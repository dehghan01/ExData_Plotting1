library(dplyr)

createPlot3 = function(filename = "household_power_consumption.txt"){
    .createPlot3(.readData(filename))
}

.readData = function(filename){
    #read and subset data
    data_df <-read.table(filename, sep=";", header=TRUE,na.strings="?")
    data_df$Date <- as.Date(data_df$Date, format = "%d/%m/%Y")
    data <- data_df %>% subset(Date == "2007-02-01" | Date == "2007-02-02")
    
    #create new datetime variable
    data <-  data %>% mutate(DateTime = paste(data$Date, data$Time)) %>% select(Global_active_power, Voltage, Sub_metering_1:DateTime)
    data$DateTime <- strptime(data$DateTime, format = "%Y-%m-%d %H:%M:%S")
    
    data
}

.createPlot3 = function(data){
    png("Plot3.png")
    plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(data$DateTime, data$Sub_metering_2, col = "red")
    lines(data$DateTime, data$Sub_metering_3, col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col = c("black", "red", "blue"))
    dev.off()
}
