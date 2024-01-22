
library(tidyverse)

dischargeinfo <- read_csv("./DischargeGaugeInfo.csv")

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


# Variables: LocationID, PeriodID and EventID

dischargeinfo |> distinct(LocationID) 

dischargeinfo |> distinct(PeriodID) 

dischargeinfo |> distinct(EventID) 


# Variables: ChannelType, ChannelTypeDescr  ----------------------------------
 
 dischargeinfo |> distinct(ChannelType)
 
 
 dischargeinfo |> distinct(ChannelTypeDescr)
 
 # Variables: GaugeSiteNo, GauageStations_StreamName, GaugeLocation --------
 
 glimpse(dischargeinfo)
 
 dischargeinfo |> 
   distinct(GaugeSiteNo, StreamName, GaugeLocation) |>  
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

 
 
 

