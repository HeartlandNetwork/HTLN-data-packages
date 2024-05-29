### Issac Quevedo, issac_quevedo@partner.nps.gov v03/19/2024

### Updated: 

### Abstract: This monitoring dataset consists of fish community data for Buffalo National River, Ozark National Scenic Riverways and multiple prairie stream park units throughout the Midwest. The dataset includes fish species counts, site conditions, water quality and habitat measures, and stream discharge data for fish communities in Heartland Inventory and Monitoring Network Parks.  The dataset includes approximately 115,000 individual observations covering over 130 fish species observed at 12 NPS park units taken between 2001 and 2023. The overall goals of Heartland Inventory and Monitoring Network fish community program are to monitor temporal changes in fish communities and relations between the fish communities and environmental factors. This monitoring information can be used by park managers to evaluate the effects of past and future activities and management decisions (either by park managers or others) on fish communities. The specific objectives for fish community monitoring are (1) to determine the status and trends in river, springs and small-stream fish communities by quantifying metrics (e.g. species richness, percent tolerant individuals, percent invertivores, and percent omnivores) that can be used to calculate multi-metric indices and (2) to estimate the spatial and temporal variability of fish community metric values and indices among collection sites, and relations between metrics and indices with various environmental variables (e.g. stream size, riparian characteristics, substrate characteristics, water quality, discharge, and land use).


## SETUP: Clear Environment and load packages ----
rm(list=ls())

packages = c("tidyverse", "terra", "geosphere", "readxl", "readr", "janitor", "here", "stringr", "stringi", "lubridate", "taxize", "devtools", "furrr", "sf", "data.table")

package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

#options(download.file.method = "wininet")
#devtools::install_github("nationalparkservice/NPSdataverse", force = TRUE)
library(NPSdataverse)

# use setwd() to folder where data files are kept 



## FISH COVER INFO processing ----

# Read in CSV
FishCoverInfo <- read_csv(here::here("Raw_Data/FishCoverInfo.csv"))

