#' @title Augment data with information from a(n) <%= class %> object
#'
#' @description Augment accepts a model object and a dataset and adds
#'   information about each observation in the dataset. Most commonly, this
#'   includes predicted values in the `.fitted` column, residuals in the
#'   `.resid` column, and standard errors for the fitted values in a `.se.fit`
#'   column. New columns always begin with a `.` prefix to avoid overwriting
#'   columns in the original dataset.
#'
#'   Users may pass data to augment via either the `data` argument or the
#'   `newdata` argument. If the user passes data to the `data` argument,
#'   it **must** be exactly the data that was used to fit the model
#'   object. Pass datasets to `newdata` to augment data that was not used
#'   during model fitting. This still requires that at least all predictor
#'   variable columns used to fit the model are present. If the original outcome
#'   variable used to fit the model is not included in `newdata`, then no
#'   `.resid` column will be included in the output.
#'
#'   Augment will often behave differently depending on whether `data` or
#'   `newdata` is given. This is because there is often information
#'   associated with training observations (such as influences or related)
#'   measures that is not meaningfully defined for new observations.
#'
#'   For convenience, many augment methods provide default `data` arguments,
#'   so that `augment(fit)` will return the augmented training data. In these
#'   cases, augment tries to reconstruct the original data based on the model
#'   object with varying degrees of success.
#'
#'   The augmented dataset is always returned as a [tibble::tibble] with the
#'   **same number of rows** as the passed dataset. This means that the passed
#'   data must be coercible to a tibble. If a predictor enters the model as part
#'   of a matrix of covariates, such as when the model formula uses
#'   [splines::ns()], [stats::poly()], or [survival::Surv()], it is represented
#'   as a matrix column.
#'
#'   We are in the process of defining behaviors for models fit with various
#'   `na.action` arguments, but make no guarantees about behavior when data is
#'   missing at this time.
#'
#' @md
