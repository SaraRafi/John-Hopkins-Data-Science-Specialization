
setwd("C:\\Users\\Sara\\Desktop\\Sara\\4_Exploratory Data Analysis\\Assignment 2")

#Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources have 
#seen decreases in emissions from 1999-2008 for Baltimore City? 
#Which have seen increases in emissions from 1999-2008?
#Use the ggplot2 plotting system to make a plot answer this question.


NEI <- readRDS("summarySCC_PM25.rds")

NEI$fips<-NULL
NEI$SCC<-NULL
NEI$Pollutant<-NULL


##reshaping data to get sum of each type of emission for a year

library(reshape2)
id<-c("year","type")
melt_data <- melt(NEI,id=id)
final_data<- dcast(melt_data, year+type~ variable,sum)

##emission values
final_data$Emissions_2<-final_data$Emissions/1000

#plot
library(ggplot2)
png('plot_3.png')
x<-qplot(year,Emissions_2, data=final_data)
#y<-x + geom_point(aes(color = factor(type))) + scale_color_manual(values = c("orange","purple", "blue","red"))
x+geom_line(size = 2, aes(color = factor(type)))+scale_x_continuous("Year") +
  scale_y_continuous("Emissions(1000 tons)") +
  ggtitle("PM2.5 Emissions by Type of Source")
dev.off()

