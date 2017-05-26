setwd("/Users/Chris/development/r/EDA_Week4_Project/")

is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
}

if (!is.installed("data.table")){
  install.packages("data.table")
}

library(data.table)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
distilledSCC <- SCC[, c("SCC","Data.Category","Short.Name","EI.Sector","SCC.Level.One","SCC.Level.Two","SCC.Level.Three","SCC.Level.Four")]
detailedNEI <- merge(NEI, distilledSCC, by=c("SCC"), all.x = TRUE)
mvSources <- detailedNEI[grep("On-Road", detailedNEI$EI.Sector), ]
mvSources <- subset(mvSources, fips %in% c("24510"))
mvSources <- data.table(mvSources)
mvSources <-  mvSources[, sum(Emissions), keyby=year]
names(mvSources) <- c("year","emissions")

png("plot5.png", width=504, height=504)
barplot(height = mvSources$emissions, 
        names.arg = mvSources$year,
        xlab = "Year",
        ylab = "Emissions Total",
        main = "Total Emissions From Mobile Sources [Baltimore City] -- 1999-2008")

dev.off()