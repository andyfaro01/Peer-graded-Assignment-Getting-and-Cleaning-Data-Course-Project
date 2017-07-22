# Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project
This is the read me for the course project for Getting and Cleaning Data course on Coursera. 

GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables 
and summaries calculated, along with units, and any other relevant information.

Code is written in R (R version 3.3.0) in file called run_analysis.R. 
This R script (run_analysis.R) does the following things:


## Obtain the data 
Step 1 - Downloads the file and stores in the "projectdata" folder.
* Sets working directory
* Check if file has already been downloaded in ./projectdata directory?
* Creates object "fileurl for file to be downloaded into in R
* Downloads zip file "Dataset.zip" into projecdata directory.

Step 2 - Unzips the file ( unziped file is "UCI HAR Dataset") and store as "projectdatafiles" object in R

Step 3 - Views "projectfiles"

Only the files listed as follows will be used: 
* test/subject_test.txt 
* test/X_test.txt 
* test/y_test.txt 
* train/subject_train.txt
* train/X_train.txt 
* train/y_train.txt

Step 4 - Reads above data from "projectfile" into following data frames:
ActivityTestdata, ActivityTraindata, SubjectTraindata, SubjectTestdata, FeaturesTestdata, FeaturesTraindata
* Reads the Activity files into "ActivityTestdata" and "ActivityTraindata"
* Reads the Subject files into "SubjectTraindata" and "SubjectTestdata"
* Reads Features files into "FeaturesTestdata" and "FeaturesTraindata"


## Merges the training and test data sets for the 3  variables and stores in R as:
## activitydata, subjectdata and featuresdata
Step 1 - Row-binds "ActivityTestdata" and "ActivityTraindata" to get "Activitydata" for Activity

Step 2 - Row-binds "SubjectTraindata" and "SubjectTestdata" to get "Subjectdata" for Subject

Step 3 - Row-binds "FeaturesTraindata" and "FeaturesTestdata" to get "Featuresdata" for Features


## Gives names to the created merged dataframes


## Gets one dataset by merging all 3 dataframes by column
Step 1 - Combines dataframes with cbind to get "Data"

Step 2 - Check the combined dataframe "Data"


## Extracts only the measurements on the mean and standard deviation in "Data" and store as "Data".
Step 1 - Extracts from "FeaturesNamesdata" using grep() (to extract names with "mean()" or "std()") 
and stores as "FeaturesdataNamessubdata" in R

Step 2 - Creates object "usefulnames" to store variables needed for the subseting

Step 3 - Subsets "Data" with "usefulnames" and stores as "Data"

Step 4 - Checks "Data"


## Uses descriptive activity names to name the activities in the "Data"
Step 1 - Reads "activity_labels.txt" to "activitylabels" object in R

Step 2 - Turns "activity" column in "Data" to a factor using the descriptive names from "activitylabels"


## Appropriately labels the data set "Data" with descriptive variable names by using descriptive variable names for the 
## Features using gsub and replacing relevant characters in the Features name labels 


## Creates second independent tidy data with average of each variable for each activity and each subject called "NewData" and output it as "independentTidydata.txt"
