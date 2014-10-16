#' test the basics of tidy/augment/glance output: is a data frame, no row names
check_tidiness <- function(o) {
    expect_is(o, "data.frame")
    expect_equal(rownames(o), as.character(seq_len(nrow(o))))
}


#' check the output of a tidy function
check_tidy <- function(o, exp.row = NULL, exp.col = NULL, exp.names = NULL) {
    check_tidiness(o)

    if (!is.null(exp.row)) {
        expect_equal(nrow(o), exp.row)
    }
    if (!is.null(exp.col)) {
        expect_equal(ncol(o), exp.col)
    }
    if (!is.null(exp.names)) {
        expect_true(all(exp.names %in% colnames(o)))
    }
}


#' check the output of an augment function
check_augment <- function(au, original = NULL, exp.names = NULL) {
    check_tidiness(au)
    
    if (!is.null(original)) {
        # check that all rows in original appear in output
        expect_equal(nrow(au), nrow(original))
        
        # TODO: handle NAs etc
    }
    
    if (!is.null(exp.names)) {
        expect_true(all(exp.names %in% colnames(au)))
    }
}
