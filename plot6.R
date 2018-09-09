if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl,destfile="./data/ExDataProject.zip")

unzip("./data/ExDataProject.zip", exdir= "./data")

##data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## Question 6: Compare emissions from motor vehicle sources in Baltimore City 
##             with emissions from motor vehicle sources in Los Angeles County, California 
##             (fips=="06037"). Which city has seen greater changes over time in 
##             motor vehicle emissions?

## Answer:

if(!library(ggplot2)){install.packages("ggplot2")}
library(ggplot2)

BaltimoreCityVehicle<- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

TotalPM.BC.byVehicle<- aggregate(Emissions ~ year, BaltimoreCityVehicle, sum)

LosAngelesVehicle<- NEI[NEI$fips == "06037" & NEI$type == "ON-ROAD", ]

TotalPM.LA.byVehicle<- aggregate(Emissions ~ year, LosAngelesVehicle, sum)

BC.LA.Totals<- merge(as.numeric(TotalPM.BC.byVehicle, TotalPM.LA.byVehicle, by = "year"))

colnames(BC.LA.Totals)<- c("year","BC", "LA")
png(filename = "plot6.png", width = 480, height = 480, units = "px")


g<- ggplot(BC.LA.Totals)+geom_bar(aes(x = factor(year), y= LA,  fill = "LA"),stat= "identity")+ 
        geom_bar(data = BC.LA.Totals, aes(x = factor(year), y= BC, fill = "BC") , stat = "identity")+
        labs(x = "year", y = "Total PM2.5 (tons)", title = "Comparison of Total PM2.5 from Vehicles in Baltimore City
             \n and Los Angeles County")+
        guides(fill = guide_legend(title = "Location"))+
        
print(g)        
dev.off()