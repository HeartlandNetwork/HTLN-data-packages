# Title: HTLN_WhiteTailedDeer_SamplingEvents_processing

# COMMENTS ON SCRIPT: ----
# Abigail Hobbs, ahobbs@nps.gov, v03/19/24
# Updated By: 

# Abstract: Because of their impacts on vegetation, disease transmission, visitor health, and vehicle-deer collisions, park managers at Arkansas Post National Memorial, Pea Ridge National Military Park, and Wilson’s Creek National Battlefield identified white-tailed deer as a vital sign for monitoring (DeBacker et al. 2005). Monitoring white-tailed deer populations better positions park management to take action to mitigate concerns involving deer. The overall goals of HTLN white-tailed deer monitoring are to 1) document annual changes in the number of white-tailed deer, changes could signal presence of illegal deer harvest, disease, or other acute factors of concern for park management; 2) document long-term trends in the number of white-tailed deer to help park management determine if measures need to be taken to maintain herd health, minimize vegetation damage within a park, or alleviate visitor health concerns; and 3) annually map locations of white-tailed deer observed to assist park management in assessing the influences of management actions on deer usage of an area, habitat type, etc.

# Databases drawn from the following links: Coded values were retrieved from SOP #4 Conducting the Spotlight Survey.docx: https://irma.nps.gov/DataStore/DownloadFile/619941

# Notes: Within the raw data, the ObjectID column was simply an autonumber, and has been removed with the approval of HTLN's Haack-Gaynor JL.

# INITIAL SETUP: ----
## Clean global environment and set working directory: ----
### Working directory is user dependent, so set as needed.
rm(list=ls())
getwd()

### Working directory is user dependent, so set as needed.
setwd()

## Packages: ----
### Load commonly used packages: 
packages = c("tidyverse", "terra", "geosphere", "readxl", "readr", "janitor", "here", "stringr", "lubridate", "taxize", "devtools", "sf", "furrr", "data.table") 

### The following function checks 1) are the packages in the list "packages" installed? If not, install them 2) Are the packages in "packages" loaded? If not, load the packages using library().
package.check <- lapply( 
  packages, 
  FUN = function(x) { 
    if (!require(x, character.only = TRUE)) { 
      install.packages(x, dependencies = TRUE) 
      library(x, character.only = TRUE) } } )

### Will also need to install NPSdataverse from Github if not previously installed:
#devtools::install_github("nationalparkservice/NPSdataverse")
library(NPSdataverse)

# READ IN FILES: ----
Deerdata<-read_csv("HtlnDeerSamplingEvents2.csv",
	na = c("", "N/A", "NULL"),
	show_col_types = FALSE)
Deerdata<-read_csv("HtlnDeerSamplingEvents2.csv",
	col_names = c("EventID", "PeriodID", "ParkCode", "Route", "SurveyNumber", "Round", "DeerDate", "StartTime", "BeginningTemperatureInCelsius", "BeginningHumidityInPercent", "BeginningWindInMetersPerSecond", "BeginningWindDirectionInDegrees", "BeginningPrecipitation", "EndTime", "EndingTemperatureInCelsius", "EndingHumidityInPercent", "EndingWindInMetersPerSecond", "EndingWindDirectionInDegrees", "EndingPrecipitation", "MoonIlluminationInPercent", "ObjectID", "DeerTotal", "BeginningCloudCoverInPercent", "EndingCloudCoverInPercent", "FieldNotes"),
	na = c("", "N/A", "NULL"),
	show_col_types = FALSE,
	skip=1)

# CLEAN DATA: ----
## Convert coded values: ----
### Convert coded values in BeginningCloudCoverInPercent:
Deerdata <- Deerdata %>% mutate(BeginningCloudCoverInPercent = case_when(
	BeginningCloudCoverInPercent == "0" ~ "None present",
	BeginningCloudCoverInPercent == "1" ~ "Trace - 1",
	BeginningCloudCoverInPercent == "2" ~ " 1 - 5",
	BeginningCloudCoverInPercent == "3" ~ " 5 - 25",
	BeginningCloudCoverInPercent == "4" ~ " 25 - 50",
	BeginningCloudCoverInPercent == "5" ~ " 50 - 75",
	BeginningCloudCoverInPercent == "6" ~ " 75 - 95",
	BeginningCloudCoverInPercent == "7" ~ " 95 - 100"))

