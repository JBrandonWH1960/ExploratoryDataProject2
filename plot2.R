## Jesse Brandon Wheeler
## Exploratory Data Analysis
## 07/22/2020
##
## Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland fips == "24510") from 
## 1999 to 2008? Use the base plotting system to make a plot answering this question.
##
## Answer: Emissions decreased from 199 to 2002 | 2005 an Increase | followed by decrease
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
## Read the data files into datasets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
##
## View the file records for load validation
head(NEI)
head(SCC)
## Get a subset of fips data = "24510" | Baltimore City, Maryland
## Create an aggregation by summing emisions for each year. 
NEIBaltimore<-subset(NEIdata, fips == "24510")
totalBaltimoreEmissions <- aggregate(Emissions ~ year, NEIBaltimore, sum)
totalBaltimoreEmissions
##
##
##
## Create a bar plot showing Baltimore City Maryland Emissions by Year.
barplot(
        (totalBaltimoreEmissions$Emissions)/10^6,
        names.arg=totalBaltimoreEmissions$year,
        xlab="Year",
        ylab="PM2.5 Emissions (10^6 Tons)",
        main="Total PM2.5 Emissions From All Baltimore City Sources"
)