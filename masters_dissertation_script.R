###############################################################
# Script: masters_dissertation.R
#
# Purpose:
#   Create reproducible workflow for assessing impacts of 
# climate change on the distribution of three threatened species

# Author: Gladys Rutto
# 
# Date: 2025-05-01
###############################################################

# ---------------------------------------------------------------------------
# Load required package
# ---------------------------------------------------------------------------
library(geodata)
library(terra)
library(sdm)
library(usdm)
library(mapview)
library(tidyverse)

# downloading species occurence record gbif and bien database
#steps to download coffea fadenii data from gbif
##downloading species
# coffea
#gbif("coffea","fadenii",download= F)
#sp <- gbif("coffea","fadenii",download= T)
#aternative method for downloading occurence data
sp_geodata <- geodata::sp_occurrence(genus = "Coffea", species = "fadenii", geo = T)
library(dplyr)
coffea_dat<- sp_geodata %>% 
  select(lon, lat, year, locality)
# Save the dataframe to the CSV file
write.csv(sp_to_csv, "C:/Users/ADMIN/OneDrive/Documents/MSC DATASET/GBIF Coffea fadenii data/sp_to_csv.csv", row.names = FALSE)
# Remove rows with NA values in any column
coffea_dat_clean <- na.omit(coffea_dat)

# Remove duplicate rows
coffea_dat_cleandup <- coffea_dat_clean[!duplicated(coffea_dat_clean), ]

# Display the cleaned data
View(coffea_dat_cleandup )

# write CSV for cleaned data 
write.csv(coffea_dat_cleandup, "C:/Users/ADMIN/OneDrive/Documents/Msc_dataset/Coffea_dat/coffea_dat_cleandup.csv", row.names = FALSE)

#dataframe for coffea combined data(kefri,gbif,bien and herbarium)
coffea_combined_clean <- read.csv("data/Combined_occurence/coffea fadenii_combined.csv")
View(coffea_combined_clean)
#filter data remain with only latitude and longitude
coffea_oc <-coffea_combined_clean[,2:3]
View(coffea_oc)
coffea_oc$species <- 1

# Remove rows with NA values in any column
coffea_na.removed <- na.omit(coffea_oc)
# Remove duplicate rows
coffea_cleaned <- coffea_na.removed  [!duplicated(coffea_na.removed  ), ]
# Display the cleaned data
View(coffea_cleaned )
# write CSV for cleaned  afrocarpus data 

write.csv(coffea_cleaned, "D:/R/msc_project/data/Combined_occurence/coffea_cleaned.csv", row.names = FALSE)



#download gbif data for afrocarpus usambarensis
sp_geodata_afro <- geodata::sp_occurrence(genus = "Afrocarpus", species = "usambarensis", geo = T)
library(dplyr)
spafro_to_csv <- sp_geodata_afro %>% 
  select(lon, lat, year, locality)

write.csv(spafro_to_csv, "C:/Users/ADMIN/OneDrive/Documents/Msc_dataset/afrocarpus_dat/spafro_to_csv.csv", row.names = FALSE)

# Read in afrocarpus combined data ( GBIF,KEFRI,NMK)
afro_combined_clean <- read.csv("data/Combined_occurence/afro_combined.csv")
View(afro_combined_clean)
#filter data remain with only latitude and longitude
afrocarpus <-afro_combined_clean[,2:3]
View(afrocarpus)
# Remove rows with NA values in any column
afrocarpus_na.removed <- na.omit(afrocarpus)
View(afrocarpus_na.removed )

# Remove duplicate rows
afrocarpus_cleaned <- afrocarpus_na.removed [!duplicated(afrocarpus_na.removed ), ]
# Display the cleaned data
View(afrocarpus_cleaned)

# write CSV for cleaned  afrocarpus data 

write.csv(afrocarpus_cleaned, "D:/R/msc_project/data/Combined_occurence/afro_clean.csv", row.names = FALSE)

#download milletia
sp_geodata_millet <- geodata::sp_occurrence(genus = "Millettia ", species = "oblata subsp. teitensis", geo = T)
library(dplyr)
spamillet_to_csv <- sp_geodata_millet  %>% 
  select(lon, lat, year, locality)
write.csv(spamillet_to_csv , "C:/Users/ADMIN/OneDrive/Documents/Msc_dataset/Milletia_dat/spmillet_to_csv.csv", row.names = FALSE)
# Remove rows with NA values in any column
spamillet_to_csv_cleanNA <- na.omit(spamillet_to_csv)

# Remove duplicate rows
spamillet_to_csv_cleandup <- spamillet_to_csv_cleanNA[!duplicated(spamillet_to_csv_cleanNA), ]

# Display the cleaned data
View(spamillet_to_csv_cleandup )

# write CSV for cleaned data 
write.csv(spamillet_to_csv_cleandup , "C:/Users/ADMIN/OneDrive/Documents/Msc_dataset/Milletia_dat/spamillet_to_csv_cleandup.csv", row.names = FALSE)

#cleaning and writing csv for milletia
milletia <- read.csv("data/Combined_occurence/Milletia_combined.csv")
View(milletia)
milletia_oc <- milletia[, 2:3] #read only long and lat
View(milletia_oc)
milletia_oc$species <- 1 # Adding the species column filled with 1s

milletia_na.removed <- na.omit(milletia_oc )
View(milletia_na.removed )

# Remove duplicate rows
milletia_cleaned <- milletia_na.removed[!duplicated(milletia_na.removed ), ]
# Display the cleaned data
View(milletia_cleaned)

# write CSV for cleaned  afrocarpus data 

write.csv(milletia_cleaned, "D:/R/msc_project/data/Combined_occurence/milletia_cleaned.csv", row.names = FALSE)












#download all three species from BIEN dataset

coffea_bien <- occCite::getBIENpoints(taxon = "Coffea fadenii")
cofeea_dat <- coffea_bien$OccurrenceTable
cofeea_dat_filter <- cofeea_dat %>% 
  select(longitude, latitude, year, datasetName)
write.csv(cofeea_dat_filter, "C:/Users/ADMIN/OneDrive/Documents/Msc_dataset/Coffea_dat/cofeea_dat_filter.csv", row.names = FALSE)
#download records for arfrocarpus
afrocarpus_bien <- occCite::getBIENpoints(taxon = "Afrocarpus usambarensis")
#cofeea_dat <- coffea_bien$OccurrenceTable
#cofeea_dat_filter <- cofeea_dat %>% 
#select(longitude, latitude, year, datasetName)#
#write.csv(cofeea_dat_filter, "C:/Users/ADMIN/OneDrive/Documents/Msc_dataset/Coffea_dat/cofeea_dat_filter.csv", row.names = FALSE)
# downoad data from BIEN for milletia
milletia_bien <- occCite::getBIENpoints(taxon = "Millettia oblata subsp. teitensis")
milletia_bien_dat<- milletia_bien$OccurrenceTable
milletia_bien_dat_filter <- milletia_bien_dat %>% 
  select(longitude, latitude, year, datasetName)
write.csv(milletia_bien_dat_filter, "C:/Users/ADMIN/OneDrive/Documents/Msc_dataset/Milletia_dat/milletia_bien_dat_filter.csv", row.names = FALSE)

url <- readLines("data/chelsa_paths.txt")

urls <- trimws(url)

output_dir <- "data/chelsa_data"

dir.create(output_dir, showWarnings = FALSE)

options(timeout = 300)

for (url in urls){
  filename = basename(url)
  dest_file = file.path(output_dir, filename)
  download.file(url, destfile = dest_file, mode = 'wb')
}

# Shuttle Radar Topography Mission (SRTM)































