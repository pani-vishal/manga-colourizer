function [sumColHis,sumRowHis] = Col_Row_Line( mask )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

    display = 0;


    sumColHis = sum(mask,1);   % width
    
    if display==1
    Colidx = [1:size(mask,2)];
    figure; 
    plot(Colidx,sumColHis);
    axis([0 size(mask,2) 0 size(mask,1)]);
    title('sum of column');
    end 
    
    sumRowHis = sum(mask,2);   % height
    
    if display==1
    Rowidx = [1:size(mask,1)];
    figure;
    plot(Rowidx,sumRowHis);
    axis([0 size(mask,1) 0 size(mask,2)]);
    title('sum of row');
    end 
    
%     ColMatrix =  repmat(sumColHis,size(mask,1),1);
%     RowMatrix =  repmat(sumRowHis,1,size(mask,2));
%     RowMatrix = RowMatrix';
%     
%     ColRowMatrix = ColMatrix*RowMatrix;  
%     
%     if display==1
%         ColRowMatrix = uint8(255*mat2gray(ColRowMatrix));
%         figure; imshow(ColRowMatrix);    
%     end 

%------------------------------------- see uint8(255*mat2gray(mask))
%     sumColHisX = (255*mat2gray(sumColHis));
%     sumRowHisX = (255*mat2gray(sumRowHis));
% 
%     for i=1:length(sumColHisX)
%         mask(:,i) = mask(:,i)*sumColHisX(i);
%     end 
% 
%     for i=1:length(sumRowHisX)
%         mask(i,:) = mask(i,:)*sumRowHisX(i);
%     end 
%     mask = uint8(255*mat2gray(mask));
%     mask(find(mask<10))==255;
%     figure; imshow(mask);

end

