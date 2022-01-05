# IMC image processing

The following sections describe the processing of raw IMC&trade; data, including file type conversion, image segmentation, feature extraction, and data export.
More detailed information can be found in the individual repositories:

[IMC Segmentation Pipeline](https://github.com/BodenmillerGroup/ImcSegmentationPipeline): Raw IMC data pre-processing is performed using the 
[imctools](https://github.com/BodenmillerGroup/imctools) Python package to convert raw `.mcd` files into `.ome.tiff` and `.tiff` files.
After image cropping, an [ilastik](https://www.ilastik.org/) pixel classifier is trained for image classification prior to image segmentation 
using [CellProfiler](https://cellprofiler.org/). Features (e.g. mean pixel intensity) of segmented objects (e.g. cells) are quantified and
exported. 

!!! note ""
    
    Read more in the [Docs](https://github.com/BodenmillerGroup/ImcSegmentationPipeline/blob/main/scripts/imc_preprocessing.ipynb)

[steinbock](https://github.com/BodenmillerGroup/steinbock): The `steinbock` framework offers tools for multi-channel image processing using the command-line or Python code. 
Supported tasks include IMC data preprocessing, supervised multi-channel image segmentation, object quantification and data export to a variety of file formats. 
The `steinbock` framework supports functionality similar to those of the IMC Segmentation Pipeline and further allows deep learning-enabled image segmentation. 
The framework is available as platform-independent Docker container, ensuring reproducibility and user-friendly installation. 

!!! note ""

    Read more in the [Docs](https://bodenmillergroup.github.io/steinbock/latest/) and the [paper](https://www.biorxiv.org/content/10.1101/2021.11.12.468357v1).

## MCD file type

IMC raw data are saved in the proprietary MCD&trade; file type.
A single `.mcd` file can hold raw acquisition data for multiple regions of interest, optical images providing a slide-level overview of the sample ("panoramas"), and detailed metadata about the experiment. 
The `.mcd` files can be read by the MCD viewer (see [Image visualization](viewers.md)) but cannot be widely read by image analysis software. 

To facilitate IMC data pre-processing, the [readimc](https://github.com/BodenmillerGroup/readimc) and [imctools](https://github.com/BodenmillerGroup/imctools) Python packages allow extraction of the multi-modal (IMC acquisitions, panoramas), multi-region, multi-channel information contained in raw IMC images.
Whereas `imctools` contains functionality specific to the IMC Segmentation Pipeline, the `readimc` package contains reader functions for IMC raw data and should be used for this purpose.
A common first step of IMC pre-processing is the conversion of raw data from `.mcd` files to multi-channel `.tiff` files. 

## Image pre-processing 

Starting from IMC raw data and a "panel" file, individual acquisitions are extracted as `.tiff` and `.ome.tiff` files. 
The panel file contains information on antibodies used in the experiment, and the user can specify which channels to keep for downstream analysis.
If random forest-based image segmentation is performed (see next section), random tiles are cropped from images for convenience of pixel labeling.

## Image segmentation

The IMC Segmentation Pipeline supports random forest-based image segmentation, whereas `steinbock` supports random forest-based and deep learning-based segmentation. 

**Random forest-based** image segmentation is performed by training a pixel classifier using [ilastik](https://www.ilastik.org/) on the randomly extracted image crops and selected image channels.
Pixels are classified as nuclear, cytoplasmic, or background. Employing a customizable [CellProfiler](https://cellprofiler.org/) pipeline, the probabilities are then thresholded to segment nuclei, and nuclei are expanded into cytoplasmic regions to obtain cell masks.

**Deep learning-based** image segmentation is performed as presented by Greenwald _et al._[^fn1]. 
Briefly, `steinbock` first aggregates user-defined image channels to generate two-channel images representing nuclear and cytoplasmic signals. 
Next, the [DeepCell](https://github.com/vanvalenlab/intro-to-deepcell) Python package is used to run `Mesmer`, a deep learning-enabled segmentation algorithm pre-trained on `TissueNet`, to automatically obtain cell masks without any further user input.

Segmentation masks are single-channel images that match the input images in size. In these images, non-zero grayscale values indicate the IDs of segmented objects (e.g., cells).
These masks are written out as `.tiff` files after segmentation.

## Feature extraction

Either the IMC Segmentation Pipeline or `steinbock` can be used to extract object-specific features from the segmentation masks together with the multi-channel images.
The object-specific features include the mean pixel intensity per object and channel, morphological features (e.g., object area) and the object locations.
Object-specific features are output as `.csv` files, where rows represent individual objects and columns represent features.

Both the IMC Segmentation Pipeline and `steinbock` can be used to compute _spatial object graphs_, in which nodes correspond to objects, and nodes in spatial proximity are connected by an edge.
These graphs serve as proxies for interactions between neighboring cells. They are stored as edge lists in form of `.csv` files.

Both the IMC Segmentation Pipeline and `steinbock` also write out image-specific metadata (e.g., width and height) as `.csv` files.

## Data export

To facilitate compatibility with downstream analysis, `steinbock` exports data to a variety of file formats such as OME-TIFF for images, FCS for single-cell data, the _anndata_[^fn2] format for data analysis in Python, and various graph file formats for network analysis using software such as [CytoScape](https://cytoscape.org/)[^fn3]. For export to OME-TIFF, steinbock uses [xtiff](https://github.com/BodenmillerGroup/xtiff), a Python package developed for writing multi-channel `.tiff` stacks.

[^fn1]: Greenwald N. _et al._ (2021) Whole-cell segmentation of tissue images with human-level performance using large-scale data annotation and deep learning. Nature Biotechnology
[^fn2]: Wolf A. F. _et al._ (2018) SCANPY: large-scale single-cell gene expression data analysis. Genome Biology
[^fn3]: Shannon P. _et al._ (2003) Cytoscape: A Software Environment for Integrated Models of Biomolecular Interaction Networks. Genome Research
