library(shiny)
library(ggplot2)
library(dplyr)

setwd("..")
data <- read.csv("data/percent-bachelors-degrees-women-usa.csv",stringsAsFactors = F)

shinyServer(function(input, output){
  
  output$graph <- renderPlot({
    
    
    #c1 <- c("1970", "1970", "1970", "1970", "1970")
    #c2 <- c("2011", "2011", "2011", "2011", "2011")
    
    year1 <- as.character(input$Year1)
    year2 <- as.character(input$Year2)
  
    
    #"input$Year1"だとinput$Year1になる
    c1 <- rep(year1, 5)
    c2 <- rep(year2, 5)
    
    df1 <- data %>% 
      filter(Year == input$Year1) %>% 
      #filter(Year == 1970) %>%
      select(Biology, Computer.Science, Engineering, Math.and.Statistics, Physical.Sciences) 
    
    
   df1.t <- t(df1) %>% 
      as.data.frame()  
    df1.t <- data.frame(major = rownames(df1.t), number = df1.t, row.names = NULL) %>% 
      mutate(Year = c1)
    
    df2 <- data %>% 
      filter(Year == input$Year2) %>%
      #filter(Year == 2011) %>% 
      select(Biology, Computer.Science, Engineering, Math.and.Statistics, Physical.Sciences) 
    
    df2.t <- t(df2) %>% 
      as.data.frame()  
    df2.t <- data.frame(major = rownames(df2.t), number = df2.t, row.names = NULL) %>% 
      mutate(Year = c2)
  
    
      
    dfnew <- bind_rows(df1.t, df2.t)
    
    
    
    graph <-ggplot(dfnew, aes(x = Year, y = V1, fill = major)) +
      #geom_bar(stat = "identity", position = "fill") +
      geom_bar(stat = "identity") +
      ylab("number of people") + 
      theme_bw()
    
    graph
    
  })
})
  

  
  