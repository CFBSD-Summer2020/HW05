HW05
================
Ariana F. Tortolani
8/3/2020

## PART A

Tidy the dad\_mom data.

INSTRUCTIONS: Clean this up so there are only 4 columns Tidy this data
frame so that it adheres to the tidy data principles: Each variable must
have its own column. Each observation must have its own row. Each value
must have its own cell.

``` r
#load necessary packages
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.1     ✓ dplyr   1.0.0
    ## ✓ tidyr   1.1.0     ✓ stringr 1.4.0
    ## ✓ readr   1.3.1     ✓ forcats 0.5.0

    ## ── Conflicts ───────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(knitr)
```

Here is an initial look at the data.

``` r
#read in data
dad_mom_initial <- read.delim("dad_mom.txt")

#initial glimpse / visualization of data
glimpse(dad_mom_initial)
```

    ## Rows: 3
    ## Columns: 5
    ## $ fam_id     <int> 1, 2, 3
    ## $ name_dad   <chr> "Bill", "Art", "Paul"
    ## $ income_dad <int> 30000, 22000, 25000
    ## $ name_mom   <chr> "Bess", "Amy", "Pat"
    ## $ income_mom <int> 15000, 22000, 50000

``` r
kable(dad_mom_initial, format = "markdown")
```

| fam\_id | name\_dad | income\_dad | name\_mom | income\_mom |
| ------: | :-------- | ----------: | :-------- | ----------: |
|       1 | Bill      |       30000 | Bess      |       15000 |
|       2 | Art       |       22000 | Amy       |       22000 |
|       3 | Paul      |       25000 | Pat       |       50000 |

Tidy the data.

``` r
#tidy the data
dad_mom_tidy <- dad_mom_initial %>%
  #unite data together for dad and mom
  unite(Dad, name_dad, income_dad, sep = "_") %>% #unite all dad data
  unite(Mom, name_mom, income_mom, sep = "_") %>% #unite all mom data
  
  #gather data
  gather(Dad, Mom, -fam_id, key = "Parent", value = "Name_Income") %>% #creates Parent col 
  
  #separate name_income col
  separate(Name_Income, into = c("Name", "Income"), sep = "_") %>%
  
#make more readable
  #clean col names
  rename(Family = fam_id) %>%
  #sort by family id
  arrange(Family)

#view the tidy data
kable(dad_mom_tidy, format = "markdown")
```

| Family | Parent | Name | Income |
| -----: | :----- | :--- | :----- |
|      1 | Dad    | Bill | 30000  |
|      1 | Mom    | Bess | 15000  |
|      2 | Dad    | Art  | 22000  |
|      2 | Mom    | Amy  | 22000  |
|      3 | Dad    | Paul | 25000  |
|      3 | Mom    | Pat  | 50000  |

## PART B

Join together the CTRP data and then answer the three questions
presented below.

``` r
#read in all the data
AUC_1 <- read.csv("CTRP_files/AUC_1.csv")
AUC_2 <- read.csv("CTRP_files/AUC_2.csv")
cancer_cell_line_info <- read.csv("CTRP_files/cancer_cell_line_info.csv")
compound_info <- read.csv("CTRP_files/compound_info.csv")
experiment_info <- read.csv("CTRP_files/experiment_info.csv")
```

to get an initial look at the data and see what variables each file
contains

``` r
glimpse(AUC_1)
```

    ## Rows: 20,000
    ## Columns: 3
    ## $ experiment_id    <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1…
    ## $ area_under_curve <dbl> 14.782, 13.327, 16.082, 13.743, 13.390, 14.385, 13.0…
    ## $ master_cpd_id    <int> 1788, 3588, 12877, 19153, 23256, 25036, 25334, 25344…

``` r
glimpse(AUC_2)
```

    ## Rows: 195,263
    ## Columns: 3
    ## $ experiment_id    <int> 461, 461, 461, 461, 461, 461, 461, 461, 461, 461, 46…
    ## $ area_under_curve <dbl> 13.4890, 14.7920, 14.7240, 13.8810, 14.7010, 14.6260…
    ## $ master_cpd_id    <int> 606586, 606670, 607696, 608062, 608999, 609058, 6090…

``` r
glimpse(cancer_cell_line_info)
```

    ## Rows: 1,107
    ## Columns: 3
    ## $ master_ccl_id <int> 1, 3, 4, 5, 6, 7, 8, 9, 10, 13, 14, 15, 16, 19, 20, 21,…
    ## $ ccl_name      <chr> "697", "5637", "2313287", "1321N1", "143B", "22RV1", "2…
    ## $ cancer_type   <chr> "haematopoietic_and_lymphoid_tissue", "urinary_tract", …

``` r
glimpse(compound_info)
```

    ## Rows: 545
    ## Columns: 3
    ## $ master_cpd_id                 <int> 1788, 3588, 12877, 17712, 18311, 19153,…
    ## $ cpd_name                      <chr> "CIL55", "BRD4132", "BRD6340", "ML006",…
    ## $ gene_symbol_of_protein_target <chr> NA, NA, NA, "S1PR3", "BAX", NA, "RARA;R…

