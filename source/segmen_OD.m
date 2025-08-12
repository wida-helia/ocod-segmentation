% Segmentasi OD

% Referensi untuk histogram matching
ref = imread("A\training\drishtiGS_068.png");

for a = 17:98
    fileI = openLocImage(a,'training\');
    if isfile(fileI)
        I_Real = imread(fileI);
        I = imhistmatch(I_Real,ref);
        R_I = I(:,:,1);
        im_bw = im2bw(R_I,0.35);
        se = strel('disk',52);
        im_open = imopen(im_bw,se);
        im_open = bwareaopen(im_open,40000);
        im_OD = ellipsfit(im_open);

        output_folder = "ellipsOD\training" ;
        image_code = sprintf('%02d', a);  % Formats i as a two-digit number with leading zeros if necessary
        output_filename = fullfile(output_folder, ['drishtiGS_0' image_code '.png']);

        % Save the cropped image automatically
        imwrite(im_OD, output_filename);

        output_folder = "segmenOD\training" ;
        image_code = sprintf('%02d', a);  % Formats i as a two-digit number with leading zeros if necessary
        output_filename = fullfile(output_folder, ['drishtiGS_0' image_code '.png']);

        % Save the cropped image automatically
        imwrite(im_open, output_filename);

    end
end