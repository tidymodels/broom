# tidy.lm works

    Code
      td_rd <- tidy(fit_rd, conf.int = TRUE)
    Condition
      Warning in `qt()`:
      NaNs produced

# augment.lm

    Code
      augment(fit, newdata = mtcars, interval = "confidence", level = 0.95)
    Condition
      Warning:
      The `level` argument is not supported in the `augment()` method for `lm` objects and will be ignored.
    Output
      # A tibble: 32 x 16
         .rownames     mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
         <chr>       <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
       1 Mazda RX4    21       6  160    110  3.9   2.62  16.5     0     1     4     4
       2 Mazda RX4 ~  21       6  160    110  3.9   2.88  17.0     0     1     4     4
       3 Datsun 710   22.8     4  108     93  3.85  2.32  18.6     1     1     4     1
       4 Hornet 4 D~  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1
       5 Hornet Spo~  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2
       6 Valiant      18.1     6  225    105  2.76  3.46  20.2     1     0     3     1
       7 Duster 360   14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
       8 Merc 240D    24.4     4  147.    62  3.69  3.19  20       1     0     4     2
       9 Merc 230     22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2
      10 Merc 280     19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4
      # i 22 more rows
      # i 4 more variables: .fitted <dbl>, .lower <dbl>, .upper <dbl>, .resid <dbl>

