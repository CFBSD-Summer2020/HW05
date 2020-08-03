dad_mom <- read.delim("~/Desktop/Datacamp course/HW05/dad_mom.txt", row.names=NULL, stringsAsFactors=FALSE)
rownames(dad_mom) <- dad_mom$fam_id
dad_mom$fam_id <- NULL