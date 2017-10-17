## lecture 2 The R Language 1
##
##
round(3.1415)
factorial(3) # 3!
sqrt(9)
factorial(round(2.0015) + 1)

## vectors
## multiple elements stored in a one dimenonal array
vec <- c(1, 2, 3, 4, 5, 6)
vec
vec + 1
vec
vec * vec # = vec ^ 2
rm(vec) # rm() is ”command to remove object"

## matrices
mat <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 3) # number of rows for matrix
mat

## MATRIX MULTIPLICATION
vec %*% vec # inner
vec %o% vec # outer
mat
t(mat) # traverse

WorldPhones # sample data

## arrays
array(c(1, 2, 3, 4, 5, 6), dim = c(2, 2, 3))

## data types
class(100) # numeric
class("Hello") # character
nchar("Hello") # 5
paste("hello", "world") # "hello world"
3 < 4 # TRUE
class(TRUE) # logical
class(T) # logical
fac <- factor(c("a", "b", "c"))
fac # a b c # Levels: a b c
fa2 <- factor(c("a", "b", "b", "c", "c", "c", "d"))
fa2 # a b b c c c d # Levels: a b c d
class(fac) # factor

## Quiz
vec <- c(1, "R", TRUE) # What class of data is the vector?
class(vec) # "character"
vec

vec2 <- c(1, TRUE) # What class of data is the vector?
class(vec2) # "numeric"
vec2

## logical < numeric < characterの順に強い

TRUE + 5 # 6 Reason: TRUE is 1, and False is 0

## manual coersion
as.numeric("1") # 1 numericになる
as.character(TRUE) # "TRUE"

## What if you want different data types in the same object?
## lists 
## A list is a one dimensional group of R objects.
lst <- list(1, "R", TRUE)
class(lst)

## The elements of a list can be anything. Even vectors or other lists.
list(c(1, 2), TRUE, c("a", "b", "c"))

## data frame
## A data frame is a two dimensional group of R objects. Each column in a data frame can be a different type
df <- data.frame(c(1, 2, 3), c("R", "S", "T"), c(TRUE, FALSE, TRUE))
class(df)
df

## names
## You can name the elements of a vector, list, or data frame when you create them.
nvec <- c(one = 1, two = 2, three = 3)
class(nvec)
nvec

nlst <- list(one = 1, two = 2, many = c(3, 4, 5))
nlst
class(nlst)

ndf <- data.frame(numbers = c(1, 2, 3), letters = c("R", "S", "T"), logic = c(TRUE, FALSE, TRUE))
ndf
class(ndf)

names(ndf)
names(nvec)
names(nvec) <- c("uno", "dos", "tres")
nvec






## lecture 3 The R Language 2
##
##
vec <-  c(6, 1, 3, 6, 10, 5)
df <- data.frame(
  name = c("John", "Paul", "George", "Ringo"), 
  birth = c(1940, 1942, 1943, 1940), 
  instrument = c("guitar", "bass", "guitar", "drums")
)
vec[2]
vec[c(5, 6)]
vec[-c(5, 6)]
vec[vec > 5]
df[2, 3]
df[c(2, 4), 3]
df[c(2, 4), c(2, 3)]
df[ , 1]
df[ , "instrument"]
df$instrument
1:4
df[1:4, 1:2]
df[c(1, 1, 1, 2, 2), 1:3]
vec[0]
vec[1]
aaa <- 1:5
aaa
aaa[1]
df[1:2, 0]
df[-c(2:4), 2:3]
df[-c(2:4), -(2:3)]
vec[1:4]
vec[-(1:4)]
vec[c(3, 4, 5)]

## matrix
mat2 <- matrix(c(1:9), nrow = 3)
mat2
mat2[2] # 2

df[2]

vec[ ] # Blank spaces return everything

df[1, ]
df[ , 2]

vec
names(vec) <- c("a", "b", "c", "d", "e", "f")
vec[]
vec[c("a", "b", "c")]

df
df[ , "birth"]
df[ , c("name", "birth")]

vec[c(FALSE, TRUE, FALSE, TRUE, TRUE, FALSE)] # TRUE will be returned
df[c(FALSE, TRUE, TRUE, FALSE), ]

lst <- list(c(1, 2), TRUE, c("a", "b", "c"))
lst
sum(c(1, 2, 3)) # 6
sum(lst[1]) # Error!
lst[c(1, 2)]
lst[1]
lst[[1]]
lst[[1]][2] # 2

