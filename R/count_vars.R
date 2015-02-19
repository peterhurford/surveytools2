#' Count the amount of "yes" responses that respondants have within a group of vars.
#'
#' @param df dataframe.  The data to be transformed.
#' @param vars character. A vector of variables to check.
#' @param ids character. A vector of all respondent ids to return results for.
#' @param value character. The value to assign those ids.
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
