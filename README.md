==================================================================

Getting and Cleaning Data Course Project

==================================================================

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

==================================================================

R script called run_analysis.R performs the following modifications on the original data set: 

1. Merges the training and the test sets to create one data set.
 - The sets include all .txt files found in "test" and "train" folders of the original directory.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 - This is performed using the "features.txt" file to identify which variables represent mean and standard deviation.
3. Uses descriptive activity names to name the activities in the data set
 - For this step we use "activity_labels.txt" file to transform numeric identifier from the files of train and test sets into a string identifier.
4. Appropriately labels the data set with descriptive variable names. 
 - For this step we're using variable names from "features.txt" to name our columns. Subject and Activity Level columns were custom named.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.