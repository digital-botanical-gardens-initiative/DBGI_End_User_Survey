library(shiny)
library(shinysurveys)
library(tidyverse)


title <- "Palmer penguins"
previewImages <- list(
  list(
    previewImageSrc = "images/lter_penguins.png",
    width = 300,
    height = 150
  )
)

extendInputType("check", {
  shiny::checkboxGroupInput(
    inputId = surveyID(),
    label = surveyLabel(),
    choices = surveyOptions(),
  )
})

extendInputType("checkbox", {
  shiny::checkboxGroupInput(
    inputId = surveyID(),
    label = surveyLabel(),
    choices = surveyOptions(),
  )
})

 
Q1 <- data.frame(question = "What is your area of research?",
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
  option = c("feature table","spectra","chemical structures", "biological activities", "ecological information"),
  input_type = "check",
  input_id = "data type",
  dependence = c(NA,NA,NA,NA,NA),
  dependence_value = NA,
  required = TRUE
)


Q5  <- data.frame(
  stringsAsFactors = FALSE,
  question = c("How would you like to be able to search for data?",
               "How would you like to be able to search for data?",
               "How would you like to be able to search for data?",
               "How would you like to be able to search for data?",
               "How would you like to be able to search for data?",
               "other sugestion?"),
  option = c("dataframe","search tools","interactive network","interactive maps","other sugestion",NA),
  input_type = c("check","check","check",
                 "check","check","text"),## check or mc
  input_id = c("search","search","search",
               "search","search","self_describe_search"),
  dependence = c(NA,NA,NA,NA,NA,"search"),
  dependence_value = c(NA,NA,NA,NA,NA,
                       "other sugestion"),
  required = c(FALSE,FALSE,FALSE,FALSE,FALSE,
               FALSE)
)

Q6  <- data.frame(
  stringsAsFactors = FALSE,
  question = c("Would you be interested in contributing data to an online platform exploring chemodiversity?",
               "Would you be interested in contributing data to an online platform exploring chemodiversity?",
               "If yes, what type of data would you be willing to contribute?"),
  option = c("No","Yes",NA),
  input_type = c("mc","mc","text"),## check or mc
  input_id = c("share","share","self_describe_share"),
  dependence = c(NA,NA,"share"),
  dependence_value = c(NA,NA,"Yes"),
  required = c(FALSE,FALSE,FALSE)
)


# Define question in the format of a shinysurvey
Q7 <- data.frame(
  question = "How important is it for an online platform exploring chemodiversity to connect with existing open data sources?
",
  option = c("High", "Moderate", "Low","None"),
  input_type = "mc",
  input_id = "connected sources",
  dependence = c(NA, NA,NA,NA),
  dependence_value = NA,
  required = TRUE
)



Q8 <- data.frame(
  question = "Would you be willing to contribute your own data to existing open data sources related to chemodiversity?",
  option = c("yes","no"),
  input_type = "y/n",
  input_id = "favorite",
  dependence = NA,
  dependence_value = NA,
  required = TRUE
)

survey_questions <- tibble(rbind(Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8))


ui <- fluidPage(
  surveyOutput(df = survey_questions,
               survey_title = "Digiltal Botanical Garden Initiative: Users expectations",
               survey_description = "Welcome to this survey on user expectations for the DBGI project!
              As the project is still in its early stages, 
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
