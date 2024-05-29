### James Brown, James_Brown@partner.nps.gov, v03/19/2024
### Updated by:
### Notes:

# Environment Setup ----
rm(list = ls())

packages = c(
  "tidyverse",
  "terra",
  "geosphere",
  "readxl",
  "readr",
  "janitor",
  "here",
  "stringr",
  "lubridate",
  "taxize",
  "devtools",
  "sf",
  "furrr",
  "magrittr",
  "NPSdataverse"
)

package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

# Preparation ----
Cedar <- read.csv(here::here("HtlnMobladCedarData.csv"))
PARD <- read.csv(here::here("HtlnMoBladPARData.csv"))
twoDecade <- read.csv(here::here("HtlnMobladCountData1997_2021.csv"))
accuracy <- read.csv(here::here("HtlnBladderpodAccuracyGridA.csv"))

Cedar %<>%
  mutate(dwcType = "Event",
         dwcBasisOfRecord = "HumanObservation",
         ParkCode = "WICR",
         scientificName = "Juniperus virginiana")

PARD %<>%
  mutate(dwcType = "Event",
         dwcBasisOfRecord = "HumanObservation",
         ParkCode = "WICR",
         scientificName = "Physaria filiformis")

twoDecade %<>%
  mutate(dwcType = "Event",
         dwcBasisOfRecord = "HumanObservation",
         ParkCode = "WICR",
         scientificName = "Physaria filiformis")

accuracy %<>% 
  mutate(dwcType = "Event",
         dwcBasisOfRecord = "HumanObservation",
         ParkCode = "WICR",
         scientificName = "Physaria filiformis")

# Final renaming of columns ----
Cedar %<>%
  rename(dbhInCentimeters = dbh)

PARD %<>%
  rename(PAR_CanopyInMicroMolePerMeterSquaredPerSecond = PAR_Canopy,
         PAR_FullSunInMicroMolePerMeterSquaredPerSecond = PAR_FullSun)

twoDecade %<>%
  rename(GridSizeInMeters = GridSizeMeters)

accuracy %<>% 
  rename(DensityClass_Estimated = DensityClass_Est)

# Column Rearrangement ----
Cedar %<>%
  relocate(
    c(
      ParkName,
      ParkCode,
      dwcType,
      dwcBasisOfRecord,
      CalYr,
      scientificName,
      DataReleaseID,
      dbhInCentimeters
    )
  )

PARD %<>% 
  relocate(
    c(
      ParkName,
      ParkCode,
      dwcType,
      dwcBasisOfRecord,
      PeriodDescriptor,
      CalYr,
      scientificName,
      DataReleaseID,
      Reading_No,
      PAR_CanopyInMicroMolePerMeterSquaredPerSecond,
      PAR_FullSunInMicroMolePerMeterSquaredPerSecond
    )
  )

twoDecade %<>%
  relocate(
    c(
      ParkName,
      ParkCode,
      dwcType,
      dwcBasisOfRecord,
      CalYr,
      scientificName,
      GridSizeInMeters,
      DataReleaseID,
      DensityClass,
      ClassRange,
      LowerBound,
      UpperBound,
      Midpoint
    )
  )

accuracy %<>%
  relocate(c(ParkCode, dwcType, dwcBasisOfRecord, scientificName), .before = DataReleaseID)

# Export ----
Cedar %>% write.csv(here::here("HTLN_MoBlad_CedarData_Cleaned_INTERNAL.csv"), row.names = FALSE, fileEncoding = "UTF-8")
PARD %>% write.csv(here::here("HTLN_MoBlad_PARData_Cleaned_INTERNAL.csv"), row.names = FALSE, fileEncoding = "UTF-8")
twoDecade %>% write.csv(here::here("HTLN_MoBlad_CountData1997-2021_Cleaned_INTERNAL.csv"), row.names = FALSE, fileEncoding = "UTF-8")
accuracy %>% write.csv(here::here("HTLN_MoBlad_AccuracyGridA_Cleaned_INTERNAL.csv"), row.names = FALSE, fileEncoding = "UTF-8")
