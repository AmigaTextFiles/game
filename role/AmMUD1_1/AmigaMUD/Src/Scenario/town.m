Print("Creating the town area and populace.\n")$

/* The minimall area. */
public t_mall CreateTable()$
use t_mall
source AmigaMUD:Src/Scenario/mall.m
unuse t_mall

/* The streets, park, out to the pear-tree field. */
public t_streets CreateTable()$
use t_streets
source AmigaMUD:Src/Scenario/streets.m
unuse t_streets

/* The squirrel quest. */
source AmigaMUD:Src/Scenario/squirrel.m

/* Caretaker, Packrat. */
source AmigaMUD:Src/Scenario/machines.m

/* Letter writing, posting, delivery; Postman. */
source AmigaMUD:Src/Scenario/mail.m
