##set working direcotry and open "Panel_8595.txt" from the github repo & run

Pan_a <- read.table("Panel_8595.Txt", as.is = TRUE, fill = TRUE)
Pan_a$V2 <- NULL
Pan_a[-c(1:2), ]

colnames(Pan_a)[colnames(Pan_a)=="V1"] <- "Plant ID"
colnames(Pan_a)[colnames(Pan_a)=="V3"] <- "Year"
colnames(Pan_a)[colnames(Pan_a)=="V4"] <- "Electricity"
colnames(Pan_a)[colnames(Pan_a)=="V5"] <- "Short Tons SO2"
colnames(Pan_a)[colnames(Pan_a)=="V6"] <- "Short Tons NOx"
colnames(Pan_a)[colnames(Pan_a)=="V7"] <- "Capital Stock"
colnames(Pan_a)[colnames(Pan_a)=="V8"] <- "Employees"
colnames(Pan_a)[colnames(Pan_a)=="V9"] <- "Heat Content of Coal"
colnames(Pan_a)[colnames(Pan_a)=="V10"] <- "Heat Content of Oil"
colnames(Pan_a)[colnames(Pan_a)=="V11"] <- "Heat Content of Gas"
colnames(Pan_a)[colnames(Pan_a)=="V12"] <- "F1"
colnames(Pan_a)[colnames(Pan_a)=="V13"] <- "F2"


Pan_a$`Short Tons NOx MwH` <- as.numeric(Pan_a$`Short Tons NOx`)*(.001/1)
Pan_a$`Short Tons NOx MwH - Daily Averages` <- as.numeric(Pan_a$`Short Tons NOx MwH`)/365

Pan_a$`Short Tons SO2 MwH` <- as.numeric(Pan_a$`Short Tons SO2`)*(.001/1)
Pan_a$`Short Tons SO2 MwH- Daily Average` <- as.numeric(Pan_a$`Short Tons SO2 MwH`)/365

Pan_a$`Electricity - Daily Average` <- as.numeric(Pan_a$`Electricity`)/365
Pan_a$`Heat Content of Coal - Daily Average` <- as.numeric(Pan_a$`Heat Content of Coal`)/365
Pan_a$`Heat Content of Oil - Daily Average` <- as.numeric(Pan_a$`Heat Content of Oil`)/365
Pan_a$`Heat Content of Gas - Daily Average` <- as.numeric(Pan_a$`Heat Content of Gas`)/365

Pan_b <- Pan_a


Pan_b$newcolumn <- as.numeric(Pan_b$Year <= 90)
colnames(Pan_b)[colnames(Pan_b)=="newcolumn"] <- "Dummy"
Pan_c <- Pan_b


Pan_c$F1 = NULL 
Pan_c$F2 = NULL


Pan_c$newcolumn <- as.numeric(Pan_c$`Capital Stock`)*(1/0.17)
colnames(Pan_c)[colnames(Pan_c)=="newcolumn"] <- "Capital Stock in 2017 Dollars"
Pan_d <- Pan_c[-c(1:2), ]


write.table(Pan_d, file = "tidy2.txt")


tidy2 <- read.table("tidy2.txt")
Tidy2_a <- aggregate(tidy2[3:10], list(tidy2$Plant.ID), mean)
write.table(Tidy2_a, file = "tidy2_a.txt")

Sums_1 <- aggregate(Electricity ~ Year , data = tidy2, sum)
Sums_2 <- aggregate(Short.Tons.SO2 ~ Year , data = tidy2, sum)
Sums_3 <- aggregate(Short.Tons.NOx ~ Year , data = tidy2, sum)
Sums_4 <- aggregate(Capital.Stock ~ Year , data = tidy2, sum)
Sums_5 <- aggregate(Employees ~ Year , data = tidy2, sum)
Sums_6 <- aggregate(Heat.Content.of.Coal ~ Year , data = tidy2, sum)
Sums_7 <- aggregate(Heat.Content.of.Oil ~ Year , data = tidy2, sum)
Sums_8 <- aggregate(Heat.Content.of.Gas ~ Year , data = tidy2, sum)
Sums_9 <- aggregate(Short.Tons.SO2.MwH ~ Year , data = tidy2, sum)
Sums_10<- aggregate(Pan_d$`Short Tons SO2 MwH- Daily Average` ~ Year , data = tidy2, sum)
Sums_11 <- aggregate(Pan_d$`Electricity - Daily Average` ~ Year , data = tidy2, sum)
Sums_12 <- aggregate(Pan_d$`Heat Content of Coal - Daily Average` ~ Year , data = tidy2, sum)
Sums_13 <- aggregate(Pan_d$`Heat Content of Oil - Daily Average` ~ Year , data = tidy2, sum)
Sums_14 <- aggregate(Pan_d$`Heat Content of Gas - Daily Average` ~ Year , data = tidy2, sum)
Sums_15 <- aggregate(Capital.Stock.in.2017.Dollars ~ Year , data = tidy2, sum)
Sums_16<- aggregate(Pan_d$`Short Tons NOx MwH - Daily Averages` ~ Year , data = tidy2, sum)

Tidy_bnew <- merge(Sums_1, Sums_2)
Tidy_bnew2 <- merge(Tidy_bnew, Sums_3)
Tidy_bnew3 <- merge(Tidy_bnew2, Sums_4)
Tidy_bnew4 <- merge(Tidy_bnew3, Sums_5)
Tidy_bnew5 <- merge(Tidy_bnew4, Sums_6)
Tidy_bnew6 <- merge(Tidy_bnew5, Sums_7)
Tidy_bnew7 <- merge(Tidy_bnew6, Sums_8)
Tidy_bnew8 <- merge(Tidy_bnew7, Sums_9)
Tidy_bnew9 <- merge(Tidy_bnew8, Sums_10)
Tidy_bnew10 <- merge(Tidy_bnew9, Sums_11)
Tidy_bnew11 <- merge(Tidy_bnew10, Sums_12)
Tidy_bnew12 <- merge(Tidy_bnew11, Sums_13)
Tidy_bnew13 <- merge(Tidy_bnew12, Sums_14)
Tidy_bnew14 <- merge(Tidy_bnew13, Sums_15)
Tidy2_b <- merge(Tidy_bnew14, Sums_16)


write.table(Tidy2_b, file = "tidy2_b.txt")