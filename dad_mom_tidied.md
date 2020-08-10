dad\_mon\_tidied
================
Yujia Liu
8/10/2020

# Tidying `dad_mom` dataset

The task is straightforward: to make `dad_mom` table tidy. Tidy data
follows certain criteria:

1.  Each variable must have its own column.
2.  Each observation must have its own row.
3.  Each value must have its own cell.

The final dataframe would be in only 4 columns. We are converting it
from wide to long.

``` r
library(tidyverse)    # include dplyr, tidyr & ggplot2
library(magrittr)    # piping
library(knitr)    # pretty tables
```

## Load the data

``` r
dad_mom <- read.csv("dad_mom.txt", sep = "\t")
kable(dad_mom)
```

| fam\_id | name\_dad | income\_dad | name\_mom | income\_mom |
| ------: | :-------- | ----------: | :-------- | ----------: |
|       1 | Bill      |       30000 | Bess      |       15000 |
|       2 | Art       |       22000 | Amy       |       22000 |
|       3 | Paul      |       25000 | Pat       |       50000 |

## Tidy the data

``` r
dad_mom %>%
  unite("dad", c(name_dad, income_dad)) %>%
  unite("mom", c(name_mom, income_mom)) %>%    # First combine "mom data" and "dad data"
  pivot_longer(-fam_id, names_to = "parent", values_to = "name_income") %>%
  #gather("parent", "name_income", -fam_id) %>%    # `gather` equivalent
  separate(name_income, c("name", "income")) %>%
  kable()
```

| fam\_id | parent | name | income |
| ------: | :----- | :--- | :----- |
|       1 | dad    | Bill | 30000  |
|       1 | mom    | Bess | 15000  |
|       2 | dad    | Art  | 22000  |
|       2 | mom    | Amy  | 22000  |
|       3 | dad    | Paul | 25000  |
|       3 | mom    | Pat  | 50000  |
