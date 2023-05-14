
library(rsconnect)
rsconnect::setAccountInfo(name='dbgi',
			  token='5DFC4899D8715288776DBCD5C8625186',
			  secret='yg/DQBBV2sQh6CphX7elQaIxypgT2cdDUCBb0E6B')

setwd("G:/Mon Drive/taf/git_repository/DBGI_End_User_Survey")
rsconnect::deployApp("academic_survey", 
    appName = "academic_surveyOnline", 
    account = "dbgi") 