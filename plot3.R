## Jesse Brandon Wheeler
## Exploratory Data Analysis
## 07/22/2020
##
##
## Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 
## for Baltimore City? Which have seen increases in emissions from 1999–2008? 
## Use the ggplot2 plotting system to make a plot answer this question.
##
## Answer: Non-Road, Nonpoint, On-Road show decreases in total emissions | Point 
## show an increase from 1999 to 2005 then a decrase in 2008.
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
## Get a subset of fips data = "24510" | Baltimore City, Maryland
## Create an aggregation by summing emisions for each year. 
NEIBaltimore<-subset(NEIdata, fips == "24510")
totalBaltimoreEmissions <- aggregate(Emissions ~ year, NEIBaltimore, sum)
totalBaltimoreEmissions
##
##
##
## Create a bar plot showing Baltimore City Maryland Emissions by Year.
bPlot<-ggplot(aes(x = year, y = Emissions, fill=type), data=NEIBaltimore)
bPlot+geom_bar(stat="identity")+
        facet_grid(.~type)+
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))+
        guides(fill=FALSE)