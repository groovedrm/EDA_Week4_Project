# Loading libraries
is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
}

if (!is.installed("lubridate")){
  install.packages("lubridate")
}

if (!is.installed("data.table")){
  install.packages("data.table")
}

library(dplyr)
library(data.table)
library(ggplot2)
library(reshape2)

setwd("/Users/Chris/development/r/EDA_Week4_Project/")

# Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Answering Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
NEI$year <- as.integer(NEI$year)
subsetYears <- as.integer(c(1999,2002,2005,2008))
distilledNEI <- subset(NEI, as.integer(year) %in% subsetYears)
# plot1 <- plot(as.numeric(distilledNEI$year, distilledNEI$Emissions))

# Question 2
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.x`
distilledNEI_BaltCity <- subset(NEI, fips == "24510")
tblBaltCity <- data.table(distilledNEI_BaltCity)
grpBaltCity <-  tblBaltCity[, sum(Emissions), keyby=year]

# Question 3
# Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) vale, riab
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make 
# a plot answer this question.

# Note, can use tblBaltCity to start




# Question 6
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California 
# (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time 
# in motor vehicle emissions?
distilledNEI_BaltCity_LaCity <- subset(NEI, fips %in% c("24510","06037"))


