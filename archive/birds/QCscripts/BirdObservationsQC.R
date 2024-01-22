
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

birdobs |> distinct(Plot) |> print(n = 843)

# Variable: EventID ------------------------------------------------------------

# Inspect an unique list - PASS

birdobs |> distinct(ParkUnit, EventID) |> print(n = 7066)

# Get sample Sizes by ParkUnit - PASS

birdobs |> distinct(ParkUnit, EventID) |>  
  group_by(ParkUnit) |> summarize(n = n())

# Variable: EventDateTime ------------------------------------------------------

# Visually inspect unique list - PASS
# can only see last 1000 records

birdobs |> distinct(EventDateTime) |>
  arrange(EventDateTime) |> print(n = 6976)

# Count date-time values by park - these counts should be
# identical to the EvendIDs - PASS

birdobs |> distinct(ParkUnit, EventDateTime) |> 
  group_by(ParkUnit) |> summarize(n = n())




# Variable: Temperature_C ------------------------------------------------------

# test using histogram - PASS
# values between 0 and 10 degrees C
# at AGFO, EFMO and HOCU


typeof(birdobs$Temperature_C)

Temp <- birdobs |> filter(Temperature_C > -9999) |>
          select(Temperature_C)

# shows values less than 10 degrees.
ggplot(Temp, aes(x = Temperature_C)) + 
    geom_bar()

# which parks had lower temps??

low_temp_obs <- birdobs |> filter((Temperature_C > -9999 ) & (Temperature_C < 10))


view(low_temp_obs)

# low temps at AGFO, HOCU, and 

# Variable: WindSpeed and WindDesc ---------------------------------------------
# Run distinct on both variables - PASS

birdobs |> distinct(WindSpeed, WindDesc) 
birdobs |> group_by(WindSpeed) |> summarize(n = n())

# Variable: Rain ---------------------------------------------------------------
# Run distinct on Rain and counts -- PASS

birdobs |> distinct(Rain) 

birdobs |> group_by(Rain) |> summarize(n = n())


# Variable: PercentCloud -------------------------------------------------------
# Plot histogram - PASS

Cloud <- birdobs |> filter(PercentCloud > -9999) |>
  select(PercentCloud)

ggplot(Cloud, aes(x = PercentCloud)) + 
  geom_bar()


# Variables: Noise and Noise Summary --------------------------------------------
# list distinct - PASS
# plot frequencies - PASS

glimpse(birdobs)

birdobs |> distinct(Noise) 

birdobs |> distinct(NoiseSummary)

MyNoise <- birdobs |> select(Noise, NoiseSummary)

ggplot(MyNoise, aes(x = Noise)) + 
  geom_bar()

ggplot(MyNoise, aes(x = NoiseSummary)) + 
  geom_bar()

# Variable: Interval --------------------------------------------
# list distinct - PASS
# plot frequencies - PASS

glimpse(birdobs)

birdobs |> distinct(Interval) 


MyData <- birdobs |> select(Interval)

ggplot(MyData, aes(x = Interval)) + 
  geom_bar()

# Variable: ObservationNumber --------------------------------------------
# list distinct - PASS
# plot frequencies - PASS

birdobs |> distinct(ObservationNumber) |>
  print(n = 38)

MyData <- birdobs |> select(ObservationNumber)

ggplot(MyData, aes(x = ObservationNumber)) + 
  geom_bar()

# Variables: AOUCode, TSN, ScientificName, Family, CommonName  -----------------
# list distinct - PASS
# sort desc - PASS

MyData <- birdobs |> 
  select(AOUCode, TSN, ScientificName, Family, CommonName)

MyData |> distinct(AOUCode, TSN, ScientificName, Family, CommonName) |>
  arrange(AOUCode) |> print(n = 223)

MyData |> group_by(AOUCode) |> summarize(n = n()) |>
  arrange(desc(n)) |> print(n = 223)

glimpse(birdobs)

# Variable: Distance  -----------------
# plot hist with and without -9999 - PASS

MyData <- birdobs |> select(Distance)

MyData2 <- birdobs |> filter(Distance > -9999) |>
  select(Distance)


# Distribution of distance has unusual irregular high frequencies along curve
# These are due to rounding distance to 100, 200, 300 etc.

ggplot(MyData2, aes(x = Distance)) + 
  geom_bar()

birdobs |> count (Distance) |> arrange (Distance, (n)) |> print(n = 491)


# Variable: DetectionType ----------------------------------
# list distinct - PASS
# plot frequencies - PASS

birdobs |> distinct(DetectionType) 

MyData <- birdobs |> select(DetectionType)

ggplot(MyData, aes(x = DetectionType)) + 
  geom_bar()

# Variable: DetectionType ----------------------------------
# list distinct - PASS
# plot frequencies - PASS

birdobs |> distinct(Sex) 

MyData <- birdobs |> select(Sex)

ggplot(MyData, aes(x = Sex)) + 
  geom_bar()

# Variable: Age ----------------------------------
# list distinct - PASS
# plot frequencies - PASS

birdobs |> distinct(Age) 

MyData <- birdobs |> select(Age)

ggplot(MyData, aes(x = Age)) + 
  geom_bar()

# Variable: FlockSize -------------------------------------------------------
# Plot histogram - PASS
# List by n desc - PASS

MyData <- birdobs |> filter(FlockSize > -9999) |>
  select(FlockSize)

ggplot(MyData, aes(x = FlockSize)) + 
  geom_bar()


birdobs |> count (FlockSize) |> arrange (FlockSize, (n)) |>
   print(n = 38)

# Variable: IsPreviousPlot -------------------------------------------------------
# Plot histogram - PASS
# List by n desc - PASS

MyData <- birdobs |> filter(IsPreviousPlot > -9999) |>
  select(IsPreviousPlot)

ggplot(MyData, aes(x = IsPreviousPlot)) + 
  geom_bar()


birdobs |> count (IsPreviousPlot) |> arrange (IsPreviousPlot, (n)) |>
  print(n = 2)

# Variable: IsFlyover -------------------------------------------------------
# Plot histogram - PASS
# List by n desc - PASS

MyData <- birdobs |> filter(IsFlyover > -9999) |>
  select(IsFlyover)

ggplot(MyData, aes(x = IsFlyover)) + 
  geom_bar()


birdobs |> count (IsFlyover) |> arrange (IsFlyover, (n)) |>
  print(n = 2)

# Variable: Comments ----------------------------------
# list distinct - PASS

birdobs |> distinct(Comments) |>
  print(n = 909)

























