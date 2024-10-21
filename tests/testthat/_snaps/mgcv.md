# tidy.gam handles messages informatively

    Code
      .res <- tidy(x, conf.int = TRUE)
    Message
      Confidence intervals only available for parametric terms.

---

    Code
      .res <- tidy(x, exponentiate = TRUE)
    Message
      Exponentiating coefficients only available for parametric terms.

---

    Code
      .res <- tidy(x, conf.int = TRUE, exponentiate = TRUE)
    Message
      Confidence intervals only available for parametric terms.
      Exponentiating coefficients only available for parametric terms.

