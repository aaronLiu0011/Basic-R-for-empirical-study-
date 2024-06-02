library(usethis)
library(dplyr)
library(tidyr)
library(dbplyr)
library(magrittr)
library(ggplot2)
library(knitr)
library(devtools)
library(tidyverse)
library(pacman)
library(ggthemes)
library(gdata)
library(griffen)
library(hrbrthemes)
library(broom)
library(palmerpenguins)

#######

for (i in 1:5){
  print(i)
}

for (i in 1:5){
  print(sqrt(i))
}

#######

a <- 1:5
b <- vector()

for (i in 1:5){
  b[i] <- sqrt(a[i])
}

print(b)

#######

df <- tibble(a)

df <- df |>
  mutate(b = sqrt(a))

#######

map(a, sqrt)

df <- df |>
  mutate(b = map(a, sqrt))

#######

map_dbl(a, sqrt)

map(mtcars, mean)

# mean(mtcars)

map_dbl(mtcars, mean)

# map(penguins, mean)

map_df(mtcars, mean)

#######
library(gapminder)

growth <- function(a){
  c <- lm(log(gdpPercap) ~ year, a)
  return(c)
}

growth(gapminder)

growth_f <- function(a,b){
  a <- a |> filter(country == b)
  c <- lm(log(gdpPercap) ~ year, a)
  return(c)
}

growth_f(gapminder, "Japan")
growth_f(gapminder, "China")

growth(filter(gapminder, country == "China", year >= 1989))

#########

jp_df <- 
  gapminder |>
  filter(country == "Japan") |>
  growth() |>
  tidy()

# jp_df[2,2]

jp_df |> filter(term == "year") |> select(estimate)

##nest()#####

gapminder |>
  group_by(country)

gapminder_nested <- 
  gapminder |>
  group_by(country) |>
  nest()

# growth(gapminder_nested$data)
# gapminder_nested <-
  # gapminder_nested |>
  # mutate(model = growth(data))

gapminder_nested <-
  gapminder_nested |>
  mutate(model = map(data,growth))

# gapminder_nested <-
  # gapminder_nested |>
  # mutate(model = map(data,growth)) |>
  # tidy()
  
# mutate(growth_rate = model |> filter(term == "year") |> select(estimate))

gapminder_nested$model[1]

map(gapminder_nested$model, tidy)

gapminder_nested <-
  gapminder_nested |>
  mutate(tidy_model = map(model,tidy))

gapminder_model <-
  gapminder_nested |>
  select(country, tidy_model)

gapminder_coef <-
  gapminder_model |>
  unnest(cols = c("tidy_model"))

gapminder_ycoef <-
  gapminder_coef |> 
  filter(term == "year")


