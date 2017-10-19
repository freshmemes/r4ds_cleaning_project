# library the necessary packages

library(stringr)
library(readr)

# read in the necessary files

y_test <- read_table("dataset/test/y_test.txt", col_names = F)
X_test <- read_table("dataset/test/X_test.txt", col_names = F)
subject_test <- read_table("dataset/test/subject_test.txt", col_names = F)
y_train <- read_table("dataset/train/y_train.txt", col_names = F)
X_train <- read_table("dataset/train/X_train.txt", col_names = F)
subject_train <- read_table("dataset/train/subject_train.txt", col_names = F)

