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


data <- "data/Online-data-for-chapter-2-whr-2016.xlsx"
happinessData <- read.xlsx(data, sheet = 3) %>% 
  rename(score = `Happiness.score`) %>% 
  select(Country, score)


dataCcode <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"
ccode <- read.csv(dataCcode) %>% 
  select(cname, ccodealp) %>% 
  rename(id = `ccodealp`,
         Country = `cname`)

happinessData <- happinessData %>% left_join(ccode, by = "Country")


happinessData$id[happinessData$Country == "Puerto Rico"] <- "PRI"
happinessData$id[happinessData$Country == "Ivory Coast"] <- "CIV"
happinessData$id[happinessData$Country == "France"] <- "FRA"
happinessData$id[happinessData$Country == "South Korea"] <- "KOR"
happinessData$id[happinessData$Country == "Cyprus"] <- "CYP"
happinessData$id[happinessData$Country == "Hong Kong"] <- "HKG"
happinessData$id[happinessData$Country == "Pakistan"] <- "PAK"
happinessData$id[happinessData$Country == "Palestinian Territories"] <- "PSE"
happinessData$id[happinessData$Country == "Ethiopia"] <- "ETH"
happinessData$id[happinessData$Country == "Congo (Kinshasa)"] <- "GOD"
happinessData$id[happinessData$Country == "Congo (Brazzaville)"] <- "COG"
happinessData$id[happinessData$Country == "Sudan"] <- "SDN"

dataMap <- "data/HiResWorldMapWithISO3.csv"
worldmap <- read.csv(dataMap)

worldmap_happiness <- full_join(worldmap, happinessData, by = "id")

happinessMap <- ggplot() +
  geom_polygon(data = worldmap_happiness,
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = score)) +
  scale_fill_gradient(low = "purple",
                      high = "yellow") +
  # scale_fill_gradient2(low = "blue",
  #                      high = "red",
  #                      mid = "black",
  #                      midpoint = 5.382185) + # mean(happinessData$score)
  labs(title = "The World's Happiest Countries of 2016",
       x = "",
       y = "",
       fill = "Happiness score") +
  coord_equal() +
  theme_gray() +
  theme(legend.position = "bottom")

happinessMap

ggsave("figure/Session11_figure1.pdf", width = 10, height = 7.5)

mean(happinessData$score)
