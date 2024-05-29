# Title: HTLN_InvasivePlant_Monitoring_processing

# COMMENTS ON SCRIPT: ----
# Abigail Hobbs, ahobbs@nps.gov, v03/20/24
# Updated By: 

# Abstract: This dataset consists of occurrence and cover class observations for problematic invasive plants (so-called “problematic plants”) in the National Park Service Heartland Inventory and Monitoring Network Parks. The dataset includes approximately 35,000 individual cover class estimates covering over 120 problematic plant species observed at 13 NPS park units taken between 2006 and 2022. Problematic plant species include invasive, exotic, and harmful plant species. They fragment native ecosystems, displace native plants and animals and alter ecosystem function. In National Parks, such species negatively affect park resources and visitor enjoyment by altering landscapes and fire regimes, reducing native plant and animal habitat, and increasing trail maintenance needs. Recognizing these challenges, Heartland Inventory and Monitoring (I&M) Network parks identified problematic plants as the highest-ranking vital sign across the network. The goals and objectives associated with this dataset are described in the protocol - Kull KA, Young CC, Haack-Gaynor JL, Morrison LW, DeBacker MD. 2022. Problematic plant monitoring protocol for the Heartland Inventory and Monitoring Network: Narrative, version 2.0. Natural Resource Report. NPS/HTLN/NRR—2022/2376. National Park Service. Fort Collins, Colorado. https://doi.org/10.36967/nrr-2293355
 
# Notes: 
#   1. Code values for CoverClassInMetersSquared (available on page 10 of the aforementioned 'Problematic Plant Monitoring Protocol for the Heartland Inventory and Monitoring. 2022' and duplicated in the tlu_CoverClass.csv look-up table) were directly integrated into the column variables to clarify the meaning of each value.
#   2. Within the CoverClassInMetersSquared column of the raw data file, the code used to represent '1,000–4,999.9' was incorrectly listed as '7', '8', and '9', when it should have only been '7'. This was corrected with the approval of HTLN's Haack-Gaynor JL.
#   3. A missing decimal was added to the LongitudeInDecimalDegrees for Hopewell Culture National Historical Park.

# INITIAL SETUP: ----
## Clean global environment and set working directory: ----
### Working directory is user dependent, so set as needed.
rm(list=ls())
getwd()

### Working directory is user dependent, so set as needed.
setwd()

## Packages: ----
## Load commonly used packages:
packages = c("tidyverse", "terra", "geosphere", "readxl", "readr", "janitor", "here", "stringr", "lubridate", "taxize", "devtools", "sf", "furrr", "data.table") 

## The following function checks 1) are the packages in the list "packages" installed? If not, install them 2) Are the packages in "packages" loaded? If not, load the packages using library():
package.check <- lapply( 
  packages, 
  FUN = function(x) { 
    if (!require(x, character.only = TRUE)) { 
      install.packages(x, dependencies = TRUE) 
      library(x, character.only = TRUE) } } )

## Will also need to install NPSdataverse from Github if not previously installed:
devtools::install_github("nationalparkservice/NPSdataverse")
library(NPSdataverse)

# READ IN FILES: ----
Plantoutput<-read_csv("qryexp_InvasivePlants.csv",
	show_col_types = FALSE)
Plantoutput<-read_csv("qryexp_InvasivePlants.csv",
	col_names = c("ParkName", "ParkCode", "LocationID", "PeriodID", "CoverClassInMetersSquared", "CommonName", "VerbatimIdentification", "LatitudeInDecimalDegrees", "LongitudeInDecimalDegrees"),
	show_col_types = FALSE,
	skip=1)

Coverclass<-read_csv("tlu_CoverClass.csv",
	show_col_types = FALSE)
Coverclass<-read_csv("tlu_CoverClass.csv",
	col_names = c("CoverClass", "LowRange", "MidRange", "HighRange"),
	show_col_types = FALSE,
	skip=1)

Coord<-read_csv("HtlnInvasiveUtmCoordinates.csv",
	show_col_types = FALSE)
Coord<-read_csv("HtlnInvasiveUtmCoordinates.csv",
	col_names = c("LocationID", "Easting", "Northing"),
	show_col_types = FALSE,
	skip=1)

# CLEAN DATA: ----
## Join files: ----
Plantdata <- Plantoutput %>%
  left_join(Coord, by='LocationID')

## Add and remove columns: ----
### Add column for Date (by extracting the date from the PeriodID column):
Plantdata <- Plantdata %>% mutate(Date = PeriodID)
Plantdata$Date <- gsub("^..........", "", Plantdata$Date)
Plantdata$Date = as.Date(Plantdata$Date, format = "%Y%B%d")

### Add Zone column:-
Plantdata <- Plantdata %>% mutate(Zone = ParkCode) 
Plantdata <- Plantdata %>% mutate(Zone = case_when(
    Zone == "ARPO" ~ "15N",
    Zone == "CUVA" ~ "17N",
    Zone == "EFMO" ~ "15N",
    Zone == "GWCA" ~ "15N",
    Zone == "HEHO" ~ "15N",
    Zone == "HOCU" ~ "17N",
    Zone == "HOME" ~ "14N",
    Zone == "HOSP" ~ "15N",
    Zone == "LIBO" ~ "16N",
    Zone == "PERI" ~ "15N",
    Zone == "PIPE" ~ "14N",
    Zone == "TAPR" ~ "14N",
    Zone == "WICR" ~ "15N"))
Plantdata <- Plantdata %>% mutate(Eas = "E") 
Plantdata <- Plantdata %>% mutate(Nor = "N") 

