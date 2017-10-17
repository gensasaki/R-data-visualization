## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## R Language, Part 2
## Session 3, Key
## 
## Name: Gen Sasaki
## Date: July5, 2016

## Initial Setting

rm(list = ls())


## 1. Load a package and read data

library(ggplot2)

url <- "http://www.qogdata.pol.gu.se/data/qog_bas_cs_jan16.csv"
df <- read.csv(url, stringsAsFactors = FALSE)


## 2. Basics: Indexing and subsetting

df.1a <- df[1]
class(df.1a) # data.frame

df.1b <- df[-c(1, 3, 5)]
class(df.1b)

df.1c <- df[5:20, ]
dim(df.1c)

df.1d <- df[c(1, 3), c(4, 5)]
dim(df.1d)

rm(df.1a, df.1b, df.1c, df.1d)


## 3. Select specific veriables

vars <- c("cname", "lp_legor", "fh_ipolity2")

df.selected <- df[vars] # ?????

nrow(df.selected)
ncol(df.selected)
head(df.selected)
View(df.selected)


## 4. Select specific observations

english <- df.selected$lp_legor == 1
df.english <- df.selected[english, ]

df.japan <- df.selected[df.selected$cname == "Japan", ]

summary(df.english$fh_ipolity2)

df.japan$fh_ipolity2 == 10


## 5. Make a group of objects

my_list <- list("This is just a test.", 
                c("Australia", "New Zealand", "Fiji"), 
                df.english)

names(my_list) <- c("title", "country", "data")

my_list[[2]] 
my_list[["country"]]
my_list$country
my_list$"country"
my_list[2] # Uncorrect. This is a list.

my_list[[2]][3]
my_list[["country"]][3]
my_list$country[3]
my_list$"country"[3]


## 6. Missing values

df.selected2 <- df.selected
df.selected2$fh_ipolity2[df.selected2$cname == "Japan"] <- NA
df.selected2[df.selected$cname == "Japan", c("cname", "fh_ipolity2")]
df.selected2$cname[!is.na(df.selected2$fh_ipolity2)]
      