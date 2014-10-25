This is the CodeBook for the Getting and Cleaning Data Course project.

**Data**
---
The data was obtained [here.]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 

Description of the data can be found at the [UCI Machine Learning Repository.]
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Data was downloaded and unziped into the directory "UCI HAR Dataset."  Details of data collection and initial processing are available either through the url above or located in the *README.txt* and *features_info.txt* files in the "UCI HAR Dataset directory.
  
**Data Processing**
---
  
Data processing with the *run_analysis.r* script did the following steps:

1) Check that the "UCI HAR Dataset" directory is in the working directory and then change into the "UCI HAR Dataset" directory.  
    
2) Read in training *(train/X_train.txt)* and then test *(test/X_test.txt)* processed data sets without ids or activity data.  Script does not read in raw data as it's not used in the script.  Combine the test and training sets using *rbind*.  
 (Instruction step 1)
  
3) Read in column names located in *features.txt*. Use subsetting and *gsub* command to make column names more descriptive and Human readable. (Instruction Step 4)  I used *gsub* to do the following: 
*   Change all occurances of mean and std to the same format and expand std to StandardDeviation
*   Remove () and - for easier column selection in R
*   Expand t to Time and F to Frequency 
*   Replace Acc with Acceleration, Gyro with AngularVelocity, Mag with Magnitude
*   Replace - with 'In'
*   Adjust remaining names to CamelCase for better Human readability without spaces
*   Replace (angles, gravity) etc. with _angles.gravity_ for easier column selection 

4) Change column names of data set to match column names derived from *features.txt*. (Instruction Step 4)
        
5) Create an index of all columns that have mean or standard deviation in their name using *grep*. I found all instances of mean or standard deviation. I am not familar with this type of data, so I kept all columns that had mean or standard deviation.  I then subsetted the data based on the index I just created. (Instruction Step 2)                    
  
6) Read in the activity labels *activity_labels.txt* and convert labels to lower case. (Instruction Step 3) 
      
7) Read in participant's activity codes and combine training *(train/y_train.txt)* and test *(test setstest/y_test.txt)* sets. Use the same order as before in *rbind* command so data stays in same order (train then test).  Use subsetting to convert integer activity type to text version.  Name column ActivityType. (Instruction Step 1 and Step 3)

8) Read in Subject ID and combine training *(train/subject_train.txt)* and test *(test/subject_test.txt)* sets using *rbind* then name column SubjectID. Maintain training and test sets in the same order when combining data as previously. (Instruction Step 1)

9) Use *cbind* to add SubjectID and ActivityType columns to data set in Step 2.
Now, I have a tidy, descriptively named, complete data set with mean and standard deviation variables along with "SubjectID", and "ActivityType". (Instruction Step 1)

10) Generate new table containing means of each column by "SubjectID" and by "ActivityType"  This step used chaining and dplyr to group the data by SubjectId and by ActivityType and then calculated the mean of each column. (Instruction Step 5)
      
11) Write out table to *GettingandCleaningData.txt* in "UCI HAR Dataset" directory.          
Table can be read with 'read.table("GettingandCleaningData.txt", header = TRUE)'


**Variable Names in Tidy Data Set**
----

Variables 3-88 were calculated as means by SubjectId and ActivityType

I expanded the abbreviations of the variable names and used CamelCase to help Human readabilty since we can't use spaces in variable names.  I swapped underscores for parentheses as R can recognize underscores even if they are not preferred in variable names.  I swapped commas to periods, as well.  The *README.txt* described the raw data units as either standard gravity units,'g', or radians/sec for angular velocity and the processed data as normalized and bounded [-1 to 1].  Additional details about the variables and how the measurments were transformed from the raw data can be found in the initial *features_info.txt* included in the "UCI HAR Dataset." 


1 SubjectID  
  numeric Id for Subject range 1-30
  
2 ActivityType  
  description of activity - laying, sitting, standing, walking, 
  walking_downstairs, walking_upstairs
  
