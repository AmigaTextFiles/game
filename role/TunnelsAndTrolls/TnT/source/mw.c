#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

#define TABLEA 0
#define TABLEB 1

/* Ambiguities/contradictions (%%):
 MW4 conflicts with MW23 re. powers of sword.
 MW10 and MW137 have conflicting statistics for red knight.
Errata:
 MWp125 (Corgi edition only): Random Encounter Table A: "151" should be "15".
 MW66/11B: "one of the two" should be "one of the three".
 MWp127 is (erroneously) a duplicate of GKp78 (and applies only to GK)!
*/

MODULE const STRPTR mw_desc[MW_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  No magic can be used in Mistywood.\n" \
"  Occasionally you may be told to go the Random Encounter Tables (either A or B). These tables are on pages 125-126 of this book. After you have survived your Random Encounter, return to the paragraph which sent you there.\n" \
"  To begin your adventure within Mistywood, read the Introduction below.\n" \
"~INTRODUCTION\n" \
"  As you sip the thin, bitter ale of the Bumley village inn, you remember the fight in the brothel in Kasar where you spilled the guts of the drunken nobleman who insulted and attacked you. A clear-cut case of self defence, and him with his rapier against your poniard! But little does that matter now. How were you to know that this perfumed young rake with the impudent mouth was the only son and heir of Grand Duke Karl Bronzo, the Tyrant of Kasar? You were lucky to escape with your skin intact as the furious noble's servitors turned the city upside down in their efforts to capture you. Fleeing from the heavy fist of royal vengeance, you rode east until fatigue compelled you to stop here in Bumley, on the border of the legend-haunted Mistywood.\n" \
"  Nothing but weariness would have made you stop here either, in this run-down and ramshackle excuse for a town. Half the shops and houses were empty, boarded-up shells; the other half looked on the verge of following them soon.\n" \
"  At least the inn was still open, but at the moment you are trying to decide whether it was the greasy stew they served you in lieu of supper, or the awful howling outside at midnight that woke you, sweat-drenched, out of a nightmare in which a hideous, dog-faced demon pursued you through some black and evil forest whose leafless branches clawed and groped and gashed at you.\n" \
"  As the fat innkeeper brings your breakfast of toast and sausages, he asks if you slept well. If you want to gripe about the dog waking you up, go to {68}. If not, you eat your meal in silence, gather your gear, and go to {27}."
},
{ // 1/1A
"This road seems to be in slightly better shape than the ones you have been on so far. You are making better progress. Roll 2 dice. If you roll 7-12, go to {72}. If you roll 2-6, you have had another random encounter; go to Random Encounter Table A and do what it says there. If you survive, return here and roll again."
},
{ // 2/1B
"Make a L2-SR on Luck (25 - LK). If you make it, you outrun your pursuers and reach the Mistywood. You are surprised to note that you are not followed. Go to {128}.\n" \
"  If you miss the roll, go to {88}."
},
{ // 3/1C
"Whether you are on foot or on horseback, it is a long arduous trip around the lake. Roll 2 dice. If you roll 9-12, go to {55}. If you roll 2-8, go to Random Encounter Table B and follow the instructions there. If you survive, return here and roll again."
},
{ // 4/1D
"Voronir was a mighty man of war, and his sword is swift and terrible. It gets 10 dice all by itself. [In addition, against most magical opponents (such as the three knights, the Barghest, and any apparitions such as ghosts and Banshees) it acts as if a Vorpal Blade is cast upon it every combat turn, scoring double damage! ]So add your adds to it and lay on these baddies; if you can't beat them with this weapon, you sure roll awful dice! Check paragraph {10} for their stats before you fight. If you beat them, they crumble to dust. Go to {23}."
},
{ // 5/1E
"As you dig frantically towards the surface, you weaken the rocks above you. The ceiling collapses, burying you alive. You'll never be able to get out. Close the book."
},
{ // 6/1F
"Make a L3-SR on Luck (30 - LK). If you make it, go to {133}. If you miss the roll, the Ogre in the clearing has spotted you slinking through the shadows. With a thunderous roar, the brute charges! Go to {108}."
},
{ // 7/1G
"Make a L3-SR on IQ (30 - IQ). If you make it, you saw the trigger and avoided the trap. If not, a spear is launched at you! If you are on horseback, roll a die: 1-4, the spear hits the horse and kills it; 5-6, the spear hits you, causing 3d6 points of damage. Fortunately, you can take some or all of the damage on your armour. If you were travelling on foot, roll a die: 1-3, the spear missed; 4-6 and you were hit as above. The trap was set by the muckmen. If you survive, proceed normally."
},
{ // 8/1H
"As you ride along, your horse suddenly plunges into a soupy muck up to its belly. Make a L2-SR on Dexterity (25 - DEX) to dismount by leaping back to more solid ground, and then make a L3-SR on Luck (30 - LK) to see if the ground really is solid!\n" \
"  If you miss either roll, or were travelling on foot, you find yourself up to mid-thigh in quicksand. Now make a L4-SR on Luck (35 - LK) to see if you were able to squirm back to solid ground. If you missed that roll, you are in up to your hips. You must now make a L5-SR on Luck (40 - LK) to escape. Miss this one and you are up to your navel. Now you need to make a L6-SR on Luck (45 - LK), or you have sunk in up to your armpits. (Your horse, if you had one, gives a last despairing scream of terror as its muzzle disappears beneath the roiling sands near you.) Make a L7-SR on LK (50 - LK), or sink up to your neck. Last chance, my friend. Make a L8-SR on Luck (55 - LK), or the evil-smelling, slimy bog sucks you under, and the marsh claims yet another victim. Close the book.\n" \
"  If you manage to extricate yourself, continue your adventure - and watch your step from now on!"
},
{ // 9/1K
"To escape the trio, you must make a L4-SR on Luck (35 - LK) and another on Dexterity (35 - DEX). If you miss either or both rolls, go to {57}. If you make both rolls, you have escaped - but the medallion has disappeared. If you want to go back and look for it, go to {102}. If you just want to get out of these miserable woods, go to {78}."
},
{ // 10/2A
"The three attack you at once. Their combined stats are as follows:\n" \
"    Red knight      CON: 20    Dice+Adds: 5+15    Armour: 10(x2)\n" \
"    Elf knight      CON: 22    Dice+Adds: 6+18    Armour: 10(x2)\n" \
"    Black knight    CON: 25    Dice+Adds: 8+21    Armour: 10(x2)\n" \
"[Unless you are *wearing* the medallion, the elf knight's sword will distract you (you will get no personal adds for DEX), and the black knight will be able to throw his magical mace at you three times. This mace never misses, and always does at least one die of damage to its opponent's CON regardless of armour or other protection. The medallion will neutralize the magical properties of both weapons only if you wear it (it won't work if it's in your pocket or pack).\n" \
"  ]If you defeat these three, they and their equipment will age and crumble into dust within minutes. Take 1000 ap and go to {50}."
},
{ // 11/2B
"You curse yourself for a fool as you recognize Duke Bronzo's hired wizard, Gorghasty, and four Bronzo men-at-arms who are drawing their weapons and whooping their war cries. If you decide to beg for mercy, go to {22}. If you fight, go to {117}. If you try to make a break east, hoping to lose them in the woods, go to {29}."
},
{ // 12/2C
#ifdef CORGI
"You run and run through the black woods, which have now become hostile and now seem to recall a nightmare you once had. Leafless branches grasp and grope at you. Your breath comes in agonizing gasps; your legs feel like lead.\n" \
"  It is midnight; behind you, a hideous baying breaks out. Unable to run anymore, you turn to see a gigantic black hound with blazing red eyes and slavering razor-fanged jaws rushing towards you. Instinct tells you that flight is useless against this terror from the pit; you might fight, or die.\n" \
"  Here at the height of his power, the Barghest has a MR of 200 (21 dice + 100 adds). [His saliva is the equivalent of dragon venom (quadruples damage). ]His infernal skin is like plate armour, and will absorb 14 hits per combat turn.\n" \
"  If you defeat this demon-dog, take 1200 adventure points. You will safely escape these woods, and can go on to other adventures. You are a tough adventurer: one that people will hesitate to cross swords with."
#else
"You run and run through the black woods, which have now become hostile and now seem to recall a nightmare you once had. Leafless branches grasp and grope at you. Your breath comes in agonizing gasps; your legs feel like lead.\n" \
"  It is midnight; behind you, a hideous baying breaks out. Unable to run anymore, you turn to see a gigantic black hound with blazing red eyes and slavering razor-fanged jaws rushing towards you. Instinct tells you that flight is useless against this terror from the pit; you might fight, or die.\n" \
"  Here at the height of his power, the Barghest has a MR of 200 (21 dice + 100 adds). [His saliva is the equivalent of dragon venom (quadruples damage). ]His infernal skin is like plate armour, and will absorb 14 hits per combat turn.\n" \
"  If you defeat this demon-dog, take 1200 adventure points. You will safely escape these woods, and can go on to other adventures. You are a tough hombre - I hope I never have to fight you!"
#endif
},
{ // 13/2D
"Roll one die and add one to the result. This is the number of goblins who leap out of the underbrush and surround you. You must fight. Each goblin has a MR of 20 (3 dice + 10 adds), carries 2-12 gold pieces, and is worth 45 adventure points. If you are riding a horse, roll 1d6 at the beginning of each combat rounds. If you roll 1 or 2, the nasty creatures have hamstrung your mount."
},
{ // 14/3A
"The bottle contains a potion that will heal 1-6 points of damage per swig. It contains 5 swigs. [If you take more than two swigs at a time, you must make a Level/swig saving roll on your CON or get drunk due to the high alcoholic content of the potion. This will cost you 1-6 points (temporarily) from both IQ and DEX, but will add 1-6 points to your ST. You will recover IQ and DEX at 1 point every 2 paragraphs/turns. ]Go to {78}."
},
{ // 15/3B
"As you ride through the woods, a huge brown bear charges roaring out of the underbrush straight at you. [If you roll 1-3 on 1d6, your horse panics and you must make a L4-SR on Dexterity (35 - DEX) or lose your personal adds for the first combat round. On each subsequent round, if your roll 4-6 on 1d6, the bear strikes your horse and breaks its neck. You will take no damage in the round if this occurs. ]The bear has a MR on 100 (11 dice + 50 adds); if you kill him, take 100 experience points.[ If the bear does no damage to you because it loses every round, it will not kill your horse.]\n" \
"  If you are on foot, simply fight the bear as you would any other monster. If you survive, proceed normally."
},
{ // 16/3C
"As you continue down the road, you notice an eerie phenomenon. Fog begins to creep up from the marsh around you, flowing over the road. Your horse whinnies anxiously. As the dense white clouds close in around you, you hear the distant baying of a large hound. For a moment you cannot see anything in the mist - but then, as quickly as it appeared, the fog suddenly clears away.\n" \
"  You look about at your surroundings and curse all evil enchantments - you are no longer on the road but in the middle of the marsh! Far to the northeast you can see the tops of trees above the fog bank. If you decide to head that way, rather than getting lost in the swamp, go to {104}. If you want to ride south, away from the ominous-looking wood, go to {69}."
},
{ // 17/3D
"The water of this deep lake is unnaturally cold. You must make a L3-SR on Luck (30 - LK), and another on CON (30 - CON). If you miss either or both rolls, the bitter waters numb you and drag you down to a watery grave. If both rolls are successful, go to {55}, as you somehow managed to swim ashore."
},
{ // 18/3E
"Your efforts to communicate have given your three foes pause. Make a L4-SR on your Charisma (35 - CHR). If you make it, go to {46}. If you fail the roll, go to {10}."
},
{ // 19/4A
"If you are on horseback, your mount rears suddenly and falls in the soft muck. A giant anaconda-like serpent has attacked you! You leap up fighting as your horse flees. (If you were travelling on foot, ignore the comments about the horse...)\n" \
"  The huge snake has a MR of 160[; roll one die each turn that he hits you]. [If you roll 4-6, the snake has snared you in its coils. Not only do you lose all DEX adds, but you suffer damage from constrictions (16 minus your armour's capacity to absorb damage at face value only). Thus, if you are wearing leather armour, on each combat round after the snake entwined you in its coils you would suffer 16 minus 7, or 9, points of damage to your CON until you (or the snake) died. ]If you survive the encounter, take 240 ap and continue your journey."
},
{ // 20/4B
"Though it is not yet midnight, the Barghest is still a terrible creature. He has a MR of 150 (16 dice + 75 adds). His [saliva is the equivalent of hellfire juice (damage × 1.5); his ]infernally tough hide will absorb 7 points of damage per round. If you slay the monster, collect 900 ap and go on about your business. As long as you stay out of Kasar, you should not have any problems. Close the book."
},
{ // 21/4C
"You ride along, placidly humming to yourself. Suddenly a giant hunting spider (MR 60) leaps upon you from the branches overhead. Unless you make a L3-SR on your Dexterity (30 - DEX), you are rudely unhorsed[ and must fight without your personal adds in the first combat round]. Your horse expresses his aversion to oversized arachnids by making tracks for somewhere far away. You must remain and dispute with the spider your right to continued life and pursuit of happiness. [If she gets any hits on you, remember to take into account the effects of her venom. ]If you kill the spider, take 150 ap and continue your adventure.\n" \
"  If you were on foot when the spider attacked, simply conduct normal combat."
},
{ // 22/4D
"You are swiftly disarmed, bound hand and foot, and borne roughly back to the palace in Kasar for the most painful judgement of Grand Duke Bronzo. Let us close here to spare the squeamish reader..."
},
{ // 23/4E
"The sword speaks to you. \"Friend, you have rendered me and my beloved great service today. You have given me revenge on my hated enemies. Therefore, I grant you a boon. Take my sword. It will serve you against the Barghest as it served you against my enemies. Farewell.\"\n" \
"  [Against unenchanted opponents, the sword is merely a normal broadsword. In any event, it will vanish without a trace after the next combat in which you use it.\n" \
"  ]The bright spirits of Auria and Voronir appear, embrace, and fade away. Go to {78}."
},
{ // 24/4F
"To open the sarcophagus, you must make a L5-SR on Strength (40 - ST). If you make it, go to {136}. If you miss it, too bad. If you leave, go to {1} - unless you want to stick around and look over the tomb walls, in which case you go to {82}."
},
{ // 25/4G
"Just as your aching lungs are ready to burst from lack of oxygen, you break through the surface. After you have rested for a while, sucking in great breaths of the cool forest air, you continue your journey. Be a little more careful from now on! Go to {1}."
},
{ // 26/4H
"As you leave the cave, you feel a stabbing pain in your hip. Angered by your refusal to wear it, the ring turned into a serpent and bit you! Make a saving roll on Luck at your level, or die! If you live, go to {109}."
},
{ // 27/4K
"You quickly mount your horse and ride east. Just outside Bumley, you come to a fork in the road. If you continue on into the Mistywood, go to {128}. If you want to ride north, across the moor, go to {90}. If you want to ride south through the marshes, go to {54}."
},
{ // 28/5A
"You descend the stairs which are thick with the dust of ages, and come at last to a door which bears cryptic runes carved in the dark wood. The runes form a barrier of some sort - but you cannot tell if they were meant to keep things out, or to keep things in. Make a L2-SR on Luck (25 - LK). If you miss the roll, the now-insistent wailing inside compels you to run to {1}. If you make the saving roll, you can go to {58}, or you can flee from this gloomy place and continue your journey (go to {1})."
},
{ // 29/5B
"Make a L3-SR on Luck (30 - LK) to see if you beat them to the woods. If you make it, go to {111}. If you don't make it, go to {117}."
},
{ // 30/5C
"As you ride along on horseback, make a L3-SR on Luck (30 - LK). If you miss the roll, you failed to see and avoid the pit trap in the path. Now roll 1d6; if you rolled 1-4, the horse landed on the bottom and was killed by the spikes. You suffered only 1d6 ÷ 2 (1-3) points of damage to your CON. If you rolled a 5, you fell off (take 1-6 points of damage). If you rolled a 6, the horse landed on top of you (roll 4 dice and take that in damage from your CON); you must now make a L6-SR on your Strength (45 - ST) to get out from under the animal, who was killed in the fall. If you miss that saving roll, you die from internal injuries.\n" \
"  If you were on foot, you must make a L2-SR on Intelligence (25 - IQ) to see and avoid the trap. If you miss the roll, you fall in and take 1-6 points of damage to your CON.\n" \
"  You must make a L4-SR on Dexterity (35 - DEX) to climb out of the pit. Each time you miss the roll, you suffer another 1-3 points of damage from falling back into the spike-filled pit. If you climb out of the pit and survive, proceed normally. If you can't climb out, you'll eventually die from thirst and your wounds..."
},
{ // 31/5D
"Roll a die. If you roll 1-4, go to {49}. If you roll 5-6, go to {73}."
},
{ // 32/5E
"The elf knight's Rainbow Sword gets 6 dice. [In combat, it shimmers in such a way that it will rob its target of his personal adds for DEX unless he wears the gold medallion from the oak around his neck. ]The elf has a CON of 22 and he has 18 adds; his silvery armour takes 10 (x2) hits per round. If you beat him, take 250 ap and go to {66}."
},
{ // 33/5F
"The skinny pirate fights which his dagger (2 dice + 5 adds) and has a CON of 30. If you score any hits at all against this brave hero, he will leap into the water and swim away as fast as he can. You won't have to worry about him again. Pick up his oars and cross the rest of the lake without further incident; go to {55}. He was worth 30 ap."
},
{ // 34/6A
"A sarcophagus with a heavy stone lid stands in the centre of the room. If you want to look inside, go to {24}. If you just want to get out of here and continue your journey, go to {1}. If you want to examine the walls of the tomb, go to {82}."
},
{ // 35/6B
"You have accidentally triggered another trap. Go to {113}."
},
{ // 36/6C
"He sips his beer, thanks you, and continues his eerie tale. That very night, he says, the same howl was heard in the streets of Bumley. On the following morning, the body of the man whose testimony had condemned the crone to death was found in the street. His eyes were wide with terror, and his throat had been torn out. To compound the horror, the grave of the old woman had been dug up. Her charred bones were gone; all about the site, in the soft dirt, were the paw prints of an enormous hound.\n" \
"  Thus it was that the peaceful and prosperous village became a place of fear and woe. At night, when the fog from the wood flowed into the narrow streets, a shapeless terror accompanied it to stalk its prey. Before long, those who could afford to leave had packed up and departed for other, safer towns. The remaining villagers huddled in their homes by night, doors locked and windows shuttered tight against the nightmare that howled in the streets outside and stalked new victims to slake its dreadful thirst.\n" \
"  With a start you realize that time is flying. You have been here too long already. Hurriedly, you gather your gear and leave. Go to {139}."
},
{ // 37/6D
"Instinct tells you that you made the best decision. The Barghest does not reach full strength until midnight. But even now he is nothing to take lightly. His shadowy form solidifies before you into a gigantic coal-black hound with slavering green jaws and eyes that glow like coals of fire. He springs forward with a terrifying howl. To attack him, go to {20}."
},
{ // 38/6E
"The cave entrance opens into a large chamber with a dirt floor. The woman is standing across from you on the other side.\n" \
"  \"You want me?\" she purrs seductively. \"Ah, but first you must defeat my lovers!\" She strikes a small gong.\n" \
"  As the loud summons dies away, you are horrified to see six rotting corpses claw their way up out of the dirt floor. You are surrounded and must fight. Each corpse has a MR of 25 (3 dice + 13 adds). If you are fighting with a cutting or thrusting type of weapon, go to {48}. If you use a blunt, crushing-type weapon, go to {97}."
},
{ // 39/6F
"You carefully advance, and soon espy a small clearing. In the centre of the clearing stands a stately old oak tree, surrounded by a faerie ring of white flowers. Embedded in the tree trunk is a sword; a gold medallion on a silver chain dangles from the hilt. If you think you have done enough sightseeing for today, and want to get out of here, go to {78}. If you want to take a closer look at the sword and medallion, go to {134}."
},
{ // 40/7A
"Smart fellow! By attacking the source of his strength, his \"gate\" to this world, you compelled him to materialize in his weakest form. However, he still gets a MR of 100 (11 dice + 50 adds). Fortunately for you, though, he does not get other special powers that he would have gained had you waited until later to fight him.\n" \
"  If you kill him, collect 600 ap and go on your way. You have rid Mistywood and Bumley of the curse of the Barghest. Now, if you can just stay out of the way of Duke Bronzo's bully boys..."
},
{ // 41/7B
"This was about as bad a choice as you could have made. Colour yourself trapped! You are abruptly caught and surrounded by a group of four servitors coming up from the south, and the group of five pursuing you from the north. If you want to throw yourself upon their mercy, go to {22}. Otherwise, you must fight. See paragraphs {117} and {88} for stats on your opponents. If you survive (!), follow the directions at the end of paragraph {117}."
},
{ // 42/7C
"Here in the clearing, the road splits. If you want to take the north branch, go to {133}. If you want to go south instead, go to {1}."
},
{ // 43/7D
"Your hair turned white as snow, your mind destroyed, you rush madly from the dismal lair of the Banshee, yelling, laughing, and gibbering senselessly. You must wander through the woods, rolling a Random Encounter each turn on Table A until you meet the Holy Man of the woods; only his touch can heal you.\n" \
"  If this fortunate event should occur before you are killed (and it probably won't happen afterwards), go to {133} and carry on. If you have slain the Holy Man, you become part and parcel of the legends of the woods: the white-haired madman of the woods.[ This character replaces the Holy Man in Encounter Table A, and will attack any person it meets.]"
},
{ // 44/7E
"Rats! You defeated the lake monster, but forgot his whistling buddy in the boat. He has just stabbed you from behind with his dagger. Take 2 dice + 5 adds worth of hits from your CON (armour will protect you at face value only). If you are still alive, you can turn around and try to avenge this cowardly blow by going to {33}. Or you can jump overboard and swim for it by going to {17}."
},
{ // 45/7F
"The panel opens, revealing a 1'x1' hole that is about 3' deep. At the far end of the hole appears to be a box with a handle. If you reach in and try to pull it out, go to {143}. If you probe inside the hole with something, write down what you use and go to {74}. If you would rather leave, go to {1}."
},
{ // 46/7G
"The elf knight speaks. \"We see you are no common thief. Therefore we will give you a chance. Give us the medallion and the sword, and defeat one of us in single, honourable combat. If you live, we will allow you to leave. Refuse, and you must fight the three of us, all at once!\"\n" \
"  If you want to give up the sword and the medallion, and fight one of the knights, make a decision. To fight the red knight, go to {137}. To fight the elf knight, go to {32}. To fight the black knight, go to {96}. If you attack all three knights at once, go to {10}. If you want to run for it, go to {57}."
},
{ // 47/8A
"Suddenly, directly in your path, you see an aged man with dark piercing eyes. He has a long white beard and wears a robe of sackcloth. He carries a staff. If you want to attack him, go to {65}. If you want to talk to him, go to {89}."
},
{ // 48/8B
#ifdef CENSORED
"Bad choice. Undead have no vital organs to slash or pierce, and hewed-off limbs and heads will continue to claw and bite. [These putrescent horrors therefore take only half damage from weapons which cut or pierce. ]It is too late for you to switch now; you are already fighting for your life. If you win the struggle and survive, take 150 adventure points. Unfortunately, the woman has fled deeper into the cave. If you want to let her go unpunished and get out of this hole, beat it out the entrance and go to {109}. If you want to kick her around for playing such a dirty trick on you, go to {125}."
#else
"Bad choice. Undead have no vital organs to slash or pierce, and hewed-off limbs and heads will continue to claw and bite. [These putrescent horrors therefore take only half damage from weapons which cut or pierce. ]It is too late for you to switch now; you are already fighting for your life. If you win the struggle and survive, take 150 adventure points. Unfortunately, the woman has fled deeper into the cave. If you want to let her go unpunished and get out of this hole, beat it out the entrance and go to {109}. If you want to kick her around (or worse) for playing such a dirty trick on you, go to {125}."
#endif
},
{ // 49/8C
"You just stepped on a loose tile, triggering a deadfall trap - and the ceiling falls on your head! Make a L6-SR on Dexterity (45 - DEX). If you succeed, you jumped back in time. If you missed the roll, take the number of points you missed the roll by directly from your CON. If you survive, you have two options: you can flee by going to {1}, or you can stick around and investigate some more by going to {73}."
},
{ // 50/8D
"You turn - and to your surprise, the sword and medallion are gone! In their places stand two bright elf spirits, a man and a woman. Prince Voronir speaks.\n" \
"  \"Hero, you have slain our evil guardians, freeing us from our long curse. Beneath the branches of this great oak, you will find a reward worthy of your deed. Beware the Barghest, and farewell!\" The two spirits fade away.\n" \
"  A little excavation around the tree trunk reveals a box containing ten diamonds (each is worth 1000 gp) and a bottle filled with a salty-tasting liquid. If you want to take a swig from the bottle, go to {14}. If not, put it in your pack until you can have it Omni-eye'd, and go to {78}."
},
{ // 51/8E
"You bolt up the stairs and out of the tomb just in the nick of time, with the god-awful howl of the Groaning Spirit ringing in your agonized ears. Breathe a grateful prayer to your gods that these monsters shun daylight, and collect 100 ap. Go to {1}, for you now only want to put a lot of distance between you and the dreadful mound."
},
{ // 52/8F
"A huge wild boar charges out of the bushes. If you are mounted, he rips the belly out of your horse with his tusks. If you are on foot, you must fight the beast normally. It has a MR of 90. If you kill the boar and survive, take 145 ap and proceed on foot."
},
{ // 53/9A
"To your relief, the road seems to be getting a little wider and much less ominous. In fact, there actually appears to be a clearing up ahead. As you approach it, however, you hear a loud squealing noise. If you decide to cautiously investigate the noise, go to {67}. If you take to the woods and bypass the clearing, go to {6}."
},
{ // 54/9B
"As you ride south, you see four horsemen coming north along the road towards you. They carry the standard of the Bronzo family. If you want to stand and fight, go to {88}. If you turn and flee north, go to {2}. If you flee east into the marshes, go to {76}. If you want to brazen it out, and try to ride on past them, feigning innocence, go to {118}."
},
{ // 55/9C
"Here, on the other side of the lake, you are pleasantly surprised to find the road is wider and more peaceful. Nothing challenges your progress as you walk along. In fact, you realize that you have not seen any sign of insect or animal life since you crossed the lake. Suddenly the utter silence of these glades becomes ominous.\n" \
"  Ahead of you, to the east, you see a high round hill. On its summit, painted blood-red by the rays of the setting sun, stands a circle of ancient stone menhirs, jutting up into the darkening sky like a giant's broken teeth. If you want to climb the brooding hill and investigate this curious prehistoric temple, go to {63}. If you bypass it and hurry on down the road, go to {130}."
},
{ // 56/9D
"As you remove the medallion from the sword's hilt and place it around your neck, you are amazed to hear it begin to weep softly. If you ignore the sad lament, keep the medallion, and leave the little clearing, go to {106}. If you want to take a closer look at it, go to {138}."
},
{ // 57/10A
"Just as you make it to the edge of the woods, the black knight's hurled mace crashes into the back of your head. Stunned, you sprawl in the grass. You desperately try to turn and draw your weapon, but before you can ready it, the Rainbow Sword of the elf-knight stabs you like a hot poker in the throat. Darkness...silence...(close the book.)"
},
{ // 58/10B
"Make a L3-SR on your Intelligence (30 - IQ). If the roll is successful, go to {142}. If you miss it, go to {31}."
},
{ // 59/10C
"Your sharp eyes have noticed a secret panel. Make a L3-SR on Intelligence (30 - IQ) to figure out how to open it. If you miss the roll, you'll have to bash it open (go to {94} if you want to try this). If you made the saving roll and opened the panel, go to {45}. If you would just rather leave, go to {1}."
},
{ // 60/10D
"Make a L2-SR on Luck (25 - LK). If you miss the roll, go to {107}. If the roll is successful, you have completely surprised your opponents (see paragraph {107} for their statistics). This means that you have attacked them from behind. You will fight your first-round attack free of opposition[, and your foes cannot double their armour defence]. After that, fight normally.\n" \
"  If you survive, go to {27}."
},
{ // 61/10E
"Roll one die and add two to the result. This is the number of huge carnivorous frogs which attack. Each has a MR of 20. If you kill them, take 20 ap apiece."
},
{ // 62/10F
"As you rest for a moment in the clearing, you hear the sound of wailing in the distance, borne faintly to your ears by the wind. It is a very sad sound. If you want to ignore it and continue, go to {1}. If you want to investigate the dolorous noise, go to {131}."
},
{ // 63/10G
"In the midst of the menhirs is a rough stone altar that stands before an equally crude obsidian image of the devil-prince Zomakarx, the Lord of Enmity. On top of the altar is the skull of a huge hound with horns. The sensation of an evil presence here is overpowering. Something, potent and invisible, is watching you from the shadows.\n" \
"  If you want to throw down the altar and idol of Zomakarx, go to {87}. If you offer worship to the Lord of Enmity, go to {120}. If you flee down the hill, trying to escape from this dreadful place, go to {130}."
},
{ // 64/10H
"Poor devil! You have just come face to face with the ruler of the swamp: a huge green dragon. He's hungry and you're lunch. Close the book."
},
{ // 65/11A
"He offers no resistance as you kill him. You realize with horror that you have just slain the holy hermit of the wood. Anyone who harms one of these harmless ascetics is cursed; you will get only half of your adds in combat for the duration of this adventure. Proceed normally."
},
{ // 66/11B
"Having beaten one of the three, you might want to jump the other two. If you do, go to {10} and delete the missing foe. If you want to leave, go to {78}."
},
{ // 67/11C
"In the clearing ahead of you, a huge ogre is preparing to skin and dress the gnome he has captured for the cooking pot. Neither has seen you yet. If you want to attack the ogre and rescue his captive, go to {108}. Or, if you'd rather avoid a confrontation, take to the woods again and skirt the area by going to {6}."
},
{ // 68/11D
"When you mention the dog, the innkeeper blanches and crosses himself. \"Alas,\" he says. \"You heard the Barghest.\"\n" \
"  You reply that it does not surprise you that dogs are served at his bar, having tasted the beer yourself. He ignores your jibe, and continues. \"No, no. There are no dogs in Bumley. Not since the coming of the Barghest.\"\n" \
"  \"Which bar guest?\" you reply, irritated. \"What are you babbling about?\"\n" \
"  \"The Dog of Hell,\" he whispers. Years ago, he tells you, an old woman lived in a hovel in the Mistywood. When several of the village children fell sick, and some of the local barns burned down under odd circumstances, the old crone was accused of witchcraft, and was sentenced to be burned at the stake.\n" \
"  As the fires were started at her feet, she cried out in a loud voice, silencing the jeering mob in the village square about her. \"Fools!\" she cried. \"You think to slay me with impunity? Never again shall you have peace of mind or freedom from fear. Hear me, ye powers of darkness, who dwell between the worlds, and feast upon the souls of men! I claim the death-boon of Zomakarx, Prince of Enmity. Send the Barghest to torment my destroyers!\" She began to cackle, coughed, and then was overcome by the smoke and fire. But as she died, as if in answer to her plea, a long, loud, lugubrious howl came from the depths of the Mistywood - a howl that chilled the marrow of all who heard it, a howl that set every dog in Bumley barking and whining in fear.\n" \
"  At this point the innkeeper stops for a moment. He clears his throat and says, \"Storytelling sure is thirsty work...\"\n" \
"  If you take the hint and buy him a beer, he'll continue; go to {36}. If you decide to flee this strange place, go to {27}."
},
{ // 69/11E
"Go to Encounter Table B. Roll for an encounter as directed, and resolve it. If you are still alive, you notice that you have been wandering in circles. Through the fog you can see the tops of the trees of Mistywood before you. If you want to go north to the woods, go to {104}. If you want to go in any other direction, go to {140}."
},
{ // 70/12A
"Make a L2-SR on Strength (25 - ST). If you miss the roll, shame on you. Go to {10}; the sword refused to budge.\n" \
"  If the roll was successful, the sword - a masterpiece of steel and mithril - slides easily out of the tree trunk and rests, light as a feather, in your hand. The three knights stop, appalled at the sight. \"Strike the traitors!\" the medallion cries. \"Strike for Auria and Voronir!\"\n" \
"  If you want to throw away the sword and medallion and run for it, go to {57}. If you want to drop the sword and fight these guys with your own weapon, go to {10}. If you want to fight them with the elf-sword, go to {4}."
},
{ // 71/12B
"Make a L3-SR on Luck (30 - LK). If you miss the roll, you failed to detect the tripwire in your path which released a delicately-balanced but very heavy log from the foliage above you.\n" \
"  If you tripped the wire, your horse is killed and you must make a L3-SR on Dexterity (30 - DEX). If the roll is not successful, roll 1d6 and add 6 to the result; take that many hits directly off your CON (armour will not help). If you survive, extricate yourself from the mess and continue your adventure."
},
{ // 72/12C
"You have come to the shore of a large lake. The deep blue water is icy cold. A tall man in a monk's cowl offers to row you across the lake; his fee is one gold piece. If you are still one horseback at this point, the boat is too small for your mount, so you must leave the horse behind.\n" \
"  If you refuse his offer and try to ride (or walk) around the lake, go to {3}. If you accept his offer, go to {129}."
},
{ // 73/12D
"The door is wedged shut; to force it open, you must make a L5-SR on Strength (40 - ST). You get three tries. If you can't get it open, shrug your weary shoulders as you return to the clearing; go to {1}. If you succeed in forcing your way in, go to {114}."
},
{ // 74/12E
"Nothing happens. If you try to dig the box out by hand, go to {143}. If you would rather leave, go to {1}."
},
{ // 75/12F
"Your non-magical weapon passes harmlessly through the shadowy form of the Banshee. Go to {91}, and take your punishment like a man."
},
{ // 76/13A
"Early morning mist blankets the marshes, and you easily lose your pursuers. However, you soon discover that in eluding them you have gotten yourself lost!\n" \
"  If you decide to head northeast, trying to find your way back to Mistywood and the road there, go to {104}. If you want to head south and avoid the wood, go to {69}."
},
{ // 77/13B
"As you ride along, you suddenly hear a chorus of howling behind you. Roll 1d6; this is the number of shaggy grey wolves that have come up to follow you. Each wolf has a MR of 26 (2 dice + 13 adds).\n" \
"  The solves race down the path, intent of making a meal of you and your mount. The horse runs but is quickly overtaken; you must draw your weapon and fight for your life.\n" \
"  [Roll 1d6 at the beginning of each combat round. If you roll a 1, the wolves have dragged your horse down, and you must a L3-SR on your Dexterity (30 - DEX). If you miss the saving roll, you lose your combat adds for one combat round. You also lose your horse, for he has broken his leg in the fall.\n" \
"  ]If you are on foot, fight the wolves normally. They are worth 26 ap each. If you survive, proceed normally."
},
{ // 78/13C
"You are greatly annoyed to find that the gnome's path is very hard to follow without your pint-sized guide. Roll 2 dice. If you roll 9-12, you have found the clearing where you met the gnome; go to {62}. If you roll 2-8, something found you. Go to the Random Encounter Table A and follow the instructions there. Then, if you survive, return here and roll again."
},
{ // 79/13D
"Smart fellow! You recognized the Bronzo insignia on the saddlebags. The owners of those horses must be inside the stable. If you want to mount your horse and go east, go to {27}. If you decide to enter the stable, go to {107}. If you want to sneak around behind the stable and try to surprise your adversaries, go to {60}."
},
{ // 80/13E
"Suddenly you hear the baying of a huge hound in the distance. Dense yellow-white fog billows up out of the ground about you; in a few minutes, your vision is almost completely obscured. When the fog starts to thin out, you look around and curse. Some evil enchantment has transported you into the depths of the Mistywood. Go to {111}."
},
{ // 81/13F
"As you draw your weapon, the boatman puts two fingers (his own) in his mouth, and gives a piercing whistle. The water about the boat becomes abruptly agitated as six huge tentacles lash up out of the foaming lake to attack you!\n" \
"  Each tentacle has a MR of 18 (2 dice + 9 adds). All damage inflicted on the lake monster will be split by two (randomly determined; roll 1d6) of the six tentacles each melee round. Tentacles accumulating more than 18 hits are severed. The monster will cease fighting to dive back into the depths of the lake if it loses 4 or more tentacles. If you defeat the lake monster, make a L2-SR on Intelligence (25 - IQ). If the roll is successful, go to {119}. If you miss the roll, go to {44}."
},
{ // 82/13G
"Make a L3-SR on your Intelligence (30 - IQ). If you make the roll, go to {59}. If you miss the roll, you have found nothing to interest you, and you might as well leave; go to {1}."
},
{ // 83/13H
"You are suddenly confronted by 1-6 muckmen. These reptilian humanoids are not always hostile, so make a saving roll on Charisma on your own level; if it is successful, the muckmen will be more inclined to be friendly. If they like you, they let you pass. If you attack them, they will fight to the death. If they don't like your looks, however, they will attack! Each muckman has a MR of 40, and carries 10-60 silver pieces each. If you slay them all, they are worth 60 ap apiece."
},
{ // 84/14A
"You have just come face to face with Grisix the Troll (MR 90), said creature being infamous for his vile temper and voracious appetite. Fight him to the death. If you win, he has 300 gp in his pouch, and was worth 135 ap. Grisix and his equally ugly brothers are responsible for most of the pit and deadfall traps in Mistywood. (If you kill Grisix, the Trolls you find hereafter are his brothers.)"
},
{ // 85/14B
"Your magic weapon strikes the Banshee before it can start its mind-shattering shriek. You see a shower of blue sparks, and a cold shock travels up your arm clear to the shoulder. The Shrieking Spirit emits a death scream that will haunt you to your dying day, then shrivels up to a tiny wisp of blue smoke. A wind rises, seemingly from nowhere, to blow it away. The encounter was worth 300 adventure points.\n" \
"  The next time you look at yourself in a mirror, you will notice that your hair has turned white as driven snow. If you want to get out of this place, return to the clearing and go to {1}. If you want to poke around the tomb, go to {34}."
},
{ // 86/14C
"You can put the medallion in your pocket, or you can put it around your neck (note on your character card where you place it). When you grasp the hilt of the sword, you feel a surge of power. Behind you, three voices cry loudly in unison: \"Stop!\"\n" \
"  \"Pull, friend,\" whispers a voice from the sword. \"Pull, or you are lost!\" If you let go the sword and make a break for it, go to {9}. If you let go the sword and turn to face your unknown foes, go to {106}. If you try to pull the sword from the tree, go to {70}."
},
{ // 87/14D
"As you assault the idol and its skull-crowned altar, you hear a howl of rage. A huge hound takes shape before you and attacks. If you want to attack the Barghest, go to {40}. If not, go to {20}."
},
{ // 88/14E
"The retainers attack you with their scimitars (4 dice each). Their stats are as follows:\n" \
"    Leader     CON: 13    Adds: +11    Armour: Mail   (11[x2])\n" \
"    2nd foe    CON: 13    Adds: +10    Armour: Ring    (7[x2])\n" \
"    3rd foe    CON: 12    Adds: +3     Armour: Leather (6[x2])\n" \
"    4th foe    CON: 16    Adds: +6     Armour: Leather (6[x2])\n" \
"If you overcome these foes, you have earned 178 experience points. You'll find a total of 135 gold pieces in their purses. Continue your ride south by going to {16}."
},
{ // 89/15A
"The old man is the holy hermit of Mistywood, a pious ascetic. He will bless you if you give him a gold piece; his blessing will heal all damage to your CON. Proceed normally."
},
{ // 90/15B
"As you ride along over the moors, you suddenly notice five men on horseback coming over the crest of the hill directly west of you. They spot you and break into a gallop. If you stop and wait for them, go to {11}. If you flee southward, go to {41}. If you want to ride east, and take your chances in Mistywood, go to {111}."
},
{ // 91/15C
"The Banshee lets loose a hideous, ear-splitting, sanity-shattering shriek that seems to go on forever. make a L6-SR on Luck (45 - LK). If you miss it, go to {43}. If you make it, go to {116}."
},
{ // 92/15D
"This box contains an ointment that will cause any non-fatal wounds to heal at twice the normal rate; the ointment is also an antiseptic and will prevent infection. You have enough ointment for 10 applications. While you remain within the Mistywood, you will recover 2 points per paragraph.)\n" \
"  Go to {1} and continue your journey."
},
{ // 93/15E
"You are attacked by a nest of Bloodworms! These giant mutated leeches a MR of 30 each; there are 1-6 of the slimy things. [If they succeed in injuring you, the wounds will continue to bleed due to a powerful anticoagulant in the worms' saliva. You will lose blood at the rate of 1 CON point per combat round for each round that you get \"hit\"; this loss will be cumulative. (If you have been hit on the first combat round, you lose 1 point on Round 2. If you are hit on the second round, you lose 2 points on the third round, and so on! Hits taken on armour don't count.) If you have a horse, it bleeds to death despite your efforts to save it. Your blood loss will stop in the turn that you are able to stop fighting (this assumes you have killed all the bloodworms) and take the time to bind your wounds tightly. ]Each bloodworm was worth 45 ap."
},
{ // 94/15F
"Roll 2 dice. If you roll doubles, go to {113}. If you roll anything but doubles, go to {45}."
},
{ // 95/15G
"Roll one die and divide the result by two. This is the number of harpies (MR 50 each) who come winging in to attack you. If you survive the assault, collect 75 ap for each monster you killed and continue your journey."
},
{ // 96/15H
"The black knight's mace is worth 8 dice in combat. He can throw it at a foe three times a day; it will inflict one die of hits on its target's CON regardless of armour - unless the target wears the gold medallion from the oak tree around his neck. The knight has a CON of 25 and 21 personal adds; his armour takes 10 (x2) hits per round. If you defeat him, collect 250 ap and go to {66}."
},
{ // 97/15K
#ifdef CORGI
"You are lucky again. The only really effective way to fight the undead is to mash them into a thin paste. If you succeed in flattening all these shambling mounds of corruption, take 150 experience points. However, the woman has fled deeper into the cave. You can let her go and flee by going to {109}. If you would rather go teach this young minx a lesson, follow her to {125}."
#else
"You are lucky again. The only really effective way to fight the undead is to mash them into a thin paste. If you succeed in flattening all these shambling mounds of corruption, take 150 experience points. However, the woman has fled deeper into the cave. You can let her go and scram yourself by going to {109}. If you would rather go teach this young minx a lesson, follow her to {125}."
#endif
},
{ // 98/16A
"Grave-robbing is a very dirty business - but quite profitable, in this case. The necklace is worth 8000 gp, and the ring is worth 7000 gp.[ The ring also allows you to see in the dark (it operates like a Cateyes spell but costs nothing, and anyone can use it).]\n" \
"  If you want to search the tomb's walls now, go to {82}. If you just want to leave, and get on with your journey, go to {1}."
},
{ // 99/16B
"If you are on horseback, a poisonous serpent hidden in the weeds strikes your horse. The poor animal soon goes to that big pasture in the sky, leaving you to hoof it out on your own.\n" \
"  If you were travelling on foot, roll 4 dice. If the total rolled exceeds the ability of your armour to absorb damage (face value only), the snake hit you in an exposed place. You must now make a L5-SR on Luck (40 - LK). If you miss the roll, you die a horrible death. If the roll is successful, proceed normally: the snake failed to inject venom when it struck you. You merely have two tiny holes to remind you of your close brush with death..."
},
{ // 100/16C
"The ring slips onto your finger, and you immediately understand its use. [As long as you wear it, you are entitled to a L1-SR on your Constitution (20 - CON) whenever you are exposed to poison in any way. If you make the saving roll, the effect of the poison is nullified. ]Rejoice in your lucky find, and go to {109}."
},
{ // 101/16D
"Without warning, a terrible apparition swoops down from the sky on huge leathery wings, lashing out with its long tail. The Wyvern has a MR of 100, and its tough hide will take 7 hits of damage per round.\n" \
"  At the beginning of each combat round, roll one die. If you roll 1-2, the monster has bitten your horse, and the horse dies.[ Each turn the creature inflicts damage on you, you must make a saving roll on CON at your own level, or suffer the effects of the Wyvern's poisonous bite (treat it as spider venom).]\n" \
"  If you manage to kill this awful thing, take 270 ap and proceed normally."
},
{ // 102/16E
"Bad choice. The three knights were hoping you'd get greedy. Go to {10}."
},
{ // 103/16F
"He takes your money and ferries you over to the opposite side of the lake. Go to {55}."
},
{ // 104/16G
"These marshes are a most unhealthy place to linger. Roll 2 dice. If you rolled 9-12, you have reached the woods; go to {111}. If you rolled 2-8, however, go to Random Encounter Table B and follow the instructions there. Then return here, if you are still alive, and roll again."
},
{ // 105/16H
#ifdef CENSORED
"You emerge abruptly from the woods and find yourself facing the mouth of a large cave. You see a wild-looking but attractive woman standing in the entrance. She turns abruptly and disappears. If you stop to follow the woman into the cave, go to {38}. If you want to ignore her and go on down the road, go to {109}."
#else
"You emerge abruptly from the woods and find yourself facing the mouth of a large cave. A wild-looking but attractive woman stands in the entrance. There is more cotton on top of an aspirin bottle than there is in her garments. She gives you a very provocative come-hither wiggle, and slips into the cave. If you stop to investigate the woman and the cave, go to {38}. If you want to ignore her and go on down the road, go to {109}."
#endif
},
{ // 106/18A
"Too late to run! Three knights stand in the clearing around you, blocking all escape routes. The first knight wears a suit of red lamellar; a huge broadsword rests lightly in his gauntleted hand. The second knight is an Elf clad in dazzling elf-lamellar; he holds a longsword whose blade scintillates with all the colours of the rainbow. The third knight wears black lamellar armour studded with small brass circles that have been engraved with mystic symbols; he carries a heavy black mace whose cylindrical head is wickedly spiked. If you want to attack the knights, go to {10}. If you want to try and parley with these three menacing figures, go to {18}."
},
{ // 107/18B
"Inside, examining your horse at the far end of the stable, are two of Duke Bronzo's men-at-arms. When they see you enter, they draw their scimitars (4 dice) and attack. The first has a CON of 16 and 8 adds, the second has a CON of 14 and 4 adds. Both men wear leather armour (6 hits[, doubled]). If you kill them, take 76 adventure points in addition to the 64 gold pieces you find in their pockets. Go to {27}.\n" \
"  If they killed you, you were too weak for this adventure anyway. Better luck next time."
},
{ // 108/18C
"This Ogre has a MR of 80 (9 dice + 40 adds). If you kill him, take 120 ap plus the contents of his wallet (300 gold pieces). If he killed you, why are you reading this?\n" \
"  The gnome is pathetically grateful. \"I have no treasure to reward you,\" he snivels, \"but I can show you a place where treasure can be found. There also you may find help to escape this thrice-cursed forest.\"\n" \
"  If you are interested, go to {123}. If you just want to keep going on your own, go to {42}."
},
{ // 109/18D
"The road turns southward, and then becomes a mere forest trail. As you proceed, the forest becomes progressively darker and more ominous.\n" \
"  If you decide to turn around and return to the clearing to take the south branch of the road there, go to {1}. If you want to press on through the woods, go to {141}."
},
{ // 110/18E
"Roll one die and multiply the result by 100; this is the number of gold pieces inside the box. Go to {1} and continue your journey."
},
{ // 111/18F
"These woods are ugly, dark, and deep. You press on into the dense underbrush, searching for the road. Roll two dice. If you rolled 9-12, you have found the road; go to {128}. If you rolled 2-8, you found something, but it was not the road. Go to Random Encounter Table A and follow the instructions there. Then return here, and try, try again!"
},
{ // 112/18G
"As you wander through an area, treading on relatively more solid ground, you are attacked by a mass of thorny vines which lash out at you like whips and entangle you. The combined MR of this large carnivorous plant is 80. If it injures you, you lose your DEX adds on subsequent combat turns, for you have been ensnared by the vines and are no longer free to move around. If the plant reduces your CON to zero, it will draw you to its mouth and devour you.\n" \
"  If you hack up the plant enough to kill it, take 120 adventure points. You'll find 97 gold pieces in the foliage - they were left by a previous dinner guest..."
},
{ // 113/18H
"With a loud roar, the tunnel that leads to the tomb caves in! You are trapped, and you must dig your way out before the air supply gives out.\n" \
"  Roll one die. If you roll 1, go to {5}. If you roll 2-5, go to {135}. If you roll 6, go to {25}."
},
{ // 114/18K
"The door screeches loudly as you force it open - and the moaning within stops abruptly. You look in and see a shadowy form approaching through the dust cloud you've kicked up. If you want to flee, go to {126}. If you attack this sinister apparition, go to {132}. If you hold your ground, waiting to see what this thing is, go to {91}."
},
{ // 115/19A
"If you are mounted, your horse is getting skittish. Then you hear a sound coming from deep in the earth below you - the distant baying of a hellish hound. The dreadful howling rises to a cacophonous roar, and your horse panics. If you fail a L2-SR on your Dexterity (25 - DEX), your horse bucks you off and you watch your terrified steed make tracks for quieter pastures. If the roll is successful, you have kept your seat; continue riding.\n" \
"  If you were on foot, the howling unnerved you somewhat, but nothing unusual happened. Proceed normally."
},
{ // 116/19B
"If you flee, go to {51}. If you are holding a weapon and wish to attack, go to {132}. If you want to do anything else, go to {43}."
},
{ // 117/19C
"Gorghasty hits you with a 40-point Take That You Fiend as his men attack you with their scimitars (4 dice each). Their stats are as follows:\n" \
"    Leader     CON: 16    Adds: +26    Armour: Lamellar (10[x2])\n" \
"    2nd foe    CON: 16    Adds: +19    Armour: Scale     (8[x2])\n" \
"    3rd foe    CON: 12    Adds: +10    Armour: Leather   (6[x2])\n" \
"    4th foe    CON: 16    Adds: +13    Armour: Leather   (6[x2])\n" \
"Gorghasty has an IQ of 40 and a CON of 15.[ Each round, he will cast another TTYF (if you roll 1-4 on 1d6) or a Delay spell (if you roll 5-6 on 1d6). He will keep casting spells until you are overcome, or you kill the retainers. (He has the Strength to do it without raising a sweat.)]\n" \
"  If you kill all the retainers, the wizard will take off for the hills. He didn't get to 12th level by standing up to tough guys like you! If you live, collect 404 adventure points; you also find 350 gp in the soldiers' saddlebags.\n" \
"  If you decide to continue north, go to {80}. If you head east into Mistywood, go to {111}. If you change your mind and head back south, go to {54}."
},
{ // 118/19D
"You must make four L3-SRs on your Luck to fool these sharp fellows. If you miss *any* of the rolls, go to {88}. If you make them all, your ruse was successful; go to {16}."
},
{ // 119/19E
"You remembered that you had another foe in the boat with you. You turned to face him before he could attack you with his nasty dagger. He curses and asks if you are ready to pay up, gesturing as though he will whistle again. If you decide not to risk a second lake monster, go to {103}. If you want to jump overboard and swim for it, go to {17}. If you think he is bluffing, and attack him, go to {33}."
},
{ // 120/19F
"As you abase yourself before the devil-prince's image, the ground beneath you suddenly gives way, and you fall, shrieking, into a fiery abyss. Before you die, you see the vast jaws of Zomakarx opening wide like a flaming cauldron to receive you. You are utterly destroyed; the dark gods are a notoriously ungrateful lot. Close the book."
},
{ // 121/19G
"Robbing the dead is a crime, but desecrating a body is a mortal sin! The vengeful guardian of the dead, Great Morrigu, curses you: roll one die and subtract that number from your Luck (permanently.)\n" \
"  If you want to leave, go to {1}. If you want to take a look at the walls of the tomb, go to {82}."
},
{ // 122/19H
"If you are riding, your horse suddenly screams in pain. You dismount and find that his foreleg is caught in the jaws of a huge mantrap; the leg is broken. Dispatch the poor beast, and proceed normally.\n" \
"  If you were on foot, the sharp jaws have grabbed your leg! [Roll a die; if you roll 1-3, your leg is broken, 4-6 and your leg is unbroken (but rather chewed up). In either case, ]take 1-6 points from your CON. [A broken leg will cost you all of your DEX adds until it heals. ]To open the trap and free yourself, you must make a L2-SR on ST (25 - ST). [Each time you fail, there is a chance (1d6: 1-3) that another encounter will occur. Roll Encounters on Table A and ignore any that occur when you are walking - if it can come to you, deal with it.\n" \
"  You will get no DEX adds until you free yourself, even if your leg is not broken. ]If you don't free yourself in three tries, you will die from shock and blood loss."
},
{ // 123/20A
"The gnome leads you down a narrow path. After a while he stops. \"In the clearing ahead you will find the things I spoke of,\" he tells you. \"But beware! These things are surrounded by strong magic - and many perils. Good luck and fare thee well. This place is not safe for us small folk.\" The gnome scurries away into the brush and is gone.\n" \
"  If you turn back, go to {78}. If you enter the clearing cautiously, go to {39}."
},
{ // 124/20B
"This encounter occurs only if you are on horseback. If you are travelling on foot, you have not encountered anything to interest you; return to the paragraph that sent you here.\n" \
"  As you are riding along, your horse suddenly rears in panic. Make a L3-SR on Dexterity (30 - DEX). If you miss the roll, you are thrown off. You lie stunned for a moment as your mount gallops wildly down the road and out of the story. Looking up, you see what frightened the poor animal. A large dog is standing in the road before you; it looks perfectly normal in all respects but one - it has no head! It wheels and disappears into the shadows. You grimly recall that the headless dog of Mistywood is the legendary harbinger of death. Proceed on foot."
},
{ // 125/20C
"Filled with battle-rage and lust, you pursue the woman and finally corner her in front of a rude stone altar. As you seize her roughly in your arms she laughs - and then, instead of a beautiful, desirable young woman, you are holding a horribly ugly, toothless old hag! She cackles awfully at your shocked expression. With an oath, you hurl her violently against the wall, crushing her skull. As she crumples, you hear a faint cry from the altar beside you. You turn quickly, weapon ready. Your eyes adjust to the dim light - with a shudder of revulsion, you see the fire-blackened skull of the Crone of Bumley. Within each black eye socket gleams a tiny red light; a hissing, unearthly voice issues from between the grinning teeth.\n" \
"  \"So, hero, you have slain my sister. But she will be avenged. You will not escape the Barghest. All who enter these woods must face him. He will rend you painfully, and carry your soul back to Hell to offer to his master.\" The skull laughs hideously; with an oath, you bring your weapon crashing down, smashing the gruesome relic to powder. But the echoes of the laughter take a long time to fade...\n" \
"  If you search carefully, you will find 900 gold pieces in a box behind the altar. In the powdery fragments of the crone's skull, you also find a ring wrought in the shape of a silver serpent with tiny ruby eyes. If you want to try the ring on, go to {100}. If you just stuff the ring in your pocket (without trying it on) and leave, go to {26}. If you would rather leave the ring alone and get on with the adventure, go to {109}."
},
{ // 126/20D
"Make a L3-SR on Luck (30 - LK). If you make it, go to {51}. If you miss it, go to {91}."
},
{ // 127/20E
"As you wade through the marsh, you are attacked by a giant crocodile with a MR of 90. [The deep muck causes you to lose your DEX adds while you battle the huge saurian. ]If you survive, take 135 ap and proceed normally."
},
{ // 128/21A
"The road through Mistywood is dismal, narrow, and overgrown with weeds. It is also deserted, for few travellers dare to use this gloomy and hazardous route.\n" \
"  Roll 2 dice. If you rolled 9-12, go to {53}. If you rolled 2-8, however, go to Random Encounter Table A and follow the instructions there. Then return here and roll again."
},
{ // 129/21B
"When the boat reaches the middle of the lake, the boatman stops rowing and stands up. He demands that you give him all of your money. If you pay up, go to {103}. If you jump over the side and swim for it, go to {17}. If you draw your weapon and assault this insolent pirate, go to {81}."
},
{ // 130/21C
"Night has fallen; there is no moon. A wind rises, moaning among the black tree trunks around you. You sense something terrible following you, padding patiently through the darkness, and growing ever stronger. If you turn and face it, go to {37}. If you keep running, and try to get out of Mistywood before it catches up with you, go to {12}."
},
{ // 131/21D
"A short distance away you find a curious-looking large grassy mound. A hole in its side leads down stone steps into the earth. The wailing is coming from this rude entrance. make a L1-SR on Luck (20 - LK). If you miss the roll, you must go down and investigate; go to {28}. If you make the saving roll, go back to {1}, and continue on your way - unless you really want to see what is moaning down there, in which case you can go of your own free will to {28}."
},
{ // 132/21E
"If you are attacking with a magic weapon, go to {85}. If you are attacking with a non-magical weapon, go to {75}."
},
{ // 133/21F
"On the road again! Roll 2 dice. If you roll 9-12, go to {105}. If you roll 2-8, go to Random Encounter Table A and follow the instructions there. If you survive, return here and roll again."
},
{ // 134/21G
"Your skin tingles momentarily as you cross the line of white flowers around the oak; you sense that there is strong enchantment here. Alert for danger, you examine the sword and medallion. The sword is of high elven workmanship; the medallion bears the face of an exquisitely beautiful Elf woman. Both items are of great value, perhaps priceless. If you want to take the medallion and leave, go to {56}. If you want to take both the sword and the medallion, go to {86}. If you just want to leave, not daring to fool around with either one, go to {106}."
},
{ // 135/21H
"In spite of a heroic effort, you are overcome by the foul air before you can break through to the surface. The Banshee tomb has become your final resting place; close the book."
},
{ // 136/21K
"Within the coffin rests a skeleton which wears a diamond necklace and a ring set with a large sapphire. If you want to take the jewellery, go to {98}. If you want to pound the skeleton to powder first, and then take the jewels, go to {121}. If you leave the bones alone and examine the walls of the tomb, go to {82}. If you would rather leave, go to {1}."
},
{ // 137/21L
"The red knight has a CON of 20 and 15 personal adds. His sword gets 5 dice; his armour will absorb 14 (x2) hits per round. If you kill him, take 250 ap and go to {66}."
},
{ // 138/22A
"There are tears in the eyes of the medallion's sad face. \"Who...what are you?\" you ask, amazed.\n" \
"  \"I am the spirit of Auria Ellendora of the Elves,\" the medallion answers. \"But a traitor and scoundrel led me astray, and, for love of him, I betrayed my family. When our treachery was discovered, the noble elf-prince Voronir, whom I had spurned, sought to protect me from my father's anger; for his bravery, he shared my fate. His spirit is in yonder sword as mine is imprisoned in this accursed metal. Here we remain, guarded by those who condemned us. But hark! They come! Quick, the sword!\"\n" \
"  You turn to see three menacing figures approaching. If you want to throw away the medallion and run for cover, go to {9}. If you want to put on the medallion and try to talk to them, go to {18}. If you want to put on the medallion and attack the three, go to {10}. If you want to put on the medallion and grab the sword, go to {70}."
},
{ // 139/22B
"As you cross the street to the stable, you see two horses hitched to a post. Make a L1-SR on Intelligence (20 - IQ). If you make it, go to {79}. If you miss, go to {107}."
},
{ // 140/22C
"Go to Encounter Table B again. Roll for another encounter as directed, and resolve it. If you survive, you will notice that once again you have wandered in a circle, and Mistywood is before you.\n" \
"  If you want to go north to the woods, go to {104}. If you want to try to trek out of this mess in any other direction, go to {69}."
},
{ // 141/22D
"Roll 2 dice (here you go again!). If you roll 8-12, go to {72}. If you roll 2-7, go to Random Encounter Table A and follow the instructions there. If you survive, return here and roll again."
},
{ // 142/22E
"You see a loose tile in the floor in front of the door. Scrutiny reveals it to be a trigger of some kind. You carefully avoid it and try the door. Go to {73}."
},
{ // 143/22F
"Roll one die. If you roll 1, go to {35}. If you roll 2-5, go to {110}. If you roll a 6, go to {92}."
}
};

