function [ ColCluster,RowCluster,ColPris,RowPris] = CombineClusterSF( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idxI,idxP )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

    display = 0;
    
    segOver = true;
    
    % generate new ColCluster by combining ColClusterS ColClusterF /
    % RowClusterS and RowClusterF
    
    % --------------- ColCluster --------------------------------
    listFinS = {};
    flagF = zeros(1,length(ColClusterF));
    for i=1:length(ColClusterS)
        idxlistS = ColClusterS{i};
        idxFinS = [];
        for j=1:length(ColClusterF)
            idxlistF = ColClusterF{j};
            for k = 1:length(idxlistF)            
                if ~isempty(find(idxlistS == idxlistF(k)))
                    idxFinS = [idxFinS,j]; 
                    flagF(j) = 1;
                    break; 
                end          
            end   
        end 
        listFinS{length(listFinS)+1} = idxFinS;
    end 
    
    ColCluster = {};
    for i=1:length(listFinS)
        if isempty(listFinS{i})
            ColCluster{length(ColCluster)+1} = ColClusterS{i};
        else
            idxFinS = listFinS{i};
            for j=1:length(idxFinS)
                ColCluster{length(ColCluster)+1} = ColClusterF{idxFinS(j)};
            end 
        end 
    end 
    
    for i=1:length(flagF)
        if flagF(i)==0
            ColCluster{length(ColCluster)+1} = ColClusterF{i}; % F is not in S, we add it to 
        end 
    end 
    
    % ---------- RowCluster ---------
    listFinS = {};   
    flagF = zeros(1,length(RowClusterF));
    for i=1:length(RowClusterS)
        idxlistS = RowClusterS{i};
        idxFinS = [];
        for j=1:length(RowClusterF)
            idxlistF = RowClusterF{j};
            for k = 1:length(idxlistF)            
                if ~isempty(find(idxlistS == idxlistF(k)))
                    idxFinS = [idxFinS,j]; 
                    flagF(j) = 1;
                    break; 
                end          
            end   
        end 
        listFinS{length(listFinS)+1} = idxFinS;
    end 
    
    RowCluster = {};
    for i=1:length(listFinS)
        if isempty(listFinS{i})
            RowCluster{length(RowCluster)+1} = RowClusterS{i};
        else
            idxFinS = listFinS{i};
            for j=1:length(idxFinS)
                RowCluster{length(RowCluster)+1} = RowClusterF{idxFinS(j)};
            end 
        end 
    end  
    
    for i=1:length(flagF)
        if flagF(i)==0
            RowCluster{length(RowCluster)+1} = RowClusterF{i}; % F is not in S, we add it to 
        end 
    end 
    
    

    ColPris = []
    for i=1:length(ColCluster)
        colidxlist = ColCluster{i};
        ColPris(i) = sum(sumColHis(colidxlist))/(size(mask,1)*length(colidxlist));
    end 

    RowPris = []
    for i=1:length(RowCluster)
        rowidxlist = RowCluster{i};
        RowPris(i) = sum(sumRowHis(rowidxlist))/(size(mask,2)*length(rowidxlist));
    end 
       
    
    figure; imshow(mask); hold on;
    for i=1:length(ColCluster)
        idxlist = ColCluster{i};
        for j=1:length(idxlist)
            plot([idxlist(j),idxlist(j)],[0,size(mask,1)],'Color',[abs(ColPris(i)),1,1-abs(ColPris(i))],'LineWidth',1); hold on;
        end 
    end
    for i=1:length(RowCluster)
        idxlist = RowCluster{i};
        for j=1:length(idxlist)
            plot([0,size(mask,2)],[idxlist(j),idxlist(j)],'Color',[abs(RowPris(i)),1,1-abs(RowPris(i))],'LineWidth',1); hold on;
        end 
    end 
    
    
end 

