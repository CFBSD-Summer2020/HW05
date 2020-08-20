library(tidyverse)
library(readr)
dad_mom <- read_table2("dad_mom.txt")
View(dad_mom)

# this didn't work but this is what I tried first
dad_mom_longer <- dad_mom %>% 
  pivot_longer(c(`name_dad`, `income_dad`), names_to = "variable", values_to = "parent_name") %>% 
  pivot_longer(c(`income_dad`, `income_mom`), names_to = NULL, values_to = "income")

dad_mom_longer$parent_type <- substring(dad_mom_longer$parent_type, first = 6)


# this worked better but I suspect there's a more efficient way of doing the same thing
dad <- dad_mom[,1:3]
mom <- dad_mom[,c(1,4,5)]

names(dad)[2] <- "name"
names(mom)[2] <- "name"
names(dad)[3] <- "income"
names(mom)[3] <- "income"
dad$mom_or_dad <- c("dad","dad","dad")
mom$mom_or_dad <- c("mom","mom","mom")
dad_mom_tidy <- rbind(dad, mom)
arrange(dad_mom_tidy, fam_id)

# Part 2
AUC_1 <- read_csv("CTRP_files/AUC_1.csv")
AUC_2 <- read_csv("CTRP_files/AUC_2.csv")
cancer_cell_line_info <- read_csv("CTRP_files/cancer_cell_line_info.csv")
compound_info <- read_csv("CTRP_files/compound_info.csv")
Experiment_info <- read_csv("CTRP_files/Experiment_info.csv")




# combine and merge data frames
AUC_1_2 <- rbind(AUC_1, AUC_2)

AUC_expt_info <- merge(AUC_1_2,Experiment_info, by.x = "experiment_id", by.y = "expt_id")

AUC_expt_info_cpd <- merge(AUC_expt_info,compound_info, by = "master_cpd_id")

AUC_expt_info_cpd_ccl <- merge(AUC_expt_info_cpd,cancer_cell_line_info, by = "master_ccl_id")

# answer questions
vorinostat_AUC_expt_info_cpd_ccl <- AUC_expt_info_cpd_ccl %>%
  subset(cpd_name == "vorinostat") 
plot_vorinostat_AUC_expt_info_cpd_ccl <- vorinostat_AUC_expt_info_cpd_ccl %>%
  ggplot(aes(x = area_under_curve, y = cancer_type)) +
  geom_col()

ccl22RV1_AUC_expt_info_cpd_ccl <- AUC_expt_info_cpd_ccl %>%
  subset(ccl_name == "22RV1") 
ccl22RV1_AUC_expt_info_cpd_ccl %>%
  select(area_under_curve, cpd_name, ccl_name) %>%
  arrange(desc(area_under_curve))
ccl22RV1_AUC_expt_info_cpd_ccl %>%
  select(area_under_curve, cpd_name, ccl_name) %>%
  arrange(area_under_curve)

EGFR_AUC_expt_info_cpd_ccl <- AUC_expt_info_cpd_ccl[grep("EGFR",AUC_expt_info_cpd_ccl$gene_symbol_of_protein_target),]
EGFR_breast_cancer <- EGFR_AUC_expt_info_cpd_ccl %>%
  subset(cancer_type == "breast")
plot_EGFR_breast_cancer <- EGFR_breast_cancer %>%
  ggplot(aes(x = area_under_curve, y = cpd_name)) +
  geom_col()



