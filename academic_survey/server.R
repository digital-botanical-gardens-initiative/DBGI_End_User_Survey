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

setwd("G:/Mon Drive/taf/git_repository/DBGI_End_User_Survey")


rsconnect::setAccountInfo(name='ceco',
			  token='45B5D17A1F097DFC5D32FF87DFB90BA0',
			  secret='Qymrs+aktMObx5fyWJOhLrdjrN+R3LqJwMacQ9w0')

setwd("my/local/dir/") # or set the full path below
rsconnect::deployApp("academic_survey", 
    appName = "academic_survey", 
    account = "ceco") 