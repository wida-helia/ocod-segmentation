% fungsi untuk menghitung f-score dan membuat gambar hasil segmentasi
% input: gambar segmentasi dan gambar referensi
% output: TP, FP, FN, f-score, gambar hasil segmentasi

%inisiasi array untuk menyimpan data
N = 20;
fs = zeros(1,N);
TP = zeros(1,N);
FP = zeros(1,N);
FN = zeros(1,N);
j = 0;

for i=17:98
    %1: OD, 2: OC
    refpath = openBinary(i,'training',2);
    %1: elips OD, 2: segmen OD, 3: elips OC, 4: segmen OC
    Ipath = openResultImage(i,'training\',3);
    if isfile(refpath) && isfile(Ipath)
        ref = imread(refpath);
        I = imread(Ipath);
        j=j+1;
        if islogical(I)
            I = uint8(I) * 255;
        end

        % templatematching untuk mendapat overlap gambar dengan referensi
        I = templatematch(I,ref);
        % memastikan gambar berupa bilangan biner
        I = logical(I);
        ref = logical(ref);

        % menghitung f-score
        TP(j) = sum((I == 1) & (ref == 1),"all");
        FP(j) = sum((I == 1) & (ref == 0),"all");
        FN(j) = sum((I == 0) & (ref == 1),"all");
        fs(j) = TP(j)/(TP(j)+FP(j)+FN(j));

        % membuat hasil segmentasi berdasarkan TP, FP, FN, dan TN
        resultImage = zeros([size(I), 3], 'uint8');

        % True Positive: Green
        resultImage(:,:,1) = resultImage(:,:,1) + uint8(I == 1 & ref == 1) * 0;
        resultImage(:,:,2) = resultImage(:,:,2) + uint8(I == 1 & ref == 1) * 255;
        resultImage(:,:,3) = resultImage(:,:,3) + uint8(I == 1 & ref == 1) * 0;

        % False Positive: Yellow
        resultImage(:,:,1) = resultImage(:,:,1) + uint8(I == 1 & ref == 0) * 255;
        resultImage(:,:,2) = resultImage(:,:,2) + uint8(I == 1 & ref == 0) * 255;
        resultImage(:,:,3) = resultImage(:,:,3) + uint8(I == 1 & ref == 0) * 0;

        % False Negative: Red
        resultImage(:,:,1) = resultImage(:,:,1) + uint8(I == 0 & ref == 1) * 255;
        resultImage(:,:,2) = resultImage(:,:,2) + uint8(I == 0 & ref == 1) * 0;
        resultImage(:,:,3) = resultImage(:,:,3) + uint8(I == 0 & ref == 1) * 0;

        % menyimpan hasil segmentasi
        output_folder = "C\testing" ;
        image_code = sprintf('%02d', i);
        output_filename = fullfile(output_folder, ['drishtiGS_0' image_code '_C.png']);
        imwrite(resultImage, output_filename);

    end
end

% menyimpan hasil perhitungan f-score
T = table(TP',FP',FN',fs');
filename = 'outputfs.xlsx';
writetable(T, filename);