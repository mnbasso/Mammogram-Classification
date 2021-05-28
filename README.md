# Mammogram Classification Using Texture Features and Multi-Layer Perceptron

This research was done to investigate the best texture feature extraction method to classify mammogram images as malignant or benign.

## Installation

Use the package manager [pip](https://pip.pypa.io/en/stable/) to install all the required packages from the requirments.txt file.

```bash
pip install -r requirements.txt
```
MATLAB scripts are used for feature extraction and are found in the submission folder.  It can be downloaded [here](https://www.mathworks.com/downloads/).

## Data

The data is open-access and can be downloaded from the CBIS-DDSM [site](https://wiki.cancerimagingarchive.net/display/Public/CBIS-DDSM).

To access the data, install the corresponding NBIA data retriever.  The .exe installer can be found in the submission folder. 

## Usage
Run the MATLAB scritps to extract features on local data.

Post .csv feature vectors to Google Drive.

Use mammoClassification.ipynb in Google Colab. Paths to the feature vectors will need to be changed to your own Google Drive paths.

## Authors and Acknowledgment 
Project by Adam Gibicar and Matthew Basso.  Thanks to Dr. Neil Bruce for a great semester.

