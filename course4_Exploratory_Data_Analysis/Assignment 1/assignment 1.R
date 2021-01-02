#"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
getwd()
setwd("C://Users//Sara//Desktop//Sara//4_Exploratory Data Analysis")


#ptm <- proc.time()

data_0<-read.table(".//household_power_consumption.txt", header=TRUE, sep=";")

#proc.time() - ptm

#ptm_3 <- proc.time()

#test_3<-read.csv(".//household_power_consumption.txt", header=TRUE, sep=";")
#proc.time() - ptm_3


data$DateTime <- as.POSIXct(paste(data_2$Date, data_2$Time), format="%d/%m/%Y %H:%M:%S") 


data<- data[ which(data_0$Date== "1/2/2007"| data_0$Date== "2/2/2007"),]


for (i in 3:9)  

  for(i in 3:9) {
    data_2[,i] <- as.numeric(as.character(data_2[,i]))
  }  
  

##PLOT_1
par(mfrow=c(1,1))

hist(data_2$Global_active_power, col="red",main="Global Active Power", xlab="Global Active Power")

#hist(as.numeric(as.character(data_2$Global_active_power)), col="red",main="Global Active Power", xlab="Global Active Power")
#title(main="Global Active Power")
dev.copy(png, file = "plot_1.png")  ## Copy my plot to a PNG file
dev.off() 


##PLOT_2

data_2$Dates_2 <- as.Date(data_2$Date, format="%d/%m/%Y")

data_2$weekdays<-weekdays(data_2$Dates_2)
table(test_2$weekdays)


plot(data_2$DateTime, data_2$Global_active_power, type="l",xlab="", ylab="Global Acitve Power")

#plot(data_2$DateTime, as.numeric(as.character(data_2$Global_active_power)), type="l",xlab="", ylab="Global Acitve Power")



##PLOT_3


plot(data_2$DateTime, data_2$Sub_metering_1, type = "l",xlab="DateTime", ylab="sub_metering", ylim = c(0, max(as.numeric(as.character(data_2$Sub_metering_1,data_2$Sub_metering_2,data_2$Sub_metering_3)))))  ## index plot with one variable
lines(data_2$DateTime,data_2$Sub_metering_2, type = "l", lty = 2, col = "red")  ## add another variable
lines(data_2$DateTime, data_2$Sub_metering_3), type = "l", lty = 2, col = "blue")  ## add another variable


#plot(data_2$DateTime, as.numeric(as.character(data_2$Sub_metering_1)), type = "l",xlab="DateTime", ylab="sub_metering", ylim = c(0, max(as.numeric(as.character(data_2$Sub_metering_1,data_2$Sub_metering_2,data_2$Sub_metering_3)))))  ## index plot with one variable
#lines(data_2$DateTime, as.numeric(as.character(data_2$Sub_metering_2)), type = "l", lty = 2, col = "red")  ## add another variable
#lines(data_2$DateTime, as.numeric(as.character(data_2$Sub_metering_3)), type = "l", lty = 2, col = "blue")  ## add another variable
title()



legend("topright", lwd = c(1,2,3), col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##PLOT_4

par(mfrow=c(2,2))
plot(data_2$DateTime, data_2$Global_active_power, type="l")

plot(data_2$DateTime, data_2$Voltage, type="l")

plot(data_2$DateTime, data_2$Sub_metering_1, type = "l", ylim = c(0, max(data_2$Sub_metering_1,data_2$Sub_metering_2,data_2$Sub_metering_3)))  ## index plot with one variable
lines(data_2$DateTime, data_2$Sub_metering_2, type = "l", lty = 2, col = "red")  ## add another variable
lines(data_2$DateTime, data_2$Sub_metering_3, type = "l", lty = 2, col = "blue")  ## add another variable

legend("topright", lwd = c(1,2,3), col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data_2$DateTime, data_2$Global_reactive_power, type="l")



##
#plot(test_2$DateTime, as.numeric(as.character(test_2$Global_active_power)), type="l")

#plot(test_2$DateTime, as.numeric(as.character(test_2$Voltage)), type="l")

#plot(test_2$DateTime, as.numeric(as.character(test_2$Sub_metering_1)), type = "l", ylim = c(0, max(as.numeric(as.character(test_2$Sub_metering_1,test_2$Sub_metering_2,test_2$Sub_metering_3)))))  ## index plot with one variable
#lines(test_2$DateTime, as.numeric(as.character(test_2$Sub_metering_2)), type = "l", lty = 2, col = "red")  ## add another variable
#lines(test_2$DateTime, as.numeric(as.character(test_2$Sub_metering_3)), type = "l", lty = 2, col = "blue")  ## add another variable

#legend("topright", lwd = c(1,2,3), col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot(test_2$DateTime, as.numeric(as.character(test_2$Global_reactive_power)), type="l")
