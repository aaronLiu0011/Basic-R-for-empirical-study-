library(usethis)
library(devtools)
#install.packages("gapminder")
#install.packages("ggthemes")
#install.packages("Hmisc")
#install.packages("wesanderson")
#install.packages("ggridges")

library(pacman)
library(tidyverse)

# install_github("andrew-griffen/gdata")
# install_github("andrew-griffen/griffen")

library(griffen)
library(gdata)



p_load(gapminder,ggthemes,Hmisc,wesanderson,ggridges)

p <- ggplot(
  data <- gapminder,
  mapping = aes(x = gdpPercap, y = lifeExp, color = continent)
) +
  geom_point() + # check https://www.color-hex.com/ to get the color code
  labs(title = "Life expectancy vs. GDP",
       x = "GDP per capital", 
       y = "Life expectancy") +
  scale_color_manual(values = wes_palette("Royal2"))

print(p)

wes_palette("Royal2")
unclass(wes_palette("Royal2"))

#######
  
p <- ggplot(
  data <- gapminder,
  mapping = aes(x = gdpPercap, y = lifeExp, color = country)
) +
  geom_point(show.legend = FALSE) + 
  labs(title = "Life expectancy vs. GDP",
       x = "GDP per capital", 
       y = "Life expectancy") +
  scale_color_manual(values = country_colors)

print(p)

####### Log

p <- ggplot(
  data <- gapminder,
  mapping = aes(x =log(gdpPercap), y = lifeExp, color = country)
) +
  geom_point(show.legend = FALSE) + 
  labs(title = "Life expectancy vs. Log GDP",
       subtitle = "Hans Rosling's Gapminder Data",
       caption = "Note: Year from 1957-2007",
       x = "Log GDP per capital", 
       y = "Life expectancy") +
  scale_color_manual(values = country_colors)

print(p)

######## Theme

library(hrbrthemes)
theme_set(theme_economist(base_size = 18))
theme_set(theme_excel(base_size = 18))
theme_set(theme_wsj(base_size = 18))
theme_set(theme_tufte(base_size = 18))
theme_set(theme_stata(base_size = 18))
theme_set(theme_ipsum(
  base_size = 18,
  axis_title_size =12))

######## Transparency

p <- ggplot(
  data <- gapminder,
  mapping = aes(x =log(gdpPercap), y = lifeExp, color = country, size = pop)
) +
  geom_point(show.legend = FALSE, alpha = .7) + 
  labs(title = "Life expectancy vs. Log GDP",
       subtitle = "Hans Rosling's Gapminder Data",
       caption = "Note: Year from 1957-2007",
       x = "Log GDP per capital", 
       y = "Life expectancy") +
  scale_color_manual(values = country_colors)

print(p)

####### Faceting

p <- ggplot(
  data <- gapminder,
  mapping = aes(x =log(gdpPercap), y = lifeExp, color = country, size = pop)
) +
  geom_point(show.legend = FALSE, alpha = .7) + 
  labs(title = "Life expectancy vs. Log GDP",
       subtitle = "Hans Rosling's Gapminder Data",
       caption = "Note: Year from 1957-2007",
       x = "Log GDP per capital", 
       y = "Life expectancy") +
  scale_color_manual(values = country_colors) + 
  facet_wrap(. ~ continent)

print(p)


####### add model

p <- ggplot(
  data <- gapminder,
  mapping = aes(x =log(gdpPercap), y = lifeExp, color = country)
) +
  geom_point(aes(size = pop), show.legend = FALSE) + 
  labs(title = "Life expectancy vs. Log GDP",
       subtitle = "Hans Rosling's Gapminder Data",
       caption = "Note: Year from 1957-2007",
       x = "Log GDP per capital", 
       y = "Life expectancy") +
  scale_color_manual(values = country_colors) + 
  facet_wrap(. ~ continent) +
  geom_smooth(aes(x = log(gdpPercap),
                  y = lifeExp,
                  group = continent),
              formula = y ~ x,
              method = 'loess',
              color = "black",
              se = FALSE,
              show.legend = FALSE)

print(p)


#####
p <- ggplot(data = gdata$codes, 
            mapping = aes(x = pgg_contribution_round1, y = pgg_contribution_round2)) +
  geom_point()

print(p)

