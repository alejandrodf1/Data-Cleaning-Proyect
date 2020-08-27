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