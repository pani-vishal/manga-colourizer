function [ II ] = MaskImage( I,poly_x,poly_y,mask )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
    [minx,miny,width,height] = MaskBoundingBox(poly_x,poly_y);   
    minx = max(1,minx);
    miny = max(1,miny);
    yend = min(size(I,1),miny+height);
    xend = min(size(I,2),minx+width);
    
    I( mask==0)=255;
    II = I(miny:yend,minx:xend);
    
    
%     if minx<1 
%         minx = 1;
%     end 
%     if minx+width-1 >size(I,2)
%         width = size(I,2)-minx+1;
%     end 
%     if miny<1
%         miny = 1;
%     end 
%     if miny+height-1 > size(I,1)
%         height = size(I,1)-miny+1;
%     end 
%     
% 
%     I( mask==0)=255;         
%     II = I(miny:miny+height-1,minx:minx+width-1);
end

