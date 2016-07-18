library(checkr)
context("surveytools")

test_that("It passes quickchecks", {
  quickcheck(add_ids)
  browser()
  quickcheck(postconditions = list(
      identical(names(result)[[1]], idname),
      identical(result[[1]], seq(NROW(df)))),
    fn = add_ids)
})
