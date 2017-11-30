context("decompose tidiers")

test_that("augment.decompose works", {
    d1a <- stats::decompose(nottem, type = "additive")
    d1b <- stats::decompose(nottem, type = "multiplicative")
    d2 <- stats::stl(nottem, s.window = "periodic", robust = TRUE)
    
    a1a <- augment(d1a)
    check_tidy(a1a, exp.row = 240, exp.col = 4)
    
    a1b <- augment(d1b)
    check_tidy(a1b, exp.row = 240, exp.col = 4)
    
    a2 <- augment(d2)
    check_tidy(a2, exp.row = 240, 5)
})
