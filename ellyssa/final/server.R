library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv("data/percent-bachelors-degrees-women-usa.csv") 
data <- as.data.frame(data)

shinyServer(function(input, output) {
   
  output$major_plot <- renderPlot ({
    selected_major <- data[[input$majors]]
    
    plot1 <- ggplot(data)+
      geom_bar(stat = "identity", aes(x = Year , y = selected_major, fill = 'darkblue'))
    
    return(plot1)
    
  })
  
  output$all_majors_plot <- renderPlot ({
    major_names <- select(data, -Year)
   # major_names <- data[1,]
    get_degrees <- data %>% 
        filter(Year == input$date)
    
    plot2 <- ggplot(data) +
        geom_bar(stat = "identity", aes(x = major_names, y = get_degrees))
    
    return(plot2)
  })
  
})
