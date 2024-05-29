
library(tidyverse)

# setwd("./fish/src")

fishcounts <- read_csv("./FishCountsThru_2023.csv")

problems(fishcounts)

glimpse(fishcounts)

# view(fishcounts)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

fishcounts |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

fishcounts |> distinct(ParkCode) |>
  arrange(ParkCode)


ggplot(fishcounts, aes(x = ParkCode)) + 
  geom_bar()



# Variable: LocationID --------------------------------------------------------

fishcounts |> distinct(LocationID) |> 
  print(n = 109)

# Variables PeriodID and EventID  ---------------------------

fishcounts |> distinct(PeriodID) |> 
  print(n = 120)

fishcounts |> distinct(EventID) |> 
  arrange(EventID) |>
  print(n = 399)

# Sampling variables -----------------------------------------------------------

s <- fishcounts |>
  distinct(SamplingGear, ChannelType, ChannelTypeDescr, SiteNumber)

view(s)


# Variable: TaxaFishNumber ----------------------------------------------------


ggplot(fishcounts, aes(x = TaxaFishNumber)) + 
  geom_bar()

# This histogram suggests something changed for fishcounts over 31... Did they
# stop counting over 30 at somepoint??

# Variable: TotalLength_mm ----------------------------------------------------

f <- fishcounts |>
  distinct(TotalLength_mm)

view(f)

ggplot(fishcounts, aes(x = TotalLength_mm)) + 
  geom_bar()

f <- fishcounts |>
  filter(TotalLength_mm > 900)

ggplot(f, aes(x = TotalLength_mm)) + 
  geom_bar()

view(f)

# Variables: AnomalyID, FishAnomalyDescr ---------------------------------------
# Delete these variables, they are cleaned up below

fishcounts |>
  distinct(AnomalyID, FishAnomalyDescr)

# Variable: Vouchered ----------------------------------------------------------

fishcounts |>
  distinct(Vouchered) 

ggplot(fishcounts, aes(x = Vouchered)) + 
  geom_bar()

# Variable: NumObs -------------------------------------------------------------

fishcounts |>
  count(NumObs, sort = TRUE) |>
  print(n = 204)

f <- fishcounts |>
  filter(NumObs > 1)

ggplot(f, aes(x = NumObs)) +  
  geom_bar()


# Variables: BatchID and BatchWT_g ---------------------------------------------

fishcounts |>
  distinct(BatchID) 

fishcounts |> distinct(BatchWT_g) |>
  print(n = 410)


f <- fishcounts |>
  filter(BatchWT_g > 1)

ggplot(f, aes(x = BatchWT_g)) +  
  geom_histogram(binwidth = 10)

f <- fishcounts |>
  filter(BatchWT_g > 150)

ggplot(f, aes(x = BatchWT_g)) +  
  geom_histogram(binwidth = 10)

# view(f)

# Variable:tbl_FishCommSppIndiv_Comments ---------------------------------------

fishcounts |>
  filter(!is.na(tbl_FishCommSppIndiv_Comments)) |>
  distinct(tbl_FishCommSppIndiv_Comments)  |>
  print(n = 304)

# Taxonomic variables ----------------------------------------------------------

f <- fishcounts |>
  distinct(TaxonCode, TSN, CommonName, FamilyName, ScientificName, Comments)  |>
  arrange(CommonName) |>
  print(n = 137)

view(f) 


f <- fishcounts |>
  distinct(CommonName, ScientificName)  |>
  arrange(CommonName) |>
  print(n = 137)

view(f)


# Variables: Tolerance code, ToleranceDescription ------------------------------

fishcounts |>
  distinct(ToleranceCode, ToleranceDescription)

# Variables: ReproductiveClassification and Reproductive Description

fishcounts |>
  distinct(ReproductiveClassification, ReproductiveDescription)

# Variables: ClassNumber, TrophicClassification, TrophicDescription -------------------------

fishcounts |>
  distinct(ClassNumber, TrophicClassification, TrophicDescription)

# Variables: FishAnomalyCode, FishDescrp ---------------------------------------

fishcounts |>
  distinct(FishAnomalyCode, FishAnomalyDescrp)

# Variables: ParkSpecificCode, ParkSpecificDescription -------------------------

fishcounts |>
  distinct(ParkSpecificCode, ParkSpecificDescription)








