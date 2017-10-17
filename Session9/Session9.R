## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 9
##
## Name: Gen Sasaki
## Data: July 14, 2016

rm(list = ls())
options(stringsAsFactors = FALSE)

library(dplyr)
library(tidyr)
library(ggplot2)
library(openxlsx)
library(gridExtra)

## Analysis 1

data1 <- "data/Total_Economic_and_Military_Assistance_1946-2014.xlsx"

Greenbook <- read.xlsx(data1, sheet = 2, startRow = 7) %>%
  rename(Year = `Fiscal.Year`,
         Category = `Assistance.Category`,
         Dollar = `Obligations.(Historical.Dollars)`) %>% 
  select(Year, Region, Category, Country, Dollar) %>% 
  filter(!grepl("(not specified)", Country))

analysis1 <- Greenbook %>% 
  filter(Region == "Asia" | 
           Region == "Latin America and Caribbean" |
           Region == "Middle East and North Africa" |
           Region == "Sub-Saharan Africa") %>% 
  group_by(Year, Region, Category) %>% 
  summarise(Total = sum(Dollar)) %>%
  mutate(Total = Total / 1000000000)



ggplot(analysis1) + 
  geom_line(aes(x = Year,
                y = Total,
                color = Category)) +
  facet_grid(. ~ Region) +
  labs(title = "U.S. Foreign Assistance By Region and Category",
       x = "Year",
       y = "Total Amount (in Billions)")

# ?grepl

## Hoe to use grep and grepl
# test <- c("A", "B (not specified)", "C", "D (not specified)")
# grep("not specified", test)
# grepl("not specified", test)
# !grep("not specified", test)

View(Greenbook)



## Analysis 2

Greenbook.Post2001 <- Greenbook %>% 
  filter(Year >= 2001) %>% 
  group_by(Country, Category) %>% 
  summarise(Amount = sum(Dollar)) %>% 
  mutate(Amount = Amount / 1000000000) %>% 
  spread(Category, Amount, fill = 0) %>% 
  mutate(Ratio = 100 * (Military / (Military + Economic))) %>% 
  arrange(desc(Ratio)) %>% 
  ungroup()

tbl_df(Greenbook.Post2001)





## Analysis 3

library(maptools)
library(gpclib)

data2 <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"

ccode <- read.csv(data2) %>% 
  select(cname, ccodealp) %>% 
  rename(id = ccodealp,
         Country = cname)

top20e <- Greenbook.Post2001 %>% 
  top_n(20, Economic) %>% 
  select(Country, Economic)

top20m <- Greenbook.Post2001 %>% 
  top_n(20, Military) %>% 
  select(Country, Military)


# Check unmerged cases
# test_m <- full_join(top20m, ccode, by = "Country")
# test_e <- full_join(top20e, ccode, by = "Country")

top20e$Country[(top20e$Country == "Pakistan")] <- "Pakistan (1971-)"
# The following command does the same thing. 
top20e$Country <- ifelse((top20e$Country == "Pakistan"), "Pakistan (1971-)", top20e$Country)

top20e$Country[(top20e$Country == "Congo (Kinshasa)")] <- "Congo, Democratic Republic"
top20e$Country[(top20e$Country == "Ethiopia")] <- "Ethiopia (1993-)"
# The following merge is strictly speaking not correct. 
top20e$Country[(top20e$Country == "Sudan")] <- "Sudan (2012-)" 

top20m$Country[(top20m$Country == "Pakistan")] <- "Pakistan (1971-)"
# The following merge is strictly speaking not correct. 
top20e$Country[(top20e$Country == "Sudan")] <- "Sudan (2012-)" 

top20eID <- full_join(top20e, ccode, by = "Country")
top20mID <- full_join(top20m, ccode, by = "Country")

data3 <- "data/HiResWorldMapWithISO3.csv"

worldmap <- read.csv(data3)

worldmap_top20e <- full_join(worldmap, top20eID, by = "id")
worldmap_top20m <- full_join(worldmap, top20mID, by = "id")

plot20m <- ggplot() +
  geom_polygon(data = worldmap_top20m,
               aes(x = long, 
                   y = lat, 
                   group = group,
                   fill = Military),
               color = "grey80") +
  labs(title = "Top 20 Recipients of U.S. Military Aid",
       x = "",
       y = "",
       fill = "$ Billion") +
  scale_fill_gradient(limits = c(0, 50),
                      low = "light blue",
                      high = "blue",
                      na.value = "grey90") +
  coord_equal() +
  theme_minimal()
  
plot20e <- ggplot() +
  geom_polygon(data = worldmap_top20e,
               aes(x = long,
                   y = lat,
                   group = group,
                   fill = Economic),
               color = "grey80") +
  labs(title = "Top 20 Recipients of U.S. Economic Aid",
       x = "",
       y = "",
       fill = "$ Billion") +
  scale_fill_gradient(limits = c(0, 50),
                      low = "pink",
                      high = "red",
                      na.value = "grey90") +
  coord_equal() +
  theme_minimal()

grid.arrange(plot20e, plot20m)

g <- arrangeGrob(plot20e, plot20m)
ggsave(filename = "data/Session9_figure2.pdf",
       plot = g,　width = 10, height = 7.5)
