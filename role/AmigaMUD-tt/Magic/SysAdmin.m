/*
 * magic/SysAdmin.m
 */

/**** Foreward
*This initialises SysAdmin as a mage, and creates clones of the
*three grimoires, placing them in SysAdmin's study.
*It was just a "hook" used during development and testing.
*I have included it to help you familiarise yourself with the
*magic system before deciding how to incorporate it into your
*mud.
*Note : I guess you should lock SysAdmin's study
****/

/**** make clones for sys admin ****/

use tp_mall
AddTail(r_SysAdminsStudy@p_rContents,MakeGrimoire(o_grimoire0)).
AddTail(r_SysAdminsStudy@p_rContents,MakeGrimoire(o_grimoire1)).
AddTail(r_SysAdminsStudy@p_rContents,MakeGrimoire(o_grimoire2)).

/* Turn SysAdmin into a Mage */
CharacterThing(SysAdmin)@p_pLearnt  := CreateThingList().
CharacterThing(SysAdmin)@p_pManaMax := 100.
CharacterThing(SysAdmin)@p_pManaNow := 100.
AddPlayerEnterChecker(CharacterThing(SysAdmin), recoverManaCheck, false).
AddStatAction(CharacterThing(SysAdmin), showStatsMage, false).
unuse tp_mall

/**** End of file ****/

