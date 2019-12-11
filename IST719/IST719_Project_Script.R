fn <- choose.files()
Alidata <- read.csv(fn, stringsAsFactors = F, sep = ',', header = T)
View(Alidata)
library(lubridate)

library(ggplot2)
library(ggalluvial)

date.fmt <- "%m/%d/%Y %H:%M"
my.date <- as.POSIXct((strptime(Alidata$Transaction.created.date, date.fmt)))
my.date
Alidata$Transaction.created.date = my.date

# G1 bar chart
annual.expense <- aggregate(Alidata$Amount.RMB.[Alidata$Expense.Revenue == 'Expense']
                            , list(year(Alidata$Transaction.created.date[Alidata$Expense.Revenue == 'Expense']))
                            , FUN = sum)
colnames(annual.expense) <- c('Year', 'Total Expense')

plot(annual.expense, type = 'l', lwd = 2, main = 'My Annual Expense')


# G2 line chart
Ali.agg.year.expense2 <- tapply(abs(Alidata$Amount.RMB.)
                                , list(expense = Alidata$Expense.Revenue ,year =year(Alidata$Transaction.created.date) ), FUN = sum)
options(scipen = 10)
barplot(Ali.agg.year.expense2, beside = T ,xlim = c(0,100000),horiz = T
        , main = 'Barplot for the total expense and revenue for each year'
        , col = c('red','yellow'), xlab = 'Year')


# G3 3D pie chart
Ali.agg.type.expense <- aggregate(abs(Alidata$Amount.RMB.[Alidata$Expense.Revenue=='Expense']), list(Alidata$Product.Type[Alidata$Expense.Revenue=='Expense']), FUN = sum)
library(plotrix)
slices <- Ali.agg.type.expense$x
lbs <- Ali.agg.type.expense$Group.1
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbs,pct)
lbls <- paste(lbls,"%",sep="") 
pie3D(slices,labels = lbls, explode = 0.1, main = 'Where did my money go?'
      , col=rainbow(length(lbls)))



# G4 matrix plot

annual.expense.per.category <- tapply(Alidata$Amount.RMB.[Alidata$Expense.Revenue == 'Expense']
                                      , list(year(Alidata$Transaction.created.date[Alidata$Expense.Revenue == 'Expense'])
                                             , Alidata$Product.Type[Alidata$Expense.Revenue == 'Expense'])
                                      , FUN = sum)
annual.expense.per.category
annual.expense.per.category.df <- as.data.frame(annual.expense.per.category)
annual.expense.per.category.df$Year <- rownames(annual.expense.per.category.df)
annual.expense.per.category.df

x<-c(1:6)
yy <-c(1:8)
x <-rep(x,times = 8)
for (i in yy )
{
  t <-rep(i,times = 6)
  y <- c(y,t)
}
y
colnames(annual.expense.per.category.df)
annual.expense.per.category.df[is.na(annual.expense.per.category.df)]<-0
annual.expense.per.category.df
z<-c()
for (i in c(1:8))
{
  t <- annual.expense.per.category.df[,i]
  z <-c(z,t)
}
plot.df <- data.frame(x,y,z)
zz <- c()

for (i in plot.df$z)
{
  t <- i/(max(plot.df$z)-min(plot.df$z))
  zz <- c(zz,t)
}
zz


plot.df
plot.df$z <- plot.df$z/sum(plot.df$z)
plot.df$zz <- 800*(plot.df$z)
plot(plot.df$x,plot.df$y, type = 'p',cex = plot.df$zz
     ,xlim = c(0.5,6), ylim = c(0,9))


# G5 Alluvial gram

index = which((Alidata$Product.Type == 'Tranportation')|(Alidata$Product.Type == 'Cultural educational and recreational articles and services')|
                (Alidata$Product.Type == 'Account Transfer')|(Alidata$Product.Type == 'Others'))

Ali2 <- Alidata[index, ]
agg2 <- aggregate(Ali2$Amount.RMB., list(year(Ali2$Transaction.created.date)
                                         ,Ali2$Product.Type
                                         ,Ali2$Expense.Revenue), FUN = sum)
colnames(agg2) <- c('Year','Type','Expense','Sum')
ggplot(agg2,aes(y = Sum, axis1 = Year, axis2 = Type, axis3 = Expense)) +
  geom_alluvium(aes(fill = Type)) +
  geom_stratum(width = 1/8) +
  geom_text(stat = "stratum",  label.strata = TRUE) +
  scale_x_continuous(breaks = 1:3, labels = c("Year", "Type", "Expense"))

# G6 clock plot

daily.total.expense.per.category <-tapply(Alidata$Amount.RMB.[Alidata$Expense.Revenue == 'Expense']
                                          , list(hour(Alidata$Transaction.created.date[Alidata$Expense.Revenue == 'Expense']))
                                          , FUN = sum)
daily.total.expense.per.category



x <-daily.total.expense.per.category

# Clock plot function
clock.plot <- function (x, col = rainbow(n), ...) {
  if( min(x)<0 ) x <- x - min(x)
  if( max(x)>1 ) x <- x/max(x)
  n <- length(x)
  if(is.null(names(x))) names(x) <- 0:(n-1)
  m <- 1.05
  plot(0, type = 'n', xlim = c(-m,m), ylim = c(-m,m), axes = F, xlab = '', ylab = '', ...)
  a <- pi/2 - 2*pi/200*0:200
  polygon( cos(a), sin(a) )
  v <- .02
  a <- pi/2 - 2*pi/n*0:n
  segments( (1+v)*cos(a), (1+v)*sin(a), (1-v)*cos(a), (1-v)*sin(a) )
  segments( cos(a), sin(a),0, 0, col = 'light grey', lty = 3) 
  ca <- -2*pi/n*(0:50)/50
  for (i in 1:n) {
    a <- pi/2 - 2*pi/n*(i-1)
    b <- pi/2 - 2*pi/n*i
    polygon( c(0, x[i]*cos(a+ca), 0), c(0, x[i]*sin(a+ca), 0), col=col[i] )
    v <- .1
    text((1+v)*cos(a), (1+v)*sin(a), names(x)[i])
  }
}

# Use the function on the created data
clock.plot(x, main = "Amount of money spent for each hour of the day")


# G7 Late night cpending pie chart


night.index <- which(hour(Alidata$Transaction.created.date)<= 4|hour(Alidata$Transaction.created.date)>=22)
                     
late.night.purchase <- Alidata[night.index,]

late.night.purchase <- late.night.purchase[which(late.night.purchase$Expense.Revenue =='Expense'),]
View(late.night.purchase)

late.night.expense.per.category <-aggregate(late.night.purchase$Amount.RMB.
                                          , list(late.night.purchase$Product.Type)
                                          , FUN = sum)
late.night.expense.per.category
library(plotrix)
slices <- late.night.expense.per.category$x
lbs <- late.night.expense.per.category$Group.1
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbs,pct)
lbls <- paste(lbls,"%",sep="") 
pie3D(slices,labels = lbls, explode = 0.1, main = 'What did I buy during late night'
      , col=rainbow(length(lbls)))