## $ is the most common syntax for subsetting lists and data frames
names(lst) <- c("alpha", "beta", "gamma")
lst
lst$alpha # 1 2
df$birth

## R Packages
install.packages("ggplot2") # one time
library(ggplot2) # every time
qplot(1:10, 1:10)
library("maps")
install.packages("RColorBrewer")
library("RColorBrewer")
install.packages(c("ggplot2", "maps", "RColorBrewer"))

## Diamonds data
data() # ggplot2 includes diamonds data
diamonds[1:6, ]
nrow(diamonds) # 53935
diamonds[53935:53940, ] # last six rows
head(diamonds) # extract six rows from the top as default
tail(diamonds) # extract six rows from the bottom as default
View(diamonds) # notice: Capital V

## Help pages
?diamonds
qplot(x, y, data = diamonds)
qplot(x, y, z, data = diamonds) # Erorr!

## Logical comparisons
1 < 3 # TRUE
1 > 3 # FALSE
c(1, 2, 3, 4, 5) > 3 # FALSE FALSE FALSE TRUE TRUE

## %in%
1 %in% c(1, 2, 3, 4) # TRUE
1 %in% c(2, 3, 4) # FALSE
c(3, 4, 5, 6) %in% c(2, 3, 4) # TRUE TRUE FALSE FALSE
x <- c(1, 2, 3, 4, 5)
x = 3 # same as <-

## & means and
x > 2 & x < 9 # TRUE & TRUE => TRUE
x > 2 & x < 3 # TRUE & FALSE => FALSE FALSE is stronger

## | means or
## TRUE is stronger
TRUE | TRUE # TRUE
TRUE | FALSE # TRUE
FALSE | TRUE # TRUE
FALSE | FALSE # FALSE

## xor 与えられた2つの命題のいずれか一つがTRUEのときのみTUREになる 
xor(TRUE, TRUE) # FALSE
xor(TRUE, FALSE) # TRUE
xor(FALSE, TRUE) # TRUE
xor(FALSE, FALSE) # FALSE

## !
!(TRUE) # FALSE
!(FALSE) # TRUE

## any 入力された引数のうち、1つ以上のTRUEが存在すればTRUEを返す
any(c(TRUE, FALSE, FALSE)) # TRUE
any(c(FALSE, FALSE, FALSE)) # FALSE

## all 入力された引数のうち、すべてがTRUEならTRUEを返す
all(c(TRUE, TRUE, TRUE)) # TRUE
all(c(TRUE, FALSE, TRUE)) # FALSE

w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")
w > 0
x > 10 & x < 20
y == "February"
all(z %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

## Logical subsetting
x_zeroes <- diamonds$x == 0
diamonds[x_zeroes, ]
diamonds[diamonds$x > 10, ]
big <- diamonds[diamonds$x > 10, ]
diamonds <- diamonds[diamonds$x < 10, ]
diamonds
diamonds <- diamonds[1, 1]
diamonds
rm(diamonds)
str(diamonds)
?str

## Missing values
a <- c(1, NA)
# a == NA # NA NA この記法はダメ。以下の方法で欠損値は確かめる
is.na(a) # FALSE TRUE

## na.rm
b <- c(1, 2, 3, 4, NA)
sum(b) # NA cannot calculate
sum(b, na.rm = TRUE)

## Assignment
summary(diamonds$x)
diamonds$x[diamonds$x == 0]
diamonds$x[diamonds$x == 0] <- NA # 0を欠損値にする
summary(diamonds$x) # 欠損値と認識して要約してくれる
summary(diamonds$y)
diamonds$y[diamonds$y == 0] <- NA
y_big <- diamonds$y > 20
diamonds$y[y_big] <- NA
summary(diamonds$y)
qplot(x, y, data = diamonds)







## lecture Visulalizing Data
##
##
?iris
plot(iris$Sepal.Width, iris$Sepal.Length)

## Diving in: Scatterplots
install.packages("ggplot2")
library(ggplot2)
?mpg
View(mpg)

## Aesthetics
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = class, size = class, shape = class, alpha = class)

## Faceting
qplot(displ, hwy, data = mpg) + facet_grid(. ~ cyl)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ .)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ cyl)
qplot(displ, hwy, data = mpg) + facet_wrap(~ class)

