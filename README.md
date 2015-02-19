# Getting and cleaning data course project

## Description

The repository contains an R script called run_analysis.R that will do the
analysis required for Coursera course Getting and Cleaning Data project
assignment. 

The purpose is to calculate the averages of all the observed means
and standard deviations for each activity and volunteer performing the 
activity of the variables in the data [1] that can be found in

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The following is from the website above: the data is collected from an
experiment that uses the embedded accelerometer and gyroscope of a
smartphone (Samsung Galaxy S II) to record 3-axial linear accelerations and 
3-axial angular velocities of the volunteers wearing the smartphone at their
waists while performing activities. The data is preprocessed by the 
researchers doing the experiments and they have randomly chosen 70% of the 
data into a training dataset and 30% of the data into a test dataset. More
information in the website above.

The processed data is used in the course project. The training and test data
are merged into one dataset. Only the data that is related to means or
standard deviations of the measurements are chosen for the analysis. the
variables had names in different files and they had to be connected to the
data. Further variables describing the activity and the volunteer were in
different files, too, so they were included into the dataset, too. Further
descriptions of the process can be found in CodeBook.md.



## Analysis with R

The analysis is made using an R script called run_analysis.R. The script 
contains three functions: run_analysis, test_train_mean_std and 
replace_labels. The test_train_mean_std reads in the datasets, merges the
test and training datasets, chooses the variables related means and standard
deviations of the measurements, includes the variable names and extra
variables describing the activity, the volunteer and the dataset the 
observation came from i.e. test or training dataset. It returns the result
as a data.frame. The replace_labels function is used in test_train_mean_std
to connect the activity names to the observations. It essentially returns
a character vector containing the activity names corresponding to the numeric
vector describing activities that the function takes as an input. The final
analysis of taking averages of the numerical variables produced by 
test_train_mean_std function is mady by run_analysis. It writes the results
into a text file and returns the tidy data set as a data.frame.

For running the script the working directory has to be set such that Samsung
dataset directory "UCI HAR Dataset" is in the same directory. Then all one has
to do is execute the commands

    source("run_analysis.R")

    avg_test_train_means_stds <- run_analysis()

and the tidy dataset is assigned to the data.frame named 

    avg_test_train_means_stds

but you can freely change this variable name into anything you like. The data
is written a file named

    "UCI_HAR_avgs_means_stds_tidy.txt"

The data can be read back into R by command

    read.table(file="UCI_HAR_avgs_means_stds_tidy.txt", header=TRUE, 
        check.names=FALSE)

The check.names=FALSE is included, since on testing the variable names changed
when reading the written data back into R without it. It might be due to
platform or other un-identified issues. The script was tested on platform 
x86_64-suse-linux-gnu (64-bit) with R version 3.1.2.



## References

[1]: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
