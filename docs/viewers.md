# Viewing IMC data

During [image processing](process.md), IMC raw data is converted into multi-channel TIFF or OME-TIFF files.
These can be visualized using common image viewers including [FIJI](https://imagej.net/software/fiji/) and [QuPath](https://qupath.github.io/).
IMC raw data need specialized image viewers to visualize aquisitions, panoramas and/or segmented objects.

## MCD viewer

The [MCD viewer](https://www.fluidigm.com/products-services/software) distributed by Fluidigm<sup>&reg;</sup> for **Windows only** allows visualization of individual MCD files.
The user can select individual acquisitions (also referred to as regions of interest; ROI) and multiple channels. 

## histoCAT 

The [histoCAT](https://github.com/BodenmillerGroup/histoCAT)[^fn1] software offers interactive visualization of IMC data.
It requires pre-processing of IMC raw data using the IMC Segmentation Pipeline (see [image processing](process)) to generate single-channel TIFF files.
By supplying segmentation masks, `histoCAT` will extract object-specific features and supports clustering, dimensionality reduction and interaction testing.

!!! note ""

    Read more in the [Docs](https://github.com/BodenmillerGroup/histoCAT/releases/download/histoCAT_1.76/histoCATmanual_1.76.pdf) and in the [paper](https://www.nature.com/articles/nmeth.4391).

## histoCAT-web

A web-app implementation of `histoCAT` is provided by [histoCAT-web](https://github.com/BodenmillerGroup/histocat-web). 
Once deployed, `histoCAT-web` supports reading in IMC raw data and offers an extended set of `histoCAT` functionality.

!!! note ""

    Read more in the [Docs](https://bodenmillergroup.github.io/histocat-web/).

## napari-imc

[napari-imc](https://github.com/BodenmillerGroup/napari-imc) is a modular [napari](https://napari.org/) plugin for loading raw IMC data. 
Upon opening MCD files, `napari-imc` displays a graphical user interface for loading panoramas, acquisitions and channels. 
For each loaded panorama and for each combination of loaded acquisition and channel, `napari-imc` creates an image layer. 
In napari, image layers represent single-channel grayscale or color images that can be overlaid in the main panel. 
Importantly, all image layers are spatially aligned. 
Adjusting channel settings will broadcast the chosen values to the settings of all associated image layers.

!!! note ""

    Read more in the [paper](https://www.biorxiv.org/content/10.1101/2021.11.12.468357v1).

[^fn1]: Shapiro D. _et al._ (2017) histoCAT: analysis of cell phenotypes and interactions in multiplex image cytometry data. Nature Methods