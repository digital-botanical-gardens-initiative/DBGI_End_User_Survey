################################################################################
#### Project: DBGI - Shiny App
#### Title:   Academic survey backend
#### Author:  Tom Walker (thomas.walker@unine.ch)
#### Date:    7 June 2023
#### ---------------------------------------------------------------------------


#### PROLOGUE ------------------------------------------------------------------

## Source packages ----
library(shiny)
library(shinysurveys)
library(tidyverse)


#### FORMATTING ----------------------------------------------------------------

## Title ----
title <- "Palmer penguins"
previewImages <- list(
  list(
    previewImageSrc = "images/lter_penguins.png",
    width = 300,
    height = 150
  )
)

# Input types ----
extendInputType("radio_inline", {
  shiny::radioButtons(
    inputId = surveyID(),
    label = surveyLabel(),
    choices = surveyOptions(),
    inline = T
  )
})

extendInputType("check_inline", {
  shiny::checkboxGroupInput(
    inputId = surveyID(),
    label = surveyLabel(),
    choices = surveyOptions(),
    inline = T
  )
})

extendInputType("check", {
  shiny::checkboxGroupInput(
    inputId = surveyID(),
    label = surveyLabel(),
    choices = surveyOptions(),
  )
})


#### QUESTIONS -----------------------------------------------------------------

Q1 <- data.frame(
  question = "What is your research domain?",
  option = "",
  input_type = "text",
  input_id = "Q1",
  dependence = NA,
  dependence_value = NA,
  required = T
)

Q2 <- data.frame(
  question = "How relevant is chemodiversity to your research?",
  option = c("Not at all", "Somewhat", "Very"),
  input_type = "radio_inline",
  input_id = "Q2",
  dependence = NA,
  dependence_value = NA,
  required = T
)

Q3 <- data.frame(
  question = "Would you consider using a chemodiversity platform?",
  option = c("Unsure", "No", "Yes"),
  input_type = "radio_inline",
  input_id = "Q3",
  dependence = NA,
  dependence_value = NA,
  required = T
)

Q3A <- data.frame(
  question = "Can you tell us why not?",
  option = "",
  input_type = "text",
  input_id = "Q3A",
  dependence = "Q3",
  dependence_value = "No",
  required = F
)

Q3B <- data.frame(
  question = "In which capacity would you use such a platform:",
  option = c("Data user", "Data contributor", "Developer"),
  input_type = "check_inline",
  input_id = "Q3B",
  dependence = "Q3",
  dependence_value = "Yes",
  required = T
)

Q4 <- data.frame(
  question = "What type of information would you like to see on a chemodiversity platform?",
  option = c("Chemical structures", "Biological activities", "Taxonomical information", "Ecological information", "Other"),
  input_type = "check",
  input_id = "Q4",
  dependence = NA,
  dependence_value = NA,
  required = F
)

Q4A <- data.frame(
  question = "If other, please specify:",
  option = "",
  input_type = "text",
  input_id = "Q4A",
  dependence = "Q4",
  dependence_value = "Other",
  required = F
)

Q5 <- data.frame(
  question = "How would you prefer to explore data on the platform?",
  option = c("Table", "Search box", "Interactive network", "Interactive map", "Other"),
  input_type = "check",
  input_id = "Q5",
  dependence = NA,
  dependence_value = NA,
  required = F
)

Q5A <- data.frame(
  question = "If other, please specify:",
  option = "",
  input_type = "text",
  input_id = "Q5A",
  dependence = "Q5",
  dependence_value = "Other",
  required = F
)

Q6 <- data.frame(
  question = "Do you already contribute chemodiversity data to an open data service?",
  option = c("No", "Yes"),
  input_type = "radio_inline",
  input_id = "Q6",
  dependence = NA,
  dependence_value = NA,
  required = F
)

Q6A <- data.frame(
  question = "Which open data service do you use?",
  option = "",
  input_type = "text",
  input_id = "Q6A",
  dependence = "Q6",
  dependence_value = "Yes",
  required = F
)

Q7 <- data.frame(
  question = "Should a chemodiversity platform interface directly with existing chemodiversity data sources?",
  option = c("Unsure", "No", "Yes"),
  input_type = "radio_inline",
  input_id = "Q7",
  dependence = NA,
  dependence_value = NA,
  required = F
)

Q8 <- data.frame(
  question = "Should a chemodiversity platform interface directly with other types of open data (e.g. ecological data)?",
  option = c("Unsure", "No", "Yes"),
  input_type = "radio_inline",
  input_id = "Q8",
  dependence = NA,
  dependence_value = NA,
  required = F
)

Q8A <- data.frame(
  question = "Which other sources of open data are most relevant to you?",
  option = "",
  input_type = "text",
  input_id = "Q8A",
  dependence = "Q8",
  dependence_value = "Yes",
  required = F
)


#### BUILD SURVEY --------------------------------------------------------------

## Aggregate questions ----
survey_questions <- tibble(rbind(Q1, Q2, Q3, Q3A, Q3B, Q4, Q4A, Q5, Q5A, Q6, Q6A, Q7, Q8, Q8A))

## Build UI ----
ui <- fluidPage(
  surveyOutput(
    df = survey_questions,
    survey_title = "Digital Botanical Garden Initiative: user expectations",
    survey_description = 
      "We want to build the DBGI in a way that is as useful and intuitive as possible.
       Please use this short survey to tell us about what you wish to be included on a chemodiversity platform.
       Thank you for your participation!"
  )
)

## Build server ----
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

## Test ----
shinyApp(ui, server)
