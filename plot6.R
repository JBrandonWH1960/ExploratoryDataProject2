## Jesse Brandon Wheeler
## Exploratory Data Analysis
## 07/22/2020
##
## Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == “06037”). 
## Which city has seen greater changes over time in motor vehicle emissions?
##
## Answer:  Los Angeles has seen greater changes over time with their vehicle emissions
##
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
vehicleBaltimore<-subset(vehicleSSC, fips == "24510")
vehicleBaltimore$city <- "Baltimore City"
vehicleLosA<-subset(vehicleSSC, fips == "06037")
vehicleLosA$city <- "Los Angeles County"
combinedCities <- rbind(vehicleBaltimore, vehicleLosA)
##
##
##
ggplot(combinedCities, aes(x=year, y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(.~city) +
        guides(fill=FALSE) + theme_bw() +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
        labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
##
##
aggregatedEmissions <- aggregate(Emissions~city+year, data=combinedCities, sum)
aggregate(Emissions~city, data=aggregatedEmissions, range)