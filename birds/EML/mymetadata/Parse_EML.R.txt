
# Script to load a data package into PowerBI

library(tidyverse)
library(EML)


# Power BI needs to know where the files are...

setwd("C:/Users/growell/HTLN-BreedingBird-Dashboard/src")

# Load csv files

birdplots <- read_csv("PlotCoordinatesDD.csv")
birdobs <- read_csv("BirdObservationsThru2022_3.csv")

glimpse(birdplots)
glimpse(birdobs)

# Load EML

my_eml <- read_eml("HTLNBreedingBird_metadata.xml")


title <- c(my_eml$dataset$title)
title
firstname <- c(my_eml$dataset$creator$individualName$givenName)
firstname
lastname <- c(my_eml$dataset$creator$individualName$surName)
lastname
pubdate <- c(my_eml$dataset$pubDate)
pubDate

abstract <- c(my_eml$dataset$abstract$para)

eml_df <- data.frame(title, firstname, lastname, pubdate, abstract)

glimpse(eml_df)






