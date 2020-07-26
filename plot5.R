## Jesse Brandon Wheeler
## Exploratory Data Analysis
## 07/22/2020
##
##
##
## Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
##
##
## Answer:  Vehice emissions have decreased over time from 199 to 2008.
##
## Load necessary plotting and data libraries
library(ggplot2)
library(plyr)
## Get the necessary files | Check file existence | If No - download then unzip.
## Download The zipped files, verify existance after setting to my default data folder
setwd("c:/users/jbwhe/documents/training/data") ## set working directory for data 
if(!(file.exists("summarySCC_PM25.rds") && 
     file.exists("Source_Classification_Code.rds"))) { 
        myZipFile <- "NEI_data.zip"
        if(!file.exists(myZipFile)) {
                zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
                download.file(url=zipURL,destfile=myZipFile,method="curl")
        }  
        unzip(myZipFile) 
}
##
##
## Read the datafiles into datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##
## View the file records for load validation
head(NEI)
head(SCC)
##
##
## Create a subset of data containing the vehicles 
## Assumption is EISector labeled "vehicle"
vehicle<-grepl(pattern = "vehicle", SCC$EISector, ignore.case = TRUE)
vehicleSCC <- SCC[vehicle,]$SCC
##
##
## using this boolean vector get the interested rows from the baltimore data
vehicleSSC <- NEIdata[NEIdata$SCC %in% vehicleSCC, ]
vehicleBaltimore <- subset(vehicleSSC, fips == "24510")
vehicleBaltimoreTotEm<-aggregate(Emissions~year, vehicleBaltimore, sum)
##
##
bPlot<-ggplot(aes(year, Emissions/10^5), data=vehicleBaltimoreTotEm)
bPlot+geom_bar(stat="identity",fill="grey",width=0.75) +
        guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))