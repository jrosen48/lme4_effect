
<!-- README.md is generated from README.Rmd. Please edit that file -->
lmereffect
==========

The goal of lmereffect is to calculate Cohen's d for a dichotomous variable in a model fitted with `lme4::lmer()`

Installation
------------

You can install lmereffect from github with:

``` r
# install.packages("devtools")
devtools::install_github("jrosen48/lme4_effect")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
#' library(lme4)
#' sleepstudy$dichotomous_var <- rbinom(nrow(sleepstudy), 1, .5)
#' fm1 <- lmer(Reaction ~ Days + dichotomous_var + (1 | Subject), sleepstudy)
#' lmer_effect(df = sleepstudy, Reaction, fm1, dichotomous_var)
```
