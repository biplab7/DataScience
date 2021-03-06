#Problem Statement
#1. You should create one R script called run_analysis.R that does the following. 
#2. Merges the training and the test sets to create one data set.
#3. Extracts only the measurements on the mean and standard deviation for each measurement. 
#4. Uses descriptive activity names to name the activities in the data set
#5. Appropriately labels the data set with descriptive variable names. 
#6. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# First Get the Data from the URL and unzip it
filepath<-"/Users/Rev/Dev/R/Coursera/CleaningData/CourseProject"
setwd(filepath)
if(!file.exists("./inpdata")) {dir.create("./inpdata")}
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="./inpdata/data.zip",method="curl")
unzip(zipfile="./inpdata/data.zip",exdir="./inpdata")

setwd("/Users/Rev/Dev/R/Coursera/CleaningData/CourseProject/inpdata/UCI HAR Dataset")

## Read all the data

test.labels <- read.table("test/y_test.txt", col.names="label")
test.subjects <- read.table("test/subject_test.txt", col.names="subject")
test.data <- read.table("test/X_test.txt")
train.labels <- read.table("train/y_train.txt", col.names="label")
train.subjects <- read.table("train/subject_train.txt", col.names="subject")
train.data <- read.table("train/X_train.txt")

# Merge the training and test resultsets
data <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))

## Extracts only the measurements on the mean and standard deviation for each measurement.
# read the features
features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]

# select only the means and standard deviations from data
# incrementing by 2 because data has subjects and labels in the beginning
data.mean.std <- data[, c(1, 2, features.mean.std$V1+2)]

## step 3
# read the labels (activities)
labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
# replace labels in data with label names
data.mean.std$label <- labels[data.mean.std$label, 2]

## step 4
# first make a list of the current column names and feature names
good.colnames <- c("subject", "label", features.mean.std$V2)
# then tidy that list
# by removing every non-alphabetic character and converting to lowercase
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))
# then use the list as column names for data
colnames(data.mean.std) <- good.colnames

## step 5
# find the mean for each combination of subject and label
aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],
                       by=list(subject = data.mean.std$subject, 
                               label = data.mean.std$label),
                       mean)

## step nothing
# write the data for course upload
write.table(format(aggr.data, scientific=T), "tidy.txt",
            row.names=F, col.names=F, quote=2)
