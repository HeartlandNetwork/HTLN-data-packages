

library(tidyverse)


mydata <- read_csv("./src/TreeTally.csv")

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
  arrange(EventDate) |> print(n = 164)

mydata |> distinct(Plot, EventDate) |> 
  group_by(Plot) |> summarize(n = n()) |>
  print(n = 325)

glimpse(mydata)

# Variable: TaxonCode, Family, CommonName, ScientificName -----------------------------------------------------------
# Unique list - PASS
# Plot frequencies - PASS

mydata |> distinct(TaxonCode, Family, CommonName, ScientificName) |>
  arrange(TaxonCode) |>
  print(n = 147)
  

mydata |> 
  group_by(TaxonCode, Family, CommonName, ScientificName) |> 
  summarize(n = n()) |>
  arrange(n) |>
  print(n = 147)


mydata1 <- mydata |> select(ParkUnit, TaxonCode)

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()


glimpse(mydata)


# Variable: DBHClass --------------------------------------------------------------
# Unique list - PASS
# DBHClass frequencies - PASS

mydata |> distinct(DBHClass)

mydata1 <- mydata |> select(ParkUnit, DBHClass)

ggplot(mydata1, aes(x = ParkUnit)) + 
  geom_bar()



?geom_histogram
# Variable: TreeCount --------------------------------------------------------------
# Summarise
# Histogram of all values
# Histograms by park

print(mydata$TreeCount)

summary(mydata$TreeCount)

ggplot(mydata,  aes(TreeCount)) +
  geom_histogram(binwidth = 1)

ggplot(mydata, aes(TreeCount)) +
  geom_histogram(binwidth = 1) + 
  facet_grid(ParkUnit ~ .)


mydata |> filter(TreeCount > 130) |>
  print(n = 1)










