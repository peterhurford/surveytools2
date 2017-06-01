#' Get the names from a dataframe that match a pattern.
#' @param df dataframe. The dataframe to search the names of.
#' @param pattern character. The pattern to search for.
#' @param ... list. Additional arguments to send to grep.
#' @export
get_vars <- function(df, pattern, ...) {
  grep(pattern, names(df), value = TRUE, ...)
}
