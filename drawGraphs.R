library(softImpute)
library(hash)
library(lme4)
library(randomForest)
library(plyr)
library(ggplot2)
revs = read.csv("~/Desktop/yelp/cleanedReviews.csv")
bus = read.csv("~/Desktop/yelp/cleanedBus.csv")

revs$day = revs$date - min(revs$date)
max(revs$day) == 3741
slice = revs[revs$day > (3741 - 366),]
slice = slice[c("bid", "stars", "category")]
m = lmer(stars ~ (1|category) + (1|bid),slice) 
slice$fitted = fitted(m)

slice$idx = 1
agged = aggregate(slice[c("idx", "bid","stars", "fitted")], slice["bid"], FUN = sum)
agged$fitted = agged$fitted/agged$idx
agged["Review_Count"] = agged$idx
agged["Business_Average"] = agged$stars/agged$idx

l = nrow(agged)
ggplot(agged) + geom_point(aes(Business_Average, log(Review_Count),alpha=0.05)) + theme_bw(base_size = 15)

s = agged[log(agged$Review_Count) > 3,]
ggplot(s) + geom_density(aes(Business_Average),alpha=0.3,fill="green") + theme_bw(base_size = 15)


starAvg = ggplot(agged)  + geom_density(aes(stars,alpha=0.1), fill="red") + theme_bw(base_size =14)  + theme(legend.position = "none")
starAvg
starAvg + geom_density(aes(fitted,alpha=0.1), fill="blue")

