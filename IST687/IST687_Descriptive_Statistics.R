install.packages("data.table")
library(data.table)

DS_1<-fread(file="~/Desktop/intro to data/project/dataset/out-201501.csv",select=c(168,194,196,232))
DS_2<-fread(file="~/Desktop/intro to data/project/dataset/out-201402.csv",select=c(168,194,196,232))
DS_3<-fread(file="~/Desktop/intro to data/project/dataset/out-201403.csv",select=c(168,194,196,232))
DS_4<-fread(file="~/Desktop/intro to data/project/dataset/out-201404.csv",select=c(168,194,196,232))
DS_5<-fread(file="~/Desktop/intro to data/project/dataset/out-201405.csv",select=c(168,194,196,232))
DS_6<-fread(file="~/Desktop/intro to data/project/dataset/out-201406.csv",select=c(168,194,196,232))
DS_7<-fread(file="~/Desktop/intro to data/project/dataset/out-201407.csv",select=c(168,194,196,232))
DS_8<-fread(file="~/Desktop/intro to data/project/dataset/out-201408.csv",select=c(168,194,196,232))
DS_9<-fread(file="~/Desktop/intro to data/project/dataset/out-201409.csv",select=c(168,194,196,232))
DS_10<-fread(file="~/Desktop/intro to data/project/dataset/out-201410.csv",select=c(168,194,196,232))
DS_11<-fread(file="~/Desktop/intro to data/project/dataset/out-201411.csv",select=c(168,194,196,232))
DS_12<-fread(file="~/Desktop/intro to data/project/dataset/out-201412.csv",select=c(168,194,196,232))

DSData<-rbind(DS_1,DS_2,DS_3,DS_4,DS_5,DS_6,DS_7,DS_8,DS_9,DS_10,DS_11,DS_12)

DSData[DSData==""]<-NA
DSData1<-na.omit(DSData) # remove NAs
View(DSData1)

DatabyNPS_TYPE<-aggregate(DSData1, by=list(DSData1$NPS_Type)  ,FUN=length)
colnames(DatabyNPS_TYPE) <- c('Type', 'No.Of People')

g<-ggplot(DatabyNPS_TYPE, aes(x=Type, y=`No.Of People`))
g<-g + geom_col(color='black', fill='Violet', width = 0.5)
g<-g + ggtitle("Total of number of Promoters, Detractors and Passives")
g

a <-aggregate(DSData1, by=list(DSData1$NPS_Type, DSData1$Location_PL)   ,FUN=length)

View(a)
colnames(a)[1] <- "Type"
colnames(a)[2] <- "Hotel_Location"
colnames(a)[3] <- "Number_of_NPS_Type"


Data.bar1 <- ggplot(data = a, aes(x=Type, y=Number_of_NPS_Type, fill = Hotel_Location)) + geom_bar(stat = "identity")
Data.bar1 <- Data.bar1 + ggtitle("NPS Type by Hotel Location")
Data.bar1


DatabyState<-aggregate(DSData1$State_PL, by=list(DSData1$State_PL)   ,FUN=length)
View(DatabyState) # sort hotels by state to see which state has the most hotels
colnames(DatabyState) <- c("States", "Observations")
library(openintro)
library(maps)
library(ggplot2)
#install.packages("ggmap")
library(ggmap)
#make state names lowercase
e <- tolower(DatabyState$States)
DatabyState$stateName <- tolower(DatabyState$States)
#create data frame with state data for the US
us <-map_data("state")
#Map of the United States with color representing Observations
map.simple <- ggplot(DatabyState, aes(map_id=stateName))
map.simple <-map.simple + geom_map(map=us, aes(fill=DatabyState$Observations), color= "black")
map.simple <- map.simple + scale_fill_gradient(low="white", high ="purple")
map.simple <- map.simple + expand_limits(x= us$long, y=us$lat)
map.simple <- map.simple + coord_map()+ggtitle("Map of the United States by NPS Observations") 
map.simple


Calrows<-which((DSData1$State_PL)=="California")
Cal<-DSData1[c(Calrows),]
View(Cal)

DatabyType<-aggregate(Cal$Type_PL, by=list(Cal$Type_PL)   ,FUN=length)
colnames(DatabyType)<-c("Type", "Observations")
Typebar<- ggplot(DatabyType) +aes(x=Type, y=Observations) + geom_col(color=" light blue", fill="light blue")+ ggtitle("Number of NPS Promoter Observations in California by Hotel Type")
View(DatabyType) 
Typebar

Busrows<-which((Cal$Type_PL)=="Business")
CalBus<-Cal[c(Busrows),]
View(CalBus)

DatabyLoc1<-aggregate(CalBus$Location_PL, by=list(CalBus$Location_PL)   ,FUN=length)
View(DatabyLoc1) 
colnames(DatabyLoc1)<-c("Location", "Observations")
Locbar<- ggplot(DatabyLoc1) +aes(x=Location, y=Observations) + geom_col(color="light blue", fill="light blue ")+ ggtitle("Number of NPS Promoter Observations in California by Hotel Location")
Locbar
