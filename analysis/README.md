# Abstract

__TODO:__ Explain the technology and outline the critical steps in data analysis

# Introduction

__TODO:__ Introduction to IMC and current ways of analysing the data.
Here, we want to highlight the challenges in image processing and IMC data analysis.
We should build the link to the CyTOF workflow of the Robinson lab and Giotto as package to analyse spatial transcriptomics data.
Also mention how IMC data is different to CyTOF data and different from spatial transcriptomics data.

# IMC data pre-processing

Describe the necessary steps in the IMC segementation pipeline.
We definitely need a good documentation of the IMC segmentation pipeline.

# Outline

__TODO:__ Overview on workflow
Make sure to correctly link the section when the article is compiled.

# Methods

__TODO:__ Describe the packages used in the workflow.
These are primarily:

1. `r Biocpkg("SingleCellExperiment")`
2. `r Biocpkg("scater")`
3. imcRtools
4. ...

# Operation

__TODO:__ Here, we need to explain the requirments for:

1. R version used (`r R.version.string`)
2. Bioconductor version used (`r BiocManager::version()`)
3. The different package versions (e.g. `r packageVersion("scater")`)

# Data description

__TODO:__ Here, we describe the data displayed in the workflow
Ideally, we agreed on some "gold standard" dataset to be used.


