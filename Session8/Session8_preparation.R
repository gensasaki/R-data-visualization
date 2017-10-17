install.packages("devtools")
install.packages(c("dplyr", "tidyr", "ggvis", "nycflights13"))

library(dplyr)
library(nycflights13)

flights <- tbl_df(flights)
# Can undo with
# flights <- as.data.frame(flights)

View(flights)
View(iris)
View(mtcars)

## glimpse()
glimpse(flights)
glimpse(iris)
glimpse(mtcars)

## %>% (command + shift + M)
dd <- flights$dep_delay
mean(dd, na.rm = TRUE)
dd %>% mean(na.rm = TRUE)

# little_bunny.foo_foo %>% 
#   hop_through(forest) %>% 
#   scoop_up(field.mouse) %>% 
#   bop_on(head)

library(EDAWR)




## dplyr
View(storms)

select(flights, dep_delay, dep_time)
select(flights, dep_time, arr_time, air_time)
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with("dep"))
select(flights, dep_time:arr_delay)


storms %>% filter(wind >= 50)
?storms

flights2 <- flights %>% filter(!is.na(arr_delay))

flights3 <- flights %>% 
  filter(!is.na(arr_delay)) %>% 
  select(carrier, arr_delay)

flights %>% 
  mutate(speed = distance / air_time * 60) %>% 
  select(carrier, arr_delay, speed)

flights %>% 
  filter(!is.na(air_time), !is.na(distance)) %>% 
  summarise(n = n(),
            n_carriers = n_distinct(carrier),
            total_time = sum(air_time),
            total_dist = sum(distance))


flights %>% filter(!is.na(arr_delay)) %>% 
  group_by(carrier) %>% 
  summarise(avg_delay = mean(arr_delay))


flights %>% 
  filter(!is.na(arr_delay)) %>% 
  group_by(origin, dest) %>% 
  summarise(n = n()) %>% 
  ungroup()
