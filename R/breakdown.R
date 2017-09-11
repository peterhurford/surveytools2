#' Breakdown values of a variable by the number of people who have that value or a higher value.
#'
#' @param df dataframe. The dataframe to analyze.
#' @param variable character. The value to breakdown.
#' @param breakdowns integer. A vector of values to breakdown.  Usually produced by seq(), but could be a vector.
#'
#' e.g., \code{breakdown(data, 'age', seq(5, 90, by = 5))} will tell me how many people
#' are age 5 or older, how many people are age 10 or older, how many people are
#' age 15 or older, etc. to age 90.
#' @export
breakdown <- function(df, variable, breakdowns) {
  if (!is.character(substitute(variable))) { variable <- deparse(substitute(variable)) }
  breakdown_(df, variable, breakdowns)
}

breakdown_ <- function(df, variable, breakdowns) {
  sapply(breakdowns, function(x) {
    y <- as.numeric(df[[variable]])
    paste(sum(y >= x, na.rm = TRUE), 'respondents >= ', x)
  })
}

#' @export
numeric_breakdown <- function(df, variable, breakdowns) {
  o <- breakdown(df, variable, breakdowns)
  sapply(o, function(x) as.integer(strsplit(x, " ")[[1]][[1]]))
}
