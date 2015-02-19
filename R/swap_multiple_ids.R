#' For all ids specified, sets their value to the assigned value within a given variable.
#'
#' @param df dataframe.  The data to be transformed.
#' @param variable character. The name of the variable in df where the replacement occurs.
#' @param ids character. A vector of ids to be transformed.
#' @param value character. The value to assign those ids.
#' @export
swap_multiple_ids <- function(df, variable, ids, value) {
  sapply(ids, function(id) {
    df[df$id == id, variable] <<- value
  })
  df
}
