## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 11
##
## Name: Gen Sasaki
## Data: July 18, 2016


rm(list = ls())
options(stringsAsFactors = FALSE)


library(dplyr)
library(tidyr)
library(ggplot2)
library(openxlsx)
library(gridExtra)
library(ggmap)
library(maptools)
library(gpclib)
library(plotly)


data <- "data/Online-data-for-chapter-2-whr-2016.xlsx"
happinessData <- read.xlsx(data, sheet = 3) %>% 
  rename(score = `Happiness.score`) %>% 
  select(Country, score)

top20 <- happinessData %>% 
  top_n(20)

bottom20 <- happinessData %>% 
  arrange(score)
bottom20 <- bottom20[1:20,]

dataCcode <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"
ccode <- read.csv(dataCcode) %>% 
  select(cname, ccodealp) %>% 
  rename(id = `ccodealp`,
         Country = `cname`)

top20 <- top20 %>% left_join(ccode, by = "Country")
bottom20 <- bottom20 %>% left_join(ccode, by = "Country")

top20$id[top20$Country == "Puerto Rico"] <- "PRI"
bottom20$id[bottom20$Country == "Ivory Coast"] <- "CIV"

dataMap <- "data/HiResWorldMapWithISO3.csv"
worldmap <- read.csv(dataMap)

worldmap_top20 <- full_join(worldmap, top20, by = "id")
worldmap_bottom20 <- full_join(worldmap, bottom20, by = "id")

others <- worldmap_top20 %>% 
  filter(is.na(Country))

worldmap_top20 <- worldmap_top20 %>% 
  filter(!is.na(Country))

worldmap_bottom20 <- worldmap_bottom20 %>% 
  filter(!is.na(Country))

happinessMap <- ggplot() +
  geom_polygon(data = others,
               aes(x = long,
                   y = lat,
                   group = group),
               fill = "grey") +
  geom_polygon(data = worldmap_top20,
               aes(text = paste("Country:", Country),
                   x = long, 
                   y = lat, 
                   group = group,
                   fill = score),
               color = "white") +
  geom_polygon(data = worldmap_bottom20,
               aes(text = paste("Country:", Country),
                   x = long,
                   y = lat,
                   group = group,
                   fill = score),
               color = "white") +
  scale_fill_gradient2(low = "blue",
                      high = "red",
                      mid = "light green",
                      midpoint = 5.382185) + # mean(happinessData$score)
  labs(title = "The Top 10% and the Bottom 10% Happiest Countries of 2016",
       x = "",
       y = "",
       fill = "Happiness score") +
  coord_equal() +
  theme_gray() +
  theme(legend.position = "bottom")

happinessMap

ggplotly(happinessMap)

ggsave("figure/Session11_figure1.pdf", width = 10, height = 7.5)
