#' Compares a variable across a group, both visually and with an appropriate statistical test.
#'
#' @param data data frame. The data to test.
#' @param variable. If character, the name of the variable to test.
#' @param groupby character. If character, the name of the variable to group `variable` by.
#' @param type character. "Continuous" if `variable` is continuous data (like age), or "categorical" / "discrete" if `variable` is categorical data (like hometown).
#'   This can be automatically inferred by whether the variable is numeric or not.
#' @aliases ctable ctab
#' @export
comparison_table <- function(data, variable, groupby, type = NULL) {
  variable <- deparse(substitute(variable))
  groupby  <- deparse(substitute(groupby))
  comparison_table_(data, variable, groupby, type)
}

#' @import checkr magrittr
comparison_table_ <- checkr::ensure(
  pre = list(data %is% dataframe,
    variable %is% simple_string, groupby %is% simple_string,
    type %is% NULL || type %in% c("continuous", "discrete", "categorical")),
  function(data, variable, groupby, type = NULL) {
    x <- data[[variable]]
    y <- data[[groupby]]
    if (length(x) != length(y)) stop('Lengths of x and y differ.')

    if (is.null(type)) {
      if (is.numeric(x)) { type <- "continuous" }
      else { type <- "categorical" }
    }
    if (identical(type, "discrete")) { type <- "categorical" }

    out <- list(
      table = table_for(data, variable, groupby, type),
      stat  = stat_for(x, y, type)
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

table_for <- function(data, variable, groupby, type) {
  if (identical(type, "continuous")) { table_for_continuous(data, variable, groupby) }
  else { table_for_categorical(data, variable, groupby) }
}
table_for_continuous <- function(data, variable, groupby) {
  data %>% dplyr::group_by_(groupby) %>% dplyr::select_(variable) %>%
    dplyr::summarise_each(dplyr::funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE)))
}
table_for_categorical <- function(data, variable, groupby) {
  data %>% tab_(.dots = list(variable, groupby), percent = TRUE, freq = FALSE, byrow = FALSE)
}

#' @export
ctable <- comparison_table
ctab <- comparison_table

#' Print the table without annoyingly displaying the class.
#' @export
print.comparison_table <- function(x) {
  class(x) <- NULL
  print(x)
}
