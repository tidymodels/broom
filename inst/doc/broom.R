## ----setup, echo=FALSE---------------------------------------------------
library(knitr)
opts_chunk$set(cache=TRUE, warning=FALSE, message=FALSE)

## ----import_broom--------------------------------------------------------
library(broom)

## ----lmfit, dependson="import_broom"-------------------------------------
lmfit = lm(mpg ~ wt, mtcars)
lmfit
summary(lmfit)

## ----, dependson="lmfit"-------------------------------------------------
tidy(lmfit)

## ----glmfit, dependson="import_broom"------------------------------------
glmfit = glm(am ~ wt, mtcars, family="binomial")
tidy(glmfit)

## ----ttest, dependson="import_broom"-------------------------------------
tt = t.test(wt ~ am, mtcars)
tidy(tt)

## ----wtest, dependson="import_broom"-------------------------------------
wt = wilcox.test(wt ~ am, mtcars)
tidy(wt)

