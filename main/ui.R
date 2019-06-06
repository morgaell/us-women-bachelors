library(shiny)
library(dplyr)
library(shinythemes)

# filter all data except year column
majors <- data %>% 
  select(-Year)

# create a list of majors
major_names <- colnames(majors)

# filter years
selected_year <- unique(data$Year)

shinyUI(fluidPage(theme = shinytheme("spacelab"),
  # create a navigation bar at top of app 
  navbarPage("US Women's Bachelors Degrees",
    ## Introduction tab
    tabPanel("Introduction",
      titlePanel("Introduction"), 
      # add graduation image and intro paragraph
      mainPanel(
         img(src='grad.jpg', align = "right"), 
         textOutput("intro")
       )
    ),
    ## Data by degree and year tab
    tabPanel("Data By Degree and Year",
     titlePanel("Data by Degree"),
      sidebarLayout(
        sidebarPanel(
          # allow user to select a major
          selectInput("majors", 
                      label = "Select a Major",
                      choices = major_names),
          # allow user to select a year
          sliderInput("date",
                       "Select a Year",
                       min = 1970,
                       max = 2011,
                       value = 2011,
                       sep = "")
        ),
        mainPanel(
          # plot bar graphs and analysis paragraphs for each
          plotOutput("major_plot"),
          textOutput("by_degree_analysis"),
          plotOutput("all_majors_plot"),
          textOutput("all_degrees_analysis")
        )
      )
    ),
    ## Compare tab
    tabPanel("Compare",
      titlePanel("Compare STEM and Non-STEM Majors"),
      sidebarLayout(
        sidebarPanel(
          # allow user to pick a year 1
          selectInput("Year1",
                      "Choose a year",
                      choices = selected_year,
                      selected = "1970"
          ),
          # allow user to pick a year 2
          selectInput("Year2",
                      "Choose a different year",
                      choices = selected_year,
                      selected = "1971"
          ),
          # insert analysis paragraph for comparison plots
          textOutput("compare_analysis")
        ),
        mainPanel(
          # create two pie charts to compare year 1 and year 2
          fluidRow(
            column(6,plotOutput(outputId="pie1", width="300px",height="300px")),  
            column(6,plotOutput(outputId="pie2", width="300px",height="300px"))
          )
        )
      )       
    ),
    ## STEM tab
    tabPanel("STEM",
        titlePanel("STEM Majors"),
             sidebarLayout(
               sidebarPanel(
                 # allow user to select a year
                 selectInput("Year3",
                             "Choose a year",
                             choices = selected_year,
                             selected = "1970"
                 ),
                 # allow user to select a year to compare
                 selectInput("Year4",
                             "Choose a different year",
                             choices = selected_year,
                             selected = "1971"
                 )
               ),
               mainPanel(
                 # insert comparison bar plots and analysis paragraph
                 plotOutput("graph"),
                 textOutput("stem_analysis")
               )
            )
          ),
    ## Sources tab
    tabPanel("Sources",
       titlePanel("Sources"),
          mainPanel(
            # insert hyperlinks to data and intro image
            uiOutput("source_data"),
            uiOutput("source_image")
          )
    )
)
))
