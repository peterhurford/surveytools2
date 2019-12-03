#' Convert all NAs in a vector to 0.
#' @export
nas_are_zeros <- function(x) { ifelse(is.na(x), 0, x) }

#' Convert all NAs in vector to FALSE.
#' @export
nas_are_false <- function(x) { ifelse(is.na(x), FALSE, x) }
