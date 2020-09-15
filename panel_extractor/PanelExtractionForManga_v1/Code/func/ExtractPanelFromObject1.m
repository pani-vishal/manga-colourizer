function [ mask, panels ] = ExtractPanelFromObject1( mask,idxI,idxP,panels,Bx1,By1,Seg) % input white dominant boundary 

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 
    if nargin < 1      
        close all;
        clear all;
        %I = imread('slum_dunk_239\2.jpg');
        %I = imread('naruto_514\1.jpg');
        I = imread('naruto_514\3.jpg');
        maskx = load('maskXx.mat');
        mask = maskx.maskXx;
        idxI = 3;
        idxP = 2;
        panels = {};
        Seg = false;
    end 
    
    
    display = 0;
      
    if display ==1
    figure; imshow(mask);
    end 
    
    
    % if the segmentation is satisfied, then we compute its panels ---
    % Seg==true 
    if Seg==true  % one object 
         %figure; imshow(mask);
         maskx = (mask-1)*(-1);
         [ LLX, NUMX ] = bwlabel(maskx);
         stats = regionprops(LLX,'Orientation','EulerNumber','Area','ConvexHull','ConvexArea','BoundingBox');

         [ X,Y ] = BiggestAreaInConvexHull4( stats(1,1).ConvexHull ); 

         panelidx = length(panels)+1;
         panels{panelidx}.X = X+Bx1;
         panels{panelidx}.Y = Y+By1;
    else
        %[panels] = DetectThePanelType( mask,idxI,idxP,panels);%sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColCluster,RowCluster,ColHisPro,RowHisPro,

       %-------------------------------------------------------------------------
%         [sumColHis,sumRowHis] = Col_Row_Line( mask );
%         [FsumColHis,FsumRowHis,ColHisPro,RowHisPro] = filter_Col_Row_Line( sumColHis,sumRowHis,mask );
%         [ColCluster,RowCluster] = clusterCol_Row_Line( FsumColHis,FsumRowHis,mask );
% 
%         % ---- display statistic data ----------------------------------------
%         display_Statistic_Data(sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColCluster,RowCluster,mask,idxI,idxP);
% 
%         ColMax = max(ColHisPro/size(mask,2));
%         RowMax = max(RowHisPro/size(mask,1));
        
        % decide the condition that satisfy segmetation 
        [ segOver, mask] = IsSegOver(mask,idxI,idxP); % if segOver == true means there is only one object do not need to segment
        %figure; imshow(mask);
        
        if segOver == true % split them into different parts 
            Seg = true; % - if there is no segmentation during the isSegOver pharse then we directly compute its boundingbox....
            % about the position, we need to recursion -- careful about the
            % BoudingBox and mask
            [ mask, panels ] = ExtractPanelFromObject1( mask,idxI,idxP,panels,Bx1,By1,Seg);   % Seg == true ---> generate panel shape         
        else
            % do segmentation and execute ExtractPanelFromObject1 again
            Seg = false;
            % segment to get new mask and new boundingbox             
            %[ mask, panels ] = ExtractPanelFromObject1( mask,idxI,idxP,panels,BoundingBox,Seg);
            
            [ mask ] = RemoveSmallObjects( mask );
            
            
            %-------------------------------
            mask = (mask-1)*(-1); % ----  reverse the matrix elements 0 and 1
            %-------------------------------

            [LLX,NUMX] = bwlabel(mask);
            stats = regionprops(LLX,'Image','Orientation','EulerNumber','Area','ConvexHull','BoundingBox','Eccentricity','FilledImage');

            if display ==1
            figure; imshow(LLX); hold on;
            end 
            flags = zeros(0,NUMX);
            for i=1:NUMX
                for j=1:NUMX
                    if display==1
                    plot(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2)); hold on;
                    end
                    if i~=j
                        in = inpolygon(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2),stats(j,1).ConvexHull(:,1),stats(j,1).ConvexHull(:,2));
                        idx = find(in==1);

                        if length(idx)>0.5*length(in) % remove the overlapped region
                            flags(i) = 1;
                        else
                            flags(i) = 0;
                        end 
                    end 
                end        
            end 
            
            if NUMX == 1
                flags(1) = 0;
            end 


            panelMask = zeros(size(mask,1),size(mask,2));

            for i=1:NUMX
                idx = i;
                maskx = LLX;
                removeidx = find(LLX~=idx);
                if ~isempty(removeidx)
                    maskx(removeidx) = 1;
                end        
                maskx(find(LLX==idx)) = 0;

                if display==1
                figure; imshow(maskx);
                end 

                if flags(i)==1
                    continue;
                end 

                x1 =  ceil(stats(i,1).BoundingBox(1)); % ceil floor
                x2 = floor(stats(i,1).BoundingBox(1)+stats(i,1).BoundingBox(3));


                y1 = ceil(stats(i,1).BoundingBox(2));
                y2 = floor(stats(i,1).BoundingBox(2)+stats(i,1).BoundingBox(4));

                if x1<1
                    x1 = 1;
                end 
                if y1<1
                    y1 = 1;
                end 
                if x2>size(maskx,2)
                    x2 = size(maskx,2);
                end 
                if y2>size(maskx,1)
                    y2 = size(maskx,1);
                end 

                maskXx = maskx(y1:y2,x1:x2);
                %save maskXx maskXx;


                Seg = false;
                %figure; imshow(maskXx);
                [ maskXx, panels ] = ExtractPanelFromObject1( maskXx, idxI,i,panels,Bx1+x1,By1+y1,Seg);              

                maskx(y1:y2,x1:x2) = maskXx;
                maskx = (maskx-1)*(-1); %???

                panelMask = panelMask + maskx;     

            end
            
            mask = panelMask; % danger ----- panelMask may equal to the black panel
            
        end 
        

        
    end 


