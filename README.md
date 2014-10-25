GettingandCleaningData
======================

Course Project for Getting and Cleaning Data from Coursera
  
  
The project's purpose was to show your ability to collect, work with and clean a data set, ie. a tidy data set that could be used for further analysis.

Data was found [here.]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
  
Description of initial processing can be found at [UCI Machine Learning Repository]
(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
  
The *run_analysis.r* script assumes that you have downloaded the above data into your working directory and now have a directory "UCI HAR Dataset" within your working directory.  The script will stop with an error message if you do not have the "UCI HAR Dataset"" in your working directory.  It will also stop if you have set your working directory to the "UCI HAR Dataset" directory.
  
The *run_analysis.r* script assumes you have the *data.tables, tidyr, dplyr and R.utils* packages installed and will load those librarys for you.
  
The *run_analysis.r* script will complete all the steps required in the course project webpage.  Instructions below are directly from [course project webpage descrition.](https://class.coursera.org/getdata-008/human_grading/view/courses/972586/assessments/3/submissions)
  
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for
    each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data 
    set with the average of each variable for each activity and each subject. 
    
The tidy data set is written out in the "UCI HAR Dataset" directory  as *GettingandCleaningData.txt*. 

Use **read.table("GettingandCleaningData.txt", header = TRUE)** to read the Tidy Data Table of means into R.
Additional details of the *run_analysis.r* script can be found in the *CodeBook.md*.



