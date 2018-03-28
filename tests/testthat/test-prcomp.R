context("prcomp tidiers")

pc <- prcomp(USArrests, scale = TRUE)

test_that("tidy.prcomp can return different sets of eigenvectors", {
    td <- tidy(pc, matrix = "d")
    check_tidy(td, exp.row = 4, exp.col = 4)
    expect_identical(tidy(pc, matrix = "pcs"), td)
    
    td <- tidy(pc, matrix = "v")
    check_tidy(td, exp.row = 16, exp.col = 3)
    expect_identical(tidy(pc, matrix = "rotation"), tidy(pc, matrix = "variables"))
    expect_identical(tidy(pc, matrix = "rotation"), td)
    expect_identical(tidy(pc, matrix = "variables"), td)
    
    td <- tidy(pc, matrix = "u")
    check_tidy(td, exp.row = 200, exp.col = 3)
    expect_identical(tidy(pc, matrix = "x"), tidy(pc, matrix = "samples"))
    expect_identical(tidy(pc, matrix = "x"), td)
    expect_identical(tidy(pc, matrix = "samples"), td)
})

test_that("tidy.prcomp can only return one type of matrix", {
    expect_error(tidy(pc, matrix = c("d", "u")))
})

test_that("augment.prcomp works with or without newdata argument", {
    au <- augment(pc)
    check_tidy(au, exp.row = 50, exp.col = 5)
    
    au <- augment(pc, data = USArrests)
    check_tidy(au, exp.row = 50, exp.col = 9)
    
    au <- augment(pc, newdata = USArrests)
    check_tidy(au, exp.row = 50, exp.col = 9)
})
