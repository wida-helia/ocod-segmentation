% menampilkan histogram image dan OD

% array untuk menyimpan threshold
N = 20;
j = 0;
threshR = zeros(1,N);
threshG = zeros(1,N);
threshB = zeros(1,N);

% Loop through the specified range of image numbers
for i = 17:98
    % membuka file gambar
    file_I = openimages(i,'training\');
    file_OD = openBinary(i,'Training',1);
    file_OC = openBinary(i,'Training',2);

    % Check if the file exists
    if isfile(file_I) && isfile(file_OD) && isfile(file_OC)
        j=j+1;
        % Read the image
        I = imread(file_I);
        I_OD = imread(file_OD);
        I_OD = I.*(I_OD/256);
        I_OC = imread(file_OC);
        I_OC = I.*(I_OC/256);

        % Separate the image into R, G, and B channels
        R_I = I(:, :, 1);
        G_I = I(:, :, 2);
        B_I = I(:, :, 3);

        R_IOD = I_OD(:, :, 1);
        G_IOD = I_OD(:, :, 2);
        B_IOD = I_OD(:, :, 3);

        R_IOC = I_OC(:, :, 1);
        G_IOC = I_OC(:, :, 2);
        B_IOC = I_OC(:, :, 3);

         % Calculate the histogram data for each channel
        [countsR, binLocationsR] = imhist(R_I);
        [countsG, binLocationsG] = imhist(G_I);
        [countsB, binLocationsB] = imhist(B_I);

        [countsR_OD, binLocationsR_OD] = imhist(R_IOD);
        countsR_OD(1)=0;
        [countsG_OD, binLocationsG_OD] = imhist(G_IOD);
        countsG_OD(1)=0;
        [countsB_OD, binLocationsB_OD] = imhist(B_IOD);
        countsB_OD(1)=0;

        [countsR_OC, binLocationsR_OC] = imhist(R_IOC);
        countsR_OC(1)=0;
        threshR(j) = findThreshold(countsR_OC);
        [countsG_OC, binLocationsG_OC] = imhist(G_IOC);
        countsG_OC(1)=0;
        threshG(j) = findThreshold(countsG_OC);
        [countsB_OC, binLocationsB_OC] = imhist(B_IOC);
        countsB_OC(1)=0;
        threshB(j) = findThreshold(countsB_OC);

        figure;
        subplot(1,3,1);
        hold on;
        stem(countsR_OD, 'r-', 'Marker','none');
        stem(countsR_OC, 'b-', 'Marker','none');
        hold off;
        xlabel('Level Intensitas');
        ylabel('Counts');
        legend('OD', 'OC');
        title('Red Channel');
        
        subplot(1,3,2);
        hold on;
        stem(countsG_OD, 'r-', 'Marker','none');
        stem(countsG_OC, 'b-', 'Marker','none');
        hold off;
        xlabel('Level Intensitas');
        ylabel('Counts');
        legend('OD', 'OC');
        title('Green Channel');
        
        subplot(1,3,3);
        hold on;
        stem(countsB_OD, 'r-', 'Marker','none');
        stem(countsB_OC, 'b-', 'Marker','none');
        hold off;
        xlabel('Level Intensitas');
        ylabel('Counts');
        legend('OD', 'OC');
        title('Blue Channel');

    end
end

T = table(threshR',threshG',threshB');
filename = 'outputHist.xlsx';
writetable(T, filename);