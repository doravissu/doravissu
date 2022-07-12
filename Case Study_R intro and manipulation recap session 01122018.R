# CASE STUDY -----
# As a marketing VP of a corporate retail, the client would like to identify 
# all the Young and senior citizen customers who spent less than $5
# on an average per transaction starting from year 2010 till date
# The purpose is to reach out to these customers through email campaign
# so that those customers utilize those campaigns to buy more


# STEP 1. - Understand business problem thoroughly

# STEP 2. - Put down what data will be needed and ask for relevant data

# STEP 3. - Get a high level understanding of data provided. 
#           Create data dictonary and validate through the client

# STEP 4. - Formulate an approach for solving the business problem
#           a.) Get your data into R. Ensure data is imported correctly
#           b.) Do data testing on each column to do a quality check of data
#           c.) Check data structure and summary statistics 
#           d.) Based on above - Missing value/ outlier treatment, correct data types etc.
#           e.) More data manipulations and iterations of above steps to get analytical dataset
#           f.) Now work towards solving problem using analytical data frame

# Import the data
customers <- read.csv("customers.csv")
invoices <- read.csv("invoices.csv")

# Checking structure of data
str(customers)
str(invoices)

# Import correctly
customers <- read.csv("customers.csv", na.strings = "",stringsAsFactors = FALSE)
invoices <- read.csv("invoices.csv", na.strings = "", stringsAsFactors = FALSE)

# Recheck structure of data
str(customers)
str(invoices)

# Check missing/  NA value counts
colSums(is.na(customers))
colSums(is.na(invoices))

# CheCking summary statistics
summary(customers)
summary(invoices)

# Understanding of unique customers
NROW(unique(customers$CustomerId))
NROW(unique(invoices$CustomerId))
min(customers$CustomerId)
max(customers$CustomerId)

min(invoices$CustomerId)
max(invoices$CustomerId)

# Correct date data type
library(lubridate)
invoices$InvoiceDate<- ymd_hms(invoices$InvoiceDate)
class(invoices$InvoiceDate)

# Check structure and summary again
str(invoices)
summary(invoices)

# Missing value treatment for Age
customers$Age[is.na(customers$Age)] <- round(mean(customers$Age, na.rm = TRUE),2)


# Check summary of Age column
summary(customers$Age)

# Manipulate data to classify customers as Young, MiddleAge and Seniors
customers$Age_Bkt[customers$Age <= 25]<-"Young"
customers$Age_Bkt[customers$Age > 25 & customers$Age <= 55 ]<-"MiddleAge"
customers$Age_Bkt[customers$Age  > 55]<-"SeniorCitizen"

# OR
library(dplyr)
customers1 <- mutate(customers, age_bkt = ifelse(Age <= 25, "Young", ifelse (Age >25 & Age <=55, "MiddleAge", "SeniorCitizen")) )

# Get invoices of all customers where country is not missing
# Get count of invoices by each of these customer and sum of sales

# Merge the 2 data frames to get one analytical dataframe
cust_inv <- merge(x = customers, y = invoices, by = "CustomerId", all.x = TRUE)
# What do you notice?

# Filter out customers where email is missing
cust_sub<- filter(customers, ! is.na(Email))

# Merge filtered customer data with their transaction data over years
cust_inv <- merge(x = cust_sub, y = invoices, by = "CustomerId", all.x = TRUE)

# Select only relevant columns - CustomerId, FirstName, LastName, Age_Bkt, Age, InvoiceId, InvoiceDate, Total 
cust_inv1 <- select(cust_inv, CustomerId, FirstName, LastName, Email, Age, Age_Bkt,  InvoiceId, InvoiceDate, Total )

# Filter records for year > 2009
cust_inv2 <- filter(cust_inv1, year(InvoiceDate) >= 2010)

# Roll up data for each cutomer over all the years to get total sales and avg sales
cust_inv3 <- group_by(cust_inv2, CustomerId, FirstName, LastName, Email, Age, Age_Bkt)
final <- cust_inv3 %>% 
  summarize(inv_cnt = n(), total = sum(Total), avg_spend = mean(Total)) %>%
  filter(avg_spend < 5 & (Age_Bkt == "Young" | Age_Bkt == "SeniorCitizen")) %>% 
  arrange(CustomerId)