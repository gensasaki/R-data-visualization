## Keio University, Spring 2016
## Interactive Data Visualizations
## Session 12, Sample Code (ggvis)
## 
## Name: Yusaku Horiuchi
## Date: July 19, 2016

## Ref: http://ggvis.rstudio.com/

## Initial Settings

rm(list = ls())
library(dplyr)
library(tidyr)
library(ggvis)

## Demonstration

df <- mtcars

g1 <- df %>%
  ggvis() %>% 
  layer_histograms(x = ~mpg,
                    width = input_slider(min = 1, 
                                        max = 5, 
                                        step = 1, 
                                        label = "Bin Width")) %>%
  add_axis("x", title = "Miles/(US) gallon") %>% 
  add_axis("y", title = "Count")
g1 

## Example

options(stringsAsFactors = FALSE)
ivy <- read.csv("data/ranking.csv", header = TRUE)

ivy2 <- ivy %>% 
  select(-uni) %>% 
  as.matrix() %>% 
  t() %>% 
  as.data.frame()

names(ivy2) <- ivy[,1]
rownames(ivy2) <- NULL

ivy2$year <- 2006:2016

ivy2

ivys <- c("Princeton",
             "Harvard",
             "Yale",
             "Penn",
             "Brown",
             "Cornell",
             "Dartmouth",
             "Columbia")

select <- input_select(choices = ivys,
                       label = "Select:",
                       selected = "Dartmouth",
                       map = as.name)

g3 <- ivy2 %>%
  ggvis(y = select,
        x = ~factor(year),
        size := 500) %>% 
  layer_points() %>% 
  # scale_numeric("y", reverse = TRUE, nice = FALSE, expand = 0, domain = c(1, 16)) %>% 
  scale_numeric("y", reverse = TRUE, domain = c(1, 16)) %>% 
  add_axis("y", title = "US News Ranking", values = seq(1, 16, by = 1)) %>% 
  add_axis("x", title = "Year")
g3
  