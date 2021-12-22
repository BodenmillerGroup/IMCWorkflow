# An introduction to imaging mass cytometry

IMC&trade; utilizes metal-tagged antibodies to detect up to 40 proteins, or other molecules which may be labelled in biological samples.
As such, it is a leading technology to perform highly-multiplexed imaging (HMI) particularly suited to profile small (1mm<sup>2</sup>) areas of tissue slices across hundreds of samples.

![IMC_workflow](img/IMC_workflow.png)
*Overview of imaging mass cytometry data acquisition. Taken from Giesen et al.[^fn1]*

## What it is

IMC has first been published by the Bodenmiller laboratory in 2014[^fn1].
Since then it has been commercialised by Fluidigm&reg; and is now distributed as the Hyperion&trade; imaging system (documentation is available [here](https://www.fluidigm.com/products-services/instruments/hyperion)).
Similar to other HMI technologies such as MIBI[^fn2], CyCIF[^fn3], CODEX[^fn4] and SABER[^fn5], IMC captures the spatial expression of multiple proteins in parallel.
With 1&mu;m resolution, IMC is able to detect cytoplasmic and nuclear localisation of proteins. 
The default ablation frequency of IMC is set to 200Hz, meaning a 1mm<sup>2</sup> area can be imaged within ~2 hours.

## How it works

Technical aspects of how data acquisition works can be found in the original publication[^fn1]. Briefly, antibodies to detect targets in biological material are labelled with heavy metals (e.g. lanthanides) which do not occur in biological systems and can therefore be used as a readout similar to fluorophores in fluorescence microscopy. Thin sections of the biological sample on a glass slide are stained with an antibody cocktail and dried after staining. Stained microscopy slides are mounted on a precise motor driven stage inside the ablation chamber of the IMC. A high energy UV laser is focused on the tissue and any individual laser shot will ablate tissue from an area of roughly 1 &mu;m<sup>2</sup>. The energy of the laser is absorbed by the tissue which leads to vaporization and partial ionization followed by condensation of the ablated material. The ablated material from each laser shot is transported in the gas phase into the plasma of the CyTOF, where exhaustive inonization of the particles occurs. The ionized particle cloud is then focused into a vacuum and all ions below a mass of 80 Da are filtered using a quadrupole mass analyzer. The remaining ions (mostly those used to tag antibodies) are analyzed in a time-of-flight mass spectrometer to obtain an accumulated mass spectrum from all ions that correspond to a single laser shot. One can regard this spectrum as the information underlying a 1 &mu;m<sup>2</sup> pixel. With repetitive laser shots (e.g. 200 Hz) and a simultaneous lateral sample movement, a tissue can be ablated pixel by pixel and ultimately an image is reconstructed from each pixel mass spectrum. 

In principle, IMC can be applied to the same type of samples as conventional fluorescence microscopy. The largest distinction from fluorescence microscopy is that for IMC primary-labelled antibodies are commonly used, while in fluorescence microscopy secondary antibodies carrying fluorophores are widely applied. Additionally, IMC samples are dried before acquisition. Formalin-fixed and paraffin-embedded (FFPE) samples are most widely used, where FFPE blocks are cut to 2-5 &mu;m thick sections for subsequent staining. Once the sections are stained and dried, slides are ready for acquisition with IMC.


### Antibodies and Staining

<!-- TODO maybe add more references, e.g. for the long stability of the dry samples -->

Metal-labelled antibodies are used to stain tissue structures, cells and molecules within cells. Metal-conjugated antibodies can either be purchased directly from Fluidigm ([MaxPar IMC Antibodies](https://store.fluidigm.com/Cytometry/ConsumablesandReagentsCytometry/MaxparAntibodies?cclcl=en_US)), or antibodies can be purchased and labelled individually ([MaxPar Antibody Labelling](https://store.fluidigm.com/Cytometry/ConsumablesandReagentsCytometry/MaxparAntibodyLabelingKits?cclcl=en_US)). Of general note, antibody labelling using the MaxPar kits is performed via TCEP antibody reduction followed by crosslinking with sulfhydryl-reactive maleimide-bearing metal polymers. Not all antibodies are functional after labelling and it is crucial to use those antibodies that provide sufficient signal intensity and specificity after conjugation. To facilitate antibody handling, a database is almost mandatory for any IMC or other HMI users. [Airlab](https://github.com/BodenmillerGroup/airlab-web) is such a platform and allows antibody lot tracking, validation data uploads and panel generation for subsequent upload to the IMC acquisition software from Fluidigm.

<!-- TODO add Fluidigm staining protocol link -->
Depending on the sample type, different staining protocols can be used. Generally, once antibodies of choice have been found and conjugated, titration experiments are commonly performed to identify the optimal staining concentration. Even for FFPE samples, different staining protocols exist and different antibodies show variable staining based on the applied protocol. For a start, protocols such as the one provided by Fluidigm ([Fluidigm staining protocol]()) or the one describe by Ijsselsteijn et al.[^fn6] are recommended. Briefly, for FFPE tissues, a dewaxing step is performed to dissolve the paraffin used to embed the material, followed by a graded re-hydration of the samples. Thereafter, heat-induced epitope retrieval (HIER), a step aiming at the reversal of formalin based fixation, is used to unmask epitopes within tissues and make them accessible to antibodies. Epitope unmasking is generally performed in either basic, EDTA-based buffers (pH 9.2) or acidic, citrate-based buffers (pH 6). Next, a buffer containing bovine serum albumin (BSA) is used to block unspecific binding. This buffer is also used to dilute antibody stocks for the actual antibody staining. Staining time and temperature may vary and optimisation/testing is inevitable. However, overnight staining at 4&deg;C or 3-5 hours at room temperature seem to be suitable in many cases.

Following antibody incubation, unbound antibodies are washed away and a counterstain comparable to DAPI is applied to enable the identification of nuclei. The [Iridium intercalator](https://store.fluidigm.com/Cytometry/ConsumablesandReagentsCytometry/MassCytometryReagents/Cell-ID%E2%84%A2%20Intercalator-Ir%E2%80%94125%20%C2%B5M) from Fluidigm is a reagent of choice and applied in a brief 5 minute staining. Finally, the samples are washed again and then dried under an airflow. Once dried, the samples are ready for acquisition and usually stable for a long period of time (at least one year).

### Data acquisition

Data is acuired using the CyTOF software from Fluidigm (see manuals [here](https://go.fluidigm.com/hyperion-support-documents)).

Important notes up front: the IMC cannot access roughly 5 mm from each of the slide edges due to mechanical properties of the build. Currently, the IMC can also only process one slide at a time and usually one `.mcd` file per sample slide is generated to contain data. The regions of interest to be acquired need to be selected by providing coordinates for ablation. Since the field of view in the IMC is only about 200 &mu;m in diameter, so called "panoramas" can be generated. These are stitched images of single fields of view. Panoramas provide an optical overview of the tissue with a resolution similar to 10x in microscopy and are intended to help with the selection of regions of interest for ablation.

<!-- TODO really mention Service mode here? -->
Many regions of interest can be defined on a single slide and acquisition parameters such as channels to acquire, acquisition speed (100 Hz, 200 HZ and 400 HZ - only in Service mode), ablation energy and more have to be defined. Of note: it is recommended to record all isotope channels and also some channels pointing towards potential contaminations of the argon gas (e.g. Xenon) or of the samples (e.g. Lead, Barium). However, the generated raw data will be larger in size.

To process a large number of slides or to select regions on whole slide samples, sometimes panoramas are not informative enough. For that purpose, multi-color immunofluorescence of the same slide prior to staining with metal-labelled antibodies may be performed. To allow for region selection based on immunofluorescence images and also align those images with a Panorama of the same or consecutive sections of this sample, we developed [napping](https://github.com/BodenmillerGroup/napping).

Acquisition time is directly proportional to the total size of ablation, and considerable run times for large samples or large sample numbers are to be taken into account. Additionally, besides the proprietary `.mcd` file format, `.txt` files can also be generated for each region of interest, which is recommended as a backup option in case of errors that may corrupt `.mcd` files but not `.txt` files.

## How the data looks like

Upon completion of the acquisition, an `.mcd` file of variable size is generated. This file contains all panoramas, all acquisition images and their metadata. Additionally, for each acquisition a `.txt` file is generated, which holds the same pixel information as the matched acquisitions in the `.mcd` file. We refer to this data as raw data and the further processing of this data is described in [Image processing](process.md). 

Generally, to get a quick view on the data, multiple image viewers are available and an overview is provided in [Image visualization](viewers.md)

[^fn1]: Giesen C. _et al._ (2014) Highly multiplexed imaging of tumor tissues with subcellular resolution by mass cytometry. Nat. Methods, 11, 417-422.  
[^fn2]: Angelo M. _et al._ (2014) Multiplexed ion beam imaging of human breast tumors. Nat. Med., 20, 436-442.  
[^fn3]: Lin J.R. _et al._ (2018) Highly multiplexed immunofluorescence imaging of human tissues and tumors using t-CyCIF and conventional optical microscopes. Elife, 7, e31657.  
[^fn4]: Goltsev Y. _et al._ (2018) Deep profiling of mouse splenic architecture with CODEX multiplexed imaging. Cell, 174, 968-981.  
[^fn5]: Saka S.K. _et al._ (2019) Immuno-SABER enables highly multiplexed and amplified protein imaging in tissues. Nat. Biotechnol., 37, 1080-1090.  
[^fn6]: Ijsselsteijn M.E. _et al._ (2019) A 40-Marker Panel for High Dimensional Characterization of Cancer Immune Microenvironments by Imaging Mass Cytometry. Frontiers in Immunology, 10, 2534.
[^fn7]: Schapiro D _et al._ (2017) HistoCAT: Analysis of cell phenotypes and interactions in multiplex image cytometry data. Nat. Methods, 14, 873-876
[^fn8]: napari contributors (2019). napari: a multi-dimensional image viewer for python. doi:10.5281/zenodo.3555620
