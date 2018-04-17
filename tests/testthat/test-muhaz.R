if (requireNamespace("muhaz")) {
    context("Kernel based hazard rate estimates via muhaz")
    data(ovarian, package = "survival")
    mz <- muhaz::muhaz(ovarian$futime, ovarian$fustat)
    test_that("tidy works on muhaz objects", {
        td <- tidy(mz)
        check_tidy(td, exp.col = 2)
    })
    test_that("glance works on muhaz objects", {
        gl <- glance(mz)
        check_tidy(gl, exp.col = 5)
    })
}
