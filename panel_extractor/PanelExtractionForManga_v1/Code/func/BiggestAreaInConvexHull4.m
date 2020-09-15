function [ X,Y ] = BiggestAreaInConvexHull4( ConvexHull )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 

    display = 0;

    x = ConvexHull(:,1);
    y = ConvexHull(:,2);

    ConvexArea = polyarea(x,y);

    cx = mean(x);
    cy = mean(y);

    x = x-cx;
    y = y-cy;

    dis = sqrt(x.*x+y.*y);

    idxL = find(x<0); % left two dim

    dimLx = x(idxL);
    dimLy = y(idxL);
    disL  = dis(idxL);

    idxLU = find(dimLy>=0);
    dimLUx = dimLx(idxLU);
    dimLUy = dimLy(idxLU);
    disLU  = disL(idxLU);

    idxLD = find(dimLy<0);
    dimLDx = dimLx(idxLD);
    dimLDy = dimLy(idxLD);
    disLD  = disL(idxLD);

    idxR = find(x>=0); % left two dim

    dimRx = x(idxR);
    dimRy = y(idxR);
    disR  = dis(idxR);

    idxRU = find(dimRy>=0);
    dimRUx = dimRx(idxRU);
    dimRUy = dimRy(idxRU);
    disRU  = disR(idxRU);

    idxRD = find(dimRy<0);
    dimRDx = dimRx(idxRD);
    dimRDy = dimRy(idxRD);
    disRD  = disR(idxRD);

    if display ==1
         figure; 
         plot(x,y); hold on;
         plot(0,0,'*','Color','r'); hold on;
         plot(dimLUx,dimLUy,'.','Color','r'); hold on;
         plot(dimLDx,dimLDy,'.','Color','g'); hold on;
         plot(dimRUx,dimRUy,'.','Color','b'); hold on;
         plot(dimRDx,dimRDy,'.','Color','y'); hold on;
    end

    idxCorLU = find(disLU==max(disLU));
    idxCorLD = find(disLD==max(disLD));

    idxCorRU = find(disRU==max(disRU));
    idxCorRD = find(disRD==max(disRD));

    idxCorLU = idxCorLU(1);
    idxCorLD = idxCorLD(1);

    idxCorRU = idxCorRU(1);
    idxCorRD = idxCorRD(1);


    %polyarea(X,Y)
    polyX = [dimRUx(idxCorRU),dimRDx(idxCorRD),dimLDx(idxCorLD),dimLUx(idxCorLU)];
    polyY = [dimRUy(idxCorRU),dimRDy(idxCorRD),dimLDy(idxCorLD),dimLUy(idxCorLU)];
    polyArea = polyarea(polyX,polyY);
    
    if display ==1
    plot(polyX,polyY,'-o','Color','y','LineWidth',2); hold on;
    end 
    %polyAreaO = polyArea;
    for i=1:length(dimRUx)
        
