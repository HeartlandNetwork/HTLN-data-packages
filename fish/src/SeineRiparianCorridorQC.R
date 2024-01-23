
library(tidyverse)

seineriparian <- read_csv("./SeineRiparianCorridor.csv")

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

# Variables: LocationID, PeriodID and EventID ----------------------------------

seineriparian |> distinct(LocationID) |> 
  print(n = 20)

seineriparian |> distinct(PeriodID) |> 
  print(n = 40)

seineriparian |> distinct(EventID) |> 
  print(n = 91)


# Variables: SiteNumber  and SampleLocation ------------------------------
 
 seineriparian |> distinct(SiteNumber)
 
 seineriparian |> distinct(SampleLocation) 
 
 
 # Variables: RiparianCover_0to25_m thru GT100 _m and StreamBankErosionCover

 
 seineriparian |> distinct(RiparianCover_0to25_m) |>
   arrange(RiparianCover_0to25_m)
 
 seineriparian |> distinct(RiparianCover_26to50_m)  |>
   arrange(RiparianCover_26to50_m)
 
 seineriparian |> distinct(RiparianCover_51to75_m) |>
   arrange(RiparianCover_51to75_m)
 
 seineriparian |> distinct(RiparianCover_76to100_m) |>
   arrange(RiparianCover_76to100_m)
 
 seineriparian |> distinct(RiparianCover_GT100_m) |>
   arrange(RiparianCover_GT100_m)
 
 seineriparian |> distinct(StreamBankErosionCover) |>
   arrange(StreamBankErosionCover)
 
 
 
 

