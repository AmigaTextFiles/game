#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Errata:
WW161 says "...go to 95, ignoring the note about the east door", but there is no such note at WW95.
WW63/12C: "If you drink it, go to 29D" should read "If you drink it, go to 29B."
*/

MODULE const STRPTR ww_desc[WW_ROOMS] = {
{ // 0
"Welcome to the Madhouse of Maximilian the Magnificent, commonly known as Weirdworld. The Madhouse is a large construction of granite, about 100' on a side and maybe 20' tall. The granite is polished smooth on the outside (but who knows what lies on the inside?).\n" \
"  [The admission is 10% of whatever you bring back in treasure, or one magical item. If you refuse to pay this, the owner of Weirdworld, none other than Maximilian the Magnificent himself, will become quite upset. For your own safety, find some treasure and make sure you pay him.\n" \
"  ]There is also a sign at the entrance that says, \"Fighters Only\". Max, who is at the stand nearby, says that he will not allow magic-users or rogues to enter. If you are a fighter, you may go right on in. Go to {1}. If you are not, he offers to change you into one. If you attack him, go to {131}. If you let him change you into a fighter, go to {130}.\n" \
"  Good luck!"
},
{ // 1/2A
"As you enter the room, a massive stone block seals off the entrance. You cannot leave the way you entered. Before you are two swords, a battleaxe, a shield, a skull, a spear, a pile of bones, and a chest. A voice from out of nowhere says, \"If you wish, you make take any one thing, then leave.\" If you wish to leave by the west corridor, go to {20}. If you wish to take an item, write down which one you wish to take, and go to {45}."
},
{ // 2/2B
"You have entered a room that contains a creature that is about 8' tall, with appendages as thick as tree trunks. It has two arms and two legs and appears to be made totally of gems and jewellery, gold and silver, but mostly of platinum. He looks at you and says, \"Hello.\" If you try to talk to him, go to {11}. If you just stand there, go to {65}. If you attack him, go to {41}. If you want to exit, go to {82}."
},
{ // 3/2C
"You are dead.[ If you wish to use the same character again, go to {142}. If this is the fifth time you have gone in, go to {139}.]"
},
{ // 4/2D
"The eye turns and stares straight into your eyes. If you stare back, go to {23}. If you avert your glance, go to {35}."
},
{ // 5/2E
"He notices you, and his hand moves to a lever. He then says, \"I wouldn't do that if I were you.\" If you attack him, go to {24}. If you pay the toll, go to {12}. If you try to rush across the bridge, go to {18}. If you go back the way you came, go to {161}."
},
{ // 6/2F
"You have survived Weirdworld by means of exceptional skill and bravery. You get 5,000 experience points. Good show!]\n" \
"  Time to pay the admission charge (10% of the treasure you have won, or one magical item. Maximilian the Magnificent can make change, if necessary.) If you pay, fine. If not, go to {131}. If you have nothing to pay him with, you become his slave forever. Too bad...]"
},
{ // 7/3A
"He pulls off one of his hands and tosses it to you. Another appears in its place, and he laughs and disappears. The hand is next to you. If you pick it up, go to {28}. If you don't, go to {85}."
},
{ // 8/3B
"He has worn the eraser down to uselessness. However, you may use the pencil to \"draw\" your Constitution back up to the level it was at before this fight. You get 500 experience points. You must now go back to the north door, and leave through it, since the corridor dead-ends. Go to {50}."
},
{ // 9/3C
"Halfway down the corridor, you notice three lights in a vertical pattern. The middle one is yellow, the other two are off. If you continue east, go to {97}. If you go back, go to {80}. If you just stand there, go to {86}."
},
{ // 10/3D
"While using the facilities, you felt something warm and squishy come out of the toilet bowl. You felt some of your flesh turn warm and squishy also, but you felt no pain. Go to {141}."
},
{ // 11/3E
"All he appears to be able to say is \"Hello\". Go to {65}."
},
{ // 12/3F
"He accepts it. When you have walked about 50', you enter a mist, and then black out. Go to {159}."
},
{ // 13/4A
"You get dizzy, and then black out for a second or two. When you come to, you are in a large amphitheatre-like room. About 100 or so oddly-dressed people are sitting around you, and there is an audience of roughly 600 seated behind you. A rather well-dressed fellow is asking you whether you want what is in the box next you, or what is in the box on the stage, or what's behind the curtain. If you want the box next to you, go to {99}. If you want the box on the stage, go to {70}. If you want the curtain, go to {147}. If you want to charge out the exit, go to {55}. If you just start attacking everything in sight, go to {52}."
},
{ // 14/4B
"The machine explodes, giving you five dice of damage. If you die, go to {3}. If you are still alive, you may leave by the north door (go to {50}) or the north corridor (go to {81})."
},
{ // 15/4C
"Make your third level saving roll on Luck (30 - LK). If you make it, go to {47}. If you miss it, go to {32}."
},
{ // 16/4D
"This is the room with the large pit in it. There are five exits: the north door (go to {157}), the east door (go to {160}), the right-hand west door (go to {107}), the centre west door (go to {87}), and the left-hand west door (go to {73})."
},
{ // 17/4E
"You are at the end of the corridor, and there is a door on the north wall. If you go through the door, go to {159}. If you go east down the corridor, go to {80}."
},
{ // 18/4F
"He pulls the lever and you are flipped into the lake, where you are set upon by a school of piranha. Go to {3}."
},
{ // 19/5A
"You are in a corridor that runs east and west, and there is a door on the north wall. If you go east, go to {91}. West, go to {111}. If this is the first time you have tried the door on the north wall, go to {13}. Otherwise, go to {53}."
},
{ // 20/5B
"The corridor shuts behind you, and you have entered a room that has a myriad assortment of tubes, glassware, chemicals, bunsen burners, beakers, etc., on a large table. You see a glass into which a liquid from this complex machine is dripping. If you wish to leave by the north door, go to {50}. If you wish to leave by the north corridor, go to {81}. If you smash the machine to pieces, go to {68}. If you drink the liquid that it is making, go to {39}."
},
{ // 21/5C
"This sword has no blade. If you wish to throw it away, and attack the rotten machine, go to {67}. If you check it more closely, go to {46}. If you try again, go to {37}. If you leave it, go to {115}."
},
{ // 22/5D
"Make your third level saving roll on Luck (30 - LK). If you don't make it, go to {10}. If you make it, go to {141}."
},
{ // 23/5E
"You appear to have started a staredown. Make your first level saving roll on Luck (20 - LK). If you make it, you have won the staredown. Go to {38}. If you didn't make it, go to {35}."
},
{ // 24/5F
"His hand moves to a lever and he says, \"Stop, if you value your life!\" If you attack him anyway, go to {18}. If you pay the toll, go to {12}. If you go back the way you came, go to {161}."
},
{ // 25/6A
"You are in a hall-like room, and there is a gunfighter at the other end who tells you to draw. If you do, go to {146}. If you don't, go to {106}."
},
{ // 26/6B
"The item rusts to flakes in your hands, and everything else disappears. You must leave by the west corridor. Go to {20}."
},
{ // 27/6C
"The monsters start up again and trample you to a slime. Go to {3}."
},
{ // 28/6D
"[The hand has the ability to let you teleport out whenever you want. It works only once. Unless you plan to use it, ]go to {85}."
},
{ // 29/6E
"You may paddle over to the east door and through it or go through the south door by paddling to it. East door, go to {152}. South door, go to {17}."
},
{ // 30/6F
"To check the results of your opening of the tome of Max, simply turn at random to any one page past this one, and read the F paragraph. ({36}, {42}, {48}, {54}, {60}, {66}, {72}, {78}, {84}, {90}, {96}, {102}, {108}, {114}, {120}, {126}, {132}, {138}, {144}, {150}, {156}, {162} or {168}). Good luck! You'll need it!"
},
{ // 31/7A
"You have been engulfed in a mass of molten lava. We told you to keep out! Go to {3}."
},
{ // 32/7B
"You were swallowed by something *big*. We told you to stay away! Go to {3}."
},
{ // 33/7C
"The skull says, \"Hello there! My name is Fred the Head! I want to be your friend!\" If you want to throw this loudmouth away, go to {62}. If you keep him, go to {57}."
},
{ // 34/7D
"Sure enough, it is a sparkling clean bathroom. After checking it out, you are certain that there are no traps. If you came here from paragraph {40}, go to {22}. Otherwise, go to {141}."
},
{ // 35/7E
"Sorry, kid, you were just turned to stone. Such a shame. Close this book."
},
{ // 36/7F
"You get a bag containing 100 gold pieces. You must leave. Go to {6}."
},
{ // 37/8A
"Here are the prices:\n" \
"    Sword - 10 gold pieces (go to {21})\n" \
"    Battleaxe - 20 gold pieces (go to {51})\n" \
"    Spear - 25 gold pieces (go to {56})\n" \
"    Mace - 30 gold pieces (go to {43})\n" \
"    Dagger - free (go to {69})\n" \
"Also, roll one die. If you roll a one, go to {145} instead. If this is not the first time this adventure that you have used it, go to {145}."
},
{ // 38/8B
"You felt a horrible sensation in your left eye, and with your other eye you can see your left eye floating toward the large eye. You are then paralyzed. The large eye becomes an exact replica of your left eye, and then grafts itself in place of your left eye. Your old eye disappears. The new one is no different in appearance but it can see in the dark, and also through walls less than 10' thick. It can also see within a mile of you all around and negates all surprise. There are no other exits from this room. Go back to {77}."
},
{ // 39/8C
"You have become drunk. Add two to your Strength, but subtract two from your IQ and Dexterity. Now leave by the north door (go to {50}) or the north corridor (go to {81}). The apparatus, otherwise known as a still, disappears. Sober up when you leave Weirdworld - Max does not administer the breathalyzer test."
},
{ // 40/8D
"You just drank a very strong and much faster laxative. If you wish to use the bathroom, go to {34}. If you don't, go to {113}."
},
{ // 41/8E
"He just grabbed you. No matter how hard you tried or what you did, he ate everything you had, including weapons, armour, clothing, and treasure. He says, \"Thank you,\" and tosses you unharmed through the north door. Go to {125}."
},
{ // 42/8F
"You have just awakened the guard of the Tome of Max - a small red dragon with a Monster Rating of 200. He has a bad sore throat, so he doesn't use his breath weapon, and therefore can be treated as any other monster. If he kills you, go to {3}. If you kill him, add 500 to your experience and leave Weirdworld. Go to {6}."
},
{ // 43/9A
"The mace attacks normally[, but every time it hits, the victim must make his first level saving roll on Luck (20 - LK). If he misses it, he is paralysed]. You may now attack the machine (go to {67}), try again (go to {37}), or leave (go to {115})."
},
{ // 44/9B
"Make your first level saving roll on Dexterity (20 - DEX). If you make it, you bounce back from the charging monsters and take two hits (go to {105}). If you missed, you were trampled to a pulp (go to {3}). If the two hits kill you, go to {3} anyway."
},
{ // 45/9C
"If you wrote down anything but \"the skull\", go to {26}. If you chose the skull, go to {33}."
},
{ // 46/9D
"You find a small button on the hilt. If you press it, go to {49}. If not, go back to {21} and try something else."
},
{ // 47/9E
"You just missed being swallowed by a very large worm. In any case, you must fight him. His abilities are:\n" \
"    Strength     -  45\n" \
"    IQ           -   2\n" \
"    Luck         -  12\n" \
"    Constitution - 100\n" \
"    Dexterity    -   8\n" \
"    Charisma     -  -2\n" \
"Every turn, make your L1-SR on Dexterity (20 - DEX). If you fail, you were swallowed, and he will eventually digest you. Go to {3}. If you kill him, go to {110}.[ He causes no other danger in combat other than swallowing, but defends with his 32 adds.]"
},
{ // 48/9F
"You have received a magical amulet. This amulet can guard against all magical attacks *or* non-magical attacks - not both at once. You must now leave. Go to {6}."
},
{ // 49/10A
"A beam of energy about 3' long leaps from the hilt. You now possess a light-sabre. It is like a normal sword, but it causes two dice of damage above and beyond the normal combat results, regardless of what they are. If you try again, go to {37}. If you attack the machine, go to {67}. If you leave, go to {115}."
},
{ // 50/10B
"You are in a corridor that runs east and west. There is a door in the south wall. If you go west, go to {104}. If you go east, go to {111}. If you go through the door, go to {88}."
},
{ // 51/10C
"This battleaxe is normal, gets 4 dice, and you must have a Strength of 15 to use it without tiring. You got a good deal on it anyway. If you try again, go to {37}. If you attack the machine, go to {67}. If you wish to leave, go to {115}."
},
{ // 52/10D
"The whole group is defenceless and in panic. Roll one die to see how many you kill per turn. After each turn, roll one die. If you roll a six, go to {123}. Whenever you think you have killed enough, you may charge to an exit. Go to {55}."
},
{ // 53/10E
"It doesn't open. Go back to where you were."
},
{ // 54/10F
"You receive a magical foldbox. [It opens to a maximum of 10x10x10' and can hold within it anything that will fit. It can then be folded up to the size of a briefcase and carried like one. Regardless of what is placed within it, it always weighs 100 gold pieces in its folded condition. In this condition, anything within the box will not be harmed - and the foldbox cannot be harmed from within. ]You must leave. Go to {6}."
},
{ // 55/11A
"After knocking down a dozen or so people, you reach an exit. When you go through it, you black out again. When you come to, you are back outside the door that led you to this adventure. If you killed anyone, you now get ten experience points for every person you killed. Go to {19}."
},
{ // 56/11B
"[The spear is magically poisoned and causes twice the damage delivered in the melee. ]If you try again, go to {37}. If you attack the machine, go to {67}. If you leave, go to {115}."
},
{ // 57/11C
"You must now leave by the west corridor. Go to {20}. [Also, if you are ever attacked while you have Fred, go to {149}. ]Fred weighs 50 weight units."
},
{ // 58/11D
"He and his gun disappear, and your gun turns to solid gold, making it worth 500 gold pieces. You also get 400 experience points. You must now leave the way you came. Go to {91}."
},
{ // 59/11E
"It doesn't open. Go back to where you were ({157})."
},
{ // 60/11F
"You have been teleported to Deathtrap Equalizer. If you don't own it, go to {168}."
},
{ // 61/12A
"You hear footsteps above you, and you see torchlight. An old man in robes leans over the edge of the pit and asks you if you need a hand. If you say yes, go to {7}. If you say no, go to {79}."
},
{ // 62/12B
"Make your second level saving roll on Dexterity (25 - DEX). If you fail, roll the difference in dice and subtract it from your Constitution - Fred can spit his teeth with the same effect as arrows. If this kills you, go to {3}. If it doesn't or you make your saving roll, you had better leave by the west corridor - fast! Go to {20}."
},
{ // 63/12C
"Good move! The string was connected to a draining cork in the bottom of the boat. The fog lifts, and you see an open jar in the boat containing a strange liquid. If you drink it, go to {164}. If not, go to {29}."
},
{ // 64/12D
"Make your second level saving roll on Luck (25 - LK). If you make it, go to {166}. If you don't, go to {154}."
},
{ // 65/12E
"He starts to walk towards you. If you wish to exit, go to {82}. If you stand there, go to {41}."
},
{ // 66/12F
"You have been teleported to Buffalo Castle. If you don't have it, go to {168}."
},
{ // 67/13A
"The machine disappears. It is not as dumb as it looks. Go to {115}."
},
{ // 68/13B
"Make your first level saving roll on Luck (20 - LK). If you succeed, the machine is destroyed, and you may leave by the north door. Go to {50}. Or you may leave by the north corridor ({81}). If you fail, go to {14}."
},
{ // 69/13C
"It is actually a foil-wrapped chocolate dagger. Too bad! If you try again, go to {37}. If you attack it, go to {67}. If you wish to leave, go to {115}."
},
{ // 70/13D
"You get a diamond ring worth 2,000 gold pieces. After you have it in your hands, you black out. When you come to, you are outside the door that led you to this adventure. Add 500 points to your experience, and go to {19}."
},
{ // 71/13E
"It is a healing potion. Raise your Constitution to its original level and add to it any bonuses that you have received. The bottle is now empty. Go back to {92} and do something else."
},
{ // 72/13F
"You have received a gem worth 500 gold pieces. You must now leave. Go to {6}."
},
{ // 73/14A
"You have just entered Max's Fun House. As a result you lose 4 from your Dexterity because of the dizzying rides. This lasts until you leave[ the next room you enter]. You may stumble through the east door (go to {135}), the south door (go to {111}), or the north door (go to {87})."
},
{ // 74/14B
"The first step you took caused the floor between the two lines to collapse into a pit. Take ten hits. If this kills you, go to {3}. If you are still alive, you may try to climb out by making your L1-SR on Dexterity (20 - DEX), taking the difference in hits if you fail. If you get out, you notice that the little imp is gone, and the only exit is back in the other room through the north door. Go to {50}."
},
{ // 75/14C
"A wall slides behind you, cutting off your return. Go to {87}."
},
{ // 76/14D
"You gain 1,000 experience points. Go back to {92} and leave."
},
{ // 77/14E
"You are in a room with a lot of black, circular, flat objects flying about. Every item you own must make a L1-SR on Luck (20 - LK). If any item fails to do so, it is destroyed[, or, if it is treasure, devalued by half]. You see, these little black objects are portable holes - tough luck if you lost something valuable. You had better leave through either the north door (go to {2}), the west door (go to {160}), the left-hand south door (go to {100}), or the right-hand south door (go to {92})."
},
{ // 78/14F
"[You get back any one item that you lost in this dungeon. ]You must now leave. Go to {6}."
},
{ // 79/15A
"He shrugs his shoulders and disappears. Go to {85}."
},
{ // 80/15B
"You are at a \"T\" intersection. If you go east, go to {9}. If you go west, go to {17}. If you go south, go to {133}."
},
{ // 81/15C
"In front of you stands a leprechaun who is about 1' tall. He stands in a corridor with a ceiling even with your height. He is holding a pencil as tall as he is. He sees you, draws a line across the floor, and dares you to cross it. If you change your mind about going into this corridor, you may leave by the north door instead (go to {50}). If you cross the line, go to {127}. If you attack the little pest, go to {116}."
},
{ // 82/15D
"Make your L1-SR on Dexterity (20 - DEX). If you make it, you may leave by the south door (go to {77}), the east door (go to {95}), or the north door (go to {125}). If you miss it, go to {41}."
},
{ // 83/15E
"The chasm *appears* to be solid, ergo, it is an illusion. If you walk around it, go to {89}. If you change your mind about it and go through the west door, go to {2}. If you walk over it, go to {167}."
},
{ // 84/15F
"You gain control of one of the magical holes of the Room of Holes. This neat little item is 3' in diameter and is controlled by a ring (which you now possess). If can put a hole up to 50' deep in any non-living material. You must now leave. Go to {6}."
},
{ // 85/16A
"To get out of the pit, make your L1-SR on Dexterity (20 - DEX) twice. If you miss the first one, take one hit. If you miss the second one, take two hits. If you are killed, go to {3}. If you make it, go to {16}."
},
{ // 86/16B
"The middle light goes off, and the top one, which is red, goes on. A swarm of huge and horrible creatures race through the walls to your left and right, about 3' in front of you. They charge back and forth through these newly created holes, ignoring you entirely. If you try to run through them, go to {98}. If you just stand there, go to {105}. If you attack them, go to {44}."
},
{ // 87/16C
"You are in a small room with doors to the north, south and east. If you wish to go through the north door, go to {107}. If you wish to go through the south door, go to {73}. If you wish to go through the east door, go to {135}."
},
{ // 88/16D
"The door doesn't open. Go back to where you were ({50})."
},
{ // 89/16E
"The floor was a clever illusion. You fell down into a pit. Take five hits. If this kills you, go to {3}. If it doesn't, there is a ladder you can climb up. Go to {161}."
},
{ // 90/16F
"The page comes out and turns to gold. It is worth 700 gold pieces. You must now leave by going to {6}."
},
{ // 91/17A
"You have entered a small room. There is a door in the south wall, a corridor along the west wall, and an archway on the east wall. The archway bears above it the quotation, \"Stay Away\". If you go down the corridor, go to {19}. If you go through the door, go to {25}. If you go through the archway, go to {15}."
},
{ // 92/17B
"You have entered a room with a table against the south wall. There are two bottles on it. The first one is marked \"DO\" and the other is marked \"DON'T\". They are both full of an unknown liquid. If you want to leave by the left-hand north door, go to {160}. If you want to leave by the right-hand north door, go to {77}. If you want to leave by the door, marked \"Bathroom\", on the west wall, go to {34}. If you want to drink from the bottle marked \"DON'T\", go to {40}. If you drink from the bottle marked \"DO\", go to {71}."
},
{ // 93/17C
"That was stupid. The ceiling was level with your head, remember? At any rate, you fell back to where you were, and took one hit from the lump on your head. Now go back to {127} and try again. If you died, go to {3}."
},
{ // 94/17D
"You have been teleported. Roll two dice and check below:\n" \
"    Roll    Go To\n" \
"    2       {73}\n" \
"    3       {9}\n" \
"    4       {165}\n" \
"    5       {107}\n" \
"    6       {133}\n" \
"    7       {92}\n" \
"    8       {91}\n" \
"    9       {13}\n" \
"    10      {81}\n" \
"    11      {160}\n" \
"    12      Out of Dungeon"
},
{ // 95/17E
"You are in a short hallway with a large crack going down the middle of the floor. You may go through the door on the west (go to {2}), check out the chasm (go to {83}), or walk around it (go to {89})."
},
{ // 96/17F
"Add 10 to your lowest attribute, or 3 to any 2 attributes of your choice. Leave now by going to {6}."
},
{ // 97/18A
"While you were walking past the lights, monsters broke through the walls on both sides. Make your L2-SR on Dexterity (25 - DEX). If you fail, you are trampled flat. Go to {3}. If you make it, you took four hits, and if you still live, go to {75}. Otherwise, go to {3}."
},
{ // 98/18B
"That was not smart. Make your L3-SR on Dexterity (30 - DEX). If you make it, you took half your Constitution in hits. If you didn't, you were splattered. Go to {3}. If you live, go to {75}."
},
{ // 99/18C
"You have just received 4000# of bat manure. You black out and when you come to, you are outside the door that led you to this adventure. Fortunately for you, the manure did not come with you. Add fifty points to your experience and go to {19}."
},
{ // 100/18D
"This room is empty except at the south end, where a large eye hovers about 5' from the floor. If you attack it, go to {94}. If you stand there, go to {4}. If you leave, go to {77}."
},
{ // 101/18E
"There are three exits from this room: the west door (go to {135}), the east door (go to {77}), or the south door (go to {92})."
},
{ // 102/18F
"You get an arrow which always points towards the worst danger in the area. However, it doesn't work in solitaire dungeons. Leave now by going to {6}."
},
{ // 103/19A
"You fell into a pit that is about 20' deep. Take three hits. If this kills you, go to {3}. If it doesn't, go to {61}, if this is the first time you have fallen into this pit. If it isn't, go to {85}."
},
{ // 104/19B
"There is a turn in the corridor. If you go east, go to {50}. If you go north, go to {133}."
},
{ // 105/19C
"After about a minute, the top light goes off and the bottom one, which is green, goes on. All the charging monsters stop on either side of the corridor. If you wish to continue east, go to {109}. If you attack these hideous beasts, go to {122}. If you just stand there, go to {117}."
},
{ // 106/19D
"He notices that you lack a gun, and offers you the use of one of his. He says that both are charmed to kill whoever is beaten to the draw. If you accept, go to {140}. If you don't, go to {129}. If you attack him, go to {146}."
},
{ // 107/19E
"You have entered a room that swarms with psychedelic and incomprehensible symbols and objects. Make your L1-SR on Luck (20 - LK). [If you make it, reduce your Dexterity by four until you have gone through another room. ]If you miss, [reduce your Dexterity as if you had made it, but ]permanently reduce your IQ to three and make another L1-SR on Luck (20 - LK). If you miss this, your mind has burned out. Go to {3}. If you make it, there are no other effects. Go to {158} and get out of here."
},
{ // 108/19F
"The page is blank and you must leave. Go to {6}."
},
{ // 109/20A
"You do so with no trouble at all. Go to {75}."
},
{ // 110/20B
"His treasure consists of one large diamond worth 10,000 gold pieces. It is also magical[; it adds ten to your Constitution as long as you possess it]. There are no other exits, so go back to {91}."
},
{ // 111/20C
"You have entered a room where you see a vending machine that dispenses weapons of various sorts. If you wish to use the machine, go to {37}. If you don't, go to {115}. If you attack it, go to {67}."
},
{ // 112/20D
"It reads, \"If you had asked for it in the first place, I would have given it to you.\" He gives you another bilabial fricative, and disappears. Go to {101}."
},
{ // 113/20E
"Half of your Charisma has been taken away as a result of your subsequent \"accident\". Now go back to {92} and do something else. You won't be able to clean up thoroughly, to restore your Charisma, until you have left the dungeon."
},
{ // 114/20F
"You get one magical arrow (for use with self bows, longbows, and composite bows)[ that will automatically hit its target]. You must leave. Go to {6}."
},
{ // 115/21A
"If you came through the door on the north wall, you may now leave through it (go to {73}), or through the east corridor (go to {19}). If you didn't enter by the door, you may also leave by the west corridor. Go to {50}."
},
{ // 116/21B
"He has the following abilities:\n" \
"    Strength     -   5\n" \
"    IQ           -  15\n" \
"    Luck         -  18\n" \
"    Constitution -   5\n" \
"    Dexterity    - 153\n" \
"    Charisma     -  18\n" \
"He attacks you with his pencil which has a magical eraser. This eraser tends to \"rub out\" people. He has one die plus fifty adds in combat. If you kill him, go to {8}. If you die, go to {3}."
},
{ // 117/21C
"The middle light, which is yellow, goes on. The bottom one goes out. The monsters continue to stand there. If you attack them, go to {122}. If you stand there, go to {128}. If you continue east, go to {134}."
},
{ // 118/21D
"The brush finished its portrait of you. Your body has disintegrated, and your life force has transferred to your portrait. The portrait is then teleported onto the wall of a room with many similar paintings. Too bad. Now close this book."
},
{ // 119/21E
"He gives it to you. It is worth 1,000 gold pieces and 100 experience points. Go to {101}."
},
{ // 120/21F
"You see a wand spring from the page. It touches you and vanishes, adding one thousand points to your experience. You must leave. Go to {6}."
},
{ // 121/22A
"Guess what! It did it again. Go back to {145} and try something else."
},
{ // 122/22B
"They just stand there as you kill them like flies. After about a minute, however, they start moving again, ignoring you as they stomp you flat. Go to {3}."
},
{ // 123/22C
"Six uniformed men charge in and open fire on you. Make your L1-SR on Luck (20 - LK) six times. If you miss even one, go to {3}. If you make all six, you had better leave before they fire again. Go to {55}."
},
{ // 124/22D
"You almost fell into a room-sized pit which is approximately 20' deep. Against each wall is a 3'-wide walkway. There is nothing else in the room. Go to {16}."
},
{ // 125/22E
"You have entered the room of the Tome of Max. There is a stone pedestal with a book of marble slabs bound by mithril rings. It has been set into the pedestal and is unmovable. If you open the book, go to {30}. If you wish to exit Weirdworld (finally!) go to {6}. The door you entered through has disappeared."
},
{ // 126/22F
"You may pick two pages instead of one. Go back to {30} and good luck.\n" \
"  If this is the second time this adventure that you have picked this page, go to {168}."
},
{ // 127/23A
"He jumps back about two paces and draws another line. He double-dares you to cross this line. If you wish to leave by the north door back in the other room, go to {50}. If you wish to jump over the line, go to {93}. If you just want to step over it, go to {74}."
},
{ // 128/23B
"The middle light goes off, and the top one, which is red, goes on. The monsters start charging across again. If you attack them, go to {44}. If you try to run through them, go to {98}. If you just stand there, go to {105}."
},
{ // 129/23C
"He has a magical device on his gun that he just used to halve your Charisma for being a \"low-down, yeller-bellied coward\". He tells you to get out and never come back. Go to {91} - and don't come back."
},
{ // 130/23D
"He turns you into a fighting-man, switching your Strength and IQ ratings. Now enter Weirdworld by going to {1}."
},
{ // 131/23E
"He has a Blasting Power spell, and he uses it. Go to {3}."
},
{ // 132/23F
"You have gained the ability to regenerate two points of your Constitution per turn, up to your original Constitution. You must leave - go to {6}."
},
{ // 133/24A
"You are in a corridor running north and south. On the east wall is a door marked \"KEEP OUT\". If you go north, go to {80}. If you go south, go to {104}. If you go through the door, go to {31}."
},
{ // 134/24B
"Make your L1-SR on Luck (20 - LK). If you make it, go to {109}. If you don't, go to {27}."
},
{ // 135/24C
"Make your L1-SR on Dexterity (20 - DEX). If you make it, go to {124}. If you miss it, go to {103}."
},
{ // 136/24D
"No matter what you do to him, he isn't even scratched. You may either take it from him (go to {148}) or leave (go to {101}). All he does is give you a bilabial fricative."
},
{ // 137/24E anti-cheat
"Go to {142} - quickly."
},
{ // 138/24F
"You have just received the ability to come back to life after being killed. The gift will work only once; you will revive at the same time and place you were killed, and your Constitution will be restored to its original level. You must leave. Go to {6}."
},
{ // 139/25A
"Perhaps it is time that you thought about getting a new solitaire dungeon from Flying Buffalo. Overworking any dungeon, solitaire or not, is hazardous to your mental health. If you don't believe me, just keep trying. But don't say I didn't warn you."
},
{ // 140/25B
"Make your L1-SR on Dexterity (20 - DEX). If you make it, you beat him to the draw and he is dead. Go to {58}. If you missed it, go to {3}."
},
{ // 141/25C
"You have been attacked by Max's favourite creature, a giant amoeba. This monster has no centralized nucleus, so it can seep through the tiniest of cracks (it was hiding in the toilet plumbing). Combat is done in the following manner:\n" \
"  Each turn, make your L1-SR on Dexterity (20 - DEX). If you miss it, you have been hit and partially engulfed. Take two hits this and every turn until the monster kills you. If you came here from 10, you have already taken six hits from its surprise attack. It can be damaged with normal weapons[ (weapons value only - no adds for ability)], and you hit automatically.[ However, it is immune to poison, and will regenerate four points per round, back up to its present Constitution.]\n" \
"  If you kill the amoeba, go to {76}. If it kills you, it digests you. [Add your Constitution, unmodified by armour or previous damage, to its original Constitution. This new score is the amoeba's new Constitution and should be written in place of the old one. ]Then go to {3}. Don't feel bad - at least your death was painless. The creature numbs all of your pain nerves on the first hit. (You can still feel it, though.)\n" \
"  The amoeba's Constitution is currently: 100."
},
{ // 142/25D anti-cheat
"You have cheated. [All of your following characters will have no gold to start with for that! ]Now go!"
},
{ // 143/25E
"Nothing has changed. You may either ask him for it (go to {119}), attack the little twerp (go to {136}), take it from him (go to {148}), or leave (go to {101})."
},
{ // 144/25F
"You receive five hundred gold pieces. Now leave by going to {6}."
},
{ // 145/26A
"The machine ate the money and returned nothing. If you wish to try again, go to {121}. If you attack it, go to {67}. If you leave, go to {115}."
},
{ // 146/26B
"You don't have a gun, stupid! You have been riddled with holes. Go to {3}."
},
{ // 147/26C
"You have just won one thousand boxes of dog yummies. You black out, and when you come to you are outside the door which led you to this adventure. Luckily, the dog yummies didn't come with you. You receive fifty experience points and go to {19}."
},
{ // 148/26D
"After trying for several minutes to yank the jewellery out of the little jerk's grasp, you manage to shatter it, making it worthless. He gives you another bilabial fricative, and pulls a small sign out from under himself. You may read it (go to {112}), or leave (go to {101})."
},
{ // 149/26E
"Fred [may spit his teeth for one die plus one of his, one per turn. He ]has 32 teeth[, and they take a week to grow back]."
},
{ // 150/26F
"[Your favourite weapon has disintegrated. ]Go to {6}."
},
{ // 151/27A
"You have come to the foot of a bridge which goes over a lake. There are two signs there which read \"Bridge to Adventure\" and \"Pay Toll to the Troll\". Sure enough, there is a troll in a structure labelled \"TROLL BOOTH - One Gold Piece Toll\". If you pay the toll and you go across, go to {12}. If you try to sneak across, go to {5}. If you attack the troll, go to {24}. If you go back the way you came, go to {161}."
},
{ // 152/27B
"Before you go through the door, you notice an inscription on it which reads \"Do Not Feed the Animals\". Go to {165}."
},
{ // 153/27C
"Roll one die. If you roll a 1, 2, or 3, the monkeys grabbed your sword hand and bit it off. On a 4, 5, or 6, they bit off your other hand. In either case, they took your hand and ran through a door in the back wall before you were able to do anything. After they all get through the door, it disappears. Take five hits. If you are killed by this, go to {3}. If not, you may not use a shield *and* a weapon at the same time. If you sword hand was bitten off, your Dexterity [in combat ]is permanently halved. Now go back to {165} and leave."
},
{ // 154/27D
"The animated brush paints a sword in the air which attacks you. It takes ten hits and [*defends* for ]two dice and 25 adds in combat. [Note that it does not cause damage. ]If the fight takes more than three rounds, go to {118}. If not, go to {166}."
},
{ // 155/27E anti-cheat
"If you are just reading through this, go to {142}."
},
{ // 156/27F
"[Your favourite weapon has just been charmed to cause double damage. ]You must leave. Go to {6}."
},
{ // 157/28A
"You are in a room that is empty except for an animated paintbrush working at an easel. The brush seems to be painting a portrait of you. If you pose for it, go to {118}. If you attack it, go to {64}. If you leave through the south door, go to {53}. If you leave through the west door, go to {59}."
},
{ // 158/28B
"There are three exits: the north door (go to {152}), the south door (go to {87}), or the east door (go to {135})."
},
{ // 159/28C
"You are engulfed by a mist, become dizzy, and black out. When you come to, you are in a boat which is floating on a body of water. It is very foggy. There is a string in your hand. If you pull it, go to {163}. If you don't, go to {63}."
},
{ // 160/28D
"You are in a room which has niche in the north wall. In the niche there stands a small cylindrical creature with a domed head and a single tentacle. He is clutching a valuable piece of jewellery in the tentacle. If you take it away from him, go to {148}. If you attack him, go to {136}. If you do nothing, go to {143}. If this is the second time, this adventure, that you have been here, the creature and the jewelry disappear. Go to {101}."
},
{ // 161/28E
"You are at a bend in the corridor. If you go north, go to {151}. If you go west, go to {95}, ignoring the note about the east door."
},
{ // 162/28F
"A spectral hand reached down and touched you, doubling your Charisma. You must leave. Go to {6}."
},
{ // 163/29A
"You pulled out the draining-cork, and the boat is sinking with incredible rapidity. Make your L2-SR on Dexterity (25 - DEX). If you make it, you were able to replace the cork before the boat sank. If you missed it, you sank and were attacked by a large school of hungry piranha. Go to {3}. Otherwise, the fog lifts, and you may paddle to the door on the east (go to {152}) or to the south door (go to {17})."
},
{ // 164/29B
"If this is the first time this adventure that you have ended up here, the liquid is a potion that permanently raises you Strength and Constitution by five apiece. Otherwise, the liquid is nothing but water. Go to {29}."
},
{ // 165/29C
"You have entered the monkey house. Two-thirds of the room has been barred off, and there are about twenty monkeys swinging on the bars and the trees, doing all sorts of tricks for you. They are looking hungrily at your lunch. If you give them a tidbit, go to {153}. If you leave through the south door, go to {107}. If you leave through the west door, go to {159}. If you leave through the east door, go to {157}."
},
{ // 166/29D
"You did it. The brush and the easel have been destroyed. You may now leave by the west door (go to {152}) or the south door (go to {135})."
},
{ // 167/29E
"It is solid. To continue down the corridor, go to {161}. There is a door on your right marked \"This Way to the Egress\". If you take it, go to {6}."
},
{ // 168/29F
"You have just sprung the alarm. Maximilian the Magnificent appears, subtracts 1 from each of your attributes, and teleports you to {141}. Anything that you killed there has been resurrected at full strength. Be more careful next time."
}
};

