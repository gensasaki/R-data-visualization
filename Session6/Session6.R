## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 6
##
## Name: Gen Sasaki
## Data: July 10, 2016

rm(list = ls())

library(ggplot2, maps)


## Figure 1


df <- read.csv("6583.csv")

states <- map_data("state")
states

ggplot() +
  geom_polygon(data = states, 
               mapping = aes(x = long,
                             y = lat,
                             group = group),
               fill = "green",
               color= "white",
               alpha = I(0.7)) +
  geom_point(data = df,
             aes(x = longitude,
                 y = latitude,
                 size = Capacity),
             alpha = I(0.5)) +
  coord_map(projectio = "polyconic",
            xlim = c(-130, -65)) +
  ggtitle("NCAA Division I Football Stadiums, Locations and Capacities") +
  xlab("Longitude") +
  ylab("Latitude")

ggsave("Session6_figure1.pdf", width = 10, height = 7.5)


## Figure 2

rm(list = ls())

library(ggplot2, ggthemes)

df <- read.csv("thads2009Seattle.txt")
df

vars <- c("VALUE", "TOTSAL")

df.2 <- df[, vars]

df.2$VALUE2 <- df.2$VALUE / 1000 
df.2$TOTSAL2 <- df.2$TOTSAL / 1000

ggplot(data = df.2,
       aes(x = TOTSAL2,
           y = VALUE2)) +
  geom_point(alpha = I(0.5)) +
  geom_density2d() +
  coord_fixed(ratio = 1/4) +
  theme_economist() +
  scale_fill_economist() +
  ggtitle("American Housing Survey, Seattle 2009") +
  xlab("Total Wage Income (in 1,000 dollars)") +
  ylab("Current Market Value of Unit (in 1,000 dollars)")

ggsave("Session6_figure2.pdf", width = 10, height = 7.5)
