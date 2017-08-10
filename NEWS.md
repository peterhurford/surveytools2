#### v0.5.6

* Fixes `ctab` to properly create variables when analyzing continuous data.
* Extends `ctab` to count the number of cells when analyzing continuous data.

#### v0.5.5

* Exports `comparison_table_` as a NSE-safe companion to `comparison_table`.

#### v0.5.4

* Extends `tab` and `ctab` to allow `filter()` as an alias for `filters()`.

#### v0.5.3

* Fixes `tab` and `ctab` when using `filters()` with a length > 1 vector.

#### v0.5.2

* Extends `tab` and `ctab` to take an argument `filters()` containing filters for the data. This will filter the dataframe and print out the list of filters. For example, try `tab(iris, filters(Species %not_in% "virginica", Petal.Width > 0.2), Species)` to look at the Species when excluding virginia and all `Petal.Length` below 0.2.

#### v0.5.1

* Adds `nas_are_zeros` to convert NAs to zeros.

## v0.5

*Major*

* Adds `drop_values` to drop individual values from a variable.
* Adds `apply_over_vars` to apply a function over variables in a dataframe by specifying the names of the variables.
* Adds `cut3` to split a vector into roughly even-sized bins.

*Minor*

* Fixes a bug that prevented `response_rate` from working.
* Fixes a bug that prevented NA values from being printed in the table when `na.rm = FALSE`.
* Extends `swap_by_value` to swap for multiple variables.
* Extends `num_over_zero` to have a `na.rm` parameter.
* Extends `breakdown` to handle passing in the variable as a string.




#### v0.4.17

* Fixes a bug in `comparison_table` for some logical operator comparisons involving continuous data, introduced by v0.4.16.

#### v0.4.16

* Extends `tab` and `comparison_table` to have a parameter `top` that can constrain the number of levels outputted, putting all minor levels in a single bin called "Other".
* Fixes printing of variable names in a table that involve a logical operator.
* Fixes `na.rm = TRUE` in `comparison_table`.

#### v0.4.15

* Extends `var_summary` to report the number of NAs and the number of values > 0 for numeric variables when called with `verbose = TRUE`.
* Extends `var_summary` to report the number of NAs for non-numeric variables when called with `verbose = TRUE`.
* Reduces `var_summary` to no longer track the `class` of the object.

#### v0.4.14

* Extends `var_summary` returns as a named vector if possible.
* Reduces `var_summary` to no longer display a table of numeric variables (as originally intended).
* Reduces `var_summary` to no longer supports `serialize`.

#### v0.4.13

* Extends `swap_by_value` to enforce a correct swap_list.
* Reduces `swap_by_value` to no longer use direct substitution.

#### v0.4.12

* Extends `swap_by_value` to swap based on a grep-pattern.

#### v0.4.11

* Extends `get_vars` to support multiple patterns passed as a vector.

## v0.4.10

* Adds `fish_for_correlations` that analyzes a dataframe for correlations.
* Adds `get_vars` to streamline finding all names in a dataframe that match a pattern.
* Adds `%not_in%`, the opposite of `%in%`.
* Adds `data_summary` to extend `var_summary` to an entire dataframe.
* Reduces ome features of `var_summary`, restore them by using `verbose = TRUE`.
* (Note: the `.10` minor versioning for this release was a mistake.)




#### v0.3.10

* Fixes `swap_by_value` when the dataframe has NAs.

#### v0.3.7-9

* Extends `replace` to now take column name via NSE.
* Fixes `replace` implementation.

#### v0.3.6

* Adds `replace` to swap values within a dataframe.

#### v0.3.5

* Adds tibble dependency.

#### v0.3.4

* Extends `breakdown` and `num_answers` to use NSE by default.
* Adds `breakdown_` and `num_answers_` for non-NSE.

#### v0.3.3

* Adds magrittr package to imports.

#### v0.3.2

* Extends `ctab` and `tab` to announce in printed table if NAs were removed.

## v0.3.0-1

* Adds `var_summary` and `summary_csv` from the (now defunct) summarizeR package.




#### v0.2.4

* Extends `tab` and `ctab` to now take a (functional) `na.rm` parameter.

#### v0.2.2-3

* Renames `num_respondants` to `num_respondents`.

#### v0.2.1

* Adds `ctab` as an alias for  `comparison_table`.

## v0.2

* Renames `dplyr_table` to `tab`.
* Adds `ctab` and `ctable` as aliases for `comparison_table`.
* Extends `tab` to print more cleanly.
* Extends `tab` and `ctab` to take expressions (e.g., `tab(iris, Species == "setosa")`)
* Extends `comparison_table` to support NSE for variable names and can infer the comparison type.
* Extends `comparison_table` to print out the median for continuous data too.
* Extends `comparison_table` to allow "discrete" as a synonym for "continuous" when specifying a type.
* Reduces `comparison_table` to no longer take in vectors directly.
