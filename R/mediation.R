#' @templateVar class mediate
#' @template title_desc_tidy
#'
#' @param x A `mediate` object produced by a call to [mediation::mediate()].
#' @template param_confint
#' @template param_unused_dots
#'
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details The tibble has four rows. The first two indicate the mediated
#'   effect in the control and treatment groups, respectively. And the last
#'   two the direct effect in each group.
#'
#' @examplesIf rlang::is_installed("mediation")
#'
#' # load libraries for models and data
#' library(mediation)
#'
#' data("jobs", package = "mediation")
#'
#' # fit models
#' b <- lm(job_seek ~ treat + econ_hard + sex + age, data = jobs)
#' c <- lm(depress2 ~ treat + job_seek + econ_hard + sex + age, data = jobs)
#' mod <- mediate(b, c, sims = 50, treat = "treat", mediator = "job_seek")
#'
#' # summarize model fit with tidiers
#' tidy(mod)
#' tidy(mod, conf.int = TRUE)
#' tidy(mod, conf.int = TRUE, conf.level = .99)
#'
#' @export
#' @seealso [tidy()], [mediation::mediate()]
#' @family mediate tidiers
#' @aliases mediate_tidiers
tidy.mediate <- function(x, conf.int = FALSE, conf.level = .95, ...) {
  check_ellipses("exponentiate", "tidy", "mediate", ...)

  if (inherits(x, "psych")) {
    cli::cli_abort(c(
      "No tidy method for objects of class {.cls mediate} from the {.pkg psych} package.",
      "i" = "The {.fn tidy.mediate} method is intended for {.cls mediate} objects 
             from the {.pkg mediation} package."
    ))
  }

  d0 <- d1 <- z0 <- z1 <- d0.sims <- d1.sims <- z0.sims <- NULL
  z1.sims <- d0.p <- d1.p <- z0.p <- z1.p <- NULL
  s <- base::summary(x)
  nn <- c("term", "estimate", "std.error", "p.value", "conf.low", "conf.high")
  sims <- s$sims
  ci <- NULL
  co <- with(
    s,
    tibble(
      c("acme_0", "acme_1", "ade_0", "ade_1"),
      c(d0, d1, z0, z1),
      c(
        stats::sd(d0.sims),
        stats::sd(d1.sims),
        stats::sd(z0.sims),
        stats::sd(z1.sims)
      ),
      c(d0.p, d1.p, z0.p, z1.p)
    )
  )

  if (conf.int) {
    low <- (1 - conf.level) / 2
    high <- 1 - low
    BC.CI <- function(theta) {
      z.inv <- length(theta[theta < mean(theta)]) / sims
      z <- qnorm(z.inv)
      U <- (sims - 1) * (mean(theta) - theta)
      top <- sum(U^3)
      under <- 6 *
        (sum(U^2))^{
          3 / 2
        }
      a <- top / under
      lower.inv <- pnorm(z + (z + qnorm(low)) / (1 - a * (z + qnorm(low))))
      lower2 <- lower <- quantile(theta, lower.inv)
      upper.inv <- pnorm(z + (z + qnorm(high)) / (1 - a * (z + qnorm(high))))
      upper2 <- upper <- quantile(theta, upper.inv)
      return(c(lower, upper))
    }
    ci <- with(
      x,
      sapply(
        list(d0.sims, d1.sims, z0.sims, z1.sims),
        function(x) apply(x, 1, BC.CI)
      )
    )
    if (s$boot.ci.type != "bca") {
      CI <- function(theta) {
        return(quantile(theta, c(low, high), na.rm = TRUE))
      }
      ci <- with(
        x,
        sapply(
          list(d0.sims, d1.sims, z0.sims, z1.sims),
          function(x) apply(x, 1, CI)
        )
      )
    }

    co <- cbind(co, t(ci))
  }

  as_tidy_tibble(
    co,
    new_names = nn[1:ncol(co)]
  )
}
