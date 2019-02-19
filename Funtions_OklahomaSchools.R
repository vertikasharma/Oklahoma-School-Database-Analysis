#Script Name: VSharma_HW09_Script.R
#Location: F:\Texas_A&M\3rd Semester\STAT604\HW9\Assignment9
#Created by Vertika Sharma
#Creation Date: 10/07/18
#Purpose: Practice working with functions and graphs in R.
#Last executed: 10/07/18

Sys.time()

#housekeeping
ls()
#rm(list=ls())



#1 read csv file into a dataframe
nke <- read.csv("F:\\Texas_A&M\\3rd Semester\\STAT604\\HW9\\NKE.csv", header=TRUE)
# show structure of dataframe
str(nke)


#2 create output pdf file and set size
pdf("F:/Texas_A&M/3rd Semester/STAT604/HW8/HW8.pdf", height=8.5, width=11)

#3 create a 30 day expotential moving average graph
#3a assign value to alpha
N <-30
alpha <-2/(1+N)

#3b create a vector for ema values
emavalues <- rep(0,length(nke$Adj.Close))

#3c update 30th value in vector with average of first 30 closing adjustments
emavalues [30] <- mean(nke[1:30,6])

#3d loop to run ema formula and store values in vector
for (i in 31:length(emavalues)){
    emavalues[i]<- ((alpha*nke[i,5]) + (emavalues[i-1]*(1-alpha)))
}

#3e set background to blue
par(bg="grey90")
plot(1:260, emavalues[9276:9535], type='l', col="blue", ylim= c(0,90), xlab="Adjusted Closing Price", ylab="Days", main="30 Day EMA and Daily Stock Prices")

#3f add formula to graph
text(130,5, expression(paste(EMA[i],"=(", P[i]%*%alpha, ") + (", EMA[i-1]%*%"(1-", alpha, ")) where ", alpha, "=", over(2,1+N))), cex=0.95)

#3g add line showing actual adjusting closing values
lines(1:260, nke[9276:9535,6], type='l', col='red')

#4 add the code to a function
emafunc = function(a, N=30, Y=90){
alpha <- 2/(1+N)
emavalues <- rep(0, length(a))
emavalues[N] <- mean(a[1:N])
y = N+1: length(emavalues)
for(i in y){
if(i<=length(emavalues)){
emavalues[i] = nke$Adj.Close[i]*alpha + emavalues[i-1]*(1-alpha)
i<-i+1}}

par(bg = 'grey90')
	
y = (length(emavalues)- 259): length(emavalues)
plot(1:260, emavalues[y], type='l', col='blue', ylim= c(0,Y), xlab='Adjusted Closing Price',ylab='Days', main=bquote(paste(.(N), ' Day EMA and Daily Stock Prices')))

P<- nke$Adj.Close
text(130, 5, cex=0.95,bquote(paste(EMA[i],"=(", P[i]%*%alpha, ") + (", EMA[i-1]%*%"(1-", alpha, ")) where ", alpha, "=", over(2,1+.(N)))))

lines(1:260, nke$Adj.Close[y],col="red")
}

par(mfcol=c(1,2), omi=c(0.5, 0.5, 1.5, 0.5), mar=c(4,4,2,0))

#6 call function
emafunc(nke$Adj.Close)
emafunc(nke$Adj.Close, N=100)

#7 include system time
mtext(Sys.time(), adj=0, side=1, outer=TRUE)

#8 close graphics
dev.off()


