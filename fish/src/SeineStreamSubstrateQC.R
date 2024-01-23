
library(tidyverse)

seinesubstrate <- read_csv("./SeineStreamSubstrate.csv")

problems(seinesubstrate) 

view(seinesubstrate)

glimpse(seinesubstrate)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

seinesubstrate |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

seinesubstrate |> distinct(ParkCode)

ggplot(seinesubstrate, aes(x = ParkCode)) + 
  geom_bar()

# Variables: LocationID, PeriodID and EventID ----------------------------------

seinesubstrate |> distinct(LocationID) |> 
  print(n = 29)

seinesubstrate |> distinct(PeriodID) |> 
  print(n = 42)

seinesubstrate |> distinct(EventID) |> 
  print(n = 93)


# Variables: SiteNumber 

 seinesubstrate |> distinct(SiteNumber)
 
 
 # Substrate Variables: Muck, Detritus, Silt, Sand, 
 # Pea_gravel, Course_gravel,
 # Cobble, Boulder, Bedrock, Hardpan_shale

 
 seinesubstrate |> distinct(Muck) |>
   arrange(Muck)
 
 seinesubstrate |> distinct(Detritus)  |>
   arrange(Detritus)
 
 seinesubstrate |> distinct(Silt) |>
   arrange(Silt)
 
 seinesubstrate |> distinct(Sand) |>
   arrange(Sand)
 
 seinesubstrate |> distinct(Pea_gravel) |>
   arrange(Pea_gravel)
 
 seinesubstrate |> distinct(Coarse_gravel) |>
   arrange(Coarse_gravel)
 
 seinesubstrate |> distinct(Cobble) |>
   arrange(Cobble)
 
 seinesubstrate |> distinct(Boulder) |>
   arrange(Boulder)
 
 seinesubstrate |> distinct(Bedrock) |>
   arrange(Bedrock)
 
 seinesubstrate |> distinct(Hardpan_shale) |>
   arrange(Hardpan_shale)
 
 

