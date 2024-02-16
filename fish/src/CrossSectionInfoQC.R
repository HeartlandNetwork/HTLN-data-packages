
library(tidyverse)

crosssectioninfo <- read_csv("./CrossSectionInfo.csv")

problems(crosssectioninfo)


view(crosssectioninfo)

glimpse(crosssectioninfo)


# Variable: Parkname -----------------------------------------------------------

# Unique list - PASS?

crosssectioninfo |> distinct(ParkName)


# Variable: ParkCode -----------------------------------------------------------

# Unique list - PASS

crosssectioninfo |> distinct(ParkCode)



ggplot(crosssectioninfo, aes(x = ParkCode)) + 
  geom_bar()



# Variables: LocationID, PeriodID and EventID

crosssectioninfo |> distinct(LocationID) |> 
  print(n = )

crosssectioninfo |> distinct(PeriodID) |> 
  print(n = 111)

crosssectioninfo |> distinct(EventID) |> 
  print(n = 393)


# Variables: ChannelType and ChannelTypeDescr ----------------------------------
 
 crosssectioninfo |> distinct(ChannelType, ChannelTypeDescr)
 
 
 # Variables: SiteNumber, TransectNumber, SampleLocation, SampleLocationDescr --
 
 crosssectioninfo |> 
   distinct(SiteNumber, TransectNumber, SampleLocation, SampleLocationDescr) |>  
   print(n = 45)
 
 
 # Variable: ChannelUnit, ChannelTypeDescr -------------------------------------
 
 crosssectioninfo |>
   distinct(ChannelType, ChannelTypeDescr)
 
 # Variables: PoolForm, Width_m, Depth_m. Velocity_ms --------------------------
 
 # What are PoolForms? Didn't see a lookup for that????
 
 crosssectioninfo |>
   distinct(PoolForm, Width_m, Depth_cm, Velocity_ms)
 
 # Width_m
 
 ggplot(crosssectioninfo, aes(x = Width_m)) +
   geom_histogram(binwidth = 1)
 
 c <- crosssectioninfo |>
   filter(Width_m > 0)
 
 ggplot(c, aes(x = Width_m)) +
   geom_histogram(binwidth = 1)
 
 # Depth_m 
  
 ggplot(crosssectioninfo, aes(x = Depth_cm)) +
   geom_histogram(binwidth = 1)
 
 c <- crosssectioninfo |>
   filter(Depth_cm > 0)
 
 ggplot(c, aes(x = Depth_cm)) +
   geom_histogram(binwidth = 5)
 
 # Velocity_ms
 
 ggplot(crosssectioninfo, aes(x = Velocity_ms)) +
   geom_histogram(binwidth = 1)
 
 
 c <- crosssectioninfo |>
   filter(Velocity_ms > 0 & Velocity_ms < 3)
 
 ggplot(c, aes(x = Velocity_ms)) +
   geom_histogram(binwidth = 0.01)
 
 
 c <- crosssectioninfo |>
   filter(Velocity_ms > 10)
 
 
 ggplot(c, aes(x = Velocity_ms)) +
   geom_histogram(binwidth = 0.1)
 
 
 # Variables: Substrate measures
 
 crosssectioninfo |>
   distinct(DomSubstrate)  |>  
   print(n = 25)
 
 ggplot(crosssectioninfo, aes(x = DomSubstrate)) +
   geom_histogram(binwidth = 1)
 
 c <- crosssectioninfo |>
   filter(DomSubstrate  > 0)
 
 ggplot(c, aes(x = DomSubstrate)) +
          geom_histogram(binwidth = 1) 
 
 
 crosssectioninfo |>
   distinct(WentworthSubstrateDescr)   |>  
   print(n = 25)
 
 crosssectioninfo |>
   distinct(WentworthMidpoint)   |>  
   print(n = 25)
 

 # Variables: Embeddedness, EmbedCanCoverDescrb, ECC_MidPoinValueb
 
 crosssectioninfo |>
   distinct(Embeddedness, EmbedCanCoverDescrb, EmbedCanCoverDescrb)
 
 
 # Variables: CanopyCover, EmbedCanCoverDescr, ECC_MidPointValue
 
 crosssectioninfo |>
   distinct(CanopyCover, EmbedCanCoverDescr, ECC_MidpoinValue)
 
 
 # Variable: Comment
 
 crosssectioninfo |>
   distinct(Comment)
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
