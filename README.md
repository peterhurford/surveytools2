## Surveytools2
Surveytools2 is a collection of R functions that make working with dplyr on survey analysis just a little bit better.  Inspired by Hadley's [dplyr](http://www.github.com/hadley/dplyr) package and my previous [surveytools](http://www.github.com/peterhurford/surveytools) package.  Surveytools2 works to extend dplyr's functionality to include more methods useful for survey analysis.

## Installation

This package is not yet available from CRAN. To install the latest development builds directly from GitHub, run this instead:

```R
if (!require("devtools")) install.packages("devtools")
devtools::install_github('peterhurford', 'surveytools')
```

## Dplyr

Dplyr and smbache's [Magrittr](http://www.github.com/smbache/magrittr) have revolutionized how we do data analysis in R.

Previously, we might analyze a survey like this to get the mean age for people by their nationality:

```R
data <- read.csv('path/to/csv')       # Read CSV
data$age <- as.numeric(data$age)      # Convert age to numeric
aggregate(data$age, list(nationality = data$nationality), mean)
```

But with Dplyr and Magrittr, we can do something like this:

```R
'path/to/csv' %>% read.csv %>%        # Read CSV
  mutate(age = as.numeric(age)) %>%   # Convert age to numeric
  group_by(nationality) %>% summarise(mean(age))
```