3 TimeBodyLinearAccelerationMeaninX   
  mean of tBodyAcc-mean()-X (original name) 
  
4 TimeBodyLinearAccelerationMeaninY  
  mean of tBodyAcc-mean()-Y (original name) 
  
5 TimeBodyLinearAccelerationMeaninZ  
  mean of tBodyAccMean-Z (original name) 
  
6 TimeBodyLinearAccelerationStandardDeviationinX   
  mean of tBodyAcc-std()-X (original name) 

7 TimeBodyLinearAccelerationStandardDeviationinY  
  mean of tBodyAcc-std()-Y (original name) 
  
8 TimeBodyLinearAccelerationStandardDeviationinZ  
  mean of tBodyAcc-std()-Z (original name) 
  
9 TimeGravityLinearAccelerationMeaninX  
  mean of tGravityAcc-mean()-X (original name) 
  
10 TimeGravityLinearAccelerationMeaninY  
   mean of tGravityAcc-mean()-Y (original name) 
   
11 TimeGravityLinearAccelerationMeaninZ  
   mean of tGravityAcc-mean()-Z (original name) 
   
12 TimeGravityLinearAccelerationStandardDeviationinX   
   mean of tGravityAcc-std()-X (original name) 
   
13 TimeGravityLinearAccelerationStandardDeviationinY   
   mean of tGravityAcc-std()-Y (original name) 
   
14 TimeGravityLinearAccelerationStandardDeviationinZ  
   mean of tGravityAcc-std()-Z (original name) 
   
15 TimeBodyLinearAccelerationJerkMeaninX   
   mean of tBodyAccJerk-mean()-X (original name) 
   
16 TimeBodyLinearAccelerationJerkMeaninY  
   mean of tBodyAccJerk-mean()-Y (original name) 
   
17 TimeBodyLinearAccelerationJerkMeaninZ  
   mean of tBodyAccJerk-mean()-Z (original name) 
   
18 TimeBodyLinearAccelerationJerkStandardDeviationinX   
   mean of tBodyAccJerk-std()-X (original name) 
   
19 TimeBodyLinearAccelerationJerkStandardDeviationinY   
   mean of tBodyAccJerk-std()-Y (original name) 
   
20 TimeBodyLinearAccelerationJerkStandardDeviationinZ   
   mean of tBodyAccJerk-std()-Z (original name) 
   
21 TimeBodyAngularVelocityMeaninX   
   mean of tBodyGyro-mean()-X (original name) 
   
22 TimeBodyAngularVelocityMeaninY  
   mean of tBodyGyro-mean()-Y (original name) 
   
23 TimeBodyAngularVelocityMeaninZ  
   mean of tBodyGyro-mean()-Z (original name) 
   
24 TimeBodyAngularVelocityStandardDeviationinX    
   mean of tBodyGyro-std()-X (original name) 
   
25 TimeBodyAngularVelocityStandardDeviationinY   
   mean of tBodyGyro-std()-Y (original name) 
   
26 TimeBodyAngularVelocityStandardDeviationinZ  
   mean of tBodyGyro-std()-Z (original name) 
   
27 TimeBodyAngularVelocityJerkMeaninX  
   mean of tbodyGyroJerk-mean()-X (original name) 
   
28 TimeBodyAngularVelocityJerkMeaninY  
   mean of tbodyGyroJerk-mean()-Y (original name) 
   
29 TimeBodyAngularVelocityJerkMeaninZ   
   mean of tbodyGyroJerk-mean()-Z (original name) 
   
30 TimeBodyAngularVelocityJerkStandardDeviationinX   
   mean of tbodyGyroJerk-std()-X (original name) 
   
31 TimeBodyAngularVelocityJerkStandardDeviationinY   
   mean of tbodyGyroJerk-std()-Y (original name) 
   
32 TimeBodyAngularVelocityJerkStandardDeviationinZ   
   mean of tbodyGyroJerk-std()-Z (original name) 
   
33 TimeBodyLinearAccelerationMagnitudeMean   
   mean of tBodyAccMag-mean() (originial name) 
   
