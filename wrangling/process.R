# Simple data wrangling
# ==============================================================================
# refresh the environment
rm(list = ls())
library(readr)
library(dplyr)

# load data
# ------------------------------------------------------------------------------
df <- read.csv("../data/simulated_data.csv")
df <- read_csv("../data/simulated_data.csv")

# load data with missing values
# ------------------------------------------------------------------------------
df_missing <- read_csv("missing_data1.csv")
df_missing <- read_csv("missing_data2.csv", na = ".")

# filter data
# ------------------------------------------------------------------------------
df_filter <- filter(df_missing, !(is.na(y) | is.na(y_se)))
df_filter <- filter_all(df_missing, all_vars(!is.na(.)))

# sort data
# ------------------------------------------------------------------------------
df_sort <- arrange(df, x)
df_sort <- arrange(df, desc(x))
df_sort <- arrange(df, group_id, x)

# add new columns
# ------------------------------------------------------------------------------
df_add <- mutate(df, sin_x = sin(x))
df_add <- mutate(df, sin_x = sin(x), cos_x = cos(x))

# save data
# ------------------------------------------------------------------------------
write.csv(df_add, "modified_data.csv")
write.csv(df_add, "modified_data.csv", row.names = FALSE)
write_csv(df_add, "modified_data.csv")
