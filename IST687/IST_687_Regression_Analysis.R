# regression model analysis

# read the data
Regression_1<-fread(file="~/Desktop/intro to data/project/dataset/out-201501.csv",select=c(137,139:145,168,194,196,232))
Regression_2<-fread(file="~/Desktop/intro to data/project/dataset/out-201402.csv",select=c(137,139:145,168,194,196,232))
Regression_3<-fread(file="~/Desktop/intro to data/project/dataset/out-201403.csv",select=c(137,139:145,168,194,196,232))
Regression_4<-fread(file="~/Desktop/intro to data/project/dataset/out-201404.csv",select=c(137,139:145,168,194,196,232))
Regression_5<-fread(file="~/Desktop/intro to data/project/dataset/out-201405.csv",select=c(137,139:145,168,194,196,232))
Regression_6<-fread(file="~/Desktop/intro to data/project/dataset/out-201406.csv",select=c(137,139:145,168,194,196,232))
Regression_7<-fread(file="~/Desktop/intro to data/project/dataset/out-201407.csv",select=c(137,139:145,168,194,196,232))
Regression_8<-fread(file="~/Desktop/intro to data/project/dataset/out-201408.csv",select=c(137,139:145,168,194,196,232))
Regression_9<-fread(file="~/Desktop/intro to data/project/dataset/out-201409.csv",select=c(137,139:145,168,194,196,232))
Regression_10<-fread(file="~/Desktop/intro to data/project/dataset/out-201410.csv",select=c(137,139:145,168,194,196,232))
Regression_11<-fread(file="~/Desktop/intro to data/project/dataset/out-201411.csv",select=c(137,139:145,168,194,196,232))
Regression_12<-fread(file="~/Desktop/intro to data/project/dataset/out-201412.csv",select=c(137,139:145,168,194,196,232))

RegressionData<-rbind(Regression_1,Regression_2,Regression_3,Regression_4,Regression_5,Regression_6,Regression_7,Regression_8,Regression_9,Regression_10,Regression_11,Regression_12)

# clean the dataset by removing NAs
RegressionData[RegressionData==""]<-NA
RegressionData1<-na.omit(RegressionData) 
View(RegressionData1)

RegressionRow<-which((RegressionData1$State_PL=="California") & (RegressionData1$Type_PL=="Business") & (RegressionData1$Location_PL=="Urban"))
RegressionData2<-RegressionData1[c(RegressionRow),]
View(RegressionData2)

RegressionData2$Promoter<-0
ProRow1<-which((RegressionData2$NPS_Type)=="Promoter")
RegressionData2$Promoter[c(ProRow1)]<-1

RegressionData2$Detractor<-0
DetRow1<-which((RegressionData2$NPS_Type)=="Detractor")
RegressionData2$Detractor[c(DetRow1)]<-1

install.packages("mfx") 
library(mfx)

Lin1<-lm(formula=RegressionData2$Likelihood_Recommend_H~RegressionData2$Guest_Room_H+RegressionData2$Tranquility_H+RegressionData2$Condition_Hotel_H+RegressionData2$Customer_SVC_H+RegressionData2$Staff_Cared_H+RegressionData2$Internet_Sat_H+RegressionData2$Check_In_H, data=RegressionData2)
summary(Lin1)

ProbPro<-glm(RegressionData2$Promoter~RegressionData2$Guest_Room_H+RegressionData2$Tranquility_H+RegressionData2$Condition_Hotel_H+RegressionData2$Customer_SVC_H+RegressionData2$Staff_Cared_H+RegressionData2$Internet_Sat_H+RegressionData2$Check_In_H, family=binomial(link="probit"),data=RegressionData2)
summary(ProbPro)
install.packages("pseudo")
library(pseudo)
install.packages("BaylorEdPsych")
library(BaylorEdPsych)
PseudoR2(ProbPro)
ProbProMfx<-probitmfx(RegressionData2$Promoter~RegressionData2$Guest_Room_H+RegressionData2$Tranquility_H+RegressionData2$Condition_Hotel_H+RegressionData2$Customer_SVC_H+RegressionData2$Staff_Cared_H+RegressionData2$Internet_Sat_H+RegressionData2$Check_In_H,data=RegressionData2,
                      atmean=TRUE, robust=TRUE)
ProbProMfx
coefplot(ProbPro)
ProbDet<-glm(RegressionData2$Detractor~RegressionData2$Guest_Room_H+RegressionData2$Tranquility_H+RegressionData2$Condition_Hotel_H+RegressionData2$Customer_SVC_H+RegressionData2$Staff_Cared_H+RegressionData2$Internet_Sat_H+RegressionData2$Check_In_H, family=binomial(link="probit"),data=RegressionData2)
PseudoR2(ProbDet)
ProbDetMfx<-probitmfx(RegressionData2$Detractor~RegressionData2$Guest_Room_H+RegressionData2$Tranquility_H+RegressionData2$Condition_Hotel_H+RegressionData2$Customer_SVC_H+RegressionData2$Staff_Cared_H+RegressionData2$Internet_Sat_H+RegressionData2$Check_In_H,data=RegressionData2,
                      atmean=TRUE, robust=TRUE)
ProbDetMfx

# focus more on guest room condition and customer service

