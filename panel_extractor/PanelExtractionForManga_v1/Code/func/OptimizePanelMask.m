function [ mask ] = OptimizePanelMask( mask, display )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
[sumColHis,sumRowHis] = Col_Row_Line( mask );



% figure; hist(sumColHis);
% figure;  hist(sumRowHis);
% sumColHis(sumColHis<median(sumColHis)+100) = 0; % high pass filter 
% sumRowHis(sumRowHis<median(sumRowHis)+100) = 0; % high pass filter

% temSumColHis = sumColHis;
% temSumRowHis = sumRowHis;
% 
% if display==1
% Colidx = [1:length(temSumColHis)];
% figure; 
% plot(Colidx,temSumColHis);
% %axis([0 size(mask,2) 0 size(mask,1)]);
% title('sum of column - high -filter');
% end 
% 
% if display==1
% Rowidx = [1:length(temSumRowHis)];
% figure;
% plot(Rowidx,temSumRowHis);
% %axis([0 size(mask,1) 0 size(mask,2)]);
% title('sum of row - - high -filter');
% end 




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



%------------------------------clear gap----------------------------------------

tempSumColHis = [];
for i=1:length(sumColHis)-1
    temSumColHis(i) = sumColHis(i)- sumColHis(i+1);
end 
temSumColHis(length(sumColHis))=0;

tempSumRowHis = [];
for i=1:length(sumRowHis)-1
    temSumRowHis(i) = sumRowHis(i)- sumRowHis(i+1);
end 
temSumRowHis(length(sumRowHis))=0;


% collist = find(sumColHis>300); % 
% for i=1:length(collist) % because it is straight
%     find(max(temSumColHis(collist)));
% end 


% for k=1:2     
%    sumColHis = temSumColHis;
%    sumRowHis = temSumRowHis;
%        
%     tempSumColHis = [];
%     for i=1:length(sumColHis)-1
%         temSumColHis(i) = sumColHis(i)- sumColHis(i+1);
%     end 
%     temSumColHis(length(sumColHis))=0;
% 
%     tempSumRowHis = [];
%     for i=1:length(sumRowHis)-1
%         temSumRowHis(i) = sumRowHis(i)- sumRowHis(i+1);
%     end 
%     temSumRowHis(length(sumRowHis))=0;
%     temSumRowHis = temSumRowHis';
% end 


% filter the mask
% windowSize = 5;
% sumColHis = filter(ones(1,windowSize)/windowSize,1,sumColHis);
% sumRowHis = filter(ones(1,windowSize)/windowSize,1,sumRowHis);
% 
%     if display==1
%     Colidx = [1:size(mask,2)];
%     figure; 
%     plot(Colidx,sumColHis);
%     axis([0 size(mask,2) 0 size(mask,1)]);
%     title('sum of column');
%     end 
% 
%     if display==1
%     Rowidx = [1:size(mask,1)];
%     figure;
%     plot(Rowidx,sumRowHis);
%     axis([0 size(mask,1) 0 size(mask,2)]);
%     title('sum of row');
%     end 


% sumColHis = (255*mat2gray(sumColHis));
% sumRowHis = (255*mat2gray(sumRowHis));

% for i=1:length(sumColHis)
%     mask(:,i) = mask(:,i)*sumColHis(i);
% end 
% 
% for i=1:length(sumRowHis)
%     mask(i,:) = mask(i,:)*sumRowHis(i);
% end 
% 
% 
% mask = uint8(255*mat2gray(mask));
% 
% mask(find(mask<10))==255;
% 
% figure; imshow(mask);
 

if display==1
Colidx = [1:length(temSumColHis)];
figure; 
plot(Colidx,temSumColHis);
%axis([0 size(mask,2) 0 size(mask,1)]);
title('sum of column');
end 

if display==1
Rowidx = [1:length(temSumRowHis)];
figure;
plot(Rowidx,temSumRowHis);
%axis([0 size(mask,1) 0 size(mask,2)]);
title('sum of row');
end 

end

