% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ordinal-clm.R
\name{tidy.clm}
\alias{tidy.clm}
\alias{ordinal_tidiers}
\title{Tidy a(n) clm object}
\usage{
\method{tidy}{clm}(
  x,
  conf.int = FALSE,
  conf.level = 0.95,
  conf.type = c("profile", "Wald"),
  exponentiate = FALSE,
  ...
)
}
\arguments{
\item{x}{A \code{clm} object returned from \code{\link[ordinal:clm]{ordinal::clm()}}.}

\item{conf.int}{Logical indicating whether or not to include a confidence
interval in the tidied output. Defaults to \code{FALSE}.}

\item{conf.level}{The confidence level to use for the confidence interval
if \code{conf.int = TRUE}. Must be strictly greater than 0 and less than 1.
Defaults to 0.95, which corresponds to a 95 percent confidence interval.}

\item{conf.type}{Whether to use \code{"profile"} or \code{"Wald"} confidence
intervals, passed to the \code{type} argument of \code{\link[ordinal:confint.clm]{ordinal::confint.clm()}}.
Defaults to \code{"profile"}.}

\item{exponentiate}{Logical indicating whether or not to exponentiate the
the coefficient estimates. This is typical for logistic and multinomial
regressions, but a bad idea if there is no log or logit link. Defaults
to \code{FALSE}.}

\item{...}{Additional arguments. Not used. Needed to match generic
signature only. \strong{Cautionary note:} Misspelled arguments will be
absorbed in \code{...}, where they will be ignored. If the misspelled
argument has a default value, the default value will be used.
For example, if you pass \code{conf.lvel = 0.9}, all computation will
proceed using \code{conf.level = 0.95}. Two exceptions here are:
\itemize{
\item \code{tidy()} methods will warn when supplied an \code{exponentiate} argument if
it will be ignored.
\item \code{augment()} methods will warn when supplied a \code{newdata} argument if it
will be ignored.
}}
}
\description{
Tidy summarizes information about the components of a model.
A model component might be a single term in a regression, a single
hypothesis, a cluster, or a class. Exactly what tidy considers to be a
model component varies across models but is usually self-evident.
If a model has several distinct types of components, you will need to
specify which components to return.
}
\details{
In \verb{broom 0.7.0} the \code{coefficient_type} column was renamed to
\code{coef.type}, and the contents were changed as well.

Note that \code{intercept} type coefficients correspond to \code{alpha}
parameters, \code{location} type coefficients correspond to \code{beta}
parameters, and \code{scale} type coefficients correspond to \code{zeta}
parameters.
}
\examples{
\dontshow{if (rlang::is_installed("ordinal")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}

# load libraries for models and data
library(ordinal)

# fit model
fit <- clm(rating ~ temp * contact, data = wine)

# summarize model fit with tidiers
tidy(fit)
tidy(fit, conf.int = TRUE, conf.level = 0.9)
tidy(fit, conf.int = TRUE, conf.type = "Wald", exponentiate = TRUE)

glance(fit)
augment(fit, type.predict = "prob")
augment(fit, type.predict = "class")

# ...and again with another model specification
fit2 <- clm(rating ~ temp, nominal = ~contact, data = wine)

tidy(fit2)
glance(fit2)
\dontshow{\}) # examplesIf}
}
\seealso{
\link{tidy}, \code{\link[ordinal:clm]{ordinal::clm()}}, \code{\link[ordinal:confint.clm]{ordinal::confint.clm()}}

Other ordinal tidiers: 
\code{\link{augment.clm}()},
\code{\link{augment.polr}()},
\code{\link{glance.clm}()},
\code{\link{glance.clmm}()},
\code{\link{glance.polr}()},
\code{\link{glance.svyolr}()},
\code{\link{tidy.clmm}()},
\code{\link{tidy.polr}()},
\code{\link{tidy.svyolr}()}
}
\concept{ordinal tidiers}
\value{
A \code{\link[tibble:tibble]{tibble::tibble()}} with columns:
  \item{conf.high}{Upper bound on the confidence interval for the estimate.}
  \item{conf.low}{Lower bound on the confidence interval for the estimate.}
  \item{estimate}{The estimated value of the regression term.}
  \item{p.value}{The two-sided p-value associated with the observed statistic.}
  \item{statistic}{The value of a T-statistic to use in a hypothesis that the regression term is non-zero.}
  \item{std.error}{The standard error of the regression term.}
  \item{term}{The name of the regression term.}

}
