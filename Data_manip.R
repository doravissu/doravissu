setwd("C:\\Users\\Kafeel Basha\\Desktop\\R Files\\R assignment solutions\\Folder Structure\\Pre-Class Video Codes and Data sets\\Class 8 Data Manipulation")
oj <- read.csv("oj.csv")
dim(oj)
str(oj)
head(oj)

#dataframe[rows,columns]
oj[1,3]

oj[c(1,2,8,456),c(1,3,6)]

oj[c(1:5),"brand"]

#Logical Subseting data frame[rows,columns]
#Selecting only those rows where brand is tropicana
dat<-oj[oj$brand=='tropicana',]
dim(dat)

#Using Or condition, brand bought is tropicana or dominicks
dat1<-oj[oj$brand=='tropicana'|oj$brand=='dominicks',]
dim(dat1)

#Use in to see the values
dat1<-oj[oj$brand %in% c("tropicana","dominicks"),]
dim(dat1)

#Using And condition, brand bought is tropicana and no feature advertisement is run
dat2<-oj[oj$brand=='tropicana' & oj$feat==0,]
dim(dat2)

#Subsetting using which() operator
index<-which(oj$brand=="dominicks")
head(index)
dat3<-oj[index,]
head(dat3)


#Selecting Columns
dat4<-oj[,c("week","brand")]
head(dat4)

#Seleecting+Subsetting
dat5<-oj[oj$brand=='tropicana' & oj$feat==0,c("week","store")]
head(dat5)

#Adding new columns
oj$logincome<-oj$INCOME+1
dim(oj)


dat6<-oj[order(oj$week),]
head(dat6)
min(oj$week)

dat7<-oj[order(-oj$week),]
head(dat7)
max(oj$week)

##Group by summaries
class(oj$brand)
unique(oj$brand)
summary(oj$price)
#Mean price of juice across brands
#Summarize-Price
#Summarize by-Brand (factor)
#Summarize how-Mean

#Syntax aggregate(variable to be summarized, by=list(variable by which grouping is to be done),function)

agg=aggregate(oj$price,by=list(oj$brand),mean)[1,]
class(agg)

t=tapply(oj$price,oj$brand,mean)
class(t)
t
#Mean income of people by brand
#Summarize-Income
#Summarize by-Brand
#Summarize how-Mean
agg=aggregate(oj$INCOME,by=list(oj$brand),mean)
class(agg)

t1=tapply(oj$INCOME,oj$brand,mean)
class(t1)
t1
#Cross tabulations
# Units of different brands sold based on if feature advertisement was run or not
tab=table(oj$brand,oj$feat)
class(tab)
tab
xtabs(oj$INCOME~oj$brand+oj$feat)

#dplyr
library(dplyr)
dat8<-filter(oj,brand=="tropicana")
dim(dat8)

dat9<-filter(oj,brand=="tropicana"|brand=="dominicks")
dim(dat9)

#Selecting Columns
dat10<-select(oj,brand,INCOME,feat)
#Removing columns
dat11<-select(oj,-brand,-INCOME,-feat)

#Creating a new column
dat12<-mutate(oj,logIncome=log(INCOME))

#Arranging data 
dat13<-arrange(oj,INCOME)
dat14<-arrange(oj,desc(INCOME))

dat14<-arrange(oj,-INCOME)

#Group Wise summaries
gr_brand<-group_by(oj,brand)
summarize(gr_brand,round(mean(INCOME),4),sd(INCOME))

#Pipelines
#Base R code
mean(oj[oj$INCOME>=10.5,"price"])
#dplyr code
sub=filter(oj,INCOME>=10.5)
summarize(sub,mean(price))
oj%>%filter(INCOME>=10.5)%>%summarize(mean(price))

oj%>%filter(price>=2.5)%>%mutate(logIncome=log(INCOME))%>%summarize(mean(logIncome),median(logIncome),sd(logIncome))

##Date
strDates="01/20/14"
date1=as.Date(strDates,format="%m/%d/%y")
date1
class(date1)

date="20180519"
date=ymd(date)
date=format(date,"%d-%B-%Y")

fd<-read.csv("Fd.csv")
dim(fd)
str(fd)

fd$FlightDate<-as.Date(fd$FlightDate,format="%d-%b-%y")
str(fd)

head(months(fd$FlightDate))
unique(months(fd$FlightDate))
head(weekdays(fd$FlightDate))
unique(weekdays(fd$FlightDate))

#Finding time interval
fd$FlightDate[60]-fd$FlightDate[900]
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "weeks")
difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "days")

