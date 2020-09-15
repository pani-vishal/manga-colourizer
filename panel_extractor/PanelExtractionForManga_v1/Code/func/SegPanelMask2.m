function [ mask,segOver ] = SegPanelMask2( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idxI,idxP )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

    display = 0;
    
    segOver = true;
    
    % generate new ColCluster by combining ColClusterS ColClusterF /
    % RowClusterS and RowClusterF
    
    % --------------- ColCluster -----------------------------------
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
            % avoid cases like page 8 in slumduk - 8 2013.10.27 add
            % boundary for some seven shape layout
            if length(ColClusterS{i})>200 && length(idxFinS)<2 
                idxlistS = ColClusterS{i};
                idxlistF = ColClusterF{idxFinS(1)};
                
                dismax = abs(idxlistF-max(idxlistS));
                dismin = abs(idxlistF-min(idxlistS));
                
                if min(dismax)>200  % how to determine the threshold ????
                    ColCluster{length(ColCluster)+1} = max(idxlistS);
                end 
                
                if min(dismin)>200
                    ColCluster{length(ColCluster)+1} = min(idxlistS);
                end                             
            end 
            
            % ------------------------------naruto page 6
%             if length(ColClusterS{i})<200 && length(idxFinS)<2 % naruto page6
%                 idxadd = find(sumColHis == max(sumColHis(idxlistS))); % need to avoid idxadd is in idxFinS               
%                 if length(idxadd)==1
%                     ColCluster{length(ColCluster)+1} = idxadd;
%                 end 
%                 if length(idxadd)>1
%                     if max(idxadd)- min(idxadd)<5
%                         ColCluster{length(ColCluster)+1} = idxadd;
%                     else 
%                         ColCluster{length(ColCluster)+1} = max(idxadd);
%                         ColCluster{length(ColCluster)+1} = min(idxadd);
%                     end                     
%                 end               
%             end 
            
            
        end 
    end 
    
%     since we changed the filter2_Col_Row_Line from left to right and right to left  
%     for i=1:length(flagF) 
%         if flagF(i)==0
%             ColCluster{length(ColCluster)+1} = ColClusterF{i}; % F is not in S, we add it to 
%         end 
%     end 
    
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
            % avoid cases like page 8 in slumduk - 8 2013.10.27
            if length(RowClusterS{i})>200 && length(idxFinS)<2 
                idxlistS = RowClusterS{i};
                idxlistF = RowClusterF{idxFinS(1)};
                
                dismax = abs(idxlistF-max(idxlistS));
                dismin = abs(idxlistF-min(idxlistS));
                
                if min(dismax)>200
                    RowCluster{length(RowCluster)+1} = max(idxlistS);
                end 
                
                if min(dismin)>200
                    RowCluster{length(RowCluster)+1} = min(idxlistS);
                end                            
            end 
            
             % ------------------------------naruto page 6
%             if length(RowClusterS{i})<200 && length(idxFinS)<2 % naruto page6              
%                 idxadd = find(sumRowHis == max(sumRowHis(idxlistS)));               
%                 if length(idxadd)==1 % need to avoid idxadd is in idxFinS
%                     RowCluster{length(RowCluster)+1} = idxadd;
%                 end 
%                 if length(idxadd)>1
%                     if max(idxadd)- min(idxadd)<5
%                         RowCluster{length(RowCluster)+1} = idxadd;
%                     else 
%                         RowCluster{length(RowCluster)+1} = max(idxadd);
%                         RowCluster{length(RowCluster)+1} = min(idxadd);
%                     end 
%                     
%                 end               
%             end  
            
            
        end 
    end  
    
