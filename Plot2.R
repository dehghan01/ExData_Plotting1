library(dplyr)

createPlot2 = function(filename = "household_power_consumption.txt"){
    .createPlot2(.readData(filename))
}

.readData = function(filename){
    #read data and subset accordingly
    data_df <-read.table(filename, sep=";", header=TRUE,na.strings="?")
    data_df$Date <- as.Date(data_df$Date, format = "%d/%m/%Y")
    data <- data_df %>% subset(Date == "2007-02-01" | Date == "2007-02-02")
    
    #create new datetime variable
    data <-  data %>% mutate(DateTime = paste(data$Date, data$Time)) %>% select(Global_active_power:DateTime)
    data$DateTime <- strptime(data$DateTime, format = "%Y-%m-%d %H:%M:%S")
    
    data
}

.createPlot2 = function(df){
    png("Plot2.png")
    plot(df$DateTime, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
    dev.off()
}