library(sdm)
m <- read.sdm("models/milletia.sdm")
#Change 126 2041 -2071
cur <- rast("output/current_pred_milletia.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
plot(cur_pa)
expanse(cur_pa , unit = 'km',byValue = TRUE)

fut <- rast("output/future_pred_milletia126_2041-2070.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa_126_7100[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)
# Alternatively -----------------------------------------------------------

code_raster <- 2 * cur_pa + fut_pa

plot(cur_pa); plot(fut_pa)

change <- subst(code_raster, from = c(0, 2, 3),
                to = c(0, 2, 3))
plot(change)
plot(ch)
change <- as.factor(change)
levels(change) <- data.frame(value = c(0, 2, 3),
                             label = c("Unsuitable",
                                       "Loss", 
                                       "Suitable"
                             ))
plot(change, col = c("gray", "red","yellow"))

# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(change , unit = 'km')
#per category
expanse(change , unit = 'km',byValue = TRUE)

#Change 126 2071 -2100
cur <- rast("output/current_pred_milletia.tif")
fut <- rast("output/future_pred_milletia126_2071-2100.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa_126_7100[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)
# Alternatively -----------------------------------------------------------

code_raster <- 2 * cur_pa + fut_pa

plot(cur_pa); plot(fut_pa)

change <- subst(code_raster, from = c(0, 2, 3),
                to = c(0, 2, 3))
plot(change)
plot(ch)
ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0, 2, 3),
                         label = c("Unsuitable",
                                   "Loss", 
                                   "Suitable"
                         ))
plot(ch, col = c("gray", "red","yellow"))

# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#ssp 585 change maps 
# period 2041 - 2070
cur <- rast("output/current_pred_milletia.tif")
fut <- rast("output/future_pred_milletia585_2041-2070.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)
# Alternatively -----------------------------------------------------------

code_raster <- 2 * cur_pa + fut_pa
plot(code_raster)
plot(cur_pa); plot(fut_pa)

change <- subst(code_raster, from = c(0, 2, 3),
                to = c(0, 2, 3))
plot(change)
plot(ch)
ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1, 2, 3),
                         label = c("Unsuitable","Gain",
                                   "Loss", 
                                   "Suitable"
                         ))
plot(ch, col = c("gray", "yellow","red","darkgreen"))

# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#ssp 585 change maps 

# period 2071 - 2100
cur <- rast("output/current_pred_milletia.tif")
fut <- rast("output/future_pred_milletia585_2071-2100.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)
# Alternatively -----------------------------------------------------------

code_raster <- 2 * cur_pa + fut_pa
plot(code_raster)
plot(cur_pa); plot(fut_pa)

change <- subst(code_raster, from = c(0, 2, 3),
                to = c(0, 2, 3))
plot(change)
plot(ch)
ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1, 2, 3),
                         label = c("Unsuitable","Gain",
                                   "Loss", 
                                   "Suitable"
                         ))
plot(ch, col = c("gray", "yellow","red","darkgreen"))

# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#ssp 585 change maps 


# Loading the packages ----------------------------------------------------

library(geodata)
library(terra)
library(sdm)
library(usdm)
library(mapview)
library(tidyverse)


# Loading the region of interest boundary ---------------------------------

# https://doi.org/10.5061/dryad.c5310 the paper to the data

roi <- vect("data/roi/Eastern Arc Mountains/Eastern Arc Mountains/EasternArc_byBloc_incPlateaus&LowMatundu_DD.shp")


# Creating roi buffer around the mountains --------------------------------

roi <- aggregate(roi) # Agrregating the fragmented mountains
roi_buffer <- terra::buffer(roi, 5000)
# Creating a buffer of 5000 m (5km) around the mountains
mapview(roi_buffer) + mapview(roi)# Viewing the buffer and the mountains

# Loading the tree species data ------------------------------------------

coffea <- read.csv("data/Combined_occurence/coffea_cleaned.csv")
coffea <- read.csv("data/Combined_occurence/coffea_cleaned_taita.csv")
view(coffea)

# Create spatvector data object -------------------------------------------

coffea_vect <- vect(coffea, geom = c("long", "lat" ), crs = "epsg:4326")

# Reading in the current predictor variables--------------------------------------
#bioclimatic

bio <- rast(list.files("data/chelsa_data/", 
                       pattern = "1981-2010", 
                       full.names = TRUE))

# Topographic
elev <- rast("data/Elevation/wc2.1_30s_elev.tif")
slope <- terrain(elev, "slope")
aspect <- terrain(elev, "aspect")

# Edaphic
ph_5 <- rast("data/Soil/soil_af/Soil_ph/af_ph_0-5cm_30s.tif")
ph_15 <- rast("data/Soil/soil_af/Soil_ph/af_ph_5-15cm_30s.tif")
carbon_5 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_0-5cm_30s.tif")
carbon_15 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_5-15cm_30s.tif")

roi_buffer <- project(roi_buffer, crs(bio))

# Cropping to roi ---------------------------------------------------------

bio_crop <- crop(bio, roi_buffer, mask = T)
elev_crop <- crop(elev, roi_buffer, mask = T)
slope_crop <- crop(slope, roi_buffer, mask = T)
aspect_crop <- crop(aspect, roi_buffer, mask = T)
ph_5_crop <- crop(ph_5, roi_buffer, mask = T)
ph_15_crop <- crop(ph_15, roi_buffer, mask = T)
carbon_5_crop <- crop(carbon_5, roi_buffer, mask = T)
carbon_15_crop <- crop(carbon_15, roi_buffer, mask = T)

# Renaming predictor variables --------------------------------------------

names(bio_crop) <- c("bio1", paste0("bio", 10:19), paste0("bio", 2:9))
names(elev_crop) <- "elevation"
names(slope_crop) <- "slope"
names(aspect_crop) <- "aspect"
names(ph_5_crop) <- "ph5"
names(ph_15_crop) <- "ph15"
names(carbon_5_crop) <- "carbon5" 
names(carbon_15_crop) <- "carbon15"
names(bio_crop) <- c(
  "Annual_Mean_Temperature",                      # bio1
  "Mean_Temperature_WQ",          # bio10
  "Mean_Temperature_CQ",          # bio11
  "Annual_Precipitation",                         # bio12
  "Precipitation_WM",               # bio13
  "Precipitation_of_DM",                # bio14
  "Precipitation_Seasonality",                    # bio15
  "Precipitation_of_WetQ",             # bio16
  "Precipitation_of_DQ",              # bio17
  "Precipitation_of_WQ",             # bio18
  "Precipitation_of_CQ",             # bio19
  "Mean_Diurnal_Range",                           # bio2
  "Isothermality",                                # bio3
  "Temperature_Seasonality",                      # bio4
  "Max_Temperature_of_WM",             # bio5
  "Min_Temperature_of_CM",             # bio6
  "Temperature_AnnualR",                     # bio7
  "Mean_Temperature_of_WQ",          # bio8
  "Mean_Temperature_of_DQ"            # bio9
)



# Combining all the current predictors together ---------------------------

preds <- (bio_crop)

# Multicollinearity -------------------------------------------------------
# Multicollinearity -------------------------------------------------------

set.seed(248)

#v <- vifcor(preds, th = 0.7, keep = c('bio2','bio3','bio8','bio9','bio13','bio14','bio15','bio18','bio19','elevation'))
#v <- vifcor(preds, th = 0.7, keep = c("bio2", "bio3", "bio8", "bio9", "bio13", "bio14", "bio13", "bio8", "bio9", "elevation"))
#v <- vifcor(preds, th = 0.7, keep = c("bio1", "bio4", "bio10", "bio11", "bio12", "bio13", "bio14","elevation"))
v <- vifcor(preds, th = 0.7)
print(v)



# Remaining predictor variables used --------------------------------------

preds_used <- exclude(preds, v)

# Creating an sdmData object ----------------------------------------------

d <- sdmData(formula = species ~., 
             train = coffea_vect , 
             predictors = preds_used, 
             bg = 1000)

# Calibrating the sdm model -----------------------------------------------

m <- sdm(formula = species ~., 
         data = d, 
         methods = "maxent",
         replications = "boot", 
         test.percent = 30,
         n = 10) 
getEvaluation(m)
#Predicting current distribution
p <- predict(m, preds_used, mean = T)
plot(p)


write.sdm(m, "models/coffea.sdm",overwrite = TRUE)
#write sdm for coffea Taita 
write.sdm(m, "models/coffea_taita.sdm",overwrite = TRUE)
# Some plots --------------------------------------------------------------
m <- read.sdm("models/coffea.sdm")

png(filename = 'plots/roc_coffea.png', height = 1200, width = 1200, res = 200)
roc(m)
dev.off()

