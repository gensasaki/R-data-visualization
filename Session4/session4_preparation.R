plot(iris$Sepal.Width, iris$Sepal.Length)
## install.packages("ggplot2")
library(ggplot2)
?mpg
View(mpg)

## Aesthetics
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, color = class)
qplot(displ, hwy, data = mpg, size = class)
qplot(displ, hwy, data = mpg, shape = class)
qplot(displ, hwy, data = mpg, alpha = class)

## Faceting
qplot(displ, hwy, data = mpg) + facet_grid(. ~ cyl)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ .)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ cyl)
qplot(displ, hwy, data = mpg) + facet_wrap(~ class)
# facet_grid(): 2d grid, rows ~ cols, / . for no split
# facet_wrap(): 1d ribbon wrapped into 2d

## Geom
qplot(displ, hwy, data = mpg)
qplot(displ, hwy, data = mpg, geom = "smooth")
qplot(displ, hwy, data = mpg, geom = c("point", "smooth")) # you can plot mutiple geoms
qplot(class, hwy, data = mpg, geom = "boxplot")
qplot(reorder(class, hwy), hwy, data = mpg, geom = "boxplot") # reorder x axis
?reorder
qplot(reorder(class, hwy, FUN = median), hwy, data = mpg, geom = "boxplot")

## Bar charts
qplot(x, z, data = diamonds)
qplot(x, data = diamonds)
qplot(cut, data = diamonds)
# Default geoms for qplot
# Two variables -> scatterplot(point)
# One continuous valiable -> histogram
# One categorical variable -> bar chart
qplot(cut, data = diamonds, geom = "bar", color = cut)
qplot(cut, data = diamonds, geom = "bar", fill = cut)

## Position adjustments
qplot(color, data = diamonds, geom = "bar", fill = cut)
qplot(color, data = diamonds, geom = "bar", fill = cut, position = "stack")
qplot(color, data = diamonds, fill = cut, position = "stack")
qplot(color, data = diamonds, fill = cut, position = "dodge")
qplot(color, data = diamonds, fill = cut, position = "identity")
qplot(color, data = diamonds, fill = cut, position = "fill")

