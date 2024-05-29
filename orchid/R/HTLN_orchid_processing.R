### Rob Baker, robert_baker@nps.gov, v03/19/24
### Updated By:
### Abstract: Pre-processing data for the HTLN network's Western Prairie Flower Orchid data set. The goal is to take the .csv files provided by HTLN and get them ready for data package construction. This means converting dates to ISO 8601 standards, converting columns to darwinCore naming stadnards (when appropriate), and replacing blanks with NA.
### Databases drawn from the following links:
# Example 1: http://...
### Notes: renamed columns according to network requirements/in consultation with the HTLN staff. All new or added columns are at the end of the data file as per HTLN request.

# remove unwanted environmental variables
rm(list=ls())
# free up any available RAM sucked into previous prcoesses:
gc()

# load commonly used packates
packages = c("tidyverse", "terra", "geosphere", "readxl", "janitor", "stringr", "taxize", "devtools", "sf", "furrr")

# The following function checks 1) are the packages in the list "packages" installed? If not, install them 2) Are the packages in "packages" loaded? If not, load the packages using library().
package.check <- lapply(
  packages,
  FUN = function(x) {
    if (!require(x, character.only = TRUE)) {
      install.packages(x, dependencies = TRUE)
      library(x, character.only = TRUE)
    }
  }
)

devtools::install_github("nationalparkservice/NPSdataverse")
library(NPSdataverse)

#get the data from the directory where it was provided and place a (new) copy in the current working directory (make sure all files are closed):

current_file_location <- here::here("..", "..", "01_raw_data_and_documents")
file_list <- list.files("../../01_raw_data_and_documents", full.names = TRUE)
new_file_location <- here::here()

file.copy(file_list, new_file_location, overwrite = TRUE)

#get all the files in the working directory
list.files()
#[1] "01_raw_data_and_documents.Rproj"   "HtlnWpfoPopData.csv"
#[3] "HtlnWpfoSoilProbe1_2007_2014.csv"  "HtlnWpfoSoilProbe2_2015_2022.csv"
#[5] "HtlnWpfoVegProfile.csv"            "HtlnWpfoYearCountUnit.csv"
#[7] "NPS_metadata_template-Orchid.docx" "NPS_metadata_template.docx"
#[9] "PIPE_Orchid_2007_b.pdf"

# replace all blank cells with "NA"
# (make sure all files are closed so that they are writable)
QCkit::replace_blanks()

# ------cleanup for #HtlknWpfoPopData.csv

# load the data
df <- read.csv("HtlnWpfoPopData.csv")

# convert GPS_DATE from character to POSIX date object
df$GPS_DATE <- as.Date(df$GPS_DATE, format = "%m/%d/%Y")

# add units to column names
colnames(df)[8] <- "HeightInfl_cm"

# add UTC offset to GPS_TIME (all are collected in CST so -6:00)
df <- df %>% mutate(GPS_TIME = case_when(!is.na(GPS_TIME) ~
                                       paste0(GPS_TIME, "-06:00")))

df$dwcType <- "event"
df$dwcBasisOfRecord <- "HumanObservation"


#write back to csv:
readr::write_csv(df, "HtlnWpfoPopData_CLEANED.csv")

# ---- cleanup for HtlnWpfoSoilProbe1_2007_2014.csv
# cleanup environmental variables:
rm(list=ls())

df <- read.csv("HtlnWpfoSoilProbe1_2007_2014.csv")

# R does not like numbers to start column names or special characters ()
# HTLN has requested to turn the numbers in to words
# changing "MeasurementTime" to "verbatimMeasurementTime"
colnames(df) <- c("verbatimMeasurementTime",
                  "five_cmDepthMoisture",
                  "five_cmDepthTempC",
                  "ten_cmDepthMoisture",
                  "twenty_cmDepthMoisture",
                  "twenty_cmDepthTempC",
                  "forty_cmDepthMoisture",
                  "RainGage_mm")

# verbatimMeasurementTime includes dates, but not in ISO 8601 format. The goal
# here is to create two new columns, both in ISO 8601 format: eventDate and
# eventTime. It will be a multi-step process:

# quick check for missing values. if == 0, no missing values:
nrow(df) - sum(!is.na(df$verbatimMeasurementTime)) # 0 so no missing values

