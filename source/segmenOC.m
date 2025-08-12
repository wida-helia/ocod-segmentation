ref = imread("A\Training\drishtiGS_063_A.png");

for a = 17:98
    fileI = openLocImage(a,'testing\');
    if isfile(fileI)
        I_Real = imread(fileI);
        I = imhistmatch(I_Real,ref);
        G_I = I(:,:,2);
        
        im_bw = im2bw(G_I,0.6);
        se = strel('disk',10);
        im_open = imopen(im_bw,se);
        se = strel('disk',100);
        im_close = imclose(im_open,se);
        im_open = bwareaopen(im_close,15000);

        im_final = im_open;
        im_OC = ellipsfit(im_final);

        output_folder = "ellipsOC\testing" ;
        image_code = sprintf('%02d', a);
        output_filename = fullfile(output_folder, ['drishtiGS_0' image_code '.png']);
        imwrite(im_OC, output_filename);

        output_folder = "segmenOC\testing" ;
        image_code = sprintf('%02d', a); 
        output_filename = fullfile(output_folder, ['drishtiGS_0' image_code '.png']);
        imwrite(im_final, output_filename);
    end
end