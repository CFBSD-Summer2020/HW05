# HW05
Due August 3rd

## Laura's notes:

I like to keep the HW assignment below for reference purposes when creating the answers. This document contains an R file and an Rmd file, both named HW05. They contain the same material/code; I include both so that whatever you prefer to look at is accessible to you. Enjoy~~~

### HW Assignment

This week the goal is to practice tidying data and joining files together. Similar to last week you can practice these skills with data you already have or you can follow with the two (probably pretty short) HW assignments below.

## 1. Tidying the dad_mom file

In this repo, you'll find a dad_mom.txt file that isn't particularly tidy. Clean this up so there are only 4 columns 
Tidy this data frame so that it adheres to the tidy data principles:

    Each variable must have its own column.
    Each observation must have its own row.
    Each value must have its own cell.

## 2. Joining together CTRP data

CTRP is a dataset I use in my research. CTRP screens cancer cells with various compounds and determines the Area Under the Dose Response Curve (AUC, a metric for how sensitive a cell line is to that compound). However, when you download the data, it comes in parts that requires a lot of id matching to be able to use reasonably easily. For example, the file that contains the AUC data doesn't tell you the cell line name or the type of cancer it is, it just gives an experiment ID number. If you wanted to know which cell line was which, you'd have to reference the experiment_info.csv file which gives you a cell line ID for each experiment, and then reference the the cancer_cell_line_file.csv to figure out what the name of that cell line actually is. 

That is all to say, it would be much easier if those files were all together instead. You're goal is to join together the 5 csv together. 

Then once those files are all together, you should have no problem answering the following questions (with graphs):

* Which cancer type has the lowest AUC values to the compound "vorinostat"?

* Which compound is the prostate cancer cell line 22RV1 most sensitive to? (For 22RV1, which compound has the lowest AUC value?)

* For the 10 compounds that target EGFR, which of them has (on average) the lowest AUC values in the breast cancer cell lines?
