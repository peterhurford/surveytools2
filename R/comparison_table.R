#' Compares a variable across a group, both visually and with an appropriate statistical test.
#'
#' @param data data frame. The data to test.
#' @param variable. If character, the name of the variable to test.
#' @param groupby character. If character, the name of the variable to group `variable` by.
#' @param type character. "Continuous" if `variable` is continuous data (like age), or "categorical" / "discrete" if `variable` is categorical data (like hometown).
#'   This can be automatically inferred by whether the variable is numeric or not.
#' @param na.rm logical. Whether or not to remove NAs from the variables being considered.
#' @param top numeric. See documentation for `tab`.
#' @aliases ctable ctab
#' @export
comparison_table <- function(data, variable, groupby, type = NULL, na.rm = FALSE, top = 0) {
  variable <- lazyeval::as.lazy(substitute(variable))
  groupby  <- lazyeval::as.lazy(substitute(groupby))
  comparison_table_(data, variable, groupby, type = type, na.rm = na.rm, top = top)
}

#' @import checkr magrittr
comparison_table_ <- checkr::ensure(
  pre = list(data %is% dataframe,
    variable %is% simple_string || variable %is% lazy,
    groupby %is% simple_string || groupby %is% lazy,
    type %is% NULL || type %in% c("continuous", "discrete", "categorical"),
    na.rm %is% logical,
    top %is% numeric, top >= 0
  ),
  function(data, variable, groupby, type = NULL, na.rm = FALSE, top = 0) {
    if (variable %is% lazy) {
      x <- lazyeval::lazy_eval(variable, data = data)
      y <- lazyeval::lazy_eval(groupby, data = data)
    } else {
      x <- data[[variable]]
      y <- data[[groupby]]
    }

    if (isTRUE(na.rm)) {
      x_ <- x[!is.na_like(x) & !is.na_like(y)]
      y_ <- y[!is.na_like(x) & !is.na_like(y)]
      x <- x_
      y <- y_
    }

    if (length(x) != length(y)) stop("Lengths of x and y differ.")

    if (is.null(type)) {
      if (is.numeric(x)) { type <- "continuous" }
      else { type <- "categorical" }
    }
    if (identical(type, "discrete")) { type <- "categorical" }

    out <- list(
      table = table_for(data, variable, groupby, type = type, na.rm = na.rm, top = top),
      stat  = stat_for(x, y, type = type)
    )
    class(out) <- "comparison_table"
    out
  })

stat_for <- function(x, y, type) {
  if (identical(type, "continuous")) { stat_for_continuous(x, y) }
  else { stat_for_categorical(x, y) }
}
stat_for_continuous <- function(x, y) {  (x ~ y) %>% lm %>% summary }
stat_for_categorical <- function(x, y) { chisq.test(x, y) }

table_for <- function(data, variable, groupby, type, na.rm, top) {
  if (identical(type, "continuous")) { table_for_continuous(data, variable, groupby, na.rm = na.rm) }
  else { table_for_categorical(data, variable, groupby, na.rm = na.rm, top = top) }
}
table_for_continuous <- function(data, variable, groupby, na.rm) {
  t <- data %>% dplyr::mutate_(.dots = list(group = groupby)) %>%
          dplyr::select_(variable, groupby)
  if (isTRUE(na.rm)) {
    t <- na.omit(t)
  }
  t <- dplyr::group_by_(t, groupby) %>%
         dplyr::summarise_each(., dplyr::funs(
           mean(., na.rm = TRUE), median(., na.rm = TRUE), sd(., na.rm = TRUE)))
  attr(t, "left_var") <- get_varname(variable)
  attr(t, "upper_var") <- get_varname(groupby)
  attr(t, "na.rm") <- TRUE
  t
}
table_for_categorical <- function(data, variable, groupby, na.rm = FALSE, top = 0) {
  data %>% tab_(.dots = list(variable, groupby), percent = TRUE, freq = FALSE, byrow = FALSE, na.rm = na.rm, top = top)
}

#' @export
ctable <- comparison_table

#' @export
ctab   <- comparison_table

#' Print the table without annoyingly displaying the class.
#' @export
print.comparison_table <- function(x) {
  if (x$table %is% tbl_df) {
    cat(attr(x$table, "left_var"));
    if (!is.null(attr(x$table, "upper_var"))) {
      cat(" ### "); cat(attr(x$table, "upper_var"))
    }
    if (isTRUE(attr(x, "na.rm"))) { cat(" (nas removed)") }
    cat("\n")
    # Hack to not print the source on the tibble::data_frame
    print(tibble::trunc_mat(x$table, n = NULL, width = NULL))
  } else {
    print(x$table)
  }
  cat("\n")
  print(x$stat)
}
