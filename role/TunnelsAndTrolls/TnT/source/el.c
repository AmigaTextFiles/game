#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

// * paragraphs probably only exist in the expanded (dT&T) edition.

MODULE const STRPTR el_desc[EL_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  This solo adventure is meant to be played with [Deluxe ]Tunnels and Trolls. You begin by going to {1} and reading that paragraph. At the end of it you will have a number of choices listed that send you to other paragraphs. To maximize your enjoyment, only read the paragraphs to which you have been sent. This adventure is suitable for any single character with no more than 60 personal adds. Magic may be used in combat, or where specified by instructions in a paragraph.[ If your character has a talent that applies in a given situation, you can make a saving roll on that talent at the same level that is needed for the attribute in that paragraph. Remember that humans are allowed one reroll on a failed saving roll (but not a critical fail).]~"
"INTRODUCTION\n" \
"  Welcome, welcome, esteemed visitors, to the port city of Gull. Located at the southern end of the island of Phoron. You've heard many wondrous and a few notorious tales of \"the City of Terrors.\" While the city's glories cannot be overestimated, its dangers always are.\n" \
"  It is true, of course, that the city was founded at the Cial River delta, by the pirates known as the Rangers. The waters around Phoron are known as the Range Sea, though the founders were blown off course through a powerful storm and onto the shores of the island. They found a good, deepwater harbour here, as well as ample supplies of fresh water, fruit and game. Phoron largely escaped the ravages of the Wizard War, resulting in its being pristine when the pirates found it. There are even unspoiled preserves further north.\n" \
"  The Rangers named their settlement Gull, in honor of the ship which had brought them to Phoron. They improved the harbour and soon pirates of all stripes enjoyed trading here. The harbour's narrow approach channel, warded as it is by spits of land on each side and fortresses at the end of each, frustrated attempts to destroy the pirates. Fair winds encouraged maritime trade, hence the city's prospering and growth as a trade centre.\n" \
"  Now you are on the Isle of Phoron and your adventure begins in Gull. Enjoy your stay and be careful..."
},
{ // 1
"It's another boring day in Gull, aka the City of Terrors. No one's been murdered (at least not within earshot of you) for the last half hour, and the perennial pirate raids, though much feared, are late again. You yawn and pull on your boots, wondering what to do. If you think venturing out of the city and into the jungles surrounding it is a good idea, go to {239}. If you actually think some sort of gainful employment would help pass the time, go to {41}. If you are someone looking for a quick profit and don't mind which side of the law you work to make it, go to {61}. If you are determined to walk on the wild side, and undertake a course of self-improvement, head to the Royal Library at {131}."
},
{ // 2
"As you leave the room, you suppress a laugh. Being connected with the Rangers, you know all about the invasion plan. You go out and select some helpless humgruffin and frame him as the spy. You kill him, and bring him in to collect the reward. They pay you 2500 gold pieces and give you the pardon; this was good for 50 adventure points. You find that very funny; after all, you are the spy..."
},
{ // 3
"You fall right in and work silently along with the other men there on the docks. The work is hard and heavy. No one says much, but the few snatches of information that you glean from conversations seems to indicate that there will be a big payoff in the near future for all the people working on the docks.\n" \
"  You continue working for a week. You notice small instances of pilfering, but nothing major. At the end of the week, just before you are ready to quit for the day, a bunch of city guardsmen show up on the dock. All of your fellow workers grab clubs and loading hooks; a fight seems unavoidable. Make an L4-SR on Luck (35 - LK). If you make it, go to {43}. If you miss it, go to {113}."
},
{ // 4
"The stones fall from his long-fingered hand and he looks excited. \"Lucky dog, do I see. Elven Lords soon be free!\" On this adventure, subtract 1 from the level of any saving roll[, 10 from the Monster Rating of any monster, and you may reroll 1 saving roll that you fail]. Go to {12}."
},
{ // 5
"In you hand you have a magic 5 dice + 4 adds sword. You twist the hilt and find Token #3. Go to {24}."
},
{ // 6
"\"No more talk,\" says the captain. \"We know what you are doing out here. You know that smuggling Demregh-mno into Gull is a crime punishable by death. (Al-Dajjal didn't happen to mention that to you, by the way.) Aid us in getting the man you work for, or I'll kill you where you stand.\"\n" \
"  If you decide to help them, go to {26}. If you don't, the harbour fishes feed well tonight."
},
{ // 7*
"Your attack, which can best be described as irresponsibly rash and foolhardy, takes the gargoyle by surprise. The battle carries the creature off the balcony and plunging down to the darkened alley below. The two of you tussle, roll through the air, and careen off alley walls. You land hard. You and the gargoyle each take 3d6 falling damage. (Roll and apply separately.) The Gargoyle has an MR of 45, from which you deduct the damage. Then kill it. If you succeed, go to {195}."
},
{ // 8
"The theft goes off like clockwork. As all of you are huddled in the warehouse splitting the take, the city guard burst in. Morgo commands everyone to fight, and then ducks out the back. You follow and announce he is under arrest. He offers you a bribe or a fight. To fight, go to {202}. To accept the bribe, go to {36}."
},
{ // 9
"You find your mind detached from normal concerns and floating well above and away from the mortal plain. Your body is no longer your own, for the creature owns it. Someday, however, you vow you will break away and flee down the path toward the standing stones. There you will see if the elven warrior is as good as his promise, and if you can wind the freedom you could not grant the Elven Lords."
},
{ // 10
"\"You wouldn't want me spreading the word that you trade with Rangers, now would you?\" you ask him, gambling a great deal.\n" \
"  He breaks down. \"They have my daughter. Unless I give them plans, they will kill her.\" He continues to explain they are going to make the exchange tonight. You suggest that you will follow and free his daughter while he hands the Rangers plans you will doctor. Both of you work on the plans until midnight when the meeting is due. If you want to run ahead and wait at the meeting place, go to {80}. If you want to shadow him, go to {40}."
},
{ // 11
"The Kraken's Cave is packed with sailors, harlots and servants of every size, race and description. You're smart enough to have changed from street clothes into something vaguely appropriate for your surroundings. But with this crush of people, you've got no idea how to handle your investigation. If you'd like to raise a glass in toast to the Rangers, go to {92}. If you'd like to curse them aloud, go to {148}."
},
{ // 12
"As you step down the path toward the City, you pause and turn to the warrior. \"Why are you here?\" you find yourself asking him.\n" \
"  He gives you a grim, frank stare. \"Because if it does to you what it did to the other champions, I promise to slay you before you can do any harm. It is the least I can do.\n" \
"  His promise, ringing in your ears, is a cold send-off. You feel chills run down your spin, but that feeling fades as the unreal quality of the City of Peace overtakes you. While you can feel the ground solidly beneath your feet, you sense you are indeed walking between worlds. Subtle changes mark the border zone between your world and the Elven Haven. While you see no one else, you hear the breeze coax sibilant whispers from the foliage and can imagine it as elven comments and well-wishes.\n" \
"  You see the building in the centre of the City. At the westernmost corner of the build you see a hole dug down into the ground. If you want to investigate it, go to {68}. If you want to enter the place through the massive arched doorway, go to {48}. If you want to bellow out a challenge to the monster, go to {107}."
},
{ // 13
"You come to a small grotto with a lake. Before you is one sword in shards; nearby are an anvil and fire. Beyond that is a second sword firmly stuck in stone. Lastly, in the middle of the lake, a sword is being held out of the lake by a feminine hand. If you wish to repair the first sword, go to {52}. If you want to obtain the second, go to {33}. If you want to try for the third sword, then go to {102}."
},
{ // 14*
"The Head Librarian has selected for you a slender, black-bound volume. The binding feels like leather, but also makes your skin crawl. The title appears to have been clawed into the cover. It is This Is Going To Hurt You More Than It Will Me. It is the world's foremost guide in desperation and dirty-fighting techniques.[ It shows you all the things you need to know to inflict maximum damage on your foes, but there is a good change you can hurt yourself in the process.\n" \
"  From this point forward, whenever you feel desperate enough to use these tactics, you can add up to five (5) dice to your weapon roll. If any dice come up with a 1, set them aside. Add the others to your combat roll and proceed normally. Then reroll the 1s, add them up and multiply them by your level number. Take that much damage, with no armour protection. (In using a desperation tactic you opened yourself to getting hurt, and you did.) (Example: You use 5 dice and roll 1,1,2,5,6. You'd add 13 to your combat roll. Then you'd reroll the pair of 1s: getting a 3 and 4. That totals to 7. Because you're second level, you'd take 14 hits with no armour protection.]\n" \
"  You wander out of the library thinking you're not sure you're the toughest person on the block, but you'll hurt anyone wanting to hurt you. Which, as an adventurer, is not a bad thing. Congratulations."
},
{ // 15
"The spy has a Monster Rating of 48. If you kill him, go to {144}. If you are defeated, it appears your adventure is at an end. Find or create a new character and revisit Gull. Maybe you will have better luck next time..."
},
{ // 16
"The City Guard waylays you as you are leaving the docks. They know who you are, but Diamondfist was getting worried about your lack of communication with him. If you make an L4-SR on the average of your Intelligence and Charisma (35 - ((IQ + CHR) ÷ 2)), the City Guard will believe you are still working undercover and that you didn't want to blow your cover. Go to {115}. If you fail the roll, go to {76}."
},
{ // 17
"Torture has some lasting effects. Your Charisma falls by 50% of the damage you took during torture. Your DEX will be down 25% permanently for damage to your hands and arms. However, you are alive. This adventure was worth 2000 adventure points for you."
},
{ // 18
"The Klorven elders explain that the Klorven, for centuries upon centuries, have maintained a special relationship with the Elves who live on the island of Phoron. Part of the reason they were pleased with you doing as well as you did is that the Elves are in need of someone with your talents to help them. If you are willing to take on this mission to help the Elves, go to {101}. If not, the way to Gull is clear and you are done."
},
{ // 19
"This is the end of the Tribe leader journey. If you have less than 4 Tokens, go to {209}. If you have between 4 and 6 Tokens, go to {69}. If you have all 7 Tokens, go to {89}."
},
{ // 20
"Even though you lost your fight, the guards who were alerted by the sound of it have entered the room and killed the spy. The ball, however, falls and breaks on the ground. Your mission has been a success, and you get 275 adventure points for it, as well as the 2500 gold pieces for the dead spy. You are done."
},
{ // 21 %%: they must mean "round" where they say "turn", so we have amended it accordingly
"Setting the magazine on fire will definitely result in the tower coming down. Roll 2d6. That's the number of combat rounds before everything explodes. That's the good news.\n" \
"  Bad news: Orcish troops attack down into the dungeon. Roll 1d6+2. That's the number of MR 15 orcs you face. Plus, those worker orcs, terrified of losing their lives, join in on the attack. It's going to take you one round to get out of the tower, so for each round of combat, deduct one from the countdown to explosion. If you have at least one round to get out of the tower, go to {203}. If you cannot escape, go to {178}."
},
{ // 22
"As you stoop over him, you notice two things. The first is that his throat has been torn up by the garotte used by the spy, but he is still breathing, barely. The second thing you notice is a bunch of guards who have come up and are surrounding you.\n" \
"  If you wish to kneel and try to revive the guard with some first aid or a Restoration spell, go to {242}. If you run off to pursue the spy, go to {34}. If you stand and try to command the guards to go after the spy with you, go to {55}."
},
{ // 23
"It is your unfortunate luck that one of the men on the work crew noticed you talking to Diamondfist. The men close about you, drawing daggers; they threaten to torture the life out of you. There is one man between you and the door. He has an MR of 100. If you can kill him in three combat rounds or less, you escape to {104}. If you don't manage to defeat him in that amount of time, you are captured and taken to {173}."
},
{ // 24
"After a short twisting tunnel you come to a broadening of your path. Before you is a wizard. He wears a dirk (2 dice + 2) and has a Constitution of 12. Roll one die to see what spell he casts. Compute damage to your or his advantage against you, then fight.\n" \
"    1) Take That You Fiend - (13 points off your CON)\n" \
"[    2) Enhance - (his dirk is now 6 dice + 6)\n" \
"    3) Concealing Cloak - because you can't see him, his combat total is doubled.\n" \
"]    4) Panic - if your Strength, IQ and Charisma total less than 36, go to {78} in panic.\n" \
"[    5) Delay - because you're slowed down, multiply his combat total by 1.5.\n" \
"]    6) Blasting Power - take 3 dice worth of hits.\n" \
"If you kill him, take Token #4 from his body and go to {78}. If he kills you, your adventure is over."
},
{ // 25
"As you attack from behind, you hear someone say, \"I knew he was a plant!\" You find yourself ringed with dockworkers. Two, with MRs of 55 each, block your path to freedom. If you can defeat them in two combat rounds, go to {104}. If you fail in your fight, one of the men throws a bola and it entangles you. The men carry you into a warehouse - go to {173}."
},
{ // 26
"You note something vaguely familiar about the captain of the patrol boat, but you cannot seem to place him. He secretes himself aboard your boat and you sail to the boathouse where you were to meet your connection, the infamous Al-Dajjal.\n" \
"  As you enter the boathouse, you notice that Al-Dajjal is accompanied by three men with light crossbows. If you wish to betray the captain of the patrol, go to {46}. If you wait for him or Al-Dajjal to make a play, go to {66}. If you want to attack Al-Dajjal, go to {86}."
},
{ // 27
"Your bleeding has attracted a large shark (MR 40). [You can only use a dagger or magic to fight it. ]If you kill the shark, go to {45}. If the shark kills you...well, better luck next time."
},
{ // 28
"You ditch the boat and make your way toward one of the gates in Gull. In a dark alley, two men reach you. Make a first level saving roll on Dexterity (20 - DEX). If you make it, go to {117}. If you miss, go to {97}."
},
{ // 29
"While they wanted no violence in City of Peace, the Elves did not leave their crypt unguarded. The trapdoor delivers you into a pit approximately 15' deep, and water gushing in from the mouths of 3 gargoyles instantly begins to flood the place.\n" \
"  To find a way out, make a third level Intelligence saving roll (30 - IQ). If you make it, go to {58}. If you miss it, make a second level Con saving roll (25 - CON), taking damage equal to what you miss the roll by. Repeat the cycle of IQ and CON rolls until you figure a way out, or drown."
},
{ // 30
"Congrats. For each dead spy you get 2500 gold pieces and for each live one you get 1000 gold pieces. Any you didn't directly engage in combat escaped and don't count towards your total. Your adventure points for this adventure total 350 and you have saved the City. Well done. If you want to try another adventure, go to {1}."
},
{ // 31
"As you walk through the darkened streets toward the Palace, you manage to see the shadowy form of a man silhouetted against one of the rising moons. You run toward the Palace wall even as you see his shadow meld with that of a guard. You cut up the hill and hear a strangled cry from the guard, then a thud as his body hits the catwalk of the wall. You quickly reach the wall and scurry up with the rope left behind by the spy. Once over the wall, you see the body of the fallen guard and the wisp of a shadow entering a window on the second floor.\n" \
"  If you would like to see if you can help the guard, go to {22}. If you wish to climb the trellis and pursue the spy, go to {72}."
},
{ // 32
"\"Scry the future, I will, I will. If you want a look, pay me bill!\" it cackles. If you want to toss it a gold coin, keep reading. If you want to consider some other form of payment, make a L3-SR on Intelligence (30 - IQ). If you make it, go to {94}. If not, toss him a gold coin and keep reading, or just head off on the mission by going to {12}. To simulate the reading of the fortune stones, roll 3 dice and check the paragraph appropriate for the results you get below:\n" \
"  If you roll triples, go to {4}.\n" \
"  If you get any pair of numbers, go to {44}.\n" \
"  If all your numbers are 3 or below, go to {64}.\n" \
"  If all your numbers are 4 or above, go to {74}.\n" \
"  For any other result, go to {83}."
},
{ // 33
"The stone begrudgingly gives up the sword. Make a saving roll at your own level on Constitution to see if you have the endurance necessary to keep pulling the blade from the stone. If you make the roll, go to {5}. If you don't, take the number you missed by in hits to your CON (ain't having a hernia hell?), then go swordless to {24}; the other swords have disappeared."
},
{ // 34
"\"Halt, dog of a murdering spy!\" one of the guards warns in a low voice. You protest your innocence, but they haul you off. Luckily for you the guard lives and the old Captain testifies at your trial. However, the spy escapes capture, although evidence of his passing is present the next morning.\n" \
"  You get paid 1000 gold pieces for your efforts. This was also worth 150 adventure points for you. Your failure was not really your fault, but convincing the Captain of that is not easy. As it is, his offer of 1000 gold pieces is quite generous and you accept it graciously."
},
{ // 35
"With four books under your belt, you are an acknowledged expert, with world-wide renown. [For any adventure where you can apply the knowledge from any of your books, you get an added 10% to experience for the adventure. Party members get an added 5%. Plus, your knowledge makes you all but prescient so you, or anyone in your party, may re-roll one failed SR. (One per party per adventure/day.) ]Congratulations! This was worth 1500 APs, plus your 150 point bonus."
},
{ // 36
"You split the gems and run off down the alley. Blocking your path you find your employer. \"Treacherous dog. This will be your reward!\" Mingor casts an Icefall spell. It does 9 dice plus 176 points of damage. If you survive it, or have a kris (dagger) that deflects magic, go to {183}."
},
{ // 37
"(You were captured, but you thought of a way out.) You walk up to Diamondfist as he enters the room and say, \"I've got the evidence, and I'm ready to testify.\" He smiles and claps you on the back. You don't remind him that you have 3 dice times 500 gold pieces worth of gems from the shipment hidden on your body. He pays you the 5000 gold pieces reward money. You are done. This adventure was worth 1500 adventure points."
},
{ // 38
"You find 150 gold pieces on their bodies. You also pick up the magic dagger (a dirk 2d+2) that they tried to use on you. When thrown, if it does at least one hit of damage on your target, it will paralyze the target for three combat turns. This effect will only work on living things, and only those of flesh and blood (no undead or stone creatures). You are done, and have earned 1000 adventure points."
},
{ // 39
"You noted that they had daggers. You burst free of the crowd. One warrior, who has MR of 30, still stands between you and freedom. Kill him and gain the exit along with Token #7. Go to {19}."
},
{ // 40
"Two Rangers hustle the Merchant off before he can get to the meeting place. It is lucky that you decided to tail him instead of going on ahead. They obviously saw you talking to him. Soon they are joined by a third man. The maps are exchanged for the daughter, who arrived in the company of the third man.\n" \
"  If you wish to wait and escort the Merchant and his daughter back to their home, go to {60}. If you want to take on the Rangers, go to {123}."
},
{ // 41
"You step from the carriage that has carried you from the central square in Gull. The day is bright and sunny, the sea breeze tugs playfully at your cloak. As your transport leaves, you turn to a signpost on the docks to see if any ships are leaving for your home port. You find none, but you notice a job-wanted poster from the Knor-East Phoron Company. As you read it you know the job was meant for you.\n" \
"  You make your way to the company office. Beside the dock in front of the office is Mingor Diamondfist's ship Nightwind. You turn from looking at that ship and discover its owner standing beside you. \"You came to answer our job-want, didn't you?\" he asks. You say yes and he invites you into the office.\n" \
"  \"We've been having things lifted from the docks,\" he tells you. We need a stranger to investigate this situation.\" He promises to pay you 5000 gold pieces if you catch the thieves.\n" \
"  You show up the next day on the docks. Make a third level Intelligence saving roll (30 - IQ) or a fifth level Luck saving roll (40 - LK), your choice. If you make it, go to {3}. If you fail, go to {23}."
},
{ // 42*
"The thing about these goblins is that they can be quite industrious. They use that trap door to send things, like dead bodies, down into the basement where they have a crew that takes those things apart. Bones are good for fertilizer, leather is leather, folks losing teeth need dentures, and meat, well, did you really look closely at what was in that last meat pie you ate?\n" \
"  Take damage equal to the number you missed the saving roll by. That comes from the various sharp edges on the chute you ride into the basement. Then you'll face the number of goblins you missed the saving roll by, each of them with MR 20. If you win, take 2d6 gold and crawl out of the basement. Your day is done.\n" \
"  And if you die, rest easy. Because of you, an orphan won't go hungry tonight."
},
{ // 43
"If you wish to join the City Guard and turn on your fellows, go to {193}. If you want to fight with your men against the City Guard, go to {93}."
},
{ // 44
"The stones clatter and click as they spell out a strange pattern. \"Luck is with thee, but dark I still see.\" [Because of this roll you may subtract 5 from the Monster Rating of any monsters you face in this adventure. Also, in one combat, you can have a bonus of 1 die for that combat's duration. ]Go to {12}."
},
{ // 45
"The shark floats belly up in the boathouse. You find yourself alone. There is no gold, nothing. Hoping for anything, you haul the shark onto the deck and open up its stomach (remembering that sharks eat anything).\n" \
"  In the shark's stomach, you find a dagger (a sax 2d+4). When you touch it, it bursts into flame, which doubles the dagger's roll. Happy, you sheathe it and leave. You have gained 1700 APs and are done."
},
{ // 46
"You tear the tarp back from where the captain had been hiding. There is no one to be found! You turn toward the landward door just in time to see it burst inward as a result of sorcerous flame. Someone from beneath your boat grabs your belt and hauls you overboard.\n" \
"  You must make a second level saving roll on Constitution (25 - CON) to see if you inhale any water. Take the number you missed your SR by in hits.\n" \
"  The warrior from beneath the boat has an MR of 50. You must fight him underwater[ with a dagger or your bare hands]. For each combat round make a L2-SR on Luck (25 - LK) to see if you can come up for air. For each combat round you miss the Luck saving roll, make a Constitution saving roll on a progressively higher level (third, fourth, etc.) as you are drowning. (The level resets to second after you get a lungful of air.)\n" \
"  If you win your fight, go to {248}.\n" \
"  If don't win, you drown in the dark waters."
},
{ // 47
"Make a second level saving roll on Luck (25 - LK) for each 1000 gp (four total). If you miss the first, subtract 1000 gps from your total. If you miss the second, take 2000 from your total and so on.\n" \
"  Your take is not all that it might be, because anyone that makes money on the darker side of Gull will face Marek at one point or another. 4000 gps is not a prize that master thief will pass up.\n" \
"  After making or missing the saving rolls, you are done. This trip has been worth 1000 adventure points."
},
{ // 48 & 48A
"Through the doorway you find an incredibly beautiful place in which you know you could rest content, were you slain today. Rows upon rows of intricately carved tombs with lifelike effigies worked into them fill the room. Disturbing them, however, is the fact that half the stone sarcophaguses have been torn open and their contents scattered about the room.\n" \
"  In this incredibly beautiful place, you need to make a third level Dexterity saving roll (30 - DEX). If you succeed, you nimbly jump aside as a trapdoor beneath your feet snaps open and closed. If you missed it, go to {29}. If you made it, you return outside and can either examine the hole at the edge of the building by going to {68}, or bellow a challenge to the defiler of this place to meet in combat by going to {107}."
},
{ // 49*
"The assistant librarian, looking rather embarrassed, brings you a book which is so beat up it looks as if it was used to batter a minotaur to death. It's a volume in the infamous Secrets They Don't Want You To Know series. It's a collection of scurrilous rumours, half-forgotten historical anecdotes and often pure fabrication. Poorly written, it's somehow fascinating.\n" \
"  Roll 2d6 to see which volume you got:\n" \
"     2 = Elves\n" \
"     3 = Nobles\n" \
"     4 = Wizards\n" \
"     5 = Dwarves\n" \
"     6 = Dragons\n" \
"     7 = Infamous Cities\n" \
"     8 = Hobbits\n" \
"     9 = Demons\n" \
"    10 = Elder Gods\n" \
"    11 = Pirates\n" \
"    12 = Lost Kingdoms\n" \
"As atrocious as much of this is, there are kernels of truth buried in there.[ Because of what you've learned, whenever asked to make a saving roll that you can even vaguely connect to the area of your expertise, you can drop the saving roll by 2 levels.]\n" \
"  Very well done, you've definitely improved yourself. Oh, and by the way, the warnings in the books about the subjects seeking out and killing those who \"know too much\" are probably false. Seriously, you should not be concerned at all about that. But, hey, would you mind not sitting so close, you know, in case they miss you..."
},
{ // 50
"You burst around a corner and smash into the group of men your quarry had gathered with hand signals to waylay you. You scatter them, half-falling unconscious from impact between you and the walls of the alley. You smash one in the face and spin another into a wall. They are down, but your quarry waits in the cul de sac beyond. He has a Monster Rating of 30. If you kill him, go to {30}. If you don't kill him - he kills you."
},
{ // 51
"Before you stands a warrior with a club. He laughs when he sees you are unarmed. He moves slowly however, and you know if you are agile enough, you can get under his swing and deliver your hits without taking any in return. To do this, you must make a second level saving roll on your Dexterity (25 - DEX). In any combat round where you miss your roll, you must fight normally. The warrior gets 4 dice and 17 combat adds; he has a Constitution of 15.\n" \
"  If you kill him, take Token #2 from his body and go to {13}."
},
{ // 52
"This is the Sword That Must Be Reforged. However, as you have no hammer, you must pound it out with your fists. Make a saving roll at your own level on Constitution to see if you can stand the pain of the fire and hammering. If you make the roll, go to {5}. If you don't, take the number you missed by in hits to your CON (bruises and minor burns), then go swordless to {24}; the other swords have disappeared."
},
{ // 53
"In your boat you have 100,000 gold pieces worth of the golden dust. Roll one die - the number you roll is the number of MR 60 assassins your connection sends after you. If you roll a one, a magicker with an MR of 20 is sent after you. He will attack using two Take That You Fiend spells, each doing 14 hits of damage.\n" \
"  If you manage to kill your assassin(s), you net 3000 APs and 75,000 gold pieces. (You had to sell cheap, no one wanted to touch the stuff.) You are done."
},
{ // 54
"You wriggle free of your bonds and stand. A hellish light plays in your eyes. You snarl and crush the life from a rat with your bare hands. You kick your way to the wooden ladder set into the wall. As you reach the top you find the warehouse deserted. Quickly, you escape.\n" \
"  Cut, grimy, bleeding, you make your way into Diamondfist's office. You tell your story, and he dispatches a messenger to the City Guard barracks nearby. They rush out and collect the gang for attempted murder. Diamondfist has a wizard heal you. He pays you the 5000 gold pieces, and a bonus of 10 times the number of hits you took from the rats in gold pieces. He also gives you a dagger worth 2d6, so you can get safely back home. You are done, and this adventure was worth 750 adventure points."
},
{ // 55
"The guards rush into the building through the lower floor while you go up the wall. At the window, you hear sounds of fighting. Inside you see the spy locked in a swordfight with Prince Arion, the 14 year old Prince of Gull! Even as you watch, the Prince slips and the spy poises himself for a death blow. If you merely stand and watch, go to {79}. If you shout and attack, go to {99}."
},
{ // 56*
"You have managed to slay a rather notorious book thief (and part time editor). The library is overjoyed because there were many valuable volumes hidden in the pockets of his cloak. You can calculate your reward by looking at {105} and rolling two dice. Do not go to the paragraph indicated, just write down the number. (For example, 236.) Add a zero to the end. (Example: 2360.) Your reward becomes 23 gold and 60 silver. It's a tidy little sum for you to take home. Congratulations."
},
{ // 57
"You are neither lucky or bright. The building was surrounded and you were captured. Roll 3 dice and multiply by 1000. This is the price in gold pieces that the Gull Municipal Court sold you for to a slaver. He moves you north and forces you to fight in the Arena of Khazan. [You will fight until you have won twice what he paid for you. At that time you will make a Luck saving roll on your level to see if he wants you to fight more. If you miss, fight until your total winnings are three times the price paid for you. Continue until you make the roll or die. ](If you don't have Arena of Khazan, this character is enslaved forever, or until you get Arena of Khazan and fight your way to freedom). [Once you make the saving roll, of course, your character is freed and given 1000 gold pieces. ]This trip was worth 1200 adventure points for you."
},
{ // 58
"You know, if water is flowing into the pit, air has to be going out somewhere. To get buoyancy, shed your armour and shield. As the water floats you up, you locate a false panel. You pry it loose and slither out onto a narrow ledge above a dark hole dug beneath the building's foundation. In that hole, something is crawling about and you know this is the thing you're after. You attack from ambush. Calculate your full damage and go to {88} to apply it to the creature there."
},
{ // 59
"You failed to notice they all had daggers. As happened to Julius Caesar (and others before and after him), they turn on you. You are stabbed to death just as you stagger across the finish line - giving that concept a whole new meaning."
},
{ // 60
"Your return home with them is uneventful, but the merchant is grateful nonetheless. He gives you a magic dagger[ that will allow you to unerringly trail one person no matter where that person goes]. This adventure has been worth 275 adventure points for you. You are now done."
},
{ // 61
"Gull, the largest city on the island of Phoron in the Range Sea, is definitely a centre of trade. There are some items (read: contraband) that have to be brought into the city on the sly. Local politics, you understand. Still, good money can be made doing bad things, so you look with favourable interest upon an offer to smuggle drugs into Gull.\n" \
"  Your part in the operation is to take a small boat through the harbour to a boathouse, at dusk. Al-Dajjal, your employer, tells you that the job is worth 1000 gold pieces. His men would do it, but they are known to the men in the patrol boats.\n" \
"  You ride to the northeast of Gull and are supplied with a small boat laden with three bales of Demregh-mno, a golden drug that is magical in its effects and devastating in its aftermath. You pilot the boat around the end of Phoron, and as you enter the harbour, a patrol boat heads in your direction. With luck it may pass you by. Make a second level saving roll on Luck (25 - LK). If you make it, go to {171}. If you miss it, go to {213}."
},
{ // 62
"\"Your Elven heritage presents something of a problem, but it can be overcome, if you wish to take a chance.\" From beneath her rosy cloak, the female draws a golden cord approximately 4' long. \"If you can bind the creature with this rope, you will have vanquished it and it will be teleported from the City of Peace. If you choose not to take this chance, you are excused from service with no blot on your honour or suggestion of cowardice.[ If you accept, however, know that you may use no weapon other than this rope while in the City.]\"\n" \
"  The rope is worth 4 dice in combat. If you accept the mission, you will have to leave all of your other weapons here before you go to {12}. If you decline, you may head back to Gull and go to {1}."
},
{ // 63*
"For reasons known only to you, you chose to head out - how to put this charitably - the long way. You come to question this strategy when the intestinal walls begin to undulate and pulse. You hear a rumbling, rather rhythmic, almost like snoring, and the walls begin to pulse harder. The footing becomes slick. About the point where you decide to go back up the way you came, the walls close in. The rumbling grows. Make a L3-SR on Luck (30 - LK). If you succeed, go to {244}.\n" \
"  If you fail, you, rather quickly, complete your journey through the dragon's bowels. Had you not passed out because of the noxious atmosphere, you'd have marvelled at these huge bacteria that ate their way through your armour, reducing it to steel wool, which is, for a dragon, what bran fibre is to us. Please take solace in the knowledge that your contribution to recycling means that there will one day be a tree which has been properly fertilized, that will shade your descendants, and they'll sit in that shade and wonder what ever became of the one they call, \"that one, the mad adventurer.\" You are now dead. Maybe you can go to the Abyss solo in the dT&T rulebook and try to win your life back."
},
{ // 64
"The fortune stones rattle around in his fist, then drop to the ground in an inconclusive pattern. \"Light and dark, life and death. Choices, choices, blood and tears.\"\n" \
"  [Because of this reading you're granted one combat round bonus of an extra die in a single combat. ]Go to {12}."
},
{ // 65
"As you move towards the guardsmen, dagger ready, you notice that they are not guards. They are just other dock workers. \"We arranged this farce attack to weed out stool pigeons. You're all right, kid,\" someone tells you. You are completely trusted now. Go to {222}."
},
{ // 66
"\"Kill the scum,\" says Al-Dajjal, pointing at you. Make a second level saving roll on Luck (25 - LK). If you make it, you managed to dive overboard. Go to {116}.\n" \
"  If you missed, roll one die and divide by 2 (round up for odd numbers). That is the number of light crossbow bolts that have hit you. Figure the damage at 3 dice per bolt and, if you live, go to {27}. You have pitched over into the water."
},
{ // 67
"This drug, Demregh-mno, is decidedly nasty. [It will add 1/4 to your IQ and 1/2 to your Constitution. ]Each dose [will last 6 hours, and ]costs an average of 50 gps.[ Once you use the drug, because it is only slightly less addicting than crack cocaine, you are hooked forever. After a dose wears off, if you fail to use it again immediately, you will permanently lose half of your old CON and l/4th of your old IQ. (Your IQ and CON will not regenerate on their own, and you can only recover the lost points with level adds, or with attribute changes from a dungeon trip.)]\n" \
"  Every time you use the dust (which is inhaled or smoked) roll two dice. Snake-eyes means that the drug was cut with poison or is actually too pure for you to tolerate. Take five dice of hits on your CON. [Since the dust is magical, no spells like Too-bad Toxin or Healing Feeling work to repair the damage from bad doses or withdrawal from addiction. ]Good luck. You are done. This trip was worth 1500 aps."
},
{ // 68
"The hole is rather large and, from the scratches gouged out of the marble blocks used in the building, you can tell whatever dug it had very sharp talons and a lot of strength. You can peer all of 4' into the hole before utter darkness renders your vision useless.\n" \
"  Make a second level saving roll on Speed (25 - SPD). If you make it, you avoid the clawed paw that reached up out of the hole seeking to drag you down. In that case your choices are to dive into the hole, {88}, or to use the front door to enter the building, {48}. If you missed the saving roll, you take damage equal to what you missed by and find yourself dragged down into the hole. Go to {88}[, but chop your first combat round's total in half because of surprise]."
},
{ // 69
"While it is plain that you are not their king, you are at least a minor hero. They respect you and allow you to keep any booty from the cave. You may return to Gull, they say, but before you do so, they ask you to consider accepting a mission that is both dangerous and terrifying. If you wish to accept this mission, go to {18}. If not, you may return to Gull at {1}."
},
{ // 70
"They lost their last king of legend this way. Many warriors block your path. Roll 1 die for how many there are; they each have Monster Ratings of 30. If you can cut them down you may go back to Gull. Your only other choice is to die...(If you win free and return to Gull, go to {41} if you are desirous of gainful employment.)"
},
{ // 71
"Make a second level saving roll on Strength (25 - STR). If you make it, go to {111}. If you miss, take the number missed by in hits on your CON, then go with bruised and mashed fingers (but otherwise empty-handed) to {51}."
},
{ // 72
"The window opens into the War Room of the Palace. On the table in the centre of the room, you see a scale map of Gull with small figures of men representing the defences of the city. You also see the spy standing over it, holding a glowing blue globe above his head. In the globe you see the face of a wizard.\n" \
"  If you would like to attack the spy, go to {15}. If you wish to wrestle for the globe, go to {85}. If you wish to tell the man to stay put and surrender, go to {155}."
},
{ // 73
"Three bales of the golden Demregh-mno go over the side. The men on the patrol boat curse but cannot touch you. You laugh until you realize you have to face your employer's wrath.\n" \
"  To escape fully you must subtract your level number from 6 and make that level saving roll on Luck. If you make it, you must leave Gull for a short bit and this adventure is over. If you miss, go to {28}."
},
{ // 74
"His nimble hands scoop the stones up and toss them down. \"Shadow souls hide in their same, a hero's legend could have your name.\"\n" \
"  [Because of this roll, you can subtract 5 from the Monster Rating of any one monster you find in this adventure. ]Go to {12}."
},
{ // 75
"You soon learn from other criminals that Mr Big as far as you are concerned is a hulking, cruel man known as Morgo. You also learn that the gem shipment is due two days hence. Certain that your financial wellbeing is secure, make a third level saving roll on Luck (30 - LK). If you make it, go to {115}. If you miss it, go to {16}."
},
{ // 76
"The City Guard does not believe you. They turn you over to the torturers to gather information from you. Make a saving roll on your current CON at your level.\n" \
"  If you make it, add a 1 to that level and try to make the new roll on CON. If you miss any saving rolls, subtract the number you miss by from your CON as damage taken. You must miss 3 saving rolls before the police will believe your story. Each subsequent roll - whether made or not - goes one level higher, and you must make the saving roll on your current CON, including damage you have taken from torture. If you survive torture, go to {17}."
},
{ // 77*
"Things get a bit tight just before you enter the mouth. The dragon's big teeth are clamped down, so you can't squeeze through. You do notice one of the molars has a round hole in it. And that tongue is just a big pink carpet.\n" \
"  If you want to stab a knife into that hole in the molar, make a L2-SR on LK. If you make it go to {135}. If you fail, go to {172}. If you decide to attack the tongue, go to {154}. If you choose to slip down close to the molars and wait for the dragon to open its mouth, go to {167}."
},
{ // 78
"Before you are two doors. Each has a face carved on it. Simultaneously they say, \"Choose passage or peril.\"\n" \
"  Make a first level saving roll on your Intelligence (20 - IQ) to see if you make the right choice. If you make the roll, you pass without incident. Go to {118} after taking Token #5. If you don't make the roll, go to {162}."
},
{ // 79
"Arion kicks out at the man's knee and trips him as the door bursts open and guards pour in. The spy scrambles to his feet and dives through the window. He batters you aside and you fall to the courtyard below (2 dice damage). Before you can recover, he bounds up and over the wall to freedom. The next morning the man is found dead with a note pinned to his chest. It reads, \"We think the Prince should take better care of his sparring partners. Marek and Rais.\"\n" \
"  You did manage to alert the guards which eventually led to the elimination of the spy. You get 150 adventure points and a bounty of 2500 gold pieces. You are done."
},
{ // 80
"It would have been a nice plan if it had worked; however, the Rangers saw you talking to the merchant while in the bar. They hustled him off to a different meeting. You spend a cold night waiting for a meeting that never takes place. The merchant talks and your cover is blown.\n" \
"  This adventure has been worth 225 aps for you, and no cash. One thing you should know, however, is that the Rangers still only got doctored maps, so your attempt was not a total failure."
},
{ // 81
"\"The reason we have hired you,\" intones the tired Captain of Gull's City Guard, \"is because you have never worked with us before. Your reputation will work for you. You have to get the information for us.\"\n" \
"  \"What's in it for me, and what do you want to know?\" you ask. The room is small and dark and close. You feel sweat roll down your temples. Your question darkens his face and deepens the black tracings of wrinkles around his eyes.\n" \
"  \"We believe the Rangers have spies in Gull. We think they are planning an attack on the city, and even now they gather their information. We will pay you 5000 gold pieces for a spy alive, half that if he is dead. We will also give you an open pardon. You will become instantly innocent of any one crime, except a capital crime, against the crown.\" His eyes reflect desperation.\n" \
"  The price is good; if you want the job you've got it. He cautions you against carrying any magical weapons because the Rangers are well known to be suspicious of magic, and the fact that magic is detectable - making you \"visible\" even when you're hidden well.\n" \
"  If, from another solo adventure, you are a member of the Rangers, go to {2}. If you are not connected with the Rangers, you can think of two places to go. The first is the Kraken's Cave, a portside tavern at {11}. The other idea you get is to check the Palace where the spy might be gathering info. (It is on the highest hill in the city, after all.) Go to {31}."
},
{ // 82
"You bring the boat into the boathouse that has been retained for your meeting place. They thank you and offer you the agreed-upon price of 1000 gold pieces. They also say they will give you 800 doses of Demregh-mno (retail 50 gold pieces each), instead of hard cash, if you wish.\n" \
"  If you want the hard cash, you get it and are done. If you want the drug to sell, go to {47}. If you want the Demregh-mno for personal use, go to {67}."
},
{ // 83
"The creature tosses the stones out, then hesitates. Gravely he looks up at you. \"Tears I see, shed for thee. Pay me heed, you are soil for Death's seed.\"\n" \
"  Make a second level saving roll on your average of Intelligence and Charisma (25 - ((IQ + CHR) ÷ 2)). If you make it, go to {114}. If you miss, you must [add 5 to the Monster Ratin]g[ of any monsters in this adventure, and must reroll for any saving roll you make by 2 or less points (taking the worst of the two rolls as your roll. You will get adventure points for both.) G]o to {12}."
},
{ // 84*
"The Death Empress slowly licks her lips. \"Nothing pretty about you. You'll do just deliciously. We are certain you will enjoy your time here.\" Go to {196}."
},
{ // 85
"His Strength is 20. Use his Strength [and your Strength ]as Monster Rating[s] and fight[ with them]. The winner [of the wrestling match ]gets the globe. If you win, go to {121}.[ If he wins, go to {20}.]"
},
{ // 86
"You leap from your boat and fly at him. He looks startled and throws a Mind Pox on you. You fall into the water. Even if you know how to swim, his spell has confused you enough that you begin to flounder and drown.\n" \
"  Make three Constitution saving rolls, starting at second level (25 - CON). Take the number you missed the saving roll by as hits. For each roll you miss, increase the level of the next one by one level. After three rolls, the Mind Pox wears off. If you live, go to {106}. If don't win, you drown in the dark water."
},
{ // 87
"The Prince looks at you in a way that makes you think the youth is far older than his years. \"There is a situation that demands a person who is both brave and intelligent. You have shown yourself to possess both these qualities, and I need an agent to act upon the City's behalf in this matter. If you're interested, you will have to take a journey some distance north of Gull. You will find you'll be well compensated for your trouble.\"\n" \
"  A minister brings a rolled-up map to point out your destination. The trip will not send you that far out into the Northern Baronies. If you want to accept this mysterious mission, go to {101}. If not, you are excused with the Prince's thanks for your service to him. To find more adventure, return to {1}."
},
{ // 88 & 88A
"Whatever this thing is, it clearly is not human and almost certainly is not of this world. Over 18' long, from nose to rump, with an added 8' of snakelike tail, this creature has six limbs and is vaguely centauroid. Its ancestors were undoubtedly feline - this you can tell by the black fur, facial features and the taloned paws on the ends of its hands. Its fangs also clue you in.\n" \
"  As you were warned, this creature is also magical and, therefore, does not fight in a conventional manner. As far as you are concerned, it has a Monster Rating of 115 but killing/subduing it will only require you bringing its CON of 45 down to zero. (It gets 12d6+58 with a CON of 45.)\n" \
"  In other words, it will always attack with an MR of 115 regardless of the damage you do to it.\n" \
"  [It will not do damage to you in a conventional manner - you take no hits from it even if you lose a round. When you do lose a round, divide the number of hits it does to you in a round by 10, rounding up, and you must make a Luck saving roll (your choice) on that level. Keep track of the number of these saving rolls you miss. (Remember it gets 12d6+58 with a CON of 45.)\n" \
"  For each roll you miss, you must make an IQ saving roll on a level equal to the number of Luck rolls you have missed. (Example: The creature gets 23 hits on you in a round. That requires a third level (23 ÷ 10 = 2.3 = 3rd level roll) saving roll on Luck (30 - LK). If you miss, you have missed 1 roll. That requires a first level saving roll on Intelligence (20 - IQ). (Level 0 saving rolls just require you to roll 5 or more on two dice.))\n" \
"  Because the creature is not defending itself, you will always do an additional 10% of your combat roll to it.\n" \
"  What the creature is doing to you is reshaping you into an image it finds more appealing. When your mind snaps (ie. you miss the IQ roll), you become its creature. In that case, go to {9}. ]If you vanquish the creature, you examine its lair by going to {108}."
},
{ // 89
"They bow deeply and chant. They bring out a magical suit of leather armour which will take 17 hits for you. They also give you a magical tower shield that takes 10 hits. You know, however, that you aren't truly the personage they're expecting, so you make it known that you must leave. Make a second level saving roll on Charisma (25 - CHR). If you make it, go to {109}. If you miss, go to {70}."
},
{ // 90
"The man you were chasing managed to signal others in the bar that he was going to draw you off. Four of them, beside him, are waiting for you as you round the corner. Each of them has an MR of 10. If you kill the lot of them, go to {30}."
},
{ // 91*
"The volume you pull from chaos is the memoir of the famous thief Tidius Fortunato. The title is I Never Stole That. It's full of amusing anecdotes and practical advice for a thief.[ Your take-away from the book involves the intricacies of locking mechanisms. From this point forward you can add 2 to the appropriate attribute when examining or picking a lock.]\n" \
"  You weren't sure about coming to the library, but it's turned out well for you. You head home feeling very satisfied."
},
{ // 92
"This was not the brightest plan you ever had. The Rangers are not loved in Gull. Average your Strength and Charisma (add them together then divide by 2). Use this new attribute to make a second level saving roll (25 - ((ST + CHR) ÷ 2)) to see if the people think you look formidable enough to stop them from attacking you. If you make it, go to {100}. If you miss it, go to {126}."
},
{ // 93
"Two foremen move to speak with the captain of the guard while the rest of you move through the warehouses and flank the guards. On a signal, you attack and drive the guardsmen back. They retreat. You are fully accepted as a member of the dock gang. Go to {222}."
},
{ // 94
"You look at the little raggedy beggar and smile slyly. \"I will cut you in for half of anything I find while in there; that will be your payment.\"\n" \
"  The creature accepts your bargain. Because of your wit, however, you will be allowed to reroll any 1 die when rolling for your fortune.\n" \
"  To simulate the reading of the fortune stones, roll 3 dice and check the paragraph appropriate for the results you get below:\n" \
"  If you roll triples, go to {4}.\n" \
"  If you get any pair of numbers, go to {44}.\n" \
"  If all your numbers are 3 or below, go to {64}.\n" \
"  If all your numbers are 4 or above, go to {74}.\n" \
"  For any other result, go to {83}."
},
{ // 95
"You soon learn that your criminal boss is Morgo. He is a big, hulking man who has a cruel streak running through him. You learn that the gem shipment is expected soon. To avoid being discovered, make a fifth level saving roll on Intelligence (40 - IQ).\n" \
"  If you miss the roll, you are discovered: go to {173}[ and roll 4 dice instead of 2 to determine your DEX saving roll]. If you make the IQ saving roll, go to {8}."
},
{ // 96
"You dodge and weave your way through the twisted streets of Gull...You have managed to escape with your portion of the take. Roll 3 dice and multiply by 500 to determine the total gold piece value of your portion of the swag. You are done, and this was worth 1000 adventure points.\n" \
"  Having proved yourself less than honest, other business propositions come to your attention. If you want to take a walk on the wild side, go to {61}, otherwise you may retire to spend your earnings."
},
{ // 97
"They hit you with a magic dagger. As the magic paralyzes you, they step in and beat you senseless. You awaken to see your connection, a man named Al-Dajjal, standing over you. In his hand he has a glass tube filled with Demregh-mno. He pushes it into your nose and closes your mouth and other nostril with his free hand. As much as you don't want to breathe, your body forces you to. You inhale the golden dust.\n" \
"  \"You are now a slave to Demregh-mno. Such is the price of failing me. When the pains of withdrawal begin, we shall release you. I wish you a long life, slave!\" he cackles. Go to {67}; you are now addicted to Demregh-mno!"
},
{ // 98*
"For the sake of argument, we're going to assume you knew what you were doing, and based your attack on an intimate knowledge of dragonkind. After all, that's what you're going to say to everyone as you tell the story of your adventure anyway. In carving your way out the dragon's side, you sliced the descending aorta in half. The dragon's blood pressure dropped instantly and it bled out in roughly thirty seconds.\n" \
"  You literally get bathed in dragon blood, which is not nearly as much fun as those trashy novels from Khazan suggests it might be. What does happen to you because of that is this: you develop [a partial ]immunity to toxins - poisons, gasses, venoms, horrible cooking at that party where you're the guest and you can't say anything but your stomach is just boiling.[ When called upon to make a saving roll against poison, you deduct two levels from that roll and gain 1300 ap.]\n" \
"  Also you get to loot the dead dragon's body. There's a decent amount of gold and gems in there. Roll 5d6 and multiply that by 100 for gps. You've done a good day's work. Time to head home and take a well-needed bath. After all, you are completely drenched in dragon's blood."
},
{ // 99
"You swing high and the Prince kicks out. Your blow kills the spy outright. A crystal ball falls from within his clothing and shatters on the ground. The Prince rises as the guards burst through the door. He commands you to kneel and instantly dubs you a Knight of the Kraken, making you one of his personal agents.\n" \
"  This adventure is worth 250 adventure points and the honour is worth 4 points to your Charisma. You also get 2500 gold pieces for killing the spy.\n" \
"  The Prince pulls you aside as the guards leave. Go to {87}."
},
{ // 100
"Everyone decides that you look a bit too tough to mess with right now. You cross the floor and seat yourself at a table. Soon a serving girl comes over with a mug of ale. \"The hooded gentleman in the corner offers this with his compliments.\"\n" \
"  As you look over, the man raises a glass in salute and drinks. If you do the same, go to {127}. If you refuse to drink or pour the ale on the floor, go to {120}."
},
{ // 101
"After long hours of trekking far north of the city, you find a pathway that leads you through the jungles to a remarkable scene. Between two standing stones you see a trio of people. Foremost you see a gorgeous Elven woman, clearly of noble birth and bearing. Behind her, brandishing a long knife in case you present a threat, you see an Elven warrior swathed in a cloak of forest green. Lastly, peering at you with inhuman amusement in his eyes, you see a shaggy, brown-furred creature you're tempted to class as a \"demon-ape.\"\n" \
"  The female smiles as you approach. \"Praise be, our entreaties have been answered.\"\n" \
"  You nod and tell her that you have come to offer whatever help you can, but that those who sent you were most circumspect in filling in details concerning the task at hand.\n" \
"  With her right hand, she points further on down the pathway toward an opalescent city you see shimmering in the twilight. \"We have told them little of why we need your help because this condition is one that causes us great distress and embarrassment. Yonder is the City of Peace. It is a place where Elven heroes who have died here in this world are laid to rest. The City only partially exists here as it bridges the way between this world and the Havens to which Elves are granted passage when their time here is finished.\n" \
"  \"A creature of magical abilities has entered the City. Elves are barred from any violence within the City of Peace, yet we cannot stand by and allow this thing to befoul the graves of our people. Somehow the defences we built in did not destroy it, so we must rely upon you. We beseech thee, help us. Rid the City of this creature.\"\n" \
"  If you are an Elf yourself, go to {62}. If you accept the mission and want to get started right away, go to {12}. If you accept the mission, but notice the furred creature is casting fortune stones and want to ask him about portents, go to {32}."
},
{ // 102
"As you wade into the lake, it reacts as if it were alive, smashing at you with tall, rough waves. Make a saving roll at your own level on Constitution to see if you can stand the pounding while getting to the sword. If you make the roll, go to {5}. If you don't, take the number you missed by in hits to your CON (bruises and minor concussion) then go swordless to {24}; the other swords have disappeared."
},
{ // 103
"Average your Intelligence and Charisma. Make a third level saving roll (30 - ((IQ + CHR) ÷ 2)). If you make it, the patrollers buy your story. You are free to continue your journey. Go to {82}. If you miss it, go to {6}."
},
{ // 104
"You burst to freedom and quickly report to Diamondfist. He tells you that a dock fight won't provide enough evidence to break up the ring. He also agrees with you that it would be deadly for you to return to the job. He pays you 500 gold pieces. This adventure was worth 300 adventure points and an introduction to the Captain of the City Guard. If you would like to accept the invitation, and are looking for more excitement, go to {81}. Otherwise you are done."
},
{ // 105*
"As impressive as the library's exterior was, the interior is even more so. Wall to ceiling shelves and pigeonholes are just crammed to overflowing. Books and scrolls choke the place and shelves are bowed beneath the weight of knowledge. You decide to plunge in and find something to read.\n" \
"  Roll 2d6 and add the result. Go to the paragraph indicated by the result below:\n" \
"     2 = {119}\n" \
"     3 = {157}\n" \
"     4 =  {91}\n" \
"     5 = {184}\n" \
"     6 = {197}\n" \
"     7 = {210}\n" \
"     8 = {223}\n" \
"     9 = {236}\n" \
"    10 = {249}\n" \
"    11 = {165}\n" \
"    12 = {240}"
},
{ // 106
"As your head clears the surface, you are fished out of the water. Standing over you is Marek, the master rogue of Gull, and a number of his men.\n" \
"  \"Your attack on Al-Dajjal cost him too much strength,\" he tells you. \"He teleported himself out, but left the Demregh-mno. We'll take the drugs out and destroy them. You can have the 1000 gold pieces he promised. Al-Dajjal will probably send a demon after you, so I'll give you a dirk called Demon Death. Just barely cut a demon (one hit) and it'll be dispelled. You can throw this dagger also, it's well-balanced.\" Marek says. \"Come with us and have a drink or two.\"\n" \
"  You leave for the Black Dragon Tavern, 1000 gold pieces richer and 2000 aps more experienced, and you are finished with this adventure."
},
{ // 107
"\"Come out and meet your maker!\" you shout boldly.\n" \
"  A harsh, buzzing voice issues from the hole in the corner of the building. \"I will be your death, but I grant one of my playthings a chance first!\"\n" \
"  Roll one die and consult the table below for your foe:\n" \
"  1 = A weird hybrid that looks like a puma for size and weaponry, but a squirrel for colouration, crawls forth to fight you. MR 30.\n" \
"  2 = A fully armoured centauroid warrior gallops out of the pit. MR 45.\n" \
"  3 = A Dwarven warrior with proportionately sized grasshopper legs bounces into battle. MR 35.\n" \
"  4 = An Elven warrior maid with bug-eyes and spider-mandibles crawls from the pit to fight you. MR 30.\n" \
"  5 = A Hobbit-naga comes slithering out toward you. It has an MR of 25.\n" \
"  6 = A giant cockroach with the head of a wolf scuttles out to fight you. MR 40.\n" \
"  If you defeat whatever creation it has challenged you with, it decides you are worthy of its attention. Go to {88} as it comes crawling out to fight you."
},
{ // 108
"Within its lair you discover a number of misshapen creatures dying. You seek to comfort them, but you cannot help them. Moreover, as they look at you, they smile and offer silent thanks for your efforts and having freed them from the living hell the creature shaped for them.\n" \
"  Within its lair you discover 5 gems (roll for their value on the chart in the T&T rules) and a ring[. The ring] - silver and set with an emerald[ - will allow you to ignore spells of evil intent cast on a level equal to half your own level. (Round down if you need to].[)]\n" \
"  Leaving the City once again in peace, you pass from this place. As you depart, you see hundreds of Elves streaming into this place to repair the damage the creature did. All of them smile in gratitude to you.\n" \
"  This adventure is done for you. You earn 1500 adventure points."
},
{ // 109
"They understand that one day you (or one like you) will return. They guide you back to the road to Gull. With you they leave five healthy youths (all have Dexterities of 15[; you'll have to roll for their other attributes]). Arm them as you see fit - they will shadow you forever, or until they die, and they are completely loyal to you. You have won - head home."
},
{ // 110
"The man takes you outside and is revealed to be the Captain of the City Guard. \"If that is your idea of Ranger hunting, you're fired...\" This adventure has been worth 250 adventure points for you, though no gold passes into your coffers. You are done."
},
{ // 111
"Beneath this stone you find a gold-coloured toga and electraglide sandals. The toga will magically take 3 hits[ and the sandals add 2 to your Dexterity while you wear them]. Take Token #1 and go to {51}."
},
{ // 112*
"The Death Empress wheels around and backhands the satyr. \"How many times have I told you, I do not like them so pretty! Get rid of it!\" You help the satyr up and he escorts you from the chamber. He moves slowly, and shows signs of being abused many times. As you round the next corner, you hear screams and the sounds of orc warriors laughing up ahead.\n" \
"  The satyr pulls you in the other direction, down a dark corridor at the end of which is a golden door. \"You helped me, so I'll help you.\" He hands you a purse with 4d6 gold. \"Go down to the docks, speak to the captain of the Black Griffin. He was once where you are now. He'll take you wherever you need to go.\" He lets you out through the door and waves as you depart.\n" \
"  You manage to make it to the ship and home. This adventure has been worth 1000 aps[, plus introduces you into the network of former Death Empress slaves. It's all over the place. If you make a L3-SR on Intelligence (30 - IQ) at the start of any scenario, you get an MR 30 companion to help you win the day]."
},
{ // 113
"If you want to fight with the police against your fellows, go to {25}. If you want to fight alongside your crew, against the police, go to {65}."
},
{ // 114
"The female looks upon you with a certain sadness in her eyes. From beneath her rosy cloak she pulls a slender silver cord that she ties around your brow. \"May this counteract the evil portents,\" she whispers solemnly.\n" \
"  [The silver cord will add 5 to your Luck while you are in the City of Peace. ]Go to {12}."
},
{ // 115
"You have a few narrow escapes from brushes with the law. Since you had done nothing, they couldn't hold you. You lay low and show up the night of the robbery. The take is big, and as it is being split up the police break into the warehouse where the split is being made. Make a fourth level saving roll on Luck (35 - LK). If you make it, go to {96}. If you miss it, make a sixth level saving roll on Intelligence (45 - IQ). If you make that, go to {37}. If you missed both rolls, go to {57}."
},
{ // 116
"You swim underwater to a place beneath one of the crossbowmen. Through the floorboards you stab upward and hear him scream. He pitches into the water. You see a flash and hear the door explode. Al-Dajjal screams, \"Marek, I'll kill you yet!\" and vanishes.\n" \
"  You come from beneath the dock and see, in the captain's garb, Marek, the master rogue of Gull. \"Thanks for your aid,\" he says. \"This shipment would have ruined a number of good people.\" Toeing a canvas bag that had been at Al-Dajjal's feet, he says, \"I believe this thousand gold pieces rightfully belongs to you.\" As he leaves, he adds, \"Good luck in the future!\" You have earned 1600 aps. You are done."
},
{ // 117
"You managed to dodge the magic dagger they threw at you. Now you face two 30 MR rogues. You have one chance to cast a spell, if you wish. If not, wade in and fight. If you win, go to {38}. If you lose, your adventure is over."
},
{ // 118
"Roll one die and multiply that number by 10. This is the number of the Monster Rating of the Chief of the Klorven. He is standing in front of you and does not look at all happy that you have made it this far, thus threatening his continuing rule.\n" \
"  You must fight him. If you kill him, take Token #6 and go to {124}."
},
{ // 119*
"The book you pluck off the shelves is a dusty old history tome entitled My Time In The Khazan-Ranger War. It's a rousing, autobiographical tale, purported to be the memoir of a Ranger who fought in the war that prevented the Empire of Khazan from taking over the City of Gull. It's quite engrossing, and you feel yourself being drawn into the story. Make an L2-SR on Luck (25 - LK). If you make it, go to {132}. If you miss, go to {134}."
},
{ // 120
"The man rises and says he demands \"satisfaction\" and wishes you to meet him outside. If you go with him, go to {110}. If you hit him here and now, go to {128}."
},
{ // 121
"You twist the globe from his grasp; it feels warm and almost alive in your hands. Neither of you noticed as you fought, but guards have entered the room. The Captain who hired you steps forward and directs his men to drag the spy off.\n" \
"  \"Thank you. You have saved Gull!\" he says. He takes the globe from you and hands it to two wizards; they'll use the globe's power to destroy the wizard who was spying through it.\n" \
"  This adventure has been worth 350 adventure points for you, as well as the 5000 gold pieces promised for a captured spy. In addition, after he hears of your bravery, the young Prince of the City, Arion, asks to have you brought to him. Go to {87}."
},
{ // 122
"You look tough to him, and he stops. As he raises his unburdened hand, a blue fire pours down his right arm from the ball. He screams as you see the flesh burn away. Before you can do anything, he becomes a human torch. In seconds he is reduced to ashes and the ball spills to the floor, shattering to glittering shards among his smoking remains.\n" \
"  The guards come in answer to his screams, and you quickly relate to them what happened. This adventure has been worth 325 adventure points to you, and 2500 gold pieces for the dead spy. You have saved the City, congratulations."
},
{ // 123
"You attack when they are in the middle of a bridge. One instantly goes over the edge. The maps, clutched tightly in his hand, go with him and are ruined. The other two are angry with you, for rather obvious reasons. Each has a Monster Rating of 25. If you survive this fight, go to {30}."
},
{ // 124
"Gathered at the cave exit is a group of the Klorven Warriors. They are cheering your survival of the Cave Complex. They mill around you and begin to guide you out. Make a saving roll on Luck at your own level. If you make it, go to {39}. If you miss it, go to {59}."
},
{ // 125
"As you pause in the doorway of the Kraken's Cave, you let your eyes adjust to the darkness. A shadowy figure darts into an alley to the right. You run after him. Make a second level saving roll on Speed (25 - SPD). If you make it, go to {50}. If you miss it, go to {90}."
},
{ // 126
"The loyal citizens assembled in the bar distinctly do not like your political stance. They gather together and throw you, bodily, out of the tavern. They threaten to kill you if you ever return.\n" \
"  Your cover has been blown, you are known as a Ranger sympathizer, and no Ranger would ever come near you. This adventure has been worth 100 adventure points for you, though no gold. Better luck next time..."
},
{ // 127
"You begin to have terrible pains in your throat and stomach. Your teeth crunch when you bite down and your tongue hurts. The drink contained ground glass. Take four dice damage - no armour will help. You fall over and black out, whether you live or not. If you don't wake up, you are dead. If you awaken, you are told two things:\n" \
"  First, the person who got you with the drink has lost a son to the Rangers in a raid, hence his attack on you. Second, the spy has been caught. Your services, such as they are, are no longer required. The Captain pays you [jewelry worth ]500 gold pieces. This has been worth 75 adventure points."
},
{ // 128
"The blow takes him by surprise and knocks him out. Suddenly you are surrounded by City Guardsmen who hustle the two of you off. The Captain appears and congratulates you on a successful venture. The man you hit was a spy, worth 5000 gps to you. You get 300 adventure points for the adventure. You are done."
},
{ // 129
"As the patrol boat pulls up along side you, an officer jumps aboard your boat. \"Captain,\" you say, \"I can make it well worth your while to leave me and my cargo alone.\"\n" \
"  Total up the amount of the bribe you would like to give him and divide by 100. Subtract that number from 10 to determine the level of the saving roll you must make on Luck to successfully bribe him. (For example, a bribe of 100 gp ÷ 100 is 1. 10 - 1 is 9. A ninth level saving roll on Luck. Note: you must always at least make a 5 on the two dice you use for the roll, regardless of how much you offer him.)\n" \
"  If you make the roll, go to {82} with his thanks and well wishes.\n" \
"  If you miss the roll (or don't have the money immediately available), he kills you. As your blood leaks all over the deck you hear him comment that 100,000 gold pieces worth of Demregh-mno is more worth his while than trying you for a crime. After all, it is his responsibility to see that the drug does not fall into the wrong hands. He laughs and spits upon your lifeless form."
},
{ // 130 (anti-cheat)
"You feel as if you don't really belong here. You begin to understand that there is no way into this room. Stop peeking and go back to the paragraph you just came from, before the gods take their vengeance upon you. If you have forgotten where you came from, go to {1}."
},
{ // 131*
"The Royal Library towers over you, more a temple to learning than a simple building. The friezes around the door feature scenes of people who appear happy. They're labouring away in the fields, at a loom, a potter's wheel, sailing. Each one of them is clearly productive and working on whatever is the newest, latest and greatest. And yet, around them, are images of little batwinged imps with tiny spears.\n" \
"  They threaten the people and one or two of the happy people seem to notice them out of the corners of their eyes. Clearly these images have a symbolic meaning.\n" \
"  Make a L2-SR on Intelligence (25 - IQ). If you fail, go to {143}. If you succeed by less than 6, go to {105}. If you succeed by 6 or more points, go to {168}."
},
{ // 132
"You hear waves crashing and smell the salt air. Cold spray washes over you - rather bracing - then an arrow whizzes past your face. The library is gone, and you are on the heaving deck of a black-sailed Ranger warship - which is on fire. In the distance you see what must be the incredible city of Khazan, and at the tips of the Dragon's Fangs lie two towers!\n" \
"  Orcish marines in Khazani tabards swarm over the deck. Roll 1d6. This is the number of MR 15 orcs that move to attack you. If you survive the battle, go to {182}."
},
{ // 133*
"What part of \"really, really hot\" and \"probably dragonfire in a plasma state\" did you not get? Did you think that being offered what is an obviously horrid option means you won't die because of it? Philosophically speaking, you're utterly correct. It's not fair to kill your character for making such a bad choice.\n" \
"  Oh, stop it with the puppy-dog eyes. Heavens. Okay, make an L4-SR on Constitution (35 - CON). If you make it, go to {250}. If you miss, at least know your character, while dying horribly, died so fast the character never had a chance to wonder why you made that choice."
},
{ // 134
"The story really is rather exciting, and details how the Ranger in question plundered a great deal of loot, and then hid it away in a place said to be guarded with incredible, magical wards. You think that's probably nonsense, but you did take something out of the story. The author once faked his death, appearing to have drowned, but he explained how he avoided that.[ Armed with this knowledge, you can deduct one level from any saving roll against drowning you ever face.]\n" \
"  Feeling good about yourself, you leave the library with a huge smile on your face. It's been a great day."
},
{ // 135*
"Your knife slips into that dark hole perfectly and dark fluid gushes back out. Then something happens, something which makes perfect sense when you consider that you've just done dragon dentistry without any painkillers - the dragon wakes up, roars, and spits you and fire high into the sky. You'd think this would be bad for your health, but you just squeezed up through a dragon's throat. You are covered in secretions that protect the dragon's throat from its own fire, and the juice which gushed back out of the tooth is some noxious stuff produced by bacteria which thrive in the fire.\n" \
"  Fire wreathes you and slows your descent to the ground. From this point forward (as the result of your experimentation), you've discovered that you can wreath all or part of yourself in flame at will, which grants you several abilities. First, you can perform [limited duration ]flight[ (20 seconds) carrying up to double your weight]. Second, you get an added 3d6 fire damage if you invoke flames during combat, and third, you're never going to need a torch again. You definitely have improved yourself. Congratulations. Now stagger home and get cleaned up."
},
{ // 136*
"You quickly search the body and find 2d6 gps, plus a small, flat stone which, when you have it on you, allows you to understand Orcish as if you were a native speaker. [(If you are a native speaker, pick another kindred's language, or the special speech of a clique or cult. You can read that language too, but only clear script.) ]You also get 1000 aps.\n" \
"  [Most importantly, you escape the Death Empress's Palace and go on to write, pseudonymously, a book titled, I Almost Died For Love. It is a smash bestseller, especially with all the bondage content you added. You get 3d6+6 × 10 gps each month for your effort. ]You really have improved yourself."
},
{ // 137*
"Your brain is itching because of the magic at work here. You go to close the book, but you notice the endpaper at the front of the book has started to peel up at  the corner. You help it along and see all sorts of squiggles and sigils scrawled there. You know it is sorcerous writing, but the script evaporates with exposure to light and air.\n" \
"  No matter, you saw what you saw. [And you learned from it. From this point forward, for any spells that rely on IQ for dominance or damage which are used by or against you, your IQ will be doubled. (When you're using the spells, the Strength cost will be decreased by 50%, round up.) ]You have completed this adventure and lived to tell the tale."
},
{ // 138*
"Well, your planning was good, but your execution really didn't do too well. But, as noted, the stomach is a bit tender. In fact, your attack wakes the dragon from a solid slumber and it heaves. Really, it's projectile vomiting, with you being the projectile.\n" \
"  Make a L2-SR on Constitution (25 - CON); take hits equal to what you miss by. You jet out of the dragon's mouth in a glistening stream of stomach acid and glittering gold coins. The ground is not soft, nor is the big rock you bounce into.\n" \
"  The dragon sniffs at the vomit, burps, then takes off. You have somehow survived being puked out of a dragon's mouth. Take 500 aps, and you have 3d6 of gold coins scattered around you for your trouble. Your day is done, but at least you're alive."
},
{ // 139
"Armour, while great for stopping combat damage, really doesn't do much for you in the water. And it's not really a matter of whether or not you can breathe water, it's just that it's pulling you down to the bottom where the pressure will kill you by squashing you like a grape. Make a L2-SR on Constitution (25 - CON). If you succeed, you strike to the surface and get pulled aboard a smaller boat. You are now, however, without your armour. Go to {174}. If you miss, take hits by what you missed. Make the roll again[, dropping any one other item you possess which has the weight equivalent of 10 gps]. You can continue this cycle until you succeed and go to {174}[ without your possessions], or die."
},
{ // 140*
"How the librarians and guards fail to notice this goblin sneaking around and then out of the library looking like a carpet wrapped around rocks you have no idea. Doesn't matter. You follow the goblin from the library and toward the docks. He enters a ramshackle building which smells like a dead-animal factory, and has a chimney belching out black smoke. If you want to sneak into the building after the goblin, go to {152}. If, instead, you'd like to climb up a trellis and gain access to the roof above a small balcony on the second floor, go to {177}. If you decide that you're probably in over your head, return to {1}[ and you are free to reroll the next saving roll you miss]."
},
{ // 141
"It strikes you with an incredible sense of clarity that striking straight for the tower is the best way to go. The audacity of the attack guarantees surprise. While it doesn't have a harbour deep enough for a large ship, your boat is perfect. You point to the tower. The Tillerman nods and you make for that huge building.\n" \
"  Your boat makes it to the small jetty. [Roll 1d6. This is the number of MR 15 Rangers who join your taskforce. ]If you want to race to the top of the tower, go to {200}. If you'd like to head down into the dungeons beneath the tower, go to {175}."
},
{ // 142*
"The assistant Librarian brings you a book entitled A Practitioner's Guide to Immortality. The book is heavily illustrated, but the charts and pictures make little sense. The text runs on in long sentences, has dubious punctuation, and half the sentences have clauses which contradict the clause that preceded it. Still, there's something about this book that makes you want to read further.\n" \
"  Make an L2-SR on Intelligence (25 - IQ). If you make it, go to {253}. If you miss, go to {214}."
},
{ // 143*
"You puzzle over the meaning of the images and are so focused that you trip on the steps going up. Roll one die and take that much damage as you bark your shin on the steps. You sit down and rub at the bruise.\n" \
"  A young boy comes running up the steps to you, then turns and waves an old woman in your direction. \"Mistress Ursula this way. This must be the one you've foreseen.\" It strikes you as odd the use of the word \"foreseen\" because the woman's milky eyes suggest she is utterly blind.\n" \
"  \"Yes, yes, this is the chosen one.\"\n" \
"  Make a L1-SR on Intelligence (20 - IQ). If you fail, go to {180}. If you make it by single digits, go to {192}. If you make it by 10 or more, go to {204}."
},
{ // 144
"The globe falls from his lifeless fingers and explodes. Guards, attracted by the sound of fighting and led by the Captain, go out into the room. You have succeeded. This adventure has been worth 300 adventure points and the 2500 gold you were promised for a dead spy. Congratulations."
},
{ // 145*
"As you get further into the darkness, the outline of the crone and urchin softens, then melds. They transform into mist, then coalesce in the form of a vengeful wraith. It shrieks at you and attacks.\n" \
"  The wraith has an MR of 45. If you survive, you find 1d6 gold scattered around in the alley. And, in your quest for self-improvement, you've learned to trust your hunches. Now, head on home to some well-deserved rest."
},
{ // 146*
"You deftly hop over the open trapdoor and safely race out of the goblin hovel. While this hasn't been exactly your best day, you do get an idea for a book. It's titled Discretion: Living To Tell The Tale. Building off your adventure, you provide a framework that adventurers can use to determine if retreating to live is better than dying. While it never sells many copies, it's popular in certain circles. [So much so, that if you can make an L3-SR on Luck (30 - LK) when at a tavern, someone else will buy your drinks. ]It's been a day. Be glad you survived."
},
{ // 147*
"Running is probably the most reasonable reaction to where you find yourself. You might think the guards would expect this sort of thing, but they were picked for brawn and not brains.\n" \
"  Make a L2-SR on Dexterity (25 - DEX)/Speed (25 - SPD) (whichever is appropriate). If you succeed by double digits, go to {208}. If you simply make the roll, go to {232}. If you miss, someone trips you up. You crash hard, roll into a wall and rebound, stunned. The satyr comes and stands over you. \"Perfect, tenderized. Just the way she likes 'em.\" go to {196}."
},
{ // 148
"\"We thrashed them scurvy Rangers more than a score of years ago, and the Death Witch beat 'em after that. Them dogs is as tough as sea foam!\" you growl. Someone buys you a drink for your patriotic statement, and over the rim of your tankard of ale you study the crowd.\n" \
"  A fat merchant man looks nervous while a dark-haired ruffian scowls in your direction and stalks out of the bar. If you wish to follow him, go to {125}. If you wish to seat yourself next to the merchant, go to {10}."
},
{ // 149*
"You are victorious and scoop up the mosaic. You can tell the sigils are a cipher, and there is some residual magic in the mosaic frame that helps you understand a little of what is in the message. Still, with pieces missing, you can't get it all.\n" \
"  [However, the magic does linger (probably because of the blood on the frame. Your blood). From this point forward, when trying to decipher an odd message, you can reduce the level of the saving roll by 1. ]Well done, now go to {195}."
},
{ // 150*
"The stomach convulses and contents slosh. You feel incredibly heavy for a moment, then get tossed across the stomach. You're not sure what's going on, but it's not good, so you set to work hacking your way to freedom.\n" \
"  Finish the battle with the stomach and keep track of how many combat rounds it takes for you to kill it. Then make a saving roll on Luck on the level equal to the number of rounds. If you make the saving roll, go to {218}. If you fail, go to {230}."
},
{ // 151*
"You find this memoir vile, offensive, disgusting and, alas, apparently built on a sliver of truth about your family. You know you should let sleeping dogs lie, but there is something about this scandalous tale that you feel demands that you uncover the truth.\n" \
"  [From this point forward, total up the adventure points you get during an adventure, divide by 1000, rounding down (minimum always being 1). This is the level of a saving roll on IQ you will make to see if the adventure yielded any clues to the mystery. If you make it, add the level number to a running total of points labeled Scandal on your character sheet. Once the points total 100, you have uncovered the mystery and are awarded 1000 ap. If that amount is under 1000, the scandal is much ado about nothing. If it is over 10,000, inform your GM as that's the kind of scandal that someone is going to want to keep quiet.\n" \
"  ]This adventure has been worth 1000 aps[, so make your L1-SR on Intelligence (20 - IQ) and gain a talent in deductive reasoning]. Yours has been a disturbing day, but at least you have a new hobby. Congratulations."
},
{ // 152*
"You creep into the darkened building. You can't see much, and that's a blessing because the place really stinks of rotting meat and fish and other noxious things. To the left stairs lead toward the upper floor. You hear some sounds from up there, which you take to be muffled goblin voices.\n" \
"  Then a floorboard creaks under your foot. You've triggered a trap. Make a L1-SR on Luck (20 - LK) or Dexterity (20 - DEX), your choice. If you make it, go to {189}. If you fail, record how much you missed it by and go to {42}."
},
{ // 153*
"You decide to look on your own and uncover a wonderfully illustrated book buried deep in the animal husbandry section. It's titled Who's a Good Boy? It's a remarkably informative guide to calming and training animals.[ To calm an animal, make an saving roll on Intelligence against the MR of the creature you face (MR - IQ). If you make the roll, the creature will not fight against you. If you miss the roll, it will attack you exclusively, with a 20% bonus to its MR for the first round of combat.\n" \
"  If you make the SR by double digits, the creature will fight for you for that combat. This only works on creatures (and Orcs from Khazan's South Side).] Feeling very lucky indeed, you head home. Well done."
},
{ // 154*
"The dragon's tongue has a CON of 55 and armour of 10. Do your worst and track the number of combat rounds it takes for you to kill the tongue. Once you've killed the tongue, make a saving roll on Luck on the level equal to combat rounds. If you make it, go to {205}.\n" \
"  If you failed, it's not good. While you were hacking away at the tongue, the dragon, in pain, decided to cauterize the wound with his own dragon flame. Curiously enough, the extreme heat will encourage rapid regrowth of tongue tissue. The same cannot be said of your tissue, because there's simply none of it left. Alas, your adventure is done."
},
{ // 155
"Average your Strength and Constitution. Make a third level saving roll on that number (30 - ((ST + CON) ÷ 2)) to see if he thinks you took formidable enough to avoid fighting. If you miss, fight him by going to {15}. If you make it, go to {122}."
},
{ // 156*
"You feel yourself being drawn fully into the story and, (though you don't know quite how) you find yourself in the modestly cavernous stomach of a dragon. You are yourself, you've not transformed into the book's hero. You're standing on a small pile of gold bits and bobs, with a few bones sticking out here and there. There are other such piles, which are islands in a bile green ocean.\n" \
"  There seem to be three logical ways out. If you want to head to the left, toward the head, go to {169}. If you want to wander to the right and the aft, go to {63}. If you figure that just going through the side is the best course, go to {181}."
},
{ // 157*
"You pull a massive volume off a shelf. The title appears to have been written in blood. It reads, Does It Hurt When I Poke You There? It's an assassin's anatomical guide to killing humanoids, and the ghastly illustrations show pressure points, where arteries lay unprotected and which muscles and tendons, when cut, will cripple.\n" \
"  [From this point forward, whenever fighting a humanoid, roll damage normally. Then roll two more dice. If any of the values on the new die match the value for your weapon die, add that new value in. (If you roll a 2, 3, 5, and then a 4, 5, you'd add the 5 in to your total). The bonus dice only add in once.\n" \
"  ]You stroll out of the library thinking you're pretty big and bad[, which, now, you actually are]. You'll sleep better tonight and feel a whole lot safer in the future. Congratulations."
},
{ // 158*
"Ursula goes from welcoming and warm to cold and paranoid at your refusal. She goes for you, as do 1d6 of the other attendees. She is MR 20, the attendees are MR 15. Those not involved in the fight just flee in terror.\n" \
"  If you survive the fight, you uncover some evidence that Xiharezed is part of a giant criminal cartel, and you were on the cusp of being sucked into a life of crime. You feel fortunate you managed to avoid that fate. Go to {195}."
},
{ // 159*
"\"Metaphysically speaking, the book you were reading connected with your unconscious desire to know union with the Death Empress. In those who are rather weak-willed and yet surprisingly stubborn down deep, this triggers magic in the book and brings them here so they may fulfill their desire.\" The satyr shrugs. \"Anyway, that's what the shaman told me.\"\n" \
"  In his explanation you gain a sense of hope. Make an L2-SR on Intelligence (25 - IQ). If you fail, go to {196}. If you make it, you close your eyes, knot your fists and fervently try to disbelieve you have any desire to be in this place. The satyr yells, \"Stop that!\" but you can barely hear him over a rhythmic thundering in your ears. The sound builds, pounding, and drowns him out. Go to {244}."
},
{ // 160*
"Attacking a gargoyle that has serious magical energy just boiling around his claws is not the kind of thing that is good for your health. You'd know this if you actually sat down in a library and read a book. About gargoyles, maybe. Then you'd know that this is Prince Akrazarach of the Dark Roost Zarachs. Very nasty. But, you do help him hit his kill quota for the month, which means your name - well, not your name but his nickname for you (which doesn't bear translating) - will be recorded in the Zarach annals forever."
},
{ // 161
"You're smart enough to know your armour will make swimming impossible, but you don't want to shuck it off. You see others in armour moving to the aft, so you join them. They clamber down a rope ladder and into a small boat crewed by Rangers. Go to {174}."
},
{ // 162
"You choose the wrong door. Behind the one you've chosen is a hungry 35 Monster Rating Tiger-cat. Kill it or be killed. If you survive, go to {118}."
},
{ // 163*
"You close the book tight. You're not sure exactly how the Death Empress' magic was at work there, but you certainly remember what it felt like.[ From this point forward, any time someone is using a spell to dominate your mind, effectively add 50% to your IQ. You're so armoured against such an attempt that if they fail, they take damage equal to what they missed by (armour does not apply).]\n" \
"  You definitely have improved yourself. Very well done. You can go home very satisfied and proud of yourself."
},
{ // 164*
"The Assistant Librarian beams as she hands you a very special book. It's the volume The Secret Magick of Gems. The author, who is mostly quoting from and recreating lost writings of an obscure wizard, says that all gemstones can be made to vibrate at a frequency which corresponds to an attribute of the person to whom they are attuned. [To attune a gem, just have the person who will use it swallow it. After a couple days, recover the gem. (A gem must be worth at least 10 times the attribute in gps.) Then double the attribute you want to improve (their value) and you make an Intelligence saving roll against that number (number - IQ). If you make the roll, the gem will add to the attribute points equal to what you made the roll by, up to the basic value of that attribute. (Example: The gem is attuned to someone with a CON of 10. The IQ saving roll made against the doubled value of CON (20), and can add up to 10 points max. to CON. The gem would have had to be worth 100 gps to function).\n" \
"  If you fail the roll, the attribute is reduced by what you missed by. And in all cases, the monetary value of the gem is reduced to 0. A character may only have one gem attuned to any one attribute at a time. This new knowledge, if used wisely, can make life easier for many. ]Now, get out there, find gems[, be patient (and bring lots of clean water) ]and change the world."
},
{ // 165*
"You find yourself drawn to a heavily illustrated volume titled I Wouldn't Touch That If I Were You. It's a guide to traps and how to avoid them. About the only thing that bothers you about it is the editor's foreword in which it is noted that the book was compiled *posthumously* from the author's notes. Even so, with all the illustrations, this gives you a much better understanding of how traps work and what to look for.[ Going forward, you may deduct one level from any trap related saving roll you're called upon to make.]\n" \
"  Feeling very fortunate, you head home. Well done."
},
{ // 166
"You struggled with the book's content. For you the content seemed to read \"And in the event that blah blah blah without forgetting the serious ramifications of blah blah blah the result is inevitable and unquestionable.\" Still you do get something out of it, which is this: if you set your mind to it, your body can do amazing things.\n" \
"  [Any time you're wounded, make a saving roll on Intelligence against the amount of damage (damage - IQ). If you make it, you heal twice as fast as normal. If not, there's no negative effect, you just aren't concentrating. The saving roll can only be made out of combat.\n" \
"  ]This has been an illuminating experience for you. You'll sleep better tonight. Congratulations."
},
{ // 167*
"As you crouch down there you feel something wriggling around your feet and haunches. It's this gross looking, grub-wormy thing with big metal teeth. It's hungry and it's coming for you. It has an MR 30. If you kill it, go to {221}."
},
{ // 168*
"A smiling librarian in purple robes trimmed in gold embroidery greets you at the top of the stairs. \"I often stand here, watching people study the images. Few understand their true meaning, but I know you caught it - that the demons of ignorance will bedevil us if we do not embrace the guiding light of knowledge. This makes you rare among our visitors. I think we might have some things in our special collection which will intrigue you.\"\n" \
"  If you wish to follow the librarian to the special collection, go to {216}. If you think you're really more in the mood for some lighter fare, go to {105}. If you want to rethink the whole reading adventure, you can return to {1}."
},
{ // 169*
"Crawling up a dragon's throat clearly appealed to you for some odd reason. As you come up out of the digestive tract, you can feel the rush of air from the dragons' lungs as it breathes in and out. And from here the going gets a bit easier, since the throat is lined with little ducts on either side that make convenient hand and footholds. However, those dots are a tad warm and through the throat tissue you can see these big, roiling orange glands that seem really, really hot.\n" \
"  If you want to keep climbing, go to {77}. If you decide to stab, cut, blast sideways out of the throat and toward one of those really, really hot spheres of glowing orange stuff, which is probably dragonfire in a plasma state before it is aerosolized for attack, go to {133}."
},
{ // 170*
"You know a scam when you hear one. You refuse to go any further.\n" \
"  Ursula's eyes, which had appeared to be blind, now blaze with unholy energy. She and the urchin attack. They have a combined MR of 35. If you survive, you search the bodies and find 3d6 gold pieces and a bunch of documents that indicate Ursula was involved rather deeply in various underworld plots. She clearly was going to recruit you into a life of crime. Go to {195}."
},
{ // 171
"You steer the boat for shore and the patrol boat comes near. You smile and wave, your heart nearly beating free of your chest. They wave back and continue on their way. If you wish you may take the drug to the chosen rendezvous point, {82}, or you may try to hijack the shipment, {53}."
},
{ // 172*
"Your knife plunges into the tooth and it explodes into a hail of razor-edged shards. They literally atomize into a mist. Treat it as if a creature with an MR of 30. [Your armour will only be half effective because much of the damage is done when you breathe the sharp dust into your lungs. ]If you survive the combat, go to {205}."
},
{ // 173
"These people have no pity for a stool pigeon. They bind you and lower you into a pit beneath the warehouse. It is dark, but you can hear rats squealing. As you touch ground, you feel hundreds of rats crawling about you. Their red eyes burn in their emaciated faces. Even as you struggle, the starving rats attack. Roll one die. This is the level of the Dexterity saving roll you must make to escape your bonds. For each turn you fail the roll, take 10 hits directly from your CON. If you get free before you die, go to {54}. If don't get free, you are dead."
},
{ // 174
"The boat goes crashing through the waves. Oars groan as men pull hard for the shore. Arrows fill the air. Ships burn on both sides of the battle. Of greatest concern for the Rangers is the closest tower. A massive trebuchet hurls fireball after fireball out into the Ranger fleet. Someone shouts, \"We have to destroy that tower!\" Ranger voices rise in agreement.\n" \
"  Make an L2-SR on Intelligence (25 - IQ). If you make it, go to {141}. If you miss, go to {233}."
},
{ // 175
"In the dungeons you make an interesting discovery. You find the magazine for the tower, in which they store the explosive fireballs which are sent up to the top via a lift. The orcs working down here are rather cowardly, so they surrender when you show up. There are 1d6 of them, each with an MR 10. Make a note of that.\n" \
"  Two strategies immediately suggest themselves. You can light the ammo on fire and escape before it explodes (you hope) or set a long fuse on one of the fireballs and send it up to the top of the tower. If you chose to light the magazine on fire, go to {21}. If you instead send a fireball up to the top of the tower, go to {224}."
},
{ // 176*
"The assistant librarian brings you a fairly new book, Don't Ever Blackmail Your Friends. It's the sequel to the old tome, Don't Ever Cheat Your Friends. In this volume the author drops all pretense at innocence, noting in the forward, \"The only folks you can blackmail are your friends, at least at the start. Then you branch out.\"\n" \
"  [Your use of this knowledge functions this way. To account for your added income stream, any treasure you get out of a solo dungeon run is increased by 10%. In a gamester situation or campaign, inform the GM of your skills, choose another player character, and let the GM set up the blackmailing scenario. Any IQ saving rolls in which the victim attempts to learn your identity will be made, in secret, against your IQ. (Which is a big clue as to who you should target.) Or, if you use this knowledge in a scenario to uncover who is blackmailing someone else, your IQ would be considered 10% higher for the purpose of any such saving roll.\n" \
"  ]Yes, if you choose to use this knowledge you will become richer, and you will head down the path of a life of crime. Or you could become a force for good. Choices, choices! You head home, knowing you're going to be living in interesting times."
},
{ // 177*
"You manage the ascent to the roof and hunker down. The goblins are chattering away and you're not certain what they're saying, but they sound excited. Then you hear the leathery flap of wings and a gargoyle descends and lands on the balcony. Evil power gathers around its claws.\n" \
"  If you decide to leap from your hiding place and attack the gargoyle, make an L2-SR on Intelligence (25 - IQ). If you succeed, go to {7}. If you fail, go to {160}. If, in this position, you begin to question your life choices and want to just head back home, go to {207}."
},
{ // 178
"Your last moments involve a lot of blood and fire. It's horrid and hot and insane. But, curiously, you feel no pain...except for a strong grip on your shoulder. You look up and see an assistant librarian picking your book up and laying it closed at your carrel (cubicle). \"Such a rousing tale. I'm surprised you were able to fall asleep. Alas, it is late, and we are closing. It is time to go.\"\n" \
"  You're not sure what really happened there, but you have a sense of story and drama that stands you in good stead in the future.[ Whenever you choose to tell a story in the future, make a saving roll on Intelligence against the IQ level of your target audience (their IQ - your IQ). If you make it, that person will be enthralled by your story and either give you gps equal to what you made the roll by or, if they don't have that much, will grant you a favour/give you local information which will be useful. If you miss the roll, they'll just think you're a crappy storyteller and wander off, intending to \"buy a REAL bard a drink.\"]\n" \
"  You wander home, your head full of adventure. Congratulations."
},
{ // 179
"You reach the tower's top. All resistance has died, but there, in the harbour, is a massive black warship, heading straight for the heart of the Ranger fleet. It's packed with troops and, worse, a contingent of Orcish shamans, ready to wreak magical havoc. Your only chance is to use the trebuchet to sink the ship.\n" \
"  The warship has an effective CON of 200. Each trebuchet fireball takes one turn to load, and one turn to shoot. Each fireball does 6d6 damage, but you can add in your combat adds from LK. Roll 2d6. If you are able to sink the ship in that number of turns or fewer, go to {215}. If you fail, go to {191}."
},
{ // 180*
"Your desire for self improvement is really laudable. Unfortunately, today you're just not at the top of your game as far as reasoning is concerned. The two of them whisper and cackle and fawn over you because you are the Chosen One, or Promised One, or the Fated One. And you begin to notice how your title changes right about the time that they stop in a dark alley and their confederates, on the rooftop above you start pitching stones down.\n" \
"  Take 6d6 damage, with armour taking normal damage. Regardless, you will be stunned and they'll loot you for double the damage in gold and equipment. (If you die, they take everything.) If you survive, you can limp back to {1}. If you survive and are bent on avenging yourself, make an saving roll on Intelligence against the amount of damage you took (damage - IQ). If you miss it, go to {219}. If you make it, go to {228}."
},
{ // 181*
"You're going to have to do some serious damage to get the heck out of the dragons's stomach. However, since the dragon's armour is on the outside, and the stomach is a tad tender, you have a chance. The stomach has an effective MR of 15. Attack and complete the first round of combat only. If you lost the first round, go to {138}. If you killed the stomach in the first round, go to {98}. If you merely won the first round, go to {150}. If you died in the first round, well, you'll just add to the bones slowly dissolving there in the stomach."
},
{ // 182
"Khazani blood drips from you. Fire crackles. You hear someone shout \"Abandon ship!\" Something snaps in the belly of the ship and the prow plunges downward precipitously. In league with other Rangers, you seek to flee the doomed vessel.\n" \
"  Make a saving roll on Intelligence against the base number of hits your armour takes (hits - IQ). If you make it, go to {161}. If you miss, go to {139}."
},
{ // 183
"Mingor Diamondfist left you for dead. You have two dice times 500 gold pieces in the gems you stole. Living in Gull will be dangerous for this character. Your survival potential is better if you enlist in the Khazani army (they're hiring for the solo adventure, Overkill). This adventure has been worth 2000 adventure points."
},
{ // 184*
"You pull a slender volume off a shelf. The cover creaks when you open it. Clearly this book hasn't been read in ages. The title is Don't Chew With Your Mouth Open. It's a practical guide to etiquette around the world and among the various races. The general gist of the text is that you should shut up, observe, and do your best to fit in. And you should learn to dance. As a result of absorbing this somewhat dry advice, you can add 1 to your Charisma; unless you are a human or orc, in which case you add 3. (C'mon, they need the help.)\n" \
"  I[f, on a return trip, you hit this selection again, you subtract 1 from your Charisma because no one likes someone who thinks they are better than everyone else and shows off with their dainty manners. Still and all, i]t's good day for you. Head on out and be a shining example to others.\n" \
"  Like the end of any of these adventures, if you want to see what else is going on in Gull, go to {1} and try another path."
},
{ // 185
"Ragged and bedraggled, battered and bleeding, you stumble through the deserted village and somehow elude the multitudinous search parties sent after you. You somehow find your way to a safe port and ship back to Gull, falling into a deep sleep on the way. You wake up in your own bed, in sweat-stained sheets, half convinced that what you experienced was a dream.\n" \
"  And we'll pretend it was. You get 500 aps for your adventure, and might think twice before venturing out to the library again."
},
{ // 186
"While the author's literary pretense and stylistic efforts really undercut the work, you do manage to glean some basic facts about dragon physiology. [While fighting any dragons, their kin, or really any higher forms of reptile, you can add two dice to your combat rolls. If those two dice double (match), add them and reroll again. If you have rerolled on the round in which the creature dies, add 10% to the loot you recover for that particular kill. The value comes from harvesting teeth, bones, skin and any other parts that someone might pay you for. ]This has been a good day for you. You really feel great and are pretty sure there's a pair of dragon skin boots in your future. Congratulations."
},
{ // 187*
"The Assistant Librarian brings you a slender, but well-thumbed book. It's one in the famous Penultimate Essential Survival Guide To... series. The books are just packed full of useful information and little known tricks for smoothing your time in a variety of awkward situations. Roll 2d6 to learn which guide you are reading.\n" \
"     2 = Dragon Lairs\n" \
"     3 = Festering Fens and Swamps\n" \
"     4 = Troll Holes\n" \
"     5 = Human Underworld\n" \
"     6 = Dwarven Realms\n" \
"     7 = Holiday Meals with Kin\n" \
"     8 = Elven Glades\n" \
"     9 = Orcish Secret Cults\n" \
"    10 = Secret World of Wizards\n" \
"    11 = Grimtooth's Traps\n" \
"    12 = Undersea Realms\n" \
"[Whenever you find yourself in a situation which is described by the title of the book you read, you have two benefits. First, your adventure points are increased by a percentage equal to your level. Second, you can deduct one level from all saving rolls in which your knowledge would apply. (Yes to making a throw to prevent insulting a dwarf; no on a Dexterity roll to prevent falling off a ladder in a dwarven realm.)\n" \
"  ]This really has been a great day for you. You've learned so much. Go home and sleep well."
},
{ // 188*
"As you're reading this book you really feel yourself falling in love with the Death Empress. Whether or not you find that prospect exciting, revolting or somewhere in the middle, the very realization of it snaps you back out of the story. It's only then that you realize the book is really a spell which is using your mind to allow the Death Empress to seduce you. Had you not snapped out of it, you'd likely have stolen away on a ship and headed for Khazan, to whatever ghastly fate awaited you there. Make an L2-SR on Intelligence (25 - IQ).\n" \
"  If you make it go to {137}.\n" \
"  If you miss it, go to {163}."
},
{ // 189*
"You leap forward as a trapdoor opens where you were standing. You land at the foot of the stairs making nary a sound, which is a miracle in and of itself. You creep up the stairs and in the upper room you spy a small gaggle of goblins who are holding the stolen books above a big, boiling pot of water. The steam curls pages and the goblins pull the bindings off the books. From the spines they manage to tease a slender pieces of ivory, about as long as your smallest finger, half as thick, into which have been etched odd runes. They pass the ivory sticks to the largest of their number, who is fitting them into a frame like pieces of a mosaic. Suddenly there's flapping of leathery wings and a gargoyle lands on the balcony opposite the stairs. The goblins begin to cower as dark power begins to coalesce around the gargoyle's clawed hands.\n" \
"  If you believe discretion is the better part of valour and want to escape with your life, go to {225}. If you want to dash into the room and steal the mosaic, go to {237}. If you want to make a mad, vainglorious assault on the gargoyle, go to {7}."
},
{ // 190*
"The goblin might be moving slowly within that cloak, but the second you grab him, he shucks it and pulls a dagger. He is MR 42. If you kill him, go to {56}. If you die, please take some solace in knowing that before he hides your body, he'll strip off anything which identifies you. He'll keep that and you're guaranteed to be at least a footnote in his memoir, titled Nasty Books and Stinky Scrolls."
},
{ // 191
"Though your fireballs have wrought incredible havoc on the burning black ship, the Orcs get themselves together. You see pulsing purple energy wreath them, then launch into a coruscating violet ball which, all things considered, looks rather cool until it hits the tower. The energy wraps itself around the stone structure's middle and begins to contract, crushing the tower and collapsing it down in on itself.\n" \
"  You, alas, don't survive this process. But, it may hearten you to know that you actually end up being mentioned in the memoir you were reading as having been part of the crew that sacrificed itself to save the Ranger Fleet. (The black ship burns to the waterline and the Rangers retreat in good order.) Somewhere along the line, a child you never knew you had, or maybe the child of that no-good second cousin of yours, will read your name and feel very proud for a moment."
},
{ // 192*
"You follow the crone and her young charge into the alleyways. You get the odd feeling that you're being watched, but when you look for people lurking in shadows, you don't see anything. Still something doesn't seem quite right.\n" \
"  If you want to ask the crone, Ursula, about where you're going, go to {217}. If you want to ignore your feeling of impending doom, blithely continue on to {145}. If you decide that this whole scenario is dodgy and attack her, go to {241}."
},
{ // 193
"As the dock workers close on the City Guard, you attack from behind. You slash and batter your way through them. The wounded fall and trip up others as the City Guard rushes forward and captures a number of them.\n" \
"  You tell the captain of the guard who you are and he nods knowingly. Diamondfist appears shortly and hands you 10 gems, each worth 500 gold pieces. \"Thank you very much. You have solved a big problem for us. Your actions were very brave.\" This adventure was worth 500 adventure points.\n" \
"  It also earns you an introduction to the Captain of the City Guards and he has a business proposition for you. Go to {81}."
},
{ // 194*
"Your life as a rep of Xiharezed begins.[ As an affiliate, you can buy healing potions, bandages and pretty much any of the cheap crap delvers need, at 10% less than market value. And you get to add 1% for every player character you sign up for Xiharezed. (You don't get a fee for their joining, that gets kicked up to Ursula.) And any player characters they sign up gives you an added .05% reduction in price. As you resell things, you may mark the price up to whatever you want.]\n" \
"  As things go, this isn't a big improvement to your life, but it's not a bad one. Good luck, you entrepreneurial genius you."
},
{ // 195
"Before you can bat an eye, the place is swarming with the Prince's Intelligence Service agents. They scoop up every bit of evidence they can find. A captain looks over the carnage, then looks at you. \"You did this, did you?\"\n" \
"  You blush. The Intel officer smiles and tosses you a purse that jingles with gold. \"Without the help of citizens like you, Gull will never be safe. Thank you for your service.\"\n" \
"  The purse contains 5d6+2 × 100 gold. You've done well. You can go home quite proud of yourself."
},
{ // 196*
"Since this is a family publication, we're going to be a bit delicate here. As much as you would like to deny any desire to be there, you actually are curious. Let's just say that what you see and experience will be enlightening, but not particularly uplifting. Make an L3-SR on Luck (30 - LK) and note how much make or miss it by.\n" \
"  If you miss, take hits equal to what you missed by. Also, you'll have to attempt that number of third level saving rolls on Luck (30 - LK), taking what you miss by as damage. (You have no time to heal during this process.) If you survive that ordeal, continue reading as if you made the first saving roll, but cut any rewards in half.\n" \
"  If you make it, you survive your ordeal. You get 2000 aps, plus 4d6 gp for your service. At the end of your service, you're released into the world, maybe a little bit wiser, and definitely a whole lot sorer."
},
{ // 197*
"You pick a book which has clearly been read a lot. It's one of The World's Best Jokes books - a renowned series that everyone loves and bards rely upon for fancy patter. Roll 1d6 to see which volume you got:\n" \
"    1 = Trolls\n" \
"    2 = Elves\n" \
"    3 = Nobles\n" \
"    4 = Wizards\n" \
"    5 = Dwarves\n" \
"    6 = Dragons\n" \
"You devour the book. It is hilarious, full of great puns, jokes and wonderful anecdotes.[ Armed with this knowledge, your Charisma and IQ are effectively 10% higher when dealing with the subject of your volume.]\n" \
"  You have definitely improved yourself. This has been a great day for you, so go home and, a word to the wise. That chuckling you're doing to yourself, yeah, kind of annoying, so you might want to curb that."
},
{ // 198*
"You're waiting patiently in your carrel for the librarian to bring you a book, but they just don't show up. But you notice, half-hidden beneath the lantern providing you light, a folded sheet of paper. You unfold it. It's an advertisement which reads: \"Are you an author looking for a publisher? We at Vengeance Press want to publish your book. Any subject, any length. Our success is your success.\" The library does seem to be popular, and you really do need something to do between adventures. And you have a story to tell. [You decide to take them up on their offer.\n" \
"  This is how it works. Pick a subject matter for your book (a people, a place. Check {187} for hints, but don't use those). For every creature in your subject area that you kill, you get a point. For every saving roll you make concerning your subject area, you get points equal to what you make it by, and deduct points equal to what you missed by. For every 1000 aps connected to your subject matter you get adventuring, you add a point. Once your points total 100, you've finished your research and have written your book. You get 3d6 × 100 in adventure points in royalties for your efforts.\n" \
"  Any time you hit this paragraph, you can begin another book on another subject matter. If you write and publish 4 books, go to {35}. ]Your adventure in the library ends here, but in life, it's just starting."
},
{ // 199
"You grab one of the goblin headbands and pull it on, then enter the water and start pushing that makeshift mine toward a Khazani Mage-frigate. You can feel the magical energy pulsing from the ship. As you get closer, you begin to doubt the mine will do enough damage to sink the ship. If you want to set the mine off toward the rudder, go to {212}. If you think it would work better toward the prow, go to {235}."
},
{ // 200
"As another contingent of Rangers races down into the dungeons, you and your Rangers head toward the top of the tower. Roll 1d6. This is the number of MR 20 orcs guarding the passage to the top of the tower. If you survive battling your way up the staircase to the top, make an L2-SR on Luck (25 - LK). If you succeed, go to {179}. If you fail, go to {246}."
},
{ // 201 (anti-cheat)
"Something sinister - a character flaw, most likely - caused you to read this paragraph. Oh, nice attempt to look away. Really. You almost made it. Almost. But your eyes were drawn back here and there's just no way to get here. Under normal circumstances, so you can pay for your crime, we'd make you write out the sentence, \"I will not read what I am not supposed to read,\" a hundred times. Then again, don't we all find the forbidden irresistible? You're only human, so just focus next time. If you can't remember where you came from, go to {1}."
},
{ // 202
"You stand in the half-light facing Morgo. Both of you circle, daggers at the ready. From the shadows step two men. Each of them has a rapier. \"Rais,\" says the taller of the pair, \"watch Mingor's agent while I relieve Morgo of his gems.\" The smaller man holds you at bay; he looks very deadly with his rapier aimed at your belly. Marek takes the gems from Morgo, and clips Morgo on the head. The big man goes down unconscious. \"I'll take the gems, you can have Morgo and the reward. Fair trade?\" Marek laughs as he leaves.\n" \
"  Diamondfist comes into the alley as the rogues leave. \"Not your fault Marek got the gems. The shipment was for him anyway, some debt the city is paying off. At least you have Morgo,\" he says. You return with him to his office, where he pays you the 5000 gps promised, and an extra 2500 for capturing Morgo. This adventure was worth 1750 adventure points.\n" \
"  Furthermore, given your success, a servant from the Palace comes and informs you that the Prince of Gull would like to meet with you. Go to {87}."
},
{ // 203
"You escape the tower in time to watch its destruction. Twin explosions, one at the top, the other in the dungeons, blossom into beautiful red and yellow fire. The tower's foundation cracks. Stones crumble. The tower sags and then falls, the loose stones an avalanche that crush two Khazani Mage-frigates, sending them to the bottom with all hands.\n" \
"  Your actions herald a Ranger victory. The Rangers sweep the sea of Khazani forces. They land and loot the area, then withdraw strategically before the Death Empress deigns to take notice of their effort and destroys them.\n" \
"  Your share of the loot is 4d6+3 × 1000 gps. You bury it and leave clues as to where it's hidden, as do the other Rangers.[ Thus, in the future, after you've hunted down your own treasure, you have a sixth sense about buried pirate treasure. When in an area where pirates are known to be active or have been active, make an L3-SR on Intelligence (30 - IQ). Roll 1d6 per point you make it by, and multiply that by 100. That's the gp value of the trove you find.]\n" \
"  You awaken in the morning in your bed, not sure how you got there, but you know exactly where your trove is. This adventure has been worth 1000 aps."
},
{ // 204*
"A librarian's assistant, in blue robes trimmed with silver thread, barrels down the stairs and shoos the urchin and its blind mistress away. \"No, no, none of your games here today, Ursula. Begone.\"\n" \
"  The urchin and crone have select words for the assistant, but they are ignored. The assistant helps you to your feet. \"I'm frightfully sorry for the trouble. You'd not believe how many people are stupid enough to fall for their trickery. Clearly, you are above that. Let me show you inside. We have many books which might interest you and, if you desire, I could even direct you to the Special Collection.\"\n" \
"  If you just want to browse through the library, go to {105}. If you want to explore the special collection, go to {216}."
},
{ // 205*
"Okay, this is kind of creepy. All the while you've been in the dragon's mouth, doing what you're doing, you failed to notice something. This dragon is already dead. The draft you felt in the throat from breathing? Nope, just wind flowing in through a huge hole in the chest. A hole you discover as you slip back down the throat and out through the lungs. And the truly creepy thing? The dragon had that hole ripped into his side by a dozen scaly nestlings that are busily gnawing away on the corpse.\n" \
"  But they don't notice you. You drop into the nest, grab a handful of gold to stuff into a pocket, and somehow - miraculously, truth be told, given your luck so far - you make it safely away from the nest of death.\n" \
"  The treasure you snagged is worth 2d6+4 × 100 gps. Congratulations."
},
{ // 206*
"Ursula leads you to a small, dimly lit room full of all manner of the kindred. She points you to a chair toward the front of the audience, then she begins to hold forth. \"I want to give you all the chance of a lifetime. We represent Xiharezed, a company that markets our own brand of healing potions, salves, bandages and other necessaries for the delving community. You'll be able to sell direct to adventurers and, better yet, offer them an opportunity to join you as one of our affiliates. As they sell, you make money, too. Now, if you sign up here and pay your initial deposit on our starter kit, your new life begins.\"\n" \
"  Roll d6 equal to the number you missed the saving roll by. That's the cost in gold for your starter kit. If you choose to pay that, go to {194}. If you opt out of joining, go to {158}."
},
{ // 207*
"You make your way back to your home, reflecting on all that has happened - here, today, and throughout your life. You meditate on what has gotten you to where you are now. You perceive a pattern to life, and you believe you have a line into some cosmic wisdom that unites all life and guides us to the fate we deserve. (Really you're just dehydrated and your blood sugar is crashing).\n" \
"  You sit down and write out all the wisdom that's just coursing around in your skull. You produce a masterwork of the self-help genre. You title it You CAN Be Better! You publish it and almost immediately you're flooded with requests for the rights to translate it into various languages.\n" \
"  So, the bad news is that copyright really doesn't exist here. It's a conspiracy by the wizards to keep public access to grimoires and spells clear. Thus your book is pirated and [while you make 4d6+5 × 100 gps once a year, ]you don't get rich. BUT, your book does touch people's lives. [So, in any scenario, where you can meet a potential reader, if you can make an L3-SR on Luck (30 - LK), you'll find an NPC who has embraced your book. They'll do you one favour to pay you back. ]See, not only did you improve yourself, you improved other people."
},
{ // 208*
"Your native elusive abilities allow you to escape pursuit. You puzzle your way through the Death Empress's palace, deftly avoiding patrolling guards and others. The curious thing is that you recall some of the facts from the book and believe you have found a way out. You cut left down a corridor and there, at the end of the hallway, as you expected, is a golden door beyond which should be freedom.\n" \
"  Then, from the shadows, steps an orc shaman, power shaping a sphere around his hands. He gurgle-grunts something at you. (Rough translation: \"Fool, I read the book, too. Now you must die.\") He has an MR of 35. If you kill him, go to {136}."
},
{ // 209
"It is plain that you are not King material. Furthermore, you have made it necessary for them to reset the situations in the cave. They take you and sacrifice you to their gods in the hope their king will come soon."
},
{ // 210*
"As you browse through the stacks you notice a goblin furtively weaving his way in and out of the area. You might not really be concerned, but he's wearing a fairly heavy cloak. We're not talking weight of material, but the weight of the books and scrolls he's stealing and stuffing into pockets sewn on the inside.\n" \
"  If you decide this is none of your business and want to keep browsing, go to {240}. If you want to grab the little rascal, go to {190}. If you want to follow him and see what's going on, go to {140}."
},
{ // 211
"You've killed the goblins and have prevented them from attacking the Ranger fleet. But, you know, you have these mines here. You could swim one out to a Khazani ship and blow it up. If you choose to do that, go to {199}. If you think you've really done enough at this point, go to {238}."
},
{ // 212
"You attach the mine to the rudder. You crank the crank and punch a button. Gears whirr. Sparks fly. Something starts hissing. You're pretty sure this is going to blow up. You need to swim for your life.\n" \
"  Make an L2-SR on Speed (25 - SPD). If you succeed, go to {227}. If you fail, go to {234}."
},
{ // 213
"You attempt to look innocent, but to no avail. The patrol boat heads straight for you. You must make a decision quickly. If you want to jettison your cargo, go to {73}, or if you want to bribe your way out, go to {129}. You can try to talk your way out-do that by going to {103}."
},
{ // 214*
"You have this very odd feeling and black out for a moment. As you come to, you notice two things which you find decidedly disturbing. First, you're no longer in the library. Second, and far more important, you're wearing some flimsy, filmy something made of fabric so light that a spiderweb would feel like mail. Adding to your discomfort is the fact that you find yourself in a room full of people with members of all sexes and kindreds (including a few of each which you can't truly identify). They lounge on pillows and mechanically go through idle pursuits like brushing out their hair and chasing down nits.\n" \
"  Off to your right, a slovenly satyr looks at you and grins. \"Oh, the book worked again. Fresh meat. Follow me for preparation.\"\n" \
"  If you follow meekly, go to {243}. If you choose to dodge past him and run away, go to {147}. If you choose instead to ask exactly what's going on here, go to {159}."
},
{ // 215
"As that last fireball arcs down toward the ship, it is truly a thing of beauty. It strikes the target perfectly amidships. A fireball pierces the main deck and explodes deep, blasting the hull apart. Water gushes in and the ship snaps in half. Fire rings the ship, and the Khazani personnel go down to the bottom.\n" \
"  You and your Rangers are hailed as heroes by the rest of the Rangers. They celebrate you and give you 6d6 × 1000 gps as your part of the plunder. As do all of you, you secret that away in a chest that you bury. You waken in your bed with full knowledge of where that trove is hidden, so you recover it easily.\n" \
"  [More importantly, you learn enough to know the secret signs and language of pirates. In a stroll down the docks you see men who have walked that path before, or the merchants who trade with pirates. Because of this knowledge, any time you need to find a contact, fence an item, or obtain contraband (at the friends and family discount), just make an L2-SR on Intelligence (25 - IQ), and you'll find the source you need. ]It's been a long and exhausting day for you, but fruitful. Well done."
},
{ // 216*
"The Royal Library's Special Collections area can only be accessed through six locked and gated doors, then up a spiral staircase, down a corridor (which feels like you're going sideways somehow), and through a low doorway so narrow that you have to enter it shoulder first. The inconvenience is definitely worth it, as the space is full of rich, warm woods, impeccably clean, with assistants in white gloves flitting around, bringing books to people seated in semi-private carrels.\n" \
"  The head librarian, a tall, slender and slightly stern looking woman greets you just inside the door. \"No, no, say nothing, I know the perfect book for you. Go to your carrel and we will bring it to you.\"\n" \
"  Roll 2d6 and add the result. Please go to the paragraph indicated by the result below.\n" \
"     2 = {229}\n" \
"     3 =  {49}\n" \
"     4 = {231}\n" \
"     5 = {220}\n" \
"     6 =  {14}\n" \
"     7 = {198}\n" \
"     8 = {187}\n" \
"     9 = {176}\n" \
"    10 = {164}\n" \
"    11 = {153}\n" \
"    12 = {142}"
},
{ // 217*
"\"I'm very glad you asked, child.\" You find her voice soothing. \"I'm going to give you the opportunity of a lifetime, one which will launch you on the path to financial freedom and liberty. That's for you and your friends and family.\"\n" \
"  Given her circumstances, this claim sounds dubious, but she seems sincere. Make an L2-SR on Intelligence (25 - IQ). If you miss, keep track of what you missed by and go to {206}. If you make it, go to {170}."
},
{ // 218*
"When you first attacked, you startled the dragon and it launched itself skyward. Lucky for you, it clipped a wing on a rock, spun around, raked huge furrows in the ground with its claws, and expired because of the internal damage you managed with your attack.\n" \
"  You manage to slip through a rent in its armour and discover that the crystalline liquid oozing from the back side of the scales is soaking into your skin. It itches a bit, but [does two things. First, ]all those wrinkles and scars, they're just gone. Your skin is now silky smooth.[ More importantly, your skin acts as 2d6 of armour. Whenever you're hit, roll 2d6 and take that much less damage.]\n" \
"  In addition, you pull 3d6+3 × 100 gps from the dragon's body cavity for your trouble.\n" \
"  This wasn't the easy day reading you expected, but you're definitely improved. Congratulations."
},
{ // 219*
"Ursula and the urchin have left you for dead, but the local alley rats can smell blood. Roll 2d6. That's the number of MR 5 rats you have to fight. Remember, you've had no time to heal from your previous damage. If you beat them, you can scrounge around and find 2d6 silver coins in the alley. Take them and head home. Use them to buy something to kill the pain of your injuries. Your day is done."
},
{ // 220*
"An assistant librarian appears at your carrel with a rather thick volume. Using a soft cloth, she flicks dust off the top edge. The lettering on the spine is faded and rather quaint. Definitely an old book. The title is Don't Ever Cheat Your Friends. It's a voluminous guide to games of chance which details, in cautionary terms, all the ways one can cheat at the game. The author seems quite sincere when he admonishes you that you should never cheat anyone, and especially should never do it using any of these methods. [As a result of absorbing this solemn advice, you can add 5 to your IQ or LK when involved in games of chance, for the purposes of a saving roll (or you can add a gambling talent to your character). You'll usually be able to spot cheaters, and what you do with that knowledge is up to you. ](The back of the book has an ad for the sequel, Don't Ever Blackmail Your Friends.)\n" \
"  Still and all, this is good information. And you're not worried about cheating your friends - one would have to have friends, first. So, go out, take a chance, and make some friends."
},
{ // 221*
"You don't notice it until your battle is done, but the dragon opened its mouth during the fight. Its tongue curls around and nudges you out. You raise your hands defensively - against the sunlight; you're not afraid of the dragon after all.\n" \
"  The dragon stares down at you and says, \"Think you would mind climbing back in here and killing a few more of those? They're really giving me toothaches.\"\n" \
"  You agree, of course, because you really have no choice. The dragon, grateful, wets a claw and draws something on your forehead, its touch featherlight. He also hoiks up a small pile of gold. \"Thanks for your help.\"\n" \
"  The gold is worth 2d6 × 1000 gp. [More importantly, he drew a sigil on your head which dragons can see. It basically indicates you're a trusted dragon dentist. Any dragon you encounter will recognize the mark and in exchange for you cleaning his teeth, will give you gold, or do you a favour. (Some dragons are contrary or illiterate, so this might not always work.) ]Patience has paid off for you. Well done."
},
{ // 222
"This is the moment of decision for you. If you want to forget your mission, meet a major gang leader (Mr Big) and become  a criminal, go to {75}. If you want to use this new confidence in you to get deeper into this organization so that you can turn them over to Diamondfist, go to {95}."
},
{ // 223*
"This is a pretty small book, which should surprise you because it promises a whole program of enlightenment within its pages. The title is The Purposeful Pilgrimage.[ It outlines a series of tasks which, when you perform them, will unlock the wisdom of Chapter 42. (No, you're not cheating when you flip to Chapter 42 and discover the pages are all blank.)\n" \
"  Here's how it works: Before any adventure (solo or otherwise), roll 1d6 and record the result below:\n" \
"    1 = Witness a Wonder\n" \
"    2 = Congratulate a Cretin\n" \
"    3 = Divining with Dwarves\n" \
"    4 = Working with Wizards\n" \
"    5 = Denigrate a Dragon\n" \
"    6 = Save a Savage\n" \
"If anything you do in that adventure can be construed as fulfilling your goal, you can check that category off. Once you have checked all the categories off, come back to this book and read paragraph {251}.]"
},
{ // 224
"You feverishly work the windlass to send the fused fireball aloft. Roll 1d6. This is the number of combat rounds you have to accomplish this task. For the purpose of measuring your effort, the windlass has a CON of 100. Once you bring it to zero, it's up there and you can escape the tower.\n" \
"  Here's the complication. 1d6 of MR 16 orc troopers head down to stop you. Also, for each round of combat, one of the MR 10 orc workers will join the combat. You can split your combat total however you want, devoting some of it to killing the orcs, the rest to the windlass. If you get the fireball to the top in time, kill the orcs and escape the tower by going to {203}. If you fail to get the fireball to the top, [or die in the attempt, ]go to {178}."
},
{ // 225*
"It's been kind of distracting, this whole sneaking around thing. Just how distracted you are will determine whether or not you remember that open trapdoor in the floor along your line of retreat. Make an L1-SR on Luck (20 - LK) or Intelligence (20 - IQ), your choice. If you make it, go to {146}. If you fail, record how much you miss it by and go to {42}."
},
{ // 226
"You're not sure how to evade the archer. You push off the ship and start to swim away. A second arrow hits you in the back and a leg goes numb. You struggle in the water and while no other arrows reach you, you can't get out of the mine's blast radius. More about that later.\n" \
"  The mine does the job, so you should be happy about that. It blasts the keel into toothpicks. The ship's forward momentum drives water deep into the hull. A wave crashes over the forecastle, and the ship heads to the bottom. Without the Mage-frigate, the Khazani fleet is powerless to defeat the Rangers and the Rangers, thanks to your sacrifice, manage to retreat in good order.\n" \
"  Oh, yeah, later is now. Go to {178}."
},
{ // 227
"You deftly plow through the water and, at the last second, duck beneath the surface. The bomb detonates, ripping a great hole in the ship's aft end. Water gushes into the hull and the ship goes down fast. Drowning sailors and mages strike for the surface, but few of them escape.\n" \
"  You watch, fascinated, ears ringing from the blast. It occurs to you that you're not having to breathe while under water, and that's because of the magic on the goblin headband. That's yours to keep.\n" \
"  You surface in time to be picked up by a Ranger vessel. You and your pirate compatriots celebrate the defeat of the Khazani fleet, all the while beating a hasty retreat. Your share of the loot confiscated in the raiding which preceded this battle is 3d6 × 200 gps. Dreaming of such loot, you fall asleep in your hammock, and when you awaken again, you're on a small ship bobbing in Gull's harbour, your sea chest full of your loot. Yours was a rousing adventure worth 1000 ap. Well done."
},
{ // 228*
"You stare into the depths of the alley, that dark, dark alley, and an old saying comes to mind: \"When you reach bottom, stop digging.\" You realize that pursuing them, bleeding as you are, is only going to result in you falling into another trap. You emerge from this experience a bit wiser, so add 1 to your IQ and call it a day."
},
{ // 229*
"A white-gloved assistant brings you a dusty old adventure yarn entitled Out of the Belly of the Beast. It's a rousing, autobiographical tale, apparently written by a female adventurer who managed to get swallowed whole by a dragon. It's quite engrossing, and you feel yourself being drawn into the story.\n" \
"  Make an L1-SR to Luck (20 - LK). If you make it, go to {186}. If you miss, go to {156}."
},
{ // 230*
"What a day this has been, right? You think you'll go to the library and do some light reading, then WHAM you're in a dragon's stomach. A dragon which, when you first attacked, took off into the air. Your subsequent attacks had the desired effect of killing the dragon, but you're in the air. And losing altitude fast.\n" \
"  Make an L2-SR on Constitution (25 - CON). If you make it, go to {245}. If you fail, the dragon's death spiral smashes him and you into a mountainside, which collapses, so the corpse ends up deep in a cavern somewhere. In about 200 years, a team of dwarven archaeologists will uncover the body and they'll find your remains in the belly. Your well articulated skeleton will spark a centuries-long debate with lines drawn on whether or not you caused the death, or were merely an unfortunate passenger. You'll keep lots of graduate students very busy."
},
{ // 231*
"The assistant, a dubious look on her face, brings you a furry cover with odd sigils worked in gold on the cover. The title is Where Weres Were and Why. It's a thrilling collection of stories by a wizard who made a career of hunting down stories about were-creatures, and then hunting said creatures down. His theory is that there are two types of were-creatures: those which are born that way, and those which facilitate the change.[ What you've learned will allow you to become a were-creature if you do the following: Step One: eat the fresh heart of the creature you wish to emulate. Step Two: Make an L2-SR on Intelligence (25 - IQ) to transform (L2-SR on Intelligence (25 - IQ) if you didn't do the killing and butchering to get the heart). If you make it, you transform and can modify your stats as appropriate. The change lasts a day.\n" \
"  If you fail the roll, you don't transform. If you fail because you rolled below a 5, you transform into a pocket version of the were you wanted to become, with all your stats dropped to 2 except for IQ, CON and CHR (you are darn cute.) You're basically a living plushy toy. Successfully transforming into another were will put you in that form and, again, the transformation lasts for a day.]\n" \
"  You find the result of your foray into education a bit unsettling, but you're definitely glad the librarians decided to lock this book in the special collections. You head home, eying every odd creature in Gull, certain that a few of them, the cute ones, are people who read what you did and got stuck."
},
{ // 232*
"It occurs to you that the guards really didn't make any solid attempt to stop you. In fact, they seem more concerned with placing bets, and odds are being shouted after you. Make an L2-SR on Intelligence (25 - IQ). If you succeed, go to {208}.\n" \
"  If you fail, you soon see why the guards aren't in hot pursuit. The corridor down which you are racing becomes a ramp. That feeds into tunnels which, at about the point your lungs are burning, open onto Naked Doom. Open that solo and continue your adventure. (If you don't have Naked Doom, you somehow managed to elude pursuit. Disguising yourself as a beggar and selling off your finery, you raise 3d6+3 gold and bribe your way on a ship headed out of Khazan.) This has been worth 1000 aps."
},
{ // 233
"It seems rather obvious to you that heading straight for the tower is a decidedly suicidal strategy. Without a doubt, making landfall at that little fishing village closer up the coast from the tower is a better plan. You and your compatriots head in that direction.\n" \
"  Make an L2-SR on Luck (25 - LK). If you succeed, go to {247}. If you miss it, spotters atop the tower see your boat coming in toward the village. They turn their trebuchet on your group, launching a fiery metal sphere festooned with jagged metal spikes which explodes in the midst of your group. You take 6d6 damage. If you somehow survive that, go to {185}."
},
{ // 234
"Okay, so, first the grand, heroic news. The bomb explodes as expected, blasting the rudder to flaming splinters. The ship, which is no longer under steerage, careens into the battle, heading toward the Khazani flagship. The flagship's orc Shamans unleash unholy magics on the Mage- frigate to fend it off. The Mages, finding themselves under attack, shoot back. The resulting magical storm obliterates both ships, allowing the Rangers to disengage and get away. The bad news: you didn't get out of the mine's blast radius. It wasn't good. Go to {178}."
},
{ // 235
"You get the mine to the prow and affix it there. You twist a knob, pull a lever and flip two switches. A mechanism begins to whine deep inside the device.  An arrow lances down into the water beside you. An orcish archer on the foredeck has seen you. Make an L2-SR on Intelligence (25 - IQ). If you make it, go to {252}. If you fail, go to {226}."
},
{ // 236*
"Oh, you are quite clever, aren't you? You skipped past all the popular trash and snagged the somewhat obscure but highly lauded philosophical masterpiece Learning From Our Mistakes. The general gist of the book is that any failure is simply the opening of a door to enlightenment.[ From this point forward, when you are on an adventure and miss a saving roll, record how much you missed by. At the end of the adventure, total up these points. They represent the percentage increase in any final experience award for that adventure. (You miss a roll by 5 points, you get 5% more experience at the end of the adventure.)]\n" \
"  Yes, this has been a banner day for your self-improvement self. Well done. Now, go out there and almost die, so you can become smart enough to realize that you might be going about this adventuring thing the wrong way."
},
{ // 237*
"Not all of the goblins are fighters, but one of them throws a spear through the gargoyle and it falls out of the window. (At least you don't have to worry about the gargoyle now.) Roll 1d6. This is the number of MR 10 goblins you have to fight, plus their leader, who has an MR of 15. If you survive the combat, go to {149}."
},
{ // 238
"You're absolutely right. I mean, you were in the library reading, and now you've intervened in the course of history. That's pretty much enough action for one afternoon. The Rangers celebrate your activity (not believing the whole library thing) and your share of the loot from this expedition is 3d6+4 × 100 gps.[ More importantly, you get a good look at how those fireball mines look. In the future, if you attempt to disarm a trap, you can deduct one level from the saving roll.]\n" \
"  You celebrate, you fall asleep, and you wake up in your own bed, with your small chest of loot as a pillow. Well done."
},
{ // 239
"Being bored and having extra time on your hands, you decided (quite unwisely - bet you wish we'd said that before) to venture out into the jungle surrounding Gull, that bastion of civilization otherwise known as The City of Terrors. You get a few miles from the city and find yourself set upon by twenty Klorven warriors, the painted barbarians of Ajor. They capture you and strip you of your clothing and weapons. They don't kill you because they think you look like you might be a reincarnation of an legendary tribe leader who promised to return to them one day...\n" \
"  You have one chance to live. They usher you into the mouth of a cave. Within you will be presented with a battery of tests that will determine if you indeed suitable to become the tribe's leader. For the successful completion of each task you will receive a wooden Token. Keep track of the number you obtain during the trip.\n" \
"  If you are ready, naked and unarmed as you are, proceed inside...Before you is a massive stone. You can see where countless others have worn handholds from trying to lift it. If you wish to pass it by, go to {51}. If you want to try to lift it, go to {71}."
},
{ // 240*
"The book you pluck off the shelves is a lusty old romance tome entitled I Was The Death Empress's Love Slave. It's a chilling, autobiographical tale, reportedly the work of an elven prince. It's quite mesmerizing, and you feel yourself being drawn into the story.\n" \
"  Make an L2-SR on Luck (25 - LK). If you make it, go to {188}. If you miss, go to {214}. If you are of elven descent, go to {151}."
},
{ // 241*
"You attack Ursula and her young charge with the advantage of surprise. Deduct your initial attack from their combined MR of 40, then continue to fight. If you win, you loot the bodies for 3d6 gold pieces, and a nifty little ring on her finger that allows you to cast a Cat's Eye spell on yourself.\n" \
"  You're unclear how choosing to kill a crone and an urchin is really much in the way of self-betterment, but your purse is heavier, and you can now see in the dark, so it's not a bad day at all. Tomorrow, you can go to {1} and wander Gull once again..."
},
{ // 242
"If you tried a spell, it failed. \"A spy, men, get him!\" the guard croaks. You point to the window he went through. Black-armoured guards pour up the wall and into the Palace. You hear the sounds of a fight, then a scream. One of the guards appears at the window with a head held aloft by its hair.\n" \
"  You have succeeded. You get 200 adventure points plus the 2500 gold pieces promised for a dead spy. They also give you the pardon and make you a Knight of Valour: Gull's legendary award for civilians who have done a great service to the city. This adds two to your Charisma.\n" \
"  After speaking with an advisor, Prince Arion, the 14 year old Prince of the City, asks for you to be brought to him. Go to {87}."
},
{ // 243*
"The satyr leads you deeper into the palace. Servants wash you, dry you, add perfume, dress you in finery, and apply just a hint of cosmetics. Then the satyr brings you into a small group of others who have been similarly primped and processed. You're led into a vast, cavernous chamber, at the heart of which is a bed. It appears as if it has been constructed out of bone - bone which has been half melted, braided, then fused. And the canopy is the weaving of countless spiders.\n" \
"  A figure arises from the bed, tall, hauntingly beautiful, and yet terrifying in her aspect. Slowly, languidly, she paces back and forth, then starts down the line. Finally she comes to you.\n" \
"  Make an L3-SR on Charisma (30 - CHR). If you succeed, go to {112}. If you fail, go to {84}."
},
{ // 244*
"Someone grabs you by the shoulder and shakes you. The book falls from your hands, the spell broken. The assistant librarian looks down at you. \"Your snoring has disturbed other patrons. I am afraid I must ask you to leave.\"\n" \
"  A little shaken, given your experience, you head on out. Still, this has been worth 1000 aps. Well done. You can go to {1} and try another path."
},
{ // 245*
"You would really have liked to be on the outside watching the dragon hit the ground. The tail dragged for a bit, then a foot clipped what had been a tall, rock natural wonder, then the beast began to roll. You remember the start of the rolling, then you blacked out. When you come to, you see a couple of people thrusting a torch into the side of the beast and they help you out.\n" \
"  The local shaman tries to explain how you survived. It comes down to a mystical quality he calls bounce. He claims it's part of a systemic fluid in the dragon - a fluid in which you have been stewing.\n" \
"  [From this point forward, deduct one level from any saving roll against falling damage. ]Also, the dragon, which the villagers harvested as they were feting you and tending to your wounds, fetched a decent price in the wizarding after-market. Your share comes to 3d6 × 100 gps. Your adventure is done. Congratulations."
},
{ // 246
"As you make it to the tower top, an explosive fireball conveyed up to the roof from the dungeon magazine appears in a lift box. With a fuse. A lit fuse. In the half-second of clarity you have left, you realize that the Rangers from below sent it up in hopes of blowing the tower top to bits. It explodes, and you really wish they'd been confident enough in your skills to believe you'd make it all the way up there. Go to {178}."
},
{ // 247
"The village appears deserted, save for that one shack down near the jetty. You creep close and see a rather curious sight. A group of goblins are pushing miniature versions of the tower fireballs on small rafts into the water. Odd runes pulse on the unlit fireballs and on the headbands the goblins have tied around their heads. Both bombs and goblins begin to fade from sight.\n" \
"  Roll 1d6+2. This is the number of MR 20 goblins you need to kill to stop these living mines from reaching the Ranger fleet. If you succeed, go to {211}."
},
{ // 248
"You noted he never attempted to go to the surface during your fight. You pry a ring off one of his fingers. It is fashioned in the shape of a fish which is biting its own tail.\n" \
"  You pocket the ring and swim out of the boathouse. The ring will allow you to spend 5 combat turns underwater without having to breathe. The ring functions only in water, and must spend at least 5 combat turns out of water for it to be fully recharged. You are done and have earned 1200 adventure points."
},
{ // 249*
"Oh, very wise choice. You've selected the volume The World's Most Valuable Coins. It's a comprehensive guide to coins minted the world over. It explains exactly what to look for to differentiate valuable coins from counterfeit. With your sharp eyes and quick wit, this is going to make you a fortune.\n" \
"  [At the end of any adventure, total up the gold value of the coins you obtained (gems not included) and divide that by 100. Make an Intelligence saving roll against that number (number - IQ). (Example: 2000 gold ÷ 100 = 20, so you're making a saving roll on Intelligence versus 20 (20 - IQ). For every point you make the throw by, you add 10% to the total value. If you miss, for every point you miss by, you deduct 10%. (You get no adventure points for this valuation throw.)\n" \
"  ]This, indeed, is your lucky day. You head home happy, just certain you can hear the coins jingling in your purse."
},
{ // 250*
"Unbearable agony. No, not from the dragonfire, though that did hurt something horrible. No, that's from waking up in an infirmary, swathed in bandages, listening to healers discuss your case and ridicule you for having made so foolish a choice.\n" \
"  Word of what you did spreads, pardon the pun, like wildfire. Everyone will know what you did. Cut your Charisma in half. [But, on the other side of things, you have 2d6 armour against heat damage (lava, fire) for surviving the last of the dragonfire. But on the third hand (c'mon, it really was a bad choice) you take double damage from cold based attacks and heal half as fast (magically and otherwise) in the cold. ]It's been a wild ride for you. Head home and stay warm."
},
{ // 251*
"You open your copy of The Purposeful Pilgrimage and thumb through to Chapter 42. As if by magic (of course), words begin to materialize on the page in a beautiful, flowing script. Really, so very beautiful. It's like elves dancing. It almost brings tears to your eyes, which is why it takes a moment or two for the words to swim into focus.\n" \
"  \"Congratulations on completing The Purposeful Pilgrimage. You have no doubt seen many things and had many wonderful adventures. The wealth of knowledge you have accrued, and the friendships you have fostered, are the most valuable possessions any thinking individual could ever have. Enlightenment is now yours to share.\n" \
"  Which means you're ready to move on to our new book, Repurposing the Purposeful Pilgrimage, which we will make available to you at the low, low price of 500 gold pieces (or equivalent). Hurry, supplies are limited. Mystical operators are waiting for your order.\"\n" \
"  [You are, of course, feeling ashamed at being hoodwinked, but then you figure your own way to repurpose The Practical Pilgrimage. From this point forward, in public houses and open spaces, jail cells and any place else where people have ears to listen (or eyes to watch you perform an interpretive dance) you will hold forth on the meaning of The Purposeful Pilgrimage. Every person who is in earshot will have to make an IQ saving roll against your IQ or CHR (their choice). They have to give you gold pieces equal to what they missed the roll by and, if broke, will find another way to repay you. (Usually a day of servitude for each point they missed by.)\n" \
"  ]You've definitely bettered yourself. Very well done."
},
{ // 252
"You're not going to give that archer another chance to shoot you. Almost by instinct you just left yourself sink, drifting beneath the waves. Arrows strike all around you, but the water acts as armour, stopping them before they can find you.\n" \
"  Above the mine detonates, ripping a gaping hole in the ship's prow, right at the waterline. You can feel the suction as the Mage-frigate plunges prow-first into the waves and strikes for bottom. Drowning mages and sailors slowly drift toward the surface. It's all very quiet down there.\n" \
"  You watch for a bit, and realize you can breathe water. That's the magic on the goblin headband, which is yours to keep. You also see this black bow chased with gold floating down toward you. It glitters with magic. You grab it. For any shot, roll 2d6. You either can add that total to [the damage you do, or add it to ]your Dexterity for the purpose of a targeting roll.\n" \
"  When you finally reach the surface a Ranger boat picks you up. The Rangers celebrate their victory lustily, all the while beating a hasty retreat \"for strategic reasons.\" But, they do manage to divvy up the loot they made during the raiding that preceded that battle. Your share is 5d6+3 × 1000 gps. In addition you get 1000 aps for the adventure.\n" \
"  You celebrate hard and fall asleep. You wake up in your own bed, wondering if it was all a dream. Then you see a sea chest with your loot in it, and know, though strange, this adventure was quite real."
},
{ // 253*
"When you boil everything down, the author's message is this: You only die when you believe you are dead. It's profound, and simple, and will have great impact in your life.[ This is how it works. From this point forward, when you die, record the amount of overkill (hits above your CON) that kills you. If you can make a saving roll on Intelligence against that number (number - IQ), you do not die. If you are in a place to heal, you will heal at a normal rate.]\n" \
"  This is definitely an illuminating discovery, so you have improved yourself. Congratulations. This adventure is over.\n" \
"  To leave the Library and see what else is going on in Gull, go to {1}."
},
};

