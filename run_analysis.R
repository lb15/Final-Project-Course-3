### read in all data files

test_set <- read.table("test/X_test.txt")
## 2947 x 561 - subject measurements for each activty
test_labels <- read.table("test/y_test.txt")
## 2947 x 1 - #1-6 representing activity
test_subjects <- read.table("test/subject_test.txt")
## 2947 x 1 - test subject IDs

features <- read.table("features.txt")
## 561 x 2 - measurement description

training_set <- read.table("train/X_train.txt")
## 7352 x 561
training_labels <- read.table("train/y_train.txt")
## 7352 x 1
training_subjects <- read.table("train/subject_train.txt")
## 7352 x 1

# 1. Merge the training and the test sets to create one data set.

### make test dataset
colnames(test_subjects) <- "subjectID"
colnames(test_set) <- features$V2
colnames(test_labels) <- "activity"

test_dataset <- cbind(activity=test_labels$activity,test_set)
test_dataset <- cbind(dataset=c(rep("test",nrow(test_set))),test_dataset)
test_dataset <- cbind(subjectID=test_subjects$subjectID,test_dataset)

## make training dataset
colnames(training_subjects) <- "subjectID"
colnames(training_set)<-features$V2
colnames(training_labels) <- "activity"

training_dataset <- cbind(activity=training_labels$activity, training_set)
training_dataset <- cbind(dataset=c(rep("training",nrow(training_set))),training_dataset)
training_dataset <- cbind(subjectID=training_subjects$subjectID,training_dataset)

## combine datasets into one
combined <- rbind(training_dataset, test_dataset)

# 2. Extract only the measurements on the mean and standard deviation for each measurement. Only included measurements that have BOTH a mean and standard deviation.
measures <- grep("mean\\(\\)|std",names(combined),value=T)
cols <- c(names(combined[,c(1:3)]),measures)
mean_sd <- combined[,match(cols,names(combined))]

# 3. Use descriptive activity names to name the activities in the data set

activities=gsub(1, "walking",mean_sd$activity)
activities=gsub(2, "walking upstairs",activities)
activities=gsub(3, "walking downstairs",activities)
activities=gsub(4, "sitting",activities)
activities=gsub(5, "standing",activities)
activities=gsub(6, "laying",activities)

mean_sd$activity <- activities

# 4. Appropriately label the data set with descriptive variable names.

## replace Acc with accelerometer and Gyro with gyroscope
measurements <- names(mean_sd)
new_meas<-gsub("Acc"," measured with accelerometer for ", measurements)
new_meas <-gsub("Gyro", " measured with gyroscope for ", new_meas)
## replace t with time domain, f with frequency domain
new_meas2 <- gsub("^t","time domain signal for ", new_meas)
new_meas2 <- gsub("^f", "frequency domain signal for ", new_meas2)
## replcae mean() with mean, std() with standard deviation
new_meas3 <- gsub("-mean\\(\\)-?","mean",new_meas2)
new_meas3 <- gsub("-std\\(\\)-?","standard deviation",new_meas3)
## replace X with "on the X axis", Y with "on the Y axis" and Z with "on the Z axis"
new_meas4 <- gsub("X"," on the X axis",new_meas3)
new_meas4 <- gsub("Y"," on the Y axis",new_meas4)
new_meas4 <- gsub("Z"," on the Z axis",new_meas4)
## replace "Jerk" and "JerkMag" with jerk and jerk magnitude
new_meas5 <- gsub("JerkMag","jerk magnitude of ",new_meas4)
new_meas5 <- gsub("Jerk","jerk of ",new_meas5)
new_meas5 <- gsub("Mag","magnitude of ",new_meas5)

tidy_dataset <- mean_sd
colnames(tidy_dataset) <- new_meas5

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_mean <- tidy_dataset %>% group_by(subjectID,activity) %>% summarise_at(.vars =c(4:69),.funs = mean )

write.table(tidy_mean,file="tidy_mean.txt")