## Geom # "point" is the default geom
qplot(displ, hwy, data = mpg, geom = "smooth")
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
qplot(class, hwy, data = mpg, geom = "boxplot") # 箱ひげ図
qplot(reorder(class, hwy), hwy, data = mpg, geom = "boxplot")
?reorder
qplot(reorder(class, hwy, FUN = median), hwy, data = mpg, geom = "boxplot")

## Diamonds
qplot(x, z, data = diamonds) # Two viariables => scatterplot(point)
qplot(x, data = diamonds) # One continuous variables => histgram
qplot(cut, data = diamonds) # One categorical variable => bar chart
qplot(cut, data = diamonds, geom = "bar", color = cut) # change border's color
qplot(cut, data = diamonds, geom = "bar", fill = cut) # change all color

## Position adjustments
qplot(color, data = diamonds, geom = "bar", fill = cut)
## position is depricated
qlot2(color, data = diamonds, fill = cut, position = "stack")
qlot(color, data = diamonds, fill = cut, position = "dodge")
qplot(color, data = diamonds, fill = cut, position = "identity")
qplot(color, data = diamonds, fill = cut, position = "fill")
qplot(cty, hwy, data = mpg)
qplot(cty, hwy, data = mpg, position = "jitter")
qplot(cty, hwy, data = mpg, geom = "jitter")

## Parameters
qplot(carat, data = diamonds, binwidth = 1) # ヒストグラムの横幅
qplot(carat, data = diamonds, binwidth = 0.1)
qplot(carat, data = diamonds, binwidth = 0.01)
qplot(carat, data = diamonds)

## Adittional variables
zoom <- coord_cartesian(xlim = c(55, 70)) # coor_catesianで作図する範囲を指定。xlimでx軸の範囲を指定する
qplot(depth, data = diamonds, binwidth = 0.2) + zoom
qplot(depth, data = diamonds, binwidth = 0.2, fill = cut) + zoom
qplot(depth, data = diamonds, binwidth = 0.2) + zoom + facet_wrap(~ cut)
qplot(depth, data = diamonds, geom = "freqpoly", color = cut, binwidth = 0.2) + zoom + facet_wrap(~ cut)
qplot(depth, data = diamonds, geom = "freqpoly", color = cut, binwidth = 0.2) + zoom
qplot(depth, data = diamonds, geom = "density", color = cut) + zoom
qplot(price, data = diamonds, binwidth = 500) + facet_wrap(~ cut)
qplot(price, data = diamonds, binwidth = 500, fill = cut)
qplot(price, data = diamonds, binwidth = 500, geom = "freqpoly", color = cut)
qplot(price, data = diamonds, geom = "density", color = cut)
qplot(carat, price, data = diamonds, color = cut)

## Geoms for Big Data
qplot(carat, price, data = diamonds, geom = "bin2d")
install.packages("hexbin")
library(hexbin)
qplot(carat, price, data = diamonds, geom = "hex")
qplot(carat, price, data = diamonds, geom = "density2d")
qplot(carat, price, data = diamonds, geom = c("point", "density2d"))
qplot(carat, price, data = diamonds, geom = "smooth")
qplot(carat, price, data = diamonds, geom = "smooth", color = cut)
qplot(carat, price, data = diamonds, geom = "smooth", group = cut)
qplot(carat, price, data = diamonds, geom = "smooth", color = cut, se = FALSE)
qplot(carat, price, data = diamonds, geom = "smooth", color = cut, se = FALSE, method = lm)

## Size and transparency
qplot(carat, price, data = diamonds, color = "blue")
qplot(carat, price, data = diamonds, color = I("blue"))
qplot(carat, price, data = diamonds)
qplot(carat, price, data = diamonds, size = I(0.5))
qplot(carat, price, data = diamonds, alpha = I(1.0))
qplot(carat, price, data = diamonds, size = I(0.5), alpha = I(0.1))


## Saving graphs
getwd()
dir()
ggsave("my-plot.pdf")
ggsave("my-plot.png")
ggsave("my-plot.pdf", width = 6, height = 6)

## Summary
# qplot + aesthetics = 100’s of plots
# qplot + geoms = 100’s of plots
# qplot + geoms + aesthetics = 1000’s of plots
# qplot + geoms + aesthetics + parameters = 100,000’s

<
