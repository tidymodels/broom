# glm tidiers warn informatively with glm.fit2 input

    Code
      .res <- tidy(gfit)
    Condition
      Warning:
      `x` seems to be outputted from the glm2 package.
      i Tidiers for glm2 output are currently not maintained; please use caution in interpreting broom output.

# glm tidiers warn informatively with stanreg input

    Code
      .res <- tidy(gfit)
    Condition
      Error in `tidy()`:
      ! `x` seems to be outputted from the rstanarm package.
      i Tidiers for mixed model output now live in broom.mixed.

