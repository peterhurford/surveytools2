#' Makes a fancy table, inspired from `tab` from STATA.
#'
#' @param .data data frame. The data to put in the table.
#' @param ... The variables to plot in the table, plus any relevant filters contained within `filters()`. Currently supports one or two variables.
#' @param top numeric. If >0, all vectors will only print the top N elements and all other elements will be called "Other", where N is the value for top.
#' @param freq logical. If TRUE, frequencies are printed in the table.
#' @param percent logical. If TRUE, percentages are printed in the table.
#' @param byrow logical. If TRUE, percentages are row percentages.  If false, column percentages.  If NULL, individual cell percentages.
#' @param sort logical. If TRUE, the resulting table is sorted (if possible).
#' @param sort.decreasing logical. If TRUE, the sort is preformed in a descending manner.
#' @param na.rm logical. If TRUE, all NAs and NA-like entries are removed from the data before tabling.
#' @export
tab <- function(.data, ..., top = 0, freq = TRUE, percent = FALSE, byrow = TRUE,
                sort = TRUE, sort.decreasing = TRUE, na.rm = FALSE) {
  dots <- lazyeval::lazy_dots(...)
  filter_data <- apply_filters(.data, dots)
  .data <- filter_data$data
  dots <- filter_data$dots
  .print_filters <- filter_data$print_filters

  tab_(.data, .dots = dots, top = top, freq = freq, percent = percent,
       byrow = byrow, sort = sort, sort.decreasing = sort.decreasing,
       na.rm = na.rm, .print_filters = .print_filters)
}

#' @export
tab_ <- function(.data, .dots, top = 0, freq = TRUE, percent = FALSE, byrow = TRUE,
                  sort = TRUE, sort.decreasing = TRUE, na.rm = FALSE, .print_filters = NULL) {
  if (!isTRUE(freq) & !isTRUE(percent)) {
    stop("No frequency and no percent makes for a blank table.")
  }
  l <- lapply(.dots, function(d) {
    if (d %is% lazy) { lazyeval::lazy_eval(d, data = .data) }
    else if (is.character(d)) { .data[[d]] }
    else { stop("Class not recognized") }
  })
  if (top > 0) {
    l <- lapply(l, function(x) {
      freqs <- as.list(table(x))
      top_names <- names(sort(unlist(freqs), decreasing = TRUE))[seq(top)]
      x[x %not_in% top_names] <- "Other"
      x
    })
  }
  if (isTRUE(na.rm)) {
    nas <- Reduce(`&`, lapply(l, Negate(is.na_like)))
    l <- lapply(l, `[`, nas)
  }
  l <- lapply(l, function(x) { if (is.factor(x)) { droplevels(x) } else { x }})
  t <- do.call(table, c(l, useNA = if (isTRUE(na.rm)) { "no" } else { "ifany" }))
  t <- if (isTRUE(percent)) {
    if (length(dim(t)) == 1) byrow <- NULL
    if (!is.null(byrow)) { byrow <- if (isTRUE(byrow)) 1 else 2 }
    pt <- prop.table(t, byrow) %>% round(digit = 4)
    if (isTRUE(freq) & length(.dots) > 2) {
      warning("tab does not yet support frequency and percent crosstabs with more than two variables. Switching to percent only.")
      freq <- FALSE
    }
    if (isTRUE(freq)) {
      o <- NULL
      for (i in seq(t)) o <- c(o, paste0(t[[i]], " (", pt[[i]] * 100, "%)"))

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
  class(t) <- c("tab", "list")
  attr(t, "left_var") <- get_varname(.dots[[1]])  # Store the variable names for printing
  if (length(.dots) > 1) { attr(t, "upper_var") <- get_varname(.dots[[2]]) }
  attr(t, "na.rm") <- na.rm
  attr(t, "filters") <- .print_filters
  t
}

#' @export
print.tab <- function(x) {
  cat(attr(x, "left_var"));
  if (!is.null(attr(x, "upper_var"))) { cat(" ### "); cat(attr(x, "upper_var")) }
  if (isTRUE(attr(x, "na.rm"))) { cat(" (nas removed)") }
  cat("\n")
  if (!is.null(attr(x, "filters"))) {
    cat("Filters: ", attr(x, "filters"), "\n")
  }
  print.table(x)
}

#' Sort a tab.
#' When both frequencies and percentages are displayed, the table can be hard to sort.
#' @export
sort.tab <- function(x, decreasing = FALSE) {
  if ('character' %in% class(x)) {
    o <- order(sapply(x, function(x) as.integer(strsplit(x, " ")[[1]][[1]])))
    if (isTRUE(decreasing)) x[rev(o)] else x[o]
  } else {
    warning("Matrix tab cannot be sorted.")
    x
  }
}
