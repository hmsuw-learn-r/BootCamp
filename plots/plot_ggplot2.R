# Plot simulated data set using BaseR
# ==============================================================================

# refresh environment
rm(list = ls())
library(ggplot2)

# load data set
# ------------------------------------------------------------------------------
df <- read.csv("../data/simulated_data.csv")
num_obs <- dim(df)[1]
num_groups <- length(unique(df$group_id))

# plot the data set
# ------------------------------------------------------------------------------
png("ggplot2_figure.png", width=6, height=4, units="in", res=500)
ggplot(data = df) +
  geom_point(mapping = aes(x = x, y = y,
                           color = factor(group_id),
                           size = 0.2/y_se, alpha=0.5)) +
  guides(alpha = FALSE, color = guide_legend("group")) +
  ggtitle("Simulated Data")
