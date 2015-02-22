#' Compares a variable across a group, both visually and with an appropriate statistical test.
#'
#' @param data data frame. The data to test.
#' @param variable. If character, the name of the variable to test.  Or you can pass a specific vector instead.
#' @param groupby character. If character, the name of the variable to group `variable` by.  Or you can pass a specific vector instead.
#' @param type character. "Continuous" if `variable` is continuous data (like age), or "categorical" if `variable` is categorical data (like hometown).
#' @export
comparison_table <- function(data = NULL, variable, groupby, type) {
  if (type != "continuous" && type != "categorical") stop('Type not recognized.')
  x <- if (is.character(variable)) data[[variable]] else variable
  y <- if (is.character(groupby)) data[[groupby]] else groupby
  if (length(x) != length(y)) stop('Lengths of x and y differ.')
  list(
    table = switch(type,
      continuous = data %>% group_by_(groupby) %>% select_(variable) %>%
        summarise_each(funs(mean(., na.rm = TRUE), sd(., na.rm = TRUE))),
      categorical = data %>% dplyr_table_(.dots = list(variable, groupby), percent = TRUE, freq = FALSE, byrow = FALSE)
    ),
    stat = switch(type,
      continuous = (x ~ y) %>% lm %>% summary,
      categorical = chisq.test(x, y)
    )
  )
}
