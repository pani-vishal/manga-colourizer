function [] = display_Statistic_Data(sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idx,idxp,ColThresF,RowThresF,ColnearThresF,RownearThresF,ColThresS,RowThresS,ColnearThresS,RownearThresS)

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 
    h = figure; 
    
    subplot(4,2,1);
    Colidx = [1:size(mask,2)];
    plot(Colidx,sumColHis); hold on;
%     for i=1:length(ColClusterF)
%         idxlist = ColClusterF{i}; 
%         for j=1:length(idxlist)
%             plot([idxlist(j),idxlist(j)],[0,size(mask,1)],'Color',[abs(ColPrisF(i)),1,1-abs(ColPrisF(i))]); hold on;
%         end 
%     end
    plot([0,size(mask,2)],[ColThresS,ColThresS],'Color','r','LineWidth',1);
    axis([0 size(mask,2) 0 size(mask,1)]);
    title('sum of column - sumColHis');   
    
    
    subplot(4,2,2);
    Rowidx = [1:size(mask,1)];
    plot(Rowidx,sumRowHis); hold on;
%     for i=1:length(RowClusterF)
%         idxlist = RowClusterF{i};
%         for j=1:length(idxlist)
%             plot([idxlist(j),idxlist(j)],[0,size(mask,2)],'Color',[abs(RowPrisF(i)),1,1-abs(RowPrisF(i))]); hold on;
%         end 
%     end
    plot([0,size(mask,1)],[RowThresS,RowThresS],'Color','r','LineWidth',1);
    axis([0 size(mask,1) 0 size(mask,2)]);
    title('sum of row - sumRowHis');
    
    
    subplot(4,2,3);
    Colidx = [1:length(FsumColHis)];
    plot(Colidx,FsumColHis); hold on;
%     for i=1:length(ColClusterF)
%         idxlist = ColClusterF{i};
%         for j=1:length(idxlist)
%             plot([idxlist(j),idxlist(j)],[0,size(mask,1)],'Color',[abs(ColPrisF(i)),1,1-abs(ColPrisF(i))]); hold on;
%         end 
%     end
    plot([0,size(mask,2)],[ColThresF,ColThresF],'Color','g','LineWidth',1);
%     for i=1:length(ColClusterS)
%         idxlist = ColClusterS{i};
%         for j=1:length(idxlist)
%             plot([idxlist(j),idxlist(j)],[0,size(mask,1)],'Color',[ColPrisS(i),1,1-ColPrisS(i)]); hold on;
%         end 
%     end
    axis([0 size(mask,2) 0 size(mask,1)]);
    title('sum of column - FsumColHis');
    
    
    subplot(4,2,4);
    Rowidx = [1:length(FsumRowHis)];
    plot(Rowidx,FsumRowHis); hold on;
%     for i=1:length(RowClusterF)
%         idxlist = RowClusterF{i};
%         for j=1:length(idxlist)
%             plot([idxlist(j),idxlist(j)],[0,size(mask,2)],'Color',[abs(RowPrisF(i)),1,1-abs(RowPrisF(i))]); hold on;
%         end 
%     end 
    plot([0,size(mask,1)],[ColThresF,ColThresF],'Color','g','LineWidth',1);
%     for i=1:length(RowClusterS)
%         idxlist = RowClusterS{i};
%         for j=1:length(idxlist)
%             plot([idxlist(j),idxlist(j)],[0,size(mask,2)],'Color',[RowPrisS(i),1,1-RowPrisS(i)]); hold on;
%         end 
%     end
    axis([0 size(mask,1) 0 size(mask,2)]);
    title('sum of row _ FsumRowHis');  
    
    
    subplot(4,2,5);
    %Colidx = [1:length(FsumColHis)];
    %plot(Colidx,FsumColHis); hold on;
    %axis([0 size(mask,2) 0 size(mask,1)]);
    nbins = size(mask,1)/20;
    ColHisPro = hist(sumColHis,nbins);
    ColHisPro = ColHisPro/length(sumColHis);
    Colidx = [1:length(ColHisPro)];
    %plot(Colidx,ColHisPro); hold on;
    hist(sumColHis,nbins);
%     binrange = [10,20,50,100];
%     binCntCol = histc(sumColHis,binrange);
    title('sum of column - FsumColHis');


    
    subplot(4,2,6);
%    Rowidx = [1:length(FsumRowHis)];
%     plot(Rowidx,FsumRowHis); hold on;
%     for i=1:length(RowCluster)
%         idxlist = RowCluster{i};
%         for j=1:length(idxlist)
%             plot([idxlist(j),idxlist(j)],[0,size(mask,2)],'Color','r'); hold on;
%         end 
%     end 
    %axis([0 size(mask,1) 0 size(mask,2)]);
    nbins = size(mask,2)/20;
    RowHisPro = hist(sumRowHis,nbins);
    RowHisPro =  RowHisPro/length(sumRowHis);
    Rowidx = [1:length(RowHisPro)];
    %plot(Rowidx,RowHisPro); hold on;
    hist(sumRowHis,nbins);
%     binrange = [10,20,50,100];
%     binCntRow = histc(sumRowHis,binrange);
    title('sum of row _ FsumRowHis');  

    subplot(4,2,7);
    Colidx = [1:length(F2sumColHis)];
    plot(Colidx,F2sumColHis); hold on;
    title('sum of column - F2sumColHis');


    
    subplot(4,2,8);
    Rowidx = [1:length(F2sumRowHis)];
    plot(Rowidx,F2sumRowHis); hold on;
    title('sum of row _ F2sumRowHis');    
    
    grid on;   
    %saveas(h,[ num2str(idx) '_' num2str(idxp) 'Statistic_Data'],'png'); %saveas(h,[name '\PreTime' num2str(i)],'png');
    
    h = figure; 
    subplot(1,2,1);
    imshow(mask); hold on;
    for i=1:length(ColClusterF)
        idxlist = ColClusterF{i};
        for j=1:length(idxlist)
            plot([idxlist(j),idxlist(j)],[0,size(mask,1)],'Color',[abs(ColPrisF(i)),1,1-abs(ColPrisF(i))],'LineWidth',1); hold on;
        end 
    end
    for i=1:length(RowClusterF)
        idxlist = RowClusterF{i};
        for j=1:length(idxlist)
            plot([0,size(mask,2)],[idxlist(j),idxlist(j)],'Color',[abs(RowPrisF(i)),1,1-abs(RowPrisF(i))],'LineWidth',1); hold on;
        end 
    end 
    
    subplot(1,2,2);
    imshow(mask); hold on;
    for i=1:length(ColClusterS)
        idxlist = ColClusterS{i};
        for j=1:length(idxlist)
            plot([idxlist(j),idxlist(j)],[0,size(mask,1)],'Color',[abs(ColPrisS(i)),1,1-abs(ColPrisS(i))],'LineWidth',1); hold on;
        end 
    end
    for i=1:length(RowClusterS)
        idxlist = RowClusterS{i};
        for j=1:length(idxlist)
            plot([0,size(mask,2)],[idxlist(j),idxlist(j)],'Color',[abs(RowPrisS(i)),1,1-abs(RowPrisS(i))],'LineWidth',1); hold on;
        end 
    end 
    %saveas(h,[ num2str(idx) '_' num2str(idxp) 'SegLines'],'png');
    

end

