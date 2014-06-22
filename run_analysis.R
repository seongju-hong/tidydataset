## read activiy_labels.txt and get only activity label data

al <- read.table("./activity_labels.txt")
al <- al[[2]]

## read test data and Uses descriptive activity names to name the activities in the data set
sx <- read.table("./test/X_test.txt")
sy <- read.table("./test/Y_test.txt") 
sy <- as.factor(sy[[1]])
levels(sy) <- al 
ss <- read.table("./test/subject_test.txt")

## read training data and label activity 
rx <- read.table("./train/X_train.txt")
ry <- read.table("./train/Y_train.txt")
ry <- as.factor(ry[[1]])
levels(ry) <- al
rs <- read.table("./train/subject_train.txt")

## Appropriately labels the data set with descriptive variable names. 
ft <- read.table("./features.txt")
ft <- ft[[2]]
ft <- sub("\\(\\)", "FU", ft)
ft <- sub("\\(", "__", ft)
ft <- sub("\\)", "__", ft)
ft <- sub("\\)", "__", ft)
ft <- sub("\\,", "COMMA", ft)
ft <- sub("\\-", "AND", ft)
ft <- sub("\\-", "AND", ft)
ft <- c(as.character(ft), "activity", "subject")

## Merges the training and the test sets to create one data set.
test <- cbind(sx, sy, ss)
train <- cbind(rx, ry, rs)
colnames(test) <- ft
colnames(train) <- ft
total <- rbind(test, train)

## Extracts only the measurements on the mean and standard deviation for each measurement. 
total <- total[,grep("meanFU|stdFU|activity|subject",ft )]

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
total <- aggregate(as.matrix(total[,1:66]), as.list(total[,68:67]), FUN = mean)
total <- total[order(total$subject, total$activity),]
write.table(total, file="./resultset.txt")