# generate two new columns, one with the dates and one with the times:
df[c('eventDate', 'eventTime')] <- stringr::str_split_fixed(df$verbatimMeasurementTime, ' ', 2)

# quickly check that both date and time column have no missing values:
nrow(df) - sum(!is.na(df$eventDate)) # 0 so no missing values
nrow(df) - sum(!is.na(df$eventTime)) # 0 so no missing values

# reformat the 'date' column to be ISO 8601 compliant:
df$eventDate <- as.Date(df$eventDate, format = "%m/%d/%Y")

# get date ranges
min(df$eventDate) # 2007-07-19
max(df$eventDate) # 2014-10-29

# add a zero to the hour if the hour was recorded as a single digit
# so 9:15 becomes 09:15
df$eventTime <- stringr::str_pad(df$eventTime, 5, side = "left", pad = 0)

# add time zone offset, taking daylights savings into account:
# 2007: March 11 - Nov 4
# 2008: March 09 - Nov 2
# 2009: March 8 - Nov 1
# 2010: March 14 - NOv 7
# 2011: March 13 - Nov 6
# 2012: March 11 - Nov 4
# 2013: March 10 - Nov 3
# 2014: March 9 - Nov 2

# Add UTC time-zone offset to eventTime, taking daylights savings into account
# This sure is ugly... there's gotta be a better way, but it does work ...
df <- df %>% mutate(
    eventTime = ifelse(eventDate > "2007-03-11" & eventDate < "2007-11-04",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2007-11-04" & eventDate < "2008-03-09",
                       paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2008-03-09" & eventDate < "2008-11-02",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2008-11-02" & eventDate < "2009-03-08",
                       paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2009-03-08" & eventDate < "2009-11-01",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2009-11-01" & eventDate < "2010-03-14",
                       paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2010-03-14" & eventDate < "2010-11-07",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2010-11-07" & eventDate < "2011-03-13",
                       paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2011-03-13" & eventDate < "2011-11-06",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2011-11-06" & eventDate < "2012-03-11",
                       paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2012-03-11" & eventDate < "2012-11-04",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2012-11-04" & eventDate < "2013-03-10",
                       paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2013-03-10" & eventDate < "2013-11-03",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2013-11-03" & eventDate < "2014-03-09",
                       paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
    eventTime = ifelse(eventDate >= "2014-03-09" & eventDate < "2014-11-02",
                       paste0(eventTime, "-05:00"), paste0(eventTime, "")))

df$dwcType <- "event"
df$dwcBasisOfRecord <- "MachineObservation"

readr::write_csv(df, "HtlnWpfoSoilProbe1_2007_2014_CLEANED.csv")


# ------ cleanup for HtlnWpfoSoilProbe2_2015_2022.csv
# clean up environment:
rm(list=ls())

# read in the data:
df <- read.csv("HtlnWpfoSoilProbe2_2015_2022.csv")

# rename the data: R doesn't like data columns to start with a number:
colnames(df) <- c("verbatimTimestamps",
                  "five_cmDepth_m3WaterContent",
                  "five_cmDepth_CSoilTemperature",
                  "ten_cmDepth_m3WaterContent",
                  "ten_cmDepth_CSoilTemperature",
                  "twenty_cmDepth_m3WaterContent",
                  "twentycmDepth_CSoilTemperature",
                  "thirty_cmDepth_m3WaterContent",
                  "thirty_cmDepth_CSoilTemperature",
                  "forty_cmDepth_m3WaterContent",
                  "forty_cmDepth_CSoilTemperature",
                  "PrimaryKeyID")

# verbatimTimestamps includes dates, but not in ISO 8601 format. The goal
# here is to create two new columns, both in ISO 8601 format: eventDate and
# eventTime. It will be a multi-step process:

# quick check for missing values. if == 0, no missing values:
nrow(df) - sum(!is.na(df$verbatimTimestamps)) # 0 so no missing values

# generate two new columns, one with the dates and one with the times:
df[c('eventDate', 'eventTime')] <- stringr::str_split_fixed(df$verbatimTimestamps,
                                                            ' ', 2)

# quickly check that both date and time column have no missing values:
nrow(df) - sum(!is.na(df$eventDate)) # 0 so no missing values
nrow(df) - sum(!is.na(df$eventTime)) # 0 so no missing values

# reformat the 'date' column to be ISO 8601 compliant:
df$eventDate <- as.Date(df$eventDate, format = "%m/%d/%Y")

# add a zero to the hour if the hour was recorded as a single digit
# so 9:15 becomes 09:15
df$eventTime <- stringr::str_pad(df$eventTime, 5, side = "left", pad = 0)


# add in UTC offsets, taking into account daylights savings time:
min(df$eventDate) # [1] "2015-04-09"
max(df$eventDate) # [1] "2022-07-12"

# Daylights savings times:
# 2015: March 8 - Nov 1
# 2016: March 13 - Nov 6
# 2017: March 12 - Nov 5
# 2018: March 11 - Nov 4
# 2019: March 10 - Nov 3
# 2020: March 8 - Nov 1
# 2021: March 14 - Nov 7
# 2022: March 13 - Nov 6

# Add UTC offset to the eventTime column, taking into account daylights savings
# This is UGLY. There's got to be a cleaner way.... but it does work!
df <- df %>% mutate(
  eventTime = ifelse(eventDate > "2015-03-081" & eventDate < "2015-11-01",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2015-11-01" & eventDate < "2016-03-13",
                     paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2016-03-13" & eventDate < "2016-11-06",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2016-11-06" & eventDate < "2017-03-12",
                     paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2017-03-12" & eventDate < "2017-11-05",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2017-11-05" & eventDate < "2018-03-11",
                     paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2018-03-11" & eventDate < "2018-11-04",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2018-11-04" & eventDate < "2019-03-10",
                     paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2019-03-10" & eventDate < "2019-11-03",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2019-11-03" & eventDate < "2020-03-08",
                     paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2020-03-08" & eventDate < "2020-11-01",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2020-11-01" & eventDate < "2021-03-14",
                     paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2021-03-14" & eventDate < "2021-11-07",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2021-11-07" & eventDate < "2022-03-13",
                     paste0(eventTime, "-06:00"), paste0(eventTime, "")))
df <- df %>% mutate(
  eventTime = ifelse(eventDate >= "2022-03-13" & eventDate < "2022-11-06",
                     paste0(eventTime, "-05:00"), paste0(eventTime, "")))

df$dwcType <- "event"
df$dwcBasisOfRecord <- "MachineObservation"

#write changes back out to csv:
readr::write_csv(df, "HtlnWpfoSoilProbe2_2015_2022_CLEANED.csv")

# ------ cleanup for HtlnWpfoVegProfile.csv
# cleanup environment:
rm(list=ls())

# load data:
df <- read.csv("HtlnWpfoVegProfile.csv")

# rename coluns to include units:
colnames(df) <- c("Year", "Site", "ObserverDistance_m", "HeightInterval_m",
                  "Cover", "PercentRangeOfCover", "PercentClassMidpt")

# remove unites (m) from HeightInterval_m:
df$HeightInterval_m <- str_sub(df$HeightInterval_m, end = -2)

# add darwin core columns
df$dwcType <- "event"
df$dwcBasisOfRecord <- "HumanObservation"


# write df back out to csv
readr::write_csv(df, "HtlnWpfoVegProfile_CLEANED.csv")

# ------ cleanup for "HtlnWpfoYearCountUnit.csv"
# clean environment
rm(list=ls())

# load data:
df <- read.csv("HtlnWpfoYearCountUnit.csv")

# add darwin core columns
df$dwcType <- "event"
df$dwcBasisOfRecord <- "HumanObservation"

# rename YEAR to get rid of trailing underscore:
colnames(df)[1] <- "YEAR"

# write df back to .csv:

readr::write_csv(df, "HtlnWpfoYearCountUnit_CLEANED.csv")

# --- generate a temporary .csv with the taxonomy
# There is only a single species and it is not actually in any of the data files, we need a temporary .csv with the species name to generate the taxonomy for metadata. This .csv will NOT be included in the final data package, it is for metadata generation purposes only.

# create very simple data frame
df <- data.frame(ID = "A01",
                 scientificName = "Platanthera praeclara")

# write to .csv. We will call it "CLEANED" because it is very clean. And it will make moving it to the EML generation folder much easier.
readr::write_csv(df, "taxonomy_CLEANED.csv")