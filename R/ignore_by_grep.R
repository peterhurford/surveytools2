#' Drops all columns that match lists of regex strings.
#'
#' @param df dataframe. The dataframe to drop columns from.
#' @param ... lists. Lists containing regex strings to match against.
#' @param keep character. A vector of variable names to not drop, despite regex.
#' @export
ignore_by_grep <- function(df, ..., keep = NULL) {
  df %>% get_cols_by_greps(list(...)) -> cols

  if(!is.null(keep)) { cols <-
    c(cols, df %>% get_cols_by_greps(keep, whole = TRUE) %>%
      setdiff(seq_along(get_names(df)), .))
  }

  df %>% dplyr::select(cols)
}

map_greps <- function(x, names, whole = FALSE) {
  if (isTRUE(whole)) names <- lapply(names, function(x) paste0('\\b', x, '\\b'))
  purrr:::map(unlist(names), ~ !grepl(., x))
}

get_cols_by_greps <- function(df, names, whole = FALSE)
  df %>% get_names %>% .[Reduce('&', map_greps(., names, whole))] %>%
    match(., get_names(df))
