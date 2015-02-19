## The purpose of the script is to read the Samsung dataset, merge the two
## datasets training and test into one, extract variables describing means
## and standard deviations of measurements, add labels of activity and the
## number of volunteer performing activity during experiment and finally
## calculate averages of the means and standard deviations of the measurement
## for each activity and volunteer.

## The script contains three functions run_analysis(), test_train_mean_std
## and replace_labels. The run_analysis does the calculation of the averages
## of the numerical variables of the already merged dataset in step 4. 
## The test_train_mean_std does the steps 1-4, reads the data in and forms
## the merged dataset with variable names and adds extra variables describing
## the activity, the volunteer and the dataset the observation came from. The
## replace_labels function replaces the numbers describing the activity
## labels in the dataset with actual activities in character format



library(plyr)



## The run_analysis function does the final work of producing the averages
## for each activity and volunteer in the experiment of all the numerical
## variables in the data.frame formed in step 4. It takes no parameters in
## and returns the result as a data.frame adding to the numerical variable
## names avg- to describe that average of the variable is taken

run_analysis <- function() {
    ## Form merged test and training dataset
    
        test_train_means_stds <- test_train_mean_std()
    
    ## Calculate the averages of the numerical variables with respect to
    ## variables activity and volunteer
    
        avgs_test_train_means_stds <- ddply(test_train_means_stds,
                .(activity, volunteer), numcolwise(mean))
    
    ## Changing the variable names whose averages were calculated to
    ## avg-original name
    
        names <- colnames(avgs_test_train_means_stds)
    
        names <- names[3:81]
    
        for (i in seq_along(names)) {
            names[i] <- paste("avg-", names[i], sep="")
        }
    
        colnames(avgs_test_train_means_stds)[3:81] <- names
    
    ## Return the resulting data.frame
    
        avgs_test_train_means_stds
}





## test_train_mean_std function forms reads in the test and training 
## datasets and forms the merged dataset of variables that contain mean 
## or std in their names. It also adds 3 new variables: activity, volunteer 
## and dataset

test_train_mean_std <- function() {
    ## Read the datafiles into data.frames
    
        activities <- read.table(file="UCI HAR Dataset/activity_labels.txt",
                    stringsAsFactors=FALSE)
    
        features <- read.table(file="UCI HAR Dataset/features.txt",
                    stringsAsFactors=FALSE)
    
        test_label_nrs <- read.table(file="UCI HAR Dataset/test/y_test.txt",
                    stringsAsFactors=FALSE)
        
        train_label_nrs <- read.table(
            file="UCI HAR Dataset/train/y_train.txt", 
                    stringsAsFactors=FALSE)
    
        test_volunteers <- read.table(
            file="UCI HAR Dataset/test/subject_test.txt", 
                    stringsAsFactors=FALSE)
        
        train_volunteers <- read.table(
            file= "UCI HAR Dataset/train/subject_train.txt", 
                    stringsAsFactors=FALSE)
    
        test_data <- read.table(file="UCI HAR Dataset/test/X_test.txt",
                    stringsAsFactors=FALSE)
        
        train_data <- read.table(file="UCI HAR Dataset/train/X_train.txt",
                    stringsAsFactors=FALSE)
    
    ## Extract vectors from the first 6 data.frames, the test_data and
    ## train_data are not affected by this step
    
        activities <- activities[[2]]
    
        features <- features[[2]]
    
        test_label_nrs <- test_label_nrs[[1]]
    
        train_label_nrs <- train_label_nrs[[1]]
    
        test_volunteers <- test_volunteers[[1]]
    
        train_volunteers <- train_volunteers[[1]]
    
    ## Set the column names for the data
    
        colnames(test_data) <- features
        
        colnames(train_data) <- features
    
    ## Logic vector of variables that contain mean or std in their names
    
        logic <- grepl("mean", features) | grepl("std", features)
    
    ## Extract only the mean and std variables
    
        test_data <- test_data[, logic]
    
        train_data <- train_data[, logic]
    
    ## Replace the label numbers in the test_- and train_label_nrs with the
    ## corresponding activities
    
        test_labels <- replace_labels(test_label_nrs, activities)
    
        train_labels <- replace_labels(train_label_nrs, activities)
    
    ## Add activity column
    
        test_data$activity <- test_labels
        
        train_data$activity <- train_labels
    
    ## Add volunteer column
        
        test_data$volunteer <- test_volunteers
        
        train_data$volunteer <- train_volunteers
    
    ## Add column to which dataset test or training does the volunteer belong
    
        test_data$dataset <- rep("test", nrow(test_data))
    
        train_data$dataset <- rep("training", nrow(train_data))
    
    ## Forms the merged dataset of test and training datasets and returns it
    
        rbind(test_data, train_data)    
}



## The replace_labels function takes in the numbers used for labels and
## returns the actual activities given in character format at the same
## positions in the vector that was given in. The 2nd parameter is the
## vector containing the character labels for the numbers

replace_labels <- function(label_nrs, activity_labels) {
    ## Variable that will contain the final result
        final_labels <- NULL
    
    ## Replacement is done in a loop going through all the components of
    ## the input vector and matching it to the activity
    
        for (i in seq_along(label_nrs)) {
            number <- label_nrs[i]
        
            for (j in 1:6) {
                if (number==j) {
                    final_labels <- c(final_labels, activity_labels[j])
                }
            }
        }
    
    ## Return final result
    
        final_labels
}