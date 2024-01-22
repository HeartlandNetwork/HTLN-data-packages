
library(tidyverse)

reachconditions <- read_csv("./FishHabitat_ReachConditions.csv")

problems(reachconditions)

view(reachconditions)

glimpse(reachconditions)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

reachconditions |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

reachconditions |> distinct(ParkCode)

ggplot(reachconditions, aes(x = ParkCode)) + 
  geom_bar()

# Variables: LocationID, LocationNumber, LocationType, LocationDescription -----

reachconditions |> distinct(LocationID) |> 
  print(n = 109)

reachconditions |> distinct(LocationNumber) |> # Can I omit LocationNumber??
  print(n = 40)

reachconditions |> distinct(LocationType) |> 
  print(n = 4)

reachconditions |> distinct(LocationDescription) |> 
  print(n = 71)

# Variables: StreamName, TributaryName, County ---------------------------------

reachconditions |> distinct(StreamName) |> 
  print(n = 96)

reachconditions |> distinct(TributaryName) |> 
  print(n = 46)

reachconditions |> distinct(County) |> 
  print(n = 40)

# Variables: StretchNumber, ReachID, ReachLength_m, StreamWatershedArea -------


reachconditions |> distinct(StretchNumber) |> 
  print(n = 63) 


reachconditions |> distinct(ReachID) |>  
  print(n = 109)

reachconditions |> distinct(ReachLength_m) |>  
  print(n = 30)

reachconditions |> distinct(StreamWatershedArea_sqkm) |>  
  print(n = 51)



# Variables: PeriodID, EventID and related variables ---------------------------

 
t <- reachconditions |> 
  distinct(PeriodID, Season, 
           tbl_SamplingPeriods_StartDate, 
           tbl_SamplingPeriods_EndDate, 
           EventID, tbl_SamplingEvents_StartDate, 
           tbl_SamplingEvents_EndDate, EventComments)

 view(t)
 

# Variables: Pct_CloudCover, WindIntensity, PrecipitationType, PrecipitationIntensity  
 
 reachconditions |> distinct(Pct_CloudCover) |>  
   print(n = 21)
 
 
 reachconditions |> distinct(WindIntensity) 
 
 reachconditions |> distinct(PrecipitationType, PrecipitationIntensity) 
 
   # ?? review these values with Hope
   
 # Variables: SH_Springs_Present, SH_StreamFlow_Description  -------------
 
 reachconditions |> distinct(SH_Springs_Present)
 
 reachconditions |> distinct(SH_StreamFlow_Description)
 
 # WeatherComment, AdditionalComments ----------------------------------------------------

reachconditions |> 
  distinct(WeatherComments) |>  
  print(n = 75)

 r <- reachconditions |> 
   distinct(AdditionalComments) |>  
   print(n = 284)
 
view(r)
 
 
 

