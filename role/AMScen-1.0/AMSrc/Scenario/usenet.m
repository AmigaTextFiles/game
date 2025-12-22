Print("Creating the usenet news and email facilities.\n").

private tp_news CreateTable().
use tp_news
source st:Scenario/news.m
source st:Scenario/email.m
unuse tp_news
