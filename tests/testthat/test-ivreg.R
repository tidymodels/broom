# test tidy, augment, glance methods from lme4-tidiers.R

if (require(AER, quietly = TRUE)) {
    context("AER::ivreg models")
    
    data("CigarettesSW", package = "AER")
    CigarettesSW$rprice <- with(CigarettesSW, price/cpi)
    CigarettesSW$rincome <- with(CigarettesSW, income/population/cpi)
    CigarettesSW$tdiff <- with(CigarettesSW, (taxs - tax)/cpi)
    ivr <- ivreg(log(packs) ~ log(rprice) + log(rincome) | log(rincome) + tdiff + I(tax/cpi),
          data = CigarettesSW, subset = year == "1995")
    
    test_that("tidy works on AER::ivreg fits", {
        td <- tidy(ivr)
        td2 <- tidy(ivr, conf.int = TRUE)
        expect_warning(tidy(ivr, exponentiate = TRUE)) # warning as we didn't use a link function, maybe this is bad?
    })
    
    test_that("augment works on ivreg fits", {
        au <- augment(ivr)
        expect_true(all(c('.resid', '.fitted') %in% names(au)))
        expect_equivalent(au$.resid, residuals(ivr))
        expect_equivalent(au$.fitted, fitted(ivr))
        old_cigs <- CigarettesSW[CigarettesSW$year == "1985" & CigarettesSW$tax < 40, ]
        au2 <- augment(ivr, newdata = old_cigs)
        expect_true('.fitted' %in% names(au2))
        expect_equivalent(au2$.fitted, predict(ivr, newdata = old_cigs))
    })
    
    test_that("glance works on ivreg fits", {
        g <- glance(ivr)
        check_tidy(g, exp.col = 7)
        g <- glance(ivr, diagnostics = TRUE)
        check_tidy(g, exp.col = 13)
    })
}