rcurve(m)
ggsave(dpi = 500, width = 20, height = 6,
       filename = "plots/rcurve_coffea.png")

plot(getVarImp(m))
ggsave(dpi = 400, width = 6, height = 4, 
       filename = "plots/var_imp_coffea.png")
print(getVarImp(m))
# Predicting current potential suitable habitat ---------------------------

p <- predict(m, newdata = preds_used, mean = TRUE)

plot(p) # Not in the buffer, concentrated up the mountain

writeRaster(p, "output/current_pred_coffea_taita.tif",overwrite = T)
p <- rast("output/current_pred_coffea_taita.tif")


# Current presence absence map
pa <- pa(x = p, y = m, id = 1, opt = 2)
plot(pa)
expanse(x = pa, zones = pa, unit = 'km')

#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop_pa <- crop(pa, taita, touches = F, mask = T)
plot(Taita_crop_pa)
expanse(Taita_crop_pa , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop_pa <- crop(pa, north_tz, touches = F, mask = T)

expanse(northtz_crop_pa  , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop_pa <- crop(pa, south_tz, touches = F, mask = T)

expanse(southtz_crop_pa , unit = 'km', byValue = TRUE)





#cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
#plot(cur_pa)
#expanse(cur_pa , unit = 'km',byValue = TRUE)

# Projection for Taita
taita  <- vect("D:/R/Taita/Taita forest/Taita_forests.shp")

# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))

something_else <- crop(cur_pa, taita_proj) # Crop to Taita

something_disagg <- disagg(something_else, 20) # 

# Taita_crop <- mask(crop(something_disagg, taita_proj), taita_proj)

Taita_crop <- crop(something_disagg, taita_proj, touches = F, mask = T)


expanse(Taita_crop , unit = 'ha', byValue = TRUE)

plot(Taita_crop)
plot(taita_proj, add = T)


# reading in future predictor variables------------------
fut_2011_2040_126 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2011-2040_ipsl-cm6a-lr_ssp126",
                                     full.names = TRUE))

fut_2011_2040_585 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2011-2040_ipsl-cm6a-lr_ssp585",
                                     full.names = TRUE))
fut_2041_2070_126 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2041-2070_ipsl-cm6a-lr_ssp126",
                                     full.names = TRUE))

fut_2041_2070_585 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2041-2070_ipsl-cm6a-lr_ssp585",
                                     full.names = TRUE))
fut_2071_2100_126 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2071-2100_ipsl-cm6a-lr_ssp126",
                                     full.names = TRUE))

fut_2071_2100_585 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2071-2100_ipsl-cm6a-lr_ssp585",
                                     full.names = TRUE))

# Cropping to roi ---------------------------------------------------------

#fut_2011_2040_126_crop <- crop(fut_2011_2040_126, roi_buffer, mask = T)
#fut_2011_2040_585_crop <- crop(fut_2011_2040_585, roi_buffer, mask = T) 
fut_2041_2070_126_crop <- crop(fut_2041_2070_126, roi_buffer, mask = T)
fut_2041_2070_585_crop <- crop(fut_2041_2070_585, roi_buffer, mask = T)
fut_2071_2100_126_crop <- crop(fut_2071_2100_126, roi_buffer, mask = T)
fut_2071_2100_585_crop <- crop(fut_2071_2100_585, roi_buffer, mask = T)

# Renaming predictor variables --------------------------------------------

names(bio_crop) <- c("bio1", paste0("bio", 10:19), paste0("bio", 2:9))
names(fut_2011_2040_126_crop) <- names(bio_crop)
names(fut_2011_2040_585_crop) <- names(bio_crop)
names(fut_2041_2070_126_crop) <- names(bio_crop)
names(fut_2041_2070_585_crop) <- names(bio_crop)
names(fut_2071_2100_126_crop) <- names(bio_crop)
names(fut_2071_2100_585_crop) <- names(bio_crop)



# Future ------------------------------------------------------------------

# coffea SSP 126 Period 2011-2040
fut_all <- (fut_2011_2040_126_crop)

fut_126_2011_2040_used <- exclude(fut_all , v)

p_fut <- predict(m, fut_126_2011_2040_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea126_2011-2040.tif")

# For the future 126 2011-2040

p_fut <- rast("output/future_pred_coffea126_2011-2040.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')


# coffea SSP 126 Period 2041-2070
fut_all <- (fut_2041_2070_126_crop)

fut_126_2041_2070_used <- exclude(fut_all , v)

p_fut <- predict(m, fut_126_2041_2070_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea126_2041-2070.tif",overwrite=TRUE)
# output map for Taita
writeRaster(p_fut, "output/future_pred_coffea126_2041-2070_taita.tif",overwrite=TRUE)
#AOA
#aoa_p <- aoa (x=exclude(fut_all,v, d=d )
aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)
# For the future 126 2041-2070

p_fut <- rast("output/future_pred_coffea126_2041-2070_taita.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

#expanse(x = pa, zones = pa, unit = 'km',byvalue=T)
#expanse(Taita_crop , unit = 'km',byValue =T)

# Projection for Taita
taita  <- vect("D:/R/Taita/Taita forest/Taita_forests.shp")
# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))

something_else <- crop(cur_pa, taita_proj) # Crop to Taita

something_disagg <- disagg(something_else, 20) # 

# Taita_crop <- mask(crop(something_disagg, taita_proj), taita_proj)

#Taita_crop <- crop(something_disagg, taita_proj, touches = F, mask = T)


#expanse(Taita_crop , unit = 'ha', byValue = TRUE)

#plot(Taita_crop)
#plot(taita_proj, add = T)




# Taita forests as a whole ------------------------------------------------

#taita_proj <- project(taita, crs(pa))
#Taita_crop <- mask(crop(pa, taita_proj),taita_proj)

#expanse(Taita_crop , unit = 'km',byValue =T)

#plot(Taita_crop)

#change quantification EA 126 2041-2070
cur <- rast("output/current_pred_coffea.tif")
fut <- rast("output/future_pred_coffea126_2041-2070.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss


plot(ch)
writeRaster(ch, "change/coffea1_changemap126_2041-2070.tif",overwrite=TRUE)
# Alternatively -----------------------------------------------------------


ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2, 3),
                         label = c("Unsuitable","Gain","Suitable",
                                   "Loss"
                         ))
plot(ch, col = c("gray","yellow","Green","red"))

plot(ch, col = c("gray", "red"), main = "C.fadenii habitat suitability area change under SSP 126 mid century")
#plot(ch, col = c("gray", "yellow", "darkgreen", "red"), main = "Coffea habitat suitability area change under SSP 126_2041_2070")

writeRaster(ch, "change/coffea_changemap126_2041-2070.tif",overwrite=TRUE)
# Calculate area change ---------------------------------------------------

df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)

expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)





#coffea SSP 126 2071-2100
fut_all <- (fut_2071_2100_126_crop)

fut_126_2071_2100_used <- exclude(fut_all , v)

p_fut <- predict(m, fut_126_2071_2100_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea126_2071-2100.tif")
#Area compatibility 

aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)



# For the future 126 2071-2100

p_fut <- rast("output/future_pred_coffea126_2071-2100_taita.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'ha')
# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))
something_else <- crop(pa, taita_proj) # Crop to Taita

something_disagg <- disagg(something_else, 20) # 

# Taita_crop <- mask(crop(something_disagg, taita_proj), taita_proj)

Taita_crop <- crop(something_disagg, taita_proj, touches = F, mask = T)


expanse(Taita_crop , unit = 'ha', byValue = TRUE)

plot(Taita_crop)
plot(taita_proj, add = T)




# Taita forests as a whole ------------------------------------------------




#change quantification EA 126 2071-2100
cur <- rast("output/current_pred_coffea.tif")
fut <- rast("output/future_pred_coffea126_2071-2100.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa_126_7100, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa_126_7100[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa_126_7100[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa_126_7100[] == 1, 2, 3))) # Suitable, Loss

plot(ch)
writeRaster(ch, "change/coffea1_changemap126_2071-2100.tif")
# Alternatively -----------------------------------------------------------


plot(ch)
ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2, 3),
                         label = c("Unsuitable","Gain","Suitable",
                                   "Loss"
                         ))
