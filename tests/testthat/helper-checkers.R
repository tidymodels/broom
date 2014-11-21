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
check_augment <- function(au, original = NULL, exp.names = NULL,
                          same = NULL) {
    check_tidiness(au)
    
    if (!is.null(original)) {
        # check that all rows in original appear in output
        expect_equal(nrow(au), nrow(original))
        # check that columns are the same
        for (column in same) {
            expect_equal(au[[column]], original[[column]])
        }
    }
    
    if (!is.null(exp.names)) {
        expect_true(all(exp.names %in% colnames(au)))
    }
}


#' add NAs to a vector randomly
#' 
#' @param v vector to add NAs to
#' @param number number of NAs to add
#' 
#' @return vector with NAs added randomly
add_NAs <- function(v, number) {
    if (number >= length(v)) {
        stop("Would replace all or more values with NA")
    }
    v[sample(length(v), number)] <- NA
    v
}

#' check an augmentation function works as expected when given NAs
#' 
#' @param func A modeling function that takes a dataset and additional
#' arguments, including na.action 
#' @param .data dataset to test function on; must have at least 3 rows
#' and no NA values
#' @param column a column included in the model to be replaced with NULLs
#' @param column2 another column in the model; optional
#' @param ... extra arguments, not used
#' 
#' @export
check_augment_NAs <- function(func, .data, column, column2 = NULL, ...) {
    # test original version, with and without giving data to augment
    obj <- class(func(.data))[1]

    test_that(paste("augment works with", obj), {
        m <- func(.data)
        au <- augment(m)
        check_augment(au, .data)
        au_d <- augment(m, .data)
        check_augment(au_d, .data, same = colnames(.data))
    })
    
    # add NAs
    if (nrow(.data) < 3) {
        stop(".data must have at least 3 rows in NA testing")
    }
    
    check_omit <- function(au, dat) {
        NAs <- is.na(dat[[column]])
        
        check_augment(au, dat[!NAs, ], same = c(column, column2))
        if (!is.null(au$.rownames)) {
            expect_equal(rownames(dat)[!NAs], au$.rownames)            
        }
    }
    
    check_exclude <- function(au, dat) {
        check_augment(au, dat, colnames(dat))
        # check .fitted and .resid columns have NAs in the right place
        for (col in c(".fitted", ".resid")) {
            if (!is.null(au[[col]])) {
                expect_equal(is.na(au[[col]]), is.na(dat[[column]]))
            }
        }
    }
    
    # test augment with na.omit (factory-fresh setting in R)
    # and test with or without rownames
    num_NAs <- min(5, nrow(.data) - 2)
    .dataNA <- .data
    .dataNA[[column]] <- add_NAs(.dataNA[[column]], num_NAs)
    
    test_that(paste("augment works with", obj, "with na.omit"), {
        .dataNA_noname <- unrowname(.dataNA)
        for (d in list(.dataNA, .dataNA_noname)) {
            m <- func(d, na.action = "na.omit")
            au <- augment(m)
            check_omit(au, d)
            au_d <- augment(m, d)
            check_omit(au_d, d)
        }
    })

    for(rnames in c(TRUE, FALSE)) {
        msg <- paste("augment works with", obj, "with na.exclude")
        if (!rnames) {
            msg <- paste(msg, "without rownames")
        }
        test_that(msg, {
            d <- if (rnames) { .dataNA } else { unrowname(.dataNA) }
            m <- func(d, na.action = "na.exclude")
            # without the data argument, it works like na.exclude
            expect_warning(au <- augment(m), "na.exclude")
            check_omit(au, d)
            # with the data argument, it keeps the NAs
            au_d <- augment(m, d)
            check_exclude(au_d, d)
        })
    }
}
