## Keio University, Spring 2016
## Interactive Data Visualizations
## Session 12, Sample Code (leaflet)
## 
## Name: Yusaku Horiuchi
## Date: July 19, 2016
## Leaflet
## Ref 1: http://datascienceplus.com/building-interactive-maps-with-leaflet/
## Ref 2: https://rstudio.github.io/leaflet/

## Initial Settings

rm(list = ls())
library(leaflet)
library(dplyr)

## Demonstration

SFmap <- leaflet() %>% 
  addTiles() %>% 
  setView(-122.42, 37.78, zoom = 13) %>% 
  addMarkers(-122.42, 37.78, popup = 'Bay Area')
SFmap

SFdata <- read.csv("data/SFPD_Incidents_-_Current_Year__2015_.csv") %>% 
  filter(Category == "BRIBERY" | Category == "SUICIDE")

SFMap <- leaflet() %>%
  addTiles() %>% 
  setView(-122.42, 37.78, zoom = 13) %>% 
  addMarkers(data = SFdata, lng = ~ X, lat = ~ Y, popup = SFdata$Category)
SFMap

SFMap2 <- leaflet() %>%
  addTiles() %>% 
  setView(-122.42, 37.78, zoom = 13) %>% 
  addCircleMarkers(data = SFdata, lng = ~ X, lat = ~ Y, radius = 5, 
                   color = ~ ifelse(Category == 'BRIBERY', 'red', 'blue'),
                   clusterOptions = markerClusterOptions())
SFMap2

## Example

options(stringsAsFactors = FALSE)

df <- read.csv("data/dining.csv", skip = 1)

leaflet() %>% 
  addTiles() %>% 
  addProviderTiles("CartoDB.Positron") %>% 
  setView(lng = -72.287449, lat = 43.705239, zoom = 16) %>% 
  addMarkers(data = df, 
             lng = df$lon, 
             lat = df$lat, 
             popup = paste("<b>", 
                           df$Name, 
                           "</b><br>", 
                           df$Description))
