library(shiny)
library(ggplot2)

function(input, output) {
  rWt <- reactive({input$wt})
  rCyl <- reactive({input$cyl})
  
  predictMpg <- reactive({
    setup()
    
    fit <- lm(mpg ~ wt, data = dataset)
    
    # Predict is caching; since this is a toy problem, we just get coef's and slope and do it
    # ourselves.
    intercept <- coef(fit)["(Intercept)"]
    wtCoef <- coef(fit)["wt"]
    intercept + wtCoef * rWt()
  })
  
  setup = function(input) {
    if (rCyl() == "All") {
      dataset <<- mtcars
    } else {
      dataset <<- mtcars[mtcars$cyl == rCyl() ,]
    }
  }
  
  output$estMpg <- renderText({ 
    predictMpg()
    })  
  
  output$plot <- renderPlot({
    setup()
    p <- ggplot(dataset, aes(x=wt, y=mpg)) + geom_point() + geom_vline(xintercept = rWt()) +
      geom_smooth(method = "lm", formula = y ~ x, colour = "red") 
    
    print(p)
  }, height=700)
  
}