
library(tidyverse)



basalarea <- read_csv("./src/BasalArea.csv")

glimpse(basalarea)

# Variable: ParkUnit --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

basalarea |> distinct(ParkUnit)

basalarea |> distinct(ParkUnit) |> 
  group_by(ParkUnit) |> summarize(n = n())


MyData <- basalarea |> select(ParkUnit)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: Plot --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

basalarea |> distinct(Plot) |>
  print(n = 501)

MyData <- basalarea |> select(ParkUnit, Plot)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()

# Variable: SubPlot --------------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


basalarea |> distinct(SubPlot) |>
  print(n = 5)


basalarea |> 
  select(ParkUnit, SubPlot) |> 
  group_by(ParkUnit, SubPlot) |> summarize(n = n()) |>
  print(n = 26)
  

# Variable: EventDate --------------------------------------------------------------
# Unique list - PASS
# EventDate frequencies - PASS

basalarea |> distinct(EventDate) |>
  arrange(EventDate) |> print(n = 168)


basalarea |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 501)

glimpse(basalarea)

# Variable: CanopyType --------------------------------------------------------------
# Unique list - PASS
# CanopyType frequencies - PASS


basalarea |> distinct(CanopyType)


basalarea |> 
  select(Plot, CanopyType) |> 
  group_by(Plot, CanopyType) |> 
  arrange(Plot) |> summarize(n = n()) |>
  print(n = 913)


# Variable: CanopyCount --------------------------------------------------------------
# Histogram of count - PASS
# CanopyCount frequencies - PASS

view(basalarea)

basalarea |> filter(CanopyCount == 0) |>
   print(n = 350)

ggplot(basalarea, aes(x = CanopyCount)) + 
  geom_bar()

basalarea |> count (CanopyCount) |> arrange (CanopyCount, (n))




