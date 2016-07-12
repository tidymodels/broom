context("dplyr and broom")

# set up the lahman batting table, and filter to make it faster
batting <- tbl(lahman_df(), "Batting")
batting <- batting %>% filter(yearID > 1980)

lm0 <- failwith(NULL, lm, quiet = TRUE)

test_that("can perform regressions with tidying in dplyr", {
    regressions <- batting %>% group_by(yearID) %>% do(tidy(lm0(SB ~ CS, data=.)))
        
    expect_lt(30, nrow(regressions))
    expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                    colnames(regressions)))
})

test_that("tidying methods work with rowwise_df", {
    regressions <- batting %>% group_by(yearID) %>% do(mod = lm0(SB ~ CS, data=.))
    tidied <- regressions %>% tidy(mod)
    augmented <- regressions %>% augment(mod)
    glanced <- regressions %>% glance(mod)
    
    num_years <- length(unique(batting$yearID))
    expect_equal(nrow(tidied), num_years * 2)
    expect_equal(nrow(augmented), sum(!is.na(batting$SB) & !is.na(batting$CS)))
    expect_equal(nrow(glanced), num_years)
})


test_that("can perform correlations with tidying in dplyr", {
    cor.test0 <- failwith(NULL, cor.test, quiet=TRUE)
    pcors <- batting %>% group_by(yearID) %>% do(tidy(cor.test0(.$SB, .$CS)))
    expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                        colnames(pcors)))
    expect_lt(30, nrow(pcors))

    scors <- suppressWarnings(batting %>% group_by(yearID) %>%
                                 do(tidy(cor.test0(.$SB, .$CS, method="spearman"))))
    expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                        colnames(scors)))
    expect_lt(30, nrow(scors))
    expect_false(all(pcors$estimate == scors$estimate))
})
