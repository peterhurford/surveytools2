#' @export
num_na <- function(x) { sum(is.na(x)) }

#' @export
num_over_zero <- function(x) { sum(x > 0) }

get_varname <- function(dot) {
  if (identical(class(dot), "lazy")) { capture.output(dot$expr) }
  else { dot }
}
