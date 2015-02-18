#' Gets the vector of a particular variable within a dplyr postgres table.
#'
#' @param pdf data frame.  The data to be transformed.
#'
#' @param variable character. The name of the variable to gather.
#'
#' @export
gather <- function(pdf, ...)
  pdf %>% dplyr::select_(lazyeval::lazy_dots(...)[[1]]) %>% collect %>%
    .[[1]] %>% unique
