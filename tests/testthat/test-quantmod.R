context("xts")
skip_on_cran()
skip_if_not_installed("modeltests")

skip_if_not_installed("xts")

test_that("tidy.quantmod", {
		  set.seed(1071)
		  index = as.Date('2016-06-23')
		  coredata <- c(TWLO.Low=23.66, TWLO.High=29.61, TWLO.Close=28.79)
		  expected <- tibble(index=index, low=as.vector(coredata[1]), high=as.vector(coredata[2]), close=as.vector(coredata[,3]))
		  expect_success(expected, tidy.quantmod('TWLO', from=index, to=index+1)) #suppressWarnings(getSymbols('TWLO', from="2016-06-23", to='2016-06-24', auto.assign=FALSE))))
})


