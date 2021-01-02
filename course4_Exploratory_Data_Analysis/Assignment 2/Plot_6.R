
#Compare emissions from motor vehicle sources in Baltimore City with emissions 
#from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?


SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

##searching for motor vehicle cases
scc_motor <- SCC[grep("[Vv]ehic", SCC$EI.Sector), ]

##searching for Baltimore data
nei_motor_bal <- NEI[NEI$fips ==  "24510", ]     # this first, it's faster

##matching motor vehicles to Baltimore data
nei_motor_bal <- nei_motor_bal[nei_motor_bal$SCC %in% scc_motor$SCC, ]

##searching for Los Angeles data
nei_motor_la <- NEI[NEI$fips ==  "06037", ]     # this first, it's faster

##matching motor vehicles to Los Angeles data
nei_motor_la <- nei_motor_la[nei_motor_la$SCC %in% scc_motor$SCC, ]

##Total emissions in baltimore
emissions_bal<-aggregate(list(Emissions=nei_motor_bal$Emissions), by=list(Year=nei_motor_bal$year), FUN=sum)
emissions_bal$county<-"Baltimore"

##Total emissions in Los Angeles
emissions_la<-aggregate(list(Emissions=nei_motor_la$Emissions), by=list(Year=nei_motor_la$year), FUN=sum)
emissions_la$county<-"Los Angeles"


##combining Los Angeles and Baltimore data 
intersect(names(emissions_bal),names(emissions_la))
merged_data<-rbind(emissions_bal, emissions_la)

#plot
png('plot_6.png')
ggplot(data=merged_data,
       aes(x=Year, y=Emissions, colour=county)) +
  geom_line(size=2)+scale_x_continuous("Year") +
  scale_y_continuous("Emissions(tons)") +
  ggtitle("Motor Vehicle PM2.5 Emissions")
dev.off()

