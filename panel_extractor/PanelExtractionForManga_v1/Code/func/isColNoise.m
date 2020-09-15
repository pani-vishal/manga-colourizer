function [noiseFlag] = isColNoise(mask,colIdxList,number,range,solidity,disperse)
% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12

noiseFlag = false;
% choose its neighbor region and compute, if it connected to a noise area is noise % can be sure it is the middle fake gap, the first and last are not in this computation 

if disperse>5 
    noiseFlag = true;
end 

end

