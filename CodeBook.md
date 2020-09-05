# Code Book 
It is a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data. According to the features_info file from the data:

"This database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. [Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise.[...] Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).[...]

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
[...]

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable"

##First the data was read, to get info of features, activities, and also subject, x, y info from test and train data
features<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt") ##561 obs of 2 variables

activities<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt") ##Activities where the information comes from. 6 obs. of 2 variables 

subject_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt") ##Subjects that was observed in test data.2947 obs of 1 variable

x_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt") ##2947 obs of 561 variables - Features mesured

y_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt") ##2947 obs of 1 variable - Activity

subject_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt") ##Subjects that was observed in train data.7352 obs of 1 variable

x_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt") ##7352 obs of 561 variables - Features mesured

y_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt") ##7352 obs of 1 variables - Activity

##1.Combine test and train data
subject<-rbind(subject_test,subject_train)
colnames(subject)<-'subject'

x<-rbind(x_test,x_train)
colnames(x)<-features$V2

y<-rbind(y_test,y_train)
colnames(y)<-"id_act"

##1.obtain one data set from test and train data
data<-cbind(subject,x,y)

##2.Extracts only the measurements on the mean and standard deviation for each measurement. It matches all the variables that contains mean and std in their names.
set_mesurements<-select(.data=data,subject,id_act,matches("mean"),matches("std"))

##3.Uses descriptive activity names to name the activities in the data set. The code matches the activities' id and add other column with the activity of each id.
set_activities<-set_mesurements%>%mutate(activity=(activities[id_act, 2]))%>%select(subject,id_act,activity,everything())

##4.Appropriately labels the data set with descriptive variable names. This code substitute the abreviation with the complete name.
names(set_activities)<-gsub("Acc", "Accelerometer", names(set_activities))
names(set_activities)<-gsub("Gyro", "Gyroscope", names(set_activities))
names(set_activities)<-gsub("^t", "Time", names(set_activities))
names(set_activities)<-gsub("BodyBody", "Body", names(set_activities))
names(set_activities)<-gsub("Mag", "Magnitude", names(set_activities))
names(set_activities)<-gsub("^f", "Frequency", names(set_activities))
names(set_activities)<-gsub("tBody", "TimeBody", names(set_activities))
names(set_activities)<-gsub("mean\\(\\)", "Mean", names(set_activities))
names(set_activities)<-gsub("std\\(\\)", "STD", names(set_activities))
names(set_activities)<-gsub("Freq\\(\\)", "Frequency", names(set_activities))

##4.Generating a .txt file with the tidy data
write.table(set_activities, "4_TidyData.txt", row.name=FALSE)

##5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
data_group<-group_by(.data = set_activities,subject, activity) ## to group by subject and activity

TidyDataGroupAverage<-summarise_all(data_group,mean) ##To obtain the mean of each variable grouped.

write.table(TidyDataGroupAverage, "5_TidyDataGroupAverage.txt", row.name=FALSE) ##to create the final tidy data
