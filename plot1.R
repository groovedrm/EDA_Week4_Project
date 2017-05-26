setwd("/Users/Chris/development/r/EDA_Week4_Project/")

is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
}

if (!is.installed("data.table")){
  install.packages("data.table")
}

library(data.table)

# Loading the data
NEI <- readRDS("summarySCC_PM25.rds")

# Answering Question 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
NEI$year <- as.integer(NEI$year)
subsetYears <- as.integer(c(1999,2002,2005,2008))
distilledNEI <- subset(NEI, as.integer(year) %in% subsetYears)
tblNEI <- data.table(distilledNEI)
tblNEI <-  tblNEI[, sum(Emissions), keyby=year]
names(tblNEI) <- c("year","emissions")

png("plot1.png", width=504, height=504)
barplot(height = tblNEI$emissions, 
        names.arg = tblNEI$year,
        xlab = "Year",
        ylab = "Emissions Total",
        main = "Total Emissions In The United States -- 1999-2008")

dev.off()