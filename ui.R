# UI to BMI app

library(shiny)
shinyUI(fluidPage(
  titlePanel("BMI calculator"),
  br(),
  h4("This app calculates your BMI and reports its interpretation according to the standards of the World Health Organization"),
  br(),
  h5("Please enter all requested values and then press the button 'Calculate my BMI'"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput('height', 'please enter your height in cm', 100, min = 1, max = 300),
      numericInput('weight', 'please enter your weight in kg', 50, min = 1, max = 300 ),
      numericInput('waist', 'please enter your waist circumference in cm', 50, min = 1, max = 300),
      selectInput('sex', 'please select your sex:', choices = c("male", "female")),
      
      actionButton("infobutton",label = "info",icon = icon("info-circle")),
      
      actionButton("Calculate BMI", "Calculate my BMI")
    
      ),
    
    mainPanel(
 
      br(),
      htmlOutput("BMI"),
      br(),
     htmlOutput("recommendation"),
     br(),
     htmlOutput("waisteval")
   
      
      )
    )
  )
)