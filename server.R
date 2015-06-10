## start shinyServer 
#shinyServer( 
## specify input/output 
#function function(input, output) { 
#  # set x as a reactive function that adds 100 to input1 
#  x <- reactive({as.numeric(input$text1)+100})
#  # set value of x to output object text1 
#  output$text1 <- renderText({x()})
#  # set value of x plus value of input object text2 to output object text1 
#  output$text2 <- renderText({x() + as.numeric(input$text2)})
#} 
#)


# load libraries 
library(shiny) 
require(googleVis) 
# begin shiny server 
shinyServer(function(input, output) { 
  # define reactive parameters 
  cylinders<- reactive({input$cylinders}) 
  gears<- reactive({input$gears}) 
  transmission<- reactive({ifelse(input$transmission, 1, 0)})
  subset1<- reactive({mtcars[which(mtcars$cyl==cylinders()), ]})
  subset2 <- reactive({subset1()[which(subset1()$gear==gears()), ]})
  subset3 <- reactive({subset2()[which(subset2()$am==transmission()), ]})
  # print text through reactive funtion 
  output$MeanMPG <- renderText({ifelse(is.nan(mean(subset3()$mpg)),"
                                       No data available",
                                       mean(subset3()$mpg))}) 
  # google visualization histogram 
  output$popHist <- renderGvis({ 
    popHist <- gvisScatterChart(data.frame(subset3()$wt, subset3()$mpg), options = list( 
      height = "300px", 
      legend = "{position: 'none'}", 
      title = "Miles/(US) gallon distribution", 
      histogram = "{ hideBucketItems: true, bucketSize: 2 }", 
      hAxis = "{ title: 'Weight (lb/1000)', maxAlternation: 1, showTextEvery: 1}", 
      vAxis = "{ title: 'Miles/(US) gallon'}"
    )) 
    return(popHist)
  })
})

