#Getting and Cleaning Data - Course Project
###Tom McMurtrie

This repository is for the Getting and Cleaning Data Course Project.

##Overview
The run_analysis.R file does the following:
- 1.  Downloads the dataset to the user's machine (if necessary).
- 2.  Loads the required activity and feature information.
- 3.  Loads both the training and test datasets.
- 4.  Applies the activity names to both training and test datasets.
- 5.  Merges the training and test datsets into a combine dataset.
- 6.  Filters the combined dataset, keeping only those variables containing mean and standard devaiation values.
- 7.  Replaces the activity_IDs with the activity labels.  
- 8.  Refines the column names to provide clarity.
- 9.  Creates and outputs a tidy dataset which provides the average of each variable for each activity and each subject.  

The resulting tidy dataset is found in tidy.txt.

The resulting tidy dataset contains 68 variables (including the subject.ID and activity.type) and is found in tidy.txt.

Tidy data is described as:
- 1.  Each variable measured should be in one column.
- 2.  Each different observation of that variable should be in a different row.
- 3.  There should be one table for each "kind" of variable.
- 4.  If you have multiple tables, the should include a column in the table that allows them to be linked.

For the tidy.txt dataset, only the first two rules apply.  Each variable measured is in one column (tBodyAcc.Mean.X to cfBodyGyroJerkMag.Std).  Each different observation--in this case the means grouped by participant and activity--are in a different row.  


##Script instructions
If the user does not have the data downloaded to their desired working directory, the script will download the data, unzip it, and set the user's working directory.

If the user already has the data in their working directory, follow the in-script instructions to proceed past that code section.  

##Dataset Information
Additional information about the dataset, including the variable names, can be found in the CodeBook.MD file.  