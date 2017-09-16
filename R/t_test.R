#' Reformat stats::t.test to accept inputs as two vectors.
#'
#' @param vector1. The first vector to compare.
#' @param vector2. The other vector to compare.
#' @return t-test on the joint frequency table of the two vectors.
#' @export
t_test <- function(vector1, vector2) {
  name1 <- capture.output(substitute(vector1))
  name2 <- capture.output(substitute(vector2))
  complete <- complete.cases(vector1, vector2)
  vector1 <- as.factor(vector1[complete])
  vector2 <- as.factor(vector2[complete])
  levels1 <- levels(vector1)
  levels2 <- levels(vector2)
  if (length(levels1) > 2 || length(levels2) > 2) {
    stop("All inputs to t_test must only have two levels.")
  }
  vector1 <- vector1 == levels1[[1]]
  vector2 <- vector2 == levels2[[1]]
  df <- data.frame(x = vector1, y = vector2)
  ttest <- t.test(vector1 ~ vector2, df)
  ttest$data.name <- paste(name1, "by", name2)
  ttest
}
