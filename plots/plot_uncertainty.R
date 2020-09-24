# Plot the uncertainty of the curves
# ==============================================================================
library(readr)
library(ggplot2)

# read data
# ------------------------------------------------------------------------------
draws = read_csv("data/draws.csv",
                 col_types = cols(group_id = col_factor()))
data = read_csv("data/simulated_data.csv",
                col_types = cols(group_id = col_factor()))

# plot the data, curve and curve uncertainty
# ------------------------------------------------------------------------------
ggplot(data = draws) +
  geom_point(data = data, mapping = aes(x = x, y = y,
                                        size = 0.2/y_se,
                                        color = group_id), alpha=0.5) +
  geom_line(mapping = aes(x = x, y = y_mean, color = group_id)) +
  geom_ribbon(mapping = aes(x = x, ymin = y_lower, ymax = y_upper,
                            fill = group_id), alpha=0.3) +
  coord_cartesian(ylim = c(-1.5, 1.5))

# ggsave("uncertainty.pdf")
