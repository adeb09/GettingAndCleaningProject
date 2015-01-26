Description of the Data

The data used to create the tidyDataSet.txt from run_analysis.R was taken from the UCI Machine Learning Repository
website listed below. Most of the information in this code book is taken straight off of the text files given to us within the
zip archive that the data is downloaded within.

The data was gathered during experimentation from 30 subjects from a Samsung Galaxy S II smartphone. The data was captured by
the smartphone using its built in accelerometer and gyroscope recording 3-axial linear acceleration and 3-axial angular
velocity at a constant rate of 50HZ. A fixed-sliding window and Butterworth low-pass filter was applied to the signals.

Transformations applied to the Data

1) The data contained in a zip file 'data.zip' was first downloaded straight from run_analysis.R.
2) Files within that were actually relevant to creating a tidy data set were actually read into R using the read.table and unz
commands.
3) The proper variable names were set for each data frame using the features.txt information present in the zip file.
4) The grep function was used to find only measurements consistenting of mean and standard deviation values of activities.
5) meanFreq() was removed from the data frames because I did not consider this a mean or standard deviation of an activity.
6) The activities were then labeled properly in each data frame by creating a hash table (hash library) from the activityLabels.txt file.
7) cbind and rbind functions were used to gather all the data frames together to create one large data set.
8) The plyr library was used to create a tidy data set by grouping the data by SUbject and Activity and calculating the mean for every
variable type.
9) The final step was the use the write.table function to write out the tidy data set to a text file called tidyDataSet.txt.

The Variables

tBodyAcc-XYZ

tGravityAcc-XYZ

tBodyAccJerk-XYZ

tBodyGyro-XYZ

tBodyGyroJerk-XYZ

tBodyAccMag

tGravityAccMag

tBodyAccJerkMag

tBodyGyroMag

tBodyGyroJerkMag

fBodyAcc-XYZ

fBodyAccJerk-XYZ

fBodyGyro-XYZ

fBodyAccMag

fBodyAccJerkMag

fBodyGyroMag

fBodyGyroJerkMag

Note: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
Note the 'f' to indicate frequency domain signals

mean(): Mean value of the activity
std(): Standard Deviation of the activity

These variables came from the accelerometer and gyroscope on the smartphone. The were the variables measured for each activity.
Raw signals from the accelerated and gyroscope respectively were denoted tAcc-XYZ and tGyro-XYZ. FFT was also applied to this 
data. The signals produced from the FFT have an 'f' on the front instead of a 't' that's from the raw data.

For an example: fBodyAccJerk-mean()-Y would imply the mean of a body acceleration jerk in the frequency domain.