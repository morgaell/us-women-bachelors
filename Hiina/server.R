library(shiny)
library(ggplot2)
library(dplyr)

setwd("..")
data <- read.csv("data/percent-bachelors-degrees-women-usa.csv",stringsAsFactors = F)

shinyServer(function(input, output){
  
  output$graph <- renderPlot({
    
    
    #read input$Year as a character
    year3 <- as.character(input$Year1)
    year4 <- as.character(input$Year2)
  
    
    #create a vector of year input1
    c1 <- rep(year3, 5)
    c2 <- rep(year4, 5)
    
    #filter the data by year input and stem major
    df1 <- data %>% 
      filter(Year == input$Year3) %>% 
      #filter(Year == 1970) %>%
      select(Biology, Computer.Science, Engineering, Math.and.Statistics, Physical.Sciences) 
    
    #flip the filtered data  
   df1.t <- t(df1) %>% 
      as.data.frame()  
    df1.t <- data.frame(major = rownames(df1.t), number = df1.t, row.names = NULL) %>% 
      mutate(Year = c1)
    
    #filter the data by second year 
    df2 <- data %>% 
      filter(Year == input$Year4) %>%
      #filter(Year == 2011) %>% 
      select(Biology, Computer.Science, Engineering, Math.and.Statistics, Physical.Sciences) 
    
    #flip the filtered data 
    df2.t <- t(df2) %>% 
      as.data.frame()  
    df2.t <- data.frame(major = rownames(df2.t), number = df2.t, row.names = NULL) %>% 
      mutate(Year = c2)
  
    #combine two datas
    dfnew <- bind_rows(df1.t, df2.t)
    
    #make a bar graph
    graph <-ggplot(dfnew, aes(x = Year, y = V1, fill = major)) +
      #geom_bar(stat = "identity", position = "fill") +
      geom_bar(stat = "identity") +
      ylab("number of people") + 
      theme_bw()
    
    graph
    
  })
})
  

  
  