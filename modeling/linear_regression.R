# Simple linear regression
# ==============================================================================
rm(list = ls())
library(readr)
library(ggplot2)

# Load Data
# ------------------------------------------------------------------------------
df <- read_csv("data/simple_lm_data.csv")

# Plot Data
# ------------------------------------------------------------------------------
png("lm_data.png", width = 5, height = 4, units = "in", res = 500)
ggplot(data = df) +
  geom_point(mapping = aes(x = x, y = y, size = 0.2/y_se, alpha = 0.5),
             show.legend = FALSE)
dev.off()

# Fit Linear Model
# ------------------------------------------------------------------------------
linear_model <- lm(formula = y ~ x,
                   data = df,
                   weights = 0.5/y_se^2)
coefficients <- linear_model$coefficients

# Plot the result
# ------------------------------------------------------------------------------
png("lm_result.png", width = 5, height = 4, units = "in", res = 500)
ggplot(data = df) +
  geom_point(mapping = aes(x = x, y = y, size = 0.2/y_se, alpha = 0.5),
             show.legend = FALSE) +
  geom_abline(intercept = coefficients[1], slope = coefficients[2]) +
  geom_abline(intercept = 0.1, slope = 2.0, color = "red")
dev.off()
