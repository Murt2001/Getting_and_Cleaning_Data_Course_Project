# Tom McMurtrie
# run_analysis.R for Getting and Cleaning Data Course Project

# load required libraries
library(downloader)
library(dplyr)
###################################################################################################
#################If you already have the Samsung data in your working directory ###################
#################skip to next section break.                                    ###################
###################################################################################################

# Download and extract the .zip data.
# Set working directory to location you would like download and unzip the project data files.

# This assumes you do not have the dataset unzipped in your working directory.
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download(fileUrl, dest = "./project_data.zip", mode = "wb")

# Extract the data from the zip file.  
unzip("project_data.zip", exdir = "./project_data")
unzip ("dataset.zip", exdir = "./")

# Set working directory to unzipped files location.
setwd("./project_data/UCI HAR Dataset/")

###################################################################################################
###################################################################################################

# Read in the data from the training files.
features     <- read.table("./features.txt",header=FALSE) #imports features.txt
activity_labels <- read.table("./activity_labels.txt",header=FALSE) #imports activity_labels.txt
subject_train <- read.table("./train/subject_train.txt",header=FALSE) #imports subject_train.txt
x_train       <- read.table("./train/X_train.txt",header=FALSE) #imports X_train.txt
y_train       <- read.table("./train/y_train.txt",header=FALSE) #imports y_train.txt

# Convert "features" into syntactical row names (helps prevent future "duplicate column names" error)
col_names <- make.names(features[,2], unique = TRUE)

# Assigin column names to the data imported above.
colnames(activity_labels)  <- c('activity_ID','activity_type')
colnames(subject_train)  <- "subject_ID"
colnames(x_train)        <- col_names 
colnames(y_train)        <- "activity_ID"

# Merge subject_train, y_train, and x_train to create the combined training set.
tng_data <- cbind(subject_train, y_train, x_train)

# Read in the test data.
subject_test <- read.table("./test/subject_test.txt",header=FALSE) #imports subject_test.txt
x_test       <- read.table("./test/X_test.txt",header=FALSE) #imports X_test.txt
y_test       <- read.table("./test/y_test.txt",header=FALSE) #imports y_test.txt

# Assign column names to the test data imported above
colnames(subject_test) <- "subject_ID"
colnames(x_test)       <- col_names
colnames(y_test)       <- "activity_ID"

# Merge subject_test, y_test, and x_test to create the combined test set.
test_data <- cbind(subject_test, y_test, x_test)

# Merge the training (tng_data) and test (test_data) datasets using rbind
merged_data <- rbind(tng_data, test_data)

# Convert merged_data to tbl class to use dplyr functions
mergeddf <- tbl_df(merged_data)

# Keep only ID, activity ID, and columns who contain information on the mean or standard deviation
mean_sd <- mergeddf[,grep("mean()|std()|ID", names(mergeddf))]

# Remove meanFreq, since it is not a true mean (a weighted average of the frequency components)
mean_sd <- mean_sd[ , grep("Freq", names(mean_sd), invert = TRUE)]

# Add the activity_labels and rearrange after the left join so that subject_ID remains the first column.
w_activity <- left_join(activity_labels, mean_sd, by = "activity_ID")
rearranged <- w_activity[, c(3,2, 4:69)]

# Refine the column names to make them more readable
final_colnames <- colnames(rearranged)
final_colnames <- gsub("[.()]", "", final_colnames)
final_colnames <- gsub("mean", ".Mean", final_colnames)
final_colnames <- gsub("std", ".Std", final_colnames)
final_colnames <- gsub("BodyBody", "Body", final_colnames)
final_colnames <- gsub("_", ".", final_colnames)
final_colnames <- gsub("X", ".X", final_colnames)
final_colnames <- gsub("Y", ".Y", final_colnames)
final_colnames <- gsub("Z", ".Z", final_colnames)

colnames(rearranged) <- final_colnames

# Part 2:  Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.
part2 <- tbl_df(rearranged)
part2$subject.ID <- as.factor(part2$subject.ID)
tdata <- aggregate(part2[,3:length(part2)], by=part2[c("subject.ID","activity.type")], FUN=mean)
tdata <- arrange(tdata, subject.ID)

# Write the tidy dataset out to my working directory for inclusion to the quiz and github repository.
write.table(tdata, "tidy.txt", row.names = FALSE, quote = FALSE)
