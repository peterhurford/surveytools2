get_varname <- function(dot) {
  if (dot %is% "lazy") { capture.output(dot$expr) }
  else { dot }
}

get_base_varname <- function(dot) {
  if (dot %is% "lazy") {
    dot <- dot$expr
    if (length(dot) > 1) { dot <- dot[[2]] }
  }
  dot
}

apply_filters <- function(.data, dots) {
	filters_idx <- unlist(lapply(lapply(lapply(lapply(dots, `[[`, "expr"), as.character), function(x) grepl("filter", x)), any))
	if (any(filters_idx)) {
		filters <- dots[[which(filters_idx)]]
    filter_list <- as.list(filters$expr[-1])
    filter_env <- filters$env
		dots <- dots[-which(filters_idx)]
    .print_filters <- paste0(lapply(filter_list, capture.output), collapse = ", ")
	} else {
		filters <- NULL
    .print_filters <- NULL
	}
	if (!is.null(filters)) {
		for (filter in filter_list) {
      for (i in seq_along(filter)) {
        if (length(as.character(filter[[i]])) == 1 &&
              exists(as.character(filter[[i]]), filter_env)) {
          filter[[i]] <- get(as.character(filter[[i]]), filter_env)
        }
      }
			.data <- dplyr::filter_(.data, filter)
		}
	}
  list(data = .data, dots = dots, print_filters = .print_filters)
}
