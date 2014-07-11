context("dplyr manipulation with tidy data")

library(dplyr)

# set up the lahman batting table, and filter to make it faster
batting <- tbl(lahman_df(), "Batting")
batting <- batting %>% filter(yearID > 1960)

test_that("can perform regressions with tidying in dplyr", {
    lm0 = failwith(NULL, lm, quiet=TRUE)
    regressions = batting %>% group_by(yearID) %>% do(tidy(lm0(SB ~ CS, data=.)))
    
    expect_less_than(30, nrow(regressions))
    expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                    colnames(regressions)))
})

test_that("can perform regressions with tidying in dplyr", {
    cor.test0 = failwith(NULL, cor.test, quiet=TRUE)
    pcors = batting %>% group_by(yearID) %>% do(tidy(cor.test0(.$SB, .$CS)))
    expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                        colnames(pcors)))
    expect_less_than(30, nrow(pcors))

    scors = suppressWarnings(batting %>% group_by(yearID) %>%
                                 do(tidy(cor.test0(.$SB, .$CS, method="spearman"))))
    expect_true(all(c("yearID", "estimate", "statistic", "p.value") %in%
                        colnames(scors)))
    expect_less_than(30, nrow(scors))
    expect_false(all(pcors$estimate == scors$estimate))
})
