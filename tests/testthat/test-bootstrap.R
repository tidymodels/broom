context("bootstrapping")

test_that("bootstrap works with by_group and grouped tbl", {
    df <- data_frame(x = c(rep("a", 3), rep("b", 5)),
                    y = rnorm(length(x)))
    df_reps <-
        df %>%
        group_by(x) %>%
        bootstrap(20, by_group = TRUE) %>%
        do(tally(group_by(., x)))
    expect_true(all(filter(df_reps, x == "a")$n == 3))
    expect_true(all(filter(df_reps, x == "b")$n == 5))                  
})

test_that("bootstrap does not sample within groups if by_group = FALSE", {
    set.seed(12334)
    df <- data_frame(x = c(rep("a", 3), rep("b", 5)),
                     y = rnorm(length(x)))
    df_reps <-
        df %>%
        group_by(x) %>%
        bootstrap(20, by_group = FALSE) %>%
        do(tally(group_by(., x)))
    expect_true(!all(filter(df_reps, x == "a")$n == 3))
    expect_true(!all(filter(df_reps, x == "b")$n == 5))                  
})

test_that("bootstrap does not sample within groups if no groups", {
    set.seed(12334)
    df <- data_frame(x = c(rep("a", 3), rep("b", 5)),
                     y = rnorm(length(x)))
    df_reps <-
        df %>%
        ungroup() %>%
        bootstrap(20, by_group = TRUE) %>%
        do(tally(group_by(., x)))
    expect_true(!all(filter(df_reps, x == "a")$n == 3))
    expect_true(!all(filter(df_reps, x == "b")$n == 5))                  
})
