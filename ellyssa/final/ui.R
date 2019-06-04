library(shiny)
library(dplyr)

majors <- data %>% 
  select(-Year)

major_names <- colnames(majors)
selected_year <- unique(data$Year)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  navbarPage("US Women's Bachelors Degrees",
    tabPanel("Data By Degree",
      sidebarLayout(
        sidebarPanel(
          selectInput("majors", 
                      label = "Select a Major",
                      choices = major_names)
        ),
        mainPanel(
          plotOutput("major_plot")
        )
      )
    ),
    tabPanel("All Degree Data",
      sidebarLayout(
        sidebarPanel( 
          numericInput("date",
                         "Select a Year",
                         value = 2011,
                         min = 1970,
                         max = 2011)
        ),
        mainPanel(
          plotOutput("all_majors_plot")
        )
       )
    ),
    tabPanel("Compare",
      sidebarLayout(
        sidebarPanel(
          selectInput("Year1",
                      "Choose a year",
                      choices = selected_year,
                      selected = "1970"
          ),
          selectInput("Year2",
                      "Choose a different year",
                      choices = selected_year,
                      selected = "1971"
          )
        ),
        mainPanel(
          plotOutput("pie1"),
          plotOutput("pie2")
        )
      )       
    ),
    tabPanel("STEM",
             sidebarLayout(
               sidebarPanel(
                 selectInput("Year3",
                             "Choose a year",
                             choices = selected_year,
                             selected = "1970"
                 ),
                 selectInput("Year4",
                             "Choose a different year",
                             choices = selected_year,
                             selected = "1971"
                 )
               ),
               mainPanel(plotOutput("graph")
               )
  )
))))
