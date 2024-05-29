
library(tidyverse)


gc <- read_csv("./src/GroundCover.csv")

glimpse(gc)


# Variable: ParkUnit -----------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

gc |> distinct(ParkUnit)

gc |> 
  group_by(ParkUnit) |> summarize(n = n())


# Variable: Plot --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

gc |> distinct(Plot) |>
  print(n = 807)

MyData <- gc |> select(ParkUnit, Plot)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: SubPlot --------------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


gc |> distinct(SubPlot) |>
  print(n = 5)


gc |> 
  select(ParkUnit, SubPlot) |> 
  group_by(ParkUnit, SubPlot) |> summarize(n = n()) |>
  print(n = 24)

# Variable: EventDate --------------------------------------------------------------
# Unique list - PASS
# EventDate frequencies - PASS

gc |> distinct(EventDate) |>
  arrange(EventDate) |> print(n = 246)

gc |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 807)

glimpse(gc)


# Variable: GroundCover -------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


gc |> distinct(GroundCover) |>
  print(n = 8)


gc |> 
  group_by(gc$ParkUnit, gc$GroundCover) |> summarize(n = n()) |>
  print(n = 86)


ggplot(gc, aes(GroundCover)) + 
  geom_bar()


ggplot(gc, aes(x = gc$ParkUnit, fill = gc$GroundCover)) +
  geom_bar(aes(fill = gc$GroundCover), position = "fill") +
  theme(legend.position = "top")

ggsave("GroundCoverAllParks.png", width = 8, height = 5, units = "in")

glimpse(gc)



# Variables: CoverClassCode, CoverClassMidPoint, CoverClassRange ---------
# Unique list - PASS
# Plot frequencies - PASS

gc |> 
  distinct(CoverClassCode, CoverClassMidPoint, CoverClassRange) |>
  arrange(CoverClassCode) 

gc |> group_by(CoverClassCode) |> summarize(n = n())

ggplot(gc, aes(x = gc$CoverClassCode)) + 
  geom_bar()



