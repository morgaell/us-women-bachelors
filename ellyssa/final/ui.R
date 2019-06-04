#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

majors <- data %>% 
  select(-Year)

major_names <- colnames(majors)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Women's Bachelor Degree Data"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("majors", 
                  label = "Select a Major",
                  choices = major_names),
      
      numericInput("date",
                   "Select a Year",
                   value = 2011,
                   min = 1970,
                   max = 2011)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("By Degree", plotOutput("major_plot")),
        tabPanel("All Degrees", plotOutput("all_majors_plot"))
      )
    )
  )
))