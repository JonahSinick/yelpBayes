# yelpBayes

This repository goes with the blog post:
http://jonahsinick.com/bayesian-adjustment-of-yelp-ratings/

I used the iPython Notebook processor2.ipynb to clean some of the data that Yelp published as a part of its dataset challenge:
https://www.yelp.com/dataset_challenge/dataset 
after first using Paul Butler's script to convert it from CSV to JSON:
https://gist.github.com/paulgb/5265767
The notebook is annotated. The most important thing is that the processed review table contains a "moving average" column that has the average of all star ratings that the business was given before the timestamp of the review.


The R script bayesModel.R	does a sort of exhaustive cross validation of a Bayesian model fit using the R library lm4e.

The R script drawGraphs.R has code that I used to produce the graphsin the images folder.

bayesModel.R	Added files	28 minutes ago
drawGraphs.R	Added files	28 minutes ago
processor2.ipynb	
