# load shiny package 
library(shiny) 
# begin shiny UI 
shinyUI(navbarPage("Shiny Project", 
    # create first tab 
    tabPanel("Documentation", 
             br(), br(), br(), br(), 
             p("This application calculates the average",strong(" ( mean() )"), " miles per gallon of cars depending on: "), 
             br(),
     # ordered list 
     tags$ol( 
       tags$li("The number of cylinders the car has, it can be selected form 4 to 8"), 
       tags$li("The number of forward gears, it can be selected from 3 to 5"), 
       tags$li("If the transmission is manual or automatic, this can be checked")
     ),br(),br(),
     p("This application run on ",
       strong("Simulation Experiment"), " tab: "), br(),
     p("A graph is shown displaying the miles per gallon depending on the weight of the cars, in the selected group of cars "), 
     p("If no values are available for a certain combination, the text",strong("No data available"), " is displayed ")
     
     ),
   # second tab 
   tabPanel("Simulation Experiment", 
      # fluid row for space holders 
      absolutePanel( 
        # position attributes 
        top = 50, left = 0, right =0, 
        fixed = TRUE, 
        # panel with predefined background 
        sidebarLayout(
          
          # Sidebar with a slider input
          sidebarPanel(
            
            sliderInput("cylinders", "Number of cylinders:", 
                                  min = 4, max = 8, value = 4, step = 2),
            tags$br(),tags$br(),
            
            sliderInput("gears", "Number of forward gears", 
                                  min = 3, max = 5, value = 3, step = 1),
            tags$br(),tags$br(),
            
            strong("Type of transmssion"),
            checkboxInput("transmission", "", 
                                    value = FALSE),
            p("Unchecked = automatic"), p("Checked = manual"),

          style = "opacity: 0.92; z-index: 100;"
          ),
          
          # Show a plot of the generated distribution
          mainPanel(
            tags$br(),tags$br(),
            p(strong("Mean Miles/(US) gallon: "), 
              h3(textOutput("MeanMPG", inline = TRUE))),
          tags$br(),tags$br(),
          tags$br(),tags$br(),
          p(strong("Miles/(US) gallon depending on weight: ")),             
          h3(htmlOutput("popHist"))
        )
        ))
  )
))  