
library(tidyverse)

transectspacing <- read_csv("./TransectSpacingInterval.csv")

problems(transectspacing) 

view(transectspacing)

glimpse(transectspacing)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

transectspacing |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

transectspacing |> distinct(ParkCode)

ggplot(transectspacing, aes(x = ParkCode)) + 
  geom_bar()

# Variables: LocationID, PeriodID and EventID ----------------------------------

transectspacing |> distinct(LocationID) |> 
  print(n = 80)

transectspacing |> distinct(PeriodID) |> 
  print(n = 74)

transectspacing |> distinct(EventID) |> 
  print(n = 327)


# Variables: ChannelType, ChannelTypeDesc, ChannelTypeSampledLength_m
#  NumberofTransects, TransectSpacingInverval_m

 transectspacing |> distinct(ChannelType)
 
 transectspacing |> distinct(ChannelTypeDescr)
 
 transectspacing |> distinct(ChannelTypeSampledLength_m) |>
   print(n = 81)
 
 transectspacing |> distinct(NumberOfTransects)
 
 transectspacing |> distinct(TransectSpacingInterval_m) |>
   print(n = 65)
 
 ggplot(transectspacing, aes(x = TransectSpacingInterval_m)) +
   geom_histogram(binwidth = 1)
 
 
 
 
 
