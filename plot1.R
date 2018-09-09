if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl,destfile="./data/ExDataProject.zip")

unzip("./data/ExDataProject.zip", exdir= "./data")

##data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Question 1: Have total emissions from PM2.5 decreased in the United States 
##             from 1999 to 2008? Using the "base" plotting system, make a plot 
##             showing the total PM2.5 emission from all sources for each of the 
##             years 1999, 2002, 2005, and 2008.

## Answer: Create dataframe using the aggregate function to sum PM2.5 
##         with respect to year.

yearly.total.pm <- aggregate(Emissions ~ year, NEI, sum)

png(filename = "plot1.png", width = 480, height = 480, units = "px")

plot(yearly.total.pm$year, yearly.total.pm$Emissions, type = "b", pch =19, main = "Emissions from all sources",
     ylab = "Total PM2.5 (tons)", xlab = "Year")

dev.off()
