#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
selected_year <- unique(df$Year)

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
  
  titlePanel("Camparing pie charts"),
  sidebarLayout(
    sidebarPanel(
      x_input,
      y_input
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("pie1"),
       plotOutput("pie2")
    )
  )
))
