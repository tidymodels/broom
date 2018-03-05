context("plm tidiers")

library(plm)

test_that("plm tidiers work", {
    data(Produc)
    zz <- plm(log(gsp) ~ log(pcap) + log(pc) + log(emp) + unemp,
              data = Produc, index = c("state","year"))
    
    td <- tidy(zz, conf.int = TRUE)
    check_tidy(td, exp.row = 4, exp.col = 7)
    
    au <- augment(zz)
    check_tidy(au, exp.col = 7)
    
    gl <- glance(zz)
    check_tidy(gl, exp.col = 6)
})
