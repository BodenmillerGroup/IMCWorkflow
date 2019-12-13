######################################################################
#### This script serves the purpose to prepare a sample dataset   ####
#### in the format of the 'cpout' folder of the IMC segmentation  ####
#### pipeline. For now, we will use altered data from the IMMUCan ####
#### project                                                      ####
######################################################################

#############################
# 1. Prepare cells.csv file #
#############################

# Read in data
cells <- read.csv("/Volumes/immucan_volume/processed_data/Panel_1/Batch20191023/IMMUcan_Batch20191023_panel_1_1_1.05/cpout/cell.csv")

# Subset data
# Here, I will select a sample with very small images.
cells <- cells[cells$ImageNumber %in% c(16, 17, 18, 19),]
table(cells$ImageNumber)

# Change image numbering
cells[cells$ImageNumber == 16,"ImageNumber"] <- 1
cells[cells$ImageNumber == 17,"ImageNumber"] <- 2
cells[cells$ImageNumber == 18,"ImageNumber"] <- 3
cells[cells$ImageNumber == 19,"ImageNumber"] <- 4

###################################
# 2. Prepare Object relationships #
###################################

relationships <- read.csv("/Volumes/immucan_volume/processed_data/Panel_1/Batch20191023/IMMUcan_Batch20191023_panel_1_1_1.05/cpout/Object relationships.csv")

# Subset data
relationships <- relationships[relationships$First.Image.Number %in% c(16, 17, 18, 19),]

# Rename images
relationships[relationships$First.Image.Number == 16,"First.Image.Number"] <- 1
relationships[relationships$First.Image.Number == 17,"First.Image.Number"] <- 2
relationships[relationships$First.Image.Number == 18,"First.Image.Number"] <- 3
relationships[relationships$First.Image.Number == 19,"First.Image.Number"] <- 4

relationships[relationships$Second.Image.Number == 16,"Second.Image.Number"] <- 1
relationships[relationships$Second.Image.Number == 17,"Second.Image.Number"] <- 2
relationships[relationships$Second.Image.Number == 18,"Second.Image.Number"] <- 3
relationships[relationships$Second.Image.Number == 19,"Second.Image.Number"] <- 4


##################################
# 3. Prepare Image metadata file #
##################################

image <- read.csv("/Volumes/immucan_volume/processed_data/Panel_1/Batch20191023/IMMUcan_Batch20191023_panel_1_1_1.05/cpout/Image_2.csv")

# Subset data
image <- image[c(16,17,18,19),]
image$ImageNumber <- c(1,2,3,4)

####################
# 4. Prepare panel #
####################

panel <- read.csv("/Volumes/immucan_volume/processed_data/Panel_1/Batch20191023/20191101_IMMUcan_panel_1_1.05.csv")

#################################
# 5. Prepare channel order file #
#################################

channel_mass <- read.csv("/Volumes/immucan_volume/processed_data/Panel_1/Batch20191023/IMMUcan_Batch20191023_panel_1_1_1.05/tiffs/IMMUcan_Batch20191023_10032143-THOR-VAR-TIS-UNST-03_s0_p5_r1_a1_ac_full.csv",
                         header = FALSE)

######################
# 5. Write out files #
######################

write.csv(cells, "data/extdata/cells.csv", row.names = FALSE)
write.csv(relationships, "data/extdata/Object relationships.csv", row.names = FALSE)
write.csv(image, "data/extdata/image.csv", row.names = FALSE)
write.csv(panel, "data/extdata/panel.csv", row.names = FALSE)
write.csv(channel_mass, "data/extdata/IMMUcan_Batch20191023_10032143-THOR-VAR-TIS-UNST-03_s0_p5_r1_a1_ac_full.csv", row.names = FALSE)

