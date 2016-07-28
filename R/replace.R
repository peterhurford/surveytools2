#' Replace a value within a dataframe.
#' @param df datafarme. The dataframe to replace within.
#' @param col character. The name of the column to replace within.
#' @param expr expression. An expression of the values in the column to replace.
#' @param value object. The value positions where the expression is true become.
#' @export
replace <- function(df, col, expr, value) {
  expr <- substitute(expr)
  col <- deparse(substitute(col))  #TODO: only substitute if not already a string. Also check that column exists.
  df[with(df, eval(expr)), col] <- value
  df
}
