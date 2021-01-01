best <- function(state, outcome) 
{
  if (state == "NN")
    stop("invliad state")
  
  ## Read outcome data
  data<- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  statedata<-subset(data,State == state)
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  ColName <- ""
  if (outcome == "pneumonia")
    ColName <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  else if (outcome == "heart attack")
    ColName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  else if (outcome == "heart failure")
    ColName <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  else
    stop("invalid outcome")
  
  MortalityRates <- statedata[,ColName]
  MortalityRates <- as.numeric(as.character(MortalityRates))
  MinMortalityRate <- min(MortalityRates, na.rm=TRUE)
  HospitalIndex <- which(MortalityRates==MinMortalityRate)
  HospitalName <- droplevels(statedata$Hospital.Name[HospitalIndex])
  as.character(HospitalName)
}
