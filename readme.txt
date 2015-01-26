README

This file shows the script from run_analysis.R but with comments explaining the program and logic behind each statement or block of code.

library(hash)
library(plyr)

#Downloading dataset
fileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl, destfile='data.zip')

#Loading accelerometer data into a data frame
files = unzip(zipfile = 'data.zip', list = TRUE)$Name

#display what files are in this zip file
files

#only reading in files that are relevant to the analysis
activityLabels = read.table(unz('data.zip', files[1]))
features = read.table(unz('data.zip', files[2]))
subjectsTest = read.table(unz('data.zip', files[16]))
XTest = read.table(unz('data.zip', files[17]))
YTest = read.table(unz('data.zip', files[18]))
subjectsTrain = read.table(unz('data.zip', files[30]))
XTrain = read.table(unz('data.zip', files[31]))
YTrain = read.table(unz('data.zip', files[32]))

#Set the proper variable names from the features data frame
names(XTrain) = as.character(features$V2)
names(XTest) = as.character(features$V2)
names(YTrain) = 'Activity'
names(YTest) = 'Activity'
names(subjectsTest) = 'Subject'
names(subjectsTrain) = 'Subject'

#This grep takes only mean and standard deviation of measurements
subsetIndices = grep('mean()|std()', features$V2)
XTest = XTest[, subsetIndices]
XTrain = XTrain[, subsetIndices]

#Remove meanFreq() measurements since they are not strictly mean or standard deviation measurements of the activities
TestsubsetIndices = grep('meanFreq()', names(XTest), invert = TRUE)
TrainsubsetIndices = grep('meanFreq()', names(XTrain), invert = TRUE)
XTest = XTest[, TestsubsetIndices]
XTrain = XTrain[, TrainsubsetIndices]

#Create a hash for activityLabels data frame
h = hash(1:6, as.character(activityLabels$V2))

#Label the Activities in the Activity column using the hash created before from the activityLabels data frame
for(i in 1:length(YTest$Activity)){
        YTest$Activity[i] = h[[as.character(YTest$Activity[i])]]
}

for(i in 1:length(YTrain$Activity)){
        YTrain$Activity[i] = h[[as.character(YTrain$Activity[i])]]
}

#Combine the columns to gather the Train and Test data frames
Train = cbind(subjectsTrain, YTrain, XTrain)
Test = cbind(subjectsTest, YTest, XTest)

#Combine the Train and Test sets to create one data set
dataset = rbind(Train, Test)

#Now use dplyr package to find the mean values of all measurements grouped by Subject and Activity
tidyDataSet = ddply(dataset, .(Subject, Activity), numcolwise(mean))

#Write the final, tidy data set to a text file
write.table(tidyDataSet, file = 'tidyDataSet.txt', row.names = FALSE)