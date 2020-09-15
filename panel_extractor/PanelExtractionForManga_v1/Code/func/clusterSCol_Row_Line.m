function [ColClusterS,RowClusterS] = clusterSCol_Row_Line( sumColHis,sumRowHis,mask,ColThres,RowThres,ColnearThres,RownearThres )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

%     ColThres = 0.3*size(mask,1); %50;% need to be modified ------ a smart method to choose the threshold
%     RowThres = 0.3*size(mask,2); 
%     
%     %detectThresX = 50;
%     ColnearThres = 0.1*size(mask,1); %maximal distance between two cluster ---------------------------------
%     RownearThres = 0.1*size(mask,2);
%     
%     ColnearThres = 50;
%     RownearThres = 50;
    
    ColClusterS = [];
    RowClusterS = [];

    %FsumColHis(abs(FsumColHis)<detectThresX) = 0;
           
    ColList = find(abs(sumColHis)>ColThres);
    
    if length(ColList)>0
    cluster = {};
    idx = 1;
    clsn = 1;
    idxlist = [ColList(idx)];
    while idx+1 <= length(ColList)
        idx=idx+1;
        if abs(ColList(idx)-ColList(idx-1))>ColnearThres%300% % 
            cluster{clsn} = idxlist;            
            clsn = clsn+1;
            idxlist = [ColList(idx)];
        else
            idxlist = [idxlist,ColList(idx)];
        end 
    end
    cluster{clsn} = idxlist;
    ColClusterS = cluster;
    end 
    
    %FsumRowHis(abs(FsumRowHis)<detectThresX) = 0;    
    RowList = find(abs(sumRowHis)>RowThres);
    
    if length(RowList)>0
        cluster = {};
        idx = 1;
        clsn = 1;
        idxlist = [RowList(idx)]; %%!!! --- slum dunk 8?9
        while idx+1 <= length(RowList)
            idx=idx+1;
            if abs(RowList(idx)-RowList(idx-1))>RownearThres%200%
                cluster{clsn} = idxlist;            
                clsn = clsn+1;
                idxlist = [RowList(idx)];
            else
                idxlist = [idxlist,RowList(idx)];
            end 
        end
        cluster{clsn} = idxlist;
        RowClusterS = cluster;
    end 
    
end