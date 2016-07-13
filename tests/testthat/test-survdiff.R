
if( require("survival", quietly = TRUE)) {
    
    # Examples from survival::survdiff help page
    ex1 <- survdiff(Surv(futime, fustat) ~ rx,data=ovarian)
    ex2 <- survdiff(Surv(time, status) ~ pat.karno + strata(inst), data=lung)
    # More factors and strata
    ex2a <- survdiff(Surv(time, status) ~ pat.karno + ph.ecog + 
                         strata(inst) + strata(sex), data=lung)
    expect <- survexp(futime ~ ratetable(
        age=(accept.dt - birth.dt),
        sex=1,
        year=accept.dt,
        race="white"
    ), 
    jasa, cohort=FALSE, ratetable=survexp.usr)
    ex3 <- survdiff(Surv(jasa$futime, jasa$fustat) ~ offset(expect))
    ex4 <- survdiff( Surv(futime, fustat) ~ rx + ecog.ps, data=ovarian)
    rm(expect)
    
    
    
    
    context("Testing tidy() of 'survdiff' objects")
    
    tidy_names <- c("N", "obs", "exp")
    
    test_that("tidy works in 2-group case", {
        td <- tidy(ex1)
        check_tidy(td, exp.names=tidy_names)
    })
    
    test_that("tidy works in 7-group stratified case", {
        td <- tidy(ex2)
        check_tidy(td, exp.names = tidy_names)
    })

    test_that("tidy works for ex2a", {
        td <- tidy(ex2a)
        check_tidy(td, exp.names=tidy_names)
    })
    
        
    test_that("tidy works for ex3", {
        td <- tidy(ex3)
        check_tidy(td, exp.names=tidy_names)
    })
    
    test_that("tidy works for ex4", {
        td <- tidy(ex4)
        check_tidy(td, exp.names=tidy_names)
    })
    
    
    
    
    context("Testing glance() for 'survdiff' objects")
    
    glance_names <- c("statistic", "df", "p.value")
    
    test_that("glance works in 2-group case", {
        gl <- glance(ex1)
        check_tidy(gl, exp.names = glance_names)
    })

    test_that("glance works in 7-group stratified case", {
        gl <- glance(ex2)
        check_tidy(gl, exp.names = glance_names)
    })

    test_that("glance works for ex2a", {
        gl <- glance(ex2a)
        check_tidy(gl, exp.names = glance_names)
    })
    
        
    test_that("glance works in ex3", {
        gl <- glance(ex3)
        check_tidy(gl, exp.names = glance_names)
    })
    
    test_that("glance works in ex4", {
        gl <- glance(ex4)
        check_tidy(gl, exp.names = glance_names)
    })
    
}
