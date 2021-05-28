%%
close all
clc 
clear
%% Gabor Texture Analysis
dcmPath=input('Please enter the path to the dicom files\n', 's');
addpath(dcmPath);

dcmFiles=dir(dcmPath);
dcm_DB={dcmFiles.name};
dcm_DB=dcm_DB(3:end);

%Filter design from http://www.cartesia.org/geodoc/isprs2004/comm4/papers/508.pdf
wavelength = [1/0.1768, 1/0.3536, 1/0.0884];
orientations = [0, 30, 60, 90, 120, 150];
gaborbank = gabor(wavelength, orientations);
tic 
clc

for i = 1:length(dcm_DB)

    I = dicomread([dcmPath, '\',dcm_DB{i}]);
    
    I_eq = histeq(I);

    [mag, ~] = imgaborfilt(I_eq, gaborbank);
    sliceG = zeros(size(mag,1), size(mag,2));
    for n = 1:size(mag, 3)
        sliceG = mag(:,:,n) + sliceG;
    end
    sliceG = sliceG / size(mag, 3);
    [GLCM_features] = glcm(sliceG,[0 1; -1 1; -1 0; -1 -1],[],8,false);
    GLCMStats(i,1) = GLCM_features(:,:,1);
    GLCMStats(i,2) = GLCM_features(:,:,2);
    GLCMStats(i,3) = GLCM_features(:,:,3);
    GLCMStats(i,4) = GLCM_features(:,:,4);
    GLCMStats(i,5) = GLCM_features(:,:,5);
    fprintf('Just finished iteration #%d\n', i);
end
toc
varNames = {'FileName', 'Contrast', 'Correlation', 'Energy', 'Entropy', 'Homogeneity'};

featureTable = table (dcm_DB', GLCMStats(:, 1), GLCMStats(:, 2), GLCMStats(:, 3), ...
    GLCMStats(:, 4),GLCMStats(:, 5), 'VariableNames',varNames);


writetable(featureTable, 'gaborFeatures_test_set.csv');
    