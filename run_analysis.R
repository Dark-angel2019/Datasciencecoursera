# Assignment instruction
## You should create one R script called run_analysis.R that does the following. 
## 1- Merges the training and the test sets to create one data set.
## 2- Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3- Uses descriptive activity names to name the activities in the data set
## 4- Appropriately labels the data set with descriptive variable names. 
## 5- From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject

## Prep work
setwd("C:/Users/jiameng.yu/Desktop/Statistics_course/Course 3 - Getting and cleaning data/Course assignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")
library("dplyr")
library("rlang")
## Step 2: extracting the relevant data

 ## test data
subject_test<- read.table ("./test/subject_test.txt",header=TRUE)
 ## 'data.frame':	2946 obs. of  1 variable
labels_test<- read.table ("./test/y_test.txt",header=TRUE) 
 ##'data.frame':	2946 obs. of  1 variable
dataset_test<- read.table("./test/X_test.txt",header=TRUE)
 ##'data.frame':	2946 obs. of  561 variables; num

 ## train data
subject_train<- read.table ("./train/subject_train.txt",header=TRUE)
## 'data.frame':	7351 obs. of  1 variable
labels_train<- read.table ("./train/y_train.txt",header=TRUE) 
##'data.frame':	7351 obs. of  1 variable
dataset_train<- read.table("./train/X_train.txt",header=TRUE)
##'data.frame':	2946 obs. of  561 variables; num

## Step 3: combining dataset 
test<- cbind(subject_test,labels_test,dataset_test)
train<- cbind(subject_train,labels_train,dataset_train)
newcollabel<- c("subject","activity_code",1:561)
colnames(test) <- newcollabel
colnames(train)<- newcollabel
fullset<- rbind(test,train)##'data.frame':	10297 obs. of  563 variables

##step 4: Extracting mean and SD 
 ## locating the relevant measurements
feature<- read.table ("./features.txt",header=FALSE)
means<- as.integer(grep("mean",feature[,2])) ## length 46
sd<- as.integer(grep("std",feature[,2])) ##length 33
feature_select<- as.character(feature[c(means,sd),2])

means1<- as.integer(lapply(means,function(x){x+2}))
sd1<- as.integer(lapply(sd,function(x){x+2})) 


 ## extracting only means and SD 
sub_set<- fullset[,c(1:2,means1,sd1)]
original_position<- 1:10297
sub_set<- cbind(original_position,sub_set) # documenting original postion to ensure 
## matching works in the next step as it reorders


## Step 5: use descriptive activity names
activity_labels<- read.table("./activity_labels.txt")
activity_labels<- rename(activity_labels,"activity_desc"="V2", "activity_code"="V1")
sub_set2 <- (merge(activity_labels,sub_set, by="activity_code"))

## Step 6: use descriptive measurement names 
newcollabel2<- c("activity_code","activity_desc","original_position","subject",feature_select)
colnames(sub_set2)<- newcollabel2

## Step 7: calculate the average of each variable for each subject and each activity
sub_set3 <- group_by(sub_set2,subject, activity_code) %>%
        summarise_if(is.numeric,mean)
results<- (merge(activity_labels,sub_set3, by="activity_code"))

## Step 8: exporting .txt file
write.table(results, "C:/Users/jiameng.yu/Desktop/Statistics_course/Course 3 - Getting and cleaning data/Course assignment/assignment_output.txt",sep="\t",row.names=FALSE) 

