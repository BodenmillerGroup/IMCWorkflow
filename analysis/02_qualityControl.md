
# Quality Control

In this section, we first read in the `SingleCellExperiment` object generated in the `01_readData` script.
The major points of the following analysis strategy include:

1. Image-level quality control
2. Cell-level quality control
3. Reduction of image-specific effects

By passing these steps, we will make sure that the data is suitable for down-stream analysis.

# Read in the data

We will first read in the data generated in the previous section.

```{r}
library(SingleCellExperiment)
sce <- readRDS("output/sce.rds")
```

# Data transformations

Due to missing standards (e.g. beads in CyTOF experiments, __Refs!__) and assumptions (e.g. equal total marker intensity across all cells, __Ref!_), IMC data cannot be normalized to acount for unobserved scaling differences beween cells.
However, IMC data can be transformed to achieve more symmetric intensity distributions with more similar ranges across markers. 
In line with CyTOF data (__Refs!__), IMC data is usually arcsinh-transformed.
However, the choice of the so called "cofactor" has to be adjusted for IMC data due its lower average intensity.
In the past, IMC data was arcsinh-transformed using a cofactor of 1 (__Refs!__) or even smaller (__Razas paper__).
Alternatively, other transformation strategies include scaling the raw data between 0 and 1 after setting outlying intensities to the 99th percentile value (__Jana/Hart's paper__).

For visualization purposes, arcsinh-transformed data can be further scaled using the z-score standardization: $$z_{ij}=\dfrac{x_{ij}-\mu_{i}}{\sigma_{i}}$$, where $$x_{ij}$$ is the arsinh-transformed intensity of marker $$i$$ in cell $$j$$, $$\mu_i$$ the mean of the arsinh-transformed intensities of marker $$i$$ across all cells and $$\sigma_i$$ the standard deviation of the arsinh-transformed intensities of marker $$i$$. 

Here, we will arsinh transform the data using a cofactor of 1.
For visualization purposes, we will z-score standardize the intensities.
To store additional count matricesin the `SingleCellExperiment` object, we can use the `assay` function:

```{r transformation}
assay(sce, "exprs") <- asinh(counts(sce)/1)
assay(sce, "scaled") <- t(scale(t(assay(sce, "exprs"))))
```

__Of note:__ By default, the `scale` function scales the matrix _column-wise_.
Therefore, we transpose the intensity matrix, scale, then transpose again.

# Image-level quality control

# Density plots of all markers for each transformation

This section aims at identifiying the best tranformation for your data.
Therefore we will look at the distributions of each marker intensity to identify potential global shifts and drop outs.

```{r QC, fig.width=15, fig.height=15}
# counts for one channel for each image separate
x <- data.frame(t(counts(sce)),Image = colData(sce)$image_number)
ggplot(x)+
  facet_wrap(~Image)+
  geom_density(aes(x=Intensity_MeanIntensity_FullStackFiltered_c15))
# Cell size per image
# Cell size is not reported

# Individual marker counts
library(reshape2)
dat.melt <- melt(counts(sce)) 
dat.melt$image <- sub("_.*$", "", dat.melt$Var2)
dat.melt$Indication <- sce_all$Indication[match(dat.melt$image, sce_all$image_number)]
dat.melt$ROI <- sce_all$ROI[match(dat.melt$image, sce_all$image_number)]

# Non-transformed
suppressMessages(print(ggplot(dat.melt) +
  geom_density_ridges(aes(value, Indication, fill = ROI), alpha = 0.5) + facet_wrap( ~ Var1) +
  ggtitle("Marker distribution, non-transformed") + theme(text = element_text(size = 20))))

# Arcsinh
suppressMessages(print(ggplot(dat.melt) +
  geom_density_ridges(aes(asinh(value), Indication, fill = ROI), alpha = 0.5) + facet_wrap( ~ Var1) +
  ggtitle("Marker distribution, asinh cofactor 1") + theme(text = element_text(size = 20))))

```

# Dimensionality reduction and Visualization of all cells 

We will compute a tsne and UMAP to visualize all cells.

```{r visualisation}
# tSNE
library(Rtsne)
library(RColorBrewer)
library(viridis)
set.seed(12345)
tsne <- Rtsne(t(asinh(counts(sce_all)[!grepl("HistoneH3|DNA", rownames(sce_all)),])), perplexity = 100)
reducedDims(sce_all)$TSNE <- tsne$Y

# Colour palette
colour_vec <- c("#A6CEE3", "#1F78B4", "#B2DF8A", "#33A02C", "#FB9A99", "#FDBF6F", "#FF7F00")
names(colour_vec) <- unique(interaction(sce_all$Indication, sce_all$ROI))

ggplot(data.frame(tsne1 = tsne$Y[,1],
                  tsne2 = tsne$Y[,2],
                  Indication = sce_all$Indication,
                  ROI = sce_all$ROI)) +
  geom_point(aes(tsne1, tsne2, colour = interaction(Indication, ROI)), size = 0.1, alpha = 0.5) +
  ggtitle("log2-transformed + 0.1") + scale_color_manual(values = colour_vec)

```

```{r tsne-representation, fig.width=20, fig.height=15}
suppressPackageStartupMessages(library(cowplot))
p.list <- list()
for(i in 1:nrow(sce_all)){
  gene <- rownames(sce_all)[i]
  # plot "negative" cells first
  cur_data <- data.frame(tsne1 = tsne$Y[,1],
                  tsne2 = tsne$Y[,2],
                  marker = asinh(counts(sce_all)[gene,]))
  p.list[[i]] <- ggplot() +
  geom_point(data = cur_data[cur_data$marker <= 1,], 
             aes(tsne1, tsne2, colour = marker), size = 0.1) + 
      geom_point(data = cur_data[cur_data$marker > 1,], 
             aes(tsne1, tsne2, colour = marker), size = 0.1) +
  scale_color_viridis_c(name = gene) + 
    theme(axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),plot.background=element_blank())
}

plot_grid(plotlist = p.list, ncol = 7)
```


# Summary plots to identify potential images to exclude downstream

This section will plot the number of cells per image...

```{r, summary plots}

```


Next, I will visualize possible biases in ion counts across the cells.

```{r cell-specific-biases}
# Total ion count
ggplot(data.frame(tsne1 = tsne$Y[,1],
                  tsne2 = tsne$Y[,2],
                  total_ion_count = colSums(counts(sce_all)))) +
  geom_point(aes(tsne1, tsne2, colour = total_ion_count), size = 0.1, alpha = 0.5) +
  scale_colour_gradientn(colours = magma(100))

# Shannon Entropy
# This measure indicates how the ion counts are distributed across the cells
prop <- t(t(counts(sce_all))/colSums(counts(sce_all)))
prod <- prop*log2(prop)
prod[is.na(prod)] <- 0
entropy <- -colSums(prod)

ggplot(data.frame(tsne1 = tsne$Y[,1],
                  tsne2 = tsne$Y[,2],
                  entropy = entropy)) +
  geom_point(aes(tsne1, tsne2, colour = entropy), size = 0.1, alpha = 0.5) +
  scale_colour_gradientn(colours = magma(100))
```

# Batch normalization

Here, I will observe how the batch correction affects the visualization of cells.
As per test experiments, I observed that a range based normalization using the arcsinh-transformed counts works best.

```{r batch-correction, fig.width=15, fig.height=15}
suppressPackageStartupMessages(library(cydar))

# Generate input format for cydar
# I assume that there are not batch effects between different ROIs
cydar.list <- list()
for(i in unique(sce_all$Indication)){
  cydar.list[[i]] <- list()
  cydar.list[[i]][["Y1"]] <- t(asinh(counts(sce_all))[,sce_all$Indication == i])
}

# Perform batch correction
suppressWarnings(corrected <- normalizeBatch(cydar.list, batch.comp = NULL, mode = "range"))
corrected_counts <- do.call("rbind", unlist(corrected, recursive = FALSE))

# Visualize batch effects
library(reshape2)
dat.melt <- melt(corrected_counts) 
dat.melt$image <- sub("_.*$", "", dat.melt$Var1)
dat.melt$Indication <- sce_all$Indication[match(dat.melt$image, sce_all$image_number)]
dat.melt$ROI <- sce_all$ROI[match(dat.melt$image, sce_all$image_number)]

suppressMessages(print(ggplot(dat.melt) +
  geom_density_ridges(aes(value, Indication, fill = ROI), alpha = 0.5) + facet_wrap( ~ Var2) +
  ggtitle("Marker distribution, batch-corrected") + theme(text = element_text(size = 20))))
```

```{r tsne-visualization}
# In form of tsne
set.seed(12345)
tsne <- Rtsne(corrected_counts[,!grepl("HistoneH3|DNA", colnames(corrected_counts))], perplexity = 100)

ggplot(data.frame(tsne1 = tsne$Y[,1],
                  tsne2 = tsne$Y[,2],
                  Indication = sce_all$Indication,
                  ROI = sce_all$ROI)) +
  geom_point(aes(tsne1, tsne2, colour = interaction(Indication, ROI)), size = 0.1, alpha = 0.5) +
  ggtitle("log2-transformed + 0.1") + scale_color_manual(values = colour_vec)
```

For visualization purposes, the batch-correction does not change anything.

# Save SCE object

Finally, for easy accessability, I will write the SCE object out.

```{r save-RDS}
saveRDS(sce_all, "Data/sce.rds")
```

