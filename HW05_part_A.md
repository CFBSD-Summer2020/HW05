HW05 Part A
================
Patrick Haller
7/31/2020

## HW05 Part A

**For this part of HW05, my goal is to tidy the dad\_mom.txt file.
First, I want to load the tidyverse package and read in the data from
the dad\_mom.txt
    file:**

``` r
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.1     ✓ dplyr   1.0.0
    ## ✓ tidyr   1.1.0     ✓ stringr 1.4.0
    ## ✓ readr   1.3.1     ✓ forcats 0.5.0

    ## ── Conflicts ───────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
# read in data using read.table() function
dad_mom <- read.table("dad_mom.txt", header = TRUE)
```

**Here, you can see the initial format of the data:**

``` r
# use the kable() function to show the data in a nice table format
knitr::kable(dad_mom, format = "markdown", align = 'c')
```

| fam\_id | name\_dad | income\_dad | name\_mom | income\_mom |
| :-----: | :-------: | :---------: | :-------: | :---------: |
|    1    |   Bill    |    30000    |   Bess    |    15000    |
|    2    |    Art    |    22000    |    Amy    |    22000    |
|    3    |   Paul    |    25000    |    Pat    |    50000    |

**My goal is to make a tidy dataframe with 4 columns that are named
“Family”, “Parent”, “Name”, “Income”.**

``` r
# create new data frame
dad_mom_tidy <- dad_mom %>% 
  # unite name and income columns for dad and mom
  unite(Dad, name_dad, income_dad) %>%   
  unite(Mom, name_mom, income_mom) %>%
  # gather the united columns
  pivot_longer(c('Dad', 'Mom'), names_to = "Parent", values_to = "Income") %>%
  # separate the previously united columns
  separate(col = "Income", into = c('Name', 'Income')) 

# adjust column name for family ID
colnames(dad_mom_tidy)[1] <- "Family"
# set the income as integers
dad_mom_tidy$Income <- as.integer(dad_mom_tidy$Income)
```

**Here, you can see what my tidy version of the data frame looks like:**

``` r
knitr::kable(dad_mom_tidy, format = "markdown", align = 'c')
```

| Family | Parent | Name | Income |
| :----: | :----: | :--: | :----: |
|   1    |  Dad   | Bill | 30000  |
|   1    |  Mom   | Bess | 15000  |
|   2    |  Dad   | Art  | 22000  |
|   2    |  Mom   | Amy  | 22000  |
|   3    |  Dad   | Paul | 25000  |
|   3    |  Mom   | Pat  | 50000  |
