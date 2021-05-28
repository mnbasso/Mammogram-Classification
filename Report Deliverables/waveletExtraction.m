%%
close all
clc 
clear
%% Wavelet Texture Analysi
dcmPath=input('Please enter the path to the dicom files\n', 's');
addpath(dcmPath);

dcmFiles=dir(dcmPath);
dcm_DB={dcmFiles.name};
dcm_DB=dcm_DB(3:end);



tic 
clc

for i = 1:length(dcm_DB)

    I = dicomread([dcmPath, '\',dcm_DB{i}]);
    
    I = histeq(I);
    %Daubechies Haar Classic Wavelet
%     [cA,cH,cV,cD] = dwt2(I,'haar','mode','per');
    
    %Biorthogonal 1.3
    %Idea from http://eitidaten.fh-pforzheim.de/daten/mitarbeiter/greiner/daten/95sptxt.pdf
    %and https://pdfs.semanticscholar.org/0f27/3baa82d0fdeea94271f68583082d10b9227d.pdf
    [cA,cH,cV,cD] = dwt2(I,'bior1.3','mode','per');
    
    [GLCM_features1] = glcm(cH,[0 1; -1 1; -1 0; -1 -1],[],8,false);
    [GLCM_features2] = glcm(cV,[0 1; -1 1; -1 0; -1 -1],[],8,false);
    [GLCM_features3] = glcm(cD,[0 1; -1 1; -1 0; -1 -1],[],8,false);

    GLCMStats(i,1) = GLCM_features1(:,:,1);
    GLCMStats(i,2) = GLCM_features1(:,:,2);
    GLCMStats(i,3) = GLCM_features1(:,:,3);
    GLCMStats(i,4) = GLCM_features1(:,:,4);
    GLCMStats(i,5) = GLCM_features1(:,:,5);

    GLCMStats(i,6) = GLCM_features2(:,:,1);
    GLCMStats(i,7) = GLCM_features2(:,:,2);
    GLCMStats(i,8) = GLCM_features2(:,:,3);
    GLCMStats(i,9) = GLCM_features2(:,:,4);
    GLCMStats(i,10) = GLCM_features2(:,:,5);
    
    GLCMStats(i,11) = GLCM_features3(:,:,1);
    GLCMStats(i,12) = GLCM_features3(:,:,2);
    GLCMStats(i,13) = GLCM_features3(:,:,3);
    GLCMStats(i,14) = GLCM_features3(:,:,4);
    GLCMStats(i,15) = GLCM_features3(:,:,5);

    fprintf('Just finished iteration #%d\n', i);

end

% GLCMStats = zscore(GLCMStats);
toc
varNames = {'FileName', 'cH_Contrast', 'cH_Correlation', 'cH_Energy', 'cH_Entropy', 'cH_Homogeneity', ...
    'cV_Contrast', 'cV_Correlation', 'cV_Energy', 'cV_Entropy', 'cV_Homogeneity', ...
    'cD_Contrast', 'cD_Correlation', 'cD_Energy', 'cD_Entropy', 'cD_Homogeneity'};

featureTable = table (dcm_DB', GLCMStats(:, 1), GLCMStats(:, 2), GLCMStats(:, 3), ...
    GLCMStats(:, 4),GLCMStats(:, 5), GLCMStats(:, 6), GLCMStats(:, 7), ...
    GLCMStats(:, 8), GLCMStats(:, 9), GLCMStats(:, 10), GLCMStats(:, 11), ...
    GLCMStats(:, 12), GLCMStats(:, 13), GLCMStats(:, 14), GLCMStats(:, 15), 'VariableNames',varNames);


writetable(featureTable, 'bio13_train_set.csv');


