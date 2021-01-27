# A guide to IMC data analysis

This repository collects tools for imaging mass cytometry (IMC) data analysis and groups them by purpose.

## Introduction

Imaging mass cytometry is a highly-multiplexed imaging technology that measures the expression of up to 40 proteins (also refered to as markers) in tissues[^fn1].
Upon acquistion, raw images are converted to .ome.tiff files and processed for downstream analysis.
Processing includes cell segmentation and feature extraction.
The extracted features per marker are later on read into R for single-cell data analysis.
Common analyses steps include quality control and intensity normalization, cell-type identification via clustering or classification and spatial data analysis.
For more information on imaging mass cytometry, please refer to the more extended [Introduction](https://bodenmillergroup.github.io/IMCWorkflow/intro/).

## Pre-processing of IMC data

Explain the key steps for pre-processing IMC data.
For more detailed explanations see [Pre-processing](https://bodenmillergroup.github.io/IMCWorkflow/prepro/).

## Viewers for IMC data

histoCAT, histoCAT++, histoCAT-web (?), napari-imc
For more detailed explanations see [Viewers](https://bodenmillergroup.github.io/IMCWorkflow/viewers/).

## Downstream analysis

IMCDataAnalysis, neighbourhood, cytomapper, imcdatasets
For more detailed explanations see [Viewers](https://bodenmillergroup.github.io/IMCWorkflow/analysis/).

## Contributors

Whoever wants to contribute

## Citation


[^fn1]: Giesen, C. _et al._ 2014. “Highly Multiplexed Imaging of Tumor Tissues with Subcellular Resolution by Mass Cytometry.” Nature Methods 11 (4): 417–22.