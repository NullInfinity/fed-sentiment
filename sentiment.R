library('syuzhet')
library('readr')
library('ggplot2')

sentiment <- function(name) {
  text.data <- read_file(paste0(name, '.txt'))
  text.lines <- get_sentences(text.data)
  syuzhet.vector <- get_sentiment(text.lines, method='syuzhet')
  list(name=name, text.lines=text.lines, text.sentiment=syuzhet.vector)
}

apple.sentiment <- sentiment('apple')
fed.sentiment <- sentiment('fed')

ggplot(data.frame(x=fed.sentiment$text.sentiment), aes(x=x)) + geom_histogram(binwidth=.25)
ggplot(data.frame(x=apple.sentiment$text.sentiment), aes(x=x)) + geom_histogram(binwidth=.25)
