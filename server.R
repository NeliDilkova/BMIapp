# Function to calculate BMI (body mass index) and hip to waist ratio
# The function calculates the value and gives an indication of where this value lies relative to the generally accepted limits

library(shiny)

shinyServer(function(input, output, session) {

  
  ##### Create the output of the info button ########
  
  observeEvent(input$infobutton,{
    showModal(modalDialog(title = "Help window","This application was created by Neli Dilkova-Gnoyke. 
                          It generates an evaluation of nutritional status based on BMI,
                          following the most recent guidelines of the World Health Organization.
                          Please be aware that BMI is only one of many indicators used in nutritional science.
                          A BMI value outside of the normal values does not automatically mean ill health." ,
                          easyClose = TRUE
                 ))
      })  
  
  ########## Actual BMI calculations ####################
  
  
return_BMI <- eventReactive(input$`Calculate BMI`,{
  
# BMI calculation
  
      bmi_fun <- function(weight, height){
        if(is.na(weight)|| is.na(height)){
          ""
        }else{
         bmi <- weight/((height/100)^2)
         print(bmi)
        }
      }
      
       BMI_calc <- reactive({
         bmi_fun(input$weight, input$height)
      }) # end of BMI calc
  
       output$BMI <- renderText({
         paste("<font color=\"orange\"><b>", "Your BMI is ", BMI_calc(), "</b></font><br/>")
       })
       
       output$recommendation <- renderText({
         if(is.null(BMI_calc())){
           "Please enter all requested values"
         } else {
           if(BMI_calc() <= 18.5){
             "Your BMI indicates underweight"
           } else if(BMI_calc() > 18.5 && BMI_calc() <= 24.9){
             "Your BMI indicates normal weight"
           } else if(BMI_calc() > 24.9 && BMI_calc() <= 34.9){
             "Your BMI indicates overweight"
           } else if(BMI_calc() > 34.9){
             "Your BMI indicates strong overweight"
           }
         }
       }) #end of output$recommendation
       
# Evaluation of waist circumfence
       
      waisteval_fun <- function(sex, waist){
        if((sex == 'female' && waist > 88) || (sex == 'male' && waist > 102)){
          "Your waist circumfence indicates increased risk of cardiovascular deiseases due to obesity."
        } else {
          "Your waist circumfence does not indicate any incresed risk of cardiovascular diseases due to obesity."
        }
      }
    
      waisteval <- reactive({
        waisteval_fun(input$sex, input$waist)
      })    

      output$waisteval <- renderText({
        if(waisteval() == ""){
          "Please enter all requested values"
        } else  paste(waisteval())
      }) # end of output$waisteval
      
      

  }) # end event reactive function
 

output$BMI <- renderText({
  return_BMI()$output
 
})





})