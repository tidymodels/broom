# test fallback to texreg

context("texreg fallback")

    
test_that("fallback to texreg works", {
    if (! require("texreg")) skip("texreg not installed, skipping")
    if (! require("nlme")) skip("nlme not installed, skipping")
    data("Ovary", package = "nlme")
    fm1 <- nlme::gls(follicles ~ sin(2*pi*Time) + cos(2*pi*Time), Ovary,
        correlation = nlme::corAR1(form = ~ 1 | Mare))
    expect_silent(res <- tidy(fm1))
    check_tidy(res, exp.row = 3)
    expect_equal(res$term, c("(Intercept)", "sin(2 * pi * Time)", "cos(2 * pi * Time)"))
})

test_that("No infinite regress if texreg has no method either", {
    if (! require("texreg")) skip("texreg not installed, skipping")
    foo <- 1:5
    class(foo) <- "unknown_to_broom_and_texreg"
    # suppressWarnings avoids an earlier warning
    expect_error(suppressWarnings(tidy(foo)), "cannot coerce .* to a data.frame")
})
