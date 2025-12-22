Print("Creating basic scenario constructs, tools and commands.\n").

/* tp_misc is used for symbols that are used in several files, but which are
   not wanted to be public. */
private tp_misc CreateTable().
use tp_misc

/* Basic properties and their accessing routines. Direction stuff. */
public t_base CreateTable().
use t_base
source st:Basics/base.m

/* Routines to do the graphics styles used in this scenario. */
public t_graphics CreateTable().
use t_graphics
source st:Basics/graphics.m

/* Routines for dealing with icons. */
public t_icons CreateTable().
use t_icons
source st:Basics/icons.m

/* General utility stuff, banks, stores, top-level parser, setup, etc. */
public t_util CreateTable().
public t_roomTypes CreateTable().
use t_util
use t_roomTypes
source st:Basics/util1.m
source st:Basics/util2.m

/* verbs.m needed early because of dependencies in quests.m, fight.m */
/* The basic verbs in the scenario. */
source st:Basics/verbs.m

/* The 'chat' command, and a bunch of pose stuff. */
source st:Basics/chat.m

/* The quest utilities - Questor, list of quests, etc. */
public t_quests CreateTable().
use t_quests
source st:Basics/quests.m