# Look through unique values
check <- lapply(FishCoverInfo, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
FishCoverInfo <- FishCoverInfo %>%
  mutate(ParkName = case_when(
  ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
  TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: SampleLocation/SampleLocationDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
FishCoverInfo <- FishCoverInfo %>% 
  select(-SampleLocation) %>% 
  rename(SampleLocation = SampleLocationDescr)

### COLUMNS: ChannelType/ChannelTypeDescr ----

# Removing Channel Type Description column (conversion for ChannelType code). Will be included in Metadata, in catvar definitions
FishCoverInfo <- FishCoverInfo %>% 
  select(-ChannelTypeDescr)

### COLUMNS: HydroMoss_HY : Bluff_BL ----

# Binary columns. Convert -1 to TRUE, 0 to FALSE
FishCoverInfo <- FishCoverInfo %>% 
  mutate(across(HydroMoss_HY:Bluff_BL, 
        ~ case_when(. == -1 ~ TRUE,
                    . == 0 ~ FALSE)))

### DWC Columns ----

FishCoverInfo <- FishCoverInfo %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 
                                                    
### Export ----

write_csv(FishCoverInfo, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_FishCoverInfo_Cleaned.csv")



## SEINE STREAM SUBSTRATE processing ----

# Read in CSV
SeineStreamSubstrate <- read_csv(here::here("Raw_Data/SeineStreamSubstrate.csv"))

# Look through unique values
check <- lapply(SeineStreamSubstrate, unique)

### DWC Columns ----

SeineStreamSubstrate <- SeineStreamSubstrate %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 

### Export ----

write_csv(SeineStreamSubstrate, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_SeineStreamSubstrate_Cleaned.csv")



## BANK MEASUREMENT INFO processing ----

# Read in CSV
BankMeasurementInfo <- read_csv(here::here("Raw_Data/BankMeasurementInfo.csv"))

# Look through unique values
check <- lapply(BankMeasurementInfo, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
BankMeasurementInfo <- BankMeasurementInfo %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: ChannelType/ChannelTypeDescr ----

# Removing Channel Type Description column (conversion for ChannelType code). Will be included in Metadata, in catvar definitions
BankMeasurementInfo <- BankMeasurementInfo %>% 
  select(-ChannelTypeDescr)

### COLUMNS: SampleLocation/SampleLocationDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
BankMeasurementInfo <- BankMeasurementInfo %>% 
  select(-SampleLocation) %>% 
  rename(SampleLocation = SampleLocationDescr)

### COLUMNS: BankAngle/BankAngleDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name. New column name will contain unit.
BankMeasurementInfo <- BankMeasurementInfo %>% 
  select(-BankAngle) %>% 
  rename(BankAngle_Degrees = BankAngleDescr) 

# Remove units from column values.
BankMeasurementInfo$BankAngle_Degrees <- str_remove(BankMeasurementInfo$BankAngle_Degrees, " degrees")

# Replace 'no data' value with missing value code '-999'
BankMeasurementInfo <- BankMeasurementInfo %>% 
  mutate(BankAngle_Degrees = 
           if_else(BankAngle_Degrees == 'no data',
                   '-999',
                   BankAngle_Degrees))


### COLUMNS: BankVegCover/BankVegCoverDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name. New column name will contain unit.
BankMeasurementInfo <- BankMeasurementInfo %>% 
  select(-BankVegCover) %>% 
  rename(BankVegCover_Percent = BankVegCoverDescr) 

# Remove units from column values.
BankMeasurementInfo$BankVegCover_Percent <- str_remove(BankMeasurementInfo$BankVegCover_Percent, "%")

# Replace 'no data' value with missing value code '-999'
BankMeasurementInfo <- BankMeasurementInfo %>% 
  mutate(BankVegCover_Percent = 
           if_else(BankVegCover_Percent == 'no data',
                   '-999',
                   BankVegCover_Percent))

### COLUMNS: BankHeight/BankHeightDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name. New column name will contain unit.
BankMeasurementInfo <- BankMeasurementInfo %>% 
  select(-BankHeight) %>% 
  rename(BankHeight_Meters = BankHeightDescr) 

# Remove units from column values.
BankMeasurementInfo$BankHeight_Meters <- str_remove(BankMeasurementInfo$BankHeight_Meters, " meter")

# Replace 'no data' value with missing value code '-999'
BankMeasurementInfo <- BankMeasurementInfo %>% 
  mutate(BankHeight_Meters = 
           if_else(BankHeight_Meters == 'no data',
                   '-999',
                   BankHeight_Meters))

### COLUMNS: BankSubstrate/BankSubstrateDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
BankMeasurementInfo <- BankMeasurementInfo %>% 
  select(-BankSubstrate) %>% 
  rename(BankSubstrate = BankSubstrateDescr) 

# Replace 'no data' value with missing value code '-999'
BankMeasurementInfo <- BankMeasurementInfo %>% 
  mutate(BankSubstrate = 
           if_else(BankSubstrate == 'no data',
                   '-999',
                   BankSubstrate))

### COLUMNS: LargeTrees_TR : Artificial_AR ----

# Binary columns. Convert -1 to TRUE, 0 to FALSE
BankMeasurementInfo <- BankMeasurementInfo %>% 
  mutate(across(LargeTrees_TR:Artificial_AR, 
                ~ case_when(. == -1 ~ TRUE,
                            . == 0 ~ FALSE)))

### DWC Columns ----

BankMeasurementInfo <- BankMeasurementInfo %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 

### Export ----

write_csv(BankMeasurementInfo, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_BankMeasurementInfo_Cleaned.csv")



## CROSS SECITON INFO processing ----

# Read in CSV
CrossSectionInfo <- read_csv(here::here("Raw_Data/CrossSectionInfo.csv"))

# Look through unique values
check <- lapply(CrossSectionInfo, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
CrossSectionInfo <- CrossSectionInfo %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: ChannelType/ChannelTypeDescr ----

# Removing Channel Type Description column (conversion for ChannelType code). Will be included in Metadata, in catvar definitions
CrossSectionInfo <- CrossSectionInfo %>% 
  select(-ChannelTypeDescr)

### COLUMNS: SampleLocation/SampleLocationDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
CrossSectionInfo <- CrossSectionInfo %>% 
  select(-SampleLocation) %>% 
  rename(SampleLocation = SampleLocationDescr)

### COLUMNS: ChannelUnit/ChannelUnitDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
CrossSectionInfo <- CrossSectionInfo %>% 
  select(-ChannelUnit) %>% 
  rename(ChannelUnit = ChannelUnitDescr)

### COLUMNS: PoolForm/PoolFormDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
CrossSectionInfo <- CrossSectionInfo %>% 
  select(-PoolForm) %>% 
  rename(PoolForm = PoolFormDescr)

# Replace 'no data' value with missing value code '-999'
CrossSectionInfo <- CrossSectionInfo %>% 
  mutate(PoolForm = 
           if_else(PoolForm == "Not applicable or no data recorded", 
                   NA,
                   PoolForm))

### COLUMNS: Width_m ----

# Rename to include full unit in column name
CrossSectionInfo <- CrossSectionInfo %>% 
  rename(Width_Meters = Width_m) 

### COLUMNS: Depth_cm ----

# Rename to include full unit in column name
CrossSectionInfo <- CrossSectionInfo %>% 
  rename(Depth_Centimeters = Depth_cm) 


### COLUMNS: Velocity_ms ----

# Rename to include full unit in column name and flag negative values (except -999 values)
CrossSectionInfo <- CrossSectionInfo %>% 
  rename(Velocity_MetersPerSecond = Velocity_ms) %>% 
  mutate(Velocity_MetersPerSecond_flag = 
           case_when(Velocity_MetersPerSecond == -999.00 |  Velocity_MetersPerSecond == -999 ~ "A",
                     Velocity_MetersPerSecond < 0 ~ "R",
                     TRUE ~ "A")) %>% 
  relocate(Velocity_MetersPerSecond_flag, .after = Velocity_MetersPerSecond)

### COLUMNS: DomSubstrate ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
CrossSectionInfo <- CrossSectionInfo %>% 
  select(-DomSubstrate) %>% 
  rename(DominantWentworthSubstrate_Millimeters = WentworthSubstrateDescr)

unique(CrossSectionInfo$DominantWentworthSubstrate_Millimeters)

# Remove units from column values, replace no data with -999, replace text, standardize values
CrossSectionInfo$DominantWentworthSubstrate_Millimeters <- str_replace(CrossSectionInfo$DominantWentworthSubstrate_Millimeters, " mm", "") 
CrossSectionInfo$DominantWentworthSubstrate_Millimeters <- str_replace(CrossSectionInfo$DominantWentworthSubstrate_Millimeters, "mm", "")
CrossSectionInfo$DominantWentworthSubstrate_Millimeters <- str_replace(CrossSectionInfo$DominantWentworthSubstrate_Millimeters, "\\([^)]*\\)", "")
CrossSectionInfo$DominantWentworthSubstrate_Millimeters <- str_replace(CrossSectionInfo$DominantWentworthSubstrate_Millimeters, " bedrock", "")
CrossSectionInfo$DominantWentworthSubstrate_Millimeters <- str_replace(CrossSectionInfo$DominantWentworthSubstrate_Millimeters, "no data", "-999")
CrossSectionInfo$DominantWentworthSubstrate_Millimeters <- str_replace(CrossSectionInfo$DominantWentworthSubstrate_Millimeters, "> 4096", ">4096")
CrossSectionInfo$DominantWentworthSubstrate_Millimeters <- str_replace(CrossSectionInfo$DominantWentworthSubstrate_Millimeters, "1024 -4096", "1024-4096")

### COLUMNS: WentworthMidpoint ----

# Rename to include full unit in column name
CrossSectionInfo <- CrossSectionInfo %>%
  rename(WentworthMidpoint_Millimeters = WentworthMidpoint)

### COLUMNS: Embeddedness/EmbedCanCoverDescr1 ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
CrossSectionInfo <- CrossSectionInfo %>% 
  select(-Embeddedness) %>% 
  rename(EmbeddedCanopyCover = EmbedCanCoverDescr1)

# Replace 'no data' value with missing value code 'NA'
CrossSectionInfo <- CrossSectionInfo %>% 
  mutate(EmbeddedCanopyCover = 
           if_else(EmbeddedCanopyCover == "no data", 
                   NA,
                   EmbeddedCanopyCover))

### COLUMNS: ECC_MidpointValue1 ----

# Rename to include full unit in column name
CrossSectionInfo <- CrossSectionInfo %>% 
  rename(ECC_MidpointValue1_Percent = ECC_MidpointValue1)

### COLUMNS: CanopyCover/EmbedCanCoverDescr2 ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
CrossSectionInfo <- CrossSectionInfo %>% 
  select(-CanopyCover) %>% 
  rename(CanopyCover = EmbedCanCoverDescr2)

# Replace 'no data' value with missing value code 'NA'
CrossSectionInfo <- CrossSectionInfo %>% 
  mutate(CanopyCover = 
           if_else(CanopyCover == "no data", 
                   NA,
                   CanopyCover))

### COLUMNS: ECC_MidpoinValue2 ----

# Rename to include full unit in column name
CrossSectionInfo <- CrossSectionInfo %>% 
  rename(ECC_MidpointValue2_Percent = ECC_MidpoinValue2)

### DWC Columns ----

CrossSectionInfo <- CrossSectionInfo %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 

### Export ----

write_csv(CrossSectionInfo, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_CrossSectionInfo_Cleaned.csv")



## DISCHARGE FIELD MEASUREMENTS processing ----

# Read in CSV
DischargeFieldMeasurements <- read_csv(here::here("Raw_Data/DischargeFieldMeasurements.csv"))

# Look through unique values
check <- lapply(DischargeFieldMeasurements, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
DischargeFieldMeasurements <- DischargeFieldMeasurements %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: DistanceFromBank_m ----

# Rename to include full unit in column name
DischargeFieldMeasurements <- DischargeFieldMeasurements %>%
  rename(DistanceFromBank_Meters = DistanceFromBank_m)

### COLUMNS: Depth_cm ----

# Rename to include full unit in column name
DischargeFieldMeasurements <- DischargeFieldMeasurements %>%
  rename(Depth_Centimeters = Depth_cm)

### COLUMNS: Velocity_ms ----

# Rename to include full unit in column name and flag negative values (except -999 values)
DischargeFieldMeasurements <- DischargeFieldMeasurements %>% 
  rename(Velocity_MetersPerSecond = Velocity_ms) %>% 
  mutate(Velocity_MetersPerSecond_flag = 
           case_when(Velocity_MetersPerSecond == -999.00 |  Velocity_MetersPerSecond == -999 ~ "A",
                     Velocity_MetersPerSecond < 0 ~ "R",
                     TRUE ~ "A")) %>% 
  relocate(Velocity_MetersPerSecond_flag, .after = Velocity_MetersPerSecond)

### DWC Columns ----

DischargeFieldMeasurements <- DischargeFieldMeasurements %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 

### Export ----

write_csv(DischargeFieldMeasurements, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_DischargeFieldMeasurements_Cleaned.csv")


## DISCHARGE GAUGE INFO processing ----

# Read in CSV
DischargeGaugeInfo <- read_csv(here::here("Raw_Data/DischargeGaugeInfo.csv"))

# Look through unique values
check <- lapply(DischargeGaugeInfo, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
DischargeGaugeInfo <- DischargeGaugeInfo %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: ChannelType/ChannelTypeDescr ----

# Removing Channel Type Description column (conversion for ChannelType code). Will be included in Metadata, in catvar definitions
DischargeGaugeInfo <- DischargeGaugeInfo %>% 
  select(-ChannelTypeDescr)

### COLUMNS: Discharge_cms ----

# Rename to include full unit in column name
DischargeGaugeInfo <- DischargeGaugeInfo %>%
  rename(Discharge_CentimetersPerSecond = Discharge_cms)

### DWC Columns ----

DischargeGaugeInfo <- DischargeGaugeInfo %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "MachineObservation") 

### Export ----

write_csv(DischargeGaugeInfo, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_DischargeGaugeInfo_Cleaned.csv")



## FISH COUNTS THRU 2023 processing ----

# Read in CSV
FishCountsThru_2023 <- read_csv(here::here("Raw_Data/FishCountsThru_2023.csv"))

# Look through unique values
check <- lapply(FishCountsThru_2023, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
FishCountsThru_2023 <- FishCountsThru_2023 %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: ChannelType/ChannelTypeDescr ----

# Removing Channel Type Description column (conversion for ChannelType code). Will be included in Metadata, in catvar definitions
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  select(-ChannelTypeDescr)

### COLUMNS: TotalLength_mm ----

# Rename to include full unit in column name and replace NA with standard missing value for numeric columns (-999)
FishCountsThru_2023 <- FishCountsThru_2023 %>%
  rename(TotalLength_Millimeters = TotalLength_mm) %>% 
  mutate(TotalLength_Millimeters = replace_na(TotalLength_Millimeters, -999))

### COLUMNS: Weight_g ----

# Rename to include full unit in column name and replace NA with standard missing value for numeric columns (-999)
FishCountsThru_2023 <- FishCountsThru_2023 %>%
  rename(Weight_Grams = Weight_g) %>% 
  mutate(Weight_Grams = replace_na(Weight_Grams, -999))

# check if any negative values exist that need to be flagged
which(FishCountsThru_2023$Weight_Grams < 0 & FishCountsThru_2023$Weight_Grams != -999) # none

### COLUMNS: AnomalyID/FishAnomalyDescr ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  select(-AnomalyID) %>% 
  rename(FishAnomaly = FishAnomalyDescr)

### COLUMNS: Vouchered ----

# Binary columns. Convert -1 to TRUE, 0 to FALSE
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  mutate(Vouchered = case_when(Vouchered == -1 ~ TRUE,
                               Vouchered == 0 ~ FALSE))

### COLUMNS: NumObs ----

# Replace NA with standard missing value for numeric columns (-999)
FishCountsThru_2023 <- FishCountsThru_2023 %>%
  mutate(NumObs = replace_na(NumObs, -999))

### COLUMNS: BatchWT_g ----

# Rename to include full unit in column name and replace NA with standard missing value for numeric columns (-999)
FishCountsThru_2023 <- FishCountsThru_2023 %>%
  rename(BatchWT_Grams = BatchWT_g) %>% 
  mutate(BatchWT_Grams = replace_na(BatchWT_Grams, -999))



### COLUMNS: TaxonCode/CommonName/FamilyName/ScientificName/TSN ----

# check for missing value standard
ex <- FishCountsThru_2023 %>% filter(is.na(TSN) | TSN == -999) # should all be -999

# Replace NA with standard missing value for numeric columns (-999)
FishCountsThru_2023 <- FishCountsThru_2023 %>%
  mutate(TSN = replace_na(TSN, -999))


ex2 <- FishCountsThru_2023 %>% select(TaxonCode:TSN) %>% unique()

# Add column for scientificName (Check scientific names against GBIF, see which (if any) can be corrected, join to dataframe, and rename to Darwin Core standards):
scinames <- gnr_resolve(sci = unique(FishCountsThru_2023$ScientificName), data_source_ids = 11,
                        canonical = TRUE, best_match_only = TRUE,  fields = "all") 

# exploration
setdiff(ex2$ScientificName, scinames$user_supplied_name)
setdiff(scinames$user_supplied_name, scinames$matched_name2)
setdiff(scinames$matched_name2, scinames$user_supplied_name)

duplicated(scinames$matched_name2)

scinames <- scinames %>% select("user_supplied_name", "matched_name2", "data_source_title", "taxon_id") 
FishCountsThru_2023 <- FishCountsThru_2023 %>% rename(VerbatimIdentification = ScientificName)
FishCountsThru_2023 <- left_join(FishCountsThru_2023, scinames, by = c("VerbatimIdentification" = "user_supplied_name"))
FishCountsThru_2023 <- rename(FishCountsThru_2023, "ScientificName" = "matched_name2")

setdiff(FishCountsThru_2023$VerbatimIdentification, FishCountsThru_2023$ScientificName)

FishCountsThru_2023 <- FishCountsThru_2023 %>%
  mutate(ScientificName = case_when(
    VerbatimIdentification == "Lepomis humilis X L. megalotis" ~ "Lepomis humilis x megalotis",
    VerbatimIdentification == "Lepomis cyanellus x L. humilis" ~ "Lepomis cyanellus x humilis",
    VerbatimIdentification == "Lepomis miniatus x L. cyanellus" ~ "Lepomis miniatus x cyanellus",
    VerbatimIdentification == "Lepomis megalotis x L. cyanellus" ~ "Lepomis megalotis x cyanellus",
    VerbatimIdentification == "Lepomis macrochirus x L. cyanellus" ~ "Lepomis macrochirus x cyanellus",
    VerbatimIdentification == "Lepomis megalotis x L. macrochirus" ~ "Lepomis megalotis x macrochirus",
    VerbatimIdentification == "Lepomis miniatus X L. megalotis" ~ "Lepomis miniatus x megalotis",
    VerbatimIdentification == "unknown Cyprinid" ~ "Cyprinidae",
    VerbatimIdentification == "Lepomis macrochirus x L. miniatus" ~ "Lepomis macrochirus x miniatus",
    TRUE ~ ScientificName
  ))

# Add column for TaxonRank:
FishCountsThru_2023 <- FishCountsThru_2023 %>%
  mutate(taxonRank = "species")
FishCountsThru_2023 <- QCkit::get_taxon_rank(FishCountsThru_2023, "ScientificName")
names(FishCountsThru_2023)[names(FishCountsThru_2023) == 'taxonRank'] <- 'TaxonRank'

# Rename columns
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  rename(ScientificNameDataSource = data_source_title,
         GBIFTaxonID = taxon_id) %>% 
  relocate(ScientificName:TaxonRank, .after = TSN)

### COLUMNS: ScientificName_flag ----

# Add data quality flag to ScientificName column
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  mutate(ScientificName_flag = case_when(
    ScientificName == "Lepomis humilis x megalotis" ~ "AE",
    ScientificName == "Lepomis cyanellus x humilis" ~ "AE",
    ScientificName == "Lepomis miniatus x cyanellus" ~ "AE",
    ScientificName == "Lepomis megalotis x cyanellus" ~ "AE",
    ScientificName == "Lepomis macrochirus x cyanellus" ~ "AE",
    ScientificName == "Lepomis megalotis x macrochirus" ~ "AE",
    ScientificName == "Lepomis miniatus x megalotis" ~ "AE",
    ScientificName == "Lepomis macrochirus x miniatus" ~ "AE",
    ScientificName == "Campostoma" ~ "AE",
    ScientificName == "Cottus" ~ "AE",
    ScientificName == "Etheostoma autumnale" ~ "AE",
    ScientificName == "Etheostoma" ~ "AE",
    ScientificName == "Ichthyomyzon" ~ "AE",
    ScientificName == "Lampetra" ~ "AE",
    ScientificName == "Moxostoma duquesnii" ~ "AE",
    ScientificName == "Moxostoma" ~ "AE",
    ScientificName == "Cyprinidae" ~ "AE",
    ScientificName == "Lepomis" ~ "AE",
    ScientificName == "Luxilus" ~ "AE",
    ScientificName == "Notropis" ~ "AE",
    ScientificName == "Noturus" ~ "AE",
    ScientificName == "Pimephales" ~ "AE",
    is.na(ScientificName) ~ "AE",
    TRUE ~ "A"
  ))

FishCountsThru_2023 <- FishCountsThru_2023 %>% relocate(ScientificName_flag, .after = ScientificName)

### COLUMNS: ToleranceCode/ToleranceDescription ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  select(-ToleranceCode) %>% 
  rename(Tolerance = ToleranceDescription)

### COLUMNS: ReproductiveClassification/ReproductiveDescription ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  select(-ReproductiveClassification) %>% 
  rename(ReproductiveClassification = ReproductiveDescription)

### COLUMNS: TrophicClassification/TrophicDescription ----

# Redundancy - both code and it's conversion included. Leave in conversion, preserve original code column name.
FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  select(-TrophicClassification) %>% 
  rename(TrophicClassification = TrophicDescription)

### DWC Columns ----

FishCountsThru_2023 <- FishCountsThru_2023 %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 

### Export ----

write_csv(FishCountsThru_2023, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_FishCountsThru_2023_Cleaned.csv")



## FISH REACH LOCATIONS processing ----

# Read in CSV
FishReachLocations <- read_csv(here::here("Raw_Data/FishReachLocations.csv"))

# Look through unique values
check <- lapply(FishReachLocations, unique)

### COORDINATE COLUMNS ----

# Create column for UTM Zone and join to main df
Zone <- as.data.frame(unlist(lapply(FishReachLocations$XstartDD, get_utm_zone)))
FishReachLocations <- cbind(FishReachLocations, Zone) %>% 
  rename(startUTMZone = `unlist(lapply(FishReachLocations$XstartDD, get_utm_zone))`) %>% 
  mutate(startUTMZone = paste0(startUTMZone, "N"))

# Add datum columns
FishReachLocations <- FishReachLocations %>% 
  mutate(startUTMDatum = case_when(
    startUTMZone == "14N" ~ "EPSG:32614",
    startUTMZone == "15N" ~ "EPSG:32615"
  )) %>% 
  mutate(startDDDatum = "EPSG:4326")

### Reorder columns ----

FishReachLocations <- FishReachLocations %>% 
  select(Status, ReachID, ActiveDates, startUTMZone, XstartUTM, YstartUTM, startUTMDatum, XstartDD, YstartDD, startDDDatum, LocationID)

### DWC Columns ----

FishReachLocations <- FishReachLocations %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "MachineObservation") 

### Export ----

write_csv(FishReachLocations, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_FishReachLocations_Cleaned.csv")



## LOCATION DETAILS processing ----

# Read in CSV
LocationDetails <- read_csv(here::here("Raw_Data/LocationDetails.csv"))

# Look through unique values
check <- lapply(LocationDetails, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
LocationDetails <- LocationDetails %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: LocationNumber ----

# Make numeric column (originally character)
LocationDetails$LocationNumber <- as.numeric(LocationDetails$LocationNumber)

### COLUMNS: LocationType ----

# Standardize capitalization of location types
LocationDetails$LocationType <- stri_trans_totitle(LocationDetails$LocationType)

### COLUMNS: StretchNumber ----

# Replace NA with standard missing value for numeric columns (-999)
LocationDetails <- LocationDetails %>%
  mutate(StretchNumber = replace_na(StretchNumber, -999))


### COLUMNS: ReachLength_m ----

# Rename to include full unit in column name and replace NA with standard missing value for numeric columns (-999)
LocationDetails <- LocationDetails %>%
  rename(ReachLength_Meters = ReachLength_m) %>% 
  mutate(ReachLength_Meters = replace_na(ReachLength_Meters, -999))

### COLUMNS: StreamWatershedArea_sqkm ----

# Rename to include full unit in column name and replace NA with standard missing value for numeric columns (-999)
LocationDetails <- LocationDetails %>%
  rename(StreamWatershedArea_SquareKilometers = StreamWatershedArea_sqkm) %>% 
  mutate(StreamWatershedArea_SquareKilometers = replace_na(StreamWatershedArea_SquareKilometers, -999))

### DWC Columns ----

LocationDetails <- LocationDetails %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 

### Export ----

write_csv(LocationDetails, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_LocationDetails_Cleaned.csv")



## REACH CONDITIONS processing ----

# Read in CSV
ReachConditions <- read_csv(here::here("Raw_Data/ReachConditions.csv"))

# Look through unique values
check <- lapply(ReachConditions, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
ReachConditions <- ReachConditions %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: Pct_CloudCover ----

# Rename to include full unit in column name
ReachConditions <- ReachConditions %>% 
  rename(CloudCover_Percent = Pct_CloudCover) 

### COLUMNS: WindIntensity/PrecipitationType/PrecipitationIntensity ----

# Standardize missing values
ReachConditions <- ReachConditions %>% 
  mutate(across(WindIntensity:PrecipitationIntensity, 
                ~ case_when(. == "Unknown" ~ NA,
                            . == "N/A" ~ NA,
                            TRUE ~ .)))

### COLUMNS: SH_Springs_Present ----

# Binary columns. Convert -1 to TRUE, 0 to FALSE
ReachConditions <- ReachConditions %>% 
  mutate(across(SH_Springs_Present, 
                ~ case_when(. == -1 ~ TRUE,
                            . == 0 ~ FALSE)))

### COLUMNS: SH_StreamFlow_Description ----

# Standardize capitalization of SH_StreamFlow_Description
ReachConditions$SH_StreamFlow_Description <- tolower(ReachConditions$SH_StreamFlow_Description)

# Standardize missing values
ReachConditions$SH_StreamFlow_Description[ReachConditions$SH_StreamFlow_Description == "unknown"] <- NA
  
### DWC Columns ----

ReachConditions <- ReachConditions %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation") 

### Export ----

write_csv(ReachConditions, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_ReachConditions_Cleaned.csv")



## REACH MEASUREMENTS processing ----

# Read in CSV
ReachMeasurements <- read_csv(here::here("Raw_Data/ReachMeasurements.csv"))

# Look through unique values
check <- lapply(ReachMeasurements, unique)

### COLUMNS: Beginning_Ending ----

# Standardize capitalization (only one value not capitalized)
ReachMeasurements$Beginning_Ending <- toupper(ReachMeasurements$Beginning_Ending)

### COLUMNS: WaterTemp_C ----

# Rename to include full unit in column name
ReachMeasurements <- ReachMeasurements %>% 
  rename(WaterTemp_Celcius = WaterTemp_C)

### COLUMNS: AirTemp_C ----

# Rename to include full unit in column name
ReachMeasurements <- ReachMeasurements %>% 
  rename(AirTemp_Celcius = AirTemp_C)

### COLUMNS: SpecificConductance_microScm ----

# Rename to include full unit in column name
ReachMeasurements <- ReachMeasurements %>% 
  rename(SpecificConductance_MicrosiemensPerCentimeter = SpecificConductance_microScm)

### COLUMNS: Conductivity_microScm ----

# Rename to include full unit in column name
ReachMeasurements <- ReachMeasurements %>% 
  rename(Conductivity_MicrosiemensPerCentimeter = Conductivity_microScm)

### COLUMNS: DissolvedOxygen_mgL ----

# Rename to include full unit in column name
ReachMeasurements <- ReachMeasurements %>% 
  rename(DissolvedOxygen_MilligramsPerLiter = DissolvedOxygen_mgL)

### COLUMNS: SecchiTube ----

# Rename to include full unit in column name
ReachMeasurements <- ReachMeasurements %>% 
  rename(SecchiTube_Centimeters = SecchiTube)

### DWC Columns ----

ReachMeasurements <- ReachMeasurements %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "MachineObservation") 

### Export ----

write_csv(ReachMeasurements, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_ReachMeasurements_Cleaned.csv")


## SAMPLING PREIODS AND EVENTS processing ----

# Read in CSV
SamplingPeriodsAndEvents <- read_csv(here::here("Raw_Data/SamplingPeriodsAndEvents.csv"))

# Look through unique values
check <- lapply(SamplingPeriodsAndEvents, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
SamplingPeriodsAndEvents <- SamplingPeriodsAndEvents %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: SamplingPeriods_StartDate/SamplingPeriods_EndDate/SamplingEvents_StartDate/SamplingEvents_EndDate ----

# Remove time arbitrarily appended to the end of the date columns
SamplingPeriodsAndEvents <- SamplingPeriodsAndEvents %>% 
  mutate(across(c(SamplingPeriods_StartDate, SamplingPeriods_EndDate, SamplingEvents_StartDate, SamplingEvents_EndDate), 
                ~ str_remove(., " 0:00$")))

### Remove Row --- 

# Remove row from dataset commented "delete" in EventComments column

SamplingPeriodsAndEvents <- SamplingPeriodsAndEvents %>% 
  filter(EventComments != "delete")

### DWC Columns ----

SamplingPeriodsAndEvents <- SamplingPeriodsAndEvents %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation")

### Export ----

write_csv(SamplingPeriodsAndEvents, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_SamplingPeriodsAndEvents_Cleaned.csv")


## SEINE RIPARIAN CORRIDOR processing ----

# Read in CSV
SeineRiparianCorridor <- read_csv(here::here("Raw_Data/SeineRiparianCorridor.csv"))

# Look through unique values
check <- lapply(SeineRiparianCorridor, unique)

### COLUMNS: SampleLocation ----

SeineRiparianCorridor <- SeineRiparianCorridor %>% 
  mutate(SampleLocation = case_when(
    SampleLocation == "L" ~ "Left",
    SampleLocation == "R" ~ "Right"
  ))

### COLUMNS: RiparianCover_0to25_m : RiparianCover_GT100_m ----

# Read in join table to translate codes
SeineRiparianCoverTypes <- read_csv(here::here("Raw_Data/SeineRiparianCoverTypes.csv"))

# Join in cover class table and rename column to include full unit name
SeineRiparianCorridor <- left_join(SeineRiparianCorridor, SeineRiparianCoverTypes, by = c("RiparianCover_0to25_m" = "RiparianVegCoverCode"))
SeineRiparianCorridor <- SeineRiparianCorridor %>% 
  select(-RiparianCover_0to25_m) %>% 
  rename(RiparianCover_0to25_Meters = RiparianVegCoverDescr)

# Join in cover class table and rename column to include full unit name
SeineRiparianCorridor <- left_join(SeineRiparianCorridor, SeineRiparianCoverTypes, by = c("RiparianCover_26to50_m" = "RiparianVegCoverCode"))
SeineRiparianCorridor <- SeineRiparianCorridor %>% 
  select(-RiparianCover_26to50_m) %>% 
  rename(RiparianCover_26to50_Meters = RiparianVegCoverDescr)

# Join in cover class table and rename column to include full unit name
SeineRiparianCorridor <- left_join(SeineRiparianCorridor, SeineRiparianCoverTypes, by = c("RiparianCover_51to75_m" = "RiparianVegCoverCode"))
SeineRiparianCorridor <- SeineRiparianCorridor %>% 
  select(-RiparianCover_51to75_m) %>% 
  rename(RiparianCover_51to75_Meters = RiparianVegCoverDescr)

# Join in cover class table and rename column to include full unit name
SeineRiparianCorridor <- left_join(SeineRiparianCorridor, SeineRiparianCoverTypes, by = c("RiparianCover_76to100_m" = "RiparianVegCoverCode"))
SeineRiparianCorridor <- SeineRiparianCorridor %>% 
  select(-RiparianCover_76to100_m) %>% 
  rename(RiparianCover_76to100_Meters = RiparianVegCoverDescr)

# Join in cover class table and rename column to include full unit name
SeineRiparianCorridor <- left_join(SeineRiparianCorridor, SeineRiparianCoverTypes, by = c("RiparianCover_GT100_m" = "RiparianVegCoverCode"))
SeineRiparianCorridor <- SeineRiparianCorridor %>% 
  select(-RiparianCover_GT100_m) %>% 
  rename(RiparianCover_GT100_Meters = RiparianVegCoverDescr)


### COLUMNS: StreamBankErosionCover ----

# Relocate column to original place
SeineRiparianCorridor <- SeineRiparianCorridor %>% relocate(StreamBankErosionCover, .after = RiparianCover_GT100_Meters )

### DWC Columns ----

SeineRiparianCorridor <- SeineRiparianCorridor %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation")

### Export ----

write_csv(SeineRiparianCorridor, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_SeineRiparianCorridor_Cleaned.csv")



## TRANSECT SPACING INTERVAL processing ----

# Read in CSV
TransectSpacingInterval <- read_csv(here::here("Raw_Data/TransectSpacingInterval.csv"))

# Look through unique values
check <- lapply(TransectSpacingInterval, unique)

### COLUMNS: ParkCode/ParkName ----

# Two different park unit names and codes used for same park unit - OZAR & OZRS. Convert to same park unit
TransectSpacingInterval <- TransectSpacingInterval %>%
  mutate(ParkName = case_when(
    ParkName == "Ozark National Scenic Riverways - SPRINGS" ~ "Ozark National Scenic Riverways",
    TRUE ~ ParkName)) %>% 
  mutate(ParkCode = case_when(
    ParkCode == "OZRS" ~ "OZAR",
    TRUE ~ ParkCode))

### COLUMNS: ChannelType/ChannelTypeDescr ----

# Removing Channel Type Description column (conversion for ChannelType code). Will be included in Metadata, in catvar definitions
TransectSpacingInterval <- TransectSpacingInterval %>% 
  select(-ChannelTypeDescr)

### COLUMNS: ChannelTypeSampledLength_m ----

# Rename to include full unit in column name and replace NA with standard missing value for numeric columns (-999)
TransectSpacingInterval <- TransectSpacingInterval %>%
  rename(ChannelTypeSampledLength_Meters = ChannelTypeSampledLength_m) %>% 
  mutate(ChannelTypeSampledLength_Meters = replace_na(ChannelTypeSampledLength_Meters, -999))

### COLUMNS: TransectSpacingInterval_m ----

# Rename to include full unit in column name and replace NA with standard missing value for numeric columns (-999)
TransectSpacingInterval <- TransectSpacingInterval %>%
  rename(TransectSpacingInterval_Meters = TransectSpacingInterval_m) %>% 
  mutate(TransectSpacingInterval_Meters = replace_na(TransectSpacingInterval_Meters, -999))

### DWC Columns ----

TransectSpacingInterval <- TransectSpacingInterval %>% 
  mutate("dwcType" = "Event") %>%
  mutate("dwcBasisOfRecord" = "HumanObservation")

### Export ----

write_csv(TransectSpacingInterval, "C:/Users/iquevedo/DOI/NPS-CSO Data Science - Documents/Open Data/HTLN/Monitoring/fish_communities/03_final_data/HTLN_FishCommunities_TransectSpacingInterval_Cleaned.csv")




