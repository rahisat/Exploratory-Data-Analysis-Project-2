## libraries
require(ggplot2)

## set work dir
setwd("/Users/satrahi/Documents/course4_project2/")

## -----------------------------------------------------------------------------
## get data
## -----------------------------------------------------------------------------
file = "exdata-data-NEI_data/summarySCC_PM25.rds"
NEI <- readRDS(file)

## -----------------------------------------------------------------------------
## elaborate plotdata: aggregate total PM25 emission from Baltimore per year
## -----------------------------------------------------------------------------
baltimore <- subset(NEI, fips == "24510")
plotdata <- aggregate(baltimore[c("Emissions")], list(year = baltimore$year), sum)

## -----------------------------------------------------------------------------
## create plot
## -----------------------------------------------------------------------------
## create file
png('plot2.png', width=480, height=480)

## plot data
plot(plotdata$year, plotdata$Emissions, type = "l", 
     main = "Total PM2.5 Emission in Baltimore 1999-2008",
     xlab = "Year", ylab = "Emissions")

## close device
dev.off()