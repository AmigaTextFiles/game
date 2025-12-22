#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

#define FROM_CAVE     0
#define FROM_VALEAT   1
#define FROM_FREEGORE 2
#define FROM_ALSCEN   3
#define FROM_KELSA    4
#define FROM_ESDURT   5
#define FROM_KROAN    6

/* %%:
Ambiguities:
 AS92: L3-SR for shot doesn't fit into a plausible size/range combination, L4-SR makes more sense.
Unofficial FB errata:
 27F ends with a nonsensical "(part three)".
Corgi errata:
 Magic Matrix:
  Some spells have "#" for some rooms in Corgi edition, a misprint.
   FB version has hollow square (no effect) in those cases.
  Note #8 says "12B"; they just forgot to convert the FB paragraph number into Corgi format.
   12B is paragraph #88.
*/

MODULE const STRPTR as_desc[AS_ROOMS] = {
{ // 0
#ifdef CORGI
"`INSTRUCTIONS\n" \
"  This adventure is full of surprises and several charts and tables. To keep everything a surprise, please only read the charts you are instructed to. Until you are told differently, the only chart you need to pay attention to is the first random encounter table (aha! I caught you checking for other tables!)\n" \
"  'Amulet of the Salkti' has many new ideas and concepts in it. The major ones are items and the Items Matrix. I devised these to put some real puzzles into the adventure. Sometimes you will pick up an item and it will direct you to a certain paragraph or special chart when you use it. Most of the time, however, you should just write down the fact that you have the item and wait until a paragraph says that you need an item. Then, choose the item you want to use, go to the Items Matrix, find the item you have on top, and then locate the paragraph you are at on the side. Go across to find the result which will either direct you to a specific paragraph or will indicate failure, in which case you should go back to the paragraph you were at and check the consequences of failure.\n" \
"  Because of some of the puzzles included, pay attention to certain facts and possibly write down clues, etc.\n" \
"  On the Magic Matrix, you may check the success of healing spells under the listing for the paragraph which contained the battle you just fought.\n" \
"  Paragraphs marked with an '*' mean you can use magic and should consult the Magic matrix if you choose to do so. Paragraphs marked with an '&' mean you should refer to the appropriate section of the Skull Matrix should you be wearing the skull (don't worry, you'll understand when the time comes).\n" \
"  All fractions round up!\n" \
"  If somebody gives you something for free, such as curing all damage, he will only do it once.\n" \
"  Thanks for playing, and good luck. - David Steven Moskowitz\n" \
"~INTRODUCTION\n" \
"  Times are getting worse in Freegore. Orcs have been raiding the city at an alarming rate; the raiding parties have grown larger and the raids seem to be increasing in frequency. People have spotted strange clouds of smoke off in the distance, first at sea, now near the city. The city's leaders have been keeping their knowledge secret to prevent panic, but rumours abound and most of the city's production has turned to weapons and other wartime items.\n" \
"  One day, you are summoned into Freegore's capital building. You are led into a small room where Jefber, the leader of the city, enters and begins to speak.\n" \
"  \"What I am about to tell you now is confidential. The people will have to know eventually, but for now I want to keep this information secret. First, I need to backtrack and tell you the origins of the city. Freegore was founded on the outskirts of the old Salkti ruins. The Salkti were a proud people who, although they lived above ground, kept most of their magic underground. One day, one of the Salkti accidentally summoned a demon of great power. This creature was so powerful that it destroyed the Salkti and was named Sxelba.\"\n" \
"  Sxelba. As a child you heard legends of this demon. It is said that Sxelba was almost as powerful as the dreaded Wsorey, the most powerful and evil of the demons.\n" \
"  \"Anyway, as the Salkti were being killed in droves by Sxelba and his followers, many of the Salkti tried to flee while others worked on an amulet. Finally, the amulet was almost finished when the demon found the amulet-makers and attacked them. Although unable to use the amulet to its full potential, the Salktians were able to banish Sxelba for at least 200 years.\n" \
"  \"That was 300 years ago. What has happened to the amulet is unknown, but we do know that Sxelba has returned. He reemerged on the island of Esdurt and developed a rapidly growing cult of worshippers, many of whom are orcs. Eventually, he amassed a huge army and now is headed towards our city. On the way, he ransacked the Island of Kelsa, causing mass starvation, and it is said that he has done strange things with the volcano island of Valeat. He has set up camp on the continent and will attack soon. Our only hope is to recover the amulet.\n" \
"  \"If we fail, the next town to fall will be Alcen, ruled by Count Kalstain, and nobody knows what will happen after that. You must help us. Enter the ruins and find the amulet. It may not be there, but we must try. Sxelba's demons have wrecked all our ships. To help you, we will cast spells you will not need food or drink for several weeks.[ Also, we will teach you the word of recall, Krepmn, but you may only use if once (if you ever use it and no other instructions are given, go to {159}). It will teleport you back to this city.]\"\n" \
"  If you are brave enough to attempt this challenge, enter the ruins at {107}. If you tell them you will do the job and then abandon the task, go to {40}. If you do not think you can handle it, recruit another character to try the task - QUICKLY!"
#else
"`INSTRUCTIONS\n" \
"  To play \"Amulet of the Salkti\", you will need the Tunnels & Troll rulebook (fifth edition), any writing implement (blood and a hypodermic needle will work just fine), several six-sided dice, and some paper.\n" \
"  I would suggest that you take in a well-equipped character  with  attributes  that, when averaged, wind up between  23  and  33.  Spellcasters might stand a better  chance.\n" \
"  This adventure is full of surprises and several charts and tables. To keep everything a surprise, please only read the charts you are instructed to. Until you are told differently, the only chart you need to pay attention to is the first random encounter table (aha! I caught you checking for other tables!)\n" \
"  'Amulet of the Salkti' has many new ideas and concepts in it. The major ones are items and the Items Matrix. I devised these to put some real puzzles into the adventure. Sometimes you will pick up an item and it will direct you to a certain paragraph or special chart when you use it. Most of the time, however, you should just write down the fact that you have the item and wait until a paragraph says that you need an item. Then, choose the item you want to use, go to the Items Matrix, find the item you have on top, and then locate the paragraph you are at on the side. Go across to find the result which will either direct you to a specific paragraph or will indicate failure, in which case you should go back to the paragraph you were at and check the consequences of failure.\n" \
"  Because of some of the puzzles included, pay attention to certain facts and possibly write down clues, etc.\n" \
"  On the Magic Matrix, you may check the success of healing spells under the listing for the paragraph which contained the battle you just fought.\n" \
"  Paragraphs marked with an '*' mean you can use magic and should consult the Magic matrix if you choose to do so. Paragraphs marked with an '&' mean you should refer to the appropriate section of the Skull Matrix should you be wearing the skull (don't worry, you'll understand when the time comes).\n" \
"  All fractions round up!\n" \
"  If somebody gives you something for free, such as curing all damage, he will only do it once.\n" \
"  Finally, write to me! Ask me questions, give me comments. Do you like the Items Matrix and its puzzles, or do you prefer simpler dungeons? Do you like my ideas or my style? Should I devote my whole life to solo-adventure writing or should I stick my hands in a meat grinder and slit my vocal chords so there is no way I can produce any more? I'd love to hear from you. Contact me care of Blade, P.O. Box 1210, Scottsdale, AZ 85252-1210.\n" \
"  Thanks for playing, and good luck. - David Steven Moskowitz\n" \
"~INTRODUCTION\n" \
"  Times are getting worse in Freegore. Orcs have been raiding the city at an alarming rate; the raiding parties have grown larger and the raids seem to be increasing in frequency. People have spotted strange clouds of smoke off in the distance, first at sea, now near the city. The city's leaders have been keeping their knowledge secret to prevent panic, but rumours abound and most of the city's production has turned to weapons and other wartime items.\n" \
"  One day, you are summoned into Freegore's capital building. You are led into a small room where Jefber, the leader of the city, enters and begins to speak.\n" \
"  \"What I am about to tell you now is confidential. The people will have to know eventually, but for now I want to keep this information secret. First, I need to backtrack and tell you the origins of the city. Freegore was founded on the outskirts of the old Salkti ruins. The Salkti were a proud people who, although they lived above ground, kept most of their magic underground. One day, one of the Salkti accidentally summoned a demon of great power. This creature was so powerful that it destroyed the Salkti and was named Sxelba.\"\n" \
"  Sxelba. As a child you heard legends of this demon. It is said that Sxelba was almost as powerful as the dreaded Wsorey, the most powerful and evil of the demons.\n" \
"  \"Anyway, as the Salkti were being killed in droves by Sxelba and his followers, many of the Salkti tried to flee while others worked on an amulet. Finally, the amulet was almost finished when the demon found the amulet-makers and attacked them. Although unable to use the amulet to its full potential, the Salktians were able to banish Sxelba for at least 200 years.\n" \
"  \"That was 300 years ago. What has happened to the amulet is unknown, but we do know that Sxelba has returned. He reemerged on the island of Esdurt and developed a rapidly growing cult of worshippers, many of whom are orcs. Eventually, he amassed a huge army and now is headed towards our city. On the way, he ransacked the Island of Kelsa, causing mass starvation, and it is said that he has done strange things with the volcano island of Valeat. He has set up camp on the continent and will attack soon. Our only hope is to recover the amulet.\n" \
"  \"If we fail, the next town to fall will be Alcen, ruled by Count Kalstain, and nobody knows what will happen after that. You must help us. Enter the ruins and find the amulet. It may not be there, but we must try. Sxelba's demons have wrecked all our ships. To help you, we will cast spells you will not need food or drink for several weeks.[ Also, we will teach you the word of recall, Krepmn, but you may only use if once (if you ever use it and no other instructions are given, go to {159}). It will teleport you back to this city.]\"\n" \
"  If you are brave enough to attempt this challenge, enter the ruins at {107}. If you tell them you will do the job and then abandon the task, go to {40}. If you do not think you can handle it, recruit another character to try the task - QUICKLY!"
#endif
},
{ // 1/1A
"It appears to be the captain's quarters. You find nothing but a chest with a very unusual lock and a book. If you want to read the book, go to {112}. If you want to open the chest, go to {87}. If you want to reenter the main ruins, go to {155}."
},
{ // 2/1B
"It's an easy jump. Make a L1-SR on Dexterity (20 - DEX) to avoid slicing yourself in half. If you make it, continue reading.\n" \
"  The top part was another chute. You continue sliding for about 5 minutes. The chute finally dumps you into a large room at {122}."
},
{ // 3/1C
"Immediately, the ball starts rolling towards you at an amazing speed. Before you react, the ball breaks into the room, breaking the magnet and crushing you up against a wall. You are quite dead."
},
{ // 4/1D
"Make a L1-SR on IQ (20 - IQ). If you are successful, go to {113}. If not, go to {169}."
},
{ // 5/1E
"Each fire extinguisher will put out one medium-sized fire. Buy as many as you like, then buy something else by returning to {96}, go to your ship at {210}, or go to Kalstain's palace at {9}."
},
{ // 6/2A
"You are in a north-south corridor. To the south, you can see an arch. If you go north, go to {178}. If you go south, go to {155}."
},
{ // 7/2B
"As you proceed, you hear a loud noise from above. Looking at the ceiling, you see a trapdoor opening and some sort of liquid being poured out of a vat onto you. You have just a split second to jump out of the way. Make a L2-SR on the average of your LK and DEX (25 - ((LK + DEX) ÷ 2)). If you fail, go to {42}. If you make it, go to {62}."
},
{ // 8/2C
"You are at one end of a north-south passage. To your north, there is a door. You may enter the door by going to {116}, or you may go south to {174}."
},
{ // 9/2D
"& You're in luck. You were able to convince the guard who you were and what your mission was. He brings you into Kalstain's library.\n" \
"  Kalstain is there and you tell him your tale. He replies gravely, \"I fear Freegore might not survive much longer. We have neither the troops nor the magic to help her. Nobody even knows where the amulet is, much less if it still exists. We do have one very slim hope, though. It is said that the greatest leaders and the greatest minds still live in a special part of the underworld, near the surface of the planet. Frietoc was one of the last yet greatest Salkti leaders. Just possibly, he might know. But entering the underworld is a dangerous task, and once you reach it and even if you find him, you must give him a perfectly preserved piece of meat from the jajuk, a rare bird whose meat is deadly to the living but is said to nourish the dead. All we know is that the jajuk is not found on this continent, but maybe it lives on one of the nearby islands.\"\n" \
"  He then proceeds to instruct you on how to recognize Frietoc. He will also heal either all of your lost CON or one disease. Then he will bid you farewell and wish you the best of luck.\n" \
"  You may now return to your ship (go to {210}) or you may go to the shop (go to {96})."
},
{ // 10/2E
"* It slowly begins to move and starts to attack. You realize that this is too big for even you to handle normally. You had better cast a spell or, even better, use an item. On your first failure, go to {176}."
},
{ // 11/2F
"The rock seems pretty solid[, and if you don't have some sort of protection for your hands or a non-edged weapon (except for a pickaxe), go back to {198}]. If you have a pickaxe, you cut through easily; go to {88} and take an extra 100 ap for a good choice of weapons, 200 if you are a dwarf. If you don't have a pickaxe, you can still try but it will take a L10-SR on ST (65 - ST). If may seem high, but you must remember that this is a mountain. If you make it, go to {41}. If you fail, go back to {198}."
},
{ // 12/2G
"You are walking down a north-south corridor. Check for a random encounter. If you survive, you may travel south by going to {61} or you may go north by going to {205}."
},
{ // 13/3A
"The snake's body begins to stiffen and the head seems to widen and split. You realize this could make a great grappling hook and take it. You may also collect the remaining four eggs. To use/eat them, go to {90}. You see the hordes advance on the city and realize there is no turning back. Enter the dungeon by going to {65}."
},
{ // 14/3B
"As the man considers your offer, you start having second thoughts about it. Make a L1-SR on IQ (20 - IQ). If you make it, go to {185}. Otherwise, go to {132}."
},
{ // 15/3C
"You are in a north-south passage. Check to see if a random event occurs. If you survive, you may go north to {174} or south to {178}."
},
{ // 16/3D
"The fire is a fairly large one. It will take one full fire extinguisher to put it out. The ship is also partially damaged, and all trips will take ¾ of the time indicated longer. If and/or when you decide to return to the island, go to paragraph {127}."
},
{ // 17/3E
"He hit you. The poison starts to spread through your veins. You shake a little, fall down, cough up a little blood, and die."
},
{ // 18/3F
"The creature is still somewhat slow and coming to life. Make a L1-SR on Speed (20 - SPD). If you make it, go to {108}. If you fail, it hit you from behind just as you tried to jump out of its way; the back part of your skull is crushed. You are dead."
},
{ // 19/3G
"Once you reach there, you find that it has a long stairway going down into the earth. You may enter by going to {208}, examine the trees by going to {140}, or leave for another island."
},
{ // 20/3H
"They passed. You may now go to the green glow of {180} or examine the adjacent corridor at {145}."
},
{ // 21/3J
"* Something bit you. It's of no matter what it was; what is important is that it injected deadly poison into you. Unless you are immune to poison, you will lose one point of CON per paragraph until cured. Go to {70} and ignore the first sentence."
},
{ // 22/3K
"You are clueless. All you see is a bunch of spirits walking around, and this has no significance. Go back to the surface of {67} and try to find out what to do."
},
{ // 23/3L
"Each net will hold up to two catches' worth of fish and keep them preserved. You may buy something else (go to {96}), go to your ship at {210}, or go to Kalstain's palace at {9}."
},
{ // 24/4A
"There is a slight earthquake, and part of the ceiling collapses, blocking off the entrance room. [From now on, every turn you spend resting, roll one die. If the result is a one, go to the Random Encounter Table #1 and face the encounter. ]You are now in an east-west passageway. To the east, you see a door. To the west, the passage bends. If you choose the east door, go to {149}. If you go west, go to {93}."
},
{ // 25/4B
"The ramp leads down into a huge cavern. At the bottom of the ramp, you see that the cavern is partially filled with water and functions as an underground harbour. One boat sits in the harbour, and you can board it without any problems. You may board the boat by going to {82}, or may head back up the ramp by going to {155}."
},
{ // 26/4C
"The mouth speaks in a rather depressed tone, using more of that horrible poetry:\n" \
"    The words written by a dying man's hand\n" \
"    Are to some the most important in the land.\n" \
"    The letters speak of colour, order and peace to be\n" \
"    And praise to be given to you but not to me.\n" \
"The mouth is once again silent. You leave the alcove - which seals off behind you - and go to {155}."
},
{ // 27/4D
"If it is not well-preserved, go to {191}. If it is, go to {89}."
},
{ // 28/4E
"The woman lets out a deep scream. The other figure runs. Your victim's appearance has changed to the form of a man. Bolts of lightning and magical energy are shooting through the room. You have killed Sxelba's physical form! Make a L2-SR on the average of your ST and IQ (25 - ((ST + IQ) ÷ 2)). If you fail, go to {58}. If you make it, go to {68}."
},
{ // 29/4F
"As you're hanging from the magnet, you get this feeling you're in deep trouble. Abruptly you change your mind and try to escape; go to {92}."
},
{ // 30/4G
"You are exploring a very long north-south corridor. Check for a random encounter as usual except that the chance for an encounter is a 1, 2, or 3. If you survive, you may travel south by going to {150} or north to {61}."
},
{ // 31/4H
"Click. Press the same button, or try a new one."
},
{ // 32/4J
"He says that you are right, unfortunately. He explains that he has not seen you around before and that he needed to give you a small test. He says a quick prayer to Sxelba and then leaves. That was close. You had better continue on your journey to the glow at {180} quickly or head back to your ship."
},
{ // 33/4K
"They teach you 10,000 gp worth of spells. They also give you 7500 gp in any form you wish (emeralds, a gold and ruby ring, cash, etc.) This adventure has been worth 7500 ap."
},
{ // 34/4L
"This island is very tropical. As you look around, you see a large circular building that looks like a temple, approximately a half mile away. Behind the temple, you see a bright green glow that is visible at this distance. You may leave for another island, enter the temple by going to {99}, or go around the temple to see the green glow by going to {197}."
},
{ // 35/4M
"You weren't strong enough. The spike was poisoned, and you die."
},
{ // 36/4N
"* He fights with an obsidian dagger which gets 2 dice and 7 adds and is covered with dragon's venom. Additionally, he fights with a staff worth 2 dice. He has a CON of 30, gets 35 adds, and wears scale armour underneath his robes. If you kill him, go to {86}. If you die, your body is teleported back to the continent and thrown over the walls of Freegore."
},
{ // 37/5A
"The pillars are not extremely thick, but you try your best. Make a L4-SR on Luck (35 - LK). If you are a rogue, subtract one level from the saving roll. Hobbits subtract one level, fairies and leprechauns subtract two (dwarves are too big to get a bonus). If you are wearing plate, [carrying a weapon over 5' long, ]or your feet have doubled in size recently, add one to the level for each of the previous factors that apply. If you make the roll, go to {20}. If you fail, they attack; go to {114}."
},
{ // 38/5B
"*& You land in a rather large, circular room on a large pile of corpses in various stages of decay. Strangely, the corpses have only one arm and one leg each. Take comfort in knowing that your landing was cushioned. On one of the walls, you see an opening leading to a flight of stairs going up. But right now, something seems very wrong.\n" \
"  The corpses are starting to come to life! All of them! You had better run for the exit quickly because they are trying to grab and eat you. You will have to be fast, lucky, dexterous, and able to break loose if they grab you as well as know where to step. Therefore, you must make a L3-SR on the average of your ST, IQ, LK, DEX and SPD (30 - (ST + IQ + LK + DEX + SPD) ÷ 5)). If you make it, go to {108}. If you fail, you are pulled down into the mass of corpses who eat one arm and one leg, resulting in your immediate death. You become one of the zombies. If you are half-dead, it makes no difference because once you come back to life, they will eat you again before you have a chance to react. The adventure is over."
},
{ // 39/5C
"The alcove is empty except for a large mouth carved into the west wall. It begins to speak:\n" \
"    Brave adventurer going to save a city,\n" \
"    When you die, it will be such a pity.\n" \
"    Perhaps to aid one such as you,\n" \
"    I will give help in the form of a clue.\n" \
"    But first you must prove your might\n" \
"    By winning more than one fight.\n" \
"To accept the challenge, go to {101}. If you decline, leave and do not return by going to {155}."
},
{ // 40/5D
"You cad! I would like to kill you here and now, but I try to be fair. You now have the blood of women and children on your hands. The gods, to show this, cover you with a permanent layer of blood. Now, anybody who sees you will know your crime and will be repulsed. Your Charisma is permanently reduced to 1[ and may not be increased by future experience]. Now get out of this adventure before I change my mind!"
},
{ // 41/6A
"Take 300 ap for a successful attempt. [Also, make a L4-SR on LK (35 - LK) to see if your weapon broke. ]Anyway, you may enter the mountain by going to {88}."
},
{ // 42/6B
"The liquid was molten lava. [If you do not have a helmet, ]just the few drops that hit your head were enough to burn through the skull and do fatal brain damage.[ If you have a helmet, take the number you missed the saving roll by and multiply by 20. This is the damage you must take. If you survive, go to {62}.]"
},
{ // 43/6C
"Make a L2-SR on the average of your LK and SPD (25 - ((LK + SPD) ÷ 2)). If you fail, they caught up to you and attacked; go to {199}. If you make it, you got a great start on them, and they've stopped trying to figure out what to do. Off in the distance, you see two landmarks: the side of a mountain and a large building. You may run towards the building at {137} or towards the mountain at {198}."
},
{ // 44/6D
"You're smart enough to guess that the snake isn't going to stay passive very much longer. Prepare to fight and go to {196}."
},
{ // 45/6E
"They are very happy to see you. They will heal each disease at a cost of [one catch or for ]25 gp (fantastic bargain!). They will also heal all of your lost CON points for the same price. You may leave for another island, go to the magic shop at {84}, the shipboulder at {184}, or the armoury at {129}."
},
{ // 46/6F
"Five of the arrows will automatically hit their target, but you only get 2/3 of your normal missile adds with them. With the other five, you must make your normal saving roll but these arrows do an extra 25 points damage when they hit.\n" \
"  You may buy something else by going to {96}, go to your ship at {210}, or go to Kalstain's palace at {9}."
},
{ // 47/6G
"The fire is not very small. It will take three-fourths of a fire extinguisher to put it out. The ship is also partially damaged, and all trips will take one-half of the time indicated longer. If and/or when you decide to return to the island, go to paragraph {127}."
},
{ // 48/6H
"Make a L1-SR on Luck (20 - LK). If you make it, go to {57}. If the roll is missed, go to {3}."
},
{ // 49/6J
"The spinning made you a little dizzy, but you managed to keep your balance. You may proceed up the altar by going to {190}, or your may try to leave the room by going to {151}."
},
{ // 50/6K
"* You have come to the end of the corridor. It is a dead end except for what looks like a carving dug into the south wall. You may just head back north to {81}, or you may try an item or spell. For every unsuccessful attempt, a random encounter occurs on a roll of 1, 2, or 3."
},
{ // 51/6L
"As you enter the room, you are swept off your feet and find yourself attached to a very large magnet. If you think you'd like to wait and see if someone comes to get you down, make a L1-SR on IQ (20 - IQ). If you are successful, go to {29}. Otherwise, go to {158}. Or you may get out of your armour[ and drop everything metal]; go to {92}."
},
{ // 52/6M
"You cannot break the bonds. You feel yourself being dumped into a room full of disgusting, somewhat decayed corpses. The pile starts to move and then begins to eat you! As the blood drains out of the rather large openings where your limbs used to be, you realize that it's all over. If you are half-dead, it makes no difference because once you come back to life, they eat you again."
},
{ // 53/6N
"Click. Press the same button, or try a new one."
},
{ // 54/7A
"& The man says, \"Greetings. Word is that Sxelba's troops have conquered Freegore and also Alscen. The time of our lord has come at last! But our task is not complete. We must summon more demons and evil creatures to help him rule. Come, let us pray for the greater glory of his name.\"\n" \
"  You may attack the man with the obsidian dagger (go to {206}), attack him with normal weapons or magic (go to {36}), call him a liar and say that the cities still stand (go to {32}), or join him since he could very well be right (go to {132})."
},
{ // 55/7B
"Make a L2-SR on Luck (25 - LK). If you fail, go to {192}. If you make it, go to {163}."
},
{ // 56/7C
"You reach a large room. No matter how you got here, all of the exits are suddenly sealed by several large rocks. On the pedestal in the middle of the room is a silver amulet engraved with many strange and ancient runes. You try to grab it, but an invisible wall prevents you. On the wall of the room, you notice five buttons of different colours: blue, orange, green, red, and yellow. The only way to get the amulet is to press the buttons in a certain order. Consult the Button Chart. It functions exactly like the other charts. Make sure you know what paragraph you are coming from because some of the paragraphs are very similar."
},
{ // 57/7D
"The ball rolls away from you at an amazingly fast speed. You hear it crashing through several walls and now you see a very long corridor. You may return to the east-west corridor by going to {24} or you may go south down the corridor by going to {205}."
},
{ // 58/7E
"Your mind feels something trying to enter. You fail to resist. The demon Sxelba now possesses you. Nothing has changed. Tear up your character sheet because your original soul is destroyed."
},
{ // 59/7F
"You reach the front of the palace and find only a huge steel wall blocking the entranceway. You may go around to the side of the building by going to {100} or to the mountain at {198}."
},
{ // 60/7G
"More of them are coming. These new guys are armed to the teeth. They motion for you to come with them. If you go peacefully with them, go to {85}. If you attack, go to {199}."
},
{ // 61/7H
"You are in a north-south corridor. Check for a random encounter as usual except that an encounter will occur on a roll of 1 or 2. If you survive the encounter, you may travel south by going to {30} or north to {12}."
},
{ // 62/8A
"That nearly killed you! You may begin to climb that altar by going to {135}, or you may try to leave the room by going to {151}."
},
{ // 63/8B
"Congratulations, you made it. Take 300 ap. If you made it on your first try, 200 if on your second, and 100 if it was your third. The tiles of the floor dissolved revealing 25 thin gold sheets worth 50 gp apiece. Also, a small pile of rocks which you did not notice dissolved revealing a skeleton with a small, very unusual key which you may now take. The doors have now unlocked. You may leave by going to {8}. If you came from {205}, you cannot find the door and must leave through {8}."
},
{ // 64/8C
"You were lucky. This is your one chance. If you stay out any longer, he will not only have a chance at another shot but will also recognize you as the enemy and when he reports back, you will have a good part of the army on your trail very quickly. Very wisely, you reenter the ruins, go through the inital room, and find yourself in an intersection. Go to {24}."
},
{ // 65/8D
"* As you enter the underground ruins, you get a very uneasy feeling. You walk down about 150 steps and find yourself in a small square room. On one side you see a corpse. You would search further but the two skeletons standing like guards on the other side of the room have suddenly come to life. They each have a MR of 26. [They are both immune to poison and edged weapons only do half damage. However, blunt weapons do double damage. ]Fight. If you win, go to {118}. If you die, your corpse is eventually eaten by rats."
},
{ // 66/8E
"Most of the bottles are empty or broken. The notable exception is a bottle which contains a very thick, blood-red liquid which has a primitive form of a squirt-nozzle on top. You may take this and now leave the room by going to {178}."
},
{ // 67/8F
"This island is a weird one. Everything is covered with a thick layer of mist. Looking through the mist, you see two things: a large rock formation approximately 500' away and several very strange trees. You may go to the rock formation at {19} or you may explore the trees by going to {140}. If you just want to play it safe and leave for another island, go ahead."
},
{ // 68/8G
"The demon tries to enter your mind, but you resist it. Sxelba is banished for at least 100 years. His armies are destroyed. You go back to Freegore and are hailed as a hero. If you are a wizard, go to {33}. If you are a warrior, go to {95}. If you are a rogue or warrior-wizard, go to {154}."
},
{ // 69/8H
"On each of their corpses, you find 25 gp and a medallion. [This medallion demagnetizes anything you touch as long as you touch it or it is on your person. This allows you to recover all of your items from the magnet and use them. ]You hear a click and realize that the magnet has shut itself off. Looking down the secret door, you see what looks like a huge ball blocking a corridor which leads from the door. You may examine the magnet further by going to {194}, or you may leave the same way you entered by going to {24}."
},
{ // 70/9A
"You managed to pull your foot out before something bit you. You may proceed by going to {172}, or you may try to leave the room by going to {151}."
},
{ // 71/9B
"Make a L1-SR on IQ (20 - IQ). If you make the roll, go to {148}. Missing the roll sends you to {115}."
},
{ // 72/9C
"The fruit tastes bitter, then sweet, then flavourless. Simultaneously, you feel weak, then strong, then normal. You have just eaten the fruit of the dead, and now you are half dead. Cut all of your attributes in half.[ If you are ever killed, you will be resurrected on the spot. However, this will only work in combat situations or in situations where it would seem logical. For example, if a guillotine had just cut your head off, both your body and head would be immediately resurrected but would die instantly afterwards. The second time you die, you really die!]\n" \
"  If you want to try to cut the trunk, decide on which weapon you will use (preferably edged) and go to {103}. If you want to pick the leaves, go to {170}. You may also leave for another island or go to the rock formation at {19}."
},
{ // 73/9D
"Searching through the nearby brush, you find a rather poorly hidden lever. Seeing the hordes approach, you have no choice but to pull it. When you do, a large portion of the mountain opens up and you enter; go to {88}."
},
{ // 74/9E
"Never attack with demons' weapons. The dagger flies out of your hand and plunges into your chest, killing you instantly."
},
{ // 75/9F
"As you press the button, you feel a powerful electrical current surge through your body. This does 1-6 points of damage directly off your CON. If this kills you, go to {128}. You then hear mechanical sounds as if something is resetting. Try another button."
},
{ // 76/9G
"You enter the tent to find a bed with a man and a woman sleeping (apparently 'recovering' from the night's activities). This is your chance. You can kill at least one of them without difficulty. If you choose the man, go to {4}. If you choose the woman, go to {28}."
},
{ // 77/9H
"Each unit of meat preserver will preserve several pounds of meat, at least the size of a large bird. You may buy something else by going to {96}, go to your ship at {210}, or go to Kalstain's palace at {9}."
},
{ // 78/10A
"As your zombies row into Kelsa's port, you see the devastating effects of mass starvation. The famine is so bad that the hunters don't have the strength to hunt. A small boy crawls over to the ship, tries to say 'food', and then dies. You realize that unless you have some sort of food in fairly large quantities (ie. fish) to help the people, they won't be able to do, give, or say anything to help you.\n" \
"  If you have fish and give it to the people, go to {98}. If you have fish but keep it from the people, go to {40}. And if you don't have any, you may either go to another island or leave. You may also sail around the island and keep rolling for random encounters. You must face all of them, but hopefully you will catch some fish."
},
{ // 79/10B
"Take 200 ap for the fight. A more careful search of the room reveals that the jewels are just paste, but the gold is real. The gold is not pure, however, so each of these pieces is only worth one-half of a regular gold piece although it weighs as much as one. Take as much as you want, up to the limit of what you can carry. You may now leave through the exit by going to {108}."
},
{ // 80/10C
"*& He dies. That sounds easy except that he wasn't a real orc, he was a container for some extremely corrosive liquid. As the liquid spills out and fills the room, your only hope is to climb up onto the dry parts of the container.\n" \
"  If that did not make things bad enough, the container held a giant squid that was immune to the liquid. It attacks immediately with four tentacles; when one is critically damaged it will withdraw that one and use a different one until all eight are in combat or are critically wounded. Each tentacle can take 18 hits. Each combat turn, make a L2-SR on the average of your LK and DEX (25 - ((LK + DEX) ÷ 2)) for each tentacle fighting. If you fail any of them, you are pulled into the liquid and are instantly killed. If you make all four, you may do your full roll in damage[ to one of the tentacles]. Proceed until all are destroyed (go to {138}) or until you die."
},
{ // 81/10D
"You are in a north-south corridor. To the west is a door with some writing on it. All you can make out is something like 'Warning, (smear) only.' To enter the room, go to {134}. If you are too scared, you may go north to {93}, or continue south to {50}."
},
{ // 82/10E
"On deck you find nothing manning the oars and sails except for several very small, lifeless, bloodless men. You need to use an item here. For each failure, you meet a wandering encounter on a roll of 1-4. If you think you do not possess the proper item, you may go back up the ramp to {155}."
},
{ // 83/10F
"Your timing is anything but great. The volcano is erupting! Rocks and lava are flying everywhere so you'd better get the derst out of there! The zombies are trying their best, but that probably won't be enough. To find out the damage done to your ship by the small flaming rocks flying through the air, make saving rolls on LK starting at level 0 and increasing in level through level 5. Take the highest level roll that you made consecutively without missing and subtract that from 5. Compare this result with the table below to find out how serious the fire is:\n" \
"    0: go to {173}.\n" \
"    1: go to {183}.\n" \
"    2: go to {164}.\n" \
"    3: go to {47}.\n" \
"    4: go to {16}.\n" \
"    5: go to {204}."
},
{ // 84/10G
"They seem very happy to see you. You may [either ]buy spells[ or use their services to remember spells you have forgotten]. Each catch of fish will buy you 10 free levels of new spells (eg. two 4th level spells and one 2nd level spell)[ or twenty levels worth of forgotten spells]. Otherwise, each new spell is at half price[, and each remembered spell is at quarter price].\n" \
"  You may leave for another island, go to the healer at {45}, the shipbuilder at {184}, or the armoury at {129}."
},
{ // 85/11A
"& They lead you to a large building. The steel barrier in front of you disappears as one of them says a few words. You are led into the main hall. Their leaders enters, sits on the throne, and begins to speak:\n" \
"  \"Stranger, what is your purpose here? Do you come to wreak more destruction upon us? The demon raids grow more and more frequent. Do you know what they want? Explain or die.\"\n" \
"  You had better start explaining. Make a L3-SR on the average of your IQ, LK, and CHR (30 - ((IQ + LK + CHR) ÷ 3)). If you make it, go to {147}. If you fail, go to {111}."
},
{ // 86/11B
"Take 95 ap for the fight. He is wearing a gold symbol of Sxelba which is exactly like the necklaces. If you wish to try it on, go to {153}; otherwise, you'll have to wait until the end of the adventure. You may also take the dagger if you wish (go to {74} should you choose to use it).\n" \
"  Anyway, you may continue on your journey through this temple to examine the glow (go to {180}), quickly return to the ship and head off to another island, or backtrack and go around the outside of the temple to explore the glow by going to {197}."
},
{ // 87/12A
"An item would be useful here. On the first failure, a small poison needle inside the lock sticks you. Unless you are immune, the poison removes 5 points from your DEX until you are cured. After that happens, you have unlimited tries. If you decide that you lack the proper item, you may return to the main ruins by going to {155}, or you may read the book by going to {112}. Otherwise, the chart will direct you to the proper paragraph when you open the lock."
},
{ // 88/12B
"As you enter the mountain, the creatures are terrified and run off. Just then, you see one of them jump into the bushes and a new steel wall crashes down, blocking off the entrance to the cave. You are in a cave with a stairway leading down. Seeing no other alternative, you walk down it and finally...go to {56}."
},
{ // 89/12C
"He eats the jajuk meat while several other spirits watch enviously. He then begins to speak:\n" \
"  \"The ship with the amulet reached Atocles and was welcomed by the inhabitants. Now, all of the Salkti people are dead and only the inhabitants of the island, who have long forgotten the meaning of the amulet, still guard it.\n" \
"  \"Now, the journey to the island is several thousand miles, but several of Sxelba's followers have created a gateway from Esdurt to Atocles. The demons, however, are repelled by the Atocleans whenever they travel through the time door because the magic of the demons does not work in Atocles and they are virtually helpless. Nevertheless, they still guard the doorway with their lives. To defeat the demons, you will need a staff built from the trees outside.\"\n" \
"  He then tells you the location of a buried axe which can cut the trees. He loses the strength the jajuk gave him and fades away. You make your way back to the upper world, find the axe, and cut yourself a staff from one of the trees. The staff functions as a staff ordinaire except it takes an extra ST point off of the normal cost for spells.\n" \
"  You may now leave for another island or examine the trees at {140}."
},
{ // 90/12D
"& The eggs are very high in protein. Unfortunately, they are also raw. For each one, you'll have to have a strong stomach plus a mind that will tell you that nothing's wrong. Make a L2-SR on the average of your IQ and CON (25 - ((IQ + CON) ÷ 2)). If you make it, you may add four to your ST[ for one hour (six turns)]. If you fail, the egg is now in a messy puddle on the floor.[ If you try to eat another egg within two hours, the level of the saving roll will triple.]\n" \
"  Return to the paragraph which sent you here."
},
{ // 91/12E
"& You hear the rumbling of ancient machinery, and the room fills with bright light and lightning. You may now take the amulet!\n" \
"  Seeing no way out, you say the recall word, Krepmn. The room begins to spin wildly and fog blinds you.\n" \
"  When you can see again, you realize that you are back in Freegore. Crowds are cheering and chanting your name. The wizard chief and the high priest take the amulet, open the city gates, and, just as the forces of Sxelba begin their invasion through the gates, start chanting. You hear an almost deafening scream from the enemy forces and see a translucent image, too horrible to describe, rise from the campsite and then explode in a fire so great that it scorches most of the enemy troops. The forces of Freegore can easily dispatch the survivors. Sxelba has been banished forever! You did it! You have survived a long, hard quest and solved all the puzzles!\n" \
"  At a banquet in your honour, the citizens of Freegore reward you greatly. First, they tell you that you will always be welcome in Freegore and that the bards are anxiously awaiting you to tell them your story because they are ready to compose a long ballad. They also give you an Amulet of Krepmn which will immediately teleport you out of any situation and into Freegore. This will only work three times (unlimited use amulets are too difficult to make). Now that they don't have to worry about war, they can forge powerful items. To get your rewards, go to the appropriate paragraph: warriors, {123}; wizards, {157}; rogues, {106}; and warrior-wizards, {146}."
},
{ // 92/13A
"* You managed to get down in time to see a secret door in the south wall open and two orcs emerge. You have one turn to fire missiles or magic at the orcs before you are in close combat. To hit one, you need to make a L4-SR on DEX (35 - DEX). [You may only use non-metallic weapons which means no crossbows. ]Each orc has a MR of 29. You notice that they are not affected by the magnet. If you kill them, go to {69}. If they kill you, they eat you."
},
{ // 93/13B
"You are at a bend in the passage. Roll to see if a random encounter occurs. If you survive, you can go east to {24}. If you go south, go to {81}."
},
{ // 94/13C
"You have successfully entered the room. It is empty except for a skull on a pedestal in the dead centre of the room. Closer examination reveals that the skull has diamonds for eyes. Also, the interior bones are missing, and the skull has been cut into two halves which are connected by a hinge in the back. You may wear the skull over your head. When you first try it on, you realize that the rest of your body has been turned into a skeleton and will remain that way until you remove the skull. Right now, the skull has permitted you to see a secret door in the east wall. Whenever you reach a paragraph that begins with an '&', go immediately to the Skull Chart and find the effect. You may now leave through the secret door (which also appears to be one-way) by going to {174}."
},
{ // 95/13D
"They give you Dronadin, an extremely powerful sword. Dronadin is a longsword that has 6 dice + 15 adds, weighs 90, and will automatically adjust itself to your Strength and Dexterity. [Whenever you wish, Dronadin can cast a Vorpal Blade which will last the entire combat session at a cost of only 4 Strength to you. Also, Dronadin has a special poison compartment which will only release poison when damage is done to the opponent. ]They also give you 7500 gp in any form you wish (emeralds, a gold and ruby ring, cash, etc.). This adventure has been worth 7500 ap."
},
{ // 96/13E
"& The shop is a small one with a large red and blue sign posted with the items and the prices (as well as the paragraph you go to when you buy the item). The items that are for sale are:\n" \
"    Magical fishing nets - 250 gp each ({23})\n" \
"    Magical clay - 25 gp each ({142})\n" \
"    10 magic arrows - 200 gp ({46})\n" \
"    Meat preserver - 100 gp each ({77})\n" \
"    Lickum & Stickum dagger - 275 gp ({156})\n" \
"    Magic door knocker - 100 gp ({136})\n" \
"    Fire extinguishers - 100 gp each ({5})\n" \
"If you don't want to buy anything, you may go to Kalstain's palace at {9} or back to your ship at {210}."
},
{ // 97/14A
"The magnet has a lever at its base with three settings. It is currently pulled towards you. You may push the lever into its middle position by going to {166}, push its position away from you by going to {209}, or you may do nothing and go to {125}."
},
{ // 98/14B
"The people rejoice as you give them the food (note: this is just one catch). The islanders have enough strength to start farming, fishing, and hunting again. The leader of the islanders, Rowrke, gives you a dead jajuk, which is the highest reward anyone on Kelsa can receive. They also give you a diadem which will allow you to understand any and all languages[ for three uses only]. It will automatically work when it is needed. The main features of the port are a healer, a magic shop, a shipbuilder, and an armoury/weapons shop dealing especially with magic weapons and armour.\n" \
"  You may leave for another island, go to the magic shop at {84}, the healer at {45}, the shipbuilder at {184}, or the armoury at {129}. If or when you come back, you will not be able to buy things using fish."
},
{ // 99/14C
"The outside of the temple is unguarded, and you enter quite easily. When you enter, you realize that the green glow is coming from the rear part of the temple itself. Suddenly, two small, disgusting creatures come walking down the hall in your direction. They are probably demons and are not too friendly. You may attack by going to {182}, hide behind one of the pillars by going to {37}, or attempt to run off into one of the side passages unnoticed by going to {179}."
},
{ // 100/14D
"Going around the building, you find a small clearing. In this clearing, you see a large hole in the ground. Looking at the hole, you realize that the hole does not go straight down; it is more like a chute going deep into the earth. You may jump on the chute by going to {201}, head back around the building by going to {59}, or try to head to the mountain by going to {198}."
},
{ // 101/14E
"*& The mouth laughs in delight, and then it speaks once more:\n" \
"    First you will battle something dead\n" \
"    Which will try to eat your measly little head.\n" \
"The mouth utters a few magic words and from the ground emerge two zombies. Each one has a MR of 3. They are disgusting and somewhat decayed.\n" \
"  Before you fight, make a L2-SR on your current CON (25 - CON). If you fail, all of your die rolls are reduced by 1/3 for this combat. You only need to make this roll once. However, if they ever hit you, make another L2-SR on your current CON. If you fail, you have been infected and your ST is cut in half until you can heal yourself or can be healed.\n" \
"  Anyway, fight. If you dispatch the zombies, go to {193}. If they kill you, the mouth was right about what they would do."
},
{ // 102/14F
"* You pull out your staff and wave it, twirl it, or do anything possible. Finally, you touch the demon. It stops and emits an ear-piercing scream. The staff vibrates more and more as the demon shrinks. Finally the staff, overcharged by all the demonic energy, ignites and quickly consumes itself. The demon now attacks, but you can handle it. It has a MR of 80, and its scales take 5 points of damage every turn. Also, on the first turn you may do your full roll in damage as it casts a Delay on you. If you die, the demon devours (destroys) your soul. If you kill it, go to {186}."
},
{ // 103/14G
"Your weapon sticks in the tree. As you try to pull it out, you notice that it is slowly being consumed by the tree until you do not see it anymore (I hope for your sake the weapon wasn't magic). If you want to pick the leaves, go to {170}. If you want to pick and eat the fruit, go to {72}. You amy also leave for another island or go to the rock formation at {19}."
},
{ // 104/14H
"& You have successfully reached the upper reaches of the realm of the dead. If you have not talked with Kalstain, go to {22}. If you have, go to {207}."
},
{ // 105/15A
"Click. Press the same button, or try a new one."
},
{ // 106/15B
"First they give you a pair of gloves that will protect your hands from any poison needle, a medallion that will allow you to breathe poison gas for an hour, and a pair of boots which will allow you to walk one and a half times faster than your normal rate. In addition, they teach you 7500 gp worth of spells. Finally, they give you 15,000 gp[ in whatever form you wish (gold, emeralds, etc.)]. Take 15,000 ap or enough to advance to the next level, whichever is greater. You did a great job; congratulations."
},
{ // 107/15C
"You stand at the entrance to the underground portion of the Salkti ruins. It is a small, rubble-covered staircase leading into the ground. Right next to you is a tall, leafy tree with several branches. There seems to be some activity going on in the tree. You may climb the tree by going to {141}, or you may enter the ruins now by going to {65}."
},
{ // 108/15D
"As you leave the room, the entrance seals itself off. You walk along a passage that is so confusing that you don't know whether you are going up or down. Finally, you reach a staircase going down. Seeing no other alternative, you walk down it and finally...go to {56}."
},
{ // 109/15E
"* They scream, \"You invade again! We warned you that if anyone else came, they would die!\" With that they attack.\n" \
"  As they attack, you get a better look at them. They look humanoid except their skin has an orange tint to it, and their eyes are perfectly round. Each one has a CON of 36, a spear which gets 4 dice and 6 adds (very sharp point), and 5 personal adds. The armour takes 5 hits per turn. When you hit the armour, the metal has a special property which makes it spark very brightly. This will cause your DEX to be reduced by 5 the turn after you hit one of them. If you kill them, go to {162}. If your CON is reduced to between 1 and 5, go to {139}. If it already was between 1 and 5, and it drops to one, go to {139}. If your CON is reduced to 0, you die."
},
{ // 110/16A
"You must have some brains or else you wouldn't have made it this far in the adventure, but it sure doesn't seem like it now. Your body from the diaphragm up goes in the top passageway while everything else goes through the bottom. You are very dead, and being dead-alive won't help since your body is in two different places."
},
{ // 111/16B
"The chieftain looks very confused and rather upset. \"I do not know what to do now. I cannot tell whether you are lying or not. I guess I will drop you unhindered into the pit and let the gods decide from there.\"\n" \
"  You are taken outside, guarded by about 20 guards. They stop in front of a rather large hole in the ground. They point their weapons at you and command you to jump in. Very wisely, you follow their advice and enter the hole which seems to be the entrance to a chute; go to {201}."
},
{ // 112/16C
"Most of the book is illegible, but the last entry, which was written in an old dialect of Common, reads:\n" \
"  \"I wish my page would get here with the key to the chest so I could get the Zombie Control Amulet. He keeps it because I lose things too easily. It doesn't matter. We're all going to die. At least the ship with the amulet got off safely. They were able to damage Sxelba enough with it to banish him for at least 200 years, but they did not have the time to kill him. Now, as the last bit of his destructive magic takes effect, we are all dying. The outside is destroyed, and only our underground portion remains. It is truly a shame. The magnet was almost working and the magic mouth was just about functioning properly. I fear it will be taken over by some evil demon.\n" \
"  \"What is happening? I feel like I am being snatched away. All that is left is the crew of the other ship and the amulet which is going off to (smear).\"\n" \
"  If you have the amulet, you may go above to the main deck by going to {177}. Otherwise, you may reenter the ruins by going to {155}, or you may try to open the chest by going to {87}."
},
{ // 113/16D
"Just before you strike, you sense a wave of sinister emanations that apparently comes from the woman. If you still want to kill the man, go to {169}. Otherwise, change your target and go to {28}."
},
{ // 114/16E
"* They are just minor demons, and you get a better look at them as you fight. They have red skin, are covered with scales, and smell horrible. Each one has a MR of 38, and the scales take 4 points of damage per turn.[ Also, their slimy skin is extremely corrosive to metal. Each time they hit you, take the damage off of the base protection value of any armour you are wearing, permanently. And every time you hit them, you lose one-tenth of the damage you did to the weapon's adds, rounded up. Magic armour and/or weapons are protected from this.\n" \
"  Finally, only one fights on the first turn while the other casts a demonic Take That You Fiend-type spell that does 10 points of damage and costs him 5 points of MR. Armour takes only half damage. On the second turn, they reverse roles.]\n" \
"  If you die, they dispose of your body in a rather unpleasant way. If you kill them, go to {120}."
},
{ // 115/16F
"The guards noticed you and pounced. One of them enters the tent. You hear muffled voices inside. A hooded figure emerges from the tent. He looks at you and says, \"So, they think they can defeat me with a mere mortal.\" His eyes glow red and he looks into your eyes deeply. Your eyes collapse with agonizing pain, and your brain explodes. Your bloody corpse is thrown back over the city walls."
},
{ // 116/16G
"*& The room is large with a high ceiling. On one wall, there is a small ledge protruding out. As you enter, the door closes and locks behind you. A thin layer of mist is suddenly gathering on the floor. You need to use an item here. On the first failure, the boots or armour around your feet will dissolve. On the second, you must take 4 points of damage. On the third, you ankles dissolve to the point where you fall and are dissolved."
},
{ // 117/17A
"You have emerged from the ruins. In the distance, you see the ball. Scanning the area, you see what looks like a huge campsite right near the city walls. You may leave the adventure now (condemning a city to its death, because you were its only hope) by going to {40}. You may try to sneak back into the city by going to {159}. You may reenter the ruins by going to {150}, or you may try to sneak into the enemy camp by going to {55}."
},
{ // 118/17B
"A further search of the room reveals that the corpse had a small pouch containing 50 gp. Also, right before the person died, he wrote the letters GORBY in blood on the wall. You have no idea what it means, but it might have some importance. You may climb back up the stairs in hope of leaving the adventure (go to {161}), or you may leave the room via the south exit by going to {24}."
},
{ // 119/17C
"* The room must have been the workplace of an alchemist. Bottles of all shapes and sizes line the shelves. When you entered, you set off a trap causing several of the bottles to fall and crash to the floor. As the contents came in contact with the cold stone, a red steam rose. The stones have taken on a blob-like structure, joined together, and now are attacking. The blob has a MR of 52. However, blunt weapons only do ¾ damage and edged weapons do only ½ damage. The blob is nevertheless very sensitive to hellfire which will do 1½ of its normal damage instead of the ½ or ¾. If you die, it digests you. If you kill it, go to {66}."
},
{ // 120/17D
"On each of their bodies, you find a gold necklace. When you remove the necklaces, the corpses seem to soak into the ground. If you try on a necklace, go to {153}. Otherwise you seem to have trouble determining their value. You may take them and handle the matter later.\n" \
"  You may now explore the adjacent corridor by going to {145}, or head towards the green glow by going to {180}."
},
{ // 121/17E
"* The mouth doesn't say anything for 3 turns (you may use this time to regain Strength). It then speaks again:\n" \
"    So far I have seen two opponents fall,\n" \
"    But here is one more yet less powerful than all.\n" \
"The ceiling begins to rise. Suddenly, there is a great cloud of smoke and a brilliant flash of light. Before you stands what looks like a 40' tall orc. You have one free turn to strike. Calculate your roll (or spell damage) and go to {80}."
},
{ // 122/17F
"The room you are dumped into is large and square. On its walls you see what looks like very old bloodstains, but you do not pay any attention that because the floor is covered with gold coins and jewels! You are thrilled, but this does not last long because the pile starts to move. The source of the bloodstains has now emerged from the pile. The horror reveals itself to be a skeleton, of what creature you cannot tell, but it has very large wings still covered with a thin membrane. It does look somewhat reptilian. As it emerged, it broke through a false ceiling and kicked a large hole in the side wall. If you choose to run through the hole, go to {18}. If you choose to fight, go to {168}."
},
{ // 123/17G
"They arm you to the teeth. First, they give you a suit of quilted silk armour woven from the extremely rare Throfd Worm. Although you will not be able to get your warrior's double protection bonus, the suit takes 15 hits of damage and is also immune to acid and fire.\n" \
"  They also forge Werqus for you. Werqus is an extremely powerful great-sword which will automatically adjust to your abilities. Werqus gets 9 dice and 200 adds. Werqus can also cast a Zappathingum on itself at a cost of only 8 ST points. It also has a special compartment that will deliver poison only when you score damage on the opponent. They give you 15,000 gp in whatever form you wish (gold, emeralds, etc.). Take 15,000 ap or enough to advance to the next level, whichever is greater. You did a great job; congratulations."
},
{ // 124/19A
"You break free! A green light similar to that which you saw when you entered now fills the room. You hear a loud but distant voice which sounds as if the speaker had been dead hundreds of years.\n" \
"  \"Stranger. You have passed our tests. We have decided to let you take the amulet. Our time has passed. While the amulet may not defeat Sxelba, our destroyer, it is the key to a nearby power. Use it for good and to help send Sxelba back to the proper dimension where we can handle him. Good luck.\"\n" \
"  You may now leave the room. As you leave, the door turns into iron and seals itself. You may head south to {50} or north to {93}."
},
{ // 125/19B
"* Two orcs suddenly jump out from a secret door in the south wall. You have one turn to push the lever away from you by going to {143}, cast a spell, or fire a missile weapon (L3-SR on DEX (30 - DEX) to hit). In melee, each orc has a MR of 29. If you kill them, go to {69}. If not, you become their lunch."
},
{ // 126/19C
"You have just exited the caves of death. For surviving this far, take 2000 ap. In this part of the adventure, you are free to sail wherever you wish, picking up clues and items at various islands. For each journey, choose your destination and then consult the Travel Chart to see how long the journey will take in twelve hour increments. Every twelve hours, roll one die. If the result is a 1, then roll on Random Encounter Chart #2 to see what the ship encountered. Because the zombies do not tire, they can row all day and all night, allowing you to rest.[\n" \
"  For those of you with rabies, this particular strain is very fast-acting. For every three days you travel uncured, you lose one-fourth of your IQ and one-eighth of your DEX (the disease eats away your spine). Once you are cured, for every one-fourth of IQ lost you lost 2 points of IQ permanently. Similarly, 1 point of DEX is lost permanently for every one-eighth lost. If your IQ drops below 5, you go mad and die. If your IQ is 5 or below already, this happens when you drop below 3.]"
},
{ // 127/19D
"The volcano has considerably cooled down and the lava has hardened. A small ship, however, did not make it, and you decide to search the wreckage. All you find in the wreckage is a small bottle of ointment which says, \"Mortus ointment. Give yourself the appearance of being dead when you're still alive. Fool friends and family. It's so realistic that it could even fool the dead.\" It's probably some patent ointment, but you decide to take it away (if you haven't guessed, it's an item). You may now set sail to your next destination."
},
{ // 128/19E
"The gods feel you have gone too far to die at this puzzle, so they supply you with a clue.\n" \
"    The words written by a dying man's hand\n" \
"    Are to some the most important in the land.\n" \
"    The letters speak of colour, order, and peace to be\n" \
"    And praise to be given to you but not to me.\n" \
"The gods then revive you at full CON. The clue, however, was costly. If you have never heard this clue before, you only lose 2000 ap and 5 points of IQ. If you have heard it before (remember the mouth?), the penalty is doubled. Your IQ can never drop below one. The gods will only do this once. Now go back to {56}, think very carefully about everything you have encountered, and try again."
},
{ // 129/19F
"[In this shop, each catch of fish will buy you 100 gp worth of work. ]Because you saved them, they give you special rates. [If you want a weapon permanently poisoned, the cost is equal to five times the normal cost of the poison. To give a weapon an extra die, the cost is equal to one-fourth of the weapon's cost (maximum of 3 extra dice per weapon). Adds cost one-tenth of the weapon's cost each (maximum of 12 extra adds per weapon). To give armour an extra point of protection costs one-tenth the armour's cost (maximum of 10 points for each complete set of armour). ]The store also sells plain weapons and armour at three-fourths of its normal cost.\n" \
"  Afterwards, you may leave for another island, go to the magic shop at {84}, the healer at {45}, or the shipbuilder at {184}."
},
{ // 130/20A
"The dagger flares, scorching your fingers, and you drop it. Quickly draw another weapon and attack! Go to {36}."
},
{ // 131/20B
"* As you fight them, you get a better look at them. They look humanoid except their skin has an orange tint to it, and their eyes are perfectly round. Each one has a CON of 36, a spear which gets 4 dice and 6 adds (very sharp point), and they get 5 adds. The armour takes 5 hits per turn. When you hit the armour, the metal has a special property which makes it spark very brightly. So brightly in fact that the turn after you hit one of them, your DEX is reduced by 5. If you die, they throw your body over a cliff. If you kill them, go to {162}."
},
{ // 132/20C
"His eyes turn bright red and he begins to speak once again, \"So, you know something we don't? Any true priest would know he hasn't launched his major assault.\"\n" \
"  Before you know what's happening, two demons similar to the ones you saw earlier grab you and bind your hands. While you're on the sacrificial altar (you're the sacrifice, if you hadn't figure it out), you begin to question your decision. Goodbye."
},
{ // 133/20D
"The snake takes its time eating and you are beginning to get bored to the point of sleep. You are rudely awakened by the screech of the bird who lives in the nest. The bird is considerably larger than you thought and, in fury, attacks you from behind, inserting one of its claws into your jugular vein. Your bloody corpse falls out of the trees and splatters on the rocks below."
},
{ // 134/20E
"The minute you enter the room, an eerie green light shines on you and then disappears. The room is small and square-shaped, with a circular altar in the middle. Prominently displayed is an amulet. You may try to leave by going to {151}, or you may advance on the altar by going to {7}."
},
{ // 135/20F
"As you climb up the steps, you get a better view of the altar. It is made out of stone and has a multi-coloured circular pattern in the centre which begins to spin. Make a L2-SR on IQ (25 - IQ). If you fail, go to {195}. If you make it, go to {49}."
},
{ // 136/21A
"The door knocker is guaranteed to open any door in any circumstance. You may buy something else by going to {96}, go to your ship at {210}, or go to Kalstain's palace at {9}."
},
{ // 137/21B
"You've eluded the guards, and it doesn't look like any of them saw you reach the building. It looks like an ancient yet sturdy palace. You may enter by going to {198}, or go around the palace to see what, if anything, is off to the side by going to {100}."
},
{ // 138/21C
"The blood released by all of the tentacles has a chemical reaction with the liquid which kills the squid. There is another flash of light and the room is once again empty except for you and the mouth. Good job! For the combats, take 1500 ap. Also, the gods are very pleased. You find on your finger a gold ring with a large emerald worth 1500 gp. If you choose not to sell it, people will recognize the divine symbol of bravery (which can only be engraved by the gods). While you wear this ring, you may add 3 points to your Charisma. The mouth is true to his word and gives you a clue; go to {26} to receive it."
},
{ // 139/21D
"& You fall unconscious. When you wake up, you find yourself in a small room. You still have all of your possessions, but your are bound. Two guards walk in and take you through a confusing series of corridors. Finally you enter a large hall. Sitting on the throne is what you presume to be the leader of the creatures. As he speaks, your diadem glows softly.\n" \
"  \"You have been accused of violence against our people,\" he says. \"There is no doubt as your guilt, but before I decide on the sentence is there anything you would like to say?\"\n" \
"  You'd better say something and make it good. Try the best you can to explain the reasons for your violence and your mission. make a L4-SR on the average of you IQ, LK, and CHR (35 - ((IQ + LK + CHR) ÷ 3)). If you fail, go to {188}. If you make it, go to {111}."
},
{ // 140/21E
"The trees have dead trunks with yellow/green leaves and purple fruit with shiny skins. If you want to try to cut the trunk, decide on which weapon you're using (preferably edged) and go to {103}. If you want to pick the leaves, go to {170}. If you want to pick and eat the fruit, go to {72}. You may also leave for another island or go to the rock formation at {19}."
},
{ // 141/21F
"It was difficult, but you managed to get up. Less than 3' away from you is a rather large snake eating some brightly coloured eggs from a bird's nest. You can tell it sees you because it has eyes on the side of its head and they're obviously focused on you, but it just keeps on eating the eggs. If you decide to climb down and just leave it to its meal, go to {165}. If you decide to attack, go to {196}. If you decide to sit and wait, make a L1-SR on IQ (20 - IQ). If you make it, go to {44}. If you miss the roll, go to {133}."
},
{ // 142/21G
"The minute you buy the clay, it begins to transform. Roll one die:\n" \
"  1. It divides into two pieces. Roll twice more on this table.\n" \
"  2. The clay turns into a small gold statue of yourself worth 50 gp.\n" \
"  3. The clay turns into a scimitar which will get +30 adds the first time you use it. After this it will immediately break, becoming useless.\n" \
"  4. The clay turns into contact poison which seeps through your skin and causes a loss of 3 points of both DEX and ST until you get cured (no effect if you are immune to poisons).\n" \
"  5. The mound turns into a salve which cures any disease once.\n" \
"  6. It turns into a small, funny looking bird that immediately bites you for damage equal to ½ of your current CON's worth of hits due to its poison teeth (take one hit if you are immune to poison). After that, you realize its true nature. It will scout ahead of your ship and look for storms. Because of this advanced warning, storms will only do half damage.\n" \
"  You may buy something else by going to {96}, go to your ship at {210}, or go to Kalstain's palace at {9}."
},
{ // 143/22A
"The equipment goes flying off the magnetic at lethal speeds, killing the orcs. [However, your equipment is destroyed. ]Go to {69}."
},
{ // 144/22B
"They yell something which seems in another language. Then your diadem begins to glow and you understand that they are saying \"Stop or die! What are you doing here? Follow us! We have alerted others and they are coming.\"\n" \
"  They aren't lying; you see the reinforcements arriving. You may attack by going to {199}, go peacefully with them by going to {85}, or try to run by going to {43}."
},
{ // 145/22C
"The corridor goes on for 30' and ends in an open room with no doors. On the walls inside, you see various organs and skulls from all sorts of animals, many of which you do not recognize and some of which look humanoid. On another wall, there are scenes depicting a great fire burning through a city as the people are charred. The central feature in the room is an altar on which you see a black robe with Sxelba's symbol on the back and an obsidian sacrificial dagger. You may take these items, but be sure to write down when you are wearing the robe. You may now leave by going to {167}."
},
{ // 146/22D
"They give you one item - the sword Grtaz. Grtaz gets 11 dice and 25 adds. In addition, Grtaz functions as a deluxe staff and has memorized all the first and second level spells as well as Bog and Mire, Hard Stuff, Blasting Power, Healing Feeling, and Protective Pentagram. It also has a special component that will deliver poison only when you score damage on an opponent. Finally, they give you 15,000 gp in whatever form you wish (gold, emeralds, etc.). Take 15,000 ap or enough to advance to the next level, whichever is greater. You did a great job; congratulations."
},
{ // 147/22E
"The chief, after a moment of thought, begins to speak again, \"Stranger, I know of the amulet, but until now I knew neither its purpose nor its origin. If what you say is true, then we shall be finally rid of the demons if you succeed. I will now deliver you to the amulet, but I warn you that it is guarded by some strange force. I do not know how to retrieve it. Good luck.\"\n" \
"  He gets off his throne and begins to push it. It slides away to reveal a pit. He says a few magic words which he explains are to make your fall easy enough to avoid any damage from impact. This is it. Take 300 ap for explaining yourself so well and jump in; go to {56}."
},
{ // 148/23A
"You decide that a fire in the night would draw too much attention, and you'd probably be discovered because of it. Wait for a chance to sneak into the tent and go to {203}."
},
{ // 149/23B
"If you are wearing any metallic armour, go to {51}. If not, go to {189}."
},
{ // 150/23C
"You are nearing the end of a very long north-south corridor. From here you can see the night sky outside. Check for a random encounter as usual except now an encounter occurs on a roll of 1, 2, 3, or 4. If you survive, you go outside by going to {117}, or you may go north by going to {30}."
},
{ // 151/23D
"Sorry, a wall of force has just appeared. Return to the paragraph you came from and try not to be such a coward."
},
{ // 152/23E
"& You are dizzy for a few seconds and all you can see are bright lights. When you can see again, you find yourself in a small clearing in a forest. Two men armed with spears and dressed in what looks like a green-coloured metal for armour are standing nearby. If you attack them, go to {131}. If you try to leave, go to {144}. If you would like a wait for a second, go to {60}. If you are wearing the priest's robe, they seem a little upset; go to {109}."
},
{ // 153/23F
"As you put the necklace on, you feel your mind being torn out. You are now under control of the demons[ and will fight future characters insted of the small demons who would have normally fought. Your soul is imprisoned until another character successfully defeats you. Your demon will fight at full attributes and will generate 3 dice damage with its clawed hands. Leave your character's card at {36} until you are freed - by death]."
},
{ // 154/24A
"They teach you 3000 gp worth of spells. In addition, if you are a warrior-wizard, they give you an extra-heavy longbow with intricate runes (it gets an extra 2 dice damage when it hits, and whenever you fire it subtracts two levels from the saving roll). If you are a rogue, they give you a 2 dice dagger that always hits when you throw it and a suit of leather armour that absorbs 10 hits. In either case, they also give you 7500 gp in any form you wish (emeralds, a gold and ruby ring, cash, etc.). This adventure has been worth 7500 ap."
},
{ // 155/24B
"You are at the end of a long corridor. In front of you, you see an arch which leads to a long ramp going through a cavern. Suddenly, you hear a voice say, \"Psst, buddy, want a clue?\" With that, a secret panel on the west wall opens up revealing a small alcove. You may go north to {6}, enter the alcove by going to {39}, or go down the ramp by going to {25}."
},
{ // 156/24C
"The dagger is a 2 dice and 5 adds dagger. The dagger is covered by an adhesive that is activated by moisture. One activated, the blade will stick to anything it touches. Once the blade has been stuck to something for five seconds, it will explode and do 30 points of damage. Thus, you will lose the dagger if you hit someone with it, but the victim will be in for a big surprise. It will stick to your opponent even if you don't do damage.\n" \
"  You may buy something else by going to {96}, go to your ship at {210}, or go to Kalstain's palace at {9}."
},
{ // 157/24D
"They teach you 10,000 gp worth of spells. In addition, they give you a special deluxe staff (with no spells memorized) that cuts the ST cost of each spell you cast in half. This replaces the normal staff bonuses. Finally, they give you 15,000 gp in whatever form you wish (gold, emerald, etc.). Take 15,000 ap or enough to advance to the next level, whichever is greater. You did a great job; congratulations."
},
{ // 158/24E
"Somebody did come. Out of a secret door in the south wall the two orcs who set the trap came charging. Before you could do anything, they slit your throat and ate you."
},
{ // 159/24F
"& You reenter the city with minimal difficulty. They see you have failed. They say that unless you can now sneak into the enemy camp and do something, the city's inhabitants are doomed to a life of slavery or, most likely, will all be killed. You may attempt to sneak into the enemy camp by going to {55}, or you may abandon your quest and escape once outside by going to {40}."
},
{ // 160/24G
"If you are a fairy, leprechaun, or elf, you are skinny enough; go to {38}. If not, this is going to be close. Divide your weight by your height in inches and round up to figure out how bulky you are. This is the level of the saving roll you need to make on LK. If you are wearing plate armour, add one level. If you make it, go to {38}. If you miss, one of two things happened. Either the top of your stomach was torn off, resulting in massive and fatal haemorrhaging, or the top part of your armour was torn off. In the latter case, it was well-connected to the other parts. The resulting action is that your body is twisted and contorted inside of the armour. Either way, you are dead."
},
{ // 161/24H
"One of Sxelba's scouts sees you. He's not sure what you are, but not to take any chances, he fires his arbalest; he's a great shot. Make a L2-SR on LK (25 - LK). If you fail, go to {17}. If you make it, go to {64}."
},
{ // 162/24J
"On each of their bodies, you find a ring with a diamond in it worth 120 gp. The noise of the fight has attracted other guards. You see at least 20 of them. In the distance you see two things: the side of a mountain and a large building. You may stand and fight by going to {199}, run towards the building at {137}, or run towards the mountain at {198}."
},
{ // 163/25A
"You made it through the outside defence. About 100' in front of you is a very large, dimly lit tent. You may try to set the tent on fire by going to {71}, or you may try to sneak in by going to {203}."
},
{ // 164/25B
"The fire is not very small. If will take one-half of a fire extinguisher to put out the fire. The ship is also partially damaged, and all trips will take one-fourth of the time indicated longer. If and/or when you decide to return the island, go to paragraph {127}."
},
{ // 165/25C
"As you're on your way down, it sees the perfect opportunity and attacks. You now have a rather large snake wrapped around your neck. It is trying its hardest (and probably doing a rather good job) to choke you. Each combat turn, take damage starting at one point and increasing every turn by one. You lose the first combat turn getting down to the ground so you can fight. At the next combat turn, make a L3-SR on Dexterity (30 - DEX). If you make it, you did enough damage to kill the snake. If not, take the damage from constriction and try again. If you kill the snake, go to {13}. If you die, maybe you should start again with a more powerful character."
},
{ // 166/25D
"* [Your equipment falls to the floor. ]Simultaneously, two orcs emerge from a secret door in the south wall. You have one free turn to cast a spell, [grab a metal weapon that just fell, ]or fire a missile. To hit one of the orcs, you need to make a L3-SR on Dexterity (30 - DEX). In melee, each orc has a MR of 29. If you kill the orcs, go to {69}. If they kill you, they eat you."
},
{ // 167/25E
"As you leave the room, you see a rather tall man wearing a cloak similar to the one you just took. If you are wearing the cloak, go to {54}. If you are not wearing it (or chose not to take it), the man's reaction is not exactly friendly; go to {36}."
},
{ // 168/25F
"* The creature realizes that you're going to fight, and it flies to the top of the room. It somehow seems to know that you will be a tough opponent. You have two turns to fire missile weapons or cast spells. To hit it, you will need to make a L4-SR on Dexterity (35 - DEX) because, although it is big, the bones have much space between them. It has a MR of 120. After these two turns, it dives to the floor, lands, and attacks. [It is immune to all poisons except hellfire juice. Also, the bones have become very brittle after all these years and any hits done with blunt weapons will score double damage. ]If you kill it, go to {79}. If you die, your possessions are spirited away from you by some strange force and your body eventually decays."
},
{ // 169/25G
"The man lets out a high shriek as he dies. Then a strange glow envelops him. He is turning (or turning back) into a woman. The other figure also reverts to his original appearance. Every muscle in your body is paralyzed. He gets up and begins to speak: \"This little masquerade always works; they always assume that I am the man. We have a slight problem now. You have killed my lover, so now I will have to kill you.\" You feel your flesh light on fire and melt away. You are used for breakfast for the men in the morning."
},
{ // 170/26A
"As you pluck the leaf, a bright, red fluid fluid oozes out of the tree. You watch in horror as the leaf shrivels, turns brown ad dies. The flow of the liquid stops. Unfortunately, some of the liquid oozed onto your feet. [If you have boots, the liquid is absorbed into them. They are now somewhat alive. When you wear them, you walk at double rate; however, after every hour of wear you must feed them meat or blood (any species) or else they will eat your feet!\n" \
"  If you are not wearing boots, ]your feet absorb the blood and grow to three times their normal size. [Boots will now cost you five times normal rate. ]In addition, your Charisma loses five points (how can you be very seductive or leading with those funny looking things). The feet may be returned to normal with a Mutatum Mundatorum.\n" \
"  If you want to try to cut the trunk, decide on which weapon you're using (preferably edged) and go to {103}. If you want to pick and eat the fruit, go to {72}. You may also leave for another island or go to the rock formation at {19}."
},
{ // 171/26B
"You return to discover that a landslide has occurred and you may no longer enter the caves."
},
{ // 172/26C
"You finally reach the altar itself. As you reach for the amulet, three mechanical doors in the altar open. Out of two, mechanical hands come out and grab the hand you were reaching for the amulet with. They then try to pull it down and impale it on the spike which came out of the third door. Make a L3-SR on Strength (30 - ST) to see if you can pull away. If you fail, go to {35}. If you make it, go to {124}."
},
{ // 173/26D
"The fire is small enough to put out with your cloak. To return to the island now, go to paragraph {127}."
},
{ // 174/26E
"You are in a north-south passage. Check to see if you meet a random encounter. If you survive, you may go north to {8}, or you may go south to {15}."
},
{ // 175/26F
"Click. Press the same button again or try a new one."
},
{ // 176/26G
"Too late. It has fully animated and with lightning speed and very little effort punctures your heart with one of its claws. You are quite dead."
},
{ // 177/26H
"The zombies, once they see the amulet, immediately start rowing out of the cave. Using the amulet, you can command them to go in different directions, hence to different locations. The underground river empties into the ocean which you are now in. Go to {126}."
},
{ // 178/26J
"You are in a north-south corridor. To your west there is a door. If you choose to enter the room, go to {119}. If not, you may go north to {15} or south to {6}."
},
{ // 179/26K
"* You make a mad dash for it. You hope you do not make too much noise or are visible for they will definitely see you. Make a L4-SR on the average of your LK and DEX (35 - ((LK + DEX) ÷ 2)). If you are a rogue, subtract one level from the saving roll. Hobbits and elves subtract one level from the roll, fairies and leprechauns subtract two. If you are wearing any metallic armour, add one level (two for plate). If you fail, they attack you at {114}. If you make it, go to {145}."
},
{ // 180/26L
"You reach the source of the green glow. It is a rectangular shaped doorway. In front of it (and guarding the entrance) is a huge, inanimate, green, humanoid creature with horns, sharp claws, and red scales. Next to it is a plaque which reads \"This door leads to the death of our master. Let only demons pass through in hope of destroying the source. Death to all else who try.\"\n" \
"  You may attempt to enter by going to {10}, return to your ship, or attempt to use an item."
},
{ // 181/27A
"You enter the port of Alscen without problem. You hire some guards to keep an eye on your ship for 25 gp (if you cannot afford the guards, you must leave). It is a normal city with two prominent features, Kalstain's palace and a shop with the sign 'Marton's Magical Trinkets'. You may go to the palace by going to {9} or you may go to the shop by going to {96}."
},
{ // 182/27B
"* You have one free turn to cast magic or to use missile weapons. They are small and at near range. Go to {114}."
},
{ // 183/27C
"The fire is a small one, and it will take only one-fourth of a fire extinguisher to put it out. Your ship has avoided any permanent damage. To return to the island, go to paragraph {127}."
},
{ // 184/27D
"The shipbuilder will repair damage equal to a quarter delay for each catch of fish or 100 gp. You may leave for another island, go to the magic shop at {84}, the healer at {45}, or the armoury at {129}."
},
{ // 185/27E
"You change your mind and attack him before he can accept or reject your offer. Go to {36}."
},
{ // 186/27F
"You may take 250 ap for this battle. As the demon dies, it is absorbed into the ground. The temple minions who heard the scream are now charging. You have only one chance and that is to jump through the door which takes you to {152}."
},
{ // 187/27G
"The chest opens to reveal an amulet which you may now take. You may read the book by going to {112} or go above to the main deck at {177}."
},
{ // 188/27H
"That was a pretty bad attempt. In fact, he looks angrier than before. He speaks briefly, \"Prepare him for death in the Pit of Death.\"\n" \
"  You are taken outside where somebody says a few magic words. They move you to the side of the building next to a huge hole in the ground which they place you in. The hole is actually the entrance to a chute, and you slide for about 200' when you see the chute being divided into two sections, upper and lower. You feel the magic pull you down as your body goes through the lower passage.\n" \
"  Seeing as they probably planned it this way and there is death at the end of your slide, you try to break your bonds as you slide down. If you want to try to work out out a dagger or edged weapon to cut the ropes, make a L5-SR on Dexterity (40 - DEX). If you just want to pull the bonds apart, make a L5-SR on Strength (40 - ST). You only have time for one attempt, so choose wisely. If you fail the roll, go to {52}. If you make it, your hands are free and you are somewhat prepared for the danger; go to {38}."
},
{ // 189/28A
"[As you enter the room, all of your metallic equipment is ripped away from you and is now attached to a huge magnet. ]You may examine the magnet by going to {97}, or you may wait a turn by going to {125}."
},
{ // 190/28B
"The step you are on collapses and your foot falls through into a hollow chamber; hollow, that is, except for several snakes, spiders, and scorpions. Make a L2-SR on Dexterity (25 - DEX). If you fail, go to {21}. If you make it, go to {70}."
},
{ // 191/28C
"Didn't you listen to Kalstain? He said well-preserved. Frietoc has no use for the jajuk. If you bring it back to Kelsa and explain, they will probably give you a new one - but just one more! And remember to have some preserver on hand! Return to the surface at {67}."
},
{ // 192/28D
"You aren't very good at this. One of the guards sees you and shoots you with a poisoned bolt from his arbalest. The poison isn't very fast-acting, and you are racked with a burning pain for two minutes before you die."
},
{ // 193/28E
"*& The zombies soak back into the floor. The mouth speaks again:\n" \
"    Now a horrible foe wreathed in flame\n" \
"    Whose manner I guarantee will not be tame.\n" \
"In front of you a fire demon is forming. The heat in the room is almost unbearable. Each turn, make a saving roll on your current CON to see if you can take the heat. If you have no armour, quilted cotton, or silk, it is a L1-SR; if you have leather, it is a L2-SR; if you have ring-joined, scale, or lamellar, it is a L3-SR; if you have mail, it is a L4-SR; and if you are in full plate, it is a L6-SR. If you fail, you faint and it kills you instantly.\n" \
"  While it is still forming, you have one more free turn to cast a spell or drop your armour. You realize it will be futile to file missile weapons because the arrows or quarrels would just burn up before they hit. It has a MR of 75. If you kill it, go to {121}. If it kills you, you are roasted to a crisp."
},
{ // 194/28F
"The magnet is facing the ball. At the base of the magnet, you see a lever which can be pulled towards you or pushed away from you. If you wish to pull the level towards you, go to {48}. If you wish to push it away, go to {57}. Or, if you wish to leave, go to {24}."
},
{ // 195/28G
"The spinning made you so dizzy that you fell...off the altar and right into a pit full of acid which just opened. You are dissolved."
},
{ // 196/28H
"* The snake is not surprised and is ready to fight. It has a MR of 48. However, each turn you must make a L1-SR on LK (20 - LK) to avoid falling out of the tree and smashing your skull on the rocks below. If you kill the snake, go to {13}. If you die, maybe you should have started out with a better character."
},
{ // 197/29A
"* The direct approach seems a little too scary, so you choose to go around the back way. The jungle is dense and the air is humid. The journey seems simple enough except that you see movement up ahead. The next thing you know, what looks like a giant mosquito is attacking.\n" \
"  Make a L3-SR on the average of your LK and DEX (30 - ((LK + DEX) ÷ 2)). If you make it, you may fight normally. If you fail, he has bitten you and is sucking your blood out very quickly! Each turn you must do as much damage as you can to it. It has a MR of 90, and you may do your full roll in damage. Each turn you lose a quarter of your CON. If you are fighting it normally and are ever hit, it begins to suck your blood.\n" \
"  If you have taken damage, make a L5-SR on your current CON (40 - current CON) when the combat is over to see if you have caught malaria. If you fail, then you've got it. Although the disease will not take full effect for at least forty-eight hours, you do begin to feel some adverse effects. Due to the nausea and occasional vomiting, subtract one-fourth of your ST and CON.\n" \
"  If you manage to kill it, you get 150 ap. Anyway, you may head back to the boat, enter the temple at {99}, or you may head towards the green glow at {180}."
},
{ // 198/29B
"* You see the Atocleans looking for you. After about fifteen minutes' worth of walking/running, you finally reach the side of the mountain. The side of the mountain is flat and straight. You see several guards about half a mile away, so you'd better work fast. You may search the nearby area by going to {73}, cast a spell, or try to pound or cut through the mountain by going to {11}."
},
{ // 199/29C
"These guys are armed with nets and spells. You feel your feet freeze to the ground, and you feel very tired as several nets are thrown over you...go to {139}."
},
{ // 200/29D
"The corpses absorb the blood, grow in size, and come to life. You now have a crew of zombies. However, they are not doing anything. One of them absorbed a little too much blood and feel through the deck into a small room. You may enter the room by going to {1} or reenter the main ruins via the ramp by going to {155}."
},
{ // 201/29E
"The chute is covered with a lubricant that eliminates almost all friction. About 200' away, you see a thin piece of metal at about chest level that will act like a guillotine! You cannot see how far it stretches. You may do nothing and go to {110}, lie flat and try to go under by going to {160}, or try to dive over it as you pass it by going to {2}."
},
{ // 202/29F
"As your ship pulls into Freegore's harbour, you feel a sharp jolt. A demon squid is attacking and destroying your ship. Some officials, citizens, and wizards were able to get you onto land as your ship sank. Go to {159}."
},
{ // 203/29G
"If you are wearing metal armour, make a L4-SR on the average of your LK and DEX (35 - ((LK + DEX) ÷ 2)). If you are not wearing metal armour you only need to make a L3-SR (30 - ((LK + DEX) ÷ 2)). If you fail, go to {115}. If you make it, go to {76}."
},
{ // 204/30A
"The fire is a big one. It will take two full fire extinguishers to put it out. The ship is also partially damaged, and all trips will take twice as long. To return to the island, go to {127}."
},
{ // 205/30B
"As you leave, you hear a huge noise; the magical power of the magnet has short-circuited and the magnet has exploded, causing the ceiling to collapse. For now, you are walking down a very long north-south corridor. On the west wall, there is a door. You may go through the door by going to {116}. Or you may continue south by going to {12}."
},
{ // 206/30C
"Make a L1-SR on Luck (20 - LK). If you make the saving roll, go to {130}. If your luck is lacking, go to {74}."
},
{ // 207/30D
"You recognize Frietoc and call him over using his real name which Kalstain taught you (I won't print it because if everybody knew, the poor guy would get no rest). The ointment is beginning to wear thin, and you had better decide on your next course of action. Another item seems a good idea. Right now he seems (if you'll pardon me) pretty lifeless. The ointment will wear out in a few minutes. You have five guesses until the ointment wears off and you are trapped in the world of the dead forever!"
},
{ // 208/30E
"You begin to realize that the stairs are not only going down physically, but you feel yourself crossing from one dimension to another.\n" \
"  You are entering the realm of the dead! Spirits sense your living flesh and, although they prefer a different species, are trying to feed from you. This requires an item. For every failure, make a L4-SR on the average of your IQ, ST, and LK (35 - ((IQ + ST + LK) ÷ 3)). Note that if you are only half-living, the roll is only 2nd level (25 - ((IQ + ST + LK) ÷ 3)). If you fail, remove one point from one of your attributes, determined randomly. If you decide you do not have the proper item, quickly return to the surface at {67}."
},
{ // 209/30F
"All of your equipment goes flying off and smashes into the wall where it is promptly destroyed. You have no choice but to go back to {24}."
},
{ // 210/30G
"You come back to find that low tides have slightly damaged the boat. Several repairmen will fix it for 100 gp. If you don't fix the boat, each journey will take an extra two days. Anyway, you may now go to another island."
}
}, as_wandertext[17] = {
{
"1*. Rats 4-6 rats the size of German Shepherds are attacking you. Each one has a MR of 13. They also have rabies. If they do damage to you, you must find a cure (or cast a spell) soon or you will die. As the adventure continues, you will be updated on your condition. You get 40 ap for each rat you kill."
},
{
"2*. Skeletons. Two skeletons who wander/guard the ruins have found you and attack. Each one has a MR of 30. They are immune to poison and edged weapons only do ½ damage. Blunt weapons, however, do twice normal damage. If you kill them, they are worth 100 ap total."
},
{
"3. Magical disturbance. There is a great magical disturbance here caused by Sxelba many years ago. If you do not know any spells, id does not affect you. If you do, make a saving roll at the spell's level on your IQ for each spell. If you fail, you forget that particular spell and cannot use it again until you relearn it or somehow find a way to remember it. For each spell you retain, you get the spell's level times 20 ap."
},
{
"4. Bolt. You triggered a pressure plate and a poison bolt was fired out of the wall at you. Make a L4-SR on the average of your DEX and LK (35 - ((DEX + LK) ÷ 2)). If you make it, you avoid the bolt. If you fail, it hits you for 20 points damage (this may be taken on armour)."
},
{
"5*&. Zombie. You have stumbled upon one rather large, very disgusting, living corpse who has stayed at the same level of decomposition for decades due to Sxelba's magic. Why Sxelba would do this is beyond you, but your job is to find an amulet, not ask questions.\n" \
"  Anyway, it attacks. It has a MR of 65. Every time it does damage to you, make a L3-SR on your current CON (30 - CON). If you fail, you have been infected. Each time you are infected, you lose ¼ of your ST until you are cured.\n" \
"  If it kills you, you begin to understand the magic. After it kills you, it falls dead and you come to 'life' to take its place. Put your character card here to fight the next character unlucky enough to meet this encounter. If you kill it, it is worth 200 ap."
},
{
"6*. Demon. A demon (MR of 45) materializes in front of you and attacks. In the first round, however, it will cast a Delay on you. In this time, you will have a chance to cast a spell or get one free attack."
},
{
"2. Storm - A violent storm hits the ship. The storm will throw your ship off course. Roll two dice. This is the number of extra days you will have to add to the time your voyage will take. Also, half of the roll times ten is the percentage damage your ship has received."
},
{
"3. Fish - You see school of fish swimming by the ship. If you have empty nets, you may catch a load of fish if you can get your nets ready by making a L2-SR on DEX (25 - DEX)."
},
{
"4. Sxelba's rams - A small ship with an iron prow is nearing your ship and is attempting to ram it. The zombies are strong enough to pull away, but this requires extreme concentration. Make a L3-SR on IQ (30 - IQ). If you make the roll, you outrace the ram. If you miss the roll, take the amount you missed by and multiply it by 10%. For all journeys undertaken until you get your ship repaired, add this percentage of the travel time to find out how long the trip will take you. If your ship takes more than 90% damage, it sinks taking you with it. After the rams have either damaged your ship or been outraced, they will leave to search for other prey."
},
{
"5. Small island - You see a small, uncharted island. It is empty except for some citrus fruit trees. You are able to get enough fruit to cure scurvy if you have it to prevent you from ever getting it."
},
{
"6. Beneficial current - This current takes 25% off of your travelling time."
},
{
"7. Fish - You see a school of fish swimming by the ship. If you have empty nets, you may catch a load of fish if you can get your nets ready by making a L2-SR on Dexterity (25 - DEX)."
},
{
"8. Merchant ship - A friendly merchant ship sails up next to you. You may buy any item in the rulebook at an extra 10% cost. [You may also sell your gems at a similar service charge. ]They will also heal any disease or poison for 300 gp or CON points at 25 gp apiece."
},
{
"9. Small raft - A small raft with a skeleton and a chest floats by. If you decide to open the chest, you must make a L3-SR on Luck (30 - LK) to avoid a mechanism which will start a small fire on your ship which will take ¼ of an extinguisher to put out. The ship will now take 10% longer to complete a trip. If you do not have any extinguishers, your ship will receive 50% damage before the zombies smother the fire and get enough water to put it out. If you survive, roll on the table below to determine the contents.\n" \
"  1.   A vial of liquid which will cure you of any disease plus all lost CON points (except those lost from poison).\n" \
"  2-4. An emerald worth 350 gp.\n" \
"  5-6. A vial of curare, a vial of spider's venom, and a vial of hellfire juice."
},
{
"10. Fish - You see a school of fish swimming by the ship. If you have empty nets, you may catch a load of fish if you can get your nets ready by making a L2-SR on Dexterity (25 - DEX)."
},
{
"11. Ghost pirates - You see a large ship approximately 500 yards away. It quickly nears your own ship. From the ghost ship, several spectral figures fly over to yours. They seep though the deck and emerge...with your gold! There are ten of them and you have ten rounds to kill them all before they steal all of your gold. Each one has a CON of 50. They will not fight back[, but they can only be attacked magically]. Each one that you kill will turn into a thick silk sheet with gold interwoven worth 100 gp. However, each one that escapes can magically carry 100 gp in weight. [They will immediately steal the jewels (each jewel weighs its worth divided by 100). ]Take 75 ap for each one you kill, and lose 25 ap for each one that escapes."
},
{
"12. Scurvy - You have not had enough fruit. Reduce your ST and CON by one die until you get some fruit."
}
};

