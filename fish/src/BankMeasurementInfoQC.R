

setwd("./fish/src")


library(tidyverse)

bankmeasures <- read_csv("./BankMeasurementInfo.csv")

problems(bankmeasures)

view(bankmeasures)

glimpse(bankmeasures)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

bankmeasures |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

bankmeasures |> distinct(ParkCode)



ggplot(bankmeasures, aes(x = ParkCode)) + 
  geom_bar()



# Variables: LocationID, PeriodID and EventID

bankmeasures |> distinct(LocationID) |> 
  print(n = 80)

bankmeasures |> distinct(PeriodID) |> 
  print(n = 72)

bankmeasures |> distinct(EventID) |> 
  print(n = 293)


# Variables: ChannelType and ChannelTypeDescr ----------------------------------
 
 bankmeasures |> distinct(ChannelType, ChannelTypeDescr)
 
 
 # Variables: TransectNumber, SampleLocation, SampleLocationDescr --------------
 
 bankmeasures |> 
   distinct(TransectNumber, SampleLocation, SampleLocationDescr) |>  
   print(n = 22)
 
 # Variables: BankAngle, BankAngleDescr ----------------------------------------
 
 bankmeasures |>
   distinct(BankAngle, BankAngleDescr)
 
 
 # Variables: BankVegCover, BankVegCoverDescr ---------------------------------
 
 bankmeasures |>
   distinct(BankVegCover, BankVegCoverDescr)
 
 
 # Variables: BankHeight, BankHeightDescr -------------------------------------
 
 bankmeasures |>
   distinct(BankHeight, BankHeightDescr)
 
 # Variables: BankSubstrate, BankSubstrateDescr -------------------------------
 
 bankmeasures |>
   distinct(BankSubstrate, BankSubstrateDescr)
 
 
 # Variables: True/False Variables ---------------------------------------------
 
 bankmeasures |>
   distinct(LargeTrees_TR)
 
 bankmeasures |>
   distinct(SmTreesShrubs_SH)
 
 bankmeasures |>
   distinct(GrassForbes_GR)
 
 bankmeasures |>
   distinct(BareRockSediment_BA)
 
 bankmeasures |>
   distinct(Artificial_AR)
 
 # Variable: Comment
 
 bankmeasures |>
   distinct(Comment) |>
   print(n = 737)
 
 
 
 
 
 
 