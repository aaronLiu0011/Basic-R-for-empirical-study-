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
p_load(shiny,shinythemes,bslib,showtext,thematic)
library(palmerpenguins)

##numeric#######

ui <- fluidPage(
  # front end interface
  numericInput("N", label = "N", value = 100, step = 50),
  textOutput("double")
)

server <- function(input, output, session){
  output$double <- renderPrint(2*input$N)
}

shinyApp(ui, server)

##slider#####

ui <- fluidPage(
  # front end interface
  sliderInput("N", label = "N", value = 50, min = 0, max = 100),
  textOutput("double")
)

server <- function(input, output, session){
  output$double <- renderPrint(2*input$N)
}

shinyApp(ui, server)

##reactivity#####

ui <- fluidPage(
  # front end interface
  sliderInput("N", label = "N", value = 50, min = 0, max = 1000),
  plotOutput("density")
)

server <- function(input, output, session){
  output$density <- renderPlot({
    x = rnorm(input$N)
    df = tibble(x)
    ggplot(df, aes(x)) + geom_density()
  })
}

shinyApp(ui, server)

#######

ui <- fluidPage(
  textInput("name", "What's your name?"),
  numericInput("age", "How old are you?", value = 0, min = 0, max = 100),
  textOutput("greeting")
  
)

server <- function(input, output, session){
  output$greeting <- renderText({
    paste0("Hello ", input$name, "!", " Congratulations on being ", input$age)
  })
}

shinyApp(ui, server)

#######

ui <- fluidPage(
  titlePanel("Palmer Penguins"),
  sidebarLayout(
    sidebarPanel(
      selectInput("island", label = "Island", choices = c("Torgersen", "Biscoe", "Dream"))
    ),
  mainPanel(
    plotOutput("plot")
    )
  )
)

server <- function(input, output, session){
  #gets input on island
  data <- reactive({
    dplyr::filter(penguins, island==input$island)
  })
  output$plot <- renderPlot({
    ggplot(data(), aes(bill_length_mm, body_mass_g)) +
      geom_point() +
      labs(x = "Bill length (mm)", y = "Body mass (g)")
  })
}
penguins_app <- shinyApp(ui, server)

#######

ui <- fluidPage(
  titlePanel("Gapminder Data"),
  sidebarLayout(
    sidebarPanel(
      selectInput("continent", label = "Continent", choices = c("Asia", "Americas", "Europe", "Oceania", "Africa"))
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session){
  data <- reactive({
    dplyr::filter(gapminder, continent==input$continent)
  })
  output$plot <- renderPlot({
    ggplot(data <- data(),
           mapping = aes(x =log(gdpPercap), y = lifeExp, color = country)
    ) +
      geom_point(aes(size = pop), show.legend = FALSE) +
      labs(x = "log GDP per cap", y = "Life Expectancy") +
      scale_color_manual(values = country_colors)
  })
}
gapminder_app <- shinyApp(ui, server)
runApp((gapminder_app))