%     since we changed the filter2_Col_Row_Line from left to right and right to left S always include inF 
%     for i=1:length(flagF)
%         if flagF(i)==0
%             RowCluster{length(RowCluster)+1} = RowClusterF{i}; % F is not in S, we add it to 
%         end 
%     end 
    
     
    %------------sort according to the colidx and rowidx---------add boundary lines --- slum dumk 8 -
    % add boundary lines 
    BoundThres = 100;% 50;%20; % naturo --- page 4~6
    rowStart = [];
    for i=1:length(RowCluster)
        rowStart = [rowStart,RowCluster{i}(1)];
    end 
    rowEnd = [];
    for i=1:length(RowCluster)
        rowEnd = [rowEnd,RowCluster{i}(length(RowCluster{i}))];
    end 
    
    if min(rowStart)-1>BoundThres    % add boundary lines --- slum dumk 8 - 
        rowStart = [rowStart,1];
        RowCluster{length(RowCluster)+1} = [1];
        rowEnd = [rowEnd,1];
    end 
    if size(mask,1)-max(rowEnd)>BoundThres
        rowEnd = [rowEnd,size(mask,1)];
        RowCluster{length(RowCluster)+1} = [size(mask,1)];
        rowStart = [rowStart,size(mask,1)];
    end 
    
    [a,rowSort] = sort(rowStart);
    tempRowCluster = {};
    for i=1:length(rowSort)
        tempRowCluster{i} = RowCluster{rowSort(i)};
    end 
    RowCluster = tempRowCluster;
        
    colStart = [];
    for i=1:length(ColCluster)
        colStart = [colStart,ColCluster{i}(1)];      
    end 
    colEnd = [];
    for i=1:length(ColCluster)
        colEnd = [colEnd,ColCluster{i}(length(ColCluster{i}))];      
    end 
    
    if min(colStart)-1>BoundThres    % % add boundary lines
        colStart = [colStart,1];
        ColCluster{length(ColCluster)+1} = [1];
         colEnd = [colEnd,1];
    end 
    if size(mask,2)-max(colEnd)>BoundThres
        colEnd = [colEnd,size(mask,2)];
        ColCluster{length(ColCluster)+1} = [size(mask,2)];
        colStart = [colStart,size(mask,2)];
    end 

    
    [a,colSort] = sort(colStart);    
    tempColCluster = {};
    for i=1:length(colSort)
        tempColCluster{i} = ColCluster{colSort(i)};
    end 
    ColCluster = tempColCluster;
    
     
    %-----------------optimize gap lines---------- remove some noise 
%     for i=1:length(ColCluster)
%         colidxlist = ColCluster{i};
%         %ColPris(i) = sum(sumColHis(colidxlist))/(size(mask,1)*length(colidxlist));
%     end 