``` r
glimpse(experiment_info)
```

    ## Rows: 1,061
    ## Columns: 4
    ## $ expt_id         <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16…
    ## $ master_ccl_id   <int> 130, 569, 682, 9, 61, 62, 108, 111, 115, 119, 455, 85…
    ## $ experiment_date <int> 20120501, 20120501, 20120501, 20120504, 20120504, 201…
    ## $ cells_per_well  <int> 500, 500, 500, 500, 500, 500, 500, 500, 500, 500, 500…

join together the separated data frames into one complete data frame
with all the information

``` r
joined_CTRP_data <- AUC_1 %>%
  #combine AUC_1 and AUC_2 (stack on top of each other)
  bind_rows(AUC_2) %>%
  #combine experiment
  inner_join(experiment_info, by = c("experiment_id" = "expt_id")) %>%
  #combine cancer_cell_line)info
  inner_join(cancer_cell_line_info, by = "master_ccl_id") %>%
  #combine compound_info
  inner_join(compound_info, by = "master_cpd_id")

#view combined data frame
glimpse(joined_CTRP_data)
```

    ## Rows: 247,923
    ## Columns: 10
    ## $ experiment_id                 <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, …
    ## $ area_under_curve              <dbl> 14.782, 13.327, 16.082, 13.743, 13.390,…
    ## $ master_cpd_id                 <int> 1788, 3588, 12877, 19153, 23256, 25036,…
    ## $ master_ccl_id                 <int> 130, 130, 130, 130, 130, 130, 130, 130,…
    ## $ experiment_date               <int> 20120501, 20120501, 20120501, 20120501,…
    ## $ cells_per_well                <int> 500, 500, 500, 500, 500, 500, 500, 500,…
    ## $ ccl_name                      <chr> "CAS1", "CAS1", "CAS1", "CAS1", "CAS1",…
    ## $ cancer_type                   <chr> "central_nervous_system", "central_nerv…
    ## $ cpd_name                      <chr> "CIL55", "BRD4132", "BRD6340", "BRD9876…
    ## $ gene_symbol_of_protein_target <chr> NA, NA, NA, NA, NA, "BCL2;BCL2L1;LDHA;L…

# Answering questions using the joined data frame:

1.  Which cancer type has the lowest AUC values to the compound
    “vorinostat”?

ANSWER: From the graph below haematopoietic\_and\_lymphoid\_tissue has
the lowest AUC values to the compound vorinostat.

``` r
#create new data frame to make plot
vorinostat_data <- joined_CTRP_data %>%
  select(area_under_curve, cancer_type, cpd_name) %>%
  filter(cpd_name == "vorinostat") %>%
  filter(cancer_type != "NA") %>%
  group_by(cancer_type)

#create plot
ggplot(vorinostat_data, aes(reorder(cancer_type, area_under_curve), area_under_curve)) +
  #use reorder to organize from lowest to highest value
  geom_boxplot() +
  
  #add labels
  labs(title = "Cancer Type Responsiveness to Vorinostat",
       x     = "Cancer Type",
       y     = "Area Under the Curve") +
  #make easier to read
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```

![](Tortolani_HW05_files/figure-gfm/Question%201-1.png)<!-- -->

2.  Which compound is the prostate cancer cell line 22RV1 most sensitive
    to? (For 22RV1, which compound has the lowest AUC value?)

ANSWER: When trying to answer this question i keep getting an error
message that the ccl\_name “22RV1” is not found so I am not sure if I
created this data frame wrong or it just doesn’t exist?

``` r
#create new data frame to make plot
AUC_22RV1_data <- joined_CTRP_data %>%
  select(area_under_curve, cancer_type, cpd_name) %>%
#  filter(ccl_name == "22RV1") %>% #unexpected error, no data with name "22RV1"
  arrange(desc(area_under_curve))
```

3.  For the 10 compounds that target EGFR, which of them has (on
    average) the lowest AUC values in the breast cancer cell lines?

ANSWER: Based on the graph below the compound afatinib has the lowest
AUC values.

``` r
#create new data frame to make plot
EGFR_data <- joined_CTRP_data %>%
  select(area_under_curve, cancer_type, gene_symbol_of_protein_target, cpd_name) %>%
  filter(cancer_type == "breast") %>%
  filter(str_detect(gene_symbol_of_protein_target, "EGFR")) %>%
  group_by(cpd_name)

#create plot
ggplot(EGFR_data, aes(reorder(cpd_name, area_under_curve), area_under_curve)) +
  #use reorder to organize from lowest to highest value
  geom_boxplot() +

  #add labels
  labs(title = "EGFR targeting compounds AUC values in breast cancer",
       x     = "Compound Name",
       y     = "Area Under the Curve") +
  #make easier to read
  theme(axis.text.x = element_text(angle = 75, hjust = 1))
```

![](Tortolani_HW05_files/figure-gfm/Question%203-1.png)<!-- -->
