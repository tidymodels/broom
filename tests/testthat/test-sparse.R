context("sparse tidiers")

library(Matrix)

m <- Matrix(0 + 1:28, nrow = 4)
m[-3, c(2, 4:5, 7)] <- m[3, 1:4] <- m[1:3, 6] <- 0
rownames(m) <- letters[1:4]
colnames(m) <- 1:7
mT <- as(m, "dgTMatrix")
mC <- as(m, "dgCMatrix")
mS <- as(m, "sparseMatrix")

test_that("tidy.dgTMatrix works", {
    td <- tidy(mT)
    check_tidy(td, exp.row = 9, exp.col = 3)
})

test_that("tidy.dgCMatrix uses tidy.dgTMatrix", {
    expect_identical(tidy(mC), tidy.dgTMatrix(mC))
})
