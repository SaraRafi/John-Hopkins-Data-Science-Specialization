
library(ggplot2) 



set.seed(1)

n<-40
numsim<-1000
lambda<-0.2

sim<-NULL


dataset<-matrix(rexp(n*numsim,lambda),numsim)


#####Equivalence of means

RowM <- rowMeans(dataset)

hist(RowM, col=rainbow(n))

x<-mean(RowM)

mean<-as.numeric(format(x, digits=3))

meanT<-as.numeric(format((1/0.2), digits=3))

#Row variables
mean
var<-var(RowM)
std<-sd(RowM)

#Theory variables
meanT
stdT<-((1/lambda) * (1/sqrt(n)))
varT<-stdT^2

######Equivalence of variance

var(RowM)

########Normal distribution

#convert to dataframe
RowMean<-apply(dataset,1,mean)

dfRowM<-data.frame(RowM)



mp<-ggplot(dfRowM,aes(x=RowM))
mp<-mp+geom_histogram(binwidth = lambda,fill="orange",color="black",aes(y = ..density..))
mp<-mp + labs(title="Density of 40 Numbers from Exponential Distribution", x="Mean of 40 Selections", y="Density")


mp<-mp+geom_vline(xintercept=mean, size=1.5,colour="green", linetype=1, show_guide=TRUE)
mp<-mp + stat_function(fun=dnorm,args=list(mean=mean, sd=std),color = "green", size = 1.5)

mp<-mp+geom_vline(xintercept=meanT, size=1.0,colour="blue", linetype=1, show_guide=TRUE)
mp<-mp + stat_function(fun=dnorm,args=list(mean=meanT, sd=stdT),linetype=1,color = "blue", size = 1.0)
mp


#
#mp<-mp + stat_function(fun=dnorm,args=list(mean=ActualMean, sd=ActualSD),color = "blue", size = 1.0)
#mp<-mp + geom_vline(xintercept=TheoryMean,size=1.0,color="yellow",linetype = "longdash")
#mp






for (i in 1:1000){
 sim<-c(sim,mean(rexp(n,lambda)))
}