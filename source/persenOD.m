% menghitung %OD

% Membuat array untuk menyimpan informasi yang dibutuhkan
N = 30;
OD = zeros(1,N);
A = zeros(1,N);
% Variabel untuk iterasi
j = 0;

% i didefinisikan sesuai rentang kode gambar yang digunakan
for i = 17:98
    % Membuka file
    fullFilePath = openResultImage(i,'testing\', 1);
    
    % Mengecek file
    if isfile(fullFilePath)
        j = j+1;
        % Membaca gambar
        I = imread(fullFilePath);
        % Menyimpan informasi baris dan kolom yang memiliki nilai 1
        [rows, cols] = size(I);
        % Menghitung luas area
        OD(j) = nnz(I);
        A(j) = rows*cols;

    end
end

% Menyimpan array pada excel untuk direkap dan diolah
T = table(OD', A');
filename = 'outputArea.xlsx';
writetable(T, filename);