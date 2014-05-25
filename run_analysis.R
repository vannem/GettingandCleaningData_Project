## Load all the useful data
setwd("E:/E220 BackUp/System/Users/Ethan_Han/Desktop/Coursea/Data_Science_JHU9Courses/Getting_and_Cleaning_Data/Peer/UCI HAR Dataset/test")
subject_test <- read.table("subject_test.txt");
X_test <- read.table("X_test.txt");
y_test <- read.table("y_test.txt");
setwd("E:/E220 BackUp/System/Users/Ethan_Han/Desktop/Coursea/Data_Science_JHU9Courses/Getting_and_Cleaning_Data/Peer/UCI HAR Dataset/train")
subject_train <- read.table("subject_train.txt");
X_train <- read.table("X_train.txt");
y_train <- read.table("y_train.txt");
setwd("E:/E220 BackUp/System/Users/Ethan_Han/Desktop/Coursea/Data_Science_JHU9Courses/Getting_and_Cleaning_Data/Peer/UCI HAR Dataset")
features <- read.table("features.txt");
activity_labels <- read.table("activity_labels.txt");

## Merges the training and the test sets to create one data set
testt <- matrix(rep("test",length(t(y_test))),nrow=length(t(y_test)),ncol=1)
trainn <- matrix(rep("train",length(t(y_train))),nrow=length(t(y_train)),ncol=1)
category <- rbind(testt,trainn)
activity <- rbind(y_test, y_train)
subject <- rbind(subject_test, subject_train)
X <- rbind(X_test, X_train)
OneDataSet = transform(X,new1=activity,new2=subject,new3=category)
colnames(OneDataSet) <- features[,2]
colnames(OneDataSet)[length(OneDataSet)-2] <- "activity"
colnames(OneDataSet)[length(OneDataSet)-1] <- "subject"
colnames(OneDataSet)[length(OneDataSet)] <- "category"
write.table(average, file="OneDataSet.txt")

##Extracts only the measurements on the mean and standard deviation for each measurement
mean_order <- grep("-mean()",colnames(OneDataSet),fixed = TRUE)
std_order <- grep("-std()",colnames(OneDataSet),fixed = TRUE)
all_order <- sort(c(mean_order,std_order))
all_feature <- colnames(OneDataSet)[all_order]
all_data <- OneDataSet[,all_order]
all_data = transform(all_data,new1=activity,new2=subject,new3=category)
colnames(all_data) <- all_feature
colnames(all_data)[length(all_data)-2] <- "activity"
colnames(all_data)[length(all_data)-1] <- "subject"
colnames(all_data)[length(all_data)] <- "category"
all_data_4 <- all_data ## just for step 4

mean_order <- grep("-mean()",colnames(OneDataSet),fixed = TRUE)
mean_feature <- colnames(OneDataSet)[mean_order]
mean_data <- OneDataSet[,mean_order]
mean_data = transform(mean_data,new1=activity,new2=subject,new3=category)
colnames(mean_data) <- mean_feature
colnames(mean_data)[length(mean_data)-2] <- "activity"
colnames(mean_data)[length(mean_data)-1] <- "subject"
colnames(mean_data)[length(mean_data)] <- "category"

std_order <- grep("-std()",colnames(OneDataSet),fixed = TRUE)
std_feature <- colnames(OneDataSet)[std_order]
std_data <- OneDataSet[,std_order]
std_data = transform(std_data,new1=activity,new2=subject,new3=category)
colnames(std_data) <- std_feature
colnames(std_data)[length(std_data)-2] <- "activity"
colnames(std_data)[length(std_data)-1] <- "subject"
colnames(std_data)[length(std_data)] <- "category"

## Uses descriptive activity names to name the activities in the data set
for(i in 1:10299){
  if(all_data[i,67]==1){all_data[i,67]<-as.character(activity_labels[1,2])}
  if(all_data[i,67]==2){all_data[i,67]<-as.character(activity_labels[2,2])}
  if(all_data[i,67]==3){all_data[i,67]<-as.character(activity_labels[3,2])}
  if(all_data[i,67]==4){all_data[i,67]<-as.character(activity_labels[4,2])}
  if(all_data[i,67]==5){all_data[i,67]<-as.character(activity_labels[5,2])}
  if(all_data[i,67]==6){all_data[i,67]<-as.character(activity_labels[6,2])}
}
for(i in 1:10299){
  if(mean_data[i,34]==1){mean_data[i,34]<-as.character(activity_labels[1,2])}
  if(mean_data[i,34]==2){mean_data[i,34]<-as.character(activity_labels[2,2])}
  if(mean_data[i,34]==3){mean_data[i,34]<-as.character(activity_labels[3,2])}
  if(mean_data[i,34]==4){mean_data[i,34]<-as.character(activity_labels[4,2])}
  if(mean_data[i,34]==5){mean_data[i,34]<-as.character(activity_labels[5,2])}
  if(mean_data[i,34]==6){mean_data[i,34]<-as.character(activity_labels[6,2])}
  if(std_data[i,34]==1){std_data[i,34]<-as.character(activity_labels[1,2])}
  if(std_data[i,34]==2){std_data[i,34]<-as.character(activity_labels[2,2])}
  if(std_data[i,34]==3){std_data[i,34]<-as.character(activity_labels[3,2])}
  if(std_data[i,34]==4){std_data[i,34]<-as.character(activity_labels[4,2])}
  if(std_data[i,34]==5){std_data[i,34]<-as.character(activity_labels[5,2])}
  if(std_data[i,34]==6){std_data[i,34]<-as.character(activity_labels[6,2])}
}

## Appropriately labels the data set with descriptive activity names
## I personally understand this as to sort the data set by activity, which
## is like to put the data with the same activity together or adjacently.
sort_by_activity <- all_data_4[order(all_data_4[, 67]), ]

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject
## need to use OneDataSet
df <- matrix(rep(0,180*564),nrow=180,ncol=564)
colnames(df) <- colnames(OneDataSet)
colnames(df)[562] <- "activity"
colnames(df)[563] <- "subject"
colnames(df)[564] <- "category"
for(i in 1:180){
  df[i,562] <- (i-1)%/%30+1
  df[i,563] <- i%%30
  if(df[i,563]==0){
    df[i,563]<-30
  }  
}
ddata<-matrix(as.numeric(unlist(OneDataSet)),nrow=10299,ncol=564)
for(j in 1:10299){
  index <- (ddata[j,562]-1)*30+ddata[j,563]
  df[index,1:561] <- df[index,1:561]+ddata[j,1:561]
  df[index,564] <- df[index,564]+1
}
for(j in 1:180){
  df[j,1:561]=df[j,1:561]/df[j,564] ## set category as counter...
}
average <- df[1:180, 1:563]
write.table(average, file="AverageDataSet.txt")