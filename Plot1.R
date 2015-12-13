library(dplyr)

createPlot1 = function(filename = "household_power_consumption.txt"){
    .createPlot1(.readData(filename))
}

#read data from current wd
.readData = function(filename){
    #read data and subset accordingly
    data_df <- tbl_df(data.table::fread(filename, sep = ";"))
    data_df$Date <- as.Date(data_df$Date, format = "%d/%m/%Y")
    data <- data_df %>% subset(Date == "2007-02-01" | Date == "2007-02-02")
    
    #set correct class of variables for plotting
    data$Global_active_power <- as.numeric(data$Global_active_power)
    
    data
} 

.createPlot1 = function(df){
    png("Plot1.png")
    hist(df$Global_active_power, col ="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
    dev.off()
}
