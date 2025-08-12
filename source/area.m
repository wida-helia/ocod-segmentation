% menghitung area dan koordinat bounding berdasarkan input binary image

% Membuat array untuk menyimpan informasi yang dibutuhkan
N = 5;
A = zeros(1,N);
x1 = zeros(1,N);
y1 = zeros(1,N);
x2 = zeros(1,N);
y2 = zeros(1,N);
% Variabel untuk iterasi
j = 0;

% i didefinisikan sesuai rentang kode gambar yang digunakan
for i = 17:98
    % Membuka file
    fullFilePath = openBinary(i,'Testing', 2);
    
    % Mengecek file
    if isfile(fullFilePath)
        j = j+1;
        % Membaca gambar
        I = imread(fullFilePath);
        % Menyimpan informasi baris dan kolom yang memiliki nilai 1
        [rows, cols] = find(I);
        % Menghitung luas area
        A(j) = nnz(I);

        % Menyimpan informasi bounding box terkecil
        x1(j) = min(cols);
        y1(j) = min(rows);
        x2(j) = max(cols);
        y2(j) = max(rows);
        
    end
end

% Menyimpan array pada excel untuk direkap dan diolah
T = table(A', x1', y1',x2', y2');
filename = 'outputArea.xlsx';
writetable(T, filename);