%     if abs(size(maskx,1)*size(maskx,2)-stats(1,1).Area)<2*(size(maskx,1)+size(maskx,2)) % BoundingBox is the Panel shape.
% 
%          typeIdx = 1; 
%          figure; imshow(maskx);
%          title(num2str(typeIdx));
%          panels{length(panels)+1} = stats(1,1).ConvexHull;
% 
%     else if abs(stats(1,1).ConvexArea - stats(1,1).Area)<2*(size(maskx,1)+size(maskx,2)) % the convexhull is the panel shape
%          typeIdx = 2;
%          figure; imshow(mask);
%          title(num2str(typeIdx));
%          panels{length(panels)+1} = stats(1,1).ConvexHull;
% 
%     %else if  % 
%     end 
    
    
    
    
    
    %---------------------old algorithm ----------the gap---------------------
    
%     idxgap = 0;
%     
%     computeX = 0
%     if computeX ==1
%         
%     %if length(ColCluster)>2
%         %for i=2:length(ColCluster)-1
%         for i=1:length(ColCluster)
%             idxlist = ColCluster{i};
%             idxstart = min(idxlist);
%             idxend   = max(idxlist);
%             
%             if idxend-idxstart>=3
%                 idxend = idxend-1;
%                 idxstart = idxstart+1;
%             end 
%             
%             if idxend-idxstart<3
%                 idxend = idxend-1;
%                 idxstart = idxstart+1;
%             end 
%             
%             gapmask = mask(:,idxstart:idxend);
%             
%             if display ==1
%             figure; imshow(gapmask);
%             end 
%             
%             if length(find(gapmask==0))/(idxend-idxstart+1)<300
%                 idxmid = (idxstart+idxend)/2;
%                 if FsumColHis(idxstart)*FsumColHis(idxend)< 0
%                     gapmask = mask(:,idxmid-2:idxmid+2);   % some problems may caused by unreasonable subidx --- modify it sometime !!!!
%                     gapmask(find(gapmask==0))=1;
%                     mask(:,idxmid-2:idxmid+2)=gapmask;
%                     idxgap = idxmid;
%                 else 
%                     if FsumColHis(idxstart)>0
%                         gapmask = mask(:,idxstart-1);
%                         gapmask(find(gapmask==0))=1;
%                         mask(:,idxstart-1)=gapmask;
%                         idxgap = idxstart-1;
%                     else
%                         gapmask = mask(:,idxend+1);  
%                         gapmask(find(gapmask==0))=1;
%                         mask(:,idxend+1)=gapmask;
%                         idxgap = idxend+1;
%                     end 
%                     
%                 end 
% 
%                 
%                 if display ==1
%                 figure; imshow(mask); hold on; 
%                 plot([idxgap,idxgap],[0,size(mask,1)]);
%                 end
%             else
%                 if display ==1
%                 figure; imshow(mask); hold on;
%                 end
%             end 
%         end 
%     %end 
%     
%     %if length(RowCluster)>2
%         %for i=2:length(RowCluster)-1
%         for i=1:length(RowCluster)    
%             idxlist = RowCluster{i};
%             idxstart = min(idxlist);
%             idxend   = max(idxlist);
%             
%             if idxend-idxstart>=3
%                 idxend = idxend-1;
%                 idxstart = idxstart+1;
%             end 
%             
%             gapmask = mask(idxstart:idxend,:);
%             
%             if display ==1
%             figure; imshow(gapmask);
%             end 
%             
%             if length(find(gapmask==0))/(idxend-idxstart+1)<500                
%                 idxmid = (idxstart+idxend)/2;
%                 if FsumRowHis(idxstart)*FsumRowHis(idxend)< 0 
%                     gapmask = mask(idxmid-2:idxmid+2,:); % some problems may caused by unreasonable subidx --- modify it sometime !!!!
%                     gapmask(find(gapmask==0))=1;
%                     mask(idxmid-2:idxmid+2,:)=gapmask;
%                     idxgap = idxmid;
%                 else 
%                     if FsumRowHis(idxstart)>0
%                         gapmask = mask(idxstart-1,:);
%                         gapmask(find(gapmask==0))=1;
%                         mask(idxstart-1,:)=gapmask;
%                         idxgap = idxstart-1;
%                     else
%                         gapmask = mask(idxend+1,:);
%                         gapmask(find(gapmask==0))=1;
%                         mask(idxend+1,:)=gapmask;
%                         idxgap = idxend+1;
%                     end 
%                 end 
%                
%                 if display ==1
%                 figure; imshow(mask); hold on;
%                 plot([0,size(mask,1)],[idxgap,idxgap]);
%                 end 
%             else
%                 if display ==1
%                 figure; imshow(mask); hold on;
%                 end 
%             end 
%         end 
%     %end
%     end 
%     
%     mask = (mask-1)*(-1);


end

