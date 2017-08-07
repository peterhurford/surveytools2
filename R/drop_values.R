#' Drop values from a variable.
#'
#' @param x vector. The vector to drop values from.
#' @param values list. A list of values to drop.
#' @param to_na logical. If to_na is FALSE, values will be fully dropped instead of converted to NA.
#' @export
drop_values <- function(x, values, to_na = TRUE) {
  for (value in values) {
    if (isTRUE(to_na)) {
      x[x == value] <- NA
    } else {
      x <- x[x != value]
    }
  }
  x
}
