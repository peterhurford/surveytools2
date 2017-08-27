#' Reformat stats::chisq.test to accept inputs as two vectors.
#'
#' @param vector1. The first vector to compare.
#' @param vector2. The other vector to compare.
#' @return chi square test on the joint frequency table of the two vectors.
#' @export
chisq_test <- function(vector1, vector2) {
  chi <- chisq.test(table(data.frame(data = c(vector1, vector2),
                                     population = c(rep("v1", length(vector1)),
                                                    rep("v2", length(vector2))))))
  chi$data.name <- paste(capture.output(substitute(vector1)), "and",
                         capture.output(substitute(vector2)))

  chi
}
