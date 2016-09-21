library('syuzhet')
library('readr')
library('ggplot2')
library('rvest')

sentiment <- function(name) {
  text.data <- read_file(paste0(name, '.txt'))
  text.lines <- get_sentences(text.data)
  syuzhet.vector <- get_sentiment(text.lines, method='syuzhet')
  list(name=name, text.lines=text.lines, text.sentiment=syuzhet.vector)
}

ggplot(data.frame(x=fed.sentiment$text.sentiment), aes(x=x)) + geom_histogram(binwidth=.25)
ggplot(data.frame(x=apple.sentiment$text.sentiment), aes(x=x)) + geom_histogram(binwidth=.25)

fomc.minutes.site <- read_html('https://www.federalreserve.gov/monetarypolicy/fomccalendars.htm')
fomc.links <- fomc.minutes.site %>% html_nodes(".minutes a:nth-child(2)") %>% html_attr('href')
