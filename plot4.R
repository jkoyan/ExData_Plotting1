#The function creates the Plot4.png file with the meter readings across the Y axis by day
createPlot4 <- function(workingdir="C:\\_R\\Exploratory Data Analysis\\Course Projects\\1 ExData\\ExData_Plotting1")
{
    if(!file.exists(workingdir)){
        print(paste("The working directory ",workingdir,"does not exist. Please supply a valid working directory.",sep=" "))
    }
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
    data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
    data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
    data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
    dateTimes <- paste(as.character(data$Date),data$Time,sep=" ")
    data <- mutate(data,Day=wday(data$Date,label=TRUE),DateTime=ymd_hms(paste(as.character(data$Date),data$Time,sep=" ")))
    data$Day <- gsub("^Thurs","Thu",data$Day)
    data <-group_by(data,Day)
    
    if(file.exists("plot4.png"))
    {
        print("The file plot4.png already exists in the working directory, deleting the file before creating a new plot.")
        unlink("plot4.png")
    }
    #data
    png(file = "plot4.png",width = 480, height = 480, bg = "white")
    par(mfrow=c(2,2))
    par(mar=c(4,4,2,2))
    plot(data$DateTime,data$Global_active_power,xlab=" ",ylab="Global active power",type="l")
    plot(data$DateTime,data$Voltage,xlab="datetime",ylab="Voltage",type="l")
    with(data,plot(data$DateTime,data$Sub_metering_1,main=" ",xlab=" ",ylab="Energy sub metering",type="l",col="black"))
    with(subset(data),lines(data$DateTime,data$Sub_metering_2,col="red"))
    with(subset(data),lines(data$DateTime,data$Sub_metering_3,col="blue"))
    legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1, lty=1 )
    plot(data$DateTime,data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")
    dev.off()
    
}