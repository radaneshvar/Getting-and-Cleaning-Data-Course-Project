## ## ##  ** COURSERA - DataScience , Course 3, Week 4 Project **

## A. GETTING THE DATA

## 1. Setting project's working directory, source URL and file.

setwd("~/Desktop")
projecturl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
projectfile<-"galaxy.zip"

## 2. Checking if file already exists.
if(!file.exists("./Course3Project")){dir.create("./Course3Project")}
setwd("~/Desktop/Course3Project")

if (!file.exists(projectfile)){
        download.file(projecturl, destfile = projectfile, method="curl")
}
if (!file.exists("UCI HAR Dataset")) { 
        unzip(projectfile) 
}

## B. READING DATA INTO TABLES

## 3. Study informations: activity labels + features
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
actLabels[,2] <- as.character(actLabels[,2])
features[,2] <- as.character(features[,2])

## 4. Extract only the data on mean and standard deviation
selectedFeatures <- grep(".*mean.*|.*std.*", features[,2])
selectedFeatures.names <- features[selectedFeatures,2]
selectedFeatures.names = gsub("-mean", "Mean", selectedFeatures.names)
selectedFeatures.names = gsub("-std", "StandardDeviation", selectedFeatures.names)
selectedFeatures.names <- gsub("[-()]", "", selectedFeatures.names)


## 5. Loading study's data and extracting desired measurements

# 5-a.training (reading data on subjects, activity and selected trainig parameters and combining them)
training <- read.table("UCI HAR Dataset/train/X_train.txt", header = F)[selectedFeatures]
trainingActivities <- read.table("UCI HAR Dataset/train/Y_train.txt", header = F)
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = F)
training <- cbind(trainingSubjects, trainingActivities, training)

# 5-b.testing (reading data on subjects, activity and selected testing parameters and combining them)
testing <- read.table("UCI HAR Dataset/test/X_test.txt", header = F)[selectedFeatures]
testingActivities <- read.table("UCI HAR Dataset/test/Y_test.txt", header = F)
testingSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header = F)
testing <- cbind(testingSubjects, testingActivities, testing)

## 6. Merging datasets
studyData <- rbind(training, testing)

## 7.  Assigning labels
colnames(studyData) <- c("subject", "activity", selectedFeatures.names)

## 8.  Reconverting data to 'factor' form
studyData$activity <- factor(studyData$activity, levels = actLabels[,1], labels = actLabels[,2])
studyData$subject <- as.factor(studyData$subject)


## 9. Using 'RESHAPE2' package for Melting data, computing means
library(reshape2)
meltedStudyData <- melt(studyData, id = c("subject", "activity"))
meanStudyData <- dcast(meltedStudyData, subject + activity ~ variable, mean)

## 10. Labeling variables with descriptive names
names(meanStudyData)<-gsub("^t", "time", names(meanStudyData))
names(meanStudyData)<-gsub("^f", "frequency", names(meanStudyData))
names(meanStudyData)<-gsub("Acc", "Accelerometer", names(meanStudyData))
names(meanStudyData)<-gsub("Gyro", "Gyroscope", names(meanStudyData))
names(meanStudyData)<-gsub("Mag", "Magnitude", names(meanStudyData))
names(meanStudyData)<-gsub("BodyBody", "Body", names(meanStudyData))


## 11. Writting final table
write.table(meanStudyData, "TidyDataSet.txt", row.names = FALSE, quote = FALSE)

