
if (require(tseries, quietly = TRUE)) {
    context("tseries::garch models")
    
    data(EuStockMarkets)
    dax <- diff(log(EuStockMarkets))[,"DAX"]
    dax.garch <- garch(dax, control = garch.control(trace = FALSE))

    test_that("it should tidy tseries::garch fits", {
        td <- tidy(dax.garch)
        check_tidy(td, exp.row = 3)
    })
    
    test_that("it should glance tseries::garch fits", {
        gl <- glance(dax.garch)
        check_tidy(gl, exp.row = 1, exp.col = 7)
    })
    
    test_that("it should augment tseries::garch fits", {
        expect_error(augment(dax.garch)) # data argument cannot be empty
        au <- augment(dax.garch, dax)
        check_tidy(au, exp.col = 4)
        au <- augment(dax.garch, newdata = dax)
        check_tidy(au, exp.col = 3)
    })
}
