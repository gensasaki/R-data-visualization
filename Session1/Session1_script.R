## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Demonstration
##
## Name: Gen Sasaki
## Data: July 1, 2016

## INITIAL SETTING

rm(list = ls())
# setwd("~/Desktop/Session1")
# install.packages(c("ggplot2", "dplyr", "ggmap"))
library(ggplot2)
library(dplyr)
library(ggmap)

## MAKE A BASE MAP

center <- geocode("Imperial Palace of Japan", source = "google")
center_lat <- center[1] %>% as.numeric()
center_lon <- center[2] %>% as.numeric()

base_map <- get_map(location = c(center_lat, center_lon), 
                    zoom = 13, 
                    # maptype = "roadmap", 
                    # maptype = "hybrid", 
                    maptype = "satellite",
                    source = "google", 
                    color = "bw")

## MAKE POINTS TO BE ADDED

name <- data.frame(name = c("Keio University", "Waseda University"))
location <- geocode(c("2-15-45 Mita, Minato-ku, Tokyo", 
                      "1-6-1 NishiWaseda, Shinjuku-ku, Tokyo"))
uni <- bind_cols(name, location) # Merge two data frames

## SHOW A MAP

ggmap(base_map) + 
  geom_point(data = uni, 
             aes(x = lon, y = lat), 
             color = "yellow", 
             size = 5) + 
  geom_text(data = uni, 
            aes(x = lon, y = lat + 0.003, label = name), 
            color = "yellow") + 
  labs(title = "Locations of Keio University and Waseda University", 
       x = "Longitude", 
       y = "Latitude")

## SAVE THE MAP

ggsave("figure/keiowaseda.pdf", scale = 1, width = 9, height = 9)

