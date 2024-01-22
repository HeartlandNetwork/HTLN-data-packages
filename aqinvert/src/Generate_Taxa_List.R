

library(tidyverse)

##########
#
# Generate_Taxa_List.R - The purpose of this script is to generate
#   list of unique TaxonCode - TaxonName pairs using the lowest possible 
#   category of taxon name for each pair. The main process for accomplishing
#   this is through left outer joins where the left table is the taxon
#   name. This is repeated for each category of taxa starting at the 
#   lowest level, which is Genus.
#
##########


##########
#
# Step 1 - Load the tlu_Taxa table
#
##########

aqinvert_taxa <- read_csv("./aqinvert/src/AqInvert_Taxa_Info.csv")

glimpse(aqinvert_taxa)

##########
#
# Step 2 - Create a taxon Code list. Initially this just has only 
#   one column - TaxonCode but we will add TaxonNames as soon as
#   we run outer joins.
#
##########

taxa_list <- aqinvert_taxa$TaxonCode

glimpse(taxa_list)

##########
#
# Step 3 - Use a left outer join for each taxon starting at
#   the lowest category which is Genus. Once we have assigned
#   a taxon to a taxon code, we will pull that taxon code - taxon
#   pair out of the list. We will left outer join each next
#   higher category using the remaining taxon codes.
#   As a preliminary test, there should be no remaining taxon codes
#   after we join the last category which is Phylum.
#
##########



