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
coalNEI <- detailedNEI[grep("Coal", detailedNEI$EI.Sector), ]
coalTable <- data.table(coalNEI)
coalTable <-  coalTable[, sum(Emissions), keyby=year]
names(coalTable) <- c("year","emissions")

png("plot4.png", width=504, height=504)
barplot(height = coalTable$emissions, 
        names.arg = coalTable$year,
        xlab = "Year",
        ylab = "Total Emissions",
        main = "Total Emissions From Coal Sources -- 1999-2008")

dev.off()