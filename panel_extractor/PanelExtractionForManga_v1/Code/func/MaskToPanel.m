function [ panelMask,panels ] = MaskToPanel( mask,I,idxI)
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

    panels = {};

    if nargin < 1      
        close all;
        clear all;
        I = imread('slum_dunk_239\5.jpg');
        %I = imread('naruto_514\3.jpg');
        mask = load('mask.mat');
        mask = mask.mask;
        idxI = 1;
    end 
    
    
    panels = {};
    
    display = 0;
    
    %white boundary dominant  -> back boundary dominant 
%-------------------------------
    mask = (mask-1)*(-1); % ----  reverse the matrix elements 0 and 1
%-------------------------------
 
  
    if display==1
    figure(100); imshow(I); hold on;
    end 

    [LLX,NUMX] = bwlabel(mask);
    stats = regionprops(LLX,'Image','Orientation','EulerNumber','Area','ConvexHull','BoundingBox','Eccentricity','FilledImage');
    
    if display ==1
    figure; imshow(LLX); hold on;
    end 
    flags = zeros(0,NUMX);
    for i=1:NUMX
        for j=1:NUMX
            if display==1
            plot(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2)); hold on;
            end
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
            maskx(removeidx) = 1;   % reverse the white and black --- white boudary dominant 
        end        
        maskx(find(LLX==idx)) = 0;
        
        if display==1
        figure; imshow(maskx);
        end 
        
        if flags(i)==1
            continue;
        end 
        
        x1 = ceil(stats(i,1).BoundingBox(1));
        x2 = floor(stats(i,1).BoundingBox(1)+stats(i,1).BoundingBox(3));
        
        
        y1 = ceil(stats(i,1).BoundingBox(2));
        y2 = floor(stats(i,1).BoundingBox(2)+stats(i,1).BoundingBox(4));
        
        if x1<1
            x1 = 1;
        end 
        if y1<1
            y1 = 1;
        end 
        if x2>size(maskx,2)
            x2 = size(maskx,2);
        end 
        if y2>size(maskx,1)
            y2 = size(maskx,1);
        end 
         
        maskXx = maskx(y1:y2,x1:x2);
        %save maskXx maskXx;
        
        
        Seg = false;
        if display==1
        figure; imshow(maskXx);
        end
        [ maskXx, panels ] = ExtractPanelFromObject1( maskXx, idxI,i,panels,x1,y1,Seg); % input white boundary -black objects
        
 
%       figure(200);
%       plot(panel.x,panel.y,'Color','r');
      
        maskx(y1:y2,x1:x2) = maskXx;
        maskx = (maskx-1)*(-1);
                
        panelMask = panelMask + maskx;     
                
%         if length(find(maskx==1))>10000        
%            figure; imshow(maskx);
%            figure; imshow(stats(i,1).FilledImage);
%         end 
        
%         masky = LLX;
%         masky(:,:) = 0;
%         X = [stats(i,1).BoundingBox(1), stats(i,1).BoundingBox(1)+stats(i,1).BoundingBox(3),stats(i,1).BoundingBox(1)+stats(i,1).BoundingBox(3),stats(i,1).BoundingBox(1),stats(i,1).BoundingBox(1)];
%         Y = [stats(i,1).BoundingBox(2), stats(i,1).BoundingBox(2), stats(i,1).BoundingBox(2)+stats(i,1).BoundingBox(4),stats(i,1).BoundingBox(2)+stats(i,1).BoundingBox(4),stats(i,1).BoundingBox(2)];
%         masky = masky + poly2mask(X,Y,size(LLX,1),size(LLX,2));
%         
%         figure(100);
%         plot(X,Y,'color','r','linewidth',2); hold on;
 
        
    end
    
    if display==1
    figure; imshow(panelMask);
    h = figure; imshow(I); hold on;
    for i=1:length(panels)
        plot([panels{i}.X,panels{i}.X(1)],[panels{i}.Y,panels{i}.Y(1)],'Color','r','LineWidth',2); hold on;
    end 

    
%    title('First:use left key reset all the wrong panels. Second?use right delect the wrong panels. Third: use middle exist the panel');
    

%     newpanels= {};
%     delFlag = zeros(1,length(panels));
%     for k = 1:10
%         X = [];
%         Y = [];
%         for j=1:4
%             [x,y,button] = ginput(1);
%             if button == 2
%                 break;
%             end 
%             if button == 3
%                 for i=1:length(panels)
%                     IN = inpolygon(x,y,[panels{i}.X,panels{i}.X(1)],[panels{i}.Y,panels{i}.Y(1)]);
%                     if IN == 1
%                         delFlag(i) = delFlag(i)*(-1);
%                         plot([panels{i}.X,panels{i}.X(1)],[panels{i}.Y,panels{i}.Y(1)],'Color','y','LineWidth',2); hold on;
%                         break;
%                     end                    
%                 end 
%                 break;
%             end 
%             if button ==3
%                 continue;
%             end 
%             if button == 1
%                 X = [X,x];
%                 Y = [Y,y];
%             end 
%         end 
%         
%         if button == 2
%             break;
%         end 
% 
%         if length(X)==4
%             plot([X,X(1)],[Y,Y(1)],'Color','b','LineWidth',2); hold on;
%             if 1 % enter key
%                 panelidx = length(newpanels)+1;
%                 newpanels{panelidx}.X = X;
%                 newpanels{panelidx}.Y = Y;
%             end 
%             
%             continue;
%         else
%             continue;
%         end 
% 
% 
%     end 
%     
%     for i=1:length(delFlag)
%         if delFlag(i)==0
%             panelidx = length(newpanels)+1;
%             newpanels{panelidx} = panels{i};
%         end 
%         
%     end 
    
        
    saveas(h,['naruto_514\result\' num2str(idxI)],'png');
    % saveas(h,num2str(idxI),'fig');
    end 

end

