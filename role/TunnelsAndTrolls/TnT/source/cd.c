#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Unofficial errata (%%):
 Applying to Corgi and FB versions:
  CD5/1E: There appears to be no way to reach this paragraph.
  CD25/4D: Casting Blasting Power here (while fighting Delverdinger)
   leads to room 66/8H (which is part of the Ythul encounter).
   There does not seem to be any appropriate paragraph existing in the
   module.
  CD134/18D: Says "amount of you missed the roll" instead "amount by
   which you missed the roll".
 Unofficial Corgi errata:
  On the 'Glib Tongue Table' (CDp71), "go to 97*" should be "go to 105".
 Official FB errata:
  On the 'Glib Tongue Table' page 29, "go to 119" should be "go to 13F".
 But this doesn't matter anyway because there is never any situation
  where "you haven't been told otherwise".

Ambiguities:
 We are allowing spellcasting during normal combat rounds, ignoring the Magic Matrix. We probably shouldn't allow this.
*/

#define COSTUME_PRISONER 0
#define COSTUME_SERVANT  1
#define COSTUME_VILLAGER 2
#define COSTUME_GUARD    3
#define COSTUME_OFFICER  4

MODULE const STRPTR cd_desc[CD_ROOMS] = {
{ // 0
#ifdef CORGI
"`INSTRUCTIONS\n" \
"  This is a solitaire adventure for single characters of humanoid type. Because costume changes are integral to the adventure, don't try running a troll or an ogre. For the sake of sense, play only a character *approximately* human-size: a short elf, tall dwarf, very tall hobbit, or (best of all) an ordinary human. You should be no higher than level 4 and have no more than 80 combat adds. Characters may only run this adventure once. Paragraphs marked with an asterisk are ones within which magic can be used.\n" \
"  Unless otherwise mentioned, standard T&T rules are in effect. Limited forms of magic are possible. [Check the Magic Matrix for a list of permissible spells. Use of prohibited spells will trigger an ancient Yvoiran curse, turning you into a herring (MR 2).\n" \
"  If you don't have a Speed (SP) rating, roll one up before starting; you'll need it (use the total of four dice). ]You may have the opportunity to change your appearance. At various times you could be dressed as a servant, a villager, or a guard. Changing costumes doesn't change your attributes, though. You retain your ratings and only look somewhat like a servant, villager, etc. Unisex is the current look so don't worry about the sex of the person from whom you obtain the costume. Attributes and accoutrements of guards, servants, and named personages are found in the Wandering Persons Table. You may only wear one costume or uniform at a time. You can't carry any with you.\n" \
"  Each class of people (in costume) has particularly appropriate weapons or tools. If you try to use improper tools you might get caught. It'll depend on how quickly you can talk your way out. To do this, consult the Glib Tongue Table.\n" \
"  When you first escape, you might be undetected awhile. However, if you kill anyone or are spotted, the alarum will be sounded. From then on, you must increase all saving rolls on Luck by one level. This penalty applies only while you're on the main level or parapet of the chateau.\n]" \
"[  If you return to a room housing a monster, named personage, or special item, nothing will be there the second time.\n]~" \
"INTRODUCTION\n" \
"  The Chateau d'Yvoire commands the western shores of Lake Lamarran and surrounding counties. The Chateau has an ancient history. When fortified with ale, the village ancients recite tales from their fathers describing the original denizens of the fortress - mages powerful in the ways of the Elder Ones. Some say strange forces are still at work within the castle's walls.\n" \
"  The Duc de Binaire has stolen the Chateau d'Yvoire and now counts it as his fief. You were hired by Gastar d'Alcene, the rightful Duc d'Yvoire. Before you could join Gastar, you were waylaid and currently sit at the bottom level of the castle donjon. You must escape or rot in the filth of the cell. Once free of the castle, you should be able to find a boat or horse to carry you to the camp of the rightful duke.\n" \
"  Now, gather your courage and go to {125}."
#else
"`INSTRUCTIONS\n" \
"  This is a solitaire adventure for single characters of humanoid type. Because costume changes are integral to the adventure, don't try running a troll or an ogre. For the sake of sense, play only a character *approximately* human-sized: a short elf, tall dwarf, very tall hobbit, or (best of all) an ordinary human. You should be no higher than level 4 and have no more than 80 combat adds. Characters may only run this adventure once.\n" \
"  Unless otherwise mentioned, standard T&T rules are in effect. Limited forms of magic are possible. [Check the Magic Matrix for a list of permissible spells. Use of prohibited spells will trigger an ancient Yvoiran curse, turning you into a herring (MR 2).\n" \
"  If you don't have a Speed (SP) rating, roll one up before starting; you'll need it (use the total of four dice).] You may have the opportunity to change your appearance. At various times you could be dressed as a servant, a villager, or a guard. Changing costumes doesn't change your attributes, though. You retain your ratings and only look somewhat like a servant, villager, etc. Unisex is the current look so don't worry about the sex of the person from whom you obtain the costume. Attributes and accoutrements of guards, servants, and named personages are found in the Wandering Persons Table. You may only wear one costume or uniform at a time. You can't carry any with you.\n" \
"  Each class of people (in costume) has particularly appropriate weapons or tools. If you try to use improper tools you might get caught. It'll depend on how quickly you can talk your way out. To do this, consult the Glib Tongue Table.\n" \
"  When you first escape, you might be undetected awhile. However, if you kill anyone or are spotted, the alarum will be sounded. From then on, you must increase all saving rolls on Luck by one level. This penalty applies only while you're on the main level or parapet of the chateau.\n" \
"[  If you return to a room housing a monster, named personage, or special item, nothing will be there the second time.\n]~" \
"INTRODUCTION\n" \
"  The Chateau d'Yvoire commands the western shores of Lake Lamarran and surrounding counties. The Chateau has an ancient history. When fortified with ale, the village ancients recite tales from their fathers describing the original denizens of the fortress - mages powerful in the ways of the Elder Ones. Some say strange forces are still at work within the castle's walls.\n" \
"  The Duc de Binaire has stolen the Chateau d'Yvoire and now counts it as his fief. You were hired by Gastar d'Alcene, the rightful Duc d'Yvoire. Before you could join Gastar, you were waylaid and currently sit at the bottom level of the castle donjon. You must escape or rot in the filth of the cell. Once free of the castle, you should be able to find a boat or horse to carry you to the camp of the rightful duke.\n" \
"  Now, gather your courage and go to {125}."
#endif
},
{ // 1/1A
"The strange creatures who roam Yvoire have diminished the night life. The tavern closes early. As you leave, you hear a sound in the shadows. Roll up a wandering person. Then you can go to the commons ({188}), towards the jetty ({183}), or deeper into the village ({178})."
},
{ // 2/1B
"If you're carrying a torch or lantern or if you make a Will-o-wisp or other flame, note this paragraph number and go to {150}. Otherwise, indistinguishable cavern passages lead to {39}, {75}, or {191}. A well seems to drop into this passage from above, but you can't negotiate its slimy walls."
},
{ // 3/1C
"You find a jewel but it slips from your hands. Scrambling after it you gather it up. As you straighten up, you stare into the stony eyes of a grumpy gargoyle, awakened when you removed the jewel. Go to {166}."
},
{ // 4/1D
"You're outside the armoury. You can try to sneak in by going to {101}. If you choose to move on, you can go to the inner courtyard at {131}, to the chateau stables at {175}, or towards the main gate at {31}."
},
{ // 5/1E
"The mist you passed through has had a strange effect. The argent fog has caused a befuddlement that threatens to unbalance your mind. Return from whence you came."
},
{ // 6/1F
"As a side effect, your spell has also put the horses to sleep. Since they're much weaker mentally, the effects last longer.\n" \
"  Roll one die for the number of additional turns you have to wait. On each turn, make a level 3 saving roll on LK (30 - LK). If you miss a saving roll the village patrol appears. Roll one die for the number of yeomen who arrive to block your escape, then go to {185}.\n" \
"  If you avoid detection, the horses finally awaken. Go to {162}."
},
{ // 7/1G
"While your attackers are gone, you still must get through the flames. Make a level 3 saving roll on ST and on CON (30 - ST/CON), taking any miss from that attribute. The stable is a complete loss and horses are no longer available as a means of escape. You'll have to discover another way out of this adventure. Try {178}."
},
{ // 8/1H
"The boy has ST 15, IQ 18, CON 12, LK 11, DEX 21, and CHR 10. If you win in one round, go to {162}. If you can't finish the lad in that time, he bravely holds off your attack until yeomen arrive. Roll one die for the number who come charging to his assistance. Now you must face them all. Go to {185}."
},
{ // 9/1J
"* Roll one die. If it's even, go to {186}. Otherwise, choose your spell and check the Magic Matrix. The old man is an ordinary villager (MR 25). If you kill the codger, subtract 4 from your CHR (3 points will return when you leave the adventure) for the dastardly deed and go to {172}."
},
{ // 10/1K
"The floor slants at a sickening angle as you try to make your way across. If you make a level 3 saving roll on DEX (30 - DEX), go to {51}. If you miss, you slip and slide to {110}."
},
{ // 11/1L
"You crouch, your weapon held lightly before you. The tip of your sword gleams hotly in the incarnadine light. The four men facing you don't seem to be as confident as they were a moment before, but they realize that it is too late to back out now. They draw their weapons and prepare for your charge. You are among them before they can react, your blade drawing red weals as an artist on canvas. Although the four are capable and well-trained, they are moving in slow motion compared to you. In less than a minute, you have finished. You are wiping the blood from your blade when you realize that you've made a terrible mistake; these were the four who wanted to hire you. Whistling quietly to yourself, you slip out the back door. Go back to the paragraph you came from before you're caught."
},
{ // 12/2A
"* Bruit Fors is a third-level wizard (ST 21, IQ 22, LK 30, CON 20, DEX 19, CHR 20). He's quick-witted and matches any spell you cast. For this duel, assume that only one-third of matching hits get through. For example, if you attack with a spell dealing 30 hits and he replies with the same spell at 40, you will get 10 hits on Bruit while he scores 20 hits on you (10 normal + one-third of the matching hits).\n" \
"  Continue the duel until someone's CON or ST is reduced to 5. If it is you and you're still alive, go back to the cells at {105}. If you should manage to win, you can explore further at {63}."
},
{ // 13/2B
"Roll one die. If it's even, go to {90}. If it's odd, the old man is an ordinary villager (MR 25). You surprise him and he's unable to defend himself for one round. Continue the fight. If you win, get in the boat and go to {172}."
},
{ // 14/2C
"You'll have to be quick. If you make a level 2 saving roll on SPD (25 - SPD), go to {181}.\n" \
"  If you fail, the guard hears a noise. Seeing no one, he suspects magic. \"Have at you, ye cursed spellcaster,\" he cries, drawing his sword and lashing about wildly. Go to {99}."
},
{ // 15/3A
"The door is protected by a level 3 ensorcelment. If you do not have the Strength to cast your spell at level 4, subtract the ST needed for a first-level spell and return to {71}.\n" \
"  If you cast the spell at level 4, the bolt slides back and the door slowly groans open. Roll 6 dice to discover the number of turns you'll have before someone finds the empty cell and raises the alarum. Quickly now, sneak away to {187}."
},
{ // 16/3B
"You are now on the landing below the Blue Gate which guards the parapet wall. Make a level 2 saving roll on LK (25 - LK). If you succeeded, you can sneak through to the parapet (go to {70}) or down one of the stone staircases. One leads to the stables ({175}), the other to the storehouse ({54}).\n" \
"  If you fail your roll, go to {132}."
},
{ // 17/3C
"The boy alerts the village patrol. Roll one die for the number of yeomen who arrive to block your escape, then go to {185} and follow the instructions there."
},
{ // 18/3D
"Although you're invisible, the door's still locked. Roll one die. If it's even, no one comes by and your spell wears off. Go back to {71} and try again.\n" \
"  If the roll was odd, a guard comes by on rounds and, seeing nothing, pulls open the door and charges thoughtlessly into the cell. If you attack him, go to {169}. If you try to sneak past, go to {14}."
},
{ // 19/3E
"How quietly can you move? Make a saving roll on your level on DEX. If successful, go to {168}. If you fail, go to {87}."
},
{ // 20/3F
"Safely in the boat, you manage to avoid any further encounters and make your escape. Under the oars, you find a small strongbox. Opening it you discover two dice worth of gems. Then go to {107}."
},
{ // 21/3G
"\"Murderin' Mithra's mother,\" swears the guard you just knocked sprawling. Momentarily stunned, the two of you face off. Record this paragraph number and carry out the fight instructions in {97}. When you return, go to {187}."
},
{ // 22/4A
"The spell works, but the brute still bars your way. He thrashes about with his bludgeon. Make a third level saving roll on DEX (30 - DEX). If you miss, he doesn't and you make a light snack for Unctar. If you make the roll, go on down the caverns to {2} or {190}."
},
{ // 23/4B
"On their next rounds, the guards discover your escape attempt. Go to {105}."
},
{ // 24/4C
"No door reveals itself in answer to your awesome spell. Check to see if you're discovered by the guards, though ({171}). If you survive, you can continue your circular journey - counterclockwise to {41} or clockwise to {117}."
},
{ // 25/4D
"* You can cast a spell before he grabs you, but just barely. Choose your spell, then consult the Magic Matrix. His MR is 150. If you kill the troll, you can continue your search for an exit by going back to {2} or forward to {190}. If your spell fails to stop the monster, continue to fight by going to {103}."
},
{ // 26/4E
"Make a saving roll on DEX at your level. If you're successful, go to {83}. Failure leads you to {3}."
},
{ // 27/4F
#ifdef CORGI
"The armoury is well stocked. You can take any two weapons you need, using the weapons table in the Rules Section at the beginning of the book. (But remember, gunnes haven't been invented yet.) Then go to {4}."
#else
"The armoury is well stocked. You can take any two weapons you need, using the standard T&T weapons tables (but remember, gunnes haven't been invented yet). Then go to {4}."
#endif
},
{ // 28/4G
"You safely reach the next niche in the parapet wall. The circular walkway continues in both directions. Nothing distinguishes this section from the others. If you tarry long, you'll be seen.\n" \
"  Record this paragraph number. Then go to {171} to see if you are detected. If not, you can proceed along the parapet, going clockwise to {137} or counterclockwise to {113}."
},
{ // 29/4H
"As you leap, the boy turns and sees you. He's apprenticed to the alchemist and is a first level wizard. He casts a Take That You Fiend (IQ of 18). If you survive its effect, go to {8}."
},
{ // 30/4J
"Ythul would look chagrined, but it can't even manage a grin. Your spell confused it a little and you have time to flee. You gain 100 ap for surviving. Go on to {10}."
},
{ // 31/4K
"The portcullis guards the main gateway to the village. A contingent of guards bars your way. You can try to bluff your way past (go to {128}) or retreat to the armoury at {4} or the stables at {175} to try to find an alternate exit from the castle."
},
{ // 32/4L
"As you slide through the square of the town, you pass the alchemist's shop. On your first visit here you see an amber light coming through the window. If you want to investigate, go to {155}. Otherwise (or if this isn't your first trip past this area), you can go to the commons ({188}), towards the jetty ({183}), deeper into the village ({178}), or towards the tavern ({1})."
},
{ // 33/4M
"These were packrat bats and buried around the room you can find their treasures. You can search as long as you wish. For each round of searching, make a saving roll on CON, starting at level 1 and increasing the level by one each time as the air becomes foul with bat dung dust. Subtract the amount a roll is missed by from your CON. Then make a third level saving roll on LK (30 - LK). If successful, you find one die's worth of gems. If you fail, one die's roll of bats return to find you stealing their loot. Fight them before continuing your search. Whenever your greed permits you leave, there are several paths waiting. A dingy passage leads to the left ({61}), a debris-filled tunnel leads straight ahead ({10}), or you can follow the cave back to a grotto at {189}."
},
{ // 34/5A
"This is a hero? Duc Gastar has more pressing problems. Subtract 1 permanently from your CHR. Go back to {71}[ and make a real choice]."
},
{ // 35/5B
"The jewel drops from your hand as the gargoyle pounces. Take one die in hits from ST as he bites your arm. [On each turn hereafter, make a third level saving roll on ST (30 - ST), subtracting any miss from ST. These hits are due to gargoyle venom which cannot be counteracted until you escape this adventure. ]If your ST goes to zero, you're dead. You still have to fight the gargoyle. Combat continues at {166}."
},
{ // 36/5C
"Ildrac is momentarily surprised at your disappearance. If you make a first level saving roll on SPD (20 - SPD), you can escape to {4}. If you fail, he catches you despite your invisibility. He ties a rope to your unseen form and waits for you to reappear. Humiliated, you eventually do, and he calls the guards to return you to {105}."
},
{ // 37/5D
"If you make a third level saving roll on CHR (30 - CHR), go to {199}. If you fail, the old man isn't convinced. He starts to call for help. You can either attack him ({13} or with magic at {9}), run away before help arrives ({183}), or try to grab a boat and escape ({93})."
},
{ // 38/6A
"Bruit Fors sends a conditioned Icefall shivering your way. Your retreat is glacial as he shuts you down, placing you in a state of suspended animation. For two weeks your frozen body hangs on the walls as a gargoyle to discourage delvers. Your mind still functions and you have plenty of time to consider other occupations. The meditation time is worth 200 ap.\n" \
"  Finally Bruit tires of your stone-faced expression and allows you to thaw. Take one die's hits to CON for defrosting. When you reawaken, you're back at {105}."
},
{ // 39/6B
"While not completely disorienting, there's not much to distinguish this room from any other in the caverns. Make a fifth level saving roll on LK (40 - LK). If you miss, go to {121}. If you make the saving roll, you can follow the quavering light to more caverns. Go back to {2} or forward to {190}."
},
{ // 40/6C
"The spell sweeps you into the air. Ildrac instinctively throws a dirk. He needs a fifth level saving roll on DEX (40 - DEX) to hit. If he hits, take the dagger's hits plus 10 adds. You fall to the floor and Ildrac prevents your escape. Go to {142}.\n" \
"  If you avoid his dagger, you fly back to the inner courtyard at {131}."
},
{ // 41/6D
"You safely reach the next niche in the parapet wall. The circular walkway continues in both directions. The parapet walls seem different here. If you want to spend the time to examine them magically, write down your spell and go to {164}. Otherwise, record this paragraph number. Then go to {171} to see if you are detected. If not, you can proceed along the parapet, going clockwise to {113} or counterclockwise to {117}."
},
{ // 42/6E
"If you make a saving roll at your level on SPD, you careen wildly down the corridors right to {2} or left to {190}. If you miss, Delverdinger blocks your way. Go to {103}."
},
{ // 43/6F
"These servants are faithful to the true duke, Gastar. They offer to provide you with a servant's livery if you want it. They'll also hide you if you need to recover ST. When you're ready, you can proceed to {149}."
},
{ // 44/6G
"If you're a magic-user, go to {116}. Otherwise the old man is less than pleased with the interruption. If you fail a third level saving roll on CHR (30 - CHR), go to {134}.\n" \
"  Making the roll, you convince him of your cause and he agrees to aid you. Alklyn gives you a potion which raises each of your attributes by one. He then returns to his work.\n" \
"  You can go to the commons ({188}), towards the jetty ({183}), deeper into the village ({178}), or towards the tavern ({1})."
},
{ // 45/6H
"The villagers discover someone trying to steal their boat. A number of them come running to stop you (roll one die to find out how many). They plunge into the water. If you wish to cast magic, write down your spell and go to {182}. If you just want to fight, go to {144}."
},
{ // 46/6J
"You are now flying over the village. If you have the Strength to recast the spell, do so and go to {145}.\n" \
"  Lacking the Strength, you need to prepare for a crash landing. Make a fifth level saving roll on CON (40 - CON). Subtract any miss from CON. You also lose any items you were carrying. If somehow you survive, go on to {188}."
},
{ // 47/6K
"You recognize the smell of methane just in time. Quickly you douse the flame you're carrying in a puddle on the floor. Take 50 ap for this quick response. Return to the paragraph that sent you to {150}."
},
{ // 48/6L
"* Write down your spell, then check the Magic Matrix. The gargoyle has a MR of 100. If you survive, go to {122}."
},
{ // 49/7A
"The smoke has attracted another guard. He's more alert than the last and already has his scimitar ready. [You, however, are caught with your sword (among other things) down, so you must fight the first round weaponless. You'll be able to use the sword on succeeding rounds, though. ]Assuming you survive, you can check the guard's pockets. Recent raids have been profitable and the guard has 2 dice worth of gold coins.\n" \
"  Now sneak out to the courtyard at {187}."
},
{ // 50/7B
"In response to your ingenuity, a small section of the parapet slides away revealing a narrow passageway. Some slight distance inwards a small figure lies crumpled and snoring. You can still sneak back to the parapet at {113} (the door will then close behind you), you can approach stealthily and try to kill the sleeper before he awakens ({87}), or you can try to sneak past him to the room beyond ({19})."
},
{ // 51/7C
"An abandoned postern lies open so there's a light at the end of the tunnel. This is known as the Optimist's Gate. You've survived the maze (take 200 ap) but you still need to escape. Proceed straight ahead to {85}."
},
{ // 52/7D
 "Even if you return as a slug, your next incarnation has to be smarter. Hurling yourself into the air, you're impaled on the cave's stalactites. Luckily you're unconscious before you hit the floor. Your body slowly loses sensation. At the end, you feel plasmoid extrusions converging on your body. A short time later, all that remains is a pair of sandals and a bloated, burping frog."
},
{ // 53/7E
"The Dreamweaver takes its full effect. If any of your attackers remain awake (that is, if you didn't cast a strong enough spell), you must finish the battle by normal means. If you defeat them (or if they are all snoring), go to {6}."
},
{ // 54/7F
"The storehouse holds nothing of special value. It does contain hatchets, ropes, lanterns, torches, and spears. You can stock up if you need anything. You can also hide here and rest for as long as you need. (Make a first level saving roll on LK (20 - LK) for each turn you rest. If you fail, go to {97} for a guard wandered in.\n" \
"  When you decide to leave, you can stay at the main level by going to the courtyard at {187}, the kitchens at {193}, or the inner doors at {109}. A stone stairway may tempt you to {16}, or you can follow the curving passageway down at {2}."
},
{ // 55/7G
"If you cast the spell at a power of 100 or more, the gargoyle shatters (its MR was 100). You're free to continue to {122}.\n" \
"  If you didn't cast it strong enough, your frosty fingers were only partially successful. Subtract your damage from the gargoyle's initial value of 100 and continue at {194}."
},
{ // 56/7H
"The boy saw you the last time and alerted the village patrol. Roll one die for the number of yeomen who are now waiting for you. You still have a chance to convince them you're on their side. Make the appropriate saving rolls on the Class Action Table. If you pass all of them, go to {162}.\n" \
"  The yeomen are quite suspicious. If you fail a saving roll, they attack. Go to {185}."
},
{ // 57/7J
"Nimbly you replace the jewel and the gargoyle restiffens. Take 100 ap and go to {189} to continue your journey."
},
{ // 58/7K
"\"Coward, spawned by a sun-shirking lizard! Thy weapons are useless to protect thy perfidy.\" Alklyn waves a gnarled hand and all your weapons turn to dust.\n" \
"  He then decides you should pay for your unchivalrous conduct by assisting in his experiments. A double dose of his potion cavorts in a retort. Go to {134} and add one to the level of the saving rolls required there."
},
{ // 59/8A
"You start to take off into the sky but one guard makes a last effort to hit you with his spear. You are a large but moving target. He needs a fifth level saving roll on his DEX of 25 (40 - 25) to hit you. If you're still in the air when he's done, go to {96}."
},
{ // 60/8B
"The massive door is counterweighted and opens smoothly. You slip inside. The foremost shelves and stalls are filled with swords, daggers, and bows. Take what you can use (and carry). You hear a guard approaching and can slip back to {4} or try to obtain more accoutrements by going to {184}."
},
{ // 61/8C
"This chamber has a brighter glow than the others. If you'd like to search the cave with a Revelation, go to {197}. Otherwise proceed to {10}."
},
{ // 62/8D
"The world needs heroes, not shirkers. Subtract 50 ap from your total. You also lose 5 CHR for the duration of the adventure. [You'll have no further chance to encounter the alchemist in his shop. ]For now, you can go to the commons ({188}), towards the jetty ({183}), deeper into the village ({178}), or towards the tavern ({1})."
},
{ // 63/8E
"This encounter was worth 300 ap plus 5 times any ST points you used in the battle. Fighting this wizard also taught you a few things (increase IQ and DEX by 2 points each). From Bruit's belt, you pluck a flask. It contains 10 draughts of a magic potion. Each swallow will restore 10 Strength points that you've used[ magically]. You cannot go beyond your normal Strength, however.[ The potion also has cumulative side effects. If you take more than one draught per day, you must make a saving roll on ST at one level higher than the previous time (ie. a level 1 saving roll for the second taste, level 2 for the third, etc.). If you fail a saving roll, your ST is cut in half.]\n" \
"  For now, proceed to the tiny room at the end of the passage (go to {168})."
},
{ // 64/8F
"You climb to the top of the parapet wall. The moonless night will prevent your discovery for awhile. If you have a rope, you can tie it off and descend the 50' to the ground (go to {100}). If you lack a rope, you still have two choices: you can try to climb down without a rope (go to {167}), or you can return to the lower levels and try to find or steal one (go to {117})."
},
{ // 65/8G
"You have the persuasive powers of a rock troll. You've frightened the girl and she runs for help. If you try to stop her, go to {146}. If you try to run, go to {154}."
},
{ // 66/8H
"You'd fight the Elder Eldritch with such puny spells? If you cast the spell at an effective strength of 100 or more, go to {30}. If you didn't make it that strong, the spell rebounds. Take the damage of that spell and go to {179}."
},
{ // 67/9A
"You can strip the guard(s) and put on a guard's uniform. Roll one die to find the number of gold pieces a guard had. Then return to the paragraph which caused you to check for guards."
},
{ // 68/9B
"Delverdinger minces people, not words: \"Me riddles like. You me beat, I you give precious. No beat, I eat!\"\n" \
"  Make a third level saving roll on IQ (30 - IQ). If you succeed, go to {159}. If you miss, you'll soon be a post-nap snack for the troll. Go to {103}."
},
{ // 69/9C
"A rock jetty curves out from shore to form a small protected cove. Several fishing boats huddle in its shelter. There appears to be only one old fisherman preparing for the morning's trip. (If you've ever been here before, all saving roll levels at this location are increased by 1.) You have several strategies:\n" \
"  Approach the old man ({37});\n" \
"  Attack the old man ({13});\n" \
"  Attack him with magic ({9});\n" \
"  Wait for him to leave, then steal a boat ({172});\n" \
"  Do nothing here. Sneak to the village ({183})."
},
{ // 70/9D
"You safely reach the next niche in the parapet wall. The circular walkway continues in both directions. The Blue Gate guards the entrance to stone stairways below.\n" \
"  Record this paragraph number. Then go to {171} to see if you are detected. If not, you can proceed along the parapet, going clockwise to {117} or counterclockwise to {137}.\n" \
"  If you want to sneak down past the Blue Gate, go to {16}."
},
{ // 71/9E
"Prison life grinds you down. Make a second level saving roll on CON (25 - CON). If you miss, take the number of hits you missed the roll by to reflect its effects on your strength.\n" \
"  Several possible means of escape await you:\n" \
"  If you want to try to get the serving girl, Jhani, to help your escape, wait till she brings your food; go to {114}.\n" \
"  If you want to start a fire (hoping to overpower a guard in the confusion), go to {151}.\n" \
"  If you'd rather play Comte de Monte Cristo (ie. \"tunnel king\"), try paragraph {177}.\n" \
"  If magic's your thing, proceed to {173}.\n" \
"  If you want to await your rescue by Duc Gastar, go to {34}."
},
{ // 72/9F
"You're not paying attention. Ildrac is weapons master. But since you insist, look up Ildrac's attributes in the Wandering Person Table and have at him. If you win, go to {27}."
},
{ // 73/9G
"The sight of their prey soaring over their heads jars the guards' reactions for an instant. When they recover, they loose a flight of arrows at you. Each guard needs to make a fifth level saving roll on DEX (40 - DEX) to hit you. If you manage to avoid the arrows, you land safely at {188}."
},
{ // 74/9H
"The boy listens to your story. If you make a saving roll at your level on CHR, go to {162}. If you fail, he runs from the stables screaming for help. Roll one die for the number of yeomen who arrive to block your escape, then go to {185}."
},
{ // 75/10A
"The glimmering slime on the walls of the cave may not be pleasant smelling, but it exudes enough light for you to walk by. From here you can dimly see passages left to {190} and right to {129}."
},
{ // 76/10B
"You're invisible now. You've confused the guards and they slash wildly. [Each turn make a first level saving roll on LK (20 - LK) for each guard present. If you succeed, they miss. On combat turns 2 and 3, you can land half your combat total with no response from them. If you fail a saving roll, treat the turn as a normal combat turn. If the battle goes on to turn 4, you become visible again. ]Finish the fight with normal combat rules. If you make it, go to {158}."
},
{ // 77/10C
"You have crept to a gate guarding the Green entrance to the parapet. Make a second level saving roll on LK (25 - LK). If you succeed, you can sneak through to the parapet (go to {137}) or down one of the stone staircases. One leads to the kitchens (go to {193}), the other to the inner courtyard ({131}).\n" \
"  If you fail your saving roll, go to {132}."
},
{ // 78/10D
"Your feet disturb the dried bat guano which covers the walls. If you fail a fourth level saving roll on CON (35 - CON), take the amount you missed by as hits to CON and go to {153}. If you make the roll, go to {135}."
},
{ // 79/10E
"Draped over a stuffed baboon, you find a silken tarnhelm. Luckily it only works on living creatures or you'd not have found it. [When pulled over your head, it renders you invisible for five combat turns. If you make a saving roll on LK at your foe's level, they can score no hits on you for that turn. You always score your full combat adds as they can't see the direction of your attack.\n" \
"  The tarnhelm's power is inexhaustible but it takes two hours to recharge itself after use. ]Your fascination with the discovery is broken when you hear footsteps. Go to {148}."
},
{ // 80/10F
"If you have a lantern or torch, make a fourth level saving roll on LK (35 - LK; lights are rather hard to hide). If you have no light you need only a second level saving roll (25 - LK) to avoid being spotted (remember to add one to the level of the saving roll if the alarum has sounded). If you make your roll, return to the paragraph which got you here. If your luck fails, a guard spots you. Go to {133}."
},
{ // 81/10G
"Congratulations. You have just created a two-ton frozen slime cone. Ythul is one of the Elder Eldritch and, as it slowly recedes to another plane of existence, you feel it slide through your mind. You then realize its malevolence was in fact the disinterested daydreaming of a vastly superior life-form. This insight increases your IQ by the roll of one die. [You also sense that henceforth you'll be resistant to any mind spells. ]This little episode is also worth 200 ap. The caverns continue on to {10}."
},
{ // 82/10H
"The night continues to shelter you. You can go to the commons at {188}, the gate to the chateau at {158}, or the road to the jetty at {183}."
},
{ // 83/10J
"Your greedy fingers just plucked the navel jewel from a cave gargoyle. The enchanted gem kept the gargoyle stone-dead and nearly harmless; he's coming around now. You can cast a spell ({48}), fight with normal weapons ({166}), try to replace the jewel ({57}), or just flee ({196})."
},
{ // 84/10K
"\"My parents were murdered by Binaire when first he took over,\" Jhani tells you. \"I have since but waited till I might destroy that evil man. I will bring thee servant's clothes and weapons. No one will see, and I will aid thy escape.\"\n" \
"  She disappears, but true to her word she returns that night. Guarding the passageway while you change into the loose-fitting servant's tabard, she then sneaks back to her duties. Go now to {187}."
},
{ // 85/11A
"You've wandered underneath the castle, emerging at an unguarded gate. As your eyes adjust to the dim light of night, you make out the shapes of village huts. Go to {32}."
},
{ // 86/11B
"Roll three dice. That's the number of turns you have before someone finds the body and raises the alarum. The door to your cell remains open, so use it while you can. Grab the daggers and go to {187}."
},
{ // 87/11C
"Concentrating on the sleeper, you fail to see the trip wire and have now awakened the guardian of the secret chamber. Bruit Fors is not quite 4' tall but weighs well over 200#.\n" \
"  \"Morpheus' malingerers,\" he mumbles as he climbs out of the sleeping robes he had been wrapped in. \"How dare you disturb my sleep?\"\n" \
"  Clearly, you make a poor first impression. You have several possible actions now. You can talk to him and see if you can improve his opinion of you ({163}), you can quickly conjure up a spell to use against him ({12}), you can launch an attack against him using ordinary weapons ({138}), or lastly you can apply the better part of valour and hightail it out of there ({38})."
},
{ // 88/11D
"Ythul has no brain to be affected by your spell. However, it does have the ability to reflect it back at you. A narcotic drowsiness envelops your mind. As your last bodily sensations fade, you feel plasmoid extrusions converging on your body. A short time later, all that remains is a pair of sandals and a bloated, burping frog."
},
{ // 89/11E
"The tiresome excavation is finally over. The tunnel you've dug breaks out in an underground cavern. The walls are covered with a slimy phosphoresence that allows you to find your way without a light. Go to {191}."
},
{ // 90/11F
"You throw yourself across the beach. If you fail a third level saving roll on LK (30 - LK), go to {180}.\n" \
"  If your luck holds, you surprise the old man who is actually the wizard Ornalac. He has time only to flip away a Blasting Power worth 20 points. If you survive this attack, you can struggle ahead and land your blows. If you fail to kill him on this first round, his next spell is a level 3 Take That You Fiend (worth 90 points). If you still survive, he's too tired to do anything more to stop you. Take 200 ap for surviving and proceed to {172}."
},
{ // 91/12A
"Wizards should practice wisdom and civility before craven aggression. Go to {134} and add one to the level of the saving rolls required there."
},
{ // 92/12B
"The kitchen servers subdue the servants. They'll guard you while you rest as long as you want to recover Strength. You can dress as a servant if you'd like to.\n" \
"  When you're ready to go, an old cook hangs a goatskin of wine around your neck. Its contents will restore one die's worth of points to your CON (up to your permanent value). There are ten draughts in the skin[ and it takes a turn to drink one]. Now go to {149}."
},
{ // 93/12C
"Roll one die. If it's even, go to {172}; otherwise go to {180}."
},
{ // 94/12D
"The torch/lantern hampers your ability to fight. You can accept that and only use one hand, or you can throw away the light. If you toss it, go to {127}.\n" \
"  If you keep the light, you still have the choice of magic or hand weapons. If you choose magic, decide on your spell and check the Magic Matrix. Remember, you only have one arm free, should it matter to your spell.\n" \
"  [If you fight by normal means, remember that you can only use one weapon. If you fail to inflict any hits in a round, the light is struck from your hand. If this happens, go to {127}.\n" \
"  ]Assuming you persevere and are still holding your light, go to {162}."
},
{ // 95/12E
"If you can make a L2-SR on SPD (25 - SPD), you run out to {4}. If you fail, Ildrac snares you before you can get away. Go to {142}."
},
{ // 96/12F
"You fly straight up, clearing the parapet and out of target range. You are now 100' in the air. If you make a third level saving roll on LK (30 - LK), go to {157}. If you fail, go to {46}."
},
{ // 97/12G
"* The guard moves to attack. If you wish to use magic, write down your spell and consult the Magic Matrix. The fight begins no matter what you do. [If you fail to inflict damage on him in any round, he has time to yell for help. For each yell, roll one die. If it comes up 1 or 2, another guard appears and joins the attack. If more than 4 guards are present, you can surrender (subtract 5 from your CHR for the rest of this adventure and go to {105}). ]If you survive, go to {67}."
},
{ // 98/12H
"If you're carrying a torch or lantern or if you make a Will-o-wisp or other flame, note this paragraph number and go to {150}. If you want to proceed with no light, you can move forward to {191} or back up to {109}."
},
{ // 99/12J
"Your invisibility still helps you in your fight with the guard. Each turn make a third level saving roll on DEX (30 - DEX). If you make it, you can land your full blow without opposition. Should you miss, you must take the guard's hits. After two such turns, the Concealing Cloak wears off and all fighting continues normally.\n" \
"  If you win, you can stop to strip the body for uniform and armour. Then roll two dice to determine how long you'll have before the alarum is raised.\n" \
"  If you run without stopping to strip the body, roll four dice for the time you'll have. In either case, your only way now lies at {187}."
},
{ // 100/13A
"You tie the rope to the iron rungs of the ladder and toss the other end out into the night. There's a satisfying plop as the rope hits the ground. If you make a third level saving roll on IQ (30 - IQ), go to {140}.\n" \
"  Failing the IQ roll means you forgot to check your anchor, and your stomach drops as the rung to which you tied the rope pops and sails past your head. Falling, you face it to the ground. Make a sixth level saving roll on CON (45 - CON). Subtract any amount you missed the roll by from CON as hits. You also get five times the amount missed by as ap, if that's any consolation. If you survive, you can pull yourself together and proceed to {82}."
},
{ // 101/13B
"A huge iron-braced door guards the armoury. An Unlock spell or a L3-SR on DEX (30 - DEX) will get you inside; go to {60}. If you fail to achieve either, return to {4}."
},
{ // 102/13C
"Ythul has no eyes, so it doesn't realize you're invisible. If you can make a third level saving roll on DEX (30 - DEX), you manage to move fast enough to try another spell. Go to {197}.\n" \
"  If you miss the DEX saving roll or haven't the ST for more magic, a narcotically soothing aura envelops you. As your last bodily sensations fade, you feel plasmoid extrusions converging on your body. A short time later all that remains is a pair of sandals and a bloated, burping frog."
},
{ // 103/13D
"\"Time me eat little man.\" The lumbering mass launches itself at you, huge teeth jutting from a drooling maw. Delverdinger starts with a MR of 150. You don't want to match this dude blow for blow. At the start of each turn, divide his current MR by 30 and round up. This is the level of the saving roll on DEX you must make. If you miss, take the difference from CON and DEX. If you make it, you sneak past the brute and deal your full combat adds. If you eventually defeat him, any loss suffered to your DEX is regained one point per turn. Then you can go back to {2} or forward to {190}."
},
{ // 104/13E
"Their attacks are only slightly hampered as they aim for the boat. Go to {144}[ but count only 40% of the total of the villagers' combat roll]."
},
{ // 105/13F
"You're back in the cell again sans everything. In addition to your tattered tunic, you now sport meteoric metal manacles on your wrists. These effectively prevent you from using magic. [If you're fool enough to start a fight, your combat adds are halved. The manacles are worth 2 dice, though. ]Should you win a fight with a guard, it will take 1 die's worth of turns to find his keys and get rid of the manacles.\n" \
"  Just surviving to this point has been worth 200 ap. Now go to {71}."
},
{ // 106/13G
"\"Oh hearty friend!\" says Bruit. \"You've come to ease my boredom, cast among these idiot helmet-bashers. Come let me show you the workshop.\" His discourse is worth 300 ap and a raise of 2 to your IQ. Then he leads you to the secret chamber; go to {168}."
},
{ // 107/13H
"You're free for now. Escaping is worth 1500 ap plus whatever ap you gained in the adventure.\n" \
"  Additional points are awarded based on the quality of the character who entered. Subtract your [initial ]level from 4 and multiply by 500. Add this value to your base score of ap. Next, subtract your current combat adds from 50 and multiply by 30. This number is also added to your tally (it may be a negative number). The adventure is over."
},
{ // 108/13J
"This old man is really the wizard Ornalac. He has some protective spells in effect, hence the level ratings in the Magic Matrix. His ST and CON are 30 and 18 respectively. If you fail to kill him, he blasts you with a level 3 Take That You Fiend (90 points worth). With that, his ST is used up. If you survive his attack, you can ignore him. Take 150 ap for this action and proceed to {172}."
},
{ // 109/14A
"Doors to the barracks and Lords' quarters lead from here, but it would be suicide to attempt those heavily guarded passages. Roll one die. If it's even, guards are present; if odd, servants are there. Then roll one die again and divide by two (round fractions up) to determine the number of people confronting you. Make the appropriate saving rolls on the Glib Tongue or Class Action Tables. If you fail any rolls, you are attacked. For the first round only of a combat, only one of your opponents manages to attack you. An additional person (if such there be) attacks on succeeding rounds. If you make all saving rolls or if you survive the battle, you can go back to the kitchen at {193} or to the storehouse at {54}. If you're really curious, there's always the passageway down to {98}."
},
{ // 110/14B
"You slide down a water-polished groove to a collecting basin. Make a fourth level saving roll on ST (35 - ST). If successful, you stop your slide and can go to {39}. If you fail to arrest yourself, you plunge into the murky pool. Make a first level saving roll on DEX (20 - DEX) for each item you carry (weapon or treasure). If you miss a saving roll, that object sinks out of sight.\n" \
"  You finally reach the edge of the pool. A constricting crawlway leads to {39}."
},
{ // 111/14C
"Your weapons disappears into the maw that opens in the creature's side. There's no way to break free and you follow the weapon into the monster where a speedy digestion awaits. Your body slowly loses sensation as you feel his plasmoid extrusions converging on your body. A short time later, all the remains is a pair of sandals and a bloated, burping frog."
},
{ // 112/14D
"Recasting the spell controls your descent. You make a gentle splash as you land. If you're wearing armour, make a third level saving roll on CON (30 - CON) to see if you can shuck it in time. Take any miss from your CON to represent damage sustained while getting out of the armour. In any case, proceed armourless to {170}."
},
{ // 113/14E
"You safely reach the next niche in the parapet wall. The circular walkway continues in both directions. You can go clockwise to {28} or counterclockwise to {41}. If you want to examine the walls for a secret door, go to {126}."
},
{ // 114/14F
"She's willing to listen to your story, but your CHR will be the only way she can tell whether you're telling the truth. Make a third level saving roll on CHR (30 - CHR; she's heard many tales from the wretches down here). If you make it, go to {84}. If you fail, she doesn't believe you; go to {65}."
},
{ // 115/15A
"* Write down your spell and consult the trusty Magic Matrix. If you defeat him, go on to {27}. If you fail, you'll have to try normal weapons. Go to {72}."
},
{ // 116/15B
#ifdef CORGI
"\"By the great Oak of Ogisil, I feel the tingle of a fledgling magic-flinger. But, youngling, have ye the power to contain my prowess?\"\n" \
"  Alklyn is ready to test your mind. To see if you can stay with his discourse, make a fourth level saving roll on IQ (35 - IQ). If you fail, go to {134}.\n" \
"  If you decide to forgo the test, and bolt for the rearest exit, go to {200}.\n" \
"  If you succeed, Alklyn says, \"Thou art smarter than thy looks give testimony. Come, see my endeavours...\" He demonstrates his arcande experiments and your IQ is increased by 5, your DEX by 2. The experience is worth 50 ap.\n" \
"  After a nightcap of toadtoe wine, Alklyn leads you to the street. You can go to the commons ({188}), towards the jetty ({183}), deeper into the village ({178}), or towards the tavern ({1})."
#else
"\"By the great Oak of Ogisil, I feel the tingle of a fledgling magic-flinger. But, youngling, have ye the power to contain my prowess?\"\n" \
"  Alklyn is ready to test your mind. To see if you can stay with his discourse, make a fourth level saving roll on IQ (35 - IQ). If you fail, go to {134}.\n" \
"  If you succeed, Alklyn says, \"Thou art smarter than thy looks give testimony. Come, see my endeavours...\" He demonstrates his arcande experiments and your IQ is increased by 5, your DEX by 2. The experience is worth 50 ap.\n" \
"  After a nightcap of toadtoe wine, Alklyn leads you to the street. You can go to the commons ({188}), towards the jetty ({183}), deeper into the village ({178}), or towards the tavern ({1})."
#endif
},
{ // 117/15C
"You reach the next niche in the parapet without incident. The walkway extends in both directions. Record this paragraph number. Then go to {171} to see if you are detected. If not, you can proceed clockwise to {41} or counterclockwise to {70}. A little further examination reveals a series of iron rungs which lead to the rim of the parapet wall. To attempt the ladder, go to {64}."
},
{ // 118/15D
"The crawlway is covered with dried bat guano and it's impossible to avoid breathing the dusty detritus. Roll one die. On a 5 or 6, go to {135}. Otherwise subtract the roll from your CON; then go to {153}."
},
{ // 119/15E
"Your nose tells you this is the commons stables. If you have ever been here before, go to {56}.\n" \
"  You can approach the young boy who is saddling a horse (go to {74}), attack him before he spots you ({29}), attack him magically ({195}), or you can sneak out and come back later ({178})."
},
{ // 120/15F
#ifdef CORGI
"The necromancer's Martel Malefictum (nicely bound in tanned mouse leather) lies open on an antique reader. It lists the spells of the Elder ways. Carefully turning its stiff parchment leaves, you absorb some of its lore before you're disturbed by a noise on the parapet. You have time to commit one spell to memory. Choose any spell you wish[ (by some coincidence, the spell section at the beginning of this book has the same spells as the Martel)]. You can cast that spell when you have sufficient IQ, DEX, and ST. You don't need to be at the level of the spell[, and you needn't pay the normal penalties for casting a higher level spell]. Then go to {148} to try to escape."
#else
"The necromancer's Martel Malefictum (nicely bound in tanned mouse leather) lies open on an antique reader. It lists the spells of the Elder ways. Carefully turning its stiff parchment leaves, you absorb some of its lore before you're disturbed by a noise on the parapet. You have time to commit one spell to memory. Choose any spell you wish (by some coincidence, the T&T spellbook has the same spells as the Martel). You can cast that spell when you have sufficient IQ, DEX, and ST. You don't need to be at the level of the spell[, and you needn't pay the normal penalties for casting a higher level spell]. Then go to {148} to try to escape."
#endif
},
{ // 121/15G
"As you cross a rock mound, it shifts under your feet. The mound is actually Delverdinger, a Ruffinbeem Troll. Luckily he's more surprised than you and you have a few moments to decide whether to reason with him ({68}), run ({42}), fight with magic ({25}), or fight with normal weapons ({103})."
},
{ // 122/15H
"The jewel casts an aura of belief. [While holding it, you only need to roll a 5 or better whenever you're asked to make a saving roll on CHR. Should you fail the saving roll or if the jewel is stolen from you, your CHR drops permanently by the roll of one die and the gem disintegrates. ]You can only rid yourself of this questionable aid by [finding someone capable of ]casting a Dis-Spell at level 12 on the jewel. When dispelled, the jewel reverts to its pre-enchantment value of 250 gp. Return to {189} [and roll one die ]to continue the adventure."
},
{ // 123/15J
"The fire continues to build. It can only attract more guards. Grab the scimitar from its sheath. You have one die's worth of turns before an alarum is raised. After that you must increase the level of every saving roll on LK by one more level.\n" \
"  If you want to use the guard's uniform, go to {161}. Otherwise, run to the courtyard at {187}."
},
{ // 124/17A
"A lichen-covered stone gives way and you peel off. Divide your present height up the wall by ten and add one. That's the level of saving roll you must now make on CON. This shows how hard you land. Subtract any miss from CON. You also get five times any damage as ap. If you're still alive, you're bruised and dazed but also free. Go to {82}."
},
{ // 125/17B
"The diet of maggoty black bread and tooth-chipping cheese is wearing you down. Besides, you're getting bored. Your subscription to \"Mercenary's Scroll\" has lapsed, your page has grown into a chapter, and there's still a thousand years before \"Wide World of Sports\" comes on. What else is there to do but escape? Your armour, weapons, and clothes were distributed to the yeomen who captured you. You now wear a standard issue, ragged tunic which will easily mark you as a prisoner should you escape. Your only luck is that your captors so underestimate your abilities (you were captured, after all!) that you have several chances to escape each day. For the nonce, go to {71}."
},
{ // 126/17C
"* If you're a magic-user, choose a spell and consult the Magic Matrix. If your spell fails, return to {113} and move on around the parapet.\n" \
"  If you're not a making-user, try a third level saving roll on IQ (30 - IQ). If you make it, go to {50}. If you fail, nothing happens; the puzzle seems to be too much for your brutish mind.\n" \
"  If you come back to try again, you'll have to make the saving roll at one level higher. For now return to the parapet at {113} and continue from the second sentence."
},
{ // 127/17D
"The dry straw of the stable floor erupts in a sheer wall of flame. The yeomen break off the fight to run for safety. Go to {7}."
},
{ // 128/17E
"* This is the last guardpost before the village. The sentries stop you. Roll one die to determine the number of guards on duty. You'll need to consult the Glib Tongue Table for each of them. If you fail any saving roll, they block your escape. You can yield (subtract 1 from CHR and go to {105}) or fight. If you want to use magic, consult the Magic Matrix after you write down your spell. If you win by any means, go on to {158}."
},
{ // 129/17F
"Angling sharply downwards, the cave narrows to a tight passageway. You won't be able to turn around once you've started down. If you choose to slither down head-first, go to {118}. If you're a feet-firster, go to {78}. Your only other choice is to sit here and eat rocks."
},
{ // 130/17G
"If you make a second level saving roll on LK (25 - LK), go to {89}. If you fail, you've dug too far down and hit the lake. Water comes pouring in. Make an L3-SR on CON (30 - CON). Take the amount you miss by as hits to determine its initial effects. If you survive, you manage to crawl back to your cell, muddied and half drowned. Go to {23}."
},
{ // 131/18A
"You're in the inner courtyard. You can pass through a small gate to {187} or try to open the door at {4}. A narrow stone stairway seems to go up at {77}."
},
{ // 132/18B
"The dusty stairs cause you to cough. \"Qui vive?\" calls a guard, sleepily. If you pass a Glib Tongue Table check, return to the paragraph that sent you here.\n" \
"  If you fail the Glib Tongue Table check, you'll have to kill him quickly. If you fail to kill the guard in two combat rounds, roll one die each succeeding turn. On the roll of a 1 or a 2, another guard comes and joins the fray. If you survive, return to the paragraph you came from and choose one of the directions there."
},
{ // 133/18C
"Check the Glib Tongue Table. If you pass, return to the paragraph which sent you to this sequence. If you fail, the guard turns out to be smarter than you thought. He figures you're a spy and attacks. Go to {97}."
},
{ // 134/18D
"\"Ah, laddie, but thou meddlest where thee should'na. Howsomever, methinks thee can yet be of some wee bitte of help to me.\"\n" \
"  Alklyn waves his hands and your form is enveloped by the crimson glow of a spell of holding. Your head moves back and your mouth gapes despite your efforts to close it. Alklyn picks up a cup made from a human skull and pours its frothy contents down your unwilling throat. Violent contractions twist your body, then a crimson haze mercifully blots your consciousness.\n" \
"  Make fourth level saving rolls on each of your seven attributes (35 - attribute: don't forget Speed). For each saving roll you make, the potion adds 2 points to that attribute. For each one you fail, decrease that attribute by the amount by which you missed the roll.\n" \
"  If you survive to awaken an hour later, you find yourself outside the alchemist's shop. The light is off. You can go to the commons ({188}), towards the jetty ({183}), deeper into the village ({178}), or towards the tavern ({1})."
},
{ // 135/18E
"Some magical powers remain in the dusty dung of the bat. You can scoop up enough for two dice worth of spell castings. [Each pinch is worth one free first-level spell (this dust is valid whether or not you're a magic-user). ]Then continue on to {153}."
},
{ // 136/18F
"You're invisible now. You've confused the guard and he slashes wildly with his blade. [Each turn make a first level saving roll on LK (20 - LK). If you make the saving roll, the guard's swipe misses. On combat turns 2 and 3, you can strike back. You get your full combat hits; the guard has none. ]If you haven't won at the end of the third round, you re-emerge from invisibility. Go to {97}. If you kill him, go to {67}."
},
{ // 137/18G
"You safely reach the next niche in the parapet wall. The circular walkway continues in both directions. The Green Gate guards the entrance to stone stairways below.\n" \
"  Record this paragraph number. Then go to {171} to see if you are detected. If not, you can proceed along the parapet, going clockwise to {70} or counterclockwise to {28}.\n" \
"  If you want to sneak down past the Green Gate, go to {77}."
},
{ // 138/18H
"You lunge across the corridor. The narrow passageway explodes in shimmering waves of fire as Bruit casts a Blasting Power spell. [He has the ST to cast it twice more, then he'll collapse in exhaustion. ]If you can kill him sooner or survive these rivers of flame, go to {63}. If you fail, your ashes will be tossed over the ramparts late tonight."
},
{ // 139/18J
"You fly towards the stable door, but the yeomen still have a chance at you. As you pass close over their heads, they each launch a javelin. You are a large target at close range, but also a moving target, so each yeoman needs to make a fifth level saving roll on a DEX of 24 (40 - 24). If you survive all their spears, proceed to {178}."
},
{ // 140/19A
"Before trusting the rope, you check the anchor. A hard tug pulls the rusty rung from its socket. A nervous chill tickles your spine as you see yourself tumbling off the wall. Then you retie the rope. This time it holds, and you skilfully lower yourself down the wall. Soon you touch ground, softly and undetected. Take 10 ap and head for {82}."
},
{ // 141/19B
"To leave the stables, go back to the main court ({187}), over to the armoury ({4}), or out to the main gate ({31}). There's also a ladder leading into a dark well at {2} or a stone stairway leading up to the parapet ({16})."
},
{ // 142/19C
"Look up Ildrac's attributes in the Wandering Person Table. He swats you with one broad hand and you're thrown against the wall. Make a first level saving roll on CON (20 - CON) and subtract the number you miss by from your CON if you should miss the roll. If you're still conscious, you barely have time before he charges you. His broadsword swings your way. You have moments to yield or prepare to fight. If at any time you yield, subtract one from your CHR and go to {105}. If you should manage to win, go to {27}."
},
{ // 143/19D
"There's nothing revealed by your spell. Check to see if you're discovered by the guards, though ({171}). If you survive, you can continue your circular journey around the parapet - counterclockwise to {41} or clockwise to {117}."
},
{ // 144/19E
"The water slows their attack[, so count only half of the villagers' combat rolls, using the standard 25 MR villager of the Wandering Person Table]. [Starting on the second combat turn and for each turn thereafter, you must make a first level saving roll on DEX (20 - DEX) for each attacker to remain in the boat. If you fail a roll, the villagers pull you into the water and you must finish the fight at half adds also. ]If you win, go to {20}. Don't consider surrender; these peasants show no mercy to thieves."
},
{ // 145/19F
"Recasting the spell controls your descent. You're heading for the village stables. Make a third level saving roll on LK (30 - LK). If you make it, go to {188}.\n" \
"  If you fail the roll, you land in this week's pile of horse dung. The smell is enough to subtract 10 from your CHR until you can bathe and get new clothes. (New clothes require a change of uniform. That will add 5 back to your CHR. The bath may be tougher. No one in this town has had a bath in 23 years.) Pull yourself together and go to {119}."
},
{ // 146/19G
"She's not as defenceless as she looks. Though she has a CON of only 9, she has ST 12, DEX 26, and LK 16. She plucks a poniard from her smock and flings it at you as you leap. If the dagger misses, she parries your attack, draws a second poniard from her belt, and attacks. Fight her. If you kill her, a quick search reveals a pouch containing one die's worth of small gems. Then go to {86}."
},
{ // 147/19H
"Invisible, you close with the boy and strike before he can react. Go to {8}."
},
{ // 148/19J
"Hastening to escape from this cul de sac, you upset a retort. Its long-trapped vapours fizzle as they contact the floor, and the fumes envelop you. Roll two dice to determine the effects. If you roll:\n" \
"     2 - increase IQ by one die roll\n" \
"     3 - increase ST by one die roll\n" \
"     4 - increase LK by one die roll\n" \
"     5 - increase CHR and DEX by 2\n" \
"     6 - increase ST and CON by 3\n" \
"     7 - increase LK and DEX by 1\n" \
"     8 - decrease ST and CON by 3\n" \
"     9 - decrease CHR and DEX by 2\n" \
"    10 - decrease LK by one die roll\n" \
"    11 - decrease ST by one die roll\n" \
"    12 - decrease IQ by one die roll\n" \
"Staggering from the effects of the fumes, you reach the parapet. Disoriented, you can go one of two ways on the circular ramparts (go to {28} or {41})."
},
{ // 149/20A
"Before you leave, you scan the kitchens for items you might need. You can take a torch, lantern, rope, knives and/or cleaver (3 dice + 1). From the kitchen you can explore the main level of the castle or climb a stone stairway to {77}. To explore the main level, you can go back to the courtyard at {187}, through a pair of massive wooden doors to {54}, or through an ornate passageway to {109}."
},
{ // 150/20B
"If you make a third level saving roll on IQ (30 - IQ), go to {47}.\n" \
"  If you fail the roll, you've just carried an open flame into a methane gas-filled room. The gas ignites violently and you're thrown against a wall. Make a fourth level saving roll on CON (35 - CON), subtracting the amount the roll is missed by as hits from CON. Should you survive, go back to the paragraph which sent you here. (Surviving is worth 100 ap. The blast burned away all your hair, though. Reduce your CHR by 5 until it grows back.)"
},
{ // 151/20C
"That was a bright move. You're locked in a small cell whose straw floor is smouldering and nearly suffocating you. Take one die's worth of hits to your CON. Eventually a guard arrives, pulls open the door, and charges impetuously into the room. his sword is still sheathed as you jump him. The pair of you tumble into the straw and struggle barehanded. Each turn of the combat, you each must make a saving roll on CON to determine the effects of the gradually building fire. The first time the level is 1, but it increases one level each turn as the fire heats up. Subtract any misses from that person's CON. If you manage to defeat the guard, go to {123}."
},
{ // 152/20D
"Half measures may be better than none. Your Revelation reveals a secret door control hidden in the rock. You still have to get the thing open, though.\n" \
"  If you try an Unlock spell, go to {50}.\n" \
"  If you think brute force will suffice, make a first level saving roll on ST (20 - ST). If you succeed, go to {50}. If you fail, try an Unlock spell or go back to the parapet at {113}."
},
{ // 153/20E
"It's hardly a surprise that you've emerged in a bat roost. Roll two dice for the number of bats (MR 11 each). If you come in feet first, you disturb all the critters before you fully emerge. They fight at full strength and so do you.\n" \
"  If you've come in head first, you stop before pulling yourself through and get one turn before the bats reach their full potential.[ Since you're still encumbered by the crawl, you get only half your normal adds, but the bats have none at all.]\n" \
"  If you destroy all the bats, you can search the cave (go to {33}) or just continue on. A dingy passage leads to the left ({61}), a debris-filled tunnel leads straight ahead ({10}), or you can follow the cave back to a grotto at {189}."
},
{ // 154/20F
"She's too surprised to stop you. You scramble out the door to {21}."
},
{ // 155/22A
"Silently you enter the alchemist's shop. Alklyn b'Frklyn seems intent on his experiment and oblivious to your entrance. You can approach him to talk ({44}), attack him with magic ({91}), or attack him with weapons ({58}). You can also do nothing and go back the way you came ({62})."
},
{ // 156/22B
"The walls of the cavern intensify your spell and it takes effect with double strength. You weren't ready for that, so [in addition to the gargoyle's hits, if any, ]you must absorb ¼ of the undoubled power of your spell. If you're still standing after that combination, go to {122}."
},
{ // 157/22C
"If you can recast the spell, do so and go to {112}.\n" \
"  If you lack the ST to recast, the spell wears off and you hit the water at full speed. Make a third level saving roll on CON (30 - CON). Subtract any miss from CON. You also lose any items you were carrying when you hit the water. If you survive, go to {170}."
},
{ // 158/22D
"The massive front gate of the chateau is behind you. You can move towards the commons ({188}) or along the harbour road ({82})."
},
{ // 159/22E
#ifdef CORGI
"You really stumped him. Luckily he's a good loser. He gives you an Amulet of Proteus.[ Once in any dungeon, you can chant the magic words \"The times, they are a'changin',\" and you will be transformed into any humanoid character you wish. The effects last for 20 turns. You also get the benefit of that race's attributes, modified as per the T&T tables in the Rule Book. Every other turn you must make a saving roll on LK at one level higher (start with a first level saving roll (20 - LK)). If you fail a saving roll, the transformation is permanent, but each of your attributes is reduced by a die roll. The amulet will also cease to function.]\n" \
"  To continue your search for a way out of this mess, go back to {2} or forward to {190}."
#else
"You really stumped him. Luckily he's a good loser. He gives you an Amulet of Proteus.[ Once in any dungeon, you can chant the magic words \"The times, they are a'changin',\" and you will be transformed into any humanoid character you wish. The effects last for 20 turns. You also get the benefit of that race's attributes, modified as per the T&T tables. Every other turn you must make a saving roll on LK at one level higher (start with a first level saving roll (20 - LK)). If you fail a saving roll, the transformation is permanent, but each of your attributes is reduced by a die roll. The amulet will also cease to function.]\n" \
"  To continue your search for a way out of this mess, go back to {2} or forward to {190}."
#endif
},
{ // 160/22F
"Use the Glib Tongue Table to see if Ildrac believes your story for being here. If he doesn't, go to {198}.\n" \
"  Ildrac's taken in by your manner, but he's still not sure you should be allowed to proceed. If you fail a third level saving roll on CHR (30 - CHR), he escorts you to the door ({4}).\n" \
"  Making the saving roll also means you've convinced him you need additional items from the back of the armoury. He goes back to his work and lets you go to {27}."
},
{ // 161/22G
"You drag the lifeless body from the flames and take his uniform. If you make a third level saving roll on LK (30 - LK), the uniform is undamaged and you can sneak out to the main courtyard at {187}. Otherwise, go to {49}."
},
{ // 162/22H
"One horse is saddled and seems to be waiting for you. Leaping into the saddle you pass through the village with no further encounters. A bulge in the saddlebags turns out to be a small sack of gems. Roll two dice to determine their number. Then go to {107}."
},
{ // 163/22J
"\"Rabid spider spit,\" Bruit exclaims. \"It's been eons since I've had a nice chat.\" If you can make a fourth level saving roll on IQ or CHR (35 - IQ or CHR), go to {106}. If you fail the roll, he shrugs in disappointment as he claps a pair of manacles to your wrists and trundles you away to the guards. Go to {105}."
},
{ // 164/22K
"The only spells that might work here are Revelation (go to {143}) or Unlock (go to {24}). If you cast anything else, subtract the ST for a miscasting and continue around the parapet - counterclockwise to {41} or clockwise to {117}."
},
{ // 165/22L
"A sizzling blast throws back your opponent(s). Any survivors scramble to escape the flames that now engulf the door to the stables. Your exit is blocked. Go to {7}."
},
{ // 166/23A
"You launch your attack before the gargoyle has fully awakened. Your full combat round is applied before the gargoyle can defend itself. Its original MR was 100. However, you must learn to pull your punches. The violence of your attack shattered the statue. Note its remaining MR and go to {194}."
},
{ // 167/23B
"Rough-hewn rocks form the outer walls but should offer little trouble to the true hero. You must climb 50' down. For each 10', make a first level saving roll on ST and on DEX (20 - ST/DEX). After each pair of saving rolls, you're 10' lower. Keep track of your current height. If you should miss any two rolls during the entire climb, go immediately to {124}.\n" \
"  If you make it safely to the bottom, the climb was worth 100 ap. Now make a second level saving roll on LK (25 - LK) to see if you've come down at a safe time. If you make it, go to {82}. If you miss the saving roll, your climbing made enough noise to attract someone. Roll on the Wandering Person Table to see who it is and deal with them. Then proceed to {82}."
},
{ // 168/23C
"You've entered the abandoned workshop of the necromancer Famorgh v'Laliel. Scattered about are magic objects and potions. No one recalls the use of everything in here, and it would be hazardous to disturb too much. If you're a wizard or rogue, go to {120}. If you're a warrior, go to {79}."
},
{ // 169/23D
"You have two combat turns of invisibility left. [For the first turn only, the guard is limited to half his combat roll and adds (he's still getting his scimitar out). Attack him now. If you fail to kill him, he gets his scimitar and slashes out at you. ]Go to {99}."
},
{ // 170/23E
"You swim the short distance to shore. Rearrange any gear you still have. Make a first level saving roll on DEX (20 - DEX) for each item. You lose any item for which you fail the saving roll. Then go to the jetty at {69}."
},
{ // 171/23F
"* You have met a guard. Make a first level saving roll on LK (20 - LK). If you make it, return to the paragraph that sent you here. If you fail the saving roll and are not a magic-user, go to {133}. Otherwise, write down your spell and consult the Magic Matrix. If your spell fails or isn't listed, go to {80}."
},
{ // 172/23G
"Securing the boat was easy. Getting it underway will take longer. Roll one die for the number of turns it will take. On each turn make a saving roll one level higher on LK (start at level 1). If you fail any roll, go to {45}.\n" \
"  If you make all the saving rolls, you manage to get the boat moving without attracting attention. Go to {20}."
},
{ // 173/23H
"* Write down your spell and check the Magic Matrix to see if it takes effect. If not, you still lose the ST it took to cast it. [You can't regain ST until you manage to leave the cell (bad diet and all that). ]If you're still here, go back to {71} and try again."
},
{ // 174/23J
"Your spell works but you've still got problems. Go to {17}."
},
{ // 175/23K
"The chateau stables are unguarded. You can take any of the items you find scattered about: ropes,  torches, whips (2 dice + 2), spears, and [various ]daggers. If you want to steal a horse, go to {192}. If you'd rather walk, go to {141}."
},
{ // 176/23L
"If the effect of your spell is less than 50, go to {151} to see its effect. If you cast it at greater than 50, then you now stare through the charred wreckage of the cell door. Letting loose that much power in a small space is not without hazard. Make a third level saving roll on CON (30 - CON) to see how well you stand up to it. If you miss, subtract as hits to CON.\n" \
"  Roll 3 dice to determine the number of turns you have before an alarum alerts the castle to your escape. Your only exit is by running to {187}."
},
{ // 177/24A
"As the serving maid leaves, she carelessly drops a metal spoon. Not the best tunnelling tool, but you may not get another chance. Roll 3 dice to determine the number of feet you must dig to escape.\n" \
"  Tunnelling is arduous. As you dig each foot of tunnel, make a second level saving roll on ST (25 - ST) and a first level saving roll on CON (20 - CON). Since your task is also boring, you must make a saving roll at your level on IQ every 5'. Subtract any misses from the appropriate attribute (the one on which you missed the roll). These losses will be restored at one per turn when you reach the outside of the chateau.\n" \
"  If you survive this attempt, proceed to {130}.\n" \
"  If, once started, you decide to quit, go to {23}."
},
{ // 178/24B
"As you sneak through the sleepy village, there's only a small chance of an encounter. Roll one die. If it comes up 1 or 2 then roll up a wandering person.\n" \
"  You can continue farther into the village square ({32}), back towards the commons ({188}), or down an alley to the village stables ({119})."
},
{ // 179/24C
"Make a fourth level saving roll on DEX (35 - DEX). If you succeed, go back to {66} and make another try. If you fail, Ythul ensnares you in his slimy tentacles. Your body slowly loses sensation as you feel his plasmoid extrusions converging on your body. A short time later, all that remains is a pair of sandals and a bloated, burping frog."
},
{ // 180/24D
"The seemingly old man is actually the wizard Ornalac. He turns condescendingly and levels you with a level 3 Take That You Fiend (worth 90 points). If you survive, you're stunned enough from the spell-shock that Ornalac can finish you off with his awl. He then calmly returns to rigging his boat."
},
{ // 181/24E
"You pull the cell door shut as you leave. Too late the guard discovers he's been tricked. Roll 5 dice to determine how many turns there'll be before the alarum goes off. Remember, you're still wearing prisoner togs. Go to {187}."
},
{ // 182/24F
"* Check the Magic Matrix. The water hinders the villagers' attack so only count half their combat roll. If your magic wins in one round, go to {20}. If there are still villagers coming, you must continue using ordinary means. Go to {144}."
},
{ // 183/24G
"You move through the fishermen's quarter. Roll one die. If your roll is even, a figure emerges from a hut (roll up a wandering person).\n" \
"  From here, paths lead to the village jetty ({69}), towards the village square ({32}), or along the harbour road ({82})."
},
{ // 184/24H
"Ildrac t'Ahlyst, the weapons master, comes to investigate the clatter you've made. You can run (go to {95}), use magic against him (go to {115}), attack him (go to {72}), or talk with him (go to {160})."
},
{ // 185/25A
"* The yeomen attack. Check the Wandering Person Table, #8. If you are carrying a torch or lantern, go to {103}.\n" \
"  To respond with magic, write down your spell and check the Magic Matrix.\n" \
"  Otherwise you fight with normal means. If you win, go to {162}."
},
{ // 186/25B
"* Write down your spell and check the Magic Matrix. Then go to {108}."
},
{ // 187/25C
"It's night. The main courtyard is but dimly lit by tiny torches attached high on the walls. In the flickering bluish light you can make out four doors set in the walls. Footsteps sound behind you. Roll one die. If it's even, you have a wandering personage to deal with. When you're done, you can choose one of the doors: north to {131}, south to {54}, east to {175}, and west to {193}."
},
{ // 188/25D
"The village commons doesn't offer much cover. As you cross the greensward, several goats remark your passage. The shadows at the edge of the commons may harbour a person. Roll up and deal with a wandering person. Then proceed to the village square ({32}), the forest ({82}), the village proper ({178}), or the entrance to the chateau ({158})."
},
{ // 189/25E
"Specks in the wall glitter as you move by. If you'd like to search the cave with a Revelation, go to {83}. You can also search the cave by hand by going to {26}. If you lack all curiosity, go directly to {51}."
},
{ // 190/25F
"Methane fumes permeate the air. Make a first level saving roll on CON (20 - CON). If you miss, subtract the difference directly from your CON. There's no reason to linger. In your haste, you slip on the slick sloping slabs. If you fail a saving roll on DEX at your level, go to {110}. If you make it, you recover your balance and can proceed normally. Go left to {61} or right to {129}."
},
{ // 191/25G
"The cave branches off in three directions. At this point you can't tell where any of them leads. Go to {2}, {39}, or {75}."
},
{ // 192/25H
"You release a stallion from his stall and lead him out. As you pass under the stable doorway, the horse rears back. There's an eighth level spell of Rustler-Holding cast on the stable's gates. The horse (MR 50) now attacks, trying to kill you with its hooves.[ Magic can't help you.]\n" \
"  If you can make a second level saving roll on DEX and on SPD (25 - DEX/SPD) each turn, then you dodge the slashing hooves to deliver your full combat total. If you miss one of the rolls, conduct a normal combat turn against the horse. If you're unfortunate enough to miss both rolls, the demon-driven pony pounds you with its full combat hits. Should you survive, subtract one from your IQ for not realizing why the stable had no guards. Killing the demon stallion is worth 150 ap. Then go to {141}."
},
{ // 193/26A
"The kitchens occupy a large hall. Food is always available and the kitchen help are used to all sorts of people wandering through. Not so the servants. Roll one die and divide by two (round up) to find the number of servants present. For each servant, make the saving roll indicated on the Class Action Table. If you make all saving rolls, go to {43}.\n" \
"  If you miss even one saving roll, the servants will see through your disguise and attack. Grabbing a meat cleaver (3 dice + 1) and a kitchen knife (2 dice), you prepare to meet their attack. If after four combat rounds you've given more hits than you've received, the kitchen help rally to your side (go to {92}). If the servants have the better of the battle, a cook sneaks up behind you and clobbers you with a large cast iron pot. The world blurs beneath waves of gravy. When you awaken, you're at {105}."
},
{ // 194/26B
"Divide the MR remaining to the gargoyle by 10 (round up) to discover the number of pieces that occur. Each piece of the gargoyle (Rocky 1, Rocky 2, etc.) has a MR of 10. Continue the fight. If you subdue the Rockettes, go to {122}."
},
{ // 195/26C
"* Write down your spell and consult the Magic Matrix. If you survive, go to {8}."
},
{ // 196/26D
"If you make a third level saving roll on SPD (30 - SPD), you escape. [Should you return to this room, the gargoyle will be frozen and jewelless. ]Continue to explore the caverns at {122}.\n" \
"  If you fail the roll, check {35}."
},
{ // 197/27A
"* Your spell turns the slime on the cave a putrescent green. As you watch in horror, the slime begins to coalesce, forming a semi-solid body. The toad-like thing before you is known as Ythul Elaith. Its obscene sucking noises indicate it senses a meal. Normal weapons will not work on it. Your only hope as Ythul continues its putrescent expansion is to use magic quickly. Write down your spell and consult the Magic Matrix.\n" \
"  If you survive, go to {61} and continue your wanderings."
},
{ // 198/27B
"\"I've had dull swords sharper than thee,\" Ildrac laughs. \"Thy pate must be addled. I will not bother to slay thee.\" He's still not about to set you free, though. he twists your arms behind you and delivers you to the wardens. Return to {105}."
},
{ // 199/27C
"The old man seems to sympathize. He tells you to take a boat and escape. Then he slips away to alert the villagers. Go to {172}."
},
{ // 200 (this is a Corgi-only paragraph!)
"You run for what looks like a door, but discover too late this is a framed mirror. You brace yourself for a crash, raising your hands in front of your face. Your body tingles all over and you find yourself elsewhere...\n" \
"  Roll three dice and turn to the paragraph indicated in the introduction to Beyond the Silvered Pane. Your character, if he survives the encounter, will get 500 ap in addition to any he gets from Beyond the Silvered Pane. He will have escaped, but will have half a world to travel to get back to his lord."
}
}, cd_wandertext[11] = {
{ // 0
"2. K'dhaz Vytyl is commander of the T'ah mercenary contingent. A level 4 wizard, he has never backed away from a fight. When you meet, use the Glib Tongue Table and add 3 to the level required. If you fail, he will accept your surrender (subtract 3 from your CHR and go to {105). If you foolishly choose to fight, his opening shot will be a level 4 Take That You Fiend worth 120 combat hits.\n" \
"  ST 35; IQ 35; CON 24; DEX 30; LK 24; CHR 20."
},
{ // 1
"3. La Miaverte, the green soulsucker, delights in tormenting her captures mentally before closing in for the kill. If you make L3-SRs on SP and IQ (30 - SP/IQ), you can avoid her snares. If you miss either, you must fight. She has a MR of 120. Every round that you can make a L3-SR on IQ (30 - IQ), she's outwitted. You can subtract your IQ times your level from her MR. If you fail, subtract the miss from IQ temporarily and fight a normal combat round (standard combat spells are permitted to magic-users).\n" \
"  La Mia's combat strength is determined as for other monsters[, but her effects are peculiar. She funnels all her powers to attack your personality. Any round she scores hits, subtract 3 from your IQ and your CHR, but subtract nothing from CON. These losses are recovered as ST is from magic, one point per turn after combat is finished].\n" \
"  Continue the encounter until [your IQ or CHR goes to zero or ]La Miaverte's MR goes below 20. If you prevail, take 200 ap."
},
{ // 2
"4. Ornalac is a level 3 wizard. He will not attack unless provoked but then starts out with a level 3 Take That You Fiend worth 90. He is the exception to the statement above: You can encounter him several times.\n" \
"  ST 26; IQ 30; CON 20; DEX 21; LK 17; CHR 16."
},
{ // 3
"5. T'ah Shash'n adepts from the desert hills of T'ah are trained killers. They never have weapons[ and are quick enough that only hand to hand fighting is possible]. [They easily slip inside your guard if you use a sword. Only daggers can be used against them.]\n" \
"  When you encounter a Shash'n, check the Glib Tongue Table and add one to the level of the saving roll required. If you pass, return to the paragraph which sent you here.\n" \
"  When attacking, the Shash'n use all their power to overcome your will. At the start of a combat turn, make a L3-SR on IQ (30 - IQ). If you succeed, take one die's roll from your opponent's IQ. Then he makes a saving roll on his current IQ at your level. If he succeeds, take one die's roll from your IQ. If either of you makes a saving roll, no normal combat occurs that round. If neither makes the roll, conduct a normal combat round for that turn only.\n" \
"  In the unlikely event that you survive contact with one of these creatures, your IQ will return at one point per turn."
},
{ // 4
"6. If you're outside the chateau: Villagers are often loyal to the rightful Duc d'Alcene. They're armed with farm implements and occasional captured swords. They will always attack if you fail a saving roll on the Class Action Table. They each have a MR of 25. If you kill a villager, you can dress in his clothes.\n" \
"  If you're inside the chateau: Servants may be obsequiously polite or aggressively bold. They'll judge you more by your image and manner than by your current position. Make a saving roll on the Class Action Table when you meet. Servants have a MR of 20 and carry poniards[ tipped with curare]. If you have time to strip a defeated servant, roll one die. If you roll between 1 and 4 inclusive, you find a purse with four dice worth of gold coins."
},
{ // 5
"7. T'ah guards are a special contingent hired by Binaire from the oasis kingdom in North Africa. Wiry, leather skinned, they are aggressive and fearless fighters. In addition, their officers' necromancy keeps them under control.[ They always have a chance of berserking in combat.]\n" \
"  T'ah guards carry halberd, scimitar, and dirk. They also have a 50% chance of carrying a light bow. They wear quilted armour (worth 3 hits)[ with ensorceled bracing which effects half of all magical hits].[ This enchantment is tuned to the guards' auras so the power disappears if someone else dons the garment.]\n" \
},
{ // 6
"8. Yeomen are the village militia. They act much like the Ta'h guards but aren't as likely to attack. Make a saving roll on the Class Action Table (whether you're in the chateau or not). They dislike the T'ah guards, so wearing a uniform doesn't help you.\n" \
"  Yeomen carry a variety of weapons. [In combat they try to hit you with a javelin first, then close in. ]They will use a pike[ if in the open. At close range they'll drop the pike and fight with gladius and dirk]. Yeomen wear quilted silk armour and carry a buckler.\n" \
"  ST 18; IQ 9; CON 18; DEX 24; LK 12; CHR 6."
},
{ // 7
"9. T'ah officers wear meteoric metal torcs[ which repel all spells below level 4]. They use mithril rapiers (worth 4 dice plus 9 hits) and normal daggers. They are protected by ring-joined armour (7 hits).\n" \
"  On encountering an officer, make a saving roll on the Glib Tongue Table. If you fail, the officer attacks. On the second and subsequent combat rounds, the officer calls for help which come if you roll a 1 or a 2 (you may surrender if outnumbered: go to {105).\n" \
"  If you kill an officer, you can take his uniform and weapons. Subtract one from all saving rolls required by the Glib Tongue Table while you wear an officer's uniform.\n" \
"  ST 20; IQ 26; CON 18; DEX 18; LK 18; CHR 15."
},
{ // 8
"10. Grazide Lazier is shire chief. He detests the new duke. If you are wearing guard's clothing, make a L6-SR on CHR (45 - CHR). Failing the roll, he attacks. If you're outside the chateau, he calls yeomen on the third and succeeding rounds (roll one die each turn; if it's 1 or 2 a yeoman arrives and attacks).\n" \
"  If you make the saving roll required above or if you're in villager or prisoner outfit, he befriends you.[ Grazide will accompany you for 15 turns. He will fight guards or monsters with you. No villagers or yeomen will attack (you don't need to make saving rolls if you encounter them). Should you attack a villager, Grazide will immediately attack you. After the 15 turns, Grazide goes on his own again.]\n" \
"  ST 29; IQ 21; CON 21; DEX 19; LK 22; CHR 23."
},
{ // 9
"11. Ildrac T'ahlyst is weapons master and a rogue. He wears a torc of meteoric metal[ that repels level 1-3 spells]. He carries a broadsword and wears lamellar armour.\n" \
"  ST 41; IQ 17; CON 34; DEX 35; LK 31; CHR 14."
},
{ // 10
"12. Vuissane Testoniere is a villager and secret leader of the anti-Binaire forces. When you encounter him, you can use the Class Action Table (for villagers)[ or you can try to join him directly]. If you use the Class Action Table and make your saving roll, return to the paragraph that sent you here. If you fail, he attacks.\n" \
"  [If you try to join him, you reveal to him your true identity and he considers your story. If you can make L4-SRs on CHR and IQ (35 - CHR/IQ), he will assist you. If you fail either saving roll, he doesn't believe you and attacks.\n" \
"  If you join Vuissane, he will accompany you where you wish. You need not make saving rolls when you contact villages. Guards will automatically attack when Vuissane is present. Use Vuissane as a second character in any combats.\n" \
"  ]Vuissane is armed with rapier and dirks. He carries a light bow and wears lamellar armour.\n" \
"  ST 33; IQ 22; CON 24; DEX 35; LK 27; CHR 27."
}
};

