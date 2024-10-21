# tidy.felm

    Code
      .res <- tidy(fit, robust = TRUE)
    Condition
      Warning:
      The `robust` argument has been deprecated in `tidy.felm()` and will be ignored.
      i Please use the `se.type` argument instead.

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

# tidy.felm errors informatively

    Code
      .res <- tidy.felm(fit, se.type = "cluster")
    Condition
      Warning:
      Clustered SEs requested, but weren't calculated in underlying model object.
      i Reverting to default SEs.

