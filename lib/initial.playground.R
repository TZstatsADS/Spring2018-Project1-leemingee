packages.used=c("data.table", 
                "dplyr", 
                "plyr",
                "tidytext",
                "tm",
                "readxl",
                "wordcloud",
                "lubridate")

# check packages that need to be installed.
packages.needed=setdiff(packages.used, 
                        intersect(installed.packages()[,1], 
                                  packages.used))
# install additional packages
if(length(packages.needed)>0){
  install.packages(packages.needed, dependencies = TRUE)
}

# load packages
library(data.table)
library(dplyr)
library(plyr)
library(tidytext)
library(tm)
library(readxl)
library(wordcloud)
library(lubridate)
