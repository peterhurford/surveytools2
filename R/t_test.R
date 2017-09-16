#' Reformat stats::t.test to accept inputs as two vectors.
#'
#' @param variable. A numeric vector to compare means.
#' @param groupby. A vector to group by.
#' @return t-test on the joint frequency table of the two vectors.
#' @export
t_test <- function(variable, groupby) {
  name1 <- capture.output(substitute(variable))
  name2 <- capture.output(substitute(groupby))
  complete <- complete.cases(variable, groupby)
  variable <- variable[complete]
  groupby <- as.factor(groupby[complete])
  if (!is.numeric(variable)) { stop("The input variable to t_test must be numeric") }
  levels2 <- levels(groupby)
  if (length(levels2) > 2) {
    stop("The grouping variable to t_test must only have two levels.")
  }
  groupby <- groupby == levels2[[1]]
  df <- data.frame(x = variable, y = groupby)
  ttest <- t.test(variable ~ groupby, df)
  ttest$data.name <- paste(name1, "by", name2)
  ttest
}
