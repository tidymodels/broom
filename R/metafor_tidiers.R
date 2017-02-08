#' Tidying methods for meta-analysis models (via the metafor package)
#' 
#' These methods include a tidy and a glance for a meta-analytic fixed- and 
#' random/mixed-effects models with or without moderators via linear (mixed-effects) 
#' models. See the documentation of the metafor-package for more details on these models.
#' 
#' @template boilerplate
#' 
#' @name metafor_tidiers
#' 
#' @param x model object returned by \code{\link[metafor]{rma}}
#' @param ... ignored.
#'
NULL

#' @rdname metafor_tidiers
#' 
#' @details 
#' A tidy method for the coefficients of a meta analysis.
#' 
#' @return \code{tidy.rma} returns a data frame with one row for each coefficient.
#' The columns include:
#' 
#' * b	- estimated coefficients of the model.
#' 
#' * se - standard errors of the coefficients.
#' 
#' * zval - test statistics of the coefficients.
#' 
#' * pval - p-values for the test statistics.
#' 
#' * ci.lb	- lower bound of the confidence intervals for the coefficients.
#' 
#' * ci.ub	- upper bound of the confidence intervals for the coefficients.
#' 
#' 
#' @export
tidy.rma <- function(x, ...) {
  with(x,
       data.frame(b = b, se = se, zval = zval, pval = pval, ci.lb = ci.lb, ci.ub = ci.ub))
}
# tidy.rma(a)
# tidy.rma(fit_AR_3)
# tidy.rma(fit_AR_3)


#' @rdname metafor_tidiers
#' 
#' @details 
#' A glance method for the meta analysis model's statistics.
#' 
#' @return \code{glance.rma} returns a data frame with one row with common statistics.
#' 
#' * The columns include:
#' 
#' * tau2 - estimated amount of (residual) heterogeneity. Always 0 when method="FE".
#' 
#' * se.tau2 - estimated standard error of the estimated amount of (residual) heterogeneity.
#' 
#' * k - number of outcomes included in the model fitting.
#' 
#' * p - number of coefficients in the model (including the intercept).
#' 
#' * m - number of coefficients included in the omnibus test of coefficients.
#' 
#' * QE - test statistic for the test of (residual) heterogeneity.
#' 
#' * QEp - p-value for the test of (residual) heterogeneity.
#' 
#' * QM - test statistic for the omnibus test of coefficients.
#' 
#' * QMp - p-value for the omnibus test of coefficients.
#' 
#' * I2 - value of I^2. See print.rma.uni for more details.
#' 
#' * H2 - value of H^2. See print.rma.uni for more details.
#' 
#' * R2 - value of R^2. See print.rma.uni for more details.
#' 
#' * int.only - logical that indicates whether the model is an intercept-only model.
#' 
#' @export
glance.rma <- function(x, ...) {
  # tau2 = tau2 , se.tau2 = se.tau2 , tau2.fix = tau2.fix , k = k , k.f = k.f , k.eff = k.eff , p = p , p.eff = p.eff , parms = parms , m = m , QE = QE , QEp = QEp , QM = QM , QMp = QMp , I2 = I2 , H2 = H2 , R2 = R2 , int.only = int.only , int.incl = int.incl , allvipos = allvipos , ai.f = ai.f , bi.f = bi.f , ci.f = ci.f , di.f = di.f , x1i.f = x1i.f , x2i.f = x2i.f , t1i.f = t1i.f , t2i.f = t2i.f , slab.null = slab.null , measure = measure , method = method , weighted = weighted , test = test , dfs = dfs , s2w = s2w , intercept = intercept , digits = digits , level = level , verbose = verbose , add = add , to = to , drop00 = drop00 , version = version , model = model ,
  with(x,
       data.frame(tau2 = tau2 , se.tau2 = se.tau2 ,  k = k , 
                  p = p , m = m , QE = QE , 
                  QEp = QEp , QM = QM , QMp = QMp , I2 = I2 , H2 = H2 , # R2 = R2 , 
                  int.only = int.only))
}



