Hello my peers in Getting And Cleaning Data!
--------------------
In this document, I will briefly introduce how I did this assignment through each step given by our instructor.

And in the end, I'll include a CodeBook for the variable names in the R scripts



To begin with, after downloading the .zip file to my local directory, I unzipped it first whereby I can use simple read.table()
function to read the files. After loading the concerned files, I immediately named the columns of the X-test and X-train tables;
Moreover, I added a column indicating the subject and another column indicating the activities to the right of the two X-files.
To visualize what I did, just imagine X-test and X-train to be two blocks with each contains all the data in the left 99% area while
another two columns concerning the subjects and the activities to the right of the block.
Then, in order to merge the data, instead of applying merge(), I used rbind to put the block of X_train to the bottom of the block
X-file. Save the merged table in "mergedData"

After merging the files, I use grep() function to help me identify the columns with names containing "mean" or "std", and extract
those target columns via basic subsetting syntax: extracted_mergedData = mergedData[,indices] where indices representing the specific
index of columns we are concerned about.

Well, I'm now moving to step 3. Since the activity code (1,2,3,4,5,6) has a one-to-one relationship with the full name of that 
activity, just by for loop, it is natural to assign the corresponding full name in the codebook for activities to the "code" appeared
in the original table.

Now, it is the time for step 4. Since I have already named the columns right after I loaded the tables, in this step, I will then
correct some typos in the names. Obviously, these typos are "BodyBody" appeared in some column names.
Therefore, I applied gsub("BodyBody","Body",old_names) to replace the typos.

Finally, we came to step 5.
The first thing I did in this step, is to split the rows by the subjects. In other words, every subject is seperated into a "block"
containing all the data and descriptions. And in each block, I used tapply function to get the mean of each columns regarding different
levels - in this case, the activities. And using nested for loop, I get the mean for every columns and every block of subject.
(cbind mean of each columns and after getting all the means ready for one subject, store them in a block for this subject. 
Apply this method to every subject, and right after we got one subject block ready, rbind it to the former subject block.)

The tidy table is stored in "final_output".
And in the end, use write.table() to write the file.
----------------------------------------------
*activity_label: store the CodeBook of the activity list.
*features_561: store the names of each column
*final_output: store the final tidy table
*subject_test: store the subjects of the group:test
*subject_train: store the subjects of the group:train
*test: read and store the file: X_test.txt
*train: read and store the file X_train.txt
*test_labels: store the activity code for the group:test
*train_labels: store the activity code for the group: train
*indices_mean: store the indices of the columns that contain keyword “mean”
*indices_std: store the indices of the columns that contain keyword “std”
*indices: the concatenation of indices-mean and indices-std
*mergedData: the table after merging two tables
*extracted_mergedData: the table after extracting the "mean" and "std" columns from the mergedData
*old_names: store the names of the orginal table after extracting with some typops
*new_names: store the names after correcting all those typos
*nsub: store the total number of subjects, namely, 30

---------------------------------------------
Thank you my peers!
And Good Luck to you!
Best wishes.
