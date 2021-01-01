

#########Step 1: Downloading data
setwd("C://Users//Sara//Desktop//Sara")
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(fileUrl,dest=".//Course Assignment//dataset.zip") 
unzip (".//Course Assignment//dataset.zip",exdir = ".//Course Assignment")


setwd(".//Course Assignment")

#########Step 2: Merging the test and train datasets


###Preparing list of variables(List of Features)
features_list<-read.table(".//UCI HAR Dataset//features.txt")

features_list$V2 <- sub("()","", features_list$V2, fixed = "TRUE")
features_list$V2 <- sub("-", "_",features_list$V2, fixed = "TRUE")
features_list$V2<-tolower(features_list$V2)

unique(features_list$V2)

features_list$V2<-make.unique(features_list$V2, sep="*")

length(unique(features_list$V2))


###Preparing data for merge

#Training Dataset
train_data<-read.table(".//UCI HAR Dataset//train//X_train.txt")
train_subject<-read.table(".//UCI HAR Dataset//train//subject_train.txt")
train_activity<-read.table(".//UCI HAR Dataset//train//Y_train.txt")


colnames(train_data)<-features_list[,2]


train_data$activity<-train_activity$V1
train_data$subject_id<-train_subject$V1

#Test Dataset
test_data<-read.table(".//UCI HAR Dataset//test//X_test.txt")
test_subject<-read.table(".//UCI HAR Dataset//test//subject_test.txt")
test_activity<-read.table(".//UCI HAR Dataset//test//Y_test.txt")

colnames(test_data)<-features_list[,2]

test_data$activity<-test_activity$V1
test_data$subject_id<-test_subject$V1

length(intersect(names(train_data),names(test_data)))

###Merging Data

library(plyr)

merged_data_1<-rbind(test_data,train_data)

#########Step 3: Extracting mean and standard deviation variables

search_string <- "_mean|_std|subject_id|activity"
colnames <- names(merged_data_1)
colnames_to_keep <- grep(search_string, colnames, value = TRUE) 
merged_data_2 <- merged_data_1[colnames_to_keep]
names(merged_data_2)


#########Step 4: Assigning activity labels

activity_labels<-read.table(".//UCI HAR Dataset//activity_labels.txt")
dim(activity_labels)
colnames(activity_labels)<-c("activity", "activity_name")
names(activity_labels)
activity_labels

#merging many to one
merged_data_3<-merge(merged_data_2, activity_labels, by="activity")
names(merged_data_3)

#deleting activity column
merged_data_3$activity<-NULL

#########Step 5: Fixing varaible names
for (colname in names(merged_data_3))
{
  if (substr(colname, 1, 1) =='t')
  {
    colname2 <-substr(colname, 2, nchar(colname))
    colname2 <- paste("time_", colname2, sep ="")
    names(merged_data_3)[names(merged_data_3)==colname] <- colname2
  }
  else if (substr(colname, 1, 1) =='f')
  {
    colname2 <-substr(colname, 2, nchar(colname))
    colname2 <- paste("freq_", colname2, sep ="")
    names(merged_data_3)[names(merged_data_3)==colname] <- colname2
  }
}
names(merged_data_3)


#########Step 6: Extracting final dataset

library(reshape2)

id<-c("subject_id","activity_name")

##melting data to long format
melt_data <- melt(merged_data_3,id=id)

##casting data
final_data<- dcast(melt_data, subject_id+activity_name ~ variable,mean)

#########Step 7: Saving data as text file

write.table(final_data, file="C://Users//Sara//Desktop//Sara//Course Assignment//final_data.txt", row.names=FALSE )
write.table(final_data, file="C://Users//Sara//Desktop//Sara//Course Assignment//final_data.csv")

