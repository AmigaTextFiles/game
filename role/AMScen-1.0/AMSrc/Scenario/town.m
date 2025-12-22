Print("Creating the town area and populace.\n").

/* The minimall area. */
public t_mall CreateTable().
use t_mall
source st:Scenario/mall.m
unuse t_mall

/* The streets, park, out to the pear-tree field. */
public t_streets CreateTable().
use t_streets
source st:Scenario/streets.m
unuse t_streets

/* The squirrel quest. */
source st:Scenario/squirrel.m

/* Caretaker, Packrat. */
source st:Scenario/machines.m

/* Letter writing, posting, delivery; Postman. */
source st:Scenario/mail.m
