

#####Working directory

setwd("C:\\Users\\Sara\\Desktop\\Sara\\5_Reproducible Research\\PA_2")

#####Loading data

assignment<-read.csv(bzfile("repdata-data-StormData.csv.bz2"), header=TRUE, stringsAsFactors=FALSE)   

######Preparing Data


dim(assignment)
names(assignment)

##Selecting columns

variables<-c("EVTYPE","FATALITIES","INJURIES","PROPDMG", "PROPDMGEXP","CROPDMG","CROPDMGEXP")
data<-assignment[variables]


######Events most harmful to human population

#aggregate data by event

fatal <- aggregate(FATALITIES ~ EVTYPE, data = data, FUN = sum)
fatal <- fatal[order(-fatal$FATALITIES),][1:10, ]
injury <- aggregate(INJURIES ~ EVTYPE, data = data, FUN = sum)
injury <- injury[order(-injury$INJURIES),][1:10, ]



par(mfrow = c(1, 2), mar = c(12, 4, 3, 2), mgp = c(3, 1, 0), las=3,cex = 0.8)
barplot(fatal$FATALITIES, names.arg=fatal$EVTYPE, ylim= c(0,7000),col=heat.colors(10),ylab="Number of Fatalities", main=" Top 10 Events with Highest Fatalities")
barplot(injury$INJURIES, names.arg=injury$EVTYPE,ylim= c(0,10000), col=terrain.colors(10), ylab="Number of Injuries", main=" Top 10 Events with Highest Injuries")


#################Question 2


unique(data$PROPDMGEXP)

data$PROPEXP[data$PROPDMGEXP ==  "K"   ]	<-	1000
data$PROPEXP[data$PROPDMGEXP ==	"M" 	]	<-	10^6
data$PROPEXP[data$PROPDMGEXP ==	""  	]	<-	1
data$PROPEXP[data$PROPDMGEXP ==	"B" 	]	<-	10^9
data$PROPEXP[data$PROPDMGEXP ==	"m" 	]	<-	10^6
data$PROPEXP[data$PROPDMGEXP ==	"+" 	]	<-	0
data$PROPEXP[data$PROPDMGEXP ==	"0" 	]	<-	1
data$PROPEXP[data$PROPDMGEXP ==	"5" 	]	<-	10^5
data$PROPEXP[data$PROPDMGEXP ==	"6" 	]	<-	10^6
data$PROPEXP[data$PROPDMGEXP ==	"?" 	]	<-	0
data$PROPEXP[data$PROPDMGEXP ==	"4" 	]	<-	10000
data$PROPEXP[data$PROPDMGEXP ==	"2" 	]	<-	100
data$PROPEXP[data$PROPDMGEXP ==	"3" 	]	<-	1000
data$PROPEXP[data$PROPDMGEXP ==	"h" 	]	<-	100
data$PROPEXP[data$PROPDMGEXP ==	"7" 	]	<-	10^7
data$PROPEXP[data$PROPDMGEXP ==	"H" 	]	<-	100
data$PROPEXP[data$PROPDMGEXP ==	"-" 	]	<-	0
data$PROPEXP[data$PROPDMGEXP ==	"1" 	]	<-	10
data$PROPEXP[data$PROPDMGEXP ==	"8"	]	<-	10^8

data$PROPDMGVAL <- data$PROPDMG * data$PROPEXP


unique(data$CROPDMGEXP)

data$CROPEXP[data$CROPDMGEXP ==  ""  	]	<-	1
data$CROPEXP[data$CROPDMGEXP ==	"M" 	]	<-	10^6
data$CROPEXP[data$CROPDMGEXP ==	"K" 	]	<-	1000
data$CROPEXP[data$CROPDMGEXP ==	"m" 	]	<-	10^9
data$CROPEXP[data$CROPDMGEXP ==	"B" 	]	<-	10^6
data$CROPEXP[data$CROPDMGEXP ==	"?" 	]	<-	0
data$CROPEXP[data$CROPDMGEXP ==	"0" 	]	<-	1
data$CROPEXP[data$CROPDMGEXP ==	"k" 	]	<-	1000
data$CROPEXP[data$CROPDMGEXP ==	"2"	]	<-	100

data$CROPDMGVAL <- data$CROPDMG * data$CROPEXP


propdmg <- aggregate(PROPDMGVAL ~ EVTYPE, data = data, FUN = sum)
cropdmg <- aggregate(CROPDMGVAL ~ EVTYPE, data = data, FUN = sum)


propdmg10<-propdmg[order(-propdmg$PROPDMGVAL), ][1:10,]
cropdmg10<-cropdmg[order(-cropdmg$CROPDMGVAL), ][1:10,]

par(mfrow = c(1, 2), mar = c(12, 4, 3, 2), mgp = c(3, 1, 0), las=3,cex = 0.8, cex.main = 0.9)

barplot((propdmg10$PROPDMGVAL)/(1*10^9), names.arg=propdmg10$EVTYPE, col=heat.colors(10, alpha = 1), ylab=" Cost of Property Damage($ billions)", main="Top 10 Events Causing Highest Property Damage")
barplot((cropdmg10$CROPDMGVAL)/(1*10^9), names.arg=cropdmg10$EVTYPE, col=terrain.colors(10, alpha = 1),  ylab=" Cost of Crop Damage($ billions)", main="Top 10 Events Causing Highest Crop Damage")
