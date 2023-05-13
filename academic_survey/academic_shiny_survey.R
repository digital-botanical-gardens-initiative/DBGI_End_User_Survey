library(shiny)
library(shinysurveys)
library(dplyr)
library(tidyverse)


title <- "Palmer penguins"
previewImages <- list(
  list(
    previewImageSrc = "images/lter_penguins.png",
    width = 300,
    height = 150
  )
)

 
Q1 <- data.frame(question = "How interested are you in exploring the topic of chemodiversity in life?",
                 option = "Your Answer",
                 input_type = "text",
                 input_id = "Q1",
                 dependence = NA,
                 dependence_value = NA,
                 required = F)


Q2 <- data.frame(question = "How interested are you in exploring the topic of chemodiversity in life?",
                 option = "Your Answer",
                 input_type = "text",
                 input_id = "Q2",
                 dependence = NA,
                 dependence_value = NA,
                 required = F)
  
# Define question in the format of a shinysurvey
Q3 <- data.frame(
  question = "What type of data would you like to see on an online platform exploring chemodiversity?",
  option = c("chemical structures", "biological activities", "ecological information"),
  input_type = "check",
  input_id = "connected data",
  dependence = NA,
  dependence_value = NA,
  required = TRUE
)


# Define question in the format of a shinysurvey
Q4 <- data.frame(
  question = "What type of data would you like to see on an online platform exploring chemodiversity?",
  option = c("chemical structures", "biological activities", "ecological information"),
  input_type = "check",
  input_id = "connected data2",
  dependence = c(NA, NA,"sushi_scale"),
  dependence_value = NA,
  required = TRUE
)

df_question <- data.frame(question = c("On a scale from 1-10, how much do you love sushi?", "On a scale from 1-10, how much do you love sushi?","On a scale from 1-10, how much do you love sushi?","Really", "Really", "Test"),
                              option = c("1", "2", "3", "Yes", "No", NA),
                              input_type = c("checkbox", "checkbox","checkbox","mc", "mc", "text"),
                              input_id = c("sushi_scale", "sushi_scale","sushi_scale","test", "test", "test2"),
                              dependence = c(NA, NA, NA,"sushi_scale", "sushi_scale", "sushi_scale"),
                              dependence_value = c(NA, NA,NA,"1", "1", "2"),
                              required = c(TRUE,TRUE,TRUE, TRUE, TRUE, TRUE))


Q5 <- data.frame(
  question = "Please indicate which",
  option = c("yes","no"),
  input_type = "y/n",
  input_id = "favorite",
  dependence = NA,
  dependence_value = NA,
  required = TRUE
)

survey_questions <- tibble(rbind(Q1,Q2,Q3,Q4,Q5,dep_questions))


ui <- fluidPage(
  surveyOutput(df = survey_questions,
               survey_title = "Digiltal Botanical Garden Initiative: Users expectations",
               survey_description = "Welcome to this survey on user expectations for the DBGI project!,
               DBGI is an innovative platform that enables users to explore the chemical diversity
               of botanical gardens, providing a wide range of data and tools to deepen their 
               understanding of plant biodiversity. As the project is still in its early stages, 
               we are interested in your thoughts and expectations regarding the platform. 
               The purpose of this survey is to gather your expectations as a potential user 
               and the features you would like to see developed.Your feedback will be essential
               in shaping the development of the platform to meet the needs of its users. 
               Thank you in advance for your participation!")
)

server <- function(input, output, session) {
  renderSurvey()
  
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Congrats, you completed your first shinysurvey!",
    ))
    response_data <- getSurveyData()
    print(response_data)
  })


}

shinyApp(ui, server)



