function [ mask,gapmask] = DealBoundary( mask,cluster,pris,idx,ColOrRow) %sumColHis,ColClusterS,ColPrisS,clusidxS,FsumColHis,ColClusterF,ColPrisF,ColClusterS,ColPrisS,ColClusterF,ColPrisF )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

% have no deal with differnt kinds of boundary:straight line or oblique line 
% needs to remove small objects. --- at suitable time 

display = 0;
gapmask = [];

 
    idxlist = cluster{idx};
    [dislist, disperse] = ComputeDisperse(idxlist);
    
    if  length(idxlist)>10; %disperse == 0 &&
        return;
    end 
    

if ColOrRow == 0 % Col
    
    % --------------------- if the line is in the middle line of the panel  
%     if length(idxlist) == 1
%         gapmask = mask(:,idxlist);
%         [blackX,blackY] = find(gapmask==0);
%         [ dislist, disperse] = ComputeDisperse( gapmask )
%         
%         if max(blackX)-min(blackX)>0.9*size(mask,1) 
%             if length(find(dislist==1))>=5
%                 return;
%             end 
%         else
%             gapmask(:,:) = 1;
%             mask(:,idxlist) = gapmask;
%             return;
%         end 
%     end 



    if disperse>=2
        colflags = ones(1,length(idxlist));
        for k=1:length(idxlist)
            tempcolidx = idxlist(k);
            tempgapmask = mask(:,tempcolidx);
            [blackX,blackY] = find(tempgapmask==0);
            if length(blackX)<1
            else
                if max(blackX)-min(blackX)>0.7*size(mask,1)
                    colflags(k) = 0;
                else
                end
            end    
        end  
    
        idxlistT = idxlist(find(colflags==1));

        if length(idxlistT)<=0
%             if idx == 1
%                 idxlist = min(idxlist);
%             else
%                 idxlist = max(idxlist);
%             end 
              return;
        else
            idxlist = idxlistT;
        end           
        [dislist, disperse] = ComputeDisperse(idxlist);       
    end 


    
         
    if idx == 1  % start 
%         if length(idxlist)<2
%             endidx = idxlist(1);
%             if endidx-1>1
%                 startidx = endidx-1;
%             else
%                 startidx = endidx;
%             end 
%         else
%             startidx = min(idxlist);
%             endidx   = max(idxlist);
%         end 
        

         %------------------------------------------ 

%         if max(dislist)<10 % slum dunk 5 naruto 17
%             endidx = idxlist(1);
%             startidx = 1;% slum dunk 5 -- ??8
%         else
            endidx = idxlist(length(idxlist));
            startidx = 1;
            
           if endidx - startidx < 10
               return;
           end 
            
            newendidx = startidx;
            gapmask = mask(:,startidx:endidx);
            
            for k=startidx:endidx               
                 idxP = k;               
                 neb = 2;
                 
                 [ flag,range ] = IsColBoundary( mask,idxP,neb );
                 
                 if flag == false
                     newendidx = idxP;
                     continue;
                 else
                     break;
                 end 
                
%                  tempgapmask = mask(:,k);
%                  [blackX,blackY] = find(tempgapmask==0);
%                  if length(blackX)<1
%                       newendidx = k;
%                       continue;
%                  else
%                      if max(blackX)-min(blackX)<0.7*size(mask,1)
%                          newendidx = k;
%                          continue;                         
%                      else
%                          break
%                      end 
%                  end 
            end 
             
%             [blackX,blackY] = find(gapmask==0);            
%             if max(blackX)-min(blackX)>0.9*size(mask,1)                 
%                 endidx = idxlist(1);
%                 startidx = 1;% slum dunk 5 -- ??8
%             else
%                 endidx = idxlist(length(idxlist));
%                 startidx = 1;
%             end 
        %end 
        gapmask = ones(size(mask,1),newendidx-startidx+1); 
        mask(:,startidx:newendidx) = gapmask ;
        return;
    else % end 
