% path to read files
dcmPath=input('Enter path to dicom files\n', 's');
outputPath=input('Enter path to save files\n', 's');
addpath(dcmPath);
addpath(outputPath);
% folders containing files
dcm_files = dir(dcmPath);
database={dcm_files.name};
database(1:2)=[];
% nii_csv=readtable('nacc_list.xlsx');
% folder_names=table2array(nii_csv(:,2));
% flair_list=table2array(nii_csv(:,4));
% mri_num=table2array(nii_csv(:,1));
% nacc_id=table2array(nii_csv(:,3));
num=0;
for i=1:length(database)
    addpath(genpath([dcmPath,'\', database{i}]));
    current_dir=dir([dcmPath,'\', database{i}, '\**\*.dcm']);
    current_db={current_dir.name};
%     current_db(1:2)=[];
    for j=1:length(current_db)
        hdr=dicominfo(current_db{j});
        im=dicomread(current_db{j});
        if hdr.SeriesDescription == "ROI mask images"
            disp('Mask Image, saving file.');
            fileName=hdr.PatientID;
            file_name=([outputPath, '\Masks\', fileName, '.dcm']);
            dicomwrite(im, file_name);
        elseif hdr.SeriesDescription == "cropped images"
            disp('ROI Image, saving file.');
            fileName=hdr.PatientID;
            file_name=([outputPath, '\Images\', fileName, '.dcm']);
            dicomwrite(im, file_name);
        else 
            disp('Not sure, saving file.');
            fileName=hdr.PatientID;
            file_name=([outputPath, '\Unknown\', fileName, '.dcm']);
            dicomwrite(im, file_name);
        end
    end
end
