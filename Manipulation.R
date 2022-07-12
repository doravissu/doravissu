#Merging data
##Joins using Merge
df1 = data.frame(CustomerId=c(1:6),Id = c("a","b","c","d","e","f"),Product=c(rep("Toaster",3),
                                                                             rep("Radio",3)))
df1
df2 = data.frame(CustomerId=c(2,4,6,7),Id = c("b","d","f","T"),
                 State=c(rep("Alabama",2),rep("Ohio",2)))
df2

merge(x = df1, y = df2, by = c("CustomerId","Id"), all = TRUE)#Outer join:

merge(x = df1, y = df2, by = "CustomerId", all.x=TRUE)#Left join

merge(x = df1, y = df2, by = "CustomerId", all.y=TRUE)#Right join

merge(x=df1,y=df2,by="CustomerId")#Inner Join/Intersection of both tables

merge(x=df1, y=df2, by=NULL)



library(dplyr)

str(left_join(df1, df2, by = c("CustomerId","Id"), match = "all"))
right_join(df1, df2, by = "CustomerId", match = "all")
inner_join(df1, df2, by = "CustomerId", match = "all")


#rbind & cbind
product=c("Bag","shoes","belt","belt")

total_price=c(500,1000,150,10000)

color=c("Blue","red","red","Blue")

quantity=c(5,NA,3,4)


product_details <- data.frame(product,total_price,color,quantity,stringsAsFactors=T)
product_details


product=c("Bag1","shoes1","belt1","belt1")

total_price=c(200,2000,250,20000)

color=c("Blue1","red1","red1","Blue1")

quantity=c(10,NA,11,12)


product_details1 <- data.frame(product,total_price,color,quantity,stringsAsFactors=T)
product_details1

rbind(product_details,product_details1)

Id<- c(1,2,3,4)
cbind(product_details1,Id)

rbind(product_details,product_details1)


#Missing values
a<-c(1,2,3,4,5,6,NA,NA,NA,7,8,9)
is.na(a)
sum(is.na(a))
mean(a, na.rm=TRUE)


data("airquality")
air<- airquality
summary(air)

head(air)

sum(is.na(air$Ozone))

sum(is.na(air$Solar.R))


#Imputing Missing values

air$Ozone[is.na(air$Ozone)]<-45

air$Solar.R[is.na(air$Solar.R)]<-mean(air$Solar.R,na.rm=TRUE)

summary(air)



#Keep in mind the compatibility of the classes returned and accepted by various functions



#String manipulation

a<-"Batman"

#Basic fuctions
substr(a,start=2,stop=5)

nchar(a)

tolower(a)

toupper(a)

#Split
b<-"Bat-Man"

strsplit(b,split="-")

c<-"Bat/Man"

strsplit(c,split="/")


#To identify pattern
d<-c("Bat-Man","Super-Man","Spiderman")

grep("-",d)

grepl("-",d)


#Substitute

sub("-","/",b)

d<-"Bat-Ma-n"


sub("-","/",d)
gsub("-","/",d)


dat5<-read.csv("C:\\Users\\User10\\Desktop\\Jigsaw\\Intro & manipulation in R\\Strings.csv")
str(dat5)
head(dat5)#is there something wrong? 
mean(dat5$Income_M)#Why will this happen

#Need to clean the data

dat5$Income_M<-gsub("Rs","",dat5$Income_M)
head(dat5)

dat5$Income_M<-gsub("/-","",dat5$Income_M)
head(dat5)
mean(dat5$Income_M)#Now why an error?

str(dat5)

dat5$Income_M<-as.numeric(dat5$Income_M)
mean(dat5$Income_M)


#sqldf, This is optional
#install.packages("sqldf")
library(sqldf)

oj <- read.csv("oj.csv")

#Using SELECT statement
oj_s1<-sqldf("select brand, income, feat from oj ")

#Subseting using where statement
oj_s<-sqldf("select brand, income, feat from oj 
            where price<3.8 
            and income<10")

#Order by statement
oj_s2<-sqldf("select store,brand,week,logmove,feat,price, income from oj 
            order by income asc")

#distinct
sqldf("select  distinct brand from oj")

#Demo sql functions
sqldf("select avg(income) as AI from oj")
sqldf("select min(price) as MI from oj")

