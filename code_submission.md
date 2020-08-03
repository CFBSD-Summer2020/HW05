code\_submission
================
Andrea
8/3/2020

``` r
library("tidyverse")
```

## 1\. Tidying the dad\_mom file

``` r
dad_mom <- read.delim("dad_mom.txt", sep="\t")

head(dad_mom)
```

    ##   fam_id name_dad income_dad name_mom income_mom
    ## 1      1     Bill      30000     Bess      15000
    ## 2      2      Art      22000      Amy      22000
    ## 3      3     Paul      25000      Pat      50000

## 2\. Joining together CTRP data
