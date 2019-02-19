#Script Name: VSharma_HW06_Script.R
#Created by Vertika Sharma
#Creation Date: 09/22/18
#Purpose: Practice working with vectors, matrices, and data frames. Analyze Oklahoma school data.
#Last executed: 09/22/18

Sys.time()

#1 housekeeping
ls()
#rm(list=ls())

#2 load previously saved workspace
load("F:/Texas_A&M/3rd Semester/STAT604/HW5/HW5.RData")

#show contents of workspace
ls()

#3a Create a data frame of Oklahoma zips. Remove PO BOX and Decommisioned zips
OklahomaZips <- ZipDF[(ZipDF$state=='OK' & ZipDF$type !='PO BOX' & ZipDF$decommissioned==0) ,c(1,3,7,15)]

#3b Change the name of primary_city to MailCity
names(OklahomaZips) <- sub('primary_city', 'MailCity', names(OklahomaZips))

#3c Change the names of the cities to upper case
OklahomaZips$MailCity <- toupper(OklahomaZips$MailCity)

#3d Create a zip3 column using the first 3 digits of the zip code
OklahomaZips$ZipRegion <- substr(OklahomaZips$zip, 1, 3)

#3e Display information on new data frame
str(OklahomaZips)
OklahomaZips[1:25,]

#4 Merge the zip data with the Oklahoma High School data
OKHSzips <- merge(OklahomaHS, OklahomaZips, all=FALSE)
dim(OKHSzips)

#5 Create a data frame of unduplicated High Schools
UniqueHS <- OKHSzips[!duplicated(OKHSzips$School),]
str(UniqueHS)

#6 Display the 20 smallest and largest schools based on number of Teachers
UniqueHS [order(UniqueHS$Teachers) [1:20], c(15,2,1,4,10,5)]
UniqueHS [order(UniqueHS$Teachers, decreasing=TRUE) [1:20], c(15,2,1,4,10,5)]

#7 Create csv file of schools including zipRegion and system time
cat(paste(UniqueHS$School, UniqueHS$MailCity, UniqueHS$County, UniqueHS$ZipRegion, UniqueHS$HSTotal, UniqueHS$SysTime <- Sys.time(), sep=","), file="F:\\Texas_A&M\\3rd Semester\\STAT604\\HW6\\VSharma_HW06_Data.csv",sep="\n")
