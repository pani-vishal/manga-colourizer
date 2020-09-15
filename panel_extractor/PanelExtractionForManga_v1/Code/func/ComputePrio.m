function [ ColPrisF,RowPrisF,ColPrisS,RowPrisS ] = ComputePrio( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,mask,idxI,idxP )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

    display = 0;
    
    %compute the priority of these clusters ------
    %ColCluster,RowCluster,ColCluster2,RowCluster2
    ColPrisF = []
    for i=1:length(ColClusterF)
        colidxlist = ColClusterF{i};
        ColPrisF(i) = sum(FsumColHis(colidxlist))/(size(mask,1)*length(colidxlist));
    end 
    
    RowPrisF = []
    for i=1:length(RowClusterF)
        rowidxlist = RowClusterF{i};
        RowPrisF(i) = sum(FsumRowHis(rowidxlist))/(size(mask,2)*length(rowidxlist));
    end 
    
    ColPrisS = []
    for i=1:length(ColClusterS)
        colidxlist = ColClusterS{i};
        ColPrisS(i) = sum(sumColHis(colidxlist))/(size(mask,1)*length(colidxlist));
    end 
    
    RowPrisS = []
    for i=1:length(RowClusterS)
        rowidxlist = RowClusterS{i};
        RowPrisS(i) = sum(sumRowHis(rowidxlist))/(size(mask,2)*length(rowidxlist));
    end 
    
    
end 