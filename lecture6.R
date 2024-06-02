# install.packages("andrew-griffen/gdata")
# install.packages("andrew-griffen/griffen")

library(devtools)
library(tidyverse)
library(griffen)
library(gdata)
library(stringi)

x <- c("a","b","c")
x <- factor(x)
x[1:2]

x <- c("a","b","c")
x <- factor(x, level = c("a","b","c"))

x <- c("a","b","c")
x <- factor(x, level = c("a","b","c","d"))

punc <- c(".",","," ")
g <-
  gettysburg |>
  stri_replace_all_fixed(punc, "", vectorize_all = FALSE)

g <-
  g |>
  str_split("") |>
  unlist() |>
  tolower()

g_df = tibble(g)

g_df <- 
  g_df |>
  mutate(g = factor(g))

g_df_pct <-
  g_df |>
  group_by(g) |>
  pct()

g_df <- 
  g_df |>
  mutate(g = factor(g, levels = rev(letters)))

g_df_pct <-
  g_df |>
  group_by(g, .drop = FALSE) |>
  pct()

ggplot(g_df_pct, aes(pct,g)) + geom_point()
  
left_join(x,y)

x |> left_join(y)

inner_join(x,y)

right_join(x,y)

cps |>
  group_by(year,state) |>
  summarise(mean_wage = mean(wage)) |>
  right_join(cps) |>
  left(year,state,mean_wage,wage)

anti_join(x,y)
full_join(x,y)

cps <- cps |> left_join(state_population)

anti_join(cps,state_population)

tbl1 |> pivot_longer(-id)

tbl4 |> pivot_longer(cols = starts_with("contribution"))
tbl4 |> pivot_longer(contains("contribution"))
