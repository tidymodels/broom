context("gmm tidiers")

library(gmm)

test_that("gmm tidiers work", {
    data(Finance)
    r <- Finance[1:300, 1:10]
    rm <- Finance[1:300, "rm"]
    rf <- Finance[1:300, "rf"]
    
    z <- as.matrix(r - rf)
    t <- nrow(z)
    zm <- rm - rf
    h <- matrix(zm, t, 1)
    res <- gmm(z ~ zm, x = h)
    
    td <- tidy(res)
    check_tidy(td, exp.col = 6)
    
    td <- tidy(res, conf.int = TRUE)
    check_tidy(td, exp.col = 8)
    
    td <- tidy(res, quick = TRUE)
    check_tidy(td, exp.col = 3)
    
    gl <- glance(res)
    check_tidy(gl, exp.col = 4)
})
