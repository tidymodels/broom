# glance.tbl_df errors informatively

    Code
      glance.tbl_df(tibble::tibble(x = 1))
    Condition
      Error in `glance.tbl_df()`:
      ! There is no glance method for tibbles.
      i Did you mean `tibble::glimpse()`?

