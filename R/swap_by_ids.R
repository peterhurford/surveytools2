#' Renames values within a dataframe based on ids.
#' Useful for imputation.
#'
#' @param df data frame.  The data to be transformed.
#'
#' @param variable character. The name of the variable in df where the replacement occurs.
#'
#' @param swap_list list. A list mapping ids to the desired value for that id.
#' e.g., to replace the value for id #233 with "cat", use
#' \code{list('233' = 'cat')}
#'
#' @export
swap_by_ids <- function(df, variable, swap_list) {
  sapply(names(swap_list), function(id) {
    df[df$id == id, variable] <<- swap_list[[id]]
  })
  df
}
