#' Split a vector into bins.
#'
#' @param x vector. The vector to split into bins.
#' @param cuts numeric. The number of bins to split.
#' @export
cut3 <- function(x, cuts) {
  sorted <- sort(na.rm(x))
  len <- length(sorted)
  if (cuts > len) {
    stop("Too many bins.")
  }
  large_bin <- ceiling(len / cuts)
  small_bin <- floor(len / cuts)
  bin_difference <- len - large_bin - small_bin * (cuts - 1)
  start <- 1
  out <- list()
  for (i in seq(cuts)) {
    if (i <= bin_difference + 1) {
      stop <- start + large_bin - 1
    } else {
      stop <- start + small_bin - 1
    }
    out[[i]] <- sorted[seq(start, stop)]
    start <- stop + 1
  }
  lapply(out, na.rm)
}
