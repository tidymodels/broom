# test tidy, glance, and augment methods from loo_tidiers.R

context("loo tidiers")
suppressPackageStartupMessages(library(rstan))
suppressPackageStartupMessages(library(loo))

if (require(rstan, quietly = TRUE) && require(loo, quietly = TRUE)) {
    set.seed(2016)
    capture.output(
        url <- "http://stat.columbia.edu/~gelman/arm/examples/arsenic/wells.dat",
        wells <- read.table(url),
        wells$dist100 <- with(wells, dist / 100),
        X <- model.matrix(~ dist100 + arsenic, wells),
        standata <- list(y = wells$switch, X = X, N = nrow(X), P = ncol(X)),
        
        logistic.stan <- "
        data {
            int<lower=0> N;
            int<lower=0> P;
            matrix[N,P] X;
            int<lower=0,upper=1> y[N];
        }
        parameters {
            vector[P] beta;
        }
        model {
            beta ~ normal(0, 1);
            y ~ bernoulli_logit(X * beta);
        }
        generated quantities {
            vector[N] log_lik;
            for (n in 1:N) {
                log_lik[n] = bernoulli_logit_lpmf(y[n] | X[n] * beta);
            }
        }
        ",
        
        fit_1 <- stan(model_code = logistic.stan, data = standata),
        
        log_lik_1 <- extract_log_lik(fit_1),
        loo_1 <- loo(log_lik_1),
        waic_1 <- waic(log_lik_1)
    )
    
    context("loo objects")
    test_that("tidy works on loo objects", {
        td1 <- tidy(loo_1)
        td2 <- tidy(waic_1)
        expect_equal(
            colnames(td1),
            colnames(td2),
            c("parameter", "estimate", "std.error"))
    })
    
    test_that("glance works on loo objects", {
        g1 <- glance(loo_1)
        g2 <- glance(waic_1)
        expect_equal(colnames(g1), c("elpd_loo", "p_loo", "looic",
            "se_elpd_loo", "se_p_loo", "se_looic", "n", "n_sims"))
        expect_equal(colnames(g2), c("elpd_waic", "p_waic", "waic",
            "se_elpd_waic", "se_p_waic", "se_waic", "n", 'n_sims'))
    })
    
    test_that("augment works on loo objects", {
        a1 <- augment(loo_1)
        a2 <- augment(loo_1, data = wells)
        a3 <- augment(waic_1)
        expect_equal(nrow(wells), nrow(a1), nrow(a2), nrow(a3))
        expect_equal(colnames(a1), c(".elpd_loo", ".p_loo", ".looic",
            ".pareto_k"))
        expect_equal(colnames(a2), c(colnames(wells), colnames(a1)))
        expect_equal(colnames(a3), c(".elpd_waic", ".p_waic", ".waic"))
    })
}