plot(ch, col = c("gray","yellow","Green","red"))
plot(ch, col = c("gray",  "red"), main = "Coffea habitat suitability area change under SSP 126 late century")

writeRaster(ch, "change/coffea_changemap126_2071-2100.tif")
# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(change , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)

expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)






# coffea SSP 585 Period 2011-2040
fut_all <- c(fut_2011_2040_585_crop , elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)

fut_585_2011_2040_used<- exclude(fut_all , v)


p_fut <- predict(m, fut_585_2011_2040_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea585_2011-2040.tif",overwrite = T)

# presence /absence coffea SSP 585 2011-2040

p_fut <- rast("output/future_pred_coffea585_2011-2040.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')


# coffea SSP 585 Period 2041-2070
fut_all <- (fut_2041_2070_585_crop)

fut_585_2041_2070_used<- exclude(fut_all , v)

p_fut <- predict(m, fut_585_2041_2070_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea585_2041-2070.tif")
#Area compatibility
aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)



# For the future 585 2041-2070

p_fut <- rast("output/future_pred_coffea585_2041-2070_taita.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')


# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))
something_else <- crop(pa, taita_proj) # Crop to Taita

something_disagg <- disagg(something_else, 20) # 

# Taita_crop <- mask(crop(something_disagg, taita_proj), taita_proj)

Taita_crop <- crop(something_disagg, taita_proj, touches = F, mask = T)


expanse(Taita_crop , unit = 'ha', byValue = TRUE)

plot(Taita_crop)
plot(taita_proj, add = T)







#change quantification EA 585 2041-2070
cur <- rast("output/current_pred_coffea.tif")
fut <- rast("output/future_pred_coffea585_2041-2070.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)
# Alternatively -----------------------------------------------------------


plot(ch)
ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2, 3),
                         label = c("Unsuitable","Gain","Suitable",
                                   "Loss"
                         ))
plot(ch, col = c("gray","yellow","Green","red"))
plot(ch, col = c("gray",  "red"), main = "Coffea habitat suitability area change under SSP585 mid century")

writeRaster(ch, "change/coffea_changemap585_2041-2070.tif")
# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(change , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)

expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)














# coffea SSP 585 Period 2071-2100 ( Recheck)
fut_all <- (fut_2071_2100_585_crop)

fut_585_2071_2100_used<- exclude(fut_all , v)

p_fut <- predict(m, fut_585_2071_2100_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea585_2071-2100.tif",overwrite=TRUE)
#Area compatibility
aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)



# For the future 585 2071-2100

p_fut <- rast("output/future_pred_coffea585_2071-2100.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'ha')
# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))
Taita_crop <- mask(crop(pa, taita_proj),taita_proj)

expanse(Taita_crop , unit = 'ha', byValue = T)

plot(Taita_crop)

# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))
something_else <- crop(pa, taita_proj) # Crop to Taita

something_disagg <- disagg(something_else, 20) # 

# Taita_crop <- mask(crop(something_disagg, taita_proj), taita_proj)

Taita_crop <- crop(something_disagg, taita_proj, touches = F, mask = T)


expanse(Taita_crop , unit = 'ha', byValue = TRUE)

plot(Taita_crop)
plot(taita_proj, add = T)









#change quantification EA 585 2071-2100
cur <- rast("output/current_pred_coffea.tif")
fut <- rast("output/future_pred_coffea585_2071-2100.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)
# Alternatively -----------------------------------------------------------

code_raster <- 2 * cur_pa + fut_pa

plot(cur_pa); plot(fut_pa)

change <- subst(code_raster, from = c(0, 1, 2, 3),
                to = c(0, 1, 2, 3))
plot(change)
plot(ch)
ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2, 3),
                         label = c("Unsuitable","Gain","Suitable",
                                   "Loss"
                         ))
plot(ch, col = c("gray","yellow","Green","red"))

plot(ch, col = c("gray", "red"), main = "Coffea habitat suitability area change under SSP 585 late century")
writeRaster(ch, "change/coffea_changemap585_2071-2100.tif")
# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(change , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)

expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)












































































































# Bioclimatic  worldclim
bio <- rast("data/bioclimatic/current/tile_44_wc2.1_30s_bio.tif")

# Topographic
elev <- rast("data/Elevation/wc2.1_30s_elev.tif")

# Edaphic
ph_5 <- rast("data/Soil/soil_af/Soil_ph/af_ph_0-5cm_30s.tif")
ph_15 <- rast("data/Soil/soil_af/Soil_ph/af_ph_5-15cm_30s.tif")
carbon_5 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_0-5cm_30s.tif")
carbon_15 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_5-15cm_30s.tif")

# Cropping to roi ---------------------------------------------------------

bio_crop <- crop(bio, roi_buffer, mask = T)
elev_crop <- crop(elev, roi_buffer, mask = T)
slope <- terrain(elev_crop, "slope")
aspect <- terrain(elev_crop, "aspect")
slope_crop <- crop(slope, roi_buffer, mask = T)
aspect_crop <- crop(aspect, roi_buffer, mask = T)
ph_5_crop <- crop(ph_5, roi_buffer, mask = T)
ph_15_crop <- crop(ph_15, roi_buffer, mask = T)
carbon_5_crop <- crop(carbon_5, roi_buffer, mask = T)
carbon_15_crop <- crop(carbon_15, roi_buffer, mask = T)

# Renaming predictor variables --------------------------------------------

names(bio_crop) <- paste0("bio", 1:19)
names(elev_crop) <- "elevation"
names(slope_crop) <- "slope"
names(aspect_crop) <- "aspect"
names(ph_5_crop) <- "ph5"
names(ph_15_crop) <- "ph15"
names(carbon_5_crop) <- "carbon5" 
names(carbon_15_crop) <- "carbon15"

# Combining all the current predictors together ---------------------------

preds <- c(bio_crop, elev_crop, slope_crop, aspect_crop, 
           ph_5_crop, ph_15_crop, carbon_5_crop, carbon_15_crop)

# Multicollinearity -------------------------------------------------------

set.seed(248)
v <- vifcor(preds, th = 0.7, keep = 'elevation')

# Remaining predictor variables used --------------------------------------

preds_used <- exclude(preds, v)

# Creating an sdmData object ----------------------------------------------

d <- sdmData(formula = species ~., 
             train = coffea_vect, 
             predictors = preds_used, 
             bg = 1000)

# Calibrating the sdm model -----------------------------------------------

m <- sdm(formula = species ~., 
         data = d, 
         methods = c("maxent"),
         replications = "boot", # sub, cv
         test.percent = 30,
         n = 10) # Number of runs---iterations---replicates

write.sdm(m, "models/coffea.sdm")

# Some plots --------------------------------------------------------------
m <- read.sdm("models/coffea.sdm")

png(filename = 'plots/roc_coffea.png', height = 1200, width = 1200, res = 200)
roc(m)
dev.off()

rcurve(m)
ggsave(dpi = 400, width = 18, height = 6,
       filename = "plots/rcurve_coffea.png")

plot(getVarImp(m))
ggsave(dpi = 400, width = 6, height = 4, 
       filename = "plots/var_imp_coffea.png")

# Predicting current potential suitable habitat ---------------------------

p <- predict(m, newdata = preds_used, mean = TRUE)

plot(p) # Not in the buffer, concentrated up the mountain

writeRaster(p, "output/current_pred_coffea.tif", overwrite = TRUE)
# Current presence absence map
pa <- pa(x = p, y = m, id = 1, opt = 2)
plot(pa)
expanse(x = pa, zones = pa, unit = 'km')

# Future ------------------------------------------------------------------

# coffea SSP 245 Period 2041-2060

fut_245_4160 <- rast("data/bioclimatic/future/bioc_245_2041-2060.tif")
names(fut_245_4160) <- paste0("bio", 1:19)

fut_245_4160_crop <- crop(fut_245_4160, roi_buffer, mask = T)

