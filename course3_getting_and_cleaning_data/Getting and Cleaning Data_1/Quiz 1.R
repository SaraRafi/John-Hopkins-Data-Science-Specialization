getwd()
setwd ("C://Users//Sara//Desktop//Sara")
dir.create("Getting and Cleaning Data")

##Question 1 How many properties are worth $1,000,000 or more?

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
datedownloaded<-date()
datedownloaded


mydata<-read.csv(".//Getting and Cleaning Data//Quiz1.csv")
 #variable= VAL
mydata
mydata["newcolumn"]<-NA

mydata$newcolumn[mydata$VAL>=24]<-1
mydata$newcolumn[mydata$VAL==NA]<-NA

mytable<-table(mydata$newcolumn)
mytable

##QUestion 2:  Consider the variable FES in the code book. 
##Which of the "tidy data" principles does this variable violate?
mydata$FES

###############incomplete


##Question 3:
fileUrl2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx "
download.file(fileUrl2,dest=".//Getting and Cleaning Data//Quiz1_3.xlsx", mode="wb")
dateDownloaded<-date()
dateDownloaded

##


install.packages("xlsxjars")
install.packages("xlsx")
install.packages("rJava")
install.packages("openxlsx")
library(openxlsx)
library(rJava)


?openxlsx
library(xlsx)
dataexcel<-read.xlsx(".//Getting and Cleaning Data//Quiz1_3.xlsx", sheet=1,startRow=1, colNames=FALSE,skipEmptyRows=FALSE)
#rows 18-23 and columns 7-15 



dat<-dataexcel[19:23,7:15]
colnames(dat)<-dataexcel[18,7:15]

z<-as.numeric(dat$Zip)
e<-as.numeric(dat$Ext)

sum(z*e,na.rm=T)


dataexcel_subset<-read.xlsx(".//Getting and Cleaning Data//Quiz1_3.xlsx", sheet=1,colIndex=colIndex, rowIndex=rowIndex,colNames=TRUE)
#################incomplete

##Question 4:
#install.packages("XML")
library(XML)
fileUrl3<- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml" 
doc <- xmlTreeParse(fileUrl3, useInternal=TRUE)
rootNode<- xmlRoot (doc)
xmlName(rootNode)
names(rootNode)
#rootNode[[1]]
rootNode[[1]][[1]]
xpathSApply(rootNode,"//zipcode",xmlValue)

zipcode_vector<-xpathSApply(doc,"//zipcode",xmlValue)
length(zipcode_vector[zipcode_vector=='21231'])



##Question 5: 
install.packages("data.table")
library(data.table)

fileUrl4<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv" 
download.file(fileUrl4, dest=".//Getting and Cleaning Data//Quiz1_4.csv")

DT<-fread(".//Getting and Cleaning Data//Quiz1_4.csv")

head(DT)


DT[,mean(pwgtp15),by=SEX]
sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT$pwgtp15,by=DT$SEX)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
tapply(DT$pwgtp15,DT$SEX,mean)

system.time(DT[,mean(pwgtp15),by=SEX])
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))

system.time(tapply(DT$pwgtp15,DT$SEX,mean))

system.time(mean(DT[DT$SEX==1,]$pwgtp15))
system.time(mean(DT[DT$SEX==2,]$pwgtp15)))
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])

