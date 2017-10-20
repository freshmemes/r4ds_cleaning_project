# Data Cleaning Project CodeBook #

This codebook pertains to the course project for [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/welcome). It summarizes the transformations performed on the file within `dataset/` by the `run_analysis.R` script to produce the tidy dataset in `results.csv`.

## Transformations ##

In a nutshell, `run_analysis.R` performs the following transformations:

 - [x] Merges the training and the test sets to create one data set.
 - [x] Extracts only the measurements on the mean and standard deviation for each measurement.
 - [x] Uses descriptive activity names to name the activities in the data set
 - [x] Appropriately labels the data set with descriptive variable names.
 - [x] From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Details ##

In more detail, `run_analysis.R` performs the transformations as outlined below. Please note that notes also reside inside the R script; each major transformation is documented with inline comments.

1. Loaded useful packages and their dependencies: `tidyverse`, `stringr`, `readr`, and `forcats`.

2. Read the following files and stored each within its own data frame:

  * `dataset/test/y_test.txt`
  * `dataset/test/X_test.txt`
  * `dataset/test/subject_test.txt`
  * `dataset/train/y_train.txt`
  * `dataset/train/X_train.txt`
  * `dataset/train/subject_train.txt`
  * `dataset/features.txt`
  
3. Vertically combined the `test` data frames with their `train` analogs.

4. Horizontally merged the `y`, `X`, and `subject` data frames into one master data frame called `df`.

5. Renamed the `y` column to `activity` and recoded the factors (numbers 1-6) with the corresponding activity labels provided by `dataset/activity_labels.txt`.

6. Gathered the 561 `X` columns as their values each correspond to a statistic aka "feature", resulting in the `feature` column to denote which statistic was represented by each observation.

7. At this point, the `subject`, `activity`, and `feature` columns have all been turned into factors as they have a limited number of levels (30, 6, and 561, respectively).

8. Separated the raw values from `features.txt` into two columns so as to create a lookup map, with each number from `1` to `561` corresponding to the name of its statistic.

9. Replaced the numbers in `df$feature` with the corresponding names, calling this newly modified version of the data frame `df2`.

10. Filtered `df2` to only contain observations for which `feature` contained the expressions `mean` and `std`.

11. Summarized the data set, grouping by each subject, activity, and feature, to show the average of each feature. Stored this in a new data frame `df3`.

12. Wrote `df3` to `results.csv`.