%     [ ColCluster ] = OptimizeColCluster( mask, ColCluster);  %----------
%     [ RowCluster ] = OptimizeRowCluster( mask, RowCluster);  %----------
    
    %-----------------compute pris----------------------------------
    ColPris = []
    for i=1:length(ColCluster)
        colidxlist = ColCluster{i};
        ColPris(i) = sum(sumColHis(colidxlist))/(size(mask,1)*length(colidxlist)); %;%
    end 
    %ColPris = ColPris/max(ColPris);

    RowPris = []
    for i=1:length(RowCluster)
        rowidxlist = RowCluster{i};
        RowPris(i) = sum(sumRowHis(rowidxlist))/(size(mask,2)*length(rowidxlist));%;%
    end 
    %RowPris = RowPris/max(RowPris);
       
    if display == 1
    h = figure; imshow(mask); hold on;
    end 
    for i=1:length(ColCluster)
        idxlist = ColCluster{i};
        for j=1:length(idxlist)
            if display == 1
            plot([idxlist(j),idxlist(j)],[0,size(mask,1)],'Color',[abs(ColPris(i)),1,1-abs(ColPris(i))],'LineWidth',1); hold on;
            end
        end 
    end
    for i=1:length(RowCluster)
        idxlist = RowCluster{i};
        for j=1:length(idxlist)
            if display == 1
            plot([0,size(mask,2)],[idxlist(j),idxlist(j)],'Color',[abs(RowPris(i)),1,1-abs(RowPris(i))],'LineWidth',1); hold on;
            end 
        end 
    end 
    
    %saveas(h,[num2str(idxI) '_' num2str(idxP)],'fig');
    
    
   %-------------- sort RowCluster and ColCluster ----------------- 
   [temp,colPrisSort] = sort(ColPris,'descend');
   [temp,rowPrisSort] = sort(RowPris,'descend');
   
   
   if length(RowCluster)<=2 && length(ColCluster)<=2
       for i=1:length(colPrisSort) % ColCluster - ColPris
           idx = colPrisSort(i);
           if idx == 1 || idx == length(ColCluster) 
               [ mask,gapmask] = DealBoundary( mask,ColCluster,ColPris,idx,0); %ColOrRow
               continue;
           end          
       end 
       for i=1:length(RowCluster)
           idx = rowPrisSort(i);
           if idx == 1 || idx == length(RowCluster)
               [ mask,gapmask] = DealBoundary( mask,RowCluster,RowPris,idx,1); %ColOrRow
               continue;
           end 
       end 
       segOver = true; % remove outlier on the boundary 
   end 
   
   if length(RowCluster)<=2 && length(ColCluster)>2 % according to the ColCluster
       
       for i=1:length(colPrisSort) % ColCluster - ColPris
           idx = colPrisSort(i);
           if idx == 1 || idx == length(ColCluster) 
               [ mask,gapmask] = DealBoundary( mask,ColCluster,ColPris,idx,0); %ColOrRow
               continue;
           else
               [mask,gapmask,segOver] = ComputeColGapMask2( mask,sumColHis,FsumColHis,ColCluster,ColPris,idx);
               if segOver == true;
                   continue;
               else
                   return;
               end 
           end           
       end 
       
       for i=1:length(RowCluster)
           idx = rowPrisSort(i);
           if idx == 1 || idx == length(RowCluster)
               [ mask,gapmask] = DealBoundary( mask,RowCluster,RowPris,idx,1); %ColOrRow
               continue;
           end 
       end 
       
   end 
   
   if length(RowCluster)>2 && length(ColCluster)<=2 % according to the RowCluster
       for i=1:length(RowCluster)
           idx = rowPrisSort(i);
           if idx == 1 || idx == length(RowCluster)
               [ mask,gapmask] = DealBoundary( mask,RowCluster,RowPris,idx,1); %ColOrRow
               continue;
           else
               [ mask,gapmask,segOver] = ComputeRowGapMask2( mask,sumRowHis,FsumRowHis,RowCluster,RowPris,idx);
               if segOver == true; % do not need to segment
                   continue;
               else % if segmented then it needs to be recomputed 
                   return;
               end 
           end 
       end
       
       for i=1:length(colPrisSort) % ColCluster - ColPris
           idx = colPrisSort(i);
           if idx == 1 || idx == length(ColCluster) 
               [ mask,gapmask] = DealBoundary( mask,ColCluster,ColPris,idx,0); %ColOrRow
               continue;
           end          
       end 
   end 
   
   if length(RowCluster)>2 && length(ColCluster)>2  % according to the combine priority
       colidx = 1;
       rowidx = 1;
       
       while colidx<=length(colPrisSort) && rowidx<=length(rowPrisSort)
           if ColPris(colPrisSort(colidx))> RowPris(rowPrisSort(rowidx))  % according to ColCluster %ColPris
               if colPrisSort(colidx) == 1 || colPrisSort(colidx) == length(ColCluster)
                   [ mask,gapmask] = DealBoundary( mask,ColCluster,ColPris,colPrisSort(colidx),0);  %ColOrRow
                   colidx = colidx+1;
                   continue;
               else
                   [mask,gapmask,segOver] = ComputeColGapMask2( mask,sumColHis,FsumColHis,ColCluster,ColPris,colPrisSort(colidx));
                   if segOver == true;
                       colidx = colidx+1;
                       continue;
                   else
                       %colidx = colidx+1;
                       return;
                   end
               end
           else
               if rowPrisSort(rowidx) == 1 || rowPrisSort(rowidx) == length(RowCluster)  %RowPris
                   [ mask,gapmask] = DealBoundary( mask,RowCluster,RowPris,rowPrisSort(rowidx),1); %ColOrRow
                   rowidx=rowidx+1;
                   continue;
               else
                   [ mask,gapmask,segOver] = ComputeRowGapMask2( mask,sumRowHis,FsumRowHis,RowCluster,RowPris,rowPrisSort(rowidx));
                   if segOver == true; % do not need to segment
                       rowidx=rowidx+1;
                       continue;
                   else % if segmented then it needs to be recomputed
                       %rowidx=rowidx+1;
                       return;
                   end
               end
           end
       end
       
       if colidx<=length(colPrisSort) 
           
           for i=colidx:length(colPrisSort) % ColCluster - ColPris
               idx = colPrisSort(i);
               if idx == 1 || idx == length(ColCluster) 
                   [ mask,gapmask] = DealBoundary( mask,ColCluster,ColPris,idx,0); %ColOrRow
                   continue;
               else
                   [mask,gapmask,segOver] = ComputeColGapMask2( mask,sumColHis,FsumColHis,ColCluster,ColPris,idx);
                   if segOver == true;
                       continue;
                   else
                       return;
                   end 
               end           
           end 
           
       end %
       if rowidx<=length(rowPrisSort)
           for i=rowidx:length(RowCluster)
               idx = rowPrisSort(i);
               if idx == 1 || idx == length(RowCluster)
                   [ mask,gapmask] = DealBoundary( mask,RowCluster,RowPris,idx,1); %ColOrRow
                   continue;
               else
                   [ mask,gapmask,segOver] = ComputeRowGapMask2( mask,sumRowHis,FsumRowHis,RowCluster,RowPris,idx);
                   if segOver == true; % do not need to segment
                       continue;
                   else % if segmented then it needs to be recomputed 
                       return;
                   end 
               end 
           end
       end %
       
       
   end 
   
   
    

    
    
    %mask = (mask-1)*(-1);
    if display == 1
    figure; imshow(mask);
    end 


end

