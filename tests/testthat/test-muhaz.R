if (requireNamespace("muhaz")) {
    context("Kernel based hazard rate estimates via muhaz")
    data(ovarian, package = "survival")
    mz <- muhaz::muhaz(ovarian$futime, ovarian$fustat)
    test_that("tidy works on muhaz objects", {
        tidy(mz)
    })
    test_that("glance works on muhaz objects", {
        glance(mz)
    })
}
