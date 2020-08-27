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
pdf("ggplot2_figure.pdf", width = 8, height = 5)
ggplot(data = df) +
  geom_point(mapping = aes(x = x, y = y,
                           color = factor(group_id),
                           size = 0.2/y_se, alpha=0.5)) +
  guides(alpha = FALSE, color = guide_legend("group")) +
  ggtitle("simulated data") + 
  scale_color_brewer(palette="Dark2")
