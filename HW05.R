#TODO: make colors nice, make labels nice, make Rmd of below (really just formatting)

#QUESTION 1:
#THE GOAL: 4 columns of data that has been tidied in the following ways:
  #Each variable must have its own column.
  #Each observation must have its own row.
  #Each value must have its own cell.

library(tidyverse) #load tidyverse

dad_mom <- read.delim("dad_mom.txt") #load data and assign as dataframe

tidy_dad_mom <- dad_mom %>% #assign to new, tidy dataframe
  unite(mom, name_mom, income_mom) %>% #mom data should be together
  unite(dad, name_dad, income_dad) %>% #dad data should be together
  gather(key = "parent", value = "data", mom, dad) %>% #sort things by parent
  separate(col = "data", into = c("name", "income")) #separate name and income from each other

#This has created a dataframe with four columns:
  #fam_id = family number
  #parent = dad or mom
  #name = name of parent
  #income = income of parent

#QUESTION 2:
#THE GOAL: Join the five csv files together and answer questions about them

AUC_1 <- read.csv("CTRP_files/AUC_1.csv") #assign AUC_1.csv a dataframe
AUC_2 <- read.csv("CTRP_files/AUC_2.csv") #assign AUC_2.csv a dataframe
cancer_cell_line_info <- read.csv("CTRP_files/cancer_cell_line_info.csv") #assign cancer_cell_line_info.csv a dataframe
compound_info <- read.csv("CTRP_files/compound_info.csv") #assign compound_info.csv a dataframe
Experiment_info <- read.csv("CTRP_files/Experiment_info.csv") #assign Experiment_info.csv a dataframe

#Observations about these files:
  #AUC_1 and AUC_2 have all the same variables and could just be stitched together
  #compound_info shares the master_cpd_id variable with AUC_1 and AUC_2
  #Experiment_info shares the experiment_id variable with AUC_1 and AUC_2
  #cancer_cell_line_info shares the master_ccl_id variable with Experiment_info

#Join AUC_1 and AUC_2
AUC <- AUC_1 %>% #assign as own dataframe for posterity/easy-undo
  full_join(AUC_2, by = c("experiment_id", "area_under_curve", "master_cpd_id"))

#Join AUC and compound_info
AUC_compound <- AUC %>% #assign as own dataframe for posterity/easy-undo
  full_join(compound_info, by = "master_cpd_id")

#Join AUC_compound and Experiment_info
AUC_compound_Experiment <- AUC_compound %>% #assign as own dataframe for posterity/easy-undo
  full_join(Experiment_info, by = c("experiment_id" = "expt_id"))  

#final join to put all together
full_combo <- AUC_compound_Experiment %>% #assign as own dataframe for posterity/easy-undo
  full_join(cancer_cell_line_info, by = "master_ccl_id")

#ANSWER THE FOLLOWING QUESTIONS (WITH GRAPHS!)
#Which cancer type has the lowest AUC values to the compound "vorinostat"?
#cpd_name will have to be "vorinostat"
vorinostat_search <- full_combo %>% #assign to dataframe vorinostat_search
  filter(cpd_name == "vorinostat") %>% #only look at vorinostat compound rows
  arrange(area_under_curve) #order so that smallest AUC at top

vorinostat_search %>%
  ggplot() + #plots plots plots plots plots plots EVERYBODY
  aes(area_under_curve, cancer_type) + #look at AUC by cancer_type
  geom_boxplot(color = "dodgerblue1", fill = "dodgerblue3") + #boxplots to demo mean vs outlier distinction
  labs(x = "AUC", #area_under_curve
       y = "Cancer Type", #cancer_type
       title = "Vorinostat AUC by Cancer Type",
       subtitle = "On average, it appears haematopoietic\nand lymphoid tissue have the lowest AUC") +
  theme(plot.title = element_text(hjust = 0.5)) + #center title
  theme(plot.subtitle = element_text(hjust = 0.5)) #center subtitle

#Based on this plot, it seems on average haematopoietic and lymphoid tissue have the lowest AUC
#However, upper aerodigestive tract has that one super low AUC outlier, of note

#Which compound is the prostate cancer cell line 22RV1 most sensitive to?
#(For 22RV1, which compound has the lowest AUC value?)

line22RV1_search <- full_combo %>% #assign to dataframe line22RV1_search
  filter(ccl_name == "22RV1") %>% #only look at ccl_name of 22RV1
  arrange(area_under_curve) #order so that smallest AUC at top

line22RV1_search %>% #use this dataframe to plot
  slice_head(n = 10) %>% #I don't care about the ones with large AUCs. Top 10 smallest pls
  ggplot() + #plots plots plots plots plots plots EVERYBODY
  aes(area_under_curve, cpd_name) + #look at AUC by cpd_name
  geom_point(color = "orange") + #point graph
  labs(x = "AUC", #area_under_curve
     y = "Compound Name", #cpd_name
     title = "Compounds 22RV1 are Sensitive to",
     subtitle = "It appears leptomycin B has the lowest AUC for 22RV1") +
  theme(plot.title = element_text(hjust = 0.5)) + #center title
  theme(plot.subtitle = element_text(hjust = 0.5)) #center subtitle

#For the 10 compounds that target EGFR,
#which of them has (on average) the lowest AUC values in the breast cancer cell lines?
EFGR_search <- full_combo %>% #assign to dataframe EFGR_search
  filter(grepl("EGFR",gene_symbol_of_protein_target)) #only look at lines with EGFR

EFGR_search %>%
  ggplot() + #plots plots plots plots plots plots EVERYBODY
  aes(area_under_curve, cpd_name) + #look at AUC by dpc_name
  geom_boxplot(color = "green4", fill = "green1") + #boxplots to demo mean vs outlier distinction
  labs(x = "AUC", #area_under_curve
       y = "Compound Name", #cpd_name
       title = "AUC of Compounds that Target EFGR",
       subtitle = "On average, it appears afatinib has the lowest AUC") +
  theme(plot.title = element_text(hjust = 0.5)) + #center title
  theme(plot.subtitle = element_text(hjust = 0.5)) #center subtitle
