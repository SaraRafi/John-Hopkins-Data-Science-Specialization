rankhospital <- function(state, outcome, num="best") 
{
  ## Read outcome data
  data<- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  statedata<-subset(data,State == state)
  
  ColName <- ""
  if (outcome == "pneumonia")
    ColName <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  else if (outcome == "heart attack")
    ColName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  else if (outcome == "heart failure")
    ColName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  else
    stop("invalid outcome")
  
  
  MortalityRates <- subset(statedata, select=c(ColName, "Hospital.Name"))
  colnames(MortalityRates)[1] <- "condition"
  
  if (num == "best")
  {
    order.pop <- order(MortalityRates$condition)
    MortalityRates<-MortalityRates[order.pop,]
  }
  else if (num == "worst")
  {
    order.pop <- order(MortalityRates$condition)
    MortalityRates<-MortalityRates[order.pop,]
  }
  else if (is.numeric(num))
  {
    order.pop <- order(MortalityRates$condition)
    MortalityRates<-MortalityRates[order.pop,]
  }
  else
    error("Invalid ranking.")
  
#  if (num < length(MortalityRates))
  {
    HospitalName <- droplevels(MortalityRates$Hospital.Name[num])
    as.character(HospitalName)
    
  }
#  else
#    message("NA")
  
}
  
  
  