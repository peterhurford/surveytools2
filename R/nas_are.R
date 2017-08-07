#' Convert all NAs in a vector to 0.
#' @export
nas_are_zeros <- function(x) { ifelse(is.na(x), 0, x) }
