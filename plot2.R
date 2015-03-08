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
    dateTimes <- paste(as.character(data$Date),data$Time,sep=" ")
    data <- mutate(data,Day=wday(data$Date,label=TRUE),DateTime=ymd_hms(paste(as.character(data$Date),data$Time,sep=" ")))
    data$Day <- gsub("^Thurs","Thu",data$Day)
    data <-group_by(data,Day)
    data
    if(file.exists("plot2.png"))
    {
        print("The file plot2.png already exists in the working directory, deleting the file before creating a new plot.")
        unlink("plot2.png")
    }
    png(file = "plot2.png",width = 480, height = 480, bg = "white")
    plot(data$DateTime,data$Global_active_power,xlab=" ",ylab="Global active power (kilowatts)",type="l")
    dev.off()
    
}