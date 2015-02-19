#' Renames values within a dataframe based on a list of swaps to make.
#' Useful for imputation.
#'
#' @param df data frame.  The data to be transformed.
#'
#' @param variable character. The name of the variable in df where the replacement occurs.
#'
#' @param swap_list list. A list mapping current values to what they should be.
#' e.g., to replace all instances of "dog" with "cat", use
#' \code{list('dog' = 'cat')}
#'
#' @export
swap_by_value <- function(df, variable, swap_list) {
  sapply(names(swap_list), function(x) {
    df[df[[variable]] == x, variable] <<- swap_list[[x]]
  })
  df
}
