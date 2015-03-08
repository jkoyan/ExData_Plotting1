createPlot1 <- function(workingdir="C:\\_R\\Exploratory Data Analysis\\Course Projects\\1 ExData\\ExData_Plotting1")
{
    setwd(workingdir)
    library(stringr)
    library(lubridate)
    file <-paste0(workingdir,"\\household_power_consumption.txt")
    data <- read.csv(file,sep=";",header=TRUE)
    data$Date <- dmy(data$Date)
    l <- (data$Date == ymd("2007-02-01") | data$Date == ymd("2007-02-02"))
    data <- data[which(l),]
    data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
    #data
    png(file = "plot1.png",width = 480, height = 480, bg = "transparent")
    hist(data$Global_active_power,xlab="Gloabl active power (kilowatts)",main="Global Active Power",col="red")
    rect(1, 5, 3, 7, col = "white")
    dev.off()
    
}