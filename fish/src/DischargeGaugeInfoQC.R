
library(tidyverse)

dischargeinfo <- read_csv("./FishHabitat_DischargeGaugeInfo.csv")

problems(dischargeinfo)


view(dischargeinfo)

glimpse(dischargeinfo)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

dischargeinfo |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

dischargeinfo |> distinct(ParkCode)



ggplot(dischargeinfo, aes(x = ParkCode)) + 
  geom_bar()



# Variables: LocationID, LocationNumber, LocationType, LocationDescription -----

dischargeinfo |> distinct(LocationID) |> 
  print(n = 108)

dischargeinfo |> distinct(LocationNumber) |> # Can I omit LocationNumber??
  print(n = 40)

dischargeinfo |> distinct(LocationType) |> 
  print(n = 40)

dischargeinfo |> distinct(LocationDescription) |> 
  print(n = 70)

# Variables: StreamName, TributaryName, County ---------------------------------

dischargeinfo |> distinct(tbl_Locations_StreamName) |> 
  print(n = 96)

dischargeinfo |> distinct(TributaryName) |> 
  print(n = 46)

dischargeinfo |> distinct(County) |> 
  print(n = 40)

# Variables: StretchNumber, ReachID, ReachLength_m, StreamWatershedArea -------


dischargeinfo |> distinct(StretchNumber) |> 
  print(n = 6) 


dischargeinfo |> distinct(ReachID) |>  
  print(n = 7)

dischargeinfo |> distinct(ReachLength_m) |>  
  print(n = 7)

dischargeinfo |> distinct(StreamWatershedArea_sqkm) |>  
  print(n = 7)



# Variables: PeriodID, EventID and related variables ---------------------------

 
t <- dischargeinfo |> 
  distinct(PeriodID, Season, tbl_SamplingPeriods_StartDate, 
           tbl_SamplingPeriods_EndDate, 
           EventID, tbl_SamplingEvents_StartDate, 
           tbl_SamplingEvents_EndDate, EventComments)

 view(t)
 

# Variables: ChannelType, ChannelTypeDescr  ----------------------------------
 
 dischargeinfo |> distinct(ChannelType)
 
 
 dischargeinfo |> distinct(ChannelTypeDescr)
 
 # Variables: GaugeSiteNo, tlu_GauageStations_StreamName, GaugeLocation --------
 
 dischargeinfo |> 
   distinct(GaugeSiteNo, tlu_GaugeStations_StreamName, GaugeLocation) |>  
   print(n = 6) # clean up weird chars in GauageLocation
 
# Variable: tlu_GaugeStations_Comments  

dischargeinfo |> 
  distinct(tlu_GaugeStations_Comments) |>  
  print(n = 7)

# Variable: Discharge_cms

ggplot(dischargeinfo, aes(x = Discharge_cms)) +
  geom_histogram(binwidth = 1)

 # Variable: Comments
 
 dischargeinfo |>
   distinct(tbl_DischargeGauge_Comments)  |>  
   print(n = 17)

 
 
 

