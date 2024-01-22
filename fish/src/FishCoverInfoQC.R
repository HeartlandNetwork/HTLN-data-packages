
library(tidyverse)

fishcover <- read_csv("./FishHabitat_FishCoverInfo.csv")

problems(fishcover)

view(fishcover)

glimpse(fishcover)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

fishcover |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

fishcover |> distinct(ParkCode)



ggplot(fishcover, aes(x = ParkCode)) + 
  geom_bar()



# Variables: LocationID, LocationNumber, LocationType, LocationDescription -----

fishcover |> distinct(LocationID) |> 
  print(n = 108)

fishcover |> distinct(LocationNumber) |> # Can I omit LocationNumber??
  print(n = 40)

fishcover |> distinct(LocationType) |> 
  print(n = 40)

fishcover |> distinct(LocationDescription) |> 
  print(n = 70)

# Variables: StreamName, TributaryName, County ---------------------------------

fishcover |> distinct(StreamName) |> 
  print(n = 96)

fishcover |> distinct(TributaryName) |> 
  print(n = 46)

fishcover |> distinct(County) |> 
  print(n = 40)

# Variables: StretchNumber, ReachID, ReachLength_m, StreamWatershedArea -------


fishcover |> distinct(StretchNumber) |> 
  print(n = 63) 


fishcover |> distinct(ReachID) |>  
  print(n = 80)

fishcover |> distinct(ReachLength_m) |>  
  print(n = 29)

fishcover |> distinct(StreamWatershedArea_sqkm) |>  
  print(n = 51)



# Variables: PeriodID, EventID and related variables ---------------------------

 
t <- fishcover |> 
  distinct(PeriodID, Season, tbl_SamplingPeriods_StartDate, 
           tbl_SamplingPeriods_EndDate, 
           EventID, tbl_SamplingEvents_StartDate, 
           tbl_SamplingEvents_EndDate, EventComments)

 view(t)
 

# Variables: TransectNumber, SampleLocation, SampleLocationDescr  -------------
 
 fishcover |> distinct(TransectNumber)
 
 fishcover |> distinct(SampleLocation, SampleLocationDescr)
 
 
 # Variables: ChannelType, ChannelTypeDescr  -------------
 
 fishcover |> distinct(ChannelType, ChannelTypeDescr)
 
 # True/False Cover Info --------------------------------------
 
 fishcover |> distinct(HydroMoss_HY)
 
 fishcover |> distinct(Boulders_BO)
 
 fishcover |> distinct(Artificial_AR)
 
 fishcover |> distinct(SmallWoodDeb_SWD)
 
 fishcover |> distinct(LargeWoodDeb_LWD)
 
 fishcover |> distinct(TreesRoots_TR)
 
 fishcover |> distinct(OverhangVeg_OV)
 
 fishcover |> distinct(UndercutBank_UC)
 
 fishcover |> distinct(Bluff_BL)
 
 # Comment ----------------------------------------------------

fishcover |> 
  distinct(Comment) |>  
  print(n = 225)



 
 
 

