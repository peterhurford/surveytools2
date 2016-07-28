#' Replace a value within a dataframe.
#' @param df datafarme. The dataframe to replace within.
#' @param col character. The name of the column to replace within.
#' @param expr expression. An expression of the values in the column to replace.
#' @param value object. The value positions where the expression is true become.
#' @export
replace <- function(df, col, expr, value) {
  df[with(df, eval(expr)), col] <- val
  df
}
