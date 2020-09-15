function [ RowCluster ] = OptimizeRowCluster( mask, RowCluster )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
for i=1:length(RowCluster)
    RowIdxList = RowCluster{i};
    
    flags = ones(1,length(RowIdxList));
    
    for j=1:length(RowIdxList)
        gapmask = mask(RowIdxList(j),:);
        [blackX,blackY] = find(gapmask==0); % find black pixel
        [ dislist, disperse] = ComputeDisperse( blackY );

        if max(blackY)-min(blackY)>0.7*size(mask,2)
            %flags(j) = 0;
            if length(blackY)>=6 
                if length(find(dislist==1))>=3
                    flags(j) = 0;
                end 
            end 
        else            
        end 
    end 
    
    tempRowIdxList = [];
    for j = 1:length(flags)
        if flags(j) == 1
            tempRowIdxList(length(tempRowIdxList)+1) = RowIdxList(j);
        end 
    end 
    
    RowCluster{i} = tempRowIdxList;
    
end 

tempRowCluster = {};
for i=1:length(RowCluster)
    RowIdxList = RowCluster{i};
    if ~isempty(RowIdxList)
        tempRowCluster{length(tempRowCluster)+1} = RowIdxList;
    end 
end 
RowCluster = tempRowCluster;

end








