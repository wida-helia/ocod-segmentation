function LocImagePath = openLocImage(kode,mode)
    basefolder = 'A\';
    folder = fullfile(basefolder,mode);
    LocImagePath = sprintf('%sdrishtiGS_%03d.png', folder, kode);
end