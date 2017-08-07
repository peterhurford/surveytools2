#' Calculate the number of positive values in a variable.
#'
#' @param x numeric. The variable to calculate.
#' @param na.rm logical. Whether or not to remove NAs when calculating the sum.
#' @export
num_over_zero <- function(x, na.rm = FALSE) { sum(x > 0, na.rm = na.rm) }
