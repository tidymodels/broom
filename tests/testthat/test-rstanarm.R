# test tidy and glance methods from rstanarm_tidiers.R

if (require(rstanarm, quietly = TRUE)) {
    context("rstanarm models")
    test_that("tidy works on rstanarm fits", {
        td1 <- tidy(example_model)
        td2 <- tidy(example_model, parameters = "varying")
        td3 <- tidy(example_model, parameters = "hierarchical")
        expect_equal(colnames(td1), c("term", "estimate", "std.error"))
    })
    
    test_that("intervals works on rstanarm fits", {
        td1 <- tidy(example_model, intervals = TRUE, prob = 0.8)
        td2 <- tidy(example_model, parameters = "varying", intervals = TRUE, 
                    prob = 0.5)
        nms <- c("level", "group", "term", "estimate", "std.error", "lower", "upper")
        expect_equal(colnames(td2), nms)
    })
    
    test_that("glance works on rstanarm fits", {
        g1 <- glance(example_model)
        g2 <- glance(example_model, looic = TRUE, cores = 1)
    })
}
