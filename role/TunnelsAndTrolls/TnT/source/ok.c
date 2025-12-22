#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Ambiguities/errata (%%):
 The picture on page 21: does it belong to 21A or 21G or both? (We assume 21A).
 The picture on page 22: does it belong to 22E? or perhaps 25D? We assume 22E.
 8/3B leads to 55/11B, which is very strange.
 22/6B leads to 76/15F, which is very strange.
 Nothing seems to link to paragraph 78/15H!
These paragraphs are only for multiplayer (and thus are not implemented):
 27, 39, 58, 63, 67, 80, 114, 126, 128.
Not implemented:
 special notes on Magic Matrix (re. PP, MP, Wall spells, D9).
Notes:
 Although there is a Magic Matrix, paragraphs where it applies are not marked (eg. by '*').
*/

MODULE const STRPTR ok_desc[OK_ROOMS] = {
{ // 0/1
"`INSTRUCTIONS\n" \
"  Into this adventure you may take up to 12 level points of characters (one 12th level character[ - or six 1st level, a 2nd and a 4th level character - and so on]). All spells will function as allowed by the Magic Matrix, to be found on page 26 at the back of this booklet. (To find your spell's result on the chart, cross-reference the paragraph number you came from to the spell you cast.) No home-grown spells are allowed.\n" \
"  [For each party going into this adventure you must designate one character as leader. (An easy way to do this with first-level characters is to make the character with the highest Charisma the leader.) This holds true if the party gets split or the leader gets killed, so be prepared to pick a new leader at any time.\n" \
"  In places where individual combat is called for, it is to be just that - *individual*. In any melee situation, however, you may elect to break it down into groups of individual combats so that wizards can cast Vorpal Blades for fighters, and the like. This is the only case where aid to fighters in combat is permitted.\n" \
"  To personalize this dungeon, you might want to put the wandering monsters on index cards and flip them over each time you fight a wandering monster. You can also create a card for all the characters who die in this dungeon, making them zombies (ST × 2, LK × ¼, DEX and IQ = a maximum of 3, CON × 3), under control of Marionarsis *only*. In this way, if you cannot reincarnate them you can still use them and keep your dungeon variable.\n" \
"  ]This dungeon has been rewritten using the Tunnels & Trolls 5th edition rules. (If you have the 4th edition of the rules, subtract 10 from all Monster Ratings and use the dice for a given weapon from the earlier edition.) In addition to those rules, you will need some six-sided dice, pencil, paper, and imagination. Enjoy!\n" \
"  Go to paragraph {84}.\n" \
"~INTRODUCTION\n" \
"  The Death Host of Lerotra'hh, she who was called the Death Goddess of Khazan, was on the march again. They had just successfully defended the Empire against the savage assault of the fierce pirates known as Rangers. Winning the Khazan-Ranger War meant that the ocean borders of the Empire were safe. Lerotra'hh once again cast her eyes to the south.\n" \
"  The cities of the south, most notably Knor and Khosht, had forgotten the might of Khazan. During the wars they had supported the Empire in voice only. Determined to collect her tribute and shatter the spirit of the southern cities, Lerotra'hh sent her hordes south.\n" \
"  Led by the veterans of the Khazan-Ranger Wars, you characters find only token resistance in the south. Then, at the southern end of the mountain pass known as the Gap in the Teeth of the Gods, you halt. Before you looms an ancient and strong fortress.\n" \
"  The veterans know many stories about this citadel; they tell you that it has withstood many assaults. The owner of the castle is a wizard named Marionarsis, they inform you. They call Marionarsis a sorcerer-butcher and a necromancer. In whispered voices they call his castle:\n" \
"  Overkill."
},
{ // 1/2A
"You make your way through the jungle in the volcano. After walking for half a day, you come to a small castle. The walls are only 10' high, and though fortified, it looks much like a summer home for a king.\n" \
"  If your party has been split when entering this world, you may wait here to see if any catch up with you. From here, your only choice is to enter the castle at {101}."
},
{ // 2/2B
"As leader, you must make a saving roll on an average of IQ and Luck. The level of the saving roll is determined by adding three to the number of characters you have lost. If you make the saving roll, go to {100}. If you fail, go to {109}."
},
{ // 3/2C
"He is true to his word. He pays each of you 1000 gp. He makes you wait until the worst of the battle has passed, and then allows you go leave. Go to {45}."
},
{ // 4/2D
"From outside the tent you hear screams of terror. \"The undead attack!\" is the cry. While you bind your wounds, you listen to your former comrades fight and die. Finally, the sounds of battle cease.\n" \
"  Into the tent walks Marionarsis. Ten undead follow him. \"As I promised,\" he says as he tosses your leader a sack of gems. \"The ten thousand.\" He turns and leaves the tent.\n" \
"  You split up the gems. As you prepare to leave, you note that Shang and his dead officers are on their feet and walking zombie-like towards the doorway. You leave the tent and find enough horses to carry you all away from this valley. As you ride out, all you can see in the dawn light are even ranks of new soldiers for Overkill.\n" \
"  You have gained 1650 ap for this trip. You are done - go to {135}."
},
{ // 5/2E
"\"We cannot let you leave. You might reveal our village to Marionarsis. Stay with us - or fight!\" If you wish to fight, go to {74}. If you would rather stay, go to {69}."
},
{ // 6/2F
"As you cautiously make your way up the stairs, you come to a landing. On the landing are two guards. You see them before they see you, so have a chance at missile and magic combat. If you want to use missiles or magic, you only get one combat turn, so do your worst...go to {81}. If you just want to fight them, go to {68}."
},
{ // 7/3A
"Roll three dice. [This is the level number of the spells that are in the book and are not fire damaged. ]If you've lost the book, that's your hard luck.\n" \
"  The remains of your party are gathered on the balcony. You watch as Marionarsis' forces, now leaderless, are cut to ribbons, and you see Shang riding into the Citadel Overkill. Ropes are thrown to you, and you escape from being roasted to death. Each of you is given 5000 gold pieces in gems and your choice of one suit of armour. This trip has been worth 1000 ap, and you are done - go to {135}."
},
{ // 8/3B
"Each of the crossbowmen has [a MR of 30 for the first combat round and ]a MR of 50[ for the ones after that]. They must take 50 hits to die[ (the lower MR is because they are drawing swords during the melee)]. The sub-captain has a MR of 40.\n" \
"  Shang is in plate armour. He uses a 6-die great sword [that triples its die roll ](magic). He has a kris[ that dispels all first- through third-level magic and disrupts other levels]. He has a CON of 100 and combat adds of 215. He also has an amulet[ that changes all magical items designed to take hits into items that will take their number of hits and then be destroyed]. If you win, go to {55}. If you want to surrender, go to {75}."
},
{ // 9/3C
"As you finish him, you manage to grab his sword. From the mirror he had indicated earlier steps Shang and five black-robed wizards.\n" \
"  \"We finally tracked him here. I see you accomplished your mission despite overwhelming odds. Men like you are hard to find.\"\n" \
"  You are led through the mirror. Soon all the Death Host is gathered about you. Shang confers on you the rank of General of the Death Host.[ You get 750 gold pieces a week, and have 20 first-level warriors as your personal guard. (All of them are fully armed and are of your kindred.)]\n" \
"  You have done well, and have earned 4000 ap. Go to {135}."
},
{ // 10/3D
"Someone touches a secret button and a panel slides back. All of you can enter, but if there are any wandering monsters still alive, one person is going to have to act as rear guard so the rest of you can bolt the door. Pick the person to act as rear guard. Those in the tunnel can go to {26}. The rear guard, if he vanquishes the WMs, can join you later - he'll knock and you'll answer..."
},
{ // 11/3E
"This is the guard room of the Citadel. Across from the maze door is a door that leads out. All the money from the guards is on the poker table. Roll one die and multiply by 1000 to see how much loot is there. In the corner is a strongbox with a large lock on it. If you wish to open it, choose one character to bash it open (Unlock spells only work on doors), and go to {130}. If you only want the ready cash on the poker table, go to {45}."
},
{ // 12/3F
"You torch the wagon and push it into the gate. Casks burst and flames wreak unholy havoc with the gate and the zombies.\n" \
"  Suddenly, a cask that had stored phosphorus in water explodes. Sheets of oil pour over the courtyard. Everyone in the party should make a fourth-level saving roll on Luck (35 - LK). Those who miss it must take ten dice worth of hits from fire and shrapnel. (Those who are immune to fire should take 6 dice from concussion and shrapnel.) Armour won't help.\n" \
"  If anyone survives, go to {96}."
},
{ // 13/3G
"Marionarsis wields the sword \"Wizard's Wand\". It gets 1 die and 30 adds. His robes take 20 hits[ and protect him from poison]. He has a CON of 25 and gets 170 personal combat adds. If you defeat him, go to {76}. In the event of failure, the remaining party members may go to {23} and choose again (they may even rechoose this option with another character)."
},
{ // 14/4A
"As you break from the grove, in full moonlight, you are seen by a patrol of zombies. Roll one die and add 1 to find the number of zombies you must fight. Each has a Monster Rating of 60. If [any of ]you survive this combat, go to {95} and ignore the first two sentences."
},
{ // 15/4B
"The room at the end of the maze, quite obviously, is a guard room. On the table is what is left of a poker game. Roll one die and multiply by 1000 to determine the amount of gold on the table (Marionarsis pays well). Behind the table is a door which leads to the outside. Over in the corner is a large strongbox with a big lock. If you wish to bash it open (an Unlock spell only works on doors), choose the character who will open it and go to {130}. If you choose to take only the treasure on the table, ignoring the chest, go to {45}."
},
{ // 16/4C
"The door is a demon. The person who missed the saving roll in the doorway is attacked. The demon has a Monster Rating of 150.\n" \
"  The person in the doorway does get the protection that his armour offers. (The doubling of armour value for warriors holds good, if he is a warrior.) For the first combat turn, he *alone* is attacked and does *not* get a chance to defend himself - this is essentially an ambush.\n" \
"  Those who have *not* entered the room may fight against the demon. Those within the room find they cannot leave it to join the fight. If you want to let the man who was attacked by the demon finish him or be finished without anyone else attacking, go to {91}. If you want others to join in the fight, go to {128}."
},
{ // 17/4D
"The room is in flames. A second level saving roll on Luck (25 - LK) will get you to the balcony unharmed. If you miss the saving roll, take the number you missed it by in hits. (Armour will not help to protect you from the fire.)\n" \
"  If you don't die, go to {29}. If you have any wizards or warrior-wizards in the room, go to {57}."
},
{ // 18/4E
"\"As you know,\" he begins, \"without Shang, the forces of Lerotra'hh will be useless. I offer you ten thousand gold pieces worth of gems if you will kill him.\"\n" \
"  If you take him up on his offer, go to {108}. If you decide to decline and attack him, go to {121}."
},
{ // 19/4F
"You assemble in the nearly deserted courtyard. All attention is riveted on the battle outside the walls and the assault on the walls by Khazan's army. Your leader suggests that even though you have failed in your mission, you might be able to open the gates to Overkill and redeem yourselves in that manner.\n" \
"  If you turn on your leader and kill him, go to {114}. If you want to try to open the gate, a massive device drawn into the upper wall by a windlass, go to {105}. If you believe that you are going to die and want to pick off people inside the walls (using missiles, magic or close combat), go to {94}. If you want to commit suicide, go to {106}."
},
{ // 20/4G
"You find a narrow path up the side of the volcano. Only bipeds can traverse it. (Multi-legged characters should return to {122} and pick again.) Each character should make a third level saving roll on Luck (30 - LK) to avoid falling from the side of the cliff. (Such a fall will end in certain death.)\n" \
"  Those who make it to the top find the exterior of the volcano totally snowbound and very cold. There is a lurch in the earth and part of the part you climbed up on is gone with the earth tremor. You can only go forwards across a large ice field on your way south to Khazan. Go to {33}."
},
{ // 21/6A
"\"I've been waiting for you spineless scum to leave that castle. You're loaded with treasure - Marionarsis must have bought you off!\" screams Shang. \"I'll show you some steel, dogs!\"\n" \
"  If you want to talk him out of attacking you, go to {36}. If you just want to fight, go to {115}."
},
{ // 22/6B
"Marionarsis casts a Hellbomb Bursts. If noone can absorb this blast, your leader is the target. Roll one die to determine the number of people who die with him. (Roll two dice for each of the remaining characters. The low rollers are destroyed.) If any people using magical attacks aimed at Marionarsis are blown up by his spell, then their spells don't take effect.\n" \
"  On the second combat round, Marionarsis backs away, allowing his eight zombies to advance. Each one has a Monster Rating of 80. Fight for your lives!\n" \
"  Marionarsis has a CON of 25, and he wears magical robes which takes 20 hits, magical or otherwise. If he is killed right off and you then destroy the zombies, go to {34}. If you destroy the zombies, but Marionarsis lives, go to {76}."
},
{ // 23/6C
"The archers hold you at bay. They only await an order from Marionarsis to launch their last flight of arrows. Marionarsis appears on his balcony. \"Your mission has been a failure,\" he laughs.\n" \
"  If one of you wants to challenge him to single combat, go to {119}. If you throw down your weapons and surrender, his guards lead you to {56}. If you grip your weapons and try to fight your way out through a small door in the gate, go to {73}."
},
{ // 24/6D
"As the rear guard hurries down the rope, it is cut from above. Each member of the rearguard must make a third level saving roll on Luck (30 - LK). If they miss, they take hits equal to the number they missed by.\n" \
"  Assemble your ground forces and go to {19}."
},
{ // 25/6E
"You slip into the castle unnoticed. You make it down a hallway in the depths of the castle, and come to a four-way intersection. Ahead of you are stairs which lead upward (go to {6}). To the right is a hallway (go to {98}) and to the left is another hallway (go to {61}). Choose your direction."
},
{ // 26/7A
"You go along a corridor that slopes gently downward. At the end you find a latch. You press it and a section of the wall slides back. Go to {82}."
},
{ // 27/7B
"As this character runs into the castle, he sees Marionarsis at the end of a long hallway. If the character can make a third level saving roll on Luck (30 - LK), he has a chance to attack Marionarsis - go to {126}. If he doesn't make it, he grabs a torch from the wall and runs back to the party. Go to {12}."
},
{ // 28/7C
"\"Base fool!\" he cries. Marionarsis casts a Hellbomb Bursts on your fighting person. The rest of you are commanded to throw down your weapons. Guards surround you and you are taken to {56}."
},
{ // 29/7D
"Your party assembles on the balcony. The zombies on the wall defend weakly, their magically-created incarnations losing power. The gate is breached and Shang rides into the courtyard. Ropes are thrown up to you and you climb down to safety.\n" \
"  Shang commends you for accomplishing your mission. You each receive full suits of armour (take your choice), and 5000 gold pieces. This trip has been worth 1000 adventure points. You are done - go to {135}."
},
{ // 30/7E
"There are fifteen defenders in the group of men. If any characters are staying here, they make up as many defenders as possible. Any other defenders should be defined by Monster Ratings, to make the number of defenders total 15. To determine the Monster Rating of each, roll one die, multiply by 10 and add 20. Do this on an individual basis. (If no characters are here, just roll up fifteen defenders, rolling each individually.) If you destroy them you go into the leader's igloo and find...go to {79}."
},
{ // 31/7F
"The crossbowmen fire. At this range they will not miss. If there are more than six characters attacking, each character should roll two dice. The lowest six characters get hit with an arbalest bolt (does 6 dice + 3 damage). Armour counts[ at face value only]. If there are an odd number of characters, roll two dice and the lowest rollers are hit with the spares.\n" \
"  If anyone is left standing and wants to fight, go to {8}."
},
{ // 32/7G
"You slash and hack your way to freedom, fighting back down the stairs and back to your original intersection. You may leave the castle (go to {88}), take the right corridor (go to {98}), or take the left corridor (go to {61})."
},
{ // 33/7H
"Walking along on an ice field is not very easy. Everyone in the party should see if they blunder or slip into a crevasse that is thinly covered with snow. Check this by making a third level saving roll on Luck (30 - LK). To miss it is to be sliced to ribbons by icy blades and impaled on spears of ice. Those characters are dead. Any survivors should go to {46}."
},
{ // 34/8A
"Through a long, full-length mirror on the wall steps Shang and five black-robed wizards. \"Well! We had given you up for dead, and finally located this fortress on our own. I see you accomplished your mission, and bravely - following him into the unknown like this.\"\n" \
"  You grin and agree with the barbarian general. You are led through the mirror, back to Overkill. Later, with the whole host of Lerotra'hh gathered about you, the rank of Sub-General is bestowed upon you. [You get 500 gold pieces a week and will lead any group of delvers that you are with. You obtain 10 first-level warriors as your retainers, full armour and weapons including bows. (The retainers are of your race.) ]You are also now fully supplied, and you receive 3500 experience points for this adventure. You are done. Congratulations! Go to {135}."
},
{ // 35/8B
"A group of zombies comes down the passage in the castle to investigate a report of intruders. Roll 1 die and add 2 for the number you must fight. Each has a Monster Rating of 60. If you survive them, go to {85}."
},
{ // 36/8C
"One character should average his LK, IQ and CON (luck, brains and sheer guts). If you make a fifth level saving roll on that average (40 - ((LK + IQ + CON) ÷ 3)), Shang believes you and allows you to go to {135}. If he doesn't believe you, go to {115} and fight. However, the character that \"lied\" to him will have to take half of the hits that Shang generates, as that character is his primary target."
},
{ // 37/8D
"You smash through the guards and escape the castle walls. Everyone in the party should make a third level saving roll on Luck (30 - LK) to avoid the missile fire from the castle. Each person who misses the saving roll takes four dice worth of damage for the arrows.\n" \
"  If anyone lives, go to {104}."
},
{ // 38/8E
"A dagger through the eye kills him. With his death a fire demon (Monster Rating 100) breaks free of the amulet he wears. Fight the demon. If you win, go to {17}."
},
{ // 39/8F
"As those on the rope climb down, the rope is cut from above by the wandering guards left on the balcony. All of the people on the rope must make a third level saving roll on Luck (30 - LK). Damage due to the fall is determined by the number you missed the saving roll by. (If you needed a 12 to make it and you got a 7, you take 5 hits.[ If you had to only hit a 5 on two dice and you missed, you take 5 hits because you *should* have been able to survive easily - something went *very* wrong!])\n" \
"  Assemble your survivors and go to {19}."
},
{ // 40/8G
"Everyone in the party going through the door must make a third level saving roll on Luck (30 - LK). Place your characters in single-file order and march them through until one misses the saving roll. If none miss it, go to {82}. As soon as one misses the roll, go to {16}."
},
{ // 41/8H
"[You now take the places of guards at the front you destroyed earlier. You get full suits of armour and fight (as allies) with as many wandering monsters as you need to make the number of guards at the front total 9. You can get experience points and wealth from the dead attackers, but all magical items revert to Marionarsis. Stay as long as you like, defending Marionarsis against *all* attackers.\n" \
"  ]When you are done, tired of being employed here, you may leave up a path on the side of the volcano and out at {33}."
},
{ // 42/9A
"You walk for about a mile through the warm labyrinthine tunnel into which you have been teleported. It slopes upward and during your hike you fail to notice any sign of life.\n" \
"  Suddenly, a flame demon drops from the ceiling in front of you. To your right and left you see others. Behind you there are even more. \"Ah, so Marionarsis sent us some more slaves,\" he sneers, looking you over. \"Drop your weapons!\"\n" \
"  Besides the leader, there are a number of flame demons (roll 3 dice to find how many). If you want to drop your weapons as you are commanded, go to {66}. If you want to fight them, go to {77}."
},
{ // 43/9B
"Despite your shock and terror of the forces arrayed against you, you have managed to keep your men together. Roll two dice. This is the number of zombies that attack your group. Each zombie has a Monster Rating of 45. (Casting a Panic spell is useless in a war, as your mission is to destroy your enemy.) If you win, go to {49}."
},
{ // 44/10A
"...a talisman.[ For 10 Strength points it will advance the decay of zombies. They will lose 20 MR per combat turn. It works against a total of 1 six-sided die worth of them each time it is used (roll for each new situation).]\n" \
"  If you would like to leave the jungle and try to climb out of the volcano, go to {20}. If you would like to explore, go to {1}."
},
{ // 45/10B
"As you leave the castle of Marionarsis you come onto the battlefield. Wounded and broken bodies surround you. The army of Khazan has been broken, the forces of Marionarsis decimated. The smell of death is everywhere.\n" \
"  As your group leaves the valley, your leader must make a second level saving roll on Luck (25 - LK). If he makes it, go to {135}. If he doesn't make it, go to {21}."
},
{ // 46/10C
"Walking without having been prepared for arctic conditions is very difficult. Roll one die and add three. This is the number of days that it takes you to get to warmer climes. For each day in these freezing conditions, you must make a saving roll on your *current* Constitution. On the first day you must make a second level saving roll on Constitution (25 - CON). For each day after that you must add one to the level of that saving roll (to determine the effects of frostbite and hunger), unless you are the only character left or there are no dead characters at the end of that day. In that case, you have no food and the saving roll will go up *two* levels each day.\n" \
"  Hits are taken according to the number by which you miss your saving roll. Constitutions are adjusted according to the number of hits taken, and then the next saving roll is made on the adjusted CON. (This simulates the cumulative damage done by constant cold.)[ Note: if you just have to hit a five on two dice to make the saving roll and you miss, you take five hits.]\n" \
"  If [any of ]you survive, go to {83}."
},
{ // 47/10D
"Marionarsis is a wizard. He clicks off a Hellbomb Bursts on your leader. Roll one die to determine the number of people who will also be taken out by the Hellbomb Bursts. These people will be killed regardless of the possible protection of any of the other members of the party. (Throwing two dice for each character and blowing up the people who roll low is the suggested method of determining who dies.) If anyone is left, they may wish to reconsider by going to {18}. If you want to attack now, go to {121}."
},
{ // 48/10E
"With the death of Marionarsis the zombies on the walls fall lifeless. One of you opens a door in the larger gate and four dwarves run over to the windlass and raise the gate.\n" \
"  Shang rides in and congratulates you on accomplishing your mission, despite the obvious trouble you had. Each of you is offered a commission in the army of Khazan. Each of you will be given the rank of major, will receive [a salary of 75 gold pieces a week, ]your choice of armour and weapons, a horse[, and two armed first level privates (roll them up and arm them) of your kindred]. You have received 3500 ap, and are done - go to {135}."
},
{ // 49/11A
"Even as you free yourselves from that group and turn to face another, you see all the zombies dropping lifeless on the ground. \"Marionarsis is dead!\" cries a lone figure in the castle. A cry of joy goes up from the assembled host and you all march into the castle. Once inside, you receive 300 gold pieces and any weapon of your choice. Go to {135}."
},
{ // 50/11B
"A single zombie comes down to investigate the goings-on at the door, but you hide and he misses you. When he is gone, you and your men go down the passage into the castle and come to a four-way intersection. Ahead of you are stairs leading upward (go to {6}). To the right is a hallway (go to {98}); to your left is another hallway (go to {61}). Choose your direction."
},
{ // 51/11C
"You slip from the castle in the darkness and return to camp. You know all the passwords and a sub-captain stops you at the interior perimeter of the camp. He orders you to wait until he can report to Shang; then he will return to lead you to him.\n" \
"  If you wish to wait, go to {97}. If you want to launch an attack, disobeying the order to wait, rush towards the tent that houses Shang and go to {118}."
},
{ // 52/11D
"\"Your valiant action in opening the gate, in the face of probable death, is commendable,\" Shang informs you, \"even though you did fail your assigned mission...\"\n" \
"  Each one of you is hailed as a hero. You are entered into the Order of the Dragon, and are retired with a stipend of 200 gp a week. You have earned 3000 ap and you are done. Go to {135}."
},
{ // 53/11E
"The battle finally ends. You and the remainder of your men are taken before Shang. \"You have failed your mission...Each of you will be tried before a military tribunal to determine punishment.\"\n" \
"  If your leader wishes to claim all responsibility for the actions of your people, go to {2}. If you wish all your characters to stand trial individually, go to {63}. If there is only one character left, you *must* go to {2}."
},
{ // 54/11F
"He awakens and says, \"I can make it well worth your while to spare me. Shang and his forces cannot stop me or destroy my castle. I'll give each of you 1000 gold pieces to let me go.\" If you take him up on his offer, go to {3}. If you gag him, knock him out, and attempt to smuggle him out of the castle, go to {86}."
},
{ // 55/11G
"The tent's cords are suddenly cut. As the heavy canvas material settles around you, you are bound. Shang knew that you had been sent to kill him, and he had prepared this trap as a failsafe.\n" \
"  Each of you is guilty of treason. You may plead that you were under a geas. Average your IQ and Charisma. Use this to make a saving roll at your level. (The saving roll is at your level because higher level characters should have been smarter than to fail at such a mission.) If you make it, you must add two to your die roll on the Military Sentence Table in the back. If you fail the saving roll, you must add three to your dice roll on that table.\n" \
"  You are done. You got 1700 ap for this trip. Roll on the Military Sentence Table in the back of this booklet to determine your fate, then go to {135}. Good luck."
},
{ // 56/12A
"Marionarsis leads the way through the castle. He takes you down the corridor that was the left branch of the original intersection you came to in his castle. After travelling about fifty yards, you stop - the corridor ends in a very large black doorway. Marionarsis mumbles some arcane chants and the blackness recedes into the top of the doorway.\n" \
"  You follow him into the room, and find that it is empty except for a circle in the middle of the floor. It is ringed with white marble and the colours in it alternate from white to green to red.\n" \
"  \"Against the time a force ever came that could take my castle, I had prepared this teleportation gate to a place far from here,\" Marionarsis says as he walks around the pit. \"Certain words will get you where you want to be, but I don't think that there is any reason for me to share them with you.\"\n" \
"  He gives a sign and his guards hand each of you a sword (choose one [you can handle by Strength and Dexterity ]from the rulebook). Wizards are handed daggers (same criterion for choice). \"Sorry, I cannot allow you your staves - swordsmen I don't fear, but sorcerers are another matter.\"\n" \
"  He gives another sign and all of you are forced into the pit. Roll one six-sided die for the whole group. 1 or 2 means you go through on the green light (go to {122}). 3 or 4 means you go through on the red light (go to {110}). 5 or 6 means you go through on the white light (go to {129})."
},
{ // 57/12B
"Deep in the inferno, the magic-users sense strong magic. If you would like to go toward the area of magic, go to {132}. If you want to ignore this, go to {29}."
},
{ // 58/12C
"Everyone climbs down with no problem, and all of you assemble at {19}."
},
{ // 59/13A
"The horror of seeing undead warriors shuffling towards your group has broken your ability to command them. Each character must fight, in individual combat, one 45 MR zombie. If any under your command survive, go to {49}."
},
{ // 60/13B
"The room at the end of the maze is a guardroom. Seated at a table in the room are seven guards playing poker. Roll on the Wandering Monster Table to decide what type of guards they are and fight seven of them. If you kill them, go to {11}."
},
{ // 61/13C
"You make your way down this hallway for about fifty yards. It comes to an abrupt end. The end wall has nothing but a very large black door, with no latch or handle.\n" \
"  If you would like to go through it, go to {40}. If you want to avoid this doorway and turn around to go back to the intersection, go to {85}."
},
{ // 62/13D
"While you battle the wandering monsters, someone - wizard or warrior, one or several - must be searching for secret doors. The searchers will not be able to fight, but will be able to share hits (the wandering monsters don't care if you are fighting or not, they are paid to kill).\n" \
"  Wizards may use a Revelation spell or search manually. Magic will find the door right away. (Don't go to the Magic Matrix.) If a searcher is not using magic, he or she must make a second level saving roll on Luck (25 - LK), one each combat turn. (The more searchers, the more chances of finding the secret doors.) If you locate one (by magic or by saving roll), go to {10}."
},
{ // 63/13E
"Each of you must make a saving roll at your own level, on the average of your IQ and Luck. (The saving roll is at your level because an experienced soldier deserves harsher scrutiny than a less experienced person.) If you make it, go to {100}. If you fail, go to {109}. (If you have gone up a level, take the level bonuses and then try for the saving roll. Chances are some will make the saving roll and some will not. Determine the fates for each member of the party and split the group, if necessary.)"
},
{ // 64/13F
"As you enter the hallway, a cry comes from behind you. A large knot of zombies heads down the hall at you. You start to run and find more coming from the left hallway and from the stairs ahead of you. Your only clear path is down the hallway to the right. You head down it and lose your following foes. Go to {98}."
},
{ // 65/13G
"You burst free into the middle of the battle for Overkill. You slash and hack in the battle that seems to go on forever. Go to {53}."
},
{ // 66/13H
"You are stripped of your clothing and placed in a coffle. All of you are led to the mines where obsidian is chipped and metal is melted and molded in the earth's natural furnace. Dwarves work metal, humans stone, and the other races are used for light or heavy work as their form allows. You find that the other slaves are men sent to accomplish the same sort of mission you were, and their fate was the same as yours is now.\n" \
"  If these characters ever wish to escape slavery, they must make a fourth level saving roll on Luck (35 - LK) to elude the demons. If they fail the roll, they are slain. (Unless they are immortal, in which case, the demons cut off their arms and legs and keep them alive but imprisoned, forever.)\n" \
"  If you make the saving roll, go to your original tunnel and then out at {123}."
},
{ // 67/14A
"You all take cover behind a large tarp-covered wagon. As you hide there, one of you notices that oil is dripping out of the bottom of the wagon. If you have the means for making fire, you may torch it and push it into the wooden gate.\n" \
"  If you have the means for making fire and want to burn the gate, go to {12}. If you want to fight within the citadel and kill creatures instead, go to {94}. If you want to torch the wagon, but lack the means for fire, you may send one man back into the castle to find a lit torch. Choose a person for the mission and go to {27}. This person cannot be the leader!"
},
{ // 68/14B
"Each has a Monster Rating of 150. If you kill them in one combat round, go to {93}. If it takes more than one combat round, go to {103}."
},
{ // 69/14C
"These characters become residents of this village. [For all of the people they may fight here in the future, they will get experience and a share of the booty. Keep track of the members of the different groups of characters. ]If you decide that they will leave the village you must go to {74} if you have been in the jungle encampment, or {30} for the polar encampment - and you *must* fight to get away. Only one group may fight at a time and the others will fight against them. (For example, if characters from Group A try to leave, the characters from Groups B and C will oppose them, along with any Monster-Rated people that you generate to make the number of defenders equal 15.)\n" \
"  Other than that, these characters have finished their adventure. Record their location on a sheet of paper and keep it in the back of this book. Each of them has earned 500 adventure points for stopping at this point."
},
{ // 70/14D
"The guard takes you to the tent of Lerotra'hh's general, a massive barbarian named Shang. \"I want you and your men to slip into the Citadel,\" he says with a northern accent, \"and kill Marionarsis. There is a secret door in the Citadel's walls that was placed there by the mad architect Ardop when he built it. We've got the key to that door, and under cover of this darkness you can reach it. Good luck.\"\n" \
"  You take your leave of Shang and set out. Leaving the glow of the thousand fires of the Death Host, you quickly head toward the Citadel through a small grove that lies to the south of the Citadel. The leader of your group must make a second level saving roll on Luck (25 - LK). If he makes it, go to {95}. If he misses the saving roll, go to {14}."
},
{ // 71/15A
"\"Your managing to get the gate open was a great help to our forces, despite the fact that I had to kill the wizard. You have shown ingenuity in your methods - I like that.\"\n" \
"  Shang offers you each a commission in the Khazani army. Your rank would be sub-captain[ and you would earn 50 gold pieces a week for the length of your service].[ You may have leave to visit your home environs, but all treasure you capture must be turned over to the party for fair and equal distribution. Also, being honourable, you must not engage in treachery within a party during the duration of your stint with the army.]\n" \
"  You get 2500 ap whether or not your accept the commission. You are done - go to {135}."
},
{ // 72/15B
"With a battle cry you tear into the forces of Marionarsis. Your band faces a group of zombies worth 100 MR each (roll 1 die to see how many). If [any of ]you survive, go to {53}."
},
{ // 73/15C
"Six 6th-level saving rolls on Luck (45 - LK) for everyone running is called for. Each failure results in adding one level to the level number of the next saving roll, and four dice of arrow damage *per number you missed the saving roll by*. (If you miss by 2, two arrows hit you with 4 dice each.) If you survive, go to {65}."
},
{ // 74/15D
"Within the village there are fifteen defenders. If characters are residing here, they must be as many of the fifteen as possible. The rest of the defenders have just Monster Ratings. To determine the Monster Rating for each of the defenders, roll one die, multiply that number by 10, then add 20. Do these on an individual basis. If there are no regular characters living in the village, simply roll up 15 Monster-Rated defenders.\n" \
"  If you destroy all the defenders, you enter the chief's tent and find...go to {44}."
},
{ // 75/15E
"You are automatically guilty of treason. However, you can plead that you were under a geas. Have the leader average his Charisma and IQ and make a saving roll at his level on that number. (The military tribunal feels that the more experienced people should show more responsibility, hence the saving roll at your own level). If you make the saving roll, you only have to add one to your die roll on the Military Sentence Table in the back of this booklet. If you miss the saving roll, you must add two to your die roll on that table. In this case the leader is responsible for the fate of the whole party. You have each obtained 1350 ap for this trip. Roll on the Military Sentence Table to find your final fate; afterwards, go to {135}. Good luck, you are done."
},
{ // 76/15F
"\"Back, dogs! You are tough fighters, but I can destroy you. I will let you go free - I will allow you pass through the mirror back to Overkill if you so choose. If not, I will be forced to fight you.\" If you want to return, go to {90}. If you want to fight him, go to {116}."
},
{ // 77/15G
"The leader has a Monster Rating of 200, and each of the other demons has a 50 MR. Close and fight. If you win, go to {92}."
},
{ // 78/15H
"To the victor go the spoils. From his body you get his robes (which take 20 hits[ for a sorcerer], magical hits or otherwise), his swords \"Wizard's Wand\" (worth 1 die + 30), and a deluxe staff ring with spells from level one to level twelve.[ (This ring cannot be given as a gift to a wizard outside the present party. It *must* be sold at its face value, which is the total cost of the spells contained in the ring that the purchasing wizard does not have.) Remember, a lesser wizard will have difficulty with the ring, as with any high level deluxe staff.)]\n" \
"  Go to {48}."
},
{ // 79/16A
"...a magic ring.[ This ring will cast an Icefall spell costing 5 Strength points for anyone - even warriors. (No deductions for levels, only works *every other* combat turn. The maximum damage this can generate is 100 hits, regardless of the caster's adds or level. GMs should modify this only if the target is unusually susceptible or unusually immune to cold.) The Icefall spell functions as listed in the Spell Book.]\n" \
"  If you wish to leave and head back towards Khazan from here, go to {33}. If you want to enter the volcano, you must first descend into the jungle. Go to {1}."
},
{ // 80/16B
"As the door is raised the Khazani horsemen pour into the courtyard. A giant armoured barbarian leads them, and you recognize Shang. Behind him ride five hooded wizards. Marionarsis appears on his balcony.\n" \
"  He looses a blast that fries one of the sorcerers in the saddle. The other four turn and attack him, a nimbus of fire playing over them and launching upward like a geyser. Marionarsis is completely overwhelmed.\n" \
"  Shang rides over to your command. \"You have failed in your mission,\" he says in low, ominous tones. Go to {52}."
},
{ // 81/16C
"For each warrior, roll two dice. Multiply that number by 30 - this is the Monster Rating for that guard.[ Spells used here must kill your foe, since a Panic spell will make him run and scream about invaders, which is not what you want.]\n" \
"  If you kill both guards in one combat round, go to {93}. If you only kill one or fail to kill both in a single round, go to {103}."
},
{ // 82/16D
"The room you find yourself in is small. The only unusual feature is a ring of white marble set in the floor. Within it are shifting lights. The pool is alternately red, green and white.\n" \
"  If anyone tries to leave the room, they are presented with the uncomforting thought that it is impossible to do so. If you wish to split your party so that you may go into the pool while it is flashing different colours, divide your characters into groups (up to three groups), pick a leader for each, and read on.\n" \
"  If you wish to enter when the light is white, go to {129}. If you want to enter when the light is red, go to {110}. If you want to enter when the light is green, go to {122}."
},
{ // 83/16E
"Half dead from hunger, frostbitten and delirious, you make your way to Khazan. You announce your name at the gate and they rush you to an audience with Lerotra'hh and Shang. You tell them of Marionarsis' hideout in the north, of your harrowing journey back to Khazan across the ice, and then collapse from exhaustion.\n" \
"  When you awaken, you find yourself dressed in the robes of a Hawk-Colonel. Lerotra'hh enters your room and indicates that you needn't rise.\n" \
"  \"You are the stuff of which legendary heroes are made. I have given you the rank of Hawk-Colonel. You will be paid 200 gold pieces a week. Each of you will have four warrior bodyguards, totally armed and of your race, and one magic user of your race with a scroll for the Restoration spell when he attains that level or can use the spell.\"\n" \
"  Lerotra'hh comes to you and kisses you. For a moment your lips relive their brush with arctic cold, but the feeling passes. (This kiss does not confer the same boon as in Arena of Khazan.)\n" \
"  You are done. This adventure was worth 3000 adventure points. Go to {135}."
},
{ // 84/17A
"The rising moon silhouettes the Citadel. As your group sets up camp, one of Lerotra'hh's personal guards comes to your group and speaks with your leader. He turns back to you and says that the Death Goddess would like you to go on a special mission for her. If you'd like to try this special mission, go to {70}. If not, get a good night's sleep - it may be your last. Go to {131}."
},
{ // 85/17B
"You press on, and come to a four-way intersection. Before you is a stairway leading up (go to {6}). To your right is a hallway (go to {98}), and there is another hallway to your left (go to {61}). Choose your direction."
},
{ // 86/17C
"As you go back down the stairs, you run into one party of the wandering monster command. Roll up the type of wandering monster. Then, roll another die and add 4 for the total number of these monsters you face. If you win, go to {37}."
},
{ // 87/17D
"You enter the fortress and follow the hallway before you. Opening two bronze doors, you see a large throne room. Seated on the throne is Marionarsis. There are four zombies on each side of Marionarsis (total of 8).\n" \
"  \"Ah, visitors. Welcome, gentlemen. I had hoped I would not have to entertain you here, but Shang controls my castle in the South.\n" \
"  \"If you want to stay, I can arrange it,\" he continues. \"However, if you are determined to fight, we might as well have at it.\"\n" \
"  If you want to stay with Marionarsis, go to {41}. If you want to fight, go to {22}."
},
{ // 88/17E
"As you leave, you enter the battle for Overkill. Have your leader make a third level saving roll on Charisma (30 - CHR). If he makes it, go to {72}. If he misses it, go to {112}."
},
{ // 89/17F
"\"You have come here from Marionarsis' castle, haven't you?\" the people in the camp ask you. You tell them yes, and they offer to let you stay with them. If you want to stay, go to {69}. If you want to leave, go to {102}."
},
{ // 90/17G
"You return to Overkill, just as the castle is razed by Hellbomb Bursts (six of 'em). If you want to try to absorb the damage you may attempt to do so. If you cannot, for any reason, a ninth level saving roll on Luck (60 - LK) will save you (1 saving roll per character).\n" \
"  If you survive, go to {134}."
},
{ // 91/18A
"If he finishes off the demon, all of you may enter at {82}. If he dies, the rest of you watch as his corpse disappears and the demon again becomes a door. Those within the room find they cannot get out. If you wish to split your party, those outside may go to {85} and choose another path. Those in the room must go to {82}. If those outside wish to enter, they should go through the same routine as before, moving in single file, each one trying to make a third level saving roll on Luck (30 - LK). If anyone misses their saving roll, go to {16} and replay the entire sequence."
},
{ // 92/18B
"From the smouldering form of the leader, you take a ring. It reeks of magic. You discover that it will absorb one Hellbomb Burst. After it takes that initial burst, you can use it to absorb other Hellbomb Bursts[ - but for each additional burst you must roll two dice].[ If they come up doubles, the ring explodes with the combined force of all the bursts it has stored. (The first one is a freebie, but the enormous amount of energy captured flaws the ring - hence the subsequent rolls.)]\n" \
"  If you want to leave by the passage you started in, go to {123}. If you wish to continue up and out into the jungle above, go to {1}."
},
{ // 93/18C
"You pass the bodies and make your way to the room of Marionarsis. It is unlocked and unguarded. You find the wizard sleeping. If you wish to murder him in his sleep, go to {95}. If you wish to bind him and try to capture him, go to {54}."
},
{ // 94/18D
"Party members can attack alone or in a group, but due to the size of catwalks on the walls and such, a group of three is about the largest that is logical. For each group or individual fighting there is a wandering monster/guard.\n" \
"  Roll three dice and add three. This is the number of combat turns that you will be fighting. For each threat you dispatch, roll up another. If you survive for the number of combat turns that you must, Shang comes riding over the remains of the walls and into the courtyard.\n" \
"  Gather up your men and go to {53}."
},
{ // 95/18E
"As you break from the grove, a slip of cloud covers the moon. A patrol of zombie guards does not see you and you make it unmolested to the secret door. One of you opens the door with the key Shang gave you. Each character in the group must make a third level saving roll on Luck (30 - LK). If all make it, go to {25}. If some miss the roll, record the number of characters that missed it and go to {120}."
},
{ // 96/18F
"Through the inferno that was the gate rides Shang. Marionarsis appears on his balcony and throws a spell at Shang, which does not have its full intended effect.\n" \
"  The barbarian guides his rearing mount with his knees and raises a crossbow. He fires and you see the top half of Marionarsis' head explode. Shang calms his horse and rides over to you. \"You have failed your mission...\" he tells you. Go to {71}."
},
{ // 97/18G
"The sub-captain returns and says, \"Shang will see you now.\" You follow and are led into Shang's tent. He is seated in a massive chair with his back to a thick curtain.\n" \
"  \"Gentlemen, I see you have fared well on your mission. I see new weapons and armour - but no blood. I think you are all traitors...\" he tells you. He waves his hand and the curtain falls. Behind it are six crossbow marksmen. Their bows are pointed at you.\n" \
"  If you decide to surrender, go to {75}. If you want to attack, go to {31}."
},
{ // 98/19A
"As you wander off down this corridor you find that you have lost your way. The twists and turns are augmented with magic to confuse you. Marionarsis uses the maze as a trap for intruders.\n" \
"  Have any *one* character in the party try to make a 7th level saving roll on IQ (50 - IQ). If that person makes it, go to {107}. If the saving roll is missed (there is only one chance to make it), note the number by which it was missed - this is how many turns you will spend wandering around in the maze. This is also the number of times you will have to roll for wandering monsters.\n" \
"  Roll a six-sided die. If you roll a 1, you have met a wandering monster. Fight and destroy it, if you can, before rolling for the next. If your fight goes five combat turns, roll for another wandering monster (unless you are fighting the final one due to you). This time, however, rolling a one *or* a six will mean that one more wandering monster is there. (A wandering monster is more likely to come along if it hears fighting.) Keep rolling for wandering monsters in this manner until you have been killed or have killed all that face you. (Obviously, you can have more than one WM fighting you at a time.) If you survive, go to {15}."
},
{ // 99/19B
"From his body you may take his weapons, armour, and the amulet. You also find two jewels (roll on the Jewel Generation Table to find out what they are). Go to {135}."
},
{ // 100/19C
"The military tribunal considers for a moment and decides that you have done your best. You made a valiant attempt against impossible odds. They retire you as a hero on a stipend of 100 gp a week for as long as you live. You have gained 2000 experience points. You are done - go to {135}."
},
{ // 101/19D
"Up and over the wall is the only way to go. You run into three different groups of wandering monsters. In each group are three WMs. Roll for each group independently, and fight them (one group at a time, one group right after the previous one). If you defeat them, go to {87}."
},
{ // 102/19E
"\"We cannot allow you to leave. You will reveal our position to Marionarsis. Stay - or fight!\" they tell you. If you want to stay, go to {69}. If you want to fight, go to {30}."
},
{ // 103/20A
"Take the number of guards alive on the landing and add one. Then make a saving roll on Luck at that level. (If there are two alive, it's a third level saving roll, etc.) Everyone in the party must make a saving roll on Luck at that level. For each person who missed, one more wandering monster will come to join the fight.\n" \
"  Your attempts to kill the first guards failed. You must still fight them, and the additional monsters that their cries bring. If you survive when the haze of battle finally clears, go to {113}."
},
{ // 104/20B
"You manage to bring Marionarsis to Shang's tent. Shang summons the camp wizards and they build a small fire in the middle of his tent. One throws green crystals onto the fire and a thick cloud of green smoke begins to form. It takes shape and becomes the face of the empress Lerotra'hh!\n" \
"  \"Ah, Marionarsis, I have longed to meet you. You will be my guest, won't you?\" her mocking spectral voice asks the terror-stricken wizard.\n" \
"  The smoke swirls about and covers him completely, obscuring your line of sight. When the green smoke vanishes, so has Marionarsis.\n" \
"  Each of you is given 6000 gold pieces in gems, a suit of armour (your choice), and a horse. You have earned 1200 experience points. You are finished with this adventure - go to {135}."
},
{ // 105/20C
"A combined Strength of at least 30 is required to make the windlass move at all. It must be turned three full revolutions to open the gate - each revolution will require 100 ST points (300 total). (This strength is not lost, and may be combined from several characters.) Each time you exert strength to turn the windlass, one combat turn passes. (For example, two dwarves with Strengths of 25 each (a total of 50) will take six combat turns to raise the door completely.)\n" \
"  While you are at the wheel, everyone must make a third level saving roll on Luck (30 - LK) each combat turn. The archers on the wall have noticed you and are firing, twelve arrows at a crack. If you miss, roll one die to determine how many arrows (worth 4 dice) hit you. (The total number of arrows shot is 12, so divide them evenly if too many people miss saving rolls.)\n" \
"  If you have any archers who would like to return fire, they are shooting from near range (6-50 yards) at a man-sized target (L4-SR on Dexterity (35 - DEX) to hit). Each hit will reduce the number of archers by one (regardless of damage done). Archers on the walls will be replaced at 2 per combat round beginning with the third combat round. Needless to say, your archers cannot turn the windlass while shooting.\n" \
"  If you succeed in opening the door, go to {80}. If there is only one survivor, or a combined total of less than 30 Strength points remaining, then you have failed. If you fail but some of you survive, go to {23}."
},
{ // 106/21A
"You all slay each other and peacefully sink into oblivion...for a moment. You have forgotten that Marionarsis is the master of the undead. Your lifeless fingers pick up the weapons that still bear a slight trace of the warmth your body once held. Eyes blank, you shuffle up to your place on the wall to repel the invaders that you once considered your brothers. The outcome of the battle matters little now...you are among the undead."
},
{ // 107/21B
"You have figured out the maze. If you wish, you can go back to the original intersection and make another choice, or you may go on to the end of the maze. If you want to go back to your mission, go to {25}. If you want to go to the end of the maze, go to {60}."
},
{ // 108/21C
"He takes you to his armoury and gives each of you a full set of armour, a shield if you desire it, and whatever weapon you would like to have. (Weapons usage limitations are still in effect.)\n" \
"  If you would like to wheel and attack him, newly armed, go to {125}. If you want to go try to kill Shang, go to {51}."
},
{ // 109/21D
"The tribunal deliberates. Finally Shang rises and announces that you have been found guilty of dereliction of duty. You have gained 2000 ap. Turn to the Military Sentence Table in the back of this booklet to decide what punishment you must face, then go to {135}. You are done."
},
{ // 110/21E
"The first thing you notice when the tingling feeling of teleportation stops is that you are very hot. The place you have come to is dark and dimly lit. The air is thick with sulfur. You are in a rough, natural tunnel. From behind you is coming a slightly cool breeze. To go to it, go to {123}. In the direction you are facing, the tunnel begins to rise, and grows warmer. To go that way, go to {42}."
},
{ // 111/21F
"As you make your way up towards the break in the walls of the volcano, you come upon an encampment of men. They are dressed in furs of white and look much warmer than you. If you wish to attack them, go to {30}. If you want to go greet them in peace, go to {89}. If you want to bypass them, going down into the jungle in the volcano, go to {1}."
},
{ // 112/21G
"Your leader loses control of all of you and you fight as individuals. You face a number of zombies - roll one die to see how many. Keep track of combat turns, as a fighter or magicker who finishes his foe quickly will be allowed to aid another member of the party who is not faring well. The zombies will also gang up if party members are destroyed, first hitting the wounded, then hitting the strong.\n" \
"  If anyone survives, go to {53}."
},
{ // 113/22A
"You make your way up the stairs and into Marionarsis' room. You enter and find the wizard fully awake. \"Welcome,\" he says. \"I have been expecting you. I have an offer for you.\"\n" \
"  If you attack him immediately, go to {47}. If you wait and listen, go to {18}."
},
{ // 114/22B
"To kill your leader, you must fight him. Battle for three combat rounds, unless one side dies first. The winner of two combat rounds gets his choice as to party action. If the leader wins, you open the door (go to {105}). If the others win, go to {67}."
},
{ // 115/22C
"Shang is a warrior with plate armour (14 hits[ × 2]), and he has an enchanted great sword (6 dice[ × 3]). He has a CON of 100 and combat adds of 215. He also has a kris in his belt[ that cancels 1st through 3rd level magic, and disrupts higher level spells (a 4th level Take That You Fiend becomes 1st level, and so forth)]. He also wears an amulet[ which alters all magical items that will take hits - the item will take only that number of hits and will be destroyed]. [(For example, a Yuurrk from Deathtrap Equalizer will take 100 hits and then shatter.) This change is permanent.]\n" \
"  If you vanquish him, go to {99}."
},
{ // 116/22D
"Marionarsis fires another Hellbomb Burst. It is aimed at your leader. If it cannot be absorbed, roll one die to determine the number of characters besides the leader that die. (Roll two dice for each character, and the low rollers die.)\n" \
"  If anyone lives to fight Marionarsis, he draws his sword. He has a Constitution of 25, combat adds of 170. His sword gets 1 die + 30 and his robes take 20 hits (magical or otherwise)[, and nullify the effects of poison].\n" \
"  If you kill him, by magic or by weaponry, go to {9}."
},
{ // 117/22E
"You enter the village and several men come out to greet you. \"You have come through the room in Marionarsis' castle, haven't you?\" they ask. You nod, and they offer to allow you to stay with them. If you want to stay with them, go to {69}. If you want to leave, go to {5}."
},
{ // 118/23A
"You run to the tent with cries of \"We must see Shang! The battle depends on it!\" You burst into Shang's tent where you find him in conference with his officers. Roll one die and add three for the number of officers present.\n" \
"  Roll another die. Multiply the number you get by 10, and add 30 to determine the Monster Rating for his officers (the die roll corresponds to rank and ability - 1=sub-captain, 2=captain, 3=major, 4=sub-colonel, 5=hawk-colonel, 6=sub-general, and add an extra 30 MR to sub-generals). There is also the additional sub-captain (40 MR) and Shang (6-die great sword, plate armour, CON of 100, combat adds of 215 and a kris[ to disrupt 1st-3rd level magic]). Shang also has an amulet[ that changes any magical item designed to absorb hits so that it will absorb that number of hits only and then will be destroyed].[ (All magical items that this applies to *have* been affected already.)]\n" \
"  If you surrender, go to {75}. If you wish to fight, do so. If you win, go to {4}."
},
{ // 119/23B
"Marionarsis teleports in front of you with a sword in his hand. If you wish to fight him fairly, go to {13}. If you have a close-range missile weapon (dagger, chakram, or shuriken) and wish to cheat, go to {124}."
},
{ // 120/23C
"The number of missed saving rolls indicates the level number for the saving roll on IQ that the leader must make. (Those that missed the saving roll were spotted entering the castle and the leader must think of some sort of evasive action.) If the leader makes the saving roll, go to {50}. If he missed by 1-5, go to {35}. If the leader missed by more than five, go to {64}."
},
{ // 121/23D
"He teleports out before you can act, but you find that there are plenty of wandering monsters that just burst through the door looking for a fight. (Roll two dice for the number of wandering monsters. Only three can get into the room per combat round.) If you want to slash your way back through the castle, go to {32}. If you want to search for secret doors in this room, go to {62}. If you have rope and want to try to escape via the balcony, go to {127}."
},
{ // 122/23E
"As the tingling of teleportation wears off, you notice that the air has gotten very humid. All around you is dense jungle, and as you look around you, you can see that the jungle is in the middle of a very large volcano.\n" \
"  If you wish to walk through the jungle until you find a path up the wall of the volcano and out, go to {20}. If you want to explore, go to {133}."
},
{ // 123/23F
"As you reach the tunnel mouth there is a rumble behind you. You all run for the exit as stones crash about you. Certain you are safe, you step onto the snowy ground outside what you now learn is a volcano. You feel very fortunate at avoiding being crushed by falling stones until someone looks up and sees an avalanche coming your way.\n" \
"  Everyone is swept up and carried along by the avalanche. All of you are covered totally and have little or no idea which way is up. Everyone in the party must make a second level saving roll on Luck (25 - LK) to see if they find the right way to dig and do so. Those who miss - even if they only have to make a five and miss by one - die as they dig the wrong way and freeze to death or suffocate (your choice).\n" \
"  Survivors go to {46}."
},
{ // 124/24A
"Figure the total damage done (L2-SR on Dexterity (25 - DEX) to hit him at this range). Marionarsis' robes act as armour and take 20 hits.[ They also neutralize all poison.] His CON is 25. If you kill him, go to {76}. If you fail, go to {28}."
},
{ // 125/24B
"Marionarsis hits you with a Mind Pox. [While you are all on the floor drooling mindlessly, he then turns the character with the lowest CHR into a toad, and turns your leader into a gnat. ]Guards enter the room and strip you of your weaponry. They guide you behind Marionarsis. Go to {56}."
},
{ // 126/24C
"If the character has a missile weapon, he may fire. The range is 25', and the target is man-sized (4th level saving roll on Dexterity (35 - DEX) to hit). Calculate the amount of damage, if you hit. If it is more than 45, go to {76}. If it is less than that, you have failed to kill Marionarsis. He wheels and hits that character with a Hellbomb Burst.\n" \
"  Return to {67} and begin again. (Another character may try this option within the same trip.)"
},
{ // 127/24D
"To get to the ground from the balcony, your characters will have to descend 60' of rope. Characters climb down the rope at a rate of 20' per combat turn. To determine the length of time it will take for the whole party to get to the ground, total the number of characters climbing and add two (this allows for three characters on the rope at a time).\n" \
"  While the characters are climbing down the rope, some character(s) will have to act as rear guard to prevent the wandering monsters from cutting the rope from above. The rear guard will have to fight off the wandering monsters for as many turns as it will take for the party to climb down. (Remember that the rear guard must also descend, so their number will slowly dwindle.)\n" \
"  If all but one of the rear guards have climbed down, and all of the wandering monsters have *not* been slain, go to {24}. If the rear guard has slain all of the WMs, go to {58}. If the rear guard is slain while other people are still on the rope, go to {39}. (It is suggested that all characters who are able should fight with the rear guard until it is their turn to go down the rope.)"
},
{ // 128/24E
"The creature has a MR of 150. If you all defeat it, there is nothing left guarding the door. Go to {82}. If you don't defeat it, then those fighting it are dead, so the characters inside should go to {82}. If the first person to miss the saving roll was the first person into the door and you didn't defeat the demon, you are all dead, so close the book."
},
{ // 129/24F
"After the tingling of teleportation wears off, the first thing you notice is that you are very cold. You are hip deep in snow and a wind is jabbing icy swords through your clothing. Above you, the sky is blue, and you quickly realize that you are halfway up the side of a snowbound volcano.\n" \
"  Above you, there appears to be a break in the wall of the cone of the volcano. If you wish to go down the mountain in an attempt to walk south to Khazan, go to {33}. If you wish to enter through the side of the volcano, go to {111}."
},
{ // 130/25A
"The chest is protected by a lock loaded with a vial of water and packed with sodium. Your blow caused it to explode and it does 3 dice worth of damage to you. Armour counts[ its face value only, and shields are of no use]. The chest, however, is now open.\n" \
"  The chest contains two gems that can be rolled for on the Jewel Generator (though neither is magical), and a magical scroll with a spell. To determine the spell on it, roll three dice. This is the level of the spell. Next, roll one die to determine the spell in that level. If the number you roll is greater than the number of spells in that level, use the number you rolled and count backwards through the lower level spells until you find a spell. (For example, if you have an 18th level spell and you roll a 6, you would start counting backwards, beginning with the last spell in the 17th level, through the 16th level and finally end up with only a 15th level spell.)\n" \
"  Only the magic users in this party will be able to use the spell on the scroll. They can teach it to other people, but within the restrictions placed on them by the rules. If no one in the party can use the spell (only warriors, or rogues who can't use the spell because of its level), the party can sell it to any wizard at whatever price the market will bear (there is only one copy).\n" \
"  Go to {45}."
},
{ // 131/25B
"Flags are raised and trumpets blown as the dawn creeps into the valley. You and your men bind yourselves for battle and take your places in the ranks. You were warned about the troops of Marionarsis, but until you actually see the ranks of zombies, of living dead coming at you, you fail to believe it possible. Have your leader make a second level saving roll on Charisma (25 - CHR). If the leader makes it, go to {43}. If the leader fails, go to {59}."
},
{ // 132/25C
"As the magickers draw close, they see a spell book that is in flames. A third level saving roll is needed on Luck (30 - LK) to approach the book. Take hits according to the number you miss the roll by (armour doesn't help). Select one wizard to carry the book. All of the wizards in the group investigating the magic must make 4th level saving rolls on their *current* Constitution (35 - CON) to avoid passing out from heat prostration. If the carrier misses the roll, the book is lost. (No second chances - the room is coming down in flames all around you!) Hits are taken according to the number you missed the saving roll by.\n" \
"  Go to {7}."
},
{ // 133/25D
"As you explore in the jungle, you find a small, palisaded village. If you wish to enter it, at peace, go to {117}. If you want to attack the villagers, go to {74}. If you want to bypass the village, go to {1}."
},
{ // 134/25E
"You are brought before Shang. \"You failed your mission. A military tribunal will have to decide your fate.\" If you want each character to stand trial alone, go to {63}. If you wish your leader to take the blame, or if there is only one character alive, go to {2}."
},
{ // 135/25F
"The characters that have entered this adventure once may *never do so again*. (This is logical, after all, for if you failed your mission, they won't entrust another to you. If you have succeeded, or merely fought with the main army, the castle is taken - for you, the war is won.)]\n" \
"  Furthermore, you should never take a character who received a military commission into Naked Doom. That dungeon is reserved for common criminals, and if you *should* commit a crime and be captured in Lerotra'hh's realm, you would probably be drawn and quartered - an officer of the Death Host should not stoop to crime...(Also, remember that Naked Doom allows only 1st and 2nd level characters.)\n" \
"  Finally, if (a) you were rewarded by Lerotra'hh's men (in arms and cash) or (b) if you received a military commission, you need never fight *as a slave* in Arena of Khazan. You would be recognized as soon as you stepped onto the sands, and your belongings would all be returned."
}
}, ok_wandertext[11] = {
{ // 0
"2. Zombie with sword (MR 200.)"
},
{ // 1
"3. Grey werewolf (MR 150.)"
},
{ // 2
"4. Two-headed ogre with club (MR 125.)"
},
{ // 3
"5. Baboon-faced, hulking ghoul (MR 100.)"
},
{ // 4
"6. Living skeleton with tower shield (doubled). Can take hits on shield (MR 75.)"
},
{ // 5
"7. Human warriors with ring mail and target shields (doubled). Can take hits on shields and armour. (MR 50.)"
},
{ // 6
"8. Centaur with ring mail (doubled). Hits can be taken on armour. (MR 75)."
},
{ // 7
"9. Cyclops, 30' tall. (MR 100.)"
},
{ // 8
"10. Naga, 30' long. (MR 150.)"
},
{ // 9
"11. Troll with roofing beam. (MR 200.)"
},
{ // 10
"12. Balrog, wreathed in flame. (MR 300.)"
}
};

