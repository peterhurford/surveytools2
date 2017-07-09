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
