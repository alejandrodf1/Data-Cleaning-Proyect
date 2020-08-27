library(dplyr)
##reading data test
data_features<-read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = " ")
data_features<-as.character(data_features[,2])
data_subject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
data_y<-read.table("./UCI HAR Dataset/test/y_test.txt")
data_X<-read.table("./UCI HAR Dataset/test/X_test.txt")

data_test<-data.frame(data_subject,data_y,data_X)
head(data_test)
names(data_test)=c(c('subject', 'activity'), data_features)

##reading data train

data_subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
data_y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
data_X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")

data_train<-data.frame(data_subject_train,data_y_train,data_X_train)
names(data_train)=c(c('subject', 'activity'), data_features)
head(data_train)

##merge data
data_mergue<-rbind(data_train, data_test)

##getting mean and sd
data_mean_sd<- grep("mean|std", data_features) ##posiciones
data_sub<- data_mergue[,c(1,2,data_mean_sd + 2)] ##showing data

##activities name
data_name_ac<- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
data_name_ac<-as.character(data_name_ac[,2])
data_sub$activity<- data_name_ac[data_sub$activity]

##Etiquetas apropiadas
name_new<- names(data_sub)
name_new<- gsub("[(][)]","", name_new)
name_new<-gsub("^t","TimeDomain_", name_new)
name_new<- gsub("^f", "FrequencyDomain_", name_new)
name_new<-gsub("Acc","Accelerometer",name_new)
name_new<-gsub("Gyro", "Gyroscope", name_new)
name_new<-gsub("Mag", "Magnitude", name_new)
name_new<-gsub("-mean-","_Mean_",name_new)
name_new<-gsub("-std-","_standardDeviation_",name_new)
name_new<-gsub("-", "_",name_new)
names(data_sub)<-name_new
names(data_sub)
##new tidy data
data_tidy<- aggregate(data_sub[,3:81], by = list(activity=data_sub$activity, subject=data_sub$subject), FUN = mean)
write.table(x = data_tidy, file = "data_tidy.txt", row.names = FALSE)
