function [ minx,miny,width,height ] = MaskBoundingBox( x, y )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

min_x = min(x);
max_x = max(x);
min_y = min(y);
max_y = max(y);
% Use rectangle to draw bounding rectangle
minx = min_x;
miny = min_y;
width = max_x-min_x;
height = max_y-min_y;

end

