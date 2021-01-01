
############ QUESTION 1 ############################
setwd("C://Users//Sara//Desktop//Sara")
dir.create(".//Getting and Cleaning Data_w3")

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv" 
download.file(fileUrl, dest=(".//Getting and Cleaning Data_w3//question1.csv"))
mydata<-read.csv(".//Getting and Cleaning Data_w3//question1.csv")

#10 acres who sold more than $10,000 worth of agriculture products.

question1<- mydata$ACR>=3 & mydata$AGS>=6

which(question1)

############ QUESTION 2 ############################

install.packages("jpeg")
fileUrl2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg" 
download.file(fileUrl2, dest=".//Getting and Cleaning Data_w3//question2.jpg", mode="wb")

library(jpeg)
mypic<-readJPEG(".//Getting and Cleaning Data_w3//question2.jpg", native=TRUE)
quantile(mypic,probs=seq(0.8,0.8))
############ QUESTION 3 ############################

fileUrl3<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv" 
fileUrl4<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
download.file(fileUrl3, dest=".//Getting and Cleaning Data_w3//question3_1.csv")
download.file(fileUrl4, dest=".//Getting and Cleaning Data_w3//question3_2.csv")
gdp_0<-read.csv(".//Getting and Cleaning Data_w3//question3_1.csv", header=FALSE)


gdp<-gdp_0[6:195,1:5]
names(gdp)<-  c("CountryCode", "Ranking","", "Economy", "GDP")




edu<-read.csv(".//Getting and Cleaning Data_w3//question3_2.csv")

merge_check<-merge(gdp, edu, by = intersect(names(gdp), names(edu)), all=TRUE)

intersect(names(gdp), names(edu))
mergedData2 = merge(gdp,edu)



st<-arrange(mergedData2,desc(as.numeric(as.character(mergedData2$Ranking))))

st[13,6]
############ QUESTION 4 ############################
question4 <- ddply(mergedData2,.(Income.Group),summarize,sum=ave(as.numeric(as.character(Ranking)),FUN=sum))
table(question4)

check<-ddply(mergedData2, "Income.Group", summarise, mean=mean(as.numeric(as.character(Ranking))))


############ QUESTION 5 ############################
install.packages("Hmisc")
library(Hmisc)
library(plyr)


mergedData3 = mutate(mergedData2,rankgroups=cut2((as.numeric(as.character(Ranking))),g=5))

table(mergedData3$rankgroups, mergedData3$Income.Group)


