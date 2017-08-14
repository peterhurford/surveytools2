#' Deletes all NA and NA-like values from a vector.
#'
#' @param vec vector. The vector to clean.
#' @export
na.rm <- function(vec) {
  vec[!is.na_like(vec)]
}


#' Drops columns that are entirely NA from the dataframe.
#'
#' @param df data.frame. The dataframe to drop from.
drop_na_cols <- function(df) {
  Filter(function(x) !all(is.na(x)), df)
}


#' Determines if something is NA or NA-like (blank, the string "NA", or "N/A")
#' @param x. The vector to test.
#' @export
is.na_like <- function(x) {
  is.na(x) | x == "" | x == "NA" | x == "N/A"
}
