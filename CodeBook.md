# Code book

## Variable description

The final data.frame contains 81 variables, so that the columns describe
variables and the rows observations. The data is given in wide form. All the
variables except he first and the second variable come from the original
dataset by calculating averages over groups given by the first and the second
variable. Thus these two variables are new and named by myself. The rest of
the variables are named by using the original naming conventions of the 
dataset, as described in the file features_info.txt, and adding in the 
beginning a prefix avg- to note that an average is taken of the rest of the
variable.

The added variables are:

activity  
volunteer

The activity is what the volunteer, who was observed in the experiment, was
doing. There are 6 values for this variable: WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING.
                
The volunteer is the person doing the activity that is observed in the
experiment. In the dataset files they are also called subjects. There are 30
persons and the value is an integer number between 1 and 30.

The rest of the variables are from the experiment itself with the above 
mentioned prefix avg-:

avg-tBodyAcc-mean()std()-XYZ  
avg-tGravityAcc-mean()std()-XYZ  
avg-tBodyAccJerk-mean()std()-XYZ  
avg-tBodyGyro-mean()std()-XYZ  
avg-tBodyGyroJerk-mean()std()-XYZ  
avg-tBodyAccMag-mean()std()  
avg-tGravityAccMag-mean()std()  
avg-tBodyAccJerkMag-mean()std()  
avg-tBodyGyroMag-mean()std()  
avg-tBodyGyroJerkMag-mean()std()  
avg-fBodyAcc-mean()std()-XYZ  
avg-fBodyAccJerk-mean()std()-XYZ  
avg-fBodyGyro-mean()std()-XYZ  
avg-fBodyAccMag-mean()std()  
avg-fBodyAccJerkMag-mean()std()  
avg-fBodyGyroMag-mean()std()  
avg-fBodyGyroJerkMag-mean()std()  

The initial avg- means that an average of the variable is taken and only one
of X, Y or Z is taken to name, same with mean() and std(). The rest of
the name is provided by the dataset itself and the descriptions for that part 
come from the file features_info.txt of the dataset [1].

    The features selected for this database come from the accelerometer and 
    gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain 
    signals (prefix 't' to denote time) were captured at a constant rate of 50 
    Hz. Then they were filtered using a median filter and a 3rd order low pass 
    Butterworth filter with a corner frequency of 20 Hz to remove noise. 
    Similarly, the acceleration signal was then separated into body and 
    gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using 
    another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

    Subsequently, the body linear acceleration and angular velocity were 
    derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and 
    tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals 
    were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, 
    tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

    Finally a Fast Fourier Transform (FFT) was applied to some of these 
    signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, 
    fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate 
    frequency domain signals). 

    These signals were used to estimate variables of the feature vector for 
    each pattern:  
    '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

    The set of variables that were estimated from these signals are: 

    mean(): Mean value
    std(): Standard deviation

The averaged values are also bounded within [-1, 1], since the original
values were normalized within this interval according to README.txt of the 
dataset.


## Study design

The starting point is the data that is already processed as described in the 
files README.txt and features_info.txt of the dataset. From the dataset the
variables that are means and standard deviations of the measurements are
chosen. These are given by files: activity_labels.txt, features.txt, 
subject_test.txt, X_test.txt, y_test.txt, subject_train.txt, X_train.txt and
y_train.txt. The files features_info.txt and README.txt contain information
about the variable definitions, units and contents of the files. There are 
also directories with the name Inertial Signals that contain many more files
for both the test and training datasets. However, these directories were
deemed not to correspond to the data sought based on the information in the 
README.txt and features_info.txt. Besides their dimensions did not match with 
the other files. The actual numerical data on the observations is contained
in the files X_test.txt and X_train.txt, their variable names are in the 
filefeatures.txt, the information about the volunteer is contained 
subject_test.txt and subject_train.txt, the correspondence of activity 
numbers and labels is in the file activity_labels.txt and the information
about which activity was taken in the observation is in the files y_test.txt 
and y_train.txt.

The activity numbers are replaced with the corresponding labels by the 
replace_labels function. The information is used inside the 
test_train_means_stds function, which reads the files into data.frames
and extracts relevant parts of the data from the data.frames. The variable
names are added to the numerical data, the variables containing mean or std
in their name were chosen among the variables based on the files README.txt
and features_info.txt, the extra variables activity, volunteer and dataset
are added to the data.frames containing the numerical data before merging
test and training data.frames into one. The result is used in run_analysis 
function, which calculates the averages for the numerical variables for each
activity and volunteer, the dataset variable drops out at this stage, since
it is not a numerical variable. However, the volunteer numbers are split
according to which dataset they belong to, so the result would be the same
if the one instead took the averages with grouping of activity, volunteer and
dataset. This would just add one more variable into the final data.frame
telling into which dataset the volunteer belonged to. Now the information is
lost simply because it was not required in the assignment instructions. The
run_analysis function also adds a prefix avg- to the numerical variables to
emphasize the fact that averages of the corresponding variables have been
taken.



## References

[1]: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
