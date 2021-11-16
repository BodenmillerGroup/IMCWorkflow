# IMC image processing

The following sections describe the processing of IMC raw data, including file type conversion, image segmentation, feature extraction and data export.
More detailed information can be found in the main strategies for multichannel image processing:

[IMC segmentation pipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline): Raw IMC data pre-processing is performed using the 
[imctools](https://github.com/BodenmillerGroup/imctools) Python package to convert raw `.mcd` files into `.ome.tiff` and `.tiff` files.
After image cropping, an [ilastik](https://www.ilastik.org/) pixel classifier is trained for image classification prior to image segmentation 
using [CellProfiler](https://cellprofiler.org/). Features (e.g. mean pixel intensity) of segmented objects (e.g. cells) are quantified and
exported. 

!!! note
    
    Read more in the [Docs](https://github.com/BodenmillerGroup/ImcSegmentationPipeline/blob/main/scripts/imc_preprocessing.ipynb)

[steinbock](https://github.com/BodenmillerGroup/steinbock): The `steinbock` framework offers tools for multi-channel image processing using the command-line or Python code. 
Supported tasks include IMC data preprocessing, supervised multi-channel image segmentation, object quantification and data export to a variety of file formats. 
It supports functionality similar to those of the IMC Segmentation Pipeline and further allows deep-leaarning enabled image segmentation. 
The framework is available as platform-independent Docker container, ensuring reproducibility and user-friendly installation. 

!!! note

    Read more in the [Docs](https://bodenmillergroup.github.io/steinbock/latest/).

## MCD file type

IMC raw data are safed in the proprietary `.mcd` file type. A single MCD file can hold raw acquisition data for multiple regions of interest, 
optical images providing a slide level overview of the sample ("panoramas"), and detailed metadata about the experiment. 
Besides the MCD viewer (see [Image visualization](viewers.md)), `.mcd` files cannot be read by image analysis software. 

To facilitate IMC data pre-processing, we created [readimc](https://github.com/BodenmillerGroup/readimc) and [imctools](https://github.com/BodenmillerGroup/imctools), open-source
Python packages for extracting the multi-modal (IMC acquisitions, panoramas), multi-region, multi-channel information contained in raw IMC images.
While `imctools` contains functionality specific to the IMC Segmentation Pipeline, the `readimc` package contains reader functions for IMC raw data and should be used for this purpose.

## Image pre-processing 

Starting from IMC raw data and a "panel" file, individual acquisitions are extracted as TIFF and OME-TIFF files. 
The panel contains information of antibodies used in the experiment and the user can specify which channels to keep for downstream analysis.
In case `ilastik` pixel classification-based image segmentation is performed (see next section), random tiles are cropped from images for convenience of pixel labelling.

## Pixel classification

The IMC Segmentation Pipeline supports pixel classification-based image segmentation while `steinbock` supports pixel classification-based and deep learning-based segmentation. 

[Ilastik](https://www.ilastik.org/) is used to train a random forest pixel classifier on these image crop to compute the probaility for each pixel to belong to one of three classes: nucleus, cytoplasm and background.

## Image segmentation

A [CellProfiler](https://cellprofiler.org/) pipeline is used to segment cells based on the generated probability maps.

## Feature extraction

Furthermore, for each cell and each marker, multiple features are extracted. 
These include the mean marker expression, <span style="color: red;">what else is needed?</span>

## Data export
