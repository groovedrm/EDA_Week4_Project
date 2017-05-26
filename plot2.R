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
distilledNEI_BaltCity <- subset(NEI, fips == "24510")
tblBaltCity <- data.table(distilledNEI_BaltCity)
grpBaltCity <-  tblBaltCity[, sum(Emissions), keyby=year]
names(grpBaltCity) <- c("year","emissions")

png("plot2.png", width=504, height=504)
barplot(height = grpBaltCity$emissions, 
        names.arg = grpBaltCity$year,
        xlab = "Year",
        ylab = "Emissions Total",
        main = "Total Emissions In Baltimore City -- 1999-2008")

dev.off()