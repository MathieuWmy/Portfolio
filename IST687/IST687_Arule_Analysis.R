# read the dataset
RULE_1<-fread(file="~/Desktop/intro to data/project/dataset/out-201501.csv",select=c(168,194,196,199:227,232))
RULE_2<-fread(file="~/Desktop/intro to data/project/dataset/out-201402.csv",select=c(168,194,196,199:227,232))
RULE_3<-fread(file="~/Desktop/intro to data/project/dataset/out-201403.csv",select=c(168,194,196,199:227,232))
RULE_4<-fread(file="~/Desktop/intro to data/project/dataset/out-201404.csv",select=c(168,194,196,199:227,232))
RULE_5<-fread(file="~/Desktop/intro to data/project/dataset/out-201405.csv",select=c(168,194,196,199:227,232))
RULE_6<-fread(file="~/Desktop/intro to data/project/dataset/out-201406.csv",select=c(168,194,196,199:227,232))
RULE_7<-fread(file="~/Desktop/intro to data/project/dataset/out-201407.csv",select=c(168,194,196,199:227,232))
RULE_8<-fread(file="~/Desktop/intro to data/project/dataset/out-201408.csv",select=c(168,194,196,199:227,232))
RULE_9<-fread(file="~/Desktop/intro to data/project/dataset/out-201409.csv",select=c(168,194,196,199:227,232))
RULE_10<-fread(file="~/Desktop/intro to data/project/dataset/out-201410.csv",select=c(168,194,196,199:227,232))
RULE_11<-fread(file="~/Desktop/intro to data/project/dataset/out-201411.csv",select=c(168,194,196,199:227,232))
RULE_12<-fread(file="~/Desktop/intro to data/project/dataset/out-201412.csv",select=c(168,194,196,199:227,232))

library(arulesViz)

RULEData<-rbind(RULE_1,RULE_2,RULE_3,RULE_4,RULE_5,RULE_6,RULE_7,RULE_8,RULE_9,RULE_10,RULE_11,RULE_12)
summary(RULE_1)

summary(RULEData)

RULERow<-which((RULEData$State_PL=="California") & (RULEData$Type_PL=="Business") & (RULEData$Location_PL=="Urban"))
RULEData1<-RULEData[c(RULERow),]
summary(RULEData1)

RULEData1[,4:33]<-lapply(RULEData1[,4:33],as.factor) # shift character to factor
summary(RULEData1)
RULEData2<-RULEData1[,-c(30,31)] # remove columns with all NAs
summary(RULEData2)
RULEData2[RULEData2==""]<-NA
RULEData3<-na.omit(RULEData2)
View(RULEData3)
summary(RULEData3)

RULEData4<-RULEData3[,c(6,7,10,18,19,21,22,25,29,31)] # select columns with both N and Y responds
summary(RULEData4)
View(RULEData4)

install.packages("arules")
library(arules)
install.packages("arulesViz")
library(arulesViz)
RulesetPro <-apriori(RULEData4,parameter = list(support=0.1, confidence=0.6,minlen=2,maxlen=2),appearance = list(rhs="NPS_Type=Promoter"))
summary(RulesetPro)
inspect(RulesetPro)
# We noticed that with in some rules there are the same support, confidence and lift with different left hand sides

View(RULEData4[Boutique_PL=="N"])
summary(RULEData4[Boutique_PL=="N"])
summary(RULEData4[Boutique_PL=="Y"])

summary(RULEData4[`Spa services in fitness center_PL`=="Y"])

summary(RULEData4[`Mini-Bar_PL`=="N"])
# boutique=business center=convention=regency grand club
# mini bar=outdoor pool

RULEData5<-RULEData3[,c(18,19,25,29,31)]
summary(RULEData5)
View(RULEData5)
# boutique(Y)=limo(Y)  boutique(Y)=mini bar(Y)  boutique(Y)=self parking(N)  boutique(Y)=spa(N)
# limo(Y)=spa(N) mini bar(N)=spa(N)
RulesetPro1 <-apriori(RULEData5,parameter = list(support=0.1, confidence=0.5,minlen=2,maxlen=2),appearance = list(rhs="NPS_Type=Promoter"))
summary(RulesetPro1)
inspect(RulesetPro1)
inspect(sort(RulesetPro1,decreasing=TRUE,by="confidence"))
# by using flag variables, it doesn't make sense.

# change to focus on metric variables
# Because of the fact that we are using the same columns as the regression dataframe,we use the same dataset for the regression data.
RULEData_1<-RegressionData2

summary(RULEData_1)
View(RULEData_1)
RULEData_1<-RULEData_1[,c(2:8,12)]
RULEData_1[,1:7]<-lapply(RULEData_1[,1:7],as.numeric)
str(RULEData_1)

RuleFunction<-function(c)
{
c[c>=1&c<=6]<-"low"
c[c>=7&c<=8]<-"med"
c[c==9|c==10]<-"high"
return(c)
}
RULEData_2<-data.frame(RuleFunction(RULEData_1$Guest_Room_H),RuleFunction(RULEData_1$Tranquility_H),RuleFunction(RULEData_1$Condition_Hotel_H),RuleFunction(RULEData_1$Customer_SVC_H),RuleFunction(RULEData_1$Staff_Cared_H),RuleFunction(RULEData_1$Internet_Sat_H),RuleFunction(RULEData_1$Check_In_H),RULEData_1$NPS_Type)
View(RULEData_2)
colnames(RULEData_2)<-c("Guest Room Satisfaction","Tranquility","Hotel Condition","Customer Service","Staff Cared","Internet","Check in Process","NPS Type")
RulesetPro_1 <-apriori(RULEData_2,parameter = list(support=0.1, confidence=0.5,minlen=2,maxlen=2),appearance = list(rhs="NPS Type=Promoter"))

summary(RulesetPro_1)
inspect(RulesetPro_1)
topConfidencePro<-sort(RulesetPro_1,decreasing=TRUE,by="confidence")
inspect(topConfidencePro)

plot((topConfidencePro), method="graph", control=list(type="items"))

RulesetDet_1<-apriori(RULEData_2,parameter = list(support=0.005, confidence=0.5,minlen=2,maxlen=2),appearance = list(rhs="NPS Type=Detractor"))
summary(RulesetDet_1)
inspect(RulesetDet_1)
topConfidenceDet<-sort(RulesetDet_1,decreasing=TRUE,by="confidence")
inspect(topConfidenceDet)

plot((topConfidenceDet), method="graph", control=list(type="items"))

RulesetPas_1 <-apriori(RULEData_2,parameter = list(support=0.01, confidence=0.5,minlen=2,maxlen=2),appearance = list(rhs="NPS Type=Passive"))
summary(RulesetPas_1)
inspect(RulesetPas_1)
topConfidencePas<-sort(RulesetPas_1,decreasing=TRUE,by="confidence")
inspect(topConfidencePas)

plot((topConfidencePas), method="graph", control=list(type="items"))
# focus on hotel condition, customer service and guest room satisfaction. 