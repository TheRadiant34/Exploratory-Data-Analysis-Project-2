if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl,destfile="./data/ExDataProject.zip")

unzip("./data/ExDataProject.zip", exdir= "./data")

##data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Question 3: Of the four types of sources indicated by the 
##             type (point, nonpoint, onroad, nonroad) variable, which of these 
##             four sources have seen decreases in emissions from 1999-2008 for 
##             Baltimore City? Which have seen increases in emissions from 
##             1999-2008? Use the ggplot2 plotting system to make a plot answer 
##             this question.

## Answer:


library(ggplot2)

BaltimoreCity<- NEI[NEI$fips == "24510", ]

TotalPM.BC.bytype<- aggregate(Emissions ~ year + type, BaltimoreCity, sum)

png(filename = "plot3.png", width = 480, height = 480, units = "px")

typeplot <- ggplot(TotalPM.BC.bytype, aes(x= year, y= Emissions, col = type))
typeplot<- typeplot + geom_line() + xlab("Year") + ylab("Total PM2.5 Emissions (tons)") + 
        ggtitle("Baltimore City, MD Emissions")

print(typeplot)

dev.off()