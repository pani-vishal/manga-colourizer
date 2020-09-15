function [ ] = DisplayPanels( mask, figidx )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 
    display = 0;

    [LLX,NUMX] = bwlabel(mask);
    stats = regionprops(LLX,'Image','Orientation','EulerNumber','Area','ConvexHull','BoundingBox','Eccentricity','FilledImage');
    
    
    figure; imshow(mask); hold on;
    flags = zeros(0,NUMX);
    for i=1:NUMX
        for j=1:NUMX
            plot(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2)); hold on; %%%%
            if i~=j
                in = inpolygon(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2),stats(j,1).ConvexHull(:,1),stats(j,1).ConvexHull(:,2));
                idx = find(in==1);
                
                if length(idx)>0.5*length(in)
                    flags(i) = 1;
                else
                    flags(i) = 0;
                end 
            end 
        end        
    end 
    
    
    panelMask = zeros(size(mask,1),size(mask,2));
     
    for i=1:NUMX
        idx = i;
        maskx = LLX;
        removeidx = find(LLX~=idx);
        if ~isempty(removeidx)
            maskx(removeidx) = 0;
        end        
        maskx(find(LLX==idx)) = 1;
        
        if display==1
        figure; imshow(maskx);
        end 
        
        if flags(i)==1
            continue;
        end 
               
        panelMask = panelMask + maskx;     
                
    end
    
    [LLX,NUMX] = bwlabel(panelMask);
    stats = regionprops(LLX,'Image','Orientation','EulerNumber','Area','ConvexHull','BoundingBox','Eccentricity','FilledImage');
    
    figure; imshow(panelMask); hold on;
    for i=1:NUMX     
        plot(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2),'Color', 'r','linewidth',2); hold on;         
    end
    saveas(gcf,num2str(figidx),'fig');

end

