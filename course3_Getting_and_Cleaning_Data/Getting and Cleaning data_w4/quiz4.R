######## Question 1
getwd()
setwd("C://Users//Sara//Desktop//Sara")


############### QUESTION 1
list.files("C://Users//Sara//Desktop//Sara")
dir.create("Getting and Cleaning data_w4")

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(fileUrl, dest=".//Getting and Cleaning data_w4//quiz4.csv" ) 

mydata<-read.csv(".//Getting and Cleaning data_w4//quiz4.csv")
splitNames = strsplit(names(mydata),"wgtp")
splitNames[[123]]

############### QUESTION 2

fileUrl2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl2, dest=".//Getting and Cleaning data_w4//quiz4_q2.csv" )

gdp_0<-read.csv(".//Getting and Cleaning Data_w4//quiz4_q2.csv", header=FALSE)


gdp<-gdp_0[6:195,1:5]
names(gdp)<-  c("CountryCode", "Ranking","", "Economy", "GDP")

gdp_check<-gsub(",","",gdp$GDP)
mean(as.numeric(gdp_check))


################ QUESTION 3

x_1<-grep("*United",gdp$Economy)
x_2<-grep("^United",gdp$Economy)
x_3<-grep("^United",gdp$Economys)
x_4<-grep("United$",gdp$Economy)


############## QUESTION 4

fileUrl3<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 
fileUrl4<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"  "

download.file(fileUrl3, dest=".//Getting and Cleaning Data_w4//question4_1.csv")
download.file(fileUrl4, dest=".//Getting and Cleaning Data_w4//question4_2.csv")
gdp_0_1<-read.csv(".//Getting and Cleaning Data_w3//question3_1.csv", header=FALSE)


gdp_1<-gdp_0_1[6:195,1:5]
names(gdp_1)<-  c("CountryCode", "Ranking","", "Economy", "GDP")




edu<-read.csv(".//Getting and Cleaning Data_w4//question4_2.csv")
names(edu)

mergedData2 = merge(gdp_1,edu)
mergedData2$Special.Notes
mergedData2$National.accounts.base.year                      
mergedData2$National.accounts.reference.year
z<-grep("Fiscal year end: June",mergedData2$Special.Notes , value=TRUE)

head(mergedData2)



################QUESTION 5
install.packages("quantmod")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

x<-format(sampleTimes, "%Y")
table(x)
table(x, weekdays(sampleTimes))
