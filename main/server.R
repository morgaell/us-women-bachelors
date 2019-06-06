library(shiny)
library(dplyr)
library(ggplot2)
library(scales)

data <- read.csv("data/percent-bachelors-degrees-women-usa.csv") 
data <- as.data.frame(data)

shinyServer(function(input, output) {
  
  output$intro <- renderText ({
    introduction <- "The data shown in this application was released by
      the Department of Education Statistic and accessed by our team via kaggle.com, 
      an online community for sharing and exploring data sets. The data that was used 
      contains the percentage of bachelor's degrees earned by women in the United States
      from 1970-2011. The data is broken up into 17 individual degree programs. 
    
      Our target audience includes young women in American who want to pursue a 
      bachelors degree. From this application, young women can find useful information and
      resources about women's history and degree trends. This application allows the user
      to show different aspects of the data to advance their search. The user has the ability
      to research certain majors, years, and analyze data about STEM majors specifically and
      and to observe changes over time."
    
    return(introduction)
  })
  
  ## Bar plot for a given individual major 
  output$major_plot <- renderPlot ({
    # select data from the user input (major)
    selected_major <- data[[input$majors]]
    
    # create bar plot where x = years, y = percentage of degrees
    plot1 <- ggplot(data)+
      geom_bar(stat = "identity", fill = '#ff6666', aes(x = Year , y = selected_major)) +
      ylab("Percentage of Degrees") +
      ggtitle("Degrees by Academic Specialty")
    
    return(plot1)
  })
  
  output$by_degree_analysis <- renderText ({
    para <- "On this page, you can select a major. The graph above 
             will show the general trend for the selected major from 1970 to 2011."
    
    return(para)
  })
  
  ## Bar plot for all majors for a given year
  output$all_majors_plot <- renderPlot ({
    # create new dataframe, select all majors columns
    df <- data.frame(data, row.names = data$Year)
    df <- select(df, -Year)
    
    # flip rows and columns of dataframe
    df <- data.frame(t(df))
    
    # add a column for the degree names
    df <- mutate(df, degrees = row.names(df))
    # take in user input for year
    user_in <- paste0("X", input$date)
    
    # select all major data for the input year
    get_year <- df[[user_in]]
    
    # select all degree names 
    get_major <- df$degrees
    
    # create bar plot where x = all majors, y = percentage of degrees
    plot2 <- ggplot(df) +
        geom_bar(stat = "identity", fill = '#6685ff', aes(x = degrees , y = get_year))+
        theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5)) +
        xlab("Major") +
        ylab("Percentage of Degrees") + 
        ggtitle("Degrees by Year")
    
    return(plot2)
  })
  
  output$all_degrees_analysis <- renderText ({
    para <- "To compare all majors at once, you can choose a year (from 1970 
             to 2011). The graph will show the percentage of women who received 
             bachelors degrees for each major."
  })
  
  #create the first comparing pie charts by dividing all majors into STEM and non-STEM major.
  output$pie1 <- renderPlot({
    
    #filter the dataset
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
    
    #transpose the dataframe
    newdf <-  as.data.frame(t(data))
    newdf <- data.frame(major = rownames(newdf), number = newdf, row.names = NULL)
    sum <- newdf[1,2] + newdf[2,2]
    
    #draw pie chart
    p <- ggplot(newdf, aes(x="", y=V1, fill=major))+
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y") + 
      geom_text(aes(y = V1/2 + c(0, cumsum(V1)[-length(V1)]),
                    label = percent(V1/sum)), size=5)
    
    return(p)
    
  })
  
  #create the second comparing pie charts by dividing all majors into STEM and non-STEM major.
  output$pie2 <- renderPlot({
    
    #filter the dataset
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
    
    #transpose the dataframe
    newdf <-  as.data.frame(t(data))
    newdf <- data.frame(major = rownames(newdf), number = newdf, row.names = NULL)
    sum <- newdf[1,2] + newdf[2,2]
    
    #draw pie chart
    p2 <- ggplot(newdf, aes(x="", y=V1, fill=major))+
      geom_bar(width = 1, stat = "identity") +
      coord_polar("y") + 
      geom_text(aes(y = V1/2 + c(0, cumsum(V1)[-length(V1)]),
                    label = percent(V1/sum)), size=5)
    
    return(p2)
    
  })
  
  output$compare_analysis <- renderText ({
    para <- "For anyone who wants to compare the general trends of STEM and 
             non-STEM majors, this is a good page to explore. On this page, you 
             can select 2 different years to compare. The pie charts show 
             the percentage of STEM and non-STEM majors for those years."
    
    return(para)
  })
  
  output$graph <- renderPlot({
    
    #read input$Year as a character
    year3 <- as.character(input$Year3)
    year4 <- as.character(input$Year4)
    
  
    #create a vector of year input1
    c1 <- rep(year3, 5)
    c2 <- rep(year4, 5)
    
    #filter the data by year input and stem major
    df1 <- data %>% 
      filter(Year == input$Year3) %>% 
      select(Biology, Computer.Science, Engineering, Math.and.Statistics, Physical.Sciences) 
    
    #flip the filtered data 
    df1.t <- t(df1) %>% 
      as.data.frame()  
    df1.t <- data.frame(major = rownames(df1.t), number = df1.t, row.names = NULL) %>% 
      mutate(Year = c1)
    
    #filter the data by second year 
    df2 <- data %>% 
      filter(Year == input$Year4) %>%
      select(Biology, Computer.Science, Engineering, Math.and.Statistics, Physical.Sciences) 
    
    #flip the filtered data 
    df2.t <- t(df2) %>% 
      as.data.frame()  
    df2.t <- data.frame(major = rownames(df2.t), number = df2.t, row.names = NULL) %>% 
      mutate(Year = c2)
    
    #combine two datas
    dfnew <- bind_rows(df1.t, df2.t)
    
    
    #make a bar graph
    graph <- ggplot(dfnew, aes(x = major, y = V1)) +
      geom_bar(stat = "identity", aes(fill = major)) + facet_grid(. ~ Year) +
      ylab("percentage of people in Degrees") + 
      theme_bw() +
      theme(axis.text.x = element_blank())
    
    graph  
  
})
  
  output$stem_analysis <- renderText ({
    para <- "On this page, users can pick two different years and compare the popularity
             of specific STEM majors (Biology, Computer Science, Engineering, Math and Statistics, 
             and Physical Science).
            
             In general, it is not hard to tell that women who chose non STEM majors were more than 
             who chose STEM major. But the popularity is still increasing."
    return(para)
  })
  
  output$source_data <- renderUI ({
    url1 <- a("Bachelor Degree Women USA Dataset", href="https://www.kaggle.com/sureshsrinivas/bachelorsdegreewomenusa")
    return(url1)
  })
  
  output$source_image <- renderUI ({
    url2 <- a("Graduation Photo", href="https://thedailysoiree.files.wordpress.com/2015/05/img_1561.jpg")
    return(url2)
  })
  
})
