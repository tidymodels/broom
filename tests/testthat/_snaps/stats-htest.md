# tidy.htest/oneway.test

    Code
      td <- tidy(ot)
    Message
      Multiple parameters; naming those columns num.df, den.df

# augment.htest (chi squared test)

    Code
      augment(tt)
    Condition
      Error:
      ! Augment is only defined for chi squared hypothesis tests.

---

    Code
      augment(wt)
    Condition
      Error:
      ! Augment is only defined for chi squared hypothesis tests.

---

    Code
      augment(ct)
    Condition
      Error:
      ! Augment is only defined for chi squared hypothesis tests.

