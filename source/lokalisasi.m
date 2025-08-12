% lokalisasi gambar
ref = imread("Images\training\drishtiGS_068.png");

for a = 17:98
    fileI = openimages(a,'training\');
    if isfile(fileI)
        % membuka gambar
        I_Real = imread(fileI);
        I = imhistmatch(I_Real,ref);
        R_I = I(:, :, 1);
        R_I = im2bw(R_I,0.65);

        [rows, cols, ~] = size(I);

        % proyeksi untuk sumbu x
        d_x = 500;
        l_x = floor(2* d_x * 15 / 100);
        numSegmentsX = floor(rows / l_x);
        x = zeros(1, numSegmentsX);

        segmentIndex = 1;
        for k = l_x/2:l_x:rows
            % Memastikan index berada pada rentang yang sesuai
            startRow = max(1, floor(k - l_x / 2));
            endRow = min(rows, floor(k + l_x / 2));

            for i = startRow:endRow
                for j = 1:cols
                    if segmentIndex <= numSegmentsX
                        % menjumlahkan intensitas pada setiap segmen
                        x(segmentIndex) = x(segmentIndex) + double(R_I(i, j));
                    end
                end
            end
            segmentIndex = segmentIndex + 1;
        end

        % mencari titik tengah lokalisasi pada sumbu x
        [sortedArray, sorted_Index] = sort(x,'descend');
        % diambil 2 alternatif terbaik
        center_x1 = (sorted_Index(1) - 1) * l_x + l_x / 2; 
        center_x2 = (sorted_Index(2) - 1) * l_x + l_x / 2;

        % proyeksi untuk sumbu y
        d_y = 600;
        l_y = floor(d_y * 15 / 100);

        numSegmentsY = floor(cols / l_y);
        % proyeksi dilakukan dengan pusat sumbu x berada pada titik pusat
        % yang sebelumnya dicari
        y1 = zeros(1, numSegmentsY);
        y2 = zeros(1, numSegmentsY);

        segmentIndex = 1;
        for k = l_y/2:l_y:cols
            % Memastikan index tidak melewati batas yang tidak sesuai
            startCol = max(1, floor(k - l_y / 2));
            endCol = min(cols, floor(k + l_y / 2));
            startRow1 = max(1, floor(center_x1-d_x/2));
            endRow1 = min(rows, floor(center_x1+d_x/2));
            startRow2 = max(1, floor(center_x2-d_x/2));
            endRow2 = min(rows, floor(center_x2+d_x/2));

            for j = startCol:endCol
                for i = startRow1:endRow1
                    if segmentIndex <= numSegmentsY
                        % menjumlahkan index pada segmen
                        y1(segmentIndex) = y1(segmentIndex) + double(R_I(i, j));
                    end
                end
                for i = startRow2:endRow2
                    if segmentIndex <= numSegmentsY
                        y2(segmentIndex) = y2(segmentIndex) + double(R_I(i, j));
                    end
                end
            end
            segmentIndex = segmentIndex + 1;
        end

        % menghitung titik tengah sumbu y
        [val_y1, index_y1] = max(y1);
        center_y1 = (index_y1 - 1) * l_y + l_y / 2;
        [val_y2, index_y2] = max(y2);
        center_y2 = (index_y2 - 1) * l_y + l_y / 2;

        % Bounding box
        x_min = center_x1 - d_x;
        y_min = center_y1 - d_y;

        % tinggi dan lebar menyesuaikan referensi
        boundingbox = [x_min, y_min, 2*d_x, 2*d_y];

        % memotong gambar dan melakukan pengecekan hasil lokalisasi
        I_lok = imcrop(I, boundingbox);
        R_lok = I_lok(:,:,1);
        I_bw = imbinarize(R_lok);
        [isEllipse,eccentricity1]=checkEllipse(I_bw);

        if not(checkEllipse(I_bw))
            x_min = center_x2-d_x;
            y_min = center_y2-d_y;
            boundingbox = [x_min, y_min, 2*d_x, 2*d_y];
            I_lok = imcrop(I, boundingbox);
            R_lok = I_lok(:,:,1);
            I_bw = imbinarize(R_lok);
            [isEllipse,eccentricity2]=checkEllipse(I_bw);
            if (eccentricity2<eccentricity1)
                x_min = center_x1 - d_x;
                y_min = center_y1 - d_y;
                boundingbox = [x_min, y_min, 2*d_x, 2*d_y];
            end
        end

        I_lok = imcrop(I_Real, boundingbox);

        % menyimpan gambar
        output_folder = "A\training\" ;
        image_code = sprintf('%02d', a);
        output_filename = fullfile(output_folder, ['drishtiGS_0' image_code '_A.png']);
        imwrite(I_lok, output_filename);
    end
end


