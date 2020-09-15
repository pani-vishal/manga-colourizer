function [ FsumColHis,FsumRowHis,ColHisPro,RowHisPro ] = filter_Col_Row_Line( sumColHis,sumRowHis,mask )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
    display = 0;

    FsumColHisL = zeros(1,length(sumColHis));
    for i=1:length(sumColHis)-1
        FsumColHisL(i) = sumColHis(i)- sumColHis(i+1);
    end 
    
    FsumColHisR = zeros(1,length(sumColHis));
    for i=1:length(sumColHis)-1
        FsumColHisR(length(sumColHis)+1-i) = sumColHis(length(sumColHis)+1-i)- sumColHis(length(sumColHis)-i);
    end
    
    FsumColHis = FsumColHisL+FsumColHisR;
    
    FsumColHis(find(FsumColHis<0)) = 0;
    

    FsumRowHisL = zeros(1,length(sumRowHis));
    for i=1:length(sumRowHis)-1
        FsumRowHisL(i) = sumRowHis(i)- sumRowHis(i+1);
    end 
    
    FsumRowHisR = zeros(1,length(sumRowHis));
    for i=1:length(sumRowHis)-1
        FsumRowHisR(length(sumRowHis)+1-i) = sumRowHis(length(sumRowHis)+1-i)- sumRowHis(length(sumRowHis)-i);
    end
    
    FsumRowHis = FsumRowHisL+FsumRowHisR;
    
    FsumRowHis(find(FsumRowHis<0)) = 0;
    
    

    if display==1
    Colidx = [1:length(FsumColHis)];
    figure; 
    plot(Colidx,FsumColHis);
    %axis([0 size(mask,2) 0 size(mask,1)]);
    title('sum of column-FsumColHis');
    end 

    if display==1
    Rowidx = [1:length(FsumRowHis)];
    figure;
    plot(Rowidx,FsumRowHis);
    %axis([0 size(mask,1) 0 size(mask,2)]);
    title('sum of row-FsumRowHis');
    end 
    
    
%     WinSize = 5;
%     EsumColHis = sumColHis;
%     for i=6:length(sumColHis)-5
%         EsumColHis(i) = entropy(sumColHis(i-WinSize:i+WinSize));
%     end 
%     %EsumColHis(length(sumColHis))=0;
% 
%     EsumRowHis = sumRowHis;
%     for i=6:length(sumRowHis)-5
%         EsumRowHis(i) = entropy(sumRowHis(i-WinSize:i+WinSize));
%     end 
%     %EsumRowHis(length(sumRowHis))=0;
%     
%     
%     if display==1
%     Colidx = [1:length(EsumColHis)];
%     figure; 
%     plot(Colidx,EsumColHis);
%     %axis([0 size(mask,2) 0 size(mask,1)]);
%     title('sum of column - EsumColHis');
%     end 
% 
%     if display==1
%     Rowidx = [1:length(EsumRowHis)];
%     figure;
%     plot(Rowidx,EsumRowHis);
%     %axis([0 size(mask,1) 0 size(mask,2)]);
%     title('sum of row - EsumRowHis');
%     end 
    
    nbins = size(mask,1)/20;
    ColHisPro = hist(sumColHis,nbins);
    
    nbins = size(mask,2)/20;    
    RowHisPro = hist(sumRowHis,nbins); 
 
    
%-filter the col and row histogram -----------------------------------
% sumRowHis = sumRowHis';
% winsize = 3;
% for k = 1:1
% tempSumColHis = sumColHis;
% for i=winsize+1:length(sumColHis)-winsize
%     temSumColHis(i) = max(sumColHis(i-winsize:i+winsize))-min(sumColHis(i-winsize:i+winsize));
%     %temSumColHis(i) = sum(sumColHis(i-winsize:i+winsize));
% end 
% temSumColHis(length(sumColHis))=0;
% 
% tempSumRowHis = sumRowHis;
% for i=winsize+1:length(sumRowHis)-winsize
%     temSumRowHis(i) = max(sumRowHis(i-winsize:i+winsize))-min(sumRowHis(i-winsize:i+winsize));
%     %temSumRowHis(i) = sum(sumRowHis(i-winsize:i+winsize));
% end 
% temSumRowHis(length(sumRowHis))=0;
% 
% temSumRowHis = temSumRowHis+sumRowHis;
% temSumColHis = temSumColHis+sumColHis;
% 
% sumRowHis = temSumRowHis;
% sumColHis = temSumColHis;
% end

end

