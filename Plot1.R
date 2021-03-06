## Jesse Brandon Wheeler
## Exploratory Data Analysis
## 07/22/2020
##
##
## Question 1
## Plot 1 Question:  Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, make a plot showing the total 
## PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
##
##
## Answer: Total decreased in the USA from 1999 to 2008
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
## Converting "year", "type", "Pollutant", "SCC", "fips" to factor
colToFactor <- c("year", "type", "Pollutant","SCC","fips")
NEI[,colToFactor] <- lapply(NEI[,colToFactor], factor)
head(levels(NEI$fips))
##
##
## Data Clean - Remove extra spaces NA
levels(NEI$fips)[1] = NA
NEIdata<-NEI[complete.cases(NEI),]
colSums(is.na(NEIdata))
##
##
##Create aggregation of the data
totalEmission <- aggregate(Emissions ~ year, NEIdata, sum)
totalEmission
##
##
##Create Bar Plot of the Emissions
barplot(
        (totalEmission$Emissions)/10^6,
        names.arg=totalEmission$year,
        xlab="Year",
        ylab="PM2.5 Emissions (10^6 Tons)",
        main="Total PM2.5 Emissions From All US Sources"
)