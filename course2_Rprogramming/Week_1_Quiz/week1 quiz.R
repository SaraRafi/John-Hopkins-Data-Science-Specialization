setwd("C:/Users/admin/Desktop/R Folder");

mydata=read.csv("hw1_data.csv")
data.matrix(mydata)
mydata[1:2,]
mydata[47,1]
y<- mydata[,1]
sum(is.na(y))

newdata <- mydata[ which(mydata$Ozone>31 & mydata$Temp > 90), ]
summary(newdata)
newdata19<-mydata[ which(mydata$Month==6), ]
newdata20<-mydata[ which(mydata$Month==5), ]
