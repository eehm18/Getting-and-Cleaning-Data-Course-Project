library(dplyr)
##Read data
features<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt")
activities<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
subject_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
x_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
x_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")

##1.Combine test and train data
subject<-rbind(subject_test,subject_train)
colnames(subject)<-'subject'

x<-rbind(x_test,x_train)
colnames(x)<-features$V2

y<-rbind(y_test,y_train)
colnames(y)<-"id_act"

##1.obtain one data set from test and train data
data<-cbind(subject,x,y)

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
set_mesurements<-select(.data = data,subject,id_act,matches("mean"),matches("std"))

##3.Uses descriptive activity names to name the activities in the data set.
set_activities<-set_mesurements%>%mutate(activity=(activities[id_act, 2]))%>%select(subject,id_act,activity,everything())

##Appropriately labels the data set with descriptive variable names.
names(set_activities)<-gsub("Acc", "Accelerometer", names(set_activities))
names(set_activities)<-gsub("Gyro", "Gyroscope", names(set_activities))
names(set_activities)<-gsub("^t", "Time", names(set_activities))
names(set_activities)<-gsub("BodyBody", "Body", names(set_activities))
names(set_activities)<-gsub("Mag", "Magnitude", names(set_activities))
names(set_activities)<-gsub("^f", "Frequency", names(set_activities))
names(set_activities)<-gsub("tBody", "TimeBody", names(set_activities))
names(set_activities)<-gsub("mean()", "Mean", names(set_activities))
names(set_activities)<-gsub("std()", "STD", names(set_activities))
names(set_activities)<-gsub("freq()", "Frequency", names(set_activities))