## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 10
##
## Name: Gen Sasaki
## Data: July 15, 2016

rm(list = ls())
options(stringsAsFactors = FALSE)

library(ggplot2)
library(dplyr)
library(tidyr)
library(gridExtra)
library(broom)

df <- read.csv("Leading_Causes_of_Death__1990-2010.csv") %>% 
  rename(year = `YEAR`, group = `AGE.GROUP`, 
       cause = `LEADING.CAUSES.OF.DEATH`, n = `FATALITIES`) %>% 
  mutate(cause = ifelse(cause == "International self-harm (suicide)", "Suicide", cause),
         cause = ifelse(cause == "All causes", "All Causes", cause),
         cause = ifelse(cause == "All causes ", "All Causes", cause))

table(df$cause)

for (i in min(df$year):max(df$year)) {
  df %>% filter(year == i, 
                group == "All Ages",
                causes != "All Causes") %>% 
    arrange(desc(n)) %>% 
    top_n(3) %>% 
    print()
}

test <- df %>% 
  filter(cause == "Suicide") %>% 
  arrange(group, year) %>% 
  group_by(group) %>% 
  mutate(n.lag = lag(year),
         year.lag = lag(year)) %>% 
  filter(!is.na(year.lag))

View(test)

test2 <- test[FALSE,]

for (i in 1:length(test)) {
  if (test$n[i] < test$n.lag[i] & test$year[i] == test$year.lag[i] + 1) {
    temp <- test[i,]
    test2 <- rbind(test2, temp)
  }
}

top3death <- function(arg1, arg2 = "All Ages") {
  df %>% 
    filter(year == arg1,
           cause != "All Causes",
           group == arg2) %>% 
    arrange(desc(n)) %>% 
    top_n(3) %>% 
    return()
}

top3death(2010)
top3death(2009, "Ages 15-24")

df.regress <- df %>% 
  filter(group == "Ages 15-24" |
           group == "Ages 25-44" |
           group == "Ages 45-64") %>% 
  filter(cause == )