Homework 5
================
Ben Wang
8/3/20

    ## -- Attaching packages ----------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.1     v dplyr   1.0.0
    ## v tidyr   1.1.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts -------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

## Part 1: Tidying up the dad\_mom file

| fam\_id | name\_dad | income\_dad | name\_mom | income\_mom |
| ------: | :-------- | ----------: | :-------- | ----------: |
|       1 | Bill      |       30000 | Bess      |       15000 |
|       2 | Art       |       22000 | Amy       |       22000 |
|       3 | Paul      |       25000 | Pat       |       50000 |

| fam\_id | Parent | Name | Income |
| ------: | :----- | :--- | :----- |
|       1 | mom    | Bess | 15000  |
|       2 | mom    | Amy  | 22000  |
|       3 | mom    | Pat  | 50000  |
|       1 | dad    | Bill | 30000  |
|       2 | dad    | Art  | 22000  |
|       3 | dad    | Paul | 25000  |

## Part 2: Joining together CTRP data

## Part 2 Q1: Which cancer type has the lowest AUC values to the compound “vorinostat”?

``` r
vorinostat_lowest <- CTRP_total %>%
  filter(cpd_name == "vorinostat") %>%
  arrange(area_under_curve)

vorinostat_lowest %>%
  ggplot() +
  aes(area_under_curve, cancer_type) +
  labs(title = "Vorinostat area under curve by cancer type", x = "Area under curve", y = "Cancer type") +
  geom_boxplot()
```

\[\](README\_files/figure-gfm/Q1: Which cancer type has the lowest AUC
values to the compound “vorinostat”?-1.png)<!-- -->

``` r
### print(vorinostat_lowest)
### Seems like I can't get my boxplot to show up, not sure why. I manually printed out the data using print(vorinostat_lowest) and found that the lowest AUC values are predominantly "Haematopoietic and Lymphoid Tissues"
```

## Part 2 Q2: Which compound is the prostate cancer cell line 22RV1 most sensitive to?

``` r
cell_sensitive <- CTRP_total %>%
  filter(ccl_name == "22RV1") %>%
  arrange(area_under_curve)

cell_sensitive %>%
  ggplot() +
  aes(area_under_curve, cpd_name) +
  labs(title = "22Rv1 sensitive compounds", x = "Area under curve", y = "Compound name") +
  geom_boxplot()
```

![](README_files/figure-gfm/Q2:%20Which%20compound%20is%20the%20prostate%20cancer%20cell%20line%2022RV1%20most%20sensitive%20to?-1.png)<!-- -->

``` r
### print(cell_sensitive) 
### Getting an error code I copy/pasted below. In the meantime, continuing my brute-force method, I manually printed out the data and found that the highest sensitivity was to Leptomycin B
#### Error code: File README_files/figure-gfm/Q2: Which compound is the prostate cancer cell line 22RV1 most sensitive to not found in resource path
#### Error: pandoc document conversion failed with error 99
#### Execution halted
#### Not sure how to get past this problem, I'll look at it more when I have more time!
```
