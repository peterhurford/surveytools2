#### v0.5.1

* Adds `nas_are_zeros` to convert NAs to zeros.

## v0.5

*Major*

* `drop_values` can drop individual values from a variable.
* `apply_over_vars` allows you to apply a function over variables in a dataframe by specifying the names of the variables.
* `cut3` supports splitting a vector into roughly even-sized bins.

*Minor*

* Fixed a bug that prevented `response_rate` from working.
* Fixed a bug that prevented NA values from being printed in the table when `na.rm = FALSE`.
* `swap_by_value` can now swap for multiple variables.
* `num_over_zero` now has a `na.rm` parameter.
* `breakdown` now handles passing in the variable as a string.




#### v0.4.17

* Fixes a bug in `comparison_table` for some logical operator comparisons involving continuous data, introduced by v0.4.16.

#### v0.4.16

* `tab` and `comparison_table` get a parameter `top` that can constrain the number of levels outputted, putting all minor levels in a single bin called "Other".
* Fixes printing of variable names in a table that involve a logical operator.
* `na.rm = TRUE` now works in `comparison_table`.

#### v0.4.15

* `var_summary` no longer tracks the `class` of the object.
* `var_summary` now reports the number of NAs and the number of values > 0 for numeric variables when called with `verbose = TRUE`.
* `var_summary` now reports the number of NAs for non-numeric variables when called with `verbose = TRUE`.

#### v0.4.14

* `var_summary` no longer displays a table of numeric variables (as originally intended).
* `var_summary` returns as a named vector if possible.
* `var_summary` no longer supports `serialize`.

#### v0.4.13

* `swap_by_value` now no longer uses direct substitution and enforces a correct swap_list.

#### v0.4.12

* `swap_by_value` can now swap based on a grep-pattern.

#### v0.4.11

* `get_vars` now supports multiple patterns passed as a vector.

## v0.4.10

* Added a function `fish_for_correlations` that analyzes a dataframe for correlations.
* Added `get_vars` to streamline finding all names in a dataframe that match a pattern.
* Added `%not_in%`, the opposite of `%in%`.
* Added `data_summary` to extend `var_summary` to an entire dataframe.
* Removed some features of `var_summary`, restore them by using `verbose = TRUE`.
* (Note: the `.10` minor versioning for this release was a mistake.)




#### v0.3.10

* Bugfix for `swap_by_value` when the dataframe has NAs.

#### v0.3.7-9

* `replace` now takes column name via NSE.
* Bugfix for `replace`.

#### v0.3.6

* Add `replace` to swap values within a dataframe.

#### v0.3.5

* Add tibble dependency.

#### v0.3.4

* Make `breakdown` and `num_answers` use NSE by default (and provide `breakdown_` and `num_answers_` for non-NSE).

#### v0.3.3

* Add magrittr package to imports.

#### v0.3.2

* It is announced in the table if NAs were removed.

## v0.3.0-1

* Add `var_summary` and `summary_csv` from the (now defunct) summarizeR package.




#### v0.2.4

* `tab` and `ctab` now take a (functional) `na.rm` parameter.

#### v0.2.2-3

* `num_respondants` was renamed `num_respondents` (the correct spelling).

#### v0.2.1

* Export `ctab` (`comparison_table` alias).

## v0.2

* `dplyr_table` has been renamed `tab` and prints more cleanly.
* `tab` and `comparison_table` can now take expressions (e.g., `tab(iris, Species == "setosa")`)
* `ctab` and `ctable` are now aliases for `comparison_table`.
* `comparison_table` supports NSE for variable names and can infer the comparison type.
* `comparison_table` now prints out the median for continuous data too.
* "discrete" can now be used as a synonym for "continuous" when specifying a type for `comparison_table`
* `comparison_table` can no longer take in vectors directly.
