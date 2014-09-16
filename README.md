Getting & Cleaning Data Course Project Read Me
========================
run_analysis.R is a script that does the following steps:

1. Merges the training and the test sets to create one data set.
    + downloads and unzips file from URL supplied in instruction
    + loads dplyr library
    + loads test and training sets from respective folders
    + loads subjects and activity labels as "row names" for measurement data
    + vertically merge test and training sets into large comnbinded dataset
    + assign column names based on features.txt file
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    + in addition to activity and subject labels, filter for only columns with either mean or standard deviation as instructed
3. Uses descriptive activity names to name the activities in the data set
    + get descriptions for activity lables from activity_labels.txt file
    + merge data frames on activity label numbers
    + rearrange columns to have descriptions near left side
4. Appropriately labels the data set with descriptive variable names.
    + change column names to remove messy characters and expand abbreviations
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    + summarize mean for each column grouped by subject and activity
    + write results to tidy.txt file