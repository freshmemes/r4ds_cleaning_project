# library the necessary packages
library(tidyverse)
library(stringr)
library(readr)
library(forcats)

# read in the necessary files; please set wd to this file's folder
y_test <- read_table("dataset/test/y_test.txt", col_names = F)
X_test <- read_table("dataset/test/X_test.txt", col_names = F)
subject_test <- read_table("dataset/test/subject_test.txt", col_names = F)
y_train <- read_table("dataset/train/y_train.txt", col_names = F)
X_train <- read_table("dataset/train/X_train.txt", col_names = F)
subject_train <- read_table("dataset/train/subject_train.txt", col_names = F)
features <- read_table("dataset/features.txt", col_names = F)

# stack test and train dfs
df_X <- bind_rows(X_test, X_train)
df_y <- bind_rows(y_test, y_train)
df_subject <- bind_rows(subject_test, subject_train)

df <- df_X %>% # join the above 3 dfs
  mutate(activity = as.factor(df_y$"X1"), subject = as.factor(df_subject$"X1")) %>%  # have to use "s to deal with "X1" as a common name
  select(subject, activity, X1:X561) %>% # reorder columns
  mutate(activity = fct_recode(activity, # recode factors to make activity descriptive
    "WALKING" = "1",
    "WALKING_UPSTAIRS" = "2",
    "WALKING_DOWNSTAIRS" = "3",
    "SITTING" = "4",
    "STANDING" = "5",
    "LAYING" = "6")) %>% 
  gather("feature", "value", X1:X561) %>% # gather the features
  mutate(feature = str_replace(feature, "X", "")) %>% # get rid of the "X" in the names so can easily substitute with descriptive
  mutate(feature = as.factor(feature)) # really just 561 levels, so turning into a factor

# split up the features tibble into key-value columns so as to create a lookup map
features <- features %>% 
  transmute(number = as.factor(str_extract(X1, "^([0-9]+)")), name = as.factor(str_extract(X1, "[^(0-9|\\ )].+")))

# replace features values 1-561 with their corresponding names
df2 <- df %>%
  left_join(features, by = c("feature" = "number")) %>% # joining in the features
  select(-feature) %>% 
  rename("feature" = name) %>% # replace numbers with names
  select (subject, activity, feature, value) %>% # reorder columns
  filter(grepl("mean|std", feature)) # filter to just mean and std features

# df2 is to serve as the answer to question 4.
# df3 is to serve as the answer to question 5.

df3 <- df2 %>% 
  group_by(subject, activity, feature) %>% 
  summarize(average = mean(value, na.rm = T))

# write df3 to a csv file called "results"
write_csv(df3, "results.csv")
