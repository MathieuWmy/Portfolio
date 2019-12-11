# room type analysis

# read the dataset
install.packages("data.table")
library(data.table)
Type_1<-fread(file="~/Desktop/intro to data/project/dataset/out-201501.csv",select=c(11,12,137,168,194,196,232))
Type_2<-fread(file="~/Desktop/intro to data/project/dataset/out-201502.csv",select=c(11,12,137,168,194,196,232))
Type_3<-fread(file="~/Desktop/intro to data/project/dataset/out-201503.csv",select=c(11,12,137,168,194,196,232))
Type_4<-fread(file="~/Desktop/intro to data/project/dataset/out-201504.csv",select=c(11,12,137,168,194,196,232))
Type_5<-fread(file="~/Desktop/intro to data/project/dataset/out-201505.csv",select=c(11,12,137,168,194,196,232))
Type_6<-fread(file="~/Desktop/intro to data/project/dataset/out-201506.csv",select=c(11,12,137,168,194,196,232))
Type_7<-fread(file="~/Desktop/intro to data/project/dataset/out-201507.csv",select=c(11,12,137,168,194,196,232))
Type_8<-fread(file="~/Desktop/intro to data/project/dataset/out-201508.csv",select=c(11,12,137,168,194,196,232))
Type_9<-fread(file="~/Desktop/intro to data/project/dataset/out-201509.csv",select=c(11,12,137,168,194,196,232))
Type_10<-fread(file="~/Desktop/intro to data/project/dataset/out-201510.csv",select=c(11,12,137,168,194,196,232))
Type_11<-fread(file="~/Desktop/intro to data/project/dataset/out-201511.csv",select=c(11,12,137,168,194,196,232))
Type_12<-fread(file="~/Desktop/intro to data/project/dataset/out-201412.csv",select=c(11,12,137,168,194,196,232))
TypeData<-rbind(Type_1,Type_2,Type_3,Type_4,Type_5,Type_6,Type_7,Type_8,Type_9,Type_10,Type_11,Type_12)
# clean the dataset by removing NAs
TypeData[TypeData==""]<-NA
TypeData1<-na.omit(TypeData) # remove NAs
View(TypeData1)
# focus on california urban area business hotels
TypeRow<-which((TypeData1$State_PL=="California") & (TypeData1$Type_PL=="Business") & (TypeData1$Location_PL=="Urban"))
TypeCalBusUrban<-TypeData1[c(TypeRow),]
# sort nps type by room types
l1<-aggregate(TypeCalBusUrban$ROOM_TYPE_DESCRIPTION_C, by=list(TypeCalBusUrban$ROOM_TYPE_DESCRIPTION_C)   ,FUN=length)

pr1<-tapply(TypeCalBusUrban$NPS_Type=="Promoter",TypeCalBusUrban$ROOM_TYPE_DESCRIPTION_C, sum)
pr1<-data.frame(pr1)
pr1<-na.omit(pr1)

de1<-tapply(TypeCalBusUrban$NPS_Type=="Detractor",TypeCalBusUrban$ROOM_TYPE_DESCRIPTION_C, sum)
de1<-data.frame(de1)
de1<-na.omit(de1)

pa1<-tapply(TypeCalBusUrban$NPS_Type=="Passive",TypeCalBusUrban$ROOM_TYPE_DESCRIPTION_C, sum)
pa1<-data.frame(pa1)
pa1<-na.omit(pa1)

score<-aggregate(TypeCalBusUrban$Likelihood_Recommend_H, by=list(TypeCalBusUrban$ROOM_TYPE_DESCRIPTION_C)   ,FUN=mean)
NPS1<-data.frame(l1,pr1,de1,pa1,score$x)
View(NPS1)
NPS1$prr1<-NPS1$pr1/NPS1$x
NPS1$der1<-NPS1$de1/NPS1$x
NPS1$par1<-NPS1$pa1/NPS1$x
NPS1$NPS<-NPS1$prr1-NPS1$der1

colnames(NPS1)<-c("Room_Type","Total_Number","Number_of_Promoter","Number_of_Detractor","Number_of_Passive","LTR_Score","Rate_of_Promoter","Rate_of_Detractor","Rate_of_Passive","NPS")

View(NPS1)

NPS1<-NPS1[NPS1$Total_Number>100,]
View(NPS1)

Data.1 <- ggplot(NPS1) + aes(x=Room_Type, y=Number_of_Promoter) + geom_col(color="red", fill="red") + ggtitle("Number of Promoters by Room Type")
Data.1 <- Data.1 + theme(axis.text.x = element_text(angle=90, hjust = 1))
Data.1

Data.2 <- ggplot(NPS1) + aes(x=Room_Type, y=Number_of_Detractor) + geom_col(color="red", fill="red") + ggtitle("Number of Detracters by Room Type")
Data.2 <- Data.2 + theme(axis.text.x = element_text(angle=90, hjust = 1))
Data.2

Data.3 <- ggplot(NPS1) + aes(x=Room_Type, y=Number_of_Passive) + geom_col(color="red", fill="red") + ggtitle("Number of Passive by Room Type")
Data.3 <- Data.3 + theme(axis.text.x = element_text(angle=90, hjust = 1))
Data.3

NPSsortL<-NPS1[order(NPS1$NPS),]

View(NPSsortL[,c(1,6,10)])

NPSsortH<-NPS1[order(-NPS1$NPS),]

View(NPSsortH[,c(1,6,10)])

NPSsortP<-NPS1[order(NPS1$Rate_of_Promoter),]

View(NPSsortP)

NPSsortD<-NPS1[order(NPS1$Rate_of_Detractor),]

View(NPSsortD )
Rate<- ggplot(data=NPSsortD) +  geom_point(aes(x=Room_Type, y=Rate_of_Promoter,col=Rate_of_Passive,size=Rate_of_Detractor)) +scale_color_gradient(low="light blue",high='dark blue')+scale_size(range = c(3,12)) +ggtitle("Rate of Promoter, Passive and Detractor by Room Type")
Rate<-Rate+theme(axis.text.x = element_text(angle=90, hjust = 1))
Rate

library("ggplot2")
LHR<- ggplot(data=NPSsortL) +  geom_point(aes(x=Room_Type, y=NPS,col=LTR_Score,size=Total_Number)) +scale_size(range=c(8,13))+scale_color_gradient(low="Yellow1",high='grey1') +ggtitle("Likelihood to recommend Room Type")
LHR<-LHR+theme(axis.text.x = element_text(angle=90, hjust = 1))
LHR

