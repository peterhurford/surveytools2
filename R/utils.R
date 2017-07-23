#' @export
num_na <- function(x) { sum(is.na(x)) }

#' @export
num_over_zero <- function(x) { sum(x > 0) }

get_varname <- function(dot) {
  if (dot %is% "lazy") { capture.output(dot$expr) }
  else { dot }
}

get_base_varname <- function(dot) {
  if (dot %is% "lazy") {
    dot <- dot$expr
    if (length(dot) > 1) { dot <- dot[[2]] }
  }
  dot
}
