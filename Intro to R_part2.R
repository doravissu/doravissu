                    ####Introduction to R####
##Part1-> R atomic data types and datastructures, saving workspace and scripts
##Part2-> Importing tabular data (text files)
##Part3-> Working with web data (Grabbing tables,JSON)

                   
          ##Part 1-> Data types and datastructures##

#Most relevant data types and datastructures

                    
#Data import using most import functions results in the creation of a dataframe
                    
  v1<-c(1,2,3,"uday",TRUE) 
  v1
  is.vector(v1)
  class(v1)
  class(V1)
  class(v1[1])
  
  v2<-c(1,2,3)
  class(v2)
    
myarray<-array(1:500,dim=c(2,3,5))
  myarray
  class(myarray)
  
  myarray[ , ,5]
  
  setwd("E:\\Intro to R assignments\\Intro to R")   
  getwd()
data1<-read.csv("cpu.csv")
                   
class(data1)                  

getwd()
#Working with data frames



#Selecting a specific row/column or both: Subsetting/Slicing

data1[2,2]

View(data1)




data1[,2]

class(data1[,2])




data1$MYCT

MYCT

data1[,"MYCT"]



data1[1,]



data1[,c(2,5,7)]










data1[0,0] 









#Indiceslib in R start from 1 not 0

#Subsetting/Slicing multiple rows and columns

data1[1,2,3,4,5] 





head(data1)
tail(data1)

#Need to assign vector of indices

data1[c(1,2,3,4,5),]


data1[c(1,2,3,4,5),c(1,5)] # combined operator




data1[c(1,2,3,4,5),c("Vendor","CACH")] #getting data with col name - first 5 records

data1[c(1,2,3,4,5),-c(1,5)] 

datanew<-data1[,"CACH"] #getting data with col name - first 5 records

head(datanew)

# except col 1,5

data1[c(1,2,3,4,5),-c("Vendor","CACH")] #Character vectors

data1[1:5,c("Vendor","CACH")] # ?

data1[1:5,c(1,5)] # ?


################################

is.vector(c(1,2,3,4,5))
is.vector(1:5) #Sequence functions in R will generate vectors, so they can be useful in slicing/indexing



















myarray<-array(1:500,dim=c(2,3,10))
myarray
class (myarray)
v3 <- as.vector(myarray)
class(v3)
#Some import functions also generate lists: Mostly functions that work with web objects like JSON/XML

library(jsonlite)
data2<-fromJSON("G:\\Neha\\Intro to R assignments\\Intro to R\\Visa.txt")
class(data2)#Not every data import will result in creation of dataframes

str(data2)

data2$fields
class(data2$fields)

head(data2$data)
class(data2$data)

data2$fields[,1]
data2$data[1,2]


save.image(file="E:\\Intro to R assignments\\Intro to R\\Workspace2.RData")

rm(data1,data2)

load("E:\\Intro to R assignments\\Intro to R\\Workspace2.RData")

class(data1)
sessionInfo()
#Lists are not only encountered while importing data but also when we work with machine learning algorithms

#Saving workspace will save only objects created in a working session, it will not save your R code!!!!!

##Importing tabular data##

#Checks needed to ensure that data is imported correctly
#1. Delimiter in the file
#2. How missing values are populated in the data


import1<-read.table("E:\\Intro to R assignments\\Intro to R\\sample2.csv",sep=",",header = TRUE)

class(import1)
summary(import1) #Focus on the missing values
str(import1) #Are column data types correct use structure command

import2<-read.table("E:\\Intro to R assignments\\Intro to R\\sample1.txt")#Why error




import2<-read.table("E:\\Intro to R assignments\\Intro to R\\sample1.txt",sep="\t")

import2#What is wrong?

import2<-read.table("E:\\Intro to R assignments\\Intro to R\\sample1.txt",sep="\t",header=TRUE)

summary(import2)
str(import2)

import2<-read.table("E:\\Intro to R assignments\\Intro to R\\sample1.txt",sep="\t",header=TRUE,na.strings = c("Missing",""))

summary(import2)

str(import2)

class(import1)
class(import2)

##Data import is considered successfull: 1.Delimiters are identified correctly, 2.Missing values in the data are recognized as missing (NA)

###Working with web data###

#Working with web objects JSON and XML#
#Sometimes data is not available in tabular formats: csv, sql servers#
#Particuarly when working with API's

#Glassdoor API, https://www.glassdoor.co.in/developer/index.htm
library(jsonlite)
web1<-fromJSON("http://api.glassdoor.com/api/api.htm?v=1&format=json&t.p=47699&t.k=g9GdVHlQ1eM&action=employers&q=pharmaceuticals&userip=192.168.43.42&useragent=Mozilla/%2F4.0")

class(web1)

str(web1)

#Getting tables from web pages
#Many web pages contain tabular data as comma separated or tab separated
#UCI Abalone data set
#web2<-read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data",header=FALSE)

head(web2) # Column names are missing

#Use the documentation on the page to figure out the column names

name<-c("Sex","Length","Diameter","Height","Whole.Weight","Shuclked.Weight","Viscera.Weight","Shell.Weight","Rings")

names(web2)<-name
head(web2)
str(web2)

#Fetching HTML tables from a webpage

#x = readHTMLTable('http://www.disastercenter.com/crime/iacrime.htm')

web3<-readHTMLTable("http://www.inflationdata.com/Inflation/Consumer_Price_Index/HistoricalCPI.aspx?reloaded=true")

#class(web3)

#https://en.wikipedia.org/wiki/World_population

#One can save the web page locally and still read in the tables
library(XML)
web4<-readHTMLTable("E:\\Intro to R assignments\\Intro to R\\Historical Consumer Price Index (CPI).html")
class(web4)
str(web4)
summary(web4)
#If analysis on this data has to be done then it should be converted to a dataframe


install.packages("XML")


web4<-as.data.frame(web4)
class(web4)


head(web4)#What is wrong?
write.csv(web4,"E:\\Intro to R assignments\\Intro to R\\cpi2.csv",row.names = F)

web5<-read.csv("E:\\Intro to R assignments\\Intro to R\\cpi2.csv")

head(web5)#Need to skip the first line

web5<-read.csv("E:\\Intro to R assignments\\Intro to R\\cpi2.csv",skip=1, nrow = 5)
head(web5)
