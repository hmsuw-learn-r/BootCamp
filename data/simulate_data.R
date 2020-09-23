# Simple data set for boot camp 2020
# ==============================================================================
# refresh environment
rm(list = ls())
library(readr)

# set random seed
# ------------------------------------------------------------------------------
set.seed(123)

# problem settings
# ------------------------------------------------------------------------------
num_points <- 50
num_groups <- 4
num_obs <- num_points*num_groups

x_range <- c(0.0, 2.0*pi)
slope_range <- c(0.0, 2.0)
y_se_range <- c(0.1, 0.5)

# create observations
# ------------------------------------------------------------------------------
x <- seq(x_range[1], x_range[2], length.out = num_points)
x <- rep(x, times = num_groups)

slope <- seq(slope_range[1], slope_range[2], length.out = num_groups)
slope <- rep(slope, each = num_points)

y_se <- runif(n = num_obs, min = y_se_range[1], max = y_se_range[2])
y_err <- rnorm(num_obs)*y_se
y <- sin(x) + slope*x + y_err

group_id <- factor(rep(1:num_groups, each=num_points))

# create and save data frame
# ------------------------------------------------------------------------------
df <- data.frame(y, y_se, x, group_id)
write_csv(df, "data/simulated_data.csv")

# create missing values and save data frame
# ------------------------------------------------------------------------------
num_na <- as.integer(0.1*num_obs)
masked_y <- y
masked_y_se <- y_se

masked_y[sample(num_obs, size = num_na)] <- NA
masked_y_se[sample(num_obs, size = num_na)] <- NA

df_missing <- data.frame(masked_y, masked_y_se, x, group_id)
colnames(df_missing) <- c("y", "y_se", "x", "group_id")
write_csv(df_missing, "data/missing_data1.csv", na = "")
write_csv(df_missing, "data/missing_data2.csv", na = ".")

# create simple linear regression data
# ------------------------------------------------------------------------------
num_points <- 100
intercept <- 0.1
slope <- 2
x <- seq(0, 1, length.out = num_points)
s <- runif(n = num_points, min = 0.1, max = 0.5)
e <- rnorm(n = num_points, sd = s)
y <- intercept + slope*x + e

df_simple <- data.frame(
  y = y,
  x = x,
  y_se = s
)
write_csv(df_simple, "data/simple_lm_data.csv")
