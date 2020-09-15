    close all;
clear all;
% echo off;
flagScreenOutput = 0;

D = '~/Work/projects/manga-colourizer-try-2/data/ds_debug';

S = dir(fullfile(D,'*'));
N = setdiff({S([S.isdir]).name},{'.','..'}); % list of subfolders of D.


PagePanels = {};
for ii = 1:numel(N)
    T = dir(fullfile(D,N{ii},'*')); % improve by specifying the file extension.
    C = {T(~[T.isdir]).name}; % files in subfolder.
    fileroot = fullfile(D, N{ii}, 'csv');
    mkdir(fileroot);
    for jj = 1:numel(C)
        F = fullfile(D,N{ii},C{jj});
        img = imread(F);
        % If first pixel black then it must be a flashback
        disp(img(1,1,:))
        red = img(10, 10, 1) < 20;
        green = img(10, 10, 2) < 20;
        blue = img(10, 10, 3) < 20;
        if red && green && blue
            img(:,:,:)=255-img(:,:,:);
        end
        panels={};
        mask = GenerateBinary(img,jj);

        %-------------- remove small object
        [ mask ] = RemoveSmallObjects( mask ); % remove the page number, etc.
        [ mask ] = OptimizePanelMask( mask, 0 );

        %------------------------------ dilate and erode -------
        mask = eroson_dilate( mask );

        %     %---------------------------- mask ----------------------
        try
            [ panelmask,panels ] = MaskToPanel(mask,img,jj);
        catch
            continue
        end
        try
            table = struct2table(vertcat(panels{:}));
        catch
            continue
        end
        filename = erase(C{jj}, ".png") + ".csv";
        filepath = fullfile(D, N{ii}, 'csv', filename);
        writetable(table, filepath);
    end
end