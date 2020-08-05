dad_mom <- read.delim("~/Desktop/Datacamp course/HW05/dad_mom.txt", row.names=NULL, stringsAsFactors=FALSE)
rownames(dad_mom) <- dad_mom$fam_id
dad_mom$fam_id <- NULL

library(tidyr)

dad <- dad_mom[,1:2]
dad <- cbind(dad, c("dad","dad", "dad"))
colnames(dad) <- c("name","income", "sex")

mom <- dad_mom[,3:4]
mom <- cbind(mom, c("mom","mom", "mom"))
colnames(mom) <- c("name","income", "sex")

dad_mom <- rbind(dad, mom)
