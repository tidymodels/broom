## ----setup, echo=FALSE---------------------------------------------------
library(knitr)
opts_chunk$set(warning=FALSE, message=FALSE)

## ----import_broom--------------------------------------------------------
library(broom)

## ----lmfit---------------------------------------------------------------
lmfit = lm(mpg ~ wt, mtcars)
lmfit
summary(lmfit)

## ------------------------------------------------------------------------
tidy(lmfit)

## ----glmfit--------------------------------------------------------------
glmfit = glm(am ~ wt, mtcars, family="binomial")
tidy(glmfit)

## ------------------------------------------------------------------------
nlsfit = nls(mpg ~ k / wt + b, mtcars, start=list(k=1, b=0))
tidy(nlsfit)

## ----ttest---------------------------------------------------------------
tt = t.test(wt ~ am, mtcars)
tidy(tt)

## ------------------------------------------------------------------------
wt = wilcox.test(wt ~ am, mtcars)
tidy(wt)

