
library(tidyverse)


mydata <- read_csv("./src/HorizDistanceProfile.csv")

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


# Variable: SubPlot --------------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


mydata |> distinct(SubPlot) |>
  print(n = 5)


mydata |> 
  select(ParkUnit, SubPlot) |> 
  group_by(ParkUnit, SubPlot) |> summarize(n = n()) |>
  print(n = 24)

glimpse(mydata)

# Variable: EventDate --------------------------------------------------------------
# Unique list - PASS
# EventDate frequencies - PASS

mydata |> distinct(EventDate) |>
  arrange(EventDate) |> print(n = 246)

mydata |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 807)

glimpse(mydata)


# Variable: Distance --------------------------------------------------------------
# Unique list - PASS
# Distance frequencies - PASS

mydata |> distinct(Distance)

mydata1 <- mydata |> select(ParkUnit, Distance)

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()

# Variable: Height --------------------------------------------------------------
# Unique list - PASS
# Height frequencies - PASS

mydata |> distinct(Height)

mydata1 <- mydata |> select(ParkUnit, Height)

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()

# Variables: CoverClassCode, CoverClassMidPoint, CoverClassRange ---------
# Unique list - PASS
# Plot frequencies - PASS

mydata |> 
  distinct(CoverClassCode, CoverClassMidPoint, CoverClassRange) |>
  arrange(CoverClassCode) 

mydata |> group_by(CoverClassCode) |> summarize(n = n())

ggplot(mydata, aes(x = mydata$CoverClassCode)) + 
  geom_bar()







