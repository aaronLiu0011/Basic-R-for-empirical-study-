library(tidyverse)
library(ggpubr)

standardized_f <- function(x){
  if (sum(!is.na(x)) > 1){
    m <- mean(x)
    s <- sd(x)
    f <- (x-m)/s
    return(f)
  }else{
    print("error")
  }
}

a <- list(1,"hello",TRUE)
b <- list(n = 1,ch = "hello",b = TRUE)
c <- list(n = 1:10, ch = c("hello","goodbye"),b = c("TRUE","FALSE"))

data("mtcars")
ggplot(mtcars, aes(x = cyl, y = mpg)) +
  geom_point() + 
  stat_smooth(method = lm)

m1 <- lm(mpg ~ cyl,mtcars)
m2 <- lm(mpg ~ disp,mtcars)
