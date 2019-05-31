

library(shiny)
library(dplyr)
library(ggplot2)
library(scales)
setwd("..")



df <- read.csv("data/percent-bachelors-degrees-women-usa.csv")

 shinyServer(function(input, output) {
   
   output$pie1 <- renderPlot({
     df <- df %>%
       filter(Year == input$Year1)
     colnms=c("Biology", "Computer.Science", "Engineering", "Math.and.Statistics", "Physical.Sciences")
     df$new_col<-rowSums(df[,colnms])
     colnm=c("Agriculture", "Architecture", "Art.and.Performance", "Business",
             "Communications.and.Journalism", "Education", "English", "Foreign.Languages",
             "Health.Professions", "Psychology", "Public.Administration", "Social.Sciences.and.History")
     df$col<-rowSums(df[,colnm])
     df <- df %>%
       select(new_col, col)
     
     newdf <-  as.data.frame(t(df))
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
     df <- df %>%
       filter(Year == input$Year2)
     colnms=c("Biology", "Computer.Science", "Engineering", "Math.and.Statistics", "Physical.Sciences")
     df$new_col<-rowSums(df[,colnms])
     colnm=c("Agriculture", "Architecture", "Art.and.Performance", "Business",
             "Communications.and.Journalism", "Education", "English", "Foreign.Languages",
             "Health.Professions", "Psychology", "Public.Administration", "Social.Sciences.and.History")
     df$col<-rowSums(df[,colnm])
     df <- df %>%
       select(new_col, col)
     
     newdf <-  as.data.frame(t(df))
     newdf <- data.frame(major = rownames(newdf), number = newdf, row.names = NULL)
     sum <- newdf[1,2] + newdf[2,2]
     p <- ggplot(newdf, aes(x="", y=V1, fill=major))+
       geom_bar(width = 1, stat = "identity") +
       coord_polar("y") + 
       geom_text(aes(y = V1/2 + c(0, cumsum(V1)[-length(V1)]),
                     label = percent(V1/sum)), size=5)
     return(p)
   })
  

})

 
 