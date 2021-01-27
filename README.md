# IMCWorkflow

This repository contains an overview of available tools to use for imaging mass cytometry data analysis.

## Related repositories

Here, we list related repositories in the order they are used throughout IMC data analysis steps.

### Pre-processing of raw data

Preprocessing of IMC data is done using the [imctools]() python package by following the [IMCSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline).
This pipeline uses custom [CellProfiler plugins](https://github.com/BodenmillerGroup/ImcPluginsCP) and its [automated version](https://github.com/BodenmillerGroup/ImcSegmentationSnakemake) is implemented in SnakeMake.

[https://github.com/BodenmillerGroup/imctools](https://github.com/BodenmillerGroup/imctools)
Docs: [https://bodenmillergroup.github.io/imctools/](https://bodenmillergroup.github.io/imctools/)

[https://github.com/BodenmillerGroup/ImcSegmentationPipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline)
Docs: [https://github.com/BodenmillerGroup/ImcSegmentationPipeline/blob/main/scripts/imc_preprocessing.ipynb](https://github.com/BodenmillerGroup/ImcSegmentationPipeline/blob/main/scripts/imc_preprocessing.ipynb)

[https://github.com/BodenmillerGroup/ImcSegmentationSnakemake](https://github.com/BodenmillerGroup/ImcSegmentationSnakemake)
Docs: [https://github.com/BodenmillerGroup/ImcSegmentationSnakemake/blob/main/README.md](https://github.com/BodenmillerGroup/ImcSegmentationSnakemake/blob/main/README.md)

[https://github.com/BodenmillerGroup/ImcPluginsCP](https://github.com/BodenmillerGroup/ImcPluginsCP)
Docs: [https://github.com/BodenmillerGroup/ImcPluginsCP/blob/master/README.rst](https://github.com/BodenmillerGroup/ImcPluginsCP/blob/master/README.rst)

### Viewers for IMC data

Clasically, IMC data can be visualized using [histoCAT](https://github.com/BodenmillerGroup/histoCAT).
Part of the `ImcSegmentationPipeline` will generate folders and file structures that can be used for the original `histoCAT` implementation.

[https://github.com/BodenmillerGroup/histoCAT](https://github.com/BodenmillerGroup/histoCAT)
Docs: [https://bodenmillergroup.github.io/histoCAT/](https://bodenmillergroup.github.io/histoCAT/)
Paper: [histoCAT: analysis of cell phenotypes and interactions in multiplex image cytometry data](https://www.nature.com/articles/nmeth.4391.pdf?origin=ppub)

Now, a [napari plugin](https://github.com/BodenmillerGroup/napari-imc) is available to directly open raw IMC data using the [napari](https://github.com/napari/napari) toolbox.

[https://github.com/BodenmillerGroup/napari-imc](https://github.com/BodenmillerGroup/napari-imc)
Docs: TODO

### Downstream analysis in R

After pre-processing and feature extraction, single-cell expression data can be read into a [SingleCellExperiment](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html) or [data.table](https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html) object in R.
For general single-cell analysis steps, please refer to the [Orchestrating Single-Cell Analysis with Bioconductor](https://bioconductor.org/books/release/OSCA/) book, which supports the use of the `SingleCellExperiment` package.
A more detailed analysis workflow for IMC data is available [here](https://github.com/BodenmillerGroup/IMCDataAnalysis).
Spatial neighbourhood analysis can be performed using the [neighbouRhood](https://github.com/BodenmillerGroup/neighbouRhood) package.
Images can be visualized in R using the [cytomapper](https://github.com/BodenmillerGroup/cytomapper) package.
Example datasets, which are publicly available can be obtained using the [imcdatasets]() package.

[https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html](https://bioconductor.org/packages/release/bioc/html/SingleCellExperiment.html)
Docs: [https://bioconductor.org/packages/release/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html](https://bioconductor.org/packages/release/bioc/vignettes/SingleCellExperiment/inst/doc/intro.html)

[https://github.com/BodenmillerGroup/IMCDataAnalysis](https://github.com/BodenmillerGroup/IMCDataAnalysis)
Docs: [https://bodenmillergroup.github.io/IMCDataAnalysis/](https://bodenmillergroup.github.io/IMCDataAnalysis/)

[https://github.com/BodenmillerGroup/neighbouRhood](https://github.com/BodenmillerGroup/neighbouRhood)
Docs: [https://github.com/BodenmillerGroup/neighbouRhood/blob/master/vignettes/example_permutation_analysis.md](https://github.com/BodenmillerGroup/neighbouRhood/blob/master/vignettes/example_permutation_analysis.md)
Paper: [histoCAT: analysis of cell phenotypes and interactions in multiplex image cytometry data](https://www.nature.com/articles/nmeth.4391.pdf?origin=ppub)

[https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html](https://www.bioconductor.org/packages/release/bioc/html/cytomapper.html)
Github: [https://github.com/BodenmillerGroup/cytomapper](https://github.com/BodenmillerGroup/cytomapper)
Docs: [https://bodenmillergroup.github.io/cytomapper/](https://bodenmillergroup.github.io/cytomapper/)
Paper: [https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/btaa1061/6050702](https://academic.oup.com/bioinformatics/advance-article/doi/10.1093/bioinformatics/btaa1061/6050702)

[https://www.bioconductor.org/packages/devel/data/experiment/html/imcdatasets.html](https://www.bioconductor.org/packages/devel/data/experiment/html/imcdatasets.html)
Github: [https://github.com/BodenmillerGroup/imcdatasets](https://github.com/BodenmillerGroup/imcdatasets)
