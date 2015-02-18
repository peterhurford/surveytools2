#' Adds a prefix to the names of a table.
#'
#' @param df dataframe.  The dataframe to change the names of.
#' @param prefix character. The prefix to add to the names.
#' @param except character. A vector of variables to not apply the prefix to.
#' @export
add_prefix_to_table_names <- function(df, prefix, except = NULL) {
  df %>% get_names %>% as.list -> l
  lapply(l, function(x) paste0(prefix, x)) -> names(l)
  l[l %in% except] <- NULL
  df %>% rename_(.dots = l)
}
