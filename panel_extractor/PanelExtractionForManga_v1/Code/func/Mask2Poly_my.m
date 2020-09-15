function [ polygon ] = Mask2Poly_my( mask )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
    %if length(find(mask ==1))>2500             
        stats = regionprops(mask,'ConvexHull');% measures a set of properties for each
        %labeled region in the label matrix L
        %The eccentricity is the ratio of the distance between the foci of the ellipse and its major axis length
        if ~isempty(stats)
            for kk=1:size(stats,1)
                poly_x = stats(kk,1).ConvexHull(:,1);
                poly_y = stats(kk,1).ConvexHull(:,2);
                %plot(poly_x, poly_y,'color','r','linewidth',1);
            end          
        end                   
    %end
    
    polygon.x = poly_x;
    polygon.y = poly_y;

end

