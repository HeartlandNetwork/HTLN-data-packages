
library(tidyverse)

seineriparian <- read_csv("./FishHabitat_SeineRiparianCorridor.csv")

problems(seineriparian) 

view(seineriparian)

glimpse(seineriparian)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

seineriparian |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

seineriparian |> distinct(ParkCode)

ggplot(seineriparian, aes(x = ParkCode)) + 
  geom_bar()

# Variables: LocationID, LocationNumber, LocationType, LocationDescription -----

seineriparian |> distinct(LocationID) |> 
  print(n = 109)

seineriparian |> distinct(LocationNumber) |> # Can I omit LocationNumber??
  print(n = 40)

seineriparian |> distinct(LocationType) |> 
  print(n = 4)

seineriparian |> distinct(LocationDescription) |> 
  print(n = 71)

# Variables: StreamName, TributaryName, County ---------------------------------

seineriparian |> distinct(StreamName) |> 
  print(n = 89)

seineriparian |> distinct(TributaryName) |> 
  print(n = 46)

seineriparian |> distinct(County) |> 
  print(n = 40)

# Variables: StretchNumber, ReachID, ReachLength_m, StreamWatershedArea -------


seineriparian |> distinct(StretchNumber) |> 
  print(n = 63) 


seineriparian |> distinct(ReachID) |>  
  print(n = 102)

seineriparian |> distinct(ReachLength_m) |>  
  print(n = 27)

seineriparian |> distinct(StreamWatershedArea_sqkm) |>  
  print(n = 51)



# Variables: PeriodID, EventID and related variables ---------------------------

 
t <- seineriparian |> 
  distinct(PeriodID, Season, 
           tbl_SamplingPeriods_StartDate, 
           tbl_SamplingPeriods_EndDate, 
           EventID, tbl_SamplingEvents_StartDate, 
           tbl_SamplingEvents_EndDate, EventComments)

 view(t)
 

# Variables: SiteNumber, Beginning_Ending, TimeSampled_hhmm_mil 
 
 seineriparian |> distinct(SiteNumber)
 
 seineriparian |> distinct(Beginning_Ending) 
  
    # Note - lowercase Ending
 
 seineriparian |> distinct(TimeSampled_hhmm_mil) |>  
   print(n = 310)


seineriparian$TimeSampled_hhmm_mil <- str_sub(seineriparian$TimeSampled_hhmm_mil, 
                                    start = 12, end = -1)

 
seineriparian |> distinct(TimeSampled_hhmm_mil) |>  
       print(n = 310)

  # Can we strip off seconds??
   
 # Variables: Reach measurements - WaterTemp_C ---------------------------------
 
ggplot(seineriparian, aes(x = WaterTemp_C)) +
  geom_histogram(binwidth = 1)

c <- seineriparian |>
  filter(WaterTemp_C > 0)

ggplot(c, aes(x = WaterTemp_C)) +
  geom_histogram(binwidth = 1)
 
# Variables: Reach measurements - AirTemp_C ------------------------------------

ggplot(seineriparian, aes(x = AirTemp_C)) +
  geom_histogram(binwidth = 1)

c <- seineriparian |>
  filter(AirTemp_C > 0)

ggplot(c, aes(x = AirTemp_C)) +
  geom_histogram(binwidth = 1)


# Variables: Reach measurements - pH -------------------------------------------

ggplot(seineriparian, aes(x = pH)) +
  geom_histogram(binwidth = 1)

c <- seineriparian |>
  filter(pH > 0)

ggplot(c, aes(x = pH)) +
  geom_histogram(binwidth = .05)


# Variables: Reach measurements - SpecificConductance_microScm -----------------


ggplot(seineriparian, aes(x = SpecificConductance_microScm)) +
  geom_histogram(binwidth = 1)

c <- seineriparian |>
  filter(SpecificConductance_microScm > 0)

ggplot(c, aes(x = SpecificConductance_microScm)) +
  geom_histogram(binwidth = 50)


# Variables: Reach measurements - Conductivity_microScm ------------------------


ggplot(seineriparian, aes(x = Conductivity_microScm)) +
  geom_histogram(binwidth = 1)

c <- seineriparian |>
  filter(Conductivity_microScm > 0)

ggplot(c, aes(x = Conductivity_microScm)) +
  geom_histogram(binwidth = 10)

# Variables: Reach measurements - DissolvedOxygen_mgL ------------------------


ggplot(seineriparian, aes(x = DissolvedOxygen_mgL)) +
  geom_histogram(binwidth = 1)

c <- seineriparian |>
  filter(DissolvedOxygen_mgL > 0)

ggplot(c, aes(x = DissolvedOxygen_mgL)) +
  geom_histogram(binwidth = .1)

# Variables: Reach measurements - SecchiTube ------------------------

ggplot(seineriparian, aes(x = SecchiTube)) +
  geom_histogram(binwidth = 1)

c <- seineriparian |>
  filter(SecchiTube > 0)

ggplot(c, aes(x = SecchiTube)) +
  geom_histogram(binwidth = 5)

c <- seineriparian |>
  filter(SecchiTube > 100)

ggplot(c, aes(x = SecchiTube)) +
  geom_histogram(binwidth = 1)

seineriparian |> distinct(SecchiTube)  |>  
  print(n = 186)


# Variable: Units ------------------------

seineriparian |> distinct(Units)  |>  
  print(n = 186)

# keep?









