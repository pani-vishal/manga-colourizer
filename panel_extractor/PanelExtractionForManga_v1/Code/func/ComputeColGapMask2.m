function [ mask,gapmask,segOver] = ComputeColGapMask2( mask,sumColHis,FsumColHis,ColCluster,ColPris,idx) %sumColHis,ColClusterS,ColPrisS,clusidxS,FsumColHis,ColClusterF,ColPrisF,ColClusterS,ColPrisS,ColClusterF,ColPrisF )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 
% it is important to decide how and if it is needed to remove the outlier
% and segment the connected objects. 
% input mask, clusidx ColClusterS - sumColHis, FsumColHis,
% ColClusterF ----- Compute the gap mask
display = 0;
gapmask = [];
segOver = true;


    colIdxList = ColCluster{idx};
    colIdxPris = ColPris(idx);
    
    minidx = colIdxList(1);
    maxidx = colIdxList(length(colIdxList));
    gapmask = mask(:,minidx:maxidx);
     
    if display ==1
    figure; imshow(mask); hold on;
    
    for j=1:length(colIdxList)
        plot([colIdxList(j),colIdxList(j)],[0,size(mask,1)],'Color',[colIdxPris,1,1-colIdxPris],'LineWidth',1); hold on;
    end 
    
    for j=minidx:maxidx
        plot([j,j],[0,size(mask,1)],'Color',[0,1,0.5],'LineWidth',1); hold on;
    end
    title(num2str(colIdxPris));
    end 
    
    % description for the colIdxList
    number = length(colIdxList);
    range  = (maxidx-minidx+1)
    solidity = number/range;
    [dislist, disperse] = ComputeDisperse(colIdxList);

%     coldis = [];
%     for i=1:number-1
%         coldis = [coldis, colIdxList(number+1-i)-colIdxList(number-i)];
%     end 
%     disperse = length(find(coldis>1)); % describe the disperse. 
    
    
    
%     noiseFlag = isColNoise(mask,colIdxList,number,range,solidity,disperse);
%     if noiseFlag == false
%     else
%         return;
%     end 
    
    
    if length(colIdxList) == 1
         if length(find(gapmask==0))<0.5*length(find(gapmask==1)) 
             
            [blackX,blackY] = find(gapmask==0);        % black points's distribution   
            if max(blackX)-min(blackX)>0.7*size(mask,1)
            else
                if colIdxPris>0.3
                    gapmask(:,:) = 1;
                    mask(:,minidx:maxidx) = gapmask ;
                    segOver = false;
                    return;
                else % do nothing -- not segmented            
                end 
            end 

         end 

    end 
    
    if length(colIdxList) >=2
        
        % new methods to deal two close line box.....................M1
        if disperse >=2
            colflags = ones(1,length(colIdxList));
            rangelist = zeros(1,length(colIdxList));
            for k = 1:length(colIdxList)
                idx = colIdxList(k);
                tempgapmask = mask(:,idx);
                [blackX,blackY] = find(tempgapmask==0);
                if length(blackX)<1
                else
                    if max(blackX)-min(blackX)>0.8*size(mask,2)
                        colflags(k) = 0;                       
                    else
                    end
                    rangelist(k) = max(blackX)-min(blackX);
                end
            end
            
            
            if length(find(colflags==1))<=0
                return;
            else
                colIdxList = colIdxList(find(rangelist==min(rangelist)));
                if length(colIdxList)==1
                else                    
                end 
                
                minidx = min(colIdxList);
                maxidx = max(colIdxList);
                gapmask = mask(:,minidx:maxidx);
                gapmask(:,:) = 1;
                mask(:,minidx:maxidx)= gapmask;
                segOver = false;
                return;
                
            end 
        end
        
        
        
        % find the thinest row ---------------------        
        
        
        
        % high confident gap 
        
        if colIdxPris>=0.8           % high confident pris - small obstacles
            gapmask(:,:) = 1;
            mask(:,minidx:maxidx) = gapmask ;
            segOver = false;
            return;
        end 
        
        if disperse == 0 && number<=20 % a single line 
            if colIdxPris>=0.3
                gapmask(:,:) = 1;
                mask(:,minidx:maxidx) = gapmask ;
                segOver = false;
                return;            
            end
        end 
        
        if disperse==1 && range<=30 % two cluster lines 
            if colIdxPris>=0.3
                gapmask(:,:) = 1;
                mask(:,minidx:maxidx) = gapmask ;
                segOver = false;
                return;            
            end
        end 
              
        % oblique line gap
        
        if disperse == 0 && number >20
            if colIdxPris>=0.8
                gapmask(:,:) = 1;
                mask(:,minidx:maxidx) = gapmask ;
                segOver = false;
                return;            
            else
                %FsumColHis(minidx:maxidx)
                
                [ mask,ObliqueLineFlag ] = isColObliqueLine( mask,sumColHis,FsumColHis,ColCluster,ColPris,idx );
                
                if ObliqueLineFlag == true
                    segOver = false;
                    return;
                else
                    %segOver = true;
                end 
                
                if length(find(FsumColHis(minidx:maxidx)>3))>0.1*length(FsumColHis(minidx:maxidx)) % not oblique line 
                    
                else % oblique line 
                end 

                                
            end 
        end 
        
        
        % the rest are fake gap 
        % if disperse >5
        
        
        
    end 
    
    
    
%     if colIdxPris>0.8
%         gapmask(:,:) = 1;
%         mask(minidx:maxidx,:) = gapmask ;
%     else % need to check the white area carefully        
%         if colIdxPris>=0.3 % 
%             
%             if length(ColClusterS)<=2
%                 gapmask(:,:) = 1;
%                 mask(minidx:maxidx,:) = gapmask ;
%             end 
%             
%             [LLX,NUMX] = bwlabel(gapmask); % white areas - 
%             stats = regionprops(LLX,'Orientation','EulerNumber','Area','Solidity');%'ConvexHull','BoundingBox'
%             
%             if display ==1
%                 figure; imshow(LLX); hold on;
%             end
%                         
%             if NUMX<=2
%                 flagSolid = true;  % solid == true means -| structure. 
%                 for i=1:length(stats)
%                     if stats(i,1).Solidity<0.85
%                         flagSolid = false;
%                     end 
%                 end 
%                 if flagSolid == false % not solid need to be segmented. 
%                     gapmask(:,:) = 1;
%                     mask(minidx:maxidx,:) = gapmask ;
%                 end 
%             else
%                 
%                 % if there are more than two 
%                 if NUMX<=5
%                 else
%                 end 
%                 
%                 
%                 for i=1:length(stats)
%                     
%                 end 
%                 
%             end 
%             
%             
%             
%         else %Confi<0.3
%             
%         end 
% 
%                
%     end %if Confi>0.8
    

end
