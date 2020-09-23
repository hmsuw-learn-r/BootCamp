# Create draws for curve in the simple data set
# ==============================================================================
library(readr)

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
draws = data.frame(
  outer(x*slope + sin(x), intercept, FUN = "+")
)
names(draws) <- paste0("y_", 1:num_draws)

data = cbind(info, draws)

# save data
# ------------------------------------------------------------------------------
write_csv(data, "draws.csv")
