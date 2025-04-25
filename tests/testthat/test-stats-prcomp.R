skip_if_not_installed("modeltests")
library(modeltests)

pc <- prcomp(USArrests, scale = TRUE)

test_that("prcomp tidier arguments", {
  check_arguments(tidy.prcomp)
  check_arguments(augment.prcomp, strict = FALSE)
})


test_that("tidy.prcomp", {
  td <- tidy(pc, matrix = "d")

  check_tidy_output(td)
  check_dims(td, 4, 4)
  expect_identical(tidy(pc, matrix = "pcs"), td)
  expect_identical(tidy(pc, matrix = "eigenvalues"), td)

  td2 <- tidy(pc, matrix = "v")

  check_tidy_output(td2, strict = FALSE)
  check_dims(td2, 16, 3)

  expect_identical(
    tidy(pc, matrix = "rotation"),
    tidy(pc, matrix = "variables")
  )
  expect_identical(tidy(pc, matrix = "rotation"), td2)
  expect_identical(tidy(pc, matrix = "variables"), td2)
  expect_identical(tidy(pc, matrix = "loadings"), td2)

  td3 <- tidy(pc, matrix = "u")

  check_tidy_output(td3)
  check_dims(td3, 200, 3)
  expect_identical(tidy(pc, matrix = "x"), tidy(pc, matrix = "samples"))
  expect_identical(tidy(pc, matrix = "x"), td3)
  expect_identical(tidy(pc, matrix = "samples"), td3)
  expect_identical(tidy(pc, matrix = "scores"), td3)

  expect_snapshot(error = TRUE, tidy(pc, matrix = c("d", "u")))

  no_row_nm <- as.data.frame(matrix(1:9, ncol = 3) + rnorm(n = 9, sd = 0.25))
  pca <- prcomp(no_row_nm)
  expect_no_error(tidy(pca, matrix = "u"))
})

test_that("augment.prcomp", {
  check_augment_function(
    aug = augment.prcomp,
    model = pc,
    data = USArrests,
    newdata = USArrests,
    strict = FALSE
  )
})

test_that("augment.prcomp works with matrix objects", {
  suppressPackageStartupMessages(library(broom))
  set.seed(17)

  # data
  C <- chol(S <- toeplitz(.9^(0:31)))
  X <- matrix(rnorm(32000), 1000, 32)
  Z <- X %*% C

  # model
  pZ <- stats::prcomp(Z, tol = 0.1)

  # using stats predict method
  pred <- as.data.frame(predict(pZ))
  names(pred) <- paste0(".fitted", names(pred))

  # with data
  df1 <- broom::augment(pZ)

  # without data
  df2 <- broom::augment(pZ, data = Z)

  expect_equal(dim(df1), c(1000L, 15L))
  expect_equal(dim(df2), c(1000L, 47L))
  testthat::expect_equal(tibble::as_tibble(pred), df1[, -1])
  expect_s3_class(df1, "tbl_df")
})
