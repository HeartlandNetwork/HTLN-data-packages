
library(tidyverse)

dischargemeasures <- read_csv("./FishHabitat_DischargeFieldMeasurements.csv")

problems(dischargemeasures)


view(dischargemeasures)

glimpse(dischargemeasures)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

dischargemeasures |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

dischargemeasures |> distinct(ParkCode)



ggplot(dischargemeasures, aes(x = ParkCode)) + 
  geom_bar()



# Variables: LocationID, LocationNumber, LocationType, LocationDescription -----

dischargemeasures |> distinct(LocationID) |> 
  print(n = 108)

dischargemeasures |> distinct(LocationNumber) |> # Can I omit LocationNumber??
  print(n = 40)

dischargemeasures |> distinct(LocationType) |> 
  print(n = 40)

dischargemeasures |> distinct(LocationDescription) |> 
  print(n = 70)

# Variables: StreamName, TributaryName, County ---------------------------------

dischargemeasures |> distinct(StreamName) |> 
  print(n = 96)

dischargemeasures |> distinct(TributaryName) |> 
  print(n = 46)

dischargemeasures |> distinct(County) |> 
  print(n = 40)

# Variables: StretchNumber, ReachID --------------------------------------------


dischargemeasures |> distinct(StretchNumber) |> 
  print(n = 108) 


dischargemeasures |> distinct(ReachID) |>  
  print(n = 109)


# Variables: PeriodID, EventID and related variables ---------------------------

 
t <- dischargemeasures |> 
  distinct(PeriodID, Season, tbl_SamplingPeriods_StartDate, 
           tbl_SamplingPeriods_EndDate, 
           EventID, tbl_SamplingEvents_StartDate, 
           tbl_SamplingEvents_EndDate, EventComments)

 view(t)
 

# Variables: ChannelType  ----------------------------------
 
 dischargemeasures |> distinct(ChannelType)
 
 
 # Variables: DischargeNo, DistnaceFromBank_m --
 
 dischargemeasures |> 
   distinct(DischargeNo) |>  
   print(n = 527)

dischargemeasures |> 
  distinct(DistanceFromBank_m) |>  
  print(n = 527)

ggplot(dischargemeasures, aes(x = DistanceFromBank_m)) +
  geom_histogram(binwidth = 1)

c <- dischargemeasures |>
  filter(DistanceFromBank_m > 0)

ggplot(c, aes(x = DistanceFromBank_m)) +
  geom_histogram(binwidth = 1)

 
 # Variable: Depth_cm -------------------------------------

ggplot(dischargemeasures, aes(x = Depth_cm)) +
  geom_histogram(binwidth = 1)

c <- dischargemeasures |>
  filter(Depth_cm > 0)

ggplot(c, aes(x = Depth_cm)) +
  geom_histogram(binwidth = 1)


# Variable: Velocity_ms -------------------------------------


ggplot(dischargemeasures, aes(x = Velocity_ms)) +
  geom_histogram

c <- dischargemeasures |>
  filter(Velocity_ms > 0)

ggplot(c, aes(x = Velocity_ms)) +
  geom_histogram(binwidth = 0.01)


 # Variable: Comments -------------------------------------
 
 dischargemeasures |>
   distinct(Comments)  |>  
   print(n = 45)
 
 # Variable: Units - drop this field??
 
 dischargemeasures |>
   distinct(Units)  |>  
   print(n = 45)
 
 






