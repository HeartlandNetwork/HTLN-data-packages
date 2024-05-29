
# script to inspect EML

library(EML)
library(tidyverse)


setwd("C:/Users/growell/HTLN-BreedingBird-Data-Package/EML")


# Load EML

my_eml <- read_eml("HTLNBreedingBird_metadata.xml")


title <- c(my_eml$dataset$title)
title
firstname <- c(my_eml$dataset$creator$individualName$givenName)
firstname
lastname <- c(my_eml$dataset$creator$individualName$surName)
lastname
#pubdate <- c(my_eml$dataset$pubDate)
#pubDate
abstract <- c(my_eml$dataset$abstract$para)
abstract

# can load and view other components, etc.








