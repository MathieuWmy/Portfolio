
RegSvm_1<-fread(file="~/Desktop/intro to data/project/dataset/out-201501.csv",select=c(168,194,196,139,141,142,232))
RegSvm_2<-fread(file="~/Desktop/intro to data/project/dataset/out-201402.csv",select=c(168,194,196,139,141,142,232))
RegSvm_3<-fread(file="~/Desktop/intro to data/project/dataset/out-201403.csv",select=c(168,194,196,139,141,142,232))
RegSvm_4<-fread(file="~/Desktop/intro to data/project/dataset/out-201404.csv",select=c(168,194,196,139,141,142,232))
RegSvm_5<-fread(file="~/Desktop/intro to data/project/dataset/out-201405.csv",select=c(168,194,196,139,141,142,232))
RegSvm_6<-fread(file="~/Desktop/intro to data/project/dataset/out-201406.csv",select=c(168,194,196,139,141,142,232))
RegSvm_7<-fread(file="~/Desktop/intro to data/project/dataset/out-201407.csv",select=c(168,194,196,139,141,142,232))
RegSvm_8<-fread(file="~/Desktop/intro to data/project/dataset/out-201408.csv",select=c(168,194,196,139,141,142,232))
RegSvm_9<-fread(file="~/Desktop/intro to data/project/dataset/out-201409.csv",select=c(168,194,196,139,141,142,232))
RegSvm_10<-fread(file="~/Desktop/intro to data/project/dataset/out-201410.csv",select=c(168,194,196,139,141,142,232))
RegSvm_11<-fread(file="~/Desktop/intro to data/project/dataset/out-201411.csv",select=c(168,194,196,139,141,142,232))
RegSvm_12<-fread(file="~/Desktop/intro to data/project/dataset/out-201412.csv",select=c(168,194,196,139,141,142,232))

RegSvmData<-RegressionData[,c(2,4,9:12)]
summary(RegressionData)
RegSvmData[RegSvmData==""]<-NA
RegSvmData1<-na.omit(RegSvmData)
View(RegSvmData1)

RegSvmRow<-which((RegSvmData1$State_PL=="California") & (RegSvmData1$Type_PL=="Business") & (RegSvmData1$Location_PL=="Urban"))
RegSvmData2<-RegSvmData1[c(RegSvmRow),]
View(RegSvmData2)
summary(RegSvmData2)
RegSvmData2[,3:6]<-lapply(RegSvmData2[,3:6],factor)

randIndex1<-sample(1:dim(RegSvmData2)[1])
summary(randIndex1)

head(randIndex1)
CutPoint2_3<-floor(2*dim(RegSvmData2)[1]/3)
CutPoint2_3

RegTrainData<-RegSvmData2[randIndex1[1:CutPoint2_3],]
RegTrainData<-RegTrainData[,-3:-5]
RegTestData<-RegSvmData2[randIndex1[(CutPoint2_3+1):dim(RegSvmData2)[1]],]
RegTestData<-RegTestData[,-3:-5]

install.packages("kernlab")
library(kernlab)

RegKsvmOutput<-ksvm(NPS_Type~., data=RegTrainData, kernel="rbfdot", kpar="automatic",C=100,cross=10,prob.model=TRUE)
RegKsvmPred<-predict(RegKsvmOutput, RegTestData, type="votes")
RegCompTable<-data.frame(RegTestData[,3],RegKsvmPred[1,])
table(RegCompTable)
# 75.0%


install.packages("e1071")
library(e1071)
install.packages("klaR")
library(klaR)
RegNbModel<-naiveBayes(NPS_Type~.,data=RegTrainData)
RegNbPred<-predict(RegNbModel,RegTestData)
RegTestData$NB_Prediction<-RegNbPred
RegTestData$nb_YesorNot<-ifelse(RegTestData$NPS_Type==RegTestData$NB_Prediction,"Correct","Wrong")
View(RegTestData)
length(which(RegTestData$nb_YesorNot=="Correct"))
Regaccuaracy<-length(which(RegTestData$nb_YesorNot=="Correct"))/length(RegTestData$nb_YesorNot)
Regaccuaracy # 78.1%

