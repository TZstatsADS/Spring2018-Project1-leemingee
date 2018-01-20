# reviewed at 01202018, to generate the jpg files automatically
load("data/20180120.RData")
head(names)
library(plyr)
library(tm)
library(wordcloud)

picture.name <- gsub(names, pattern = ".txt", replacement = ".jpg")


fq.from.simplecorpus <- function(contents){
  ## Convert the object type
  contents <- Corpus(VectorSource(contents))
  
  # I don't know why, but here I must convert it to the Corpus object again
  # otherwise it will return the error calls:
  # "Error in UseMethod("TermDocumentMatrix", x) : 
  # no applicable method for 'TermDocumentMatrix' applied to an 
  # object of class "character"
  
  ## proprocess the contents, as I didn't use the content.p here.
  contents <- tm_map(contents, removeNumbers)
  contents <- tm_map(contents, removePunctuation)
  contents <- tm_map(contents, removeWords, stopwords("english"))
  contents <- tm_map(contents, stripWhitespace)
  
  ## convert to dtm and then it's easy
  dtm <- DocumentTermMatrix(contents)
  fq <- colSums(as.matrix(dtm))
  return(fq)
}

fq.list <- llply(contents, fq.from.simplecorpus)

# for each speech
for (i in 1:length(picture.name)){
  jpeg(file = paste("output/wordcloud/", picture.name[i], sep = ""))
  wordcloud(names(fq.list[[i]]), fq.list[[i]], 
            min.freq = 2, max.words=200, 
            random.order=FALSE, rot.per=0.35,
            colors=brewer.pal(8, "Dark2"))
  dev.off()
}

# for total speeches
jpeg(file = paste("output/wordcloud/", "total.jpg", sep = ""))
wordcloud(FreqMat$Term, FreqMat$Freqence, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))
dev.off()

