#' Apply a function over variables in a dataframe.
#'
#' @param df dataframe. The dataframe to apply the function over.
#' @param vars. A list of the variable names to apply to, or a character regex pattern to search for (using `get_vars`).
#' @param f function. The function to apply.
#' @export
apply_over_vars <- function(df, vars, f) {
    if (length(vars) == 1 && is.character(vars)) { vars <- get_vars(df, vars) }
    setNames(lapply(vars, function(x) { f(df[[x]]) }), vars)
}
