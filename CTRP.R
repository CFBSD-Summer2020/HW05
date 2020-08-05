library(dplyr)

AUC_1 <- read.csv("AUC_1.csv", header = TRUE, stringsAsFactors = FALSE)
AUC_2 <- read.csv("AUC_2.csv", header = TRUE, stringsAsFactors = FALSE)
cancercellline <- read.csv("cancer_cell_line_info.csv", header = TRUE, stringsAsFactors = FALSE)
compound <- read.csv("compound_info.csv", header = TRUE, stringsAsFactors = FALSE)
experiment <- read.csv("Experiment_info.csv", header = TRUE, stringsAsFactors = FALSE)

colnames(experiment)[colnames(experiment) == "expt_id"] <- c("experiment_id")

AUC <- rbind(AUC_1, AUC_2)

#first, let's join AUC and experiment, by "expriment_id"

AUC_experiment <- inner_join(AUC, experiment, by = "experiment_id")

#then, let's join AUC_experiment to cancercellline, by "master_ccl_id"

AUC_experiment_ccl <- inner_join(AUC_experiment, cancercellline, by = "master_ccl_id")

#finally, join the rest everything by "master_cpd_id"

fulllist <- inner_join(AUC_experiment_ccl, compound, by = "master_cpd_id")


#test this dataset: Which cancer type has the lowest AUC values to the compound "vorinostat"?

vorinostat <- subset(fulllist, fulllist$cpd_name == "vorinostat")
minimum <- min(vorinostat$area_under_curve)
lowest_AUC <- vorinostat[vorinostat$area_under_curve == minimum,]
print(lowest_AUC$cancer_type)
#"upper_aerodigestive_tract"


#For 22RV1, which compound has the lowest AUC value?

RV1 <- subset(fulllist, fulllist$ccl_name == "22RV1")
min(RV1$area_under_curve)
lowest_AUC_RV1 <- RV1[RV1$area_under_curve == min(RV1$area_under_curve),]
print(lowest_AUC_RV1$cpd_name)
#"leptomycin B"


#For the 10 compounds that target EGFR, 
#which of them has (on average) the lowest AUC values in the breast cancer cell lines?
  
EGFR <- subset(fulllist, grepl( "EGFR", fulllist$gene_symbol_of_protein_target, ignore.case = TRUE))
EGFR <- subset(EGFR, EGFR$cancer_type == "breast")
compound_list_EGFR <- as.data.frame(table(EGFR$cpd_name))
#I found 11 not 10 compounds targeting EGFR??

EGFR_AUC_cp <- EGFR[,c("area_under_curve", "cpd_name")]
EGFR_AUC_cp <- aggregate(EGFR_AUC_cp$area_under_curve ~ EGFR_AUC_cp$cpd_name, EGFR_AUC_cp, mean)
colnames(EGFR_AUC_cp) <- c("compound", "AUC")

min <- EGFR_AUC_cp[EGFR_AUC_cp$AUC == min(EGFR_AUC_cp$AUC),]
print(min$compound)
#"afatinib"


