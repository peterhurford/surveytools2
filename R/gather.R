#' Gets the vector of a particular variable within a dplyr postgres table.
#'
#' @param pt postgres.  The postgres table.
#' @param variable character. The name of the variable to gather.
#' @export
gather <- function(pt, ...)
  pt %>% dplyr::select_(lazyeval::lazy_dots(...)[[1]]) %>% collect %>%
    .[[1]] %>% unique
