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
distilledNEI_BaltCity <- subset(NEI, fips == "24510")
tblBaltCity <- data.table(distilledNEI_BaltCity)
grpBaltCity <- aggregate(Emissions ~ year + type, tblBaltCity, sum)

q3plot <- ggplot(grpBaltCity, aes(year, Emissions, color=type))
q3plot <- q3plot +  geom_line()
q3plot <- q3plot + xlab("Year")
q3plot <- q3plot + ylab("Total Emissions")
q3plot <- q3plot + ggtitle("Total Emissions Totals - By Year and Type")
ggsave("plot3.png", plot = q3plot, device = "png", width = 20, height = 20, units="cm")
