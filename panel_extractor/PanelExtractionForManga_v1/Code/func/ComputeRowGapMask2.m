function [ mask,gapmask,segOver] = ComputeRowGapMask2( mask,sumRowHis,FsumRowHis,RowCluster,RowPris,idx) %sumRowHis,RowClusterS,RowPrisS,clusidxS,FsumRowHis,RowClusterF,RowPrisF,ColClusterS,ColPrisS,ColClusterF,ColPrisF )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 
% it is important to decide how and if it is needed to remove the outlier
% and segment the connected objects. 
% input mask, clusidx ColClusterS - sumColHis, FsumColHis,
% ColClusterF ----- Compute the gap mask
display = 0;
gapmask = [];
segOver = true;


    rowIdxList = RowCluster{idx};
    rowIdxPris = RowPris(idx);
    
    minidx = rowIdxList(1);
    maxidx = rowIdxList(length(rowIdxList));
    gapmask = mask(minidx:maxidx,:);
     
    if display == 1
    figure; imshow(mask); hold on;
    
    for j=1:length(rowIdxList)
        plot([0,size(mask,2)],[rowIdxList(j),rowIdxList(j)],'Color',[rowIdxPris,1,1-rowIdxPris],'LineWidth',1); hold on;
    end 
    
    for j=minidx:maxidx
        plot([0,size(mask,2)],[j,j],'Color',[0,1,0.5],'LineWidth',1); hold on;
    end
    
    title(num2str(rowIdxPris));
    end 
    
    number = length(rowIdxList);
    range  = (maxidx-minidx+1)
    solidity = number/range;
    [ dislist, disperse] = ComputeDisperse( rowIdxList );
       
        
%     coldis = [];
%     for i=1:number-1
%         coldis = [coldis, colIdxList(number+1-i)-colIdxList(number-i)];
%     end 
%     disperse = length(find(coldis>1)); % describe the disperse. 


%     noiseFlag = isRowNoise(mask,rowIdxList,number,range,solidity,disperse);
%     if noiseFlag == false
%     else
%         return;
%     end 
    
    
    if length(rowIdxList) == 1
        if length(find(gapmask==0))<0.5*length(find(gapmask==1))  
            [blackX,blackY] = find(gapmask==0);
            
            if max(blackY)-min(blackY)>0.7*size(mask,2)
                neb = 1;
                
                for k=-5:5
                    [flag,range] = IsRowBoundary( mask,rowIdxList+k,neb );
                    if flag == false
                        rowIdxList = rowIdxList-1;
                        gapmask(:,:) = 1;
                        mask(minidx:maxidx,:) = gapmask ;
                        segOver = false;
                        return;
                    end 
                end

                
            else                
                if rowIdxPris>0.3
                    gapmask(:,:) = 1;
                    mask(minidx:maxidx,:) = gapmask ;
                    segOver = false;
                    return;
                else % do nothing -- not segmented            
                end
            end 
        end
    end 
    
    if length(rowIdxList) >=2

