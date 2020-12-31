corr <- function(directory, threshold = 0) {
  
  path <- paste(getwd(), directory, sep="/")
  csv_files <- list.files(path, pattern="*.csv")
  output <- numeric(0);
  for (i in 1:length(csv_files))
  {
    filename <- csv_files[i];
    full_name <- paste(directory, filename, sep="/")
    mydata <- read.csv(full_name);
    mydata <- mydata[,2:3];
    mydata <- mydata[complete.cases(mydata),]
    num_observations = dim(mydata)[1]
    if (num_observations >= threshold)
    {
      output[length(output)+1] <- cor(mydata[,1], mydata[,2]);
    }
  }
  output;
}
