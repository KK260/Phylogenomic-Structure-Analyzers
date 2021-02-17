#### min30 ####

#change file ending *.ustr to *.txt

dat_min30<-read.table("all_97_new_class_without_outgroup_min30.txt", header=FALSE)

dat_min30 <- apply(dat_min30, 2, function(x)gsub('\\s+', '', x))

# add "pseudo-phases" after country labels

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_AD', '_AD.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_AT', '_AT.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_CH', '_CH.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_CZ', '_CZ.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_DE', '_DE.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_ES', '_ES.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_FI', '_FI.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_FR', '_FR.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_HR', '_HR.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_HU', '_HU.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_IT', '_IT.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_PL', '_PL.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_RO', '_RO.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_SE', '_SE.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_SI', '_SI.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_SK', '_SK.A ', x))

dat_min30 <- apply(dat_min30, 2, function(x)gsub('_UA', '_UA.A ', x))


#### add .B to every second taxon name (every second row)

dat_min_subset1 <- dat_min30[seq(0, nrow(dat_min30), 2), ]

dat_min_subset1 <- as.data.frame(dat_min_subset1)


dat_min_subset2 <- dat_min30[seq(1, nrow(dat_min30), 2), ]

dat_min_subset2 <- gsub("_AD.A", "_AD.B", dat_min_subset2)
dat_min_subset2 <- gsub("_AT.A", "_AT.B", dat_min_subset2)
dat_min_subset2 <- gsub("_CH.A", "_CH.B", dat_min_subset2)
dat_min_subset2 <- gsub("_CZ.A", "_CZ.B", dat_min_subset2)
dat_min_subset2 <- gsub("_DE.A", "_DE.B", dat_min_subset2)
dat_min_subset2 <- gsub("_ES.A", "_ES.B", dat_min_subset2)
dat_min_subset2 <- gsub("_FI.A", "_FI.B", dat_min_subset2)
dat_min_subset2 <- gsub("_FR.A", "_FR.B", dat_min_subset2)
dat_min_subset2 <- gsub("_HR.A", "_HR.B", dat_min_subset2)
dat_min_subset2 <- gsub("_HU.A", "_HU.B", dat_min_subset2)
dat_min_subset2 <- gsub("_IT.A", "_IT.B", dat_min_subset2)
dat_min_subset2 <- gsub("_PL.A", "_PL.B", dat_min_subset2)
dat_min_subset2 <- gsub("_RO.A", "_RO.B", dat_min_subset2)
dat_min_subset2 <- gsub("_SE.A", "_SE.B", dat_min_subset2)
dat_min_subset2 <- gsub("_SI.A ", "_SI.B", dat_min_subset2)
dat_min_subset2 <- gsub("_SK.A", "_SK.B", dat_min_subset2)
dat_min_subset2 <- gsub("_UA.A", "_UA.B", dat_min_subset2)



dat_min_subset2 <- as.data.frame(dat_min_subset2)


dat_min30_3 <- merge(dat_min_subset1, dat_min_subset2, all=TRUE, sort=FALSE)    #merge subsets

dat_min30_3 <- as.data.frame(dat_min30_3, stringsAsFactors = FALSE)
dat_min30_4 <- dat_min30_3[order(dat_min30_3$V1),]


dat_min30_4[dat_min30_4 == "-9"] <- NA


dat_min30_5 <- data.frame(lapply(dat_min30_4, as.character), stringsAsFactors=FALSE)
str(dat_min30_5)

dat_min30_5[is.na(dat_min30_5)] <- "M"




# add first row (only for the format)

x <- rep(" ", ncol(dat_min30_5))
dat_min30_5 <- rbind(x, dat_min30_5)



write.table(dat_min30_5, "all_97_new_class_without_outgroup_min30_wblanks_and_minus2.txt", sep="", row.names=FALSE, col.names=FALSE, quote = FALSE)

#add manually "282 10000" in first row



dat_min30_5a<-read.table("all_97_new_class_with_outgroup_min30_wblanks_and_minus2.txt", sep="")
