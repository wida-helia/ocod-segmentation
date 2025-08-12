function overlay_image = templatematch(I,ref)
    correlation_output = normxcorr2(I, ref);
    [ypeak, xpeak] = find(correlation_output == max(correlation_output(:)));

    % Calculate the offset from the peak to the template location
    yoffSet = ypeak - size(I, 1);
    xoffSet = xpeak - size(I, 2);

    % Create a copy of the main image to overlay the template
    overlay_image = ref;

    % Overlay the template onto the main image
    overlay_image(yoffSet+1:yoffSet+size(I, 1), xoffSet+1:xoffSet+size(I, 2)) = I;
end