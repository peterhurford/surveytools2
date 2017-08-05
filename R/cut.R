#' Split a vector into bins.
#'
#' @param x vector. The vector to split into bins.
#' @param cuts numeric. The number of bins to split.
#' @export
cut3 <- function(x, cuts) {
  s <- sort(na.rm(x))
  len <- length(s)
  bin_len <- ceiling(len/cuts)
  start <- 0
  out <- list()
  for (i in seq(cuts)) {
    stop <- start + bin_len
    out[[i]] <- s[seq(start, stop)]
    start <- stop + 1
  }
  lapply(out, na.rm)
}