%         rowdis = [];
%         for i=1:number-1
%             rowdis = [rowdis, rowIdxList(number+1-i)-rowIdxList(number-i)];
%         end 
%         disperse = length(find(rowdis>1)); % describe the disperse. 
        
        
        % new methods to deal two close line box.....................M1
        
        if disperse >=2
            rowflags = ones(1,length(rowIdxList));
            rangelist = zeros(1,length(rowIdxList));
            for k = 1:length(rowIdxList)
                idx = rowIdxList(k);
                tempgapmask = mask(idx,:);
                [blackX,blackY] = find(tempgapmask==0);
                if length(blackY)<1
                else
                    if max(blackY)-min(blackY)>0.8*size(mask,2)
                        rowflags(k) = 0;
                    else
                    end
                    rangelist(k) = max(blackY)-min(blackY);
                end
            end
            
            if length(find(rowflags==1))<=0
                return;
            else
                rowIdxList = rowIdxList(find(rangelist==min(rangelist)));
                if length(rowIdxList)==1
                else                    
                end 
                
                minidx = min(rowIdxList);
                maxidx = max(rowIdxList);
                gapmask = mask(minidx:maxidx,:);
                gapmask(:,:) = 1;
                mask(minidx:maxidx,:)= gapmask;
                segOver = false;
                return;
            end 
            
        end
        
        
        %---------------------
        
        % find the thinest row 
        
        
        
        
        if rowIdxPris>=0.8           % high confident pris - small obstacles
            gapmask(:,:) = 1;
            mask(minidx:maxidx,:) = gapmask ;
            segOver = false;
            return;
        end 
        
        if disperse == 0 && number<=20 % a single line 
            if rowIdxPris>=0.3 %???
                gapmask(:,:) = 1;
                mask(minidx:maxidx,:) = gapmask ;
                segOver = false;
                return;            
            end
        end 
        
        if disperse==1 && range<=30 % two cluster lines 
            if rowIdxPris>=0.3
                gapmask(:,:) = 1;
                mask(minidx:maxidx,:) = gapmask ;
                segOver = false;
                return;            
            end
        end 
              
        % oblique line gap
        
        if disperse == 0 && number >20 % oblique line or noise 
            if rowIdxPris>=0.8
                gapmask(:,:) = 1;
                mask(minidx:maxidx,:) = gapmask ;
                segOver = false;
                return;            
            else
                % ???????? --- check if it is boundary oblique line or
                % middle line 
                
                [mask, ObliqueLineFlag ] = isRowObliqueLine( mask,sumRowHis,FsumRowHis,RowCluster,RowPris,idx );
                
                if ObliqueLineFlag == true
                    segOver = false;
                    return;
                else
                    %segOver = true;
                end 
                
                if length(find(FsumRowHis(minidx:maxidx)>3))>0.1*length(FsumRowHis(minidx:maxidx)) % not oblique line 
                    
                else % oblique line 
                end 
         
                
            end 
        end 
        
%         if disperse>=2 
%             for i=1:length(dislist)
%                 % we check the pixels in between  find the one with biggierest number of white pixels and black pixel are not distribut all around 
%                 idxS = i;
%                 tempidxlist = [];
%                 while i<=length(dislist) && dislist(i)==1 % connected 
%                     tempidxlist = [tempidxlist,i];
%                     i=i+1;
%                 end 
%                 if i>length(dislist) || dislist(i)>1
%                     i=i-1;
%                     idxE = i;
%                 end 
%                                                 
%                 if length(tempidxlist)>=2 % there has connection....
%                     tempgap = mask(idxS:idxE,:);
%                                         
%                     [blackX,blackY] = find(tempgap==0);
% 
%                     if max(blackY)-min(blackY)>0.7*size(mask,2)
% 
%                     else
% 
%                     end 
%                    
%                 else 
%                     idxE = i+dislist(i);
%                     tempgap = mask(idxS:idxE,:);
%                                         
%                     [blackX,blackY] = find(tempgap==0);
% 
%                     if max(blackY)-min(blackY)>0.7*size(mask,2)
%                         startidx = 1; % slum dunk 5 -- ??8
%                         endidx = idxlist(1);
%                     else
%                         startidx = 1; % slum dunk 5 -- ??8  % if the black pixels all over 0.8 then do not remove
%                         endidx = idxlist(length(idxlist)); % slum dunk 5 -- ??8 if the black pixels all over 0.8 then do not remove
%                     end 
%                     
%                 end 
%                 
%                 if dislist(i)>=2 
%                     idxS = i;
%                     idxE = i+dislist(i);
%                     tempgap = mask(idxS:idxE,:);
%                                         
%                     [blackX,blackY] = find(tempgap==0);
% 
%                     if max(blackY)-min(blackY)>0.7*size(mask,2)
%                         startidx = 1; % slum dunk 5 -- ??8
%                         endidx = idxlist(1);
%                     else
%                         startidx = 1; % slum dunk 5 -- ??8  % if the black pixels all over 0.8 then do not remove
%                         endidx = idxlist(length(idxlist)); % slum dunk 5 -- ??8 if the black pixels all over 0.8 then do not remove
%                     end 
% 
%                     
%                     if length(find(gapmask==0))<0.5*length(find(gapmask==1))
%                         
%                     end 
%                     
%                 end 
%             end 
%         end 
        
        
        % the rest are fake gap 
        % if disperse >5
        
        
        
    end 
    
    
    
%     if rowIdxPris>0.8
%         gapmask(:,:) = 1;
%         mask(minidx:maxidx,:) = gapmask ;
%     else % need to check the white area carefully        
%         if rowIdxPris>=0.3 % 
%             
%             if length(RowClusterS)<=2
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
