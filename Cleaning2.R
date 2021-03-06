##set working direcotry and open "Panel_8595.txt" from the github repo & run

Pan_a <- read.table("Panel_8595.Txt", as.is = TRUE, fill = TRUE)
Pan_a$V2 <- NULL
Pan_a[-c(1:2), ]

##Pan_a removes V2 and rows 1 & 2 in order to have pure data and headers.

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


##Changed each corresponding "V" column header to its designated header per the data on page 37 from table 1.

Pan_a$`Short Tons NOx MwH` <- as.numeric(Pan_a$`Short Tons NOx`)*(.001/1)
Pan_a$`Short Tons NOx MwH - Daily Averages` <- as.numeric(Pan_a$`Short Tons NOx MwH`)/365

Pan_a$`Short Tons SO2 MwH` <- as.numeric(Pan_a$`Short Tons SO2`)*(.001/1)
Pan_a$`Short Tons SO2 MwH- Daily Average` <- as.numeric(Pan_a$`Short Tons SO2 MwH`)/365

Pan_a$`Electricity - Daily Average` <- as.numeric(Pan_a$`Electricity`)/365
Pan_a$`Heat Content of Coal - Daily Average` <- as.numeric(Pan_a$`Heat Content of Coal`)/365
Pan_a$`Heat Content of Oil - Daily Average` <- as.numeric(Pan_a$`Heat Content of Oil`)/365
Pan_a$`Heat Content of Gas - Daily Average` <- as.numeric(Pan_a$`Heat Content of Gas`)/365

Pan_b <- Pan_a

##This fixed the error of the spaces within the data in the Short Tons NOx column, and converts the Short Tons NOx variables into numeric class so that it can be divided by 365 in order to get a daily average. The Short Tons SO2 is converted into numeric class so that it can be divided by 365 in order to get a daily average.

Pan_b$newcolumn <- as.numeric(Pan_b$Year <= 90)
colnames(Pan_b)[colnames(Pan_b)=="newcolumn"] <- "Dummy"
Pan_c <- Pan_b

##Adding dummy variables separating 1990 as the cutoff time (before and during 1990 = 1, after 1990 = 0).


Pan_c$F1 = NULL 
Pan_c$F2 = NULL
##Removed superfluous variables (columns F1 and F2) given they are neither necessary data points nor necessary columns for the overall data analysis.

Pan_c$newcolumn <- as.numeric(Pan_c$`Capital Stock`)*(1/0.17)
colnames(Pan_c)[colnames(Pan_c)=="newcolumn"] <- "Capital Stock in 2017 Dollars"
Pan_d <- Pan_c[-c(1:2), ]

##$1.00 today (January 2018) = $0.17 in January of 1973 <https://www.bls.gov/data/inflation_calculator.htm>
##This gets the conversion of Capital Stock in 1973 dollars to 2018 dollars (both being taking from the month of January in their respective years).

write.table(Pan_d, file = "tidy2.txt")

##Save Tidy2

tidy2 <- read.table("tidy2.txt")
Tidy2_a <- aggregate(tidy2[3:10], list(tidy2$Plant.ID), mean)
write.table(Tidy2_a, file = "tidy2_a.txt")

##open Tidy2 and use aggregate comand to average all variables over at 92 plants
##Save as Tidy2_a


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

##create datasubets of the aggreated variables to be merges


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

##merge the datasubets into one large dataset

write.table(Tidy2_b, file = "tidy2_b.txt")

##save as Tidy2_b