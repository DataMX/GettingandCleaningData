# Script assumes data.tables, tidyr, dplyr and R.utils packages are installed
library (data.table)
library (tidyr)
library (dplyr)
library (R.utils)

# Check to see if file already downloaded and in working directory
# If not, send error message
# Switch to UCI HAR Dataset director

if (!file.exists ("UCI HAR Dataset")) {
     stop ("Directory is missing. Check working directory") 
    }else {
          setwd ("UCI HAR Dataset")
#1      
          # Read in test and training data
          # Does not include raw data, only processed.
          data_train <- read.table ("train/X_train.txt") 
          data_test <- read.table("test/X_test.txt")
          # Combine data frames vertically and remove old data frames
          data_rbind <- rbind (data_train, data_test)
          rm(data_train)
          rm(data_test)    

#1 and 4 -Read in column names then make them more descriptive and Human readable
          column_names <- read.table ("features.txt", stringsAsFactors = FALSE)
          dim (column_names) # check numbers

          # Change all occurances of the word Mean or Standard deviation to the same format
          # Remove () and - for easier column selection in R
          column_names[,2] = gsub('-mean', 'Mean', column_names[,2])
          column_names[,2] = gsub('-std', 'Std', column_names[,2])
          column_names[,2] = gsub('Std', 'StandardDeviation', column_names[,2])
          column_names[,2] = gsub('\\(\\)', '', column_names[,2])

          # Expand t to Time and F to Frequency for better Human readability
          column_names[,2] = gsub('\\(tB', '(TimeB', column_names[,2])
          column_names[,2] = gsub('^t', 'Time', column_names[,2])
          column_names[,2] = gsub ('^f', 'Frequency', column_names[,2])

          # Replace Acc, Gyro, Mag, Freq with Acceleration, AngularVelocity, Magnitude & Frequency
          column_names[,2] = gsub('Acc','LinearAcceleration', column_names[,2])
          column_names[,2] = gsub('Gyro','AngularVelocity', column_names[,2])
          column_names[,2] = gsub('Mag','Magnitude', column_names[,2])
          column_names[,2] = gsub('Freq','Frequency', column_names[,2])
          # Replace - with 'In'
          column_names[,2] = gsub('-', 'In', column_names[,2])

          # Adjust remaining names to CamelCase for better Human readability without spaces
          column_names[,2] = gsub ('^a', 'A', column_names[,2])
          column_names[,2] = gsub ('gravity', 'Gravity', column_names[,2])

          # Replace (angles, gravity) etc. with _angles.gravity_ for easier column selection
          column_names[,2] = gsub('\\(','_', column_names[,2])
          column_names[,2] = gsub('\\)','_', column_names[,2])
          column_names[,2] = gsub(',','.', column_names[,2])
          
          # Change column names in data set to match column_names derived from features.txt
          setnames(data_rbind, column_names[1:561,2]) 
        
#2        Select columns that have mean or standard deviation in them                    
          meanandstd<- grep ("Mean|StandardDeviation", column_names[,2])
          
          # subset the data based on the index          
          data_rbind <-data_rbind[,meanandstd]

#3        Read in activity labels and convert to lower case 
          activity_labels <- read.table ("activity_labels.txt")
          activity_labels[, 2] = tolower(as.character(activity_labels[, 2]))          
          
          # Read in participant's activity codes and combine test and training sets
          activity_train <- read.table ("train/y_train.txt")
          activity_test <- read.table ("test/y_test.txt")      
          activity_rbind <- rbind(activity_train, activity_test)

          # Convert numbers to text for activities
          activity_rbind[,1] = activity_labels[activity_rbind[,1], 2]   

          # Add column name
          names(activity_rbind) <- "ActivityType"
          rm(activity_train)
          rm(activity_test)
          rm(activity_labels)

          # Read in participants id and combine test and training sets 
          id_train <- read.table ("train/subject_train.txt")
          id_test <- read.table ("test/subject_test.txt")
          id_rbind <- rbind (id_train, id_test)
          names(id_rbind) <- "SubjectID" #Add column name
          rm(id_train)
          rm(id_test)

          # Add columns (id and activity) to data_rbind
          data_id <- cbind (id_rbind, data_rbind)
          rm(data_rbind)
          rm(id_rbind)
          data_id_activity <- cbind (data_id, activity_rbind) # 4 finished -Tidy, complete data set
          rm(data_id)
          rm(activity_rbind)

#5        New Data set with means of each column generated and written out using chaining and dplyr
          new_table <- data_id_activity %>% group_by (SubjectID,ActivityType)  %>% summarise_each(funs(mean))
          write.table (new_table, file = "GettingandCleaningData.txt", row.name=FALSE)
    }
# table can be read with read.table("GettingandCleaningData.txt", header = TRUE)

