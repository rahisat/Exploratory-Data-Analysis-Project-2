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
## elaborate plotdata: aggregate total PM25 emission from Baltimore 
## and Los Angeles per year for motor vehicles
## -----------------------------------------------------------------------------
# get Baltimore and Los Angeles NEI data
NEIBaLa <- subset(NEI, fips == "24510" | fips == "06037")

# get motor vehicle SCC
vehicleSource <- SCC[grepl("Vehicle", SCC$EI.Sector),]

# select baltimore data based on vehicle sources
vehicleBaLa <- subset(NEIBaLa, NEIBaLa$SCC %in% vehicleSource$SCC)

# assign the city name, based on fips code
vehicleBaLa$city <- rep(NA, nrow(vehicleBaLa))
vehicleBaLa[vehicleBaLa$fips == "06037", ][, "city"] <- "Los Angeles County"
vehicleBaLa[vehicleBaLa$fips == "24510", ][, "city"] <- "Baltimore City"


# make plotdata
plotdata <- aggregate(vehicleBaLa[c("Emissions")], 
                      list(city = vehicleBaLa$city, 
                           year = vehicleBaLa$year), sum)

## -----------------------------------------------------------------------------
## create plot
## -----------------------------------------------------------------------------
## create file
png('plot6.png', width=480, height=480)

## plot data
p <- ggplot(plotdata, aes(x=year, y=Emissions, colour=city)) +
  # fade out the points so you will see the line
  geom_point(alpha=0.1) +
  # use loess as there are many datapoints
  geom_smooth(method="loess") +
  ggtitle("PM2.5 Emissions in Baltimore and Los Angeles for Motor Vehicles")
print(p)

## close device
dev.off()