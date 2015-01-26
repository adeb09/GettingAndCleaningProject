library(hash)
library(plyr)

fileUrl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl, destfile='data.zip')

files = unzip(zipfile = 'data.zip', list = TRUE)$Name
files

activityLabels = read.table(unz('data.zip', files[1]))
features = read.table(unz('data.zip', files[2]))
subjectsTest = read.table(unz('data.zip', files[16]))
XTest = read.table(unz('data.zip', files[17]))
YTest = read.table(unz('data.zip', files[18]))
subjectsTrain = read.table(unz('data.zip', files[30]))
XTrain = read.table(unz('data.zip', files[31]))
YTrain = read.table(unz('data.zip', files[32]))

names(XTrain) = as.character(features$V2)
names(XTest) = as.character(features$V2)
names(YTrain) = 'Activity'
names(YTest) = 'Activity'
names(subjectsTest) = 'Subject'
names(subjectsTrain) = 'Subject'

subsetIndices = grep('mean()|std()', features$V2)
XTest = XTest[, subsetIndices]
XTrain = XTrain[, subsetIndices]

TestsubsetIndices = grep('meanFreq()', names(XTest), invert = TRUE)
TrainsubsetIndices = grep('meanFreq()', names(XTrain), invert = TRUE)
XTest = XTest[, TestsubsetIndices]
XTrain = XTrain[, TrainsubsetIndices]

h = hash(1:6, as.character(activityLabels$V2))

for(i in 1:length(YTest$Activity)){
        YTest$Activity[i] = h[[as.character(YTest$Activity[i])]]
}

for(i in 1:length(YTrain$Activity)){
        YTrain$Activity[i] = h[[as.character(YTrain$Activity[i])]]
}

Train = cbind(subjectsTrain, YTrain, XTrain)
Test = cbind(subjectsTest, YTest, XTest)

dataset = rbind(Train, Test)

tidyDataSet = ddply(dataset, .(Subject, Activity), numcolwise(mean))

write.table(tidyDataSet, file = 'tidyDataSet.txt', row.names = FALSE)