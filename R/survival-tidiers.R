# # tidying functions for the survival package
# # http://cran.r-project.org/web/packages/survival/index.html
# 
# afit <- aareg(Surv(time, status) ~ age + sex + ph.ecog, data=lung,
#               dfbeta=TRUE)
# summary(afit)
# 
# tidy.aareg <- function(x, ...) {
#     nn <- c("estimate", "statistic", "stderror", "robust.se", "z", "p.value")
#     fix_data_frame(summary(x)$table, nn)
# }
# 
# 
# fit <- coxph(Surv(time, status) ~ age + sex, lung)
# 
# tidy.coxph <- function(x, ...) {
#     # decided not to include the exp(coef) vlaues
#     co <- coef(summary(fit))
#     nn <- c("estimate", "stderror", "statistic", "p.value")
#     fix_data_frame(co[, -2], nn)
# }
# 
# fit1 <- survexp(futime ~ 1, rmap=list(sex="male", year=accept.dt,
#                                       age=(accept.dt-birth.dt)), method='conditional', data=jasa)
# 
# summary(fit1)
# 
# tidy.survexp <- function(x, ...) {
#     as.data.frame(summary(x)[c("time", "surv", "n.risk")])
# }
# 
# 
# fit <- coxph(Surv(time, status) ~ age + sex, lung)
# sfit <- survfit(fit)
# 
# library(ggplot2)
# ggplot(tidy(sfit), aes(time, estimate)) + geom_line() + geom_ribbon(aes(ymin=conf.low, ymax=conf.high), alpha=.25)
# 
# tidy.survfit <- function(x, ...) {
#     ret <- as.data.frame(unclass(x)[c("time", "n.risk", "n.event",
#                                       "n.censor", "cumhaz")])
#     # give it names consistent with broom style
#     ret <- cbind(ret, estimate=x$surv, stderror=x$std.err,
#                  conf.high=x$upper, conf.low=x$lower)
#     ret
# }
# 
# 
# temp.yr  <- tcut(mgus$dxyr, 55:92, labels=as.character(55:91)) 
# temp.age <- tcut(mgus$age, 34:101, labels=as.character(34:100))
# ptime <- ifelse(is.na(mgus$pctime), mgus$futime, mgus$pctime)
# pstat <- ifelse(is.na(mgus$pctime), 0, 1)
# pfit <- pyears(Surv(ptime/365.25, pstat) ~ temp.yr + temp.age + sex,  mgus,
#                data.frame=TRUE) 
# 
# 
# 
# tidy.pyears <- 