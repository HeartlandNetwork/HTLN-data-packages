
library(tidyverse)

locationdetails <- read_csv("./LocationDetails.csv")

problems(locationdetails)

view(locationdetails)

glimpse(locationdetails) 


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

locationdetails |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

locationdetails |> distinct(ParkCode)


ggplot(locationdetails, aes(x = ParkCode)) + 
  geom_bar()


# Variables: LocationID, LocationNumber, LocationType, LocationDescription -----
  
locationdetails |> distinct(LocationID) |> 
  print(n = 118)

locationdetails |> distinct(LocationNumber) |> 
  print(n = 40)

locationdetails |> distinct(LocationType) |> 
  print(n = 4)


# Variables: StreamName, TributaryName, County ---------------------------------

locationdetails |> distinct(StreamName) |> 
  print(n = 101)

locationdetails |> distinct(TributaryName) |> 
  print(n = 51)

locationdetails |> distinct(County) |> 
  print(n = 15)

# Variables: StretchNumber, ReachID, ReachLength_m, StreamWatershedArea -------


locationdetails |> distinct(StretchNumber) |> 
  print(n = 68) 

locationdetails |> distinct(ReachID) |>  
  print(n = 118)

locationdetails |> distinct(ReachLength_m) |>  
  print(n = 34)

locationdetails |> distinct(StreamWatershedArea_sqkm) |>  
  print(n = 52)

glimpse(locationdetails)