# A guide to IMC data analysis

This repository collects tools for imaging mass cytometry (IMC) data analysis and groups them by purpose.

## Introduction

Imaging mass cytometry is a highly-multiplexed imaging technology that measures the expression of up to 40 proteins (also refered to as markers) in tissues[^fn1].
For more information on imaging mass cytometry, please refer to the more extended [Introduction](intro.md).

## Pre-processing of IMC data

Upon image acquisition, raw data are stored in the `.mcd` format [<span style="color: red;">REF</span>], which contain chanel-specific metadata, one or multiple multi-channel images (one per acquisition) and the generated panoramas (see [Introduction](intro.md)).
The first step of the pre-processing pipeline includes the conversion of images from `.mcd` to `.ome.tiff` and `.tiff` format.
These formats are easier to read in using software such as ImageJ.
[Ilastik](https://www.ilastik.org/) is used to train a random forest pixel classifier on these images to compute the probaility for each pixel to belong to one of three classes: nucleus, cytoplasm and background.
A [CellProfiler](https://cellprofiler.org/) pipeline is used to segment cells based on the generated probability maps.
Furthermore, for each cell and each marker, multiple features are extracted. 
These include the mean marker expression, <span style="color: red;">what else is needed?</span>
Finally, the measured features and segmentation masks are saved,

For more details see [Pre-processing](prepro.md).

## Viewers for IMC data

Raw `.mcd` files can be interactively visualized using the [MCD Viewer](https://www.fluidigm.com/software) software distributed by Fluidigm<sup>&reg;<\sup>.

To further perform data analysis based on the images, the [histoCAT](https://bodenmillergroup.github.io/histoCAT/) toolbox supports interactive image and data visualization, clustering and spatial data analysis.

Alternatively, the [napari-imc](https://github.com/BodenmillerGroup/napari-imc) plugin for the [napari](https://napari.org/) software allows reading in raw `.mcd` files for image visualization.

The full features of the viewers can be seen at [Viewers](viewers.md).

## Downstream analysis

The single-cell features extracted by the pre-processing pipeline can be read in using the statistical software `R`.
For convenience, the [SingleCellExperiment](https://bioconductor.org/packages/devel/bioc/html/SingleCellExperiment.html) object is used as a data container, which provides a rich environment for single-cell data analysis (see further documentation [here](https://bioconductor.org/books/release/OSCA/)) 
Common analyses steps include image- and cell-level quality control, cell-type identification via clustering or classification and spatial data analysis.
To get an overview on common analysis steps, please refer to [Analysis](analysis.md).

## Contributors

Nils Eling [:fontawesome-fa-github:](https://github.com/nilseling) [:fontawesome-fa-twitter:](https://twitter.com/NilsEling) [:fontawesome-fa-home:](https://nilseling.github.io/) :fontawesome-fa-github: :fontawesome-github:

Whoever wants to contribute

## Citation

To come...

[^fn1]: Giesen, C. _et al._ 2014. “Highly Multiplexed Imaging of Tumor Tissues with Subcellular Resolution by Mass Cytometry.” Nature Methods 11 (4): 417–22.