Tidying the dad\_mom file
================

## 1\. Load packages

``` r
library(data.table)
library(readr)
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:data.table':
    ## 
    ##     between, first, last

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(tidyverse)
```

    ## ── Attaching packages ──────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.0 ──

    ## ✓ ggplot2 3.3.2     ✓ purrr   0.3.4
    ## ✓ tibble  3.0.3     ✓ stringr 1.4.0
    ## ✓ tidyr   1.1.0     ✓ forcats 0.5.0

    ## ── Conflicts ─────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::between()   masks data.table::between()
    ## x dplyr::filter()    masks stats::filter()
    ## x dplyr::first()     masks data.table::first()
    ## x dplyr::lag()       masks stats::lag()
    ## x dplyr::last()      masks data.table::last()
    ## x purrr::transpose() masks data.table::transpose()

``` r
library(knitr)
```

## 2\. Load data

``` r
dad_mom <- fread("dad_mom.txt")
```

## 3\. Tidy the file

``` r
dad_mom_rename <- dad_mom %>%
    rename(Dad = income_dad, Mom = income_mom, Family = fam_id)

dad_mom_parent_income <- dad_mom_rename %>%
    gather(key = "Parent", value = "Income", Mom, Dad)

dad_mom_dads <- dad_mom_parent_income %>%
    gather(key = "Mom or dad", value = "Name", name_dad:name_mom) %>%
    select(-"Mom or dad") %>%
    arrange(Family) %>%
    filter(Parent == "Dad" & Name == c("Paul", "Bill", "Art")) 

dad_mom_moms <- dad_mom_parent_income %>%
    gather(key = "Mom or dad", value = "Name", name_dad:name_mom) %>%
    select(-"Mom or dad") %>%
    arrange(Family) %>%
    subset(Parent == "Mom" & Name == c("Amy", "Pat", "Bess"))

dad_mom_tidy <- rbind(dad_mom_dads, dad_mom_moms)

dad_mom_tidy <- select(dad_mom_tidy, "Family", "Name", "Parent", "Income")

row.names(dad_mom_tidy) <- NULL

kable(dad_mom_tidy, col.names = c("Family", "Name", "Parent", "Income"), align = "cllc")
```

| Family | Name | Parent | Income |
| :----: | :--- | :----- | :----: |
|   1    | Bill | Dad    | 30000  |
|   2    | Art  | Dad    | 22000  |
|   3    | Paul | Dad    | 25000  |
|   1    | Bess | Mom    | 15000  |
|   2    | Amy  | Mom    | 22000  |
|   3    | Pat  | Mom    | 50000  |
