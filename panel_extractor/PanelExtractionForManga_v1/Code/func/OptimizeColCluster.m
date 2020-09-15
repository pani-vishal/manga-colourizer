function [ ColCluster ] = OptimizeColCluster( mask, ColCluster )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
for i=1:length(ColCluster)
    colIdxList = ColCluster{i};
    
    flags = ones(1,length(colIdxList));
    
    for j=1:length(colIdxList)
        gapmask = mask(:,colIdxList(j));
        [blackX,blackY] = find(gapmask==0); % find black pixel
        [ dislist, disperse] = ComputeDisperse( blackX );
        
        if max(blackX)-min(blackX)>0.7*size(mask,1)
            %flags(j) = 0;
            if length(blackX)>=6 
                if length(find(dislist==1))>=3
                    flags(j) = 0;
                end 
            end 
        else            
        end 
        
    end 
    
    tempColIdxList = [];
    for j = 1:length(flags)
        if flags(j) == 1
            tempColIdxList(length(tempColIdxList)+1) = colIdxList(j);
        end 
    end 
    
    ColCluster{i} = tempColIdxList;
    
end 

tempColCluster = {};
for i=1:length(ColCluster)
    colIdxList = ColCluster{i};
    if ~isempty(colIdxList)
        tempColCluster{length(tempColCluster)+1} = colIdxList;
    end 
end 
ColCluster = tempColCluster;

end


%-------------------------------------------

%    colIdxList = ColCluster{i};
    
%     maxidx = max(colIdxList);
%     minidx = min(colIdxList);
%     number = length(colIdxList);
%     range  = (maxidx-minidx+1)
%     solidity = number/range;
% 
% %     coldis = [];
% %     for i=1:number-1
% %         coldis = [coldis, colIdxList(number+1-i)-colIdxList(number-i)];
% %     end 
% %     disperse = length(find(coldis>1)); % describe the disperse. 
% 
%     [ dislist, disperse] = ComputeDisperse( colIdxList )
%     
%     if number == 1 % slum dunk -5 
%         gapmask = mask(:,colIdxList(1));
%         gapn = length(find(gapmask==0));        % find the number of the black pixels
% 
%         if colIdxList(1)+1<=size(mask,2);
%             gapright = mask(:,colIdxList(1)+1); % find blcak pixel to see if there is a boundary 
%             gapRn = length(find(gapright==0)); 
%         else
%             gapRn = 0;
%             continue;
%         end 
%         if colIdxList(1)-1>=1
%             gapleft = mask(:,colIdxList(1)-1);  
%             gapLn = length(find(gapleft==0));   % find blcak pixel to see if there is a boundary 
%         else
%             gapLn = 0;
%             continue; 
%         end 
%         
%         gapR = gapRn-gapn;
%         gapL = gapLn-gapn;
%         
%         if gapR>gapL
%             if gapR>150 % left is the boundary
%                 colIdxList = [colIdxList(1),colIdxList(1)+1]
%                 ColCluster{i}= colIdxList;
%                 continue;                
%             else
%                 ColCluster{i} = [];
%             end 
%         else
%             if gapL>150
%                 colIdxList = [colIdxList(1),colIdxList(1)-1]
%                 ColCluster{i}= colIdxList;
%                 continue;
%             else
%                 ColCluster{i} = [];
%             end 
%         end 
%         
%     end 
%     
%     if disperse==1
%         
%         gapidx = find(dislist>1);
%         gapE = colIdxList(gapidx+1);
%         gapS = colIdxList(gapidx); % check if the middle pixels
%         
%         gapEn = length(find(mask(:,gapE)==0)); % the number of black pixels
%         gapSn = length(find(mask(:,gapS)==0)); % the number of black pixels
%             
%         if (gapE-gapS)<5   % slumduck 5-- single black line
%             maxgapnk = 0;
%             for k = gapS+1:gapE-1
%                 gapnk = length(find(mask(:,k)==0));
%                 if gapnk>maxgapnk
%                     maxgapnk = gapnk;
%                 end 
%             end 
%             if maxgapnk-gapEn>150
%                 if gapEn>gapSn
%                     colIdxList = colIdxList(gapidx+1:length(colIdxList)); 
%                     ColCluster{i} = colIdxList;
%                     continue;
%                 else
%                     colIdxList = colIdxList(1:gapidx);
%                     ColCluster{i} = colIdxList;
%                     continue;
%                 end 
%             else
%                 % do not modify 
%                 continue;
%             end 
%         else  % the maximum gapdis would be 30 -------------------------
%             % do not modify
%             continue;
%         end 
%         
%     end
%     
%     if disperse > 2 % 
%         
%     end    

%-------------------------------------------




