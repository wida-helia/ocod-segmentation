% membuka image RGB
% input kode gambar dan mode (training atau testing)
% output file gambar

function RGBPath = openimages(kode,mode)
    basefolder = 'Images\';
    folder = fullfile(basefolder,mode);
    RGBPath = sprintf('%sdrishtiGS_%03d.png', folder, kode);
end