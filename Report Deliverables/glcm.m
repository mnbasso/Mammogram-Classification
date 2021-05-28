function [GLCMStats] = glcm(I,offset,graylim, numlevels,symmetric)

    [glcm,~] = graycomatrix(I, 'Offset',offset, 'GrayLimits', graylim, 'NumLevels',numlevels, 'Symmetric', symmetric);
    glcm_stats = graycoprops2(glcm,'all');
    GLCMStats(:,:,1) = mean(glcm_stats.Contrast);
    GLCMStats(:,:,2) = mean(glcm_stats.Correlation);
    GLCMStats(:,:,3) = mean(glcm_stats.Energy);
    GLCMStats(:,:,4) = mean(glcm_stats.Entropy);
    GLCMStats(:,:,5) = mean(glcm_stats.Homogeneity);
end