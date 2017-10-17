install.packages(dplyr)

library(ggplot2)
library(ggmap)
ggplot(mpg, aes(hwy, cty)) + 
  geom_jitter(aes(color = cyl)) + 
  geom_smooth(method ="lm") + 
  coord_cartesian() + 
  scale_color_gradient() + 
  theme_bw()

View(mpg)

qplot(cty, hwy, data = mpg, position = "jitter")


vec <- c(6, 1, 3, 6, 10, 5)
vec[vec > 5]

apple <- data.frame(1:4, 1:2)
apple
