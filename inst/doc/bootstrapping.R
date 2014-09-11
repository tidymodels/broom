## ----setup, echo=FALSE---------------------------------------------------
library(knitr)
opts_chunk$set(message=FALSE)

## ------------------------------------------------------------------------
library(ggplot2)
data(mtcars)
ggplot(mtcars, aes(mpg, wt)) + geom_point()

## ------------------------------------------------------------------------
nlsfit <- nls(mpg ~ k / wt + b, mtcars, start=list(k=1, b=0))
summary(nlsfit)
ggplot(mtcars, aes(wt, mpg)) + geom_point() + geom_line(aes(y=predict(nlsfit)))

## ------------------------------------------------------------------------
library(dplyr)
bootreps <- data.frame(replication=1:100) %>% group_by(replication) %>%
    do(sample_n(mtcars, nrow(mtcars), replace=TRUE))

## ------------------------------------------------------------------------
library(broom)
bootnls <- bootreps %>% do(tidy(nls(mpg ~ k / wt + b, ., start=list(k=1, b=0))))
bootnls

## ------------------------------------------------------------------------
alpha = .05
bootnls %>% group_by(term) %>% summarize(low=quantile(estimate, alpha / 2),
                                         high=quantile(estimate, 1 - alpha / 2))

## ------------------------------------------------------------------------
library(ggplot2)
ggplot(bootnls, aes(estimate)) + geom_histogram(binwidth=2) + facet_wrap(~ term, scales="free")

