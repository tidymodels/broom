context("rlm tidiers")

test_that("tidy and augment methods use tidy.lm, glance works", {
    r <- MASS::rlm(stack.loss ~ ., stackloss)
    expect_identical(tidy(r), tidy.lm(r))
    expect_identical(augment(r), augment.lm(r))
    gl <- glance(r)
    check_tidy(gl, exp.col = 6)
})
