/* Copyright (c) 1992 by Michael J. Roberts.  All Rights Reserved. */
/*
    This file contains the sample game described in TADS.DOC, and
    chapter 1 of the TADS Author's Manual.  The finished game, with the
    complete "gold skull" puzzle, is included here.  
*/

/* This is a comment, just like in C */
#include <adv.t>              /* read basic adventure game definitions file */
#include <std.t>                   /* read starting standard functions file */

startroom: room                      /* the game always starts in startroom */
   sdesc = "Outside cave"              /* the Short DESCription of the room */
   ldesc = "You're standing in the bright sunlight just
            outside of a large, dark, forboding cave, which
            lies to the north."
   north = cave                 /* the room called "cave" lies to the north */
;

cave: room
   sdesc = "Cave"
   ldesc = "You're inside a dark and musty cave.  Sunlight
            pours in from a passage to the south."
   south = startroom
;

pedestal: surface, fixeditem
   sdesc = "pedestal"
   noun = 'pedestal'
   location = cave
;

goldSkull: item
   sdesc = "gold skull"
   noun = 'skull' 'head'
   adjective = 'gold'
   location = pedestal
   doTake(actor) =
   {
      if (self.location <> pedestal or smallRock.location = pedestal)
      {
         pass doTake;
      }
      else
      {
         "As you lift the skull, a volley of poisonous
         arrows is shot from the walls!  You try to dodge
         the arrows, but they take you by surprise!";
         die();
      }
   }
;

smallRock: item
   sdesc = "small rock"
   noun = 'rock'
   adjective = 'small'
   location = cave
;
