#===============================================================================
# Simple data set for boot camp 2020
#===============================================================================
# refresh environment
rm(list = ls())

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
write.csv(df, "simulated_data.csv", row.names = FALSE)
