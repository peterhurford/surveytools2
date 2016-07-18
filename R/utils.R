get_varname <- function(dot) {
  if (identical(class(dot), "lazy")) { as.character(dot$expr) }
  else { dot }
}
