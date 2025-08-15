# Optic Cup (OC) and Optic Disk (OD) Segmentation
OC and OD segmentation using image processing techniques. This project aims to learn and implement image processing for biomedical images.

----------------------------


## Dataset
The dataset contain 30 fundus images with each corresponding OC and OD ground truth, annotated by doctor.

For deploying the image processing techniques, I explored the data, including OC and OD dimensions, histogram, and possibility of false negative or false positive.


## Segmentation
For performing OC and OD segmentation, I perform following steps:
- Localization, adapting projection method [[Paper](https://ieeexplore.ieee.org/document/5484595)]
- Segmentation, performed histogram matching, thresholding, and morphological operations
- Post-processing, using ellipse fitting


## Result
The result can be found in the following folders:
- [Localization](https://github.com/wida-helia/ocod-segmentation/tree/main/result-localization)
- [OD segmentation](https://github.com/wida-helia/ocod-segmentation/tree/main/result-od)
- [OC segmentation](https://github.com/wida-helia/ocod-segmentation/tree/main/result-oc)

We evaluate the result using RoI efficiency for localization and F1-Score for segmentation.
