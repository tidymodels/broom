#' @templateVar class mediate
#' @template title_desc_tidy
#' 
#' @param x A `mediate` object produced by a call to [mediation::mediate()].
#' @template param_confint
#' @template param_unused_dots
#' 
#' @evalRd return_tidy(regression = TRUE)
#'
#' @details The tibble has one row for each term in the regression. 
#'
#' @examples
#'
#' library(mediation)
#' data(jobs)
#'
#' b <- lm(job_seek ~ treat + econ_hard + sex + age, data = jobs)
#' c <- lm(depress2 ~ treat + job_seek + econ_hard + sex + age, data = jobs)
#' mod <- mediate(b, c, sims = 50, treat = "treat", mediator = "job_seek")
#'
#' mod
#' tidy(mod)
#' tidy(mod, conf.int = TRUE)
#' tidy(mod, conf.int = TRUE, conf.level = .99)
#'
#' augment(mod)
#'
#' glance(mod)
#'
#' @export
#' @seealso [tidy()], [mediation::mediate()]
#' @family mediate tidiers
#' @aliases mediate_tidiers
tidy.mediate <- function(x, conf.int = FALSE, conf.level = .95, ...){
  s <- summary(x)
  ret <- tidy.summary.mediate(s, conf.int, conf.level)
  as_tibble(ret)
}


#' @rdname tidy.mediate
#' @export
tidy.summary.mediate <- function(s, conf.int = FALSE, conf.level = .95, ...){
  nn <- c("term", "estimate", "std.error", "p.value", "conf.low", "conf.high")
  ci <- NULL
  co <- with(s, 
             cbind( c("acme_0", "acme_1", "ade_0", "ade_1"), 
                    c(d0, d1, z0, z1),
                    c(sd(d0.sims), sd(d1.sims) , sd(z0.sims), sd(z1.sims)),
                    c(d0.p, d1.p, z0.p, z1.p)))
  
  
  if(confint){
    low <- (1 - conf.level)/2
    high <- 1 - low
    if(s$boot.ci.type == "bca"){
      BC.CI <- function(theta){
        z.inv <- length(theta[theta < mean(theta)])/sims
        z <- qnorm(z.inv)
        U <- (sims - 1) * (mean(theta) - theta)
        top <- sum(U^3)
        under <- 6 * (sum(U^2))^{3/2}
        a <- top / under
        lower.inv <-  pnorm(z + (z + qnorm(low))/(1 - a * (z + qnorm(low))))
        lower2 <- lower <- quantile(theta, lower.inv)
        upper.inv <-  pnorm(z + (z + qnorm(high))/(1 - a * (z + qnorm(high))))
        upper2 <- upper <- quantile(theta, upper.inv)
        return(c(lower, upper))      
      }
      ci <- sapply(list(d0.sims, d1.sims, z0.sims, z1.sims), function(x)  apply(x, 1, BC.CI))
    } else {
      CI <- function(theta){
        return(quantile(theta, c(low, high), na.rm = TRUE))
      }
      ci <- with(s,
                 sapply(list(d0.sims, d1.sims, z0.sims, z1.sims), function(x)  apply(x, 1, CI)))
    }
    
    co <- cbind(co, t(ci))
    
    
  } 
  
  ret <- fix_data_frame(co, nn[1:ncol(co)])
  as_tibble(ret)
  
}
