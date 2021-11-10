# Pre-processing IMC data

## Segmentation pipeline

Either explain the steps of the segmentation pipeline here or build a better documentation for the actual repository (preferred).

Link to other pipelines

[Ilastik](https://www.ilastik.org/) is used to train a random forest pixel classifier on these images to compute the probaility for each pixel to belong to one of three classes: nucleus, cytoplasm and background.
A [CellProfiler](https://cellprofiler.org/) pipeline is used to segment cells based on the generated probability maps.
Furthermore, for each cell and each marker, multiple features are extracted. 
These include the mean marker expression, <span style="color: red;">what else is needed?</span>
Finally, the measured features and segmentation masks are saved,

### MCD file type

### Spillover correction (optional)

## Alternative approaches

### imctoolkit
