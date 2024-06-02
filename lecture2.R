library(rmarkdown)
library(tidyverse)

x <- 1:10
z <- seq(1,10,1)

print(identical(x,z))

square_f <- function(x,z){
  if(is.numeric(x)){
    x <- x^2
    return(x)
  }else{
    z <- z^2
    return(z)
  }
}

square_f2 <- function(x,z){
  if(is.numeric(z)){
    z <- z^2
    return(z)
  }else{
    x <- x^2
    return(x)
  }
}

z <- 3
three_f <- function(x){
  x <- x^z
  return(x)
}




