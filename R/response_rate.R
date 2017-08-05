#' Calculates the number of total respondents in a dataframe.
#' Assumes each column corresponds to a unique respondent.
#'
#' @param df data frame. The dataframe to count.
#' @export
num_respondents <- function(df) { NROW(df) }


#' Calculates the number of people that answered a particular question.
#' Assumes each column corresponds to a unique respondent.
#'
#' @param df data frame. The dataframe to count.
#' @param variable character. The variable to count.
#' @param na. NA responses in the dataframe are coded as this.
#' @export
num_answers <- function(df, variable, na = NA) {
  if (!is.character(substitute(variable))) { variable <- deparse(substitute(variable)) }
  num_answers_(df, variable, na = na)
}

num_answers_ <- function(df, variable, na = NA) {
  df %>% select_(variable) %>% na.rm %>% num_respondents
}


#' Calculates the response rate to a particular question.
#' Assumes each column corresponds to a unique respondent.
#'
#' @param df data frame. The dataframe to count.
#' @param variable character. The variable to count.
#' @param na. NA responses in the dataframe are coded as this.
#' @export
response_rate <- function(df, variable, na = NA) {
  if (!is.character(substitute(variable))) { variable <- deparse(substitute(variable)) }
  num_answers_(df, variable, na) / num_respondents(df)
}
