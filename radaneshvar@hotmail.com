Coursera Data Science Course
Course 3: Getting and Cleaning Data Project
Ramin Daneshvar

Description
This is the project of the above mentioned course. The data are about ‘wearable computing’ and the dataset is obtained from UCI project on Samsung Galaxy S device. The data have been extracted from the accelerometers and gyroscopes of the device. The data set would be downloaded from the below link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The full description of the UCI study is available in following link:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



Data Set Information
According to the above mentioned descriptions, the study was done on 30 healthy volunteers in their 2nd to 5th decade of life. In each participants data were collected by Samsung Galaxy’s accelerometers and gyroscope during six daily activities: walking, climbing stairs (walking upstairs), going stairs down (waking downstairs), sitting, standing and lying. To improve signal to noise (SNR) ratio, the investigators used two sets of low-pass filters.

Attribute Information
Each record in the dataset provide the following informations:

	•	Triaxial acceleration from the accelerometer.
	•	Triaxial Angular velocity from the gyroscope.
	•	Time and frequency domain variables.
	•	Activity label.
	•	Subject identifier number.

Section 1. Merge the training and the test sets to create one data set.

Briefly, I first set a new working directory on the desktop of my computer and named it ‘Course3Project’. Then I downloaded the file into it and decompressed the file (Steps 1 & 2 in the script).
In the next step the data labels are read from the files into corresponding table (Step 3) and the labels corresponding to ‘mean’ and ‘standard deviation’ are selected by using the ‘grep’ function; their labels are concurrently corrected (Steps 3 & 4 in the script).
The data on training and testing of each subjects are the loaded in Step 5 and simultaneously, only variables related to mean and standard deviation of measurements are selected.
Merging of data are done in steps 5 and 6.


Section 2. Extract only the measurements on the mean and standard deviation for each measurement.
As mentioned above, this is done in step 4 and 5, along with reading data.

Section 3. Use descriptive activity names to name the activities in the data set
Activity labels (ActLabels) are extracted and assigned in Step 3.

Section 4. Appropriately label the data set with descriptive activity names.
Activity names are assigned to dataset in Steps 7 & 8.

Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
This is done in steps 10 & 11.


Variables
The following variables are present in the ‘TidyDataSet.txt’ file. The names are self-explanatory.

timeBodyAccelerometer - Along X, Y, and Z axes
timeGravityAccelerometer - Along X, Y, and Z axes
timeBodyAccelerometerJerk-Along X, Y, and Z axes
timeBodyGyroscope-Along X, Y, and Z axes
timeBodyGyroscopeJerk-Along X, Y, and Z axes
timeBodyAccelerometerMagnitude
timeGravityAccelerometerMagnitude
timeBodyAccelerometerJerkMagnitude
timeBodyGyroscopeMagnitude
timeBodyGyroscopeJerkMagnitude
frequencyBodyAccelerometer-Along X, Y, and Z axes
frequencyBodyAccelerometerJerk-Along X, Y, and Z axes
frequencyBodyGyroscope-Along X, Y, and Z axes
frequencyBodyAccelerometerMagnitude
frequencyBodyAccelerometerJerkMagnitude
frequencyBodyGyroscopeMagnitude
frequencyBodyGyroscopeJerkMagnitude
