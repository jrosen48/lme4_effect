#' Calculate Cohen's d for a dichotomous variable in a model created with lme4::lmer()
#' @details Calculate Cohen's d for a dichotomous variable in a model created with lme4::lmer()
#' @param df data frame used in model
#' @param dv dependent variable
#' @param lmer_model_object model fitted lme4::lmer() model
#' @param var_name name of dichotomous variable
#' @return prints the Cohen's d for the dichotomous variable
#' @examples
#' library(lme4)
#' sleepstudy$dichotomous_var <- rbinom(nrow(sleepstudy), 1, .5)
#' fm1 <- lmer(Reaction ~ Days + dichotomous_var + (1 | Subject), sleepstudy)
#' lmer_effect(df = sleepstudy, Reaction, fm1, dichotomous_var)

#' @export 

lmer_effect <- function(df, dv, lmer_model_object, var_name) {
    
    quo_var_name <- enquo(var_name) 
    quo_var_string <- quo_name(quo_var_name)
    
    quo_dv_name <- enquo(dv) 
    quo_dv_string <- quo_name(quo_dv_name)
    
    sd_n_d <- df %>%
        group_by(!!quo_var_name) %>%
        summarize(sd = sd(!!quo_dv_name, na.rm = T),
                  n = n())
    
    the_mean <- tidy(lmer_model_object) %>% 
        filter(term == quo_var_string) %>% 
        pull(estimate)
    
    sd_group1 <- sd_n_d %>% filter(UQ(quo_var_name) == 0) %>% pull(sd)
    sd_group2 <- sd_n_d %>% filter(UQ(quo_var_name) == 1) %>% pull(sd)
    n_group1 <- sd_n_d %>% filter(UQ(quo_var_name) == 0) %>% pull(n)
    n_group2 <-  sd_n_d %>% filter(UQ(quo_var_name) == 1) %>% pull(n)
    
    pooled_sd <- calculate_pooled_sd(sd_group1 = sd_group1, n_group1 = n_group1, sd_group2 = sd_group1, n_group2 = n_group2)
    message("Cohen's d for the selected variable is: ", round(the_mean / pooled_sd, 3))
    
}