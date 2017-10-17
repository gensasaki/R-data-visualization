## Keio University, Spring 2016
## Interactive Data Visualizations
## Session 12, Sample Code (gganimate)
## 
## Name: Yusaku Horiuchi
## Date: July 19, 2016

## Ref: https://github.com/dgrtwo/gganimate

## Installation

# install.packages("devtools")
# devtools::install_github("dgrtwo/gganimate")

## Initial Settings

rm(list = ls())
library(gapminder)
library(ggplot2)
library(gganimate)

p <- ggplot(gapminder, 
            aes(x = gdpPercap, 
                y = lifeExp, 
                size = pop, 
                color = continent, 
                frame = year)) +
  geom_point() +
  scale_x_log10()

gg_animate(p)