MODULE SWORD cd_exits[CD_ROOMS][EXITS] =
{ { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  { 188, 183, 178,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  39,  75, 191,  -1,  -1,  -1,  -1,  -1 }, //   2
  { 166,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  { 101, 131, 175,  31,  -1,  -1,  -1,  -1 }, //   4
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  { 185, 162,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  70, 175,  54,  -1,  -1,  -1,  -1,  -1 }, //  16
  { 185,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  { 169,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {   2, 190,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  { 105,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  41, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {   2, 190,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {   4,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  { 137, 113,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  { 128,   4, 175,  -1,  -1,  -1,  -1,  -1 }, //  31
  { 155, 188, 183, 178,   1,  -1,  -1,  -1 }, //  32
  {  61,  10, 189,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  { 166,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  13,   9, 183,  93,  -1,  -1,  -1,  -1 }, //  37
  { 105,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {   2, 190,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  { 113, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {   2, 190,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  { 149,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  { 188, 183, 178,   1,  -1,  -1,  -1,  -1 }, //  44
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  { 187,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  { 113,  87,  19,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  { 187, 193, 109,  16,   2,  -1,  -1,  -1 }, //  54
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  { 189,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  { 134,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  96,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {   4, 184,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  { 188, 183, 178,   1,  -1,  -1,  -1,  -1 }, //  62
  { 168,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  { 167, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  { 146, 154,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  37,  13,   9, 172, 183,  -1,  -1,  -1 }, //  69
  { 117, 137,  16,  -1,  -1,  -1,  -1,  -1 }, //  70
  { 114, 151, 177, 173,  34,  -1,  -1,  -1 }, //  71
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  { 188,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  65,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  { 158,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  { 193, 131,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  { 148,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  { 188, 158, 183,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  48, 166,  57, 196,  -1,  -1,  -1,  -1 }, //  83
  { 187,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  32,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  { 187,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  { 163,  12, 138,  38,  -1,  -1,  -1,  -1 }, //  87
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  { 134,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  { 149,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  { 191, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {   2, 190,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  { 144,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  { 168,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  { 172,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  { 193,  54,  98,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  39,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  { 170,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  28,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  { 188, 183, 178,   1,  -1,  -1,  -1,  -1 }, // 116
  {  41,  70,  64,  -1,  -1,  -1,  -1,  -1 }, // 117
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  {  74,  29, 195, 178,  -1,  -1,  -1,  -1 }, // 119
  { 148,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  {  68,  42,  25, 103,  -1,  -1,  -1,  -1 }, // 121
  { 189,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  { 161, 187,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  {  82,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  { 118,  78,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  { 187,   4,  77,  -1,  -1,  -1,  -1,  -1 }, // 131
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  { 188, 183, 178,   1,  -1,  -1,  -1,  -1 }, // 134
  { 153,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  {  70,  28,  77,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  82,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  { 187,   4,  31,   2,  16,  -1,  -1,  -1 }, // 141
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  {  41, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  { 119,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  86,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  {  28,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  {  77, 187,  54, 109,  -1,  -1,  -1,  -1 }, // 149
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  { 123,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  33,  61,  10, 189,  -1,  -1,  -1,  -1 }, // 153
  {  21,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  {  44,  91,  58,  62,  -1,  -1,  -1,  -1 }, // 155
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157
  { 188,  82,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  {   2, 190,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  {  41, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168
  {  99,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  { 192, 141,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177
  {  32, 188, 119,  -1,  -1,  -1,  -1,  -1 }, // 178
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  { 187,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  {  69,  32,  82,  -1,  -1,  -1,  -1,  -1 }, // 183
  {  95, 115,  72, 160,  -1,  -1,  -1,  -1 }, // 184
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  { 108,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  { 131,  54, 175, 193,  -1,  -1,  -1,  -1 }, // 187
  {  32,  82, 178, 158,  -1,  -1,  -1,  -1 }, // 188
  {  26,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  61, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  {   2,  39,  75,  -1,  -1,  -1,  -1,  -1 }, // 191
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197
  { 105,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198
  { 172,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 200
};

MODULE STRPTR cd_pix[CD_ROOMS] =
{ "", //   0
  "",
  "",
  "",
  "",
  "", //   5
  "",
  "",
  "",
  "",
  "", //  10
  "",
  "cd12",
  "",
  "",
  "", //  15
  "",
  "",
  "",
  "",
  "", //  20
  "",
  "",
  "",
  "",
  "", //  25
  "",
  "",
  "",
  "",
  "", //  30
  "",
  "",
  "",
  "",
  "cd35", //  35
  "",
  "",
  "",
  "",
  "", //  40
  "",
  "",
  "",
  "",
  "", //  45
  "",
  "",
  "",
  "",
  "", //  50
  "",
  "",
  "",
  "",
  "", //  55
  "",
  "",
  "",
  "",
  "", //  60
  "",
  "",
  "",
  "",
  "", //  65
  "",
  "",
  "",
  "cd69",
  "", //  70
  "",
  "",
  "",
  "",
  "", //  75
  "",
  "",
  "",
  "",
  "", //  80
  "",
  "",
  "",
  "",
  "", //  85
  "",
  "",
  "",
  "",
  "", //  90
  "",
  "",
  "",
  "",
  "", //  95
  "",
  "",
  "",
  "",
  "", // 100
  "",
  "",
  "",
  "",
  "", // 105
  "",
  "",
  "",
  "",
  "", // 110
  "",
  "",
  "",
  "cd114",
  "", // 115
  "",
  "",
  "",
  "",
  "cd120", // 120
  "",
  "",
  "",
  "",
  "", // 125
  "",
  "",
  "",
  "",
  "", // 130
  "",
  "",
  "",
  "",
  "", // 135
  "",
  "",
  "",
  "",
  "", // 140
  "",
  "",
  "",
  "",
  "", // 145
  "",
  "",
  "",
  "",
  "", // 150
  "",
  "",
  "",
  "",
  "cd155", // 155
  "",
  "",
  "",
  "",
  "", // 160
  "",
  "",
  "",
  "",
  "", // 165
  "",
  "",
  "",
  "",
  "", // 170
  "",
  "",
  "",
  "",
  "", // 175
  "",
  "",
  "",
  "",
  "", // 180
  "",
  "",
  "",
  "",
  "", // 185
  "",
  "",
  "",
  "",
  "", // 190
  "",
  "",
  "",
  "",
  "", // 195
  "",
  "cd197",
  "",
  "",
  ""  // 200
};

EXPORT FLAG cd_inside[CD_ROOMS] =
{ TRUE, //   0
  FALSE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, //   5
  FALSE,
  FALSE,
  FALSE,
  FALSE,
  TRUE, //  10
  TRUE,
  TRUE,
  FALSE,
  TRUE,
  TRUE, //  15
  TRUE,
  FALSE,
  TRUE,
  TRUE,
  FALSE, //  20
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, //  25
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, //  30
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, //  35
  TRUE,
  FALSE,
  TRUE,
  TRUE,
  TRUE, //  40
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  FALSE, //  45
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, //  50
  TRUE,
  TRUE,
  FALSE,
  TRUE,
  TRUE, //  55
  FALSE,
  TRUE,
  FALSE,
  TRUE,
  TRUE, //  60
  TRUE,
  FALSE,
  TRUE,
  TRUE,
  TRUE, //  65
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, //  70
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, //  75
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, //  80
  TRUE,
  FALSE,
  TRUE,
  TRUE,
  FALSE, //  85
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  FALSE, //  90
  FALSE,
  TRUE,
  FALSE,
  TRUE,
  TRUE, //  95
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, // 100
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, // 105
  TRUE,
  FALSE,
  FALSE,
  TRUE,
  TRUE, // 110
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, // 115
  FALSE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, // 120
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, // 125
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, // 130
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, // 135
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, // 140
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  TRUE, // 145
  TRUE,
  FALSE,
  TRUE,
  TRUE,
  TRUE, // 150
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  FALSE, // 155
  TRUE,
  TRUE,
  FALSE,
  TRUE,
  TRUE, // 160
  TRUE,
  FALSE,
  TRUE,
  TRUE,
  FALSE, // 165
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  TRUE, // 170
  TRUE,
  FALSE,
  TRUE,
  FALSE,
  TRUE, // 175
  TRUE,
  TRUE,
  FALSE,
  TRUE,
  FALSE, // 180
  TRUE,
  FALSE,
  FALSE,
  TRUE,
  FALSE, // 185
  FALSE,
  TRUE,
  FALSE,
  TRUE,
  TRUE, // 190
  TRUE,
  TRUE,
  TRUE,
  TRUE,
  FALSE, // 195
  TRUE,
  TRUE,
  TRUE,
  FALSE,
  FALSE  // 200
};

EXPORT int                    alarum;

IMPORT int                    been[MOST_ROOMS + 1],
                              evil_attacktotal,
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              healable_st, healable_iq, healable_con, healable_dex,
                              armour,
                              good_attacktotal,
                              good_shocktotal,
                              good_hitstaken,
                              evil_hitstaken,
                              gp, sp, cp, rt, lt, both,
                              height, weight, sex, race, class, size,
                              room, prevroom,
                              module,
                              spellchosen,
                              spelllevel,
                              spellpower,
                              theround;
IMPORT       SWORD*           exits;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct LanguageStruct  language[LANGUAGES];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

MODULE int                    costume,
                              guards,
                              servants,
                              villagers,
                              yeomen,
                              wp[12];

IMPORT void (* enterroom) (void);

MODULE void cd_enterroom(void);
MODULE void cd_wandering(void);
MODULE FLAG classactiontable(int who);
MODULE FLAG glibtonguetable(int difficulty);
MODULE void cd_killedguards(int amount);

EXPORT void cd_preinit(void)
{   int i;

    descs[MODULE_CD]   = cd_desc;
    wanders[MODULE_CD] = cd_wandertext;
    for (i = 0; i < CD_ROOMS; i++)
    {   pix[i] = cd_pix[i];
}   }

EXPORT void cd_init(void)
{   int i;

    exits        = &cd_exits[0][0];
    enterroom    = cd_enterroom;

    alarum       = -1;
    guards       =
    servants     =
    villagers    =
    yeomen       = 0;
    costume      = COSTUME_PRISONER;

    for (i = 0; i < 11; i++)
    {   wp[i] = 0; // unmet and alive
}   }

MODULE void cd_enterroom(void)
{   TRANSIENT int  choice,
                   i, j,
                   oldguards,
                   result,
                   temp;
    TRANSIENT FLAG attacking,
                   done;
    PERSIST   int  causecheck = 0,
                   direction,
                   wall;

    switch (room)
    {
    case 0:
        costume = COSTUME_PRISONER;
    acase 1:
        cd_wandering();
    acase 2:
        if (prevroom != 150)
        {   DISCARD makelight();
            if (lightsource() != LIGHT_NONE && lightsource() != LIGHT_CE)
            {   causecheck = 2;
                room = 150;
        }   }
    acase 5:
        room = prevroom;
    acase 6:
        result = dice(1);
        for (i = 0; i < result; i++)
        {   elapse(10, TRUE);
            if (!saved(3, lk))
            {   yeomen = dice(1);
                room = 185;
                break;
        }   }
        if (room == 6)
        {   room = 162;
        }
    acase 7:
        dispose_npcs();
        if (!saved(3, st))
        {   templose_st(misseditby(3, st));
        }
        if (!saved(3, con))
        {   templose_con(misseditby(3, con));
        }
    acase 8:
        if (!countfoes() && prevroom != 195)
        {   create_monster(98);
        }
        theround = 0;
        oneround();
        if (!countfoes())
        {   room = 162;
        } else
        {   yeomen = dice(1);
            room = 185;
        }
    acase 9:
        if (dice(1) % 2 == 0)
        {   room = 186;
        } else
        {   create_monster(90);
            fight();
            lose_chr(1);
            owe_chr(3);
            room = 172;
        }
    acase 10:
        if (saved(3, dex))
        {   room = 51;
        } else
        {   room = 110;
        }
    acase 11:
        room = prevroom;
    acase 12:
        create_monster(99);
        do
        {   oneround();
            if (!countfoes() || npc[0].st <= 5 || npc[0].con <= 5)
            {   dispose_npcs();
                room = 63;
            } elif (st <= 5 || con <= 5)
            {   room = 105;
        }   }
        while (room == 12);
    acase 13:
        if (dice(1) % 2 == 0)
        {   room = 90;
        } else
        {   create_monster(90);
            good_freeattack();
            fight();
            room = 172;
        }
    acase 14:
        if (saved(2, spd))
        {   room = 181;
        } else
        {   room = 99;
        }
    acase 15:
        if (spelllevel >= 4)
        {   alarum = dice(6);
            room = 187;
        } else
        {   room = 71;
        }
    acase 16:
        if (prevroom != 132 && !saved(2, lk))
        {   room = 132;
        }
    acase 17:
        yeomen = dice(1);
    acase 18:
        if (dice(1) % 2 == 0)
        {   room = 71;
        }
    acase 19:
        if (saved(level, dex))
        {   room = 168;
        } else
        {   room = 87;
        }
    acase 20:
        rb_givejewels(-1, -1, 1, dice(2));
    acase 21:
        if (prevroom == 97)
        {   room = 187;
        } else
        {   room = 97;
        }
    acase 22:
        if (saved(3, dex))
        {   dispose_npcs();
        } else
        {   die();
        }
    acase 24:
        if (prevroom != 171)
        {   room = 171;
        }
    acase 25:
        create_monster(101);
        DISCARD castspell(-1, FALSE);
        if (room == 25 && countfoes())
        {   room = 103;
        }
    acase 26:
        if (saved(level, dex))
        {   room = 83;
        } else
        {   room = 3;
        }
    acase 27:
        if (shop_give(10) != -1)
        {   shop_give(10);
        }
    acase 28:
        if (prevroom != 171)
        {   room = 171;
        }
    acase 29:
        good_takehits(18, TRUE);
    acase 30:
        award(100);
    acase 33:
        i = 1;
        while (getyn("Search (otherwise leave)"))
        {   if (!saved(i, con))
            {   templose_con(misseditby(i, con));
            }
            if (saved(3, lk))
            {   rb_givejewels(-1, -1, 1, dice(1));
            } else
            {   result = dice(1);
                for (j = 1; j <= result; j++)
                {   create_monster(100);
                }
                fight();
            }
            i++;
        }
    acase 34:
        lose_chr(1);
    acase 35:
        templose_st(dice(1));
        gain_flag_ability(21);
    acase 36:
        dispose_npcs();
        if (saved(1, spd))
        {   room = 4;
        } else
        {   room = 105;
        }
    acase 37:
        if (saved(3, chr))
        {   room = 199;
        }
    acase 38:
        elapse(ONE_DAY * 14, FALSE);
        award(200);
        templose_con(dice(1)); // %%: presumably armour doesn't help
    acase 39:
        if (!saved(5, lk))
        {   room = 121;
        }
    acase 40:
        getsavingthrow(FALSE);
        if (madeit(5, 35)) // Ildrac's DEX
        {   good_takehits(dice(2) + 1 + 10, TRUE);
            room = 142;
        } else
        {   dispose_npcs();
            room = 131;
        }
    acase 41:
        if (prevroom != 171)
        {   if (castspell(-1, FALSE))
            {   room = 164;
            } else
            {   room = 171;
        }   }
    acase 42:
        if (!saved(level, spd))
        {   room = 103;
        }
    acase 43:
        if (costume != COSTUME_SERVANT && getyn("Wear servant costume"))
        {   costume = COSTUME_SERVANT;
        }
        waitforever(); // %%: maybe we shouldn't force the player to do this, if for some reason they don't want to
    acase 44:
        if (class == WARRIOR)
        {   if (saved(3, chr))
            {   give(330); // %%: or perhaps it is intended that the player must quaff the potion immediately
            } else
            {   room = 134;
        }   }
        else
        {   room = 116;
        }
    acase 45:
        villagers = dice(1);
        if (castspell(-1, FALSE))
        {   room = 182;
        } else
        {   room = 144;
        }
    acase 46:
        if (canfly(TRUE))
        {   room = 145;
        } else
        {   if (!saved(5, con))
            {   templose_con(misseditby(5, con));
            }
            drop_all(); // %%: do we lose gp, etc. too? We assume so.
            room = 188;
        }
    acase 47:
        award(50);
        room = causecheck;
    acase 48:
        create_monster(103);
        DISCARD castspell(-1, FALSE);
        // %%: it's ambiguous about what happens if you don't kill it in one round.
        // %%: we are going to 194 in that case.
        if (room == 48 && countfoes())
        {   room = 194;
        } else
        {   room = 122;
        }
    acase 49:
        create_monster(92);
        fight();
        give_gp(dice(2));
        cd_killedguards(1);
    acase 51:
        award(200);
    acase 52:
        die();
    acase 53:
        payload(TRUE);
        fight();
        room = 6;
    acase 54:
        // %%: we are assuming hatchet = taper axe
        choice = getnumber("Take how many hatchets",   0,  100);
        give_multi(HAT, choice);
        // %%: it doesn't say whether there are a limited number of these items
        choice = getnumber("Take what length of rope", 0, 1000);
        give_multi(ROP, choice);
        choice = getnumber("Take how many lanterns",   0, 1000);
        give_multi(LAN, choice);
        // %%: it doesn't say whether they are allowed to take oil for their lantern(s); we assume not.
        choice = getnumber("Take how many torches",    0, 1000);
        give_multi(TOR, choice);
        choice = getnumber("Take how many spears",     0,  100);
        give_multi(SPE, choice);
        if (getyn("Rest (otherwise leave)"))
        {   elapse(10, TRUE);
            if (!saved(1, lk))
            {   room = 97;
        }   }
    acase 55:
        payload(TRUE);
        if (countfoes())
        {   room = 194;
        } else
        {   room = 122;
        }
    acase 56:
        yeomen = dice(1);
        for (i = 1; i <= yeomen; i++)
        {   if (!classactiontable(COSTUME_VILLAGER))
            {   room = 185;
                break;
        }   }
        if (room == 56)
        {   room = 162;
        }
    acase 57:
        award(100);
    acase 58:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].dice || items[i].adds)
            {   dropitems(i, items[i].owned);
        }   }
    acase 59:
        dispose_npcs();
        getsavingthrow(FALSE);
        if (madeit(5, 25))
        {   good_takehits(dice(3) + 1, TRUE); // spear damage
        }
    acase 60:
        while (shop_give(3) != -1);
        // %%: it doesn't say whether they are allowed to take arrows for their bow(s); we assume not.
    acase 61:
        if (cast(SPELL_RE, FALSE))
        {   room = 197;
        } else
        {   room = 10;
        }
    acase 62:
        award(-50);
        owe_chr(5);
    acase 63:
        award(300);
        gain_iq(2);
        gain_dex(2);
        give_multi(331, 10);
    acase 64:
        if (gotrope(50))
        {   room = 100;
        }
    acase 66:
        if (spellpower >= 100)
        {   room = 30;
        } else
        {   rebound(FALSE);
            room = 179;
        }
    acase 67:
        if (costume != COSTUME_GUARD && getyn("Wear guard costume"))
        {   costume = COSTUME_GUARD;
        }
        give_gp(dice(1));
        room = causecheck;
    acase 68:
        if (saved(3, iq))
        {   room = 159;
        } else
        {   room = 103;
        }
    acase 70:
        if (prevroom != 171)
        {   room = 171;
        }
    acase 71:
        alarum = -1;
        drop_all();
        if (!saved(2, con))
        {   templose_con(misseditby(2, con));
        }
    acase 72:
        if (!countfoes())
        {   create_monster(96);
        }
        fight();
        wp[9] = 2;
        room = 27;
    acase 73:
        for (i = 1; i <= guards; i++)
        {   getsavingthrow(FALSE);
            if (!madeit(5, 23)) // guard DEX
            {   good_takehits(dice(3), TRUE); // light self-bow (CDp76-77) gets 3 dice
        }   }
        dispose_npcs();
    acase 74:
        if (saved(level, chr))
        {   room = 162;
        } else
        {   yeomen = dice(1);
            room = 185;
        }
    acase 76:
        fight();
        room = 158;
    acase 77:
        if (prevroom != 132 && !saved(2, lk))
        {   room = 132;
        }
    acase 78:
        direction = 1; // feet first
        if (saved(4, con))
        {   room = 135;
        } else
        {   templose_con(misseditby(4, con));
            room = 153;
        }
    acase 79:
        give(199);
    acase 80:
        if
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
         || lightsource() == SPELL_WO // %%: we assume SPELL_WO would be treated like a torch/lantern
        )
        {   if (saved(4, lk))
            {   room = 133;
        }   }
        else
        {   if (saved(2, lk))
            {   room = 133;
        }   }
        if (room == 80)
        {   room = causecheck;
        }
    acase 81:
        gain_iq(dice(1));
        gain_flag_ability(22);
        award(200);
    acase 84:
        costume = COSTUME_SERVANT;
    acase 86:
        alarum = dice(3);
        give_multi(PON, 2);
    acase 88:
        die();
    acase 90:
        if (saved(3, lk))
        {   create_monster(88); // %%: but what if we already run into him (eg. as a WP) and killed him?
            good_takehits(20, TRUE);
            good_freeattack();
            if (countfoes())
            {   good_takehits(90, TRUE);
                kill_npcs();
            }
            wp[2] = 2;
            award(200);
            room = 172;
        } else
        {   room = 180;
        }
    acase 92:
        dispose_npcs();
        if (costume != COSTUME_SERVANT && getyn("Wear servant costume"))
        {   costume = COSTUME_SERVANT;
        }
        waitforever();
        give_multi(200, 10);
    acase 93:
        oddeven(180, 172);
    acase 94:
        if (getyn("Drop light"))
        {   room = 127;
            switch (lightsource())
            {
            case LIGHT_TORCH:
                dropitem(TOR);
            acase LIGHT_UWTORCH:
                dropitem(ITEM_BS_UWTORCH);
            acase LIGHT_LANTERN:
                dropitem(LAN);
        }   }
        else
        {   // %%: Magic Matrix is supposed to support this room but doesn't!
            fight();
            room = 162;
        }
    acase 95:
        if (saved(2, spd))
        {   room = 4;
        } else
        {   room = 142;
        }
    acase 96:
        if (saved(3, lk))
        {   room = 157;
        } else
        {   room = 46;
        }
    acase 97:
        if (countfoes())
        {   create_monster(92);
        }
        DISCARD castspell(-1, FALSE);
        if (room == 97)
        {   fight();
            cd_killedguards(1);
            room = 67;
        }
    acase 98:
        if (prevroom != 150)
        {   makelight();
            if
            (   lightsource() != LIGHT_NONE
             && lightsource() != LIGHT_CE
            )
            {   causecheck = 98;
                room = 150;
        }   }
    acase 99:
        create_monster(92);
        theround = 0;
        if (saved(3, dex))
        {   good_freeattack();
        } else
        {   oneround(); // %%: it's ambiguous about whether we get to generate an attack total for the good side
        }
        if (countfoes())
        {   if (saved(3, dex))
            {   good_freeattack();
            } else
            {   oneround(); // %%: it's ambiguous about whether we get to generate an attack total for the good side
            }
            while (countfoes())
            {   fight();
        }   }
        if (getyn("Strip body"))
        {   cd_killedguards(1);
            alarum = dice(2);
        } else
        {   // strictly speaking, we shouldn't have let them auto-loot the armour
            alarum = dice(4);
        }
        room = 187;
    acase 100:
        if (saved(3, iq))
        {   room = 140;
        } else
        {   if (!saved(6, con))
            {   award(5 * misseditby(6, con)); // order-dependent
                templose_con(misseditby(6, con));
            }
            room = 82;
        }
    acase 101:
        if
        (   saved(3, dex)
         || cast(SPELL_KK, FALSE)
        )
        {   room = 60;
        } else
        {   room = 4;
        }
    acase 102:
        if (saved(3, dex))
        {   room = 197;
        } else
        {   die();
        }
    acase 103:
        if (!countfoes())
        {   create_monster(101);
        }
        theround = 0;
        while (countfoes())
        {   temp = npc[0].mr / 30;
            if (npc[0].mr % 30)
            {   temp++;
            }
            if (saved(temp, dex))
            {   good_freeattack();
            } else
            {   templose_con(misseditby(temp, dex));
                owe_dex(misseditby(temp, dex));
                healable_dex += misseditby(temp, dex);
                oneround(); // %%: presumably a normal combat round occurs, it doesn't explicitly say.
        }   }
    acase 105:
        dispose_npcs();
        drop_all();
        gain_flag_ability(23);
        award(200);
    acase 106:
        award(300);
        gain_iq(2);
    acase 107:
        victory(1500 + ((4 - level) * 500) + ((50 - calc_personaladds(st, lk, dex)) * 30));
    acase 108:
        create_monster(88);
        payload(TRUE);
        if (countfoes())
        {   good_takehits(90, TRUE);
            dispose_npcs();
        }
        wp[2] = 2;
        award(150);
    acase 109:
        attacking = FALSE;
        if (dice(1) % 2 == 0)
        {   result = dice(1);
            oldguards = guards = (result / 2) + (result % 2);
            for (i = 0; i < guards; i++)
            {   if (!glibtonguetable(0))
                {   attacking = TRUE;
                    break;
            }   }
            if (attacking)
            {   create_monster(92);
                guards--;
                theround = 0;
                oneround();
                if (guards)
                {   create_monster(92);
                    guards--;
                }
                oneround();
                if (guards)
                {   create_monster(92);
                    guards--;
                }
                do
                {   oneround();
                } while (countfoes());
                cd_killedguards(oldguards);
        }   }
        else
        {   result = dice(1);
            servants = (result / 2) + (result % 2);
            for (i = 0; i < servants; i++)
            {   if (!classactiontable(COSTUME_SERVANT))
                {   attacking = TRUE;
                    break;
            }   }
            if (attacking)
            {   create_monster(91);
                servants--;
                theround = 0;
                oneround();
                if (servants)
                {   create_monster(91);
                    servants--;
                }
                oneround();
                if (servants)
                {   create_monster(91);
                    servants--;
                }
                do
                {   oneround();
                } while (countfoes());
        }   }

    acase 110:
        if (!saved(4, st))
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && items[i].type != ARMOUR && items[i].type != SHIELD) // %%: it seems to exclude armour/shields
                {   temp = items[i].owned;
                    for (j = 1; j <= temp; j++)
                    {   if (!saved(1, dex))
                        {   dropitem(i);
        }   }   }   }   }

    acase 111:
        die();
    acase 112:
        if (armour != -1)
        {   if (!saved(3, con))
            {   templose_con(misseditby(3, con));
            }
            dropitem(armour);
            armour = -1;
        } // %%: what about carried armour?
    acase 113:
        if ((prevroom != 126 || class == WARRIOR) && getyn("Search for secret doors"))
        {   room = 126;
        }
    acase 114:
        if (saved(3, chr))
        {   room = 84;
        } else
        {   room = 65;
        }
    acase 115:
        create_monster(96);
        DISCARD castspell(-1, FALSE);
        if (!countfoes())
        {   wp[9] = 2;
        }
        if (room == 115)
        {   if (countfoes())
            {   room = 72;
            } else
            {   room = 27;
        }   }
    acase 116:
#ifdef CORGI
        if (getyn("Test your mind (otherwise flee)"))
#else
        if (1)
#endif
        {   if (saved(4, iq))
            {   gain_iq(5);
                gain_dex(2);
                award(50);
            } else
            {   room = 134;
        }   }
        else
        {   room = 200;
        }
    acase 117:
        if (prevroom != 171)
        {   room = 171;
        }
    acase 118:
        direction = 0; // head first
        result = dice(1);
        if (result >= 5)
        {   room = 135;
        } else
        {   templose_con(result);
            room = 153;
        }
    acase 119:
        if (been[119])
        {   room = 56;
        }
    acase 120:
        // %%: does the usual rule about rogues not learning spells higher than 7th level apply? We assume so.
        for (i = 0; i < SPELLS; i++)
        {   if (!spell[i].known && (class != ROGUE || spell[i].level <= 7))
            {   listspell(i, TRUE);
        }   }
        do
        {   done = FALSE;
            result = getspell("Learn which spell (ENTER for none)");
            if (result == -1)
            {   done = TRUE;
            } elif (spell[result].known)
            {   aprintf("You already know %s!\n", spell[result].corginame);
            } elif (class == ROGUE && spell[result].level > 7)
            {   aprintf("Rogues can't learn spells beyond level 7!\n");
            } else
            {   learnspell(result);
                done = TRUE;
        }   }
        while (!done);
    acase 122:
        // %%: why are we meant to roll one die?
        dispose_npcs();
        give(198);
    acase 123:
        // we don't give(SCI) because they already looted it from the corpse
        alarum = dice(1);
    acase 124:
        temp = (wall / 10) + 1;
        if (!madeit(temp, con))
        {   award(5 * misseditby(temp, con)); // order-dependent!
            templose_con(misseditby(temp, con));
        }
    acase 125:
        costume = COSTUME_PRISONER;
    acase 126:
        if (class != WARRIOR)
        {   DISCARD castspell(-1, FALSE);
        } else
        {   if
            (   (!been[126] && saved(3, iq))
             || ( been[126] && saved(4, iq)) // %%: does it increase by 1 level each time? Or just once? We assume it's just once.
            )
            {   room = 50;
            } else
            {   room = 113;
        }   }
    acase 127:
        dispose_npcs();
    acase 128:
        guards = dice(1);
        attacking = FALSE;
        for (i = 0; i < guards; i++)
        {   if (!glibtonguetable(0))
            {   attacking = TRUE;
                break;
        }   }
        if (attacking)
        {   if (getyn("Yield (otherwise fight)"))
            {   lose_chr(1);
                room = 105;
            } else
            {   create_monsters(92, guards);
                DISCARD castspell(FALSE, -1);
                if (room == 128)
                {   fight();
                    cd_killedguards(guards);
                    room = 158;
        }   }   }
        else
        {   room = 158;
        }
    acase 130:
        if (saved(2, lk))
        {   room = 89;
        } else
        {   if (!saved(3, con))
            {   templose_con(misseditby(3, con)); // %%: does armour help? We assume not.
            }
            room = 23;
        }
    acase 132:
        if (!glibtonguetable(0))
        {   guards = 1;
            create_monster(92);
            theround = 0;
            oneround();
            if (countfoes())
            {   oneround();
            }
            while (countfoes())
            {   if (dice(1) <= 2)
                {   guards++;
                    create_monster(92);
                }
                oneround();
            }
            cd_killedguards(guards);
        }
        room = prevroom;
    acase 133:
        if (glibtonguetable(0))
        {   room = causecheck;
        } else
        {   room = 97;
        }
    acase 134:
        if (prevroom == 58 || prevroom == 91)
        {   temp = 5;
        } else
        {   temp = 4;
        }
        if (saved(temp, st )) { gain_st(2);  } else { permlose_st( misseditby(temp, st )); }
        if (saved(temp, iq )) { gain_iq(2);  } else {     lose_iq( misseditby(temp, iq )); }
        if (saved(temp, lk )) { gain_lk(2);  } else {     lose_lk( misseditby(temp, lk )); }
        if (saved(temp, dex)) { gain_dex(2); } else {     lose_dex(misseditby(temp, dex)); }
        if (saved(temp, con)) { gain_con(2); } else { permlose_con(misseditby(temp, con)); }
        if (saved(temp, chr)) { gain_chr(2); } else {     lose_chr(misseditby(temp, chr)); }
        if (saved(temp, spd)) { gain_spd(2); } else {     lose_spd(misseditby(temp, spd)); }
    acase 135:
        give_multi(201, dice(2));
    acase 136:
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   room = 97;
        } else
        {   room = 67;
        }
    acase 137:
        if (prevroom != 171)
        {   room = 171;
        }
    acase 138:
        create_monster(99);
        npc_templose_st(0, 8); // %%: assuming he doesn't have a staff
        good_takehits(npc[0].level + calc_personaladds(npc[0].st, npc[0].lk, npc[0].dex), TRUE);
        fight();
        room = 63;
    acase 139:
        for (i = 0; i < yeomen; i++)
        {   getsavingthrow(FALSE);
            if (madeit(5, 24))
            {   good_takehits(dice(3) + 1, TRUE); // spear damage
        }   }
        dispose_npcs();
    acase 140:
        award(10);
    acase 142:
        if (!saved(1, con))
        {   templose_con(misseditby(1, con));
        }
        if (countfoes())
        {   create_monster(96);
        }
        theround = 0;
        while (countfoes())
        {   if (getyn("Yield"))
            {   dispose_npcs();
                lose_chr(1);
                room = 105;
            } else
            {   oneround();
        }   }
        if (room == 142)
        {   wp[9] = 2;
            room = 27;
        }
    acase 143:
        if (prevroom != 171)
        {   room = 171;
        }
    acase 144:
        if (!countfoes())
        {   create_monsters(90, villagers);
        }
        theround = 0;
        do
        {   oneround();
        } while (countfoes());
        room = 20;
    acase 146:
        create_monster(102);
        evil_missileattack(RANGE_POINTBLANK, 0);
        fight();
        rb_givejewels(-1, SIZE_SMALL, 1, dice(1));
    acase 148:
        switch (dice(2))
        {
        case 2:
            gain_iq(dice(1));
        acase 3:
            gain_st(dice(1));
        acase 4:
            gain_lk(dice(1));
        acase 5:
            gain_chr(2);
            gain_dex(2);
        acase 6:
            gain_st(3);
            gain_con(3);
        acase 7:
            gain_lk(1);
            gain_dex(1);
        acase 8:
            permlose_st(3);
            permlose_con(3);
        acase 9:
            lose_chr(2);
            lose_dex(2);
        acase 10:
            lose_lk(dice(1));
        acase 11:
            permlose_st(dice(1));
        acase 12:
            lose_iq(dice(1));
        }
    acase 149:
        if (getyn("Take torch"))
        {   give(TOR);
        }
        if (getyn("Take lantern"))
        {   give(LAN);
        }
        if (getyn("Take rope"))
        {   give_multi(ROP, 50); // %%: it doesn't say what length of rope
        }
        if (getyn("Take meat cleaver"))
        {   give(202);
        }
        choice = getnumber("Take how many knives", 0, 100);
        if (choice)
        {   for (i = 0; i < choice; i++)
            {   give(203);
        }   }
    acase 150:
        if (saved(3, iq))
        {   room = 47;
        } else
        {   if (!saved(4, con))
            {   templose_con(misseditby(4, con));
            }
            award(100);
            owe_chr(5);
            room = causecheck;
        }
    acase 151:
        templose_con(dice(1));
        create_monster(92);
        theround = 0;
        do
        {   if (!saved(theround + 1, con))
            {   templose_con(misseditby(theround + 1, con));
            }
            getsavingthrow(FALSE);
            if (!madeit(theround + 1, npc[0].con))
            {   npc_templose_hp(0, misseditby(theround + 1, npc[0].con));
            }
            oneround();
        } while (countfoes());
        cd_killedguards(1);
        room = 123;
    acase 152:
        if
        (   saved(1, st)
         || cast(SPELL_KK, FALSE)
        )
        {   room = 50;
        } else
        {   room = 113;
        }
    acase 153:
        create_monsters(100, dice(2));
        theround = 0;
        if (direction == 0) // head first
        {   good_freeattack();
            while (countfoes())
            {   oneround();
        }   }
        else // feet first
        {   fight();
        }
    acase 156:
        spellpower *= 2;
        payload(TRUE);
        spellpower /= 8;
        rebound(FALSE);
    acase 157:
        if (canfly(TRUE))
        {   room = 112;
        } else
        {   if (!saved(3, con))
            {   templose_con(misseditby(3, con));
            }
            drop_all();
            room = 170;
        }
    acase 159:
        give(204);
    acase 160:
        if (glibtonguetable(0))
        {   if (saved(3, chr))
            {   room = 27;
            } else
            {   room = 4;
        }   }
        else
        {   room = 198;
        }
    acase 161:
        if (saved(3, lk))
        {   costume = COSTUME_GUARD;
            room = 187;
        } else
        {   room = 49;
        }
    acase 162:
        rb_givejewels(-1, -1, 1, dice(2));
    acase 163:
        choice = getnumber("1) IQ\n2) CHR\nWhich", 1, 2);
        if (saved(4, choice == 1 ? iq : chr))
        {   room = 106;
        } else
        {   room = 105;
        }
    acase 164:
        if (spellchosen == SPELL_RE)
        {   room = 143;
        } elif (spellchosen == SPELL_KK)
        {   room = 24;
        }
    acase 165:
        payload(TRUE);
    acase 166:
        if (!countfoes())
        {   create_monster(103);
        }
        theround = 0;
        good_freeattack();
        room = 194;
    acase 167:
        temp = 0;
        for (wall = 50; wall > 0; wall -= 10)
        {   if (!saved(1, st))
            {   temp++;
                if (temp >= 2)
                {   room = 124;
                    break;
            }   }
            if (!saved(1, dex))
            {   temp++;
                if (temp >= 2)
                {   room = 124;
                    break;
        }   }   }
        if (room == 167)
        {   award(100);
            if (!saved(2, lk))
            {   cd_wandering();
            }
            room = 82;
        }
    acase 168:
        if (class == WARRIOR)
        {   room = 79;
        } else // %%: what about warrior-wizards?
        {   room = 120;
        }
    acase 170:
        for (i = 0; i < ITEMS; i++)
        {   temp = items[i].owned;
            if (temp)
            {   for (j = 1; j <= temp; j++)
                {   if (!saved(1, dex))
                    {   dropitem(i);
        }   }   }   }
    acase 171:
        causecheck = prevroom;
        if (saved(1, lk))
        {   room = prevroom;
        } elif (class == WARRIOR)
        {   room = 133;
        } else
        {   castspell(-1, FALSE);
        }
    acase 172:
        result = dice(1);
        for (i = 1; i <= result; i++)
        {   elapse(10, TRUE);
            if (!saved(i, lk))
            {   room = 45;
                break;
        }   }
        if (room == 172)
        {   room = 20;
        }
    acase 173:
        DISCARD castspell(-1, FALSE);
        if (room == 173)
        {   room = 71;
        }
    acase 174:
        ; // don't call payload(TRUE); that would kill him
    acase 175:
        // %%: it doesn't say whether there are a limited number of these items
        choice = getnumber("Take what length of rope", 0, 1000);
        give_multi(148, choice);
        choice = getnumber("Take how many torches",    0, 1000);
        give_multi(146, choice);
        choice = getnumber("Take how many whips",      0,  100);
        give_multi(205, choice);
        choice = getnumber("Take how many spears",     0,  100);
        give_multi( 64, choice);
        choice = getnumber("Take how many daggers",    0,  100);
        give_multi( 75, choice); // %%: it just says "various daggers". We are only supporting dirks
    acase 176:
        if (spellpower < 50)
        {   room = 151;
        } else
        {   if (saved(3, con))
            {   templose_con(misseditby(3, con)); // %%: it doesn't say whether armour helps. Not that we would be wearing any.
            }
            alarum = dice(3);
            room = 187;
        }
    acase 177:
        result = dice(3);
        for (i = 1; i <= result; i++)
        {   if (!saved(2, st))
            {   owe_st(misseditby(2, st));
                healable_st += misseditby(2, st);
            }
            if (!saved(1, con))
            {   owe_con(misseditby(1, con));
                healable_con += misseditby(1, con);
            }
            if (i % 5 == 0)
            {   if (!saved(level, iq))
                {   owe_iq(misseditby(level, iq));
                    healable_iq += misseditby(level, iq);
            }   }
            if (i < result && getyn("Quit tunnelling"))
            {   room = 23;
                break;
        }   }
        if (room == 177)
        {   room = 130;
        }
    acase 178:
        if (dice(1) <= 2)
        {   cd_wandering();
        }
    acase 179:
        if (saved(4, dex))
        {   room = 66;
        } else
        {   die();
        }
    acase 180:
        die();
    acase 181:
        alarum = dice(5);
    acase 182:
        create_monsters(90, villagers);
        DISCARD castspell(FALSE, -1);
        if (room == 182)
        {   if (countfoes())
            {   room = 144;
            } else
            {   room = 20;
        }   }
    acase 183:
        if (dice(1) % 2 == 0)
        {   cd_wandering();
        }
    acase 184:
        wp[9] = 1;
    acase 185:
        create_monsters(93, yeomen);
        if
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
        ) // %%: it says "carrying"
        {   room = 94; // misprinted as 103 in book
        } else
        {   DISCARD castspell(-1, FALSE);
            if (room == 185 && countfoes())
            {   fight();
                room = 162;
        }   }
    acase 186:
        DISCARD castspell(-1, FALSE);
    acase 187:
        if (dice(1) % 2 == 0)
        {   cd_wandering();
        }
    acase 188:
        dispose_npcs();
        cd_wandering();
    acase 189:
        if (cast(SPELL_RE, FALSE))
        {   room = 83;
        }
    acase 190:
        if (!saved(1, con))
        {   templose_con(misseditby(1, con));
        }
        if (!saved(level, dex))
        {   room = 110;
        }
    acase 192:
        create_monster(104);
        theround = 0;
        do
        {   if (saved(2, dex))
            {   if (saved(2, spd))
                {   good_freeattack();
                } else
                {   oneround();
            }   }
            else
            {   if (saved(2, spd))
                {   oneround();
                } else
                {   evil_freeattack();
        }   }   }
        while (countfoes());
        lose_iq(1);
        room = 141;
    acase 193:
        result = dice(1);
        servants = (result / 2) + (result % 2);
        attacking = FALSE;
        for (i = 1; i <= servants; i++)
        {   if (!classactiontable(COSTUME_SERVANT))
            {   attacking = TRUE;
                break;
        }   }
        if (attacking)
        {   both = EMPTY;
            give(202); // meat cleaver
            give(203); // knife
            rt = 202;
            lt = 203;
            create_monsters(91, servants);
            good_hitstaken =
            evil_hitstaken =
            theround       = 0;
            oneround();
            oneround();
            oneround();
            oneround();
            if (countfoes())
            {   if (good_hitstaken < evil_hitstaken) // %%: it's ambiguous about what to do if both are equal
                {   room = 92;
                } else
                {   room = 105;
            }   }
            else
            {   room = 92;
        }   }
        else
        {   room = 43;
        }
    acase 194:
        temp = npc[0].mr / 10;
        if (npc[0].mr % 10)
        {   temp++;
        }
        dispose_npcs();
        create_monsters(105, temp);
        fight();
        room = 122;
    acase 195:
        create_monster(98);
        DISCARD castspell(-1, FALSE);
        if (room == 195)
        {   room = 8;
        }
    acase 196:
        if (saved(3, spd))
        {   dispose_npcs();
            room = 122;
        } else
        {   room = 35;
        }
    acase 197:
        DISCARD castspell(-1, FALSE);
        if (room == 197)
        {   die();
        }
    acase 200:
        award(500); // strictly speaking, we are supposed to wait until after the BS encounter before awarding this
        module = MODULE_BS;
        room = -1;
}   }

MODULE FLAG classactiontable(int who)
{   getsavingthrow(TRUE);
    if
    (   ( cd_inside[room] && who == COSTUME_VILLAGER)
     || (!cd_inside[room] && who == COSTUME_SERVANT )
    )
    {   return madeit(1 + (race == HUMAN) ? 0 : 1, chr);
    } elif (cd_inside[room] && who == COSTUME_SERVANT)
    {   if (costume == COSTUME_PRISONER)
        {   return madeit(4 + (race == HUMAN) ? 0 : 1, chr);
        } elif (costume == COSTUME_SERVANT)
        {   return madeit(1 + (race == HUMAN) ? 0 : 1, chr);
        } elif (costume == COSTUME_VILLAGER)
        {   return madeit(2 + (race == HUMAN) ? 0 : 1, iq);
        } elif (costume == COSTUME_GUARD || costume == COSTUME_OFFICER)
        {   return madeit(1 + (race == HUMAN) ? 0 : 1, iq);
    }   }
    elif (!cd_inside[room] && who == COSTUME_VILLAGER)
    {   if (costume == COSTUME_PRISONER)
        {   return madeit(2 + (race == HUMAN) ? 0 : 1, chr);
        } elif (costume == COSTUME_SERVANT)
        {   return madeit(3 + (race == HUMAN) ? 0 : 1, chr);
        } elif (costume == COSTUME_VILLAGER)
        {   return madeit(1 + (race == HUMAN) ? 0 : 1, chr);
        } elif (costume == COSTUME_GUARD || costume == COSTUME_OFFICER)
        {   return madeit(4 + (race == HUMAN) ? 0 : 1, chr);
    }   }

    return FALSE; // to avoid spurious Visual C compiler warnings
}

MODULE FLAG glibtonguetable(int difficulty)
{   int  i,
         temp = 0; // initialized to avoid a spurious SAS/C optimizer warning
    FLAG none = TRUE;

    if (gotrope(1)) // rope
    {   none = FALSE;
        getsavingthrow(TRUE);
        switch (costume)
        {
        case COSTUME_PRISONER:
            temp = 6;
        acase COSTUME_SERVANT:
            temp = 2;
        acase COSTUME_VILLAGER:
            temp = 3;
        acase COSTUME_GUARD:
            temp = 1;
        acase COSTUME_OFFICER:
            temp = 0;
        }
        temp += difficulty + ((race != HUMAN) ? 1 : 0);
        if (temp < 1)
        {   temp = 1;
        }
        switch (costume)
        {
        case COSTUME_PRISONER:
        case COSTUME_VILLAGER:
            if (!madeit(temp, chr))
            {   return FALSE;
            }
        acase COSTUME_SERVANT:
        case COSTUME_GUARD:
        case COSTUME_OFFICER:
            if (!madeit(temp, iq))
            {   return FALSE;
    }   }   }

    for (i = 0; i < ITEMS; i++)
    {   if
        (   items[i].owned >= 1
         && (   items[i].type == WEAPON_SWORD
             || items[i].type == WEAPON_POLE
             || items[i].type == WEAPON_HAFTED
             || items[i].type == WEAPON_SPEAR
             || items[i].type == WEAPON_STAFF
        )   )
        {   none = FALSE;
            getsavingthrow(TRUE);
            switch (costume)
            {
            case COSTUME_PRISONER:
                temp = 6;
            acase COSTUME_SERVANT:
                temp = 4;
            acase COSTUME_VILLAGER:
                temp = 4;
            acase COSTUME_GUARD:
                temp = 1;
            acase COSTUME_OFFICER:
                temp = 0;
            }
            temp += difficulty + ((race != HUMAN) ? 1 : 0);
            if (temp < 1)
            {   temp = 1;
            }
            switch (costume)
            {
            case COSTUME_PRISONER:
            case COSTUME_SERVANT:
            case COSTUME_VILLAGER:
                if (!madeit(temp, iq))
                {   return FALSE;
                }
            acase COSTUME_GUARD:
            case COSTUME_OFFICER:
                if (!madeit(temp, lk))
                {   return FALSE;
            }   }
            break;
    }   }

    if
    (   items[TOR].owned
     || items[ITEM_BS_UWTORCH].owned
     || items[LAN].owned
    )
    {   none = FALSE;
        getsavingthrow(TRUE);
        switch (costume)
        {
        case COSTUME_PRISONER:
            temp = 6;
        acase COSTUME_SERVANT:
        case COSTUME_VILLAGER:
        case COSTUME_GUARD:
            temp = 1;
        acase COSTUME_OFFICER:
            temp = 0;
        }
        temp += difficulty + ((race != HUMAN) ? 1 : 0);
        if (temp < 1)
        {   temp = 1;
        }
        switch (costume)
        {
        case COSTUME_PRISONER:
        case COSTUME_VILLAGER:
            if (!madeit(temp, chr))
            {   return FALSE;
            }
        acase COSTUME_SERVANT:
        case COSTUME_GUARD:
        case COSTUME_OFFICER:
            if (!madeit(temp, lk))
            {   return FALSE;
    }   }   }

    if (none && costume != COSTUME_GUARD && costume != COSTUME_OFFICER)
    {   getsavingthrow(TRUE);
        switch (costume)
        {
        case COSTUME_PRISONER:
            temp = 6;
        acase COSTUME_SERVANT:
        case COSTUME_VILLAGER:
            temp = 1;
        }
        temp += difficulty + ((race != HUMAN) ? 1 : 0);
        if (temp < 1)
        {   temp = 1;
        }
        switch (costume)
        {
        case COSTUME_PRISONER:
            if (!madeit(temp, chr))
            {   return FALSE;
            }
        acase COSTUME_SERVANT:
        case COSTUME_VILLAGER:
            if (!madeit(temp, lk))
            {   return FALSE;
    }   }   }

    return TRUE;
}

MODULE void cd_wandering(void)
{   int  result;
    FLAG attacking,
         normal;

    aprintf(
"WANDERING PERSONS TABLE\n" \
"  Roll two dice to determine the Wandering Person (WP) you've found. If you roll a named person you've already encountered - either from the table or as part of the adventure proper - then you encounter no one now. Any named persons might still be found within the actual adventure, though.\n" \
"  Deal with the WP and return from whence you came.\n" \
"  [Should you reduce any WP's CON to 5 or less, they will drop out of the fight if it's a melee or yield if it's a tete a tete. You can accept a surrender if no other enemies are fighting. If you do so, increase your CHR for the adventure by 2 per opponent and take 100 additional ap.]\n"
    );

    result = dice(2);
    if (wp[result - 2] == 2 || (result != 4 && wp[result - 2] == 1)) // already met or killed
    {   return;
    }
    wp[result - 2] = 1;
    aprintf("%s\n", cd_wandertext[result - 2]);

    switch (result)
    {
    case 2:
        attacking = FALSE;
        if (glibtonguetable(3))
        {   if (!getyn("Ignore (otherwise fight)"))
            {   attacking = TRUE;
        }   }
        else
        {   if (!getyn("Surrender (otherwise fight)"))
            {   attacking = TRUE;
            } else
            {   lose_chr(3);
                room = 105;
        }   }

        if (attacking)
        {   create_monster(86);
            npc_templose_st(0, 6 * 4);
            good_takehits(120, TRUE); // strictly speaking this is his attack, against which you should get your own combat total
            fight();
            wp[0] = 2;
        }
    acase 3:
        if (!saved(3, spd) || !saved(3, iq) || getyn("Attack (otherwise flee)"))
        {   create_monster(87);
            theround = 0;
            do
            {   if (saved(iq, 3))
                {   npc_templose_hp(0, iq * level);
                } else
                {   owe_iq(misseditby(iq, 3));
                    healable_iq -= madeitby(iq, 3);
                    oneround();
            }   }
            while (countfoes() && npc[0].mr >= 20);
            award(200);
            if (countfoes())
            {   dispose_npcs();
            } else
            {   wp[1] = 2;
        }   }
    acase 4:
        if (getyn("Attack (otherwise ignore)"))
        {   create_monster(88);
            npc_templose_st(0, 6 * 3);
            good_takehits(90, TRUE); // strictly speaking this is his attack, against which you should get your own combat total
            fight();
            wp[2] = 2;
        }
    acase 5:
        if (!glibtonguetable(1))
        {   create_monster(89);
            theround = 0;
            do
            {   normal = TRUE;
                if (saved(3, iq))
                {   npc_lose_iq(0, dice(1));
                    normal = FALSE;
                }
                getsavingthrow(FALSE);
                if (madeit(level, npc[0].iq))
                {   result = dice(1);
                    owe_iq(result);
                    healable_iq += result;
                    normal = FALSE;
                }
                if (normal)
                {   oneround();
            }   }
            while (countfoes());
        }
    acase 6:
        if (!classactiontable(cd_inside[room] ? COSTUME_SERVANT : COSTUME_VILLAGER) || getyn("Attack"))
        {   if (!cd_inside[room])
            {   create_monster(90);
                fight();
                if (costume != COSTUME_VILLAGER && getyn("Wear villager costume"))
                {   costume = COSTUME_VILLAGER;
            }   }
            else
            {   create_monster(91);
                fight();
                if (dice(1) <= 4) // %%: it doesn't say how long it takes to strip them. We are assuming it is instant.
                {   give_gp(dice(4));
                }
                if (costume != COSTUME_SERVANT && getyn("Wear servant costume"))
                {   costume = COSTUME_SERVANT;
        }   }   }
    acase 7: // T'ah guard
        // %%: it doesn't say whether they automatically attack or whether eg. Glib Tongue Table check is required. We assume they attack.
        create_monster(92);
        fight();
        cd_killedguards(1);
    acase 8: // yeowoman
        if (!classactiontable(COSTUME_VILLAGER) || getyn("Attack (otherwise ignore)"))
        {   create_monster(93);
            fight();
            give(JAV);
            give(GLA);
            give(DRK);
            give(BUC);
        }
    acase 9: // T'ah officer
        if (!glibtonguetable(0) || getyn("Attack (otherwise ignore)"))
        {   create_monster(94);
            guards = 0;
            theround = 0;
            oneround();
            while (countfoes())
            {   if (dice(1) <= 2)
                {   guards++;
                    create_monster(92);
                }
                if (countfoes() >= 2)
                {   if (getyn("Surrender (otherwise fight)"))
                    {   dispose_npcs();
                        room = 105;
                    } else
                    {   oneround();
            }   }   }
            give(334);
            if (costume != COSTUME_OFFICER && getyn("Wear officer costume"))
            {   costume = COSTUME_OFFICER;
            }
            if (ability[23].known && getyn("Get rid of manacles"))
            {   elapse(dice(1) * 10, TRUE);
                lose_flag_ability(23);
            } // %%: we assume that officers carry manacle keys
            cd_killedguards(guards);
        }
    acase 10:
        if
        (   ((costume == COSTUME_GUARD || costume == COSTUME_OFFICER) && !saved(6, chr))
         || getyn("Attack (otherwise ignore)")
        )
        {   create_monster(95); // %%: it doesn't mention his weapons/armour, so we assume he has none
            theround = 0;
            oneround();
            oneround();
            while (countfoes())
            {   if (!cd_inside[room] && dice(1) <= 2)
                {   create_monster(93);
                }
                oneround();
            }
            wp[8] = 2;
        }
    acase 11:
        // %%: it doesn't say whether he automatically attacks. We assume he does.
        create_monster(96);
        fight();
        give(334);
        wp[9] = 2;
    acase 12:
        if (!classactiontable(COSTUME_VILLAGER))
        {   create_monster(97);
            fight();
            give(DRK);
            give(LSB);
            wp[10] = 2;
}   }   }

EXPORT void cd_viewman(void)
{   aprintf("³Costume: ²");
    switch (costume)
    {
    case COSTUME_PRISONER:
        aprintf("Prisoner");
    acase COSTUME_SERVANT:
        aprintf("Servant");
    acase COSTUME_VILLAGER:
        aprintf("Villager");
    acase COSTUME_GUARD:
        aprintf("Guard");
    acase COSTUME_OFFICER:
        aprintf("Officer");
    }
    aprintf("\n³Alarum:  ²");
    if (alarum == -1)
    {   aprintf("Not raised\n");
    } elif (alarum == 0)
    {   aprintf("Raised\n");
    } else
    {   aprintf("Raised in %d turns\n", alarum);
}   }

MODULE void cd_killedguards(int amount)
{   int i;

    for (i = 1; i <= amount; i++)
    {   give(DRK);
        if (dice(1) <= 3)
        {   give(LSB);
    }   }

    if (costume != COSTUME_GUARD && getyn("Wear guard costume"))
    {   costume = COSTUME_GUARD;
    }
    if (ability[23].known && getyn("Get rid of manacles"))
    {   elapse(dice(1) * 10, TRUE);
        lose_flag_ability(23);
}   }

EXPORT void cd_magicmatrix(void)
{   switch (spellchosen)
    {
    case SPELL_RE:
        if (room == 126)
        {   room = 152;
        } else
        {   noeffect();
        }
    acase SPELL_DW:
        if (room == 9 || room == 128)
        {   maybeeffect(5);
        } elif (room == 25)
        {   maybeeffect(4);
        } elif (room == 48)
        {   rebound(FALSE);
        } elif (room == 97 || room == 195)
        {   fulleffect();
        } elif (room == 108)
        {   powereffect(50);
        } elif (room == 115)
        {   powereffect(100);
        } elif (room == 171)
        {   if (st + iq + chr > 14 + 6 + 5)
            {   room = prevroom;
            } else
            {   noeffect();
        }   }
        elif (room == 185)
        {   room = 53;
        } elif (room == 195)
        {   room = 147;
        } elif (room == 197)
        {   room = 88;
        } else
        {   noeffect();
            // %%: CD173: it is supposed to take effect, but we there are no
            // enemies for it to affect, and no paragraph for us to go to.
        }
    acase SPELL_CC:
        if (room == 25)
        {   room = 22;
        } elif (room == 48)
        {   room = 196;
        } elif (room == 97)
        {   room = 136;
        } elif (room == 115)
        {   room = 36;
        } elif (room == 128)
        {   room = 76;
        } elif (room == 171)
        {   room = prevroom;
        } elif (room == 173)
        {   room = 18;
        } elif (room == 182)
        {   room = 104;
        } elif (room == 185)
        {   fulleffect();
        } elif (room == 197)
        {   room = 102;
        } else
        {   noeffect();
        }
    acase SPELL_WI:
    case SPELL_BG:
        if
        (   room == 25
         || room == 48
         || room == 197
        )
        {   room = 52;
        } elif (room == 97)
        {   room = 59;
        } elif (room == 115)
        {   room = 40;
        } elif (room == 128)
        {   room = 73;
        } elif (room == 171)
        {   room = 96;
        } elif (room == 182)
        {   room = 188;
        } elif (room == 185)
        {   room = 139;
        } else
        {   noeffect();
        }
    acase SPELL_KK:
        if (room == 126)
        {   room = 50;
        } elif (room == 173)
        {   room = 15;
        } else
        {   noeffect();
        }
    acase SPELL_PA:
        if (room == 9)
        {   maybeeffect(5);
        } elif (room == 25)
        {   powereffect(100);
        } elif (room == 48)
        {   rebound(FALSE);
        } elif (room == 108)
        {   powereffect(50);
        } elif (room == 115)
        {   leveleffect(4);
        } elif
        (   room == 128
         || room == 182
         || room == 185
        )
        {   fulleffect();
        } elif (room == 195)
        {   room = 174;
        } else
        {   noeffect();
        }
    acase SPELL_IF:
        if
        (   room == 12
         || room == 97
         || room == 115
         || room == 185
         || room == 195
        )
        {   fulleffect();
        } elif (room == 25)
        {   maybeeffect(4);
        } elif (room == 48)
        {   room = 55;
        } elif (room == 108)
        {   powereffect(60);
        } elif (room == 128)
        {   maybeeffect(5);
        } elif (room == 182)
        {   doubleeffect();
        } elif (room == 197)
        {   room = 81;
        } else
        {   noeffect();
        }
    acase SPELL_BP:
        if
        (   room == 9
         || room == 12
         || room == 97
         || room == 115
        )
        {   fulleffect();
        } elif (room == 25 || room == 197)
        {   room = 66;
        } elif (room == 48)
        {   room = 156;
        } elif (room == 108)
        {   powereffect(60);
        } elif (room == 128)
        {   maybeeffect(5);
        } elif (room == 173)
        {   room = 176;
        } elif (room == 182)
        {   doubleeffect();
        } elif (room == 185 || room == 195)
        {   room = 165;
        } else
        {   noeffect();
        }
    acase SPELL_TF:
        if
        (   room == 9
         || room == 12
         || room == 25
         || room == 48
         || room == 97
         || room == 128
         || room == 182
         || room == 185
         || room == 195
        )
        {   fulleffect();
        } elif (room == 108)
        {   powereffect(50);
        } elif (room == 115)
        {   leveleffect(4);
        } elif (room == 173)
        {   rebound(FALSE);
        } elif (room == 197)
        {   room = 66;
        } else
        {   noeffect();
        }
    acase SPELL_VB:
    case SPELL_EH:
    case SPELL_DD:
    case SPELL_ZA:
    case SPELL_ZP:
    case SPELL_DE:
        if
        (   room == 9
         || room == 12
         || room == 25
         || room == 97
         || room == 128
         || room == 182
         || room == 185
         || room == 195
        )
        {   fulleffect();
        } elif (room == 115)
        {   leveleffect(4);
        } elif (room == 197)
        {   room = 111;
        } else
        {   noeffect();
        }
    adefault:
        noeffect();
}   }
