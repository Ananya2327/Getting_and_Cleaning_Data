## Course Project 
##1. Merge the training and test data to create one dataset

setwd("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset")
features <- read.table("features.txt")

names(features) <- c('S.No', 'Feature')

features$S.No <- NULL
activity_labels <- read.table("activity_labels.txt")

names(activity_labels) <- c('Label', 'Activity')
training_set <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\X_train.txt")
    #total 7352 observations for 561 variables

training_labels <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\y_train.txt")
      #range is 1:6. Each row corresponds to an activity mentioned in activity_labels like walking,sitting etc.

test_set <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\X_test.txt")

test_labels <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\y_test.txt")



#################training data##################


subject_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\subject_train.txt") 
  #range is 1:30. Each row corresponds to a person in the experiment.

total_acc_x_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_x_train.txt")

total_acc_y_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_y_train.txt")

total_acc_z_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_z_train.txt")

body_acc_x_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_x_train.txt")

body_acc_y_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_y_train.txt")

body_acc_z_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_z_train.txt")

body_gyro_x_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_x_train.txt")

body_gyro_y_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_y_train.txt")

body_gyro_z_train <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_z_train.txt")

names(subject_train) <- 'Subject ID'


############################test data###########################

subject_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\subject_test.txt") 
#range is 1:30. Each row corresponds to a person in the experiment.

total_acc_x_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_x_test.txt")

total_acc_y_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_y_test.txt")

total_acc_z_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_z_test.txt")

body_acc_x_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_x_test.txt")

body_acc_y_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_y_test.txt")

body_acc_z_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_z_test.txt")

body_gyro_x_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_x_test.txt")

body_gyro_y_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_y_test.txt")

body_gyro_z_test <- read.table("C:\\Users\\e571237\\Desktop\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_z_test.txt")

names(subject_test) <- 'Subject ID'


#######################################combining various tables - test data####################3

features.T <- t(features[,1])
   #transpose of the features table. This will become the column names for test set and training set tables
 
colnames(test_set) <- features.T
  #setting features as colnames for test_set table

colnames(test_labels) <- 'Activity ID'

test_data <- cbind(subject_test, test_labels, test_set)
    #combines person ID, activity data and features data
    #dimension: 2947*563



#################combining various tables -  training data###########


colnames(training_set) <- features.T
    #doing the same for traning_set table

colnames(training_labels) <- 'Activity ID'

training_data <- cbind(subject_train, training_labels, training_set)
    #combines person ID, activity ID and features data
    #dimension: 7352*563

################final data set -  combination of training and test data##############

final_data <- rbind(training_data, test_data)
##qs 1
##dimension: 10299*563


################intermediate steps##########

library(reshape2)

temp_features <- colsplit( string = as.character(features$Feature), pattern = '-', names = c('Feature Vector', 'Variable', 'Axis'))
    #splitting the features column into three separate columns in order to get the variables mean() and std()

#####final data frame with mean() and std() data 


mean_data <- final_data[,c( 1, 2, grep(pattern = "mean()", x= names(final_data), fixed = TRUE))]

std_data <- final_data[,c( 1, 2, grep(pattern = "std()", x= names(final_data), fixed = TRUE))]

final_df <- cbind(mean_data, std_data)
final_df[,36] <- NULL
final_df[,36] <- NULL
