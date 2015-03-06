#' Count the amount of a particlar response that respondants have across a group of vars.
#'
#' @param df dataframe.  The data to be transformed.
#' @param vars character. A vector of variables to check.
#' @param response character. The value of the response that you want to count.  Defaults to 1.
#' @param idname character. The name of the variable in the dataframe where respondent ids are kept.  Defaults to 'id'.
#' @param colname character. The output will be a two-column dataframe with ids and values. The names are the idname for ids and this (default 'value') for the values.
#' @export
count_vars <- function(df, vars, response = 1, idname = 'id', colname = 'value') {
  o <- sapply(df[[idname]], function(id) {
    count <- 0
    for (var in vars)
      if (identical(df[df[[idname]] == id, var], response)) count <- count + 1
    count
  })
  df <- data.frame(df[[idname]], o)
  names(df) <- c(idname, colname)
  df
}
