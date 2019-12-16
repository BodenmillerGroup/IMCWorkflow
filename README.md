# IMCWorkflow

This repository contains scripts to perform analysis of imaging mass cytometry (IMC) data.
The analysis is largely based on [Bioconductor](https://bioconductor.org/) packages to allow reproducible data analysis.
In detail, the main packages include [scater](https://bioconductor.org/packages/release/bioc/html/scater.html) to perform low-level analysis and [SingleCellExperiment](https://www.bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) as data container.

__TODO: Write Abstract__

Overview on folder structure:

* __analysis:__ .Rmd and .md files that contain the code of the workflow
* __code:__ additional scripts to generate example data
* __data:__ raw `cpout`-like files
* __docs:__ .html files corresponding to the .Rmd files in the analysis folder, and .png files that contain the figures
* __output:__ contains the processed `SingleCellExperiment` object
