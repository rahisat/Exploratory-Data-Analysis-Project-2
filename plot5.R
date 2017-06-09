## libraries
require(ggplot2)

## set work dir
setwd("/Users/satrahi/Documents/course4_project2/")

## -----------------------------------------------------------------------------
## get data
## -----------------------------------------------------------------------------
# read national emission inventory data (NEI)
fileNEI = "exdata-data-NEI_data/summarySCC_PM25.rds"
NEI <- readRDS(fileNEI)

# read source classification codes (SCC)
fileSCC = "exdata-data-NEI_data/Source_Classification_Code.rds"
SCC <- readRDS(fileSCC)

## -----------------------------------------------------------------------------
## elaborate plotdata: aggregate total PM25 emission from Baltimore per year
## for motor vehicles
## -----------------------------------------------------------------------------
# get baltimore NEI data
baltimore <- subset(NEI, fips == "24510")

# get motor vehicle SCC
vehicleSource <- SCC[grepl("Vehicle", SCC$EI.Sector),]

# select baltimore data based on vehicle sources
vehicleBaltimore <- subset(baltimore, baltimore$SCC %in% vehicleSource$SCC)

# make plotdata
plotdata <- aggregate(vehicleBaltimore[c("Emissions")], 
                      list(type=vehicleBaltimore$type, 
                           year = vehicleBaltimore$year), sum)

## -----------------------------------------------------------------------------
## create plot
## -----------------------------------------------------------------------------
## create file
png('plot5.png', width=480, height=480)

## plot data
p <- ggplot(plotdata, aes(x=year, y=Emissions, colour=type)) +
  # fade out the points so you will see the line
  geom_point(alpha=0.1) +
  # use loess as there are many datapoints
  geom_smooth(method="loess") +
  ggtitle("Total PM2.5 Emissions in Baltimore for Motor Vehicles 1999-2008")
print(p)

## close device
dev.off()