# test tidy, augment, glance from pca objects

context("pca tidiers")

test_that("tidy.prcomp works", {
    pca <- prcomp(iris[-5])
    
    td <- tidy(pca)
    exp <- data.frame(`.rownames` = c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width'),
                      PC1 = c(0.36138659, -0.08452251, 0.85667061, 0.35828920),
                      PC2 = c(-0.65658877, -0.73016143, 0.17337266, 0.07548102),
                      PC3 = c(0.58202985, -0.59791083, -0.07623608, -0.54583143),
                      PC4 = c(0.3154872, -0.3197231, -0.4798390, 0.7536574),
                      stringsAsFactors = FALSE)
    expect_equal(td, exp, tolerance=1e-5)
    
    aug <- augment(pca, iris[-5])
    expect_equal(colnames(aug), c('Sepal.Length', 'Sepal.Width', 'Petal.Length', 'Petal.Width',
                                  'PC1', 'PC2', 'PC3', 'PC4'))
    
    gl <- glance(pca)
    exp <- data.frame(c('PC1', 'PC2', 'PC3', 'PC4'),
                      c(2.0562689, 0.4926162, 0.2796596, 0.1543862),
                      c(0.924618723, 0.053066483, 0.017102610, 0.005212184),
                      c(0.9246187, 0.9776852, 0.9947878, 1.0000000), 
                      stringsAsFactors = FALSE)
    colnames(exp) <- c('.rownames', 'Standard deviation', 'Proportion of Variance', 'Cumulative Proportion')
    expect_equal(gl, exp, tolerance=1e-5)
})
