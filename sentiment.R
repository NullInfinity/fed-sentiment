library('syuzhet')
library('readr')
library('ggplot2')
library('rvest')
library('magrittr')

sentiment <- function(report.date) {
  site <- read_html(paste0('https://www.federalreserve.gov/monetarypolicy/fomcminutes', report.date, '.htm'))
  text.data <- site %>% html_nodes("#leftText") %>% html_text()
  text.lines <- get_sentences(text.data)
  syuzhet.vector <- get_sentiment(text.lines, method='syuzhet')
  syuzhet.vector
}

fomc.minutes.site <- read_html('https://www.federalreserve.gov/monetarypolicy/fomccalendars.htm')
fomc.links <- fomc.minutes.site %>% html_nodes(".minutes a:nth-child(2)") %>% html_attr('href')
fomc.dates <- sapply(fomc.links, . %>% gsub(pattern='/monetarypolicy/fomcminutes|.htm', replacement='', .))

sentiments <- lapply(X=fomc.dates, FUN=sentiment)
names(sentiments) = fomc.dates
