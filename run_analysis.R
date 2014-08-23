readandmerge <- function(part = 'test')
{
        x_data<-read.table(paste0(paste0(paste0(paste0('./UCI HAR Dataset/',part),'/X_'),part),'.txt'))
        y_data<-read.table(paste0(paste0(paste0(paste0('./UCI HAR Dataset/',part),'/y_'),part),'.txt'))
        subject_data<-read.table(paste0(paste0(paste0(paste0('./UCI HAR Dataset/',part),'/subject_'),part),'.txt'))
        
        data<-cbind(subject_data,y_data)
        data<-cbind(data,x_data)
        
        data
}


#downloading and unzipping
if(!file.exists("./UCI HAR Dataset")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile="UCI%20HAR%20Dataset.zip")
        unzip("UCI%20HAR%20Dataset.zip")
}

#test
test <- readandmerge("test")

#train
train <- readandmerge("train")

merged <- rbind(test,train)

features <- read.table('./UCI HAR Dataset/features.txt')
features[,2] <- tolower(gsub("-","",as.character(features[,2])))
activity <- read.table('./UCI HAR Dataset/activity_labels.txt')

colnames(merged)[1]<-"subject"
colnames(merged)[2]<-"activity"
colnames(merged)[3:563]<-as.character(features[,2])

merged[,1]<-as.factor(merged[,1])

merged<-merge(activity, merged, by.x="V1", by.y="activity",all.y=TRUE)
colnames(merged)[2]<-"activity"

merged<-merged[,c(2:564)]

mean_std <- features[(grepl('mean',features$V2) | grepl('std',features$V2)) & !grepl('meanfreq',features$V2) & !grepl('angle',features$V2),]

cutted<-merged[,c("activity","subject", as.character(mean_std[,2]))]

aggreg<-aggregate(cutted, by=list(cutted$subject,cutted$activity), FUN=mean)
aggreg<-aggreg[,c(1,2,5:70)]
colnames(aggreg)[1]<-"subject"
colnames(aggreg)[2]<-"activity"

aggreg