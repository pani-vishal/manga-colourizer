function [panels] = ExtractPanelShape(I,idxI)
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12


    if nargin < 1      
        close all;
        clear all;
        I = imread('Data/naruto_514/49.png'); %3,12,7 4, 9% panel shape -- problems --naruto_514\3 % 3-4 17-2!!-- if there is no boundary in page, then we add dotted line not affect the connected component but will indicate the peak F
        idxI = 20;
    end 
    
    panels={};
    %figure(idxI); imshow(I);
 
    mask = GenerateBinary( I,idxI );
    %figure; imshow(mask);
    
    %-------------- remove small object
    [ mask ] = RemoveSmallObjects( mask ); % remove the page number, etc. 
    %figure; imshow(mask); % discribe each stage 
 
%     mask = (mask-1)*(-1);
%     DisplayPanels( mask, 0);
     
%     [ mask ] = OptimizePanelMask( mask );
        
    %-------------- reverce and bwlabel
%     se = strel('disk',2,8);
%     mask2 = imerode(mask,se);
%     figure; imshow(mask2);
 
    
%     %------------------------------ column or row ---   
%     Col_Row_Line( mask );
%       
%     %------------------------------ dilate and erode -------
     % mask = eroson_dilate( mask );
%     
%     %---------------------------- mask ----------------------
      
%    save mask mask;
     
     [ panelmask,panels ] = MaskToPanel(mask,I,idxI);
 
     if nargin < 1   
        DisplayPanels( panelmask, idxI);
     end 
     
     %PanelList = panels;
       
end

