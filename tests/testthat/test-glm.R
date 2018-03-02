context("glm tidiers")

test_that("glance.glm works", {
    g <- glm(am ~ mpg, mtcars, family = "binomial")
    gl <- glance(g)
    check_tidy(gl, exp.col = 7)
})
