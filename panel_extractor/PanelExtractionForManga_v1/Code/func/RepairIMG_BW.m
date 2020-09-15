function [BW,rowflagS,rowflagE,colflagS,colflagE,repairsize] = RepairIMG_BW(BW)
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

% BW: boundary == 0: content == 1;


rowflagS = false;
rowflagE = false;
colflagS = false;
colflagE = false;

repairsize = 5;

colBlack = sum(BW,1);
rowBlack = sum(BW,2);

colLine = ones(size(BW,1),repairsize);
%figure; imshow(colLine);

rowLine = ones(repairsize,size(BW,2));
%figure; imshow(rowLine);

for i=1:100
    rowidx = i;
    neb = 2;
    [ flag,range ] = IsRowBoundary( BW,rowidx,neb )
    if flag == true
        boundmask = BW(rowidx,:);
        [dislist, disperse] = ComputeDisperse( boundmask );
        if length(find(dislist>0))>10
            rowflagS = true;
            BW(1:repairsize,1:size(BW,2)) = rowLine;
            break;
            
        end 
    end 
end 


for i = (size(BW,1)-100):size(BW,1)
    rowidx = i;
    neb = 2;
    [ flag,range ] = IsRowBoundary( BW,rowidx,neb )
    if flag == true
        boundmask = BW(rowidx,:);
        [dislist, disperse] = ComputeDisperse( boundmask );
        if length(find(dislist>0))>10
            rowflagE = true;
            BW(size(BW,1)-repairsize+1:size(BW,1),1:size(BW,2)) = rowLine;
            break;
            
        end 
    end 
end 


for i=1:100
    colidx = i;
    neb = 2;
    [ flag,range ] = IsColBoundary( BW,colidx,neb )
    if flag == true
        boundmask = BW(:,colidx);
        [dislist, disperse] = ComputeDisperse( boundmask );
        if length(find(dislist>0))>10 
            colflagS = true;
            BW(1:size(BW,1),1:repairsize) = colLine;
            break;
           
        end 
    end 
end 


for i=(size(BW,2)-100):size(BW,2)
    colidx = i;
    neb = 2;
    [ flag,range ] = IsColBoundary( BW,colidx,neb )
    if flag == true
        boundmask = BW(:,colidx);
        [dislist, disperse] = ComputeDisperse( boundmask );
        if length(find(dislist>0))>10
            colflagE = true;
            BW(1:size(BW,1),size(BW,2)-repairsize+1:size(BW,2)) = colLine;
            break;
            
        end 
    end 
end 

%----------------method2---------------------
% if max(rowBlack(1:100))<0.7*size(BW,2)
%     BW(1:repairsize,1:size(BW,2)) = rowLine;
%     rowflagS = true;
% end 
% 
% if max(rowBlack((size(BW,1)-100):size(BW,1)))<0.7*size(BW,2)
%     BW(size(BW,1)-repairsize+1:size(BW,1),1:size(BW,2)) = rowLine;
%     rowflagE = true;
% end 
% 
% if max(colBlack(1:100))<0.6*size(BW,1)
%     BW(1:size(BW,1),1:repairsize) = colLine;
%     colflagS = true;
% end 
% 
% if max(colBlack((size(BW,2)-100):size(BW,2)))<0.7*size(BW,1)
%     BW(1:size(BW,1),size(BW,2)-repairsize+1:size(BW,2)) = colLine;
%     colflagE = true;
% end 

BW(1:repairsize,1:repairsize) = 0;
BW(size(BW,1)-repairsize+1:size(BW,1),size(BW,2)-repairsize+1:size(BW,2)) = 0;
BW(1:repairsize,size(BW,2)-repairsize+1:size(BW,2)) = 0;
BW(size(BW,1)-repairsize+1:size(BW,1),1:repairsize) = 0;





% template = [0,0,0,0,1,1,1,1];
% 
% if length(find(BW(1,:)==0))<size(BW,2) % row1
%     Temp = repmat(template,1,size(BW,1)/5);
%     BW(2,:) = Temp(1:size(BW,2));
% end 
% 
% if length(find(BW(size(BW,1),:)==0))<size(BW,2) % row-last
%     Temp = repmat(template,1,size(BW,1)/5);
%     BW(size(BW,1)-1,:) = Temp(1:size(BW,2));
% end 
% 
% template = [0,0,0,0,1,1,1,1]';
% 
% if length(find(BW(:,1)==0))<size(BW,1) % row1
%     Temp = repmat(template,size(BW,1)/5,1);
%     BW(:,2) = Temp(1:size(BW,1));
% end 
% 
% if length(find(BW(:,size(BW,2))==0))<size(BW,1) % row-last
%     Temp = repmat(template,size(BW,1)/5,1);
%     BW(:,size(BW,2)-1) = Temp(1:size(BW,1));
% end 

end

