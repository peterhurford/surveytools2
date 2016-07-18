#' Creates a CSV file containing summary information on the given variables. 
#'
#' @param data list. A list containing all the R objects to summarize.
#' @param filename character. The name of the CSV file to write.
#' @return TRUE. Generates a CSV file at the designated location.
#' @export
summary_csv <- function(data, filename) {
  summary <- list()
  write.csv("", filename)
  header_written <- FALSE
  for (name in names(data)) {
    summary[[name]] <- list()
    summary[[name]]$variable_name <- name
    summary[[name]]$description <- ""
    summary[[name]] <- c(
      summary[[name]],
      var_summary(data[[name]], na.rm = FALSE, serialize = TRUE)
    )
    if (!header_written) {
      write_csv_line(as.list(names(summary[[1]])), filename)
      header_written <- TRUE
    }
    write_csv_line(summary[[name]], filename)
  }
  cat(paste("Written to", filename, '\n'))
  TRUE
}

write_csv_line <- function(value, filename)
  write.table(value, file = filename, sep = ",", col.names = FALSE, append = TRUE)
