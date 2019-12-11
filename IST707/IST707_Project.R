H1B_Data<-read.csv("~/Desktop/IST 707/Project/H1B Data.csv",na.strings=c(""," ","NA"))
H1B_Data_1<-H1B_Data
H1B_Data_1$Decision_Duration<-as.Date(as.character(H1B_Data_1$DECISION_DATE),format="%m/%d/%Y")-as.Date(as.character(H1B_Data_1$CASE_SUBMITTED),format="%m/%d/%Y")
H1B_Data_1$Length_of_Contract<- difftime(as.Date(as.character(H1B_Data_1$EMPLOYMENT_END_DATE),format="%m/%d/%Y"),as.Date(as.character(H1B_Data_1$EMPLOYMENT_START_DATE),format="%m/%d/%Y"),units = "weeks")/52.25

H1B_Data_2<-H1B_Data_1[,-c(3,4,6:11,13,15:17,19:21,23,27:32,37:42,45:49,51,52)]
H1B_Data_3<-H1B_Data_2[which(H1B_Data_2$EMPLOYER_COUNTRY=="UNITED STATES OF AMERICA"),]
H1B_Data_3<-H1B_Data_3[which(H1B_Data_3$VISA_CLASS=="H-1B"),]
H1B_Data_3<-na.omit(H1B_Data_3)
# original data set summary
summary(H1B_Data_5$CASE_STATUS)
summary(H1B_Data_1$PW_UNIT_OF_PAY)
summary(H1B_Data_3$NAICS_CODE)
str(H1B_Data_3$PREVAILING_WAGE)
1-7470/(7470+566976)
# Arule
# preprocessing
H1B_Data_3$NAICS_CODE<-as.factor(H1B_Data_3$NAICS_CODE)
H1B_Data_3$Length_of_Contract<-as.numeric(H1B_Data_3$Length_of_Contract)
H1B_Data_3$Decision_Duration<-as.numeric(H1B_Data_3$Decision_Duration)
H1B_Data_3$Length_of_Contract_F<-cut(H1B_Data_3$Length_of_Contract,breaks= seq(0,3,1),labels=c("within 1 year", "1 to 2 years", "2 to 3 years"))
H1B_Data_3$Decision_Duration_F<- cut(H1B_Data_3$Decision_Duration, breaks = c(-Inf,0,7,30,180,365,730,Inf),labels = c("0 day","within 1 week","1 week to 1 month","1 month to half a year","half a year to 1 year","1 year to 2 years","more than 2 years"))

H1B_Data_4<-H1B_Data_3[c(which(H1B_Data_3$CASE_STATUS=="CERTIFIED"),which(H1B_Data_3$CASE_STATUS=="DENIED")),]
H1B_Data_4$NAICS_CODE<-substr(H1B_Data_4$NAICS_CODE,1,4)
View(H1B_Data_4)
H1B_Data_4$NAICS_CODE<-as.factor(H1B_Data_4$NAICS_CODE)
str(H1B_Data_4$PREVAILING_WAGE)
View(H1B_Data_4$PREVAILING_WAGE)
levels(H1B_Data_4$PREVAILING_WAGE)

H1B_Data_4$PREVAILING_WAGE<-as.character(H1B_Data_4$PREVAILING_WAGE)
H1B_Data_4$PREVAILING_WAGE<-as.numeric(H1B_Data_4$PREVAILING_WAGE)

