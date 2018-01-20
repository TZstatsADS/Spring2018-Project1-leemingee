##### 01182018
first downloaded at 01172018, and I'm working on the idea part, namely, what can I do with these datasets?

The task from the proj description:
You are tasked to explore the texts using tools from text mining and natural language processing such as sentiment analysis, topic modeling, etc, all available in `R` and write a small story about inaugural speeches of U.S. presidents on interesting trends and patterns identified by your analysis. 

So I need to do some basic data work, maybe some visualization will help


##### 01192018
As I created the wordcloud for the txt files as a whole as well as for each year yesterday, maybe I can play some NLP tricks such as sentiment analysis, topic modeling today.

Links: 
[Topic modeling](https://cran.r-project.org/web/packages/topicmodels/vignettes/topicmodels.pdf)
+ [Clustering](http://www.statmethods.net/advstats/cluster.html)
+ [Sentiment analysis of Trump's tweets](https://www.r-bloggers.com/sentiment-analysis-on-donald-trump-using-r-and-tableau/)

the reference during the process:
+ [tidy text-mining Book Online](https://www.tidytextmining.com/topicmodeling.html)

To be honest, I admitted that the tm package may be faster and more powerful, but the tidytext package are more easy to learn and to implement.

###### 01202018
Also, the packages like topicmodels, tidytext are all build under R version 3.4.2

I merge the two datasets and get four properties can be used for logistic regression or classification.