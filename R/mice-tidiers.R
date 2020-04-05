#' @templateVar class mipo
#' @template title_desc_tidy
#' 
#' @param x A `mipo` objected returned by [mice::pool()].
#' @template param_confint
#' @template param_unused_dots
#' @evalRd return_tidy(
#'     "estimate",
#'     "ubar",
#'     "b",
#'     "t",
#'     "dfcom",
#'     "df",
#'     "riv",
#'     "lambda",
#'     "fmi",
#'     "p.value",
#'     "conf.low", 
#'     "conf.high")
#' @aliases mice_tidiers
#' @export
#' @seealso [tidy()]
#' @family mice tidiers
#'
#' @examples
#'
#' library(mice)
#' dat <- data.frame(y = c(.1, .2, .3, .4, .5), 
#'                   x = c(.01, .02, .04, .02, .01), 
#'                   z = c(0, 2, 1, NA, 5))
#' imp <- mice(dat, print = FALSE, seed = 1234)
#' fit <- with(imp, lm(y ~ x + z))
#' poo <- pool(fit)
#' tidy(poo, conf.int = TRUE, conf.level = .90)
#'
#' glance(poo)
#'
#'
#' return_tidy
#' @note
tidy.mipo <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {

	# summarize pooled models using summary method supplied by mice
    # NOTE: could use type = 'all' to extract more information
	out <- summary(x, conf.int = conf.int, 
                   conf.level = conf.level, ...)

    # term: factor -> character
	out$term <- as.character(out$term)

	# rename confidence intervals if present
	idx <- grepl('^\\d.*\\%', names(out))
	names(out)[idx] <- c("conf.low", "conf.high")

	# output a tibble
	out <- tibble::as_tibble(out)
	out
}


#' @templateVar class mice
#' @template title_desc_tidy
#' 
#' @export
#' @seealso [tidy()]
#' @family mice tidiers
#' @inherit tidy.mipo params examples
#'
tidy.mira <- function(x, conf.int = FALSE, conf.level = 0.95, ...) {
	# pool observations
	out <- mice::pool(x, ...)

    # summarize mipo object
    out <- tidy(out, conf.int = conf.int, conf.level = conf.level, ...)
    out
}


#' @templateVar class mice
#' @template title_desc_glance
#' 
#' @inherit tidy.mipo examples
#'
#' @evalRd return_glance("nimp")
#' @export
#' @seealso [glance()]
#' @family mice tidiers
#' @export
#' @family tidiers
glance.mipo <- function(x, ...) {
	out <- tibble::tibble(nimp = x$m[1])
	out
}


#' @templateVar class mice
#' @template title_desc_glance
#' 
#' @inherit glance.mipo params
#' @inherit tidy.mipo examples
#'
#' @evalRd return_glance(
#'     "m", 
#'     "r.squared", 
#'     "adj.r.squared"
#'     )
#' @export
#' @seealso [glance()]
#' @family mice tidiers
#' @export
glance.mira <- function(x, ...) {
	poo <- mice::pool(x, ...)
	out <- glance(poo, ...)

    # number of observations
	out$nobs <- tryCatch(stats::nobs(x$analyses[[1]]), error = function(e) NULL)

    # if linear model, get r2
	if (class(x$analyses[[1]])[1] == 'lm') {
    	out$r.squared <- mice::pool.r.squared(x, adjusted = FALSE)[1]
	}

	# output
	out
}
