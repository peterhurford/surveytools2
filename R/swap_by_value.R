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
#' @param grep logical. Should values be searched by grep (grep = TRUE) or just found by full name (default)?
#'
#' @export
swap_by_value <- function(df, variable, swap_list, grep = FALSE) {
  if ("" %in% names(swap_list)) {
    stop("Your swap_list is misconfigured. All elements of the swap_list must be named.")
  }
  if (isTRUE(grep)) {
    for (swap in names(swap_list)) {
      df[grepl(swap, df[[variable]]) & !is.na(df[[variable]]), variable] <- swap_list[[swap]]
    }
  } else {
    for (swap in names(swap_list)) {
      df[df[[variable]] == swap & !is.na(df[[variable]]), variable] <- swap_list[[swap]]
    }
  }
  df
}