MODULE SWORD as_exits[AS_ROOMS][EXITS] =
{ { 107,  40,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0 Freegore (early)
  { 112,  87, 155,  -1,  -1,  -1,  -1,  -1 }, //   1 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4 Freegore (later)
  {  96, 210,   9,  -1,  -1,  -1,  -1,  -1 }, //   5 Alscen
  { 178, 155,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7 Freegore (early)
  { 116, 174,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8 Freegore (early)
  { 210,  96,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9 Alscen
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11 Esdurt
  {  61, 205,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12 Freegore (early)
  {  90,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14 Esdurt
  { 174, 178,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15 Freegore (early)
  { 127,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16 Valeat
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18 Esdurt
  { 208, 140,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19 Kroan
  { 180, 145,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20 Esdurt
  {  70,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21 Freegore (early)
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22 Kroan
  {  96, 210,   9,  -1,  -1,  -1,  -1,  -1 }, //  23 Alscen
  { 149,  93,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24 Freegore (early)
  {  82, 155,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25 Freegore (early)
  { 155,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28 Freegore (later)
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29 Freegore (early)
  { 150,  61,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31 Esdurt
  { 180,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33 Freegore (later)
  {  99, 197,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38 Esdurt
  { 101, 155,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40 Exit World
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41 Esdurt
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42 Freegore (early)
  { 137, 198,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43 Esdurt
  { 196,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44 Freegore (early)
  {  84, 184, 129,  -1,  -1,  -1,  -1,  -1 }, //  45 Kelsa
  {  96, 210,   9,  -1,  -1,  -1,  -1,  -1 }, //  46 Alscen
  { 127,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47 Valeat
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48 Freegore (early)
  { 190, 151,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53 Esdurt
  {  36,  32, 132,  -1,  -1,  -1,  -1,  -1 }, //  54 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56 Esdurt
  {  24, 205,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58 Freegore (later)
  { 100, 198,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59 Esdurt
  {  85, 199,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60 Esdurt
  {  30,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61 Freegore (early)
  { 135, 151,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62 Freegore (early)
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63 Freegore (early)
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65 Freegore (early)
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66 Freegore (early)
  {  19, 140,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68 Freegore (later)
  { 194,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69 Freegore (early)
  { 172, 151,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71 Freegore (later)
  { 103, 170,  19,  -1,  -1,  -1,  -1,  -1 }, //  72 Kroan
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75 Esdurt
  {   4,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76 Freegore (later)
  {  96, 210,   9,  -1,  -1,  -1,  -1,  -1 }, //  77 Alscen
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78 Kelsa
  { 108,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80 Freegore (early)
  { 134,  93,  50,  -1,  -1,  -1,  -1,  -1 }, //  81 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83 Valeat
  {  45, 184, 129,  -1,  -1,  -1,  -1,  -1 }, //  84 Kelsa
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85 Esdurt
  { 153,  74, 180, 197,  -1,  -1,  -1,  -1 }, //  86 Esdurt
  { 155, 112,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87 Freegore (early)
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88 Esdurt
  { 140,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91 Esdurt
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92 Freegore (early)
  {  24,  81,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93 Freegore (early)
  { 174,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95 Freegore (later)
  {   9, 210,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96 Alscen
  { 166, 209, 125,  -1,  -1,  -1,  -1,  -1 }, //  97 Freegore (early)
  {  84,  45, 184, 129,  -1,  -1,  -1,  -1 }, //  98 Kelsa
  { 182,  37, 179,  -1,  -1,  -1,  -1,  -1 }, //  99 Esdurt
  { 201,  59, 198,  -1,  -1,  -1,  -1,  -1 }, // 100 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102 Esdurt
  { 170,  72,  19,  -1,  -1,  -1,  -1,  -1 }, // 103 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106 Freegore (later)
  { 141,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107 Freegore (early)
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110 Esdurt
  { 201,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111 Esdurt
  { 155,  87,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112 Freegore (early)
  { 169,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116 Freegore (early)
  {  40, 159, 150,  55,  -1,  -1,  -1,  -1 }, // 117 Freegore (early)
  { 161,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119 Freegore (early)
  { 153, 145, 180,  -1,  -1,  -1,  -1,  -1 }, // 120 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121 Freegore (early)
  {  18, 168,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123 Freegore (later)
  {  50,  93,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126 Freegore (early) aka cave
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127 Valeat
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128 Esdurt
  {  84,  45, 184,  -1,  -1,  -1,  -1,  -1 }, // 129 Kelsa
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133 Freegore (early)
  { 151,   7,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135 Freegore (early)
  {  96, 210,   9,  -1,  -1,  -1,  -1,  -1 }, // 136 Alscen
  { 198, 100,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137 Esdurt
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139 Esdurt
  { 170,  72,  19,  -1,  -1,  -1,  -1,  -1 }, // 140 Kroan
  { 165, 196,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141 Freegore (early)
  {  96, 210,   9,  -1,  -1,  -1,  -1,  -1 }, // 142 Alscen
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143 Freegore (early)
  { 199,  85,  43,  -1,  -1,  -1,  -1,  -1 }, // 144 Esdurt
  { 167,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146 Freegore (later)
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147 Esdurt
  { 203,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149 Freegore (early)
  { 117,  30,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151 Freegore (early)
  { 131, 144,  60,  -1,  -1,  -1,  -1,  -1 }, // 152 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154 Freegore (later)
  {   6,  39,  25,  -1,  -1,  -1,  -1,  -1 }, // 155 Freegore (early)
  {  96, 210,   9,  -1,  -1,  -1,  -1,  -1 }, // 156 Alscen
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158 Freegore (early)
  {  55,  40,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161 Freegore (early)
  { 199, 137, 198,  -1,  -1,  -1,  -1,  -1 }, // 162 Esdurt
  {  71, 203,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163 Freegore (later)
  { 127,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164 Valeat
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169 Freegore (later)
  {  72,  19,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171 cave
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172 Freegore (early)
  { 127,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173 Valeat
  {   8,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176 Esdurt
  { 126,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177 Freegore (early)
  { 119,  15,   6,  -1,  -1,  -1,  -1,  -1 }, // 178 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180 Esdurt
  {   9,  96,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181 Alscen
  { 114,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182 Esdurt
  { 127,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183 Valeat
  {  84,  45, 129,  -1,  -1,  -1,  -1,  -1 }, // 184 Kelsa
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185 Esdurt
  { 152,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186 Esdurt
  { 112, 177,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188 Esdurt
  {  97, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190 Freegore (early)
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193 Freegore (early)
  {  48,  57,  24,  -1,  -1,  -1,  -1,  -1 }, // 194 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195 Freegore (early)
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196 Freegore (early)
  {  99, 180,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197 Esdurt
  {  73,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198 Esdurt
  { 139,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199 Esdurt
  {   1, 155,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200 Freegore (early)
  { 110, 160,   2,  -1,  -1,  -1,  -1,  -1 }, // 201 Esdurt
  { 159,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202 Freegore (later)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203 Freegore (later)
  { 127,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204 Valeat
  { 116,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206 Esdurt
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207 Kroan
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208 Kroan
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209 Freegore (early)
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 210 Alscen
};
/* Freegore (early) aka cave =  82 paragraphs
   Esdurt                    =  67 paragraphs
   Freegore (later)          =  23 paragraphs
   Kroan                     =  13 paragraphs
   Alscen                    =  11 paragraphs
   Valeat                    =   8 paragraphs
   Kelsa                     =   6 paragraphs
   Exit World                =   1 paragraph
                             = 211 paragraphs */

MODULE STRPTR as_pix[AS_ROOMS] =
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
  "as54",
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
  "as85", //  85
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
  "",
  "", // 115
  "",
  "",
  "",
  "",
  "", // 120
  "as121",
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
  "as134",
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
  "", // 155
  "",
  "",
  "",
  "",
  "", // 160
  "",
  "",
  "",
  "",
  "as165", // 165
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
  "as193",
  "",
  "", // 195
  "",
  "",
  "",
  "",
  "", // 200
  "",
  "",
  "",
  "",
  ""  // 210
};

MODULE FLAG                   fishable;
MODULE int                    as_whichmonster,
                              axe,
                              current,
                              extradelay,
                              shiptime,
                              shipdamage,
                              timeleft;

IMPORT FLAG                   inmatrix;
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
                              prevroom, room, module,
                              round,
                              spellchosen,
                              spelllevel,
                              spellpower;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void as_enterroom(void);
MODULE FLAG as_itemmatrix(void);
MODULE void as_buttonmatrix(void);
MODULE void as_travelmatrix(int from);
MODULE void as_wandering1(int chance);
MODULE void as_wandering2(int chance);
MODULE void as_disturbance(void);

EXPORT void as_preinit(void)
{   descs[MODULE_AS]   = as_desc;
    wanders[MODULE_AS] = as_wandertext;
}

EXPORT void as_init(void)
{   int i;

    exits     = &as_exits[0][0];
    enterroom = as_enterroom;
    for (i = 0; i < AS_ROOMS; i++)
    {   pix[i] = as_pix[i];
    }

    as_whichmonster = -1;
    shiptime   =
    shipdamage =
    extradelay = 0;
}

MODULE void as_enterroom(void)
{   int  clays,
         i,
         needed,
         result,
         target,
         tentacles;
    FLAG ok;

    switch (room)
    {
    case 0:
        as_whichmonster = -1;
    acase 2:
        if (saved(1, dex))
        {   room = 122;
        } else
        {   die();
        }
    acase 3:
        die();
    acase 4:
        savedrooms(1, iq, 113, 169);
    acase 5:
        result = getnumber("Buy how many", 0, money / 10000);
        pay_gp(100 * result);
        give_multi(397, result * 4);
    acase 7:
        savedrooms(2, (lk + dex) / 2, 62, 42);
    acase 9:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They do not recognize you as a human (or elf, dwarf, etc.) and will not deal with you. Take the skull of before they attack. There are so many of them that they would automatically win.\n");
            items[ITEM_AS_SKULL].inuse = FALSE;
        }
        if (!been[9])
        {   if     (ability[44].known && getyn("Cure scurvy"))
            {   lose_flag_ability(44);
            } elif (ability[50].known && getyn("Cure zombie infection"))
            {   lose_flag_ability(50);
            } elif (ability[51].known && getyn("Cure rabies"))
            {   lose_flag_ability(51);
            } elif (ability[53].known && getyn("Cure malaria"))
            {   lose_flag_ability(53);
            } elif (con < max_con)
            {   healall_con();
        }   }
        // %%: if you refuse all his healing, and then return later, should he offer again? We assume not (see ASp25).
    acase 10:
        do
        {   castspell(-1, FALSE);
        } while (spellchosen == SPELL_PP);
        if (spellchosen != -1)
        {   room = 176;
        } elif (!as_itemmatrix())
        {   room = 176;
        }
    acase 11:
        if (items[33].owned || items[340].owned)
        {   award(race == DWARF ? 200 : 100);
            room = 88;
        } else
        {   savedrooms(10, st, 41, 198);
        }
    acase 12:
        as_wandering1(1);
    acase 13:
        if (prevroom == 90)
        {   room = 65;
        } else
        {   give(398);
            give_multi(399, 4);
        }
    acase 14:
        savedrooms(1, iq, 185, 132);
    acase 15:
        as_wandering1(1);
    acase 16:
        if (items[397].owned <= 4) // %%: what if they don't have enough?
        {   dropitems(397, items[397].owned);
        } else
        {   dropitems(397, 4);
        }
        shiptime += 75;
        as_travelmatrix(FROM_VALEAT);
    acase 17:
        die();
    acase 18:
        if (saved(1, spd))
        {   room = 108;
        } else
        {   die();
        }
    acase 19:
        as_travelmatrix(FROM_KROAN);
    acase 21:
        if (!immune_poison())
        {   gain_flag_ability(46);
        }
        castspell(-1, TRUE);
    acase 23:
        result = getnumber("Buy how many", 0, money / 25000);
        pay_gp(250 * result);
        give_multi(400, result);
    acase 27:
        if (items[447].owned)
        {   room = 89;
        } else
        {   // assert(items[411].owned);
            room = 191;
        }
    acase 28:
        savedrooms(2, (st + iq) / 2, 68, 58);
    acase 30:
        as_wandering1(3);
    acase 31:
        as_buttonmatrix();
    acase 32:
        as_travelmatrix(FROM_ESDURT);
    acase 33:
        buy_spells(1, 10000);
        give_gp(7500);
        victory(7500);
    acase 34:
        as_travelmatrix(FROM_ESDURT);
    acase 35:
        die();
    acase 36:
        create_monster(189);
        castspell(-1, TRUE);
        fight();
        room = 86;
    acase 37:
        needed = 4;
        if (class == ROGUE)
        {   needed--;
        }
        if (race == WHITEHOBBIT)
        {   needed--;
        } elif (race == FAIRY || race == LEPRECHAUN)
        {   needed -= 2;
        }
        if (armour == PLA)
        {   needed++;
        }
        if (ability[47].known)
        {   needed++;
        }
        savedrooms(needed, lk, 20, 114);
    acase 38:
        if
        (   ( items[ITEM_AS_SKULL].inuse && saved(1, ((st + iq + lk + dex + spd) / 5)))
         || (!items[ITEM_AS_SKULL].inuse && saved(3, ((st + iq + lk + dex + spd) / 5)))
        )
        {   room = 108;
        } else
        {   die();
        }
    acase 40:
        gain_flag_ability(48);
        failmodule();
    acase 41:
        award(300);
    acase 42:
        die();
    acase 43:
        if (!saved(2, (lk + spd) / 2))
        {   room = 199;
        }
    acase 45:
        if (ability[44].known && getyn("Cure scurvy") && pay_gp(25))
        {   lose_flag_ability(44);
        }
        if (ability[50].known && getyn("Cure zombie infection") && pay_gp(25))
        {   lose_flag_ability(50);
        }
        if (ability[51].known && getyn("Cure rabies") && pay_gp(25))
        {   lose_flag_ability(51);
        }
        if (ability[53].known && getyn("Cure malaria") && pay_gp(25))
        {   lose_flag_ability(53);
        }
        if (con < max_con && getyn("Heal all CON") && pay_gp(25))
        {   healall_con();
        }
        as_travelmatrix(FROM_KELSA);
    acase 46:
        result = getnumber("Buy how many sets of 10", 0, money / 20000);
        pay_gp(200 * result);
        give_multi(403, 5 * result);
        give_multi(404, 5 * result);
    acase 47:
        if (items[397].owned <= 3) // %%: what if they don't have enough?
        {   dropitems(397, items[397].owned);
        } else
        {   dropitems(397, 3);
        }
        shiptime += 50;
        as_travelmatrix(FROM_VALEAT);
    acase 48:
        savedrooms(1, lk, 57, 3);
    acase 50:
        do
        {   while (castspell(-1, TRUE))
            {   as_wandering1(3);
            }
            while (room == 50 && getyn("Use an item"))
            {   if (!as_itemmatrix())
                {   as_wandering1(3);
            }   }
            if (room == 50 && getyn("Leave"))
            {   room = 81;
        }   }
        while (room == 50);
    acase 51:
        if (getyn("Wait (otherwise get out of armour)"))
        {   savedrooms(1, iq, 29, 158);
        } else
        {   dropitem(armour);
            armour = -1;
            room = 92;
        }
    acase 52:
        die();
    acase 53:
        as_buttonmatrix();
    acase 54:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  He automatically attacks. If you fight with the obsidian dagger, go to {206. If you fight with normal weapons, go to {36.\n");
        }
        if (items[401].owned && getyn("Fight with the obsidian dagger"))
        {   // we should really make them put it in their hand, but they are about to die anyway
            room = 206;
        } elif (items[ITEM_AS_SKULL].inuse)
        {   room = 36;
        }
    acase 55:
        savedrooms(2, lk, 163, 192);
    acase 56:
        as_buttonmatrix();
    acase 58:
        die();
    acase 61:
        as_wandering1(2);
    acase 63:
        // we award the experience at AK116
        give_multi(405, 25);
        give(406);
    acase 65:
        create_monsters(190, 2);
        fight();
        room = 118;
    acase 66:
        give(407);
    acase 67:
        as_travelmatrix(FROM_KROAN);
    acase 68:
        if (class == WIZARD)
        {   room = 33;
        } elif (class == WARRIOR)
        {   room = 95;
        } else
        {   room = 154;
        }
    acase 69:
        give_gp(50);
        give_multi(408, 2);
    acase 71:
        savedrooms(1, iq, 148, 115);
    acase 72:
        gain_flag_ability(49);
    acase 74:
        die();
    acase 75:
        result = dice(1);
        if (con <= result)
        {   room = 128;
        } else
        {   templose_con(result);
            as_buttonmatrix();
        }
    acase 76:
        result = getnumber("Buy how many", 0, money / 10000);
        pay_gp(100 * result);
        give_multi(409, result);
    acase 78:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They do not recognize you as a human (or elf, dwarf, etc.) and will not deal with you. Take the skull of before they attack. There are so many of them that they would automatically win.\n");
            items[ITEM_AS_SKULL].inuse = FALSE;
        }
        if (been[98])
        {   room = 98;
        } else
        {   if (items[396].owned)
            {   if (getyn("Give fish"))
                {   room = 98;
                } else
                {   room = 40;
            }   }
            else
            {   if (getyn("Sail around island (otherwise leave)"))
                {   as_wandering2(6);
                    room = 78;
                }
                as_travelmatrix(FROM_KELSA);
        }   }
    acase 79:
        encumbrance();
        give_multi(410, (st * 100) - carrying());
    acase 80:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  With more bones and appendages with gaps (ribs, spaces between leg bones, etc.) the creature can get a better hold of you. The saving roll is now third level. If you want to spend a turn taking off the skull, you may but the saving roll for that turn is fourth level.\n");
        }
        create_monsters(201, 4);
        tentacles = 4;
        do
        {   if (items[ITEM_AS_SKULL].inuse)
            {   if (getyn("Take off skull"))
                {   needed = 4;
                    items[ITEM_AS_SKULL].inuse = FALSE;
                } else
                {   needed = 3;
            }   }
            else
            {   needed = 2;
            }
            for (i = 1; i <= countfoes(); i++)
            {   if (!saved(needed, (lk + dex) / 2))
                {   die();
            }   }
            if (con >= 1)
            {   good_freeattack();
            }
            if (tentacles)
            {   create_monster(201);
                tentacles--;
        }   }
        while (countfoes());
        room = 138;
    acase 82:
        while (room == 82 && getyn("Use an item"))
        {   if (!as_itemmatrix())
            {   as_wandering1(4);
        }   }
        if (room == 82)
        {   room = 155;
        }
    acase 83:
        if (been[83])
        {   room = 127;
        } else
        {   if (saved(0, lk)) // this L0-SR is actually pointless
            {   if (saved(1, lk))
                {   if (saved(2, lk))
                    {   if (saved(3, lk))
                        {   if (saved(4, lk))
                            {   if (saved(5, lk))
                                {   room = 173; // 0
                                } else
                                {   room = 183; // 1
                            }   }
                            else
                            {   room = 164; // 2
                        }   }
                        else
                        {   room = 47; // 3
                    }   }
                    else
                    {   room = 16; // 4
                }   }
                else
                {   room = 204; // 5
            }   }
            else
            {   room = 204; // 5
        }   }
    acase 84:
        if (fishable)
        {   if (items[396].owned)
            {   result = getnumber("Spend how many fishes buying spells", 0, items[396].owned);
                if (result)
                {   dropitems(396, result);
                    buy_spells(3, result * 10);
        }   }   }
        buy_spells(2, money / 100);
        as_travelmatrix(FROM_KELSA);
    acase 85:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They will not let you wear the skull.\n");
            items[ITEM_AS_SKULL].inuse = FALSE;
        }
        savedrooms(3, (iq + lk + chr) / 3, 147, 111);
    acase 86:
        give(442);
        // obsidian dagger gets autolooted
        as_travelmatrix(FROM_ESDURT);
    acase 87:
        while (room == 87 && getyn("Use an item"))
        {   if (!as_itemmatrix() && !ability[54].known && !immune_poison() && !items[415].owned) // maybe we should make them wear the gloves
            {   gain_flag_ability(54);
        }   }
    acase 89:
        dropitem(411);
        give(440);
        give(441);
    acase 90:
        use(399);
        use(399);
        use(399);
        use(399);
        room = prevroom;
    acase 91:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They do not recognize you as a human (or elf, dwarf, etc.) and will not deal with you. Take the skull of before they attack. There are so many of them that they would automatically win.\n");
            items[ITEM_AS_SKULL].inuse = FALSE;
            dropitem(ITEM_AS_SKULL);
            give(413);
        }
        give(439);
        switch (class)
        {
        case WARRIOR:
            room = 123;
        acase WIZARD:
            room = 157;
        acase ROGUE:
           room = 106;
        acase WARRIORWIZARD:
            room = 146;
        }
    acase 92:
        create_monsters(197, 2);
        if (!castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_NEAR, SIZE_LARGE, TRUE)) // %%: adventure says 30 - DEX but that would only make sense if they were hobbit-sized and at pointblank range, 35 is more correct
            {   evil_takemissilehits(target);
        }   }
        fight();
    acase 93:
        as_wandering1(1);
    acase 94:
        give(ITEM_AS_SKULL);
    acase 96:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They do not recognize you as a human (or elf, dwarf, etc.) and will not deal with you. Take the skull of before they attack. There are so many of them that they would automatically win.\n");
            items[ITEM_AS_SKULL].inuse = FALSE;
        }
        result = getnumber(
"1) Magical fishing nets\n" \
"2) Magical clay\n" \
"3) 10 magic arrows\n" \
"4) Meat preserver\n" \
"5) Lickum & Stickum dagger\n" \
"6) Magic door knocker\n" \
"7) Fire extinguisher\n" \
"Buy what (0 for none)", 0, 7);
        switch (result)
        {
        case 1:
            room = 23;
        acase 2:
            room = 142;
        acase 3:
            room = 46;
        acase 4:
            room = 77;
        acase 5:
            room = 156;
        acase 6:
            room = 136;
        acase 7:
            room = 5;
        }
    acase 98:
        if (been[98])
        {   fishable = FALSE;
            if (been[191] == 1)
            {   give(411);
        }   }
        else
        {   fishable = TRUE;
            dropitem(398);
            give(411);
            give(412);
        }
        as_travelmatrix(FROM_KELSA);
    acase 101:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  You have no real flesh, therefore there is no chance of infection.\n");
        }
        create_monsters(191, 2);
        do
        {   oneround();
            if (!items[ITEM_AS_SKULL].inuse && good_damagetaken && !saved(2, con))
            {   gain_flag_ability(50);
        }   }
        while (con > 0 && countfoes());
        room = 193;
    acase 102:
        create_monster(192);
        fight();
        room = 186;
    acase 103:
        dropitem(axe);
        as_travelmatrix(FROM_KROAN);
    acase 104:
        if (items[ITEM_AS_SKULL].inuse)
        {   die();
        } else
        {   if (been[9])
            {   room = 207;
            } else
            {   room = 22;
        }   }
    acase 105:
        as_itemmatrix();
    acase 106:
        give(415);
        give(416);
        give(417);
        buy_spells(1, 7500);
        give_gp(15000);
        victory_level(15000);
    acase 109:
        create_monsters(193, 2); // %%: it doesn't say whether their armour is lootable; we assume so.
        result = con;
        do
        {   oneround();
            if (con == 1 || (result >= 6 && con >= 2 && con <= 5))
            // %%: if you started with a CON of 1 you would get automatically captured!
            {   room = 139;
            } elif (!countfoes())
            {   room = 162;
        }   }
        while (con >= 1 && room == 109);
    acase 110:
        die();
    acase 112:
        if (items[438].owned && getyn("Go above"))
        {   room = 177;
        }
    acase 114:
        create_monsters(194, 2);
        if (prevroom == 182)
        {   if (!castspell(-1, TRUE))
            {   if (shooting())
                {   target = gettarget();
                    if (target != -1 && shot(RANGE_NEAR, SIZE_SMALL, FALSE))
                    {   evil_takemissilehits(target);
        }   }   }   }
        fight();
        room = 120;
    acase 115:
        die();
    acase 116:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  Without flesh, there is less to dissolve. You now only have one turn to act correctly.\n");
        }
        if (as_itemmatrix())
        {   award(300);
        } elif (items[ITEM_AS_SKULL].inuse)
        {   die();
        } elif (as_itemmatrix())
        {   award(200);
        } else
        {   templose_con(4); // %%: we assume armour doesn't help for this
            if (as_itemmatrix())
            {   award(100);
            } else
            {   die();
        }   }
    acase 118:
        give_gp(50);
    acase 119:
        create_monster(195);
        fight();
        room = 66;
    acase 120:
        give_multi(446, 2);
    acase 121:
        elapse(30, TRUE);
        create_monster(196);
        good_freeattack();
        dispose_npcs(); // he will likely be dead anyway
        room = 80;
    acase 123:
        give(420);
        give(421);
        give_gp(15000);
        victory_level(15000);
    acase 124:
        give(422);
    acase 125:
        create_monsters(197, 2);
        if (!castspell(-1, TRUE))
        {   if (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_POINTBLANK, SIZE_SMALL, FALSE)) // %%: it specifically says it's a L3-SR (they must be small orcs?).
                {   evil_takemissilehits(target);
            }   }
            elif (getyn("Push lever"))
            {   room = 143;
        }   }
        if (room == 125)
        {   fight();
            room = 69;
        }
    acase 126:
        award(2000);
        shiptime = 0;
        shipdamage = 0;
        extradelay = 0;
        as_travelmatrix(FROM_CAVE);
    acase 127:
        if (!been[127])
        {   give(423);
        }
        as_travelmatrix(FROM_VALEAT);
    acase 128:
        if (been[128])
        {   die();
        } else
        {   healall_con();
            if (been[26])
            {   award(-4000);
                if (iq > 10)
                {   lose_iq(10);
                } else
                {   change_iq(1);
            }   }
            else
            {   award(-2000);
                if (iq > 5)
                {   lose_iq(5);
                } else
                {   change_iq(1);
            }   }
            room = 56;
        }
    acase 129:
        while (shop_buy(75, 'X') == EMPTY);
        as_travelmatrix(FROM_KELSA);
    acase 130:
        dropitem(401);
    acase 131:
        create_monsters(193, 2); // %%: it doesn't say whether their armour is lootable; we assume so.
        fight();
    acase 132:
    case 133:
        die();
    acase 135:
        savedrooms(2, iq, 49, 195);
    acase 136:
        result = getnumber("Buy how many", 0, money / 10000);
        pay_gp(100 * result);
        give_multi(424, result);
    acase 138:
        award(1500);
        give(425);
    acase 139:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They will not let you wear the skull.\n");
            items[ITEM_AS_SKULL].inuse = FALSE;
        }
        savedrooms(4, (iq + lk + chr) / 3, 111, 188);
    acase 140:
        if (getyn("Cut trunk"))
        {   listitems(TRUE, FALSE, 100, 100);
            ok = FALSE;
            do
            {   axe = getnumber("With which weapon (0 for none)", 0, ITEMS) - 1;
                if (axe == EMPTY)
                {   ok = TRUE;
                } elif (isweapon(axe) && items[axe].owned)
                {   room = 103;
                    ok = TRUE;
                } else
                {   aprintf("Not allowed!\n");
            }   }
            while (!ok);
        }
    acase 141:
        if (getyn("Wait"))
        {   savedrooms(1, iq, 44, 133);
        }
    acase 142:
        if (money < 2500)
        {   room = 96;
        } else
        {   pay_gp(25);
            clays = 1;
            while (clays)
            {   result = dice(1);
                switch (result)
                {
                case 1:
                    clays += 2;
                acase 2:
                    give(426);
                acase 3:
                    give(427);
                acase 4:
                    if (!immune_poison())
                    {   gain_flag_ability(52);
                    }
                acase 5:
                    give(428);
                acase 6:
                    give(429);
                }
                clays--;
            } while (clays);
        }
    acase 143:
        kill_npcs();
    acase 145:
        give(401);
        give(ITEM_AS_ROBE);
    acase 146:
        give(431);
        give_gp(15000);
        victory_level(15000);
    acase 147:
        award(300);
    acase 149:
        if ((armour >= PLA && armour <= RIN) || armour == 419)
        {   room = 51;
        } else
        {   room = 189;
        }
    acase 150:
        as_wandering1(4);
    acase 151:
        room = prevroom;
    acase 152:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They are puzzled and frightened, so naturally they attack. Go to {131.\n");
            room = 131;
        } elif (items[ITEM_AS_ROBE].inuse)
        {   room = 109;
        }
    acase 153:
        die();
    acase 154:
        buy_spells(1, 3000);
        if (class == WARRIORWIZARD)
        {   give(432);
        } elif (class == ROGUE)
        {   give(433);
            give(434);
        }
        give_gp(7500);
        victory(7500);
    acase 156:
        result = getnumber("Buy how many", 0, money / 27500);
        pay_gp(275 * result);
        give_multi(435, result);
    acase 157:
        buy_spells(1, 10000);
        give(ITEM_AS_SDELUXE);
        give_gp(15000);
        victory_level(15000);
    acase 158:
        die();
    acase 159:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  They do not recognize you as a human (or elf, dwarf, etc.) and will not deal with you. Take the skull of before they attack. There are so many of them that they would automatically win.\n");
            items[ITEM_AS_SKULL].inuse = FALSE;
        }
    acase 160:
        if (race == FAIRY || race == LEPRECHAUN || race == ELF)
        {   room = 38;
        } else
        {   needed = (weight / 10) / height; // %%: weight in weight units? or in pounds?
            if ((weight / 10) % height)
            {   needed++;
            }
            if (armour == PLA)
            {   needed++;
            }
            if (saved(needed, lk))
            {   room = 38;
            } else
            {   die();
        }   }
    acase 161:
        savedrooms(2, lk, 64, 17);
    acase 162:
        give_multi(437, 2);
    acase 164:
        if (items[397].owned <= 2) // %%: what if they don't have enough?
        {   dropitems(397, items[397].owned);
        } else
        {   dropitems(397, 2);
        }
        shiptime += 25;
        as_travelmatrix(FROM_VALEAT);
    acase 165:
        templose_con(1); // %%: does armour help?
        result = 2;
        do
        {   if (saved(3, dex))
            {   room = 13;
            } else
            {   templose_con(result++); // %%: does armour help?
        }   }
        while (con >= 1 && room == 165);
    acase 166:
        create_monsters(197, 2);
        if (!castspell(-1, TRUE))
        {   if (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_POINTBLANK, SIZE_SMALL, FALSE)) // %%: it specifically says it's a L3-SR (they must be small orcs?).
                {   evil_takemissilehits(target);
        }   }   }
        fight();
        room = 69;
    acase 167:
        if (items[ITEM_AS_ROBE].inuse)
        {   room = 54;
        } else
        {   room = 36;
        }
    acase 168:
        create_monster(202);
        if (!castspell(-1, TRUE))
        {   if (shooting() && shot(RANGE_NEAR, SIZE_LARGE, FALSE)) // %%: it specifically says it is a L4-SR even though it is really SIZE_HUGE
            {   evil_takemissilehits(0);
            }
            if (!castspell(-1, TRUE))
            {   if (shooting() && shot(RANGE_NEAR, SIZE_LARGE, FALSE)) // %%: it specifically says it is a L4-SR even though it is really SIZE_HUGE
                {   evil_takemissilehits(0);
        }   }   }
        fight();
        room = 79;
    acase 169:
        die();
    acase 170:
        gain_flag_ability(47);
        if (getyn("Cut trunk"))
        {   listitems(TRUE, FALSE, 100, 100);
            ok = FALSE;
            do
            {   axe = getnumber("With which weapon (0 for none)", 0, ITEMS) - 1;
                if (axe == EMPTY)
                {   ok = TRUE;
                } elif (isweapon(axe) && items[axe].owned)
                {   room = 103;
                    ok = TRUE;
                } else
                {   aprintf("Not allowed!\n");
            }   }
            while (!ok);
        }
    acase 171:
        as_travelmatrix(FROM_CAVE);
    acase 172:
        savedrooms(3, st, 124, 35);
    acase 173:
        as_travelmatrix(FROM_VALEAT);
    acase 174:
        as_wandering1(1);
    acase 175:
        as_buttonmatrix();
    acase 176:
        die();
    acase 179:
        castspell(-1, TRUE);
        if (room == 179)
        {   needed = 4;
            if (class == ROGUE)
            {   needed--;
            }
            if (race == WHITEHOBBIT || race == ELF)
            {   needed--;
            } elif (race == FAIRY || race == LEPRECHAUN)
            {   needed -= 2;
            }
            if (armour == PLA)
            {   needed += 2;
            } elif ((armour >= MAI && armour <= RIN) || armour == 419)
            {   needed++;
            }
            savedrooms(needed, (lk + dex) / 2, 145, 114);
        }
    acase 180:
        as_travelmatrix(FROM_ESDURT);
        if (room == 180)
        {   while (getyn("Use an item"))
            {   as_itemmatrix();
            }
            if (room == 180)
            {   room = 10;
        }   }
    acase 181:
        if (!pay_gp(25))
        {   do
            {   as_travelmatrix(3);
            } while (room == 181);
        }
    acase 183:
        if (items[397].owned) // %%: what if they don't have any?
        {   dropitem(397);
        }
        as_travelmatrix(FROM_VALEAT);
    acase 184:
        as_viewman();
        if (fishable)
        {   while ((shipdamage || shiptime) && items[396].owned && getyn("Fix 25 points for 1 load of fish"))
            {   dropitem(396);
                shipdamage -= 25;
                if (shipdamage < 0) shipdamage = 0;
                shiptime -= 25;
                if (shiptime < 0) shiptime = 0;
        }   }
        while ((shipdamage || shiptime) && maybespend(100, "Fix 25 points for 100 gp"))
        {   shipdamage -= 25;
            if (shipdamage < 0) shipdamage = 0;
            shiptime -= 25;
            if (shiptime < 0) shiptime = 0;
        }
        as_travelmatrix(FROM_KELSA);
    acase 186:
        award(250);
    acase 187:
        give(438);
    acase 188:
        if (getyn("Cut ropes (otherwise pull bonds)"))
        {   savedrooms(5, dex, 38, 52);
        } else
        {   savedrooms(5, st, 38, 52);
        }
    acase 190:
        savedrooms(2, dex, 70, 21);
    acase 191:
        dropitem(411);
    acase 192:
        die();
    acase 193:
        if (items[ITEM_AS_SKULL].inuse)
        {   aprintf("  No flesh full of nerves of heat-sensitive organs, so no saving roll needed.\n");
        }

        create_monster(203);

        if (!items[ITEM_AS_SKULL].inuse)
        {   if (armour == PLA)
            {   needed = 6;
            } elif (armour == MAI)
            {   needed = 4;
            } elif (armour >= LAM && armour <= RIN)
            {   needed = 3;
            } elif (armour == LEA)
            {   needed = 2;
            } else
            {   needed = 1;
            }
            if (!saved(needed, con))
            {   die();
        }   }
        if (!castspell(-1, TRUE))
        {   if (getyn("Remove armour"))
            {   armour = -1; // %%: maybe we should really "drop" (ie. destroy) it?
        }   }
        while (countfoes())
        {   if (!items[ITEM_AS_SKULL].inuse)
            {   if (armour == PLA)
                {   needed = 6;
                } elif (armour == MAI)
                {   needed = 4;
                } elif (armour >= LAM && armour <= RIN)
                {   needed = 3;
                } elif (armour == LEA)
                {   needed = 2;
                } else
                {   needed = 1;
                }
                if (!saved(needed, con))
                {   die();
            }   }
            oneround();
        }
        room = 121;
    acase 195:
        die();
    acase 196:
        create_monster(198);
        do
        {   if (!saved(1, lk))
            {   die();
            } else
            {   oneround();
        }   }
        while (con >= 1 && countfoes());
    acase 197:
        create_monster(199);
        ok = TRUE;
        if (saved(3, (lk + dex) / 2))
        {   do
            {   oneround();
                if (good_damagetaken >= 1) // %%: what does it mean by if you "are ever hit"
                {   ok = FALSE;
                    do
                    {   templose_con(con / 4); // %%: do they mean a quarter of your CON before being bitten, a quarter of your current CON, or a quarter of your maximum CON?
                        good_freeattack();
                    } while (con >= 1 && countfoes());
            }   }
            while (con >= 1 && countfoes());
        } else
        {   ok = FALSE;
            do
            {   templose_con(con / 4); // %%: do they mean a quarter of your CON before being bitten, a quarter of your current CON, or a quarter of your maximum CON?
                good_freeattack();
            } while (con >= 1 && countfoes());
        }
        if (!ok && !saved(5, con))
        {   gain_flag_ability(53);
        }
        as_travelmatrix(FROM_ESDURT);
    acase 198:
        castspell(-1, TRUE);
    acase 203:
        if ((armour >= PLA && armour <= RIN) || armour == 419)
        {   savedrooms(4, (lk + dex) / 2, 76, 115);
        } else
        {   savedrooms(3, (lk + dex) / 2, 76, 115);
        }
    acase 204:
        if (items[397].owned <= 8) // %%: what if they don't have enough?
        {   dropitems(397, items[397].owned);
        } else
        {   dropitems(397, 8);
        }
        shiptime += 100;
        as_travelmatrix(FROM_VALEAT);
    acase 206:
        savedrooms(1, lk, 130, 74);
    acase 207:
        ok = FALSE;
        for (i = 1; i <= 5; i++)
        {   if (as_itemmatrix())
            {   ok = TRUE;
                break;
        }   }
        if (!ok)
        {   die();
        }
    acase 208:
        while (getyn("Use an item"))
        {   if (as_itemmatrix())
            {   break;
            } else
            {   if
                (   ( ability[49].known && !saved(2, (iq + st + lk) / 3))
                 || (!ability[49].known && !saved(4, (iq + st + lk) / 3))
                )
                {   result = anydice(1, 7);
                    switch (result)
                    {
                    case 1:
                        permlose_st(1);
                    acase 2:
                        lose_iq(1);
                    acase 3:
                        lose_lk(1);
                    acase 4:
                        permlose_con(1);
                    acase 5:
                        lose_dex(1);
                    acase 6:
                        lose_chr(1);
                    acase 7:
                        lose_spd(1);
        }   }   }   }
        if (room == 208)
        {   room = 67;
        }
    acase 209:
        drop_all(); // %%: what exactly do they mean by "equipment"?
    acase 210:
        if (!maybespend(100, "Fix boat"))
        {   extradelay += 4;
}   }   }

MODULE FLAG as_itemmatrix(void)
{   int choice;

    choice = getnumber(
"0: None\n" \
"1: Ointment\n" \
"2: Amulet\n" \
"3: Snake\n" \
"4: Key\n" \
"5: Jajuk\n" \
"6: Red Liquid\n" \
"7: Staff\n" \
"Which item", 0, 7);
    // %%: do the items get used up?
    switch (choice)
    {
    case 1:
        if (items[423].owned)
        {   if (room == 208) { room = 104; return TRUE; }
        }
    acase 2:
        if (items[422].owned)
        {   if (room ==  50) { room =  94; return TRUE; }
        }
    acase 3:
        if (items[398].owned)
        {   if (room == 116) { room =  63; return TRUE; }
        }
    acase 4:
        if (items[406].owned)
        {   if (room ==  87) { room = 187; return TRUE; }
        }
    acase 5:
        if (items[411].owned)
        {   if (room == 207) { room =  27; return TRUE; }
        }
    acase 6:
        if (items[407].owned)
        {   if (room ==  82) { room = 200; return TRUE; }
        }
    acase 7:
        if (items[441].owned)
        {   if (room == 180 || room == 10) { room = 102; return TRUE; }
    }   }

    aprintf("Failed!\n");
    return FALSE;
}

MODULE void as_buttonmatrix(void)
{   TEXT letter;

    letter = getletter("ªRªed/ªBªlue/ªGªreen/ªYªellow/ªOªrange", "RBGYO", "Red", "Blue", "Green", "Yellow", "Orange", "", "", "", FALSE);
    // %%: it's ambiguous about what happens when it is called from AS75
    switch (letter)
    {
    case 'R':
        if (room ==  53) room =  31; else room = 75;
    case 'B':
        if (room ==  31) room = 105; else room = 75;
    case 'G':
        if (room ==  56 || room == 75) room = 175; else room = 75;
    case 'Y':
        if (room == 105) room =  91; else room = 75;
    case 'O':
        if (room == 175) room =  53; else room = 75;
}   }

MODULE void as_travelmatrix(int from)
{   int choice;

PERSIST const int traveltimes[8][8] = {
{ 0, 4, 1, 3, 4, 7, 7, 171 }, // cave
{ 4, 0, 4, 3, 3, 3, 4,  83 }, // Valeat
{ 1, 4, 0, 4, 4, 7, 8, 202 }, // Freegore
{ 3, 3, 4, 0, 6, 6, 5, 181 }, // Alscen
{ 4, 3, 4, 5, 0, 4, 6,  78 }, // Kelsa
{ 7, 3, 7, 6, 7, 0, 4,  34 }, // Esdurt
{ 7, 4, 8, 5, 6, 4, 0,  67 }, // Kroan
{12,10,11,13, 8, 8, 7,  40 }  // Exit World
};

    choice = getnumber(
"0: Stay here\n" \
"1: Cave (171)\n" \
"2: Valeat (83)\n" \
"3: Freegore (202)\n" \
"4: Alscen (181)\n" \
"5: Kelsa (78)\n" \
"6: Esdurt (34)\n" \
"7: Kroan (67)\n" \
"8: Exit World (40)\n" \
"Which destination", 0, 8);
    if (choice == 0 || choice == from + 1)
    {   return;
    }

    timeleft =   traveltimes[choice][from]
             + ((traveltimes[choice][from] * shiptime) / 100)
             +   extradelay;
    current = timeleft / 4;

    while (timeleft >= 1)
    {   thewait(ONE_DAY / 2);
        as_wandering2(1);
        timeleft--;
    }

    room = traveltimes[choice][7];
}

MODULE void as_wandering1(int chance)
{   if (dice(1) > chance)
    {   return;
    }

    as_whichmonster = dice(1) - 1; // 0..5
    aprintf("%s\n", as_wandertext[as_whichmonster]);

    switch (as_whichmonster)
    {
    case 1 - 1:
        create_monsters(185, anydice(1, 3) + 3);
        fight();
    acase 2 - 1:
        create_monsters(186, 2);
        fight();
    acase 3 - 1:
        as_disturbance();
    acase 4 - 1:
        if (!saved(4, (dex + lk) / 2))
        {   good_takehits(20, TRUE);
        }
    acase 5 - 1:
        create_monster(187);
        fight();
    acase 6 - 1:
        create_monster(188);
        fight();
    }

    as_whichmonster = -1;
}

MODULE void as_wandering2(int chance)
{   int foes,
        i,
        limit,
        result;

    if (dice(1) > chance)
    {   return;
    }

    as_whichmonster = dice(2) + 4; // 6..16
    aprintf("%s\n", as_wandertext[as_whichmonster]);

    switch (as_whichmonster)
    {
    case 2 + 4:
        result = dice(2);
        timeleft += result * 2;
        shipdamage += (result / 2) * 10;
        shiptime += (result / 2) * 10;
        if (shipdamage >= 100)
        {   die();
        }
    acase 3 + 4:
    case 7 + 4:
    case 10 + 4:
        if (items[396].owned < items[400].owned * 2 && saved(2, dex))
        {   give(396);
        }
    acase 4 + 4:
        if (!saved(3, iq))
        {   result = misseditby(3, iq) * 10;
            shipdamage += result;
            shiptime   += result;
            if (shipdamage >= 100)
            {   die();
        }   }
    acase 5 + 4:
        if (ability[44].known)
        {   lose_flag_ability(44);
        } else
        {   gain_flag_ability(45);
        } // %%: maybe we should be allowed to take fruit away?
    acase 6 + 4:
        timeleft -= current; // %%: does it mean from the total voyage? or just the remainder of the voyage? We assume the total voyage.
    acase 8 + 4:
        while (shop_buy(110, 'X') != -1);
        if (ability[44].known && getyn("Cure scurvy") && pay_gp(300))
        {   lose_flag_ability(44);
        }
        if (ability[50].known && getyn("Cure zombie infection") && pay_gp(300))
        {   lose_flag_ability(50);
        }
        if (ability[51].known && getyn("Cure rabies") && pay_gp(300))
        {   lose_flag_ability(51);
        }
        if (ability[53].known && getyn("Cure malaria") && pay_gp(300))
        {   lose_flag_ability(53);
        }
        if (ability[46].known && getyn("Cure creature poison") && pay_gp(300))
        {   lose_flag_ability(46);
        }
        if (ability[52].known && getyn("Cure clay poison") && pay_gp(300))
        {   lose_flag_ability(52);
        }
        if (ability[54].known && getyn("Cure needle poison") && pay_gp(300))
        {   lose_flag_ability(54);
        }
        if (money < (max_con - con) * 2500)
        {   limit = money / 2500;
        } else
        {   limit = max_con - con;
        }
        if (limit >= 1)
        {   result = getnumber("Heal how many CON", 0, limit);
            pay_gp(result * 25);
            heal_con(result);
        }
    acase 9 + 4:
        if (getyn("Open chest"))
        {   if (!saved(3, lk))
            {   if (items[397].owned)
                {   dropitem(397);
                    shipdamage += 10;
                } else
                {   shipdamage += 50;
            }   }
            result = dice(1);
            switch (result)
            {
            case 1:
                give(443);
            acase 2:
            case 3:
            case 4:
                give(444);
            acase 5:
            case 6:
                give(373);
                give(374);
                give(376);
        }   }
    acase 11 + 4:
        create_monsters(200, 10);
        for (i = 1; i <= 10; i++)
        {   good_freeattack();
            if (!countfoes())
            {   break;
        }   }
        foes = countfoes();
        if (foes)
        {   for (i = 1; i <= foes; i++)
            {   pay_gp(100);
                award(-25);
        }   }

        give_multi(445, 10 - foes);
        award(75 * (10 - foes));
    acase 12 + 4:
        if (!ability[45].known)
        {   gain_flag_ability(44);
    }   }

    as_whichmonster = -1;
}

MODULE void as_disturbance(void)
{   int i;

    for (i = 0; i < SPELLS; i++)
    {   if (spell[i].known)
        {   if (saved(spell[i].level, iq))
            {   aprintf("Remembered %s.\n", spell[i].corginame);
                award(spell[i].level * 20);
            } else
            {   aprintf("Forgot %s.\n", spell[i].corginame);
                spell[i].known = FALSE;
}   }   }   }

#define is ==
#define or ||

EXPORT void as_magicmatrix(void)
{   aprintf(
"`MAGIC MATRIX\n" \
"  When using the Magic matrix, cross-index down from the spell name (at the top of the table) to the paragraph number that sent you here (along the left side) and read your result. Even if a spell does not work, the spellcaster still loses Strength for *trying* to cast it.\n~"
    );

    if (as_whichmonster is 15) // R2,11
    {   if (spell[spellchosen].combat)
        {   fulleffect();
        } else
        {   noeffect();
        }
        return;
    }

    inmatrix = TRUE;

    switch (spellchosen)
    {
    case SPELL_TF:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   fulleffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 116
         or room is 179
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 102
         or room is 114
         or room is 119
         or room is 121
         or room is 125
         or room is 166
         or room is 182
         or room is 193
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
         or room is 168
        )
        {   thresholdeffect();
        }
    acase SPELL_KK:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif (room is 50)
        {   aprintf("The lock sends out a charge of magical/electrical energy which does 2 dice worth of damage directly off your CON. In addition, roll a die. If you roll a one, a magical disturbance has hit you. See item 3 on Random Encounter Table #1. The door remains locked.\n");
            templose_con(dice(2));
            if (dice(1) == 1)
            {   as_disturbance();
        }   }
        else
        {   noeffect();
        }
    acase SPELL_VB:
    case SPELL_EH:
    case SPELL_DE:
    case SPELL_DD:
    case SPELL_ZA:
    case SPELL_ZP:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   fulleffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 116
         or room is 179
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 102
         or room is 114
         or room is 119
         or room is 121
         or room is 125
         or room is 166
         or room is 182
         or room is 193
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
         or room is 168
        )
        {   thresholdeffect();
        }
    acase SPELL_PA:
        if (as_whichmonster is 0) // R1,1
        {   fulleffect();
        } elif
        (   as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 65
         or room is 80
         or room is 101
         or room is 102
         or room is 109
         or room is 116
         or room is 121
         or room is 131 // "#" (misprint) in Corgi version but hollow square (no effect) in FB version
         or room is 168 // "#" (misprint) in Corgi version but hollow square (no effect) in FB version
         or room is 179
         or room is 193
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 92
         or room is 114
         or room is 119
         or room is 125
         or room is 166
         or room is 182
         or room is 196
         or room is 197
        )
        {   fulleffect();
        }
    acase SPELL_CC:
        if (as_whichmonster is 0) // R1,1
        {   fulleffect();
        } elif
        (   as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 65
         or room is 80
         or room is 101
         or room is 102
         or room is 116
         or room is 121
         or room is 193
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 92
         or room is 114
         or room is 119
         or room is 125
         or room is 166
         or room is 182
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
         or room is 168
        )
        {   thresholdeffect();
        } elif (room is 179)
        {   aprintf("You automatically make the roll. Go to {145}.\n");
            room = 145;
        }
    acase SPELL_RS:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   fulleffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 109 // "#" (misprint) in Corgi version but hollow square (no effect) in FB version
         or room is 116
         or room is 131 // "#" (misprint) in Corgi version but hollow square (no effect) in FB version
         or room is 168 // "#" (misprint) in Corgi version but hollow square (no effect) in FB version
         or room is 179
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 102
         or room is 114
         or room is 119
         or room is 121
         or room is 125
         or room is 166
         or room is 182
         or room is 193
         or room is 196
         or room is 197
        )
        {   fulleffect();
        }
    acase SPELL_BM:
    case SPELL_RH:
        if (as_whichmonster is 0) // R1,1
        {   noeffect();
        } elif
        (   as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   aprintf("The monster you are fighting soaks into the ground with its treasure.\n");
            dispose_npcs();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 92
         or room is 102
         or room is 109
         or room is 116
         or room is 119
         or room is 125
         or room is 131
         or room is 166
         or room is 168
         or room is 179
         or room is 196
         or room is 197
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 114
         or room is 182
        )
        {   fulleffect();
        } elif (room is 65)
        {   aprintf("The monster you are fighting soaks into the ground with its treasure.\n");
            dispose_npcs();
        } elif
        (   room is 80
         or room is 101
         or room is 121
         or room is 193
        )
        {   aprintf("Whatever monster you are fighting absorbs into the ground. In addition, the mouth cries for mercy. It says that if you stop the process (ie. cast a Hard Stuff), he will tell you the clue. If you do not or cannot cast the spell, leave the room and go to {155. If you do, take [500 ap for each battle you fought inclusive and an extra] 500 ap for good thinkin and go to {26.\n");
            kill_npcs();
            if (cast(SPELL_HA, FALSE))
            {   award(500);
                room = 26;
            } else
            {   room = 155;
        }   }
        elif (room is 198)
        {   aprintf("The stone melts. You may now enter the mountain by going to {88}.\n");
            room = 88;
        }
    acase SPELL_DW:
        if (as_whichmonster is 0) // R1,1
        {   fulleffect();
        } elif
        (   as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 65
         or room is 80
         or room is 101
         or room is 102
         or room is 116
         or room is 119
         or room is 121
         or room is 168
         or room is 179
         or room is 193
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 92
         or room is 114
         or room is 125
         or room is 166
         or room is 182
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
        )
        {   thresholdeffect();
        }
    acase SPELL_BP:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   fulleffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 102
         or room is 116
         or room is 179
         or room is 193
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 114
         or room is 121
         or room is 125
         or room is 166
         or room is 182
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
         or room is 168
        )
        {   thresholdeffect();
        } elif (room is 119)
        {   doubleeffect();
        }
    acase SPELL_IF:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   fulleffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 116
         or room is 179
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 102
         or room is 114
         or room is 121
         or room is 125
         or room is 166
         or room is 182
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
         or room is 168
        )
        {   thresholdeffect();
        } elif (room is 119)
        {   halfeffect();
        } elif (room is 193)
        {   doubleeffect();
        }
    acase SPELL_HF:
        if (as_whichmonster is 0) // R1,1
        {   triplecost();
        } elif (as_whichmonster is 4) // R1,5
        {   doublecost();
        } elif
        (   as_whichmonster is 1 // R1,2
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif
        (   room is 10
         or room is 21
         or room is 36
         or room is 38
         or room is 50
         or room is 65
         or room is 80
         or room is 92
         or room is 102
         or room is 109
         or room is 114
         or room is 116
         or room is 119
         or room is 121
         or room is 125
         or room is 131
         or room is 166
         or room is 168
         or room is 179
         or room is 182
         or room is 193
         or room is 196
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 101
        )
        {   doublecost();
        } elif
        (   room is 197
        )
        {   triplecost();
        }
    acase SPELL_TT:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif
        (   room is 10
         or room is 36
         or room is 38
         or room is 50
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 102
         or room is 109
         or room is 114
         or room is 116
         or room is 119
         or room is 121
         or room is 125
         or room is 131
         or room is 166
         or room is 168
         or room is 179
         or room is 182
         or room is 193
         or room is 196
         or room is 197
         or room is 198
        )
        {   noeffect();
        } elif (room is 21)
        {   doublecost();
        }
    acase SPELL_SG:
        if (as_whichmonster is 0) // R1,1
        {   fulleffect();
        } elif
        (   as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif
        (   room is 10
         or room is 21
         or room is 38
         or room is 50
         or room is 65
         or room is 80
         or room is 101
         or room is 102
         or room is 116
         or room is 121
         or room is 179
         or room is 193
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 92
         or room is 114
         or room is 119
         or room is 125
         or room is 166
         or room is 182
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 168
         or room is 131
        )
        {   thresholdeffect();
        }
    acase SPELL_UP:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   noeffect();
        } elif
        (   room is 10
         or room is 21
         or room is 36
         or room is 38
         or room is 50
         or room is 65
         or room is 92
         or room is 101
         or room is 102
         or room is 109
         or room is 114
         or room is 119
         or room is 121
         or room is 125
         or room is 131
         or room is 166
         or room is 168
         or room is 179
         or room is 182
         or room is 193
         or room is 197
         or room is 198
        )
        {   noeffect();
        } elif (room is 80 or room is 116)
        {   aprintf("You have successfully levitated above the acid for the duration of its effects. Take an extra 200 ap and go to {63}.\n");
            award(200);
            room = 63;
        } elif (room is 196)
        {   aprintf("You levitate for a few inches. [No need to make a saving roll for as long as the spell lasts.]\n");
        }
    acase SPELL_PP:
        if (as_whichmonster is 0) // R1,1
        {   noeffect();
        } elif
        (   as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   fulleffect();
        } elif
        (   room is 21
         or room is 38
         or room is 50
         or room is 116
         or room is 119
         or room is 179
         or room is 196
         or room is 197
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 102
         or room is 114
         or room is 121
         or room is 125
         or room is 166
         or room is 182
         or room is 193
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
         or room is 168
        )
        {   thresholdeffect();
        } elif (room is 10)
        {   fulleffect();
            aprintf("You have until the spell wears out to decide which item or spell to choose.\n");
            elapse(20, TRUE);
        }
    acase SPELL_SF:
        if
        (   as_whichmonster is 0 // R1,1
         or as_whichmonster is 1 // R1,2
         or as_whichmonster is 4 // R1,5
         or as_whichmonster is 5 // R1,6
        )
        {   fulleffect();
        } elif
        (   room is 10
         or room is 21
         or room is 50
         or room is 116
         or room is 179
         or room is 198
        )
        {   noeffect();
        } elif
        (   room is 36
         or room is 38
         or room is 65
         or room is 80
         or room is 92
         or room is 101
         or room is 102
         or room is 114
         or room is 119
         or room is 121
         or room is 125
         or room is 166
         or room is 182
         or room is 193
         or room is 196
         or room is 197
        )
        {   fulleffect();
        } elif
        (   room is 109
         or room is 131
         or room is 168
        )
        {   thresholdeffect();
        }
    adefault:
        noeffect();
    }

    inmatrix = FALSE;
}

EXPORT void as_viewman(void)
{   aprintf("³Ship damage: ²%d points\n", shipdamage);
    aprintf("³Ship delay:  ²%d points", shiptime);
    if (extradelay)
    {   aprintf(" + %d days", extradelay / 2);
    }
    aprintf("\n");
}
