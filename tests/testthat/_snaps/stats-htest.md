# tidy.htest/oneway.test

    Code
      td <- tidy(ot)
    Message
      Multiple parameters; naming those columns num.df and den.df.

---

    Code
      gl <- glance(ot)
    Message
      Multiple parameters; naming those columns num.df and den.df.

# augment.htest (chi squared test)

    Code
      augment(tt)
    Condition
      Error in `augment()`:
      ! `augment.htest()` is only defined for chi squared hypothesis tests.

---

    Code
      augment(wt)
    Condition
      Error in `augment()`:
      ! `augment.htest()` is only defined for chi squared hypothesis tests.

---

    Code
      augment(ct)
    Condition
      Error in `augment()`:
      ! `augment.htest()` is only defined for chi squared hypothesis tests.

# tidy.htest handles various test types

    Code
      .res <- tidy(tt)
    Condition
      Warning:
      Multiple unnamed parameters in hypothesis test; dropping them.

