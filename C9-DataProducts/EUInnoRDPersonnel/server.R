library(shiny)
library(ggplot2)


shinyServer(function(input, output) {
 
  load("SciTechRD_20JUN2015.RData")

  output$indicatorControl <- renderUI({
    indicator_names <- levels(dfr$Indicator)
    
    indicator_names <- indicator_names[-c(1:8,10,11,13:25,27:43)]
    indicator_names <- c("EU Innovation Score - All countries",
                         "Total R&D personnel (FTE) - All countries", 
                         "Evolution Innovation Score - by Country",
                         "Evolution R&D personnel (FTE) - by Country",
                         indicator_names)
    
    selectInput("indicator", 
                label = "Indicator",
                choices = indicator_names, 
                selected = "EU Innovation Score - All countries",
    )   
    
  })
  
  output$countryControl <- renderUI({
    countries <- levels(dfr$Country)
    if (input$indicator == "Evolution Innovation Score - by Country"){
      selectInput("country",
                  label="Country",
                  choices = countries,
                  selected="Germany",
                  multiple=T)
    } else if (input$indicator == "Evolution R&D personnel (FTE) - by Country"){
      selectInput("country",
                  label="Country",
                  choices = countries,
                  selected="China",
                  multiple=T)
    }
    
  })
  
  
  output$yearControl <- renderUI({
    if (input$indicator == "Evolution Innovation Score - by Country" | input$indicator == "Evolution R&D personnel (FTE) - by Country"){
      
    } else if (input$indicator == "EU Innovation Score - All countries"){
      selectInput("year",
                  label="Year",
                  choices=c(2006:2012),
                  selected=2011)
    } else {
      selectInput("year",
                  label="Year",
                  choices=c(1996:2012),
                  selected=2011)
      
    }
  })
  

  
  output$sciPlot <- renderPlot({
    
    #avoid scientific notation; default is 0. 
    options("scipen"=10) 
    
    if (input$indicator == "EU Innovation Score - All countries"){
      df.indicator <- dfr[complete.cases(dfr),]
      df.indicator <- subset(df.indicator, Indicator == "Total R&D personnel (FTE) x Innovation Score" & Time==input$year)
      g <- ggplot(df.indicator, aes(x=reorder(Country, -EUII), y=EUII)) + geom_bar(stat="identity")
      g <- g + theme(axis.text.x = element_text(angle=60, hjust=1, vjust=1)) + xlab("Country") + ylab("Innovation Score")
      
      
    } else if (input$indicator == "Total R&D personnel (FTE) - All countries"){
      df.indicator <- subset(dfr, Indicator == "Total R&D personnel (FTE) x Innovation Score" & Time==input$year)
      g <- ggplot(df.indicator, aes(x=reorder(Country, -ValueFlags), y=ValueFlags)) + geom_bar(stat="identity")
      g <- g + theme(axis.text.x = element_text(angle=60, hjust=1, vjust=1)) + xlab("Country") + ylab("Total R&D Personnel (FTE)")
      
      
    } else if (input$indicator == "Evolution Innovation Score - by Country"){
      df.indicator <- dfr[complete.cases(dfr),]
      df.indicator <- subset(df.indicator, Indicator == "Total R&D personnel (FTE) x Innovation Score" & Country == input$country)
      g <- ggplot(df.indicator, aes(x=Time, y=EUII, colour=Country)) + geom_line()
      g <- g + xlab("Year") + ylab("Innovation Score")
      
      
    } else if (input$indicator == "Evolution R&D personnel (FTE) - by Country"){  
      df.indicator <- subset(dfr, Indicator == "Total R&D personnel (FTE) x Innovation Score" & Country==input$country)
      g <- ggplot(df.indicator, aes(x=Time, y=ValueFlags, colour=Country)) + geom_line()
      g <- g + xlab("Year") + ylab("Total R&D personnel (FTE)")
      
    } else {
      
      df.indicator <- dfr[complete.cases(dfr),]
      df.indicator <- subset(df.indicator, Indicator == input$indicator & Time==input$year)
      
      
      g <- ggplot(df.indicator, aes(x=ValueFlags, y=EUII)) + geom_point()
      #if (input$addLinear) g <- g + stat_smooth(method=lm)
      g <- g + ylim(0,max(1)) + ylab("Innovation Score") + xlab(input$indicator)
      g <- g + geom_text(aes(label=Country), size=5, vjust=1.2, hjust=-.1)
      
      
    }
    
    g
    
  })  
  
  
  
  
})
