# the basic data manipulation and clean, maybe some visulization part included
# created on 01172018, Ming Li
library(xlsx)
library(data.table)
library(readxl)

dates <- fread("/Users/wanrenzhifeng/Git-leemingee/1/Spring2018-Project1-leemingee/data/InauguationDates.txt", stringsAsFactors = F)

general.info <- read_xlsx("/Users/wanrenzhifeng/Git-leemingee/1/Spring2018-Project1-leemingee/data/InaugurationInfo.xlsx")

# now for the text things
# here I used the most powerful one, the tm package

txt.path <- "/Users/wanrenzhifeng/Git-leemingee/1/Spring2018-Project1-leemingee/data/InauguralSpeeches/"

library(tm)
filenames <- list.files(path = txt.path, pattern = "txt$")
# speeches.number <- length(filenames)
# So I got 57 txt files, which is well organized due to the names of files are classified.

# head(filenames)
# then comes for the powerful package
contents <- Corpus(DirSource(txt.path))

# store the original files into one rdata for faster access next time.
save.image(file = "20180118.RData")

