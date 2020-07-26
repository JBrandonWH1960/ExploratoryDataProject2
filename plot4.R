## Jesse Brandon Wheeler
## Exploratory Data Analysis
## 07/22/2020
##
## Question 4
## Across the United States, how have emissions from coal 
## combustion-related sources changed from 1999–2008?
##
## Answer: Coal combustion has down a downward trend overall.  There is a bit of an increase
## from 2002 to 2005 but overall a decrease.
##
## Load necessary plotting and data libraries
library(ggplot2)
library(plyr)
# Get the necessary files | Check file existence | If No - download then unzip.
# Download The zipped files, verify existance after setting to my default data folder
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
## Data Cleanup - eliminate all \\ in the names
names(SCC)<-gsub("\\.","", names(SCC))
##
##
Combustion<-grepl(pattern = "comb", SCC$SCCLevelOne, ignore.case = TRUE)
Coal<-grepl(pattern = "coal", SCC$SCCLevelFour, ignore.case = TRUE)
## extracting the SCC in 
SCCCoalCombustion <-SCC[SCCcombustion & SCCCoal,]$SCC
NIECoalCombustionValues<-NEIdata[NEIdata$SCC %in% SCCCoalCombustionSCC,]
NIECoalCombustionTotal<-aggregate(Emissions~year, NIECoalCombustionValues, sum)
##
##
## Create the plot by subsetting NEI data with SCC data matching coal and combusions.
bPlot<-ggplot(aes(year, Emissions/10^5), data=NIECoalCombustionTotalEm)
bPlot+geom_bar(stat="identity",fill="grey",width=0.75) +
        guides(fill=FALSE) +
        labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
        labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))