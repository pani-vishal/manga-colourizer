function [ mask,ObliqueLineFlag ] = isRowObliqueLine( mask,sumRowHis,FsumRowHis,RowCluster,RowPris,idx )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

    if nargin < 1      
        close all;
        clear all;
        %I = imread('slum_dunk_239\4.jpg'); % 5, 2 expmaple %8% 1 % 3 % 5~8 6  10 15 -- clusterCol_Row_Line--modify 30
        I = imread('naruto_514\2.jpg'); %3 4, 9% panel shape -- problems --naruto_514\3 % 3-4 17-2!!-- if there is no boundary in page, then we add dotted line not affect the connected component but will indicate the peak F
        idxI = 20;
        idxP = 0;
        load oblique;
    end 
    
    %mask = mask(:,2:size(mask,2)-1);
    
    ObliqueLineFlag = false;

    rowIdxList = RowCluster{idx};
        

    minidx = rowIdxList(1);
    maxidx = rowIdxList(length(rowIdxList));
    gapmask = mask(minidx:maxidx,:);
    
    
    
    %---------------------- % find this code in other parts of the program 
%     FRowHis = FsumRowHis(rowIdxList);
%     [FRowdislist, FRowDisperse] = ComputeDisperse( FRowHis );
%    
%     FRowDisperse = length(find(abs(FRowdislist)>=5)); % describe the disperse. naruto -- page 12
%     
%     if FRowDisperse>0.1*length(rowIdxList)  % how to distinguish the gap line and white areas in panel 
%         return;
%     end 
    
%    'MajorAxisLength' 'MinorAxisLength' 'Perimeter' needs more feature to distinguish two case  slum(4)--naturo --12


    [LLX,NUMX] = bwlabel(gapmask);
    stats = regionprops(LLX,'Image','Area','Orientation','MajorAxisLength','MinorAxisLength', 'Perimeter','Eccentricity');
       
    
    if NUMX>5
        return;
    end 
    
    if NUMX>=1
        areaW = stats(1,1).Area;
        majaxis = stats(1,1).MajorAxisLength;
        minaxis = stats(1,1).MinorAxisLength;
        perime  = stats(1,1).Perimeter;
        eccent  = stats(1,1).Eccentricity;
        orien   = stats(1,1).Orientation;
        
        for i=2:NUMX

            if stats(i,1).MajorAxisLength> majaxis 
                areaW = stats(i,1).Area;
                majaxis = stats(i,1).MajorAxisLength;
                minaxis = stats(i,1).MinorAxisLength;
                perime  = stats(i,1).Perimeter;
                eccent  = stats(i,1).Eccentricity;
                orien   = stats(1,1).Orientation;
                
            end 
            %direction = [cos(stats(i,1).Orientation),sin(stats(i,1).Orientation)];
        end 
    end 
    
    if majaxis<0.5*size(mask,2)
        return;
    end 
    
%     if minaxis>2*(length(find(gapmask))/size(mask,2))
%         return;
%     end 
    
    if eccent<0.5
        return;
    end 
    
    if abs(orien)>=45
        return;
    end 
    
    

    
    %----------------------
    
    
    
    
    range  = (maxidx-minidx+1);
    
    
    SS = sum(sumRowHis(minidx:maxidx));
    Sw = uint16(SS/size(mask,2));
    
    if range>30
        range = Sw*0.5;
    else
    end 
    
    display = 0;
    
    expminidx = 1;
    if minidx-range>1
        expminidx = minidx-range;
    end 
    
    expmaxidx = size(mask,1);
    if (maxidx+range)<size(mask,1)
        expmaxidx = maxidx+range;
    end 
    
    expandmask = mask(expminidx:expmaxidx,:);
    
    [LLX,NUMX] = bwlabel(expandmask);
    stats = regionprops(LLX,'Image','Orientation','Centroid','EulerNumber','Area','ConvexHull','BoundingBox','Eccentricity','FilledImage');

    
    if display ==1
    figure; imshow(LLX); hold on;
    end 

    
    for i=1:NUMX

        direction = [cos(stats(i,1).Orientation),sin(stats(i,1).Orientation)];
        if display==1
        plot(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2)); hold on;
        plot([stats(i,1).Centroid(1),direction(1)],[stats(i,1).Centroid(2),direction(2)]);hold on;
        end
 
    end 
    
    
    
    % give the condition that is not oblique lines ------------???? ---
    
    
    
%         idxI = 0;
%         idxP = 0;
%         [sumColHis,sumRowHis] = Col_Row_Line( gapmask );
%         [FsumColHis,FsumRowHis,ColHisPro,RowHisPro] = filter_Col_Row_Line( sumColHis,sumRowHis,gapmask );
%         [ColClusterF,RowClusterF] = clusterCol_Row_Line( FsumColHis,FsumRowHis,gapmask );
%         [F2sumColHis,F2sumRowHis] = filter2_Col_Row_Line( sumColHis,sumRowHis,gapmask );
%         [ColClusterS,RowClusterS] = cluster2Col_Row_Line( sumColHis,sumRowHis,gapmask );
%         [ColPrisF,RowPrisF,ColPrisS,RowPrisS] = ComputePrio( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,gapmask,idxI,idxP );
%         %[ColCluster,RowCluster,ColPris,RowPris] = CombineClusterSF( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idxI,idxP );
% 
%         % ---- display statistic data ----------------------------------------
%         display_Statistic_Data(sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,gapmask,idxI,idxP);
% 
%         se = strel('disk',30,8);
%         mask2 = imdilate(gapmask,se);
%         figure; imshow(mask2);
        
        Xx = [];
        Yy = [];
        for i=1:size(expandmask,2)
            whitelist = find(expandmask(:,i)==1);
            if length(whitelist)<=0
            else
                Xx = [Xx,i];
                Yy = [Yy, mean(whitelist)];
            end 
            
        end 
        
        if display ==1
        figure; imshow(expandmask); hold on;
        plot(Xx,Yy,'.','Color','r'); hold on;   
        end 
        p=polyfit(Xx,Yy,1);
        
        Xx = 1:size(expandmask,2);
        Yy = uint16(polyval(p,Xx));
         
        if display ==1
        plot(Xx,Yy,'p','Color','g'); hold on;
        poly2sym(p,'x'); hold on;
        end 
        
       
        
        Yy(find(Yy<1)) = 1;
        Yy(find(Yy>size(expandmask,1))) = size(expandmask,1);
                
        for i=1:length(Xx)
            for j=-2:2
                if Yy(i)+j<size(expandmask,1)
                    expandmask(Yy(i)+j,Xx(i)) = 1;
                    if display ==1
                    plot(Xx(i),Yy(i)+j,'O'); hold on;
                    end 
                end 
            end 
        end 
        
        mask(expminidx:expmaxidx,:) = expandmask;
        if display ==1
        figure; imshow(mask);
        end 
        ObliqueLineFlag = true;
        
        %YY=polyfit(Xx,Yy,1);
        %plot(Xx,Yy,'o','Color','r'); hold on;
        


end

