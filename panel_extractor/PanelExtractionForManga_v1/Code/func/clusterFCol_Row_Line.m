function [ColClusterF,RowClusterF] = clusterFCol_Row_Line( FsumColHis,FsumRowHis,mask,ColThres,RowThres,ColnearThres,RownearThres )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

%     ColThres = 0.1*size(mask,1); %50;% need to be modified ------ a smart method to choose the threshold
%     RowThres = 0.1*size(mask,2); 
%     
%     %detectThresX = 50;
%     %ColnearThres = 0.1*size(mask,1); %maximal distance between two cluster ---------------------------------
%     %RownearThres = 0.1*size(mask,2); % set to 0.05 why??
%     
%     ColnearThres = 30; % 0.05*size(mask,1); %maximal distance between two cluster ---------------------------------
%     RownearThres = 30; % 0.1*size(mask,2); % set to 0.05 why??
    
    ColClusterF = [];
    RowClusterF = [];

    %FsumColHis(abs(FsumColHis)<detectThresX) = 0;
           
    ColList = find(abs(FsumColHis)>ColThres);
    
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
    ColClusterF = cluster;
    end 
    
    %FsumRowHis(abs(FsumRowHis)<detectThresX) = 0;    
    RowList = find(abs(FsumRowHis)>RowThres);
    
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
        RowClusterF = cluster;
    end 
    
end