### Add GeodeticDatum column:
Plantdata <- Plantdata %>% mutate(GeodeticDatum = "EPSG:4326") 

### Add VerbatimCoordinates column:
Plantdata <- Plantdata %>% mutate(VerbatimCoordinates = with(Plantdata, paste0(Zone, " ", Easting, Eas, " ", Northing, Nor)))

### Remove intermediary columns:
Plantdata$Zone <- NULL
Plantdata$Eas <- NULL
Plantdata$Nor <- NULL
Plantdata$Easting <- NULL
Plantdata$Northing <- NULL

### Add VerbatimCoordinatesSystem column:
Plantdata <- Plantdata %>% mutate(VerbatimCoordinatesSystem = "UTM")

### Add VerbatimSRS column:
Plantdata <- Plantdata %>% mutate(VerbatimSRS = "EPSG:26915")

### Add columns for Type and BasisofRecord:
Plantdata <- Plantdata %>% mutate(Type = "Event", BasisofRecord = "HumanObservation" )

### Add column for scientificName (Check scientific names against ITIS, see which (if any) can be corrected, join to dataframe, and rename to Darwin Core standards):
scinames <- gnr_resolve(sci = unique(Plantdata$VerbatimIdentification), data_source_ids = 3,
canonical = TRUE, ) 
setdiff(Plantdata$VerbatimIdentification, scinames$user_supplied_name)
scinames <- scinames %>% select("user_supplied_name", "matched_name2") 
Plantdata <- left_join(Plantdata, scinames, by = c("VerbatimIdentification" = "user_supplied_name"))
Plantdata <- rename(Plantdata, "ScientificName" = "matched_name2")

### Add column for TaxonRank:
Plantdata <- Plantdata %>%
mutate(taxonRank = "species")
Plantdata <- QCkit::get_taxon_rank(Plantdata, "ScientificName")

## Format column names and variables: ----
### Standardize capitalization within columns:
names(Plantdata)[names(Plantdata) == 'taxonRank'] <- 'TaxonRank'
Plantdata$TaxonRank[ Plantdata$TaxonRank == "species" ] <- "Species"
Plantdata$TaxonRank[ Plantdata$TaxonRank == "genus" ] <- "Genus"
Plantdata$TaxonRank[ Plantdata$TaxonRank == "subspecies" ] <- "Subspecies"
str_sub(Plantdata$CommonName, 1, 1) <- str_sub(Plantdata$CommonName, 1, 1) %>% str_to_upper()
Plantdata$CommonName[ Plantdata$CommonName == "Bald brome. spiked brome" ] <- "Bald brome or Spiked brome"
Plantdata$CommonName[ Plantdata$CommonName == "Burningbush. winged euonymus" ] <- "Burningbush or Winged euonymus"
Plantdata$CommonName[ Plantdata$CommonName == "Caucasian bluestem. Australian bluestem" ] <- "Caucasian bluestem or Australian bluestem"
Plantdata$CommonName[ Plantdata$CommonName == "Hardy orange. trifoliate orange" ] <- "Hardy orange or Trifoliate orange"
Plantdata$CommonName[ Plantdata$CommonName == "Nepalese browntop. Japanese stiltgrass" ] <- "Nepalese browntop or Japanese stiltgrass"
Plantdata$CommonName[ Plantdata$CommonName == "Yellow bluestem. King Ranch bluestem" ] <- "Yellow bluestem or King Ranch bluestem"

## Correct data issues: ----
### Correct code issue in CoverClassInMetersSquared column:
Plantdata$CoverClassInMetersSquared[ Plantdata$CoverClassInMetersSquared == "8" ] <- "7"
Plantdata$CoverClassInMetersSquared[ Plantdata$CoverClassInMetersSquared == "9" ] <- "7"

### Add missing decimal to LongitudeInDecimalDegrees column:
Plantdata$LongitudeInDecimalDegrees <- Plantdata$LongitudeInDecimalDegrees %>% str_replace_all('\\.', '')

Plantdata$LongitudeInDecimalDegrees <- paste0(substr(Plantdata$LongitudeInDecimalDegrees, 1, 3), ".", substr(Plantdata$LongitudeInDecimalDegrees, 4, nchar(Plantdata$LongitudeInDecimalDegrees)))

## Convert coded values: ----
Plantdata <- Plantdata %>% mutate(CoverClassInMetersSquared = case_when(
    CoverClassInMetersSquared == "1" ~ " 0.1 - 0.9",
    CoverClassInMetersSquared == "2" ~ " 1 - 9.9",
    CoverClassInMetersSquared == "3" ~ " 10 - 49.9",
    CoverClassInMetersSquared == "4" ~ " 50 - 99.9",
    CoverClassInMetersSquared == "5" ~ " 100 - 499.9",
    CoverClassInMetersSquared == "6" ~ " 499.9 - 999.9",
    CoverClassInMetersSquared == "7" ~ " 1,000 - 4,999.9"))

## Order columns: ----
Plantdata <- Plantdata[, c("ParkName", "ParkCode", "LocationID", "PeriodID", "CoverClassInMetersSquared", "CommonName", "VerbatimIdentification", "LatitudeInDecimalDegrees", "LongitudeInDecimalDegrees", "GeodeticDatum", "VerbatimCoordinates", "VerbatimCoordinatesSystem", "VerbatimSRS", "Date", "Type", "BasisofRecord", "ScientificName", "TaxonRank")]

# EXPORT CLEANED .CSV: ----
write_csv(Plantdata, "C:/Users/ahobbs/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/invasive_plants/02_processed_data/data_processing/Data/HTLN_InvasivePlants_Monitoring_cleaned.csv")