34 TimeBodyLinearAccelerationMagnitudeStandardDeviation    
   mean of tBodyAccMag-std() (originial name) 
   
35 TimeGravityLinearAccelerationMagnitudeMean   
   mean of tGravityAccMag-mean() (original name) 
   
36 TimeGravityLinearAccelerationMagnitudeStandardDeviation   
   mean of tGravityAccMag-std() (original name) 
   
37 TimeBodyLinearAccelerationJerkMagnitudeMean  
   mean of tBodyAccJerMag-mean() (original name) 
   
38 TimeBodyLinearAccelerationJerkMagnitudeStandardDeviation   
   mean of tBodyAccJerMag-std() (original name) 
   
39 TimeBodyAngularVelocityMagnitudeMean      
   mean of tBodyGyroMag-mean() (original name) 
   
40 TimeBodyAngularVelocityMagnitudeStandardDeviation     
   mean of tBodyGyroMag-std() (original name) 
   
41 TimeBodyAngularVelocityJerkMagnitudeMean   
   mean of tBodyGyroJerkMag-mean() (original name) 
   
42 TimeBodyAngularVelocityJerkMagnitudeStandardDeviation     
   mean of tBodyGyroJerkMag-std() (original name) 
   
43 FrequencyBodyLinearAccelerationMeaninX  
   mean of fBodyAcc-mean()-X (original name) 
   
44 FrequencyBodyLinearAccelerationMeaninY  
    mean of fBodyAcc-mean()-Y (original name) 
    
45 FrequencyBodyLinearAccelerationMeaninZ   
    mean of fBodyAcc-mean()-Z (original name) 
    
46 FrequencyBodyLinearAccelerationStandardDeviationinX    
    mean of fBodyAcc-std()-Z (original name)  
    
47 FrequencyBodyLinearAccelerationStandardDeviationinY   
    mean of fBodyAcc-std()-Y (original name) 
    
48 FrequencyBodyLinearAccelerationStandardDeviationinZ   
    mean of fBodyAcc-std()-z (original name) 
    
49 FrequencyBodyLinearAccelerationMeanFrequencyinX   
   mean of fBodyAcc-meanFreq()-X (original name) 

50 FrequencyBodyLinearAccelerationMeanFrequencyinY  
   mean of fBodyAcc-meanFreq()-Y (original name) 
   
51 FrequencyBodyLinearAccelerationMeanFrequencyinZ   
   mean of fBodyAcc-meanFreq()-Z (original name) 
   
52 FrequencyBodyLinearAccelerationJerkMeaninX  
   mean of fBodyAccJerk-mean()-X (original name) 
   
53 FrequencyBodyLinearAccelerationJerkMeaninY   
   mean of fBodyAccJerk-mean()-Y (original name) 
   
54 FrequencyBodyLinearAccelerationJerkMeaninZ   
   mean of fBodyAccJerk-mean()-Z (original name) 
   
55 FrequencyBodyLinearAccelerationJerkStandardDeviationinX   
   mean of fBodyAccJerk-std()-X (original name) 
   
56 FrequencyBodyLinearAccelerationJerkStandardDeviationinY   
   mean of fBodyAccJerk-std()-Y (original name) 
   
57 FrequencyBodyLinearAccelerationJerkStandardDeviationinZ  
   mean of fBodyAccJerk-std()-Z (original name) 
   
58 FrequencyBodyLinearAccelerationJerkMeanFrequencyinX   
   mean of fBodyAccJerk-meanFreq()-X (original name) 

59 FrequencyBodyLinearAccelerationJerkMeanFrequencyinY  
   mean of fBodyAccJerk-meanFreq()-Y (original name) 
   
60 FrequencyBodyLinearAccelerationJerkMeanFrequencyinZ   
   mean of fBodyAccJerk-meanFreq()-Z (original name) 
   
61 FrequencyBodyAngularVelocityMeaninX    
   mean of fBodyGyro-mean()-X (original name) 
   
