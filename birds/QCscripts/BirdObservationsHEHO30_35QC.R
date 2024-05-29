
library(tidyverse)
# library(data.table)

birdobs <- read_csv("src/BirdObservationsThru2022_3.csv")

glimpse(birdobs)

# Variable: ParkUnit --------------------------------------------------------------

# Unique list - PASS

birdobs |> distinct(ParkUnit)

# bar chart looking at count by park unit - PASS

ParkUnit_factor <- factor(birdobs$ParkUnit)

ggplot(birdobs, aes(x = ParkUnit_factor)) + 
  geom_bar()

# Variable: 'Plot --------------------------------------------------------------

# Unique list - PASS

birdobs |> distinct(Plot) |>
  print(n = 843)

# Test for HEHO30 and HEHO35 for 2010

glimpse(birdobs)

birdobs |> 
  distinct(ParkUnit, Plot, EventID) |>
  filter(ParkUnit == "Herbert Hoover", Plot == "HEHO30")

birdobs |> 
  distinct(ParkUnit, Plot, EventID) |>
  filter(ParkUnit == "Herbert Hoover", Plot == "HEHO35")