fut_all <- c(fut_245_4160_crop, elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_245_4160_used <- subset(fut_all, v)

p_fut <- predict(m, fut_245_4160_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea245_4160.tif",overwrite=T)

# For the future 245 2041-2060

p_fut <- rast("output/future_pred_coffea245_4160.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')


# coffea SSP 245 Period 2061-2080

fut_245_6180 <- rast("data/bioclimatic/future/bioc_245_2061-2080.tif")
names(fut_245_6180) <- paste0("bio", 1:19)

fut_245_6180_crop <- crop(fut_245_6180, roi_buffer, mask = T)

fut_all <- c(fut_245_6180_crop, elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_245_6180_used <- subset(fut_all, v)

p_fut <- predict(m, fut_245_6180_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea245_6180.tif",overwrite=T)

# For the future 245 2061-2080

p_fut <- rast("output/future_pred_coffea245_6180.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')


# coffea SSP 585 Period 2041-2060

fut_585_4160 <- rast("data/bioclimatic/future/bioc_585_2041-2060.tif")
names(fut_585_4160) <- paste0("bio", 1:19)

fut_585_4160_crop <- crop(fut_585_4160, roi_buffer, mask = T)

fut_all <- c(fut_585_4160_crop, elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_585_4160_used <- subset(fut_all, v)

p_fut <- predict(m, fut_585_4160_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea585_4160.tif",overwrite=T)

# For the future 585 2041-2060

p_fut <- rast("output/future_pred_coffea585_4160.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')


# coffea SSP 585 Period 2061-2080

fut_585_6180 <- rast("data/bioclimatic/future/bioc_585_2061-2080.tif")
names(fut_585_6180) <- paste0("bio", 1:19)

fut_585_6180_crop <- crop(fut_585_6180, roi_buffer, mask = T)

fut_all <- c(fut_585_6180_crop, elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_585_6180_used <- subset(fut_all, v)

p_fut <- predict(m, fut_585_6180_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea585_6180.tif",overwrite=T)
# For the future SSP 585 2061-2080

p_fut <- rast("output/future_pred_coffea585_6180.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')
























# Future climate data -----------------------------------------------------

# model = IPSL-CM6A-LR and EC-Earth3-Veg 
# ssp = 245, 585 # Removed 370 and 126
# time = 2021-2040, 2041-2060, 2061-2080
# Resolution = 30 arc second, about 1 km

#Download future Model= IPSL-CM6A-LR,SSP=245 period(2021-2040;2041-2060,2061-2080,2018-2100)


library(geodata)

times <- c("2021-2040", "2041-2060", "2061-2080", "2081-2100")

ssp <- c( "245", "585")

for (t in times){
  for (s in ssp){
    data <- cmip6_tile(lon = 38.25,
                       lat = -4.21,
                       model = "IPSL-CM6A-LR",
                       ssp = s,
                       time = t,
                       var = "bioc",
                       path = "data/bioclimatic/future")
    filename <- paste0("data/bioclimatic/future/bioc_", s, "_", t, ".tif")
    writeRaster(data, filename, overwrite = TRUE)
    
  }
}


# Cropping the bioclim variables to the buffer boundaries -----------------

elev <- rast("data/wc2.1_30s_elev.tif") # Reading/Loading elevation data

elev_crop <- crop(elev, roi_buffer, mask = TRUE) # Cropping the raster to bounds of roi_buffer

plot(elev_crop) # Plotting the elev_crop
plot(roi_buffer, add = T, lwd = 4, border = 'yellow')

mapview(elev_crop)

# Creating slope and aspect -----------------------------------------------

# Slope
slope <- terrain(elev_crop, 'slope')
plot(slope)

# Aspect
aspect <- terrain(elev_crop, "aspect")
plot(aspect)
#DOWNLOAD SOIL variables
# Please note that you have to set download=T if you haven't downloaded the data before:
#soil at depth of 0-5cm
SOIL <- geodata::soil_af(var = 'pH', depth = '5', 
                         path = 'data/Soil', 
                         download = TRUE)
library(terra)
cropped_soil <- crop(SOIL, roi_buffer, mask = T)
#Soil at depth of 5-15 cm
SOIL <- geodata::soil_af(var = 'pH', depth = '15', 
                         path = 'data/Soil', 
                         download = TRUE)
cropped_soil <- crop(SOIL, roi_buffer, mask = T)

#download soil carbon at 0cm-5cm depth
Soil_carbon<-geodata::soil_af(var = 'SOC', depth = '5', 
                              path = 'data/Soil/soil_af/soil_carbon', 
                              download = TRUE)
#download soil carbon at 5cm-15cm depth                       
Soil_carbon<-geodata::soil_af(var = 'SOC', depth = '15', 
                              path = 'data/Soil/soil_af/soil_carbon', 
                              download = TRUE)




# Loading the packages ----------------------------------------------------

library(geodata)
library(terra)
library(sdm)
library(usdm)
library(mapview)
library(tidyverse)

# GBIF
# BIEN
# KEFRI
# EAH

# Loading the region of interest boundary ---------------------------------

# https://doi.org/10.5061/dryad.c5310 the paper to the data

roi <- vect("data/roi/Eastern Arc Mountains/Eastern Arc Mountains/EasternArc_byBloc_incPlateaus&LowMatundu_DD.shp")
#roi  <- vect("D:/R/Taita/Taita forest/Taita_forests.shp")
# Creating roi buffer around the mountains --------------------------------

roi <- aggregate(roi) # Agrregating the fragmented mountains
roi_buffer <- terra::buffer(roi, 5000) # Creating a buffer of 5000 m (5km) around the mountains

mapview(roi_buffer) + mapview(roi) # Viewing the buffer and the mountains

# Loading the tree species data ------------------------------------------
afro<- read.csv("data/Combined_occurence/afro_clean.csv")
afro <- read.csv("data/Combined_occurence/afro_cleaned.csv", sep = ',', header = T)
afro$species <- 1
afro$Lat <- as.numeric(afro$Lat)


# Create spatvector data object -------------------------------------------

afro_vect <- vect(afro, geom = c("Long", "Lat"), crs = "epsg:4326")

# Reading in the current predictor variables--------------------------------------
#bioclimatic

bio <- rast(list.files("data/chelsa_data/", 
                       pattern = "1981-2010", 
                       full.names = TRUE))

# Topographic
elev <- rast("data/Elevation/wc2.1_30s_elev.tif")
slope <- terrain(elev, "slope")
aspect <- terrain(elev, "aspect")

# Edaphic
ph_5 <- rast("data/Soil/soil_af/Soil_ph/af_ph_0-5cm_30s.tif")
ph_15 <- rast("data/Soil/soil_af/Soil_ph/af_ph_5-15cm_30s.tif")
carbon_5 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_0-5cm_30s.tif")
carbon_15 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_5-15cm_30s.tif")

# Cropping to roi ---------------------------------------------------------
roi_buffer <- project(roi_buffer, crs(bio))
bio_crop <- crop(bio, roi_buffer, mask = T)
elev_crop <- crop(elev, roi_buffer, mask = T)
slope_crop <- crop(slope, roi_buffer, mask = T)
aspect_crop <- crop(aspect, roi_buffer, mask = T)
ph_5_crop <- crop(ph_5, roi_buffer, mask = T)
ph_15_crop <- crop(ph_15, roi_buffer, mask = T)
carbon_5_crop <- crop(carbon_5, roi_buffer, mask = T)
carbon_15_crop <- crop(carbon_15, roi_buffer, mask = T)

# Renaming predictor variables --------------------------------------------

names(bio_crop) <- c("bio1", paste0("bio", 10:19), paste0("bio", 2:9))
names(elev_crop) <- "elevation"
names(slope_crop) <- "slope"
names(aspect_crop) <- "aspect"
names(ph_5_crop) <- "ph5"
names(ph_15_crop) <- "ph15"
names(carbon_5_crop) <- "carbon5" 
names(carbon_15_crop) <- "carbon15"

names(bio_crop) <- c(
  "Annual_Mean_Temperature",                      # bio1
  "Mean_Temperature_WQ",          # bio10
  "Mean_Temperature_CQ",          # bio11
  "Annual_Precipitation",                         # bio12
  "Precipitation_WM",               # bio13
  "Precipitation_of_DM",                # bio14
  "Precipitation_Seasonality",                    # bio15
  "Precipitation_of_WetQ",             # bio16
  "Precipitation_of_DQ",              # bio17
  "Precipitation_of_WQ",             # bio18
  "Precipitation_of_CQ",             # bio19
  "Mean_Diurnal_Range",                           # bio2
  "Isothermality",                                # bio3
  "Temperature_Seasonality",                      # bio4
  "Max_Temperature_of_WM",             # bio5
  "Min_Temperature_of_CM",             # bio6
  "Temperature_AnnualR",                     # bio7
  "Mean_Temperature_of_WQ",          # bio8
  "Mean_Temperature_of_DQ"            # bio9
)



# Combining all the current predictors together ---------------------------

preds <- c(bio_crop)


# Multicollinearity -------------------------------------------------------

set.seed(248)

v <- vifcor(preds, th = 0.7)
print(v)
preds_used <- exclude(preds, v)
# Remaining predictor variables used --------------------------------------

#preds_used <- exclude(preds_dis, v)

# Creating an sdmData object ----------------------------------------------

d <- sdmData(formula = species ~., 
             train = afro_vect , 
             predictors = preds_used, 
             bg = 1000)

#AREA OF compatibility 
aoa_p <- aoa(x = exclude(preds, v), 
             d = d)
plot(aoa_p)


# Calibrating the sdm model -----------------------------------------------

m <- sdm(formula = species ~., 
         data = d, 
         methods = c("maxent"),
         replications = "boot", # sub, cv
         test.percent = 30,
         n = 10) # Number of runs---iterations---replicates
getEvaluation(m)
write.sdm(m, "models/afrocarpus.sdm",overwrite = TRUE)

#Making prediction of current distribution of Afrocarpus using models with highest TSS values

m <- read.sdm("models/afrocarpus.sdm")
m <- read.sdm("models/afrocarpus_taita.sdm")

p <- predict( m,  preds_used,mean = T)
plot(p)
#p <- predict(m, newdata = preds_used, mean = TRUE)
writeRaster(p, "output/current_pred_afrocarpus.tif",overwrite = T)
#p <- rast("output/current_pred_afrocarpus.tif")
#plot(p)

#writeRaster(p, "output/current_pred_afrocarpusHR.tif", overwrite = TRUE)

# Some plots --------------------------------------------------------------
#write.sdm(m, "models/afrocarpusHR.sdm",overwrite = TRUE)
#m <- read.sdm("models/afrocarpusHR.sdm")

png(filename = 'plots/roc_afrocarpus.png', height = 1200, width = 1200, res = 200)
roc(m)
dev.off()

rcurve(m)
ggsave(dpi = 500, width = 20, height = 6,
       filename = "plots/rcurve_afrocarpus.png")


plot(getVarImp(m))
ggsave(dpi = 400, width = 6, height = 4, 
       filename = "plots/var_imp_afrocarpus.png")
print(getVarImp(m))
# Predicting current potential suitable habitat ---------------------------


# Current presence absence map
pa <- rast("output/current_pred_afrocarpus_taita.tif")
pa <- sdm::pa(x = p1, y = m, id  ="ensemble", opt = 2)
# Current presence absence map
pa <- pa(x = p, y = m, id = 1, opt = 2)
plot(pa)
expanse(x = pa, zones = pa, unit = 'km')

#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(pa, taita, touches = F, mask = T)
expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(pa, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(pa, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)






# Projection for Taita

# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))
Taita_crop <- mask(crop(pa, taita_proj),taita_proj)

expanse(Taita_crop , unit = 'ha')

plot(Taita_crop)

# reading in future predictor variables------------------
fut_2011_2040_126 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2011-2040_ipsl-cm6a-lr_ssp126",
                                     full.names = TRUE))

fut_2011_2040_585 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2011-2040_ipsl-cm6a-lr_ssp585",
                                     full.names = TRUE))
fut_2041_2070_126 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2041-2070_ipsl-cm6a-lr_ssp126",
                                     full.names = TRUE))

fut_2041_2070_585 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2041-2070_ipsl-cm6a-lr_ssp585",
                                     full.names = TRUE))
fut_2071_2100_126 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2071-2100_ipsl-cm6a-lr_ssp126",
                                     full.names = TRUE))

fut_2071_2100_585 <- rast(list.files("data/chelsa_data/",
                                     pattern = "2071-2100_ipsl-cm6a-lr_ssp585",
                                     full.names = TRUE))

# Cropping to roi ---------------------------------------------------------

fut_2011_2040_126_crop <- crop(fut_2011_2040_126, roi_buffer, mask = T)
fut_2011_2040_585_crop <- crop(fut_2011_2040_585, roi_buffer, mask = T) 
fut_2041_2070_126_crop <- crop(fut_2041_2070_126, roi_buffer, mask = T)
fut_2041_2070_585_crop <- crop(fut_2041_2070_585, roi_buffer, mask = T)
fut_2071_2100_126_crop <- crop(fut_2071_2100_126, roi_buffer, mask = T)
fut_2071_2100_585_crop <- crop(fut_2071_2100_585, roi_buffer, mask = T)

# Renaming predictor variables --------------------------------------------

names(bio_crop) <- c("bio1", paste0("bio", 10:19), paste0("bio", 2:9))
names(fut_2011_2040_126_crop) <- names(bio_crop)
names(fut_2011_2040_585_crop) <- names(bio_crop)
names(fut_2041_2070_126_crop) <- names(bio_crop)
names(fut_2041_2070_585_crop) <- names(bio_crop)
names(fut_2071_2100_126_crop) <- names(bio_crop)
names(fut_2071_2100_585_crop) <- names(bio_crop)



# Future ------------------------------------------------------------------

# afrocarpus SSP 126 Period 2011-2040
fut_all <- c(fut_2011_2040_126_crop , elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)

fut_126_2011_2040_used <- exclude(fut_all , v)

p_fut <- predict(m, fut_126_2011_2040_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_coffea126_2011-2040.tif")




#disaggregate future 2011-2040  126 
fut_126_1140_dis <- disagg(x = fut_all, fact = 30)
#save future_126_1140_dis 
fut_126_1140_dis <- rast("output/fut_126_1140_dis.tif")

# Read it back correctly
fut_126_1140_dis <- rast("output/fut_126_1140_dis.tif")

fut_126_2011_2040_used <- exclude(fut_126_1140_dis , v)

p_fut <- predict(m, fut_126_2011_2040_used, id=c(5,3,8),mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_afrocarpus126_2011-2040.tif")

# For the future 126 2011-2040

p_fut <- rast("output/future_pred_afrocarpus126_2011-2040.tif")
pa <- sdm::pa(x = p_fut, y = m, id ="ensemble", opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')
#project for Taita
taita_proj <- project(taita, crs(pa))
Taita_crop <- mask(crop(pa, taita_proj),taita_proj)

expanse(Taita_crop , unit = 'ha')

plot(Taita_crop)


# afrocarpus SSP 126 Period 2041-2070
fut_all <- c(fut_2041_2070_126_crop)

fut_126_2041_2070_used <- exclude(fut_all , v)

p_fut <- predict(m, fut_126_2041_2070_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_afrocarpus126_2041-2070.tif",overwrite=TRUE)
#AOA
aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)


# For the future 126 2041-2070

p_fut <- rast("output/future_pred_afrocarpus126_2041-2070.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')

#change quantification EA 126 2041-2070
cur <- rast("output/current_pred_afrocarpus.tif")
fut <- rast( "output/future_pred_afrocarpus126_2041-2070.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)


ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2,3),
                         label = c("Unsuitable","Gain","Suitable",
                                   
                                   "Loss"
                         ))
plot(ch, col = c("gray","yellow", "Green","red"))
plot(ch, col = c("gray", "red"), main = "Afrocarpus  area change map  under SSP 126 mid century")
writeRaster(ch, "change/afrocarpus_changemap126_2041-2070.tif")
# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)

#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)
expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)





#Afro SSP 126 2071-2100
fut_all <- c(fut_2071_2100_126_crop)

fut_126_2071_2100_used <- exclude(fut_all , v)

p_fut <- predict(m, fut_126_2071_2100_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_afrocarpus126_2071-2100.tif",overwrite=TRUE)

#AOA
aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)


# For the future 126 2071-2100

p_fut <- rast("output/future_pred_afrocarpus126_2071-2100.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')

#change quantification EA 126 2071-2100
cur <- rast("output/current_pred_afrocarpus.tif")
fut <- rast("output/future_pred_afrocarpus126_2071-2100.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)


ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2, 3),
                         label = c("Unsuitable","Gain","suitable",
                                   
                                   "loss"
                         ))
plot(ch, col = c("gray","yellow","Green","red"))
plot(ch, col = c("gray",  "red"), main = "Afrocarpus area change under SSP 126 late century")
writeRaster(ch, "change/afrocarpus_changemap126_2071-2100_taita.tif")
# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)

#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)
expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)









# afrocarpus SSP 585 Period 2041-2070
fut_all <- c(fut_2041_2070_585_crop)


fut_585_2041_2070_used<- exclude(fut_all , v)

p_fut <- predict(m, fut_585_2041_2070_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_afrocarpus585_2041-2070.tif",overwrite=TRUE)

#AOA
aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)



# For the future 585 2041-2070

p_fut <- rast("output/future_pred_afrocarpus585_2041-2070.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')
#change quantification EA 126 2071-2100
cur <- rast("output/current_pred_afrocarpus.tif")
fut <- rast("output/future_pred_afrocarpus585_2041-2070.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)


ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2, 3),
                         label = c("Unsuitable","Gain","suitable",
                                   
                                   "Loss"
                         ))

plot(ch, col = c("gray","yellow","Green","red"))
plot(ch, col = c("gray",  "red"), main = "Afrocarpus habitat area change under SSP 585 mid century")

writeRaster(ch, "change/afrocarpus_changemap585_2041-2070.tif")
# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)

expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)


# afrocarpus SSP 585 Period 2071-2100 
fut_all <- (fut_2071_2100_585_crop)

fut_585_2071_2100_used<- exclude(fut_all , v)

p_fut <- predict(m, fut_585_2071_2100_used, mean = T)

plot(p_fut)
writeRaster(p_fut, "output/future_pred_afrocarpus585_2071-2100.tif",overwrite=TRUE)
#AOA
aoa_p <- aoa(x = exclude(fut_all, v), 
             d = d)
plot(aoa_p)




# For the future 585 2071-2100

p_fut <- rast("output/future_pred_afrocarpus585_2071-2100.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')
#change quantification EA 126 2071-2100
cur <- rast("output/current_pred_afrocarpus.tif")
fut <- rast("output/future_pred_afrocarpus585_2071-2100.tif")
cur_pa <- pa(x = cur, y = m, id =1, opt = 2)
fut_pa <- pa(x = fut, y = m, id =1, opt = 2)

cur_pa <- as.factor(cur_pa)
levels(cur_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))
fut_pa <- as.factor(fut_pa)
levels(fut_pa) <- data.frame(value = c(0, 1),
                             label = c("Absence", 
                                       "Presence"))

par(mfrow = c(1, 2))
plot(cur_pa, col = c("gray", "darkgreen"), main = "Current")
plot(fut_pa, col = c("gray", "darkgreen"), main = "Future")

# change map --------------------------------------------------------------
ch <- rast(cur_pa)

ch[] <- ifelse(cur_pa[] == 0 & fut_pa[] == 0, 0, # Unsuitable
               ifelse(cur_pa[] == 0 & fut_pa[] == 1, 1, # Gain
                      ifelse(cur_pa[] == 1 & fut_pa[] == 1, 2, 3))) # Suitable, Loss

plot(ch)


ch <- as.factor(ch)
levels(ch) <- data.frame(value = c(0,1,2, 3),
                         label = c("Unsuitable","Gain","suitable",
                                   
                                   "loss"
                         ))
plot(ch, col = c("gray","yellow","Green","red"))
plot(ch, col = c("gray", "red"), main = "Afrocarpus habitat  area change under SSP 585 late century")
writeRaster(ch, "change/afrocarpus_changemap585_2071-2100.tif")
# Calculate area change ---------------------------------------------------

#df_area <- expanse(change, unit = 'km', byValue = TRUE)
expanse(ch , unit = 'km')
#per category
expanse(ch , unit = 'km',byValue = TRUE)
#Taita fragments 
taita <- vect("data/roi/taita.gpkg")
plot(taita)
Taita_crop <- crop(ch, taita, touches = F, mask = T)

expanse(Taita_crop , unit = 'km', byValue = TRUE)
#north_Tz fragments
north_tz <- vect("data/roi/north_tz.gpkg")
plot(north_tz)
northtz_crop <- crop(ch, north_tz, touches = F, mask = T)

expanse(northtz_crop , unit = 'km', byValue = TRUE)

#South Tz fragments 
south_tz <- vect("data/roi/south_tz.gpkg")
plot(south_tz)
southtz_crop <- crop(ch, south_tz, touches = F, mask = T)

expanse(southtz_crop , unit = 'km', byValue = TRUE)






































# Reading in the current predictor variables(worldclim_data) --------------------------------------

# Bioclimatic 
bio <- rast("data/bioclimatic/current/tile_44_wc2.1_30s_bio.tif")

# Topographic
elev <- rast("data/Elevation/wc2.1_30s_elev.tif")
slope <- terrain(elev, "slope")
aspect <- terrain(elev, "aspect")

# Edaphic
ph_5 <- rast("data/Soil/soil_af/Soil_ph/af_ph_0-5cm_30s.tif")
ph_15 <- rast("data/Soil/soil_af/Soil_ph/af_ph_5-15cm_30s.tif")
carbon_5 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_0-5cm_30s.tif")
carbon_15 <- rast("data/Soil/soil_af/soil_carbon/soil_af/af_soc_5-15cm_30s.tif")

# Cropping to roi ---------------------------------------------------------

bio_crop <- crop(bio, roi_buffer, mask = T)
elev_crop <- crop(elev, roi_buffer, mask = T)
slope_crop <- crop(slope, roi_buffer, mask = T)
aspect_crop <- crop(aspect, roi_buffer, mask = T)
ph_5_crop <- crop(ph_5, roi_buffer, mask = T)
ph_15_crop <- crop(ph_15, roi_buffer, mask = T)
carbon_5_crop <- crop(carbon_5, roi_buffer, mask = T)
carbon_15_crop <- crop(carbon_15, roi_buffer, mask = T)

# Renaming predictor variables --------------------------------------------

names(bio_crop) <- paste0("bio", 1:19)
names(elev_crop) <- "elevation"
names(slope_crop) <- "slope"
names(aspect_crop) <- "aspect"
names(ph_5_crop) <- "ph5"
names(ph_15_crop) <- "ph15"
names(carbon_5_crop) <- "carbon5" 
names(carbon_15_crop) <- "carbon15"

# Combining all the current predictors together ---------------------------

preds <- c(bio_crop, elev_crop, slope_crop, aspect_crop, 
           ph_5_crop, ph_15_crop, carbon_5_crop, carbon_15_crop)

# Multicollinearity -------------------------------------------------------

# afro_ext <- terra::extract(preds, afro_vect)
# coffea_ext <- terra::extract(preds, coffea_vect)
# milletia_ext <- terra::extract(preds, milletia_vect)
# 
# afro_v <- vifcor(afro_ext[, -1], th = 0.7)
# coffea_v <- vifcor(coffea_ext[, -1], th = 0.7)
# milletia_v <- vifcor(milletia_ext[, -1], th = 0.7, 
#                      keep = c("", ""))
set.seed(248)

v <- vifcor(preds, th = 0.7, keep = 'elevation')

# Remaining predictor variables used --------------------------------------

preds_used <- exclude(preds, v)

# Creating an sdmData object ----------------------------------------------

d <- sdmData(formula = species ~., 
             train = afro_vect, 
             predictors = preds_used, 
             bg = 1000)

# Calibrating the sdm model -----------------------------------------------

m <- sdm(formula = species ~., 
         data = d, 
         methods = "maxent",
         replications = "boot", # sub, cv
         test.percent = 30,
         n = 10) # Number of runs---iterations---replicates

write.sdm(m, "models/afro.sdm")



# Some plots --------------------------------------------------------------

m <- read.sdm("models/afrocarpus.sdm")

png(filename = 'plots/roc.png', height = 1200, width = 1200, res = 200)
roc(m)
dev.off()

rcurve(m)
ggsave(dpi = 400, width = 18, height = 6,
       filename = "plots/rcurve.png")

plot(getVarImp(m))
ggsave(dpi = 400, width = 6, height = 4, 
       filename = "plots/var_imp.png")

# Predicting current potential suitable habitat ---------------------------

p <- predict(m, newdata = preds_used, mean = T)

plot(p) # Not in the buffer, concentrated up the mountain

writeRaster(p, "output/current_pred.tif")

# Current presence absence map

p <- rast("output/current_pred.tif")
pa <- sdm::pa(x = p, y = m, id = 1, opt = 2)
plot(pa)

taita  <- vect("E:/Taita forests/Taita forests/Taita_forests.shp")

ngangao <- taita[taita$Name == "Mbololo", ]

ngangao_proj <- project(ngangao, crs(pa))

pa_ngangao <- mask(crop(pa, ngangao_proj), 
                   ngangao_proj, touches = F)

# Taita forests as a whole ------------------------------------------------

taita_proj <- project(taita, crs(pa))

plot(mask(crop(pa, taita_proj), taita_proj))
plot(taita_proj, add = T, col = 'red', lwd = 2)


expanse(x = pa, zones = pa, unit = 'km')



# Future ------------------------------------------------------------------

# afro SSP 245 Period 2041-2060,2061-2080

# afro SSP 245 2041-2060

fut_245_4160 <- rast("data/bioclimatic/future/bioc_245_2041-2060.tif")
names(fut_245_4160) <- paste0("bio", 1:19)

fut_245_4160_crop <- crop(fut_245_4160, roi_buffer, mask = T)

fut_all <- c(fut_245_4160_crop , elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_245_4160_used <- subset(fut_all, v)

p_fut_245_4160 <- predict(m, fut_245_4160_used, mean = T)

plot(p_fut_245_4160 )
writeRaster(p_fut_245_4160 , "output/future_pred_afro245_4160.tif",overwrite=T)

# For the future

p_fut <- rast("output/future_pred_afro245_4160.tif")
pa_f <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa_f)


# Change quantification ---------------------------------------------------

pa # current binary
pa_f # future binary

change <- rast(pa) # Empty raster/template

# 1 pa 1---pa_f 1 Suitable
# 2 pa 1---pa_f 0 Loss
# 3 pa 0---pa_f 1 Gain/Expansion
# 4 pa 0---pa_f 0 Unsuitable

change[] <- ifelse(pa[] == 1 & pa_f[] == 1, 1,
                   ifelse(pa[] == 1 & pa_f[] == 0, 2,
                          ifelse(pa[] == 0 & pa_f[] == 1, 3, 4)))

plot(change)
expanse(x = change, byValue = TRUE, unit = 'km')

# Taita change ------------------------------------------------------------

taita_change <- mask(crop(change, taita_proj), taita_proj)
expanse(taita_change, byValue = T, unit = "km")









# afro SSP 245 2061-2080

fut_245_6180 <- rast("data/bioclimatic/future/bioc_245_2061-2080.tif")
names(fut_245_6180) <- paste0("bio", 1:19)

fut_245_6180_crop <- crop(fut_245_6180, roi_buffer, mask = T)

fut_all <- c(fut_245_6180_crop , elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_245_6180_used <- subset(fut_all, v)

p_fut_245_6180 <- predict(m, fut_245_6180_used, mean = T)

plot(p_fut_245_6180 )
writeRaster(p_fut_245_6180 , "output/future_pred_afro245_6180.tif",overwrite=T)

# For the future

p_fut <- rast("output/future_pred_afro245_6180.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')


# afro SSP 585 2041-2060

fut_585_4160 <- rast("data/bioclimatic/future/bioc_585_2041-2060.tif")
names(fut_585_4160) <- paste0("bio", 1:19)

fut_585_4160_crop <- crop(fut_585_4160, roi_buffer, mask = T)

fut_all <- c(fut_585_4160_crop , elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_585_4160_used <- subset(fut_all, v)

p_fut_585_4160 <- predict(m, fut_585_4160_used, mean = T)

plot(p_fut_585_4160)
writeRaster(p_fut_585_4160 , "output/future_pred_afro585_4160.tif",overwrite=T)

# For the future

p_fut <- rast("output/future_pred_afro585_4160.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')

# afro SSP 585 2061-2080

fut_585_6180 <- rast("data/bioclimatic/future/bioc_585_2061-2080.tif")
names(fut_585_6180) <- paste0("bio", 1:19)

fut_585_6180_crop <- crop(fut_585_6180, roi_buffer, mask = T)

fut_all <- c(fut_585_6180_crop  , elev_crop, slope_crop, aspect_crop,
             carbon_5_crop, carbon_15_crop, ph_5_crop, ph_15_crop)
v <- c(paste0("bio", c(6, 10, 13:14, 17)), 
       "elevation", 'slope', 'aspect', 'ph15', 'carbon15')

fut_585_6180_used <- subset(fut_all, v)

p_fut_585_6180 <- predict(m, fut_585_6180_used, mean = T)

plot(p_fut_585_6180 )
writeRaster(p_fut_585_6180 , "output/future_pred_afro585_6180.tif",overwrite=T)

# For the future

p_fut <- rast("output/future_pred_afro585_6180.tif")
pa <- sdm::pa(x = p_fut, y = m, id = 1, opt = 2)
plot(pa)

expanse(x = pa, zones = pa, unit = 'km')




















































































# Future climate data -----------------------------------------------------

# model = IPSL-CM6A-LR and EC-Earth3-Veg 
# ssp = 245, 585 # Removed 370 and 126
# time = 2021-2040, 2041-2060, 2061-2080
# Resolution = 30 arc second, about 1 km

#Download future Model= IPSL-CM6A-LR,SSP=245 period(2021-2040;2041-2060,2061-2080,2018-2100)


library(geodata)

times <- c("2021-2040", "2041-2060", "2061-2080", "2081-2100")

ssp <- c( "245", "585")

for (t in times){
  for (s in ssp){
    data <- cmip6_tile(lon = 38.25,
                       lat = -4.21,
                       model = "IPSL-CM6A-LR",
                       ssp = s,
                       time = t,
                       var = "bioc",
                       path = "data/bioclimatic/future")
    filename <- paste0("data/bioclimatic/future/bioc_", s, "_", t, ".tif")
    writeRaster(data, filename, overwrite = TRUE)
    
  }
}


# Cropping the bioclim variables to the buffer boundaries -----------------

elev <- rast("data/wc2.1_30s_elev.tif") # Reading/Loading elevation data

elev_crop <- crop(elev, roi_buffer, mask = TRUE) # Cropping the raster to bounds of roi_buffer

plot(elev_crop) # Plotting the elev_crop
plot(roi_buffer, add = T, lwd = 4, border = 'yellow')

mapview(elev_crop)

# Creating slope and aspect -----------------------------------------------

# Slope
slope <- terrain(elev_crop, 'slope')
plot(slope)

# Aspect
aspect <- terrain(elev_crop, "aspect")
plot(aspect)
#DOWNLOAD SOIL variables
# Please note that you have to set download=T if you haven't downloaded the data before:
#soil at depth of 0-5cm
SOIL <- geodata::soil_af(var = 'pH', depth = '5', 
                         path = 'data/Soil', 
                         download = TRUE)
library(terra)
cropped_soil <- crop(SOIL, roi_buffer, mask = T)
#Soil at depth of 5-15 cm
SOIL <- geodata::soil_af(var = 'pH', depth = '15', 
                         path = 'data/Soil', 
                         download = TRUE)
cropped_soil <- crop(SOIL, roi_buffer, mask = T)

#download soil carbon at 0cm-5cm depth
Soil_carbon<-geodata::soil_af(var = 'SOC', depth = '5', 
                              path = 'data/Soil/soil_af/soil_carbon', 
                              download = TRUE)
#download soil carbon at 5cm-15cm depth                       
Soil_carbon<-geodata::soil_af(var = 'SOC', depth = '15', 
                              path = 'data/Soil/soil_af/soil_carbon', 
                              download = TRUE)




































