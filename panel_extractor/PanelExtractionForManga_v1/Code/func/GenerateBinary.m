function [ InitialMask ] = GenerateBinary( I, idxI)
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

    if nargin < 1      
        close all;
        clear all;
        %I = imread('slum_dunk_239\3.jpg');
        I = imread('naruto_514\4.jpg');
        idxI = 1;
    end 


    InitialMask = [];

    if size(I,3)==3
        I = rgb2gray(I);
    end
        
    
    % Threshhold the image and smooth the edges
    %if mean(mean(I))> 203.7260 214 185
    %if mean(mean(I))>210
    %thresh = 235; % naruo -- 3
    %thresh = 240;
    thresh = 230;
    BW = (I < thresh);
    
    
    %[BW,rowflagS,rowflagE,colflagS,colflagE,repairsize] = RepairIMG(BW); % repair uncomplete panel shape
    [BW,rowflagS,rowflagE,colflagS,colflagE,repairsize] = RepairIMG_BW(BW);
    
    BW = ~BW;  % t
    
%    figure(idxI); imshow(BW); hold on;
    

    [LLX,NUMX] = bwlabel(BW,8);  
    stats = regionprops(LLX, 'BoundingBox');
       
    
    idxlist = [];
    
    if BW(1,1) == 1
        idxlist = [idxlist,LLX(1,1)];
    end 
    if BW(size(BW,1),size(BW,2)) == 1
        idxlist = [idxlist,LLX(size(BW,1),size(BW,2))];
    end 
    if BW(1,size(BW,2))
        idxlist = [idxlist,LLX(1,size(BW,2))];
    end 
    if BW(size(BW,1),1)
        idxlist = [idxlist,LLX(size(BW,1),1)];
    end 
    
    filteridx = [];
    for i=1:length(idxlist)
        idx = idxlist(i);
        if isempty(find(filteridx==idx))
            filteridx = [filteridx; idx];
        end 
    end 
    
   
    flidx = filteridx(1);
    flarea = stats(flidx,1).BoundingBox(3)*stats(flidx,1).BoundingBox(4);
    
    if length(filteridx)>1
        for i=2:length(filteridx)
            idx = filteridx(i);
            
            if (stats(idx,1).BoundingBox(3)*stats(idx,1).BoundingBox(4)>flarea)
                flidx = idx;
                flarea = stats(idx,1).BoundingBox(3)*stats(idx,1).BoundingBox(4);
            end
        end
    end 
    
    
    idx = flidx;
    mask = LLX;
    removeidx = find(LLX~=idx);
    if ~isempty(removeidx)
        mask(removeidx) = 0;
    end        
    mask(find(LLX==idx)) = 1;
    
%    figure; imshow(mask); hold on;
 
%    poly = Mask2Poly_my(mask);% the bounding box is bigger equal to the image 
%    tempmask = poly2mask(poly.x,poly.y,size(mask,1),size(mask,2));


% if max(rowBlack(1:100))<0.7*size(BW,2)
%     BW(1:3,1:size(BW,2)) = rowLine;
%     rowflagS = true;
% end 
% 
% if max(rowBlack((size(BW,1)-100):size(BW,1)))<0.7*size(BW,2)
%     BW(size(BW,1)-3+1:size(BW,1),1:size(BW,2)) = rowLine;
%     rowflagE = true;
% end 
% 
% if max(colBlack(1:100))<0.7*size(BW,1)
%     BW(1:size(BW,1),1:3) = colLine;
%     colflagS = true;
% end 
% 
% if max(colBlack((size(BW,2)-100):size(BW,2)))<0.7*size(BW,1)
%     BW(1:size(BW,1),size(BW,2)-3+1:size(BW,2)) = colLine;
%     colflagE = true;
% end 


     templateX = [0,0,0,1,1,1];
     template = [];
     for k=1:repairsize
         template = [template;templateX];
     end 
     template = repmat(template,1,fix(size(mask,1)/5));
     
     rowTemp  = template(:,1:size(mask,2));
     colTemp  = template(:,1:size(mask,1));
     colTemp  = colTemp';

     if rowflagS == true
         mask(1:repairsize,1:size(mask,2)) = rowTemp;
     end
     
     if rowflagE == true
         mask(size(mask,1)-repairsize+1:size(mask,1),1:size(mask,2)) = rowTemp;
     end
     
     if colflagS == true
         mask(1:size(mask,1),1:repairsize) = colTemp;
     end
     
     if colflagE == true
         mask(1:size(mask,1),size(mask,2)-repairsize+1:size(mask,2)) = colTemp;
     end 

     
    InitialMask = mask;
    
end