### Convert coded values in EndingCloudCover:
Deerdata <- Deerdata %>% mutate(EndingCloudCoverInPercent = case_when(
	EndingCloudCoverInPercent == "0" ~ "None present",
	EndingCloudCoverInPercent == "1" ~ "Trace - 1",
	EndingCloudCoverInPercent == "2" ~ " 1 - 5",
	EndingCloudCoverInPercent == "3" ~ " 5 - 25",
	EndingCloudCoverInPercent == "4" ~ " 25 - 50",
	EndingCloudCoverInPercent == "5" ~ " 50 - 75",
	EndingCloudCoverInPercent == "6" ~ " 75 - 95",
	EndingCloudCoverInPercent == "7" ~ " 95 - 100"))

### Convert coded values in BeginningPrecipitation:
Deerdata <- Deerdata %>% mutate(BeginningPrecipitation = case_when(
	BeginningPrecipitation == "0" ~ "No rain",
	BeginningPrecipitation == "1" ~ "Mist or fog",
	BeginningPrecipitation == "2" ~ "Light drizzle",
	BeginningPrecipitation == "3" ~ "Light rain",
	BeginningPrecipitation == "4" ~ "Heavy rain difficult to hear",
	BeginningPrecipitation == "5" ~ "Snow"))

### Convert coded values in EndingPrecipitation:
Deerdata <- Deerdata %>% mutate(EndingPrecipitation = case_when(
	Deerdata$EndingPrecipitation == "0" ~ "No rain",
	Deerdata$EndingPrecipitation == "1" ~ "Mist or fog",
	Deerdata$EndingPrecipitation == "2" ~ "Light drizzle",
	Deerdata$EndingPrecipitation == "3" ~ "Light rain",
	Deerdata$EndingPrecipitation == "4" ~ "Heavy rain difficult to hear",
	Deerdata$EndingPrecipitation == "5" ~ "Snow"))

## Convert column type: ----
Deerdata$DeerDate = as.Date(Deerdata$DeerDate, format = "%m/%d/%Y")

## Format variables: ----
Deerdata$StartTime <- paste0(substr(Deerdata$StartTime, 1, 2), ":", substr(Deerdata$StartTime, 3, nchar(Deerdata$StartTime)))
Deerdata$StartTime <- sub( '(?<=.{5})', ':00', Deerdata$StartTime, perl=TRUE ) 
Deerdata$EndingHumidityInPercent <- gsub("NA", "-9999", paste(Deerdata$EndingHumidityInPercent))
Deerdata$EndingTemperatureInCelsius <- gsub("NA", "-9999", paste(Deerdata$EndingTemperatureInCelsius))
Deerdata$EndingWindInMetersPerSecond <- gsub("NA", "-9999", paste(Deerdata$EndingWindInMetersPerSecond))
Deerdata$BeginningWindDirectionInDegrees <- gsub("NA", "-9999", paste(Deerdata$BeginningWindDirectionInDegrees))
Deerdata$EndingWindDirectionInDegrees <- gsub("NA", "-9999", paste(Deerdata$EndingWindDirectionInDegrees))

## Standardize capitalization: ----
str_sub(Deerdata$FieldNotes, 1, 1) <- str_sub(Deerdata$FieldNotes, 1, 1) %>% str_to_upper()

## Add and remove columns: ----
### Add Type and BasisofRecord:
Deerdata <- Deerdata %>% mutate(dwcType = "Event", BasisofRecord = "HumanObservation" )

### Add scientificName:
Deerdata <- Deerdata %>% mutate(ScientificName = "Odocoileus virginianus")

### Add taxonRank and correct capitalization:
Deerdata <- Deerdata %>% mutate(taxonRank = "species")
Deerdata <- QCkit::get_taxon_rank(Deerdata, "ScientificName")
names(Deerdata)[names(Deerdata) == 'taxonRank'] <- 'TaxonRank'
Deerdata$TaxonRank[ Deerdata$TaxonRank == "species" ] <- "Species"

### Remove ObjectID column:
Deerdata$ObjectID <- NULL

# EXPORT CLEANED .CSV: ----
write_csv(Deerdata, "C:/Users/ahobbs/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/white_tail_deer/02_processed_data/data_processing/Data/HTLN_WhiteTailedDeer_SamplingEvents_cleaned.csv")