H1B_Data_4$AnnualIncome<-ifelse(H1B_Data_4$PW_UNIT_OF_PAY =="Year",H1B_Data_4$PREVAILING_WAGE,ifelse(H1B_Data_4$PW_UNIT_OF_PAY =="Month",(H1B_Data_4$PREVAILING_WAGE)*12,ifelse(H1B_Data_4$PW_UNIT_OF_PAY =="Week",(H1B_Data_4$PREVAILING_WAGE)*52,ifelse(H1B_Data_4$PW_UNIT_OF_PAY =="Hour",(H1B_Data_4$PREVAILING_WAGE)*9*5*52,(H1B_Data_4$PREVAILING_WAGE*26)))))
View(H1B_Data_4)
summary(H1B_Data_4$AnnualIncome)
H1B_Data_4$IncomeLevel<-cut(H1B_Data_4$AnnualIncome,breaks = c(-Inf,20000,50000,80000,100000,150000,200000,500000,Inf),labels = c("Less than 20k","20k-50k","50k-80k","80k-100k","100k-150k","150k-200k","200k-500k","Above 500k"))
H1B_Data_5<-H1B_Data_4[,c(2,4,6,8,9,14:17,20,21,23)]
View(H1B_Data_5)
H1BTrain<-H1B_Data_5
H1BTrain$NAICS_CODE<-as.factor(H1BTrain$NAICS_CODE)
str(H1BTrain$NAICS_CODE)
write.csv(H1BTrain,'e.csv')

View(H1BTrain)
install.packages("arules")
library("arules")
install.packages("arulesViz")
library("arulesViz")
RulesetApproved<-apriori(H1B_Data_5[which(H1B_Data_5$WORKSITE_STATE =="NY"),c(1,3:8,10:12)], parameter = list(support = 0.2, confidence = 0.987,minlen =2, maxlen = 2),appearance = list(rhs = "CASE_STATUS=CERTIFIED"))
goodApprovedRules<-RulesetApproved[quality(RulesetApproved)$lift>1]
inspect(goodApprovedRules)
summary(H1B_Data_4$CASE_STATUS)
RulesetDenied<-apriori(H1B_Data_5[which(H1B_Data_5$WORKSITE_STATE =="NY"),c(1,3:8,10:12)], parameter = list(support = 0.0001, confidence = 0.1,maxlen=2),appearance = list(rhs = "CASE_STATUS=DENIED"))
RulesetDenied
inspect(RulesetDenied)
goodDeniedRules<-RulesetDenied[quality(RulesetDenied)$lift>2]
goodDeniedRules
inspect(goodDeniedRules)

length(which(H1B_Data_4$NAICS_CODE=="6117"))


# descriptive analysis
# 1
rateByGroup<-function(category)
{
app_1<-tapply(H1B_Data_5$CASE_STATUS=="CERTIFIED",H1B_Data_5[,c(category)], sum)
app_1<-data.frame(app_1)
den_1<-tapply(H1B_Data_5$CASE_STATUS=="DENIED",H1B_Data_5[,c(category)], sum)
den_1<-data.frame(den_1)
employer_state<-data.frame(app_1,den_1)
employer_state$appRate<-employer_state$app_1/(employer_state$app_1+employer_state$den_1)
employer_state$denRate<-employer_state$den_1/(employer_state$app_1+employer_state$den_1)
employer_state<-cbind(rownames(employer_state),employer_state)
rownames(employer_state)<-NULL
colnames(employer_state)<-c("Group By","# of approved case","# of denied case","Approved rate","Denied rate")
employer_state<-employer_state[which(employer_state$`# of denied case`>=10),]
return(employer_state)
}
View(rateByGroup("NAICS_CODE"))
View(rateByGroup("SOC_NAME"))

library(shiny)
library(DT)
if (interactive()) {
  ui <- fluidPage(
    h3("Check the approved rate by category"),
    column(12,
           textInput("x", "Group by"),
           br(),
           actionButton("button", "Show")
    ),
    column(8, DTOutput("table"))
  )
  server <- function(input, output) {
    observeEvent(input$button, {})
    df <- eventReactive(input$button, {
      data.frame(rateByGroup(input$x))
    })
    output$table <- renderDT({
      df()
    })
  }
  shinyApp(ui=ui, server=server)
}



