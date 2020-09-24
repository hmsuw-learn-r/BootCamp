# Create draws for curve in the simple data set
# ==============================================================================
library(readr)
library(dplyr)

# problem settings
# ------------------------------------------------------------------------------
num_points <- 50
num_groups <- 4
num_draws <- 20

x_range <- c(0.0, 2.0*pi)
s_range <- c(0.0, 2.0)
i_range <- c(-0.5, 0.5)

# create draws
# ------------------------------------------------------------------------------
x <- rep(seq(x_range[1], x_range[2], length.out = num_points),
         times = num_groups)
s <- rep(seq(s_range[1], s_range[2], length.out = num_groups),
         each = num_points)
i <- seq(i_range[1], i_range[2], length.out = num_draws)
group_id <- rep(1:num_groups, each=num_points)

info = data.frame(
  x = x,
  group_id = group_id
)
draw_matrix = outer(x*s + sin(x), i, FUN = "+")
draws = data.frame(
  draw_matrix
)
draw_names <- paste0("y_", 1:num_draws)
names(draws) <- draw_names

draws_mean <- apply(draws, mean, MARGIN = 1)
draws_lower <- apply(draws, min, MARGIN = 1)
draws_upper <- apply(draws, max, MARGIN = 1)

raw_draws <- cbind(info, draws)
draws <- cbind(raw_draws, data.frame(y_mean = draws_mean,
                                     y_lower = draws_lower,
                                     y_upper = draws_upper))

# save data
# ------------------------------------------------------------------------------
write_csv(raw_draws, "data/raw_draws.csv")
write_csv(draws, "data/draws.csv")
