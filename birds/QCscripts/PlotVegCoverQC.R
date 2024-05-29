
library(tidyverse)


mydata <- read_csv("./src/PlotVegCover.csv")

glimpse(mydata)



# Variable: ParkUnit -----------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

mydata |> distinct(ParkUnit)

mydata |> 
  group_by(ParkUnit) |> summarize(n = n())


# Variable: Plot --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

mydata |> distinct(Plot) |>
  print(n = 807)

mydata1 <- mydata |> select(ParkUnit, Plot)

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()


glimpse(mydata)

# Variable: EventDate --------------------------------------------------------------
# Unique list - PASS
# EventDate frequencies - PASS

mydata |> distinct(EventDate) |>
  arrange(EventDate) |> print(n = 243)

mydata |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 807)

glimpse(mydata)


# Variable: VegType --------------------------------------------------------------
# Unique list - PASS
# VegType frequencies - PASS

mydata |> distinct(VegType) |>
  print(n = 34)


mydata1 <- mydata |> select(ParkUnit, VegType)

mydata1

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()

glimpse(mydata)


# Variables: CovClass, MidPointValue, Range --------------------------
# Unique list - PASS
# Plot frequencies - PASS

mydata |> 
  distinct(CovClass, MidpointValue, Range) |>
  arrange(CovClass) 

mydata |> group_by(CovClass) |> summarize(n = n())

ggplot(mydata, aes(x = mydata$CovClass)) + 
  geom_bar()









