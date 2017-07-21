#Obtain the data by downloading the file and storing in the "projectdata" folder

##step 1 - set directory, check if "projectdata" folder exists, if not create "projectdata" folder
setwd("C:/Users/User/Desktop/Coursera")

if(!file.exists("./projectdata")){dir.create("./projectdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./projectdata/Dataset.zip")

##step 2 - Unzip the file ( unziped file is "UCI HAR Dataset") and store as "projectdatafiles" object in R
unzip(zipfile="./projectdata/Dataset.zip",exdir="./projectdata")
projectfilespath <- file.path("./projectdata" , "UCI HAR Dataset")
projectdatafiles <- list.files(projectfilespath, recursive=TRUE)

##step 3 - View "projectfiles"
projectdatafiles

#Only the following files will be used to load data:
# test/subject_test.txt
# test/X_test.txt
# test/y_test.txt
# train/subject_train.txt
# train/X_train.txt
# train/y_train.txt

#Variables Activity, Subject and Features will be used. 
#Values of Activity are in "Y_train.txt" and "Y_test.txt" while levels of Activity are in "activity_labels.txt"
#Values of Subject are in "subject_train.txt" and subject_test.txt"
#Values are in "X_train.txt" and "X_test.txt" while Names of Features are in  "features.txt"

##step 4 - Read above data from "projectfile" into following data frames:
#ActivityTestdata, ActivityTraindata, SubjectTraindata, SubjectTestdata, FeaturesTestdata, FeaturesTraindata

#For Activity:
ActivityTestdata  <- read.table(file.path(projectfilespath, "test" , "Y_test.txt" ),header = FALSE)
ActivityTraindata <- read.table(file.path(projectfilespath, "train", "Y_train.txt"),header = FALSE)

#For Subject:
SubjectTraindata <- read.table(file.path(projectfilespath, "train", "subject_train.txt"),header = FALSE)
SubjectTestdata  <- read.table(file.path(projectfilespath, "test" , "subject_test.txt"),header = FALSE)

#For Features
FeaturesTestdata  <- read.table(file.path(projectfilespath, "test" , "X_test.txt" ),header = FALSE)
FeaturesTraindata <- read.table(file.path(projectfilespath, "train", "X_train.txt"),header = FALSE)
str(ActivityTestdata)

#Merging the training and test data sets for the 3  variables and store in R as:
#activitydata, subjectdata and featuresdata

##Step 1 - row bind ActivityTestdata and ActivityTraindata to get Activitydata for Activity
Activitydata<- rbind(ActivityTraindata, ActivityTestdata)
##Step 2 - row bind SubjectTraindata and SubjectTestdata to get Subjectdata for Subject
Subjectdata <- rbind(SubjectTraindata, SubjectTestdata)
##Step 3 - row bind FeaturesTraindata and FeaturesTestdata to get Featuresdata for Features
Featuresdata<- rbind(FeaturesTraindata, FeaturesTestdata)

#Give names to the created merged dataframes
##step 1- For Activitydata:
names(Activitydata)<- c("activity")
##step 2 - For subjectdata
names(Subjectdata)<-c("subject")
##Step 3 - For features, names are read from "features.txt"
names(Activitydata)<- c("activity")
FeaturesNamesdata <- read.table(file.path(projectfilespath, "features.txt"),head=FALSE)
names(Featuresdata)<- FeaturesNamesdata$V2

#Get one dataset by merging all 3 dataframes by column
##step 1 - Combine dataframes with cbind
lumpdata <- cbind(Subjectdata, Activitydata)
Data <- cbind(Featuresdata, lumpdata)
##Step 2 - check the combined dataframe "Data"
str(Data)

#Extract only the measurements on the mean and standard deviation in Data and store as Data.
## Step 1 - Extract from "FeaturesNamesdata" using grep() (to extract names with "mean()" or "std()") 
#and store as "FeaturesdataNamessubdata" in R
FeaturesdataNamessubdata<-FeaturesNamesdata$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNamesdata$V2)]
##Step 2 - Create object "usefulnames" to store variables needed for the subseting
usefulnames<-c(as.character(FeaturesdataNamessubdata), "subject", "activity" )
##Step 3 - subset "Data" with "usefulnames" and store as "Data"
Data<-subset(Data,select=usefulnames)
##Step 4- check Data
str(Data)

#Use descriptive activity names to name the activities in the "Data"
##Step 1 - read "activity_labels.txt" to "activitylabels" object in R
activitylabels <- read.table(file.path(projectfilespath, "activity_labels.txt"),header = FALSE)
##Step 2- turn "activity" column in "Data" to a factor using the descriptive names from "activitylabels"
Data$activity <- factor(Data$activity, labels = activitylabels$V2)

#Appropriately labels the data set "Data" with descriptive variable names by using descriptive variable names for the 
#Features using gsub and replacing relevant characters in the Features name labels below:
#prefix t is replaced by time
#Acc is replaced by Accelerometer
#Gyro is replaced by Gyroscope
#prefix f is replaced by frequency
#Mag is replaced by Magnitude
#BodyBody is replaced by Body

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))
names(Data)

#Create second independent tidy data with average of each variable for each activity and 
#each subject called "NewData" and output it as "independentTidydata.txt"

NewData<-aggregate(. ~subject + activity, Data, mean)
NewData<-NewData[order(NewData$subject,NewData$activity),]
write.table(NewData, file = "independentTidydata.txt",row.name=FALSE)