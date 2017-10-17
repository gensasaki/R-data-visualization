## Keio University, Spring 2016
## Interactive Data Visualizations
## Session 12, Sample Code (GoogleVis)
## 
## Name: Yusaku Horiuchi
## Date: July 19, 2016

## Ref: http://github.com/mages/googleVis.
## Ref: http://mages.github.io/googleVis_Tokyo_April_2014

## Hans Rosling's 200 Countries, 200 Years, 4 Minutes - The Joy of Stats - BBC Four
## https://youtu.be/jbkSRLYSojo

## Initial Settings

rm(list = ls())
library(dplyr)
library(tidyr)
library(googleVis)

## Demonstrations

demo(package = 'googleVis')
# demo(googleVis)
demo(AnimatedGeoChart)
demo(WorldBank)

## Example 1

options(stringsAsFactors = FALSE)
ivy <- read.csv("data/ranking.csv", header = TRUE) %>% 
  gather("year", "n", 2:12) %>% 
  mutate(year = as.numeric(gsub("X","",year))) %>%
  mutate(ranking = -n) %>% 
  gvisMotionChart(idvar = "uni",
                  timevar = "year",
                  options=list(width=600, 
                               height=400)) %>% 
  plot()

## Example 2

dining <- read.csv("data/dining.csv", skip = 1) %>% 
  mutate(Address = paste(lat, lon, sep=":")) %>% 
  mutate(Tip = paste("<b>", Name, "</b><br>", Description)) %>% 
  gvisMap(locationvar = "Address", 
          tipvar = "Tip",
          options = list(width = 600,
                         height = 600,
                         zoomLevel = 16)) %>% 
  plot()

