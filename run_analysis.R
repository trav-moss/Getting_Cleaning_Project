## Download and unzip data
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL,"data.zip",method='curl')
unzip("data.zip")
rm("URL")
library(dplyr)
setwd("UCI HAR Dataset")
## 1. Merge training and test sets to create one set
train <- read.table("./train/X_train.txt",sep="")
train_lbl <- read.table("./train/y_train.txt",sep="")
train <- cbind(train_lbl,train)

test <- read.table("./test/X_test.txt",sep="")
test_lbl <- read.table("./test/y_test.txt",sep="")
test <- cbind(test_lbl,test)

activity_lbl <-read.table("activity_labels.txt",sep="")
features <- read.table("features.txt",sep="")
features <- c("labels",as.character(features[,2]))

merge <- rbind(train,test)
colnames(merge) <- features

rm(list=c("test","test_lbl","train","train_lbl"))

## 2. Extract only the measurements on the mean and the 
## standard deviation for each measurement
cols <- grepl("*mean()*|*std()*|labels",features)
merge <- merge[,cols]

rm(list=c("cols","features"))

## 3. Use descriptive activity names to name the activities
## in the data set
colnames(activity_lbl) <- c("number","activities")
merge <- merge(merge,activity_lbl,by.x="labels",by.y="number",all=FALSE)
merge <- merge[,c(81,1:80)]

## 4. Appropriately label the data set with descriptive variable 
## names


## 5. Create second, independent tidy data set with the average 
## of each variable for each activity and each subject.

