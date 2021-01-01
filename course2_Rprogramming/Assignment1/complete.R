complete <- function(directory, id = 1:332) {
  
  output <- data.frame(id=numeric(0), nobs=numeric(0))
  
  for (i in 1:length(id)) 
  {
    id_ <- formatC(id[i], width=3, flag="0");
    filename <- paste(id_, "csv", sep = ".");
    filename <- paste(directory, filename, sep="/")
    mydata <- read.csv(filename);
    mydata <- mydata[,2:3];
    mydata <- mydata[complete.cases(mydata),]
    num_observations <- dim(mydata)[1]
    row <- data.frame(id=id_, nobs=num_observations)
    output<-rbind(output, row)
  }
  print(output)
}
