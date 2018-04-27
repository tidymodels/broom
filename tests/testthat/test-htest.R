context("htest tidiers")

test_that("tidy.htest same as glance.htest", {
    tt <- t.test(rnorm(10))
    expect_identical(tidy(tt), glance(tt))
})

test_that("oneway.test works", {
    ot <- oneway.test(extra ~ group, data = sleep)
    expect_message(td <- tidy(ot))
    check_tidy(td, exp.col = 5)
})
