#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Official errata:
Paragraph 1: Go to 65 should be go to 211.
Paragraph 57: The Constitution of the guards is 16 each.
Paragraph 123: Go to 5016 should be go to 84.
Paragraph 182: After you determine the "adds" of the Baron, (by rolling 6 dice) add 12 for his Constitution.
Paragraph 211: Camp is at 209 should be Camp is at 91.
Paragraph 213: Go to 4015 should be go to 89.

Unofficial errata:
Paragraph 187: Camp is at 209 should be Camp is at 91.

Unimplemented:
Alarms.
Paragraph 9.
*/

MODULE const STRPTR rc_desc[RC_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  The Red Circle is a solo adventure written for Tunnels and Trolls. Any single humanoid character may enter this adventure provided he has no more than 60 personal adds. This adventure has been written with the 5th edition of the T&T rules in mind. The rules presented in this book will allow you to play the game with no problem.\n" \
"  In addition to the rules presented here you will need many six sided dice, paper and pencils to play the adventure. Create your hero and begin.\n" \
"  Enjoy!\n" \
"~INTRODUCTION\n" \
"  You've been travelling the caravan route alone despite the danger. You've heard all the stories about the raiders, The Red Circle, and you do find them interesting. Still you know the Red Circle will be a power only so long as they do not get powerful people angry.\n" \
"  You top a small hill on the road and rein your horse to a stop. Before you, at the base of the hill, you see the remains of the caravan you've been following for three days. All the horses, camels and pack mules are dead. The wares carried in the caravan are spread all over the little meadow below; the most valuable goods are gone. The bodies of the soldiers and people in the caravan are also lying there. Carrion birds are feeding on the remains.\n" \
"  It is rather obvious that the raiders took the caravan by surprise. The meadow around the battleground is pockmarked with holes, like shallow graves, where the raiders had buried themselves while waiting for the caravan. The attack was well planned, and executed ruthlessly.\n" \
"  If you want to continue down the road, past the carnage, and on your way, go to {31}. If you want to investigate the battleground for any possible survivors, go to {62}. If you want to look for the raiders' trail and backtrack them, go to {93}."
},
{ // 1
"You sneak forward silently. Around a turn in the trail ahead you see two members of Red Circle crouched in ambush. Both are young and have bows. You note, with a certain amount of surprise, that their quivers and bracers are made of Dhesiri flesh. You were not aware any of the little dragonmen were this far north in Karesia.\n" \
"  If you want to talk to the youths, make a first level Charisma saving roll (20 - CHR). If you make it, go to {125}. If you miss it, go to {156}. If you decide to attack mercilessly, go to {211}. Because you have sneaked up on them they will not have any hit point total for the first round of the fight."
},
{ // 2
"Your move takes the Red Circle warriors by surprise. If you can avoid a couple of arrows you should be able to escape the Red Circle warriors.\n" \
"  Make a first level Luck saving roll (20 - LK). If you make it, you may travel north to the next town at {13}, or you may head West toward Goblin Mountain at {171}.\n" \
"  If you miss the saving roll you are hit with one arrow for each point you missed it by. Each arrow does 3 dice of damage. If you survive, the above options are for you."
},
{ // 3
"You pivot and grab the wrist behind the dagger heading toward your back. You twist the knife around and force it back into the stomach of the blonde woman who showed you the secret stairway. She drops to the floor, lifeless.\n" \
"  The Baron stands, his face pale. \"Just you and me.\" He dismisses his guards, leaving his nephew the only other person in the room with you.\n" \
"  Because you slew his mistress right before his eyes the Baron is going to be a bit distracted in this fight. [You will get a 20% bonus to your combat rolls for this fight. ]Go to {182}."
},
{ // 4
"The cavern is huge, and back near the dragon's tail you see what might have been an opening large enough to get two or three wagons into the cavern. Still it is much too small to ever have admitted the dragon.\n" \
"  Continuing around the dragon, ignoring the shifting carpet of coins and jewels, you locate three smaller doorways. One has a pair of hands carved into the rock above it. The second has a helmet carved above it. The last has a sword carved above it.\n" \
"  If you would like to enter the Hands door, go to {128}. If you want to enter the Helmet door, go to {190}. If you want to enter the Sword door, go to {37}. If you want to ask the dragon about this place, go to {35}."
},
{ // 5
"\"It must be all very confusing. As I understand it the situation is this. You and I are in the treasure laden Tomb of Rex Sunwolf, the first king of free Karesia. I happen to know, having been trapped here for the last 1000 years or so, that no one has come to visit. The people of the Red Circle live on the surface above us, pleased with the water that I warm for them. Between them and us are Dhesiri, introduced by Baron Valdemar to drive the Red Circle people out.\"\n" \
"  You blanch at the thought of anyone bringing the burrowing lizardmen into an area just to drive others out. \"That's like setting a house on fire just because you don't like the colour of the outside!\"\n" \
"  The dragon nods. \"True, but that will be academic soon. The Dhesiri will burrow in here and we'll both be killed. I'm so large I can only fry those near my head. It was nice knowing you.\"\n" \
"  If you want to ask the dragon to point out where the Dhesiri will come through so you can set up some defences, go to {159}. If you want to search the cavern for treasure or tools that might help your defence, go to {4}. If you want to search for an exit, go to {191}."
},
{ // 6
"If this is your first time at this paragraph roll one die. Subtract the number you roll from 12. Keep the result noted on a piece of paper.\n" \
"  On every subsequent trip to this paragraph roll one die and subtract it from the total. If the total ever hits zero or goes negative go immediately to {100}. If it is still positive you may go after any treasure you have not gotten. The Hand room is {128}, the Sword room is {37} and the Helmet room is {190}. You may also ask the dragon about the odd pounding sound you hear by going to {38}."
},
{ // 7
"The Dhesiri horde breaks through the cavern wall in several spots. The small scaly lizardmen are unarmed, their teeth and claws more than enough to deal with you or the dragon. You look up from your breastwork and can see no end to them. Your heart sinks and you prepare to sell your life dearly.\n" \
"  Roll two dice. This is the number of Dhesiri who can get at you in any one round. [Since they care nothing for defence you may distribute half your hit point total, even if you lost the round, on to the horde. Divide the hits by 5 and count that number of Dhesiri as dead, the remainder being passed off on a surviving Dhesiri. ]Keep track of the number you kill.\n" \
"  The Dhesiri each get 2 dice and 2 adds. They have a CON of 5 each. There is no end to them so you must just keep fighting. If you survive 5 combat rounds, go to {131}."
},
{ // 8
"You are in a cell, of sorts, with 1 die + 1 other prisoners. They all look as if they have not been here long, but they all have a haunted look in their eyes. None of them seem very disposed to talking.\n" \
"  The cell is an alcove dug into the wall of the warren. Wooden bars prevent you from moving about freely, though it is really the presence of an 8' tall Dhesiri Warrior that slows any thoughts of escape. It is huge and looks formidable.\n" \
"  The only chance you have for escape, realistically, is if you can convince your fellow prisoners to join you in fighting the Dhesiri warrior. To try this make a second level Charisma saving roll (25 - CHR). If you make it, go to {39}. If you miss it, your fellow prisoners are apathetic. In this case make a first level Luck saving roll (20 - LK). If you miss it, go to {70}. If you make it, you may try to convince your fellow prisoners to escape again. Repeat the above process until you either make the Charisma roll or miss the Luck saving roll."
},
{ // 9
"Roll the other prisoners up as normal human characters. They will have no weapons so they will only get 1 die in combat. They will fight on your behalf, but you will have to take all the risks. Any saving rolls called for you will have to make, and you alone will suffer the consequences.\n" \
"  Having the prisoners with you automatically raises your Alarm level by 2.\n" \
"  Return to the paragraph you came from for your current options."
},
{ // 10
"One of the prisoners grabs your arm. \"We better hurry. An alarm will be sounded and we'll never get to the queen. I was there before, that's where they captured me.\" She leads off through a maze of ttmnels to the Queen's climber at {16}."
},
{ // 11
"The steaming pool is warm, but you notice turbulence in its surface. There is a current there. If you would like to slip into it, to see where the water comes from or is going to, go to {196}. If you decide to return to the Grand Gallery, go to {154}."
},
{ // 12
"You have had the luck to stumble upon the sleeping quarters of the Dhesiri Warriors. There are three of them in here at this time. You may butcher them in their sleep. Each has a CON equal to the roll of four dice. Roll your damage and apply it to them one at a time. If you finish a combat round with the Warrior you are attacking with a CON of 5 or more, he will awaken, raise an alarm, and fight you.\n" \
"  In combat the Warriors are worth 6 dice and 3 dice worth of adds. Their CONs are as above, but [in combat ]they also get 3 hits worth of armour from their leathery skin. Other sleeping Warriors will join the fight one round after the alarm is raised.\n" \
"  [If the battle lasts more than 5 combat rounds, go to {131}. If an alarm is raised jack your Alarm level by 2.\n" \
"  ]If you kill the Warriors you get [50 points per sleeping Warrior and ]100 per [awake ]Warrior you slay. From here you may only return to the Grand Gallery at {154}. You may not choose this northwest corridor again."
},
{ // 13
"The nearest village is the provincial capital, Valdemarton. It is the seat of Baron Valdemar's power; his castle overlooks the village from a hill to the north. The town itself is a small collection of buildings clustered around the road. The only two buildings that interest you are the Dusty Rose Tavern and the inn. All the other buildings look like houses or businesses used primarily by townspeople.\n" \
"  If you want to go to the tavern, go to {75}. If you want to check into the inn, go to {137}."
},
{ // 14
"You awaken the prospector. His rheumy eyes clear and he strains to focus on your face. You motion him to silence and press a gold coin into his palm. In a whisper you say, \"I understand there are Dhesiri about. You would know, in the mountains.\"\n" \
"  Make a first level Luck saving roll (20 - LK). If you make it by more than 5, go to {45}. If you make it by 5 or less, go to {77}. If you miss it, go to {107}."
},
{ // 15
"The Baron's throne hall is large and very dark. Sunlight streams through the windows on both sides of the hall. The stained glass depicts the exploits of past heroes, though the Baron himself is featured in the newest pane. The red carpet leading from the doorway to the high throne is worn but suitable for the room.\n" \
"  There at two people at the far end of the room. One is a powerfully built man with a shaved head. He is dressed in dark blue clothing and wears a dagger. A broadsword and scabbard hangs from the left armrest on the throne.\n" \
"  Beside him is a stunningly beautiful blonde woman. She is dressed in a blue velvet robe. A silver collar and chain link her to the throne. The chain is very light, and probably could be broken with ease.\n" \
"  \"I have need of someone who could solve a problem for me. I need to know what you know of Dhesiri.\"\n" \
"  Add your Luck and IQ and divide that total by 2. To that total add your current level. Make a first level saving roll on that total (20 - Total). If you make it by 5 or more, go to {50}. If you make it by less than 5, go to {81}. If you miss it and know something about Dhesiri, go to {142}. If you miss it and know nothing of Dhesiri, go to {204}."
},
{ // 16
"You wander down a short corridor and turn the corner into the Queen's chamber. At once you are filled with conflicting emotions: wonder and fear. The scene you are watching is incredible, the stuff folktales are made of.\n" \
"  The Queen is huge, fully 12' long and fat like a walrus. Workers crowd around her, some spooning food into her mouth while others carry away the eggs she produces. Her only purpose in life is to produce the eggs that insure the life of the colony. It is amazing and revolting.\n" \
"  Scattered all around the room are the bones and remnants of previous meals. The stench of decaying meat is very strong. The production of life amid the charnel house atmosphere seems very inappropriate.\n" \
"  One Dhesiri Warrior stands guard over the Queen. The eggs are taken back into a chamber off toward the southeast.\n" \
"  If you want to shoot or throw a missile weapon at the Queen, you are trying to hit a large target at pointblank range. If you hit, go to {112}. If you want to engage the Warrior in combat, go to {143}. If you want to dash past the Warrior to the Egg Chamber, go to {174}. If you want to back out and go to the Grand Gallery, you may do so by going to {154}. Write down the number of this paragraph, though, because once you are here you should be able to reach it from the Grand Gallery at will."
},
{ // 17
"You pry open the long-sealed doorway into the Baron's castle. The stone around it is weathered and covered with faint carvings. Were you not so intent upon killing the Baron you might balk at entering such a doorway. Still, you are not daunted.\n" \
"  The corridor beyond the doorway is dark, but luminous moss and lichen provide enough light for you to navigate by. You head in toward the castle and marvel as you pass up through several different levels of basements. You hear things scurrying around in the shadows, but you decide not to investigate.\n" \
"  At this point you realize there are two ways to go about your task. One is to pursue a course of stealth, trying to pass unnoticed. The other is to power your way through the castle, killing others before they can raise an alarm. Both are effective ways of travelling.\n" \
"  At any paragraph you should have a choice between stealth and power, as well as options that offer themselves. If you want to choose the stealth option you will have to make a first level Dexterity saving roll (20 - DEX). If you make it, you may choose that option. If you want to choose the power option, you must make a first level Strength saving roll (20 - ST). If you make that roll, you may take the power option.\n" \
"  If you miss the saving roll, either one, you must take the Failure option listed at the paragraph. If there is no Failure option, any option other than Stealth or Power may be used at that paragraph.\n" \
"  You reach the first torchlit corridor and hear someone walking down it toward your position.\n" \
"  Stealth: {56} Power: {87} If you want to slip into the shadows and watch make a first level saving roll on Luck (20 - LK). If you make it, go to {118}. If you miss it, go to {212}. Failure: {26}."
},
{ // 18
"As a prisoner you are conducted before the headman of all the Red Circle. He is an old man, thin yet not frail. He wears the red headband you recognize on all Red Circle warriors. He points a crooked finger at you and your captors remove your bonds.\n" \
"  \"We do not keep prisoners. We offer them a chance to join us, work for us, or to depart if we believe we can trust them.\"\n" \
"  You rub your wrists where the leather thongs had rubbed the flesh a bit raw. If you want to join the Red Circle, go to {85}. If you are willing to work for the Red Circle, roll one die. If it comes up odd, go to {116}. If it comes up even, go to {147}. If you want to convince them you are to be trusted and released, go to {178}."
},
{ // 19
"You leap from the saddle, hit the ground and roll to your feet. Your horse screams and struggles as it is dragged down. You see the scaly claws of Dhesiri tearing at it. The Dhesiri had dug out a pit beneath the road and waited for prey to come along. You barely escaped being captured by them.\n" \
"  You scout around the area, knowing the Dhesiri do not like to range very far when hunting. With ease you locate the opening to their underground lair. Screwing your courage to the sticking point you enter and soon find yourself at {154}, the Grand Gallery."
},
{ // 20
"You were not lucky enough to be suspicious about the Baron. Just for your edification he has a vested interest in keeping the Dhesiri problem as undiscovered as possible. Now, far from his castle, three of his men murder you. They ride up like fellow travellers, and are quite pleasant. Unfortunately your luck fails you and they kill you with little or no resistance.\n" \
"  For you this adventure is done. Better luck next time."
},
{ // 21
"Make a first level IQ saving roll (20 - IQ). If you make it by 5 or more, go to {206}. If you make it by less than 5, go to {83}. If you miss it, go to {145}."
},
{ // 22
"You wedge yourself in between two smaller stalactites and kick the big one free. It drops slowly, tumbling so the widest end hits the water first. The splash is deafening and you get covered with water.\n" \
"  The stalactite has its expected effect. It displaces enough water to flood back into the other chambers of the Dhesiri warren. Furthermore it ripped a narrow hole in the cavern's roof, allowing you an exit. You climb up and out, taking great delight in the sunlight and lack of Dhesiri.\n" \
"  You have succeeded in destroying the Dhesiri threat to Karesia. This adventure has been worth 2500 experience points for you. Congratulations."
},
{ // 23
"You find yourself in a huge cavern, scattered with gold and human bones. It is very dark and you squint to see anything. Then, suddenly, the room is lit with a ball of dragonfire! All too late you see the dragon and its claw arcing toward you.\n" \
"  Make a first level IQ saving roll (25 - IQ). If you miss it, take 4 dice damage from the blow. If you are killed, go to {153}.\n" \
"  If you survive the attack or make the saving roll you feel the searing pain of the dragon's three claws slicing parallel scars in your left cheek. You black out.\n" \
"  You awaken in the Soulcave. You know you are now immune to damage from fire. This does not apply to your armour and equipment. This does not mean you can bathe in lava (it would smother you) but the heat and fire of anything will not harm you. Go to {30}."
},
{ // 24
"\"Good, I am glad you are brave enough to undertake this mission.\" The headman presses a small jade amulet into your hand. \"This is a Dhesiri amulet. Our sorcerer Andar created it. With this you will appear to all other Dhesiri to be Dhesiri. It will make your journey easier in the Warren.\" He also tells you that he is sending 5,000 gold pieces to the nearest village for you to recover after you are done and the Dhesiri Queen is dead.\n" \
"  You are given whatever weapons you want and taken to the entrance to the Warren. It is unguarded and you slip unnoticed to the Grand Gallery at {154}."
},
{ // 25
"You rein your horse around and spur it forward. The only person standing between you and freedom is a warrior with a crossbow. He raises it and shoots.\n" \
"  Make a second level saving roll on Luck or Dexterity, your choice. (25 - attribute.) If you miss it, take 5 dice off your CON. If you survive the attack, or make the roll, you escape after riding the man down and killing him. You leave the adventure with a bonus of 1500 experience points.\n" \
"  Congratulations, you have won."
},
{ // 26
"You whirl around the corner, anticipating the guard's continued stroll toward you. As it is, the guard had a nasty feeling about the doorway to the lower dungeons and stopped a step ahead of it. With a push he sends you back into the wall where you smack your head and lose consciousness.\n" \
"  You awaken in one of the Baron's cells.[ Place this character card inside the front cover of this book. If you ever have a character make it to the dungeons of this castle and release the prisoners this character will be free to exact his revenge.]"
},
{ // 27
"You silently slip inside the doorway. The Baron is sitting proudly on his throne. He sees you, but the four guards near the door do not. You slip up beside one of the guards and press a dagger to his throat. \"Just you and me, Baron.\"\n" \
"  The Baron smiles and draws his broadsword. To the guards he says, \"You are dismissed.\" Only one remains, his nephew. For this combat, go to {182}."
},
{ // 28
"Your weapon is knocked from your hand, only your shield protects you. You run up some stairs and burst onto the castle roof with the Baron in hot pursuit.\n" \
"  Make a first level Luck saving roll (20 - LK). If you make it, go to {184}. If you miss it, the Baron catches you and throws you off the roof. Oddly, you note, the fall is not fatal. Hitting the ground is."
},
{ // 29
"You round a corner in the corridor and discover you are in the dungeons. There are 1d + 1 prisoners in the cells. To free them you have to open the cells. You may pick the lock with a first level Dexterity saving roll (20 - DEX)[ or if you can do 15 points of damage to the lock you will open it].\n" \
"  For each turn you spend opening the doors roll one die. If it comes up a 1 you will have to fight a 4 dice, 6 adds guard with a CON of 12. Freed prisoners will join you, and you may pull prisoners from the front of this book (if there are any there), but no more than the number rolled above will join you. The others will flee. If you need more prisoners, just roll them up as you would new characters."
"  From here the only place you can go is up the stairs at {57}."
},
{ // 30
"You walk from the Soulcave and present yourself to the Headman of the Red Circle. He smiles and presents you a red strip of cloth to be your headband.\n" \
"  If you have a symbol on your chest, go to {148}. If you have scars on your face, go to {179}. If you have no special marks on your body, go to {65}."
},
{ // 31
"The carrion birds fly off and scream at you. They settle back down once you pass through their feast. You urge your horse forward and into the dark safety of the forest on the other side of the meadow. In no time you have left the caravan behind.\n" \
"  Make a first level saving roll on Luck (20 - LK). If you make it, go to {124}. If you miss it, go to {155}."
},
{ // 32
"Your approach was not as noiseless as you might have hoped. Roll two six sided dice, doubles add and reroll, as if you were making a saving roll. If your total is 10 or above, the first archer hidden in the brush has hit you. Roll for the second archer as well.\n" \
"  Each arrow that hits you will do 2 dice plus 5 in damage. Armour may be applied against the damage, but may not be doubled because you have been attacked from ambush. If you survive the arrows, you may run off, go to {64}, or you may fight the hidden warriors at {211}."
},
{ // 33
"Attacking when you are outnumbered and covered is not the brightest of moves, but it does show heart. The archers take careful aim and shoot. Their arrows, blunt varminting arrows, strike you in the head. You black out.\n" \
"  When you regain consciousness you find yourself stripped of your weaponry and tied to your saddle. You are being led into the Red Circle encampment. Go to {18}."
},
{ // 34
"Excerpt from Encyclopaedia Imperiana:\n" \
"  \"Dhesiri, also known as goblins in some locales, are generally small lizardman creatures who live underground in colonies. Dhesiri break down into one of three types. At the head of each colony is a Queen. She is a large snakelike monster whose sole purpose is to produce eggs and the various hormones that determine the product of those eggs. A queen can produce over one thousand eggs from one mating.\n" \
"  Most common are the workers. They stand 4' tall, are sexless and tailless. They mindlessly follow the orders of the Queen or a Warrior. They do all work, from gathering food to digging and tending the eggs. While they are extremely easy to kill they always attack in groups, overwhelming their prey.\n" \
"  Lastly there are the Warriors. They are twice the size of the workers and very male. They mate with the queen and are used to destroy major threats to the colony. It is rare to have more than a half dozen Warriors in a colony at any one time since their appetites are voracious and they are not above cannibalism.\n" \
"  Dhesiri prefer temperate or warm climates.\""
},
{ // 35
"\"A thousand years ago this was the tomb of Rex Sunwolf, first king of free Karesia. He united Karesia and freed it from the Empire. He was a great king and upon his death he was interred here, beneath Goblin Mountain.\n" \
"  \"His court wizard laid a curse on the tomb itself. The curse was in the form of a spell that would make any robber grow to 100 times his normal size, and would last for 1,000 years. The wizard expected most robbers to die in that time, but he did not anticipate a dragon being one of the first in here.\"\n" \
"  You leap back off the gold coins. The dragon laughs.\n"
"  \"Don't worry, expanding my bulk burned out the spell. Pack rats have stolen gold and jewels without any problem in the last four hundred years. In fact, if you wanted to, you could probably get Rex's last three treasures. Better you than the Dhesiri.\"\n" \
"  If you want to ask the dragon about Dhesiri, go to {129}. If you want to explore the cavern, go to {4}."
},
{ // 36
"Power floods through your body as your hands slip into the gauntlets. You ball your fists and the stone explodes.[ The gauntlets have formed themselves to your hands, they feel like a second skin.\n" \
"  Since you are very intelligent you grasp and can control the gauntlets and their full power. In addition to digging through 100 cubic feet of stone a turn at the cost of one Strength, the gauntlets will let you double your strength in combat for five turns in any one day.]\n" \
"  Sunwolf's shade smiles and fades; go to {6}."
},
{ // 37
"The Sword room has rainbow coloured walls. Hanging in the air, about 2' the ground, is the tip of the 6' long crystalline blade Rex Sunwolf was known to wield. It slowly spins, light glinting from it.\n" \
"  Beyond the sword stands a ghost. It is a tall, handsome man. It speaks to you. \"I am the ghost of Rex Sunwolf. I have long waited for someone to come take my sword. Though Sunshard was created for a hero, any who are worthy can wield it. Those who are not worthy will die by it.\"\n" \
"  If you decide not to try for the sword, go to {122}. If you decide to take it, make a Charisma saving roll on your own level. If you make it by 5 or more, go to {130}. If you make it by less than 5, go to {161}. If you miss it by rolling less than 5, go to {192}. All others, go to {69}."
},
{ // 38
"\"That sound you hear is the sound of Dhesiri tunnelling their way here. We'll be dead soon,\" is the dragon's reply.\n" \
"  If you want to go after one of the treasures you have not yet obtained, you may. The Hand room is {128}, the Helmet room is {190} and the Sword room is {37}. If you would like to prepare some defences against the Dhesiri attack, go to {122}. Keep track of the number of visits you have made to this paragraph - that number will be important at paragraph {122}."
},
{ // 39
"You grab a wooden bar and rip it free. You can use it as a quarterstaff. [Roll up the characteristics for the other prisoners and arm up to three of them with quarterstaves as well. With this crew ]you must battle the Dhesiri Warrior.\n" \
"  The Dhesiri Warrior gets 6 dice in combat and 3 dice worth of personal adds. His CON is equal to the roll of 4 dice, and his leathery skin takes 3 hits in combat.\n" \
"  If you kill it, everyone gets 100 experience points for it. Make a first level Luck saving roll (20 - LK). If you make it, go to {101}. If you miss it, go to {132}."
},
{ // 40
"This tunnel is fairly large and seems well travelled. The dusty floor is hard-packed, the earthen walls are trimmed of roots and stones. It runs on about a hundred yards into the darkness, then ends abruptly in a tangled ruin of debris.\n" \
"  Make a second level saving roll on IQ (25 - IQ). If you make it, read {71}. If you miss it, you have the choice of continuing on to {102} or you may retrace your steps to the Grand Gallery at {154}."
},
{ // 41
"You scramble to the surface with Dhesiri clawing at your heels. You kill a few that dare poke their heads above ground but you know you've only bought a little time. The Dhesiri horde will be after you yet.\n" \
"  Then you notice one of the prisoners. She rises to her full height and changes. Her voice becomes spectral and hollow. \"Free again, and granted the sunlight!\" Light sweeps over her and she is transformed into a beautiful Sun-nymph. A cold, grim expression captures her features.\n" \
"  She gestures at the hole in the ground. Light flies from her fingers and a Dhesiri leaving the hole is fried on the spot. Then, like water, the light pours down into the hole. You hear muffled screams, see light pouring from countless warren exits all over the landscape.\n" \
"  \"That will fix those disgusting creatures!\" She smiles, sweet and ice cold, at you. \"Thank you for your help.\" With that she turns into pure light and flies off to the sun.\n" \
"  The adventure is through for you. You get 10 points for each Dhesiri you killed, and a bonus of 1500 experience points for the adventure. You have succeeded in stopping the Dhesiri, which will stop the Red Circle from raiding. Try and tell anyone about it, though, and they'll assume the Sun-nymph you saw was a figment of your imagination.\n" \
"  [Oh, you can keep any other prisoners you created and escaped with you.\n" \
"  ]Thanks for playing."
},
{ // 42
"You slash and hack through some eggs; you know there are too many for you to ever be able to destroy. You decide you need a different plan to deal with this underground lake full of Dhesiri eggs. Go to {21}."
},
{ // 43
"You cautiously creep forward, hiding yourself as best you can. This close to freedom you don't want to be discovered and captured. Just as you are about to step into the sunlight the silhouette of a huge Warrior Dhesiri fills the opening.\n" \
"  The Dhesiri Warrior gets 6 dice in combat and 3 dice worth of adds. His CON is equal to the roll of four dice, and his thick, leathery hide takes three hits in combat. You must fight it unless you have the Dhesiri Amulet. In the latter case go to {167}. If you must fight do your best. If the fight lasts more than 5 combat rounds, make a second level Luck saving roll (25 - LK). If you make it, go to {105}. If you miss it, go to {96}. If you kill the Warrior, go to {74}."
},
{ // 44
"You look fairly tough to the guards seated in the tavern. One of them, a sergeant from the patch on his shoulder, comes over to harass you. \"New people are not much welcome in Valdemarton, especially worthless drifters like you.\" He draws his knife and cuts off a small slice of sausage and pops it in his mouth. He waits for your reaction.\n" \
"  You study him. He does not look that tough. You notice something unusual about him, but you cannot put your finger on it unless you make a second level saving roll on IQ (25 - IQ). If you make the saving roll, read {108} and return here immediately.\n" \
"  If you would like to attack the soldier with no warning, a less than honourable but more likely for success strategy, go to {169}. If you want to challenge him to an even duel out in the street, go to {170}. If you ignore his taunting, go to {201}."
},
{ // 45
"\"Yeah, I see 'em. Hundreds of 'em and a Queen. They followed her from the south when she was brought in. Told all this to Handar when he was here. Only got him killed. If you want them they's at the south face of Goblin Mountain.\"\n" \
"  He lapses into silence as the guards look over at you. If you want to talk with the guards, you may go to {138}. If you want to go to the inn, go to {137}. If you want to head out to where the prospector placed the Dhesiri den, go to {154}.\n" \
"  The last thing the prospector says is, \"Handar wanted the 50 gp bounty per scalp, but he never got paid in coin. Just cold steel.\""
},
{ // 46
"You stroll over to the sergeant and say, \"A friend of mine had a dagger like that once. How did you get it from him? He'd never give it up this side of the grave.\"\n" \
"  The sergeant looks up at you, wide eyed with innocence. \"I got it from his body. The Dhesiri got him. If he was your friend you might head off to the south face of Goblin Mountain. There you can avenge him.\"\n" \
"  If you want to head off in that direction, go to {154}. If you decide you'd rather quit the inn and head to the tavern, go to {75}. If you have decided that the sergeant is lying, and you want to lay in wait for him, go to {110}."
},
{ // 47
"In no time at all a group of ten warriors led by a red robed sorcerer confront you. You explain what happened, but you can see none of them believe you. The sorcerer gestures and a red light bathes your body. You black out.\n" \
"  You awaken and discover yourself painfully stretched out spread eagle on a table. You are naked. Sweat is pouring out of your body, the dungeon you are being held in is insufferably hot.\n" \
"  You lift your head and see the silhouette of a large man in the shadows. \"You slew two of my guards. I could have you tortured, broken, killed or worse, and no one could gainsay me. Still I sense honour in you, and I may have another way for you to work off the punishment due you for your crime. Are you interested?\"\n" \
"  Anything is better than this pain. You nod your head. The shadow withdraws and you are released from the table. You are taken to a room where you are bathed and freshly robed. Once you are ready, go to {15}."
},
{ // 48
"You step from the inn and are beset by the sergeant and four other men. They grab you before you can raise any weapon against them. Mercilessly they hammer you with punches and kicks. You black out. Go to {140}."
},
{ // 49
"The Dhesiri pit trap opens below you, sucking you and your horse down quickly. You would have leaped clear of the saddle but a stirrup got caught. As it is you are surrounded by hundreds of Dhesiri. If you do not have the Dhesiri amulet you are captured and bound. You are conducted as a prisoner to {8} and thrown into a cell.\n" \
"  If you have the Dhesiri amulet you are virtually ignored as they slaughter your horse. In that case you wander back into the Warren with the hunting party and find yourself, unmolested, at {154}, the Grand Gallery of the Dhesiri Warren."
},
{ // 50
"Between your Luck, Intelligence and experience you know you cannot trust this man any further than you could throw him. Despite your knowledge you feign ignorance.\n" \
"  The Baron smiles. \"Good. Rumour has it there are Dhesiri in the area, but everyone knows it is too cold for them here. I need an agent who will believe what I say, and will act on my knowledge.\"\n" \
"  You listen to him as he offers you a job in his personal guard. You agree to work for him, but decide to leave at the first opportunity. That opportunity comes later that night. You steal a horse and head out of town to the west; go to {171}. This little lesson in trust was worth 300 experience points."
},
{ // 51
"Your dash past the Warrior to the Egg Chamber is very successful. You artfully dodge his clawed swipe, then leap through the doorway. You noticed that he continued his attack and raked through a rope beside the doorway.\n" \
"  Your dive carries you far into the room. A wooden rack with spears crashes down behind you, and would have impaled you had you not jumped. You were very lucky. Go to {175}."
},
{ // 52
"The last rock rips free and the water rushes through the opening. Being as close as you are you get sucked into the opening. The water rushes you through a frothing underground river, but before you can drown, the river boils toward the surface and flings you out over the edge of a waterfall. Luckily you are out through the air and splash down in the small pond at the waterfall's base.\n" \
"  You swim to the pond's edge and, exhausted, pull yourself from the water. The eggs, many of them broken, are being washed away on the flood and out toward the ocean. Although costly to life, your effort succeeded and destroyed the Dhesiri threat to Karesia.\n" \
"  This adventure has earned you 2500 experience points."
},
{ // 53
"You dream you are running with a herd of wild deer. You spend whole seasons with them it seems. You feel the warmth of the summer sun, and the biting cold of a windy winter. You taste the delicate young shoots of plants in the spring, and you share the fear of hearing a predator stalking you. You watch their life cycle, you learn much from them.\n" \
"  What you bring away from the experience is an understanding of how a fawn can be safe by hiding. [With this understanding, if you can make an IQ saving roll against the IQ of anyone or thing pursuing you, you will avoid detection by remaining hidden in one place. This does not apply to when you are moving, only when you are still and hiding. ]Go to {30}."
},
{ // 54
"You find yourself in a dark cavern. Beneath your feet you feel coins, jewels and bones. You can see nothing in the darkness, but you hear the rustle of coins before you. Suddenly there is light, in the form of a gust of dragonfire heading straight at you!\n" \
"  Make a second level IQ saving roll (25 - IQ). If you miss it, your body is incinerated beyond recognition. You are dead. Go to {153}.\n" \
"  If you make the roll you feel the fire wash around you. You breathe it in and feel searing pain for the barest of moments. Then all is dark again and you awaken in the Soulcave.\n" \
"  On your chest is a black flame insign. You look around the cave and breathe out. A burst of flame erupts from your mouth. Because of your experience you can breathe flame. It costs you one Strength point per burst, may be used in combat while you fight with other weapons, and will generate dice equal to your current level.\n" \
"  You have been blessed. Go to {30}."
},
{ // 55
"The headman looks furious. \"Bind the outsider. Dispose of it!\" Two warriors move to comply.\n" \
"  Make a second level Strength saving roll (25 - ST). If you make it, you break free of your captors. You twist and run. You vault from a wagon and knock a rider from his horse. You settle yourself in the saddle, draw the broadsword from the saddle scabbard and prepare to fight your way free of the Red Circle crowd. Go to {117}."
},
{ // 56
"You slip around the corner right after the guard passes. He's heading up toward some stairs. Back in the direction he came from, you see a corridor. If you want to investigate the corridor, go to {29}. If you want to head up the stairs, go to {149}."
},
{ // 57
"Apparently you and the prisoners made enough noise to be noticed. On the stairs there are 1 dice + 2 guards. All the guards get 4 dice for their swords and 3 adds. The Constitution of the guards is 16 each.\n" \
"  If you are outnumbered you must stand and fight them. If you are victorious, you may go to {149}. If your allies outnumber the guards you may run ahead of them to {149}, breaking through the line of guards.[ (Fight the combat out with the prisoners versus the guards because, for each prisoner who dies if you abandon them you will lose 300 experience points from the final bonus.)]"
},
{ // 58
"You burst through the doors and within seconds lay two of the four guards out. A third lunges at you with his spear, you break it and punch him in the face. He collapses. The fourth guard near the door, the Baron's nephew, drops his sword and backs off.\n" \
"  You look at the Baron. \"Just you and me.\"\n" \
"  The Baron stands and draws his broadsword. \"Just you and me.\" Go to {182}."
},
{ // 59
"Barging or slipping into a room full of guards, and blowing the move, is not a bright idea. Suffice it to say the six men in here beat you senseless and have you sent down to the dungeon. Put this character inside the front cover of this book and save it until someone busts the prisoners out."
},
{ // 60
"The Baron knocks you from your feet, your weapon falls just out of your grasp. He places his sword at your throat. \"What have you to say before I kill you?\"\n" \
"  You tell him about the armband, and the fact that it will reveal traitors nearby. Make a first level Charisma saving roll (20 - CHR). If you make it, he believes you and takes the armband. He puts it on. Go to {185}.\n" \
"  If you fail the saving roll, he does not believe you and kills you by leaning forward on his sword."
},
{ // 61
"The dragon smiles, flames creeping from the corners of his mouth. \"That's the answer I'd give if I was in your shoes.\"\n" \
"  He puts you down. If you want to explore the cavern, go to {4}. If you want to talk with the dragon, go to {35}."
},
{ // 62
"The carrion birds scream protests at you when you dismount amid their feast. The stench of death is overwhelming. Most of the animals and warriors were killed by well placed bowshot, the black arrows with red fletching in evidence everywhere. You've seen worse deaths in your time as an adventurer, but never so much at one time.\n" \
"  There, from your right, you hear a moan. Someone is still alive. You rush over to a group of bodies, looking for the survivor.\n" \
"  Make a first level Luck saving roll (20 - LK). If you make it, go to {186}. If you miss it, go to {157}."
},
{ // 63
"One Red Circle member advances and strips you of your weapons. You are allowed to keep your horse and are led on a long two day ride to the Land of Warm Springs, the homeland of the Red Circle.\n" \
"  During this journey you may decide to escape. If you want to reconsider your surrender, you may do so either the first or second evening by going to {187}. If you want to remain with the Red Circle members, who do not mistreat or abuse you, go to {18}."
},
{ // 64
"Your move catches the Red Circle warriors by surprise. They shout curses at you, but do not pursue you. You count yourself as lucky until you hear them laugh. You feel doomed.\n" \
"  Go to {111}."
},
{ // 65
"The Headman grasps you firmly by the shoulders. \"Once you complete a mission for us you will be a full member of the Red Circle.\"\n" \
"  If you agree to do a mission for the Headman, roll one die. If it comes up odd, go to {116}. If it comes up even, go to {147}. If you want to refuse, go to {55}."
},
{ // 66
"\"Good, I'm glad you are a Dhesiri hunter. If they keep digging you should be up to your armpits in them before too long. They don't realize I'm the reason behind the warm springs in this area, and they see me as a source of food for their colony. If they kill me, though, they will be killing the young they have incubating in the Warren above us. But then again we did not create Dhesiri for their intelligence, we created them to bother humans.\"\n" \
"  His prognosis of future events does not sound good. If you would like to ask for specific points where the Dhesiri are going to come into the cavern so you can prepare defences, go to {159}. If you decide to scout the cavern out, go to {4}. If you want to search for a potential exit, go to {191}."
},
{ // 67
"You feel power ripple through your body, but you know you have not grasped the full power of these powerful gauntlets. With ease you withdraw your hands from the stone block, shredding it in the process.[ For you the gauntlets will dig through 100 cubic feet of stone per turn at the cost of one Strength.\n" \
"  The only problem you have with the gauntlets is that they have grafted themselves to your hands. You cannot remove them, but this is not bad. At least no one can ever take them away from you.]\n" \
"  The shade of Sunwolf fades, a grin on his face. Go to {6}."
},
{ // 68
"You settle the helmet over your head and feel very relaxed.[ You look around the room and see instantly any flaws in the walls and floor. You look out the doorway and see all the vulnerable spots on the dragon. In any combat you will be able to cut the value of an enemy's armour in half because you can see the flaws in it. This will not eliminate the effects of warrior training, but will allow warriors to get the face value of their armour alone.]\n" \
"  The shade of Rex Sunwolf fades with a smile on his face. Go to {6}."
},
{ // 69
"The ghost of Rex Sunwolf studies you critically. \"You are not a hero, but you are redeemable. Take my blade, and use it well.\" His ghost fades with a questioning look on his face.\n" \
"  The crystal sword is worth 8 dice in combat for you. It has no other special powers as far as you are concerned. Go to {6}."
},
{ // 70
"You are unlucky enough to have been selected as the next meal for the Dhesiri Queen. You are dragged by a horde of Dhesiri workers through a twisted maze of low tunnels to the Queen's chamber. Once there you are shocked by the sight and smell, and are determined to escape.\n" \
"  The Dhesiri Queen is huge, 12' long and fat like a walrus. Workers are spooning food into her mouth and carrying away the eggs she produces. It is a grotesque sight, especially when you realize you are next.\n" \
"  Make a first level Strength saving roll (20 - ST). If you make it, you snatch a femur up from a pile of bones on the floor and attack her. She cannot defend herself. Roll 6 dice for her CON. If your attack kills her outright in one round, go to {163}. If you only wound her, go to {194}. If you miss the saving roll, you struggle weakly while she devours you alive."
},
{ // 71
"It makes no sense to you for the Dhesiri to have constructed such a large tunnel that leads to nowhere. You look around at this end and find a lever set about 3' high in the wall. You pull it and hear a sound from back down the hallway. You smile, turn and head to the newly opened corridor heading south at {16}."
},
{ // 72
"This tunnel is somewhat smaller than the others, built to allow Dhesiri to pass two abreast. You follow it for a couple of twists and turns. Make a first level Luck saving roll (20 - LK). If you make it, go to {103}. If you miss it, go to {134}. If you have the Dhesiri amulet, go to {103}."
},
{ // 73
"You have had the dubious honour of discovering the living quarters of the Dhesiri Warriors. There are three of them here in this dark, dank hole strewn with bones and other debris. Each gets 6 dice in combat and has 3 dice worth of adds for their sheer size and ferocity. Their CONs equal the roll of 4 dice and they get 3 hits in armour for their leathery skin.\n" \
"  All of this information is actually academic. They raise an alarm and engage you just long enough for others to arrive. Go to {96}."
},
{ // 74
"The Warrior lies dead at your feet. He was worth 100 experience points. If you want to reenter the warren and seek out the queen to kill her, return to the Grand Gallery at {154}. If you want to quit the adventure at this point you may leave with a 1,000 experience point bonus for all you have done at this point."
},
{ // 75
"You step through the doors to the Dusty Rose and pause to let your eyes adjust to the relative darkness in the room. The place is fairly empty. There are two men in the black and gold livery of the Baron at a table back away from the door. An older man, a prospector from the look of him, is slumped asleep back on a bench by the fireplace. A couple of townies are seated at a table in the middle of the room, but they pay you no attention.\n" \
"  The bartender asks you what you want.\n" \
"  You order and drink deeply to cut the road dust from your throat. If you want to tell about the caravan slaughter, go to {199}. If you want to talk to the prospector about Dhesiri, go to {14}. If you want to talk with the guards about the Baron, go to {138}. If you want to talk to the townies about local events and news, go to {168}."
},
{ // 76
"Your attack goes smoothly. The smaller man is spun away by the sheer ferocity of your assault. He smacks the back of his head on a table and lands lifeless on the floor. His partner lunges with his dagger, but you avoid the attack. You turn his dagger back on him and in seconds he joins his companion in oblivion.\n" \
"  One of the townies grabs your arm. \"Quickly, you must get away. If the Baron finds you...\" If you want to head off with him, go to {139}. If you choose to ignore his advice, and wait around for the authorities to arrive, go to {47}."
},
{ // 77
"\"Sure, I seen Dhesiri. They're all over the Warm Springs area. Never had no trouble from the Red Circle until the Dhesiri arrived, curse them little dragonmen. Good thing the Baron has a 50 gp bounty on their scalps or they'd overrun all of us.\"\n" \
"  He adds a brief description of where he thinks their central warren is. If you want to leave town and head for it, go to {171}. If you want to talk to the guards about the Baron, go to {138}. If you want to break the news about the caravan, go to {199}."
},
{ // 78
"Each guard has a poniard (2 dice) and 3 personal adds. Each has a CON of 10.\n" \
"  If you slay them a townie grabs your arm and says, \"Quickly, you must get away. If the Baron finds you...\" If you want to head off with him, go to {139}. If you choose to ignore his advice and wait around for the authorities to arrive, go to {47}."
},
{ // 79
"The two of you arm yourselves and face the Baron's men. The two you have to fight each have a broadsword and 3 personal adds. Their CON is 10 each. If the fight takes more than 5 combat rounds, make a second level saving roll on Luck (25 - LK). If you make it, your compatriot has dispatched his guards and will fight with you (doubling your attack). If you miss, he has been killed and one more guard comes to join those opposing you.\n" \
"  If you survive alone you realize that he gave his life for you when he could merely have pointed you out to the guards and saved himself the trouble. You may either quit this adventure now, with 1000 aps, or you may decide to venture forth and rid the Barony of the evil ruler on its throne at {17}.\n" \
"  If Festus survives with you he'll note you really only have one option at this point. \"We should join the Red Circle. \" If you agree, go to {173}. If you want to decline his suggestion, you may leave the adventure with 1000 eps or can go after the Baron at {17}."
},
{ // 80
"Black water boils up from beneath you as an underground river washes the earth below you away. In seconds you are sucked down and everything, save your weapons and armour, is swept away from you. You manage to gulp down a lungful of air, but the wild ride through the dark underground river is too long for you to hold it. Just when you think you are going to drown you see light and are plucked from the river. Go to {127}."
},
{ // 81
"Eager to please the Baron you tell him everything you know about Dhesiri, and include a hint that there might be some about.\n" \
"  The Baron smiles. \"Good, I cannot stand ignorance. I need you to search the Dhesiri out and destroy them, or bring me proof they do not exist. Will you do that? I'll pay you 500 gold pieces for each Dhesiri you kill.\"\n" \
"  That is an incredible offer and you accept it. The Baron assigns a man to get you outfitted and on your way. You ride out of town toward the west and Goblin Mountain.\n" \
"  Make a second level Luck saving roll (25 - LK). If you make it, go to {205}. If you miss it, go to {20}. If the name Handar means anything to you, add 10 to your Luck for the sake of this saving roll."
},
{ // 82
"You artfully dodge the Dhesiri Warrior's clawed swipe. You rush on toward the Egg Chamber doorway.\n" \
"  Make a second level saving roll on Luck (25 - LK). If you make it, go to {144}. If you miss it, go to {113}."
},
{ // 83
"The obvious solution, it seems to you, is to drop pieces of the cavern ceiling down on the eggs. You study the roof and select a huge stalactite as a likely candidate for dropping. The most difficult part of the job, though, is getting to it. You'll have to climb.\n" \
"  Roll one die. This is the number of first level Dexterity saving rolls (20 - DEX) you'll have to make to get to the stalactite. If you miss a roll, roll dice equal to the number you missed by and take that as damage from the fall. At that point you'll have to start the climb all over again. Good luck.\n" \
"  When you get to the stalactite, go to {22}."
},
{ // 84
"You are torn from your sleep by the serpentine hiss of a Dhesiri worker. The dragonman leaps at you, his teeth and claws worth 2 dice in combat. He gets 2 adds and his CON is 5.\n" \
"  Fight the creature. If it kills you, go to {153}. If you defeat it, go to {30}. Note: even if it gets hits on you, you will not have any scars from this attack."
},
{ // 85
"\"While we allow outsiders to join us, the test to join is perilous. Are you willing to accept any risks of that test?\" The chieftain's voice reinforces the gravity of the words he has spoken. If you want to proceed, go to {123}. If you would like to ask to leave instead, go to {178}. If you want to perform a mission for them, go to {116} on the odd roll of one die or {147} on the even roll of a die."
},
{ // 86
"The Headman is very pleased. He pulls a silver armband from his own right arm and hands it to you. \"This armband is something no one should be without. If one you trust is about to strike you down it will warn you. I hope it helps.\"\n" \
"  You thank him. He appoints two guides and they lead you from Goblin Mountain on the ride to Valdemarton where you are directed toward a hidden passage into the Baron's castle. \"It goes in through the foundations of several previous castles built on the same spot,\" you are told.\n" \
"  You thank your guards, adjust the armband on your swordarm and head to {17}."
},
{ // 87
"You pivot around the corner and hit the guard walking the hall hard about the head and shoulders. He pitches forward on his face and stays down. You drag him back into the corridor, bind and gag him with his own clothing. He is out of the picture.\n" \
"  Out in the corridor you notice, off to the right, stairs leading up. The corridor he was walking down leads off to the left. If you want to follow the corridor left, go to {29}. If you want to head up the stairs, go to {149}."
},
{ // 88
"If you want to Stealth through the door, go to {151}. If you want to Power through the door, go to {183}. If you just want to knock and enter, go to {214}. Failure means the door is locked and your choices are {180} up the stairs or {213} to the doorway on this landing."
},
{ // 89
"You enter the throne room. The Baron is sitting in the throne across from the door. \"Did you think it would be this easy, getting here to kill me?\" he asks.\n" \
"  Make a first level IQ saving roll (20 - IQ). If you miss it, you stand still and answer him as four arrows shoot through your chest. This cuts down your ability to answer, and happens to kill you.\n" \
"  If you make the saving roll, you dash forward as the arrows smash into the door behind you. \"Enough games, Baron, now it's just you and me.\"\n" \
"  The Baron smiles. His nephew steps from the shadows to watch the fight. \"You don't mind my heir being here, do you?\"\n" \
"  You shake your head. He draws his broadsword. Go to {182}."
},
{ // 90
"You are knocked sprawling, your weapons flying far from reach. The Baron runs at you, his sword up high for the death blow.\n" \
"  Make a second level Dexterity saving roll (20 - DEX). If you succeed, you plant a foot in the Baron's stomach even as he is swinging at you, and flip him over onto his head where he breaks his neck. Go to {209}.\n" \
"  If you miss the roll you miss the foot placement, but the Baron does not miss you. You are terminated."
},
{ // 91
"You ride into the Red Circle's camp as bold as brass. A crowd quickly gathers, centring around you and the village chieftain. He is a thin old warrior, his silver hair bound back with a red headband. \"Rare is the adventurerer who can enter our camp unheralded.\"\n" \
"  You smile at the compliment. \"The raiding you are doing, it must stop.\" Your voice carries over the whole crowd and some of the warriors grumble.\n" \
"  The Chieftain smiles. \"There are two ways you can stop the raiding. One is to work for us and eliminate the cause of our discontent. The other is to kill us all.\"\n" \
"  If you decide to work for the Red Circle to help them, roll one die. If it comes up even, go to {147}. If it comes up odd go to {116}. If you decide that killing the Red Circle is preferable, go to {117}."
},
{ // 92
"On your way out of the Barony you scan the horizon, hoping perhaps for a glimpse of the dragon. You don't see him, but you do smile. There, far away on the horizon, you see a cloud of smoke that could only represent a castle burning.\n" \
"  Thank you for playing."
},
{ // 93
"The raiders' trail is painfully easy to pick up. No only did they neglect to hide their trail, but some of them blaze it with a circle surrounding a lightning bolt, a symbol of the Red Circle. Their arrogance annoys you slightly.\n" \
"  Suddenly the hackles rise on the back of your neck. Something feels wrong. Perhaps the trail was too obvious. There, ahead of you, something seems wrong.\n" \
"  You dismount and advance, weapon in hand and ready. Make a first level Dexterity saving roll (20 - DEX). If you make it, go to {1}. If you miss it, go to {32}."
},
{ // 94
"Your horse smashes into the three men. They are unhorsed, their mounts are a tangle of screaming animals. You race the beast down the road toward the nearest town, not pausing for fear the Red Circle warriors will catch up with you. Finally, at the top of a hill that lets you study your back trail. You are not being pursued.\n" \
"  There, on the horizon, is the next town. Go to {13}."
},
{ // 95
"The authorities in Esturiat are glad to hear about the loss of the caravan. Now they know to send more warriors with the next caravan.\n" \
"  You have earned 300 experience points for what you have seen and done so far. You may head back out and tell the next town down the line about the tragedy at {13} or you may leave well-enough alone and quit right now."
},
{ // 96
"The fight has raised enough of a commotion that Dhesiri from all over the warren come and overwhelm you. You are knocked unconscious, stripped of your weaponry, and carried off to the prison in the warren. You awaken at {8}.\n" \
"  [(The only nice thing about this turn of events is that your Alarm level drops back down to zero.) ]If you had the amulet when you arrived here, it is stripped from you in the fight."
},
{ // 97
"\"Well, join the club. I came in here to pad my trove and got caught in the old spell laid down by Rex Sunwolf's wizard. Old Rex didn't want anyone walking off with his treasures. The curse was to make the thief grow to 100 times his normal size, and the change was to last 1000 years. That would have killed someone like you, but not me.\n" \
"  \"If you're interested I think there are a few of Rex's trinkets still in here, aside from the gold that is...\n" \
"  You wander around and see three doorways. One has a pair of hands carved above it, the next a helmet and the last a sword. If you want to enter the Hand room, go to {128}. If you want to enter the Helmet room, go to {190}. If you want to enter the Sword room, go to {37}. If you are confused and want to ask the dragon what is really going on here, go to {5}."
},
{ // 98
"You fail to comprehend the incredible power these gauntlets can offer you. You struggle in vain to withdraw your hands from the gauntlets. The stone suddenly stops floating and drags you down to the ground. From outside you hear the dragon scream in pain and soon Dhesiri are swarming all over you. Mercifully your end is swift."
},
{ // 99
"The helmet settles onto your head with ease. You feel more confident, more sure of yourself. [While wearing the helmet ]you [will ]have a doubled Charisma[ for the purpose of leading others, avoiding the nasty effects of spells, and scaring foes off].\n" \
"  Sunwolf's shade fades with a smile on his face. Go to {6}."
},
{ // 100
"A horde of Dhesiri descend upon you in an ambush. These little 4' tall dragonmen use their teeth and claws in combat. Each gets 2 dice and 2 adds; they have a CON of 5.[ In fighting them, do not distribute hits evenly; divide the hits you do by 5, killing that number of Dhesiri, and apply the remainder to any Dhesiri left.]\n" \
"  Roll four dice. This is the number of Dhesiri who break off from the main attack on the dragon to attack you. In each combat turn roll one die: this is the number of Dhesiri that attack you in that round. For each subsequent round, roll the die again. If you beat your earlier roll, fight the higher number of foes. If you tie the old roll, add one to it and fight that number of Dhesiri. If your roll is lower than the number of foes you fought in the last round, you will fight the same number you fought last time. The only exception to this rule is if you have killed off all the Dhesiri facing you.\n" \
"  If you survive 7 combat rounds, go to {131}."
},
{ // 101
"[You catch, out of the corner of your eye, the motion of a Dhesiri running down the tunnel toward the ]G[rand Gallery. You may shoot it, a small target at medium range, or you may try to outrun it. For shooting it to be effective you must get at least 5 hits on it.\n" \
"  If you want to outrun it, roll one die. This represents the headstart it has. Roll three dice for it to give it a Speed rating. Make a first level Speed saving roll for it (20 - SPD) and one for yourself. If you both miss, your positions have not changed. If you make it and it misses, the difference between your total and its total is subtracted from the number you rolled above. If you both make it, the difference by which you made the roll is added or subtracted from the headstart number.\n" \
"  If you miss the roll and it makes it, it has escaped. Go to {132}. If the headstart number is reduced to zero or a negative number you have caught the Dhesiri and killed it. If the Dhesiri is dead, g]o to {10}.[ You get three chances at making the rolls to catch the Dhesiri. If you fail to catch it, go to {132}.]"
},
{ // 102
"Make a second level Luck saving roll (25 - LK). If you make it, go to {133}. If you miss it, the roof comes down as you step into the debris. You get tangled up in vines and sticks and dirt. Suddenly there are a dozen Dhesiri on you. They strip you of your weapons. You are pulled free of the deadfall trap and conducted to the south corridor and thrown into the prison there at {8}."
},
{ // 103
"A party of six workers passes you, ignoring you in the shadowed tunnel despite the squeeze. You are either very lucky or, for some reason, look to them like one of their own.\n" \
"  You wander deeper in the tunnel and come to an open pool of water. The water steams gently. You touch it and find it soothingly warm. Then, behind you, you hear Dhesiri voices.\n" \
"  If you want to stand and slay all the Dhesiri coming down the tunnel, go to {165}. If you want to slip into the water to hide, go to {196}."
},
{ // 104
"This northern tunnel is a little low but you manage to get through it with no problem. It ends in a large oval-shaped room. The walls have small alcoves carved in them, each alcove being home to a sleeping worker. The floor is littered with bones, debris and trash.\n" \
"  If you would like to search the floor for valuables, go to {166}. If you want to kill all the Dhesiri in the room, go to {135}. If you want to return to the Grand Gallery, go to {154}."
},
{ // 105
"The battle lasts for, what seems to you, an eternity. The Dhesiri Warrior knocks you down and raises one claw to rake your face off. Then, from outside the warren entrance, three arrows fly into his back. The Warrior stiffens and falls.\n" \
"  You scramble to your feet and run from the warren. You're stopped by three men, all of them wearing the red headbands of the Red Circle.\n" \
"  You thank them for your life. They smile. \"You can discharge your debt to us, if you wish. We need someone to slip into the castle of Baron Valdemar and kill him.\"\n" \
"  If you accept this mission, go to {56}. If you want to quit the adventure at this point, you get a bonus of 750 experience points for everything you've done."
},
{ // 106
"You knew from the first that even sober the guards would not be great fighters. You smash your tankard across the short one's face. He reels away unconscious. His partner hesitates, then draws his dagger. You parry his feeble cut and slam him into the bar. He grunts loudly and sinks to the floor.\n" \
"  From behind you, at the door, you hear mild applause. You turn and discover a handsome young man in the Baron's colours standing there. He nods a brief salute. \"I thank you for not killing them. They are stupid, but not so stupid as to be killed for it. I apologize for their treatment of you.\"\n" \
"  You briefly explain why you are in Valdemarton. The young man smiles. \"Let me assist you. I am Count Vlad. Valdemar is my uncle. I would be pleased to conduct you to him.\". Go to {15}."
},
{ // 107
"Despite your caution, the Baron's soldiers overheard your question. Your first sign of trouble comes from the look of horror in the prospector's eyes. You turn and see both guards rushing at you, weapons drawn.\n" \
"  Make a first level Dexterity saving roll (20 - DEX). If you make it, go to {78}. If you miss it, a glancing blow catches you on the head, knocking you out. Go to {140}."
},
{ // 108
"You recognize the knife the sergeant is using as one owned by Handar, a Dhesiri hunter from Boucan. You met him in Jania a year or two ago, and he commented about how that knife was the sweetest skinning blade a man could ever hope to handle. He said he'd never part with it in life."
},
{ // 109
"Make a first level saving roll on Charisma (20 - CHR). Add your current level number to this saving roll to reflect how experienced you look. If you make it, go to {200}. If you don't make it they laugh at you, calling you worthless. If you would like to challenge the sergeant to a duel, go to {170}. If you decide to leave, you may go to the tavern at {75} or you can ride out of town toward the west, the lands owned by the Red Circle, by going to {171}."
},
{ // 110
"The sergeant leaves the inn feeling quite light headed. You tackle him and drag him through the mud to some deep shadows. Drawing his dagger you press it up under his chin. \"There are odd things going on around here. You're going to tell me what is what or I will gig you like a frog.\"\n" \
"  The fear in his eyes is real. Words spill from his mouth like water from a fountain. \"The Baron sent a bunch of us to capture a Queen Dhesiri and put her near the south face of Goblin Mountain. They're all through this area now, and are supposed to drive the Red Circle out. The Red Circle has a treasure the Baron wants, but they don't know it.\"\n" \
"  From that point he babbles. If you want to head off toward the Dhesiri warren, go to {154}. If you have decided the Baron is evil and ought to be deposed, go to {17} to steal into his castle and kill him. If you decide you just want to ride away from this town you may go west to {171}, or any other direction out of the adventure with 1000 eps."
},
{ // 111
"The ground beneath you shifts. Make a first level Luck saving roll (20 - LK). If you make it, go to {80}. If you miss it, you feel legions of grasping claws dragging you down into the boiling earth. You know it must be a Dhesiri hunting party, but you cannot raise an alarm or accurately defend yourself before you have been pulled out of sight.\n" \
"  If you have the Dhesiri amulet, the stupid little dragonmen ignore you and tunnel on hunting better prey. You brush off the dirt and, stooping over in the narrow tunnel, backtrack them and discover yourself in the Grand Gallery of the Dhesiri warren at {154}. If you do not have the amulet, you are bound and carried back to the warren. You are thrown into a cell at {8}."
},
{ // 112
"Roll 6 dice. This is the Queen's Constitution. If your damage kills her outright, go to {163}. If you only wound her, go to {194}."
},
{ // 113
"While you dodged the Dhesiri Warrior's clawed swipe, you failed to attach significance to the rope it snapped as it followed through with the blow. The rope released a rack of spears that crashed down in the Egg Chamber doorway.\n" \
"  This is of interest to you because you are caught by it as it falls. The spears do enough damage to you to kill you. This means the adventure is over for you. Better luck next time."
},
{ // 114
"You dream yourself in a thick, green jungle. You feel you are being stalked. You panic and run, but broad tree trunks box you in. You turn and turn but cannot escape the small clearing you are in. You hear something, spin and look behind you. Advancing on you is a huge tiger.\n" \
"  You see the tiger gather itself back on powerful haunches to pounce. It leaps and shrinks as it flies through the air. The size of a small statuette, it strikes you lightly and dissolves into your chest!\n" \
"  Make a second level IQ saving roll (25 - IQ). If you miss it, you feel your heart seize and burn. You fall over dead. Go immediately to {153}.\n" \
"  If you make it, you see the outline of a tiger paw appear in the middle of your chest.[ At will you may shift into the form of a were-tiger as outlined in the Tunnels and Trolls rules.]\n" \
"  Your test is finished; go to {30}."
},
{ // 115
"Your sleep is dreamless. Your experience within the Soulcave is painfully average (as was your die roll). Console yourself with the fact there was no way, with this die roll, to fail your test. Go to {30}."
},
{ // 116
"The Headman smiles at your decision. \"We have a problem. Dhesiri have been brought to a sacred series of caverns in Goblin Mountain here. We cannot go in and destroy them, but we can and will help you if you want to kill the queen and destroy the hatchlings.\"\n" \
"  If you are willing to accept this task, go to {24}. If you refuse, go to {55}."
},
{ // 117
"The chieftain points at you. \"Slay the outsider!\"\n" \
"  On horseback your chances of survival are fairly good. [For each combat round you spend in the village roll your dice. Divide your combat total by 10. This is the number of Red Circle people you kill per round. Each is worth 20 eps.\n" \
"  For each round you also need to make a first level Luck saving roll (20 - LK). ]T[he number you miss it by is the number of hits you take in combat during that round.\n" \
"  On any round you make the Luck saving roll you may decide to escape instead of fighting. If you choose t]o escape, go to {25}."
},
{ // 118
"The guard wandering the hallway doesn't even see you in the shadows. He walks past and up some stairs to the right. He came from down the corridor to the left. If you would like to head up the stairs, go to {149}. If you want to head down the corridor, go to {29}."
},
{ // 119
"Failure at such a crucial junction as this is very dangerous. In this case it is fatal. The Baron had four men with spears waiting near the doorway. Your entrance was detected and they used their spears to good effect. Unfortunately that disrupts your internal organs and causes you terminal discomfort.\n" \
"  Your adventure is at an end. Good luck next time."
},
{ // 120
"This is one of those instances when the Power approach might not have been the best idea. There are six guards in here. Each gets 4 dice for his sword and has 3 adds. All have a CON of 12. Because you powered into the room you will get a free combat round. I hope you trim them down enough because if you don't you are history.\n" \
"  If you survive, you can head up the stairs at {180}."
},
{ // 121
"The armband tickles your arm. You cut to the left, driving your weapon back through the space where you had been standing. The blonde had just lunged at your back with a dagger. Your blow takes her in the head and kills her instantly.\n" \
"  The Baron is on his feet. A look of shock washes over his face. He dismisses his guards, only his nephew remains.\n" \
"  \"Just you and me,\" he says.\n" \
"  [Because you have just slain his mistress in front of his eyes you may multiply your combat rolls by 120% to account for his distraction. ]Go to {182}."
},
{ // 122
"Roll two dice and subtract from that total 5 times the number of visits to paragraph {38} you have made. If the resulting number is zero or negative, go to {100}.\n" \
"  [If the number is positive, it represents the number of turns you have to construct defences against the coming Dhesiri. The dragon is nice enough to point out places where they will be coming through, and he even managed to help you move some boulders around to make a wall.\n" \
"  For each turn, make a first level IQ saving roll (20 - IQ). For each saving roll you make, roll one die. The total of the dice will be the \"armour\" you have behind your fortress. It will not wear out but cannot be doubled if you are a warrior.\n" \
"  ]Good luck because here they come. Go to {7}."
},
{ // 123
"You are led to a dark, warm cavern high in Goblin Mountain. You are [stripped of your clothing and ]told to drink from an earthenware bowl. The liquid in the bowl is noxious stuff, but you begin to drift off into a stupor before you have finished it. You seat yourself and begin to dream.\n" \
"  Roll two dice. Go to the paragraph that corresponds to the die roll on the table below. 2={114}, 3={176}, 4={207}, 5={53}, 6={84}, 7={115}, 8={146}, 9={177}, 10={208}, 11={23}, 12={54}."
},
{ // 124
"You duck your head to avoid a low hanging branch. A lasso snakes out through the air but misses you. You dig your heels into your horse's ribs and it bolts forward. There are shouts from behind you, but you ride low, pulling your horse left and right. Arrows whistle past your head.\n" \
"  Ahead of you are three members of the Red Circle. Each is a man mounted on a horse. They wear no armour, are armed with broadswords and wear red headbands. They are not a savoury lot.\n" \
"  If you wish to rein up short and surrender, go to {63}. If you urge your horse on to charge through the trio, go to {94}. If you want to turn your horse off the roadway, and race the beast down the hill to your left, go to {2}."
},
{ // 125
"You startle both of them. You talk and they listen, and they decide to trust you, and you them. They take you back to their encampment, a huge village, and introduce you to the Headman of the Red Circle.\n" \
"  \"You seem trustworthy. I have a job that needs doing. Are you willing to undertake it?\"\n" \
"  If you accept the job, go to {116}. If you refuse, go to {55}."
},
{ // 126
"[To reach Alarm level 6 you must have done a great deal, or been very unlucky. Well, you'll have to do more or your luck will have to improve to survive now.\n" \
"  With each new group of Dhesiri you will have to face a Dhesiri Warrior. The Warriors are huge, 8' tall and full of muscle and claw. They get 6 dice in combat and 3 dice worth of adds. Their CON is equal to the roll of 4 dice and their skin takes 3 hits in combat like armour.\n" \
"  There is one nice thing: there are only six Warriors in the warren, and three of them are guarding specific sites, so if you killed three Warriors you will no longer have to worry about them. Good luck. ]Return to the paragraph you were playing."
},
{ // 127
"Dripping wet, you are being dangled high in the air by a dragon. He has you neatly and gently held in the razor-edged talons of one massive claw. Smoke curls and drifts lightly upward from his golden muzzle; his green-gold eyes study you with the fascination of a child watching a bug before he squashes it.\n" \
"  This dragon is much larger than you have ever imagined any dragon could be. Beyond it you can see a huge cavern; the dragon virtually fills it, but there is no entrance large enough for the dragon to have entered the cave. The floor beneath the dragon is littered with gold and jewels.\n" \
"  The dragon's eyes slit and a clear membrane nictitates up over the lower half of the malachite orbs. \"Friend or foe?\" it asks fatefully.\n" \
"  If you answer friend, go to {61}. If you answer foe, go to {158}. If you shrug your shoulders, go to {188}."
},
{ // 128
"The Hand room is small and very dark. The walls of the room sparkle as if diamonds are set in the walls. Still, the walls have a distant feel that makes it easy for you to imagine they are the night sky and the diamonds are stars.\n" \
"  Floating in the middle of the room, about 4' off the ground, is a solid block of grey granite with two ornate and handsomely worked gauntlets sticking out of it. The gauntlets are positioned so you could slip your hands into them with ease. In fact, they look inviting.\n" \
"  Beyond the block you see a ghost materialize like fog rolling into city streets. It is of a tall man, strong and handsome, wearing a crown and armour still famous even so many years after his death. It speaks. \"I am the shade of Rex Sunwolf. I have waited for a hero to come claim my gauntlets. If you succeed, great power can become yours. If you fail, you will be trapped here. The choice is yours.\"\n" \
"  If you choose not to try for the gauntlets, go to {122}. If you choose to try for them, slip your hands into them and make a second level saving roll on IQ (25 - IQ). If you make it by 5 or more, go to {36}. If you make it by less than 5, go to {67}. If you miss it, go to {98}."
},
{ // 129
"\"Dhesiri are disgusting little lizardmen,\" the dragon shrugged. \"Dragons created them eons ago. We gave them all the annoying habits we saw in humans, and made them prolific. We also made them stupid so they would constantly bedevil mankind.\" The dragon looks down at you and a low, rumbling chuckle booms like thunder in his broad chest.\n" \
"  \"The majority of them, workers, stand about 4' tall and do one of three things: get food, care for the Queen and her young, or dig more tunnels. The Queen does nothing but lay eggs. The Warriors, larger workers, do nothing but kill. With any luck those burrowing in here will have a few Warriors with them; workers are so clumsy when they kill, it could take us a long time to die.\"\n" \
"  If you would like to ask the dragon about setting up defences against the Dhesiri, go to {159}. If you'd like to search for a way out of here, go to {191}. You can explore the cavern at {4} if you wish."
},
{ // 130
"Your fingers wrap around the crystal hilt of the sword and it slowly stops its spinning. The blade is perfectly balanced for you and the hilt feels cool to the touch. The edge is sharper than a razor, and therein, you sense, is its power for you. [If you inflict damage on a foe the wound will not close until you will it to be healed. This means the wounded enemy will be bled to death, losing half a six sided die (1-3) in damage each turn. Magic may repair that damage, replacing the CON, but the wound will continue to bleed until you, of your own free will, wish it to heal. The only wounds this will not hold true for are wounds inflicted outside a battle. (If you cut someone slightly in an attempt at assassination, the magic in the sword will not work.) ]This is truly a weapon worthy of a hero, and one you will greatly need in the near future.\n" \
"  The sword is worth 8 dice in combat. The shade of Rex Sunwolf fades with a smile on his face. Go to {6}."
},
{ // 131
"Your arms are weary from the fighting. More Dhesiri are pouring into the cavern. You know you are going to be overwhelmed, your death is at hand. Then it happens.\n" \
"  A sheet of dragonfire washes the Dhesiri away from you. You turn and see the dragon, now normal size, sitting up, lacing the cavern with ropes of fire. Dhesiri are flung high and wide as the dragon shakes itself like a dog flinging off fleas.\n" \
"  The Dhesiri are caught in a sea of flame. They realize, all too late, the battle is lost. They try to retreat but the dragon has torched their tunnels. Mindlessly they run into the inferno and are killed.\n" \
"  When the last Dhesiri is dead the dragon laughs and lies back down. \"What timing! The thousand year curse wore off with not a second to spare!\"\n" \
"  You and the dragon have destroyed the Dhesiri threat. You get 10 experience points for each Dhesiri you killed plus a bonus of 1500 points for surviving the battle. If you wish, you may quit the adventure now, carrying any weaponry you have gained and a small sack with 6 gems in it (roll on the treasure table). Or you may discuss what has gone on with the dragon. If you choose to discuss, go to {162}."
},
{ // 132
"A Dhesiri has run to the Grand Gallery and given the alarm. Dhesiri come pouring into the prison from all over the warren. You have one chance for survival. You march into the tunnel, plant your feet and begin to kill Dhesiri.\n" \
"  Each Dhesiri is worth 2 dice and 2 adds, with a CON of 5. At any one time two dice worth can get at you. For each round roll the two dice and fight that number of Dhesiri.[ You start the battle 12' forward in the tunnel. For each round you lose, divide the hits you normally would have to take from the combat by 10. That is the number of feet you are forced back. You take no damage from the combat, but you do get pushed back. There is no way you can recover ground you have lost. Once you have lost 12' you will be overwhelmed.]\n" \
"  The prisoners in the prison are busily digging a tunnel to the surface. Each one can dig 1' per combat round. They are 4d6 feet from the surface. If you are forced back into the prison you will be slain. If you hold the Dhesiri off long enough for the surface to be reached, go to {41}."
},
{ // 133
"The debris at that end of the tunnel looks untrustworthy so you approach it cautiously. You steady yourself by grabbing a piece of wood stuck in the tunnel wall. It shifts and you hear a sound back to the west. You look and see another tunnel has opened to the south. You smile and decide to investigate. Go to {154}."
},
{ // 134
"A band of six workers rounds a corner and runs smack into you. Instantly you're in combat.\n" \
"  Each of them is worth 2 dice and 2 adds. Each has a CON of 5. If the fight goes longer than 5 rounds, go to {96}. [If you live through the combat, raise your Alarm level by 1. ]If you win, you may press on and investigate the warm spring in the chamber at the end of this hallway or may return to the Grand Gallery at {154}. To investigate the spring, go to {11}."
},
{ // 135
"R[oll six dice. This is the number of Dhesiri sleeping in this chamber. Roll your attack and divide the number by 5. That is the number of Dhesiri you kill in one round. If you have a remainder of 1 or 2 you have lightly wounded one of them and it will raise an alarm. Raise your Alarm level by one for each time you leave a Dhesiri lightly wounded and deal with that emergency at that point.\n" \
"  Any Dhesiri with 3 or 4 hits on its CON of 5 is unconscious and unable to sound an alarm. You get 10 experience points for each Dhesiri you kill. Once you are finished killing Dhesiri, you may r]eturn to the Grand Gallery at {154} for another choice of tunnel."
},
{ // 136
"This tunnel slopes up toward the surface. It is one of the tunnels out of the warren. If you want to leave the Dhesiri behind, go to {43}. If you want to still lurk around in the warren, return to the Grand Gallery at {154}."
},
{ // 137
"The quaint little inn feels friendly and homey. A pleasant faced woman wipes her hands on a calico apron and greets you. \"Welcome to the inn. Would you be wanting a room or just a meal?\"\n" \
"  You opt for a meal, for the time being, and are conducted into the common room. There you see three men dressed as the Baron's guards seated at one table, and about a dozen townies all nursing ales sitting elsewhere. You select a table alone and sit with your back to the corner of the room.\n" \
"  Make a first level saving roll on Charisma (20 - CHR), adding your current level number to your Charisma for the purpose of the roll. (This reflects how experienced you look.) If you make it, go to {44}. If you miss it, go to {198}."
},
{ // 138
"As bold as brass you walk up to the two guards. \"I'm new in this town. What are the rules and regulations? Is your Baron hiring, and is there a reason I'd want to work for him?\"\n" \
"  The guards look you over. Make a first level Charisma saving roll (20 - CHR), adding your current level number to your Charisma for the purpose of this saving roll. (This reflects how experienced you look.)\n" \
"  If you make it, go to {200}. If you miss it, they rise up and verbally abuse you. One drops a hand to a dagger. Go to {76}."
},
{ // 139
"You hurry from town with your new friend. On the journey to his farm he tells you about the Baron and his men. \"The Baron is deeply in debt. He spends great deals of money on foolish projects, most of them looking for lost treasures he can use to finance more expeditions. I know because he pressed me into service on one of his digs.\n" \
"  \"He thinks the Red Circle are sitting on top of a treasure trove and he's trying to get them all killed. Whatever he's done has made them mad and they raid all over this barony to exact revenge.\"\n" \
"  You reach his farm, but before he can introduce you to his family or offer you any food riders crest the hill a mile back. \"Looks like the Baron's men, after you or me or both of us.\"\n" \
"  Your friend, Festus, offers you two choices. Either you can stand with him and fight off the soldiers at {79} or you can hide in the root cellar at {172}."
},
{ // 140
"You awaken with your head splitting. A man stands over you in the cell where you have been thrown. \"Brawling in public is an offence, but the Baron is lenient with outsiders. If you wish, he might pardon you in return for some work.\"\n" \
"  You have nothing to lose so you agree. You are taken to a room and bathed. You are given a clean robe and conducted to {15} and the Baron."
},
{ // 141
"A thin, handsome man in the Baron's colours steps over the body. \"In this death you have given the sergeant more honour than he has granted his victims. I am impressed. I think my uncle the Baron would like to speak with you. If you permit me I will conduct you to him.\"\n" \
"  You are surprised at his reaction to the death of one of his men, but you agree to go with him. Go to {15}."
},
{ // 142
"The Baron rises from his throne and claps his hands. \"Guards, take this petty adventurer away. He has insulted me!\"\n" \
"  You look around and find yourself surrounded by a dozen men with spears. Your chances of survival, if you resisted, would be nil. Take this character and tuck him inside the front cover of this book. If you ever get a character into the castle and the prisoners are freed, this character would be free. Until then, this character languishes in the dungeon."
},
{ // 143
"The Dhesiri Warrior gets 6 dice and 3 dice worth of adds in combat for his teeth and claws. His CON is equal to the roll of 4 dice, and his leathery hide takes 3 hits in combat just like armour. If the fight takes longer than 5 combat rounds, go to {96}. Dead, the Warrior is worth 100 experience points.\n" \
"  Once he is dispatched there is nothing that will stop you from killing the Queen. Roll 6 dice to determine her CON and attack her. If you kill her outright in the first round, go to {163}. If you only wound her, go to {194}."
},
{ // 144
"You have an uneasy feeling about the Warrior's attack. He missed you by a mile, but his follow through broke a rope. At the last second you leap through the Egg Chamber doorway.\n" \
"  A rack of spears crashes down behind you. Your leap carried you beyond it and into the Egg Chamber. Go to {175}."
},
{ // 145
"While you sit there thinking you become mesmerized by the warmth and peaceful quiet of the cavern. This, unfortunately, is not a good idea. A Dhesiri Warrior, on a regular patrol of the area, discovers you here and breaks your neck. At least you have the comforting knowledge that your last moments were peaceful..."
},
{ // 146
"Your dream is abruptly shredded when a man in Baron Valdemar's livery grabs you by the throat.\n" \
"  Make a first level Strength saving roll (20 - ST). If you make it, you break his grip and can fight him evenly. He gets one die for his hands and has 4 combat adds. His CON is 15.\n" \
"  If you miss the roll, subtract 5 from your CON and try again. Continue trying to break free until you succeed or until he kills you. If you kill him, go to {30}. If he kills you, go to {153}."
},
{ // 147
"The Headman smiles at your decision. \"We have a problem. Baron Valdemar wants us out of this area around Goblin Mountain. He brought Dhesiri to this area and they are driving us out of our homes. We need someone to enter his castle and kill him. Will you do this for us?\"\n" \
"  If you agree, go to {86}. If you refuse, go to {55}."
},
{ // 148
"The Headman touches your shoulder. \"By the mark on your chest I know you have been selected for great things. I release you from any obligation to us. You are free to go on your way.\"\n" \
"  Your adventure here is finished. You have earned a bonus 2000 experience points. Congratulations, you have won."
},
{ // 149
"You reach the first landing. The stairs continue forward and up. To the right there is a doorway. To the left there is a closed door.\n" \
"  If you want to continue up the stairs, go to {180}. If you want to deal with the doorway, go to {213}. If you want to deal with the door, go to {88}."
},
{ // 150
"You are fortunate. You see a half dozen guards in this room before they see you. You can back out and either choose to go up the stairs at {180} or investigate the door across the landing at {88}."
},
{ // 151
"You are in a curious position. You have slipped into the room somewhat silently. Facing you is a beautiful blonde woman. She has a crossbow levelled at your chest.\n" \
"  Make a first level Charisma saving roll (20 - CHR), adding 5 to your Charisma if you've seen her before. If you make it, she puts the crossbow down. \"I suppose you've come to kill the Baron? This way, I know a secret.\" Go to {181}.\n" \
"  If you miss the roll, she drills you. You are dead."
},
{ // 152
"In the polished interior of the silver shield, you see movement behind you. You step to the right and swing the shield back through where you had been. The blonde woman was lunging with a dagger toward your back. The shield catches her in the head. She drops to the floor, quite dead.\n" \
"  The Baron stands, his face drained of colour. \"Just you and me.\" He dismisses his guards, only his nephew remains in the room with the two of you.\n" \
"  [Because you have just killed his mistress right before his eyes you will get a 20% bonus to your combat rolls to reflect his state of distraction. ]Go to {182}."
},
{ // 153
"Two members of the Red Circle shake their heads as they carry your body from the Soulcave. You are not the first to die there, and probably not the last. You are done."
},
{ // 154
"This is the Grand Gallery of the Dhesiri warren. To you it looks like the inside of a wheel hub with tunnels running out of it like spokes - a central hole in the warren where all the tunnels come together.\n" \
"  [Though the warren is dark there is a chance you will be discovered. Because the Dhesiri, as a race, are stupid, it will only be through the failure of your luck that they discover you. With each paragraph where you move you must make a Luck saving roll. The first will be a \"zero\" level saving roll. Roll two dice as you would in a normal saving roll. You can only miss this one if you fail to roll a five or more.\n" \
"  For each failed saving roll you must add one to the level of the saving roll you are trying to make. In addition you must roll one die, add in the current level of your saving roll (hereafter Alarm level) and fight that number of 2 dice, 2 adds, 5 CON Dhesiri. If the fight ever takes longer that 5 combat rounds, go to {96}. If the Alarm level ever reaches 6, go to {126}.\n" \
"  If you have the Dhesiri amulet you may ignore the above.\n" \
"  ]There are six different tunnels that are large enough to accommodate you. They are north {104}, east {40}, south {164}, southwest {72}, west {136}, northwest {197}. In addition to those choices, if you would like to take a moment[, risking discovery,] to recall everything you know about Dhesiri you may do so by going to {34}. Lastly you will probably want to note the number of this paragraph, {154}, so you can return to it when fighting is needed."
},
{ // 155
"A lasso settles itself around your throat, tightens, and jerks you from the saddle. You land hard in the road, incurring one die of damage in the process (armour does apply[ but cannot be doubled]). You rise and throw off the rope only to discover yourself surrounded by five members of the Red Circle.\n" \
"  Two of them have bows drawn and arrows pointed at you. The other three are armed with broadswords. None of them wear armour, but all of them have red headbands, a mark of the Red Circle.\n" \
"  If you wish to surrender, go to {63}. If you want to draw your weapon and attack, go to {33}. If you want to run off to the left, downhill, go to {64}."
},
{ // 156
"Both of them, as nervous as they are, shoot at you. Make a first level saving roll on Luck (20 - LK). If you make it, they miss their shots and you may attack them as if they were unarmed for the first combat round at {211}. If they hit, each arrow does 2 dice plus 5 damage. If you are not killed, go to {211} and fight for your life."
},
{ // 157
"The survivor you locate is a member of the Red Circle. Fury and defiance blazes in his eyes. He's been stabbed through the stomach, and though he must be in great pain, he gives no sign of it.\n" \
"  \"We will kill you all until you stop hunting us. Baron Valdemar will not have our lands. The lands of Warm Springs are ours.\"\n" \
"  His eyes roll to heaven and he dies in your arms. You are surprised by his words. You know Baron Valdemar is a local noble, one known for his pride in his title and the lack of gold in his treasury.\n" \
"  If you want to head into the nearest village to investigate the Baron, go to {13}. If you want to backtrack the raiders, go to {93}. If you decide to return to the last village to report the demise of the caravan, go to {95}."
},
{ // 158
"Make a first level saving roll on IQ (20 - IQ). If you miss it, go to {189}. If you make it, you reply \"foe\" with a smile on your face. The dragon stares at you for a moment, flames rising up toward your feet.\n" \
"  The dragon shakes his head. \"Stuck here for 1,000 years and I get a joker for a companion.\" He sets you down.\n" \
"  If you would like him to explain that remark, go to {35}. If you want to explore the cavern, go to {4}."
},
{ // 159
"[Roll two dice. This is the number of turns you have to construct defences against the coming Dhesiri. The dragon is nice enough to point out places where they will be coming through, and he even managed to help you move some boulders around to make a wall.\n" \
"  For each turn, make a first level IQ saving roll (20 - IQ). For each saving roll you make, roll one die. The total of the dice will be the \"armour\" you have behind your fortress. It will not wear out but cannot be doubled if you are a warrior.\n" \
"  ]Good luck because here they come. Go to {7}."
},
{ // 160
"Unfortunately for you the helmet does not want to be yours. With alarming swiftness it contracts, crushing your head. You fall lifeless to the floor. Your only consolation might be that the Dhesiri that discover your body also try the helmet on, and they die in droves before one of them kicks it off into the shadows."
},
{ // 161
"The sword's hilt is cool to your touch. The blade feels light and balanced. It is a good weapon[, and one that you will get better with as you practice with it].\n" \
"  I[n any combat you may increase the hits done by the sword (before personal adds are included), equal to a percentage determined by multiplying your level number by 10. A first level character would get an increase of 10% in a combat round. This option costs Strength equal to the character's level number, and i]f the character's Strength ever drops to 5 or below, he will not be able to wield the blade. The sword itself is worth 8 dice in combat.\n" \
"  Rex Sunwolf's ghost fades smiling. Go to {6}."
},
{ // 162
"The dragon agrees that the Dhesiri threat has been destroyed, yet he notes, \"The evil that brought the Dhesiri here still rules the land. What he did once he could do again. I think he should be taught a lesson.\"\n" \
"  If you want to accompany the dragon on his raid on the Baron, go to {193}. If you decide to leave the adventure here you still get 10 points per Dhesiri, a 1500 point bonus and {6} gems. In this latter case, go to {92}."
},
{ // 163
"The Queen dies from your attack. As she dies she exudes a strong scent and the other Dhesiri present go mad. They start clawing at the walls and attacking each other. The scent, it would appear, was a signal to fight and kill, but was not directed at any target. The colony, by order of the Queen, is destroying itself.\n" \
"  You run from the Queen's chamber and out of the warren. All around you there are dying Dhesiri. You catch a glimpse of a couple of Dhesiri Warriors shredding each other, but you feel absolutely no remorse or regret.\n" \
"  You win free of the warren and stand in the warm sunlight. You have succeeded in destroying the Dhesiri colony, which will relieve pressure on the Red Circle, stopping their raiding. You have won.\n" \
"  The adventure is over for you. You get a bonus of 2500 experience points for having destroyed the Dhesiri Queen."
},
{ // 164
"The south corridor is dark and smells different from the warren in general. As you round a corner you see why. The chamber at the end of this tunnel is the prison where prospective meals are kept before they are eaten. There is 1 die worth of humans in the cells. They are being warded by a Dhesiri Warrior!\n" \
"  The Dhesiri Warrior is huge, fully 8' tall. It has thick leathery skin that will take 3 hits in combat. It fights with teeth and claws, an awesome 6 dice worth. Roll three dice for its personal adds. It has a CON equal to the roll of four dice.\n" \
"  If you want to attack it, do so now. If the fight takes more than 5 combat rounds, go to {96}. If you kill it, go to {195}."
},
{ // 165
"The two dice worth of Dhesiri who enter the room attack ferociously. Each is worth 2 dice and 2 adds in combat, and each has a CON of 5. [When you get hits on them, divide the number of hits by 5 and count that number of Dhesiri as dead. Even if you lose a round you may count half your hit point total against your foes as they are unconcerned with defence. ]If the fight goes longer than 5 rounds, go to {96}. If you survive the fight you may return to the Grand Gallery at {154}, or may give the warm pool a better look at {11}."
},
{ // 166
"The trash is fairly consistent in quality and type, suggesting to you that the Dhesiri find round stones and shiny bits of metal attractive. You find 3 dice worth of gold pieces in gold nuggets.\n" \
"  [Make a first level saving roll on Luck (20 - LK). If you make it, no Dhesiri wakes up to see you looting the common treasure. If you miss it, one wakes up. If you can kill it with a thrown dagger or other hand held missile weapon (no time to fit arrow to bow here), the Dhesiri being a small target at pointblank range; make the attack. If it dies - it has a CON of 5 - ]you may either kill all the other Dhesiri at {135} or you may return to the Grand Gallery at {154}.[\n" \
"  If you cannot kill it instantly, raise your Alarm level by one and treat the situation as if you missed your saving roll. This does apply for those who have the Dhesiri amulet. If you survive, the options above apply to you.]"
},
{ // 167
"Because you have the Amulet the Warrior does not give you a second glance. You leave the warren and, once out of sight of the Warren, you sink to the ground and sigh.\n" \
"  If you want to return to the warren, to try to locate the destroy the queen you may return to the Grand Gallery at {154}. If you want to quit the adventure here, you may do so. You get a bonus of 500 experience points for all you have done so far."
},
{ // 168
"The townies seem a bit reluctant to talk about anything with the Baron's guards in the area. One of them, seated with his back to the guards, mouths the words, \"Follow my lead.\"\n" \
"  You nod your understanding.\n" \
"  He smiles at you. \"I thought you looked familiar. I've not seen you since my wife's sister's wedding, cousin. You'll have to come to the house and see Mary, she'll be glad to see you.\"\n" \
"  He rises to leave and indicates the door. If you want to accompany him, go to {139}. If you would rather stay and speak to the prospector about Dhesiri, go to {14}. If you'd like to announce the news about the caravan's death, go to {199}."
},
{ // 169
"You shove your table forward, catching the sergeant in the middle. He takes two dice damage from his CON of 15. You get a chance to punch him (worth one die plus your adds) before he will be able to defend himself. If you lower his CON to 0, he'll be knocked out. If this happens, go to {203}.\n" \
"  If you do not knock him out, you will have to fight him. He has whatever is left of his CON of 15. He also fights with a broadsword and gets 10 adds. If you kill him, go to {141}."
},
{ // 170
"\"I'll prove my worth against you if you have the guts for it. Out in the street, now.\"\n" \
"  You rise and leave. You enter the street and draw your weapon. You make a couple of practice passes and wait. The sergeant joins you. He has a CON of 15, personal adds of 10 and uses a broadsword.\n" \
"  If you kill him, go to {141}."
},
{ // 171
"The ride west is simple and easy. You are unmolested almost to the foot of Goblin Mountain. Then the totally unexpected happens. The ground beneath you opens up.\n" \
"  Make a second level saving roll on Luck (25 - LK). If you make it, go to {19}. If you miss it by an odd number of points, go to {49}. If you miss it by an even number, go to {80}."
},
{ // 172
"You hunker down in the root cellar and hear the sounds of shouting above. If you decide this was less than the honourable thing to do, you may go out and attack, getting one free round on the pair of soldiers you'll face at {79}. If you decide to hide longer, go to {111}."
},
{ // 173
"You and Festus make it unmolested almost all the way to Goblin Mountain. You both feel giddy about the degree of your success, so much so that you do not pay enough attention to the trail ahead of you.\n" \
"  Suddenly you find yourself surrounded by Red Circle warriors. Resisting would be stupid so both of you surrender your weapons and allow yourselves to be bound. As such you are led to {18}."
},
{ // 174
"Roll two dice; doubles add and reroll. Once you get your total, add your Luck to it. If the total is 25 or more, go to {51} and take double the dice roll as experience points. If the total is 20-24, go to {82} and take the dice roll as experience points. If the total is less than 20, go to {113}."
},
{ // 175
"The Egg Chamber is quite a sight. Thousands of white, leathery eggs are floating on a vast, steaming underground lake. The eggs vary in size from a grapefruit to a watermelon, and the outline of Dhesiri young can be seen in each. There are enough eggs here to literally overrun Karesia in the next generation.\n" \
"  If you want to start hacking eggs to bits, go to {42}. If the job looks hopeless to you, go to {21}."
},
{ // 176
"You find yourself in a thick, humid jungle. You are being pursued by something, but you cart only catch faint glimpses of it through the verdant underbrush. Suddenly you reach a clearing and look back to see a tiger stalking you. Before you can do anything it leaps.\n" \
"  Make a first level IQ saving roll (20 - IQ). If you miss it, roll four dice and take that as damage. Remember you are wearing no armour. If you are killed, go to {153}.\n" \
"  If you make the roll or survive the attack, you feel the searing pain of the tiger raking four parallel scars in your right cheek with a quick swipe of a massive paw. The pain is enough to make you pass out.\n" \
"  You awaken with the knowledge that you can mentally converse with all cats. You cannot control them, but they feel comfortable with you and will provide you with as accurate information as they can. Go to {30}."
},
{ // 177
"You find yourself deep beneath the ocean surface, yet this causes you no consternation. You watch as a huge shark courses lazily through the water and stalks prey. The fish it has selected is swimming erratically. It is nervous and is reacting oddly - and this strange behavior increases as the shark gets closer. The shark homes in on the distress and attacks savagely.\n" \
"  From this you learn the secret to locating those trying to elude you. [Within 100' if you can make an IQ saving roll against the IQ of the prey you will be able to locate it. You will not be able to see it, you will just know it is there. (If the prey has a power that would block this whichever character makes an IQ saving against the other's IQ by the largest margin wins.) ]Go to {30}."
},
{ // 178
"The Headman claps his hand and an equally ancient sorcerer moves through the crowd to your side. \"Andar will determine if you can be trusted.\" The sorcerer places his hands on your temples and you can feel his mind probing yours.\n" \
"  Average your IQ and Charisma. Make a saving roll on that number on a level equal to your own level, as modified by the following. If this character is truly trustworthy and honourable, subtract 1 from the level of the saving roll. If the character is treacherous, add 1 to the level of the saving roll.\n" \
"  If you make the saving roll, go to {210}. If you miss it, take the number you missed by in hits off your CON. If you survive that, go to {210}."
},
{ // 179
"The headman traces the scars on your check. \"Because of these marks I know you have been selected for great things. Leave us and seek your fame. We will rejoice in stories of your success.\"\n" \
"  Your adventure here is done. You have earned a bonus of 1500 experience points. Congratulations, you have won."
},
{ // 180
"The stairway ends in two massive doors. The chamber beyond is the Baron's chamber. If you want to enter via Stealth, go to {27}. If you want to enter by Power, go to {58}. If you just want to walk in, go to {89}. Failure, go to {119}."
},
{ // 181
"She wanders back to a corner of her room and presses the button on the wall. A chest of drawers slides back to reveal a secret passage. \"This leads to his throne room. He is there.\"\n" \
"  You head up and open the door at the other end of the passage. It lets you out into the throne room. At the doorway off to your right four men stand waiting in ambush with spears at the ready. The Baron is seated in his throne almost directly in front of you, his profile outlined by one of the stained-glass windows.\n" \
"  You draw your weapon. \"Now, Baron, between us.\"\n" \
"  The Baron turns, looks at you and smiles. \"Not quite.\"\n" \
"  If you have the armband, go to {121}. If you have the Runeshield, go to {152}. If you make a first level Luck saving roll (20 - LK), go to {3}. If you miss it, you feel cold steel enter your back and kill you. As you die you see the woman walk from behind you and wipe her blood-stained hand on a handkerchief given her by Baron Valdemar."
},
{ // 182
"The Baron gets 5 dice for his special broadsword and gets 6 dice worth of adds. He fights without armour. His Constitution is 12.\n" \
"  If you kill him, go to {209}. If you are losing and have the armband, go to {60}. If you are losing and have the Runeshield, go to {28}. If you are losing and have nothing special, go to {90}. (Pick a losing options just before you think he'll kill you.)"
},
{ // 183
"You power into the room. A crossbow bolt whistles past your ear. You strike out at the only target in the room. The Baron's blonde mistress collapses, dead.\n" \
"  Killing her quite probably saved your life. Head up the stairs to {180}. She was worth 100 experience points."
},
{ // 184
"A gout of dragonfire blasts the Baron from the roof just as he was about to kill you. The dragon circles the roof, screaming a victory cry. Then it flies over to you. \"I think that makes us even, eh?\"\n" \
"  You laugh and agree. The dragon fires off a salute to you and flies away. You pick your way down through the castle to where the Baron's body still smoulders. Go to {209}."
},
{ // 185
"The Baron puts the armband on and immediately turns to stare at his nephew. \"You! I should have known!\"\n" \
"  You grab your weapon and strike upward. You catch the Baron totally unawares. He dies.\n" \
"  Go to {209}."
},
{ // 186
"You find the survivor, a small man who took an arrow through the left lung. You know he is not long for the world. He does too. You give him some water, he chokes it down, then smiles weakly at you.\n" \
"  \"I don't have much time. You can stop the Red Circle. They would not be out raiding except that their lands have been overrun by Dhesiri. The dragonmen are forcing them out and the Red Circle are attacking to expand their territory.\"\n" \
"  The man pulls an amulet from around his neck and presses it into your hand. \"If you wear this you can understand Dhesiri and will appear to be Dhesiri to other Dhesiri. Slay the Queen, destroy the eggs, and the Red Circle will no longer raid.\"\n" \
"  The man coughs hard, twice, and dies.\n" \
"  Please note your character has the Dhesiri amulet.\n" \
"  If you wish to backtrack the raiders, go to {93}. If you wish to ride on to the next village and learn more about Dhesiri, go to {13}. If you know something of Dhesiri and wish to head off west toward the Red Circle lands, go to {171}."
},
{ // 187
"Make a first level Dexterity saving roll (20 - DEX). If you make it, you slip out of camp easily, taking a horse and weapons with you. If you want to surprise the Red Circle members, you may do so by riding into their home encampment at {91}. You could also, from here, head toward Goblin Mountain at {171} or Valdemarton at {13}.\n" \
"  If you miss the saving roll, you are knocked unconscious and taken in bonds to the Red Circle homeland. Go to {18}."
},
{ // 188
"\"I can appreciate honesty.\" The dragon smiles at you and sets you down on the ground. \"Let me guess, you are either a Dhesiri hunter who got caught in the river, a treasure hunter looking for this trove, or an unfortunate person who got pulled in here without knowing quite what is going on.\"\n" \
"  If you claim to be a Dhesiri hunter, go to {66}. If you claim to be a treasure hunter, go to {97}. If you claim not to know what is going on, go to {5}."
},
{ // 189
"\"Not any more!\" The dragon opens its mouth and pops you into it. You are dead. Perhaps, in a future incarnation you won't answer such a perfectly easy question with such a dumb answer."
},
{ // 190
"The Helmet room has very white walls, yet the light is muted enough to make them feel warm. Resting atop a white marble pedestal, on a white satin pillow, is a silvery helmet. It is a full helm with no ornamentation; two eye slits are the only decoration on it.\n" \
"  Behind it stands a ghost. It is the outline of a tall handsome man. It speaks. \"I am the ghost of Rex Sunwolf. I have long waited for a hero to come claim my helmet. If you can master it, you will know great power. If you cannot, it will kill you.\"\n" \
"  If you choose not to take the helmet, go to {122}. If you try it on, make a second level Luck saving roll (25 - LK). If you make it by 5 or more, go to {68}. If you make it by less than 5, go to {99}. If you miss it, go to {160}."
},
{ // 191
"You find a small crawlway leading up toward the surface. You know you can get out, but the dragon will be left behind to perish. If you want to return to help the dragon prepare defences, go to {159}. If you want to escape, you continue on until you reach a fork in the crawlway. If you go left, you find yourself in the Dhesiri warren, in the Grand Gallery at {154}. If you head right, you reach the surface and find yourself surrounded by three members of the Red Circle. Go to {18}."
},
{ // 192
"The blade spins quickly and slashes through your body. You obviously had some deep dark secret that the blade felt made you unworthy of it. Sorry, better luck next time."
},
{ // 193
"The dragon picks up a silver target shield from the treasure hoard and lightly breathes on it On the fire blackened surface he scratches a complex serpentine rune. \"This rune is a dragonrune, and it says the bearer of this shield is a friend. Keep this with you; it is probably all that would prevent me, in the heat of battle, from roasting you.\"\n" \
"  You take the warm shield gladly. The dragon indicates you should mount up and you climb up on his shoulders. You grab hold of a scale or two and the dragon turns his attention to the long blocked off entrance to the cavern. With a blast or two of dragonfire the rocks melt and you walk out into the open.\n" \
"  He spreads his wings and is airborne. \"When we near the village I will need you to sneak into the castle to flush the Baron out. Get him to the roof. I'll keep his guards busy for a moment or two while you do your job. If the Baron does not die, he will simply rebuild and keep up his evil. Amazingly like Dhesiri, you humans...\"\n" \
"  Beyond a hillock near the village the dragon lands. You climb down. \"The castle is built on the foundations of two or three others. Over there, about 100' from that lightning blasted oak, there is a secret passage leading into the dungeons left over from the first castle. It is your way in. I'll give you time to get to the Baron before I attack.\"\n" \
"  Shield in hand you set off. Go to {17}."
},
{ // 194
"Merely wounding the Dhesiri Queen is a fatal mistake. At her wounding she exudes a heavy scent that instantly fills the chamber and beyond. You watch as the workers gnash their teeth, frothing at the mouth. They advance upon you and are unstoppable. They drag you down and, eventually, feed you yet living to the Queen you tried to kill.\n" \
"  Your adventure is at an end. Better luck next time."
},
{ // 195
"The Dhesiri Warrior you just killed was worth 100 experience points.\n" \
"  You can free the prisoners by cutting the stout rope that held the cage doors shut. If you want to have them join you, the prisoners are more than willing to do so. Go to {9} to see what having them with you will do.\n" \
"  Make a first level Luck saving roll (20 - LK). If you make it, go to {101}. If you miss it, go to {132}."
},
{ // 196
"You slip into the pool and immediately are drawn down in by a strong current. Roll two dice and take that as damage off your CON. The current drags you through a narrow tunnel of rock, battering you against the granite sides. Luckily you retain your weapons.\n" \
"  You are released by the current, but being prudent you don't immediately strike for the surface of this new pool. Instead you look up and see white, translucent sacks floating on the water. Through them you can see the outline of Dhesiri young. You have been dragged into the warren's Egg chamber!\n" \
"  You strike for the surface and you find the chamber empty. You are left alone to destroy all the eggs you can. Go to {42}."
},
{ // 197
"This hallway is wide, tall and shrouded in deep shadows that could hide just about anything. That makes you somewhat uneasy, but you conquer your anxiety and press on. Then you round a corner and see something that brings your heart to your throat.\n" \
"  Make a second level Luck saving roll (25 - LK). If you make it, go to {12}. If you miss it, go to {73}."
},
{ // 198
"The Baron's guardsmen look you over but see nothing remarkable. You return their interest, and note something odd about the sergeant when he cuts a thick slice of a greasy, steaming sausage at his table. If you can make a second level IQ saving roll (25 - IQ), go to {108} and return here immediately after reading the information there.\n" \
"  If you read the information at {108} and wish to question the sergeant about it, go to {46}. If you want to ignore the guards and just listen for any idle gossip, go to {202}. If you want to ask the sergeant about how you might go about joining up with the Baron, go to {109}."
},
{ // 199
"The news of the caravan being slaughtered surprises the townspeople and the newly awakened prospector. The news has no effect on the guards, and it strikes you as unusual. They notice your attention, whisper to themselves and cross the room to you. Both are weaving slightly and they are obviously drunk. You know there's going to be trouble.\n" \
"  \"How much did you loot from the caravan, drifter?\" One of them, a small man, pushes you. His taller compatriot drops a hand to the dagger at his belt. \"We don't like thieving scum like you in this town,\" he continues.\n" \
"  It looks like a fight is inevitable. Make a first level IQ saving roll (20 - IQ). If you make it, go to {106}. If you miss it, go to {76}."
},
{ // 200
"The guards look you over and decide you have the stuff of which their numbers are made. They lead you from the tavern up the steep hill to the castle. Words are exchanged with the guards at the gate and you are conducted inside the granite fortress of Baron Valdemar.\n" \
"  You are turned over to a robed Chamberlain who says nothing to you. He takes you to a room, rather small but very clean, with a tub of hot water and a clean robe. He indicates you should bathe and prepare yourself for an audience with the Baron. Once you are presentable, go to {15}."
},
{ // 201
"The sergeant hurls a few invectives in your direction then returns to his table. His compatriots laugh at you then, returning their limited attention to their food, ignore you. Soon a townsman rises from the table where he's seated and comes to you. \"Let's leave. You've made no friends here, and your enemies are my enemies. \" He smiles and you feel he's trustworthy.\n" \
"  If you leave with him, go to {139}. If you decide to stay and eat a meal, you will finish and leave after the Baron's men have left the inn. Go to {48}."
},
{ // 202
"Listening to idle gossip in an agricultural village is about as exciting as watching grass grow. You learn there is a worm blight on a farm north of the city and you gain the impression that the Baron is not well liked. If you had gone to {108} before, you may still question the sergeant about the information you learned there by going to {46}. You may also go to {109} and ask about signing up with the guard. Lastly you could go to {75} to see if the Dusty Rose Tavern is as boring as the inn."
},
{ // 203
"The crowd in the inn stands stunned. From behind you comes applause. You turn and see a handsome man clapping. He is dressed in the colours of the Baron. \"You have dealt with him quite well. I think my uncle, the Baron, would like to speak with you. If you will permit me, I will conduct you to him.\"\n" \
"  Go to {15}."
},
{ // 204
"The Baron looks down his nose at you. \"Ignorance is so boring. \" He hits a panel on the right arm of his throne and the floor drops away from beneath you.\n" \
"  You drop 20' onto rocks that make up the foundation of the castle. Take 3 dice damage, armour counting[ for half strength (no doubling allowed)]. If you survive that, you manage to crawl from the castle through the sewers. A townsman finds you.\n" \
"  \"Anyone the Baron has dropped to the sewers has an enemy in common with me. Come on, let's get you far away from him.\" Go to {139}."
},
{ // 205
"You realize, a bit late, that the Baron is not the sort of man to be trusted. Luckily you recognize this fact just as three riders come out of the shadows at you. They ride up slowly, like fellow travellers, but you hear one of them say, \"There, that's the adventurer.\"\n" \
"  You spur your horse forward and knock one of them down. The other two get a total of 6 dice plus 2 for their weapons and 3 combat adds each. Each has a CON of 10.\n" \
"  If you kill them, the third man, lying with a broken leg beneath his horse, tells you of a secret passage into the castle that he and his buddies discovered when exploring the forbidden subbasement of the castle.\n" \
"  You can leave the adventure with a bonus of 1500 experience points right now, or you may go to {17} to teach the Baron that when he plots to kill he should get it right."
},
{ // 206
"The solution to the problem is obvious to you. The lake is fed by a warm spring, but has not flooded out the cavern. That means there in an outflow. If you could enlarge the outflow, the lake would drain and the Dhesiri eggs would be swept out to sea where the cold water would destroy the eggs.\n" \
"  You shuck your clothing and dive into the lake. You can feel the current. You follow it and discover the outlet, and note there are some rocks blocking it, limiting it.\n" \
"  [Roll three dice. This is the number of hits you'll have to generate to open the outflow. After each combat round, you will have to surface to breathe. When you surface, roll to see if you are discovered (unless you have the Amulet). ]Once you open the outflow, go to {52}."
},
{ // 207
"You dream that you are big and strong. You have long claws and a thick shaggy coat. You spend what seems to be an eternity wandering, eating and preparing a resting place. At one point you see a reflection of yourself in a pool and you are a bear. Suddenly and savagely another bear attacks you.\n" \
"  Make a first level Strength saving roll (20 - ST).\n" \
"  If you miss it, take 3 dice damage. If you die, go to {153}.\n" \
"  If you survive the combat or make the saving roll, you have learned something about being a bear. Part of you finds this metaphysical experience funny, but another part remembers how a bear slows down his body during hibernation. This is a gift you retain. [You may survive on no food or water for four months provided you remain quiet and do nothing during that time. Four months should be enough time to have friends rescue you from even the worst dungeon cave in. ]Go to {30}."
},
{ // 208
"In your dream you see yourself running with a pack of wolves across a moonlit snowfield. The pack leader howls and you feel a thrill go through your blood. He's located a moose trapped in deep snow and you are going to help taking it. It is at this point you recognize you are in wolf form.\n" \
"  The fight is long and gruelling. Quickness is your only defence against the massive rack of antlers. Two other wolves are hit and broken in the fray. Make a first level Dexterity saving roll (20 - DEX). If you miss it, take 3 dice damage. If you die, go to {153}.\n" \
"  If you survive the combat or make the saving roll, [you learn how to avoid taking dama]g[e in a fight. If you can make a Dexterity saving roll against the Dexterity of your opponent, you can use the number you made it by as \"armour\" for that one turn only. The \"armour\" cannot be doubled by a warrior. G]o to {30}."
},
{ // 209
"The Baron lies dead at your feet. His nephew, Count Vlad, bows to you. \"Thank you for freeing us of the tyranny of my uncle.\"\n" \
"  In a celebration that lasts for the next two weeks you are feted and rewarded. You are officially knighted so Sir or Dame may be added to your name. You are given 5000 gold pieces and have earned 3000 experience points on this adventure.\n" \
"  Congratulations, you have won."
},
{ // 210
"The sorcerer nods to the headman, and the headman smiles. \"I grant you your freedom. I also tell you that if you want to work for us I would gladly accept your aid.\"\n" \
"  If you want to work for the Red Circle, roll one die. If it comes up even, go to {116}. If it comes up odd, go to {147}.\n" \
"  If you choose not to work for them, the adventure is over for you. It has been worth 1750 experience points[, and your reputation as a person who can be trusted will spread from this point so all will trust you. Trust you, that is, until you prove no longer worthy of that trust].\n" \
"  Congratulations, you have won."
},
{ // 211
"Each of the Red Circle youths has a dagger worth 2 dice plus 3 in combat. Each one gets 1 die worth of adds and has a CON equal to the roll of 3 dice. If you kill them, you discover a map of the area. It notes their camp is to the west at {91}. There is also a town at {13} that looks to be the largest city in the area. On their bodies you also find 3 dice times 100 gold pieces."
},
{ // 212
"The guard spots you and draws his weapon. You have no choice but to defend yourself. He gets 4 dice for his sword and has 3 adds. His CON is 12.\n" \
"  If you kill him, you can head up the stairs to the right at {149} or head back down the corridor he came from at {29}."
},
{ // 213
"If you want to Stealth through the doorway, go to {89}. If you want to Power into the room, go to {120}. Failure, go to {59}."
},
{ // 214
"You enter the room and see a very beautiful blonde woman standing in the middle of a pleasantly appointed room. She sighs and almost collapses. \"I was so afraid it was Baron Valdemar. I suppose you have come to kill him.\"\n" \
"  You nod.\n" \
"  She smiles. \"Thank the gods. Come with me, I know a secret.\"\n" \
"  If you decide to follow her, go to {181}. If you would rather just leave her here and head up the stairs, go to {180}."
}
};

