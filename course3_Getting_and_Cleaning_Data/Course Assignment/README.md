---
title: "README"
author: "Sara Rafi"
date: "Sunday, December 21, 2014"
output: html_document
---

##Introduction
This document briefly explains the cleaning process of the UCI HAR dataset, in order to meet the following requirements:  

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final data was prepared following the steps discussed.

###Step 1: Downloading Data

```
setwd("C://Users//Sara//Desktop//Sara")
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
download.file(fileUrl,dest=".//Course Assignment//dataset.zip") 
unzip (".//Course Assignment//dataset.zip",exdir = ".//Course Assignment")
setwd(".//Course Assignment")
```

This code downloads the zipped data folder folder and then uses the unzip to extract the data files. The working directory is then set to the directory that contains the UCI HAR dataset file.


###Step 2: Merging the Traning the Test datasets
Before merging the two datasets, it is helpful to assign variable names, subject_id and acitivity codes. Thus, this step is divided into further steps, these are:

1. Assigning varirable names to both datasets
2. Prepraing the individual Test and Train for merging
3. Merging/appending the two datasets

***Preparing variable names***

The list of variables is the list of features stores on the feature.txt file. Some minor changes are required to this list before they can be assigned as varibale names to the two datasets that have to be merged. The second and the third line of code in the box below removies"()", and replaces "-" with "_", respectively. The next step was to have names with all letters in lowercase. 


```
features_list<-read.table(".//UCI HAR Dataset//features.txt")

features_list$V2 <- sub("()","", features_list$V2, fixed = "TRUE")
features_list$V2 <- sub("-", "_",features_list$V2, fixed = "TRUE")
features_list$V2<-tolower(features_list$V2)

unique(features_list$V2)

features_list$V2<-make.unique(features_list$V2, sep="*")
```

Checking for unique features revealed that there were duplicates in the list of features. The features with duplicates were not required for the current assignment, hence these were not thoroughly analysed and made unique using make.unique.

***Preparing Test and Train data for Merge***

```
train_data<-read.table(".//UCI HAR Dataset//train//X_train.txt")
train_subject<-read.table(".//UCI HAR Dataset//train//subject_train.txt")
train_activity<-read.table(".//UCI HAR Dataset//train//Y_train.txt")
```
The code in the box above read the train data, the subject id and the activity number into R.

The next step was to add the variable names to the data, which had been prepared in the previous step. This was done by using colnames. 

The activity number and subject_id were also added to  by creation of new variables which were assigned values from the relevant dataframes.

```
colnames(train_data)<-features_list[,2]


train_data$activity<-train_activity$V1
train_data$subject_id<-train_subject$V1
```

The same steps were repeated for the test data.


***Merging/appending Data***

Merging the data required the installing of the plyr package. The merging was a one step appending of data using rbind. The idea was to the stack the data togther as both contain different obervations on the same variables.


```
library(plyr)

merged_data_1<-rbind(test_data,train_data)
```


###Step 3: Extracting mean and standard deviation variables

This step had to keep variables subject_id, activity and the mean and standard deviation features. A new dataframe "merged_data_2" was created which contained only the required variables. This was done by using grep to get the names of the variables for the new dataframe.

```
search_string <- "_mean|_std|subject_id|activity"
colnames <- names(merged_data_1)
colnames_to_keep <- grep(search_string, colnames, value = TRUE) 
merged_data_2 <- merged_data_1[colnames_to_keep]
```


###Step 4: Assigning activity labels

The activity labels were first uploaded as a sepearte data frame. This dataframe was assigned coloumn names. Then, a simple many-to-one merge by the activity code variable was carried out to include the activity names in the merged data for each observation. This step was concluded by setting the value of the activity variable to NULL, which deleted the variable from the dataframe.

```
activity_labels<-read.table(".//UCI HAR Dataset//activity_labels.txt")
dim(activity_labels)
colnames(activity_labels)<-c("activity", "activity_name")

#merging many to one

merged_data_3<-merge(merged_data_2, activity_labels, by="activity")


#deleting activity column

merged_data_3$activity<-NULL
```

###Step 5: Fixing varaible names


In the variable names the 't' was replaced with time and 'f' was replaced with freq. This was done using a for loop.


```
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
```

