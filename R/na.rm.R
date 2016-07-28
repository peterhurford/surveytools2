#' Deletes all NA and NA-like values from a vector.
#'
#' @param vec vector. The vector to clean.
#' @export
na.rm <- function(vec) {
  vec[!is.na_like(vec)]
}


#' Determines if something is NA or NA-like (blank, the string "NA", or "N/A")
#' @param x. The vector to test.
#' @export
is.na_like <- function(x) {
  is.na(x) | x == "" | x == "NA" | x == "N/A"
}
