context("estimatr")

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("estimatr")
library(estimatr)

data("alo_star_men")

lmfit <- lm_robust(GPA_year1 ~ sfsp, data = alo_star_men)
lmlinfit <- lm_lin(GPA_year1 ~ sfsp, ~ gpa0, data = alo_star_men)
test_that("tidy.lm_robust", {
  td <- tidy(lmfit)
  
  check_tidy_output(td)
  
  td2 <- tidy(lmlinfit)
  
  check_tidy_output(td2)
})

# Note: this is a meaningless regression
ivfit <- iv_robust(GPA_year1 ~ sfsp | gpa0, data = alo_star_men)

test_that("tidy.iv_robust", {
  td <- tidy(ivfit)
  
  check_tidy_output(td)
})

dimfit <- difference_in_means(GPA_year1 ~ sfsp, data = alo_star_men)

test_that("tidy.difference_in_means", {
  td <- tidy(dimfit)
  
  check_tidy_output(td)
})

htfit <- horvitz_thompson(
  GPA_year1 ~ sfsp,
  data = alo_star_men,
  condition_prs = mean(sfsp)
)

test_that("tidy.horvitz_thompson", {
  td <- tidy(htfit)
  
  check_tidy_output(td)
})