%         if length(idxlist)<2
%             startidx = idxlist(length(idxlist));
%             if startidx+1<length(size(mask,2))
%                 endidx = startidx+1;
%             else
%                 endidx= startidx;
%             end 
%         else
%             startidx = min(idxlist);
%             endidx   = max(idxlist);
%         end 


        %---------------------------------------
%         if max(dislist)<10
%             startidx = idxlist(length(idxlist));
%             endidx = size(mask,2); % slum dunk 5 -- ??8
%         else
            startidx = idxlist(1);
            endidx = size(mask,2); % slum dunk 5 -- ??8
            
%             gapmask = mask(:,startidx:endidx);
%             [blackX,blackY] = find(gapmask==0);
%             
%             if max(blackX)-min(blackX)>0.9*size(mask,1)
%                 startidx = idxlist(length(idxlist));
%                 endidx = size(mask,2); % slum dunk 5 -- ??8
%             else
%                 startidx = idxlist(1);
%                 endidx = size(mask,2); % slum dunk 5 -- ??8
%             end 


           if endidx - startidx < 10
               return;
           end 


            newstartidx = endidx;
            for k=(-1)*endidx:(-1)*startidx
                 idxP = k*(-1);
                 neb = 2;
                 
                 [ flag,range ] = IsColBoundary( mask,idxP,neb );
                 
                 if flag == false
                     newstartidx = idxP;
                     continue;
                 else
                     break;
                 end 
                 
%                  tempgapmask = mask(:,idxP);
%                  [blackX,blackY] = find(tempgapmask==0);
%                  if length(blackX)<1
%                       newstartidx = idxP;
%                       continue;
%                  else
%                      if max(blackX)-min(blackX)<0.7*size(mask,1)
%                          newstartidx = idxP;
%                          continue;                         
%                      else
%                          break;
%                      end 
%                  end 
            end 

            
%         end 
        gapmask = ones(size(mask,1),endidx-newstartidx+1);       
        mask(:,newstartidx:endidx) = gapmask ;
        return;
    end 
else % Row
    
   % --------------------- if the line is in the middle line of the panel  
%    if length(idxlist) == 1
%         gapmask = mask(idxlist,:);
%         [blackX,blackY] = find(gapmask==0);
%         [dislist, disperse] = ComputeDisperse( gapmask );
%         
%         if max(blackY)-min(blackY)>0.9*size(mask,2)
%             if length(find(dislist==1))>=5
%                return;
%             end 
%         else
%             gapmask(:,:) = 1;
%             mask(idxlist,:)=gapmask;
%             return;
%         end 
%     end 


    if disperse >=2
        rowflags = ones(1,length(idxlist));
        for k=1:length(idxlist)
            temprowidx = idxlist(k);
            tempgapmask = mask(temprowidx,:);
            [blackX,blackY] = find(tempgapmask==0);
            if length(blackY)<1
            else
                if max(blackY)-min(blackY)>0.7*size(mask,2)
                    rowflags(k) = 0;
                else
                end
            end    
        end 

        idxlistT = idxlist(find(rowflags==1));

        if length(idxlistT)<=0
%             if idx == 1
%                 idxlist = min(idxlist);
%             else
%                 idxlist = max(idxlist);
%             end 
              return;
        else
            idxlist = idxlistT;
        end           
        [dislist, disperse] = ComputeDisperse(idxlist);     
    end 
    
    %-------------------------------------
    
        
    if idx == 1  % start 
%         if length(idxlist)<2   % ??---- slum dunk 5------ 3!!
%             endidx = idxlist(1);
%             if endidx-1>1
%                 startidx = endidx-1;
%             else
%                 startidx = endidx;
%             end 
%         else
%             startidx = min(idxlist);
%             endidx   = max(idxlist);
%         end 

