library(checkr)
context("surveytools")

test_that("It passes quickchecks", {
  quickcheck(add_ids)
  quickcheck(postconditions = list(
      names(result)[[1]] == idname,
      result[[1]] == seq(NROW(df))),
    fn = add_ids)
})
