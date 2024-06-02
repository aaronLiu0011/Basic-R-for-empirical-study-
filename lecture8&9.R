if (!require("dplyr")) install.packages("dplyr")
if (!require("tidyr")) install.packages("tidyr")
if (!require("dbplyr")) install.packages("dbplyr")
if (!require("magrittr")) install.packages("magrittr")
if (!require("ggplot2")) install.packages("ggplot2")

library(tidyverse)
library(ggplot2)
library(gifski)
library(gganimate)
library(usethis)
library(devtools)
library(pacman)
library(ggrepel)
p_load(gapminder,ggthemes,Hmisc,wesanderson,ggridges)

# install_github("andrew-griffen/gdata")
# install_github("andrew-griffen/griffen")

library(gdata)
library(griffen)

# update.packages(ask = FALSE)

## Last time ####

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

## 1 ####

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
              method = 'gam', # lm
              color = "black",
              se = FALSE,
              show.legend = FALSE)

print(p)

## Filter ####

p <- ggplot(filter(gapminder, year == 1982),
  mapping = aes(x =log(gdpPercap), y = lifeExp, color = country)
) +
  geom_point(aes(size = pop), show.legend = FALSE) + 
  labs(title = "Life expectancy vs. Log GDP",
       subtitle = "Hans Rosling's Gapminder Data",
       caption = "Note: Year from 1957-2007",
       x = "Log GDP per capital", 
       y = "Life expectancy") +
  scale_color_manual(values = country_colors) + 
  facet_wrap(. ~ continent)

print(p)

## geom text ####

p <- ggplot(mapping = aes(x = log(gdpPercap), y = lifeExp, label = country)) +
  geom_text(data = filter(gapminder, country == "Germany")) +
  geom_point(data = filter(gapminder, country != "Germany"))

print(p)


#######

p <- ggplot(
  data = filter(
    gapminder,
    continent == "Asia",
    year == 1952),
  mapping = aes(x = log(gdpPercap), y = lifeExp, label = country)
  ) +
  geom_text()

print(p)

########

p <- ggplot(
  data = filter(
    gapminder,
    continent == "Asia"),
  mapping = aes(x = log(gdpPercap), y = lifeExp, label = country)
) +
  geom_text_repel()

print(p)

########

p <- ggplot(gapminder,
            aes(x = log(gdpPercap))) +
  geom_histogram(bins = 30) +
  facet_wrap(. ~ continent)

print(p)

########

p <- ggplot(gapminder,
            aes(x = log(gdpPercap))) +
  geom_density() +
  labs(x = "log gdp per capital", y = NULL)

print(p)

########

p <- ggplot(gapminder,
            aes(x = log(gdpPercap), fill = continent, color = continent)) +
  geom_density() +
  facet_wrap(. ~ continent) +
  scale_fill_manual(values = wes_palette("BottleRocket2")) +
  scale_color_manual(values = wes_palette("BottleRocket2"))
  theme(legend.title = element_blank())

print(p)

########

p <- ggplot(gapminder,
            mapping = aes(x = log(gdpPercap), y = factor(year))) +
  geom_density_ridges() +
  labs(x = "log gdp per capital", y = NULL)

print(p)

########

p <- ggplot(gapminder,
            mapping = aes(x = log(gdpPercap), y = lifeExp)) +
  geom_density_2d() +
  labs(x = "log gdp per capital", y = "Life expectancy")

print(p)

########

p <- ggplot(gapminder,
            mapping = aes(x = log(gdpPercap), y = lifeExp)) +
  geom_hex() +
  labs(x = "log gdp per capital", y = "Life expectancy")

print(p)

########

p <- ggplot(filter(gapminder, country == "China"),
            mapping = aes(x = year, y = lifeExp, size = pop)) +
  geom_line() +
  geom_point() +
  labs(x = "Year", y = "Life expectancy")

print(p)

######
p <- ggplot(
  data = whales,
  mapping = aes(long, lat)) +
  geom_path()

print(p)


## lecture 9 ####

# e9ff9ece-aae9-441a-82e7-e575dc4a87fa
library(leaflet)
library(ggmap)
library(sf)

####### 

leaflet() |>
  addTiles() |>
  setView(
    lng = 139.7614,
    lat = 35.7104,
    zoom = 5)

leaflet() |>
  addTiles() |>
  addMarkers(
    lng = 139.7614,
    lat = 35.7104,
    popup = "UTokyo Economics")

leaflet() |>
  addTiles() |>
  setView(
    lng = 139.7614,
    lat = 35.7104,
    zoom = 5) |>
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")

#########

register_stadiamaps("e9ff9ece-aae9-441a-82e7-e575dc4a87fa", write = FALSE)

bbox_whale <- make_bbox(long, lat, whales)

map_whales <- get_stadiamap(bbox = bbox_whale, zoom = 9, maptype = "stamen_toner_lite")

w = ggmap(map_whales) +
  geom_path(
    data = whales,
    mapping = aes(long, lat)
  )

print(w)


#### ##

bbox_whale <- make_bbox(long, lat, whales, f = c(3,3))
map_whales <- get_stadiamap(bbox = bbox_whale, zoom = 5, maptype = "stamen_toner_lite")

w = ggmap(map_whales) +
  geom_path(
    data = whales,
    mapping = aes(long, lat)
  ) +
  labs(title = "Path of Whales",
       caption = "Note: Year 2007",
       x = "Longitude", 
       y = "Latitude")

print(w)


#########
us <- c(left = -125, bottom = 25.75, right = -67, top = 49)

library(usethis)
library(devtools)
install_github("dkahle/ggmap")
map_us = get_stadiamap(us, zoom = 5, maptype = "stamen_watercolor")

us = ggmap(map_us) +
  geom_point(
    data = blood_meridian,
    mapping = (aes(x = lng,y = lat, label = location))
    ) 

print(us)

us = ggmap(map_us) +
  geom_text_repel(data = blood_meridian, aes(x = lng,y = lat, label = location), size = 2) + 
  geom_point(
    data = blood_meridian,
    mapping = (aes(x = lng,y = lat, label = location))
  ) 

print(us)

#########

ggplot(data = us_sf) + geom_sf()
ggplot(data = japan_sf) + geom_sf()

trump_biden