62 FrequencyBodyAngularVelocityMeaninY  
   mean of fBodyGyro-mean()-Y (original name) 
   
63 FrequencyBodyAngularVelocityMeaninZ   
   mean of fBodyGyro-mean()-Z (original name) 
   
64 FrequencyBodyAngularVelocityStandardDeviationinX   
   mean of fBodyGyro-std()-X (original name) 
   
65 FrequencyBodyAngularVelocityStandardDeviationinY   
   mean of fBodyGyro-std()-Y (original name) 
   
66 FrequencyBodyAngularVelocityStandardDeviationinZ  
   mean of fBodyGyro-std()-Z (original name) 
   
67 FrequencyBodyAngularVelocityMeanFrequencyinX   
   mean of fBodyGyro-meanFreq()-X (original name) 
   
68 FrequencyBodyAngularVelocityMeanFrequencyinY   
   mean of fBodyGyro-meanFreq()-Y (original name) 
   
69 FrequencyBodyAngularVelocityMeanFrequencyinZ   
   mean of fBodyGyro-meanFreq()-Z (original name) 
   
70 FrequencyBodyLinearAccelerationMagnitudeMean    
   fBodyAccMag-mean() (original name) 
   
71 FrequencyBodyLinearAccelerationMagnitudeStandardDeviation  
   mean of fBodyAccMag-std() (original name) 
   
72 FrequencyBodyLinearAccelerationMagnitudeMeanFrequency     
 mean of fBodyAccMag-meanFreq() (original name) 
 
73 FrequencyBodyBodyLinearAccelerationJerkMagnitudeMean    
   mean of fBodyBodyAccJerkMag-mean() (original name) 
   
74 FrequencyBodyBodyLinearAccelerationJerkMagnitudeStandardDeviation   
   mean of fBodyBodyAccJerkMag-std() (original name) 
   
75 FrequencyBodyBodyLinearAccelerationJerkMagnitudeMeanFrequency   
   mean of fBodyBodyAccJerkMag-meanFreq() (original name)
    
76 FrequencyBodyBodyAngularVelocityMagnitudeMean                 
   mean of fBodyBodyGyroMag-mean() (original name) 
   
77 FrequencyBodyBodyAngularVelocityMagnitudeStandardDeviation     
   mean of fBodyBodyGyroMag-std() (original name) 
   
78 FrequencyBodyBodyAngularVelocityMagnitudeMeanFrequency        
   mean of fBodyBodyGyroMag-meanFreq() (original name) 
   
79 FrequencyBodyBodyAngularVelocityJerkMagnitudeMean           
   mean of fBodyBodyGyroJerkMag-mean() (original name) 
   
80 FrequencyBodyBodyAngularVelocityJerkMagnitudeStandardDeviation   
   mean of fBodyBodyGyroJerkMag-std() (original name) 
   
81 FrequencyBodyBodyAngularVelocityJerkMagnitudeMeanFrequency    
   mean of fBodyBodyGyroJerkMag-meanFreq() (original name) 
   
82 Angle_TimeBodyLinearAccelerationMean.Gravity_        
   mean of angle(tBodyAccMean,gravity) (original name) 
   
83 Angle_TimeBodyLinearAccelerationJerkMean_.GravityMean_  
   mean of angle(tBodyAccJerkMean),gravityMean) (original name) 
   
84 Angle_TimeBodyAngularVelocityMean.GravityMean_          
   mean of angle(tBodyGyroMean,gravityMean) (original name) 
   
85 Angle_TimeBodyAngularVelocityJerkMean.GravityMean_  
   mean of angle(tBodyGyroJerkMean,gravityMean) (original name) 
   
86 Angle_X.GravityMean_            
   mean of angle(X,gravityMean) (original name) 
   
87 Angle_Y.GravityMean_    
   mean of angle(Y,gravityMean) (original name) 
   
88 Angle_Z.GravityMean_   
   mean of angle(Z,gravityMean) (original name) 
   
