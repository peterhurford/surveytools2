#' Calculate the number of NAs in a variable.
#'
#' @param x variable. The variable to calculate the number of NAs for.
#' @export
num_na <- function(x) { sum(is.na(x)) }
