check_tidy <- function(o, exp.row = NULL, exp.col = NULL, exp.names = NULL) {
    expect_is(o, "data.frame")
    if (!is.null(exp.row)) {
        expect_equal(nrow(o), exp.row)
    }
    if (!is.null(exp.col)) {
        expect_equal(ncol(o), exp.col)
    }
    if (!is.null(exp.names)) {
        expect_true(all(exp.names %in% colnames(o)))
    }
    
    # test that there are no rownames
    expect_equal(rownames(o), as.character(seq_len(nrow(o))))
}
