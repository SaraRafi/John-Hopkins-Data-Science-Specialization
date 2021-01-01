setwd ("C://Users//Sara//Desktop//Sara//R Folder//Assignment3")

#######1. Plot mortality rates for heart attack
#outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
#head(outcome)
#outcome[, 11] <- as.numeric(outcome[, 11])
#hist(outcome[, 11])

#######2.
source("best.R")
 best("TX", "heart failure")
# best("MD", "heart attack")
# best("MD", "pneumonia")
# best("BB", "heart attack")
# best("NY", "hert attack")

#######3.
source("rankhospital.R")
#rankhospital("TX", "heart failure", "worst")
#rankhospital("TX", "heart failure", 4)