## Load all the useful data

## Merges the training and the test sets to create one data set
## By using rbind, I combine them together. I also added three columns at 
## the end of this matrix which are "activity" (different behavior, like walking...), 
## "subject" (who performs this measurement, from 1 to 30), "category" 
## (indicates test data or train data). Save data out as OneDataSet.txt. 

## Extracts only the measurements on the mean and standard deviation for each measurement
## Still keep activity, subject and category out there.

## Uses descriptive activity names to name the activities in the data set
## Read activity_labels file and based on it change those numbers in the 
## activity column to words.

## Appropriately labels the data set with descriptive activity names
## I personally understand this as to sort the data set by activity, which
## is like to put the data with the same activity together or adjacently.

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject
## My result matrix is 180 * 563, 180 includes all the situation of considering each activity and each subject.
## The 562th column is the activity, the 563th column is the subject.
## Save this average values matrix to "AverageDataSet.txt"

