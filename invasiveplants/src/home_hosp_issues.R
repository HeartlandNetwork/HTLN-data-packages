



################################################################################
#
#  home_hosp_issues.R
#
#  Gareth Rowell, 6/14/2024
#
#  Resolving issues between home and hosp data
#    problem - hosp locations showing up among home data
#
#
################################################################################


library(tidyverse)
library(writexl)

#setwd("./invasiveplants/src")

#################---------------------------------------------------------------
#
# Step 1 - load .csv files originally from 
# .\DataStrikeTeam\Monitoring_from_shared_folder\invasive_plants\03_final_data
#   
#################

# setwd("./invasiveplants/src")

inv_plants <-  read_csv("HTLN_InvasivePlants_Monitoring.csv")

problems()

glimpse(inv_plants)

#view(inv_plants)

home_plants <- inv_plants |>
  filter(
    ParkCode == "HOME"
  )

glimpse(home_plants)

ggplot(home_plants, aes(x = LatitudeInDecimalDegrees)) +
  geom_histogram(binwidth = 0.5)

error_recs <- home_plants |>
  filter(
    LatitudeInDecimalDegrees < 36
  )

glimpse(error_recs)

view(error_recs)

writexl::write_xlsx(error_recs, "Invasive_plants_errors.xlsx")








