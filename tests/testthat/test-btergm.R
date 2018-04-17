context("btergm tidiers")

test_that("btergm tidiers work", {
    networks <- list()
    for (i in 1:10) {
        mat <- matrix(rbinom(100, 1, .25), nrow = 10, ncol = 10)
        diag(mat) <- 0
        nw <- network::network(mat)
        networks[[i]] <- nw
    }
    covariates <- list()
    for (i in 1:10) {
        mat <- matrix(rnorm(100), nrow = 10, ncol = 10)
        covariates[[i]] <- mat
    }
    btfit <- btergm::btergm(
        networks ~ edges + istar(2) + edgecov(covariates), R = 100,
        verbose = FALSE)
    td <- tidy(btfit)
    check_tidy(td, exp.row = 3, exp.col = 4)
    
    td <- tidy(btfit, exponentiate = TRUE)
    check_tidy(td, exp.row = 3, exp.col = 4)
    
    tdq <- tidy(btfit, quick = TRUE)
    check_tidy(tdq, exp.row = 3, exp.col = 2)
})
