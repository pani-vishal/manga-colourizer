function [ segOver, mask] = IsSegOver( mask,idxI,idxP) % input white boundary 
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12


    if nargin < 1      
        close all;
        clear all;
        %I = imread('slum_dunk_239\2.jpg');
        %I = imread('naruto_514\1.jpg');
        I = imread('naruto_514\3.jpg');
        maskx = load('maskXx.mat');
        mask = maskx.maskXx;
        idxI = 3;
        idxP = 2;
        panels = {};
    end 
    
    display = 0;
    
    
    if display == 1
    figure; imshow(mask);
    end 
    
    %if length(find(mask))
    
    masko = mask;
    mask = ones(size(masko,1)+2,size(masko,2)+2);
    mask(2:size(masko,1)+1,2:size(masko,2)+1) = masko;


        [sumColHis,sumRowHis] = Col_Row_Line( mask );
        [FsumColHis,FsumRowHis,ColHisPro,RowHisPro] = filter_Col_Row_Line( sumColHis,sumRowHis,mask );
        
            ColThresF = 0.1*size(mask,1); %50;% need to be modified ------ a smart method to choose the threshold
            RowThresF = 0.1*size(mask,2); 
            ColnearThresF = 30; % 0.05*size(mask,1); %maximal distance between two cluster ---------------------------------
            RownearThresF = 30; % 0.1*size(mask,2); % set to 0.05 why??
        
        [ColClusterF,RowClusterF] = clusterFCol_Row_Line( FsumColHis,FsumRowHis,mask,ColThresF,RowThresF,ColnearThresF,RownearThresF );
        [F2sumColHis,F2sumRowHis] = filterF2_Col_Row_Line( sumColHis,sumRowHis,mask );
        
            ColThresS = 0.1*size(mask,1); %50;% need to be modified ------ a smart method to choose the threshold
            RowThresS = 0.1*size(mask,2); 
            
%             ColThresS = 0.3*size(mask,1); %50;% need to be modified ------ a smart method to choose the threshold
%             RowThresS = 0.3*size(mask,2); 
            
            ColnearThresS = 50;
            RownearThresS = 50;
        
        [ColClusterS,RowClusterS] = clusterSCol_Row_Line( sumColHis,sumRowHis,mask,ColThresS,RowThresS,ColnearThresS,RownearThresS );
        [ColPrisF,RowPrisF,ColPrisS,RowPrisS] = ComputePrio( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,mask,idxI,idxP );
        %[ColCluster,RowCluster,ColPris,RowPris] = CombineClusterSF( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idxI,idxP );

        % ---- display statistic data ----------------------------------------
        %display_Statistic_Data(sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idxI,idxP,ColThresF,RowThresF,ColnearThresF,RownearThresF,ColThresS,RowThresS,ColnearThresS,RownearThresS);

        ColMax = max(ColHisPro/size(mask,2));
        RowMax = max(RowHisPro/size(mask,1));
        
       
        % add some segmentation line to the boundary        
        % satisfy these conditions then it is defined as segmentation over. 
        if length(ColClusterF)<=2 && length(RowClusterF)<=2 && length(ColClusterS)<=2 && length(RowClusterS)<=2
            % sometimes the boundry of the mask has no white pixels, so it
            % is better to normalize it by adding lines on the boundary...
            [ mask,segOver ] = SegPanelMask2( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idxI,idxP );
            segOver = true;
        else % we segment it under different condition 
            % continue segmentation  // sometimes there is no segmentation
            % during the SegPanelMask pharse -----------------------------
            [ mask,segOver ] = SegPanelMask2( sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColClusterF,RowClusterF,F2sumColHis,F2sumRowHis,ColClusterS,RowClusterS,ColPrisF,RowPrisF,ColPrisS,RowPrisS,mask,idxI,idxP );
            %segOver = false; % segment mask use a line..           
        end 

    mask = mask(2:size(masko,1)+1,2:size(masko,2)+1);

end

