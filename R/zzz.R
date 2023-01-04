.onLoad <- function(libname, pkgname) {
  backports::import(pkgname)
  
  # - If poissonreg isn't installed, register the method (`packageVersion()` will error here)
  # - If poissonreg >= 1.0.1.9001 is installed, register the method
  should_register_pscl_tidiers <- tryCatch(
    expr = utils::packageVersion("poissonreg") >= "1.0.1.9001",
    error = function(cnd) TRUE
  )
  if (should_register_pscl_tidiers) {
    # `tidy.hurdle()` and `tidy.zeroinfl()` moved from poissonreg to workflows
    vctrs::s3_register("generics::tidy", "hurdle", tidy_hurdle)
    vctrs::s3_register("generics::tidy", "zeroinf", tidy_zeroinfl)
  }
}
