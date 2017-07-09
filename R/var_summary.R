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
#' @param verbose logical. Return even more data about the variable, false to not (default)
#' @return the class and size of the variable.
#'    The mean, median, min, max, and SD of the variable if it is numeric.
#'    A table, head, and tail of the variable if it is not numeric.
#' @export
var_summary <- function(variable, na.rm = TRUE, verbose = FALSE) {
  o <- list()
  funs <- c('mean', 'median', 'min', 'max', 'sd')
  if (verbose) { funs <- c(funs, 'length', 'sum', 'num_na', 'num_over_zero') }
  for (fun in funs) { o[[fun]] <- do.call(do_or_na, list(fun, variable, na.rm)) }

  if (is.na(o$mean)) {
    funs <- c('table')
    if (verbose) { funs <- c(funs, 'head', 'tail', 'num_na') }
    for (fun in funs) { o[[fun]] <- do.call(fun, list(variable)) }
  }


  o <- o[!is.na(o)]
  if (!("table" %in% funs)) { unlist(o) } else { o }
}

do_or_na <- function(method, variable, na.rm = TRUE) {
  if (is.numeric(variable)) {
    tryCatch(
      { do.call(method, list(variable, na.rm = na.rm)) },
      error = function(e) { do.call(method, list(variable)) }
    )
  }
  else { NA }
}
