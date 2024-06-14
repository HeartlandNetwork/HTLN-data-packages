



################################################################################
#
#  ORAM_calculations.R
#
#  Gareth Rowell, 6/11/2024
#
#  Transforms denormalized ORAM data files from HTLNWetlands Access db
#    into metrics and frequency data suitable for analysis
#
#
################################################################################


library(tidyverse)
library(writexl)

#setwd("./src")

#################---------------------------------------------------------------
#
# Step 1 - load .csv files from HTLNWetlands Access db
#   
#################

# setwd("./wetlands/src")

# commas in input data!!
# true is positive 1??

denorm_p1 <-  read_csv("tbl_ORAMMetrics1Denorm.csv")

glimpse(denorm_p1)

view(denorm_p1)








denorm_p2 <-  read_csv("tbl_ORAMMetrics2Denorm.csv")

glimpse(denorm_p2)

view(denorm_p1)


submetrics <-  read_csv("tbl_ORAMMetrics2Denorm.csv")

glimpse(submetrics)

view(submetrics)










