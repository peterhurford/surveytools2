#' Makes a fancy table, using dplyr-like syntax, but inspired from `tab` from STATA.
#' Try to make Hadley proud.
#'
#' @param .data data frame. The data to put in the table.
#' @param ... The variables to plot in the table. Currently supports one or two variables.
#' @param freq logical. If true, frequencies are printed in the table.
#' @param percent logical. If true, percentages are printed in the table.
#' @param byrow logical. If true, percentages are row percentages.  If false, column percentages.  If NULL, individual cell percentages.
#' @param sort logical. If true, the resulting table is sorted (if possible).
#' @param sort.decreasing logical. If true, the sort is preformed in a descending manner.
#' @param na.rm logical. If true, all NAs and NA-like entries are removed from the data before tabling.
#' @export
dplyr_table <- function(.data, ..., freq = TRUE, percent = FALSE, byrow = TRUE, sort = TRUE, sort.decreasing = TRUE, na.rm = FALSE)
  dplyr_table_(.data, .dots = lazyeval::lazy_dots(...), freq = freq, percent = percent, byrow = byrow, sort = sort, sort.decreasing = sort.decreasing, na.rm = na.rm)

#' @export
dplyr_table_ <- function(.data, .dots, freq = TRUE, percent = FALSE, byrow = TRUE, sort = TRUE, sort.decreasing = TRUE, na.rm = FALSE) {
  if (!isTRUE(freq) & !isTRUE(percent)) stop('No frequency and no percent makes for a blank table.')
  t <- do.call(table, lapply(.dots, function(d) {
    dd <- if (identical(class(d), 'lazy')) .data[[as.character(d$expr)]]
    else if (is.character(d)) .data[[d]]
    else stop('Class not recognized')
    if (isTRUE(na.rm)) dd <- na.rm(dd)
    dd
  }))
  if (isTRUE(percent)) {
    if (length(dim(t)) == 1) byrow <- NULL
    if (!is.null(byrow)) { byrow <- if (isTRUE(byrow)) 1 else 2 }
    pt <- prop.table(t, byrow) %>% round(digit = 4)
    if (isTRUE(freq) & length(.dots) > 2) {
      warning("Dplyr table does not yet support frequency and percent crosstabs with more than two variables. Switching to percent only.")
      freq <- FALSE
    }
    if (isTRUE(freq)) {
      o <- NULL
      for (i in seq(t)) o <- c(o, paste0(t[[i]], " (", pt[[i]] * 100, "%)"))
      class(o) <- c('surveytools2_dplyr_table', class(o))
      if (length(dim(t)) > 1) {
        o <- matrix(o, dim(t)[[1]], dim(t)[[2]])
        dimnames(o) <- dimnames(t)
      } else {
        names(o) <- rownames(t)
        if (isTRUE(sort)) o <- sort(o, decreasing = sort.decreasing)
      }
      o
    } else {
      if (isTRUE(sort) & length(dim(pt)) == 1) pt <- sort(pt, decreasing = sort.decreasing)
      pt
    }
  } else {
    if (isTRUE(sort) & length(dim(t)) == 1) t <- sort(t, decreasing = sort.decreasing)
    t
  }
}

#' Print the table without annoyingly displaying the class.
#' @export
print.surveytools2_dplyr_table <- function(x) {
  class(x) <- NULL
  print(x)
}

#' Sort a dplyr table.
#' When both frequencies and percentages are displayed, the table can be hard to sort.
#' @export
sort.surveytools2_dplyr_table <- function(x, decreasing = FALSE) {
  if ('character' %in% class(x)) {
    o <- order(sapply(x, function(x) as.integer(strsplit(x, " ")[[1]][[1]])))
    if (isTRUE(decreasing)) x[rev(o)] else x[o]
  } else {
    warning("Matrix dplyr_table cannot be sorted.")
    x
  }
}
