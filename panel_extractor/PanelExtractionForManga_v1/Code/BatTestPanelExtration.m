function [ ] = BatTestPanelExtration( filepath )
 
% Input is the manga pages
% Output (PagePanels) is the polygons for panels in each manga page
% Function CheckPanel_display draw the extracted panel shapes

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

 
if nargin<1
    clear all;
    close all;
    filepath = 'Code/Data/naruto_514/';   %17
    pageNum = 17;
    % filepath = 'slum_dunk_239\'; % 19
    % pageNum = 19;
end

PagePanels = {};

for i=1:pageNum 
    % display(i);
    
    % close all;
    file = [filepath num2str(i) '.jpg'];
    I = imread(file);
 
    [panels] = ExtractPanelShape(I,i);
    PagePanels{i} = panels;

    CheckPanel_display( I,panels,i);
end 


save PagePanels PagePanels;

end

