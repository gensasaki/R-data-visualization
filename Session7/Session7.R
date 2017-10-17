## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 7
##
## Name: Gen Sasaki
## Data: July 12, 2016


rm(list = ls())

library(ggplot2)
library(dplyr)
library(ggmap)

school <- c("Brown University", "Cornell University",
            "Columbia University", "Dartmouth University",
            "Harvard University", "Princeton University",
            "University of Pennsylvania", "Yale University")

map <- map_data("state") %>%
  filter(region %in% c("connecticut", "massachusetts", "new hampshire", "vermont",
                       "new jersey", "new york", "pennsylvania", "rhode island"))

ivy <- geocode(school, source = "dsk")
ivy$school <- school

ggplot() +
  geom_polygon(data = map,
               aes(x = long, y = lat, group = group),
               color = "gray90",
               fill = "white") +
  geom_point(data = ivy,
             aes(x = lon, y = lat)) +
  geom_text(data = ivy,
            aes(x = lon, y = lat + 0.15, label = school)) +
  labs(title = "Locations of Ivy League Institutions",
       x = "Longitute",
       y = "Latitude") +
  coord_map()

ggsave("Session7.pdf", scale = 1, width = 9, height = 6)
