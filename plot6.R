setwd("/Users/Chris/development/r/EDA_Week4_Project/")

is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
}

if (!is.installed("data.table")){
  install.packages("data.table")
}

if (!is.installed("ggplot2")){
  install.packages("ggplot2")
}

library(data.table)
library(ggplot2)

# Loading the data
NEI <- readRDS("summarySCC_PM25.rds")
distilledNEI_BaltCity_LaCity <- subset(NEI, fips %in% c("24510","06037"))
tblBaltLA <- data.table(distilledNEI_BaltCity_LaCity)
tblBaltLA <- transform(tblBaltLA, city = ifelse(fips == "24510", "Baltimore City", "Los Angeles"))
grpBaltLA <- aggregate(Emissions ~ year + city, tblBaltLA, sum)

q6plot <- ggplot(grpBaltLA, aes(year, Emissions, color=city))
q6plot <- q6plot +  geom_line()
q6plot <- q6plot + xlab("Year")
q6plot <- q6plot + ylab("Total Emissions")
q6plot <- q6plot + ggtitle("Total Emissions Totals - By Year and City")
ggsave("plot6.png", plot = q6plot, device = "png", width = 20, height = 20, units="cm")