%         polyX = [dimRUx(idxCorRU),dimRDx(idxCorRD),dimLDx(idxCorLD),dimLUx(idxCorLU)];
%         polyY = [dimRUy(idxCorRU),dimRDy(idxCorRD),dimLDy(idxCorLD),dimLUy(idxCorLU)];
%         polyArea = polyarea(polyX,polyY);

        polyXt = polyX;
        polyYt = polyY;
        
        polyXt(1) = dimRUx(i);
        polyYt(1) = dimRUy(i);
        
        %if length(find((polyX-polyX(1))<10))>=2 ||length(find((polyY-polyY(1))<10))>=2
        if length(find(sqrt((polyX-polyXt(1)).*(polyX-polyXt(1))+(polyY-polyYt(1)).*(polyY-polyYt(1)))<20))>=2
            continue;
        end 
        
        if display ==1
        plot(polyXt(1),polyYt(1),'o','Color','c'); hold on;
        end 
        
        tempArea = polyarea(polyXt,polyYt);
        if tempArea>polyArea
            idxCorRU = i;
            polyArea = tempArea; 
            if display ==1
            plot(polyXt,polyYt,'-o','Color','c'); hold on;
            end 
        end
       
        
    end
    
    
    

    polyX = [dimRUx(idxCorRU),dimRDx(idxCorRD),dimLDx(idxCorLD),dimLUx(idxCorLU)];
    polyY = [dimRUy(idxCorRU),dimRDy(idxCorRD),dimLDy(idxCorLD),dimLUy(idxCorLU)];
    polyArea = polyarea(polyX,polyY);
    if display ==1
    plot(polyX,polyY,'p','Color','r','LineWidth',2); hold on;
    end
    
    for i=1:length(dimRDx)
        
        polyXt = polyX;
        polyYt = polyY;
     
        polyXt(2) = dimRDx(i);
        polyYt(2) = dimRDy(i);
        
        %if length(find((polyX-polyX(2))<10))>=2 ||length(find((polyY-polyY(2))<10))>=2
        if length(find(sqrt((polyX-polyXt(2)).*(polyX-polyXt(2))+(polyY-polyYt(2)).*(polyY-polyYt(2)))<20))>=2
            continue;
        end 
        
        if display ==1        
        plot(polyXt(2),polyYt(2),'o','Color','g'); hold on;
        end 
        
        tempArea = polyarea(polyXt,polyYt);
        if tempArea>polyArea
            idxCorRD = i;
            polyArea = tempArea;
            if display ==1       
            plot(polyXt,polyYt,'-o','Color','g'); hold on;
            end 
        end
                
    end
    

        
    polyX = [dimRUx(idxCorRU),dimRDx(idxCorRD),dimLDx(idxCorLD),dimLUx(idxCorLU)];
    polyY = [dimRUy(idxCorRU),dimRDy(idxCorRD),dimLDy(idxCorLD),dimLUy(idxCorLU)];
    polyArea = polyarea(polyX,polyY); 
    if display ==1
    plot(polyX,polyY,'p','Color','g','LineWidth',2); hold on;
    end 

    for i=1:length(dimLUx)
        
        polyXt = polyX;
        polyYt = polyY;
        
        polyXt(4) = dimLUx(i);
        polyYt(4) = dimLUy(i);
        
        %if length(find((polyX-polyX(3))<10))>=2 ||length(find((polyY-polyY(3))<10))>=2
        if length(find(sqrt((polyX-polyXt(4)).*(polyX-polyXt(4))+(polyY-polyYt(4)).*(polyY-polyYt(4)))<20))>=2
            continue;
        end 
        
        if display ==1
        plot(polyXt(4),polyYt(4),'o','Color','b'); hold on;
        end 
        
        tempArea = polyarea(polyXt,polyYt);
        if tempArea>polyArea
            idxCorLU = i;
            polyArea = tempArea;
            if display ==1
            plot(polyXt,polyYt,'-o','Color','b'); hold on;
            end
        end
        
        
        
    end
    
    
    polyX = [dimRUx(idxCorRU),dimRDx(idxCorRD),dimLDx(idxCorLD),dimLUx(idxCorLU)];
    polyY = [dimRUy(idxCorRU),dimRDy(idxCorRD),dimLDy(idxCorLD),dimLUy(idxCorLU)];
    polyArea = polyarea(polyX,polyY);  
    
    if display ==1   
    plot(polyX,polyY,'p','Color','b','LineWidth',2); hold on;
    end

    for i=1:length(dimLDx)
        
        polyXt = polyX;
        polyYt = polyY;
        
        polyXt(3) = dimLDx(i);
        polyYt(3) = dimLDy(i);
                
        %if length(find((polyX-polyX(4))<10))>=2 ||length(find((polyY-polyY(4))<10))>=2
        if length(find(sqrt((polyX-polyXt(3)).*(polyX-polyXt(3))+(polyY-polyYt(3)).*(polyY-polyYt(3)))<20))>=2
            continue;
        end 
        
        if display ==1          
        plot(polyXt(3),polyYt(3),'o','Color','r'); hold on;
        end 
        
        tempArea = polyarea(polyXt,polyYt);
        if tempArea>polyArea
            idxCorLD = i;
            polyArea = tempArea;
            if display ==1
            plot(polyXt,polyYt,'-o','Color','r'); hold on;
            end
        end
       
    end
    
    %plot(polyX,polyY,'p','Color','y','LineWidth',2); hold on;

    polyX = [dimRUx(idxCorRU),dimRDx(idxCorRD),dimLDx(idxCorLD),dimLUx(idxCorLU)];
    polyY = [dimRUy(idxCorRU),dimRDy(idxCorRD),dimLDy(idxCorLD),dimLUy(idxCorLU)];
    polyArea = polyarea(polyX,polyY);
    
    if display ==1
    plot(polyX,polyY,'p','Color','w','LineWidth',2); hold on;
    end 


    % optimize minimize(ConvexArea-polyArea)  --- ???? corner points
    % areas = [];
    % areas(1) = polyarea(x(2:length(x)),y(2:length(x)));
    % for i=2:length(x)-1
    %     xx = x([1:i-1,i+1:length(x)]);
    %     yy = y([1:i-1,i+1:length(y)]);
    %     areas(i) = polyarea(xx,yy);
    % end
    % areas(length(x)) = polyarea(x(1:length(x)-1),y(1:length(x)-1));
    % areas = abs(areas - ConvexArea);
    % areasX =sort(areas,'descend');

%     if polyAreaO>polyArea
%         idxCorLU = idxCorLU(1);
%         idxCorLD = idxCorLD(1);
% 
%         idxCorRU = idxCorRU(1);
%         idxCorRD = idxCorRD(1);
%     end 
   
    if display ==1
        plot(  dimRUx(idxCorRU),dimRUy(idxCorRU),'p','Color','k'); hold on;
        plot(  dimRDx(idxCorRD),dimRDy(idxCorRD),'p','Color','k'); hold on;
        plot(  dimLUx(idxCorLU),dimLUy(idxCorLU),'p','Color','k'); hold on;
        plot(  dimLDx(idxCorLD),dimLDy(idxCorLD),'p','Color','k'); hold on;
    end


    X = polyX+cx;
    Y = polyY+cy;




    for i=1:length(x)
    end

end

