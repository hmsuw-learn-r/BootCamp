# Create draws for curve in the simple data set
# ==============================================================================

# problem settings
# ------------------------------------------------------------------------------
num_points <- 50
num_groups <- 4
num_draws <- 20

x_range <- c(0.0, 2.0*pi)
slope_range <- c(0.0, 2.0)
intercept_range <- c(-0.5, 0.5)

# create draws
# ------------------------------------------------------------------------------
x <- rep(seq(x_range[1], x_range[2], length.out = num_points),
         times = num_groups)
slope <- rep(seq(slope_range[1], slope_range[2],
                 length.out = num_groups),
             each = num_points)
intercept <- seq(intercept_range[1], intercept_range[2],
                 length.out = num_draws)
group_id <- rep(1:num_groups, each=num_points)

info = data.frame(
  x = x,
  group_id = group_id
)
draws = data.frame(
  outer(x*slope + sin(x), intercept, FUN = "+")
)