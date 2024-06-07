
library(tidyverse)


mydata <- read_csv("./src/VerticalProfile.csv")

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


# Variable: SubPlot --------------------------------------------------------------
# Unique list - PASS
# SubPlot frequencies - PASS


mydata |> distinct(SubPlot) |>
  print(n = 4)


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
  print(n = 806)


glimpse(mydata)



# Variable: Height --------------------------------------------------------------
# Unique list - PASS
# Height frequencies - PASS

mydata |> distinct(Height)

mydata1 <- mydata |> select(ParkUnit, Height)

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: Vegetation --------------------------------------------------------------
# Unique list - PASS
# Vegetation frequencies - PASS

mydata |> distinct(Vegetation)

mydata1 <- mydata |> select(ParkUnit, Vegetation)

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()



# Variable: Count --------------------------------------------------------------
# Summarize
# Histogram of all values
# Histograms by park

summary(mydata$Count)

ggplot(mydata,  aes(Count)) +
  geom_histogram(binwidth = 1)

ggplot(mydata, aes(Count)) +
  geom_histogram(binwidth = 1) + 
  facet_grid(ParkUnit ~ .)

?geom_histogram













