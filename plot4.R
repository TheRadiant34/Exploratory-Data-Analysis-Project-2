if(!file.exists("./data")){dir.create("./data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

download.file(fileUrl,destfile="./data/ExDataProject.zip")

unzip("./data/ExDataProject.zip", exdir= "./data")

##data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")


## Question 4: Across the United States, how have emissions from 
##             coal combustion-related sources changed from 1999-2008?

## Answer:

mergedNEISCC<- merge(NEI, SCC, by = "SCC")

coal<- grepl("Coal", mergedNEISCC$Short.Name, ignore.case = T)

subset.coal<- mergedNEISCC[coal, ]

TotalPM.USA.coal<- aggregate(Emissions ~ year, subset.coal, sum)

png(filename = "plot4.png", width = 480, height = 480, units = "px")

plot(TotalPM.USA.coal$year, TotalPM.USA.coal$Emissions, type = "b", pch =19, main = "Emissions from Coal",
     ylab = "Total PM2.5 (tons)", xlab = "Year")

dev.off()
