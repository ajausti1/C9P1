library(shiny)
library(ggplot2)

dataset <- mtcars

fluidPage(
  
  titlePanel("MPG Estimator"),
  
  sidebarPanel(
    helpText("Use the weight slider below to set your new car's weight and select how many cylinders your car's engine has to get an estimate of your new
             vehicles MPG!"),
    sliderInput('wt', 'Vehicle Weight', min=1, max=6,
                value=3, step=1, round=0),
    
    selectInput('cyl', 'Cylinders', c('All', levels(as.factor(dataset$cyl)))),
    helpText("Expected MPG for a vehicle with the configured cylinders and weight:"),
    textOutput("estMpg")
  ),
  
  mainPanel(
    plotOutput('plot')
  )
)