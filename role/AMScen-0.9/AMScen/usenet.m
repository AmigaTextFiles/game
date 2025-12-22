Print("Creating the usenet news and email facilities.\n").

private tp_news CreateTable().
use tp_news
source st:news.m
source st:email.m
unuse tp_news
