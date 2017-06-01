#' Fish the entire dataframe for correlations. Many will be spurious.
#' @param df dataframe. The dataframe to fish.
#' @param x character. A character vector of names to put first in the correlation. Or 'all' for all.
#' @param y character. A character vector of names to put second in the correlation. Or 'all' for all.
#' @param p_threshold numeric. The threshold cutoff for determining a significant test.
#' @export
fish_for_correlations <- function(df, x = 'all', y = 'all', p_threshold = 0.05) {
  fish_tables <- list()
  n <- 0
  if (identical(x, 'all')) { x <- names(df) }
  if (identical(y, 'all')) { y <- names(df) }
  for (x_ in x) {
    for (y_ in y) {
      if (x_ != y_) {
        n <- n + 1
        fish_table <- comparison_table_(df, x_, y_)
        stat <- fish_table$stat
        if ("p.value" %in% ls(stat)) { stat <- stat$p.value }
        else { stat <- as.data.frame(stat$coefficients)[["Pr(>|t|)"]][[2]] }
        if (stat < p_threshold) {
          fish_tables <- c(fish_tables, fish_table)
        }
      }
    }
  }
  list(tables = fish_tables, n = n)
}
