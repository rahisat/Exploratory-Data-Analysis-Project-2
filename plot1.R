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
## elaboraote plotdata: aggregate total PM25 emission from all sources per year
## -----------------------------------------------------------------------------
plotdata <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)

## -----------------------------------------------------------------------------
## create plot
## -----------------------------------------------------------------------------
## create file
png('plot1.png', width=480, height=480)

## plot data
plot(plotdata$year, plotdata$Emissions, type = "l", 
     main = "Total PM2.5 Emission in the US 1999-2008",
     xlab = "Year", ylab = "Emissions")

## close device
dev.off()