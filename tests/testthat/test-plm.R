context("plm tidiers")

test_that("plm tidiers work", {
  skip_if_not_installed("plm")

  data(Produc, package = "plm")
  zz <- plm::plm(log(gsp) ~ log(pcap) + log(pc) + log(emp) + unemp,
    data = Produc, index = c("state", "year")
  )

  td <- tidy(zz, conf.int = TRUE)
  check_tidy(td, exp.row = 4, exp.col = 7)

  au <- augment(zz)
  check_tidy(au, exp.col = 7)

  gl <- glance(zz)
  check_tidy(gl, exp.col = 6)
})
