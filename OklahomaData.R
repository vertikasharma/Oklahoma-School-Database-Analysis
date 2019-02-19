#Script Name: VSharma_HW04_Script.R
#Location: F:\Texas_A&M\3rd Semester\STAT604\HW4\Script
#Created by Vertika Sharma
#Creation Date: 09/10/18
#Purpose: Practical implementation of topics (vectors, matrices, dataframes) covered in class
#Last executed: 09/10/18

#System Time Log
Sys.time()

#1 Housekeeping
ls()
#rm(list=ls())

#2 Send output to console and text file
sink("F:/Texas_A&M/3rd Semester/STAT604/HW4/VSharma_HW04_Output.txt", split=TRUE)

#3 Create and display a vector of numeric values from 4 to 100 with an increment of 4
(V1<- seq(4, 100, by=4))
# show the type of data contained in the vector
mode(V1)

 #4 Create and display a vector of numeric values from .8 to 40 with an increment of .8
(V2<- seq(0.8, 40, by=0.8))
# show the type of data contained in the vector
mode(V2)

#5 Use the second vector to create and display a matrix by columns that is 5 columns wide
(M1 <- matrix(V2, ncol=5))

#6 Combine the two vectors as columns to create and display a new matrix
# The two vectors will be combined as columns side by side, the vector with the shorter length will have its values recycled
(M2 <- cbind(V1,V2))

#7 Combine the two vectors as rows to create and display a new matrix
(M3 <- rbind(V1,V2))

#8a show contents of workspace
ls()

#8b load previously saved workspace
load("F:/Texas_A&M/3rd Semester/STAT604/HW4/HW04.RData")

#8c show contents of workspace again
ls()

#9 Display the object type and the type of data contained in the object
loaded in the workspace
class(Oklahoma)
mode(Oklahoma)

#10 Display the same information for column 1 from that object
class(Oklahoma[,1])
mode(Oklahoma[,1])

#11 Display the structure of the object loaded in the HW04 workspace
str(Oklahoma)

#12 Display a summary of the object loaded in the HW04 workspace
summary(Oklahoma)

#13 Display the first 10 rows and all but column 12 from the object
Oklahoma[1:10, -12]

#14 Create and display a new object from Oklahoma using the first 25 rows, the first 2 columns, columns 4 and 5, andcolumns 13 through 15
(DF<- Oklahoma[1:25, c(1,2,4,5,13,14,15)])

#15 close output file
sink()
