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
train_subj <- read.table("./train/subject_train.txt",sep="")
train_subj <- transform(train_subj, V1=paste("train",V1))
train <- cbind(train_subj,train_lbl,train)

test <- read.table("./test/X_test.txt",sep="")
test_lbl <- read.table("./test/y_test.txt",sep="")
test_subj <- read.table("./test/subject_test.txt",sep="")
test_subj <- transform(test_subj,V1=paste("test",V1))
test <- cbind(test_subj,test_lbl,test)

activity_lbl <-read.table("activity_labels.txt",sep="")
features <- read.table("features.txt",sep="")
features <- c("subject","label",as.character(features[,2]))

merge <- rbind(train,test)
colnames(merge) <- features

rm(list=c("test","test_lbl","test_subj","train","train_lbl","train_subj"))

## 2. Extract only the measurements on the mean and the 
## standard deviation for each measurement
cols <- grepl("*mean\\(\\)*|*std\\(\\)*|label|subject",features)
merge <- merge[,cols]

rm(list=c("cols","features"))

## 3. Use descriptive activity names to name the activities
## in the data set
colnames(activity_lbl) <- c("number","activity")
merge <- merge(merge,activity_lbl,by.x="label",by.y="number",all=FALSE)
ncols <- ncol(merge)
n_1 <- ncols -1
merge <- merge[,c(2,1,ncols,3:n_1)]
merge <- tbl_df(merge)
rm(list=c("activity_lbl","n_1","ncols"))
## 4. Appropriately label the data set with descriptive variable 
## names
colnames(merge) <- gsub("*-mean\\(\\)\\-*"," Mean ",colnames(merge))
colnames(merge) <- gsub("*-std\\(\\)\\-*", " SD ", colnames(merge))

## 5. Create second, independent tidy data set with the average 
## of each variable for each activity and each subject.

tidy <- merge %>% group_by(subject,activity) %>% summarise_each(funs(mean),-c(1:3))
tidy <- tbl_df(tidy)