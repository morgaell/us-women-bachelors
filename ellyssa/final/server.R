library(shiny)
library(dplyr)
library(ggplot2)
library(scales)

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
  
  
  output$pie1 <- renderPlot({
    data <- data %>%
      filter(Year == input$Year1)
    
    colnms=c("Biology", "Computer.Science", "Engineering", "Math.and.Statistics", "Physical.Sciences")
    data$stem<-rowSums(data[,colnms])
    colnm=c("Agriculture", "Architecture", "Art.and.Performance", "Business",
            "Communications.and.Journalism", "Education", "English", "Foreign.Languages",
            "Health.Professions", "Psychology", "Public.Administration", "Social.Sciences.and.History")
    data$non_stem<-rowSums(data[,colnm])
    data <- data %>%
      select(stem, non_stem)
    
    newdf <-  as.data.frame(t(data))
    newdf <- data.frame(major = rownames(newdf), number = newdf, row.names = NULL)
    sum <- newdf[1,2] + newdf[2,2]
  
    p <- ggplot(newdf, aes(x="", y=V1, fill=major))+
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y") + 
      geom_text(aes(y = V1/2 + c(0, cumsum(V1)[-length(V1)]),
                    label = percent(V1/sum)), size=5)
    
    return(p)
    
  })
  
  output$pie2 <- renderPlot({
    
    data <- data %>%
      filter(Year == input$Year2)
    
    colnms=c("Biology", "Computer.Science", "Engineering", "Math.and.Statistics", "Physical.Sciences")
    
    data$stem<-rowSums(data[,colnms])
    
    colnm=c("Agriculture", "Architecture", "Art.and.Performance", "Business",
            "Communications.and.Journalism", "Education", "English", "Foreign.Languages",
            "Health.Professions", "Psychology", "Public.Administration", "Social.Sciences.and.History")
    
    data$non_stem<-rowSums(data[,colnm])
    
    data <- data %>%
      select(stem, non_stem)
    
    newdf <-  as.data.frame(t(data))
    
    newdf <- data.frame(major = rownames(newdf), number = newdf, row.names = NULL)
    
    sum <- newdf[1,2] + newdf[2,2]
    
    p2 <- ggplot(newdf, aes(x="", y=V1, fill=major))+
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y") + 
      geom_text(aes(y = V1/2 + c(0, cumsum(V1)[-length(V1)]),
                    label = percent(V1/sum)), size=5)
    
    return(p2)
    
  })
  
})
