# install.packages("devtools")
library(devtools)

# install_github("andrew-griffen/griffen")
# install_github("andrew-griffen/gdata")

library(tidyverse)
is_tibble("cps")
is_tibble("mtcars")

mtcars <- as_tibble(mtcars)
is_tibble(mtcars)

mtcars <- as.data.frame(mtcars)
is.data.frame(mtcars)

library(gdata)

write_csv(oj,"oj.csv")
a = read_csv("oj.csv")
b = read.csv("oj.csv")

library(griffen)

select(cps,year)
cps_year <- select(cps,year)

select(cps,wage,black)

cps_year <- cps |> select(year)

cps |> select(year) |> distinct()