MODULE SWORD ok_exits[OK_ROOMS][EXITS] =
{ {  84,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/2A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/2B
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/2C
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/2D
  {  74,  69,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/2E
  {  81,  68,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/2F
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/3A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/3B
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/3C
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/3D
  { 130,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/3E
  {  96,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/3F
  {  76,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/3G
  {  95,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/4A
  { 130,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/4B
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/4C
  { 108, 121,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/4D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/4E
  { 105,  94, 106,  -1,  -1,  -1,  -1,  -1 }, //  19/4F
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/4G
  {  36, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/6A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/6B
  { 119,  56,  73,  -1,  -1,  -1,  -1,  -1 }, //  23/6C
  {  19,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/6D
  {   6,  98,  61,  -1,  -1,  -1,  -1,  -1 }, //  25/6E
  {  82,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/7A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/7B
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/7C
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/7D
  {  79,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/7E
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/7F
  {  88,  98,  61,  -1,  -1,  -1,  -1,  -1 }, //  32/7G
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/7H
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/8A
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/8B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/8C
  { 104,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/8D
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/8E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/8F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/8G
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/8H
  {  66,  77,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/9A
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/9B
  {  20,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/10A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/10B
  {  83,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/10C
  {  18, 121,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/10D
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/10E
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/11A
  {   6,  98,  61,  -1,  -1,  -1,  -1,  -1 }, //  50/11B
  {  97, 118,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/11C
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/11D
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/11E
  {   3,  86,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/11F
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/11G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/12A
  { 132,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/12B
  {  19,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/12C
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/13A
  {  11,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/13B
  {  40,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/13C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/13D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/13E
  {  98,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/13F
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/13G
  { 123,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/13H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/14A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/14B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/14C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/14D
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/15A
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/15B
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/15C
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/15D
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/15E
  {  90, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/15F
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/15G
  {  48,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/15H
  {  33,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/16A
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/16B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/16C
  { 129, 110, 122,  -1,  -1,  -1,  -1,  -1 }, //  82/16D
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/16E
  {  70, 131,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/17A
  {   6,  98,  61,  -1,  -1,  -1,  -1,  -1 }, //  85/17B
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/17C
  {  41,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/17D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/17E
  {  69, 102,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/17F
  { 134,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/17G
  {  82,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/18A
  { 123,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/18B
  {  95,  54,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/18C
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/18D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/18E
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/18F
  {  75,  31,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/18G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/19A
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/19B
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/19C
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/19D
  {  69,  30,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/19E
  { 113,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/20A
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/20B
  {  23,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/20C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/21A
  {  25,  60,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/21B
  { 125,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/21C
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/21D
  { 123,  42,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/21E
  {  30,  89,   1,  -1,  -1,  -1,  -1,  -1 }, // 111/21F
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/21G
  {  47,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/22A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/22B
  {  99,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/22C
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/22D
  {  69,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/22E
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/23A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/23B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/23C
  {  32,  62,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/23D
  {  20, 133,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/23E
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/23F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/24A
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/24B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/24C
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/24D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/24E
  {  33, 111,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/24F
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/25A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/25B
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/25C
  { 117,  74,   1,  -1,  -1,  -1,  -1,  -1 }, // 133/25D
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/25E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 135/25F
};

MODULE STRPTR ok_pix[OK_ROOMS] =
{ "", //   0
  "ok1",
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
  "ok16",
  "",
  "",
  "",
  "", //  20
  "",
  "ok22",
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
  "", //  35
  "",
  "",
  "",
  "",
  "", //  40
  "",
  "ok42",
  "",
  "ok44",
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
  "ok56",
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
  "",
  "ok70", //  70
  "",
  "",
  "",
  "",
  "", //  75
  "",
  "",
  "",
  "ok79",
  "", //  80
  "",
  "",
  "",
  "",
  "", //  85
  "",
  "ok87",
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
  "ok101",
  "",
  "",
  "",
  "ok105", // 105
  "ok106",
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
  "ok117",
  "",
  "",
  "", // 120
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
  ""  // 135
};

EXPORT FLAG                   ok_inwander;

MODULE int                    sentence;

IMPORT FLAG                   inmatrix,
                              usedweapons;
IMPORT int                    armour,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              missileammo,
                              room, prevroom, module,
                              round,
                              spellchosen,
                              spelllevel,
                              spellpower;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *treasures[MODULES],
                             *wanders[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void ok_enterroom(void);
MODULE void ok_wandering(void);
MODULE void ok_sentence1(int penalty);
MODULE void ok_sentence2(void);

EXPORT void ok_preinit(void)
{   descs[MODULE_OK]     = ok_desc;
    wanders[MODULE_OK]   = ok_wandertext;
}

EXPORT void ok_init(void)
{   int i;

    exits       = &ok_exits[0][0];
    enterroom   = ok_enterroom;
    for (i = 0; i < OK_ROOMS; i++)
    {   pix[i] = ok_pix[i];
    }

    sentence    = 0;
    ok_inwander = FALSE;
}

MODULE void ok_enterroom(void)
{   TRANSIENT FLAG ok;
    TRANSIENT int  i,
                   result,
                   result2,
                   result3,
                   target;
    PERSIST   int  oldstat;

    switch (room)
    {
    case 1:
        elapse(ONE_DAY / 2, TRUE);
    acase 2:
        savedrooms(3, (iq + lk) / 2, 100, 109);
    acase 3:
        give_gp(1000);
    acase 4:
        give(626);
        give(ITEM_SO_HORSE);
        award(1650);
    acase 7:
        if (oldstat)
        {   give(630);
        }
        give(641);
        DISCARD shop_give(8);
        award(1000);
    acase 8:
        create_monsters(418, 6);
        create_monster(412);
        create_monster(411);
        do
        {   if (getyn("Surrender (otherwise fight)"))
            {   dispose_npcs();
                room = 75;
            } else
            {   oneround();
        }   }
        while (countfoes());
        if (room == 8)
        {   room = 55;
        }
    acase 9:
        gain_flag_ability(112);
        award(4000);
    acase 10:
        fight();
    acase 11:
        oldstat = dice(1) * 1000;
    acase 12:
        if (saved(4, lk))
        {   if (ability[93].known || ability[97].known)
            {   templose_con(dice(6));
            } else
            {   templose_con(dice(10));
        }   }
    acase 13:
        create_monster(400);
        fight();
    acase 14:
        create_monsters(401, dice(1) + 1);
        fight();
    acase 15:
        oldstat = dice(1) * 1000;
    acase 16:
        create_monster(402);
        evil_freeattack();
    acase 17:
        if (!saved(2, lk))
        {   templose_con(misseditby(2, lk));
        }
        if (class == WIZARD || class == WARRIORWIZARD) // %%: do these still have to do the saving roll? We assume so.
        {   room = 57;
        } else
        {   room = 29;
        }
    acase 20:
        if (!races[race].humanoid)
        {   room = 122;
        } else
        {   if (!saved(3, lk))
            {   die();
        }   }
    acase 22:
        create_monster(400);
        if (!immune_hb())
        {   die();
        } else
        {   good_freeattack();
            result = countfoes();
            dispose_npcs();
            create_monsters(403, 8);
            fight();
            if (result) room = 76; else room = 34;
        }
    acase 24:
        dispose_npcs();
        if (!saved(3, lk))
        {   good_takehits(misseditby(3, lk), TRUE); // %%: does armour help?
        }
    acase 28:
        if (!immune_hb())
        {   die();
        } else
        {   room = 56;
        }
    acase 29:
        DISCARD shop_give(8);
        give_gp(5000);
        award(1000);
    acase 30:
        create_monsters(404, 15);
        for (i = 0; i < 15; i++)
        {   npc[i].mr = (dice(1) * 10) + 20;
            recalc_ap(i);
        }
        fight();
    acase 31: // %%: ambiguous paragraph
        good_takehits(dice(6) + 3, TRUE);
    acase 32:
        dispose_npcs(); // %%: do we actually have to fight them? We assume not.
    acase 33:
        if (!saved(3, lk))
        {   die();
        }
    acase 34:
        gain_flag_ability(108);
        while (shop_give(0) != -1);
        award(3500);
    acase 35:
        create_monsters(401, dice(1) + 2);
        fight();
    acase 36:
        savedrooms(5, (lk + iq + con) / 3, 135, 115);
    acase 37:
        if (!saved(3, lk))
        {   templose_con(dice(4));
        }
    acase 38:
        create_monster(405);
        fight();
    acase 40:
        savedrooms(3, lk, 82, 16);
    acase 42:
        oldstat = dice(3);
    acase 43:
        create_monsters(408, dice(2));
        fight();
    acase 44:
        give(621);
    acase 45:
        if (prevroom == 11 || prevroom == 15 || prevroom == 130)
        {   give_gp(oldstat);
        }
        savedrooms(2, lk, 135, 21);
    acase 46:
        result = dice(1) + 3;
        for (i = 1; i <= result; i++)
        {   if (!saved(i * 2, con))
            {   templose_con(misseditby(i * 2, con));
            }
            elapse(ONE_DAY, FALSE); // %%: do we regain ST? We assume not.
        }
    acase 47:
        if (!immune_hb())
        {   die();
        }
    acase 48:
        gain_flag_ability(109);
        while (shop_give(8));
        while (shop_give(2));
        give(ITEM_SO_HORSE);
        award(3500);
    acase 49:
        give_gp(300);
        DISCARD shop_give(10);
    acase 52:
        award(3000);
    acase 55:
        award(1700);
        if (saved(level, (iq + chr) / 2))
        {   ok_sentence1(2);
        } else
        {   ok_sentence1(3);
        }
    acase 56:
        drop_all(); // %%: only weapons, or everything?
        if (class == WIZARD)
        {   DISCARD shop_give(5);
        } else
        {   DISCARD shop_give(4);
        }
        result = dice(1);
        if   (result <= 2) room = 122;
        elif (result <= 4) room = 110;
        else               room = 129;
    acase 59:
        create_monster(408);
        fight();
    acase 60:
        for (i = 1; i <= 7; i++)
        {   ok_wandering();
        }
        fight();
    acase 62:
        do
        {   evil_freeattack();
            if (cast(SPELL_RE, FALSE) || saved(2, lk))
            {   room = 10;
        }   }
        while (room == 62);
    acase 66:
        drop_all();
        if (!saved(4, lk))
        {   die();
        }
    acase 68:
        create_monsters(409, 2);
        oneround();
        if (countfoes())
        {   room = 103;
        } else
        {   room = 93;
        }
    acase 69:
        award(500);
        create_monsters(404, 15);
        for (i = 0; i < 15; i++)
        {   npc[i].mr = (dice(1) * 10) + 20;
            recalc_ap(i);
        }
        fight();
        if (been[133])
        {   room = 74;
        } else
        {   // assert(been[111]);
            room = 30;
        }
    acase 70:
        savedrooms(2, lk, 95, 14);
    acase 71:
        if (getyn("Accept commission"))
        {   gain_flag_ability(110);
        }
        award(2500);
    acase 72:
        create_monsters(410, dice(1));
        fight();
    acase 73:
        result = 6;
        for (i = 1; i <= 6; i++)
        {   if (!saved(result, lk))
            {   good_takehits(dice(4) * misseditby(result, lk), TRUE);
                result++;
        }   }
    acase 74:
        create_monsters(404, 15);
        for (i = 0; i < 15; i++)
        {   npc[i].mr = (dice(1) * 10) + 20;
            recalc_ap(i);
        }
        fight();
    acase 75:
        award(1350);
        if (saved(level, (chr + iq) / 2))
        {   ok_sentence1(1);
        } else
        {   ok_sentence1(2);
        }
    acase 77:
        create_monster(406);
        create_monsters(407, oldstat);
        fight();
    acase 78:
        give(ITEM_OK_DELUXER);
        if (class != WARRIOR)
        {   for (i = 0; i < SPELLS; i++)
            {   if (spell[i].level <= 12 && (spell[i].level <= 7 || class != ROGUE))
                {   learnspell(i);
        }   }   }
    acase 79:
        give(623);
    acase 81:
        create_monsters(409, 2);
        if (shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE)) // %%: we assume large size at pointblank range
            {   evil_takemissilehits(target);
        }   }
        else
        {   castspell(-1, TRUE);
        }
        if (countfoes())
        {   room = 103;
        } else
        {   room = 93;
        }
    acase 83:
        gain_flag_ability(111);
        award(3000);
    acase 86:
        result = dice(1) + 4;
        for (i = 1; i <= result; i++)
        {   ok_wandering();
        }
        fight();
    acase 88:
        savedrooms(3, chr, 72, 112);
    acase 90:
        if (!immune_hb() && !saved(9, lk))
        {   die();
        }
    acase 91:
        fight();
    acase 92:
        give(624);
    acase 94:
        result = dice(3) + 3;
        for (i = 1; i <= result; i++)
        {   if (!countfoes())
            {   ok_wandering();
            }
            oneround();
        }
        dispose_npcs();
    acase 95:
        savedrooms(3, lk, 25, 120);
    acase 98:
        if (saved(7, iq))
        {   room = 107;
        } else
        {   result = misseditby(7, iq);
            for (i = 1; i <= result; i++)
            {   result2 = dice(1);
                if (result2 == 1 || (result2 == 6 && countfoes()))
                {   ok_wandering();
                }
                oneround();
                oneround();
                oneround();
                oneround();
                oneround();
            }
            room = 15;
        }
    acase 99:
        give(KRI);
        give(629);
        rb_givejewels(-1, -1, 1, 2);
    acase 100:
        award(2000);
    acase 101:
        for (i = 1; i <= 3; i++) // %%: is each group of monsters of the same type?
        {   ok_wandering();
            ok_wandering();
            ok_wandering();
            fight();
        }
    acase 103:
        if (!saved(countfoes() + 1, lk))
        {   ok_wandering();
        }
        fight();
    acase 104:
        give(642);
        DISCARD shop_give(8);
        give(ITEM_SO_HORSE);
        award(1200);
    acase 106:
        die();
    acase 108:
        DISCARD shop_give(8);
        DISCARD shop_give(9);
        DISCARD shop_give(10);
    acase 109:
        award(2000);
        ok_sentence1(0);
    acase 112:
        create_monsters(410, dice(1)); // %%: we assume MRs of 100, based on OK72
        fight();
    acase 115:
        create_monster(411);
        fight();
    acase 116:
        if (!immune_hb())
        {   die();
        } else
        {   create_monster(400);
            fight();
        }
    acase 118:
        result = dice(1) + 3;
        create_monsters(411 + dice(1), result); // 412..417
        create_monster(412);
        create_monster(411);
        if (getyn("Surrender (otherwise fight)"))
        {   dispose_npcs();
            room = 75;
        } else
        {   fight();
            room = 4;
        }
    acase 119:
        ok = FALSE;
        for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && items[i].range > 0
             && (items[i].type == WEAPON_DAGGER || i == 116 || i == 117 || i == 589)
            )
            {   ok = TRUE;
                break; // for speed
        }   }
        if (ok && getyn("Cheat"))
        {   room = 124;
        }
    acase 120:
        if (saved(1, iq))
        {   room = 50;
        } elif (misseditby(1, iq) <= 5)
        {   room = 35;
        } else
        {   room = 64;
        }
    acase 121:
        result = dice(2);
        for (i = 1; i <= result; i++)
        {   ok_wandering();
        }
        if (gotrope(60) && getyn("Escape via balcony"))
        {   room = 127;
        }
    acase 123:
        if (!saved(2, lk))
        {   die();
        }
    acase 124:
        create_monster(400);
        for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && items[i].range > 0
             && (items[i].type == WEAPON_DAGGER || i == 116 || i == 117 || i == 589)
            )
            {   aprintf
                (   "%d: %s\n",
                    i + 1,
                    items[i].name
                );
                break; // for speed
        }   }
        do
        {   result = getnumber("Use which weapon", 1, ITEMS) - 1;
        } while
        (   !items[result].owned
         || items[result].range == 0
         || (items[result].type != WEAPON_DAGGER && result != 116 && result != 117 && result == 589)
        );
        missileammo = result;
        if (shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE))
        {   evil_takemissilehits(0);
        }
        dropitem(missileammo);
        if (countfoes())
        {   room = 28;
        } else
        {   room = 76;
        }
    acase 130:
        good_takehits(dice(3), TRUE);
        rb_givejewels(-1, -1, 1, 2);
        give(631);
        result = dice(3);
        result2 = 0; // to avoid a spurious SAS/C optimizer warning
        for (i = 0; i < SPELLS; i++)
        {   if (spell[i].level == result)
            {   result2 = i;
                break;
        }   }
        result3 = dice(1);
        if (result2 + result3 - 1 < SPELLS && spell[result2 + result3 - 1].level == result)
        {   learnspell(result2 + result3 - 1);
        } else
        {   learnspell(result2 - result3);
        }
    acase 131:
        savedrooms(2, chr, 43, 59);
    acase 132:
        if (saved(3, lk))
        {   templose_con(misseditby(3, lk));
        }
        if (saved(4, con))
        {   oldstat = 1;
        } else
        {   oldstat = 0;
            templose_con(misseditby(4, con));
        }
    acase 135:
        if (sentence)
        {   ok_sentence2();
        } else
        {   victory(0);
}   }   }

MODULE void ok_wandering(void)
{   int whichmonster;

    // Note that this only creates the monster, it doesn't run the fight.

    aprintf(
"WANDERING MONSTER TABLE\n" \
"  Included in the Monster Rating are the values for any weapons the monster may carry.\n"
    );

    whichmonster = dice(2) - 2;
    create_monster(389 + whichmonster); // 389..399
    ok_inwander = TRUE;

/* We really should give them treasure as follows, *after* the fight...
    switch (whichmonster)
    {
    case 2 - 2:
        give(BRO); // %%: it doesn't say what kind of sword. We assume broadsword.
    acase 3 - 2:
        give(CLU);
    acase 6 - 2:
        give(TOW);
    acase 7 - 2:
        give(RIN);
        give(TAR);
        // %%: it doesn't say how many there are
 // acase 8 - 2:
 //     ; // %%: We assume this armour won't fit (see DD145)
 // acase 11 - 2:
 //     ; // %%: what are the stats for a roofing beam?
    } */
}

#define is ==
#define or ||

EXPORT void ok_magicmatrix(void)
{   inmatrix = TRUE;

    aprintf(
"MAGIC MATRIX\n" \
"  Take That You Fiend, Double-Double, Enhance, Zappathingum, Zapparmour, Summoning, Medusa, Hellbomb Bursts, Concealing Cloak, Delay, Magic Fangs, and Swiftfoot always work except when stopped by a kris (either in the group or on the target). Other spells work when allowed by the Magic Matrix, and take effect in the manner described below.\n"
    );

    switch (spellchosen)
    {
    case SPELL_TF:
    case SPELL_DD:
    case SPELL_EH:
    case SPELL_ZA:
    case SPELL_ZP:
    case SPELL_SU:
    case SPELL_ME:
    case SPELL_HB:
    case SPELL_CC:
    case SPELL_DE:
    case SPELL_MF:
    case SPELL_SF:
        fulleffect();
    acase SPELL_VB:
        if
        (   ok_inwander
         or room is  14 // 4A
         or room is  22 // 6B
         or room is  30 // 7E
         or room is  35 // 8B
         or room is  38 // 8E
         or room is  39 // 8F
         or room is  43 // 9B
         or room is  59 // 13A
         or room is  60 // 13B
         or room is  62 // 13D
         or room is  72 // 15B
         or room is  74 // 15D
         or room is  77 // 15G
         or room is  81 // 16C
         or room is  94 // 18D
         or room is  98 // 19A
         or room is 101 // 19D
         or room is 103 // 20A
         or room is 112 // 21G
         or room is 114 // 22B
         or room is 121 // 23D
         or room is 127 // 24D
        )
        {   fulleffect();
        } elif (room is 115) // 22C
        {   noeffect();
        }
    acase SPELL_BP:
        if
        (   ok_inwander
         or room is  14 // 4A
         or room is  22 // 6B
         or room is  30 // 7E
         or room is  35 // 8B
         or room is  39 // 8F
         or room is  43 // 9B
         or room is  59 // 13A
         or room is  60 // 13B
         or room is  62 // 13D
         or room is  72 // 15B
         or room is  74 // 15D
         or room is  81 // 16C
         or room is  94 // 18D
         or room is  98 // 19A
         or room is 101 // 19D
         or room is 103 // 20A
         or room is 112 // 21G
         or room is 114 // 22B
         or room is 121 // 23D
         or room is 127 // 24D
        )
        {   fulleffect();
        } elif
        (   room is  38 // 8E
         or room is  77 // 15G
         or room is 115 // 22C
        )
        {   noeffect();
        }
    acase SPELL_IF:
        if
        (   ok_inwander
         or room is  14 // 4A
         or room is  22 // 6B
         or room is  30 // 7E
         or room is  35 // 8B
         or room is  38 // 8E
         or room is  39 // 8F
         or room is  43 // 9B
         or room is  59 // 13A
         or room is  60 // 13B
         or room is  62 // 13D
         or room is  72 // 15B
         or room is  74 // 15D
         or room is  77 // 15G
         or room is  81 // 16C
         or room is  94 // 18D
         or room is  98 // 19A
         or room is 101 // 19D
         or room is 103 // 20A
         or room is 112 // 21G
         or room is 114 // 22B
         or room is 121 // 23D
         or room is 127 // 24D
        )
        {   fulleffect();
        } elif (room is 115) // 22C
        {   noeffect();
        }
    acase SPELL_PP:
        if
        (   ok_inwander
         or room is  14 // 4A
         or room is  22 // 6B
         or room is  30 // 7E
         or room is  35 // 8B
         or room is  38 // 8E
         or room is  39 // 8F
         or room is  43 // 9B
         or room is  59 // 13A
         or room is  60 // 13B
         or room is  62 // 13D
         or room is  72 // 15B
         or room is  74 // 15D
         or room is  77 // 15G
         or room is  94 // 18D
         or room is  98 // 19A
         or room is 101 // 19D
         or room is 103 // 20A
         or room is 112 // 21G
         or room is 114 // 22B
         or room is 115 // 22C
         or room is 121 // 23D
         or room is 127 // 24D
        )
        {   fulleffect();
        } elif (room is 81) // 16C
        {   noeffect();
        }
    acase SPELL_MP:
        if
        (   !ok_inwander
         && (   room is  22 // 6B
             or room is  30 // 7E
             or room is  38 // 8E
             or room is  39 // 8F
             or room is  60 // 13B
             or room is  62 // 13D
             or room is  74 // 15D
             or room is  77 // 15G
             or room is  94 // 18D
             or room is  98 // 19A
             or room is 101 // 19D
             or room is 103 // 20A
             or room is 114 // 22B
             or room is 115 // 22C
             or room is 121 // 23D
             or room is 127 // 24D
        )   )
        {   fulleffect();
        } elif
        (   ok_inwander
         or room is  14 // 4A
         or room is  35 // 8B
         or room is  43 // 9B
         or room is  59 // 13A
         or room is  72 // 15B
         or room is  81 // 16C
         or room is 112 // 21G
         or room is 114 // 22B
         or room is 115 // 22C
         or room is 121 // 23D
         or room is 127 // 24D
        )
        {   noeffect();
        }
    acase SPELL_WA:
    case SPELL_WF:
    case SPELL_WN:
    case SPELL_W1:
    case SPELL_W2:
    case SPELL_WS:
    case SPELL_WT:
    case SPELL_W3:
    case SPELL_W4:
    case SPELL_W5:
    case SPELL_IW: // %%: does this count as a Wall spell? We assume so.
    case SPELL_BI:
    case SPELL_OW:
        if
        (   ok_inwander
         or room is  22 // 6B
         or room is  30 // 7E
         or room is  35 // 8B
         or room is  60 // 13B
         or room is  72 // 15B
         or room is  74 // 15D
         or room is  77 // 15G
         or room is  81 // 16C
         or room is  94 // 18D
         or room is  98 // 19A
         or room is 101 // 19D
         or room is 103 // 20A
         or room is 112 // 21G
         or room is 115 // 22C
         or room is 121 // 23D
        )
        {   fulleffect();
        } elif
        (   room is  14 // 4A
         or room is  38 // 8E
         or room is  39 // 8F
         or room is  43 // 9B
         or room is  59 // 13A
         or room is  62 // 13D
         or room is 114 // 22B
         or room is 127 // 24D
        )
        {   noeffect();
        }
    acase SPELL_D9:
        if
        (   ok_inwander
         or room is  22 // 6B
         or room is  30 // 7E
         or room is  38 // 8E
         or room is  39 // 8F
         or room is  60 // 13B
         or room is  62 // 13D
         or room is  74 // 15D
         or room is  77 // 15G
         or room is  94 // 18D
         or room is  98 // 19A
         or room is 101 // 19D
         or room is 103 // 20A
         or room is 114 // 22B
         or room is 115 // 22C
         or room is 121 // 23D
         or room is 127 // 24D
        )
        {   fulleffect();
        } elif
        (   room is  14 // 4A
         or room is  35 // 8B
         or room is  43 // 9B
         or room is  59 // 13A
         or room is  72 // 15B
         or room is  81 // 16C
         or room is 112 // 21G
        )
        {   noeffect();
        }
    adefault:
        noeffect();
    }

    inmatrix = FALSE;
}

MODULE void ok_sentence1(int penalty)
{   aprintf(
"MILITARY SENTENCE TABLE\n" \
"  In the event that you are found guilty of dereliction of duty, you will be asked to roll for your sentence on this table. Roll one die and add your level number to the number you get.\n" \
"  If, for any reason (lack of money, or lack of the solitaire dungeon you are sentenced to), you cannot complete the punishment meted out, your character is reduced to slavery. This entails loss of all weapons, monies, lands and title. Such a character may be [sold to *another player's character* or] taken into City of Terrors at paragraph {57} (you've been sold to slavers). [If you have Arena of Khazan and cannot pay your fine, then you are subject to sentence number 10.]\n" \
"  Once you have determined your sentence, go to {135} for last comments.\n"
    ); // %%: what if they have AK and CT and can't pay their fine?

    sentence = dice(1) + level + penalty;
    switch (sentence)
    {
    case 2:
    case 3:
        aprintf("2,3. A trip into Naked Doom. [You must roll for choices of options *randomly*.]\n");
    acase 4:
    case 5:
    case 6:
        aprintf("4-6. [A battle for your honour in] the Arena of Khazan [(three fights)].\n");
    acase 10:
        aprintf("10. Three fights in the Arena of Khazan as a slave! (Start at {77}.)\n");
    acase 14:
    case 15:
    case 16:
    case 17:
        aprintf("14-17. [A battle for your honour in] the Arena of Khazan [(ten fights)].\n");
    acase 7:
        aprintf("7. A fine of 100 gold pieces.\n");
    acase 8:
        aprintf("8. A fine of 200 gold pieces.\n");
    acase 9:
        aprintf("9. A fine of 500 gold pieces.\n");
    acase 11:
        aprintf("11. A fine of 1000 gold pieces.\n");
    acase 12:
        aprintf("12. A fine of 2000 gold pieces.\n");
    acase 13:
        aprintf("13. A fine of 5000 gold pieces.\n");
    adefault:
        // assert(sentence >= 18);
        aprintf("18+. The supreme penalty. You are forced to drink a potion that magically reduces your attributes to 0. (Deathtrap Equalizer and other immortals will be reborn with an IQ and CON of zero and will die again, and so on, forever.) If that doesn't work, you are teleported to an alternate universe which contains only you. (You sound as if you're tougher than the world, anyway...)\n");
}   }

MODULE void ok_sentence2(void)
{   switch (sentence)
    {
    case 2:
    case 3:
        module = MODULE_ND;
        room = 0;
    acase 4:
    case 5:
    case 6:
        module = MODULE_AK;
        room = 0;
    acase 10:
        module = MODULE_AK;
        room = 77;
    acase 14:
    case 15:
    case 16:
    case 17:
        module = MODULE_AK;
        room = 0;
    acase 7:
        if (!pay_gp( 100)) { module = MODULE_CT; room = 57; }
    acase 8:
        if (!pay_gp( 200)) { module = MODULE_CT; room = 57; }
    acase 9:
        if (!pay_gp( 500)) { module = MODULE_CT; room = 57; }
    acase 11:
        if (!pay_gp(1000)) { module = MODULE_CT; room = 57; }
    acase 12:
        if (!pay_gp(2000)) { module = MODULE_CT; room = 57; }
    acase 13:
        if (!pay_gp(5000)) { module = MODULE_CT; room = 57; }
    adefault:
        // assert(sentence >= 18);
        die();
}   }
