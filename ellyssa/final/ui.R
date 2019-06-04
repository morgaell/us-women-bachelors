library(shiny)

majors <- data %>% 
  select(-Year)

major_names <- colnames(majors)

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
    )
  )
))