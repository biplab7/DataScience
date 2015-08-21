# Getting and Cleaning Data

## Course Project

### Raw Data for the course
The data set for this project is available in the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Problem Statement
You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Solution
run_analysis.R file contains the code to achieve the problem statement.
In case it needs to be run on a different machine, the follwoing lines needs to be modified:
filepath<-"/Users/Rev/Dev/R/Coursera/CleaningData/CourseProject"
setwd("/Users/Rev/Dev/R/Coursera/CleaningData/CourseProject/inpdata/UCI HAR Dataset")
to the exact workig directory of the machine.

###Dependencies
There is no need to download data separately. Once the file path is set, the code will download the data from the required URL.
All the other dependencies will also be downloaded by the file automatically.



