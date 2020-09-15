function [ flag,range ] = IsRowBoundary( mask,rowidx,neb ) % theck the left and right row together
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

startidx = rowidx-neb;
if startidx<1
    startidx = 1;
else
end
endidx = rowidx+neb;

if endidx>size(mask,1)
    endidx = size(mask,1);
else
end 

            tempgapmask = mask(startidx:endidx,:);
            [blackX,blackY] = find(tempgapmask==0);
            if length(blackY)<1
                flag = false;
                range = 0;
            else
                if max(blackY)-min(blackY)>0.7*size(mask,2)
                    flag = true;
                else
                    flag = false;
                end
                range = max(blackY)-min(blackY);
            end    

end

