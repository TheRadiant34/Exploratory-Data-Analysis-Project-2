if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl,destfile="./data/ExDataProject.zip")

unzip("./data/ExDataProject.zip", exdir= "./data")

##data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Question 5: How have emissions from motor vehicle sources changed 
##             from 1999-2008 in Baltimore City?

## Answer:

BaltimoreCityVehicle<- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

TotalPM.BC.byVehicle<- aggregate(Emissions ~ year, BaltimoreCityVehicle, sum)

png(filename = "plot5.png", width = 480, height = 480, units = "px")

plot(TotalPM.BC.byVehicle$year, TotalPM.BC.byVehicle$Emissions, type = "b", pch =19, main = "Baltimore City, MD Vehicle Emissions",
     ylab = "Total PM2.5 (tons)", xlab = "Year")

dev.off()