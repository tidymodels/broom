# test fallback to texreg

context("texreg fallback")

skip_without_texreg_and <- function (pkg = character(0)) {
    if (! requireNamespace("texreg", quietly = TRUE)) skip(
        "texreg not installed, skipping")
    for (p in pkg) {
        if (! requireNamespace(p, quietly = TRUE)) skip(
            paste("Package", p, "not installed, skipping"))
    }
}
    
test_that("fallback to texreg works", {
    skip_without_texreg_and("nlme")
    data("Ovary", package = "nlme")
    fm1 <- nlme::gls(follicles ~ sin(2*pi*Time) + cos(2*pi*Time), Ovary,
        correlation = nlme::corAR1(form = ~ 1 | Mare))
    expect_silent(res <- tidy(fm1))
    check_tidy(res, exp.row = 3)
    expect_equal(res$term, c("(Intercept)", "sin(2 * pi * Time)", "cos(2 * pi * Time)"))
})

test_that("No infinite regress if texreg has no method either", {
    skip_without_texreg_and()
    foo <- 1:5
    class(foo) <- "unknown_to_broom_and_texreg"
    as.data.frame.unknown_to_broom_and_texreg <- function (x, ...) data.frame(a = 1:5)
    expect_warning(tidy(foo), "using as.data.frame")
})
    

    
