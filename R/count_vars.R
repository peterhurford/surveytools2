#' Count the amount of "yes" responses that respondants have within a group of vars.
#'
#' @param df dataframe.  The data to be transformed.
#' @param vars character. A vector of variables to check.
#' @param idname character. The name of the variable in the dataframe where respondent ids are kept.  Defaults to 'id'.
#' @param yes character. The value of the response counted as a "yes" response that you seek to tally.  Defaults to 1.
#' @param colname character. The output will be a two-column dataframe with ids and values. The names are the idname for ids and this (default 'value') for the values.
#' @export
count_vars <- function(df, vars, idname = 'id', yes = 1, colname = 'value') {
  o <- sapply(df[[idname]], function(id) {
    count <- 0
    for (var in vars)
      if (identical(df[df[[idname]] == id, var], yes)) count <- count + 1
    count
  })
  df <- data.frame(df[[idname]], o)
  names(df) <- c(idname, colname)
  df
}
