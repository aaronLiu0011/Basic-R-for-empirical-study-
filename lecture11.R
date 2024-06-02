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
library(gt)
library(gtExtras)
library(webshot2)
library(broom)
p_load(gapminder,ggthemes,Hmisc,wesanderson,ggridges)


##########


gap_lifeExp <-
  gapminder |>
  group_by(continent) |>
  summarise(lifeExp_mean = mean(lifeExp), lifeExp_sd = sd(lifeExp))

gap_lifeExp |>
  gt()

growth <- function(a){
  c <- lm(log(gdpPercap) ~ year, a)
  return(c)
}

gapminder_nested <- 
  gapminder |>
  group_by(continent) |>
  nest()

gapminder_nested <-
  gapminder_nested |>
  mutate(model = map(data,growth))

gapminder_nested <-
  gapminder_nested |>
  mutate(tidy_model = map(model,tidy))

gapminder_model <-
  gapminder_nested |>
  select(continent, tidy_model)  

gapminder_coef <-
  gapminder_model |>
  unnest(cols = c("tidy_model"))

gapminder_ycoef <-
  gapminder_coef |> 
  filter(term == "year") |>
  select(continent, estimate, std.error, p.value)

gapminder_ycoef <-
  gapminder_ycoef |> 
  mutate(estimate = roundr(estimate))
  

gapminder_ycoef <-
  gapminder_ycoef |>
  mutate(estimate = if_else(p.value<0.05, paste0(estimate,"*"), estimate))

gapminder_ycoef <-
  gapminder_ycoef |> 
  mutate(std.error = roundr(std.error))

gapminder_ycoef <-
  gapminder_ycoef |>
  mutate(std.error = paste0("(", std.error,")"))

gapminder_ycoef <-
  gapminder_ycoef |>
  rename("Growth rate" = estimate) |>
  select(-p.value) |>
  ungroup()

gap_tbl <-
  gapminder_ycoef |>
  gt()

gap_tbl <-
  gap_tbl |>
  tab_style(
    style = cell_text(align = "left"),
    locations = cells_stub()
  )
  
gap_tbl <-
  gap_tbl |>
  cols_merge(columns = c("Growth rate", "std.error"), pattern = "{1}<br>{2}")

gap_tbl <-
  gap_tbl |>
  gt_theme_538()