# 2
RateBy2Group<-function(GivenCategory,value,Sortby)
{
H1B_Data_6<-H1B_Data_4[which(H1B_Data_4[,c(GivenCategory)]==value),]
app_3<-tapply(H1B_Data_6$CASE_STATUS=="CERTIFIED",H1B_Data_6[,c(Sortby)], sum)
app_3<-data.frame(app_3)
den_3<-tapply(H1B_Data_6$CASE_STATUS=="DENIED",H1B_Data_6[,c(Sortby)], sum)
den_3<-data.frame(den_3)
employer_state_11<-data.frame(app_3,den_3)
employer_state_11$appRate<-employer_state_11$app_3/(employer_state_11$app_3+employer_state_11$den_3)
employer_state_11$denRate<-employer_state_11$den_3/(employer_state_11$app_3+employer_state_11$den_3)
employer_state_11<-cbind(rownames(employer_state_11),employer_state_11)
rownames(employer_state_11)<-NULL
colnames(employer_state_11)<-c("Group by","# of approved case","# of denied case","Approved rate","Denied rate")
return(employer_state_11)
}
View(RateBy2Group("EMPLOYER_STATE","CA","NAICS_CODE"))

if (interactive()) {
  ui <- fluidPage(
    h3("Check the approved rate by category"),
    column(12,
           textInput("x","Select Category"),
           textInput("y","Category"),
           textInput("z", "Group by"),
           br(),
           actionButton("button", "Show")
    ),
    column(8, DTOutput("table"))
  )
  server <- function(input, output) {
    observeEvent(input$button, {})
    df <- eventReactive(input$button, {
      data.frame(RateBy2Group(input$x,input$y,input$z))
    })
    output$table <- renderDT({
      df()
    })
  }
  shinyApp(ui=ui, server=server)
}

df("EMPLOYER_STATE")
# 4
app_111<-tapply(H1B_Data_5$CASE_STATUS=="CERTIFIED",H1B_Data_5$SOC_NAME, sum)
app_111<-data.frame(app_111)
den_111<-tapply(H1B_Data_5$CASE_STATUS=="DENIED",H1B_Data_5$SOC_NAME, sum)
den_111<-data.frame(den_111)
employer_state_111<-data.frame(app_111,den_111)
employer_state_111$appRate<-employer_state_111$app_111/(employer_state_111$app_111+employer_state_111$den_111)
employer_state_111$denRate<-employer_state_111$den_111/(employer_state_111$app_111+employer_state_111$den_111)
View(employer_state_111)
employer_state_111<-cbind(rownames(employer_state_111),employer_state_111)
rownames(employer_state_111)<-NULL
colnames(employer_state_111)<-c("SOC_Name","# of approved case","# of denied case","Approved rate","Denied rate")

NaicsApproved<-apriori(H1B_Data_5[which(H1B_Data_5$SOC_NAME =="SOFTWARE DEVELOPERS, APPLICATIONS"),c(1,2,5:12)], parameter = list(support = 0.1, confidence = 0.987,minlen =2, maxlen = 2),appearance = list(rhs = "CASE_STATUS=CERTIFIED"))
goodNaicsApproved<-NaicsApproved[quality(NaicsApproved)$lift>1]
inspect(goodNaicsApproved)
summary(H1B_Data_4$CASE_STATUS)
NaicsDenied<-apriori(H1B_Data_5[which(H1B_Data_5$SOC_NAME =="SOFTWARE DEVELOPERS, APPLICATIONS"),c(1,2,5:12)], parameter = list(support = 0.000005, confidence = 0.1,maxlen=2),appearance = list(rhs = "CASE_STATUS=DENIED"))
NaicsDenied
inspect(NaicsDenied)


# Prediction
randIndex<-sample(1:dim(H1BTrain)[1])
cutPoint2_3<-floor(2*dim(H1BTrain)[1]/3)
H1BTrain_1<-H1BTrain[randIndex[1:cutPoint2_3],]
H1BTest<-H1BTrain[randIndex[(cutPoint2_3+1):dim(H1BTrain)[1]],]

install.packages("e1071")
library(e1071)
install.packages("klaR")
library(klaR)
H1BNbModel<-naiveBayes(CASE_STATUS~., data = H1BTrain_1)
H1BNbPred<-predict(H1BNbModel,H1BTest)
H1BTest$NB_Prediction<-H1BNbPred
H1BTest$nb_YesorNot<-ifelse(H1BTest$CASE_STATUS==H1BTest$NB_Prediction,"Correct","Wrong")
NbAcc<-length(which(H1BTest$nb_YesorNot=="Correct"))/length(H1BTest$nb_YesorNot)
View(H1BTrain_1)
summary(H1BNbPred)
H1BSvmModel<-svm(CASE_STATUS~., data = H1BTrain_1)
H1BSvmPred<-predict(H1BSvmModel,H1BTest)
H1BTest$NB_Prediction<-H1BSvmPred
H1BTest$nb_YesorNot<-ifelse(H1BTest$CASE_STATUS==H1BTest$NB_Prediction,"Correct","Wrong")
SvmAcc<-length(which(H1BTest$nb_YesorNot=="Correct"))/length(H1BTest$nb_YesorNot)
summary(H1BSvmPred)

