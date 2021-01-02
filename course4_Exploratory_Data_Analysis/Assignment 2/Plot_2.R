#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
#(fips == "24510") from 1999 to 2008?
#Use the base plotting system to make a plot answering this question.

setwd("C:\\Users\\Sara\\Desktop\\Sara\\4_Exploratory Data Analysis\\Assignment 2")

NEI <- readRDS("summarySCC_PM25.rds")

NEI$SCC<-NULL
NEI$Pollutant<-NULL
NEI$type<-NULL
#subseting data for  baltimore
NEI_bal<-subset(NEI,fips == "24510")

#NEI$fips<-NULL


##Using aggreagtes to get total emissions for each year
NEI_sum_bal<-aggregate(list(Emissions=NEI_bal$Emissions), by=list(year=NEI_bal$year),  FUN=sum)


##plot
png('plot_2.png')
plot(NEI_sum_bal$year, NEI_sum_bal$Emissions, type="l", xlab="Year", ylab="Emissions(tons)" ,main="Total PM2.5 Emissions in Baltimore")
dev.off()


