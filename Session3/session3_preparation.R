x <- c(0, 0, 0, 0, 1, 0, 0)
y <- x
y
vec <- c(6, 1, 3, 6, 10, 5)
df <- data.frame(
  name = c("John", "Paul", "George", "Ringo"), 
  birth = c(1940, 1942, 1943, 1940), 
  instrument = c("guitar", "bass", "guitar", "drums")
  )
vec[2]
vec[c(5, 6)]
vec[-c(5, 6)]
vec[vec > 5]
df[c(2, 4), 3]
df[ , 1]
df[ , "instrument"]
df$instrument
1:4
df[1:4, 1:2]
df[c(1, 1, 1, 2, 2), 1:3]
vec[0]
df[1:2, 0]
df[0, 0]
matrix(1:9)
mat <- matrix(1:9, nrow = 3)
mat[2]
vec
names(vec) <- c("a", "b", "c", "d", "e", "f")
vec
vec["a"]
df
df[ , "birth"]
vec[c(FALSE, TRUE, FALSE, TRUE, TRUE, FALSE)]
lst <-list(c(1, 2), TRUE, c("a", "b", "c"))
sum(c(1, 2, 3))
lst[c(1, 2)]
lst[1]
lst[[1]]
lst[[1]][2]
las[1][2] # Error!
names(lst) <- c("alpha", "beta", "gamma")
lst
lst$alpha
lst$beta
df$birth
df
df$instrument
install.packages("name") # Error! not available (for R version 3.3.0)
library(c(ggplot2, maps, RColorBrewer)) # Error!
library(ggplot2)
library(maps)
library(RColorBrewer)
diamonds[1:6, ]
nrow(diamonds) # 53940 rows
head(diamonds)
tail(diamonds)
View(diamonds)
?diamonds
qplot(x, y, data = diamonds)
1 < 3
1 > 3
c(1, 2, 3, 4, 5) > 3
1 %in% c(1, 2, 3, 4)
1 %in% c(2, 3, 4)
c(3, 4, 5, 6) %in% c(2, 3, 4)
x > 2 & x < 9

w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")
w > 0
x > 10 & x < 20
y == "February"
all(z %in% c("Sunday", "Monday", "Tuesday", 
         "Wednesday", "Thursday", "Friday", 
         "Saturday", "Sunday"))
x_zeroes <- diamonds$x == 0
diamonds[x_zeroes, ]
diamonds[diamonds$x > 10, ]
big <- diamonds[diamonds$x > 10, ]
a <- c(1, NA)
a == NA # NA
is.na(a)
b <- c(1, 2, 3, 4, NA)
sum(b) # NA
sum(b, na.rm == TRUE)
summary(diamonds$x)
diamonds$x[diamonds$x == 0]
diamonds$x[diamonds$x == 0] <- NA
summary(diamonds$x)
summary(diamonds$y)
diamonds$y[diamonds$y == 0] <- NA
y_big <- diamonds$y > 20
diamonds$y[y_big] <- NA
summary(diamonds$y)
