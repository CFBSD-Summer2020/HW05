#HW05 Part B
#Author: Hannah Farrell
#Date: 8/3/2020

#load appropriate packages
library(tidyverse)
library(dplyr)
library(ggplot2)
library(stringr)

#load in the data
AUC1 <- read.csv("./CTRP_files/AUC_1.csv", header = TRUE)
AUC2 <- read.csv("./CTRP_files/AUC_2.csv", header = TRUE)
cell_line <- read.csv("./CTRP_files/cancer_cell_line_info.csv", header = TRUE)
compound <- read.csv("./CTRP_files/compound_info.csv", header = TRUE)
experiment <- read.csv("./CTRP_files/Experiment_info.csv", header = TRUE)

#merge the AUC data
merged_AUC <- AUC1 %>%
  full_join(AUC2)
#add in the 3 other csvs based on matching column names
full_data_set <- merged_AUC %>%
  full_join(experiment, by = c("experiment_id" = "expt_id")) %>%
  full_join(cell_line, by = "master_ccl_id") %>%
  full_join(compound, by = "master_cpd_id")

#Which cancer type has the lowest AUC values to the compound "vorinostat"?
lowest_vorinostat <- full_data_set %>%
  filter(cpd_name == "vorinostat") %>%
  arrange(area_under_curve) %>%
  top_n(area_under_curve, n = -20) #pulls out the lowest 20 values for AUC 

ggplot(lowest_vorinostat, aes(x = cancer_type, y = area_under_curve, fill = cancer_type)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, vjust = .65))
#Answer: though not the most elegant/aesthetically pleasing graph, it shows that buy a longshot
#upper aerodigestive tract cancer has the lowest AUC values with this compound at 4.9941

#Which compound is the prostate cancer cell line 22RV1 most sensitive to? 
#(For 22RV1, which compound has the lowest AUC value?)
lowest_22RV1 <- full_data_set %>%
  filter(cancer_type == "prostate", ccl_name == "22RV1") %>%
  arrange(area_under_curve) %>%
  top_n(area_under_curve, n = -10) #pulls out the lowest 10 values for AUC 

ggplot(lowest_22RV1, aes(x = cpd_name, y = area_under_curve, fill = cpd_name)) +
  geom_bar(stat = "identity") +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x = element_blank())
#Answer: based on the results of filtering (and graphing) the lowest 10 AUC values under 
#the desired conditions, leptomycin B produced the lowest AUC for 22RV1 at 2.6367

#For the 10 compounds that target EGFR, which of them has (on average) 
#the lowest AUC values in the breast cancer cell lines?
lowest_breast_EGFR <- full_data_set %>%
  filter(cancer_type == "breast") %>%
  filter(str_detect(gene_symbol_of_protein_target, "EGFR")) %>% 
  #filtering out strings in the specified column containing "EGFR"
  arrange(area_under_curve)

ggplot(lowest_breast_EGFR, aes(x = cpd_name, y = area_under_curve, fill = cpd_name)) +
  geom_boxplot() +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x = element_blank())
#Answer: my data suggests that 11 compounds target EGFR in breast cancer cell lines, but 
#regardless based on the averages indicated by the boxplot, afatinib has on average the 
#lowest AUC values given the specified conditions