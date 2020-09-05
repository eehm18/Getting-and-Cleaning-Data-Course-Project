# Getting-and-Cleaning-Data-Course-Project

This repo explains how all of the scripts work and how they are connected.

The data set used for this project is the folder:

    "getdata_projectfiles_UCI HAR Dataset"

Files:

    CodeBook.md is a code that describes the variables, the data, and any transformations or work performed to clean up the data
    
    run_analysis.R is a code to crate a tidy data:
        -Merges the training and the test sets to create one data set.
        -Extracts only the measurements on the mean and standard deviation for each measurement.
        -Uses descriptive activity names to name the activities in the data set
        -Appropriately labels the data set with descriptive variable names.
        -From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
    4_TidyData.txt is the the dataset not grouped but with the approproatey labels
    
    5_TidyDataGroupAverage.txt is the the dataset with the average of each variable for each activity and each subject.