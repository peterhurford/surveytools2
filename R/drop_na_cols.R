#' Drops columns from the dataframe that meet a certain threshold of NAs.
#'
#' @param df dataframe.  The dataframe to drop from.
#' @param treshold integer.  If a column has this many percent of NAs or more, drop.
#' @export
drop_na_cols <- function(df, threshold = 0.7)
  df[which(sapply(df, function(col) { mean(is.na(col)) < threshold }))]
