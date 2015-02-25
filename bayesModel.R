library(softImpute)
library(hash)
library(lme4)
library(randomForest)
library(plyr)
library(ggplot2)
revs = read.csv("~/Desktop/yelp/cleanedReviews.csv")
bus = read.csv("~/Desktop/yelp/cleanedBus.csv")

revs$day = revs$date - min(revs$date)
quantile(revs$day, seq(0,1,0.05))
hist(revs$day)
#Restrict to days after 2572 days for simplicity
revs = revs[revs$day >= 2572,]
#Restrict to business with at least 5 reviews
revs = revs[revs$bCount >= 5,]
#Consider users with <=20 reviews to be identical
revs[revs$uCount <=  20,"uid"] = 0

#Will look at change in ratings over time
revs$dayAdj = scale(revs$day)

#Test set is last year
now = max(revs$day)

revs = revs[order(revs["day"]),]
test = revs[revs$day >= now - 365,]

m = lmer(stars ~  (1|category),revs[revs$day < now - 365,])
revs[revs$day < now - 365,"cat"] = fitted(m)
test[["cat"]] = predict(m, test, allow.new.levels = TRUE)
a = 2
days = seq(now - 365, now, a)
names = c("stars", "category", "bid", "dayAdj", "movingAvg", "cat", "day")
for(day in days){
  print(date())
  print(day)
  tr = revs[revs$day < day,names]
  te = test[test$day %in% day:(day + a - 1),names]
  m = lmer(stars ~  1 +  (1|bid),tr)
  test[test$day %in% day:(day + a - 1),"basic"] = predict(m, te, allow.new.levels = TRUE)          
  s = test[test$day <= (day + a - 1) & !(test$movingAvg  %in% c(Inf,-Inf)), c("stars", "basic", "movingAvg")]
  print(1000*round(cor(s["stars"], s[c("movingAvg", "basic")]),3))
}
