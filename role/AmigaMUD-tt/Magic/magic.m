/*
 * Amiga MUD 1.0
 *
 * Copyright (c) 1996 by Chris Gray
 */

/*
 * magic.m - Magic source
 */

Print("Creating the magic system.\n").

/* Use */
private tp_magic CreateTable().
use tp_magic
use t_base
use t_util
use t_fight
use tp_verbs
use Characters

/* Set up stuff */
source st:magic/base.m
source st:magic/langTrans.m
source st:magic/checker.m
source st:magic/character.m

source st:magic/list-mortal.m
source st:magic/list-divine.m

source st:magic/potion.m
source st:magic/scroll.m
source st:magic/wand.m

source st:magic/list-mana.m
source st:magic/grimoire.m

/* Sys Admin */
source st:magic/SysAdmin.m

/**************  Clean up **********/

unuse tp_verbs
unuse t_util
unuse t_base
unuse t_fight
unuse tp_magic
unuse Characters

