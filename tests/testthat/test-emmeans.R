context("emmeans")

skip_on_cran()

skip_if_not_installed("modeltests")
library(modeltests)

skip_if_not_installed("lsmeans")
library(lsmeans)

fit <- lm(sales1 ~ price1 + price2 + day + store, data = oranges)
rg <- ref.grid(fit)

marginal <- lsmeans(rg, ~day)

marginal_summary <- summary(marginal, infer = TRUE)
joint_tests_summary <- joint_tests(fit)

# generate dataset with dashes
marginal_dashes <- tibble(
  y = rnorm(100),
  x = rep(c("Single", "Double-Barrelled"), 50)
) %>%
  lm(y ~ x, data = .) %>%
  lsmeans::lsmeans(., ~x) %>%
  lsmeans::contrast(., "pairwise")

test_that("lsmeans tidier arguments", {
  check_arguments(tidy.lsmobj, strict = FALSE)
  check_arguments(tidy.ref.grid)
  check_arguments(tidy.emmGrid)
})

test_that("tidy.lsmobj", {
  tdm <- tidy(marginal)
  tdmd <- tidy(marginal_dashes)
  tdc <- tidy(contrast(marginal, method = "pairwise"))

  check_tidy_output(tdm, strict = FALSE)
  check_tidy_output(tdmd, strict = FALSE)
  check_tidy_output(tdc, strict = FALSE)

  check_dims(tdm, 6, 6)
  check_dims(tdmd, 1, 8)
  check_dims(tdc, 15, 8)

  tdm <- tidy(marginal, conf.int = TRUE)
  tdmd <- tidy(marginal_dashes, conf.int = TRUE)
  tdc <- tidy(contrast(marginal, method = "pairwise"), conf.int = TRUE)

  check_dims(tdm, 6, 7)
  check_dims(tdmd, 1, 9)
  check_dims(tdc, 15, 9)
})

test_that("ref.grid tidiers work", {
  td <- tidy(rg)
  check_tidy_output(td, strict = FALSE)
  check_dims(td, 36, 9)

  td <- tidy(rg, conf.int = TRUE)
  check_dims(td, 36, 10)
})

test_that("summary_emm tidiers work", {
  tdm <- tidy(marginal, conf.int = TRUE)
  tdms <- tidy(marginal_summary)

  expect_identical(tdm, tdms)

  tdjt <- tidy(joint_tests_summary)
  check_tidy_output(tdjt)
  check_dims(tdjt, 2, 5)
})

test_that("tidy.ref.grid consistency with tidy.TukeyHSD", {
  amod <- aov(breaks ~ wool + tension, data = warpbreaks)
  td_hsd <- tidy(TukeyHSD(amod, "tension"))

  td_pairs <- lsmeans(amod, ~tension) %>%
    pairs(reverse = TRUE) %>%
    tidy(conf.int = TRUE) %>%
    dplyr::select(-statistic, -df) %>%
    mutate(contrast = gsub(" ", "", contrast))

  expect_equal(
    as.data.frame(td_hsd),
    as.data.frame(td_pairs),
  )
})

test_that("tidy.ref.grid consistency with tidy.glht", {
  pigs.aov <- aov(log(conc) ~ source, data = pigs)
  pigs.emm.s <- emmeans(pigs.aov, "source")

  pigs.emm_c <- contrast(
    pigs.emm.s,
    list(lambda1 = c(1, 2, 0), lambda2 = c(0, 3, -2)),
    offset = c(-7, 1),
    adjust = "none"
  )

  td_emm <- tidy(pigs.emm_c) %>%
    dplyr::select(-df)

  pigs.aov <- aov(log(conc) ~ 0 + source, data = pigs)
  K <- rbind(
    c(1, 2, 0),
    c(0, 3, -2)
  )
  rownames(K) <- c("lambda1", "lambda2")
  colnames(K) <- names(coef(pigs.aov))

  aov_glht <- multcomp::glht(pigs.aov, linfct = multcomp::mcp(source = K), rhs = c(7, -1))
  tidy_glht <- tidy(aov_glht, test = multcomp::adjusted("none")) %>%
    mutate(
      estimate = estimate - null.value,
      null.value = -null.value
    )

  expect_equal(
    as.data.frame(td_emm),
    as.data.frame(purrr::map_dfr(tidy_glht, unname)),
    tolerance = 0.000001
  )
})

test_that("tidy.emmGrid for combined contrasts", {
  noise.lm <- lm(noise ~ size * type * side, data = auto.noise)
  noise.emm <- emmeans(noise.lm, ~ size * side * type)
  noise_c.s <- contrast(noise.emm,
                        method = "consec", 
                        simple = "each", 
                        combine = TRUE, 
                        adjust = "mvt")
  td_noise <- tidy(noise_c.s)

  # strict = FALSE needed becasue of factor names and "null.value" column
  check_tidy_output(td_noise, strict = FALSE)
  check_dims(td_noise, 20, 11)
})
