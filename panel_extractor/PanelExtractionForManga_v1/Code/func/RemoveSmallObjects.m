function [ mask ] = RemoveSmallObjects( mask )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

    mask = (mask-1)*(-1);

    [LLX,NUMX] = bwlabel(mask);
    stats = regionprops(LLX,'Area','BoundingBox','FilledImage');
    
    for i=1:NUMX
        idx = i;

        if stats(i,1).Area<10000%
            removeidx = find(LLX==idx);
            LLX(removeidx) = 0;
        else
            %figure; imshow(stats(i,1).FilledImage);
        end 
 
    end
    
    LLX(find(LLX~=0))=1;
    mask = LLX;
    
    %-------------- fill the holes   
    %se = strel('disk',1,8);
    %mask = imdilate(mask,se);
    
    mask = imfill(mask,'holes');
    %figure; imshow(mask);    
    
    %mask = imerode(mask,se);
    
    mask = (mask-1)*(-1);

end

