training<-read.csv("pml-training.csv",header=T)
testing<-read.csv("pml-testing.csv",header=T)



library(caret);library(ggplot2)

# 1) remove unnecessary variables:

discard<-nearZeroVar(training)
newtrain<-training[,-discard]

newtrain<-newtrain[,-c(1:6)]	 # remove "X", "user name", "timestamp"...


# Preprocess:

preObj<-preProcess(newtrain[-94],method="knnImpute")
newtrain<-predict(preObj,newtrain)


# trying a model with tree:
mod<-train(classe~.,method="rpart",data=newtrain)

library(rattle)
fancyRpartPlot(mod$finalModel)   # this is not a good model since it will never predict value "C"

# Same process to the test set:
newtest<-testing[,-discard]
newtest<-newtest[,-c(1:6)]



preObj2<-preProcess(newtest[,-94],method="knnImpute")  
newtest<-predict(preObj,newtest[,-94])

pred<-predict(mod, newtest)

# some problems testing options and no time to finish

