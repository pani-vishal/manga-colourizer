function [ panels] = DetectThePanelType( mask,idxI,idxP,panels)%sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColCluster,RowCluster,ColHisPro,RowHisPro,

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

    [sumColHis,sumRowHis] = Col_Row_Line( mask );
    [FsumColHis,FsumRowHis,ColHisPro,RowHisPro] = filter_Col_Row_Line( sumColHis,sumRowHis,mask );
    [ColCluster,RowCluster] = clusterCol_Row_Line( FsumColHis,FsumRowHis,mask );

    % ---- display statistic data ----------------------------------------
    display_Statistic_Data(sumColHis,sumRowHis,FsumColHis,FsumRowHis,ColCluster,RowCluster,mask,idxI,idxP);

    ColMax = max(ColHisPro/size(mask,2));
    RowMax = max(RowHisPro/size(mask,1));


     maskx = (mask-1)*(-1);
     [LLX,NUMX] = bwlabel(maskx);
     stats = regionprops(LLX,'Orientation','EulerNumber','Area','ConvexHull','ConvexArea','BoundingBox');

     [ X,Y ] = BiggestAreaInConvexHull4( stats(1,1).ConvexHull ); 

     panelidx = length(panels)+1;
     panels{panelidx}.X = X+BoundingBox(1);
     panels{panelidx}.Y = Y++BoundingBox(2);
 

if abs(size(maskx,1)*size(maskx,2)-stats(1,1).Area)<2*(size(maskx,1)+size(maskx,2)) % BoundingBox is the Panel shape.
    
     typeIdx = 1; 
     figure; imshow(maskx);
     title(num2str(typeIdx));
     panels{length(panels)+1} = stats(1,1).ConvexHull;
     
else if abs(stats(1,1).ConvexArea - stats(1,1).Area)<2*(size(maskx,1)+size(maskx,2)) % the convexhull is the panel shape
     typeIdx = 2;
     figure; imshow(mask);
     title(num2str(typeIdx));
     panels{length(panels)+1} = stats(1,1).ConvexHull;
     
%else if  % 
end 


end

