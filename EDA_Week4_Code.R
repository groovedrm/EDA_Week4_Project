# Loading libraries
is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
}

if (!is.installed("lubridate")){
  install.packages("lubridate")
}

setwd("/Users/Chris/development/r/EDA_Week4_Project/")

# Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Answering Question 1
NEI$year <- as.integer(NEI$year)
subsetYears <- as.integer(c(1999,2002,2005,2008))
distilledNEI <- subset(NEI, year %in% subsetYears)