#' For all ids specified, sets their value to the assigned value within a given variable.
#' Like swap_by_ids, but for multiple ids and one swap value.
#' Useful for imputation.
#'
#' @param df dataframe.  The data to be transformed.
#' @param variable character. The name of the variable in df where the replacement occurs.
#' @param ids character. A vector of ids to be transformed.
#' @param value character. The value to assign those ids.
#' @param idname character. The name of the column with ids.
#' @seealso swap_by_ids
#' @export
swap_multiple_ids <- function(df, variable, ids, value, idname = 'id') {
  sapply(ids, function(id) {
    df[df[[idname]] == id, variable] <<- value
  })
  df
}