MODULE SWORD mw_exits[MW_ROOMS][EXITS] =
{ {  68,  27,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/1G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/1H
  { 102,  78,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/1K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2A
  {  22, 117,  29,  -1,  -1,  -1,  -1,  -1 }, //  11/2B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/2D
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/3A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/3B
  { 104,  69,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/3C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/3D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/3E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/4A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/4C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/4D
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/4E
  {   1,  82,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/4F
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/4G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/4H
  { 128,  90,  54,  -1,  -1,  -1,  -1,  -1 }, //  27/4K
  {  58,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/5A
  { 111, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/5B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/5C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/5D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/5E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/5F
  {  24,   1,  82,  -1,  -1,  -1,  -1,  -1 }, //  34/6A
  { 113,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/6B
  { 139,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/6C
  {  20,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/6D
  {  48,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/6E
  {  78, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/6F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/7A
  {  80, 111,  54,  -1,  -1,  -1,  -1,  -1 }, //  41/7B
  { 133,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/7D
  {  33,  17,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/7E
  { 143,  74,   1,  -1,  -1,  -1,  -1,  -1 }, //  45/7F
  { 137,  32,  96,  10,  57,  -1,  -1,  -1 }, //  46/7G
  {  65,  89,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/8A
  { 109, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/8B
  {   1,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/8C
  {  14,  78,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/8D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/8E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/8F
  {  67,   6,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/9A
  {  88,   2,  76, 118,  -1,  -1,  -1,  -1 }, //  54/9B
  {  63, 130,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/9C
  { 106, 138,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/9D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/10A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/10B
  {  94,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/10C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/10D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/10E
  {   1, 131,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/10F
  {  87, 120, 130,  -1,  -1,  -1,  -1,  -1 }, //  63/10G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/10H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/11A
  {  10,  78,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/11B
  { 108,   6,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/11C
  {  36,  27,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/11D
  { 104, 140,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/11E
  {  57,  10,   4,  -1,  -1,  -1,  -1,  -1 }, //  70/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/12B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/12C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/12D
  { 143,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/12E
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/12F
  { 104,  69,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/13A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/13B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/13C
  {  27, 107,  60,  -1,  -1,  -1,  -1,  -1 }, //  79/13D
  { 111,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/13E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/13F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/13G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/13H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/14A
  {   1,  34,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/14B
  {   9, 106,  70,  -1,  -1,  -1,  -1,  -1 }, //  86/14C
  {  40,  20,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/14D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/14E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/15A
  {  11,  41, 111,  -1,  -1,  -1,  -1,  -1 }, //  90/15B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/15C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/15D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/15F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/15G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/15H
  { 109, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/15K
  {  82,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/16B
  { 109,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/16C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/16D
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/16E
  {  55,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/16F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/16G
  {  38, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/16H
  {  10,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/18A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/18B
  { 123,  42,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/18C
  {   1, 141,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/18D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/18E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/18F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/18G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/18H
  { 126, 132,  91,  -1,  -1,  -1,  -1,  -1 }, // 114/18K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/19A
  {  51, 132,  43,  -1,  -1,  -1,  -1,  -1 }, // 116/19B
  {  80, 111,  54,  -1,  -1,  -1,  -1,  -1 }, // 117/19C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/19D
  { 103,  17,  33,  -1,  -1,  -1,  -1,  -1 }, // 119/19E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/19F
  {   1,  82,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/19G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/19H
  {  78,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/20A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/20B
  { 100,  26, 109,  -1,  -1,  -1,  -1,  -1 }, // 125/20C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/20D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/20E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/21A
  { 103,  17,  81,  -1,  -1,  -1,  -1,  -1 }, // 129/21B
  {  37,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/21C
  {   1,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/21D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/21E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/21F
  {  56,  86, 106,  -1,  -1,  -1,  -1,  -1 }, // 134/21G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/21H
  {  98, 121,  82,   1,  -1,  -1,  -1,  -1 }, // 136/21K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/21L
  {   9,  18,  10,  70,  -1,  -1,  -1,  -1 }, // 138/22A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/22B
  { 104,  69,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/22C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/22D
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/22E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 143/22F
};

MODULE STRPTR mw_pix[MW_ROOMS] =
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
  "",
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
  "mw28",
  "",
  "", //  30
  "",
  "",
  "",
  "",
  "", //  35
  "",
  "",
  "",
  "mw39",
  "", //  40
  "",
  "",
  "",
  "",
  "", //  45
  "",
  "mw47",
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
  "mw63",
  "",
  "", //  65
  "",
  "mw67",
  "",
  "",
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
  "mw105", // 105
  "mw106",
  "",
  "",
  "",
  "", // 110
  "",
  "",
  "",
  "",
  "", // 115
  "",
  "",
  "",
  "",
  "", // 120
  "",
  "",
  "",
  "",
  "mw125", // 125
  "",
  "",
  "",
  "mw129",
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
  ""  // 143
};

MODULE int                    mounted,
                              wm[2][12][2];

IMPORT int                    age,
                              armour,
                              been[MOST_ROOMS + 1],
                              evil_damagetaken,
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp, rt, lt, both,
                              height, weight, sex, race, class, size,
                              prevroom, room, module,
                              round,
                              spellchosen,
                              spelllevel,
                              spellpower;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void mw_enterroom(void);
MODULE void mw_wandering(int whichtable);

EXPORT void mw_preinit(void)
{   descs[MODULE_MW]   = mw_desc;
 // wanders[MODULE_MW] = mw_wandertext;
}

EXPORT void mw_init(void)
{   int i, j, k;

    exits     = &mw_exits[0][0];
    enterroom = mw_enterroom;
    for (i = 0; i < MW_ROOMS; i++)
    {   pix[i] = mw_pix[i];
    }

    mounted = 1;
    for (i = 0; i < 2; i++)
    {   for (j = 0; j < 12; j++)
        {   for (k = 0; k < 2; k++)
            {   wm[i][j][k] = FALSE;
}   }   }   }

MODULE void mw_enterroom(void)
{   int i,
        result,
        result1,
        result2;

    switch (room)
    {
    case 1:
        result = dice(2);
        if (result >= 7)
        {   room = 72;
        } else
        {   mw_wandering(TABLEA);
        }
    acase 2:
        savedrooms(2, lk, 128, 88);
    acase 3:
        result = dice(2);
        if (result >= 9)
        {   room = 55;
        } else
        {   mw_wandering(TABLEB);
        }
    acase 4:
        give(500);
        create_monster(247);
        create_monster(248);
        create_monster(249);
        fight();
        award(1000);
        room = 23;
    acase 5:
        die();
    acase 6:
        savedrooms(3, lk, 133, 108);
    acase 7:
        if (!saved(3, iq))
        {   if (mounted)
            {   if (dice(1) <= 4)
                {   mounted = FALSE;
                } else
                {   good_takehits(dice(3), TRUE);
            }   }
            elif (dice(1) >= 4)
            {   good_takehits(dice(3), TRUE);
        }   }
        room = prevroom;
    acase 8:
        if (!mounted || !saved(2, lk) || !saved(3, lk))
        {   if (!saved(4, lk) && !saved(5, lk) && !saved(6, lk))
            {   mounted = FALSE;
                if (!saved(7, lk) && !saved(8, lk))
                {   die();
        }   }   }
    acase 9:
        if (prevroom == 138)
        {   dropitem(507);
        }
        if (!saved(4, lk) || !saved(4, dex))
        {   room = 57;
        } else
        {   dropitem(507);
        }
    acase 10:
        if (!been[137])
        {   create_monster(247);
        }
        if (!been[32])
        {   create_monster(248);
        }
        if (!been[96])
        {   create_monster(249);
        }
        fight();
        award(1000);
        room = 50;
    acase 12:
        create_monster(250);
        fight();
        victory(1200);
    acase 13:
        result = dice(1) + 1;
        create_monsters(251, result);
        do
        {   if (mounted && dice(1) <= 2)
            {   mounted = 0;
            }
            oneround();
        } while (con >= 1 && countfoes());
        for (i = 1; i <= result; i++)
        {   give_gp(dice(2));
        }
        room = prevroom;
    acase 14:
        use(501);
        room = prevroom;
    acase 15:
        create_monster(252);
        fight();
        room = prevroom;
    acase 17:
        if (saved(3, lk) && saved(3, con))
        {   room = 55;
        } else
        {   die();
        }
    acase 18:
        savedrooms(4, chr, 46, 10);
    acase 19:
        mounted = 0;
        create_monster(253);
        fight();
        room = prevroom;
    acase 20:
        create_monster(254);
        fight();
        victory(900);
    acase 21:
        if (mounted && !saved(3, dex))
        {   mounted = 0;
        }
        create_monster(255);
        fight(); // %%: presumably the spider's venom works like the "spider venom" in the RB
        room = prevroom;
    acase 22:
        die();
    acase 24:
        if (saved(5, st))
        {   room = 136;
        }
    acase 26:
        savedrooms(level, lk, 109, -1);
        // %%: does it turn back into a ring afterwards? We assume not.
    acase 28:
        if (!saved(2, lk))
        {   room = 1;
        }
    acase 29:
        savedrooms(3, lk, 111, 117);
    acase 30:
        if (mounted)
        {   if (saved(3, lk))
            {   room = prevroom;
            } else
            {   result1 = dice(1);
                if (result1 <= 4)
                {   mounted = 0;
                    result2 = dice(1);
                    if (result2 % 2)
                    {   result2 = (result2 / 2) + 1;
                    } else
                    {   result2 /= 2;
                    }
                    templose_con(result2);
                } elif (result1 == 5)
                {   templose_con(dice(1));
                } else
                {   mounted = 0;
                    templose_con(dice(4));
                    if (!saved(6, st))
                    {   die();
        }   }   }   }
        else
        {   if (saved(2, iq))
            {   room = prevroom;
            } else
            {   templose_con(dice(1));
        }   }
        while (room == 30 && con >= 1)
        {   if (saved(4, dex))
            {   room = prevroom;
            } else
            {   templose_con(anydice(1, 3));
        }   }
    acase 31:
        if (dice(1) <= 4)
        {   room = 49;
        } else
        {   room = 73;
        }
    acase 32:
        dropitem(500);
        dropitem(507);
        create_monster(248);
        fight();
        award(250);
        room = 66;
    acase 33:
        create_monster(256);
        do
        {   oneround();
            if (evil_damagetaken >= 1)
            {   dispose_npcs();
        }   }
        while (countfoes());
        if (con >= 1)
        {   award(30);
            room = 55;
        }
    acase 38:
        create_monsters(273, 6);
    acase 40:
        create_monster(257);
        fight();
        victory(900);
    acase 41:
        if (getyn("Surrender (otherwise fight)"))
        {   room = 22;
        } else
        {   // %%: are we allowed to kill Gorghasty?
            good_takehits(40, TRUE); // %%: is this meant to happen on the first round, or before that?
            create_monster(264);
            create_monster(265);
            create_monster(266);
            create_monster(267);
            create_monster(278);
            create_monster(279);
            create_monster(280);
            create_monster(281);
            fight();
            award(404 + 178);
            give_gp(350 + 135);
        }
    acase 43:
        if (prevroom != 43)
        {   gain_flag_ability(64);
        }
        mw_wandering(TABLEA);
        if (!ability[64].known)
        {   room = 133;
        }
    acase 44:
        good_takehits(dice(2) + 5, TRUE);
    acase 48:
        fight();
        award(150);
    acase 49:
        if (!saved(6, dex))
        {   templose_con(misseditby(6, dex));
        }
    acase 50:
        if (prevroom != 14)
        {   give_multi(502, 10);
            give(501);
        }
    acase 51:
        award(100);
    acase 52:
        mounted = 0;
        create_monster(258);
        fight();
        room = prevroom;
    acase 56:
        give(507);
    acase 57:
        die();
    acase 58:
        savedrooms(3, iq, 142, 31);
    acase 59:
        if (saved(3, iq))
        {   room = 45;
        }
    acase 60:
        if (saved(2, lk))
        {   create_monster(271);
            create_monster(272);
            good_freeattack();
            fight();
            award(76);
            give_gp(64);
            room = 27;
        } else
        {   room = 107;
        }
    acase 61:
        create_monsters(259, dice(1) + 2);
        fight();
        room = prevroom;
    acase 64:
        die();
    acase 65:
        if (ability[64].known)
        {   die();
        } else
        {   room = prevroom;
        }
 /* acase 68:
        %%: how much does a beer cost? We assume nothing. */
    acase 69:
        if (prevroom != 69)
        {   mw_wandering(TABLEB);
        }
    acase 70:
        if (!saved(2, st))
        {   room = 10;
        }
    acase 71:
        if (!saved(3, lk))
        {   mounted = 0;
            if (!saved(3, dex))
            {   templose_con(dice(1) + 6);
        }   }
        room = prevroom;
    acase 72:
        if (maybespend(1, "Pay 1 gp"))
        {   room = 129;
        } else
        {   room = 3;
        }
    acase 73:
        if (saved(5, st) || saved(5, st) || saved(5, st))
        {   room = 114;
        } else
        {   room = 1;
        }
    acase 77:
        create_monsters(260, dice(1));
        fight();
        room = prevroom;
    acase 78:
        if (dice(2) >= 9)
        {   room = 62;
        } else
        {   mw_wandering(TABLEA);
        }
    acase 81:
        create_monsters(261, 6);
        fight();
        savedrooms(2, iq, 119, 44);
    acase 82:
        savedrooms(3, iq, 59, 1);
    acase 83:
        result = dice(1);
        create_monsters(262, result);
        if (!saved(level, chr) || getyn("Fight"))
        {   fight();
            for (i = 1; i <= result; i++)
            {   give_sp(dice(1) * 6);
        }   }
        else
        {   dispose_npcs();
        }
        room = prevroom;
    acase 84:
        create_monster(263);
        fight();
        give_gp(300);
        room = prevroom;
    acase 85:
        award(300);
    acase 88:
        create_monster(264);
        create_monster(265);
        create_monster(266);
        create_monster(267);
        fight();
        award(178);
        give_gp(135);
        room = 16;
    acase 89:
        lose_flag_ability(64); // %%: do we need to pay him for this? We assume not.
        if (maybespend(1, "Give 1 gp"))
        {   healall_con();
        }
        room = prevroom;
    acase 91:
        savedrooms(6, lk, 116, 43);
    acase 92:
        give_multi(503, 10);
    acase 93:
        create_monsters(268, dice(1));
        fight();
        room = prevroom;
    acase 94:
        if (dice(1) == dice(1))
        {   room = 113;
        } else
        {   room = 45;
        }
    acase 95:
        result = dice(1);
        if (result % 2) // %%: we assume we are supposed to round up
        {   result = (result / 2) + 1;
        } else
        {   result /= 2;
        }
        create_monsters(269, result);
        fight();
        room = prevroom;
    acase 96:
        dropitem(500);
        dropitem(507);
        create_monster(249);
        fight();
        award(250);
        room = 66;
    acase 97:
        fight();
        award(150);
    acase 98:
        give(504);
        give(505);
    acase 99:
        if (mounted)
        {   mounted = 0;
        } elif ((armour == -1 || dice(4) > items[armour].hits) && !saved(5, lk))
        {   die();
        }
        room = prevroom;
    acase 100:
        give(506);
    acase 101:
        create_monster(270);
        do
        {   if (mounted && dice(1) <= 2)
            {   mounted = 0;
            }
            oneround();
        } while (countfoes() && con >= 1);
        room = prevroom;
    acase 103:
        pay_gp_only(gp);
        pay_sp_only(sp);
        pay_cp_only(cp);
    acase 104:
        if (dice(1) >= 9)
        {   room = 111;
        } else
        {   mw_wandering(TABLEB);
        }
    acase 107:
        create_monster(271);
        create_monster(272);
        fight();
        award(76);
        give_gp(64);
        room = 27;
    acase 108:
        create_monster(274);
        fight();
        give_gp(300);
    acase 110:
        give_gp(dice(1) * 100);
    acase 111:
        if (dice(2) >= 9)
        {   room = 128;
        } else
        {   mw_wandering(TABLEA);
        }
    acase 112:
        create_monster(275);
        fight();
        give_gp(97);
        room = prevroom;
    acase 113:
        dicerooms(5, 135, 135, 135, 135, 25);
    acase 115:
        if (mounted && !saved(2, dex))
        {   mounted = 0;
        }
        room = prevroom;
    acase 117:
        // %%: are we allowed to kill Gorghasty?
        good_takehits(40, TRUE); // %%: is this meant to happen on the first round, or before that?
        create_monster(278);
        create_monster(279);
        create_monster(280);
        create_monster(281);
        fight();
        award(404);
        give_gp(350);
    acase 118:
        if (saved(3, lk) && saved(3, lk) && saved(3, lk) && saved(3, lk))
        {   room = 16;
        } else
        {   room = 88;
        }
    acase 120:
        die();
    acase 121:
        // %%: it doesn't say whether we actually get the jewels or not; we assume so.
        lose_lk(dice(1));
        give(504);
        give(505);
    acase 122:
        if (mounted)
        {   mounted = 0;
        } else
        {   templose_con(dice(1));
            if (!saved(2, lk) && !saved(2, lk) && !saved(2, lk))
            {   die();
        }   }
        room = prevroom;
    acase 124:
        if (mounted && !saved(3, dex))
        {   mounted = 0;
        }
        room = prevroom;
    acase 125:
        give_gp(900);
    acase 126:
        savedrooms(3, lk, 51, 91);
    acase 127:
        create_monster(276);
        fight();
        room = prevroom;
    acase 128:
        if (dice(2) >= 9)
        {   room = 53;
        } else
        {   mw_wandering(TABLEA);
        }
    acase 131:
        if (!saved(1, lk))
        {   room = 28;
        }
    acase 132:
        if
        (   (both != EMPTY && isweapon(both) && items[both].magical)
         || (rt   != EMPTY && isweapon(rt  ) && items[rt  ].magical)
         || (lt   != EMPTY && isweapon(lt  ) && items[lt  ].magical)
        )
        {   room = 85;
        } else
        {   room = 75;
        } // %%: it doesn't say what to do if one is magic and the other is not
    acase 133:
        if (dice(2) >= 9)
        {   room = 105;
        } else
        {   mw_wandering(TABLEA);
        }
    acase 135:
        die();
    acase 137:
        dropitem(500);
        dropitem(507);
        create_monster(277);
        fight();
        room = 66;
    acase 139:
        savedrooms(2, iq, 79, 107);
    acase 140:
        if (prevroom != 140)
        {   mw_wandering(TABLEB);
        }
    acase 141:
        if (dice(2) >= 8)
        {   room = 72;
        } else
        {   mw_wandering(TABLEA);
        }
    acase 143:
        dicerooms(35, 110, 110, 110, 110, 92);
}   }

MODULE void mw_wandering(int whichtable)
{   TRANSIENT       FLAG ok;
    TRANSIENT       int  bestdistance,
                         bestwp = -1, // initialized to avoid spurious SAS/C optimizer warnings
                         i,
                         result1,
                         result2,
                         whichwp;
    PERSIST   const int  wr[2][12] = { { 47, 115, 15, 77, 30,  84, 13, 21, 71, 124,  52, 101 },   // Table A
                                       {  8, 127, 93, 83, 99, 112, 61, 95, 19,   7, 122,  64 } }; // Table B

    aprintf(
"RANDOM ENCOUNTER TABLES\n" \
"  To determine what you have met up with, consult the appropriate table (A or B) below. Roll 1d6 for your *first die roll*, then roll again for your *second die roll*. Go to the paragraph indicated, and resolve the situation described there.\n" \
"  Where it makes a difference, instructions have been given for mounted and unmounted situations. Once you have had a particular encounter, mark it on the table below. If the dice call for that encounter again, go to the nearest encounter (above or below it) on that table. Don't repeat encounters until you have worked your way through the entire list. (An encounter is not identical if you were on horseback the first time you had it, and have subsequently lost your horse.).\n" \
"  If you survive the encounter, return to the paragraph that sent you here and continue your adventure.\n"
    );

    ok = FALSE;
    for (i = 0; i < 12; i++)
    {   if (!wm[whichtable][i][mounted])
        {   ok = TRUE;
            break; // for speed
    }   }
    if (!ok)
    {   for (i = 0; i < 12; i++)
        {   wm[whichtable][i][mounted] = FALSE;
    }   }

    result1 = dice(1);
    result2 = dice(1);
    whichwp = (((result1 - 1) / 3) * 6) + result2;
    bestdistance = 12;
    for (i = 0; i < 12; i++)
    {   if (!wm[whichtable][i][mounted])
        {   if (abs(whichwp - i) < bestdistance)
            {   bestdistance = abs(whichwp - i);
                bestwp       = i;
    }   }   }

    whichwp = bestwp;
    wm[whichtable][whichwp][mounted] = TRUE;
    room = wr[whichtable][whichwp];
}
