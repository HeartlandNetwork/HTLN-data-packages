library(tidyverse)
library(NPSdataverse)
library(magrittr)

# Name of the .xml file to be made (must end with the "_metadata" suffix):
metadataFilename <- "HTLN_MoBlad_metadata"

# Name of the data package (7 -- 20 words):
data.packageTitle <- "Missouri Bladderpod Monitoring Data at Wilson's Creek National Battlefield, 1997-2021 - Data Package"

# Data collection status; either "ongoing" or "complete":
dataStatus <- "ongoing"

# (string) The working directory where the .xml needs to go. Usually the same path as where the current R project is located:
destinationFolder <- getwd()

# The .csv files with the data being described by the metadata being made
## NOTE: This wildcard operator will populate the resulting vector in alphabetical order
dataFiles <- list.files("./Data", pattern = "*.csv")

# (string vector) Naming the data files more descriptively (or, adding spaces and proper capitalization to the .csv file names).
## NOTE: The order of the names need to be in the same index as the index of their corresponding files within dataFiles
dataNames <- c("HTLN Missouri Bladderpod Survey Accuracy",
               "Eastern Red Cedar Occurrences and Sizes", 
               "HTLN Missouri Bladderpod Counts, 1997-2021", 
               "HTLN Missouri Bladderpod Photosynthesis Activity")

# (string vector) Adding a short description of what the dataset describes/contains. Should be about 10 words or less
## NOTE: The order of the descriptions need to be in the same index as the index of their corresponding files within dataFiles
dataDescriptions <- c("HTLN Missouri bladderpod accuracy data for 2006 to 2021 for grid A",
                      "Diameter of Eastern red cedars found within bladderpod survey grid A at WICR", 
                      "HTLN Missouri bladderpod survey data from 1997 to 2021 for 10 grids",
                      "Photosynthetically Active Radiation of Missouri bladderpod in grid A in 2007-2008, and 2015")

# Placeholder URLs -- to be updated later on once the DOI is made
dataURL <- c(rep("https://doi.org/10.57830/2303034", length(dataFiles)))

# Taxonomic Information ----

## (string or vector of strings) Indicate the .csv datasets where scientific names are a categorical value of one of its attributes
data.TaxaTables <- dataFiles

## (string/vector of strings) List the attribute/column name(s) which contain scientific names in each file
### NOTE: The order of the column names need to be in the same index as the index of their correspoinding files within data.TaxaTables
data.TaxaAttributes <- c(rep("scientificName", length(dataFiles)))

# Geographic Information ----

## (string/vector of strings) List the .csv datasets where coordinates are a numerical value of one of its attributes
# data.CoordinatesTable <- c("Data Files with Coordinates")

## (string/vector of strings) List the attribute(s)/column name(s) which contain coordinates in each file
# data.Latitude <- "Latitude"
# data.Longitude <- "Longitude"

## (string/vector of strings) List the attribute containing the park unit ID
data.SiteName <- "ParkCode"

# The start and end dates of data collection
startDate <- ymd("1997-01-01")
endDate <- ymd("2021-12-31")

# `EMLassemblyline` `.txt` Template Generation ----
#* Use `EMLeditor` to change this to the "Restricted" prompt once the XML is generated
EMLassemblyline::template_core_metadata(
                        path                    = "./Data",
                        license                 = "CC0")

## This will spawn attributes_*.txt files based on the contents of dataFiles. Be sure to edit these before executing template_categorical_variables!
EMLassemblyline::template_table_attributes(
                        path                    = "./Data",
                        data.table              = dataFiles,
                        write.file              = TRUE)

EMLassemblyline::template_categorical_variables(
                        path                    = "./Data",
                        write.file              = TRUE)

# Geographic Coverage ----
## Make sure your coordnate values are in lat/lon format. If not, be sure to convert the coordinates to this format before continuing
# EMLassemblyline::template_geographic_coverage(
#                         path                    = destinationFolder,
#                         data.path               = destinationFolder,
#                         data.table              = data.CoordinatesTable,
#                         lat.col                 = data.Latitude,
#                         lon.col                 = data.Longitude,
#                         site.col                = data.SiteName,
#                         write.file              = TRUE)

# Taxonomic Coverage ----
## NOTE: The taxa.authority param can accept a vector of integers, where the first item is your most preferred database to check the names against.
## 3 = ITIS ; 9 = WORMS ; 11 = GBIF
EMLassemblyline::template_taxonomic_coverage(
                        path                    = "./Data",
                        data.path               = "./Data",
                        taxa.table              = data.TaxaTables,
                        taxa.col                = data.TaxaAttributes,
                        taxa.authority          = 3,
                        taxa.name.type          = "scientific",
                        write.file              = TRUE)

# EML Make

myXML <- EMLassemblyline::make_eml(
                        path                    = "./Data",
                        data.path               = "./Data",
                        eml.path                = getwd(),
                        dataset.title           = data.packageTitle,
                        data.table              = dataFiles,
                        data.table.name         = dataNames,
                        data.table.description  = dataDescriptions,
                        data.table.url          = dataURL,
                        temporal.coverage       = c(startDate, endDate),
                        maintenance.description = dataStatus,
                        package.id              = metadataFilename,
                        return.obj              = TRUE,
                        write.file              = TRUE)

myXML %>% EML::eml_validate()

# Add Controlled Unclassified Information (CUI) codes
## PUBLIC: Does not contain CUI ; FED ONLY: Contains CUI, only feds have access ; FEDCON: Contains CUI, feds and contractors have access
## DL ONLY: Contains CUI, only a designated list of individuals have access ; NOCON: Contains CUI, gov't officials sans contractors have access
myXML %<>% EMLeditor::set_cui(cui_code = "FED ONLY")

# Set intellectual rights
## public: If no CUI, default to public ; CC0: If a partner org/agency wants to work on the data, this designation is needed
## restricted: If CUI is present, restricted must be used
myXML %<>% EMLeditor::set_int_rights("Restricted")

# Add a DOI
myXML %<>% EMLeditor::set_doi(2303034)
# myXML %<>% EMLeditor::set_datastore_doi(dev = TRUE)

# Add DRR information, if applicable
# myXML %>% EMLeditor::set_drr(DOI of DRR, "DOI of DRR")

# Set the language of the file. This will usually be eng
myXML %<>% EMLeditor::set_language("English")

# Add the park units where the data was collected from
parkUnits <- c("WICR")
myXML %<>% EMLeditor::set_content_units(parkUnits)

# Add the park units whose staff created the DRR
## This may be a park unit or network code; these codes may not be the same as the codes in the previous step
myXML %<>% EMLeditor::set_producing_units(c("IMD", "HTLN"))

# Validate the EML again, just to make sure the modifications have been made appropriately
myXML %>% EML::eml_validate()

# Write out the EML file
myXML %>% EML::write_eml("HTLN_MoBlad_metadata.xml")

# Check the newly-written EML file
## Specify the directory the EML file is in, if not within the working directory
EMLeditor::check_eml()

# Check the data package that you're planning to upload the EML file to
## Specify the directory the data package is in, if not within the working directory
DPchecker::run_congruence_checks("./Data", metadata = load_metadata(getwd()))

# If everything has checked out up to this point, it's time to upload!
EMLeditor::upload_data_package("./Data")
