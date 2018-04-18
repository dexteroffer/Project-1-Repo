##Setting the environment, and loading dplyr. 
rm(List=ls())
setwd(X)
library(dplyr)

## The following txt files were merged in Excel: “X_Test.txt”, “X_train.txt”, “y_test.txt”, “y_train.txt”, “subject_test.txt”, “subject_train.txt”, and “features.txt”. This merged file was saved as a csv file “Raw_Data” and then uploaded to R Studio. 
Raw_Data<-read.csv("Raw_Data.csv")

## We used the grep function to filter/select all of the variable names in the data headers that related to mean and standard deviation. We individually isolated “Subject”, “Activity”, “mean”, “std”, and then combined them with the ‘select’ function to create the data table “Raw_Selected”. 
Subject <-grep("Subject", colnames(Raw_Data))
Activity <-grep("Activity", colnames(Raw_Data))
mean <-grep("mean", colnames(Raw_Data))
std <-grep("std", colnames(Raw_Data))
Raw_Selected <-select(Raw_Data, Subject, Activity, mean, std)

## We used the ‘arrange’ function to order the subjects in ascending order. 
Raw_Arranged<-arrange(Raw_Selected, Subject)

## Used group_by function to select “Subject” and “Activity” variables to be able to summarize the 
subject_group <-group_by(Raw_Selected, Subject, add=TRUE)
activity_group <-group_by(subject_group, Activity, add=TRUE)
Averages_Data  <-activity_group %>% summarize_all(c("mean"))

## Renaming Activity Variables (1-6) to corresponding activity name (“WALKING”, WALKING_UPSTAIRS”, etc). 
Averages_Data$Activity[Averages_Data$Activity =="1"] <- "WALKING"
Averages_Data$Activity[Averages_Data$Activity =="2"] <- "WALKING_UPSTAIRS" 
Averages_Data$Activity[Averages_Data$Activity =="3"] <- "WALKING_DOWNSTAIRS" 
Averages_Data$Activity[Averages_Data$Activity =="4"] <- "SITTING" 
Averages_Data$Activity[Averages_Data$Activity =="5"] <- "STANDING" 
Averages_Data$Activity[Averages_Data$Activity =="6"] <- "LAYING"

## Write final table with the ‘write.table’ function to save as txt file “tidy1.txt”. 
write.table(Averages_Data, "tidy1.txt", row.names = F, quote = F)
