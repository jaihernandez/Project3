library(dplyr)
library(data.table)

#This is my personal folder...
# setwd("~/Work/Training/Data Science Coursera/3-Data Cleansing")

## Code to download zip folder into deafult folder
zipurl = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./UCI HAR Dataset.zip')){
    download.file(zipurl,'./UCI HAR Dataset.zip', mode = 'wb')
    unzip("UCI HAR Dataset.zip", exdir = getwd())
}


###Code to read test and training data

features <- read.table('./UCI HAR Dataset/features.txt')
features <- as.character(features[,2])

train_data_x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train_data_activ <- read.table('./UCI HAR Dataset/train/y_train.txt')
train_data_sub <- read.table('./UCI HAR Dataset/train/subject_train.txt')

data.train <-  as.data.frame(cbind(train_data_sub, train_data_activ, train_data_x))

names(data.train) <- c(c('subject', 'activity'), features)

test_data_x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test_data_activ <- read.table('./UCI HAR Dataset/test/y_test.txt')
test_data_sub <- read.table('./UCI HAR Dataset/test/subject_test.txt')

data.test <-  as.data.frame(cbind(test_data_sub, test_data_activ, test_data_x))
names(data.test) <- c(c('subject', 'activity'), features)

###Merge test and train data

main_DF <- rbind(data.train, data.test)

### Extract only mean and SD related variables

my_variables <- grep('mean|std', names(main_DF))

final_DF <- main_DF[,c(1,2,my_variables)]

#Read activity labels and map to final_DF

activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt')
activity_labels <- as.character(activity_labels[,2])
final_DF$activity <- activity_labels[final_DF$activity]

###### Name the data set
new_names <- names(final_DF)
new_names <- gsub("[(][)]", "", new_names)
new_names <- gsub("^t", "TimeDomain_", new_names)
new_names <- gsub("^f", "FrequencyDomain_", new_names)
new_names <- gsub("Acc", "Accelerometer", new_names)
new_names <- gsub("Gyro", "Gyroscope", new_names)
new_names <- gsub("Mag", "Magnitude", new_names)
new_names <- gsub("-mean-", "_Mean_", new_names)
new_names <- gsub("-std-", "_StandardDeviation_", new_names)
new_names <- gsub("-", "_", new_names)
names(final_DF) <- new_names

##Get averages set

avg_dataset <- final_DF %>%
    group_by(activity, subject) %>%
    summarise_all(funs(mean))
    
#Write text file with new tidy set for averages
write.table(x = avg_dataset, file = "avg_dataset.txt", row.names = FALSE)


