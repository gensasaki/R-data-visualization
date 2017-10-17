## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Demonstration
##
## Name: Gen Sasaki
## Data: July 4th, 2016

rm(list = ls())




## 1. Simple Calculation

123 + 456
789 - 123
111 * 222
(12 + 34) * (56 - 78)
123 + 45 / 67



## 2. Simple Algebra

x <- 123
y <- 456
x + y
firstName <- 8
lastName <- 2
(firstName + lastName) / (firstName + lastName)



## 3. Use Functions

sqrt(456)
log(12)
factorial(4)
round(123.45678, digit = 2)
round(12345678, digit = -2)



## 4. R Objects

rm(firstName, lastName)
firstName
firstName <- 10
lastName <- ((firstName + 2) * 3 - 6) / 6
firstName
lastName
Best.University <- "Keio"
Best.University



## 5. Data Structure

A <- c(15, 49, 18, 48, 88, 91, 74, 39, 94)
A
A + 3
A * 3
A ^ 2
B <- matrix(A, nrow = 3)
rownames(B) <- c("a", "b", "c")
colnames(B) <- c("A", "B", "C")
B



## 6. Data Types

class(123)
class("Yusaku")
class(Yusaku) # Error! This is not charater.
X <- "Yusaku"
Y <- "Horiuchi"
nchar(X) + nchar(Y)
paste(X, Y) # print(c(Y, X) cannot combine words
17 > 16
12 * 78 > 34 * 56
class(FALSE)
TRUE + 5
FALSE + 4
(FALSE + 5) * FALSE
fruits <- factor(c("apple", "orange", "apple", "apple", 
                   "orange", "banana", "banana", "orange", 
                   "apple", "banana"))
fruits
class(fruits)
table(fruits)
ThisCourse <- c("Spring", 2016, TRUE)
ThisCourse
class(ThisCourse) # Error! contains some classes
fruits.2 <- is.numeric(fruits)
fruits.2
as.character(TRUE) + 5



## 7. List and Data Frame

Horiuchi.Course.List <- list(
  c("Quantitative Political Analysis", 
    "Data Visualization", 
    "Politics of Japan", 
    "Global Public Opinion"), 
  c(10, 16, 43, 81), 
  c(TRUE, FALSE, FALSE, FALSE)
  ) 
Horiuchi.Course.List
class(Horiuchi.Course.List)
names(Horiuchi.Course.List) <- c("Course" ,"Number", "QDS")
Horiuchi.Course.List
Horiuchi.Course.DF <- data.frame(
  Course = c("Quantitative Political Analysis", 
             "Data Visualization", 
             "Politics of Japan", 
             "Global Public Opinion"), 
  Number = c(10, 16, 43, 81), 
  QDS = c(TRUE, FALSE, FALSE, FALSE)
)
Horiuchi.Course.DF
is.data.frame(Horiuchi.Course.DF)
nrow(Horiuchi.Course.DF)
ncol(Horiuchi.Course.DF)
dim(Horiuchi.Course.DF)
