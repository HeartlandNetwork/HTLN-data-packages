

#options(download.file.method="wininet")
#install.packages(c("devtools", "tidyverse"))
#devtools::install_github("nationalparkservice/NPSdataverse", force = TRUE)


library(NPSdataverse)
library(tidyverse)

metadata_id <- "HTLN_BreedingBird_metadata"

package_title <- "Heartland Inventory and Monitoring Network Breeding Bird Data Package"

data_type <- "ongoing"

working_folder <- setwd("C:/users/growell/HTLN-BreedingBird-Data-Package/EML")

data_files <- c("BasalArea.csv",
                "BirdObservationsThru2022_3.csv",
                "CanopyCover.csv",
                "CanopyHeight.csv",
                "FoliarCover.csv",
                "GroundCover.csv",
                "HorizDistanceProfile.csv",
                "PlotCoordinatesDD.csv",
                "PlotPhysicalFeatures.csv",
                "PlotVegCover.csv",
                "TreeTally.csv",
                "VerticalProfile.csv")

data_names <- c("Habitat - BasalArea Data",
                "Bird Observations - Site Conditions Data",
                "Habitat - Canopy Cover Data",
                "Habitat - Canopy Height Data",
                "Habitat - Foliar Cover Data",
                "Habitat - Ground Cover Data",
                "Habitat - Horizontal Distance Profile Data",
                "Sampling Plot Coordinates",
                "Habitat - Plot Physical Features Data",
                "Habitat - Plot Vegetation Cover Data",
                "Habitat - Tree Tally Data",
                "Habitat - Vertical Profile Data")

data_descriptions <- c("Basal area of hardwood and conifer species estimated using a 10-factor English cruz-all",
                       "Bird observations taken using variable circular plots using continuous distance",
                       "Canopy cover estimated with densiometer at four cardinal directions (N, E, S, W)",
                       "Canopy heights of the tallest hardwood and coniferous trees estimated with clinometer",
                       "Percent foliar cover estimated under 1.5 high grouped into plant guilds",
                       "Percent ground cover estimated for conifer, deciduous, grass litter, rock and other classes",
                       "Horizontal vegetation profile readings taken using profile board at 15 m.",
                       "Sampling Plot Coordinates in latitude - longitude decimal degrees",
                       "Plot physical attributes including slope, aspect, and topographic description",
                       "Plot cover types estimated by percent cover classes",
                       "Tree tally data for tree species > 1.5 m based on diameter size-classes",
                       "Vertical profile of vegetion measured with 7.5 m rod")

data_urls <- c(rep("temporary URL", length(data_files)))

data_taxa_tables <- c("BirdSpeciesNames.csv","TreeSpeciesNames.csv")

data_taxa_fields <- c("ScientificName","ScientificName")


data_coordinates_table <- "PlotCoodinatesDD.csv"
data_latitutde <- "decimalLatitude"
data_longitude <- "decimalLongitude"
data_sitename <- "PlotID"


startdate <- ymd("2001-05-07")
enddate <- ymd("2022-06-15")

######################################################################################

working_folder <- setwd("C:/users/growell/HTLN-BreedingBird-Data-Package/EML")

template_core_metadata(path = working_folder, 
                       license = "CC0") # that '0' is a zero!

template_table_attributes(path = working_folder, 
                          data.table = data_files, 
                          write.file = TRUE)


template_categorical_variables(path = working_folder, 
                               data.path = working_folder, 
                               write.file = TRUE)

template_taxonomic_coverage(path = working_folder, 
                            data.path = working_folder, 
                            taxa.table = data_taxa_tables,
                            taxa.col = data_taxa_fields, 
                            taxa.authority = c(3,11),
                            taxa.name.type = 'scientific', 
                            write.file = TRUE)



my_metadata <- make_eml(path = working_folder,  
                        dataset.title = package_title,
                        data.table = data_files,
                        data.table.name = data_names,
                        data.table.description = data_descriptions,
                        data.table.url = data_urls,
                        temporal.coverage = c(startdate, enddate),
                        maintenance.description = data_type,
                        package.id = metadata_id,
                        return.obj = TRUE, 
                        write.file = FALSE)

EML::write_eml(my_metadata, "my_metadata.xml")

################################################################################

library(NPSdataverse)
library(tidyverse)
library(EML)

working_folder <- setwd("C:/users/growell/HTLN-BreedingBird-Data-Package/EML")

my_metadata <- EML::read_eml("my_metadata.xml")

eml_validate(my_metadata) 

my_metadata <- set_cui(my_metadata, "PUBLIC")

my_metadata <- set_int_rights(my_metadata, "public")

my_metadata <- set_datastore_doi(my_metadata)

my_metadata <- set_drr(my_metadata, 2299582, "Data Release Report for the Heartland Inventory and Monitoring Breeding Bird Data Package")

my_metadata <- set_language(my_metadata, "English")

park_units <- c("ARPO", "PERI", "LIBO", "EFMO", "HEHO", "TAPR", "PIPE", "GWCA", "WICR", "AGFO", "HOME", "HOCU")
my_metadata <- set_content_units(my_metadata, park_units)

my_metadata <- set_producing_units(my_metadata, "HTLN")

eml_validate(my_metadata) 

write_readme(my_metadata) 

write_eml(my_metadata, "HTLNBreedingBird_metadata.xml")

################################################################################
################################################################################
################### left off here <<<<<<<<<<<<<<<<<<<<<<<<<<<<

library(NPSdataverse)
library(tidyverse)
library(EML)

working_folder <- setwd("C:/users/growell/HTLN-BreedingBird-Data-Package/EML")
my_metadata <- EML::read_eml("HTLNBreedingBird_metadata.xml")

eml_validate(my_metadata) 

################################################################################
################################################################################
#################### delete my_metadata.xml before running #####################



check_eml("C:/users/growell/HTLN-BreedingBird-Data-Package/EML")

run_congruence_checks("C:/users/growell/HTLN-BreedingBird-Data-Package/EML") 

# if your data package is somewhere else, specify that:
# run_congruence_checks("C:/Users/<yourusername>/Documents/my_data_package")

#EMLeditor::set_abstract(my_metadata, abstract, force = FALSE, NPS = TRUE)

## Upload your data package 
# If everything checked out, you should be ready to upload your data package! 
# We recommend using `upload_data_package()` to accomplish this. The function 
# automatically checks your DOI and uploads to the correct reference on DataStore. 
# All of your files for the data package need to be in the same folder, there can 
# be only one .xml file (ending in "_metadata.xml") and all the other files should 
# be data files in .csv format. Each individual file should be < 32Mb.  If you have 
# files > 32Mb, you will need to upload them manually using the web interface on DataStore. 

# this assumes your data package is in the current working directory
upload_data_package()

# If your data package is somewhere else, specify that:
# upload_data_package("C:/Users/<yourusername>/Documents/my_data_package)


# From within DataStore you should be able to extract all the information 
# from the metadata file to populate the relevant DataStore fields.

# Please don't activate your reference just yet! Data package references need 

