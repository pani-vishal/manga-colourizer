function [ ] = CheckPanel_display( I,panels,idx)

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

% if nargin<1
%     clear all;
%     close all;
%     filepath = 'naruto_514\';   %17
%     %filepath = 'slum_dunk_239\'; %19
%     PagePanels = load('PagePanels.mat');
%     PagePanels = PagePanels.PagePanels;
% end

%PagePanels = {};

% for n=1:length(PagePanels)
    
%     close all;
%     file = [filepath num2str(n) '.jpg']
%     I = imread(file);
%     panels = PagePanels{n};

    
    
    h = figure(idx); imshow(I); hold on;
    for i=1:length(panels)
        plot([panels{i}.X,panels{i}.X(1)],[panels{i}.Y,panels{i}.Y(1)],'Color','r','LineWidth',2); hold on;
    end 
    hold off;
    
   

end

