#Script Name: VSharma_HW05_Script.R
#Location: F:\Texas_A&M\3rd Semester\STAT604\HW5\Assignment5
#Created by Vertika Sharma
#Creation Date: 09/16/18
#Purpose: Practice working with data frames and text files. Analyze Oklahoma school data.
#Last executed: 09/16/18

Sys.time()

#1 housekeeping
ls()
#rm(list=ls())

#2 load workspace from previous assigment
load("F:/Texas_A&M/3rd Semester/STAT604/HW4/HW04.RData")

#show contents of workspace
ls()

#3 Compute the average of the HSTotal column using various methods
#3a. Using index numbers
mean(Oklahoma[,15], na.rm=TRUE)

#3b. Using fully qualified column name
mean(Oklahoma$HSTotal, na.rm=TRUE)

#3c. Using only the column name
attach(Oklahoma)
search()
mean(HSTotal,na.rm=TRUE)
detach(Oklahoma)

#3d. Compute the mean using the with function
with(Oklahoma, mean(HSTotal, na.rm=TRUE))

#4 Perform a logical test to show which HSTotal values are not missing and are larger than average
Oklahoma$HSTotal>mean(Oklahoma$HSTotal, na.rm=TRUE) & is.na(Oklahoma$HSTotal)==FALSE

#5 Display school, city and HSTotal of records that meet criteria in previous step
Oklahoma[Oklahoma$HSTotal>mean(Oklahoma$HSTotal, na.rm=TRUE) & is.na(Oklahoma$HSTotal)==FALSE, 
c(1,2,15)]

#6 Use the apply function to compute the average class size for grades 7 through 12
apply(Oklahoma [,6:11], 2, mean, na.rm=TRUE)

#7 Use the apply function to create a new column called AvgClassSize by computing the average class size of grades 7 through 12 for each school.
Oklahoma$AvgClassSize <- apply(Oklahoma[,6:11],1, mean, na.rm=TRUE)

#8 Display the first 25 rows of the modified data frame.
Oklahoma[1:25,]

#9 Create a new data frame of schools containing HS in the name
OklahomaHS<- Oklahoma[grep(" HS",Oklahoma$School), -c(6,7,12,13,14)]
# show the structure of the new data frame
str(OklahomaHS)

#10 Read in zip code database into a data frame for future use
ZipDF<- read.csv("F:/Texas_A&M/3rd Semester/STAT604/HW5/zip_codes.csv")
# show the structure of the new data frame
str(ZipDF)

#11 Display the contents of the workspace
ls()

#12 Save the workspace in a new file
save.image("F:/Texas_A&M/3rd Semester/STAT604/HW5/HW5.RData")


