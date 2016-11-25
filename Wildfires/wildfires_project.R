#read in wildfires.csv
train = read.csv("~/Data Science/Group Project 1/wildfires.csv")

#TASK1#

#best Subset Selection
library(leaps)
regfit.full=regsubsets(burned~.-wlf, data=train, nvmax=15)
reg.summary=summary(regfit.full)
reg.summary

#plot RSS, adjusted R^2, Cp, and BIC
par(mfrow=c(2,2))
plot(reg.summary$rss, xlab="Number of Variables", ylab="RSS")
plot(reg.summary$adjr2, xlab="Number of Variables", ylab="Adjusted RSq")
plot(reg.summary$cp, xlab="Number of Variables", ylab="Cp")
plot(reg.summary$bic, xlab="Number of Variables", ylab="BIC")

#find max # of predictors for each method
which.min(reg.summary$rss)
which.max(reg.summary$adjr2)
which.min(reg.summary$cp)
which.min(reg.summary$bic)

#create a function for regsubsets
predict.regsubsets=function(object,newdata,id,...){
  form=as.formula(object$call[[2]])
  mat=model.matrix(form,newdata)
  coefi=coef(object, id=id)
  xvars=names(coefi)
  mat[,xvars]%*%coefi
}

#choose a model using cross validation
k=10
set.seed(1)
folds=sample(1:k,nrow(train),replace=TRUE)
cv.errors=matrix(NA,k,15, dimnames=list(NULL, paste(1:15)))

#for loop that performs cross-validation
for(j in 1:k){
  best.fit=regsubsets(burned~.-wlf,data=train[folds!=j,], nvmax=15)
  for(i in 1:15){
    pred=predict(best.fit,train[folds==j,],id=i)
    cv.errors[j,i]=mean((train$burned[folds==j]-pred)^2)
  }
}

#average over columns of this matrix
mean.cv.errors=apply(cv.errors,2,mean)
mean.cv.errors
which.min(mean.cv.errors)

#cross-validation says we should use a 6 variable model
#perform best subset selection on the full data set to get the 6 variable model
model1=regsubsets(burned~.-wlf,data=train, nvmax=15)
coef(model1,6)

#TASK2#

#lasso
x = model.matrix(wlf~.,train)
y = train$wlf

library(glmnet)
grid = 10^seq(1,-5, length = 20000)
lasso = glmnet(x,y,alpha=1, lambda=grid)

head(grid)
tail(grid)

crossvalidation = cv.glmnet(x,y,alpha = 1, lambda=grid)
plot(crossvalidation)
bestlam = crossvalidation$lambda.min
bestlam
model2 = predict (lasso ,type="coefficients",s=bestlam)[1:25,]
model2

