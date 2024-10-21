# tidy.ergm

    Code
      tde <- tidy(gest, conf.int = TRUE, exponentiate = TRUE)
    Condition
      Warning:
      Coefficients will be exponentiated, but the model didn't use a `log` or `logit` link.

---

    Code
      td2 <- tidy(gest2, conf.int = TRUE, exponentiate = TRUE)
    Condition
      Warning:
      Coefficients will be exponentiated, but the model didn't use a `log` or `logit` link.

# glance.ergm

    Code
      gl3 <- glance(gest, deviance = TRUE, mcmc = TRUE)
    Message
      Though `glance()` was supplied `mcmc = TRUE`, the model was not fitted using MCMC,
      i The corresponding columns will be omitted.

