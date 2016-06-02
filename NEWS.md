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
