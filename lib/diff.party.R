# this file needs for the analysis of the diff parties and different years
# the key point is to create the functions to subset the dataset automatically by the factor I choose
# then I can just apply the functions I wrote in wordcloud file

# 01192018 Ming Li
load("data/20180119.RData")

# So here I will use the dates and general.info file
# combine them with the original text file, we may find something

unique.party <- unique(general.info$Party)
unique.party
summary(as.numeric(general.info$Words))
unique.president <- unique(general.info$President)
unique.president
