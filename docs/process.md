# IMC image processing

The following sections describe the processing of raw IMC data, which includes file type conversion, image segmentation, feature extraction and data export.
More detailed information can be found in the main strategies for multichannel image processing:

[IMC segmentation pipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline): Raw IMC data pre-processing is performed Read more in the [Docs](https://github.com/BodenmillerGroup/ImcSegmentationPipeline/blob/main/scripts/imc_preprocessing.ipynb)

[steinbock](https://github.com/BodenmillerGroup/steinbock): Read more in the [Docs](https://bodenmillergroup.github.io/steinbock/latest/).

## MCD file type

imctools

readimc

## Image pre-processing 

Either explain the steps of the segmentation pipeline here or build a better documentation for the actual repository (preferred).

Link to other pipelines

[Ilastik](https://www.ilastik.org/) is used to train a random forest pixel classifier on these images to compute the probaility for each pixel to belong to one of three classes: nucleus, cytoplasm and background.
A [CellProfiler](https://cellprofiler.org/) pipeline is used to segment cells based on the generated probability maps.
Furthermore, for each cell and each marker, multiple features are extracted. 
These include the mean marker expression, <span style="color: red;">what else is needed?</span>
Finally, the measured features and segmentation masks are saved,

## Image segmentation

## Feature extraction

## Data export

## Spillover correction (optional)
