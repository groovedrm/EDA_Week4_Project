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
subsetYears = c(1999,2002,2005,2008)
distilledNEI = NEI[NEI$year %in% subsetYears, ]