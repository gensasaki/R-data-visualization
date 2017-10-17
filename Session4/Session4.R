## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 4, 5 Data Visualization with ggplot2, Part 1
##
## Name: Gen Sasaki
## Data: July 7, 8, 2016

rm(list = ls())
library(ggplot2)

url <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"

df <- read.csv(url)
df

vars <- c("unna_gdppc", "fh_ipolity2", "lp_legor")
obs <- df$lp_legor <= 3 & !(is.na(df$lp_legor))
df.figure1 <- df[obs, vars]

df.figure1$lp_legor <- as.factor(df.figure1$lp_legor)
levels(df.figure1$lp_legor) <- c("English Common Law", 
                                 "French Commercial Code", 
                                 "Socialist/Communist Laws"
                                 )

df.figure1$ln_unna_gdppc <- log(df.figure1$unna_gdppc)

ggplot(data = df.figure1, 
       mapping = aes(ln_unna_gdppc, fh_ipolity2)) +
  geom_point(na.rm = TRUE, size = I(5), alpha = I(0.5)) +
  facet_wrap(~ lp_legor) +
  ggtitle("Figure 1") +
  ylab("Polity Score") +
  xlab("GDP Per Capita (in log)")



## 2. Figure 2

rm(list = ls())
library(ggplot2)

url <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"
df <- read.csv(url)
df

vars <- c("wdi_trade", "gd_ptsa")
df.figure2 <- df[, vars]
df.figure2$gd_ptsa <- as.factor(df.figure2$gd_ptsa)
View(df.figure2)

df.figure2$wdi_trade[df.figure2$wdi_trade > 300] <-  NA

ggplot(data = df.figure2,
       mapping = aes(x = gd_ptsa, y = wdi_trade)) + 
  geom_boxplot(na.rm = TRUE) + 
  ggtitle("Figure 2") +
  xlab("Political Terror Scale") +
  ylab("Trade (% of GDP)")

ggsave("Session4_figure2.pdf", width = 10, height = 7.5)


## Figure 3


rm(list = ls())
library(ggplot2)

url <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"
df <- read.csv(url)
df

vars = c("une_gdpc", "wdi_co2mtpc", "ross_oil_prod", "unna_pop")
df.figure3 <- df[, vars]

df.figure3$ln_une_gdpc <- log(df.figure3$une_gdpc)
df.figure3$ln_wdi_co2mtpc <- log(df.figure3$wdi_co2mtpc)
df.figure3$oil_pc <- df.figure3$ross_oil_prod / df.figure3$unna_pop

ggplot(data = df.figure3,
       mapping = aes(x = ln_une_gdpc, 
                     y = ln_wdi_co2mtpc)) +
  geom_point(na.rm = TRUE, 
             mapping = aes(color = oil_pc,
                           size = oil_pc)) +
  geom_smooth(method = lm, 
              na.rm = TRUE) +
  labs(title = "Real GDP per capita (in log)",
       x = "Real GDP per capita (in log)",
       y = "CO2 emissions (metric tons per capita, in log)",
       color = "Oil Production per capita",
       size = "Oil Production per capita")
ggsave("Session4_figure3.pdf", width = 10, height = 7.5)


## Figure 4


rm(list = ls())
library(ggplot2)

url <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"
df <- read.csv(url)
df

vars = c("dpi_system", "fh_status")
df.figure4 <- df[vars]

df.figure4$dpi_system[is.na(df.figure4$dpi_system)] <- 3
df.figure4$system <- as.factor(df.figure4$dpi_system)
df.figure4$free <- as.factor(df.figure4$fh_status)
levels(df.figure4$system) <- c("Presidential", "Assembly-elected President",
                               "Parliamentary", "NA")
levels(df.figure4$free) <- c("Free", "Partly Free", "Not Free")

ggplot(data = df.figure4,
       aes(x = free,
           fill = system)) +
  geom_bar(na.rm = TRUE,
           position = "stack") +
  ggtitle("Figure 4") +
  xlab("Political Rights and Civil Liberties") +
  labs(fill = "Political System")

ggsave("Session4_figure4.pdf", width = 10, height = 7.5)