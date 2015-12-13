library(dplyr)

createPlot4 = function(filename = "household_power_consumption.txt"){
    .createPlot4(.readData(filename))
}

.readData = function(filename){
    #read and subset data
    data_df <- tbl_df(data.table::fread(filename, sep = ";"))
    data_df$Date <- as.Date(data_df$Date, format = "%d/%m/%Y")
    data <- data_df %>% subset(Date == "2007-02-01" | Date == "2007-02-02")
    
    #create new datetime variable
    data <-  data %>% mutate(DateTime = paste(data$Date, data$Time)) %>% select(Global_active_power:DateTime)
    data$DateTime <- strptime(data$DateTime, format = "%Y-%m-%d %H:%M:%S")
    
    #set correct class of variables for plotting
    cols = c(1:7)
    data[,cols] <- apply(data[,cols], 2, function(x) as.numeric(x))
    
    data
}

.createPlot4 = function(data){
    png("Plot4.png")
    par(mfrow = c(2, 2))
    plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
    lines(data$DateTime, data$Sub_metering_2, col = "red")
    lines(data$DateTime, data$Sub_metering_3, col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), bty = "n", col = c("black", "red", "blue"))
    plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime")
    dev.off()
}