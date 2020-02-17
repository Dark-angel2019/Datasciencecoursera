Getting and cleaning data course assignment 

Step 1: Understanding the data being provided.
 
The data have been provided in the form of various .txt files. The process explained below focus on the "test" data. The process for "train" would be equivalent. 

The labels to the data are scattered in "activity_label.txt" which lists the corresponding numbers for activities being carried out by the subject. "y_text.txt" shows which activity (by numbers) is being carried out. "subject_text.txt" lists out the subject who performed the test. "feature_info.txt" shows lists out the colume names for "X_test.txt" (the file that contains the observations).

"features.txt" is also read and stored as "feature" for further reference later. 

Step 2: Extracting the relevant data
Function read.table was used on the "subject_test.txt" (subject), "y_test.txt"  (activity label) and "X_test.txt". Each file has 2946 rows with X_test having 561 columes corresponding to the list in "feature_info.txt". 

This process is repeated for "train". 

Step 3: Combining data
Both test and train set were combined with subject and activity labels extracted above increasing each data frame to 563 columns. 

The column names were then changed to "subject", "activity" and number from 1 to 561 for ease of reference back to "feature". 

Then, "train" and "test" are then merged into "fullset" resulting in a data frame of 10297 rows and 563 columns. 

This completes the 1st requirement of the assignment - "Merges the training and the test sets to create one data set."


Step 4: extracting mean and SD
With the combined dataset, "grep" is used to identify the locations of the variables that represent mean and stand deviation in "feature.txt" file. The names of these variables are also extracted as characters from this file. 

Applying sub-setting, relevant columns are then selected by column number ("sub_set"). Column numbers had to be adjusted by 2 due to additional columns in the dataset. 

An additional "original_positions" column was added in order to track the locations of the variables so that I could check later that merger has not overridden values. 

Step 5: use descriptive activity names
"activity_labels.txt" is imported and merged with the current dataset ("sub_set") so that activity descriptions are incorporated with look-up. Tracking "original_position" has provided comfort at look-up has worked. The output here is "sub_set2" which adds activity description ("activity_desc") as an additional column. 

Step 6: use descrptive variable (colume) names
"feature_select" from step 4 has the actual names of the variables in the same order as the extraction of columns in the same step. It is used to update column names in sub_set2. 

Step 7:  calculate the average of each variable for each subject and each activity
Sub_Set2 is grouped by activity code and subject code. Then mean is calculated for each combination. The "activity desc" column was dropped for not being numeric so it was added back. 

Step 8: .txt file exported. 
