#' Prints a summary of the dataframe.
#' @param df dataframe. The dataframe to summarize.
#' @param ... list. Additional args to pass to var_summary.
#' @export
data_summary <- function(df, ...) {
  lapply(df, function(var, ...) var_summary(var, ...))
}

#' Prints a summary of the variable.
#'
#' @param variable character. The variable to summarize.
#' @param na.rm logical. True to not return NAs (default), false to return NAs.
#' @param serialize logical. True to join lists into serialized strings, false to not (default)
#' @return the class and size of the variable.
#'    The mean, median, min, max, and SD of the variable if it is numeric.
#'    A table, head, and tail of the variable if it is not numeric.
#' @export
var_summary <- function(variable, na.rm = TRUE, serialize = FALSE) {
  o <- list()
  varclass <- class(variable[1])
  o$class <- varclass
  o$N <- length(variable)

  funs <- c('mean', 'median', 'min', 'max', 'sd', 'sum')
  for (fun in funs) { o[[fun]] <- do.call(do_or_na, list(fun, variable, na.rm)) }

  funs <- c('table', 'head', 'tail')
  for (fun in funs) { o[[fun]] <- do.call(try_serialized, list(fun, variable, serialize)) }
  o[!is.na(o)]
}

do_or_na <- function(method, variable, na.rm = TRUE) {
  if (is.numeric(variable)) { do.call(method, list(variable, na.rm = na.rm)) }
  else { NA }
}

try_serialized <- function(method, variable, serialize) {
  m <- do.call(method, list(variable))
  if (isTRUE(serialize)) {
    if (identical(method, table)) {
      if (length(m) == 0) { return(NA) }
      if (length(m) > 5) { return(paste0("<", length(m), " values>")) }
      o <- c()
      for (i in seq(length(m))) {
        o <- c(o, names(m)[[i]], m[[i]]) 
      }
      paste0(o, collapse = " ")
    } else { paste0(m, collapse = " ") }
  } else { m }
}