MODULE SWORD el_exits[EL_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  { 239,  41,  61, 131,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  { 202,  36,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  80,  40,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  92, 148,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  68,  48, 107,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  52,  33, 102,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  { 144,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  34,  55,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  { 104,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  { 104,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  46,  66,  86,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  22,  72,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  { 183,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  19,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  60, 123,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  { 193,  93,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  { 248,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  68, 107,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  79,  99,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  { 222,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  27,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {  88,  48,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  18,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  { 111,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  {  15,  85, 155,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  { 154, 167,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  11,  31,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  46,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  { 196,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  { 121,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  { 101,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  { 108,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  { 222,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {  61,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  { 127, 120,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  12,  32,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  51,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  25,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119
  { 110, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  {  82,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  { 182,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  { 174,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  { 152, 177,   1,  -1,  -1,  -1,  -1,  -1 }, // 140
  { 200, 175,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  { 125,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  { 205,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  { 169,  63, 181,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  { 174,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  { 221,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  { 216, 105,   1,  -1,  -1,  -1,  -1,  -1 }, // 168
  {  77, 133,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  {  82,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  { 205,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  {  54,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  {  21, 224,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  { 207,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  {  98,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  { 139,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188
  { 225, 237,   7,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191
  { 217, 145, 241,  -1,  -1,  -1,  -1,  -1 }, // 192
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198
  { 212, 235,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203
  { 105, 216,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207
  { 136,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209
  { 240, 190, 140,  -1,  -1,  -1,  -1,  -1 }, // 210
  { 199, 238,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212
  {  73, 129, 103,  -1,  -1,  -1,  -1,  -1 }, // 213
  { 243, 147, 159,  -1,  -1,  -1,  -1,  -1 }, // 214
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216
  { 170,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221
  {  75,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223
  { 203,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 225
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 226
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 227
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 228
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 229
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 230
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 231
  { 208,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 232
  { 247,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 233
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 234
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 235
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 236
  { 149,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 237
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 238
  {  51,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, // 239
  { 151,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 240
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 241
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 242
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 243
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 244
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 245
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 246
  { 211,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 247
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 248
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 249
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 250
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 251
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 252
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 253
};

MODULE STRPTR el_pix[EL_ROOMS] =
{ ""     , "el1"  , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  "el10" , ""     , ""     , ""     , "el14" , ""     , ""     , ""     , "el18" ,  "",
  ""     , "el21" , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , "el32" , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , "el41" , ""     , ""     , ""     , ""     , "el46" , ""     , "el48" ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , "el73" , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , "el82" , ""     , ""     , ""     , ""     , ""     , "el88" ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  "el100", "el101", ""     , ""     , ""     , "el105", "el106", ""     , "el108",  "",
  ""     , ""     , "el112", ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , "el127", ""     ,  "",
  ""     , "el131", ""     , ""     , ""     , "el135", ""     , ""     , ""     ,  "",
  "el140", ""     , ""     , ""     , ""     , "el145", ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , "el154", ""     , ""     , ""     , ""     ,  "",
  "el160", ""     , ""     , ""     , "el164", ""     , ""     , ""     , "el168",  "",
  ""     , ""     , ""     , ""     , ""     , ""     , "el176", ""     , ""     ,  "",
  ""     , ""     , ""     , "el183", ""     , ""     , ""     , "el105", ""     ,  "",     // this is no mistake
  ""     , ""     , "el192", "el193", ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , "el203", ""     , ""     , ""     , ""     , "el208",  "",
  ""     , ""     , ""     , ""     , "el214", "el215", "el216", ""     , "el218",  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , "el233", ""     , ""     , ""     , "el237", ""     ,  "el18", // this is no mistake
  ""     , ""     , "el242", ""     , ""     , ""     , ""     , "el247", ""     ,  "",
  ""     , "el154", "el252", ""                                                             // this is no mistake
};

IMPORT       FLAG             rawmode,
                              logconsole;
IMPORT       TEXT             userstring[40 + 1];
IMPORT       int              armour,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              evil_attacktotal,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              minutes,
                              spellchosen,
                              spelllevel,
                              room, prevroom, module,
                              target,
                              theround,
                              thethrow,
                              wordwrap;
IMPORT       SWORD*           exits;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct LanguageStruct  language[LANGUAGES];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];
IMPORT struct SpellInfoStruct spellinfo[20 + 1];

IMPORT void (* enterroom) (void);

MODULE void el_enterroom(void);
MODULE int nig(int levelofsave);

EXPORT void el_preinit(void)
{   descs[MODULE_EL]   = el_desc;
 // wanders[MODULE_EL] = el_wandertext;
}

EXPORT void el_init(void)
{   int i;

    exits     = &el_exits[0][0];
    enterroom = el_enterroom;
    for (i = 0; i < EL_ROOMS; i++)
    {   pix[i] = el_pix[i];
}   }

MODULE void el_enterroom(void)
{   TRANSIENT int i,
                  result, result1, result2, result3;
    PERSIST   int amount;

    switch (room)
    {
    case 2:
        give_gp(2500);
        victory(50);
    acase 3:
        elapse(ONE_DAY * 7, TRUE);
        savedrooms(nig(4), lk, 43, 113);
    acase 5:
        give(924);
        give(927);
    acase 6:
        if (!getyn("Help them (otherwise die)"))
        {   die();
        }
    acase 7:
        create_monster(619);
        evil_takehits(dice(3), TRUE);
        good_takehits(dice(3), TRUE); // %%: does armour help?
        fight();
    acase 9:
        die();
    acase 14:
        victory(0);
    acase 15:
        create_monster(620);
        fight();
    acase 16:
        savedrooms(nig(4), (iq + chr) / 2, 115, 76);
    acase 17:
        lose_chr(amount / 2);
        lose_dex(dex / 4);
        victory(2000);
    acase 18:
        if (!getyn("Accept mission (otherwise leave adventure)"))
        {   victory(0);
        }
    acase 19:
        result = 0;
        for (i = 925; i <= 931; i++)
        {   if (items[i].owned)
            {   result++;
        }   }
        if   (result <  4) room = 209;
        elif (result <= 6) room =  69;
        else               room =  89;
    acase 20:
        give_gp(2500);
        victory(275);
    acase 21:
        result = dice(2);
        create_monsters(621, dice(1) + 2);
        create_monsters(659, amount);
        for (i = result; i >= 1; i--)
        {   aprintf("%d rounds until explosion...\n", i);
            oneround();
            if (!countfoes())
            {   room = 203;
                break;
        }   }
        dispose_npcs();
    acase 22:
        if (cast(SPELL_RS, FALSE) || getyn("Give first aid"))
        {   room = 242;
        }
    acase 23:
        create_monster(622);
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   dispose_npcs();
            room = 173;
        }
    acase 24:
        create_monster(623);
        switch (dice(1))
        {
        case 1:
            good_takehits(13, TRUE);
        acase 4:
            if (!ability[22].known && st + iq + chr < 36)
            {   dispose_npcs();
                room = 78;
            }
        acase 6:
            good_takehits(dice(3), TRUE);
        }
        if (room == 24)
        {   fight();
            give(928);
        }
    acase 25:
        create_monsters(624, 2);
        oneround();
        oneround();
        if (countfoes())
        {   dispose_npcs();
            room = 173;
        }
    acase 27:
        create_monster(625);
        fight();
    acase 28:
        savedrooms(nig(1), dex, 117, 97);
    acase 29:
        do
        {   if   ( saved(nig(3), iq )) room = 58;
            elif (!saved(nig(2), con)) templose_con(misseditby(nig(2), con));
        } while (room == 29 && con >= 1);
    acase 30:
        if   (prevroom ==  50) give_gp( 2500);
        elif (prevroom ==  90) give_gp(10000);
        elif (prevroom == 123) give_gp( 7500);
        // %%: there doesn't seem to be any situation where there would be live ones
        award(350);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 32:
        if (getyn("Another form of payment") && saved(nig(3), iq))
        {   room = 94;
        } elif (gp >= 1 && getyn("Toss it a gold coin"))
        {   result1 = dice(1);
            result2 = dice(1);
            result3 = dice(1);
            if (result1 == result2 && result1 == result3)
            {   room = 4;
            } elif (result1 == result2 || result1 == result3 || result2 == result3)
            {   room = 44;
            } elif (result1 <= 3 && result2 <= 3 && result3 <= 3)
            {   room = 64;
            } elif (result1 >= 4 && result2 >= 4 && result3 >= 4)
            {   room = 74;
            } else
            {   room = 83;
        }   }
    acase 33:
        if (saved(nig(level), con))
        {   room = 5;
        } else
        {   templose_con(misseditby(nig(level), con));
        }
    acase 34:
        give_gp(1000);
        victory(150);
    acase 35:
        victory(1650);
    acase 36:
        if (!items[KRI].owned) // %%: krises are only supposed to work on low-level magic
        {   good_takehits(dice(9) + 176, TRUE);
        }
    acase 37:
        give_multi(725, dice(3));
        give_gp(5000);
        victory(1500);
    acase 38:
        give_gp(150);
        give(932);
        victory(1000);
    acase 39:
        create_monster(626);
        fight();
        give(931);
    acase 41:
        if (getyn("L3-SR on IQ (otherwise L5-SR on LK)"))
        {   savedrooms(nig(3), iq, 3, 23);
        } else
        {   savedrooms(nig(5), lk, 3, 23);
        }
    acase 42:
        good_takehits(amount, TRUE);
        create_monsters(627, amount);
        fight();
        give_gp(dice(2));
        victory(0);
    acase 45:
        give(933); // %%: perhaps this should be usable as a light and/or ignition source
        victory(1700);
    acase 46:
        if (!saved(nig(2), con))
        {   templose_con(misseditby(nig(2), con));
        }
        create_monster(628);
        result = 2;
        do
        {   if (!can_breathewater(FALSE)) // %%: we assume they can't cast underwater
            {   if (saved(nig(2), lk)) // %%: at what point in the round are we supposed to do these checks? Before or after the actual combat?
                {   result = 2;
                } else
                {   if (saved(nig(result), con)) // %%: ambiguous about the level of the CON saving roll, and how EL4 been[4] applies
                    {   result++;
                    } else
                    {   die();
            }   }   }
            oneround();
        } while (con >= 1 && countfoes());
    acase 47:
        result = 4000;
        if (!saved(nig(2), lk)) result -= 1000;
        if (!saved(nig(2), lk)) result -= 2000;
        if (!saved(nig(2), lk)) result -= 3000;
        if (!saved(nig(2), lk)) result -= 4000;
        if (result < 0)
        {   result = 0;
        }
        give_gp(result);
        victory(1000);
    acase 48:
        if (!saved(nig(3), dex))
        {   room = 29;
        }
    acase 49:
        DISCARD dice(2);
        victory(0);
    acase 50:
        create_monster(629);
        fight();
    acase 51:
        drop_weapons(); // %%: do we ever get them back?
        create_monster(630);
        do
        {   if (saved(nig(2), dex))
            {   good_freeattack();
            } else
            {   oneround();
        }   }
        while (countfoes() && con >= 1);
        give(926); // %%: and what about his club?
    acase 52:
        if (!saved(nig(level), con))
        {   templose_con(misseditby(nig(level), con));
            room = 24;
        }
    acase 53:
        result = dice(1);
        if (result == 1)
        {   create_monster(631);

        } else
        {   create_monsters(632, result);
            fight();
        }
        give_gp(75000);
        victory(3000);
    acase 54:
        healall_con();
        give_gp(5000);
        give_gp(amount * 10);
        give(PON); // %%: presumably the "worth" is in generated hits rather than a monetary value
        victory(750);
    acase 56:
        aprintf("#105:\n%s\n\n", descs[MODULE_EL][105]);
        switch (dice(2))
        {
        case   2: result = 119;
        acase  3: result = 157;
        acase  4: result =  91;
        acase  5: result = 184;
        acase  6: result = 197;
        acase  7: result = 210;
        acase  8: result = 223;
        acase  9: result = 236;
        acase 10: result = 249;
        acase 11: result = 165;
        acase 12: result = 240;
        }
        result *= 10;
        give_gp(result / 100);
        give_sp(result % 100);
        victory(0);
    acase 57:
        DISCARD dice(3);
        award(1200);
        module = MODULE_AK;
        room = 77;
    acase 58:
        drop_armour();
        create_monster(633);
        good_freeattack();
    acase 59:
        die();
    acase 60:
        give(934);
        victory(275);
    acase 61:
        savedrooms(nig(2), lk, 171, 213);
    acase 62:
        if (getyn("Accept mission")) // %%: when and how do they get them back? We assume never.
        {   drop_weapons();
            give(935);
            room = 12;
        }
    acase 63:
        savedrooms(nig(3), lk, 244, -1);
    acase 66:
        if (saved(nig(2), lk))
        {   room = 116;
        } else
        {   result = divide_roundup(dice(1), 2);
            good_takehits(result * dice(3), TRUE);
        }
    acase 67:
        if (prevroom == 82)
        {   // %%: it's ambiguous about whether we become addicted in this case. We assume not.
            give_multi(936, 800);
        }
        victory(1500);
    acase 68:
        if (!saved(nig(2), spd))
        {   room = 88;
        }
    acase 70:
        create_monsters(626, dice(1));
        fight();
        // %%: are they allowed to leave the adventure at this point?
    acase 71:
        if (!saved(nig(2), st))
        {   templose_con(misseditby(nig(2), st));
            room = 51;
        }
    acase 73:
        result = (level > 6) ? 0 : (6 - level);
        if (saved(nig(result), lk))
        {   victory(0);
        }
    acase 75:
        savedrooms(nig(3), lk, 115, 16);
    acase 76:
        result1 = level; // level of save
        result2 = 0;     // saves missed
        amount  = 0;     // torture damage
        do
        {   if (!saved(nig(result1), con))
            {   templose_con(misseditby(nig(result1), con));
                amount += misseditby(nig(result1), con);
                result2++;
            }
            result1++;
        } while (result2 < 3);
    acase 77:
        if (getyn("Stab hole")) // %%: maybe we should check that they have a suitable weapon?
        {   savedrooms(nig(2), lk, 135, 172);
        }
    acase 78:
        if (saved(nig(1), iq))
        {   give(929);
            room = 118;
        }
    acase 79:
        good_takehits(dice(2), TRUE); // %%: does armour help? We assume so.
        give_gp(2500);
        award(150);
    acase 80:
        hourofday(6);
        victory(225);
    acase 81:
        if (ability[165].known)
        {   room = 2;
        }
    acase 82:
        if (getyn("Take cash"))
        {   give_gp(1000);
            victory(0);
        }
    acase 83:
        savedrooms(nig(2), (iq + chr) / 2, 114, 12);
    acase 85:
        create_monster(663);
        fight();
    acase 86:
        if (!saved(nig(2), con))
        {   templose_con(misseditby(nig(2), con));
            result = 3;
        } else
        {   result = 2;
        }
        if (!saved(nig(result), con))
        {   templose_con(misseditby(nig(result), con));
            result++;
        }
        if (!saved(nig(result), con))
        {   templose_con(misseditby(nig(result), con));
        }
    acase 87:
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 88:
        if (prevroom != 58)
        {   create_monster(633);
        }
        fight();
    acase 89:
        give(937);
        give(938);
        savedrooms(nig(2), chr, 109, 70);
    acase 90:
        create_monsters(634, 4);
    acase 91:
        victory(0);
    acase 92:
        savedrooms(nig(2), (st + chr) / 2, 100, 126);
    acase 94:
        result1 = dice(1);
        result2 = dice(1);
        result3 = dice(1);
        result  = getnumber("Reroll which die (0 for none)", 0, 3);
        if   (result == 1) result1 = dice(1);
        elif (result == 2) result2 = dice(1);
        elif (result == 3) result3 = dice(1);
        if (result1 == result2 && result1 == result3)
        {   room = 4;
        } elif (result1 == result2 || result1 == result3 || result2 == result3)
        {   room = 44;
        } elif (result1 <= 3 && result2 <= 3 && result3 <= 3)
        {   room = 64;
        } elif (result1 >= 4 && result2 >= 4 && result3 >= 4)
        {   room = 74;
        } else
        {   room = 83;
        }
        // %%: it's ambiguous about whether and when we pay him his cut
    acase 95:
        savedrooms(nig(5), iq, 8, 173); // %%: do they really mean you actually add together 4 dice to get your saving roll?
    acase 96:
        give_gp(dice(3) * 500);
        award(1000);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 97:
        gain_flag_ability(166);
    acase 98:
        gain_flag_ability(1);
        give_gp(dice(5) * 100);
        victory(0);
    acase 99:
        gain_flag_ability(168);
        award(250);
        gain_chr(4);
        give_gp(2500);
    acase 101:
        elapse(120, TRUE); // %%: ambiguous about exactly how long
        if (race == ELF)
        {   room = 62;
        }
    acase 102:
        if (!saved(nig(level), con))
        {   templose_con(misseditby(nig(level), con)); // %%: does armour help? We assume not.
            room = 24;
        }
    acase 103:
        savedrooms(nig(3), (iq + chr) / 2, 82, 6);
    acase 104:
        give_gp(500);
        award(300);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 105:
        switch (dice(2))
        {
        case   2: room = 119;
        acase  3: room = 157;
        acase  4: room =  91;
        acase  5: room = 184;
        acase  6: room = 197;
        acase  7: room = 210;
        acase  8: room = 223;
        acase  9: room = 236;
        acase 10: room = 249;
        acase 11: room = 165;
        acase 12: room = 240;
        }
    acase 106:
        give_gp(1000);
        give(939);
        victory(2000);
    acase 107:
        create_monster(634 + dice(1)); // 635..640
        fight();
    acase 108:
        rb_givejewels(-1, -1, 2, 5);
        give(940);
        victory(1500);
    acase 109:
        give_multi(941, 5);
        victory(0);
    acase 110:
        victory(250);
    acase 111:
        give(942);
        give(943);
        give(925);
    acase 112:
        give_gp(dice(4));
        victory(1000);
    acase 114:
        give(944);
    acase 115:
        hourofday(18);
        if (saved(nig(4), lk))
        {   room = 96;
        } elif (saved(nig(6), iq))
        {   room = 37;
        }
    acase 116:
        give_gp(1000);
        victory(1600);
    acase 117:
        create_monsters(641, 2);
        DISCARD castspell(-1, TRUE);
        fight();
    acase 118:
        create_monster(642);
        npc[0].mr = dice(1) * 10;
        give(930);
    acase 119:
        savedrooms(nig(2), lk, 132, 134);
    acase 121:
        award(350);
        give_gp(5000);
    acase 122:
        give_gp(2500);
        award(325);
    acase 123:
        create_monsters(643, 2);
        fight();
    acase 124:
        savedrooms(nig(level), lk, 39, 59);
    acase 125:
        savedrooms(nig(2), spd, 50, 90);
    acase 126:
        victory(100);
    acase 127:
        templose_con(dice(4));
        give_gp(500);
        victory(75);
    acase 128:
        give_gp(5000);
        victory(300);
    acase 129:
        result = getnumber("Give how many gp", 0, 1000); // %%: maybe let them pay more, it is pointless though
        if (!pay_gp(result) || !saved(nig(10) - (result / 100), lk))
        {   die();
        }
    acase 131:
        getsavingthrow(TRUE);
        if (madeitby(nig(2), iq) >= 6)
        {   room = 168;
        } elif (madeit(nig(2), iq))
        {   room = 105;
        } else
        {   room = 143;
        }
    acase 132:
        create_monsters(621, dice(1));
        fight();
    acase 133:
        savedrooms(nig(4), con, 250, -1);
    acase 134:
        victory(0);
    acase 135:
        gain_flag_ability(169);
        victory(0);
    acase 136:
        give_gp(dice(2));
        give(945);
        victory(1000);
    acase 137:
        victory(0);
    acase 138:
        dispose_npcs();
        if (!saved(nig(2), con))
        {   good_takehits(misseditby(nig(2), con), TRUE);
        }
        give_gp(dice(3));
        victory(500);
    acase 139:
        drop_armour();
        while (con >= 1 && !saved(nig(2), con))
        {   templose_con(misseditby(nig(2), con));
        }
    acase 142:
        savedrooms(nig(2), iq, 253, 214);
    acase 143:
        good_takehits(dice(1), TRUE);
        getsavingthrow(TRUE);
        if (madeitby(nig(1), iq) >= 10)
        {   room = 204;
        } elif (madeit(nig(1), iq))
        {   room = 192;
        } else
        {   room = 180;
        }
    acase 144:
        give_gp(2500);
        victory(300);
    acase 145:
        create_monster(645);
        fight();
        give_gp(dice(1));
        victory(0);
    acase 146:
        victory(0);
    acase 147:
        if (getyn("L2-SR on DEX (otherwise L2-SR on SPD)"))
        {   result = dex;
        } else
        {   result = spd;
        }
        getsavingthrow(TRUE);
        if (madeitby(nig(2), result) >= 10)
        {   room = 208;
        } elif (madeit(nig(2), result))
        {   room = 232;
        } else
        {   room = 196;
        }
    acase 150:
        // %%: does the round we just fought count? We assume so.
        fight();
        savedrooms(nig(theround), lk, 218, 230);
    acase 151:
        victory(1000);
    acase 152:
        if (getyn("L1-SR on LK (otherwise L1-SR on DEX)"))
        {   result = lk;
        } else
        {   result = dex;
        }
        if (saved(nig(1), result))
        {   room = 189;
        } else
        {   amount = misseditby(nig(1), result);
            room = 42;
        }
    acase 153:
        victory(0);
    acase 154:
        create_monster(646);
        fight();
        if (!saved(nig(theround), lk))
        {   die();
        }
    acase 155:
        savedrooms(nig(3), (st + con) / 2, 122, 15);
    acase 157:
        victory(0);
    acase 158:
        create_monster(647);
        create_monsters(648, dice(1));
    acase 159:
        savedrooms(nig(2), iq, 244, 196);
    acase 160:
        die();
    acase 162:
        create_monster(649);
        fight();
    acase 163:
    case 164:
    case 165:
    case 166:
        victory(0);
    acase 167:
        create_monster(650);
        fight();
    acase 170:
        create_monster(651); // %%: they have different MRs in different paragraphs
        fight();
        give_gp(dice(3));
    acase 172:
        create_monster(652);
        fight();
    acase 173:
        amount = 0;
        result = dice(1);
        while (!saved(nig(result), dex))
        {   templose_con(10);
            amount += 10;
        }
    acase 174:
        savedrooms(nig(2), iq, 141, 233);
    acase 175:
        amount = dice(1);
    acase 176:
        victory(0);
    acase 177:
        if (getyn("Attack gargoyle"))
        {   savedrooms(nig(2), iq, 7, 160);
        }
    acase 178:
        victory(0);
    acase 179:
        result1 = dice(2); // rounds remaining
        result2 = 200;     // warship CON
        do
        {   result1--;
            aprintf("Loaded trebuchet. %d rounds left.\n");
            if (result1 >= 1)
            {   result1--;
                result3 = dice(6);
                if   (lk > 12) result3 += lk - 12;
                elif (lk <  9) result3 -=  9 - lk;
                if (result3 <= 0) result3 = 0;
                aprintf("Fired trebuchet for %d damage.\n", result3);
                result2 -= result3;
                if (result2 < 0) result2 = 0;
                aprintf("Warship has %d CON remaining. %d rounds left.\n");
        }   }
        while (result1 >= 1 && result2 >= 1);
        if (result2 == 0)
        {   room = 215;
        }
    acase 180:
        result = dice(6);
        good_takehits(result, TRUE); // %%: we assume by "taking normal damage" that we are still allowed to double it where appropriate (as is normally the case).
        if (money < result * 200)
        {   pay_cp(money);
        } else
        {   pay_gp(result * 2);
        }
        if (getyn("Avenge yourself"))
        {   getsavingthrow(TRUE);
            if (thethrow >= result - iq) // %%: is "the damage you took" before or after deducting armour protection? We assume it is before.
            {   room = 228;
            } else
            {   room = 219;
        }   }
    acase 181:
        create_monster(653);
        oneround();
        if (countfoes())
        {   if (good_attacktotal >= evil_attacktotal) // %%: what if it was a draw?
            {   room = 150;
            } else
            {   room = 138;
        }   }
    acase 182:
        // %%: this kind of saving roll doesn't have a level
        if (armour == EMPTY)
        {   result = 0;
        } else
        {   result = items[armour].hits;
        }
        getsavingthrow(TRUE);
        if (thethrow >= result - iq)
        {   room = 161;
        }
    acase 183:
        give_multi(725, dice(2));
        victory(2000);
    acase 184:
        if (race == HUMAN || race == ORC)
        {   gain_chr(3);
        } else
        {   gain_chr(1);
        }
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 185:
        victory(500);
    acase 186:
        victory(0);
    acase 187:
        DISCARD dice(2);
        victory(0);
    acase 188:
        savedrooms(nig(2), iq, 137, 163);
    acase 190:
        create_monster(654);
        fight(); // %%: maybe let the character loot his dagger
    acase 191:
        die();
    acase 193:
        give_multi(725, 10);
        award(500);
    acase 194:
        pay_gp(amount);
        victory(0);
    acase 195:
        give_gp((dice(5) + 2) * 100);
        victory(0);
    acase 196:
        lose_flag_ability(88);
        getsavingthrow(TRUE);
        if (madeit(nig(3), lk))
        {   give_gp(dice(4));
            victory(2000);
        } else
        {   result = misseditby(nig(3), lk);
            good_takehits(result, TRUE);
            for (i = 1; i <= result; i++)
            {   getsavingthrow(TRUE);
                if (!madeit(nig(3), lk))
                {   good_takehits(misseditby(nig(3), lk), TRUE);
            }   }
            give_gp(dice(4) / 2);
            victory(1000);
        }
    acase 197:
        DISCARD dice(1);
        victory(0);
    acase 198:
        victory(0);
    acase 200:
        create_monsters(644, dice(1));
        fight();
        savedrooms(nig(2), lk, 179, 246);
    acase 202:
        give_gp(7500);
        award(1750);
    acase 203:
        give_gp((dice(4) + 3) * 1000);
        victory(1000);
    acase 205:
        give_gp((dice(2) * 4) * 100);
        victory(0);
    acase 206:
        amount = dice(amount);
        if (money < amount)
        {   room = 158; // %%: we assume that if they can't afford it they must go to EL158
        }
    acase 207:
        victory(0);
    acase 208:
        create_monster(655);
        fight();
    acase 209:
        die();
    acase 212:
        savedrooms(nig(2), spd, 227, 234);
    acase 215:
        give_gp(dice(6) * 1000);
        victory(0);
    acase 216:
        switch (dice(2))
        {
        case   2: room = 229;
        acase  3: room =  49;
        acase  4: room = 231;
        acase  5: room = 220;
        acase  6: room =  14;
        acase  7: room = 198;
        acase  8: room = 187;
        acase  9: room = 176;
        acase 10: room = 164;
        acase 11: room = 153;
        acase 12: room = 142;
        }
    acase 217:
        getsavingthrow(TRUE);
        if (!madeit(nig(2), iq))
        {   amount = misseditby(nig(2), iq);
            room = 206;
        }
    acase 218:
        // %%: it's somewhat ambiguous about exactly what skin conditions this would and wouldn't cure
        lose_flag_ability(59);
        lose_flag_ability(62);
        lose_flag_ability(149);
        give_gp(dice(3) * 100);
        victory(0);
    acase 219:
        create_monsters(656, dice(2));
        give_sp(dice(2));
        victory(0);
    acase 220:
        victory(0);
    acase 221:
        give_gp(dice(2) * 1000);
        victory(0);
    acase 223:
        // %%: presumably the book remains in the library
        victory(0);
    acase 224:
        result = dice(1);
        create_monster(661); // windlass
        create_monsters(662, dice(1)); // orc troopers
        do
        {   oneround();
            if (countfoes())
            {   create_monster(659); // orc worker. %%: it's ambiguous about when in the round this happens
        }   }
        while (con >= 1 && theround < result && countfoes());
        if (countfoes())
        {   dispose_npcs();
            room = 178;
        }
    acase 225:
        if (getyn("L1-SR on LK (otherwise L1-SR on IQ)"))
        {   result = lk;
        } else
        {   result = iq;
        }
        if (saved(nig(1), result))
        {   room = 146;
        } else
        {   amount = misseditby(nig(1), result);
            room = 42;
        }
    acase 227:
        give_gp(dice(3) * 200);
        victory(1000);
    acase 228:
        gain_iq(1);
        victory(0);
    acase 229:
        savedrooms(nig(1), lk, 186, 156);
    acase 230:
        savedrooms(nig(2), con, 245, -1);
    acase 231:
        victory(0);
    acase 232:
        if (!saved(nig(2), iq))
        {   award(1000);
            module = MODULE_ND;
            room = -1;
        }
    acase 233:
        if (!saved(nig(2), lk))
        {   good_takehits(dice(6), TRUE);
            room = 185;
        }
    acase 235:
        savedrooms(nig(2), iq, 252, 226);
    acase 236:
        victory(0);
    acase 237:
        create_monsters(657, dice(1));
        create_monster(658);
        fight();
    acase 238:
        give_gp((dice(3) + 4) * 100);
        victory(0);
    acase 239:
        drop_clothing();
        drop_weapons();
    acase 240:
        if (race != ELF && race != HALFELF)
        {   savedrooms(nig(2), lk, 188, 214);
        }
    acase 241:
        create_monster(660); // %%: they have different MRs in different paragraphs
        fight();
        give_gp(dice(3));
        give(946);
        // %%: perhaps we should wait until tommorrow (midnight? or 6am?)
    acase 242:
        award(200);
        give_gp(2500);
        gain_flag_ability(167);
    acase 243:
        savedrooms(nig(3), chr, 112, 84);
    acase 244:
        award(1000);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 245:
        give_gp(dice(3) * 100);
        victory(0);
    acase 247:
        create_monsters(627, dice(1) + 2);
        fight();
    acase 248:
        give(947);
        victory(1200);
    acase 249:
        victory(0);
    acase 250:
        lose_chr(chr / 2);
        victory(0);
    acase 251:
        victory(0);
    acase 252:
        give(948);
        give(949);
        give_gp((dice(5) + 3) * 1000);
        victory(1000);
    acase 253:
        if (getyn("Leave adventure"))
        {   victory(0);
}   }   }

MODULE int nig(int levelofsave)
{   if (been[4] && levelofsave >= 2)
    {   levelofsave--;
    }
    return levelofsave;
}
