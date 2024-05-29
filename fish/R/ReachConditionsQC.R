
library(tidyverse)

reachconditions <- read_csv("./ReachConditions.csv")

problems(reachconditions)

view(reachconditions)

glimpse(reachconditions)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

reachconditions |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

reachconditions |> distinct(ParkCode)

ggplot(reachconditions, aes(x = ParkCode)) + 
  geom_bar()


# Variables: LocationID, PeriodID and EventID ----------------------------------

reachconditions |> distinct(LocationID) |> 
  print(n = 109)

reachconditions |> distinct(PeriodID) |> 
  print(n = 117)

reachconditions |> distinct(EventID) |> 
  print(n = 398)

# Variables: Pct_CloudCover, WindIntensity, PrecipitationType, PrecipitationIntensity  
 
 reachconditions |> distinct(Pct_CloudCover) |>  
   print(n = 21)
 
 
 reachconditions |> distinct(WindIntensity) 
 
 reachconditions |> distinct(PrecipitationType, PrecipitationIntensity) 
 

   
 # Variables: SH_Springs_Present, SH_StreamFlow_Description  -------------
 
 reachconditions |> distinct(SH_Springs_Present)
 
 reachconditions |> distinct(SH_StreamFlow_Description)
 
 # WeatherComment, AdditionalComments ----------------------------------------------------

reachconditions |> 
  distinct(WeatherComments) |>  
  print(n = 75) |>
  view()

 r <- reachconditions |> 
   distinct(AdditionalComments) |>  
   print(n = 284)
 
view(r)
 
 
 

