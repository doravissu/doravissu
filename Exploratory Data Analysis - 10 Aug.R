setwd("C:\\Users\\Kafeel Basha\\Desktop\\R Files\\Classes\\Data Visualization and Exploration")

# Base plotting

# Using plot() to study to continous variables
ir<-iris
str(ir)

# Syntax
# plot(x=variable to be displayed on x axis, y = variable to be displayed on y axis)
#Scatter plot: Two continuous variables
plot(x=ir$Petal.Width,y=ir$Petal.Length)

# Adding xlabels, ylables and title

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"))

# Adding colors, plotting symbols
#Adding colors
plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),col="red")


#Adding different plotting symbol
plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),col="red",pch=2)

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),col="red",pch=3)

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),col="red",pch=4)

#Adding  more options

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),col="red",pch=4,type="b")

# Making a conditional bivariate plot

# Seeing relationship across different species

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),col=ir$Species)

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),pch=as.numeric(ir$Species),col=ir$Species)

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),cex=as.numeric(ir$Species))

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),pch=as.numeric(ir$Species),cex=as.numeric(ir$Species),col=ir$Species)


#Adding a legend

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),pch=as.numeric(ir$Species))
unique(ir$Species)
legend(0.2,7,c("Setosa","Versicolor","Verginica"),pch=1:3)

plot(x=ir$Petal.Width,y=ir$Petal.Length,main=c("Petal Width Vs Petal Length"),xlab=c("Petal Width"),ylab=c("Petal Length"),col=ir$Species,pch=as.numeric(ir$Species))

legend(0,7,c("Setosa","Versicolor","Verginica"),pch=1:3,col=1:3)

#Studying a continous variable across groups
#Distribution of Sepal lengths across different species

# Univariate Analysis
#Histogram and boxplot are used to understand the distribution of one continuosu variables.

#Box plots
boxplot(ir$Petal.Length)

summary(ir$Petal.Length) #Mean<Median, negatively skewed

box=boxplot(ir$Sepal.Width,horizontal = TRUE)
summary(ir$Sepal.Width) #Mean>Median, positively skewed

#Improving the asethetics of boxplot
boxplot(ir$Petal.Length,col="red",main="Distribution of Petal length")

#x is factor and y is continuous then you will get box plot
plot(x=ir$Species,y=ir$Sepal.Width,xlab="Species",main="Sepal Length across sepcies",col="red",horizontal=TRUE)

#Histograms:  Frequency distribution
hist(ir$Sepal.Width,col="orange")

hist(ir$Sepal.Width,col="orange",labels=TRUE)

hist(ir$Sepal.Width,col="orange",freq=FALSE)
hist(ir$Sepal.Width,col="orange",labels=TRUE,freq=FALSE)
lines(density(ir$Sepal.Width))


#Adding multiple plots in single plotting window
par('mar')
par(mfrow=c(1,2))

plot(x=ir$Species,y=ir$Sepal.Width,xlab="Species",main="Sepal Width across sepcies",col="red")

plot(x=ir$Species,y=ir$Sepal.Length,xlab="Species",main="Sepal Length across sepcies",col="red")

data=iris[,1:4]
list=names(data)
par(mfrow=c(2,2))
par('mar')
par(mar=c(2,2,2,2))
for(i in 1:length(list))
{
  box=boxplot(data[,list[i]],main=list[i])
}

##Market mix data
mix<-read.csv("MMix.csv")

library(dplyr)
library(ggplot2)
#Univariate analysis: 
#Distribution of Sales
quantile(mix$NewVolSales,p=c(1:100)/100) #divide data into 100 parts

#Histogram
plot1=ggplot(mix, aes(x=NewVolSales)) #Aes
plot1+geom_histogram(breaks=seq(17000, 25000, by =1000),col="blue",fill="green",alpha = .2)+labs(title="Distribution of Sales") +  labs(x="Sales", y="Count")

plot1+geom_histogram(aes(y=..density..),breaks=seq(17000, 25000, by =1000),col="blue",fill="green",alpha = .2) + geom_density()

#Understanding Website.Campaign wise distribution
plot1+geom_histogram(aes(fill=Website.Campaign),breaks=seq(17000, 25000, by =1000))

#Modifying the position
plot1+geom_histogram(aes(fill=Website.Campaign,colour=Website.Campaign),position="stack",alpha=0.3)

#Understand the relationship between Sales and price
p<-ggplot(mix,aes(x=Base.Price,y=NewVolSales))
p+geom_point() #geom_point() is used to draw scatter plot

#Understanding the conditional relationship based on Website.Campaign
q<-p+geom_point(aes(colour=Website.Campaign))
q
q+xlab("Price")+ylab("Volume sales")

#Creating grid
p+geom_point(aes(colour=Website.Campaign))+facet_grid(Website.Campaign~.)

#Understand the impact of amount spent on TV for advertisement on Sales

#Boxplots
p<-ggplot(mix,aes(x=Website.Campaign,y=NewVolSales,fill=Website.Campaign))
p+geom_boxplot()

#Density plots
p<-ggplot(mix,aes(x=NewVolSales))
p+geom_density(aes(fill=Website.Campaign,colour=Website.Campaign),alpha=0.3)

library(dplyr)
#Find average sales by Website.Campaign
mix%>%group_by(Website.Campaign)%>%summarise(Avg_sales=mean(NewVolSales))%>%as.data.frame()->df
df
plot2=ggplot(df,aes(x=Website.Campaign,y=Avg_sales,fill=Website.Campaign))
plot2+geom_bar(stat="identity")+geom_text(label=round(df$Avg_sales),vjust=-0.5)

#Correlation:Relationship between continuous variables
cor(mix[c(1,2,4)])

library(corrgram)
plot3=corrgram(mix[c(1,2,4)], lower.panel = panel.cor, upper.panel = panel.pts)

##Understand the relationship between Sales and Discount.
#2d counts
p<-ggplot(mix,aes(x=Discount,y=NewVolSales))
p+geom_point()+scale_x_continuous(breaks=seq(0,0.15,0.02))
p+geom_bin2d()

#Sanity check and missing value treatment
colSums(is.na(mix))
index<-which(mix$Website.Campaign=="")
index

#Consider empty values as new category
mix$Website.Campaign=as.character(mix$Website.Campaign)
mix$Website.Campaign[is.na(mix$Website.Campaign)]="Missing"

#Transformation and creating dummies