difftime(fd$FlightDate[3000],fd$FlightDate[90],units = "hours")
difftime(fd$FlightDate[3000],fd$FlightDate[90])

#Subsetting data based on time information
library(dplyr)

#Subset the data for day=Sunday
dim(fd)
fd%>%filter(weekdays(FlightDate)=="Sunday")%>%nrow()
dim(weekd)

#Find the number of flights on Sundays for destination Atlanta
fd%>%filter(weekdays(FlightDate)=="Sunday",DestCityName=="Atlanta, GA")%>%nrow()

fd%>%mutate(day=weekdays(FlightDate)=="Sunday")%>%
  filter(day==TRUE,DestCityName=="Atlanta, GA")%>%nrow()

#Find the number of flights on Sundays for all cities
fd%>%filter(weekdays(FlightDate)=="Sunday")%>%group_by(DestCityName)%>%summarize(count=n())%>%arrange(-count)

#PISIXct and POSIXlt
date1=as.POSIXct(Sys.time())
class(date1)
unclass(date1)

date2 <- as.POSIXlt(date1)
class(date2)
unclass(date2)

#Duration between two date in years
library(lubridate)
year=duration(num=1,units="years")
dob="01011980"
dob=dmy(dob)
refdate=today()
nyears=interval(dob,refdate)/year

nyears
#Merging data
##Joins using Merge
df1 = data.frame(CustomerId=c(1:6),Product=c(rep("Toaster",3),rep("Radio",3)))
df2 = data.frame(CustomerId=c(2,4,6),State=c(rep("Alabama",2),rep("Ohio",1)))

merge(x = df1, y = df2, by = "CustomerId", all = TRUE)#Outer join:

merge(x = df1, y = df2, by = "CustomerId", all.x=TRUE)#Left join

merge(x = df1, y = df2, by = "CustomerId", all.y=TRUE)#Right join

merge(x=df1,y=df2,by="CustomerId")#Inner Join/Intersection of both tables


#Missing values
a<-c(1,2,3,4,5,6,NA,NA,NA,7,8,9)
is.na(a)
sum(is.na(a))

air<-airquality
head(air)

sum(is.na(air$Ozone))
sum(is.na(air$Solar.R))

summary(air)

#Imputing Missing values
air$Ozone[is.na(air$Ozone)]<-45
summary(air)

air$Solar.R[is.na(air$Solar.R)]<-mean(air$Solar.R,na.rm=TRUE)
summary(air)

#reshape2()
library(reshape2)
person<-c("Sankar","Aiyar","Singh")
age<-c(26,24,25)
weight<-c(70,60,65)
wide<-data.frame(person,age,weight)
wide

#Wide to long
melt(wide,id.vars="person")
melted<-melt(wide,id.vars="person",value.name ="Demo_Value" )

dcast(melted,person~variable,value.var = "Demo_Value")


#String manipulation
a<-"Batman"
substr(a,start=2,stop=6)

nchar(a)
tolower(a)
toupper(a)

b<-"Bat-Man"
strsplit(b,split="-")
c<-"Bat/Man"
strsplit(c,split="/")

mfc=rownames(mtcars)
head(mfc)  
mname=strsplit(mfc,split=" ")
class(mname)
mname[[1]][1]
mname=sapply(mname,"[",1)
paste(b,c)
c(b,c)

grep("-",c(b,c))

c(b,c)
grepl("/",c(b,c))

c(c,b)
grepl("/",c(c,b))

b
sub("-","/",b)


d<-"Bat-Ma-n"
sub("-","/",d)

gsub("-","/",d)

#clearning
reve=c("M 3.2","B 3.6","B 2.8","B 3.5","M 4")
class(reve)

data=data.frame(reve)
data
index=which(grepl("M ",data$reve))
data$reve=gsub("M ","",data$reve)
data$reve=gsub("B ","",data$reve)
data$reve=as.numeric(data$reve)

#Millions to Billions
data$reve[index]=data$reve[index]/1000
data


#sqldf
library(sqldf)
#Using SELECT statement
oj_s<-sqldf("select brand, income, feat from oj ")
#Subseting using where statement
oj_s<-sqldf("select brand, income, feat from oj where price<3.8 and income<10")
#Order by statement
oj_s<-sqldf("select store,brand,week,logmove,feat,price, income from oj order by income asc")
#distinct
sqldf("select distinct brand from oj")
#Demo sql functions
sqldf("select avg(income) from oj")
sqldf("select min(price) from oj")
