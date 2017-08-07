library(RJSONIO)
citycycle <- jsonlite::fromJSON('~/citycycle.json')
head(as.data.frame(unlist(citycycle)))
