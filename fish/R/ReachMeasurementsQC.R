
library(tidyverse)

reachmeasurements <- read_csv("./ReachMeasurements.csv")

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


# Variables: LocationID, PeriodID and EventID ----------------------------------

reachmeasurements |> distinct(LocationID) |> 
  print(n = 102)

reachmeasurements |> distinct(PeriodID) |> 
  print(n = 63)

reachmeasurements |> distinct(EventID) |> 
  print(n = 318)


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











