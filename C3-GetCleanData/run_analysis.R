

setwd("/run/media/joerg/zeitzahm/work/stats/moocstuff/CourseraDataSciSpecial/C3-GetCleanData/pproject/")

setwd("/mnt/DATA/work/stats/moocstuff/CourseraDataSciSpecial/C3-GetCleanData/pproject")



###############
# Instructions:

# 1. Combine all the data
# 2. Reduce the columns to those involving mean and sd
# 3. Turn the activity numbers into words
# 4. Fix the variable names 
# 5. Create and save a version with an average of each variable for each activity and each subject. 





###############################################
# 1. Read and merge both train and test dataset
###############################################


## read the TEST data 
df.test <- read.csv("data/test/X_test.txt", sep="", header=F)

# check number of rows and variables
cat("Test data frame has",nrow(df.test),"observations on", ncol(df.test), "variables\n")

#check NAs
cat("Complete cases: ", sum(complete.cases(df.test)), "\n")

# read related activities and subject file(s)
test.activity <- read.table("data/test/y_test.txt", header=F)
test.subject <- read.table("data/test/subject_test.txt", header=F)

#nrow(test.activity)
#nrow(test.subject)

# combine activity and subject to the df.test
df.test <- cbind(test.activity, df.test)
df.test <- cbind(test.subject, df.test)



## read the TRAIN data 
df.train <- read.csv("data/train/X_train.txt", sep="", header=F)
cat("Train data frame has",nrow(df.train),"observations on", ncol(df.train), "variables\n")

#check NAs
cat("Complete cases: ", sum(complete.cases(df.train)), "\n")

# read activities and subject file
train.activity <- read.table("data/train/y_train.txt", header=F)
train.subject <- read.table("data/train/subject_train.txt", header=F)

nrow(train.activity)
nrow(train.subject)

# add activity and subject to the df.train
df.train <- cbind(train.activity, df.train)
df.train <- cbind(train.subject, df.train)



## put TRAIN and TEST into one dataframe
df <- rbind(df.test, df.train)

cat("The combined data frame of test + train has",nrow(df),"observations on", ncol(df), "variables\n")

# removing tmp objects to free up memory
rm(df.train, df.test, train.activity, train.subject, test.subject, test.activity)

  

#########################################################################
# 2. Extract only the measurements on the mean and standard deviation for 
#    each measurement.  
#########################################################################

#read the list of 561 variables 
features <- read.table("data/features.txt", header=F)

#name the variables in the dataframe includind the first two columns; 
#later we make the names more descriptive. 
names(df)[1] <- c("subject")
names(df)[2] <- c("activity")
names(df)[3:563] <- as.character(features$V2) 

#extract all variables that measure either "mean" or "std"
ss <- grep("mean|std", names(df))

#subset df to those columns which contain mean or standard deviation measurements
#preserve activity and subject columns as well
df <- df[, c(1,2,ss)]

#take out the FFT variables since these contain the same information as the original 
#variables just in FFT form. Keep "t*" variables:
st <- grep("^[t]", names(df))
df <- df[, c(1,2,st)]

#cleaning up
rm(ss, st)


########################################################################
# 3. use descriptive activity names to name the activites in the dataset
########################################################################

# read the levels and lables of the activities
l.activities <- read.table("data/activity_labels.txt", header=F)

#convert "activity" into descriptive factor. 
df$activity <- factor(df$activity, levels=l.activities$V1, labels=l.activities$V2)

#cleaning up
rm(l.activities)


###########################
# 4. Fix the variable names
###########################

#remove parenthesis "()" and "-" from the names since these will be interpreted
#as mathematical signs when using the variable names in functions. 

names(df) <- gsub("[()]", "", names(df))
names(df) <- gsub("[-]", "_", names(df))



##########################################################################
# 5. Creates a second, independent tidy data set with the average of each 
#    variable  for each activity and each subject. 
##########################################################################

#let's look at the number of cases for each group of subject-activity.
table(df$subject, df$activity)

#There are 30 subjects performing 6 activities; need to calculate the average for each 
#variable for each of those 180 groupings. The resulting df will have 180 * 79 = 14220 cells. 


#calculate the mean of each variable, grouped by subject and activity. 
df.tidy <- aggregate(df[,3:ncol(df)], by=list(df$activity, df$subject), FUN=mean)

#rename grouping variables
names(df.tidy)[1] <- c("activity")
names(df.tidy)[2] <- c("subject")

#save tidy data set to file. 
write.csv(df.tidy, file="dftidy.csv")








