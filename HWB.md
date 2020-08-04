HW5B\_Angela\_Chun
================
Angela Chun
8/3/2020

# Load the data

``` r
AUC_1 <- read.csv("CTRP_files/AUC_1.csv")
AUC_2 <- read.csv("CTRP_files/AUC_2.csv")
cancer_cell_line_info <- read.csv("CTRP_files/cancer_cell_line_info.csv")
compound_info <- read.csv("CTRP_files/compound_info.csv")
experiment_info <- read.csv("CTRP_files/Experiment_info.csv")
```

# Join the data

``` r
#joining all the data into one data frame
Joined_CTRP_data <- AUC_1 %>%
  bind_rows(AUC_2) %>%
  inner_join(experiment_info, by = c("experiment_id" = "expt_id")) %>%
  inner_join(cancer_cell_line_info, by = "master_ccl_id")%>%
  inner_join(compound_info, by = "master_cpd_id") 
```

# Answering Questions

## Q1) Which cancer type has the lowest AUC values to the compound “vorinostat”?

``` r
#finding the cancer_type with lowest mean AUC
CTRP_VOR <- Joined_CTRP_data %>%
  filter(cpd_name == "vorinostat") %>%
  group_by(cancer_type) %>%
  summarize(AUC = mean(area_under_curve)) %>%
  arrange(AUC)
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

``` r
#visualizing the data 
CTRP_VOR
```

    ## # A tibble: 24 x 2
    ##    cancer_type                          AUC
    ##    <chr>                              <dbl>
    ##  1 haematopoietic_and_lymphoid_tissue  10.7
    ##  2 autonomic_ganglia                   10.7
    ##  3 biliary_tract                       11.3
    ##  4 prostate                            11.5
    ##  5 breast                              11.9
    ##  6 soft_tissue                         12.0
    ##  7 large_intestine                     12.0
    ##  8 lung                                12.1
    ##  9 urinary_tract                       12.1
    ## 10 thyroid                             12.2
    ## # ... with 14 more rows

``` r
#Answer = haematopoietic_and_lymphoid_tissue
```

## Q1) Graph

``` r
# creating a bar graph for the average AUC of each cancer type
ggplot(CTRP_VOR, aes(x = reorder(cancer_type, AUC), y = AUC)) + geom_col(fill = "lightslateblue") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Cancer type") +
  ylab("Average AUC")
```

![](HWB_files/figure-gfm/Q1%20Graph-1.png)<!-- -->

## Q2) Which compound is the prostate cancer cell line 22RV1 most sensitive to? (For 22RV1, which compound has the lowest AUC value?)

``` r
CTRP_prostate <- Joined_CTRP_data %>%
  filter(cancer_type == "prostate") %>%
  group_by(cpd_name) %>%
  summarize(AUC = mean(area_under_curve)) %>%
  arrange(AUC)
```

    ## `summarise()` ungrouping output (override with `.groups` argument)

``` r
#filtering for ccl_name == "22RV1" yielded no results, so instead I just filtered for the prostate cancer type and found the compound with lowest AUC. Note that this isn't really related to a specific cell line, but didn't know what else to do.

#visualizing CTRP_prostate data frame
graph_prostate <- head(CTRP_prostate)


#Answer = *Auobain
```

## Q2) Graph

``` r
#Graph of top 6 rows of CTRP_prostate
ggplot(graph_prostate, aes(x = reorder(cpd_name,AUC), AUC, fill = cpd_name)) + 
  geom_col() +
  xlab("Compound name") +
  ylab("Average AUC") +
  theme(legend.position = "none")
```

![](HWB_files/figure-gfm/Q2%20Graph-1.png)<!-- -->

## Q3) For the 10 compounds that target EGFR, which of them has (on average) the lowest AUC values in the breast cancer cell lines?

``` r
CTRP_EGFR <- Joined_CTRP_data %>%
  select(cancer_type, gene_symbol_of_protein_target, area_under_curve, cpd_name) %>%
  filter(cancer_type == "breast") %>%
  filter(str_detect(gene_symbol_of_protein_target, "EGFR"))%>%
  group_by(cpd_name, gene_symbol_of_protein_target) %>%
  summarize(AUC = mean(area_under_curve)) %>%
  arrange(AUC)
```

    ## `summarise()` regrouping output by 'cpd_name' (override with `.groups` argument)

``` r
CTRP_EGFR
```

    ## # A tibble: 11 x 3
    ## # Groups:   cpd_name [11]
    ##    cpd_name                         gene_symbol_of_protein_target   AUC
    ##    <chr>                            <chr>                         <dbl>
    ##  1 afatinib                         EGFR;ERBB2                     9.04
    ##  2 neratinib                        EGFR;ERBB2                     9.50
    ##  3 canertinib                       EGFR;ERBB2                    10.0 
    ##  4 WZ8040                           EGFR                          10.6 
    ##  5 lapatinib                        EGFR;ERBB2                    11.6 
    ##  6 WZ4002                           EGFR                          11.9 
    ##  7 gefitinib                        AKT1;EGFR                     12.3 
    ##  8 vandetanib                       EGFR;KDR                      12.9 
    ##  9 erlotinib:PLX-4032 (2:1 mol/mol) EGFR;ERBB2;BRAF               12.9 
    ## 10 erlotinib                        EGFR;ERBB2                    13.5 
    ## 11 PD 153035                        EGFR                          13.6

``` r
#Answer = afatinib
```

## Q3) Graph

``` r
ggplot(CTRP_EGFR, aes(x = reorder(cpd_name, AUC), y = AUC, fill = cpd_name)) +
  geom_col() +
  xlab("Compound name")+
  ylab("Average AUC") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")
```

![](HWB_files/figure-gfm/Q3%20Graph-1.png)<!-- -->
