library(dplyr)

#adding training sets
x_train <- read.table("./train/X_train.txt") 
y_train <- read.table("./train/y_train.txt") 
sub_train <- read.table("./train/subject_train.txt") 

#adding training labels
x_test <- read.table("./test/X_test.txt") 
y_test <- read.table("./test/y_test.txt") 
sub_test <- read.table("./test/subject_test.txt") 

#adding features
features<- read.table("./features.txt")

#adding different labels
activities<-read.table("./activity_labels.txt")

#binding test and training subject 
x_total<- rbind(x_train,x_test)
y_total<- rbind(y_train,y_test)
sub_total<-rbind(sub_train,sub_test)

#getting features having mean and sd in them
sel_features <- features[grep(".*mean\\(\\)|std\\(\\)", features[,2], ignore.case = FALSE),]
x_total<-x_total[,sel_features[,1]]

#setting descriptive col names
colnames(x_total)=sel_features[,2]
colnames(y_total)="activity"
colnames(sub_total)="subject"

#binding observation with activity and subject
total<-cbind(x_total,y_total,sub_total)

#setting activity and subject as factors
total$activity<- factor(total$activity,labels=(activities[,2]),levels=(activities[,1]))
total$subject<-factor(total$subject)

#grouping each activity and subject
total_mean <- total%>%group_by(activity,subject)%>%summarize_all(funs(mean))

#writing tidy data
write.table(total_mean,file="./tidyData.txt",row.names = FALSE,col.names = TRUE)







