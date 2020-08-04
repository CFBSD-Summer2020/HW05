#HW05 Part A
#Author: Hannah Farrell
#Date: 8/3/2020

#load appropriate packages
library(tidyverse)

#load in the data
dad_mom <- read.table("dad_mom.txt", header = TRUE)

#tidy the data -> goal is a table with columns Family, Parent, Name, and Income
dad_mom_tidy <- gather(dad_mom, key = "key", value = "value", name_dad:income_mom) %>%
  separate(key, into = c("key", "Parent")) %>%
  spread(key = key, value = value) %>%
  rename("Family" = fam_id, "Income" = income, "Name" = name)

#reordering the columns to make the data easier to comprehend
col_order <- c("Family", "Name", "Parent", "Income")
dad_mom_tidy_ordered <- dad_mom_tidy[, col_order]
#should result in a table with 6 rows and 4 columns order as indicated above 