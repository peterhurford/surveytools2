#' Reverse code a variable.
#'
#' @param variable. The varaible to recode.
#' @export
reverse_code <- function(variable) {
  if (!is.numeric(variable)) {
    stop("Only numeric variables can be reverse coded.")
  }
  scale <- sort(Filter(Negate(is.na), unique(variable)))
  flipped <- paste0(rev(scale), "_")
  for (i in seq_along(scale)) {
    variable[variable == scale[[i]]] <- flipped[[i]]
  }
  for (i in seq_along(scale)) {
    variable[variable == flipped[[i]]] <- gsub("_", "", flipped[[i]])
  }
  as.numeric(variable)
}
