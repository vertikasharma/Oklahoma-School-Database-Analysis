#Script Name: VSharma_HW08_Script.R
#Location: F:\Texas_A&M\3rd Semester\STAT604\HW8Assignment8
#Created by Vertika Sharma
#Creation Date: 10/03/18
#Purpose: Practice working with different types of graphs in R.
#Last executed: 10/03/18

Sys.time()

#1 housekeeping
ls()
#rm(list=ls())

#2 load previously saved workspace
load("F:/Texas_A&M/3rd Semester/STAT604/HW5/HW5.RData")

#show contents of workspace
ls()

#3 create Output PDF file
pdf("F:/Texas_A&M/3rd Semester/STAT604/HW8/HW8.pdf")

#4a create histogram of PTRatio with default breaks
hist(Oklahoma$PTRatio, freq=FALSE, xlab="Pupils/Teacher", main="Pupil/Teacher Ratios in Oklahoma Schools")
#4b create break vector for break points every 4 pupil/teacher
brv<- seq(0,160,4)
#4b Create Histogram with breakpoints at 4 pupil/teacher
hist(Oklahoma$PTRatio, breaks=brv, freq=FALSE, xlab="Pupils/Teacher", main="Pupil/Teacher Ratios in Oklahoma Schools")

#5 add normal distribution curve to histogram
xd<- seq(0,160,1)
yd<- dnorm(xd, mean=mean(Oklahoma$PTRatio, na.rm=TRUE), sd=sd(Oklahoma$PTRatio, na.rm=TRUE))
lines(xd,yd, col="#FF9900")

#6 add vertcal line on average value to graph
abline(v=mean(Oklahoma$PTRatio, na.rm=TRUE), col=6)

#7 create plot for distribution of teachers and PTRatio
plot(Oklahoma$Teachers, Oklahoma$PTRatio, xlab='Teachers', ylab='Pupil/Teacher Ratio', xlim=c(0,140), pch=3, col="maroon")

#8 add fitline to graph and show summary statistics
tm<-lm(Oklahoma$PTRatio~Oklahoma$Teachers, Oklahoma)
abline(tm, col="yellow")
summary(tm)

#9 add timestamp to graph
text(100,150, Sys.time())

#10 create a boxplot of the number of students in each grade
boxplot(Oklahoma[,6],Oklahoma[,7],Oklahoma[,8],Oklahoma[,9],Oklahoma[,10],Oklahoma[,11],names=c(7,8,9,10,11,12), xlab="Grades", ylab="Students", main="Tulsa County vs. State", range=1200, col="light green")

#11 add points in graph indicating averages for each column
means<-apply(Oklahoma[Oklahoma$County=="TULSA COUNTY",6:11], 2, mean, na.rm=TRUE)
points(means, pch=23, col="red", bg="dark green", cex=1.5) 

graphics.off()
