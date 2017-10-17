## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Factors in R
##
## Name: Gen Sasaki
## Data: July 7th, 2016

rm(list = ls())


y <- c(rep(1, 3), rep(2, 4), rep(4, 2), rep(7, 1))
x <- c(rep("C", 1), rep("B", 2), rep("D", 3), rep("A", 4))
df <- data.frame(y, x)
df

str(df)

table(df$x) # Count the number of observations for each category.

levels(df$x) # Check the category names.

install.packages("gdata")
library(gdata)
mapLevels(df$x)

library(ggplot2)
ggplot(data = df,
       aes(x = x)) +
  geom_bar()

df$x2 <- factor(df$x, levels = c("B", "C", "D", "A"))
ggplot(data = df,
       aes(x = x2)) +
  geom_bar()

mapLevels(df$x2)

levels(df$x2) <- c("BB", "CC", "DD", "AA")
ggplot(data = df,
       aes(x = x2)) +
  geom_bar()

levels(df$x) <- c("AA", "BB", "CC", "DD")
ggplot(data = df,
       aes(x = x)) +
  geom_bar()

df$y2 <- factor(df$y)
table(df$y2)
ggplot(data = df,
       aes(x = y2)) +
  geom_bar()

df$y2 <- as.factor(df$y)
table(df$y2)
ggplot(data = df,
       aes(x = df$y2)) +
  geom_bar()
mapLevels(df$y2)

levels(df$y2) <- c("JP", "US", "UK", "AU")
ggplot(data = df,
       aes(x = y2)) +
  geom_bar()

df$y3 <- factor(df$y, levels = c(1, 2, 4, 7),
                labels = c("JP", "US", "UK", "AU"))
df$y4 <- factor(df$y, labels = c("JP", "US", "UK", "AU"))
