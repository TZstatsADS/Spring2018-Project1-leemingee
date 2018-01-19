# 20180118 the first step for some basic analysis, start from the wordcloud

load("20180118.RData")
library(tm)
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
library(plyr)
library(dplyr)

library(topicmodels)