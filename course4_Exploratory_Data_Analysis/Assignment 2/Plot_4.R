
#Across the United States, 
#how have emissions from coal combustion-related sources changed from 1999-2008?

setwd("C:\\Users\\Sara\\Desktop\\Sara\\4_Exploratory Data Analysis\\Assignment 2")


SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")


##selecting coal related cases
scc_coal <- SCC[grep("comb.+(coal|lignite)", SCC$Short.Name, ignore.case=TRUE), ]

##matching the cases to the nei data
nei_coal <- NEI[NEI$SCC %in% scc_coal$SCC, ]

##using aggregate to get the sum of emissions
emissions_coal<-aggregate(list(Emissions=nei_coal$Emissions), by=list(Year=nei_coal$year), FUN=sum)


#plot
png('plot_4.png')
plot(emissions_coal$Year, emissions_coal$Emissions, type="l", xlab="Year", ylab="Emissions(tons)", main=" Sum of Emissions from Coal Combustion-Related Sources")
dev.off()
