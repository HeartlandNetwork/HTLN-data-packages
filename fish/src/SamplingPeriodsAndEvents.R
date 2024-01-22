

library(tidyverse)

periodsevents <- read_csv("./SamplingPeriodsAndEvents.csv")

problems(periodsevents)

view(periodsevents)

glimpse(periodsevents)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

periodsevents |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

periodsevents |> distinct(ParkCode)

ggplot(periodsevents, aes(x = ParkCode)) + 
  geom_bar()

# Variables: PeriodID, EventID and related variables ---------------------------

periodsevents |> 
  distinct(PeriodID, Season, tbl_SamplingPeriods_StartDate, 
           tbl_SamplingPeriods_EndDate, 
           EventID, tbl_SamplingEvents_StartDate, 
           tbl_SamplingEvents_EndDate, EventComments) |>
  view()



