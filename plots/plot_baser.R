# Plot simulated data set using BaseR
# ==============================================================================

# refresh environment
rm(list = ls())

# load data set
# ------------------------------------------------------------------------------
df <- read.csv("../data/simulated_data.csv")
num_obs <- dim(df)[1]
num_groups <- length(unique(df$group_id))

# plot the data set
# ------------------------------------------------------------------------------
colors <- hcl.colors(num_groups, palette = "Dark2", alpha=0.5)
normal_font_size <- 0.8
title_font_size <- 1

pdf("baser_figure.pdf", width = 8, height = 5)
with(df, plot(x, y, main = "simulated data",
              pch = 19, cex = 0.2/y_se, col = colors[group_id], tck = -0.02,
              cex.main = title_font_size,
              cex.lab = normal_font_size,
              cex.axis=normal_font_size))
grid()
legend("topleft", legend = paste("group ", 1:num_groups),
       bty = "n", col = colors, pch = 19, cex = normal_font_size)
