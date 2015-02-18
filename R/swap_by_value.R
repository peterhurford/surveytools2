#' Renames values within a dataframe.
#'
#' @param df data frame.  The data to be transformed.
#'
#' @param variable character. The name of the variable in df where the replacement occurs.
#'
#' @param swap_list list. A list mapping current values to what they should be.
#' e.g., to replace all instances of "dog" witih "cat", use
#' \code{list('dog' = 'cat')}
#'
#' @export
swap_by_value <- function(df, variable, swap_list) {
  sapply(names(swap_list), function(x) {
    df[df[[variable]] == x, ] <<- swap_list[[x]]
  })
  df
}
