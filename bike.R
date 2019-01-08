# Importing the dataset
data=read.csv('bike_trip.csv')


#Data Cleaning
data=data[,c(1,4,6,9)]
data$Member.type=factor(data$Member.type,levels = c('Casual','Member','Unknown'),labels=c(1,2,3))

#Data Spliting
library(caTools)
split=sample.split(data$Member.type,SplitRatio = 0.8)
train=subset(data,split==T)
test=subset(data,split==F)


#Feature Scaling
train[-4]=scale(train[-4])
test[-4]=scale(test[-4])


# Fitting Random Forest Classification to the Training set
# install.packages('randomForest')
library(randomForest)
classifier = randomForest(x = train[-4],
                          y = train$Member.type,
                          ntree = 300)

# Predicting the Test set results
y_pred = predict(classifier, newdata = test[-4])

# Making the Confusion Matrix
cm = table(test[, 4], y_pred)

#Writing Data
write.csv(train,"train.csv")
write.csv(test,"test.csv")
write.csv(y_pred,"pred.csv")
