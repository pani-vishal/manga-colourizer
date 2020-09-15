function [ flag,range ] = IsColBoundary( mask,colidx,neb ) % theck the left and right row together
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

startidx = colidx-neb;
if startidx<1
    startidx = 1;
else
end
endidx = colidx+neb;

if endidx>size(mask,2)
    endidx = size(mask,2);
else
end 

        tempgapmask = mask(:,startidx:endidx);
        [blackX,blackY] = find(tempgapmask==0);
        if length(blackX)<1
            flag = false;
            range = 0;
        else
            if max(blackX)-min(blackX)>0.7*size(mask,1)
                flag = true;                    
            else
                flag = false;
            end
            range = max(blackX)-min(blackX);
        end    

end

