## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 10
##
## Name: Gen Sasaki
## Data: July 15, 2016

rm(list = ls())
options(stringsAsFactors = FALSE)

library(dplyr)
library(tidyr)
library(ggplot2)
library(openxlsx)
library(gridExtra)
library(broom)

diamonds
df <- diamonds %>% 
  sample_n(1000) %>% 
  mutate(cut = as.numeric(cut))


model1 <- lm(price ~ carat, data = df)
model2 <- lm(price ~ carat + factor(cut), data = df)

summary(model1)
summary(model2)

out1 <- tidy(model1) %>% 
  mutate(model = "Model 1") %>% 
  mutate(vars = c("Intercept", "Carat"))

out1

out2 <- tidy(model2) %>% 
  mutate(model = "Model 2") %>% 
  mutate(vars = c("Intercept", "Carat",
                  "Cut = Good",
                  "Cut = Very Good",
                  "Cut = Premium",
                  "Cut = Ideal"))

out <- rbind(out1, out2)

out$vars <- ordered(out$vars,
                    levels = c("Intercept",
                               "Carat",
                               "Cut = Good",
                               "Cut = Very Good",
                               "Cut = Premium",
                               "Cut = Ideal"))

ggplot(data = out,
       aes(x = estimate, y = vars)) +
  geom_point() +
  geom_errorbarh(aes(xmin = (estimate - 1.96 * std.error),
                     xmax = (estimate + 1.96 * std.error),
                     height = 0)) +
  geom_vline(xintercept = 0, linetype = 8) +
  facet_grid(. ~ model) +
  labs(title = "Regression Coeffeicient Plots",
       x = "Estimated Effects on Price (in dollars)",
       y = "")
