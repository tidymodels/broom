% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cluster.R
\name{tidy.pam}
\alias{tidy.pam}
\alias{pam_tidiers}
\title{Tidy a(n) pam object}
\usage{
\method{tidy}{pam}(x, col.names = paste0("x", 1:ncol(x$medoids)), ...)
}
\arguments{
\item{x}{An \code{pam} object returned from \code{\link[cluster:pam]{cluster::pam()}}}

\item{col.names}{Column names in the input data frame.
Defaults to the names of the variables in x.}

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
For examples, see the pam vignette.
}
\examples{
\dontshow{if (rlang::is_installed(c("cluster", "modeldata", "ggplot2")) && identical(Sys.getenv("NOT_CRAN"), "true")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}

# load libraries for models and data
library(dplyr)
library(ggplot2)
library(cluster)
library(modeldata)
data(hpc_data)

x <- hpc_data[, 2:5]
p <- pam(x, k = 4)

# summarize model fit with tidiers + visualization
tidy(p)
glance(p)
augment(p, x)

augment(p, x) |>
  ggplot(aes(compounds, input_fields)) +
  geom_point(aes(color = .cluster)) +
  geom_text(aes(label = cluster), data = tidy(p), size = 10)
\dontshow{\}) # examplesIf}
}
\seealso{
\code{\link[=tidy]{tidy()}}, \code{\link[cluster:pam]{cluster::pam()}}

Other pam tidiers: 
\code{\link{augment.pam}()},
\code{\link{glance.pam}()}
}
\concept{pam tidiers}
\value{
A \code{\link[tibble:tibble]{tibble::tibble()}} with columns:
  \item{size}{Size of each cluster.}
  \item{max.diss}{Maximal dissimilarity between the observations in the
    cluster and that cluster's medoid.}
  \item{avg.diss}{Average dissimilarity between the observations in the
    cluster and that cluster's medoid.}
  \item{diameter}{Diameter of the cluster.}
  \item{separation}{Separation of the cluster.}
  \item{avg.width}{Average silhouette width of the cluster.}
  \item{cluster}{A factor describing the cluster from 1:k.}

}
