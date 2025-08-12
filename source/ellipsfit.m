% melakukan ellips fitting menggunakan Hough Transform
% input gambar biner hasil segmentasi
% output gambar binar hasil ellips fitting

function binaryIm = ellipsfit(I)
        s = regionprops(I, {'Centroid', 'Orientation', 'MajorAxisLength', 'MinorAxisLength'});
        
        % Create a blank binary image of the same size as the original image
        [rows, cols] = size(I);
        binaryIm = false(rows, cols);
        
        for k = 1:length(s)
            theta = linspace(0, 2*pi, 100);
            col = (s(k).MajorAxisLength/2) * cos(theta);
            row = (s(k).MinorAxisLength/2) * sin(theta);
            
            % Create transformation matrix
            M = makehgtform('translate', [s(k).Centroid, 0], 'zrotate', deg2rad(-s(k).Orientation));
            
            % Apply transformation
            D = M * [col; row; zeros(1, numel(row)); ones(1, numel(row))];
            
            % Convert the transformed coordinates to a polygon
            x = D(1, :);
            y = D(2, :);
            
            % Create a mask from the polygon
            mask = poly2mask(x, y, rows, cols);
            
            % Combine the mask with the binary image
            binaryIm = binaryIm | mask;
        end
end