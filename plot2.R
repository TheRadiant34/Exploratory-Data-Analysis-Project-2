if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl,destfile="./data/ExDataProject.zip")

unzip("./data/ExDataProject.zip", exdir= "./data")

##data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##            fips == "24510" from 1999 to 2008? Use the base plotting system 
##            to make a plot answering this question.

#  Answer:

BaltimoreCity<- NEI[NEI$fips == "24510", ]

TotalPM.BC.bytype<- aggregate(Emissions ~ year, BaltimoreCity, sum)

png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(TotalPM.BC$year, TotalPM.BC$Emissions, type = "b", pch =19, main = "Baltimore City, MD Emissions",
     ylab = "Total PM2.5 (tons)", xlab = "Year")

dev.off()
