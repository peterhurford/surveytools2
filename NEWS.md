## v0.2

* `dplyr_table` has been renamed `tab` and prints more cleanly.
* `ctab` and `ctable` are now aliases for `comparison_table`.
* `comparison_table` supports NSE for variable names and can infer the comparison type.
* `comparison_table` now prints out the median for continuous data too.
* "discrete" can now be used as a synonym for "continuous" when specifying a type for `comparison_table`
* `comparison_table` can no longer take in vectors directly.
