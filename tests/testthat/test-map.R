context("map tidiers")

library(maps)

test_that("tidy.map works", {
    ca <- map("county", "ca", plot = FALSE, fill = TRUE)
    td <- tidy(ca)
    check_tidy(td, exp.col = 7)
})
