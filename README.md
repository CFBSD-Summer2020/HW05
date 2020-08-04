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

## Part 2 Q3: For the 10 compounds that target EGFR, which of them has (on average) the lowest AUC values in the breast cancer cell lines?

``` r
EGFR_lowest <- CTRP_total %>%
  select(area_under_curve, cancer_type, cpd_name, gene_symbol_of_protein_target) %>%
  filter(cancer_type == "breast") %>%
  filter(str_detect(gene_symbol_of_protein_target, "EGFR")) %>%
  arrange(area_under_curve)

print(EGFR_lowest)
```

    ##     area_under_curve cancer_type                         cpd_name
    ## 1             3.3159      breast                        neratinib
    ## 2             3.8874      breast                         afatinib
    ## 3             4.0968      breast                         afatinib
    ## 4             4.0968      breast                         afatinib
    ## 5             4.3140      breast                        neratinib
    ## 6             4.3140      breast                        neratinib
    ## 7             4.8166      breast                         afatinib
    ## 8             4.8590      breast                       canertinib
    ## 9             5.0936      breast                        neratinib
    ## 10            5.3520      breast                        neratinib
    ## 11            5.4521      breast                       canertinib
    ## 12            5.5574      breast                        lapatinib
    ## 13            5.6581      breast                        neratinib
    ## 14            5.6799      breast                        neratinib
    ## 15            5.6799      breast                        neratinib
    ## 16            5.7366      breast                         afatinib
    ## 17            5.7641      breast                        neratinib
    ## 18            6.3996      breast                       canertinib
    ## 19            6.3996      breast                       canertinib
    ## 20            6.4253      breast                         afatinib
    ## 21            6.6520      breast                        lapatinib
    ## 22            6.6520      breast                        lapatinib
    ## 23            6.7777      breast                         afatinib
    ## 24            6.9656      breast                       canertinib
    ## 25            6.9843      breast                         afatinib
    ## 26            7.0116      breast                         afatinib
    ## 27            7.2083      breast                        neratinib
    ## 28            7.2241      breast                           WZ8040
    ## 29            7.2515      breast                       canertinib
    ## 30            7.5253      breast                        neratinib
    ## 31            7.8503      breast                         afatinib
    ## 32            7.8593      breast                         afatinib
    ## 33            7.8596      breast                       canertinib
    ## 34            7.8973      breast                       canertinib
    ## 35            8.1168      breast                           WZ4002
    ## 36            8.1472      breast                       canertinib
    ## 37            8.2948      breast                       canertinib
    ## 38            8.2948      breast                       canertinib
    ## 39            8.3797      breast                         afatinib
    ## 40            8.4572      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 41            8.4572      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 42            8.5194      breast                           WZ8040
    ## 43            8.6690      breast                         afatinib
    ## 44            8.6782      breast                        gefitinib
    ## 45            8.9361      breast                        neratinib
    ## 46            8.9608      breast                        gefitinib
    ## 47            9.0549      breast                        neratinib
    ## 48            9.0639      breast                           WZ8040
    ## 49            9.2188      breast                        neratinib
    ## 50            9.2219      breast                           WZ8040
    ## 51            9.2310      breast                         afatinib
    ## 52            9.2908      breast                           WZ8040
    ## 53            9.2908      breast                           WZ8040
    ## 54            9.3437      breast                       vandetanib
    ## 55            9.4019      breast                           WZ8040
    ## 56            9.4925      breast                       canertinib
    ## 57            9.5949      breast                        gefitinib
    ## 58            9.6344      breast                           WZ4002
    ## 59            9.7847      breast                         afatinib
    ## 60            9.7931      breast                       canertinib
    ## 61            9.8018      breast                        lapatinib
    ## 62            9.8185      breast                           WZ8040
    ## 63            9.8734      breast                       canertinib
    ## 64            9.8972      breast                        gefitinib
    ## 65            9.9212      breast                           WZ8040
    ## 66            9.9212      breast                           WZ8040
    ## 67            9.9758      breast                         afatinib
    ## 68            9.9821      breast                           WZ8040
    ## 69           10.0590      breast                        neratinib
    ## 70           10.1530      breast                         afatinib
    ## 71           10.1610      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 72           10.1740      breast                        gefitinib
    ## 73           10.1850      breast                        lapatinib
    ## 74           10.2220      breast                           WZ4002
    ## 75           10.2840      breast                           WZ8040
    ## 76           10.3510      breast                        lapatinib
    ## 77           10.3600      breast                       canertinib
    ## 78           10.3700      breast                        neratinib
    ## 79           10.4000      breast                         afatinib
    ## 80           10.5320      breast                           WZ4002
    ## 81           10.5450      breast                        lapatinib
    ## 82           10.5630      breast                        gefitinib
    ## 83           10.5900      breast                         afatinib
    ## 84           10.6010      breast                         afatinib
    ## 85           10.7130      breast                           WZ8040
    ## 86           10.7250      breast                         afatinib
    ## 87           10.7820      breast                       canertinib
    ## 88           10.7820      breast                       canertinib
    ## 89           10.7840      breast                       canertinib
    ## 90           10.8060      breast                        neratinib
    ## 91           10.8570      breast                        lapatinib
    ## 92           10.8950      breast                         afatinib
    ## 93           10.9420      breast                         afatinib
    ## 94           10.9440      breast                           WZ8040
    ## 95           10.9470      breast                           WZ8040
    ## 96           10.9640      breast                        lapatinib
    ## 97           10.9640      breast                        lapatinib
    ## 98           10.9850      breast                        neratinib
    ## 99           10.9900      breast                        neratinib
    ## 100          11.0240      breast                           WZ8040
    ## 101          11.0400      breast                           WZ8040
    ## 102          11.0400      breast                           WZ8040
    ## 103          11.0410      breast                        gefitinib
    ## 104          11.0410      breast                        gefitinib
    ## 105          11.0780      breast                       vandetanib
    ## 106          11.0810      breast                           WZ8040
    ## 107          11.0900      breast                           WZ8040
    ## 108          11.0980      breast                       vandetanib
    ## 109          11.1090      breast                        erlotinib
    ## 110          11.1380      breast                        erlotinib
    ## 111          11.1540      breast                           WZ8040
    ## 112          11.1550      breast                        gefitinib
    ## 113          11.1550      breast                           WZ8040
    ## 114          11.2170      breast                         afatinib
    ## 115          11.2170      breast                         afatinib
    ## 116          11.2310      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 117          11.2370      breast                        gefitinib
    ## 118          11.2590      breast                           WZ4002
    ## 119          11.2590      breast                           WZ4002
    ## 120          11.2670      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 121          11.2820      breast                           WZ8040
    ## 122          11.2840      breast                        lapatinib
    ## 123          11.2900      breast                           WZ8040
    ## 124          11.3040      breast                       vandetanib
    ## 125          11.3050      breast                           WZ8040
    ## 126          11.3130      breast                       canertinib
    ## 127          11.3210      breast                        PD 153035
    ## 128          11.3330      breast                         afatinib
    ## 129          11.3340      breast                        neratinib
    ## 130          11.3340      breast                        neratinib
    ## 131          11.3570      breast                           WZ4002
    ## 132          11.3600      breast                           WZ8040
    ## 133          11.3680      breast                        lapatinib
    ## 134          11.3690      breast                         afatinib
    ## 135          11.3720      breast                       canertinib
    ## 136          11.4260      breast                       vandetanib
    ## 137          11.4840      breast                           WZ4002
    ## 138          11.5260      breast                         afatinib
    ## 139          11.5350      breast                           WZ8040
    ## 140          11.5420      breast                         afatinib
    ## 141          11.5690      breast                       vandetanib
    ## 142          11.6070      breast                           WZ4002
    ## 143          11.6300      breast                         afatinib
    ## 144          11.6530      breast                        PD 153035
    ## 145          11.6530      breast                        PD 153035
    ## 146          11.6600      breast                        lapatinib
    ## 147          11.6670      breast                        neratinib
    ## 148          11.6730      breast                        gefitinib
    ## 149          11.6760      breast                       vandetanib
    ## 150          11.6850      breast                       vandetanib
    ## 151          11.7150      breast                        erlotinib
    ## 152          11.7170      breast                        neratinib
    ## 153          11.7310      breast                       canertinib
    ## 154          11.7350      breast                        gefitinib
    ## 155          11.7460      breast                       canertinib
    ## 156          11.7550      breast                       canertinib
    ## 157          11.7910      breast                        lapatinib
    ## 158          11.8190      breast                         afatinib
    ## 159          11.8520      breast                       canertinib
    ## 160          11.8740      breast                       canertinib
    ## 161          11.8740      breast                       canertinib
    ## 162          11.8820      breast                        gefitinib
    ## 163          11.8850      breast                         afatinib
    ## 164          11.8890      breast                        gefitinib
    ## 165          11.9270      breast                        neratinib
    ## 166          11.9320      breast                        neratinib
    ## 167          11.9380      breast                       vandetanib
    ## 168          11.9480      breast                        erlotinib
    ## 169          11.9870      breast                         afatinib
    ## 170          11.9870      breast                         afatinib
    ## 171          11.9900      breast                        gefitinib
    ## 172          12.0070      breast                        gefitinib
    ## 173          12.0070      breast                        gefitinib
    ## 174          12.0150      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 175          12.0310      breast                           WZ4002
    ## 176          12.0360      breast                        erlotinib
    ## 177          12.0500      breast                           WZ4002
    ## 178          12.0570      breast                       canertinib
    ## 179          12.0670      breast                       vandetanib
    ## 180          12.0830      breast                       vandetanib
    ## 181          12.0870      breast                        neratinib
    ## 182          12.0910      breast                       canertinib
    ## 183          12.1320      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 184          12.1370      breast                           WZ8040
    ## 185          12.1600      breast                        lapatinib
    ## 186          12.1620      breast                         afatinib
    ## 187          12.1730      breast                        PD 153035
    ## 188          12.1740      breast                       canertinib
    ## 189          12.1900      breast                           WZ8040
    ## 190          12.2130      breast                           WZ8040
    ## 191          12.2180      breast                        gefitinib
    ## 192          12.2220      breast                       vandetanib
    ## 193          12.2250      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 194          12.2300      breast                        gefitinib
    ## 195          12.2390      breast                       vandetanib
    ## 196          12.2700      breast                       canertinib
    ## 197          12.2720      breast                        erlotinib
    ## 198          12.2720      breast                        erlotinib
    ## 199          12.2730      breast                       vandetanib
    ## 200          12.2780      breast                        erlotinib
    ## 201          12.3030      breast                        gefitinib
    ## 202          12.3250      breast                         afatinib
    ## 203          12.3600      breast                        lapatinib
    ## 204          12.3670      breast                        gefitinib
    ## 205          12.3670      breast                        gefitinib
    ## 206          12.3800      breast                           WZ4002
    ## 207          12.4190      breast                        neratinib
    ## 208          12.4240      breast                           WZ4002
    ## 209          12.4240      breast                           WZ4002
    ## 210          12.4290      breast                         afatinib
    ## 211          12.4540      breast                        neratinib
    ## 212          12.4580      breast                        gefitinib
    ## 213          12.5170      breast                        gefitinib
    ## 214          12.5330      breast                       vandetanib
    ## 215          12.5330      breast                       vandetanib
    ## 216          12.5340      breast                           WZ8040
    ## 217          12.5340      breast                        neratinib
    ## 218          12.5670      breast                        lapatinib
    ## 219          12.5930      breast                        lapatinib
    ## 220          12.5990      breast                        PD 153035
    ## 221          12.6150      breast                       canertinib
    ## 222          12.6410      breast                        erlotinib
    ## 223          12.6550      breast                           WZ4002
    ## 224          12.6630      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 225          12.6630      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 226          12.6820      breast                        neratinib
    ## 227          12.7370      breast                       vandetanib
    ## 228          12.7460      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 229          12.7520      breast                           WZ4002
    ## 230          12.7610      breast                        gefitinib
    ## 231          12.7670      breast                        lapatinib
    ## 232          12.7740      breast                       vandetanib
    ## 233          12.7950      breast                        neratinib
    ## 234          12.8130      breast                        erlotinib
    ## 235          12.8310      breast                           WZ4002
    ## 236          12.8530      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 237          12.8830      breast                        erlotinib
    ## 238          12.9150      breast                        gefitinib
    ## 239          12.9190      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 240          12.9630      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 241          12.9800      breast                        erlotinib
    ## 242          12.9900      breast                        PD 153035
    ## 243          12.9960      breast                        erlotinib
    ## 244          13.0020      breast                           WZ4002
    ## 245          13.0230      breast                        neratinib
    ## 246          13.0520      breast                           WZ4002
    ## 247          13.0580      breast                        lapatinib
    ## 248          13.0620      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 249          13.0650      breast                        neratinib
    ## 250          13.0720      breast                       canertinib
    ## 251          13.0800      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 252          13.0820      breast                        erlotinib
    ## 253          13.1090      breast                        lapatinib
    ## 254          13.1170      breast                       vandetanib
    ## 255          13.1360      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 256          13.1360      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 257          13.1450      breast                       vandetanib
    ## 258          13.1660      breast                       vandetanib
    ## 259          13.1700      breast                        neratinib
    ## 260          13.1760      breast                        neratinib
    ## 261          13.1790      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 262          13.1880      breast                       canertinib
    ## 263          13.2130      breast                        erlotinib
    ## 264          13.2210      breast                       canertinib
    ## 265          13.2260      breast                       vandetanib
    ## 266          13.2350      breast                        erlotinib
    ## 267          13.2440      breast                       canertinib
    ## 268          13.2620      breast                       vandetanib
    ## 269          13.2710      breast                        erlotinib
    ## 270          13.2790      breast                        lapatinib
    ## 271          13.2820      breast                        neratinib
    ## 272          13.2840      breast                       vandetanib
    ## 273          13.3220      breast                           WZ4002
    ## 274          13.3350      breast                           WZ4002
    ## 275          13.3600      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 276          13.3790      breast                        erlotinib
    ## 277          13.3800      breast                        neratinib
    ## 278          13.3810      breast                        neratinib
    ## 279          13.3810      breast                        neratinib
    ## 280          13.3810      breast                        PD 153035
    ## 281          13.3850      breast                        lapatinib
    ## 282          13.3870      breast                       vandetanib
    ## 283          13.3870      breast                       vandetanib
    ## 284          13.4240      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 285          13.4250      breast                        lapatinib
    ## 286          13.4330      breast                        erlotinib
    ## 287          13.4650      breast                       vandetanib
    ## 288          13.4850      breast                        gefitinib
    ## 289          13.4920      breast                       vandetanib
    ## 290          13.5120      breast                       vandetanib
    ## 291          13.5140      breast                         afatinib
    ## 292          13.5380      breast                        erlotinib
    ## 293          13.5380      breast                        erlotinib
    ## 294          13.5440      breast                        PD 153035
    ## 295          13.5470      breast                        PD 153035
    ## 296          13.5550      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 297          13.5550      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 298          13.5700      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 299          13.5710      breast                        erlotinib
    ## 300          13.5710      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 301          13.5850      breast                       vandetanib
    ## 302          13.5870      breast                       vandetanib
    ## 303          13.6010      breast                        erlotinib
    ## 304          13.6070      breast                        gefitinib
    ## 305          13.6130      breast                       canertinib
    ## 306          13.6140      breast                        lapatinib
    ## 307          13.6200      breast                       vandetanib
    ## 308          13.6300      breast                        lapatinib
    ## 309          13.6300      breast                        lapatinib
    ## 310          13.6340      breast                        lapatinib
    ## 311          13.6360      breast                       canertinib
    ## 312          13.6510      breast                       canertinib
    ## 313          13.6770      breast                       canertinib
    ## 314          13.6860      breast                        erlotinib
    ## 315          13.6890      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 316          13.6980      breast                        PD 153035
    ## 317          13.7030      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 318          13.7110      breast                        gefitinib
    ## 319          13.7160      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 320          13.7250      breast                       vandetanib
    ## 321          13.7250      breast                       vandetanib
    ## 322          13.7320      breast                        PD 153035
    ## 323          13.7510      breast                        lapatinib
    ## 324          13.7560      breast                        lapatinib
    ## 325          13.7730      breast                        gefitinib
    ## 326          13.7730      breast                        gefitinib
    ## 327          13.7880      breast                        erlotinib
    ## 328          13.8070      breast                        neratinib
    ## 329          13.8280      breast                        erlotinib
    ## 330          13.8280      breast                        lapatinib
    ## 331          13.8380      breast                        erlotinib
    ## 332          13.8470      breast                        PD 153035
    ## 333          13.8490      breast                        erlotinib
    ## 334          13.8540      breast                           WZ4002
    ## 335          13.8540      breast                           WZ4002
    ## 336          13.8720      breast                        lapatinib
    ## 337          13.8810      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 338          13.9030      breast                        lapatinib
    ## 339          13.9410      breast                           WZ4002
    ## 340          13.9700      breast                        erlotinib
    ## 341          14.0150      breast                        gefitinib
    ## 342          14.0430      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 343          14.0480      breast                        erlotinib
    ## 344          14.0480      breast                        erlotinib
    ## 345          14.0510      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 346          14.0640      breast                        erlotinib
    ## 347          14.1270      breast                        neratinib
    ## 348          14.1740      breast                       canertinib
    ## 349          14.1890      breast                        PD 153035
    ## 350          14.2240      breast                        PD 153035
    ## 351          14.2260      breast                           WZ8040
    ## 352          14.2370      breast                        lapatinib
    ## 353          14.3020      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 354          14.3180      breast                        lapatinib
    ## 355          14.3180      breast                        PD 153035
    ## 356          14.3180      breast                        PD 153035
    ## 357          14.3240      breast                           WZ8040
    ## 358          14.3250      breast                        gefitinib
    ## 359          14.3330      breast                        erlotinib
    ## 360          14.3660      breast                        erlotinib
    ## 361          14.4030      breast                        erlotinib
    ## 362          14.4420      breast                        PD 153035
    ## 363          14.4770      breast                        gefitinib
    ## 364          14.4850      breast                       canertinib
    ## 365          14.4930      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 366          14.5370      breast                        PD 153035
    ## 367          14.5400      breast                        PD 153035
    ## 368          14.6330      breast                       vandetanib
    ## 369          14.6590      breast                           WZ8040
    ## 370          14.6620      breast                        PD 153035
    ## 371          14.6780      breast                           WZ8040
    ## 372          14.7090      breast                        PD 153035
    ## 373          14.7090      breast                        PD 153035
    ## 374          14.7660      breast                       vandetanib
    ## 375          14.8100      breast                        erlotinib
    ## 376          14.8340      breast                        lapatinib
    ## 377          14.8500      breast                       vandetanib
    ## 378          14.8500      breast                       vandetanib
    ## 379          14.8650      breast                        PD 153035
    ## 380          14.8660      breast                        neratinib
    ## 381          14.8690      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 382          14.9330      breast                        gefitinib
    ## 383          14.9880      breast                       canertinib
    ## 384          15.0000      breast                        erlotinib
    ## 385          15.0000      breast                        gefitinib
    ## 386          15.0000      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 387          15.0880      breast                       vandetanib
    ## 388          15.1080      breast                        neratinib
    ## 389          15.3740      breast                        gefitinib
    ## 390          15.9320      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 391          15.9590      breast                        PD 153035
    ## 392          16.5700      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 393          16.9320      breast erlotinib:PLX-4032 (2:1 mol/mol)
    ## 394          17.5850      breast                        lapatinib
    ## 395          17.6030      breast                        erlotinib
    ## 396          17.9110      breast                        gefitinib
    ## 397          18.0620      breast                        erlotinib
    ## 398          18.1230      breast                        gefitinib
    ##     gene_symbol_of_protein_target
    ## 1                      EGFR;ERBB2
    ## 2                      EGFR;ERBB2
    ## 3                      EGFR;ERBB2
    ## 4                      EGFR;ERBB2
    ## 5                      EGFR;ERBB2
    ## 6                      EGFR;ERBB2
    ## 7                      EGFR;ERBB2
    ## 8                      EGFR;ERBB2
    ## 9                      EGFR;ERBB2
    ## 10                     EGFR;ERBB2
    ## 11                     EGFR;ERBB2
    ## 12                     EGFR;ERBB2
    ## 13                     EGFR;ERBB2
    ## 14                     EGFR;ERBB2
    ## 15                     EGFR;ERBB2
    ## 16                     EGFR;ERBB2
    ## 17                     EGFR;ERBB2
    ## 18                     EGFR;ERBB2
    ## 19                     EGFR;ERBB2
    ## 20                     EGFR;ERBB2
    ## 21                     EGFR;ERBB2
    ## 22                     EGFR;ERBB2
    ## 23                     EGFR;ERBB2
    ## 24                     EGFR;ERBB2
    ## 25                     EGFR;ERBB2
    ## 26                     EGFR;ERBB2
    ## 27                     EGFR;ERBB2
    ## 28                           EGFR
    ## 29                     EGFR;ERBB2
    ## 30                     EGFR;ERBB2
    ## 31                     EGFR;ERBB2
    ## 32                     EGFR;ERBB2
    ## 33                     EGFR;ERBB2
    ## 34                     EGFR;ERBB2
    ## 35                           EGFR
    ## 36                     EGFR;ERBB2
    ## 37                     EGFR;ERBB2
    ## 38                     EGFR;ERBB2
    ## 39                     EGFR;ERBB2
    ## 40                EGFR;ERBB2;BRAF
    ## 41                EGFR;ERBB2;BRAF
    ## 42                           EGFR
    ## 43                     EGFR;ERBB2
    ## 44                      AKT1;EGFR
    ## 45                     EGFR;ERBB2
    ## 46                      AKT1;EGFR
    ## 47                     EGFR;ERBB2
    ## 48                           EGFR
    ## 49                     EGFR;ERBB2
    ## 50                           EGFR
    ## 51                     EGFR;ERBB2
    ## 52                           EGFR
    ## 53                           EGFR
    ## 54                       EGFR;KDR
    ## 55                           EGFR
    ## 56                     EGFR;ERBB2
    ## 57                      AKT1;EGFR
    ## 58                           EGFR
    ## 59                     EGFR;ERBB2
    ## 60                     EGFR;ERBB2
    ## 61                     EGFR;ERBB2
    ## 62                           EGFR
    ## 63                     EGFR;ERBB2
    ## 64                      AKT1;EGFR
    ## 65                           EGFR
    ## 66                           EGFR
    ## 67                     EGFR;ERBB2
    ## 68                           EGFR
    ## 69                     EGFR;ERBB2
    ## 70                     EGFR;ERBB2
    ## 71                EGFR;ERBB2;BRAF
    ## 72                      AKT1;EGFR
    ## 73                     EGFR;ERBB2
    ## 74                           EGFR
    ## 75                           EGFR
    ## 76                     EGFR;ERBB2
    ## 77                     EGFR;ERBB2
    ## 78                     EGFR;ERBB2
    ## 79                     EGFR;ERBB2
    ## 80                           EGFR
    ## 81                     EGFR;ERBB2
    ## 82                      AKT1;EGFR
    ## 83                     EGFR;ERBB2
    ## 84                     EGFR;ERBB2
    ## 85                           EGFR
    ## 86                     EGFR;ERBB2
    ## 87                     EGFR;ERBB2
    ## 88                     EGFR;ERBB2
    ## 89                     EGFR;ERBB2
    ## 90                     EGFR;ERBB2
    ## 91                     EGFR;ERBB2
    ## 92                     EGFR;ERBB2
    ## 93                     EGFR;ERBB2
    ## 94                           EGFR
    ## 95                           EGFR
    ## 96                     EGFR;ERBB2
    ## 97                     EGFR;ERBB2
    ## 98                     EGFR;ERBB2
    ## 99                     EGFR;ERBB2
    ## 100                          EGFR
    ## 101                          EGFR
    ## 102                          EGFR
    ## 103                     AKT1;EGFR
    ## 104                     AKT1;EGFR
    ## 105                      EGFR;KDR
    ## 106                          EGFR
    ## 107                          EGFR
    ## 108                      EGFR;KDR
    ## 109                    EGFR;ERBB2
    ## 110                    EGFR;ERBB2
    ## 111                          EGFR
    ## 112                     AKT1;EGFR
    ## 113                          EGFR
    ## 114                    EGFR;ERBB2
    ## 115                    EGFR;ERBB2
    ## 116               EGFR;ERBB2;BRAF
    ## 117                     AKT1;EGFR
    ## 118                          EGFR
    ## 119                          EGFR
    ## 120               EGFR;ERBB2;BRAF
    ## 121                          EGFR
    ## 122                    EGFR;ERBB2
    ## 123                          EGFR
    ## 124                      EGFR;KDR
    ## 125                          EGFR
    ## 126                    EGFR;ERBB2
    ## 127                          EGFR
    ## 128                    EGFR;ERBB2
    ## 129                    EGFR;ERBB2
    ## 130                    EGFR;ERBB2
    ## 131                          EGFR
    ## 132                          EGFR
    ## 133                    EGFR;ERBB2
    ## 134                    EGFR;ERBB2
    ## 135                    EGFR;ERBB2
    ## 136                      EGFR;KDR
    ## 137                          EGFR
    ## 138                    EGFR;ERBB2
    ## 139                          EGFR
    ## 140                    EGFR;ERBB2
    ## 141                      EGFR;KDR
    ## 142                          EGFR
    ## 143                    EGFR;ERBB2
    ## 144                          EGFR
    ## 145                          EGFR
    ## 146                    EGFR;ERBB2
    ## 147                    EGFR;ERBB2
    ## 148                     AKT1;EGFR
    ## 149                      EGFR;KDR
    ## 150                      EGFR;KDR
    ## 151                    EGFR;ERBB2
    ## 152                    EGFR;ERBB2
    ## 153                    EGFR;ERBB2
    ## 154                     AKT1;EGFR
    ## 155                    EGFR;ERBB2
    ## 156                    EGFR;ERBB2
    ## 157                    EGFR;ERBB2
    ## 158                    EGFR;ERBB2
    ## 159                    EGFR;ERBB2
    ## 160                    EGFR;ERBB2
    ## 161                    EGFR;ERBB2
    ## 162                     AKT1;EGFR
    ## 163                    EGFR;ERBB2
    ## 164                     AKT1;EGFR
    ## 165                    EGFR;ERBB2
    ## 166                    EGFR;ERBB2
    ## 167                      EGFR;KDR
    ## 168                    EGFR;ERBB2
    ## 169                    EGFR;ERBB2
    ## 170                    EGFR;ERBB2
    ## 171                     AKT1;EGFR
    ## 172                     AKT1;EGFR
    ## 173                     AKT1;EGFR
    ## 174               EGFR;ERBB2;BRAF
    ## 175                          EGFR
    ## 176                    EGFR;ERBB2
    ## 177                          EGFR
    ## 178                    EGFR;ERBB2
    ## 179                      EGFR;KDR
    ## 180                      EGFR;KDR
    ## 181                    EGFR;ERBB2
    ## 182                    EGFR;ERBB2
    ## 183               EGFR;ERBB2;BRAF
    ## 184                          EGFR
    ## 185                    EGFR;ERBB2
    ## 186                    EGFR;ERBB2
    ## 187                          EGFR
    ## 188                    EGFR;ERBB2
    ## 189                          EGFR
    ## 190                          EGFR
    ## 191                     AKT1;EGFR
    ## 192                      EGFR;KDR
    ## 193               EGFR;ERBB2;BRAF
    ## 194                     AKT1;EGFR
    ## 195                      EGFR;KDR
    ## 196                    EGFR;ERBB2
    ## 197                    EGFR;ERBB2
    ## 198                    EGFR;ERBB2
    ## 199                      EGFR;KDR
    ## 200                    EGFR;ERBB2
    ## 201                     AKT1;EGFR
    ## 202                    EGFR;ERBB2
    ## 203                    EGFR;ERBB2
    ## 204                     AKT1;EGFR
    ## 205                     AKT1;EGFR
    ## 206                          EGFR
    ## 207                    EGFR;ERBB2
    ## 208                          EGFR
    ## 209                          EGFR
    ## 210                    EGFR;ERBB2
    ## 211                    EGFR;ERBB2
    ## 212                     AKT1;EGFR
    ## 213                     AKT1;EGFR
    ## 214                      EGFR;KDR
    ## 215                      EGFR;KDR
    ## 216                          EGFR
    ## 217                    EGFR;ERBB2
    ## 218                    EGFR;ERBB2
    ## 219                    EGFR;ERBB2
    ## 220                          EGFR
    ## 221                    EGFR;ERBB2
    ## 222                    EGFR;ERBB2
    ## 223                          EGFR
    ## 224               EGFR;ERBB2;BRAF
    ## 225               EGFR;ERBB2;BRAF
    ## 226                    EGFR;ERBB2
    ## 227                      EGFR;KDR
    ## 228               EGFR;ERBB2;BRAF
    ## 229                          EGFR
    ## 230                     AKT1;EGFR
    ## 231                    EGFR;ERBB2
    ## 232                      EGFR;KDR
    ## 233                    EGFR;ERBB2
    ## 234                    EGFR;ERBB2
    ## 235                          EGFR
    ## 236               EGFR;ERBB2;BRAF
    ## 237                    EGFR;ERBB2
    ## 238                     AKT1;EGFR
    ## 239               EGFR;ERBB2;BRAF
    ## 240               EGFR;ERBB2;BRAF
    ## 241                    EGFR;ERBB2
    ## 242                          EGFR
    ## 243                    EGFR;ERBB2
    ## 244                          EGFR
    ## 245                    EGFR;ERBB2
    ## 246                          EGFR
    ## 247                    EGFR;ERBB2
    ## 248               EGFR;ERBB2;BRAF
    ## 249                    EGFR;ERBB2
    ## 250                    EGFR;ERBB2
    ## 251               EGFR;ERBB2;BRAF
    ## 252                    EGFR;ERBB2
    ## 253                    EGFR;ERBB2
    ## 254                      EGFR;KDR
    ## 255               EGFR;ERBB2;BRAF
    ## 256               EGFR;ERBB2;BRAF
    ## 257                      EGFR;KDR
    ## 258                      EGFR;KDR
    ## 259                    EGFR;ERBB2
    ## 260                    EGFR;ERBB2
    ## 261               EGFR;ERBB2;BRAF
    ## 262                    EGFR;ERBB2
    ## 263                    EGFR;ERBB2
    ## 264                    EGFR;ERBB2
    ## 265                      EGFR;KDR
    ## 266                    EGFR;ERBB2
    ## 267                    EGFR;ERBB2
    ## 268                      EGFR;KDR
    ## 269                    EGFR;ERBB2
    ## 270                    EGFR;ERBB2
    ## 271                    EGFR;ERBB2
    ## 272                      EGFR;KDR
    ## 273                          EGFR
    ## 274                          EGFR
    ## 275               EGFR;ERBB2;BRAF
    ## 276                    EGFR;ERBB2
    ## 277                    EGFR;ERBB2
    ## 278                    EGFR;ERBB2
    ## 279                    EGFR;ERBB2
    ## 280                          EGFR
    ## 281                    EGFR;ERBB2
    ## 282                      EGFR;KDR
    ## 283                      EGFR;KDR
    ## 284               EGFR;ERBB2;BRAF
    ## 285                    EGFR;ERBB2
    ## 286                    EGFR;ERBB2
    ## 287                      EGFR;KDR
    ## 288                     AKT1;EGFR
    ## 289                      EGFR;KDR
    ## 290                      EGFR;KDR
    ## 291                    EGFR;ERBB2
    ## 292                    EGFR;ERBB2
    ## 293                    EGFR;ERBB2
    ## 294                          EGFR
    ## 295                          EGFR
    ## 296               EGFR;ERBB2;BRAF
    ## 297               EGFR;ERBB2;BRAF
    ## 298               EGFR;ERBB2;BRAF
    ## 299                    EGFR;ERBB2
    ## 300               EGFR;ERBB2;BRAF
    ## 301                      EGFR;KDR
    ## 302                      EGFR;KDR
    ## 303                    EGFR;ERBB2
    ## 304                     AKT1;EGFR
    ## 305                    EGFR;ERBB2
    ## 306                    EGFR;ERBB2
    ## 307                      EGFR;KDR
    ## 308                    EGFR;ERBB2
    ## 309                    EGFR;ERBB2
    ## 310                    EGFR;ERBB2
    ## 311                    EGFR;ERBB2
    ## 312                    EGFR;ERBB2
    ## 313                    EGFR;ERBB2
    ## 314                    EGFR;ERBB2
    ## 315               EGFR;ERBB2;BRAF
    ## 316                          EGFR
    ## 317               EGFR;ERBB2;BRAF
    ## 318                     AKT1;EGFR
    ## 319               EGFR;ERBB2;BRAF
    ## 320                      EGFR;KDR
    ## 321                      EGFR;KDR
    ## 322                          EGFR
    ## 323                    EGFR;ERBB2
    ## 324                    EGFR;ERBB2
    ## 325                     AKT1;EGFR
    ## 326                     AKT1;EGFR
    ## 327                    EGFR;ERBB2
    ## 328                    EGFR;ERBB2
    ## 329                    EGFR;ERBB2
    ## 330                    EGFR;ERBB2
    ## 331                    EGFR;ERBB2
    ## 332                          EGFR
    ## 333                    EGFR;ERBB2
    ## 334                          EGFR
    ## 335                          EGFR
    ## 336                    EGFR;ERBB2
    ## 337               EGFR;ERBB2;BRAF
    ## 338                    EGFR;ERBB2
    ## 339                          EGFR
    ## 340                    EGFR;ERBB2
    ## 341                     AKT1;EGFR
    ## 342               EGFR;ERBB2;BRAF
    ## 343                    EGFR;ERBB2
    ## 344                    EGFR;ERBB2
    ## 345               EGFR;ERBB2;BRAF
    ## 346                    EGFR;ERBB2
    ## 347                    EGFR;ERBB2
    ## 348                    EGFR;ERBB2
    ## 349                          EGFR
    ## 350                          EGFR
    ## 351                          EGFR
    ## 352                    EGFR;ERBB2
    ## 353               EGFR;ERBB2;BRAF
    ## 354                    EGFR;ERBB2
    ## 355                          EGFR
    ## 356                          EGFR
    ## 357                          EGFR
    ## 358                     AKT1;EGFR
    ## 359                    EGFR;ERBB2
    ## 360                    EGFR;ERBB2
    ## 361                    EGFR;ERBB2
    ## 362                          EGFR
    ## 363                     AKT1;EGFR
    ## 364                    EGFR;ERBB2
    ## 365               EGFR;ERBB2;BRAF
    ## 366                          EGFR
    ## 367                          EGFR
    ## 368                      EGFR;KDR
    ## 369                          EGFR
    ## 370                          EGFR
    ## 371                          EGFR
    ## 372                          EGFR
    ## 373                          EGFR
    ## 374                      EGFR;KDR
    ## 375                    EGFR;ERBB2
    ## 376                    EGFR;ERBB2
    ## 377                      EGFR;KDR
    ## 378                      EGFR;KDR
    ## 379                          EGFR
    ## 380                    EGFR;ERBB2
    ## 381               EGFR;ERBB2;BRAF
    ## 382                     AKT1;EGFR
    ## 383                    EGFR;ERBB2
    ## 384                    EGFR;ERBB2
    ## 385                     AKT1;EGFR
    ## 386               EGFR;ERBB2;BRAF
    ## 387                      EGFR;KDR
    ## 388                    EGFR;ERBB2
    ## 389                     AKT1;EGFR
    ## 390               EGFR;ERBB2;BRAF
    ## 391                          EGFR
    ## 392               EGFR;ERBB2;BRAF
    ## 393               EGFR;ERBB2;BRAF
    ## 394                    EGFR;ERBB2
    ## 395                    EGFR;ERBB2
    ## 396                     AKT1;EGFR
    ## 397                    EGFR;ERBB2
    ## 398                     AKT1;EGFR
