# install.packages("stringi")

library(devtools)
library(tidyverse)
library(griffen)
library(gdata)
library(stringi)

cps |>
  select(year) |>
  distinct() |>
  arrange(year)

cps |>
  select(year) |>
  arrange(year) |>
  distinct()

cps |>
  select(year) |>
  distinct() |>
  arrange(-year)

cps |>
  select(year) |>
  distinct() |>
  arrange(-year) |>
  pull()

cps |>
  select(year) |>
  distinct() |>
  arrange(year) |>
  print_all()

filter(cps, year == 1999)

cps |>
  filter(year == 1999)

cps |>
  filter(educ_years < 12)

cps |>
  filter(educ_years > 16 & state == "Kentucky")

cps |>
  filter(educ_years > 16 | state == "Kentucky")

cps |> filter(year == 1984 | year == 1999)

cps |> filter(year %in% c(1999,1984))

cps <- cps |> rename(area = region)

cps |>
  filter(year == 1999) |>
  select(wage) |>
  pull() |>
  mean()

cps <-
  cps |>
  mutate(log_wage = log(wage))

cps <-
  cps |>
  mutate(earnings = hours_lastweek * wage)

cps <-
  cps |>
  mutate(year_of_birth = 2024 - age)

cps <-
  cps |>
  mutate(if_kentucky = if_else(state == "Kentucky",1,0))

cps |>
  group_by(education_category) |>
  summarise(mean_wage = mean(wage))

cps |>
  group_by(year) |>
  summarise(mean_wage = mean(wage))

cps |>
  group_by(education_category,year) |>
  summarise(mean_wage = mean(wage))

cps_sd <-
cps |>
  group_by(year) |>
  summarise(sd_wage = sd(wage, na.rm = TRUE))

ggplot(data = cps_sd, aes(x = year, y = sd_wage)) + geom_point()

cps |>
  group_by(year) |>
  summarise(across(c(black,white,married),mean))

cps |>
  select(where(is.character))

  