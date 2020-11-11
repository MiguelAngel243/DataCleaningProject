##Download zip file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"data.zip",method="curl")
##Unzip in working directory
unzip("data.zip")
##Loads tables 
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("./UCI HAR Dataset/train/y_train.txt")
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("./UCI HAR Dataset/test/y_test.txt")
clabels <- read.table("./UCI HAR Dataset/features.txt")

##Assign activity name to y column with factors
test_y[,1] <- factor(test_y[,1],c(1:6),labels=c("walking","walkingupstairs","walkingdownstairs","sitting","standing","laying"))
train_y[,1] <- factor(train_y[,1],c(1:6),labels=c("walking","walkingupstairs","walkingdownstairs","sitting","standing","laying"))
##Add y column to x tables
test_table <- cbind(test_y,test_x)
train_table <- cbind(train_y,train_x)
##Join tables
df <- rbind(test_table,train_table)
##Assign column names
colnames(df) <- c("activity",clabels[,2])
##Select mean and std related columns
library(dplyr)
df <- select(df,matches("mean[^F]|std|activity"))
##Unfold abbreviations, separate word with periods, lowerize words and remove (),-
colnames(df) <- colnames(df) %>%
  gsub(pattern="\\(\\)",replacement=".") %>%
  gsub(pattern="\\(",replacement=".") %>%
  gsub(pattern="\\)",replacement=".") %>%
  gsub(pattern="^t",replacement="total.") %>%
  gsub(pattern="^f",replacement="estimated.") %>%
  gsub(pattern="Body",replacement="body.") %>%
  gsub(pattern="Acc",replacement="acceleration.") %>%
  gsub(pattern="Gravity",replacement="gravity.") %>%
  gsub(pattern="mag",replacement="magnitude.") %>%
  gsub(pattern="Gyro",replacement="gyroscope.") %>%
  gsub(pattern="-",replacement="") %>%
  gsub(pattern=",",replacement=".") %>%
  gsub(pattern="\\.$",replacement="") %>%
  tolower()
##Load subjects data
train_sub <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test_sub <- read.table("./UCI HAR Dataset/test/subject_test.txt")
##Adjunt subject column to dataframe
dt2<-cbind(rbind(test_sub,train_sub),df)
##Name subject column
colnames(dt2)<-c("subject",colnames(df))
##Group data by subject and activity
dt2 <- group_by(dt2,subject,activity)
##Summarize all columns
dt2<- summarize_all(dt2,mean)
#Output
write.table(dt2,"tidydataset.txt",row.name=FALSE)
write.table(colnames(dt2),"variablenames.txt")

