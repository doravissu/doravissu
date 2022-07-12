#Introduction to R

#R as calculator
#Arithmetic Operations

#Sum
3+2

#Subtraction
3-2

#Multiplication
3*2

#Division
4/2

#Power
4^2

#logarithm of value 2
log(2)
log10(2)

#Exponential
exp(0)

#Store values in R: Variables/Vectors
#Store a numeric value
n<-5 #Use either <- or =
n<-6

#Store a character value
chr<-"string"
chr1='strings'
Chr="Kunal"

#class
class(n)
class(chr)
class(Chr)

5_x=3

d=1.5
class(d)

class(n)
n=as.integer(n)
class(n)

chr=as.numeric(chr)
chr

d=as.character(d)
d

#You can think of converting a character value to numeric using a different way. Factors

#How to store/assign more than one value to a variable.
#Vectors
#Numeric vector
num<-c(1,2,3,4)
num<-1:4
num
class(num)

dec=c(1,2.1,3.3)
class(dec)
dec=as.integer(dec)
dec

#character vector
character<-c('R','python','sas','tableau')
character
class(character)

char<-c(1,2,3,'a')
class(char)

c<-c(1:100,'a')
class(c)
#Even if you have millions of numeric values along with one character or string value then whole vector will be considered as character

#Logical vectors
logical<-c(TRUE,FALSE)
class(logical)

#Length of vectors
length(character)

#Missing values in vectors
numeric<-c(1,2,9,NA)
numeric

#How to check missing values in vectors
is.na(numeric)
sum(is.na(numeric))

numeric
character
#Combine two vectors in R
new<-c(numeric,character)
new
length(new)

#Indexing/slicing:In R index start with 1
#Select an element from a vector
new[3]
character[1]
new[1:4]
new[c(3,5,8)]

#Adding elements
num
c(num,5)

#Replacing elements
num[1]<-0
character
character[3]<-"sql"
character
character[-4]

#Data Frames in R
df<-data.frame(col1=num,col2=character)
df
#Get column names
names(df)
#Change column names
names(df)<-c("Numeric values","character values")
names(df)[2]<-"Name"

#Lets say I have 100 column names, I would like to know the column number where "Name" is occuring.
which(names(df)=="Name")

#What is factor variable?
#A variable which represents a group or level?

#Inbuilt data frame in R
iris
View(iris)
head(iris)
head(iris,10) 

str(iris)
dim(iris)

#Access elements of data frame [nrow,ncols]
names(iris)

#Select a column
iris$Petal.Length
iris[,3]
iris[,c("Species","Sepal.Width")]

#Select 5th row 3rd element
iris[5,3]

#Select first 10 rows
iris[1:10,"Species"]

#Select rows with index 5:12 from first two columns
iris[5:12,1:2]
iris[c(5,9,12),]

#Replace element in 5th row 3rd column
iris[5,3]<-0
head(iris)

#Matrices in R
m=matrix(1:9,ncol=3) #default arrange values in column wise
m

m1=matrix(1:9,ncol=3,byrow=TRUE) #arrange row wise
m1

m2=matrix(c(2,9,8,1,3,5,1),nrow=3,byrow=TRUE)
m2

m2[2,2]<-""

m3=as(iris[,1:4],"matrix")
class(m3)

#Add row/column names
rownames(m1)<-c("r1","r2","r3")
colnames(m1)<-c("c1","c2","c3")
m1

#Access the elements of matrix
m1[2,2]

#Lists: Can have any object of any data type of different dimension or length
list=list(num,new,df,iris,m1)
length(list)
str(list)

#Select elements of the list
list[1]
list[[1]][c(1:3)]

#Change element names in the list
names(list)<-c("e1","e2","e3","e4","e5")
list$e3
list[1]

list[[3]][3,1]

#Current working directory
getwd()

#Importing csv or tab separated files into R
setwd("D:\\Intro to R Redo\\class")
data=read.csv("Fitness.csv")
head(data)
dim(data)

data=read.csv("Fitness.csv",na.string=c("9999","-","NA",0," ",""))
data

store=read.table("Store_Sales.txt",header=TRUE,sep="\t",stringsAsFactors = FALSE)
head(store)
str(store)
unique(store$State)

#Reading excel files into R
library(readxl)
#Load the workbook
wb=read_excel("customers.xlsx") #xlsx, xls
head(wb)

#Get sheet names in the excel
ns=excel_sheets("customers.xlsx")
ns
length(ns)

#Import the worksheet by name or number
california=read_excel("customers.xlsx", sheet = "california")
head(california)

data=read_excel("customers.xlsx",sheet=3)
head(data)

data[3,5]

#HTML data
library(XML)
x = readHTMLTable('http://apps.saferoutesinfo.org/legislation_funding/state_apportionment.cfm')
str(x)
data=as.data.frame(x[[1]])
head(data)

#Import json file in to R
library(rjson)
json<-fromJSON(file='persondetails.json')

#Export data from R to csv file
write.csv(data,"transport.csv",row.names=FALSE)
list.files()

#Loading
save.image(file="intro.RData")
load("intro.RData")

#.R files will store the codes in text format
#.RData will store the objects you have created
#.Rhistory will store all the codes executed
