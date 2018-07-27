library(data.table)
NYC_311 <- fread("/nfs/bedbugs-data/City Housing Complaint Databases 2-28-18/NYC_Original_Data_Feb_28_2018/311_Call_Center_Inquiry.csv")

NYC_com <- fread("/nfs/bedbugs-data/City Housing Complaint Databases 2-28-18/NYC_Original_Data_Feb_28_2018/Housing_Maintenance_Code_Complaints.csv")

NYC_vio <- fread("/nfs/bedbugs-data/City Housing Complaint Databases 2-28-18/NYC_Original_Data_Feb_28_2018/Housing_Maintenance_Code_Violations.csv")
library(dplyr)

NYC_BB <- subset(NYC_com, Code == "BEDBUGS" | Code == "BED BUGS")

#another option 
NYC_BB <- NYC_com %>% filter(Code %in% c("BEDBUGS", "BED BUGS"))

#Time Series Analysis

library(here)
library(tidyverse)
library(tidytext)
library(lubridate)

#setting up date

NYC_BB <- NYC_BB %>% mutate(C_Date = lubridate::mdy(`StatusDate`))
NYC_BB <- NYC_BB %>% mutate(C_Year = lubridate::year(C_Date))
NYC_BB <- NYC_BB %>% mutate(C_Month = lubridate::month(C_Date))
NYC_BB <- NYC_BB %>% mutate(C_Month_Date = paste(C_Month, C_Year, sep="-"))

NYC_BB <- NYC_BB %>% mutate(Violation = recode(`Code`, "BEDBUGS" = "Bed Bugs", "BED BUGS" = "Bed Bugs"))

BB_month<-NYC_BB %>% group_by(C_Year, C_Month, Violation) %>% summarise(count=n())
BB_month<-BB_month %>% mutate(C_Month_Year = as_date(paste(C_Year,C_Month, "01", sep="-")))

library(ggplot2)
ggplot(BB_month, aes(C_Month_Year, count)) + geom_line() 

#hmm something wrong here -> going to go from 311 

##violations for NYC-dataset
library(stringr)

bb_terms <- c("BED BUGS", "BEDBUGS", "BED BUG", "BEDBUG")

#attempting on smaller dataset 
NYC_s <- NYC_vio[1:10000,]

NYC_s$BB <- sapply(NYC_s$NOVDescription, function(x) any(str_detect(x, pattern = bb_terms)))

#full dataset 

NYC_vio$BB <- sapply(NYC_vio$NOVDescription, function(x) any(str_detect(x, pattern = bb_terms)))

#Number of Bed bug violations 
## FALSE    TRUE 
#4510312   24070 

NYC_BB <- subset(NYC_vio, BB == "TRUE")

NYC_BB <- NYC_BB %>% mutate(C_Date = lubridate::mdy(`InspectionDate`))
NYC_BB <- NYC_BB %>% mutate(C_Year = lubridate::year(C_Date))
NYC_BB <- NYC_BB %>% mutate(C_Month = lubridate::month(C_Date))
NYC_BB <- NYC_BB %>% mutate(C_Month_Date = paste(C_Month, C_Year, sep="-"))

BB_month<-NYC_BB %>% group_by(C_Year, C_Month, BB) %>% summarise(count=n())
BB_month<-BB_month %>% mutate(C_Month_Year = as_date(paste(C_Year,C_Month, "01", sep="-")))

library(ggplot2)
ggplot(BB_month, aes(C_Month_Year, count)) + geom_line() +
  scale_x_date(date_breaks = "2 years", date_labels = "%b-%Y") +
  xlab("") + ylab("Number of Bed Bug Violations") +
  ggtitle("Bed Bug Code Violations for New York City 2002 - Present")

#subsetting to study period for 2010 - present 

#hmm something wrong here -> going to go from 311 


