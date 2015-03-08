createPlot2 <- function(workingdir="C:\\_R\\Exploratory Data Analysis\\Course Projects\\1 ExData\\ExData_Plotting1")
{
    setwd(workingdir)
    library(stringr)
    library(lubridate)
    library(dplyr)
    file <-paste0(workingdir,"\\household_power_consumption.txt")
    data <- read.csv(file,sep=";",header=TRUE)
    data$Date <- dmy(data$Date)
    l <- (data$Date == ymd("2007-02-01") | data$Date == ymd("2007-02-02"))
    data <- data[which(l),]
    data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
    
    data <- mutate(data,Day=wday(data$Date,label=TRUE))
    #plot(d$Day,d$Global_active_power,ylab="Gloabl active power (kilowatts)"type="s")
    #png(file = "plot1.png",width = 480, height = 480, bg = "white")
    #hist(data$Global_active_power,xlab="Gloabl active power (kilowatts)",main="Global Active Power",col="red")
    #dev.off()
    
}