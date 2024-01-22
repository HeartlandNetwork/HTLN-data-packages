
library(tidyverse)


foliarcover <- read_csv("./src/FoliarCover.csv")

glimpse(foliarcover)


# Variable: ParkUnit -----------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

foliarcover |> distinct(ParkUnit)

foliarcover |> 
  group_by(ParkUnit) |> summarize(n = n())


# Variable: Plot --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

foliarcover |> distinct(Plot) |>
  print(n = 807)

MyData <- foliarcover |> select(ParkUnit, Plot)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: SubPlot --------------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


foliarcover |> distinct(SubPlot) |>
  print(n = 5)


foliarcover |> 
  select(ParkUnit, SubPlot) |> 
  group_by(ParkUnit, SubPlot) |> summarize(n = n()) |>
  print(n = 24)

# Variable: EventDate --------------------------------------------------------------
# Unique list - PASS
# EventDate frequencies - PASS

foliarcover |> distinct(EventDate) |>
  arrange(EventDate) |> print(n = 246)


foliarcover |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 807)

glimpse(foliarcover)


# Variable: FoliarCover -------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


foliarcover |> distinct(FoliarCover) |>
  print(n = 8)


foliarcover |> 
  select(ParkUnit, FoliarCover) |> 
  group_by(ParkUnit, FoliarCover) |> summarize(n = n()) |>
  print(n = 86)


ggplot(foliarcover, aes(FoliarCover)) + 
  geom_bar()


ggplot(foliarcover, aes(x = foliarcover$ParkUnit, fill = foliarcover$FoliarCover)) +
  geom_bar(aes(fill = foliarcover$FoliarCover), position = "fill") +
  theme(legend.position = "top")

glimpse(foliarcover)



# Variables: CoverClassCode, CoverClassMidPoint, CoverClassRange ---------
# Unique list - PASS
# Plot frequencies - PASS

foliarcover |> 
  distinct(CoverClassCode, CoverClassMidPoint, CoverClassRange) |>
  arrange(CoverClassCode) 

foliarcover |> group_by(CoverClassCode) |> summarize(n = n())

ggplot(foliarcover, aes(x = foliarcover$CoverClassCode)) + 
  geom_bar()



