% menampilkan histogram image dan OD

% array untuk menyimpan threshold
N = 20;
j = 0;
threshR = zeros(1,N);
threshG = zeros(1,N);
threshB = zeros(1,N);

% i didefinisikan sesuai rentang kode gambar yang digunakan
for i = 17:98
    % membuka file gambar
    file_I = openimages(i,'training\');
    file_OD = openBinary(i,'Training',1);

    % cek apakah terdapat file yang dimaksud
    if isfile(file_I) && isfile(file_OD)
        j = j+1;
        % membuka image
        I = imread(file_I);
        I_OD = imread(file_OD);
        % memotong gambar OD menggunakan gambar binary
        I_OD = I.*(I_OD/256);

        % mengambil informasi masing-masing channel
        R_I = I(:, :, 1);
        G_I = I(:, :, 2);
        B_I = I(:, :, 3);

        R_IOD = I_OD(:, :, 1);
        G_IOD = I_OD(:, :, 2);
        B_IOD = I_OD(:, :, 3);

        % menghitung histogram
        [countsR, binLocationsR] = imhist(R_I);
        [countsG, binLocationsG] = imhist(G_I);
        [countsB, binLocationsB] = imhist(B_I);

        % histogram OD saat intensitas 0 diabaikan
        [countsR_OD, binLocationsR_OD] = imhist(R_IOD);
        countsR_OD(1)=0;
        threshR(j) = findThreshold(countsR_OD);
        [countsG_OD, binLocationsG_OD] = imhist(G_IOD);
        countsG_OD(1)=0;
        threshG(j) = findThreshold(countsG_OD);
        [countsB_OD, binLocationsB_OD] = imhist(B_IOD);
        countsB_OD(1)=0;
        threshB(j) = findThreshold(countsB_OD);

        % plot histogram
        figure;

        % channel merah
        subplot(1,3,1);
        hold on;
        stem(countsR, 'r-', 'Marker','none');
        stem(countsR_OD, 'b-', 'Marker','none');
        hold off;
        xlabel('Level Intensitas');
        ylabel('Counts');
        legend('Images', 'OD');
        title('Red Channel');
        
        % channel hijau
        subplot(1,3,2);
        hold on;
        stem(countsG, 'r-', 'Marker','none');
        stem(countsG_OD, 'b-', 'Marker','none');
        hold off;
        xlabel('Level Intensitas');
        ylabel('Counts');
        legend('Images', 'OD');
        title('Green Channel');
        
        % channel biru
        subplot(1,3,3);
        hold on;
        stem(countsB, 'r-', 'Marker','none');
        stem(countsB_OD, 'b-', 'Marker','none');
        hold off;
        xlabel('Level Intensitas');
        ylabel('Counts');
        legend('Images', 'OD');
        title('Blue Channel');
    end
end

T = table(threshR',threshG',threshB');
filename = 'outputHist.xlsx';
writetable(T, filename);