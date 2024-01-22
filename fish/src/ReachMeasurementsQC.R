
library(tidyverse)

reachmeasurements <- read_csv("./FishHabitat_ReachMeasurements.csv")

problems(reachmeasurements)

view(reachmeasurements)

glimpse(reachmeasurements)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

reachmeasurements |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

reachmeasurements |> distinct(ParkCode)

ggplot(reachmeasurements, aes(x = ParkCode)) + 
  geom_bar()

# Variables: LocationID, LocationNumber, LocationType, LocationDescription -----

reachmeasurements |> distinct(LocationID) |> 
  print(n = 109)

reachmeasurements |> distinct(LocationNumber) |> # Can I omit LocationNumber??
  print(n = 40)

reachmeasurements |> distinct(LocationType) |> 
  print(n = 4)

reachmeasurements |> distinct(LocationDescription) |> 
  print(n = 71)

# Variables: StreamName, TributaryName, County ---------------------------------

reachmeasurements |> distinct(StreamName) |> 
  print(n = 89)

reachmeasurements |> distinct(TributaryName) |> 
  print(n = 46)

reachmeasurements |> distinct(County) |> 
  print(n = 40)

# Variables: StretchNumber, ReachID, ReachLength_m, StreamWatershedArea -------


reachmeasurements |> distinct(StretchNumber) |> 
  print(n = 63) 


reachmeasurements |> distinct(ReachID) |>  
  print(n = 102)

reachmeasurements |> distinct(ReachLength_m) |>  
  print(n = 27)

reachmeasurements |> distinct(StreamWatershedArea_sqkm) |>  
  print(n = 51)



# Variables: PeriodID, EventID and related variables ---------------------------

 
t <- reachmeasurements |> 
  distinct(PeriodID, Season, 
           tbl_SamplingPeriods_StartDate, 
           tbl_SamplingPeriods_EndDate, 
           EventID, tbl_SamplingEvents_StartDate, 
           tbl_SamplingEvents_EndDate, EventComments)

 view(t)
 

# Variables: SiteNumber, Beginning_Ending, TimeSampled_hhmm_mil 
 
 reachmeasurements |> distinct(SiteNumber)
 
 reachmeasurements |> distinct(Beginning_Ending) 
  
    # Note - lowercase Ending
 
 reachmeasurements |> distinct(TimeSampled_hhmm_mil) |>  
   print(n = 310)


reachmeasurements$TimeSampled_hhmm_mil <- str_sub(reachmeasurements$TimeSampled_hhmm_mil, 
                                    start = 12, end = -1)

 
reachmeasurements |> distinct(TimeSampled_hhmm_mil) |>  
       print(n = 310)

  # Can we strip off seconds??
   
 # Variables: Reach measurements - WaterTemp_C ---------------------------------
 
ggplot(reachmeasurements, aes(x = WaterTemp_C)) +
  geom_histogram(binwidth = 1)

c <- reachmeasurements |>
  filter(WaterTemp_C > 0)

ggplot(c, aes(x = WaterTemp_C)) +
  geom_histogram(binwidth = 1)
 
# Variables: Reach measurements - AirTemp_C ------------------------------------

ggplot(reachmeasurements, aes(x = AirTemp_C)) +
  geom_histogram(binwidth = 1)

c <- reachmeasurements |>
  filter(AirTemp_C > 0)

ggplot(c, aes(x = AirTemp_C)) +
  geom_histogram(binwidth = 1)


# Variables: Reach measurements - pH -------------------------------------------

ggplot(reachmeasurements, aes(x = pH)) +
  geom_histogram(binwidth = 1)

c <- reachmeasurements |>
  filter(pH > 0)

ggplot(c, aes(x = pH)) +
  geom_histogram(binwidth = .05)


# Variables: Reach measurements - SpecificConductance_microScm -----------------


ggplot(reachmeasurements, aes(x = SpecificConductance_microScm)) +
  geom_histogram(binwidth = 1)

c <- reachmeasurements |>
  filter(SpecificConductance_microScm > 0)

ggplot(c, aes(x = SpecificConductance_microScm)) +
  geom_histogram(binwidth = 50)


# Variables: Reach measurements - Conductivity_microScm ------------------------


ggplot(reachmeasurements, aes(x = Conductivity_microScm)) +
  geom_histogram(binwidth = 1)

c <- reachmeasurements |>
  filter(Conductivity_microScm > 0)

ggplot(c, aes(x = Conductivity_microScm)) +
  geom_histogram(binwidth = 10)

# Variables: Reach measurements - DissolvedOxygen_mgL ------------------------


ggplot(reachmeasurements, aes(x = DissolvedOxygen_mgL)) +
  geom_histogram(binwidth = 1)

c <- reachmeasurements |>
  filter(DissolvedOxygen_mgL > 0)

ggplot(c, aes(x = DissolvedOxygen_mgL)) +
  geom_histogram(binwidth = .1)

# Variables: Reach measurements - SecchiTube ------------------------

ggplot(reachmeasurements, aes(x = SecchiTube)) +
  geom_histogram(binwidth = 1)

c <- reachmeasurements |>
  filter(SecchiTube > 0)

ggplot(c, aes(x = SecchiTube)) +
  geom_histogram(binwidth = 5)

c <- reachmeasurements |>
  filter(SecchiTube > 100)

ggplot(c, aes(x = SecchiTube)) +
  geom_histogram(binwidth = 1)

reachmeasurements |> distinct(SecchiTube)  |>  
  print(n = 186)


# Variable: Units ------------------------

reachmeasurements |> distinct(Units)  |>  
  print(n = 186)

# keep?









