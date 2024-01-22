
library(tidyverse)

canopycover <- read_csv("./src/CanopyCover.csv")

glimpse(canopycover)

# Variable: ParkUnit --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

canopycover |> distinct(ParkUnit)

canopycover |> distinct(ParkUnit) |> 
  group_by(ParkUnit) |> summarize(n = n())


# Variable: Plot --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

canopycover |> distinct(Plot) |>
  print(n = 504)

MyData <- canopycover |> select(ParkUnit, Plot)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: SubPlot --------------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


canopycover |> distinct(SubPlot) |>
  print(n = 5)


canopycover |> 
  select(ParkUnit, SubPlot) |> 
  group_by(ParkUnit, SubPlot) |> summarize(n = n()) |>
  print(n = 19)

# Variable: EventDate --------------------------------------------------------------
# Unique list - PASS
# EventDate frequencies - PASS

canopycover |> distinct(EventDate) |>
  arrange(EventDate) |> print(n = 162)


canopycover |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 504)


# Variable: CanopyType --------------------------------------------------------------
# Unique list - PASS
# CanopyType frequencies - PASS


canopycover |> distinct(CanopyType)


canopycover |> 
  select(Plot, CanopyType) |> 
  group_by(Plot, CanopyType) |> 
  arrange(Plot) |> summarize(n = n()) |>
  print(n = 1040)


# Variable: ReadingNumber --------------------------------------------------------------
# Unique list - PASS
# ReadingNumber frequencies - PASS


canopycover|> distinct(ReadingNumber) |>
  print(n = 5)


MyData <- canopycover |> select(ParkUnit, ReadingNumber)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: DotScore --------------------------------------------------------------
# Unique list - PASS
# DotScore frequency histogram - PASS


canopycover|> distinct(DotScore) |>
  print(n = 98)


MyData <- canopycover |> select(DotScore)

ggplot(MyData, aes(x = DotScore)) + 
  geom_bar()



glimpse(canopycover)



