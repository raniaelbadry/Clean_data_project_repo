## Summary

The goal of this project is to create a tidy data data set using R to analyse experimental results in the Human Activity Recognition Using Smartphones(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) study.

`run_analysis.R` script should be run on the above data and perform the below steps:

 1. Merges the training and the test sets to create one data set.
 2. Extracts only  measurements on the mean and standard deviation. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names. 
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable.

## Repo info

This repository contains 3 main files:

 - `run_analysis.R` - This script is used to perform the analysis on the required sample data.
 - `tidy.txt` - This is the final cleansed output from the `run_analysis.R` script. 
 - `CodeBook.md` - Contains columns definition in generated `tidy.txt` file.