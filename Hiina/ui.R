library(shiny)
library(ggplot2)
library(dplyr)




selected_year <- unique(data$Year)

x_input <- selectInput(
  "Year1",
  "Choose a year",
  choices = selected_year,
  selected = "1970"
)

y_input <- selectInput(
  "Year2",
  "Choose a different year",
  choices = selected_year,
  selected = "1971"
)

shinyUI(fluidPage(
  titlePanel("comparing STEM majors in different years"),
  
  sidebarLayout(
    sidebarPanel(
      x_input,
      y_input
    ),
    
  
  mainPanel(plotOutput("graph")
  )
)))
