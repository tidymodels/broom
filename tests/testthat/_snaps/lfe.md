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
      Error:
      ! Glance does not support linear models with multiple responses.

# augment.felm

    Code
      augment(fit_multi)
    Condition
      Error:
      ! Augment does not support linear models with multiple responses.

