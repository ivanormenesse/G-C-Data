#1.Merges the training and the test sets to create one data set.
#load
train = read.table("./train/X_train.txt",header = F)
test = read.table("./test/X_test.txt",header = F)
#indicate the subjects of each group: in train£º 21 subjects while in test£º9 subjects
subject_train = read.table("./train/subject_train.txt")
subject_test = read.table("./test/subject_test.txt")
#labels Y
train_labels = read.table("./train/Y_train.txt")
test_labels = read.table("./test/Y_test.txt")

#4.Appropriately labels the data set with descriptive variable names. 
features_561 = read.table("features.txt")
names(train)= features_561[,2]
names(test)= features_561[,2]

#Add columns for subjects and activity
train  = cbind(train,subject_train)
test  = cbind(test,subject_test)
names(train)[562] = "subjects"
names(test)[562] = "subjects"

activity_label= read.table("activity_labels.txt")
train = cbind(train,train_labels)
test = cbind(test,test_labels)
names(train)[563] = "activities"
names(test)[563] = "activities"    #now we get a full table

#merge data
mergedData = rbind(train,test)


#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
indices_mean = grep("mean",names(mergedData))
indices_std = grep("std",names(mergedData))
indices = c(indices_mean,indices_std,562,563)
extracted_mergedData = mergedData[,indices]

#3.Uses descriptive activity names to name the activities in the data set
activity_code = 0
for(i in 1:nrow(extracted_mergedData)){
  activity_code = extracted_mergedData$activities[i] 
  full_activity_name = as.character(activity_label[activity_code,2])
  extracted_mergedData$activities[i] = full_activity_name
}


#4-2 correct some names
#identified the typos that some abbreviations contain "BodyBody" rather than "Body"
#use gsub() to correct these typo
old_names = names(extracted_mergedData)
new_names = gsub("BodyBody","Body",old_names)
names(extracted_mergedData) = new_names

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#get how many different subjects:
nsub = length(unique(tmp$subjects))

final_output =  data.frame();
for(i in 1:nsub){
  sub = tmp[tmp$subjects==i,]
  num_col = ncol(sub)
  output= cbind(rep(i,times =6),c("Laying","Sitting","Standing","Walking","Walking_Downstairs","Walking_Upstairs"))
  for(j in 1:(num_col-2)){
    output = cbind(output,tapply(sub[,j],INDEX = sub$activities,mean))
  }
  names(output) = c("subjects","activities",names(tmp)[1:79])
  final_output = rbind(final_output,output)
}
names(final_output) = c("subjects","activities",names(tmp)[1:79])

##write the table into directory
write.table(x=final_output, file = "FINAL_OUTPUT.txt",row.names = FALSE)
