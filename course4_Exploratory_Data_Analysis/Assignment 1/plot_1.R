

setwd("C://Users//Sara//Desktop//Sara//4_Exploratory Data Analysis")

##Loading data
data_0<-read.table(".//household_power_consumption.txt", header=TRUE, sep=";")
data<- data_0[ which(data_0$Date== "1/2/2007"| data_0$Date== "2/2/2007"),]


## converting class to numeric
for(i in 3:9) {
  data[,i] <- as.numeric(as.character(data[,i]))
}  

##histogram
par(mfrow=c(1,1))


png('plot_1.png')  
hist(data$Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power(kilowatts)")

dev.off() 



