% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/list.R
\name{list_tidiers}
\alias{list_tidiers}
\alias{tidy.list}
\alias{glance.list}
\title{Tidying methods for lists / returned values that are not S3 objects}
\usage{
\method{tidy}{list}(x, ...)

\method{glance}{list}(x, ...)
}
\arguments{
\item{x}{A list, potentially representing an object that can be tidied.}

\item{...}{Additionally, arguments passed to the tidying function.}
}
\description{
Broom tidies a number of lists that are effectively S3 objects without
a class attribute. For example, \code{\link[stats:optim]{stats::optim()}}, \code{\link[base:svd]{base::svd()}} and
\code{\link[interp:interp]{interp::interp()}} produce consistent output, but because they do not
have a class attribute, they cannot be handled by S3 dispatch.
}
\details{
These functions look at the elements of a list and determine if there is
an appropriate tidying method to apply to the list. Those tidiers are
themselves are implemented as functions of the form \verb{tidy_<function>}
or \verb{glance_<function>} and are not exported (but they are documented!).

If no appropriate tidying method is found, throws an error.
}
\seealso{
Other list tidiers: 
\code{\link{glance_optim}()},
\code{\link{tidy_irlba}()},
\code{\link{tidy_optim}()},
\code{\link{tidy_svd}()},
\code{\link{tidy_xyz}()}
}
\concept{list tidiers}
