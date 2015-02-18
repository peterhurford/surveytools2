#' Gets the names of a dplyr postgres table.
#'
#' @param pt postgres.  The postgres table.
#' @export
get_names <- function(pt) pt %>% head %>% names
