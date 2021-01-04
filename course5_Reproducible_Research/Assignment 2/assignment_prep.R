
setwd("C:\\Users\\Sara\\Desktop\\Sara\\5_Reproducible Research\\PA_2")

##assignment<-read.csv("repdata-data-StormData.csv.bz2")


##assignment<-read.table(bzfile("repdata-data-StormData.csv.bz2"))   

assignment<-read.csv(bzfile("repdata-data-StormData.csv.bz2"), header=TRUE, stringsAsFactors=FALSE)   

x<-grep("SUMMARY",assignment$EVTYPE, ignore.case=TRUE)

#selecting columns

variables<-c("EVTYPE","FATALITIES","INJURIES","PROPDMG", "PROPDMGEXP","CROPDMG","CROPDMGEXP")

data<-assignment[variables]

#####Events most harmful to human population

#aggregate data by event

fatal <- aggregate(FATALITIES ~ EVTYPE, data = data, FUN = sum)
fatal <- fatal[order(-fatal$FATALITIES),][1:10, ]
injury <- aggregate(INJURIES ~ EVTYPE, data = data, FUN = sum)
injury <- injury[order(-injury$INJURIES),][1:10, ]



par(mfrow = c(1, 2), mar = c(12, 4, 3, 2), mgp = c(3, 1, 0), las=3,cex = 0.8)
barplot(fatal$FATALITIES, names.arg=fatal$EVTYPE, ylim= c(0,7000),col=rainbow(10))
barplot(injury$INJURIES, names.arg=injury$EVTYPE,ylim= c(0,10000), col=rainbow(10))


#################Question 2


unique(data$PROPDMGEXP)

data$PROPEXP[data$PROPDMGEXP ==  "K" 	]	<-	1000
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

par(mfrow = c(1, 2), mar = c(12, 4, 3, 2), mgp = c(3, 1, 0), las=3,cex = 0.8)

#par(mfrow = c(1, 1), las=3,cex = 0.8)
barplot((propdmg10$PROPDMGVAL)/(1*10^9), names.arg=propdmg10$EVTYPE, col=heat.colors(10, alpha = 1))
barplot((cropdmg10$CROPDMGVAL)/(1*10^9), names.arg=cropdmg10$EVTYPE, col=terrain.colors(10, alpha = 1))






##assignment<-read.table("repdata-data-StormData.csv.bz2") 
````````
install.packages("R.utils")
require("R.utils", warn.conflicts = F)

bunzip2("repdata-data-StormData.csv.bz2", remove = F, overwrite = T) 
data <- read.csv("repdata-data-StormData.csv", stringsAsFactors = FALSE)







#################################

names(data)

assignment$event_check<-assignment$EVTYPE
assignment$event_check<-toupper(assignment$EVTYPE)

table(assignment$event_check)

#data$EVTYPE<-toupper(data$EVTYPE)

check_summary<-grep("SUMMARY", assignment$event_check)
check_summary_2<-grep("SUMMARY", assignment$event_check, invert=TRUE)

data_final<-assignment[check_summary_2,]

table(data_final$event_check)

install.packages("dplyr")
library("dyplyr)
View(data_final %>% group_by(event_check) %>% summarise(n=n(), remarks=(REMARKS)))



AVALANCE

BLIZZARD AND EXTREME WIND CHIL  
BLIZZARD AND HEAVY SNOW	
BLIZZARD WEATHER	
BLIZZARD/FREEZING RAIN	
BLIZZARD/HEAVY SNOW	
BLIZZARD/HIGH WIND	
BLIZZARD/WINTER STORM



COASTAL  FLOODING/EROSION  1
47	COASTAL EROSION	1
48	COASTAL FLOOD	656
49	COASTAL FLOODING	183
50	COASTAL FLOODING/EROSION	5
53	COASTAL/TIDAL FLOOD	2
54	COASTALFLOOD	1
CSTL FLOODING/EROSION




grep("DEBRIS", data_final$event_check, value=TRUE)



grep("st", assignment$EVTYPE, value=TRUE)

assignment$event_check<-assignment$event_check

grep("ST", assignment$event_check, value=TRUE)

sub("TS", "thunderstorm", assignment$event_check)