%         if max(dislist)<10 %5  --- naruto 17 ---
%             startidx = 1; % slum dunk 5 -- ??8
%             endidx = idxlist(1);
%         else

            startidx = 1; % slum dunk 5 -- ??8  % if the black pixels all over 0.7 then do not remove
            endidx = idxlist(length(idxlist));
            
           if endidx - startidx < 10
               return;
           end 
            
            newendidx = startidx;
            gapmask = mask(startidx:endidx,:);
            for k=startidx:endidx
                
                 idxP = k;               
                 neb = 2;
                 
                 [ flag,range ] = IsRowBoundary( mask,idxP,neb );
                 
                 if flag == false
                     newendidx = idxP;
                     continue;
                 else
                     break;
                 end 
                
%                  tempgapmask = mask(k,:);
%                  [blackX,blackY] = find(tempgapmask==0);
%                  if length(blackY)<1
%                       newendidx = k;
%                       continue;
%                  else
%                      if max(blackY)-min(blackY)<0.7*size(mask,2)
%                          newendidx = k;
%                          continue;                         
%                      else
%                          break
%                      end 
%                  end 
            end 

            
           
%             gapmask = mask(startidx:endidx,:);
%             [blackX,blackY] = find(gapmask==0);
%             
%             if max(blackY)-min(blackY)>0.9*size(mask,2)
%                 startidx = 1; % slum dunk 5 -- ??8
%                 endidx = idxlist(1);
%             else
%                 startidx = 1; % slum dunk 5 -- ??8  % if the black pixels all over 0.7 then do not remove
%                 endidx = idxlist(length(idxlist)); % slum dunk 5 -- ??8 if the black pixels all over 0.7 then do not remove
%             end 
            
%         end 
        gapmask = ones(newendidx-startidx+1,size(mask,2));  
        mask(startidx:newendidx,:) = gapmask ;
        return;
    else % end 
%         if length(idxlist)<2
%             startidx = idxlist(length(idxlist));
%             if startidx+1<length(size(mask,1))
%                 endidx = startidx+1;
%             else
%                 endidx= startidx;
%             end 
%         else
%             startidx = min(idxlist);
%             endidx   = max(idxlist);
%         end 

        %--------------------------------

%         if max(dislist)<10 %5
%             startidx = idxlist(length(idxlist));
%             endidx = size(mask,1); % slum dunk 5 -- ??8
%         else
            startidx = idxlist(1);
            endidx = size(mask,1); % slum dunk 5 -- ??8 if the black pixels all over 0.7 then do not remove
            
            
           if endidx - startidx < 10
               return;
           end 
            
            newstartidx = endidx;
            for k=(-1)*endidx:(-1)*startidx
                 
                 idxP = k*(-1);
                 neb = 2;
                 
                 [ flag,range ] = IsRowBoundary( mask,idxP,neb );
                 
                 if flag == false
                     newstartidx = idxP;
                     continue;
                 else
                     break;
                 end 
%                  tempgapmask = mask(idx,:);
%                  [blackX,blackY] = find(tempgapmask==0);
%                  if length(blackY)<1
%                       newstartidx = idx;
%                       continue;
%                  else
%                      if max(blackY)-min(blackY)<0.7*size(mask,2)
%                          newstartidx = idx;
%                          continue;                         
%                      else
%                          break
%                      end 
%                  end 
            end 
            
            
%             gapmask = mask(startidx:endidx,:);
%             [blackX,blackY] = find(gapmask==0);
%             
%             if max(blackY)-min(blackY)>0.9*size(mask,2)
%                 startidx = idxlist(length(idxlist));
%                 endidx = size(mask,1); % slum dunk 5 -- ??8
%             else
%                 startidx = idxlist(1);
%                 endidx = size(mask,1); % slum dunk 5 -- ??8 if the black pixels all over 0.7 then do not remove
%             end 
            
            
%         end 
        gapmask = ones(endidx-newstartidx+1,size(mask,2));  
        mask(newstartidx:endidx,:) = gapmask ;
        return;
    end 
    
end 

end 
 