# yelpBayes

This repository goes with the blog post: http://jonahsinick.com/bayesian-adjustment-of-yelp-ratings/. I made it to explore whether it's possible to adjust the "average number of stars" business ratings on Yelp to be closer to the ratings that users will give the businesses in the future.

I used the iPython Notebook processor2.ipynb to clean some of the data that Yelp published as a part of its dataset challenge: https://www.yelp.com/dataset_challenge/dataset (after first using Paul Butler's script https://gist.github.com/paulgb/5265767 to convert it from CSV to JSON).

The notebook is annotated. The most important thing is that the processed review table contains a "moving average" column that has the average of all star ratings that the business was given before the timestamp of the review.

The R script bayesModel.R	can be used to do a sort of exhaustive cross validation of a Bayesian model that I fit using the R library lm4e.

I used the drawGraphs.R script to generate graphics.
