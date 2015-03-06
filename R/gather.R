#' Gets the vector of a particular variable within a dplyr postgres table.
#'
#' @param pt postgres.  The postgres table.
#' @param variable character. The name of the variable to gather.
#' @export
gather <- function(pt, ...)
  gather_(pt, lazyeval::lazy_dots(...)[[1]])

#' @export
gather_ <- function(.data, .dots)
  .data %>% dplyr::select_(.dots) %>% collect %>% .[[1]]
