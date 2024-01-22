
library(tidyverse)

fishcover <- read_csv("./FishCoverInfo.csv")

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

# Variable: LocationID --------------------------------------------------------
  
  fishcover |> distinct(LocationID) |> 
  print(n = 80)

# Variables PeriodID and EventID  ---------------------------

fishcover |> distinct(PeriodID) |> 
  print(n = 73)

fishcover |> distinct(EventID) |> 
  print(n = 296)

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



 
 
 

