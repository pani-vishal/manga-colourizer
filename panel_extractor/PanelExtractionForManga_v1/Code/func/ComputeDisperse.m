function [ dislist, disperse] = ComputeDisperse( idxlist )

% A Robust Panel Extraction Method for Manga
% Copyright (c) by Xufang PANG, 2015-12-12
 
    dislist = [];
    number = length(idxlist);
    for i=1:number-1
        dislist = [dislist, idxlist(number+1-i)-idxlist(number-i)];
    end 
    disperse = length(find(dislist>1)); % describe the disperse. 

    fliplr(dislist);
end

