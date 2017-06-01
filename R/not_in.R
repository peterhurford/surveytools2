#' An infix operator for determining if values are not in a list.
#' @param x variable. The object to scan for membership.
#' @param table vector. A vector of objects to check against.
#' @export
`%not_in%` <- function(x, table) {
  !(`%in%`(x, table))
}
