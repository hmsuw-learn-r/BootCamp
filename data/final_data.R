# This is the data for the final day exercise
# ==============================================================================
# clean the environment
rm(list = ls())

library(readr)
library(dplyr)
library(ggplot2)

# settings
# ------------------------------------------------------------------------------
set.seed(123)

num_groups <- 5L
num_ppg <- 50L
num_obs <- num_groups*num_ppg

x_range <- c(0, 2*pi)
# intercept
beta0_range <- c(-2, 2)
# slope
beta1_range <- c(0, 2)
# coefficients on sin(x)
beta2_range <- c(1, 1)
# coefficients on log(1 + x)
beta3_range <- c(0, 2)
# coefficients on x^2
beta4_range <- c(0.1, 0.1)
# standard error range
se_range <- c(0.1, 0.3)

# simulate data
# ------------------------------------------------------------------------------
x <- rep(seq(x_range[1], x_range[2], length.out = num_ppg), times = num_groups)
# covariates
intercept <- rep(1, times = num_obs) 
sin_x <- sin(x)
log_x <- log(1 + x)
x2 <- x^2
# coefficients
beta0 <- rep(seq(beta0_range[1], beta0_range[2], length.out = num_groups), each = num_ppg)
beta1 <- rep(seq(beta1_range[1], beta1_range[2], length.out = num_groups), each = num_ppg)
beta2 <- rep(seq(beta2_range[1], beta2_range[2], length.out = num_groups), each = num_ppg)
beta3 <- rep(seq(beta3_range[1], beta3_range[2], length.out = num_groups), each = num_ppg)
beta4 <- rep(seq(beta4_range[1], beta4_range[2], length.out = num_groups), each = num_ppg)
# observation
y_se <- runif(n = num_obs, min = se_range[1], max = se_range[2])
y <- intercept*beta0 + x*beta1 + sin_x*beta2 + log_x*beta3 + x2*beta4 +
  rnorm(n = num_obs, sd = y_se)

# create and save dataframe
# ------------------------------------------------------------------------------
data = data.frame(
  y = y,
  x = x,
  y_se = y_se,
  group_id = as.factor(rep(1:num_groups, each = num_ppg))
)

# mask data
num_na <- as.integer(0.05*num_obs)
masked_y <- y
masked_y_se <- y_se

data[sample(num_obs, size = num_na), "y"] <- NA
data[sample(num_obs, size = num_na), "y_se"] <- NA

# mask majority of group 3 data
data <- data[-(num_ppg*2 + sample(num_ppg, size = as.integer(0.95*num_ppg))),]

# save data
write_csv(data, "data/final_data.csv")


# plot the data
# ------------------------------------------------------------------------------
ggplot(data = data) +
  geom_point(mapping = aes(x = x, y = y,
                           size = 0.2/y_se, color = group_id),
             alpha = 0.5)

# attend to fit the data
# ------------------------------------------------------------------------------
data <- mutate(data,
               sin_x = sin(x),
               log_x = log(1 + x),
               x2 = x^2)

group_data <- group_split(data, group_id)

result <- lm(y ~ 1 + x + sin_x + log_x + x2, data = group_data[[1]])
