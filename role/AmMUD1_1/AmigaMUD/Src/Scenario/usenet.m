Print("Creating the usenet news and email facilities.\n")$

private tp_news CreateTable()$
use tp_news
source AmigaMUD:Src/Scenario/news.m
source AmigaMUD:Src/Scenario/email.m
unuse tp_news
