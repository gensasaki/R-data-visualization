## Keio University, Spring 2016
## Introduction to Data Science and Data Visualization with R
## Session 8
##
## Name: Gen Sasaki
## Data: July 13, 2016




## Figure 1


rm(list = ls())
options(stringsAsFactors = FALSE)

library(dplyr)
library(ggplot2)
library(reshape2)

name <- "data/HouseStateFirstPrefsByPollingPlaceDownload-17496-"

act <- read.csv(paste0(name, "ACT", ".csv"), skip = 1)
nsw <- read.csv(paste0(name, "NSW", ".csv"), skip = 1)
nt <- read.csv(paste0(name, "NT", ".csv"), skip = 1)
qld <- read.csv(paste0(name, "QLD", ".csv"), skip = 1)
sa <- read.csv(paste0(name, "SA", ".csv"), skip = 1)
tas <- read.csv(paste0(name, "TAS", ".csv"), skip = 1)
vic <- read.csv(paste0(name, "VIC", ".csv"), skip = 1)
wa <- read.csv(paste0(name, "WA", ".csv"), skip = 1)


## 
# act <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-ACT.csv", skip = 1)
# nsw <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-NSW.csv", skip = 1)
# nt <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-NT.csv", skip = 1)
# qld <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-QLD.csv", skip = 1)
# sa <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-SA.csv", skip = 1)
# tas <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-TAS.csv", skip = 1)
# vic <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-VIC.csv", skip = 1)
# wa <- read.csv("data/HouseStateFirstPrefsByPollingPlaceDownload-17496-WA.csv", skip = 1)
?read.csv

## これだと大変だから下のbind_rowsでやる
# df <- bind_rows(act, nsw)
# df <- bind_rows(df, nt)
# df <- bind_rows(df, qld)
# df <- bind_rows(df, sa)
# df <- bind_rows(df, tas)
# df <- bind_rows(df, vic)
# df <- bind_rows(df, wa)

df <- bind_rows(act, nsw, nt, qld, sa, tas, vic, wa) %>% 
  filter(BallotPosition != 999) %>% 
  select(PollingPlaceID, BallotPosition, OrdinaryVotes) %>% 
  mutate(log_votes = log(OrdinaryVotes + 1)) %>% 
  group_by(PollingPlaceID) %>% 
  mutate(ncand = max(BallotPosition)) %>% 
  filter(ncand != 16) %>% 
  ungroup()


df$ncand <- as.factor(df$ncand)
levels(df$ncand) <- c("Num. Candidates = 5",
                      "Num. Candidates = 6",
                      "Num. Candidates = 7",
                      "Num. Candidates = 8",
                      "Num. Candidates = 9",
                      "Num. Candidates = 10",
                      "Num. Candidates = 11",
                      "Num. Candidates = 12",
                      "Num. Candidates = 13")

ggplot() +
  geom_boxplot(data = df, 
               aes(x = as.factor(BallotPosition),
                   y = log_votes,
                   na.rm = TRUE)) +
  facet_wrap(~ ncand, nrow = 3) +
  labs(title = "Figure 1 (Box Plot)",
       x = "Ballot Position",
       y = "Number of Votes (in log)")

ggsave("figures/Session8_figure2.pdf", width = 9, height = 4.95)





## Figure 2

rm(list = ls())

library(dplyr)
library(ggplot2)
library(reshape2)

name <- "data/HouseStateFirstPrefsByPollingPlaceDownload-17496-"

act <- read.csv(paste0(name, "ACT", ".csv"), skip = 1)
nsw <- read.csv(paste0(name, "NSW", ".csv"), skip = 1)
nt <- read.csv(paste0(name, "NT", ".csv"), skip = 1)
qld <- read.csv(paste0(name, "QLD", ".csv"), skip = 1)
sa <- read.csv(paste0(name, "SA", ".csv"), skip = 1)
tas <- read.csv(paste0(name, "TAS", ".csv"), skip = 1)
vic <- read.csv(paste0(name, "VIC", ".csv"), skip = 1)
wa <- read.csv(paste0(name, "WA", ".csv"), skip = 1)


df <- bind_rows(act, nsw, nt, qld, sa, tas, vic, wa) %>% 
  filter(BallotPosition != 999) %>% 
  select(PollingPlaceID, BallotPosition, OrdinaryVotes) %>% 
  mutate(log_votes = log(OrdinaryVotes + 1)) %>% 
  group_by(PollingPlaceID) %>% 
  mutate(ncand = max(BallotPosition)) %>% 
  filter(ncand != 16) %>% 
  ungroup()

# df <- bind_rows(act, nsw, nt, qld, sa, tas, vic, wa)

df <- df %>% mutate(position = BallotPosition)

df$position <- ifelse(df$position <= 3, "smaller", "larger")

df2 <- df %>% 
  group_by(PollingPlaceID, position) %>% 
  summarise(votes = mean(OrdinaryVotes)) %>% 
  dcast(PollingPlaceID ~ position, value.var = "votes") %>% 
  mutate(diff = smaller - larger)

t.test(df2$diff, mu = 0)
