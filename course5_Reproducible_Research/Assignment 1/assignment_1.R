
getwd()
setwd ("C://Users//Sara//Desktop//Sara")
#dir.create("5_Reproducible Research")

unzip ("C://Users//Sara//Downloads//repdata-data-activity.zip", exdir="C://Users//Sara//Desktop//Sara//5_Reproducible Research")


###############################################################################
#################################################################################
##########################  PART 1: Loading data ############################################


setwd ("C://Users//Sara//Desktop//Sara//5_Reproducible Research")

assignment<-read.csv("activity.csv")



###############################################################################
#################################################################################
##########################  PART 2:Total steps ############################################

###What is mean total number of steps taken per day?

#1.For this part of the assignment, you can ignore the missing values in the 
# dataset.

#Calculate the total number of steps taken per day

steps_total<-aggregate(list(steps_total=assignment$steps), by=list(date=assignment$date),  FUN=sum, na.rm=TRUE)


#If you do not understand the difference between a histogram and a barplot, 
#research the difference between them. 
#Make a histogram of the total number of steps taken each day

hist(steps_total$steps, col="light blue" ,main= "Total number of steps per day", xlab="Number of Steps")

#Calculate and report the mean and median of the total number of steps 
#taken per day
mean(steps_total$steps)
median(steps_total$steps)


#steps_mean<-aggregate(list(steps_mean=assignment$steps), by=list(date=assignment$date),  FUN=mean, na.rm=TRUE)

#steps_median<-aggregate(list(steps_median=assignment$steps), by=list(date=assignment$date),  FUN=median, na.rm=TRUE)

###############################################################################
#################################################################################
##########################  PART 3: Average daily activity ############################################

#1.Make a time series plot (i.e. type = "l") of the 5-minute interval (x-axis) 
#and the average number of steps taken, averaged across all days (y-axis)

steps_mean_interval<-aggregate(list(steps_mean=assignment$steps), by=list(interval=assignment$interval),  FUN=mean, na.rm=TRUE)


plot(steps_mean_interval$interval, steps_mean_interval$steps_mean, type="l",lwd=5, col="green", xlab="5 mins interval", ylab="Average steps" ,main="Average Daily Activity")


#2.Which 5-minute interval, on average across all the days in the dataset, 
#contains the maximum number of steps?

max(steps_mean_interval$steps_mean)
max_row<-which.max(steps_mean_interval$steps_mean)
steps_mean_interval[max_row, "interval"]



###############################################################################
#################################################################################
##########################  PART 3 ############################################


# 1.Calculate and report the total number of missing values in the 
#dataset (i.e. the total number of rows with NAs)

sum(is.na(assignment))


#2.Devise a strategy for filling in all of the missing values 
# in the dataset. The strategy does not need to be sophisticated. 
#For example, you could use the mean/median for that day, or the mean 
#for that 5-minute interval, etc.





j=0
for (i in 1:200) {
j= j+1 
}

new_data<-assignment

for (row in 1:nrow(assignment)) 
{
  step= new_data[row, "steps"]
  
  if (is.na(step))
  {
    step_interval=new_data[row, "interval"]
    mean_row<-which(steps_mean_interval$interval== step_interval)
    mean_value<- steps_mean_interval[mean_row, "steps_mean"]
      
    if (is.nan(mean_value))
    {
      print("Error Invalid Mean ")
    } 
    else
    {
      new_data[row,"steps"]= mean_value
            
    }
  }
}




for (row in 1:nrow(assignment)) 
{
step= assignment[row, "steps"]

if (is.na(step))
{
step_date=assignment[row, "date"]
mean_row<-which(steps_mean$date == step_date)
mean_value<- steps_mean[mean_row, "steps_mean"]
if (is.nan(mean_value))
{
  print("Error Invalid Mean ")
} else
{
 new_data<-assignment
  new_data[row,"steps"]= mean_value
  
}
}
}

#3.Create a new dataset that is equal to the original dataset but with 
#the missing data filled in.

#4.Make a histogram of the total number of steps taken each day and 
#Calculate and report the mean and median total number of steps 
#taken per day. Do these values differ from the estimates from the 
#first part of the assignment? What is the impact of imputing missing 
#data on the estimates of the total daily number of steps?

#histogram

steps_total_nomissing<-aggregate(list(steps=new_data$steps), by=list(date=new_data$date),  FUN=sum, na.rm=TRUE)


hist(steps_total_nomissing$steps, col="orange", xlab="Total number of steps", main="Total number of steps per day with imputed missing values")

#mean per day
#steps_mean_nomissing<-aggregate(list(steps_mean=new_data$steps), by=list(date=new_data$date),  FUN=mean, na.rm=TRUE)
mean(steps_total_nomissing$steps)
median(steps_total_nomissing$steps)


#median per day


steps_median_nomissing<-aggregate(list(steps_median=new_data$steps), by=list(date=new_data$date),  FUN=median, na.rm=TRUE)
head(steps_mean_nomissing, 10)
head(steps_median_nomissing,10)



###############################################################################
#################################################################################
##########################  PART 4 ############################################

#1.Create a new factor variable in the dataset with two levels - "weekday" and 
#"weekend" indicating whether a given date is a weekday or weekend day.




#new_data$weekday<-weekdays(new_data$date_test)


install.packages("timeDate")
library("timeDate")

new_data$date_test<-as.Date(new_data$date)

  weekday_row=which(isWeekday(new_data$date_test, wday=1:5))
  weekend_row=which(isWeekend(new_data$date_test, wday=1:5))
  
  new_data$day=0
  new_data[weekday_row, "day"]=1 
  new_data[weekend_row, "day"]=2
  
  new_data$day <- factor(new_data$day,
                     levels = c(1,2),
                     labels = c("weekdays", "weekend"))
  
  
  
#2.Make a panel plot containing a time series plot (i.e. type = "l") of the 
#5-minute interval (x-axis) and the average number of steps taken, 
#averaged across all weekday days or weekend days (y-axis). 
#See the README file in the GitHub repository to see an example of what this 
#plot should look like using simulated data.


#steps_mean_interval_nomissing<-aggregate(list(steps_mean=new_data$steps), by=list((interval=new_data$interval)+ (Day=new_data$day)),  FUN=mean, subset= new_data$weekend_day,na.rm=TRUE)


steps_mean_interval_nomissing<-aggregate(steps ~ day+interval,data = new_data,FUN=mean) 

#library(ggplot)
#png('plot_6.png')
#ggplot(data=steps_mean_interval_nomissing,
#       aes(x=interval, y=steps, colour=weekend_day)) +
#  geom_line(size=2)+scale_x_continuous("Year") +
#  scale_y_continuous("Emissions(tons)") +
#  ggtitle("Motor Vehicle PM2.5 Emissions")
#dev.off()



library (lattice)
xyplot ( steps~ interval| day,  data=steps_mean_interval_nomissing, type="l", lwd="5",
        layout=c(1, 2), xlab="Interval", ylab="Average Steps")

install.packages("knitr")
library("knitr")

knit2html(input="PA1_template.Rmd", output="PA1_template.html")


markdownToHTML("PA1_template.Rmd", output="PA1_template.html") 