RegTestData$Guest_Room_H<-as.numeric(RegTestData$Guest_Room_H)
RegTestData$Condition_Hotel_H<-as.numeric(RegTestData$Condition_Hotel_H)
RegTestData$nb_YesorNot<-as.factor(RegTestData$nb_YesorNot)
RegPlot1<-ggplot(data=RegTestData)+geom_point(aes(x=RegTestData$Guest_Room_H,y=RegTestData$Condition_Hotel_H,color=RegTestData$NPS_Type))
RegPlot2<-ggplot(data=RegTestData)+geom_point(aes(x=RegTestData$Guest_Room_H,y=RegTestData$Condition_Hotel_H,color=RegTestData$NB_Prediction))
RegPlot3<-ggplot(data=RegTestData)+geom_point(aes(x=RegTestData$Guest_Room_H,y=RegTestData$Condition_Hotel_H,color=RegTestData$nb_YesorNot))

length(RegTestData$NPS_Type)

AruleData<-RegressionData[,c(2,4,5,9:12)]
summary(AruleData)
AruleData[AruleData==""]<-NA
AruleData1<-na.omit(AruleData)
View(AruleData1)

AruleSvmRow<-which((AruleData1$State_PL=="California") & (AruleData1$Type_PL=="Business") & (AruleData1$Location_PL=="Urban"))
AruleData2<-AruleData1[c(AruleSvmRow),]
View(AruleData2)
summary(AruleData2)

RuleFunction<-function(c)
{
  c[c>=1&c<=6]<-"low"
  c[c>=7&c<=8]<-"med"
  c[c==9|c==10]<-"high"
  return(c)
}
AruleData3<-data.frame(RuleFunction(AruleData2$Guest_Room_H),RuleFunction(AruleData2$Condition_Hotel_H),RuleFunction(AruleData2$Customer_SVC_H),AruleData2$NPS_Type)
View(AruleData3)
colnames(AruleData3)<-c("Guest Room Satisfaction","Hotel Condition","Customer Service","NPS_Type")

str(AruleData3)
randIndex2<-sample(1:dim(AruleData2)[1])
summary(randIndex2)

head(randIndex2)
CutPoint22_3<-floor(2*dim(AruleData2)[1]/3)
CutPoint22_3

AruleTrainData<-AruleData3[randIndex2[1:CutPoint22_3],]
AruleTestData<-AruleData3[randIndex2[(CutPoint22_3+1):dim(AruleData2)[1]],]


AruleKsvmOutput<-ksvm(NPS_Type~., data=AruleTrainData, kernel="rbfdot", kpar="automatic",C=5,cross=5,prob.model=TRUE)
AruleKsvmPred<-predict(AruleKsvmOutput, AruleTestData, type="votes")
AruleCompTable<-data.frame(AruleTestData[,4],AruleKsvmPred[1,])
table(AruleCompTable) # 79.4%


AruleNbModel<-naiveBayes(NPS_Type~.,data=AruleTrainData)
AruleNbPred<-predict(AruleNbModel,AruleTestData)
AruleTestData$NB_Prediction<-AruleNbPred
AruleTestData$nb_YesorNot<-ifelse(AruleTestData$NPS_Type==AruleTestData$NB_Prediction,"Correct","Wrong")
View(AruleTestData)
Aruleaccuaracy<-length(which(AruleTestData$nb_YesorNot=="Correct"))/length(AruleTestData$nb_YesorNot)
Aruleaccuaracy # 80.0%

NBPro<-length(which(AruleTestData$NB_Prediction=="Promoter"))
NBDet<-length(which(AruleTestData$NB_Prediction=="Detractor"))
NBNPSPre<-(NBPro-NBDet)/length(AruleTestData$NB_Prediction)
