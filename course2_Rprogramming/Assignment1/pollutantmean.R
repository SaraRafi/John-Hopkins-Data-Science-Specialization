pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  global_sum <- 0;
  global_count <- 0;
  
  for (i in 1:length(id)) {
    
    id_ <- formatC(id[i], width=3, flag="0");
    filename <- paste(id_, "csv", sep = ".");
    filename <- paste(directory, filename, sep="/");
    mydata <- read.csv(filename);
    
    if (pollutant == "sulfate")
    {
      mydata <- mydata[,2];
    }
    else if (pollutant == "nitrate")
    {
      mydata <- mydata[,3];
    }
    
    num_observations <- length(which(!is.na(mydata)));
    sum_observations <- sum(mydata, na.rm=TRUE);
    
    global_sum <- global_sum + sum_observations;
    global_count <- global_count + num_observations;
  }
  
  average <- global_sum/global_count;
  return(average)
}
