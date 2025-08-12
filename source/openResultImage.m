function ResultImagePath = openResultImage(kode,mode,tipe)
    if tipe == 1
        basefolder = 'ellipsOD';
    elseif tipe == 2
        basefolder = 'segmenOD';
    elseif tipe == 3
        basefolder = 'ellipsOC';
    elseif tipe == 4
        basefolder = 'segmenOC';
    end
    folder = fullfile(basefolder,mode);
    ResultImagePath = sprintf('%sdrishtiGS_%03d.png', folder, kode);
end