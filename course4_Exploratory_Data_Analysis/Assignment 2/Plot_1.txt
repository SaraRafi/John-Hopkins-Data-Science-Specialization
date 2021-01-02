

setwd("C:\\Users\\Sara\\Desktop\\Sara\\4_Exploratory Data Analysis\\Assignment 2")


#Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total 
#PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
#and 2008.

NEI <- readRDS("summarySCC_PM25.rds")


NEI$fips<-NULL  #setting variables to NULL to reduce memory space being used
NEI$SCC<-NULL
NEI$Pollutant<-NULL
NEI$type<-NULL

##Using aggreagtes to get total emissions for each year
NEI_sum<-aggregate(list(Emissions=NEI$Emissions), by=list(year=NEI$year),  FUN=sum)

##Emission values
NEI_sum$Emissions_2<-(NEI_sum$Emissions/1000)

#plot
png('plot_1.png')
barplot(NEI_sum$Emissions_2, names.arg=NEI_sum$year,col="red",main="Total PM2.5 Emissions", xlab="Year", ylab="Emissions (1000 tons)")
dev.off()