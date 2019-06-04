library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv("data/percent-bachelors-degrees-women-usa.csv") 
data <- as.data.frame(data)

shinyServer(function(input, output) {
   
  output$major_plot <- renderPlot ({
    selected_major <- data[[input$majors]]
    
    plot1 <- ggplot(data)+
      geom_bar(stat = "identity", fill = '#b9c6fa', aes(x = Year , y = selected_major)) +
      ylab("Percentage of Degrees") +
      ggtitle("Degrees by Academic Specialty")
    
    return(plot1)
    
  })
  
  output$all_majors_plot <- renderPlot ({
    df <- data.frame(data, row.names = data$Year)
    df <- select(df, -Year)
    df <- data.frame(t(df))
    df <- mutate(df, degrees = row.names(df))
    user_in <- paste0("X", input$date)
    get_year <- df[[user_in]]
    get_major <- df$degrees
    
    plot2 <- ggplot(df) +
        geom_bar(stat = "identity", fill = '#6685ff', aes(x = degrees , y = get_year))+
        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
        xlab("Major") +
        ylab("Percentage of Degrees") + 
        ggtitle("Degrees by Year")
    
    return(plot2)
  })
  
})
