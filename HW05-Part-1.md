HW05 Part 1
================
Olivia Pura
8/3/2020

## HW05 Part 1

In Part 1 of HW05, we’re tidying up the dad\_mom.txt dataset. To do
this, we have to load the tidyverse package. I’m also loading in the
knitr package to utilize the kable() function.

``` r
library(tidyverse)
```

    ## Warning: package 'purrr' was built under R version 3.6.2

``` r
library(knitr)
```

Now, we’re reading in the dad\_mom.txt dataset and printing it using
kable().

| fam\_id | name\_dad | income\_dad | name\_mom | income\_mom |
| :------ | :-------- | :---------- | :-------- | :---------- |
| 1       | Bill      | 30000       | Bess      | 15000       |
| 2       | Art       | 22000       | Amy       | 22000       |
| 3       | Paul      | 25000       | Pat       | 50000       |

In order for this data to be tidy, our columns must represent the four
variables - family, parent, name, and income.

Now that the data is tidy, we can view it as a table using kable()

| Family | Parent | Name | Income |
| :----- | :----- | :--- | :----- |
| 1      | Dad    | Bill | 30000  |
| 2      | Dad    | Art  | 22000  |
| 3      | Dad    | Paul | 25000  |
| 1      | Mom    | Bess | 15000  |
| 2      | Mom    | Amy  | 22000  |
| 3      | Mom    | Pat  | 50000  |