Much cleaner code!  Yay!  Read more from [RStudio](http://blog.rstudio.org/2014/01/17/introducing-dplyr/) and [RBloggers](www.r-bloggers.com/do-your-data-janitor-work-like-a-boss-with-dplyr/).


## Surveytools2

Surveytools2 adapts my previous Surveytools to work with Dplyr, bringing some survey-related functions that are missing from Dyplr's box of tools.


#### `comparison_table`

Surveytools was designed with the intention of making it easy to write tabular reports.  `comparison_table` compares a variable across a group, both visually and with an appropriate statistical test.

```R
iris %>% comparison_table(Sepal.Length, Species)

> $table
> Source: local data frame [3 x 3]

>  Species  mean        sd
>  1     setosa 5.006 0.3524897
>  2 versicolor 5.936 0.5161711
>  3  virginica 6.588 0.6358796

>  $stat
>   Call:
>   lm(formula = .)

>   Residuals:
>     Min      1Q  Median      3Q     Max
>     -1.6880 -0.3285 -0.0060  0.3120  1.3120

>     Coefficients:
>       Estimate Std. Error t value Pr(>|t|)
>       (Intercept)   5.0060     0.0728  68.762  < 2e-16 ***
>       yversicolor   0.9300     0.1030   9.033 8.77e-16 ***
>       yvirginica    1.5820     0.1030  15.366  < 2e-16 ***
>       ---
>       Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

>       Residual standard error: 0.5148 on 147 degrees of freedom
>       Multiple R-squared:  0.6187,    Adjusted R-squared:  0.6135
>       F-statistic: 119.3 on 2 and 147 DF,  p-value: < 2.2e-16
```


#### `tab`
Makes a fancy table, inspired from `tab` from STATA.

```R
data(iris)        # reset the iris variable
> iris %>% tab(Species, Petal.Width)
> iris %>% tab(Species, Petal.Width)
Species ### Petal.Width

             0.1 0.2 0.3 0.4 0.5 0.6  1 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9  2
  setosa       5  29   7   7   1   1  0   0   0   0   0   0   0   0   0   0  0
  versicolor   0   0   0   0   0   0  7   3   5  13   7  10   3   1   1   0  0
  virginica    0   0   0   0   0   0  0   0   0   0   1   2   1   1  11   5  6

             2.1 2.2 2.3 2.4 2.5
  setosa       0   0   0   0   0
  versicolor   0   0   0   0   0
  virginica    6   3   8   3   3
```

It also does percentages:

```R
> iris %>% tab(Species, Petal.Width, percent = TRUE, freq = FALSE)
Species ### Petal.Width

              0.1  0.2  0.3  0.4  0.5  0.6    1  1.1  1.2  1.3  1.4  1.5  1.6
  setosa     0.10 0.58 0.14 0.14 0.02 0.02 0.00 0.00 0.00 0.00 0.00 0.00 0.00
  versicolor 0.00 0.00 0.00 0.00 0.00 0.00 0.14 0.06 0.10 0.26 0.14 0.20 0.06
  virginica  0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.02 0.04 0.02

              1.7  1.8  1.9    2  2.1  2.2  2.3  2.4  2.5
  setosa     0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00 0.00
  versicolor 0.02 0.02 0.00 0.00 0.00 0.00 0.00 0.00 0.00
  virginica  0.02 0.22 0.10 0.12 0.12 0.06 0.16 0.06 0.06
```

But, like `tab` from STATA, it can do both frequencies AND percentages:

```R
iris %>% dplyr_table(Petal.Width, Species, percent = TRUE)
> iris %>% tab(Species, Petal.Width, percent = TRUE)
Species ### Petal.Width

             0.1     0.2      0.3     0.4     0.5    0.6    1       1.1
  setosa     5 (10%) 29 (58%) 7 (14%) 7 (14%) 1 (2%) 1 (2%) 0 (0%)  0 (0%)
  versicolor 0 (0%)  0 (0%)   0 (0%)  0 (0%)  0 (0%) 0 (0%) 7 (14%) 3 (6%)
  virginica  0 (0%)  0 (0%)   0 (0%)  0 (0%)  0 (0%) 0 (0%) 0 (0%)  0 (0%)

             1.2     1.3      1.4     1.5      1.6    1.7    1.8      1.9
  setosa     0 (0%)  0 (0%)   0 (0%)  0 (0%)   0 (0%) 0 (0%) 0 (0%)   0 (0%)
  versicolor 5 (10%) 13 (26%) 7 (14%) 10 (20%) 3 (6%) 1 (2%) 1 (2%)   0 (0%)
  virginica  0 (0%)  0 (0%)   1 (2%)  2 (4%)   1 (2%) 1 (2%) 11 (22%) 5 (10%)

             2       2.1     2.2    2.3     2.4    2.5
  setosa     0 (0%)  0 (0%)  0 (0%) 0 (0%)  0 (0%) 0 (0%)
  versicolor 0 (0%)  0 (0%)  0 (0%) 0 (0%)  0 (0%) 0 (0%)
  virginica  6 (12%) 6 (12%) 3 (6%) 8 (16%) 3 (6%) 3 (6%)
```

And it has other options too, such as sorting and removing NAs.


#### `fish_for_correlations`

`fish_for_correlations(data)` iterates over the entire dataframe and finds (probably spurious) correlations.


#### `var_summary`, `data_summary`, and `summary_csv`

Surveytools2 is also designed to help you quickly summarize a table.

```R
> var_summary(iris$Petal.Width)
   mean    median       min       max        sd
   1.1993333 1.3000000 0.1000000 2.5000000 0.7622377
```

`data_summary(iris)` will run `var_summary` on every column, giving you a detailed view of the dataframe.

`summary_csv(data, filename)` will write out the dataframe summary to a CSV (with `filename` being the name of the file you want to write to).


#### `num_respondents`

Calculates the number of respondents for a particular survey.

```R
iris %>% num_respondents
> [1] 150
```

Also useful to see how many people remain after a particular filter.

```R
iris %>% dplyr::filter(Species == 'setosa') %>% num_respondents
> [1] 50
```


#### `num_answers`

Calculates the number of people who answered a particular question, removing na-like responses.

```R
df <- data.frame(q1 = c(1, 2, NA, 3, 4, '', 5, 'N/A', 6))
df %>% num_answers('q1')
> [1] 6
```


#### `response_rate`

Calculates the response rate to a particular question.

```R
df <- data.frame(q1 = c(1, 2, NA, 3, 4, '', 5, 'N/A', 6))
df %>% response_rate('q1')
> [1] 0.6666667
```


#### `swap_by_value`

Swaps particular values with other values within the dataframe.  Useful for imputation.

```R
data(iris)   # Reset iris
iris %>% gather(Species) %>% table
>     setosa versicolor  virginica
>        50         50         50
iris %<>% swap_by_value('Species', list('setosa' = 'virginica'))
iris %>% gather(Species) %>% table
>     setosa versicolor  virginica
>        0         50         100
```


#### `swap_by_ids`

Changes the answer of a particular question by the id of the user.  Useful for imputation.

```R
iris %<>% add_ids  # Add ids to iris
iris[iris$id == 42, ]
> id Sepal.Length Sepal.Width Petal.Length Petal.Width Species
> 42 42          4.5         2.3          1.3         0.3  setosa
iris %<>% swap_by_ids('Petal.Length', list('42' = 'test'))
iris[iris$id == 42, ]
> id Sepal.Length Sepal.Width Petal.Length Petal.Width Species
> 42 42          4.5         2.3          test         0.3  setosa
```


#### `swap_multiple_ids`

Assign the same value to multiple ids.  Useful for imputation.

```R
data(iris)          # Reset iris
iris %<>% add_ids   # Add ids to iris
> 42 42          4.5         2.3          1.3         0.3  setosa
iris %<>% swap_multiple_ids('Petal.Length', c(42, 43), 'test')
iris[iris$id %in% c(42, 43), ]
>   id Sepal.Length Sepal.Width Petal.Length Petal.Width Species
>   42 42          4.5         2.3         test         0.3  setosa
>   43 43          4.4         3.2         test         0.2  setosa
```


#### `breakdown`

Breakdown values of a variable by the number of people who have that value or a higher value.

```R
iris %>% breakdown('Sepal.Length', seq(10))
>  [1] "150 respondents >=  1" "150 respondents >=  2" "150 respondents >=  3" "150 respondents >=  4" "118 respondents >=  5" "61 respondents >=  6"  "12 respondents >=  7"
>  [8] "0 respondents >=  8"   "0 respondents >=  9"   "0 respondents >=  10"
```


#### `get_vars`

An easier way to get all the variables that start with a certain pattern.

```R
> get_vars(iris, "Sepal")
[1] "Sepal.Length" "Sepal.Width"
```

#### `count_vars`

For a given variable, counts the number of a particular response to that variable.

This returns 1 if the iris has a Petal.Length or Petal.Width of 1.4 and 0 otherwise:

```R
iris %<>% add_ids  # x %<>% f is the same as x <- x %>% f. 
                   # add_ids adds an id column to the dataframe. 
iris %>% count_vars(c('Petal.Length', 'Petal.Width'), 1.4)
```

More useful to summarize across larger groups of variables, such as finding the number of "Yes" responses given to a group of questions.


#### `drop_na_cols`

Drops columns with an amount of NAs over a certain threshold.

```R
iris$Petal.Width <- NA   # Make Petal.Width NA
iris %>% drop_na_cols %>% names
> [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Species"
# Note that Petal.Width is dropped.
```


#### `drop_values`

```R
unique(as.character(iris$Species))
> [1] "setosa"     "versicolor" "virginica"
unique(drop_values(as.character(iris$Species), c("setosa", "virginica")))
> [1] NA           "versicolor"
```


#### `is.na_like`

Detects NAs, but also blanks (`""`), the string NA (`"NA"`), and the string `"N/A"`.  This removes most NA vars from surveys.

```R
is.na_like("")
> [1] TRUE
```


#### `na.rm`

Takes a vector and removes all NA-like values.

```R
c(1, 2, NA, 3, 4, '', 5, 'N/A', 6) %>% na.rm
> [1] "1" "2" "3" "4" "5" "6"
```


#### `apply_over_vars`

```R
apply_over_vars(iris, c("Petal.Length", "Petal.Width"), mean)
> $Petal.Length
> [1] 3.758

> $Petal.Width
> [1] 1.199333
```


#### `cut3`

TODO.


## Examples

* [The .impact survey](https://github.com/peterhurford/imsurvey/blob/master/imsurvey.R)
