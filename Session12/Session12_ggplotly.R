## Keio University, Spring 2016
## Interactive Data Visualizations
## Session 12, Sample Code (ggplotly)
## 
## Name: Yusaku Horiuchi
## Date: July 19, 2016

## Ref: https://plot.ly/r/

## Initial Settings

rm(list = ls())
library(ggplot2)
library(plotly)

set.seed(100)
d <- diamonds[sample(nrow(diamonds), 1000), ] # randomly sample 1,000 observations

p <- ggplot(data = d, 
            aes(x = carat, 
                y = price)) +
  geom_point(aes(text = paste("Clarity:", clarity)), 
             size = 1) +
  geom_smooth(aes(colour = cut, 
                  fill = cut)) + 
  facet_wrap(~ cut)

ggplotly(p)
