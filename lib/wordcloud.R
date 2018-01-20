# 20180118 the first step for some basic analysis, start from the wordcloud

load("lib/20180118.RData")
library(tm)
library(data.table)
content.p <- TermDocumentMatrix(contents,
                                control = list(removePunctuation = TRUE,
                                               stopwords = TRUE, 
                                               tolower = TRUE, 
                                               stemming = TRUE, 
                                               removeNumbers = TRUE, 
                                               bounds = list(local = c(3, Inf))))

myTdm <- as.matrix(content.p)
FreqMat <- data.frame(Term = rownames(myTdm), 
                      Freqence = rowSums(myTdm), 
                      row.names = NULL)
FreqMat <- FreqMat[order(FreqMat$Freqence), ]

library(wordcloud)
wordcloud(FreqMat$Term, FreqMat$Freqence, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
# as for now, I can create the basic wordcloud for the speeches as a whole, then I may label the words for different years and different 


dirandname <- DirSource(txt.path)
names <- list.files(path = txt.path, pattern = "txt$")

# split the documents by presidents' names
names.clean <- gsub(names, pattern = "inaug", replacement = "")
names.clean <- gsub(names.clean, pattern = ".txt", replacement = "")
names.clean <- gsub(names.clean, pattern = "-[0-9]", replacement = "")
unique.names <- unique(names.clean)

# get a function to select the names out
select_name <- function(pattern){
  names <- list.files(path = txt.path, pattern = "txt$")
  return(names[as.vector(grep(names, pattern = pattern))])
}
# also a function to select the directory and name for Corpus() function
select_dirandname <- function(pattern){
  dirandnames <- DirSource(txt.path)$filelist
  return(dirandnames[as.vector(grep(dirandnames, pattern = pattern))])
}

filenames.by.name <- apply(as.data.frame(unique.names), 1, FUN = select_name)
dirandname.by.name <- apply(as.data.frame(unique.names), 1, FUN = select_dirandname)
# then reproduce the work as in step one
# but the Corpus are splited by names.cleaned

library(plyr)
library(dplyr)
library(topicmodels)
library(tidytext)

# so here I make a function to select the specific parts of speeches and then make a wordcloud based on that.

clean.from.corpus <- function(contents){
  # here the input of the function needs to be a Corpus
  # the output of the function is a FreqMat has two columns, Term and Frequence
  content.p <- TermDocumentMatrix(contents,
                                  control = list(removePunctuation = TRUE,
                                                 stopwords = TRUE, 
                                                 tolower = TRUE, 
                                                 stemming = TRUE, 
                                                 removeNumbers = TRUE, 
                                                 bounds = list(local = c(1, Inf))))
  
  myTdm <- as.matrix(content.p)
  FreqMat <- data.frame(Term = rownames(myTdm), 
                        Frequence = rowSums(myTdm), 
                        row.names = NULL)
  FreqMat <- FreqMat[order(FreqMat$Frequence), ]
}
  
# read the csv file splited by the author:

# initialize one data.frame
FreqMat.total <- data.frame(matrix(ncol = 3))
colnames(FreqMat.total) <- c('Term', 'Frequence', 'name')

for(i in 1:length(names.clean)){
  # calculate each list element
  dir.tmp <- DirSource(txt.path, pattern = names.clean[i])
  contents.tmp <- Corpus(dir.tmp)
  FreqMat.tmp <- clean.from.corpus(contents.tmp)
  FreqMat.tmp$name <- names.clean[i]
  FreqMat.total <- rbind(FreqMat.total, FreqMat.tmp)
}

write.csv(FreqMat.total, file = "data/splited.authors.csv")

library(wordcloud)
wordcloud.by.factor <- function(factor.vec){
  FreqMat <- subset(FreqMat.total, name == factor.vec)
  wordcloud(FreqMat$Term, FreqMat$Freqence, min.freq = 2,
            max.words=200, random.order=FALSE, rot.per=0.35,
            colors=brewer.pal(8, "Dark2"))
}

# todo, not finished, maybe I can split the speeches by time and period to create the wordcloud, but the wordcloud visualization are really not so good, I prefer to work on the sentiment analysis and topic modelling first.


save.image("data/20180119.RData")