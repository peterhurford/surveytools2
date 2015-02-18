#' Gets the vector of a particular variable within a dplyr postgres table.
#'
#' @param pt postgres.  The postgres table.
#' @param variable character. The name of the variable to gather.
#' @export
add_prefix_to_table_names <- function(df, prefix, except = NULL) {
  df %>% get_names %>% as.list -> l
  lapply(l, function(x) paste0(prefix, x)) -> names(l)
  l[l %in% except] <- NULL
  df %>% rename_(.dots = l)
}
