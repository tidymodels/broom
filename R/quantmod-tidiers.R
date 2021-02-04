tidy.quantmod <- function(symbol, from=Sys.Date()-500, to=Sys.Date()) {
	tseries <- suppressWarnings(getSymbols(symbol, from=from, to=to, auto.assign=FALSE))
	ret <- tibble(index=as.Date(index(tseries)), low=as.vector(Lo(tseries)), high=as.vector(Hi(tseries)), close=as.vector(Cl(tseries)))
	return(ret)
}
