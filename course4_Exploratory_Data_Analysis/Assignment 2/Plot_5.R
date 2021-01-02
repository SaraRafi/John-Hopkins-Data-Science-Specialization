
#How have emissions from motor vehicle sources changed from 
#1999-2008 in Baltimore City

SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

##selecting mototr vehicle cases
scc_motor <- SCC[grep("[Vv]ehic", SCC$EI.Sector), ]

##selecting cases from Baltimore
nei_motor <- NEI[NEI$fips ==  "24510", ]

##matching motorvehicle and Baltimore cases
nei_motor_2 <- nei_motor[nei_motor$SCC %in% scc_motor$SCC, ]

##using aggregate to get the sum of emissions
motor_baltimore<-aggregate(list(Emissions=nei_motor_2$Emissions), by=list(Year=nei_motor_2$year), FUN=sum)

##plot
png('plot_5.png')
plot(motor_baltimore$Year,motor_baltimore$Emissions,type="l", xlab="Year", ylab="Emissions(tons)", main="Emissions from Motor Vehicle Sources in Baltimore")
dev.off()



