HWA
================
Angela Chun
8/4/2020

In this repo, you’ll find a dad\_mom.txt file that isn’t particularly
tidy. Clean this up so there are only 4 columns Tidy this data frame so
that it adheres to the tidy data principles:

    Each variable must have its own column.
    Each observation must have its own row.
    Each value must have its own cell.

Family\_id, name, parent, income

## Load & Tidy dad\_mom.txt

``` r
dad_mom <- read.delim("dad_mom.txt", header = TRUE)

dad_mom_tidy <- dad_mom %>%
  #unite the parents separately
  unite(dad, name_dad, income_dad) %>%
  unite(mom, name_mom, income_mom) %>%
  #gather mom and dad into a single column
  gather(key = Parent, value = name_income, -fam_id) %>%
  #seperate the column into "name" and "income"
  separate(name_income, into = c("Name", "Income")) %>%
  #setting income to number instead of character
  mutate(Income = parse_number(Income))  %>%
  #arranging by family id
  arrange(fam_id) %>%
  #renaming fam_id to Family_ID
  rename(Family_ID = fam_id)


knitr::kable(dad_mom_tidy, format = "markdown", align = "c")
```

| Family\_ID | Parent | Name | Income |
| :--------: | :----: | :--: | :----: |
|     1      |  dad   | Bill | 30000  |
|     1      |  mom   | Bess | 15000  |
|     2      |  dad   | Art  | 22000  |
|     2      |  mom   | Amy  | 22000  |
|     3      |  dad   | Paul | 25000  |
|     3      |  mom   | Pat  | 50000  |
