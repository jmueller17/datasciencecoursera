library(shiny)

shinyUI(fluidPage(
  titlePanel("EU Innovation Scoreboard and investments in R&D Personnel"),

  fluidRow(
    column(12,
      p(HTML("This interactive Shiny application provides a simple explorer of the EU Innovation Scoreboard data vs Research and Development Personnel across certain countries. Two datasets were combined in a preprocessing step; first the UNESCO Science, Technology and Innovation indicator (<a href='http://data.uis.unesco.org/index.aspx?queryid=63&lang=en' target='_blank'>available here</a>) and the EU Innovation Scoreboard data (<a href='http://ec.europa.eu/enterprise/policies/innovation/files/ius/ius-2014-database_en.xlsx' target='_blank'>available here</a>).")),
      p(HTML("<strong>Instructions:</strong><br>Choose different indicators and select supporting dimensions such as 'Year' or 'Country'. The application will the redraw the corresponding plots. For the time series indicators you can add as many countries as desired.<br><br>
          Years and countries do not coincide between both datasets. The EU Innovation Scoreboard data only spans EU countries from 2006 until 2013 whereas the UNESCO data spans many additional countries outside the EU and more years (1996-2012)."))
           )
    ),
  
  fluidRow(
    column(2,
      uiOutput("yearControl")     
            ),
    
    column(8,
      uiOutput("indicatorControl")       
           ),
    column(2,
      uiOutput("countryControl")
          )
    ),
  
  fluidRow(
    column(10,
      plotOutput("sciPlot")           
           )
    
    )

  



))
