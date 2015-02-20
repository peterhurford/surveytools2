#' Calculates the number of total respondents in a dataframe.
#' Assumes each column corresponds to a unique respondent.
#'
#' @param df data frame. The dataframe to count.
#' @export
num_respondants <- function(df) df %>% dim %>% .[[1]]

#' Calculates the number of people that answered a particular question.
#' Assumes each column corresponds to a unique respondent.
#'
#' @param df data frame. The dataframe to count.
#' @param variable character. The variable to count.
#' @param na. NA responses in the dataframe are coded as this.
#' @export
num_answers <- function(df, variable, na = NA) df %>% filter_(.dots = paste0(variable, " != ", "'", na, "'")) %>% num_respondants

#' Calculates the response rate to a particular question.
#' Assumes each column corresponds to a unique respondent.
#'
#' @param df data frame. The dataframe to count.
#' @param variable character. The variable to count.
#' @param na. NA responses in the dataframe are coded as this.
#' @export
response_rate <- function(df, variable, na = NA) num_answers(df, variable, na) / num_respondants(df)