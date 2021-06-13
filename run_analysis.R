### 1. Merge training and test sets

# As per instructions, assuming that Samsung data is in my working directory.
trainData <- read.table("UCI HAR Dataset/train/X_train.txt")
testData <- read.table("UCI HAR Dataset/test/X_test.txt")

# Also including data about training labels and experiment subjects
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt",)
trainLabels <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainData <- cbind(trainSubjects, trainLabels, trainData)

testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testLabels <- read.table("UCI HAR Dataset/test/Y_test.txt")
testData <- cbind(testSubjects, testLabels, testData)

# Merged training and test data sets
mergedData <- rbind(trainData, testData)

### 2. Extract measurements for the mean and standard deviation for each measurement

# Using "features.txt" file to determine which measurements correspond to mean and standard deviation
features <- read.table("UCI HAR Dataset/features.txt")
meanOrStdFeatures <- grep("mean\\(\\)|std\\(\\)", features[,2])

# Readjusting to account for the Subjects and Activity Labels columns in the merged data set
meanOrStdFeaturesUpdated <- append(1:2, meanOrStdFeatures + 2)

# Subset data set to get only required columns
mergedData <- mergedData[, meanOrStdFeaturesUpdated]

### 3. Use descriptive activity names

# Using "activity_labels.txt" to identify activity names
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")

for (i in 1:length(mergedData[,2]))
{
    element <-  mergedData[i, 2]
    for (j in activityLabels[,1])
    {
        if (element == j)
        {
            mergedData[i, 2] <- activityLabels[j, 2]
            break
        }
    }
}

### 4. Label data set with descriptive variable names

# Updating column names to "Subject", "Activity Label", and names from "features.txt"
meanOrStdFeaturesNames <- features[meanOrStdFeatures,2]
prospectColumnNames <- append(c("Subject", "Activity Label"), meanOrStdFeaturesNames)

colnames(mergedData) <- prospectColumnNames

### 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

# Convert activity and subject variables into factors
mergedData$Subject <- as.factor(mergedData$Subject)
mergedData$`Activity Label` <- as.factor(mergedData$`Activity Label`)

# Aggregate by activity and subject to calculate means of each variable
averageMergedData <- aggregate(. ~Subject + `Activity Label`, mergedData, mean)
write.table(averageMergedData, "stepFiveData.txt" , row.name=FALSE)

