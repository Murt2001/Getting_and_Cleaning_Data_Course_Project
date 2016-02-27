##Getting and Cleaning Data - Course Project
#Tom McMurtrie

This CodeBook is for the Getting and Cleaning Data Course Project.


#Study Design

This data was collected from experiments been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The following is provided for each record:
*- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
*- Triaxial Angular velocity from the gyroscope. 
*- A 561-feature vector with time and frequency domain variables. 
*- Its activity label. 
*- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

More information on this experiment and the source data can be found at:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


#Code Execution

This run_analysis.R executes the follow steps to create the tidy.txt dataset.

The run_analysis.R file does the following:
*1.  Downloads the dataset to the user's machine (if necessary).
*2.  Loads the required activity and feature information:
     *features.txt
     *activity_labels.txt.
*3.  Loads both the training and test datasets:
     *subject_train.txt
     *x_train.txt
     *y_train.txt
     *subject_test.txt
     *x_test.txt
     *y_text.txt
*4.  Applies the activity names to both training and test datasets.
*5.  Merges the training and test datsets into a combine dataset.
*6.  Filters the combined dataset, keeping only those variables containing mean and standard devaiation values.
*7.  Replaces the activity_IDs with the activity labels.  
*8.  Refines the column names to provide clarity.
*9.  Creates and outputs a tidy dataset which provides the average of each variable for each activity and each subject. This tidy.txt dataset is "wide" in that it mantains the 66 "mean" and "standard deviation" variables as columns and summarizes the mean on the subject.ID/activity.type groupings.   

The resulting tidy dataset contains 68 variables (including the subject.ID and activity.type) and is found in tidy.txt.

Tidy data is described as:
*1.  Each variable measured should be in one column.
*2.  Each different observation of that variable should be in a different row.
*3.  There should be one table for each "kind" of variable.
*4.  If you have multiple tables, the should include a column in the table that allows them to be linked.

For the tidy.txt dataset, only the first two rules apply.  Each variable measured is in one column (tBodyAcc.Mean.X to cfBodyGyroJerkMag.Std).  Each different observation--in this case the means grouped by participant and activity--are in a different row.  


#Variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the various measures for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

*tBodyAcc-XYZ
*tGravityAcc-XYZ
*tBodyAccJerk-XYZ
*tBodyGyro-XYZ
*tBodyGyroJerk-XYZ
*tBodyAccMag
*tGravityAccMag
*tBodyAccJerkMag
*tBodyGyroMag
*tBodyGyroJerkMag
*fBodyAcc-XYZ
*fBodyAccJerk-XYZ
*fBodyGyro-XYZ
*fBodyAccMag
*fBodyAccJerkMag
*fBodyGyroMag
*fBodyGyroJerkMag

*Variables are normalized and bounded within [-1,1].

The run_analysis.R uses the following variable naming convention to produce the tidy.txt tidy dataset described above:
*1.  Adopts the base of the variable name.
*2.  Applies the mean ("Mean") or standard deviation ("Std") identifier, depending on the measure.
*3.  Applies the directionality ("X", or "Y", or "Z"), where applicable.

For example, the mean of the tBodyAcc in the X direction is named tBodyAcc.Mean.X


#Identifier Variables
*subject.ID  (Factor variable (and primary key) from 1 to 30 indicating the participant)
*activity.type (Factor variable indicating the activity:  WALKING, WALKING_UPSTAIRS
, WALKING_DOWNSTAIRS, SITTING
, STANDING, LAYING)


#Variable Names  (see Variables section above for applicable units) 
*tBodyAcc.Mean.X      
*tBodyAcc.Mean.Y      
*tBodyAcc.Mean.Z      
*tBodyAcc.Std.X       
*tBodyAcc.Std.Y       
*tBodyAcc.Std.Z       
*tGravityAcc.Mean.X   
*tGravityAcc.Mean.Y   
*tGravityAcc.Mean.Z   
*tGravityAcc.Std.X    
*tGravityAcc.Std.Y    
*tGravityAcc.Std.Z    
*tBodyAccJerk.Mean.X  
*tBodyAccJerk.Mean.Y  
*tBodyAccJerk.Mean.Z  
*tBodyAccJerk.Std.X   
*tBodyAccJerk.Std.Y   
*tBodyAccJerk.Std.Z   
*tBodyGyro.Mean.X     
*tBodyGyro.Mean.Y     
*tBodyGyro.Mean.Z     
*tBodyGyro.Std.X      
*tBodyGyro.Std.Y      
*tBodyGyro.Std.Z      
*tBodyGyroJerk.Mean.X 
*tBodyGyroJerk.Mean.Y 
*tBodyGyroJerk.Mean.Z 
*tBodyGyroJerk.Std.X  
*tBodyGyroJerk.Std.Y  
*tBodyGyroJerk.Std.Z  
*tBodyAccMag.Mean     
*tBodyAccMag.Std      
*tGravityAccMag.Mean  
*tGravityAccMag.Std   
*tBodyAccJerkMag.Mean 
*tBodyAccJerkMag.Std  
*tBodyGyroMag.Mean    
*tBodyGyroMag.Std     
*tBodyGyroJerkMag.Mean
*tBodyGyroJerkMag.Std 
*fBodyAcc.Mean.X      
*fBodyAcc.Mean.Y      
*fBodyAcc.Mean.Z      
*fBodyAcc.Std.X       
*fBodyAcc.Std.Y       
*fBodyAcc.Std.Z       
*fBodyAccJerk.Mean.X  
*fBodyAccJerk.Mean.Y  
*fBodyAccJerk.Mean.Z  
*fBodyAccJerk.Std.X   
*fBodyAccJerk.Std.Y   
*fBodyAccJerk.Std.Z   
*fBodyGyro.Mean.X     
*fBodyGyro.Mean.Y     
*fBodyGyro.Mean.Z     
*fBodyGyro.Std.X      
*fBodyGyro.Std.Y      
*fBodyGyro.Std.Z      
*fBodyAccMag.Mean     
*fBodyAccMag.Std      
*fBodyAccJerkMag.Mean 
*fBodyAccJerkMag.Std  
*fBodyGyroMag.Mean    
*fBodyGyroMag.Std     
*fBodyGyroJerkMag.Mean
*cfBodyGyroJerkMag.Std