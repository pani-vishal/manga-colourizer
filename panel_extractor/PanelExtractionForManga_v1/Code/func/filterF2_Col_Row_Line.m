function [ F2sumColHis,F2sumRowHis] = filterF2_Col_Row_Line( sumColHis,sumRowHis,mask )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
display = 0;

%-filter the col and row histogram -----------------------------------
winsize = 10;
for k = 1:1
    temSumColHis = sumColHis;
    for i=1:winsize
        temSumColHis(i) = max(sumColHis(1:winsize))-min(sumColHis(1:winsize));
    end
    for i=winsize+1:length(sumColHis)-winsize
        temSumColHis(i) = max(sumColHis(i-winsize:i+winsize))-min(sumColHis(i-winsize:i+winsize));
        %temSumColHis(i) = sum(sumColHis(i-winsize:i+winsize));
    end
    for i=length(sumColHis)-winsize+1:length(sumColHis)
        temSumColHis(i) = max(sumColHis(length(sumColHis)-winsize+1:length(sumColHis)))-min(sumColHis(length(sumColHis)-winsize+1:length(sumColHis)));
    end
    
    if display==1
        Colidx = [1:length(temSumColHis)];
        figure;
        plot(Colidx,temSumColHis);
        %axis([0 size(mask,2) 0 size(mask,1)]);
        title('sum of column - F2 Col');
    end
    
    if display==1
        Colidx = [1:length(sumColHis)];
        figure;
        plot(Colidx,sumColHis);
        %axis([0 size(mask,2) 0 size(mask,1)]);
        title('sum of column - F2 Col');
    end
    
    temSumRowHis = sumRowHis;
    for i=1:winsize
        temSumRowHis(i) = max(sumRowHis(1:winsize))-min(sumRowHis(1:winsize));
    end
    for i=winsize+1:length(sumRowHis)-winsize
        temSumRowHis(i) = max(sumRowHis(i-winsize:i+winsize))-min(sumRowHis(i-winsize:i+winsize));
        %temSumColHis(i) = sum(sumColHis(i-winsize:i+winsize));
    end
    for i=length(sumRowHis)-winsize+1:length(sumRowHis)
        temSumRowHis(i) = max(sumRowHis(length(sumRowHis)-winsize+1:length(sumRowHis)))-min(sumRowHis(length(sumRowHis)-winsize+1:length(sumRowHis)));
    end    
    
    if display==1
        Rowidx = [1:length(temSumRowHis)];
        figure;
        plot(Rowidx,temSumRowHis);
        %axis([0 size(mask,1) 0 size(mask,2)]);
        title('sum of row - F2 Row');
    end
    
    if display==1
        Rowidx = [1:length(sumRowHis)];
        figure;
        plot(Rowidx,sumRowHis);
        %axis([0 size(mask,1) 0 size(mask,2)]);
        title('sum of row - F2 Row');
    end

      
    
end

F2sumColHis = temSumColHis;
F2sumRowHis = temSumRowHis;
    
    
end