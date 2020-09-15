function [ mask,ObliqueLineFlag ] = isColObliqueLine( mask,sumColHis,FsumColHis,ColCluster,ColPris,idx )
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

    if nargin < 1      
        close all;
        clear all;
        %I = imread('slum_dunk_239\4.jpg'); % 5, 2 expmaple %8% 1 % 3 % 5~8 6  10 15 -- clusterCol_Col_Line--modify 30
        I = imread('naruto_514\2.jpg'); %3 4, 9% panel shape -- problems --naruto_514\3 % 3-4 17-2!!-- if there is no boundary in page, then we add dotted line not affect the connected component but will indicate the peak F
        idxI = 20;
        idxP = 0;
        load oblique;
    end 
    
    %mask = mask(:,2:size(mask,2)-1);
    
    ObliqueLineFlag = false;

    ColIdxList = ColCluster{idx};

    

    minidx = ColIdxList(1);
    maxidx = ColIdxList(length(ColIdxList));
    gapmask = mask(:,minidx:maxidx);
        
    
    %---------------------- % find this code in other parts of the program 
%     FColHis = FsumColHis(ColIdxList);
%     [FColdislist, FColDisperse] = ComputeDisperse( FColHis );
%    
%     FColDisperse = length(find(abs(FColdislist)>=5)); % describe the disperse. naruto -- page 12 threshold 
%     
%     if FColDisperse>0.1*length(ColIdxList) % exist bigger area of unorganized area.....
%         return;
%     end 
    
    % how to distinguish the gap line and white areas in panel 
    
    %----------------------
    
    
    [LLX,NUMX] = bwlabel(gapmask);
    stats = regionprops(LLX,'Image','Area','Orientation','MajorAxisLength','MinorAxisLength', 'Perimeter','Eccentricity');
       
    
    if NUMX>5
        return;
    end 
    
    if NUMX>=1
        areaW = stats(1,1).Area;
        majaxis = stats(1,1).MajorAxisLength;
        minaxis = stats(1,1).MinorAxisLength;
        perime  = stats(1,1).Perimeter;
        eccent  = stats(1,1).Eccentricity;
        orien   = stats(1,1).Orientation;
        
        for i=2:NUMX

            if stats(i,1).MajorAxisLength> majaxis 
                areaW = stats(i,1).Area;
                majaxis = stats(i,1).MajorAxisLength;
                minaxis = stats(i,1).MinorAxisLength;
                perime  = stats(i,1).Perimeter;
                eccent  = stats(i,1).Eccentricity;
                orien   = stats(1,1).Orientation;
                
            end 
            %direction = [cos(stats(i,1).Orientation),sin(stats(i,1).Orientation)];
        end 
    end 
    
%     if eccent>0.8
%         ObliqueLineFlag = true;
%         return;
%     end 
    
    if majaxis<0.3*size(mask,1)
        return;
    end 
        
    if eccent<0.5
        return;
    end 
    
    if abs(orien)<=45
        return;
    end 
    
    
    
    
    %---------------------------------------
    range  = (maxidx-minidx+1);
    
    SS = sum(sumColHis(minidx:maxidx));
    Sw = uint16(SS/size(mask,1));
    
    if range>30
        range = Sw*0.5;
    else
    end 
    
    display = 0;
    
    expminidx = 1;
    if minidx-range>1
        expminidx = minidx-range;
    end 
    
    expmaxidx = size(mask,2);
    if (maxidx+range)<size(mask,2)
        expmaxidx = maxidx+range;
    end 
    
    expandmask = mask(:,expminidx:expmaxidx);
    
    [LLX,NUMX] = bwlabel(expandmask);
    stats = regionprops(LLX,'Image','Orientation','Centroid','EulerNumber','Area','ConvexHull','BoundingBox','Eccentricity','FilledImage');

    
    if display ==1
    figure; imshow(LLX); hold on;
    end 

    
    for i=1:NUMX

        direction = [cos(stats(i,1).Orientation),sin(stats(i,1).Orientation)];
        if display==1
        plot(stats(i,1).ConvexHull(:,1),stats(i,1).ConvexHull(:,2)); hold on;
        plot([stats(i,1).Centroid(1),direction(1)],[stats(i,1).Centroid(2),direction(2)]);hold on;
        end
 
    end 
    
    
    
    % give the condition that is not oblique lines ------------???? ---
    
    
    
%         idxI = 0;
%         idxP = 0;
%         [sumColHis,sumColHis] = Col_Col_Line( gapmask );
%         [FsumColHis,FsumColHis,ColHisPro,ColHisPro] = filter_Col_Col_Line( sumColHis,sumColHis,gapmask );
%         [ColClusterF,ColClusterF] = clusterCol_Col_Line( FsumColHis,FsumColHis,gapmask );
%         [F2sumColHis,F2sumColHis] = filter2_Col_Col_Line( sumColHis,sumColHis,gapmask );
%         [ColClusterS,ColClusterS] = cluster2Col_Col_Line( sumColHis,sumColHis,gapmask );
%         [ColPrisF,ColPrisF,ColPrisS,ColPrisS] = ComputePrio( sumColHis,sumColHis,FsumColHis,FsumColHis,ColClusterF,ColClusterF,F2sumColHis,F2sumColHis,ColClusterS,ColClusterS,gapmask,idxI,idxP );
%         %[ColCluster,ColCluster,ColPris,ColPris] = CombineClusterSF( sumColHis,sumColHis,FsumColHis,FsumColHis,ColClusterF,ColClusterF,F2sumColHis,F2sumColHis,ColClusterS,ColClusterS,ColPrisF,ColPrisF,ColPrisS,ColPrisS,mask,idxI,idxP );
% 
%         % ---- display statistic data ----------------------------------------
%         display_Statistic_Data(sumColHis,sumColHis,FsumColHis,FsumColHis,ColClusterF,ColClusterF,F2sumColHis,F2sumColHis,ColClusterS,ColClusterS,ColPrisF,ColPrisF,ColPrisS,ColPrisS,gapmask,idxI,idxP);
% 
%         se = strel('disk',30,8);
%         mask2 = imdilate(gapmask,se);
%         figure; imshow(mask2);
        
        Xx = [];
        Yy = [];
        for i=1:size(expandmask,1)
            whitelist = find(expandmask(i,:)==1);
            if length(whitelist)<=0
            else
                Xx = [Xx,i];
                Yy = [Yy, mean(whitelist)];
            end 
            
        end 
        
        if display ==1
        figure; imshow(expandmask); hold on;
        plot(Yy,Xx,'.','Color','r'); hold on;  
        end
        p=polyfit(Xx,Yy,1);
        
        Xx = 1:size(expandmask,1);
        Yy = uint16(polyval(p,Xx));
         
        if display ==1
        plot(Yy,Xx,'p','Color','g'); hold on;
        poly2sym(p,'x'); hold on;
        end
        
       
        
        Yy(find(Yy<1)) = 1;
        Yy(find(Yy>size(expandmask,2))) = size(expandmask,2);
                
        for i=1:length(Xx)
            for j=-2:2
                if Yy(i)+j<size(expandmask,2)
                    expandmask(Xx(i),Yy(i)+j) = 1;
                    if display ==1
                    plot(Yy(i)+j,Xx(i),'O'); hold on;
                    end
                end 
            end 
        end 
        
        mask(:,expminidx:expmaxidx) = expandmask;
        if display ==1
        figure; imshow(mask);
        end
        ObliqueLineFlag = true;
        
        %YY=polyfit(Xx,Yy,1);
        %plot(Xx,Yy,'o','Color','r'); hold on;
        


end

