==================================================================
Getting and Cleaning Data - Final Project
==================================================================
By: Jaime Hernandez
==================================================================

This repository contains my submission to meet the Data Science Coursera requirements for the Getting and Cleaning Data Course.

As instructed, the following dataset was used for the project:

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In addition to this README, this repository includes the following files:

	CodeBook.md - Describes all the data transformations and variables that were changed
		      for this project (in run_analysis.R), as well as all other relevant information.

	run_analysis.R - Performs the followin g5 steps as instructed:

		1. Merges the training and the test sets to create one data set.
		2. Extracts only the measurements on the mean and standard deviation for each measurement.
		3. Uses descriptive activity names to name the activities in the data set
		4. Appropriately labels the data set with descriptive variable names.
		5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	
	avg_dataset.txt - Final text file with the summarized, average tidy data for means and standard deviation calculations grouped by actvity and subject