MODULE SWORD ww_exits[WW_ROOMS][EXITS] =
{ { 131,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/2A
  {  11,  65,  41,  82,  -1,  -1,  -1,  -1 }, //   2/2B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/2C
  {  23,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/2D
  {  24,  18, 161,  -1,  -1,  -1,  -1,  -1 }, //   5/2E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/2F
  {  28,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/3A
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/3B
  {  97,  80,  86,  -1,  -1,  -1,  -1,  -1 }, //   9/3C
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/3D
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/3E
  { 159,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/3F
  {  99,  70, 147,  55,  52,  -1,  -1,  -1 }, //  13/4A
  {  50,  81,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/4C
  { 157, 160, 107,  87,  73,  -1,  -1,  -1 }, //  16/4D
  { 159,  80,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/4E
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/4F
  {  91, 111,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/5A
  {  50,  81,  68,  39,  -1,  -1,  -1,  -1 }, //  20/5B
  {  67,  46,  37, 115,  -1,  -1,  -1,  -1 }, //  21/5C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/5D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/5E
  {  18, 161,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/5F
  { 146, 106,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/6A
  {  20,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/6B
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/6C
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/6D
  { 152,  17,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/6E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/6F
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/7A
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/7B
  {  62,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/7D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/7E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/7F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/8A
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/8B
  {  50,  81,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/8C
  {  34, 113,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/8D
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/8E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/8F
  {  67,  37, 115,  -1,  -1,  -1,  -1,  -1 }, //  43/9A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/9B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/9C
  {  49,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/9D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/9E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/9F
  {  37,  67, 115,  -1,  -1,  -1,  -1,  -1 }, //  49/10A
  { 104, 111,  88,  -1,  -1,  -1,  -1,  -1 }, //  50/10B
  {  37,  67, 115,  -1,  -1,  -1,  -1,  -1 }, //  51/10C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/10D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/10E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/10F
  {  19,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/11A
  {  37,  67, 115,  -1,  -1,  -1,  -1,  -1 }, //  56/11B
  {  20,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/11C
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/11D
  { 157,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/11E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/11F
  {   7,  79,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/12B
  { 164,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/12C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/12D
  {  82,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/12E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/12F
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/13A
  {  50,  81,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/13B
  {  37,  67, 115,  -1,  -1,  -1,  -1,  -1 }, //  69/13C
  {  19,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/13D
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/13E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/13F
  { 135, 111,  87,  -1,  -1,  -1,  -1,  -1 }, //  73/14A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/14B
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/14C
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/14D
  {   2, 160, 100,  92,  -1,  -1,  -1,  -1 }, //  77/14E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/14F
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/15A
  {   9,  17, 133,  -1,  -1,  -1,  -1,  -1 }, //  80/15B
  {  50, 127, 116,  -1,  -1,  -1,  -1,  -1 }, //  81/15C
  {  77,  95, 125,  -1,  -1,  -1,  -1,  -1 }, //  82/15D
  {  89,   2, 167,  -1,  -1,  -1,  -1,  -1 }, //  83/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/15F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/16A
  {  98, 105,  44,  -1,  -1,  -1,  -1,  -1 }, //  86/16B
  { 107,  73, 135,  -1,  -1,  -1,  -1,  -1 }, //  87/16C
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/16D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/16E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/16F
  {  19,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/17A
  { 160,  77,  34,  -1,  -1,  -1,  -1,  -1 }, //  92/17B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/17C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/17D
  {   2,  83,  89,  -1,  -1,  -1,  -1,  -1 }, //  95/17E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/17F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/18A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/18B
  {  19,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/18C
  {  94,   4,  77,  -1,  -1,  -1,  -1,  -1 }, // 100/18D
  { 135,  77,  92,  -1,  -1,  -1,  -1,  -1 }, // 101/18E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/18F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/19A
  {  50, 133,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/19B
  { 109, 122, 117,  -1,  -1,  -1,  -1,  -1 }, // 105/19C
  { 140, 129, 146,  -1,  -1,  -1,  -1,  -1 }, // 106/19D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/19E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/19F
  {  75,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/20A
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/20B
  {  37, 115,  67,  -1,  -1,  -1,  -1,  -1 }, // 111/20C
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/20D
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/20E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/20F
  {  73,  19,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/21A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/21B
  { 122, 128, 134,  -1,  -1,  -1,  -1,  -1 }, // 117/21C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/21D
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/21E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/21F
  { 145,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/22A
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/22B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/22C
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/22D
  {  30,   6,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/22E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/22F
  {  50,  93,  74,  -1,  -1,  -1,  -1,  -1 }, // 127/23A
  {  44,  98, 105,  -1,  -1,  -1,  -1,  -1 }, // 128/23B
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/23C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/23D
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/23E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/23F
  {  80, 104,  31,  -1,  -1,  -1,  -1,  -1 }, // 133/24A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/24B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/24C
  { 148, 101,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/24D
  { 142,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/24E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/24F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/25A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/25B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/25C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/25D
  { 119, 136, 148, 101,  -1,  -1,  -1,  -1 }, // 143/25E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/25F
  { 121,  67, 115,  -1,  -1,  -1,  -1,  -1 }, // 145/26A
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/26B
  {  19,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/26C
  { 112, 101,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/26D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/26E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/26F
  {   5,  24, 161,  -1,  -1,  -1,  -1,  -1 }, // 151/27A
  { 165,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/27B
  { 165,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/27C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/27D
  { 142,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/27E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/27F
  { 118,  64,  53,  59,  -1,  -1,  -1,  -1 }, // 157/28A
  { 152,  87, 135,  -1,  -1,  -1,  -1,  -1 }, // 158/28B
  { 163,  63,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/28C
  { 148, 136, 143,  -1,  -1,  -1,  -1,  -1 }, // 160/28D
  { 151,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/28E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/28F
  { 152,  17,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/29A
  {  29,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/29B
  { 107, 159, 157,  -1,  -1,  -1,  -1,  -1 }, // 165/29C
  { 152, 135,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/29D
  { 161,   6,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/29E
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/29F
};

MODULE STRPTR ww_pix[WW_ROOMS] =
{ "ww0", //   0
  "",
  "",
  "",
  "",
  "", //   5
  "ww6",
  "ww7",
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
  "ww18",
  "",
  "ww20", //  20
  "",
  "",
  "",
  "",
  "ww25", //  25
  "",
  "",
  "",
  "",
  "", //  30
  "",
  "",
  "ww33",
  "",
  "", //  35
  "",
  "",
  "",
  "",
  "", //  40
  "",
  "ww42",
  "",
  "",
  "", //  45
  "",
  "ww47",
  "",
  "",
  "", //  50
  "ww51",
  "",
  "",
  "",
  "", //  55
  "",
  "",
  "",
  "",
  "ww60", //  60
  "",
  "",
  "",
  "",
  "", //  65
  "",
  "",
  "",
  "ww69",
  "", //  70
  "",
  "",
  "",
  "",
  "", //  75
  "",
  "ww77",
  "",
  "",
  "", //  80
  "",
  "",
  "",
  "ww84",
  "", //  85
  "",
  "",
  "",
  "",
  "", //  90
  "",
  "ww92",
  "",
  "",
  "", //  95
  "",
  "",
  "",
  "",
  "ww100", // 100
  "",
  "",
  "",
  "",
  "", // 105
  "",
  "ww107",
  "",
  "",
  "", // 110
  "",
  "",
  "",
  "ww114",
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
  "ww125", // 125
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
  "ww136",
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
  "ww154",
  "", // 155
  "",
  "",
  "",
  "",
  "", // 160
  "",
  "ww162",
  "ww163",
  "",
  "", // 165
  "",
  "",
  ""  // 168
};

IMPORT int                    age,
                              armour,
                              been[MOST_ROOMS + 1],
                              evil_damagetaken,
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_hitstaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              prevroom, room, module,
                              round,
                              spellchosen,
                              spelllevel,
                              spellpower,
                              thethrow;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct LanguageStruct  language[LANGUAGES];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void ww_enterroom(void);

EXPORT void ww_preinit(void)
{   descs[MODULE_WW]   = ww_desc;
 // wanders[MODULE_WW] = ww_wandertext;
}

EXPORT void ww_init(void)
{   int i;

    exits     = &ww_exits[0][0];
    enterroom = ww_enterroom;
    for (i = 0; i < WW_ROOMS; i++)
    {   pix[i] = ww_pix[i];
}   }

MODULE void ww_enterroom(void)
{   TRANSIENT FLAG engulfed;
    TRANSIENT int  i, j,
                   result,
                   temp;
    PERSIST   int  killed,
                   prevcon,
                   taken;

    switch (room)
    {
    case 0:
        if (class == WARRIOR)
        {   if (getyn("Go in (otherwise attack)"))
            {   room = 1;
        }   }
        else
        {   if (getyn("Change into a fighter (otherwise attack)"))
            {   room = 130;
        }   }
    acase 1:
        taken = getnumber("1) Sword #1\n2) Sword #2\n3) Battleaxe\n4) Shield\n5) Skull\n6) Spear\n7) Bones\n8) Chest\n9) None\nTake which", 1, 9);
        if (taken == 9)
        {   room = 20;
        } else
        {   room = 45;
        }
    acase 3:
        die();
    acase 5:
        if (maybespend(1, "Pay troll"))
        {   room = 12;
        }
    acase 6:
        victory(5000);
    acase 8:
        if (prevcon > con)
        {   heal_con(prevcon - con);
        }
        award(500);
        // %%: do we get to keep the pencil? We assume not.
    acase 14:
        templose_con(dice(5)); // %%: does armour help? We assume not.
        if (con <= 0)
        {   room = 3;
        }
    acase 15:
        savedrooms(3, lk, 47, 32);
    acase 19:
        if (getyn("Go north"))
        {   if (been[13])
            {   room = 53;
            } else
            {   room = 13;
        }   }
    acase 22:
        savedrooms(3, lk, 141, 10);
    acase 23:
        savedrooms(1, lk, 38, 35);
    acase 24:
        if (maybespend(1, "Pay troll"))
        {   room = 12;
        }
    acase 28:
        give(530);
    acase 30:
        do
        {   result = getnumber("Which paragraph", 36, 168);
        } while (result % 6);
        room = result;
    acase 34:
        if (prevroom == 40)
        {   room = 22;
        } else
        {   room = 141;
        }
    acase 35:
        die();
    acase 36:
        give_gp(100);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 37:
        do
        {   result = getnumber("1) Sword\n2) Battleaxe\n3) Spear\n4) Mace\n5) Dagger\nBuy which", 1, 5);
            if     (result == 1 && pay_gp(10))
            {   if (been[37] || dice(1) == 1) room = 145; else room = 21;
            } elif (result == 2 && pay_gp(20))
            {   if (been[37] || dice(1) == 1) room = 145; else room = 51;
            } elif (result == 3 && pay_gp(25))
            {   if (been[37] || dice(1) == 1) room = 145; else room = 56;
            } elif (result == 4 && pay_gp(30))
            {   if (been[37] || dice(1) == 1) room = 145; else room = 43;
            } elif (result == 5)
            {   if (been[37] || dice(1) == 1) room = 145; else room = 69;
        }   }
        while (room == 37);
    acase 38:
        gain_flag_ability(0);
        gain_flag_ability(65);
    acase 39:
        gain_flag_ability(66);
    acase 41:
        drop_all();
    acase 42:
        create_monster(285);
        fight();
        if (con <= 0)
        {   room = 3;
        } elif (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 43:
        give(HEM); // maybe we should have this as a different item to the normal heavy mace?
    acase 44:
        if (saved(1, dex))
        {   templose_con(2); // %%: does armour help? We assume not.
            if (con <= 0)
            {   room = 3;
            } else
            {   room = 105;
        }   }
        else
        {   room = 3;
        }
    acase 45:
        if (taken == 5)
        {   room = 33;
        } else
        {   room = 26;
        }
    acase 47:
        create_monster(286);
        do
        {   if (!saved(1, dex)) // %%: it doesn't say whether this is done at the start or end of the round
            {   room = 3;
            } else
            {   oneround();
        }   }
        while (room == 47 && con >= 1 && countfoes());
        if (room == 47 && con >= 1)
        {   room = 110;
        }
    acase 48:
        give(514);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 49:
        give(515);
    acase 51:
        give(516);
    acase 52:
        // %%: can you go immediately to the exit, killing none of them? We assume not.
        killed = 0;
        do
        {   killed += dice(1);
            if (dice(1) == 6)
            {   room = 123;
        }   }
        while (room == 52 && getyn("Continue (otherwise leave)"));
        if (room == 52)
        {   room = 55;
        }
    acase 53:
        room = prevroom;
    acase 54:
        give(517);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 55:
        award(10 * killed);
    acase 56:
        give(SPE); // maybe we should have this as a different item to the normal common spear?
    acase 57:
        give_multi_always(518, 1);
    acase 58:
        give(519);
        award(400);
    acase 60:
        module = MODULE_DE;
        room = -1;
    acase 62:
        getsavingthrow(TRUE);
        if (!madeit(2, dex))
        {   templose_con(dice(misseditby(2, dex)));
            if (con <= 0)
            {   room = 3;
        }   }
        if (room == 62)
        {   room = 20;
        }
    acase 64:
        savedrooms(2, lk, 166, 154);
    acase 66:
        module = MODULE_BC;
        room = -1;
    acase 68:
        if (!saved(1, lk))
        {   room = 14;
        }
    acase 69:
        give(520);
    acase 70:
        give(521);
        award(500);
    acase 71:
        healall_con();
    acase 72:
        give(522);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 73:
        owe_dex(4);
    acase 74:
        good_takehits(10, TRUE); // %%: does armour help? We assume so.
        if (con <= 0)
        {   room = 3;
        } else
        {   do
            {   if (saved(1, dex))
                {   room = 50;
                } else
                {   good_takehits(misseditby(1, dex), TRUE);
                    if (con <= 0)
                    {   room = 3;
            }   }   }
            while (room == 74);
        }
    acase 76:
        award(1000);
    acase 77:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned)
            {   for (j = 1; j <= items[i].owned; j++)
                {   if (!saved(1, lk))
                    {   dropitem(i);
        }   }   }   }
    acase 78:
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 82:
        if (!saved(1, dex))
        {   room = 41;
        }
    acase 84:
        give(523);
        give(524);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 85:
        if (!saved(1, dex))
        {   templose_con(1); // %%: does armour help? We assume not.
            if (con <= 0)
            {   room = 3;
        }   }
        if (room == 85)
        {   if (!saved(1, dex))
            {   templose_con(2); // %%: does armour help? We assume not.
                if (con <= 0)
                {   room = 3;
        }   }   }
        if (room == 85)
        {   room = 16;
        }
    acase 89:
        good_takehits(5, TRUE);
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 161;
        }
    acase 90:
        give(525);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 91:
        if (!been[129])
        {   if (getyn("Go south"))
            {   room = 25;
        }   }
    acase 92:
        if (!been[71] && getyn("Drink \"DO\" bottle"))
        {   room = 71;
        } elif (!been[40] && getyn("Drink \"DON'T\" bottle"))
        {   room = 40;
        }
    acase 93:
        templose_con(1); // %%: does armour help? We assume not.
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 127;
        }
    acase 94:
        result = dice(2);
        switch (result)
        {
        case 2:   room =  73;
        acase 3:  room =   9;
        acase 4:  room = 165;
        acase 5:  room = 107;
        acase 6:  room = 133;
        acase 7:  room =  92;
        acase 8:  room =  91;
        acase 9:  room =  13;
        acase 10: room =  81;
        acase 11: room = 160;
        acase 12: victory(100); // %%: perhaps we should send them to paragraph 6 in this case?
        }
    acase 96:
        result = getnumber("1) Add 10 to your lowest attribute\n2) Add 3 to any 2 attributes\nWhich", 1, 2);
        // %%: is this done based on current or maximum attributes? We assume current.
        if (result == 1)
        {   // %%: what if they have several attributes which are equally low? We should probably let them choose among them in that case.
            if (st <= iq && st <= lk && st <= con && st  <= dex && st  <= chr && st  <= spd)
            {   gain_st(10);
            } elif         (iq <= lk && iq <= con && iq  <= dex && iq  <= chr && iq  <= spd)
            {   gain_iq(10);
            } elif                     (lk <= con && lk  <= dex && lk  <= chr && lk  <= spd)
            {   gain_lk(10);
            } elif                                  (con <= dex && con <= chr && con <= spd)
            {   gain_con(10);
            } elif                                                (dex <= chr && dex <= spd)
            {   gain_dex(10);
            } elif                                                              (chr <= spd)
            {   gain_chr(10);
            } else
            {   gain_spd(10);
        }   }
        else
        {   for (i = 1; i <= 2; i++)
            {   result = getnumber("1) Strength\n2) Intelligence\n3) Luck\n4) Constitution\n5) Dexterity\n6) Charisma\n7) Speed\nRaise which attribute", 1, 7);
                switch (result)
                {
                case 1:  gain_st(3);
                acase 2: gain_iq(3);
                acase 3: gain_lk(3);
                acase 4: gain_con(3);
                acase 5: gain_dex(3);
                acase 6: gain_chr(3);
                acase 7: gain_spd(3);
        }   }   }
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 97:
        if (saved(2, dex))
        {   good_takehits(4, TRUE); // %%: does armour help? We assume so.
            if (con <= 0)
            {   room = 3;
            } else
            {   room = 75;
        }   }
        else
        {   room = 3;
        }
    acase 98:
        if (saved(3, dex))
        {   templose_con(con / 2); // %%: does armour help? We assume not.
            room = 75;
        } else
        {   room = 3;
        }
    acase 99:
        award(50);
    acase 102:
        give(526);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 103:
        templose_con(3); // %%: does armour help? We assume not.
        if (con <= 0)
        {   room = 3;
        } elif (!been[103])
        {   room = 61;
        } else
        {   room = 85;
        }
    acase 107:
        room = 158;
        if (!saved(1, lk))
        {   change_iq(3);
            if (!saved(1, lk))
            {   room = 3;
        }   }
    acase 108:
        give(527);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 113:
        gain_flag_ability(67);
    acase 114:
        give(528);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 115:
        if ((prevroom == 19 || prevroom == 50) && getyn("Go west"))
        {   room = 50;
        }
    acase 116:
        create_monster(287);
        prevcon = con;
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 8;
        }
    acase 118:
        die();
    acase 119:
        give(529);
        award(100);
    acase 120:
        award(1000);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 123:
        if (saved(1, lk) && saved(1, lk) && saved(1, lk) && saved(1, lk) && saved(1, lk) && saved(1, lk))
        {   room = 55;
        } else
        {   room = 3;
        }
    acase 126:
        if (been[126])
        {   room = 168;
        } else
        {   room = 30;
        }
    acase 129:
        lose_chr(chr / 2);
    acase 130:
        become_warrior();
        temp = st;
        permchange_st(iq);
        change_iq(temp);
    acase 132:
        gain_flag_ability(68);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 134:
        savedrooms(1, lk, 109, 27);
    acase 135:
        savedrooms(1, dex, 124, 103);
    acase 138:
        gain_flag_ability(69);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 140:
        savedrooms(1, dex, 58, 3);
    acase 141:
        create_monster(288);
        if (prevroom == 10)
        {   templose_con(6);
            if (con <= 0)
            {   room = 3;
        }   }
        engulfed = FALSE;
        while (room == 141)
        {   if (engulfed || !saved(1, dex))
            {   templose_con(2);
                engulfed = TRUE;
                if (con <= 0)
                {   room = 3;
            }   }
            if (room == 141)
            {   good_freeattack();
                if (!countfoes())
                {   room = 76;
        }   }   }
    acase 144:
        give_gp(500);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 147:
        award(50);
    acase 150:
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 151:
        if (maybespend(1, "Pay troll"))
        {   room = 12;
        }
    acase 153:
        if (dice(1) <= 3)
        {   gain_flag_ability(18);
        } else
        {   gain_flag_ability(70);
        }
        templose_con(5);
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 165;
        }
    acase 154:
        create_monster(289);
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   room = 118;
        } else
        {   room = 166;
        }
    acase 156:
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 160:
        if (been[160])
        {   room = 101;
        }
    acase 162:
        gain_chr(chr);
        if (been[126] && been[30] == 1)
        {   room = 30;
        } else
        {   room = 6;
        }
    acase 163:
        if (!saved(2, dex))
        {   room = 3;
        }
    acase 164:
        if (!been[164])
        {   gain_st(5);
            gain_con(5);
        }
    acase 165:
        if (prevroom != 153 && getyn("Feed monkeys"))
        {   room = 153;
        }
    acase 168:
        permlose_st(1);
        lose_iq(1);
        lose_lk(1);
        permlose_con(1);
        lose_dex(1);
        lose_chr(1);
        lose_spd(1);
}   }
