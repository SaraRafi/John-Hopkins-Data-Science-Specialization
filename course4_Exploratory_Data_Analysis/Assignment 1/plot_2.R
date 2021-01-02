
setwd("C://Users//Sara//Desktop//Sara//4_Exploratory Data Analysis//ExData_Plotting1")

##Loading data
data_0<-read.table(".//Data//household_power_consumption.txt", header=TRUE, sep=";")
data<- data_0[ which(data_0$Date== "1/2/2007"| data_0$Date== "2/2/2007"),]


## converting class to numeric
for(i in 3:9) {
  data[,i] <- as.numeric(as.character(data[,i]))
}  

##creating date variable
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S") 

##plot

par(mfrow=c(1,1))

png(".//Assignment 1//plot_2.png")  
plot(data$DateTime, data$Global_active_power, type="l",xlab="", ylab="Global Acitve Power(kilowatts)")

dev.off() 
