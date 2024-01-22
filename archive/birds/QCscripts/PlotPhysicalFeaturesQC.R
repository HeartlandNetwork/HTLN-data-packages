
library(tidyverse)


pf <- read_csv("./src/PlotPhysicalFeatures.csv")


glimpse(pf)

# Variable: ParkUnit -----------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

pf |> distinct(ParkUnit)

pf |> 
  group_by(ParkUnit) |> summarize(n = n())

# Variable: Plot --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

pf |> distinct(Plot) |>
  print(n = 843)

MyData <- pf |> select(ParkUnit, Plot)

ggplot(MyData, aes(x = ParkUnit)) + 
  geom_bar()


# Variable: HabitatType --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS
# Note - many values are unknown

pf |> distinct(HabitatType) |>
  print(n = 6)

MyData <- pf |> select(ParkUnit, HabitatType)

ggplot(MyData, aes(x = HabitatType)) + 
  geom_bar() +
  facet_grid(ParkUnit ~ .)


view(pf |> filter(HabitatType == "Unknown"))

glimpse(pf)

# Variable: Slope --------------------------------------------------------------
# Convert to double
# Summarise
# Histogram of all values
# Histograms by park

d_slope <- as.double(pf$Slope)

d_slope

summary(d_slope)

ggplot(pf, aes(d_slope)) +
  geom_histogram()

ggplot(pf, aes(d_slope)) +
  geom_histogram() + 
  facet_grid(ParkUnit ~ .)


# Variable: SlopeVariability --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

pf |> distinct(SlopeVariability) |>
  print(n = 4)

MyData <- pf |> select(ParkUnit, SlopeVariability)

view(MyData)

ggplot(MyData, aes(x = MyData$SlopeVariability)) + 
  geom_bar() 

ggplot(MyData, aes(x = SlopeVariability)) + 
  geom_bar() +
  facet_grid(ParkUnit ~ .)

glimpse(pf)


# Variable: Aspect --------------------------------------------------------------
# Convert to double
# Summarise
# Histogram of all values
# Histograms by park

d_aspect <- as.double(pf$Aspect)

d_aspect

summary(d_aspect)

ggplot(pf, aes(d_aspect)) +
  geom_histogram()

ggplot(pf, aes(d_aspect)) +
  geom_histogram() + 
  facet_grid(ParkUnit ~ .)


# Variable: AspectVariability --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

pf |> distinct(AspectVariability) |>
  print(n = 4)

MyData <- pf |> select(ParkUnit, AspectVariability)

view(MyData)

ggplot(MyData, aes(x = MyData$AspectVariability)) + 
  geom_bar() 

ggplot(MyData, aes(x = AspectVariability)) + 
  geom_bar() +
  facet_grid(ParkUnit ~ .)

glimpse(pf)

# Variable: InRiparianCorridor --------------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

pf |> distinct(InRiparianCorridor)

MyData <- pf |> select(ParkUnit, InRiparianCorridor)

view(MyData)

ggplot(MyData, aes(x = MyData$InRiparianCorridor)) + 
  geom_bar() 

ggplot(MyData, aes(x = InRiparianCorridor)) + 
  geom_bar() +
  facet_grid(ParkUnit ~ .)



