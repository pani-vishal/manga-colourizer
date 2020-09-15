function [ PanelMask ] = eroson_dilate( mask )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

    se = strel('disk',30,8);
    mask2 = imdilate(mask,se); % expand
    %figure; imshow(mask2);
    
    % --- ?????????????? ? imerode ----------------
    
    mask3 = imerode(mask2,se);
%     figure; imshow(mask3);
    
    PanelMask = mask3;

end

