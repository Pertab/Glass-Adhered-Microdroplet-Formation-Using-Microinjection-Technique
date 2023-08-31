clc
clear 
close all

% Read the image
image = imread('Image-2.bmp'); % Replace with your image file

figure(1)
imshow(image);

% Image to grayscale
gray_image = rgb2gray(image);

level = graythresh(gray_image);
stepsize = 0.15;
sensitvity = stepsize + level; 

% Edge detection to identify droplet boundaries
edges = edge(gray_image, 'canny', sensitvity);

% Morphological operations to enhance droplet boundaries
se = strel('disk', 1);
dilated_edges = imdilate(edges, se);

fill = imfill(dilated_edges, "holes");

% Identify connected components (droplets) in the image
cc = bwconncomp(fill);

stats = regionprops(cc, 'Centroid', 'MajorAxisLength', 'MinorAxisLength');

% Array to store droplet diameters
diameters = zeros(1, cc.NumObjects);

figure(2)
imshow(fill);

% Calculate the diameters from major and minor axis lengths
for i = 1:cc.NumObjects
    major_axis = stats(i).MajorAxisLength;
    minor_axis = stats(i).MinorAxisLength;
    diameter = mean([major_axis, minor_axis]);
    diameters(i) = (diameter/20)*(3.2);
    center = stats(i).Centroid;
    radius = (diameter / 2);
    viscircles(center, radius, 'EdgeColor', 'r');
end

% Display the diameters
disp('Droplet Diameters:');
disp(diameters);