H1BTrain_2<-H1BTrain_1[,c(1:7,9,10,12)]
H1BTest_2<-H1BTest[,c(1:7,9,10,12)]
H1BNbModel_2<-naiveBayes(CASE_STATUS~., data = H1BTrain_2)
H1BNbPred_2<-predict(H1BNbModel_2,H1BTest_2)
H1BTest_2$NB_Prediction<-H1BNbPred_2
View(H1BTest_2)
H1BTest_2$nb_YesorNot<-ifelse(H1BTest_2$CASE_STATUS==H1BTest_2$NB_Prediction,"Correct","Wrong")
NbAcc_2<-length(which(H1BTest_2$nb_YesorNot=="Correct"))/length(H1BTest_2$nb_YesorNot)
summary(H1BTest_2$CASE_STATUS)
188969/(188969+2514)



View(List)
List<-rateByGroup("NAICS_CODE")[(which(rateByGroup("NAICS_CODE")$`Approved rate`<0.95)),1]
na.omit(match(H1BTrain$NAICS_CODE,List))

H1BTrain_<-H1BTrain[H1B_Data_5$NAICS_CODE %in% List,]
H1BTrain_clean<-H1BTrain_[,c(1,4,5,6,7,12)]
H1BTrain_clean<-H1BTrain_clean[,c(1,3,4,5,6,7,9,10)]
View(H1BTrain_clean)
randIndex_2<-sample(1:dim(H1BTrain_clean)[1])
cutPoint2_3_2<-floor(2*dim(H1BTrain_clean)[1]/3)
H1BTrain_3<-H1BTrain_clean[randIndex_2[1:cutPoint2_3_2],]
H1BTest_3<-H1BTrain_clean[randIndex_2[(cutPoint2_3_2+1):dim(H1BTrain_clean)[1]],]
write.csv(H1BTrain_3,'H1BTrain_3 SOC.csv')
write.csv(H1BTest_3,'H1BTest_3 SOC.csv')
write.csv(H1BTrain_clean,'H1BData NAICS.csv')
View(H1BTest_3)

H1BNbModel_3<-naiveBayes(CASE_STATUS~., data = H1BTrain_3)
H1BNbPred_3<-predict(H1BNbModel_3,H1BTest_3)
H1BTest_3$NB_Prediction<-H1BNbPred_3
H1BTest_3$nb_YesorNot<-ifelse(H1BTest_3$CASE_STATUS==H1BTest_3$NB_Prediction,"Correct","Wrong")
NbAcc_3<-length(which(H1BTest_3$nb_YesorNot=="Correct"))/length(H1BTest_3$nb_YesorNot)
summary(H1BTest_3$CASE_STATUS)
602/(621+51)

H1BSvmModel_3<-svm(CASE_STATUS~., data = H1BTrain_3,method="C-classification", kernel= 'linear', C=10)
H1BSvmPred_3<-predict(H1BSvmModel_3,H1BTest_3)
H1BTest_3$Svm_Prediction<-H1BSvmPred_3
H1BTest_3$svm_YesorNot<-ifelse(H1BTest_3$CASE_STATUS==H1BTest_3$Svm_Prediction,"Correct","Wrong")
SvmAcc_3<-length(which(H1BTest_3$svm_YesorNot=="Correct"))/length(H1BTest_3$svm_YesorNot)
View(H1BTest_3)

library(rpart)
H1BDtModel_3<-rpart(CASE_STATUS~., data = H1BTrain_3,method="class")
H1BDtPred_3<-predict(H1BDtModel_3,H1BTest_3)

