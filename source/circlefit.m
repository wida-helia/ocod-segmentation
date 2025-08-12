% fungsi untuk membuat lingkaran berdasarkan input binary image hasil Segmentasi
% input: binary image hasil Segmentasi
% output: image hasil circlefit

function binaryIm = circlefit(I)
 
    labeledImage = bwlabel(I);
    s = regionprops(labeledImage, 'Centroid', 'PixelIdxList');
    
    [rows, cols] = size(I);
    binaryIm = false(rows, cols);
    
    for k = 1:length(s)
        % mencari titik tengah
        centroid = s(k).Centroid;
        
        % mengambil pixel titik tepi
        pixelIdxList = s(k).PixelIdxList;
        [y, x] = ind2sub([rows, cols], pixelIdxList);
        distances = sqrt((x - centroid(1)).^2 + (y - centroid(2)).^2);
        
        % radius = rata-rata jarak
        radius = mean(distances);
        
        % membuat mask
        [x_grid, y_grid] = meshgrid(1:cols, 1:rows);
        mask = sqrt((x_grid - centroid(1)).^2 + (y_grid - centroid(2)).^2) <= radius;
        binaryIm = binaryIm | mask;
    end
end
