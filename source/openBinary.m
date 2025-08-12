% membuka images binary
% input kode gambar, mode (training atau testing), jenis (OD atau OC)
% output file gambar binary

function BinaryPath = openBinary(kode, mode, jenis)
    if jenis == 1   % 1 untuk OD
        fileSuffix = '_ODAvgBoundary_OD_img.png';
    end
    if jenis == 2   % 2 untuk OC
        fileSuffix = '_CupAvgBoundary_OC_img.png';
    end
    folderPrefix = 'drishtiGS_';
    basefolder = sprintf('%s%03d', folderPrefix, kode);
    folder = fullfile(mode,basefolder);
    filePrefix = 'drishtiGS_';
    fileName = sprintf('%s%03d%s', filePrefix, kode, fileSuffix);
    BinaryPath = fullfile(folder, fileName);
end