% cek apakah bentuk merupakan ellipse atau bukan
% input: citra biner
% output: boolean menyatakan elips atau bukan serta eccentricity

function [isEllipse,eccentricity] = checkEllipse(binaryImage)
    
    labeledImage = bwlabel(binaryImage);
    stats = regionprops(labeledImage, 'Eccentricity', 'MajorAxisLength', 'MinorAxisLength');
    
    if isempty(stats)
        isEllipse = false;
        return;
    end
    
    % ellipse diambil dari objek paling besar
    [~, largestIdx] = max([stats.MajorAxisLength]);
    largestObject = stats(largestIdx);
    eccentricity = largestObject.Eccentricity;
    aspectRatio = largestObject.MinorAxisLength / largestObject.MajorAxisLength;
    
    % threshold untuk menentukan bentuk
    eccentricityThreshold = 0.5; % Example threshold for eccentricity
    aspectRatioThreshold = 0.7;  % Example threshold for aspect ratio

    isEllipse = (eccentricity > eccentricityThreshold) && (aspectRatio > aspectRatioThreshold);
end
