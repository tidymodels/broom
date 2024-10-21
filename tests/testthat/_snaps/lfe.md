# tidy.felm

    Code
      .res <- tidy(fit, robust = TRUE)
    Condition
      Warning in `tidy.felm()`:
      
      The "robust" argument has been deprecated in tidy.felm and will be ignored. Please use the "se.type" argument instead.

# glance.felm

    Code
      glance(fit_multi)
    Condition
      Error in `glance()`:
      ! `felm()` models with multiple responses are not supported.

# augment.felm

    Code
      augment(fit_multi)
    Condition
      Error in `augment()`:
      ! `felm()` models with multiple responses are not supported.

