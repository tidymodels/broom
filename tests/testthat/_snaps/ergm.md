# tidy.ergm

    Code
      tde <- tidy(gest, conf.int = TRUE, exponentiate = TRUE)
    Condition
      Warning in `tidy.ergm()`:
      Exponentiating but model didn't use log or logit link.

---

    Code
      td2 <- tidy(gest2, conf.int = TRUE, exponentiate = TRUE)
    Condition
      Warning in `tidy.ergm()`:
      Exponentiating but model didn't use log or logit link.

# glance.ergm

    Code
      gl3 <- glance(gest, deviance = TRUE, mcmc = TRUE)
    Message
      Though `glance` was supplied `mcmc = TRUE`, the model was not fittedusing MCMC, so the corresponding columns will be omitted.

