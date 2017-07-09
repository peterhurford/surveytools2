#' Get the names from a dataframe that match a pattern.
#' @param df dataframe. The dataframe to search the names of.
#' @param pattern character. The pattern or patterns to search for.
#' @param collapse logical. When using multiple patterns, whether to return
#'    as one list (collapse = TRUE) or as multiple lists (FALSE, default).
#' @param ... list. Additional arguments to send to grep.
#' @export
get_vars <- function(df, pattern, collapse = FALSE, ...) {
  if (length(pattern) == 1) {
    grep(pattern, names(df), value = TRUE, ...)
  } else {
    r <- lapply(pattern, function(pat) { get_vars(df, pat, ...) })
    if (isTRUE(collapse)) { unlist(r) } else { r }
  }
}
