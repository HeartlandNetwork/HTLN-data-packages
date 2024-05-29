
library(tidyverse)
library(writexl)
library(readxl)



canopyheight <- read_csv("./src/CanopyHeight.csv")

glimpse(canopyheight)

# Variable: ParkUnit --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

canopyheight |> distinct(ParkUnit)

canopyheight |> 
  group_by(ParkUnit) |> summarize(n = n())


# Variable: Plot --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

canopyheight |> distinct(Plot) |>
  print(n = 503)

MyData <- canopyheight |> select(ParkUnit, Plot)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: SubPlot --------------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


canopyheight |> distinct(SubPlot) |>
  print(n = 5)


canopyheight |> 
  select(ParkUnit, SubPlot) |> 
  group_by(ParkUnit, SubPlot) |> summarize(n = n()) |>
  print(n = 19)

# Variable: EventDate --------------------------------------------------------------
# Unique list - PASS
# EventDate frequencies - PASS

canopyheight |> distinct(EventDate) |>
  arrange(EventDate) |> print(n = 161)


canopyheight |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 503)

glimpse(canopyheight)

# Variable: CanopyType --------------------------------------------------------------
# Unique list - PASS
# CanopyType frequencies - PASS


canopyheight |> distinct(CanopyType)


canopyheight |> 
  select(Plot, CanopyType) |> 
  group_by(Plot, CanopyType) |> 
  arrange(Plot) |> summarize(n = n()) |>
  print(n = 936)


# Variable: CanopyHeight --------------------------------------------------------------
# Unique list - PASS
# CanopyHeight frequency histogram - question about 0's
# in CanopyHeight variable


canopyheight|> distinct(CanopyHeight) |>
  print(n = 342) 
  
MyData <- canopyheight |> select(CanopyHeight) |>
  filter(CanopyHeight > 0)


ggplot(MyData, aes(x = CanopyHeight)) + 
  geom_bar() 

ggplot(MyData, aes(x = CanopyHeight)) + 
  geom_density() 


canopyheight0s <- canopyheight |>
  filter(CanopyHeight == 0) |>
  print(n = 348) 

glimpse(canopyheight0s)

write_xlsx(canopyheight0s, "canopyheight0s.xlsx")




