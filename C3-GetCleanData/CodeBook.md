Code Book - Peer Assignment - Coursera Getting and Cleaning Data May 2014
========================================================

This codebook includes the description of the raw data, the variables and steps for transformating them into tidy data set for Human Activity Recognition Using Smartphones Dataset Version 1.0 (see [1]) as required by the Peer Assignment of Coursera's "Getting and Cleaning Data" May 2014. 

The description of the original experiment, how it has been carried out and how the raw data has been produced can be found on the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Summarizing briefly: the accelerometer and gyroscope data of a Samsung Galaxy S II smartphone was recorded while a person either was walking, walking upstairs, walking downstairs, sitting, standing or laying. The activities were video recorded in order to later on manually label data with the performed activities. Based on the raw data file [2] the assignment asks for: 

* merging the training and the test sets to create one data set.
* extracting only the measurements on the mean and standard deviation for each measurement. 
* using descriptive activity names to name the activities in the data set
* appropriately labeling the variables in the data set.
* creating a second, independent tidy data set with the average of each variable for each activity and each subject. 



The raw data
------------
The raw dataset is available at the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip). The zip folder contains two folders, one with the training data set and one for the test dataset; the train- and test data stem both from the original same experiment. The first step of the transformation is to (re-)unite those files into one dataframe. 

Giving a basic overview of the provide variables, it follows from the used sensors to distinguish between triaxial accelerometer data on the one hand and triaxial gyroscope data on the other. As the features_info.txt specifies, the logic of the variables is as follows: 

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. [...] acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) [...]. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals)."

All measurements of the variables have been normalized on a scale from -1 to 1. 
Units: Angular acceleration is given in radians. 



Data transformations
--------------------

### Step 1: Merging data files. 
As required all datafiles were merged into one dataframe. First, the training dataset was combined with training subject- (subject_train.txt) and training activity-file (y_train.txt) in order to produce an expanded dataframe containing two additional columns: first, the number indicating the relevant "subject" (person) carrying out the activities and second, a number corresponding to one of the six activities carried out. 

The data files contained inside the "Signals/" folder was ignored since it contains basically the raw sensor data already contained in preprocessed form in the training dataset. 

In addition, checks on NA rows has been carried out, but none found.

The exact same steps were carried out for the "test" dataset and files. 

The resulting train- and test- dataframe was then merged into one new dataframe called "df."


### Step 2: Selecting variables
The second step consists in selecting a subset of the 561 available variables for each measurement. 

First, the numeric variable names in the merged dataframe were replaced with the provided 561 variable names in the file "features.txt". 

Second, only columns containing "mean" and "std" (standard deviation) were selected according to the assignment requirements. This produces 79 variables which were furthermore reduced to contain only those time-based variables and not FFT variables - since the latter essentially duplicate the information already available in the time-based ones. Removing "f*" variables leaves a final dataset with 40 feature variables + 2 edited in variables (activity, subject).  


### Step 3: Naming activities
Subsequently, the numerically coded activities where converted into a factor in order to incorporate their direct descriptive lables. 


### Step 4: Renaming variables
Since the 561 variable names described in the features.txt file contain parenthesis "()" and "-" signs, the columns of the dataframe were renamed in order to prevent in subsequent operations R from misinterpreting these as mathematical symbols. The parenthesis were removed and the minus sign "-" replaced with "_" underscore. This produces a final set of 42 variables explained in what follows. 

**NOTE:** as long as not indicated otherwise, for each variable, there are two groups: first the "mean" data, and second, the "std" data. Each of those groups is in turn split into three variables holding the spatial axis measurements (X,Y,Z). This means, there are six sub-measurements for each of the following variables: 

* tBodyAcc: Numeric variable. Body acceleration only data
* tGravityAcc: Numeric variable. Gravity accceleration only data
* tBodyAccJerk: Numeric variable. Body acceleration Jerk data
* tBodyGyro: Numeric variable. Body angular velocity data
* tBodyGyroJerk: Numeric variable. Body angular velocity Jerk data

Furthmore the magnitude for each those variables was calculated: 

* tBodyAccMag: Numeric variable. body acceleration magnitude (mean/std)
* tGravityAccMag: Numeric variable. gravity acceleration magnitude (mean/std)
* tBodyAccJerkMag: Numeric variable. the magnitude of the body acceleration Jerk signal (mean/std)
* tBodyGyroMag: Numeric variable. the magnitude of the body angular velocity
* tBodyGyroJerkMag: Numeric variable. the magnitude of the body angular velocity Jerk signal (mean/std)

All these variables are numeric and normalized to a scale between -1 to 1. 

In addition the dateframe has two more variables: 
* activity: factor variable containing the six activity types. Values: (1-WALKING, 2-WALKING_UPSTAIRS, 3-WALKING_DOWNSTAIRS, 4-SITTING, 5-STANDING, 6-LAYING)
* subject: numeric variable identifying the subject who carried out the experiment. Values: 1...30.  


### Tidy dataset with average of each variable for each activity and each subject.  
Finally, a new dataframe was created that contains the mean of each of the 40 variables grouped by activity type and subject. There are 30 subjects on 6 activities, i.e. 180 calculations (the mean) for each of the 40 variables. 

The resulting dataframe has been saved as "dftidy.csv"


References
----------
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

[2] http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip




