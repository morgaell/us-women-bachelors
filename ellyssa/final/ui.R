library(shiny)
library(dplyr)
library(shinythemes)

majors <- data %>% 
  select(-Year)

major_names <- colnames(majors)
selected_year <- unique(data$Year)

# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("darkly"),
  
  navbarPage("US Women's Bachelors Degrees",
    
    tabPanel("Introduction",
      titlePanel("Introduction"), 
      mainPanel(
         img(src='grad.jpg', align = "right"), 
         textOutput("intro")
       )
    ),
    tabPanel("Data By Degree",
     titlePanel("Data by Degree"),
      sidebarLayout(
        sidebarPanel(
          selectInput("majors", 
                      label = "Select a Major",
                      choices = major_names)
        ),
        mainPanel(
          plotOutput("major_plot"),
          textOutput("by_degree_analysis")
          
        )
      )
    ),
    tabPanel("All Degree Data",
      titlePanel("All Degree Data"),
      sidebarLayout(
        sidebarPanel( 
          numericInput("date",
                         "Select a Year",
                         value = 2011,
                         min = 1970,
                         max = 2011)
        ),
        mainPanel(
          plotOutput("all_majors_plot"),
          textOutput("all_degrees_analysis")
        )
       )
    ),
    tabPanel("Compare",
      titlePanel("Compare STEM and Non-STEM Majors"),
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
          ),
          textOutput("compare_analysis")
        ),
        mainPanel(
          plotOutput("pie1"),
          plotOutput("pie2")
        )
      )       
    ),
    tabPanel("STEM",
        titlePanel("STEM Majors"),
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
               mainPanel(
                 plotOutput("graph"),
                 textOutput("stem_analysis")
               )
            )
          ),
    tabPanel("Sources",
       titlePanel("Sources"),
          mainPanel(
            uiOutput("source_data"),
            uiOutput("source_image")
          )
             )
)
))
