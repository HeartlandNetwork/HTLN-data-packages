
library(tidyverse)

dischargemeasures <- read_csv("./DischargeFieldMeasurements.csv")

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


# Variables: LocationID, PeriodID and EventID

dischargemeasures |> distinct(LocationID) |> 
  print(n = 80)

dischargemeasures |> distinct(PeriodID) |> 
  print(n = 72)

dischargemeasures |> distinct(EventID) |> 
  print(n = 320)
 

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
  geom_histogram(binwidth = 5)


# Variable: Velocity_ms -------------------------------------


ggplot(dischargemeasures, aes(x = Velocity_ms)) +
  geom_histogram(binwidth = 1)

c <- dischargemeasures |>
  filter(Velocity_ms > 0)

ggplot(c, aes(x = Velocity_ms)) +
  geom_histogram(binwidth = 0.01)


 # Variable: Comments -------------------------------------
 
 dischargemeasures |>
   distinct(Comments)  |>  
   print(n = 45)

 
 