MODULE SWORD rc_exits[RC_ROOMS][EXITS] =
{ {  31,  62,  93,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  13, 171,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  { 182,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  { 128, 190,  37,  35,  -1,  -1,  -1,  -1 }, //   4
  { 159,   4, 191,  -1,  -1,  -1,  -1,  -1 }, //   5
  { 128,  37, 190,  38,  -1,  -1,  -1,  -1 }, //   6
  { 131,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  { 196, 154,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  75, 137,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  { 143, 174, 154,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  {  85, 178,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  { 182,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  64, 211,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  { 129,   4,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  { 102, 104,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  21,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  { 169, 170, 201,  -1,  -1,  -1,  -1,  -1 }, //  44
  { 138, 137, 154,  -1,  -1,  -1,  -1,  -1 }, //  45
  { 154,  75, 110,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  { 140,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  { 171,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  { 175,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  { 117,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  29, 149,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  { 149,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  { 182,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {   4,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  { 111,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  { 159,   4, 191,  -1,  -1,  -1,  -1,  -1 }, //  66
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  96,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  { 199,  14, 138, 168,  -1,  -1,  -1,  -1 }, //  75
  { 139,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  { 171, 138, 199,  -1,  -1,  -1,  -1,  -1 }, //  77
  { 139,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  { 127,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  { 123, 178,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  {  29, 149,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  { 180, 213,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  { 117,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  { 128, 190,  37,   5,  -1,  -1,  -1,  -1 }, //  97
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  { 131,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  { 165, 196,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  { 166, 135, 154,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  { 170,  75, 171,  -1,  -1,  -1,  -1,  -1 }, // 109
  { 154,  17, 171,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {  24,  55,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  {  25,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  { 149,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119
  { 180,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  { 182,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  {  63,  94,   2,  -1,  -1,  -1,  -1,  -1 }, // 124
  { 116,  55,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  {  61, 158, 188,  -1,  -1,  -1,  -1,  -1 }, // 127
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  { 159, 191,   4,  -1,  -1,  -1,  -1,  -1 }, // 129
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  {  41,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  { 154,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  {  43, 154,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  {  79, 172,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  { 175,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {  86,  55,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  { 180, 213,  88,  -1,  -1,  -1,  -1,  -1 }, // 149
  { 180,  88,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  { 182,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  { 104,  40, 164,  72, 136, 197,  34,  -1 }, // 154
  {  63,  33,  64,  -1,  -1,  -1,  -1,  -1 }, // 155
  { 211,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  13,  93,  95,  -1,  -1,  -1,  -1,  -1 }, // 157
  {  35,   4,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  { 154,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  { 135, 154,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  { 139,  14, 199,  -1,  -1,  -1,  -1,  -1 }, // 168
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  {  79, 111,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  {  42,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177
  { 210,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  { 180,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183
  { 209,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  { 209,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  {  93,  13, 171,  -1,  -1,  -1,  -1,  -1 }, // 186
  {  91, 171,  13,  -1,  -1,  -1,  -1,  -1 }, // 187
  {  66,  97,   5,  -1,  -1,  -1,  -1,  -1 }, // 188
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  { 159, 154,  18,  -1,  -1,  -1,  -1,  -1 }, // 191
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195
  {  42,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197
  { 202, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200
  { 139,  48,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201
  { 109,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203
  { 139,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210
  {  91,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211
  { 149,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213
  { 181, 180,  -1,  -1,  -1,  -1,  -1,  -1 }  // 214
};

MODULE STRPTR rc_pix[RC_ROOMS] =
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
  "rc16",
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
  "rc30", //  30
  "",
  "",
  "",
  "",
  "", //  35
  "rc36",
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
  "rc51",
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
  "",
  "", //  70
  "",
  "",
  "",
  "",
  "", //  75
  "",
  "rc77",
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
  "rc106",
  "",
  "rc108",
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
  "", // 125
  "",
  "rc127",
  "",
  "",
  "", // 130
  "",
  "",
  "",
  "",
  "", // 135
  "",
  "rc137",
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
  "rc165", // 165
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
  "rc190", // 190
  "",
  "",
  "",
  "",
  "", // 195
  "rc196",
  "",
  "",
  "",
  "", // 200
  "",
  "",
  "",
  "",
  "", // 205
  "",
  "",
  "",
  "",
  "", // 210
  "",
  "",
  "",
  ""  // 214
};

IMPORT FLAG                   usedweapons;
IMPORT int                    armour,
                              bankcp,
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
                              spellpower,
                              thethrow;
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

MODULE void rc_enterroom(void);

EXPORT void rc_preinit(void)
{   descs[MODULE_RC] = rc_desc;
}

EXPORT void rc_init(void)
{   int i;

    exits      = &rc_exits[0][0];
    enterroom  = rc_enterroom;
    for (i = 0; i < RC_ROOMS; i++)
    {   pix[i] = rc_pix[i];
}   }

MODULE void rc_enterroom(void)
{   TRANSIENT FLAG ok;
    TRANSIENT int  i,
                   result, result2, result3;
    TRANSIENT TEXT letter;
    PERSIST   FLAG oldstat;
    PERSIST   int  killed,
                   prisoners,
                   thenum;

    switch (room)
    {
    case 1:
        if (getyn("Attack (otherwise talk)"))
        {   room = 211;
        } else
        {   savedrooms(1, chr, 125, 156);
        }
    acase 2:
        if (!saved(1, lk))
        {   templose_con(dice(3 * misseditby(1, lk)));
        }
    acase 6:
        if (been[6])
        {   thenum -= dice(1);
            if (thenum <= 0)
            {   room = 100;
        }   }
        else
        {   thenum = 12 - dice(1);
        }
    acase 7:
        result = dice(2);
        killed = 0;
        create_monsters(436, result);
        oneround();
        killed += result - countfoes();
        if (countfoes() < result)
        {   create_monsters(436, result - countfoes());
        }
        oneround();
        killed += result - countfoes();
        if (countfoes() < result)
        {   create_monsters(436, result - countfoes());
        }
        oneround();
        killed += result - countfoes();
        if (countfoes() < result)
        {   create_monsters(436, result - countfoes());
        }
        oneround();
        killed += result - countfoes();
        if (countfoes() < result)
        {   create_monsters(436, result - countfoes());
        }
        killed += result - countfoes();
        oneround();
    acase 8:
        drop_all();
        prisoners = dice(1) + 1;
        do
        {   if (saved(2, chr))
            {   room = 39;
            } elif (!saved(1, lk))
            {   room = 70;
        }   }
        while (room == 8);
    acase 12:
        create_monster(438);
        npc[0].con  = dice(4);
        npc[0].adds = dice(3);
        recalc_ap(0);
        good_freeattack();
        if (npc[0].con >= 5)
        {   create_monster(438);
            npc[1].con  = dice(4);
            npc[1].adds = dice(3);
            recalc_ap(1);
            create_monster(438);
            npc[2].con  = dice(4);
            npc[2].adds = dice(3);
            recalc_ap(2);
            fight();
        } else
        {   kill_npc(0);
            create_monster(438);
            npc[0].con  = dice(4);
            npc[0].adds = dice(3);
            recalc_ap(0);
            good_freeattack();
            if (npc[0].con >= 5)
            {   create_monster(438);
                npc[1].con  = dice(4);
                npc[1].adds = dice(3);
                recalc_ap(1);
                fight();
            } else
            {   kill_npc(0);
                create_monster(438);
                npc[0].con  = dice(4);
                npc[0].adds = dice(3);
                recalc_ap(0);
                good_freeattack();
                if (npc[0].con >= 5)
                {   fight();
                } else
                {   kill_npc(0);
        }   }   }
    acase 14:
        pay_gp_only(1);
        getsavingthrow(TRUE);
        if (madeitby(1, lk) > 5)
        {   room = 45;
        } elif (madeit(1, lk))
        {   room = 77;
        } else
        {   room = 107;
        }
    acase 15:
        getsavingthrow(TRUE);
        if (madeitby(1, ((lk + iq) / 2) + level) >= 5)
        {   room = 50;
        } elif (madeit(1, ((lk + iq) / 2) + level))
        {   room = 81;
        } elif (been[34]) // %%: ambiguous
        {   room = 142;
        } else
        {   room = 204;
        }
    acase 16:
        if (shooting() && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE))
        {   room = 112;
        } // %%: what if they miss?
    acase 17:
        letter = getletter("ªSªtealth/ªPªower/ªNªeither", "SPN", "Stealth", "Power", "Neither", "", "", "", "", "", FALSE);
        if (letter == 'S')
        {   savedrooms(1, dex, 56, 26);
        } elif (letter == 'P')
        {   savedrooms(1, st, 87, 26);
        } else
        {   savedrooms(1, lk, 118, 212);
        }
    acase 18:
        // %%: what, if any, of our inventory do they take? We assume nothing.
        if (getyn("Work for them"))
        {   oddeven(116, 147);
        }
    acase 19:
        dropitem(ITEM_SO_HORSE);
    acase 20:
        die();
    acase 21:
        getsavingthrow(TRUE);
        if (madeitby(1, iq) >= 5)
        {   room = 206;
        } elif (madeit(1, iq))
        {   room = 83;
        } else
        {   room = 145;
        }
    acase 22:
        victory(2500);
    acase 23:
        if (saved(1, iq))
        {   good_takehits(dice(4), TRUE); // %%: does armour help?
            if (con <= 0)
            {   room = 153;
        }   }
        if (con > 0)
        {   gain_flag_ability(114);
        }
    acase 24:
        give(328);
        bankcp += 500000;
        while (shop_give(2) != -1);
    acase 25:
        if (getyn("Use Luck (otherwise Dexterity)"))
        {   if (!saved(2, lk))
            {   templose_con(dice(5));
        }   }
        else
        {   if (!saved(2, dex))
            {   templose_con(dice(5));
        }   }
        victory(1500);
    acase 26:
        die();
    acase 28:
        // no need to actually knock it from their hand
        savedrooms(1, lk, 184, -1);
    acase 29:
        prisoners = dice(1) + 1;
        do
        {   if (saved(1, dex))
            {   room = 57;
            }
            if (dice(1) == 1)
            {   create_monster(437);
                fight(); // %%: can more guards come while we are still fighting?
        }   }
        while (room == 29);
    acase 30:
        if     (ability[116].known || ability[117].known)
        {   room = 148;
        } elif (ability[114].known || ability[118].known)
        {   room = 179;
        } else
        {   room = 65;
        }
    acase 31:
        savedrooms(1, lk, 124, 155);
    acase 32:
        if (daro() < 10)
        {   good_takehits(dice(2) + 5, FALSE);
        }
        if (daro() < 10)
        {   good_takehits(dice(2) + 5, FALSE);
        }
    acase 33:
        drop_weapons();
    acase 36:
        give(543);
    acase 37:
        if (getyn("Try for sword"))
        {   getsavingthrow(TRUE);
            if (madeitby(level, chr) >= 5)
            {   room = 130;
            } elif (madeit(level, chr))
            {   room = 161;
            } elif (thethrow < 5)
            {   room = 192;
            } else
            {   room = 69;
        }   }
        else
        {   room = 122;
        }
    acase 38:
        if   (!items[543].owned && getyn("Enter Hand room"  )) room = 128;
        elif (!items[628].owned && getyn("Enter Helmet room")) room = 190;
        elif (!items[627].owned && getyn("Enter Sword  room")) room =  37;
    acase 39:
        give(QUA);
        create_monster(438);
        npc[0].adds = dice(3);
        npc[0].con  = dice(4);
        recalc_ap(0);
        fight();
        savedrooms(1, lk, 101, 132);
    acase 40:
        if (saved(2, iq))
        {   room = 71;
        }
    acase 41:
        award(10 * killed);
        victory(1500);
    acase 43:
        if (items[328].owned)
        {   room = 167;
        } else
        {   create_monster(438);
            npc[0].adds = dice(3);
            npc[0].con  = dice(4);
            recalc_ap(0);
            oneround();
            oneround();
            oneround();
            oneround();
            oneround();
            if (countfoes())
            {   savedrooms(2, lk, 105, 96);
            } else
            {   room = 74;
        }   }
    acase 44:
        if (prevroom != 108 && saved(2, iq))
        {   room = 108;
        }
    acase 49:
        dropitem(ITEM_SO_HORSE);
        if (items[328].owned)
        {   room = 154;
        } else
        {   room = 8;
        }
    acase 50:
        give(ITEM_SO_HORSE);
        award(300);
    acase 52:
        victory(2500);
    acase 53:
        gain_flag_ability(115);
    acase 54:
        if (saved(2, iq))
        {   gain_flag_ability(116);
        } else
        {   room = 153;
        }
    acase 55:
        if (saved(2, st)) // %%: it doesn't actually say what happens if we miss. Presumably we die.
        {   give(ITEM_SO_HORSE);
            give(BRO);
        } else
        {   die();
        }
    acase 57:
        result = dice(1) + 2;
        if (prisoners < result) // %%: what if same number of prisoners and guards?
        {   create_monsters(439, result);
            fight();
        }
    acase 59:
        die();
    acase 60:
        savedrooms(2, chr, 185, -1);
    acase 62:
        savedrooms(1, lk, 186, 157);
    acase 63:
        drop_weapons();
        elapse(ONE_DAY, TRUE);
        if (getyn("Escape first evening"))
        {   room = 187;
        } else
        {   elapse(ONE_DAY, TRUE);
            if (getyn("Escape second evening"))
            {   room = 187;
            } else
            {   room = 18;
        }   }
    acase 65:
        if (getyn("Accept mission"))
        {   oddeven(116, 147);
        } else
        {   room = 55;
        }
    acase 67:
        give(543); // gauntlets
    acase 68:
        give(628); // helmet
    acase 69:
        give(627); // sword
    acase 70:
        if (saved(1, st))
        {   create_monster(440);
            npc[0].con = dice(6);
            recalc_ap(0);
            good_freeattack(); // %%: with a femur? What are the stats for it?
            if (countfoes())
            {   room = 194;
            } else
            {   room = 163;
        }   }
        else
        {   die();
        }
    acase 72:
        if (items[328].owned || saved(1, lk))
        {   room = 103;
        } else
        {   room = 134;
        }
    acase 74:
        if (getyn("Leave adventure"))
        {   victory(1000);
        }
    acase 78:
        create_monsters(441, 2);
        fight();
    acase 79:
        ok = TRUE;
        create_monsters(442, 2);
        if (prevroom == 172)
        {   good_freeattack(); // does this count as one of the 5 rounds? We assume so.
        } else
        {   oneround();
        }
        oneround();
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   if (!saved(2, lk))
            {   ok = FALSE;
                create_monster(442);
            }
            fight();
        }
        if (ok && getyn("Join Red Circle"))
        {   room = 173;
        } elif (getyn("Leave adventure"))
        {   victory(1000);
        } else
        {   room = 17;
        }
    acase 80:
        pay_cp_only(cp);
        pay_sp_only(sp);
        pay_gp_only(gp);
        for (i = 0; i < ITEMS; i++)
        {   if (!isweapon(i) && items[i].type != ARMOUR) // %%: what about shields?
            {   dropitems(i, items[i].owned);
        }   }
    acase 81:
        give(ITEM_SO_HORSE);
        while (shop_give(0) != -1); // %%: is this what is meant by "get you outfitted"?
        if (been[45] || been[108])
        {   savedrooms(2, lk + 10, 205, 20);
        } else
        {   savedrooms(2, lk     , 205, 20);
        }
    acase 82:
        savedrooms(2, lk, 144, 113);
    acase 83:
        result = dice(1);
        do
        {   ok = TRUE;
            for (i = 1; i <= result; i++)
            {   if (!saved(1, dex))
                {   good_takehits(dice(misseditby(1, dex)), TRUE); // %%: does armour help?
                    ok = FALSE;
                    break;
        }   }   }
        while (!ok);
    acase 84:
        create_monster(436);
        fight();
        if (con <= 0)
        {   room = 153;
        }
    acase 85:
        if (getyn("Perform mission"))
        {   oddeven(116, 147);
        }
    acase 86:
        give(643);
    acase 88:
        letter = getletter("ªSªtealth/ªPªower/ªNªeither", "SPN", "Stealth", "Power", "Neither", "", "", "", "", "", FALSE);
        if (letter == 'S')
        {   if (saved(1, dex)) room = 151;
        } elif (letter == 'P')
        {   if (saved(1, st )) room = 183;
        } else // %%: are we still allowed to choose the other options in this case? We assume not.
        {   room = 214;
        }
    acase 89:
        savedrooms(1, iq, 182, -1);
    acase 90:
        savedrooms(2, dex, 209, -1);
    acase 91:
        if (getyn("Work for them"))
        {   oddeven(116, 147);
        }
    acase 92:
        victory(0); // adventure points were already awarded at RC162
    acase 93:
        savedrooms(1, dex, 1, 32);
    acase 95:
        if (getyn("Leave adventure"))
        {   victory(300);
        }
    acase 96:
        dispose_npcs();
        drop_weapons();
        dropitem(328);
    acase 98:
        die();
    acase 99:
        give(628);
        change_chr(chr * 2);
    acase 100:
        result2 = dice(4);
        result = dice(1);
        killed = 0;
        for (i = 1; i <= 7; i++)
        {   create_monsters(436, result);
            oneround();
            killed  += result - countfoes();
            result2 -= killed;
            result3 =  dice(1);
            if (result3 > result)
            {   result = result3;
            } elif (result3 == result)
            {   result++;
            } // else result = result;
            if (result > result2 - killed)
            {   result = result2;
            }
            if (!result)
            {   break;
        }   }
        // %%: are the new dhesiri added to the old ones still fighting you? We assume so.
        dispose_npcs();
    acase 101:
        // %%: this whole paragraph is very ambiguous
        room = 10;
    acase 102:
        if (saved(2, lk))
        {   room = 133;
        } else
        {   drop_weapons();
            room = 8;
        }
    acase 105:
        dispose_npcs();
        if (getyn("Leave adventure"))
        {   victory(750);
        }
    acase 107:
        savedrooms(1, dex, 78, 140);
    acase 109:
        if (saved(1, chr + level))
        {   room = 200;
        }
    acase 110:
        if (getyn("Leave adventure"))
        {   victory(1000);
        }
    acase 111: // %%: ambiguous paragraph
        if (saved(1, lk))
        {   room = 80;
        } elif (items[328].owned)
        {   room = 154;
        } else
        {   // %%: drop weapons?
            room = 8;
        }
    acase 112:
        create_monster(440);
        npc[0].con = dice(6);
        recalc_ap(0);
        evil_takemissilehits(0);
        if (countfoes())
        {   room = 194;
        } else
        {   room = 163;
        }
    acase 113:
        die();
    acase 114:
        if (!saved(2, iq))
        {   room = 153;
        } else
        {   gain_flag_ability(117);
            room = 30;
        }
    acase 119:
        die();
    acase 120:
        create_monsters(437, 6);
        good_freeattack();
        fight();
    acase 122:
        result = dice(2) - (5 * been[38]);
        if (result <= 0)
        {   room = 100;
        }
    acase 123:
        result = dice(2);
        switch (result)
        {
        case   2: room = 114;
        acase  3: room = 176;
        acase  4: room = 207;
        acase  5: room =  53;
        acase  6: room =  84;
        acase  7: room = 115;
        acase  8: room = 146;
        acase  9: room = 177;
        acase 10: room = 208;
        acase 11: room =  23;
        acase 12: room =  54;
        }
    acase 126:
        room = prevroom;
    acase 128:
        if (getyn("Try for gauntlets"))
        {   getsavingthrow(TRUE);
            if (madeitby(2, iq) >= 5)
            {   room = 36;
            } elif (madeit(2, iq))
            {   room = 67;
            } else
            {   room = 98;
        }   }
        else
        {   room = 122;
        }
    acase 130:
        give(627);
    acase 131:
        if (getyn("Leave adventure"))
        {   award(killed * 10);
            award(1500);
            rb_givejewels(-1, -1, 1, 6);
            victory(0);
        }
    acase 132:
        killed = 0;
        result2 = dice(4);
        do
        {   result = dice(2);
            create_monsters(436, result);
            oneround();
            killed += result - countfoes();
            dispose_npcs();
            result2 -= prisoners;
        } while (result2 >= 1);
    acase 134:
        create_monsters(436, 6);
        oneround();
        oneround();
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   room = 96;
        }
    acase 137:
        savedrooms(1, chr + level, 44, 198);
    acase 138:
        savedrooms(1, chr + level, 200, 76);
    acase 142:
        die();
    acase 143:
        create_monster(438);
        npc[0].adds = dice(3);
        npc[0].con  = dice(4);
        recalc_ap(0);
        oneround();
        oneround();
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   room = 96;
        } else
        {   create_monster(440);
            npc[0].con = dice(6);
            recalc_ap(0);
            good_freeattack();
            if (countfoes())
            {   room = 194;
            } else
            {   room = 163;
        }   }
    acase 145:
        die();
    acase 146:
        while (!saved(1, st))
        {   templose_con(5);
        }
        create_monster(443);
        fight();
        if (con <= 0)
        {   room = 153;
        }
    acase 148:
        victory(2000);
    acase 151:
        if (been[15] || been[214])
        {   savedrooms(1, chr + 5, 181, -1);
        } else
        {   savedrooms(1, chr    , 181, -1);
        }
    acase 153:
        die();
    acase 154:
        if (been[16] && getyn("Queen"))
        {   room = 16;
        }
    acase 155:
        good_takehits(dice(1), TRUE);
    acase 156:
        if (saved(1, lk))
        {   oldstat = TRUE;
        } else
        {   good_takehits(dice(2) * 5, TRUE); // %%: do we take these hits separately or together?
            good_takehits(dice(2) * 5, TRUE);
            oldstat = FALSE;
        }
    acase 158:
        if (!saved(1, iq))
        {   room = 189;
        }
    acase 160:
        die();
    acase 161:
        give(627);
    acase 162:
        if (getyn("Leave adventure"))
        {   award(10 * killed);
            award(1500);
            rb_givejewels(-1, -1, 1, 6);
            room = 92;
        } else
        {   room = 193;
        }
    acase 163:
        victory(2500);
    acase 164:
        prisoners = dice(1);
        create_monster(438);
        npc[0].adds = dice(3);
        npc[0].con  = dice(4);
        recalc_ap(0);
        oneround();
        oneround();
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   room = 96;
        } else
        {   room = 195;
        }
    acase 165:
        create_monsters(436, dice(2));
        oneround();
        oneround();
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   room = 96;
        }
    acase 166:
        give_gp(dice(3));
    acase 167:
        if (getyn("Leave adventure"))
        {   victory(500);
        } else
        {   room = 154;
        }
    acase 169:
        create_monster(444);
        evil_takehits(0, dice(2));
        evil_takehits(0, dice(1) + calc_personaladds(st, lk, dex)); // this assumes everyone has a 1-die barehanded attack
        if (countfoes())
        {   fight();
            room = 141;
        } else
        {   room = 203;
        }
    acase 170:
        create_monster(444);
        fight();
    acase 171:
        if (saved(2, lk))
        {   room = 19;
        } elif (misseditby(2, lk) % 2)
        {   room = 49;
        } else
        {   room = 80;
        }
    acase 173:
        drop_weapons();
    acase 174:
        result = daro() + lk;
        if (result >= 25)
        {   award(result * 2);
            room = 51;
        } elif (result >= 20)
        {   award(result);
            room = 82;
        } else
        {   room = 113;
        }
    acase 176:
        if (!saved(1, iq))
        {   templose_con(dice(4));
            if (con <= 0)
            {   room = 153;
        }   }
        if (con > 0)
        {   gain_flag_ability(118);
            set_language(LANG_CAT, 2);
        }
    acase 177:
        gain_flag_ability(119);
    acase 178:
        if (ability[48].known)
        {   result = 3;
        } else
        {   result = getnumber("1) Trustworthy\n2) Average\n3) Treacherous\nWhich", 1, 3);
        }
        if (!saved(level + result - 2, (iq + chr) / 2))
        {   good_takehits(misseditby(level + result - 2, (iq + chr) / 2), TRUE);
        }
    acase 179:
        victory(1500);
    acase 180:
        letter = getletter("ªSªtealth/ªPªower/ªNªeither", "SPN", "Stealth", "Power", "Neither", "", "", "", "", "", FALSE);
        if (letter == 'S')
        {   savedrooms(1, dex, 27, 119);
        } elif (letter == 'P')
        {   savedrooms(1, st, 58, 119);
        } else
        {   room = 89;
        }
    acase 181:
        if (items[643].owned)
        {   room = 121;
        } elif (items[644].owned)
        {   room = 152;
        } else
        {   savedrooms(1, lk, 3, -1);
        }
    acase 182:
        create_monster(445);
        npc[0].adds = dice(6);
        recalc_ap(0);
        do
        {   oneround();
        } while (countfoes() && getyn("Fight again"));
        if (countfoes())
        {   if (items[643].owned)
            {   room = 60;
            } elif (items[644].owned)
            {   room = 28;
            } else
            {   room = 90;
        }   }
        else
        {   room = 209;
        }
    acase 183:
        award(100);
    acase 186:
        give(328);
        // %%: what exactly is meant by "know something of Dhesiri"?
    acase 187:
        if (saved(1, dex))
        {   give(ITEM_SO_HORSE);
            while (shop_give(2) != -1); // %%: what weapons?
        } else
        {   room = 18;
        }
    acase 189:
        die();
    acase 190:
        if (getyn("Try for helmet"))
        {   getsavingthrow(TRUE);
            if (madeitby(2, lk) >= 5)
            {   room = 68;
            } elif (madeit(2, lk))
            {   room = 99;
            } else
            {   room = 160;
        }   }
        else
        {   room = 122;
        }
    acase 192:
        die();
    acase 193:
        give(644);
        // %%: do we miss out on the dhesiri-killing bonuses, the 1500 ap and the 6 gems (from RC131/162)? We assume so.
    acase 194:
        die();
    acase 195:
        savedrooms(1, lk, 101, 132);
    acase 196:
        templose_con(dice(2));
    acase 197:
        savedrooms(2, lk, 12, 73);
    acase 198:
        if (prevroom != 108 && saved(2, iq))
        {   room = 108;
        } else
        {   if (been[108] && getyn("Question sergeant"))
            {   room = 46;
        }   }
    acase 199:
        savedrooms(1, iq, 106, 76);
    acase 202:
        if (been[108] && getyn("Question sergeant"))
        {   room = 46;
        }
    acase 204:
        good_takehits(dice(3), TRUE);
    acase 205:
        create_monsters(446, 2);
        fight();
        if (getyn("Leave adventure"))
        {   victory(1500);
        } else
        {   room = 17;
        }
    acase 207:
        if (!saved(1, st))
        {   good_takehits(dice(3), TRUE);
            if (con <= 0)
            {   room = 153;
        }   }
        if (con > 0)
        {   gain_flag_ability(120);
        }
    acase 208:
        if (!saved(1, dex))
        {   good_takehits(dice(3), TRUE);
            if (con <= 0)
            {   room = 153;
        }   }
        if (con > 0)
        {   gain_flag_ability(121);
        }
    acase 209:
        gain_flag_ability(122);
        give_gp(5000);
        victory(3000);
    acase 210:
        if (getyn("Work for them"))
        {   oddeven(147, 116);
        } else
        {   victory(1750);
        }
    acase 211:
        create_monsters(447, 2);
        npc[0].adds = dice(1);
        npc[0].con  = dice(3);
        recalc_ap(0);
        npc[1].adds = dice(1);
        npc[1].con  = dice(3);
        recalc_ap(1);
        if (prevroom == 1 || (prevroom == 156 && oldstat))
        {   good_freeattack();
        }
        fight();
        // we could implement the map as an item
        give_gp(dice(3) * 100);
    acase 212:
        create_monster(448);
        fight();
    acase 213:
        letter = getletter("ªSªtealth/ªPªower", "SP", "Stealth", "Power", "", "", "", "", "", "", FALSE);
        if (letter == 'S')
        {   savedrooms(1, dex, 89, 59);
        } elif (letter == 'P')
        {   savedrooms(1, st, 120, 59);
}   }   }
