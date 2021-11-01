# IMC data analysis tools

This repository contains an overview of available tools to use for imaging mass cytometry (IMC) data analysis.

## Image processing

Common tasks for IMC data analysis first include image pre-processing, segmentation, feature extraction and data export.
The initial [IMCSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline) was developed to allow
manual image processing for IMC and other multiplexed imaging data.

Building up on the `IMCSegmentationPipeline`, the [steinbock](https://github.com/BodenmillerGroup/steinbock) framework offers user-friendly processing of multi-channel images and supports different segmentation strategies.

### IMC Segmentation pipeline

The [ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline) uses the [imctools](https://github.com/BodenmillerGroup/imctools) python package to handle IMC data. Custom [CellProfiler plugins](https://github.com/BodenmillerGroup/ImcPluginsCP) support multi-channel image analysis within [CellProfiler](https://cellprofiler.org/). 
In addition, [Ilastik](https://www.ilastik.org/) is needed to perform pixel classification. 

[ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline)  
[ImcSegmentationPipeline Docs](https://github.com/BodenmillerGroup/ImcSegmentationPipeline/blob/main/scripts/imc_preprocessing.ipynb) 

[imctools](https://github.com/BodenmillerGroup/imctools)  
[imctools Docs](https://bodenmillergroup.github.io/imctools/)

[ImcPluginsCP](https://github.com/BodenmillerGroup/ImcPluginsCP)    
[ImcPluginsCP Docs](https://github.com/BodenmillerGroup/ImcPluginsCP/blob/master/README.rst) 

[CellProfiler](https://cellprofiler.org/)  
[CellProfiler Docs](https://cellprofiler-manual.s3.amazonaws.com/CellProfiler-4.0.7/index.html)

### steinbock

The [steinbock](https://github.com/BodenmillerGroup/steinbock) framework uses the [readimc](https://github.com/BodenmillerGroup/readimc) python package for IMC-specific pre-processing. Image processing can be performed via a command line interface.

[steinbock](https://github.com/BodenmillerGroup/steinbock)  
[steinbock Docs](https://bodenmillergroup.github.io/steinbock/latest/)

[readimc](https://github.com/BodenmillerGroup/readimc)  
[readimc Docs](https://bodenmillergroup.github.io/readimc/)
 
## Viewers for IMC data

The raw IMC data files in `MCD` format can be read in and visualized using the [MCD viewer](https://www.fluidigm.com/software) (only supported on Windows).

A [napari](https://napari.org/) plugin is now available to read in raw IMC data files and visualize them in a shared coordinate system:

[napari-imc](https://github.com/BodenmillerGroup/napari-imc)

[napari](https://napari.org/)  
[napari Docs](https://napari.org/tutorials/index.html)

After processing using the `ImcSegmentationPipeline` or `steinbock`, raw MCD files are converted into single-channel TIFF files which can be read in and visualized using [histoCAT](https://github.com/BodenmillerGroup/histoCAT). `histoCAT` also allows single-cell and spatial data analysis.

[histoCAT](https://github.com/BodenmillerGroup/histoCAT)  
[histoCAT Docs](https://bodenmillergroup.github.io/histoCAT/)  
[histoCAT: analysis of cell phenotypes and interactions in multiplex image cytometry data](https://www.nature.com/articles/nmeth.4391.pdf?origin=ppub)

A web-application of `histoCAT` is available at:

[histoCAT-web](https://github.com/BodenmillerGroup/histocat-web)  
[histoCAT-web Docs](https://bodenmillergroup.github.io/histocat-web/)

## Downstream analysis

After pre-processing and feature extraction, single-cell expression data can be read into R and analysed using standardized approaches.
An overview on how to analyse single-cell data generated by multiplexed imaging can be seen here:

[IMC data analysis](https://bodenmillergroup.github.io/IMCDataAnalysis/)

### Reading in data

The [imcRtools](https://github.com/BodenmillerGroup/imcRtools) package allows reading in spatially annotated single-cell data extracted from IMC raw data using the `ImcSegmentationPipeline` or `steinbock`. In R, single-cell data are stored in either a [SpatialExperiment](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html) or [SingleCellExperiment](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) object.

[imcRtools](https://github.com/BodenmillerGroup/imcRtools)  
[imcRtools Docs](https://bodenmillergroup.github.io/imcRtools/)

[SpatialExperiment](https://bioconductor.org/packages/release/bioc/html/SpatialExperiment.html)  
[SpatialExperiment Docs](https://bioconductor.org/packages/release/bioc/vignettes/SpatialExperiment/inst/doc/SpatialExperiment.html)

[SingleCellExperiment](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html)  
[SingleCellExperiment Docs](https://bioconductor.org/packages/release/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html)

### Single-cell analysis

Within the [Bioconductor](https://www.bioconductor.org/) project, a number of single-cell analysis tools have been developed. 
The [Orchestrating Single-Cell Analysis with Bioconductor](https://bioconductor.org/books/release/OSCA/) book offers an overview on common analysis strategies. Here, we name a number of individual packages for different tasks.

[scran](https://bioconductor.org/packages/release/bioc/html/scran.html) for graph-based clustering

[scater](https://bioconductor.org/packages/release/bioc/html/scater.html) for dimensionality reduction and data visualization

[dittoSeq](https://bioconductor.org/packages/release/bioc/html/dittoSeq.html) for data visualziation

[CATALYST](https://bioconductor.org/packages/release/bioc/html/CATALYST.html) for clustering, data visualization and differential analysis

### Spatial analysis

The [imcRtools](https://github.com/BodenmillerGroup/imcRtools) package offers a number of functions to perform spatial analysis of cells extracted from multi-channel images.

[imcRtools](https://github.com/BodenmillerGroup/imcRtools)  
[imcRtools Docs](https://bodenmillergroup.github.io/imcRtools/)

### Image visualization

In R, the [cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html) package allows pixel- and cell-level visualization of multiplexed imaging data.

[cytomapper](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html)  
[cytomapper Docs](https://bodenmillergroup.github.io/cytomapper/)  
[cytomapper: an R/Bioconductor package for visualization of highly multiplexed imaging data](https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/btaa1061/6050702)

### Example datasets 

To access example IMC datasets, we have build the [imcdatasets](https://www.bioconductor.org/packages/devel/data/experiment/html/imcdatasets.html) Bioconductor package.

[imcdatasets](https://www.bioconductor.org/packages/devel/data/experiment/html/imcdatasets.html)   
[imcdatasets Docs](https://bodenmillergroup.github.io/imcdatasets/)   
