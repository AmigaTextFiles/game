#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Errata:
 SO Disease Chart for Malaria: "See Malaria for determining frequency and results of attacks."
  We assume Cholera is meant.

Unimplemented:
 disease payloads.
*/

MODULE const STRPTR so_desc[SO_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  Since the sewers *are* sewers you won't find yourself walking down dry passages. Chances are very good that the majority of your encounters with Wandering Monsters will take place underwater.[ Towards this end, only daggers will be allowed to be used in underwater fights, so be sure to have plenty with you. (Other weapons would not function efficiently underwater.)]\n" \
"  Fighting underwater also will cause problems with armour. *Every time you fight underwater you must make a saving throw on your current Constitution, on the level equal to ½ your armour's damage rating (round up).* This \"drowning saving roll\" is used to simulate the effects of the armour's weight and constriction of motion on your ability to get to the surface and take in air. If you miss the saving roll you take the number you missed the saving roll by in damage on your CON, regardless of armour (you took in a lungful of water). This roll is to be made for each combat turn you fight in the water. (Warriors need only make the saving roll on the face value of the armour they are using.)\n" \
"  [Poison will not work on these Wandering Monsters and other creatures. After all they *do* thrive in the sewers. ]Disease also thrives in the sewers and you would be well advised to check out the Wandering Monster Chart and Disease Chart before reading further.\n" \
"  Any character that is humanoid in form, not larger than 10' tall [and of solid body ]may enter this dungeon. No creature over 7th level or with more than 425 combat adds may enter the adventure. Mermen need not worry about the saving roll mentioned above[, but should roll for Wandering Monsters each time they dip into the water to replenish themselves].\n" \
"  Read the Introduction, and begin. I hope you'll enjoy your adventures. In the words from Othello, \"Oh, now, forever farewell the tranquil mind...\".\n" \
"  You have entered the Sewers of Oblivion.\n" \
"~INTRODUCTION\n" \
"  The Council of Merchants of the city of Gull feared an assault by the Rangers. These pirates were known to be the fiercest of fighters and arrogant enough to challenge the might of the Empire of Khazan. Though the men who had founded Gull had been Rangers, and though the Empire was not loved in Gull, the Council cheered as Khazan repelled the attack of the Rangers. it was then a few realized Gull was the next target for the Rangers, and all remembered that the Rangers had almost taken the city thirty years before.\n" \
"  Towers and walls were built to make the city impossible to take by siege. Harbour patrols and the City Guard were expanded. The defensive preparation of Gull had only one weak area: the sewers. Since the city could hardly live without sewers, the Council hired a local wizard, Biorom, to design traps within the sewers that would dispose of any Rangers who tried to enter the city by that route. Being merchants, they also asked him to get rid of the rats in the sewers.\n" \
"  Normally you wouldn't care about the history of the sewers. On this night, however, you indulged in too much drink at the Red Guardian Inn. As you leave the inn, a number of very strong ruffians mug you. They begin to strip you of your wealth, magical treasure and dignity - and at that moment, the lookout cries that the City Guard is on its way.\n" \
"  In an effort to destroy the evidence, they pitch you (in your armour) into the sewer drain in the back of the alley, along with your swordbelt and sword, dagger and pack with all non-magical provisions. (The City Guard catches these men and keeps your wealth and magical items in safe-keeping until you return.)\n" \
"  You plunge into the slimy, tepid water and quickly pull yourself out. As you seat yourself on the canal ledge, you notice two things. First, you note that the water teems with life. And then you spot a ring, small and red, near your hand. You pick it up and a demon in a boat appears beside you in the canal.\n" \
"  \"Hi, I'm Ignxx,\" the demon says. \"This is your boat; I am your guide. I've been charged with the duty of wet-nursing every dude who falls in here until they get out. Don't use any magic; you can get turned into a fish by doing that stuff. And please don't die, I've got to get a certain number of you out of here before Biorom will forget about the gold-plated dumbwaiter.\n" \
"  Good luck.\n" \
"  When you are ready, go to {74} and begin."
},
{ // 1/4A
"As you trudge down the path towards home, a wizard appears in front of you. \"I'm with the Gull Disease Control Department,\" he tells you. \"If you've picked up any diseases in the sewers, we must isolate you and destroy the disease.\"\n" \
"  If you are a magic-user or rogue who can cast the spell Healing Feeling, or have no disease (through luck of the dice or because you had a spell cast upon you by a grateful magic-user), skip down to the next paragraph. If you cannot cast the spell, the wizard looks at you and says, \"A Healing Feeling will take care of you. It'll cost, oh, (1d6 × 1,000) gold pieces for me to cast it. If you don't have that much, [you have two choices. You can work for me for a year, or ]I must fulfill my duty and eliminate the threat to Gull's public health. The choice is yours.\"\n" \
"  [If you choose the first option, all treasure and magical items earned in the next *game year* go directly to this wizard. The second option is clearly death.\n" \
"  ]This adventure has been worth 1,000 adventure points as a base number. In addition to this, subtract the level at which your character began this adventure from 7, and multiply that number by 100. Take that number also in experience. Next, subtract your starting combat adds from 300 and multiply this number by 10. Take this as experience points, positive or negative. You also get 100 experience points for every disease you have contracted.\n" \
"  I hope you enjoyed yourself."
},
{ // 2/4B
"\"He is awake!\" screams Ignxx in sheer terror. The water around the boat boils, the boat rocks and Ignxx vanishes with a flash of light. Out of the water come tentacles that wrap around the boat and begin to drag it under.\n" \
"  The beast's hide is stony like a troll's. Water rushes into the boat and a tentacle grabs your leg. The beast has combat adds of 150 and rolls 12 dice. If you get 100 hits upon it you will drive it off. (You can fight it more than once if you roll doubles in this situation at another time.) If you drive it away, go to {167}."
},
{ // 3/4C
"From each of the zombies you have slain you may pick up a dirk. Their swords are rusted and useless. You also recover 1 die times 10 worth of gold pieces from previous fighters who were not as fortunate as you. You may leave the room and rejoin Ignxx. Go north to {39}, south to {142} or southeast to {74}."
},
{ // 4/4D
"The lock clicks open, surprising both you and the woman. \"Great! Five hundred rats are dead!\" she cries with joy. \"Now I can leave!\" She pushes the door open and you help her from the cage. She walks over to the south wall and touches a brick. A hidden door slides back and reveals a small room. She enters, dons some sorcerer's robes, picks up a staff and some other provisions.\n" \
"  Set in the wall of the small room is a mirror. She waves a hand before it and an image of Biorom appears in it. She speaks to the mirror and you hear a mumbled reply.\n" \
"  Make a L5-SR on Charisma (40 - CHR). If you make it, go to {161}. If you miss it, go to {51}."
},
{ // 5/5A
"\"I can go no further. The Wraith is on the edge of the sewers. If you get past him you are free. May the gods be with you, for not many tangle with him and survive,\" Ignxx says. \"Those that do manage it by using their wits, not their brawn.\"\n" \
"  With a puff of red smoke he is gone. You take up the pole and propel yourself deep into the black canal before you. Farther along it grows cold, as if the warmth of life has been sucked out of you. The whole canal reeks of corruption and you are alone with your heartbeat.\n" \
"  You turn the last corner and there is the Wraith. He stands fully 12' tall, an ebon statue of a demon wreathed with an unholy, blasphemous vapour. His eyes lock on to yours; they shine with a grey brilliance that chills you to your soul.\n" \
"  \"Why are you here, mortal?\" he asks in a strong, deep voice as you step from your boat onto the canal pathway.\n" \
"  If you must defeat the Wraith, go to {189}. If you merely wish to leave the sewers, go to {66}."
},
{ // 6/5B
"You couldn't stay in the saddle and land with a thump on the ground. The rest of the ragged footmen swarm over you. They could not let you sound the alarm, so they sounded your death knell instead. You are dead."
},
{ // 7/5C
"This reptile has a MR of 210. It will not be an easy fight. [(Remember to make your drowning saving rolls.) ]If you kill it, go to {148}."
},
{ // 8/5D
"Make a L3-SR on Intelligence (30 - IQ). If you make it, go to {103}. If you miss it, go to {80}."
},
{ // 9/6A
"You neatly move in and outflank the infantry group. Your sword sings as it blasts through one of their sorcerers. With his death their magical protection is destroyed, and the mounted soldiers tear them apart.\n" \
"  The mounted men thank you. They offer you a chance to join them as they return to the castle of Count Karken. They tell you that he pays very well and treats his men right. If you would like to join them, go to {91}. If you decline their offer, go to {53}."
},
{ // 10/6B
"The elf dumps the jewels into the basket. It is at this point, after you have paid the 100 gold pieces, that you notice the cobra in the basket. Each gem is worth about 50 gp.\n" \
"  \"All you have to do is reach in a grab a gem,\" Ignxx explains. \"If the snake strikes you, you'll die. If not, you win the gem.\"\n" \
"  For each grab, roll one die. If you get a six, add and reroll. When the total for all your attempts is 20 or greater the snake succeeds in striking you. You may quit whenever you want to. If you [can control snakes or ]are immune to poison and the total of your rolls is 20 or higher, go to {70}. If you are finished playing, go to {121}."
},
{ // 11/6C
"As was already stated, no man has lived to see a dragon's power dive completed. From about 15 metres out Marsimbar lets loose a blast of flame-breath that melts your armour and weapons in addition to roasting you like a marshmallow on a stick. Even if you survive that torching, it buys you little time as Marsimbar lands and snaps you up as a snack. (If you were immortal you find that your spirit cannot leave this room. It was designed to torment the inhabitant of this island. You merely serve the purpose by haunting here.)"
},
{ // 12/6D
"You both disembark and head west down a corridor following the sign's arrow. You come to a room that is 20' by 20' and has no furniture. In the middle of the room stands the warrior of wood.\n" \
"  The wooden warrior is a very lifelike carving of a man. He stands on a platform that has a small control panel that rises to a height of 4'. The control panel has a slot for coins. \"'Place coin in slot, select level of skill for warrior, and allow three seconds for him to clear the stand,'\" Ignxx reads.\n" \
"  The levels of skill for the warrior have nothing to do with levels as far as characters are concerned. If you would like to fight at a level from 1-5, go to {218}. If you would like to fight at a level from 6-10, go to {96}. If you would like to fight at a level from 11-15, go to {162}. If you would like to fight at a level from 16-25, go to {193}. If you would like to fight at level 26 or higher, go to {43}.\n" \
"  Whenever you decide to stop playing with the warrior you may return to your boat and go north to {142}, northeast to {74} or south to {205}."
},
{ // 13/6E
"The water is rather murky. If you would like to make a magical light in order to aid you in your search, go to {183}. If you choose to dive in the dark, go to {97}."
},
{ // 14/6F
"At the door is a grimy little man in pink and black. He looks past you at the looted room. He yells, \"Thief!\" and draws both rapier and sax. He has 115 combat adds and his CON is 25.\n" \
"  If you kill him, go to {192}."
},
{ // 15/7A
"\"No! Don't go!\" Ignxx cries. Once again the woman screams, this time with such terror in her voice that the short hairs on the back of your neck rise. If you decide to go despite Ignxx's warning, go to {129}. If you decide to leave, you may go north to {169}, south to {188}, or southwest to {74}."
},
{ // 16/7B
"\"That little man was my ex-husband,\" she explains. \"I left him a week ago and he was mad - but I never realized how mad. I want to thank you. Allow me to tend to your wounds.\"\n" \
"  She leads you to a tub full of hot soapy water behind a curtain. You disrobe and she washes you. After she tends to your wounds she asks if you would care to join her in bed. If you would like to, go to {44}. If you decide instead to leave, go to {125}."
},
{ // 17/7C
"As you reach the doorway, you feel a sharp impact on your back. Your sword arm goes numb. Whatever hit you punched directly through your armour and does 17 hits worth of damage to your CON. If you are still with us after this damage, go to {138}."
},
{ // 18/7D
"You burst into the Count's room. Huddled in the middle of the bed is the outline of a body, but you detect soft breathing from the far corner. A lamp burns softly by your right hand. It occurs to you that you can use it to destroy the Count and cause as much confusion as possible at the same time - so you throw it into the corner where the figure hides.\n" \
"  The lamp bursts upon impact and sprays the Count with a shower of flaming oil. Immediately the doorway becomes clogged with household guards. The Count, engulfed in fire, moves toward you in an effort to kill you. Your only avenue of escape is to attempt to jump out of the window to your left. Make a fourth level saving roll on Luck (35 - LK). If you make it, go to {98}. If you miss it, go to {199}."
},
{ // 19/7E
"Your companion, Arath, tells you of their plan. He says they plan to pepper the Great Spider with arrows while one man runs into the circle and frees the sacrifice. He hands you a thumb ring and a bow that has a strange grip. You tell him you do not know how to use this type of bow.\n" \
"  \"Would you be willing to run into the circle and save the little girl?\" he asks. You agree to try, and the raid is set.\n" \
"  The canoes hit the edge of a large clearing and the native warriors are off and running. Five of them shoot a concentrated volley of arrows into the crowd before you. Many fall; you cut your way through the rest and into the circle with the girl. The Spider God is down, with hundreds of arrows covering him like stiff fur. You free the girl and turn to find your escape cut off by three cult warriors.\n" \
"  Each has a CON of 30, combat adds of 75 and fights with a scimitar. They are warriors and their green and black silk uniforms will act like quilted silk armour (3 hits[, doubled for warriors]. Those who are not using the 5th edition rules ignore this.) If you kill them, go to {88}. If you don't, the little girl was saved and you are a hero in her village. She will grow up and name one of her children for you."
},
{ // 20/8A
"You make it to the cave. Marsimbar lets loose a blast of flame that comes close to frying your bacon. A cloaked figure reaches out and pulls you from the direct line of fire.\n" \
"  \"I am Briah,\" the figure tells you. \"I've been trapped here for three years. I need you to run out and distract the dragon while I uncover the door out. Biorom placed it 25 metres directly in front of this cave, and then placed large-green-and-scaly out there to stop me from getting at it.\" He pauses for a moment, and fingers his pilum. \"I hope you'll volunteer your help. I'd hate to have to kill you.\"\n" \
"  If you think Briah is off his rocker and you attack him, go to {135}. If you want to distract the dragon in an effort to escape, go to {67}."
},
{ // 21/8B
"\"Decisions, decisions! Which way?\" Ignxx asks as you reach a four way intersection. Check for a Wandering Monster; then, from here you can go north to {74}, south to {180}, east to {188} or west to {205}."
},
{ // 22/8C
"The sound of fighting brings a number of guards - three are already at the door. To battle your way out of the castle, go to {45}. To race to the window and jump out, go to {98}."
},
{ // 23/8D
"The room is dimly lit and misty. In the far end of it, about 30' from where you stand, you see several men. (Roll 1 die + 1 for the number.) You suspect nothing out of the ordinary until you draw close and they look at you with worm-eaten eyes. These men are zombies of former Rangers!\n" \
"  You realize that Biorom placed these men here as a slap in the face of the Rangers. Their undead comrades are bait to lure Rangers in and a means to destroy Rangers who might trust their deceased companions. Since you are not a Ranger and do not suffer from any such ideas, you did not get close enough for the zombies to jump you. If you would like to run, go to {151}. If you want to attack, go to {182}."
},
{ // 24/8E
"For defeating this foe you get 1,000 experience points. You search around and locate his lair. You find a small bag containing six gems (roll for these on the Jewel Generation Table in the rules). You return to your ship and find that the giant's blood, which does not seem to stop flowing, has filled the river enough to refloat your ship. You re-embark and the ship heads towards another shimmering.\n" \
"  This shimmering places you in the harbour of Gull. You guide your ship into port and offload the treasure. The vessel moves on through another shimmering you can barely see. You have done well - now, go to {1}."
},
{ // 25/9A
"You have defeated the toughest character in this adventure. Amid the shards of his hollow form you see Hellblade. From the alcove that had housed the sword comes a dim light, revealing a small leather pouch. It contains 3,000 gp worth of gems. If you want to take the sword Hellblade in addition to the gems, go to {208}. If you want to leave the sword behind, but take the gems and leave, go to {1}. This fight was worth 1,000 experience points."
},
{ // 26/9B
"When constructing the sewers Biorom imbued the area with a spell that would cause any magic user who practiced his craft within the confines of the sewers to be turned into a fish. You have been turned into a fish with no memory of your previous existence. Ignxx enters the tomb, nods at the mummy and picks you up as you gasp for water, your gills slowly drying out. Ignxx dumps you into the sewer canal. You are done, close the book."
},
{ // 27/9C
"\"Thank you. You will be honoured by our cause if you win through. To help you we have this little magical amulet.[ It will make you invisible while you hold your breath.]\"\n" \
"  [This charm will make you functionally invisible. The only time you will have trouble with it is when you are fighting. In that case you are invisible only every other combat turn. (You cannot hold your breath for more than two minutes, if that much, while fighting.) When you are invisible, your foes must divide their combat roll by 2.\n" \
"  ]You are led to the high northwest wall of the Castle. A grappling hook is lofted onto the wall and it holds. You grab the rope and begin to climb. Make a L3-SR on Luck (30 - LK). If you make it, go to {206}. If you don't make it, go to {130}."
},
{ // 28/9D
"You slash to the left, cutting down cultists as you burst into the circle of worshippers. As you race across the clearing you hear war cries from a source that you are certain is not the Spider Cult members. You see the worshippers fall and die beneath a hail of black arrows.\n" \
"  You race unopposed to the sacrifice and sever her bonds with a slash of your sword. She looks towards the arachnid towering over the both of you, screams and faints. You realize that if you try to carry her, the spider will catch you. If you leave her, she will die. Your only choice, the one you make bravely, is to turn and fight.\n" \
"  The spider has a MR of 450.[ Its bite contains spider venom, so if you take any hits on your CON you will begin to suffer the effects of the venom as outlined in the rules. In addition the spider has its web to use in the fight against you. Beginning with the first combat round make a third level saving roll on DEX (30 - DEX). For each combat turn you fight, add 1 to the level of that saving roll. (During the combat rounds, the spider is trailing webs. As you both dance around, it leaves a sticky net on the ground that will begin to slow you down.) For each saving roll you miss, take the number you missed and subtract it from your Dexterity. This is only a temporary loss and indicates the loss of mobility that you are suffering as a result of the web binding up your feet and legs. This will cause a certain reduction in your combat adds. If you reach a Dexterity so low you cannot handle your weapon, you must drop it in favour of another weapon. If your Dexterity goes negative you are entangled and cannot fight in that round unless you make the appropriate level saving roll.]\n" \
"  After eight combat turns, the attacking warriors will finish off the spider with arrow fire. If you survive this ordeal, go to {88}."
},
{ // 29/10A
"As you dry yourself off from the bath the door bursts inward. Framed in the doorway is a very big man whom you recognize as Morgo, thief and part-time assassin. He has a dagger in his hand and blood in his eyes.\n" \
"  If you wish to dive naked and weaponless into the sewers, do so and rejoin Ignxx. From there you can go north to {178} or east to {136}. If you wish to seduce Morgo go to {85}. If you wish to scream for help go to {109}. If you wish to gather up your weapon and fight him, go to {100}."
},
{ // 30/10B
"You mount a set of steps and push open the massive door. Beyond this portal you see an immense grotto, large enough to house a lake and an island in that lake. Before you is a long staircase that gently winds down to the edge of the lake. At the base of the stairway a small boat is moored.\n" \
"  If you would like to use this boat to get to the island, go to {95}. If you want to swim to the island, you must shuck your armour and go to {190}. If you decide that you want to rejoin Ignxx, go to {65} and choose another option."
},
{ // 31/10C
"\"This way eventually leads to the Wraith,\" comments Ignxx. \"He is one mean creature and I don't envy you if you tangle with him. Few walk away from their meetings with him.\"\n" \
"  Your stomach rumbles and interrupts Ignxx's tour guide routine. \"Hungry, huh?\" he asks as he brings the boat closer to the north edge of the canal. \"Over that way,\" he says, pointing towards a darkened tunnel, \"is a guy who'll feed you. He's rather odd, but he had good food. If you want to eat, I'll wait for you.\"\n" \
"  If you want to go off and eat, go to {75}. If you want to forge ahead and continue east go to {101}. If you want to avoid the Wraith, you can do so by returning to {136}."
},
{ // 32/10D
"\"If we walk into an ambush you will be the first to die,\" Kavar tells you. He directs you to take the point position. You move 20' in front of the group and cautiously scout out a safe path.\n" \
"  You enter the shipyards and head for the ship the Rangers are interested in. As you near it, you hear a sound from some of the half-finished hulls to your left. One of Al-Dajjal's house guards shows you his sword and whispers, \"Keep moving, dog or you'll die with the rest of your misbegotten companions.\"\n" \
"  If you wish to lead the Rangers into an ambush, go to {84}. If you want to draw your weapon, lash out at the guard and give warning of the ambush, go to {171}."
},
{ // 33/10E
"\"You have four choices here - which way?\" asks Ignxx. From here you can go north to {170}, south to {74}, east to {169}, or west to {39}. Check for a Wandering Monster before you proceed."
},
{ // 34/11A
"In your hands you hold the sword Fanirfang. It has an ivory blade carven with runes. It weighs 150, and gets 9 dice and 150 adds[ minus 10 times your level number].[ (If you are a 7th level character the sword gets 9d plus 80. The sword adds will never go negative.) If this character ever loses the sword the character will lose 5% of his or her original CON per hour (six game turns), fractions rounded up. This will continue until the sword is recovered and returned to its owner. Restoration spells or any sort of magical healing will not reverse this process. The sword can only be passed on by the death of its owner. (Note: wizards can carry it, but cannot use it. The same result, however, applies to them concerning its loss.)]\n" \
"  The eight 40 MR wooden warriors have closed with you. If you kill them all, go to {212}."
},
{ // 35/11B
"You were standing beneath an iron portcullis which has crashed down upon you. If you missed both saving rolls, you weren't smart enough to think of the trap and you didn't move fast enough to avoid the portcullis. You got squashed like a bug.\n" \
"  If you missed one of the rolls, either you didn't think of a trap or you moved too slowly to avoid the portcullis. The portcullis caught you on the shoulder and inflicted five hits regardless of your armour. (Those with light armour moved faster sustaining less relative damage than characters better protected, but armoured like a tank.) This portcullis has fractured your shoulder.\n" \
"  Now you may only use a one-handed weapon, as one arm is out of the fight. Roll three dice to see how many rats (20 MR each) you must fight. If you win, go to {119}."
},
{ // 36/11C
"It is possible to use magic now because you are out of the sewers. This monster has a MR of 210. If you want to hit it with a Panic spell, use it. If you cannot use that spell or do not wish to, choose a suitable combat spell and attempt to kill the beast. If you kill it, go to {148}."
},
{ // 37/11D
"\"We cannot let you live if you won't help us,\" one of them warns. You, however, are on horseback while they are on foot. You drive your foot into the ribs of the horse and it leaps forward. You burst through their line and one of them makes a grab for you in an effort to pull you from the saddle. Make a L5-SR on Dexterity (40 - DEX). If you make it, go to {197}. If you miss it, go to {6}."
},
{ // 38/11E
"Make a 7th level saving roll on Luck (50 - LK). If you make it, go to {177}. If you fail, go to {140}."
},
{ // 39/12A
"As you pass down the canal some glowing moss reveals a door covered with ancient writings. \"There's more to the message, but the moss is covering most of it. Ignore it and let's get out of here,\" Ignxx whines.\n" \
"  If you want to scrape moss away and try to read the message, go to {198}. If you want to press on, go east to {33}, or south to {122}."
},
{ // 40/12B
"There are two types of people; the Quick and the Dead. You obviously are not one of the former, which makes you one of the latter. The Wraith's sword, Hellblade, cleaves you into several different parts. (For the actual number of parts, take the number of saving rolls you missed and multiply by two.) Close the book - you are done."
},
{ // 41/12C
"On your way back across the lake, you pass the spot where Marsimbar sank. Beneath the water one of his wings twitches in its death throes and swamps you. (The death throes of a dragon would swamp the Queen Mary.) If you were in your little boat, you are tossed over the side.\n" \
"  Roll to see if you encounter a Wandering Monster as you swim for the shore. If you get one, deal with it and go to {65} for your options to leave."
},
{ // 42/12D
"You head for the man who seems to be the leader of the group of pirates. He looks just over 5½' tall, very lean and very nasty. \"I am Kavar,\" he says. \"Guide us to the new Al-Dajjal ship being built in the shipworks.\"\n" \
"  The name Kavar is not unknown to you. You have heard that he is a superior swordsman (perhaps even better than Marek) and he has been reported dead on at least six different occasions. Above all you have heard that he is a fair man, slow to anger but vicious when crossed. If you decide to help him get to the ship being built for Al-Dajjal (you just happen to know where it is), go to {32}. If you decide to attack him, go to {57}."
},
{ // 43/12E
"The wooden warrior pitches off the stand and begins smoking at the ears. You hear gears whirring in its chest. A high-pitched whine fills the room and the wooden warrior explodes, doing 7 dice damage to you.\n" \
"  \"What have you done?\" Ignxx cries out. \"Now I'll never get out of here! Biorom will have my head in a basket.\" He wails and moans. Suddenly, a furtive look appears on his face. \"I guess a little demon magic will have to be used to clear this problem up,\" he says, shooting a glance at you.\n" \
"  Make a 4th level saving roll on Charisma (35 - CHR). If you make it, go to {145}. If you miss it, go to {61}."
},
{ // 44/13A
"After your bath she towels you off and leads you to the large bed in the room. You are making love when the door explodes off its hinges. Framed by the doorway is a huge man. She cowers and breathes one word. \"Morgo!\"\n" \
"  You know Morgo by reputation only, and that reputation is a bad one. If you fight Morgo, go to {157}. If you want no part of this fight, you may dive back into the sewers (without your weapons, armour or treasure). If you choose to dive, rejoin Ignxx and go east to {21} or north to {178}."
},
{ // 45/13B
"These three have a MR of 90 each. If you defeat them, roll three dice. This is the number of guards you must defeat to make it back to the northwest wall and freedom. Roll one more die and divide the number of guards by your roll to determine how many guards there will be in each group. (If you face 18 guards and roll a 6, you must fight six groups of three guards.) The guards you must fight on your way out each have a MR of 50. (If there is a remainder to your division, add the extra to the last group you fight.) If you win through, go to {63}."
},
{ // 46/13C
"Being the quick thinker that you obviously are, you strip the guard's body and don his clothing. You find a silk hood that he had tossed off to be able to use the blow gun; you put it on to hide your features. You also locate and follow a path that parallels the main path.\n" \
"  Suddenly you come to a large clearing. In the middle of the clearing ringed by the faithful of the Spider God, there is a small five-year-old girl bound to a stake. Across the clearing from you there is a large bamboo cage that contains the largest spider you have ever seen in your lifetime (or nightmares).\n" \
"  Someone starts beating a drum; the cage door begins to open. The spider emerges and the girl screams. If you want to attack the spider in an effort to save the sacrifice, go to {28}. If you stand and watch the sacrifice, go to {159}."
},
{ // 47/13D
"The wooden warriors back off, half in terror of the fire, half because you have taken nothing of value. You cut a fiery path to the rail and dive overboard. Check to see if a Wandering Monster is attracted. Once you have dealt with any threat, you climb back aboard your own boat and go to {5}, as the alien death ship has disappeared."
},
{ // 48/13E
"A second man appears in the doorway. He stands just shy of 6' feet tall and has a wiry frame. His eyes are an icy blue and they lock on Morgo. The interloper clears his throat and the assassin turns to face his new foe.\n" \
"  You watch as Morgo cuts at the new man with the great sword. The smaller man dodges the blow and steps in on Morgo. Morgo catches four or five shots from the fists of the interloper. Finally a quick right clips Morgo's chin and the assassin stumbles down the passage to the sewers.\n" \
"  You recognize the man who stepped in as Marek, the master of the younger rogues of Gull. You thank him and he bows. \"It was my pleasure, M'lady,\" he says as he deftly removes all of the jewellery from the vanity table. He flashes you a smile and leaves.\n" \
"  Bathed and refreshed, with all of the treasure you got from the sewers, you may leave this apartment. Go to {1}."
},
{ // 49/14A
"Your leap out the window lands you in a thorn bush. Take one embarrassing hit. You are out, go to {1}."
},
{ // 50/14B
"This man is the wizard Briah. He was placed here by Biorom to practice with the pilum until he reached the point where he could defeat the dragon. (Briah had once commented that a warrior's skills were not nearly as hard to learn as the sorcerer's arts.) Since he cannot use magic to fight the dragon he has trained diligently and has gotten quite good.\n" \
"  Briah gets 154 combat adds. The pilum he holds is not enchanted, nor does he get double hits for his tower shield. If you kill him, go to {102}."
},
{ // 51/14C
"\"Biorom is right. You're too ugly to stick in that cage,\" the sorceress Jasmine tells you. \"No one would fight to save you.\" She touches another brick. \"Come on, let's go have a drink.\" A door slides back and reveals a sun-drenched stairway leading up. Ignxx stands at the head of the stairs, waiting there with your treasure.\n" \
"  Jasmine casts a Healing Feeling on you as you clear the sewers, You are out; go to {1}."
},
{ // 52/14D
"You run swiftly along the path, keeping a watchful eye on the roots and pitfalls that seem determined to stop you or break you in your escape. You see the trip wire before you, but your headlong flight is impossible to check in time. The wire is tripped and a net springs up around you.\n" \
"  Your sword flies from your hand as you are hoisted high in the air. If you have a dagger, go to {106}. If you do not have a cutting weapon of some sort, go to {143}."
},
{ // 53/14E
"They say OK, but charge you with the duty of burying the bodies. You collect a little gold (2d × 10 worth) from the bodies of the rebels and a pilum that is in very good condition.\n" \
"  However, the smell of blood in the clearing is strong enough to attract the attention of a passing Ogre. He has a club (6 dice) and 124 personal combat adds. His CON is 45. If you kill him, go to {1}. He has no treasure on him."
},
{ // 54/14F
"You rip the room apart, finding little in the way of treasure. The only valuable items you see are the silver service from the table and a ring on the dead man's finger. If you take the ring, go to {71}. If you only take the silver service you find it is worth 150 gp. Rejoining Ignxx, you find you can go west to {136} or east to {101}."
},
{ // 55/14G
"This fork leads you along the coast. As you walk toward the city, you enjoy the smell of the salt air and the cool, fresh breeze that blows in from the sea. In no time you see the high battlements of the city wall and you begin to think about revenge upon those bandits who tossed you into the sewers.\n" \
"  The grin that graced your face as you thought of revenge melts. Near the base of the city wall you see a group of twenty men clad in the black uniform of Rangers. All are armed and you suspect that they must be fairly desperate to be skulking around the city in the daylight. If you wish to run and sound an alarm, go to {154}. If you move towards them to talk, go to {42}. If you launch an attack upon them, go to {107}."
},
{ // 56/15A
"You climb up about 20'. There is a gold-plated grate at the top of the ladder, but it is unlocked. You quietly push but it springs open and clatters noisily on the marble floor. You look around and find yourself in the toilet section of a well-appointed apartment. As you emerge from the sewer a beautiful woman steps into view holding a crossbow at pointblank range. Startled, you choke out a hasty greeting.\n" \
"  If you drop back down the ladder in the sewers, rejoin Ignxx and go north to {70} or east to {21}. If you want to strike out with your sword and try to kill her, go to {38}. If you want to drop your weapons and emerge peacefully, go to {81}. If you have sores or jaundice, go to {140}."
},
{ // 57/15B
"His rapier clears its scabbard soundlessly. His skill with a sword amazes you. His silver blade traces patterns that mesmerize you. With a flick of his wrist he sends your sword skyward. He catches it before it hits the ground.\n" \
"  \"I had hoped you would aid us without any pressure,\" he says. Now I am afraid that you must aid us - or we will kill you.\" He hands your sword back to you, and insists that you lead the way to {32}."
},
{ // 58/15C
"You swim to the boat from the waterfall. Ignxx helps you in and propels the boat to the east. You travel for a long while; the canal bends slightly to carry you to the northeast. Finally you reach a half-submerged iron grating that blocks the canal from the outside.\n" \
"  \"This is the end of the line for me, ace,\" Ignxx tells you. \"You'll find yourself in the swamp area northeast of Gull. Be careful, because you've worked hard to get this far.\" Ignxx conjures up a small red bag for you to put your booty in. As you prepare to leave, he opens the grating. \"Good luck!\" he cries as he, his boat and the red ring vanish.\n" \
"  You do indeed find yourself in the swamp. You have heard many tales about the swamp, the most frightening being the story of the Spider Cult and their strange human sacrifices. Looking around, you see two ways to travel through the swamps. You can either walk along the built-up pathways in the swamp, or swim beside them. If you wish to swim, go to {79}. To stay warm and dry by walking, go to {216}."
},
{ // 59/15D
"Each missed saving roll means a sword hit you. Each sword does 5 points of damage that you can take on your armour, and slows you down enough for one of the zombies to catch up with you. His MR is 80. If you can defeat him in two rounds you escape. If not, the other zombies in the room close and attack, each with an 80 MR.\n" \
"  If you defeat the first zombie, you may leave. Ignxx can take you north to {39}, south to {142} or southeast to {74}. If you are forced into fighting all of the zombies, and still destroy them, go to {3}."
},
{ // 60/15E
"You stuff his body down into the sewers, yelling to Ignxx to take good care of him. From his body you take 250 gps. The fight was worth 150 experience points. You can locate about 1,000 gp worth of stuff to steal from this room. Go to {1}."
},
{ // 61/16A
"Ignxx decides that he doesn't really want to repair the wooden warrior. Instead he weaves a spell that turns you into another wooden warrior.[ Remember to charge a gold piece a fight, and hope that no one wants to fight you at level 26 or higher.]"
},
{ // 62/16B
"Your ship passes through the shimmering area and arrives in a very large and dark cavern. In the torchlight from your own ship you see the dim outlines of other ships like yours and some glinting that suggests they too may be loaded with treasure.\n" \
"  \"We aren't going to be able to stay here long,\" Ignxx notes. \"If you want, we can load up my boat with 5,000 gold pieces and get out of here.\" If you wish to do this, consider it done and go to {196}.\n" \
"  Your ship, laden with at least 10,000 gp of treasure, is headed towards yet another shimmering area. If you wish to tell Ignxx to cast off and you alone are willing to pass into this shimmering area, go to {126}."
},
{ // 63/16C
"You reach the rope and slide down to the ground. You run to the woods surrounding the castle while arrows fall about you. You are lucky and reach {158} unharmed."
},
{ // 64/16D
"You seem to be as smart as you are good-looking. You crack her a good one on the jaw. You remove her robe and stuff her back into the cage. You walk back into the small room, search and find another fake brick. You press it and a passage to the surface opens up. As you leave you see the face in the mirror laughing. Well done. Go to {1}."
},
{ // 65/16E
"On a wooden door to the east you see an odd rune. You ask what it is and Ignxx answers, \"That is the Dragon Rune. It serves as a warning device, for not many who enter that room will leave it.\"\n" \
"  If you would like to venture within that room, go to {30}. If you want to leave this place, you can go south to {188}, north to {136} or northwest to {74}."
},
{ // 66/16F
"\"I require something from every person who tries to leave here,\" he says to you. \"I require a chance at getting your soul.\" He moves back into the alcove that lay previously unseen behind him. As he enters, it is illuminated by a sinister glowing. On the wall you see a large black sword and a small leather bag. It is the bag he removes from the alcove.\n" \
"  He moves back towards you and opens the bag, pouring the contents onto a table that materializes before you. Three large gems and two dice roll out. The dice are black and have death's heads instead of ones.\n" \
"  \"The game we will play is simple,\" he explains. \"Your soul against these 1,000 gp gems.\"\n" \
"  If you wish to play, go to {127}. To bolt and run for it, go to {215}. To fight him, go to {111}."
},
{ // 67/17A
"\"Stop looking at me like I've lost my mind!\" he cries. \"You've managed to dodge his flame before - I think you have a real aptitude for it. I want you to dodge him while I open the doorway and escape. When I get outside I can teleport you out. Look alive, let's go!\"\n" \
"  You both hit the beach and Briah uncovers the door while being accompanied by a wailing alarm. Marsimbar swoops low and blasts the door with fire. The ring used to open it glows white-hot.\n" \
"  Roll two dice. That is the number of attacks the dragon will make before the ring is cool enough for Briah to open the door and escape. You must make that number of fifth level saving rolls on DEX (40 - DEX) to escape the dragon's flames. If you miss a saving roll, subtract five from your DEX (leg damage) and continue. A second missed roll will mean that you dodged poorly and Marsimbar ate you.\n" \
"  If you survive, go to {76}."
},
{ // 68/17B
"You sneak up on the cavalry men and unhorse one with your first thrust. You leap into the saddle and smash your horse into two others, upsetting their riders. The cavalry's formation is shattered; the infantry drags the horsemen from their saddles and kill them.\n" \
"  The leader of the foot soldiers approaches you. He is tired and bleeding from several cuts. \"Thank you, stranger,\" he says. \"We are a group of men dedicated to killing our evil overlord, Count Karken. We were on our way to attempt to assassinate him when this patrol happened upon us. As you can see, we are hardly fit to complete the mission we started these evening. I would like to ask you to aid us again. Go to the castle of Count Karken and rid this land of an evil man.\"\n" \
"  If you would like to help these men by trying to kill the Count, go to {27}. If this type of mission is not to your liking, go to {37}."
},
{ // 69/17C
"\"Our reward to you,\" says Kavar, extending a sack. In it you find loot from the men killed in the ambush: 100 gold pieces and three gems (roll for them on the Jewel Generator in the rules). Kavar leaves as his men torch the ship they wanted; he suggests that you leave also. Go to {1}."
},
{ // 70/17D
"The elf strikes just a bit slower than the snake, but his aim is just as true. He jams a dagger into your eye as he cries the elven word for 'Cheat'. The blade enters your brain and kills you instantly. You are dead, close the book."
},
{ // 71/17E
"As you take the ring from the dead man's finger you are teleported. You appear in a very beautifully decorated room. In front of you is a man who is dressed in black robes which are covered with arcane designs. He is thin and lithe; his black hair and beard are neatly groomed. His black eyes lock onto yours and he speaks.\n" \
"  \"So, the rat catcher is dead. Whatever am I going to do with you?\" he asks.\n" \
"  If you wish to attack this wizard, go to {200}. If you do nothing and killed Leo while he was in man-form, go to {173}. If you do nothing and killed Leo while he was in cat-form, go to {152}."
},
{ // 72/18A
"Congratulations! In your right hand is the sword Fanirfang. It weighs 150 and has an ivory blade worked with runes that give it 9 dice and 150 combat adds[, minus your level number times 10].[ (A seventh level character gets 9 dice and 80 adds. The adds on the sword will never go negative.) If you lose the sword you will lose 5% of your original CON per hour (six game turns) until it is recovered. The sword may only be passed on by the death of the current owner. (Wizards cannot wield the sword, but they will suffer the detrimental result of losing it.)]\n" \
"  On your shield arm you have the \"Do Unto Others\" shield. It weighs 400[ and will reflect half of the hits you must take back upon the foe that generated them. The shield's properties only work for damage done by weapons wielded by corporeal foes. The shield will not reflect any magic or hits as a result of a trap. Your armour may absorb any damage you must take, up to its rating. Warriors cannot double the damage reflected].\n" \
"  The air begins to glow about you. The wooden warriors back away. \"There's enough power coursing through you to create a dimensional doorway out of here!\" Ignxx yells. \"Concentrate on your home!\"\n" \
"  Make a fifth level IQ saving roll (40 - IQ). If you make it, go to {1}. If you don't, go to {141}."
},
{ // 73/18B
"You may pick up Morgo's weapons. You also take a gem from his body worth 1000 gp. She gives you a 500 gp gold necklace set with a ruby. Both of you struggle and shove Morgo down into the sewers, yelling to Ignxx to look out, and she guides you to the door. The fight with Morgo was worth 151 experience points. Go to {1}."
},
{ // 74/18C
"\"Herein lies danger,\" Ignxx cautions. Roll two dice. If you get doubles, go to {2}. If you don't roll doubles, you can leave this place by going north to {33}, south to {21}, east to {136}, west to {142}, northeast to {105}, southeast to {65}, southwest to {178} or northwest to {122}."
},
{ // 75/19A
"You hop out of the boat and walk down the dark path. The pathway winds back and forth but eventually leads you to a small, brightly lit room. In the middle of the room is a table laden with a vast selection of cheese and some sort of animal meat.\n" \
"  At the far end of the table a man rises from a chair. He sets a book down and greets you. \"I am Leo Felis. I live here, placed by Biorom to monitor the sewers and to entertain people like yourself. Please help yourself,\" he says.\n" \
"  You draw closer and are impressed with the selection of cheese, and slightly puzzled by the lack of an equally wide selection of meat. Careful inspection of the meat shows it to be greasy and stringy. If you decide to attack this man go to {194}. If you would like to eat some cheese, go to {104}. If you want to sample the animal flesh, go to {165}."
},
{ // 76/19B
"You are out of the sewers. Briah shows his appreciation by curing any disease you may have contracted while in the sewers. He buys you a hot bath and meal (in that order) and gives you either 1,000 gold pieces or two spells 1-6th level (if you are a wizard, rogue, or warrior-wizard who wants spells). Getting past the dragon, by stealth or by force of arms, nets you 1000 experience points in addition to any others you have gathered in your adventuring. Go to {1}."
},
{ // 77/19C
"You climb up about 20' and find a gold-plated grate over the top of the ladder. You push on it and it springs open. You emerge to find yourself in the washroom of an apartment of a lady of Gull. No one is in the main room, but there is a hot steaming bath in the corner behind a silk curtain. A soft bed, a wardrobe full of beautiful clothing and a table near it covered with expensive perfumes and cosmetics complete the setting.\n" \
"  If you would like to avail yourself of the bath, bed and clothing, go to {29}. If you want to rip this place off, go to {124}. If you just want to leave, go to {195}."
},
{ // 78/19D
"You find it is not an apparition at all, but a misguided peasant driven by a fanatical desire to kill the Count. As you close to fight, he vanishes. You step back and are alerted to his presence by the sound of his sandals scraping across the stone on top of the wall.\n" \
"  He has a CON of 27 and 115 combat adds; he fights with a scimitar and carries a buckler.[ On every odd-numbered combat round he is invisible, and you must divide your combat roll by 2.]\n" \
"  If you kill him, go to {184}."
},
{ // 79/19E
"Swimming might not have been the most intelligent action you have ever taken. You feel a powerful tug on your leg - it goes numb. You are pulled beneath the water and you find that a rather large crocodile is attempting to make a lunch of your leg. Take 6 hits regardless of armour, and make your drowning saving roll on CON. If you would battle the reptile with magic, go to {36}. If you want to draw your knife and attack the crocodile, go to {7}."
},
{ // 80/19F
"As you reach for a jewelled tiara, a hand grabs your wrist. Bone white fingers covered with tattered linen twist your arm with incredible strength. Effortlessly the mummy from the throne flips you into the side wall of his tomb.\n" \
"  If you would like to try to fight this mummy with weapons, go to {134}. If you would like to fight the mummy with magic, go to {26}. If you would like to flee, go to {17}."
},
{ // 81/20A
"\"You look as though you have seen some hard times,\" she says as she lowers the weapon. \"Let's get you cleaned up and see what you're hiding under all that grime.\"\n" \
"  She leads you into her boudoir. Behind a standing silk screen is a tub full of hot soapy water. You disrobe and slip into the water, keeping your weapons and treasure close beside you. The water is warm and you relax as she takes her clothing off and joins you.\n" \
"  A sharp knocking sound intrudes upon your peaceful bath. She rises, dons a robe and pulls the curtain so it cuts you off from a view of the door. She cautions you to silence and goes off to answer the door. Once there, you hear her speak to a voice which sounds male. Both of them soon become agitated and angry.\n" \
"  If you wish to sit tight, go to {44}. If you wish to take up your weapon and attack the man at the door, go to {168}. If you want to leave the situation, you may gather up all your belongings and reenter the sewers, going either east to {21} or north to {178}."
},
{ // 82/20B
"You run as fast as possible, mere inches ahead of his deadly sword. You charge down the canal pathway and dash into sunlight. From behind comes a scream of frustration.\n" \
"  \"Damn you, for you have defeated me. Therefore, you are absolved of curse and geas alike where connected with me in any way!\"\n" \
"  You walk away from his screams, fill your lungs with good fresh air and head towards Gull. Go to {1}. You have survived."
},
{ // 83/20C
"This could be your lucky day. You have grabbed the famed \"Do Unto Others\" shield. This shield weighs 400.[ During combat, it will reflect half of the hits you must take back upon the foe who generated them. You must take the other half, though your armour will take its share. (Warriors do not double the hits reflected.) The properties of this shield only work on damage inflicted by actual foes using actual weapons. The shield will not reflect damage as a result of magic, traps or noncorporeal foes.]\n" \
"  The reason this could be your lucky day is because the eight wooden warriors are closing fast. The first three will fight you alone for two combat turns, then the remaining five will join in the fray. Each has a MR of 40. If you kill them all, go to {212}."
},
{ // 84/20D
"Kavar warned you that you would be the first to die in an ambush. As you turn to watch the fight, you see his hand move swiftly in your direction three times. You feel pain, then numbness in your chest as three shuriken hit you. The shuriken are made of kris metal and were poisoned with sea snake venom. The kris disrupts the spells Healing Feeling and Too-bad Toxin enough that, even if you could cast either spell, you would be too far gone to survive. Needless to say, you are dead."
},
{ // 85/20E
"\"Come here, you...\"  you say in a low seductive voice. You move onto the bed and discover a dirk hidden beneath the pillow. It you move to engage him in battle right now, go to {100}. If you want to wait and stab him in bed go to {186}."
},
{ // 86/21A
"In this small room you see a dark elf, a wicker basket and a small, lumpy sack which you guess might be full of gems. As the demon and the elf talk, the elf notices your interest in the sack and speaks to Ignxx.\n" \
"  \"Aradon has a little game you can play, if you want to try and win some of the gems,\" Ignxx says. \"It'll cost you 100 gold pieces to play.\" If you are interested in playing, go to {10}. If you have no money or decide not to play, go to {121}."
},
{ // 87/21B
"Make a saving roll on Luck at fifth level (40 - LK). If you make it, go to {20}. If you miss it, go to {202}."
},
{ // 88/21C
"The leader of the attackers, the older brother of the girl you have saved, thanks you heartily. He insists you take a canoe to return home. If you are sick he casts a Healing Feeling on you. He turns over to you a portion of the loot that was taken from the bodies of the Cultists. (Roll three times on the Jewel Generator in the rules to see what you got.) This adventure has been worth 550 experience points. Go to {1}."
},
{ // 89/21D
"You cannot seem to make heads or tails of the message. Being wiser than your literacy would seem to indicate, you decide not to enter this room. Roll to see if you encounter a Wandering Monster here, since you have been in one place for a while. After you deal with it (if there is one), go to {33}, or head south to {122}."
},
{ // 90/21E
"The sound of metal striking metal attracts 3 dice more worth of rats. Roll for them and try to kill them; each rat still has a MR of 20. If you kill them all, go to {210}."
},
{ // 91/21F
"You are taken to the Castle of Count Karken. You find yourself cordially received and employed as one of his household guards. Equip yourself in any manner you desire from his armoury; however, all of his guards use mail and a knight's shield.\n" \
"  The second night of your service, you are standing guard duty on the high northwest wall of the castle. It is near midnight and the twin moons of Ajor are not seen. This is known on Ajor as an Assassin's Night. You hear a scraping sound over to your left, and when you turn to look, you catch a fleeting glimpse of a man.\n" \
"  If you would like to check out the apparition, go to {78}. If you figure it is just a product of your overactive imagination, go to {115}."
},
{ // 92/22A
"Climbing down the slick rocks will take a combination of Dexterity (ability to cling to wet rocks) and Constitution (sheer guts). Make a saving roll on fourth level (35 - DEX/CON) on each. If you miss both, you slip and die on the sharp rocks below. If you miss one saving roll you fall into the pool below the falls, and must fight one Wandering Monster before you reach the boat. If you make both, you climb down without mishap. If you survive, Ignxx takes you to {58}."
},
{ // 93/22B
"Swimming beneath the wires is easy. The only threat you must deal with is a Wandering Monster. If you get a dolphin as the Wandering Monster in this instance, it lifts you into the wires and you fry. Barring the possibility of getting a dolphin, after you deal with the Wandering Monster you swim to the boat and Ignxx takes you to {214}."
},
{ // 94/22C
"He cries out in pain and reels to the opening to the sewers. He stumbles in and is gone. From his equipment you can gather a sax and a great sword. He had 250 gold pieces on his belt and the room yields another 1,000 gp worth of portable loot. Go to {1}."
},
{ // 95/22D
"As you sail close to the island, you see that on the top of the cliff facing you there is a dragon who appears to be sleeping. The beach at the base of the cliff is about 50 metres wide and directly before you a cave can be seen in the base of the cliff. It is small, only man-sized, and obviously is not the lair of the dragon.\n" \
"  If you wish to sail to the island in an effort to gain the cave before the dragon notices you, go to {209}. If you would like to challenge the dragon to fight over water, go to {117}."
},
{ // 96/22E
"On these levels the wooden warrior gets the level number (6-10) plus 20 in CON points, and four times the level number in combat adds. His sword is worth 4 dice plus 2 in this level bracket. (At level 10 he would have a CON of 30, combat adds of 40 and 4 dice plus 2 for his weapon.) Constitution represents the number of hits it will take to turn him off.\n" \
"  If you defeat him, you get 8 times the level number in experience points. You may continue to play, but only at a higher level. If you want to move to a higher level set, or wish to stop playing altogether, go to {12} for your options. Remember to deduct one gold piece per fight."
},
{ // 97/22F
"To search this pool you are going to have to make a series of dives. The pool is 25' deep and the drowning saving roll on CON *does* apply during your searches.\n" \
"  For each dive, roll two dice. If they come up doubles you have located some treasure. Roll on the Treasure Generator (not just the Jewel Generator) in the rules to see what it is. If the roll does not come up doubles, check to see if you must deal with a Wandering Monster. If you successfully deal with the monster, you may continue to dive.\n" \
"  You may dive for as long as you wish. When you tire of this you may rejoin Ignxx and either go south to {105} or west to {33}."
},
{ // 98/23A
"You make it to the window unhurt. 30' below is the moat. You can see that it is mostly shallow except for a small deep pool. As the Count gets near enough to grab you in his fiery hands, you dive. Arrows accompany your descent, but you splash into the deep pool unharmed.\n" \
"  You must deal with one wandering monster from this pool (ignoring disease at this point). Then you may leave the water and recover any treasure obtained earlier from the place nearby where you hid it. Go to {158}."
},
{ // 99/23B
"As you run along the canal edge you hit a slick spot. Make one saving roll each on LK and DEX, on the fourth level (35 - LK/DEX). If you miss both, you get pulped. If you miss one or the other, take the number you missed by in damage. If you made both, or survive missing one you climb back into the boat and go north to {191}."
},
{ // 100/23C
"Morgo is fighting with a sax. He has personal combat adds of 151 and a CON of 20. He has been enchanted so that he cannot die at the hands of a female. If you reduce his CON to one, it will remain at {1} and he will be unconscious. If you win, go to {60}."
},
{ // 101/23D
"Before you in the canal you see a shimmer of light. Out of the light you see a ship entering the canal. The workmanship on the vessel is totally alien to you. Upon it are eight wooden warriors, carved to look almost alive. They guard a body that is resting in the middle of the ship.\n" \
"  \"I have never seen anything like this before,\" Igwxx breathes softly. \"Something is very wrong here.\" If you wish to pass it by, you may go to {5}. If you wish to board the ship to investigate, go to {207}."
},
{ // 102/23E
"\"Bastard!\" he groans with his last breath, and hits you with a curse (he no longer cares if he becomes a fish). You feel yourself growing smaller. Halve all of your attributes.\n" \
"  As you walk back to your boat, being smaller and slightly smarter you notice part of a metal ring that appears to be buried in the sand. You dig around it and find that it is attached to a door. You pull it open and feel a cool breeze that is coming from the surface. (If you are slightly concerned because this leads *down*, and the surface is *up*, don't be. Biorom knows what he's doing.) If you would like to leave this way for the surface, go to {1}. If you want to return back across the water the way you came in, go to {41}."
},
{ // 103/23F
"The familiar air of this place rekindled in your mind thoughts of tales from the old days. You realize that the purpose of all this treasure is to assure the Prince's pleasant survival in the afterlife. Suddenly a plan forms itself in your mind.\n" \
"  You kneel at the foot of the throne. \"My lord, I offer you this dagger,\" you intone, \"as it will stand you in far better stead in the afterlife than this treasure. I will ease the burden of your transition by accepting this jewelled circlet in exchange for my dagger and as a sign of your favour upon me.\"\n" \
"  The circlet has seven gems in it, and the band is made of silver. (Roll for the gems on the Jewel Generator in the rules.) Remember, you are now short one dagger.\n" \
"  As you leave, you note that there is a doorway in the south wall where there was none before. If you would like to enter you can tell Ignxx to head south and go to {23}. You may also rejoin Ignxx at the boat and go to {33}."
},
{ // 104/24A
"\"You have eaten cheese! You are one of them!\" Leo shrieks, his voice changing to a low rumble in mid sentence. You turn to face him and see him going through a strange metamorphosis. He has dropped to all fours, his hair has become long and his clothing has ripped to reveal a furry, tan hide beneath. In moments he has completed his transformation into a lion.\n" \
"  His Monster Rating is 350. You realize Biorom set him here to help deal with the rat problem. His limited cranial capacity (he's a warrior) led him to believe anyone who eats cheese is a rat. To continue living, you must kill him. If you succeed, go to {155}. (His body regains its human form upon death.)"
},
{ // 105/24B
"Ignxx poles the boat into an intersection. \"I really hate this area...so many rats,\" he says with a shudder. You look around and see pairs of yellow eyes staring at you from the darkness. Ignxx lifts the pole from the water and pokes at one of the pairs of eyes. The rat flees, squealing loudly.\n" \
"  Ignxx points out that from here you can go southwest to {74}, north to {169} or south to {136}. Suddenly you hear a female voice scream, \"Is anyone out there? Help me, please!\"\n" \
"  Her cry comes from a darkened doorway in the east wall. If you would like to investigate, go to {15}."
},
{ // 106/24C
"With your dagger you cut a large hole in the net. You manage to get half of yourself free when a man springs out of the brush at you. He is clad in a green and black silk fighting suit. His shirt is off and tied about his waist. You can still see the spider insignia worked upon the shirt and you know that he is a member of the Spider Cult. He fights with a scimitar, has 110 combat adds and a CON of 28.\n" \
"  You must kill him[, but in your fight you only get your Luck adds]. [Your ST and DEX are neutralized by your entanglement in the net. ]If you kill him, go to {46}."
},
{ // 107/24D
"Three Rangers move to engage you. Each has a sword drawn, and their compatriots head towards the shipworks. To fight them with magic, go to {139}. To fight them with only your weapons, go to {211}."
},
{ // 108/24E
"The light reveals to you that your victim is not in the bed. The bulky outline in the bedsheets is a dummy - the Count stands in the far corner of the room with sabre drawn. \"Killing me will not be as easy as you expected, will it?\" he sneers as he closes to fight.\n" \
"  The Count is wearing leather armour and he holds a buckler. He gets 240 combat adds and has a CON of 45. [You may use the power of invisibility while fighting. ]If you kill the Count, go to {22}."
},
{ // 109/25A
"As you cry out, Morgo growls in a low voice. He strides across the room towards you, great sword replacing dagger. Avoiding the blow he is aiming at you will require a fifth level DEX saving roll (40 - DEX). If you make it, go to {48}. If you fail you take the damage for a great sword and 151 combat adds. If you survive go to {48}."
},
{ // 110/25B
"The tomb has a low ceiling that is supported by six columns which look like sarcophagi. The room is 20' deep and 10' wide, decorated in an ancient style that you recognize from some of the older buildings in Gull. At the far end of the tomb you see a throne; a mummy is seated upon it amid piles of treasure.\n" \
"  If you would like to grab some treasure, go to {8}. If you have the means for making fire and want to torch the mummy on the throne, go to {147}. If you want to use the same firemaking capabilities to burn the guardian mummies within the sarcophagi, go to {176}. If you would like to leave, rejoin Ignxx and go east to {33} or south to {122}."
},
{ // 111/25C
"From the alcove behind him he draws his sword Hellblade. The Wraith has a CON of 100, combat adds of 400 and his statue-like form will absorb twelve hits as though it were armour. Hellblade rolls 9 dice and gets 100 adds.[ If you take hits on magical items designed to absorb hits, they will take hits totaling up to their maximum limit and then explode. (An amulet designed to take 50 hits will take 50 hits and then be destroyed.) This also carries over to magical armour. Regular armour lasts just one turn against Hellblade.]\n" \
"  If he slays you in the first combat round, you are dead. Close the book. If you last past the first combat round and you want to flee, go to {215}. If you kill the Wraith, go to {25}."
},
{ // 112/25D
"She screams and twists out of your grasp as she dies. Your sword is torn from your grip and the door swings open to reveal a little man with a rapier and dirk. He has 115 combat adds and you have just slain his wife. He attacks[ before you have a chance to tear your sword free from her body]. He wears no armour and has a CON of 25. If you kill him you get 115 experience points and 500 gold pieces from his purse. There is now a warrant out for your arrest for the woman's murder, but a scum like you should be able to dodge the law. Go to {1}."
},
{ // 113/25E
"\"We've not seen many a man from Gull who fights like you,\" Kavar says. \"We'd be proud to consider you one of us.\"\n" \
"  He hands you 3000 gp worth of gems, and a gold ring with a glass stone set in it. He shows you how to open it and reveals a secret insignia hidden beneath the stone. The insignia looks like the letter R with a dagger acting as the diagonal leg. \"There are places where you can get aid for what you have done for us today. Show them the ring and they will help you.\"\n" \
"  [If you are ever in Gull, you may get a loan of 500 gold pieces from selected merchants in the city. These are men who trade with the Rangers even though it is illegal to do so. If you ever fail to pay them back, they will kill you in a most horrible and terrifying way. Also, being a Ranger, you are a sworn enemy of the Empire of Khazan. If you are ever caught and taken by the men of the Empire you can expect no mercy from them. (If they consider you unsuitable for Naked Doom, you will be placed in the Arena of Khazan for ten fights as a slave. If you do not have access to a copy of Arena of Khazan, you are not in a position to fulfill your sentence - so the forces of Khazan will slay you out of hand.)\n" \
"  ]The Rangers burn the ship and leave. You get 500 experience points for the fight. Go to {1}."
},
{ // 114/26A
"Looks you have, but brains are another matter altogether. As you peer into the mirror she bashes you on the head. You [sink into unconsciousness ]a[nd awaken in the cage. Five hund]re[d rats from now, this character will be released. When the cage door opens this character only will be teleported to the surface. The character who kills the five hundredth rat will leave the room, ignoring the fact that the five hundredth rat has been] killed.[ The count will begin again, and the next person to enter the room will find the woman again.]"
},
{ // 115/26B
"There was something there - your imagination was not playing tricks on you. It really was an Assassin's Night, which neatly accounts for why a slim piece of steel has been inserted into your spinal column. This tends to terminally disrupt proper functioning of your nervous system. You are dead - close the book."
},
{ // 116/26C
"Behind the bushes you find a young man clad in a fighting costume of green and black silk. It has a spider insignia on the breast. The youth is facing you, gladius in one hand, sax in the other. He has no armour, a CON of 18 and 70 combat adds. You may use magic to kill him if you so desire[, but if you don't kill him instantly he still does his damage on you]. Fight - if he is the one to die, you will go to {46}."
},
{ // 117/26D
"The dragon, Marsimbar, launches himself into the air and swoops towards your small craft. His wings stir up quite a mist as he hovers there snapping at you and your boat. This mist renders his flame breath useless - consequently he only gets 10 dice and 371 adds. His CON is 500.\n" \
"  [As with all dragons in myth and legend, Marsimbar also has a chink in his armour. As he hovers, you get one chance at throwing a dagger or other missile weapon at his soft spot. The soft spot is a coin-sized target at near range; the throw requires a 10th level saving roll on Dexterity (65 - DEX) to hit it. (You must make this saving roll on DEX to hit, no matter what edition of the rules you are using.) ]If you [hit him in his vulnerable soft spot, or ]defeat him in a straight fight, go to {163}.[ (Simply hitting Marsimbar in the soft spot will bring him down, no matter how much damage you do. He has a glass jaw, so to speak.)]"
},
{ // 118/26E
"You weren't strong enough to get the sword from its scabbard or you weren't lucky enough to have any time to grab the shield. No matter what the reason, the result is the same. One of the warriors slaps your hands from the sword pommel and another kicks you into the rail of the ship. The force of the blow propels you overboard.\n" \
"  The force of the collision with the rail also caused your nose to start bleeding, something that attracts a Wandering Monster. Roll to see which one you face and deal with it. If you survive, Ignxx pulls you aboard and you head to {5}."
},
{ // 119/27A
"You wipe the blood from your blade and move towards the cage. As you draw nearer, you see a large padlock on the cage. You raise your weapon to strike the lock off with the pommel of your sword when she says, \"Don't.\"\n" \
"  If you ignore her warning and hit the lock, go to {90}. If you don't want to free her, go to {210}."
},
{ // 120/27B
"If you have the solitaire adventure City of Terrors, you find that the left fork goes to paragraph {59} in that dungeon. If you do not have City of Terrors, you are beset by a leopard-like creature which springs down upon you as you pass under its tree. Take 2 dice in hits (armour counts[, but not doubled]) as the animal mauls you. Turn and fight; its MR is 180. If you survive, go to {1}."
},
{ // 121/27C
"\"Thanks, I hadn't seen him in an age,\" Ignxx says as he reenters the boat. \"Where to now, sahib?\" From here, you may go north to {65} or west to {21}."
},
{ // 122/27D
"Ignxx poles your boat along to an intersection. In the west wall there is a dark hallway that ends in a door. If you would like to investigate the room beyond the door, go to {23}. From this point you may also go south to {142}, north to {39}, or southeast to {74}."
},
{ // 123/27E
"If you have a Strength of 60 or greater, go to {34}. If you do not, you cannot pull the sword from its scabbard. Your hands slip free of the pommel of the sword and you fly off the ship. As you swim towards Ignxx, you attract the attention of a Wandering Monster. Deal with it, then get into your own boat and go to {5}."
},
{ // 124/27F
"As you gather various stuff (total value 1,000 gp) into a pillow case, there is a knocking at the door. If you want to reenter the sewers with your booty, do so and go either north to {178} or east to {136}. If you want to leap out the window, go to {49}. If you want to open the door, weapon in hand, go to {14}."
},
{ // 125/27G
"She bids you farewell. She gives you 500 gold pieces from her husband's pouch and 500 more from her own stores. Killing her ex-husband was worth 115 experience points.\n" \
"  On your way out of the building, you bump into a very large man. \"Out of Morgo's way, little man,\" he grumbles. He is armed to the teeth, so you don't argue with him as you go to {1}."
},
{ // 126/28A
"You pass through the shimmering and find your ship in a bleak and forbidding land. Your ship grounds itself and you disembark. When your feet touch land you hear a shout and apparently from nowhere, a humanoid figure appears.\n" \
"  The figure is of a giant. He has a massive great sword that gets 20 dice and he himself gets 245 combat adds. He has a CON of 100 and is wearing mail. \"I am the guardian of the Tomb of Kings. I cannot let anyone pass with plunder from their tombs.\"\n" \
"  If you wish to surrender the loot from your ship to him, pass freely to {1}. If you wish to fight him, do so. If you win, go to {24}."
},
{ // 127/28B
"\"The game is simple. We will roll the dice three times. You choose (write down) whether you think the number rolled will be 8 and above, or 7 and below. For each time you are correct, you win one of these 1,000 gold piece gems. If you win two of the three times we play, you go free. If I win because you guessed incorrectly two out of three times, I get your soul. One caution: if I roll death's heads (ie. snake eyes, double ones), I get your soul immediately.\"\n" \
"  If you win the first two rolls, you may roll for the third gem, keeping in mind the fate of your soul if you roll death's heads. If you win your freedom, go to {1}. If you lose your soul, go to {172}. If you played, and lost, yet had no soul to lose, go to {150}."
},
{ // 128/28C
"You execute a beautiful swan dive into the pool beneath the waterfall. Make a third level saving roll on Luck (30 - LK). If you miss it, you are splattered on a rock hidden beneath the surface. If you make the roll, you must deal with one Wandering Monster before you can swim to the boat and have Ignxx take you to {58}."
},
{ // 129/28D
"You reach the doorway and look into the room. It is a large room, 20' wide by 40' deep, filled with a fog-like mist. 30' from where you stand is a cage which contains a woman. She is blonde and attractive and the source of the screams you have heard. She is screaming because the largest rats you have ever seen are trying to get inside the cage.\n" \
"  Make two fifth level saving rolls, one on IQ and one on DEX (40 - IQ/DEX). If you make both of them, go to {153}. If you miss one or both, go to {35}."
},
{ // 130/28E
"You make the climb safely, but your sword scrapes stone as you go over the top of the wall. As you curse your luck and exhale some air, the guard who is stationed there sees you. He has 130 combat adds and fights with a scimitar. He is uniformed in mail (ring) and uses a knight's shield. He has a CON of 22. If you kill him, go to {166}."
},
{ // 131/29A
"The room beyond the doorway has nothing in it except a chest that sits in the middle of the wooden floor. If you would like to open it, go to {144}. If you wish to leave, you may rejoin Ignxx and go south to {105} or west to {33}."
},
{ // 132/29B
"In the tomb, which has a low ceiling and is decorated in a vaguely familiar but ancient style, you see many valuables at the far end of the room. The ceiling is upheld by six pillars that look to be sarcophagi and amid the treasure there is a throne that has a well-preserved mummy seated upon it.\n" \
"  If you have a means for making fire and wish to burn the mummy on the throne, go to {147}. If you wish to grab some treasure, go to {80}. You can open the sarcophagi-pillars and burn the contents - go to {176}. If you wish to leave, get back to Ignxx and go east to {33} or south to {122}."
},
{ // 133/29C
"Ignxx conjures up a little red bag for you to put your treasure in. \"Good luck in the outside world,\" he says. \"I'll wait here for a moment in case you decide to come back down.\" You hand him his ring and climb. You note that you appear to be climbing up a direct access route into the privy of some rich person's house. If you don't look vaguely human (ie. you're some monster type), go to {140}. If you are male, go to {56}. If you are female, go to {77}."
},
{ // 134/29D
"He fights with his bony bare hands (two dice) and has 221 combat adds. His CON is 30. If you kill him, go to {187}."
},
{ // 135/29E
"After three years alone he might well be mad, but three years is a long time to train with only one weapon. Briah gets 154 combat adds and the dice for his pilum. He has a CON of 50. If you kill him, go to {160}."
},
{ // 136/29F
"\"North, south, east or west; which way, ace?\" Ignxx inquires as you enter a four-way intersection. Check for a Wandering Monster; then, from here you can go north to {105}, south to {65}, east to {31} or west to {74}."
},
{ // 137/29G
"Just before you grab him you hear a bowstring twang. A barbed black shaft appears in his back. He half rises, then pitches backwards into the water beside you. You look up for the unseen archer and soon he comes paddling a canoe towards you.\n" \
"  \"Peace, brother, I mean you no harm. I am here with many men, to put an end to the threat of the Spider Cult. \"Will you join us?\"\n" \
"  If you are too tired, go to {1}. If you want some real excitement, go to {19}."
},
{ // 138/30A
"From your shoulder you pluck a silver dagger with a flame-shaped blade. This magical dagger will [punch through any armour, ]do[ing] three dice worth of damage[ regardless of who won the round. If you and your foe both die in the same round, you will survive with a CON of one (the dagger will funnel enough of your foe's life-force into you to keep you alive)].\n" \
"  You now leave the room and hop back into the boat with Ignxx. You have a choice of wandering south to {122} or east to {33}."
},
{ // 139/30B
"Since you are out of the sewers you won't get turned into a fish for using magic. The men you face each have a Monster Rating of 80. You can cast two spells before they reach you. If you kill them with magic, go to {203}. If you find that you do not have enough in the way of killing power in your spells you may teleport away or run away by using a Swiftfoot spell on yourself. If you cannot escape or kill them, you die. (If you get away, go to {1}.)"
},
{ // 140/30C
"She triggers the crossbow and the bolt strikes you. You take the damage allowed for the toughest crossbow in your edition of the rules. If you live through that you fall down the ladder to Ignxx. From there you can go north to {178} or east to {21}. If you die, she calls a member of the City Guard and gets a bounty for killing a Ranger attempting to enter the city. You are dead, close the book."
},
{ // 141/30D
"You were not quick enough in focusing your mind. The energy channeling through your body opened a doorway into the Deathtrap Equalizer dungeon. If you have a copy of Deathtrap Equalizer, take a frog trip.\n" \
"  If you don't have a copy of Deathtrap Equalizer, you failed to focus the power at all and it burns your brain out. You die as a result, your IQ at zero. Close the book."
},
{ // 142/30E
"\"Pick a direction, any direction,\" Ignxx quips as you arrive at a four-way intersection. You may go north to {122}, south to {178}, east to {74} or west to {174}. Check for a Wandering Monster before you proceed."
},
{ // 143/30F
"In the course of designing adventures for solo play it has become apparent that some players do very foolish things. In the introduction to this adventure it was suggested that no daggers are lost during the fall into the sewer. Therefore, it was assumed that everyone *had* a dagger. No one should have to read this paragraph unless they had not done the obvious thing - bring a dagger. Needless to say, the Spider Cult guard waiting by this snare kills you. If only you had a dagger..."
},
{ // 144/31A
"The wooden floor creaks as you walk to the chest. You reach it and flip the lid open. Inside you see several jewelled items and a great deal of coinage. Unfortunately the wooden floor chooses this moment to give way and you and the chest are plunged into the murky water beneath the floor.\n" \
"  You suspect the collapse of the floor was no coincidence, as the pool below has placed you in a situation in which you must deal with a Wandering Monster. Roll to see which one appears.\n" \
"  If you successfully cope with the Wandering Monster, you may repeatedly dive into the water and search for treasure by going to {13}. If you would like to leave, go to {219}."
},
{ // 145/31B
"\"Gather up the pieces and put them in a pile,\" Ignxx directs. He mumbles a spell and the wooden warrior reassembles itself. \"Since you broke it, you should clean up this mess. I'll be waiting at the boat for you.\"\n" \
"  Straightening up the room, you find (three dice × 10) gold pieces that were blown about the area. From here Ignxx can take you north to {142}, south to {205} or northeast to {33}."
},
{ // 146/31C
"\"I am Briah. Biorom, who designed this monster of a dungeon, happened to be listening when I shot my mouth off about warriors and their cranial capacity,\" he confesses to you. \"Biorom drugged me and trapped me here. I cannot use magic to fight the dragon unless I want to escape as a fish, so I live here and practice fighting. I have little but I am willing to share. You see, I need a sparring partner.\"\n" \
"  You tell him that the dragon is no longer a problem. \"Great!\" he cries, capering about the room. \"Biorom put a doorway out beneath the sand twenty-five meters from the cave entrance. When I stepped on the beach to run to it, the alarm would go off and Marsimbar would be on me before I got it half uncovered. Come on, I'll get us out of here.\"\n" \
"  If you don't trust him, or don't want to leave, go to {41} and head back the way you came. If you want to go with him, go to {76}."
},
{ // 147/31D
"The mummy explodes into flame. It rises and screams with vocal chords long dead. Smoke issues from its mouth and assumes a human form. With words barely discernable over the snapping of the fire, the mummy's spirit form speaks to you.\n" \
"  \"You have ruined my chances for the afterlife, desecrator of my tomb. You are the vilest creature ever to walk this world.\"\n" \
"  Summoning up your courage you talk back, maintaining that you are a fine person, brave and honest (even if you're lying through your teeth). \"If this is true,\" says the spirit, \"I shall not torment you. To prove to me your bravery I bind you to find and defeat the Wraith. He is the embodiment of evil, and should be opposed by all like you.\n" \
"  \"If you manage to defeat the Wraith, I shall leave you alone. If you do not defeat him, you will suffer my curse. You will travel with me forever, denied any afterlife or immortality you already own. You will be my servant in my quest for eternal peace.\n" \
"  \"Now go and do what I have charged you with.\"\n" \
"  You are turned from the treasure and forced back to the boat. Go east to {33} or south to {122}."
},
{ // 148/32A
"The skin of this crocodile is worth 25 gp and weighs 50. When you open it up you find that the crocodile's reputation for eating anything is well deserved. In its stomach you find a sack with 100 gold pieces and two gems (roll for them on the Jewel Generator in the rulebook).\n" \
"  As you swim from the small islet you used as a slaughterhouse, you see a man hiding beside the pathway. He is dressed in a green and black silk fighting suit. His shirt is tied about his waist and he has a scimitar in his hand. He appears to be waiting in ambush for someone.\n" \
"  If you wish to ignore him and swim on, watchful for more crocodiles, go to {1}. If you want to attack the man waiting there, go to {137}."
},
{ // 149/32B
"To successfully dive through the net you must make both a 6th level Dexterity (45 - DEX) and a 7th level Luck (50 - LK) saving roll. If you miss *both rolls* you get fried. If you miss one roll, take the number you missed by and roll that many dice. Take that damage off your CON. This represents your grazing two wires and catching some juice. If you make both rolls, you miss both of the wires as you dive through. If you survive, go to {214}."
},
{ // 150/32C
"You feel powerful, evil magic work upon you. You feel the flesh on your body peel back and expose your bones to the air. You feel yourself shrinking and getting smaller, denser. As your eyes finally begin to die, you look up to see the Wraith standing over you. He grasps you firmly with forefinger and thumb, and lifts you up to place you in the sack with the other death's head dice...\n" \
"  (In case it had not occurred to you, this adventure is over and this character is dead.)"
},
{ // 151/32D
"For each zombie in the room make a 4th level saving roll on DEX (35 - DEX). You are attempting to dodge the swords they throw in your direction. If you make all of the saving rolls you may leave and rejoin Ignxx. From there you may go north to {39}, south to {107} or southeast to {74}.\n" \
"  If you miss one or more of the saving rolls, go to {59}. If you missed all of them the swords trip you up long enough for the zombies to catch you and pull your arms and legs off. (This character is dead.)"
},
{ // 152/32E
"\"So he thought you were a rodent, eh?\" Biorom laughs. \"I think I can handle that.\" He bestows upon you the ability to shift your shape into that of four different families of rodent: Shrew (2 CON, 1 die + 1 in combat), Mouse (4 CON, 1 die + 2 in combat), Squirrel (6 CON, 1 die + 3 in combat) and Rat (8 CON, 1 die + 4 in combat). When you shift shape you leave all armour and weapons behind - nothing goes with you.\n" \
"  Biorom, seeing that you are not a Ranger, releases you from the sewers and cures any illness you might have. Go to {1}."
},
{ // 153/33A
"Your mind flashed the message \"TRAP\" to your feet and you dove into the room as the iron portcullis over the doorway slammed down into place. Your dive carries you into the room, about 10' from the cage. Roll three dice to see how many rats you have to fight. Each rat has a MR of 20. If you kill all of the rats, go to {119}."
},
{ // 154/33B
"You break from cover and sprint for the sea gate. One of the Rangers spots you. He moves in your direction, digging his hand into a pouch at his belt, and tosses a handful of small round objects directly in your path. You attempt to dodge them, but they get beneath your feet and cause you to fall. You land on your head and are knocked unconscious.\n" \
"  You awaken with a crowd of city guards around you. The concussion you received when you fell blanks your most recent memory of what you have seen. Subtract the roll of 1 die from your IQ. Puzzled, you rise and go to {1}."
},
{ // 155/33C
"Killing Leo is worth 350 experience points. You may loot the room if you wish, by going to {54}. If you decide not to loot the room, you may return to Ignxx and go either east to {101} or west to {136}."
},
{ // 156/33D
"You pulled very hard at the sword and had the unlucky misfortune to sprain your back. It only hurts for a moment, though, as the wooden warriors rip you limb from limb. This is a rather drastic way to get rid of back pain, but it is crudely effective. You are dead, close the book."
},
{ // 157/33E
"Morgo has 151 combat adds. He is armed with a great sword and wears leather armour. He is a rogue, so the armour is not doubled. His CON is 20.\n" \
"  If your Strength is greater than 140, go to {213}. If your Strength is 140 or less, go to {185}."
},
{ // 158/33F
"Your rebel friends are overjoyed with the results of your mission. To show you how much they appreciate what you have done, they allow you to keep the amulet[ that can make you invisible when you hold your breath. The same restrictions on it that were found in here will apply in all other dungeons and adventures you may use it in]. Your friends also give you five gems, each worth 1,000 gold pieces. You may now go to {1}."
},
{ // 159/33G
"You hear a warcry and see a volley of black shafted arrows pepper the giant spider. You soon discover that the arrows have a nasty barb on them, as one of those arrows buries itself in your back and you see the barb protruding from your heart. You really cannot blame the attackers for mistaking you for a worshipper, since you wear the uniform. (Take heart, the worshippers of the Spider God believe in life after death. You are reincarnated as a spider, but that's life.)"
},
{ // 160/33H
"\"Bastard!\" he groans from where he lies. No longer worried about becoming a fish, he casts a powerful curse on you, and you suddenly feel yourself growing smaller. Halve all your prime attributes, as well as your height and weight.\n" \
"  You peer out of the cave mouth and see Marsimbar has landed on the beach, and awaits you hungrily. If you are prepared to fight the great saurian, go to {181}.[ If, in addition to being smaller, you're a little smarter, you can wait in this cave and hope someone else will help you escape. In this case, put this character's card at {30} and carry it through the adventure in Briah's position. However, if you're diseased with dysentery, cholera, hepatitis, plague, malaria, yellow fever or rabies - you may as well go fight the dragon because you'll die of the disease before you can be rescued.]"
},
{ // 161/34A
"\"Biorom would speak with you!\" she says, pointing to his image in the mirror. Make a fifth level saving roll on IQ (40 - IQ). If you make it, go to {64}. If you miss it, go to {114}."
},
{ // 162/34B
"On these levels the wooden warrior gets 5 times the level number (11-15) in CON points. His sword is now worth 5 dice and he gets 15 times the level number in combat adds. (On level 15 he would get 5 dice and 225 combat adds, and it will take 75 hits to shut him off.)\n" \
"  If you win, you get 10 times the level number in experience points. You may continue to play but only at a higher level than before. If you would like to try a higher level bracket or leave this situation, go to {12} for your options. Remember to deduct one gold for each of your fights."
},
{ // 163/34C
"You stride across the island's beach towards the cave in the cliff. The alarm that was triggered when you stepped on the island still rings, but it will never again warn Marsimbar that there is a person on the beach. You enter the cave.\n" \
"  This cave was formed by volcanic activity; the lava channels and broken pieces of the earth's crust make for tricky walking. You follow the winding path through the cave and deep into the interior of the mountain. Soon, where there should be none, there is light and the sound of a living person.\n" \
"  Cautiously you take the last turn and come upon a large cavern. It has been crudely decorated with bookshelves and books, chairs, tables, and some moth-eaten tapestries. In the middle of the room is a man in the robes of a wizard; oddly enough, he is practicing with a pilum and tower shield.\n" \
"  If you wish to speak with the man, go to {146}. If you wish to attack him, go to {50}."
},
{ // 164/34D
"You can make out the first part of the message. It reads: \"This is the tomb of the richest Prince of Gull...\" The rest of the message is too worn for you to make out. If you would like to enter through the door into the tomb, go to {132}. If you wish to leave go east to {33}, or south to {122}."
},
{ // 165/34E
"\"You have eaten the meat of the rat. You, then, are one of us!\" he cries with joy. Before you can ask what he means by that, he raises his head and lets loose a roar that would do credit to a lion. From the passage where you were come countless cats. \"We are all here to kill rats. You are one of us - if not in form, then in spirit.\" The cats all change form into human beings.\n" \
"  \"We don't know any way out of here, but we can give you something that might aid you in your adventures if you escape,\" Leo says. The assembly nods silent assent. He hands you a ring of a cat biting its own tail. \"This ring will allow you to jump five times your height in a line up or out. You will also always land on your feet, sustaining no damage for a fall of up to 20', provided there are no spikes (or any equivalent danger) beneath you.\"\n" \
"  You thank them and return to Ignxx. You may go east, toward the Wraith, by going to {101}. You may also return to the west by going to {136}."
},
{ // 166/35A
"Your last blow knocks the guard from the top of the wall, and he falls into the courtyard below. His body lands with a thud and immediately the castle is alerted to the presence of an intruder. You realize that you must make haste, and run through the hallways of the castle towards the Count's room. You round the corner of the last hallway - and find three guards (80 MR each) blocking your path. They move to cut you off and you must fight them. If you win, go to {18}."
},
{ // 167/35B
"Ignxx reappears with a poof, looking sheepish. \"Sorry about leaving you there, ah...but I had to go get this diamond I saw you drop over there.\" Ignxx jerks his head back towards the darkness and with a wave of his hand he hands the gem over. It appears to be worth 1000 gp. From here you can go north to {33}, south to {21}, east to {136}, west to {142}, northeast to {105}, northwest to {122}, southwest to {178} or southeast to {65}."
},
{ // 168/35C
"As you emerge from behind the curtain the male voice reaches its highest pitch as he cries \"Adulteress!\" She screams and reels from the door, a dirk firmly planted in her breast. You catch her falling body and pull the dirk out.\n" \
"  At the door is a small, greasy man dressed in pink and black. In your anger you throw the dirk back at him. He is at pointblank range and is wearing no armour. If you do 25 or more points of damage to him (provided you hit him), he dies. If you don't kill him with the thrown dirk you step back, pick up your sword from where it had fallen when you caught her, and prepare to fight him. His CON is 25; he has 115 combat adds and fights with a rapier.\n" \
"  If you kill him you get 115 experience points for the fight. You find 500 gold pieces in his purse, and you can take his weapons if you want them. Go to {1}."
},
{ // 169/35D
"Ignxx has brought you to a right-angle intersection. In the east wall there is a door. To investigate it, go to {131}. You may also go south to {105} or west to {33}."
},
{ // 170/36A
"As Ignxx moves your boat along you come to two strange outcroppings of rock on each side of the sewer canal. A bat flits along the surface of the water in search of insects. He flies between the rocks and they crash together, reducing the bat to a bloody pulp.\n" \
"  Ignxx says he can teleport himself and all of the inanimate objects in the boat to the other side of the rocks, but you are on your own. He does note, however, that you could take a running start on the canal ledge and might jump through. If you would like to try Ignxx's plan go to {99}. If you decide not to, Ignxx will turn the boat around and go to {33}."
},
{ // 171/36B
"Your sword springs forth with a brilliant flash. You attack the man who spoke to you, splitting him in two with your first blow. As he falls you yell, \"Ambush!\" and end the lives of two men who have not even drawn their weapons yet.\n" \
"  The whole ship works seems alive with mercenaries who wear Al-Dajjal's house crest. The Rangers fight like demons, each visiting havoc upon their foemen. You find yourself beset by three more men, each with a MR of 75. If you survive the combat with your foes and had previously fought with Kavar, go to {69}. If you survive and never fought with the Ranger leader, go to {113}.\n" \
"  If you don't survive your personal battle please do know that your warning saved the Rangers and they managed to disable the ship they sought. Small consolation, but that's life."
},
{ // 172/36C
"You stare at the Wraith as he wraps one hand over your face. You feel no pain, just an emptiness as he drains your soul from your body. Your earthly form crumples and slides into the canal to feed the creatures there. You are done, close the book."
},
{ // 173/36D
"[\"Well, someone has to replace Leo,\" Biorom says. ]He waves his hand and you [find yourself b]a[ck in the ]r[oom wh]e[re you slew Leo. This character will take his place until he has slain ten characters. At that time he may continue on his way. Any disease this character might have will undergo a temporary remission (it won't bother him) while he or she is in the service of Biorom. Keep this person at {194} and use his or her attributes in the place of Leo's. If the character is attacked and slain, he or she is] dead."
},
{ // 174/36E
"As Ignxx poles your boat along you begin to hear a dull roar. The current becomes faster and Ignxx stops the boat above a waterfall. You get out and walk 50' down the canal ledge to scout the situation out.\n" \
"  The falls are 30' high. The rocks along the edge are sharp and slick with mist. The pool at the bottom of the falls is dark, but you can see some indication of life below. Ignxx tells you that he can teleport the boat and all of your treasure down below the falls but you will be on your own.\n" \
"  If you want Ignxx to turn the boat around and head back east to {142}, he will. If you want to dive down, go to {128}. If you want to climb down, go to {92}."
},
{ // 175/37A
"You were deceived by the pillows-under-the-covers trick...While you stab at pillows, the Count comes from the corner and strikes with his sabre. [Because you are invisible, he only gets 40 combat adds plus the dice for his weapon (this combat only). ]Your armour will take hits. [(If you are a warrior, you cannot double your armour, because you were not expecting the attack.) ]Take the damage off your CON. If you die, close the book. If you survive, continue reading.\n" \
"  [During this second combat round (not odd numbered), the Count can see you. ]He is wearing leather armour and uses a buckler. He fights with a sabre and gets 240 combat adds. His CON is 45. If you kill him, go to {22}."
},
{ // 176/37B
"All six mummies burst into flames the instant the fire is touched to them. Suddenly the whole room is blazing. From each sarcophagus pours a thick yellow gas that chokes you. You fall to the ground, facing the throne. As you die you almost suppose that the mummy is smiling at you. Your last thought is that his smile is truly a death's head grin. He *had* guarded his tomb well."
},
{ // 177/37C
"She triggers the crossbow but her aim is thrown off by your attack. You pop out of the hole and bat the crossbow from her hands. Just as you rest the point of your sword against her throat you hear a knocking at the door.\n" \
"  If you would like to kill her instantly and then answer the door go to {112}. If you want to toss her onto the bed in the outer chamber and then open the door, go to {201}."
},
{ // 178/37D
"\"'Try Your Luck On The Wooden Warrior',\" Ignxx says, reading a sign painted on the sewer wall. You ask what the wooden warrior is and Ignxx explains it is a swordsman's practice device. It costs a gold piece a round and is good exercise.\n" \
"  If you would like to try the wooden warrior, go to {12}. If you wish to leave this place you may go south to {205}, north to {142}, or northeast to {74}."
},
{ // 179/37E
"Make sixth level saving rolls on your ST (45 - ST) and LK (45 - LK). If you make both of them, go to {72}. If you miss one of them, go to {118}. If you miss both, go to {156}."
},
{ // 180/37F
"Across the sewer canal there are seven copper cables. You don't know why they are there and if Ignxx knows, he's not saying. As you try to puzzle them out you see two dolphins playfully swim past your position. One neatly dives between two cables. The other is more clumsy and hits two of the wires. There is a bright flash of light, not unlike lightning, and the dolphin is fried.\n" \
"  Ignxx tells you that he can teleport the boat and your treasure to the other side of the cables, but you're on your own. He does note that you could swim under or dive through the cables.\n" \
"  If you wish, Ignxx will turn the boat around and take you to {21} to the north. If you dive through the wires, go to {149}. If you swim beneath them, go to {93}."
},
{ // 181/37G
"Marsimbar has a CON of 500, and 371 combat adds. He gets 10 dice for his basic attack, plus another 15 for his flame breath. Once in each combat turn, he rears up, exposing his soft spot. If you're fighting with a weapon which can also be a missile (dagger or spear, only), you may try to make a 10th level saving roll on your DEX (65 - DEX), to try to bring the dragon down. If you strike the soft spot, he's down for good, and topples back into the lake. If you tried to hit, and missed, you've lost the weapon.\n" \
"  If you miraculously survive, you can return the way you came by going to {41}."
},
{ // 182/38A
"Each of these zombies suffers from a problem hinted at before - their eyes are useless. They can only locate you by sound. [Make a saving roll on your Dexterity on the level equal to the number of hits your armour is rated to take (at face value only). A suit of leather armour (5th edition rules) would require a 6th level DEX saving roll (45 - DEX) for you to fight in it silently.\n" \
"  If you make the saving roll you are effectively fighting while invisible. Halve the attack of the zombies. ]Each zombie has a MR of 80.\n" \
"  [If the zombies get any hits on you, it means they have located you. In order to fight silently again, and avoid their notice, you must make the saving roll one level higher than the previous time. If you fail they do not have their attack halved.\n" \
"  ]If you kill them all, go to {3}. If you die in your attempt to slay them, Biorom will either dress you up in a Ranger uniform or sell you to Marionarsis the Necromancer so that you may continue to be useful even after you die."
},
{ // 183/38B
"Forget this character. Using magic in the sewers results in getting turned into a fish. This character is now a fish. You are done, close the book."
},
{ // 184/38C
"From the body, you take a magic amulet[ that will make you invisible while you hold your breath]. [On odd-numbered combat turns you will be invisible; your foes must divide their combat rolls by 2 during those rounds. ]The fight was worth 100 experience points.\n" \
"  The Count himself rewards you. He presents you with a 2,000 gp bonus and promotes you to captain of his household guard. This is a mostly honourary position that allows you complete freedom to travel as you wish. (He will not pay you for the duration of any adventures you go on.) [Whenever you are working you get room, board and 15 gold pieces a week. ]Go to {1}."
},
{ // 185/38D
"Morgo was hired to kill her; he wants no quarrel with you. As you advance he grabs your arm and flings you through the window into the street. You land with a thump and take one hit. You are outside and stark naked.\n" \
"  You manage to find a discarded towel and you go to {1} on your way to the City Guard barracks near the Red Guardian to recover your lost goods."
},
{ // 186/38E
"He takes his clothing off and joins you. Do your damage[ with the dirk]. [Morgo cannot be killed by the hand of a female (due to an old enchantment) but] if you reduce his CON of 20 to 1 he will be unconscious. ]If you best him, go to {94}. If you cannot do it, go to {204}."
},
{ // 187/39A
"As he falls into dust so does his tomb. You make a grab for the tiara you wanted and manage to escape the tomb's destruction. You seat yourself in the boat, order Ignxx east towards {33}, or south to {122}. Then, look over the tiara. It is made of silver and is set with three jewels (roll for them on the Jewel Generation chart in the rules)."
},
{ // 188/39B
"\"Do you mind if I visit a buddy of mine here?\" Ignxx asks, pointing to a door in the  southern wall. You know that even if you mind, he'll ignore you - so you agree. If you would like to join Ignxx go to {86}. If you would rather sit in the boat and wait, go to {121}."
},
{ // 189/39C
"\"So you are one of those that must defeat me, eh?\" he comments in a matter-of-fact tone. \"They have come before. They have died before. To arms then.\"\n" \
"  If you would like to fight him, go to {111}. If you wish to run for the exit, regardless of curses, etc. go to {215}."
},
{ // 190/39D
"Halfway out to the island, you note that on the top of the cliff facing you there is a dragon who appears to be asleep. As you pause to ponder what you are doing swimming towards an island that is being guarded by a dragon, a Wandering Monster strikes. (If the Wandering Monster you roll up does not live in the water, ignore the attack...you lucked out.)\n" \
"  If you survive the fight, you can either make for the island and the cave in the base of the cliff (go to {209}), or swim back to {65} and move on."
},
{ // 191/39E
"Ignxx poles the boat along until it scrapes its hull on the bottom of the canal. \"This is the end of the line for me, boss,\" he says. \"You've gotten out of the sewers. Now all you have to do is head north and back to town.\" He conjures up a small red bag for you to place your belongings into. He waves goodbye and vanishes; the red ring vanishes with him.\n" \
"  You set your feet on the path north and soon come to a fork in the road. The left fork will lead through the forested area to the south of the city. The right fork will follow the shore of the Range Sea and deliver you near the new shipworks in the city. If you wish to go to the left, go to {120}. If you want to take the right fork, go to {55}."
},
{ // 192/39F
"On his person you find a purse with 500 gp worth of gems. You reenter the room and gather up your treasure. The bath still looks inviting. If you want to use it go to {29}. If you would rather leave, go to {195}."
},
{ // 193/40A
"On these levels, the wooden warrior has a CON equal to 10 times the level number (16-25). His sword is worth 6 dice plus 3 and he gets 15 times the level number in combat adds. (On level 25 he would have 375 combat adds, 6 dice plus 3 for his sword and it would take 250 hits to shut him off.)\n" \
"  If you defeat him, you get 20 times the level number in experience points. You may continue to fight, but only at a higher level than before. If you would like to change to a higher level bracket or leave this situation, go to {12} for your options. Remember to deduct one gold for each fight."
},
{ // 194/40B
"Your attack comes as a complete surprise. Take all damage off his CON of 40. If you fail to kill him he fights with a sax and a plate that he uses as a crude buckler. He has 225 combat adds and no armour. If you kill him go to {155}."
},
{ // 195/40C
"As you leave the building you bump into a very large man. \"You smell like a sewer rat,\" he sneers at you. You recognize him as Morgo, small-time thief and part-time assassin. You file his name for future reference and go to {1}."
},
{ // 196/40D
"As you attempt to make your way back into the sewers you can find no shimmering to suggest a course to take. You turn to watch Ignxx as he begins to glow and it seems like he has entered a trance. Your boat moves forward and runs into incredible turbulence.\n" \
"  Make a fifth level saving roll on DEX (40 - DEX). If you make it, you and your treasure survived the trip back to the sewers.\n" \
"  If you missed, multiply how much you missed the roll by 100 and subtract that from the number of gold pieces you had in the boat. This indicates how much gold you lost overboard as you sought to keep the boat balanced, and did a poor job of it. Go to {5}."
},
{ // 197/40E
"He fails to throw you from the saddle. Now you are both locked in a bizarre struggle. With a sax obtained from a saddle sheath, you attempt to stab the man who has swung into the saddle behind you.[ This is so difficult that you get only ½ your combats adds that come from DEX and LK, and none of the combat adds that come from Strength.]\n" \
"  Your foe, on the other hand, is not quite in the same situation. He gets all of his 19 combat adds, in addition to the dice and adds for the sax he is stabbing you with. [Your armour will make no difference: at this range, joints are very easy to hit. ]He has a CON of 40.\n" \
"  [*Both of you will take all of the hits generated by the other fighter directly off your CON*. There is no fancy blocking in this fight - both of you are attacking a target that is incapable of defending itself. Combat will continue until one of you has carved the other into nonexistence.\n" \
"  (If any of this seems overly harsh, have someone sit behind you on a horse or bicycle or bench and try this situation - *without* real knives, of course.)\n" \
"  ]If you survive, you have won free of the adventure. Go to {1}. (The horse is worth 200 gold pieces, and the fight was worth 150 experience points.)"
},
{ // 198/41A
"You clear away chunks of moss and fully disclose the outline of the door. The message is fairly short. Make a 6th level saving roll on IQ (45 - IQ) to see how well you can read it. If you make it by a margin of 10 or higher, go to {217}. If you make it by 9 or less, go to {164}. If you miss it altogether, go to {89}."
},
{ // 199/41B
"Without going into gory details, the Count wraps his arms about you and carries you through the window. Like a falling star you plummet from the balcony into the shallow moat. The 6\" of water does little to break your fall or quench the Count. (You may decide whether you died from immolation, drowning or terminal damage incurred while stopping after a long fall.)\n" \
"  Do rejoice in the fact that everyone is happy that the Count is dead. You will be sung of by bards. Your ballad will be known as the Ballad of (your name) the Starcrossed Assassin."
},
{ // 200/41C
"\"Bad move,\" he says as you rush forward. With a gesture of his hand the floor begins to move. From between the marble blocks that make up the floor grow amber crystals. Quickly they form about your legs, stopping your forward progress. As you struggle against them they cover you to your waist, then your neck. At last they close about your head.\n" \
"  You are not dead, you are a prisoner of Biorom. If your character is immortal he or she is trapped forever. If the character is not immortal it too is trapped forever, though it will die from suffocation very soon. You are done, close the book."
},
{ // 201/41D
"At the door is a grimy little man in pink and black. He has a dirk raised in striking position and he catches you off guard. (You surprised him also so he only managed the dice and adds for the weapon this round - no personal adds.)\n" \
"  If his treacherous blow did not kill you, feel free to visit on him any retribution you feel he deserves. He also has a rapier, 115 combat adds and a CON of 25. If you kill him, go to {16}."
},
{ // 202/41E
"You made it to the cave. However the cave was very small and while the dragon could not get into the cave, a blast of his flame breath could. Surprisingly enough it was not the flame that killed you, but the wind itself was so strong that it blew you into the rock wall of the cave and shattered every bone in your body."
},
{ // 203/41F
"\"A magic user!\" cries the leader. \"You are just what we wanted to see. Our sorcerer was killed during the journey here. Our mission is very important and we need your aid.\"\n" \
"  He takes a pendant from around his neck. It looks like a flame carved from a piece of quartz, and oozes magical vibrations. \"Take this. It will allow you to cast a modified Blasting Power spell. With it, you can shape the fire, limit its spread and cast it at a distance of 50'.\"\n" \
"  You take the pendant and creep close to the ship they want destroyed. You use the amulet (ST cost is the same as if you were casting the spell) and the ship bursts into flame. The Rangers thank you and allow you to keep the magical trinket as your reward for helping them. Go to {1}."
},
{ // 204/42A
"Enraged, Morgo twists the dirk from your hand. He locks his hands about your throat and twists until your neck snaps. You are dead, close the book."
},
{ // 205/42B
"As Ignxx propels the boat along, you sit in the bow of the craft. Soon you come to a right-angle intersection. On the west wall is a ladder made of metal rungs sunk into the wall. From here you can climb the ladder (go to {133}) or go north (go to {178}) or east (go to {21})."
},
{ // 206/42C
"You make the climb with no mishaps. You climb over the wall and carefully trace the steps you memorized from the rebels' description. Avoiding all the well-travelled halls, you make your way to the chambers of the Count. You enter his bedchamber, noiselessly and unseen. The Count is in bed, neatly outlined by his sheets.\n" \
"  If you wish to light the lamp by the bed so as to look upon the face of your victim, go to {108}. If you would rather just kill him where lies, go to {175}."
},
{ // 207/42D
"You pass through the honour guard of wooden soldiers, each fully as tall as yourself, and look upon the body they guard. It is old, yet well preserved. The body is surrounded by treasure; gold can be seen glinting in the light from the torches at either end of his resting place.\n" \
"  Suddenly the ship bumps into one of the sewer walls. This was unexpected and you are knocked from your feet, falling across the body of the dead man. The wooden warriors, set to guard their king into the afterlife, move to attack you.\n" \
"  In the fall your sword becomes fouled in your belt. You have no time to draw it, but the boat itself offers many weapons. If you would like to grab one of the torches, go to {47}. If you would like to try for the sword in the scabbard to your left, go to {123}. If you want to try for the curiously-worked shield to your right, go to {83}. If you wish to try for both sword and shield, go to {179}."
},
{ // 208/43A
"\"Take up my sword, take up my heritage,\" you hear the Wraith's voice echo. You see your skin take on a stony texture. It darkens and you grow. This character will take the place of the Wraith, and will never leave this dungeon. There is no way to get this character out - if another character defeats it in battle, this character will not and cannot be reborn. Place this character at {111} and use it whenever combat must be fought. This adventure is over - or perhaps it is just beginning. Close the book."
},
{ // 209/43B
"The moment you set foot on the beach a mystical alarm begins to wail. Marsimbar the dragon takes to the air. With strong, swift strokes of his magnificent wings he gains altitude, coming just short of impaling himself on the stalactites in the cavern roof. Casually he looks in your direction. Then, with a long looping turn, he goes into a dragonish power dive, a thing no man has lived to see completed.\n" \
"  If you want to stand on the beach to fight Marsimbar one-on-one, go to {11}. If you want to run for the cave in the cliff and attempt to escape the dragon, go to {87}."
},
{ // 210/43C
"\"The lock won't open until five hundred rats have been killed,\" she says. \"Biorom put me in here to attract people into the room to kill rats. I'm working off a debt, much like Ignxx. The rats can't get me - the repulsive things are too big to get into the cage.\n" \
"  \"I appreciate your helping me. I have nothing to give you[ other than this vial of magic water that will heal any damage you have taken in this room, from the rats or the portcullis].\n" \
"  [After you drink the water ]she points out the controls to the portcullis. You may leave after you raise it. From here you may go north to {169}, southwest to {74} or south to {136}.[ If the five hundredth rat has been slain in this room since you started playing this solo, or since the last set of five hundred was slain, go to {4}. (In other words, every 500 dead rats go to {4}.)]"
},
{ // 211/43D
"Each one of the Rangers has a MR of 80. If you kill them you find that each had 300 gold pieces on his person. Take 80 experience points for the fight, then turn towards the sea gate and go to {1}."
},
{ // 212/43E
"About you lay the splintered bodies of the warriors. The weapons you did not choose vanished. The ship is heading for another shimmering light, like the one it came from.\n" \
"  \"Hey, I just tied the boat onto this ship,\" Ignxx tells you as he climbs aboard. \"We can leave now or we can ride this ship through to wherever it is going.\"\n" \
"  If you wish to leave on the small boat, go to {5}. If you want to stay with the ship, go to {62}."
},
{ // 213/43F
"Morgo was hired to kill her. \"Leave or die!\" he grunts. You [ball up your fists and ]block his path. To your surprise he drops his weapons and faces you barehanded.\n" \
"  [This is to be a fist fight. Both of you get your adds in addition to the number of dice you get for your bare hands. ]Morgo gets one die for his bare hands and he is wearing leather armour.[ If either your CON or Morgo's drops below 2, leave it at 2 and that person is unconscious.]\n" \
"  If you knock him out, go to {73}. If he knocks you out, roll one die. If you roll a 1-3 it means he tosses you out the window and you may go to {1}. If you roll 4-6 he throws you back down into the sewers; find Ignxx, and head east to {21} or north to {178}. In both cases, you are naked and unarmed."
},
{ // 214/44A
"Ignxx poles the boat along until you come to a large iron gate which blocks the path to the outside. It is worn and a little push forces it open for you.\n" \
"  You hand Ignxx the red ring and he conjures up a bag for your booty. \"Maybe I'll see you again some time, boss!\" he says. \"Good luck on the outside.\"\n" \
"  You bid him farewell and leave the sewers. You find yourself on a road that leads through some woods. You realize that these woods are a little east of Gull and that the road will take you farther east than you have ever been before.\n" \
"  As you near a small clearing you hear the sounds of fighting. You get off the road and peer cautiously through the bushes. You see a small group of men, ragged yet valiant, fighting a slightly more numerous mounted troop of uniformed guards.\n" \
"  If you would like to join the fray on the side of the mounted guards, go to {9}. If you would like to help the underdog infantry, go to {68}."
},
{ // 215/44B
"As you bolt for the exit, you realize only your speed will save you. If you have a Speed attribute, make four first level saving rolls (20 - SPD) on it. If you don't have a Speed attribute use three dice and roll one up right now. Make the four first level saving rolls on it. If you make all four, go to {82}. If you miss any, record how many you miss and go to {40}."
},
{ // 216/44C
"As you walk along on the pathway you begin to get the feeling that you are being watched. To your right, from the middle of the deep dark clump of brush, you hear a sound. Something zips by your ear, and you see a blowgun dart bury itself in the tree by your head.\n" \
"  If you would like to run along the path and attempt to elude your attacker, go to {52}. If you want to draw your weapon and attack the person in the brush, go to {116}."
},
{ // 217/44D
"You manage to read all of the message. It says \"This is the tomb of the richest Prince of Gull. He was wise and his treasures are guarded well.\" If you want to enter the tomb, go to {110}. If you want to leave with Ignxx, get into the boat and go east to {33}, or south to {122}."
},
{ // 218/44E
"On these levels the wooden warrior gets CON points and combat adds equal to 3 times the level you decide to fight at (1-5). His sword is worth 3 dice + 4 adds. (If he is at level 4 he will get 3 dice plus 16 (4 for the sword plus 12 combat adds) and will take 12 hits before he shuts down.)\n" \
"  Defeating him gives you 6 times his level number in experience points. You can continue to play, but only at a higher level. You cannot go down or stay at the same level for another fight. If you wish to change level sets or leave this adventure, return to {12} for your options. Don't forget to deduct gold for your fights."
},
{ // 219/44F
"As you climb back into the boat, Ignxx looks at you strangely. \"What's that thing stuck in your boot top?\" he asks. You look down and find a gem trapped in the top of your boot (roll for it on the Jewel Generator in the rulebook). It must have lodged there as you fell through the floor.\n" \
"  From here, Ignxx can take you south to {105} or east to {33}."
}
}, so_wandertext[11] = {
{
"2. Rats with fleas: Roll one die to determine the number of rats you must face. Each rat has a Monster Rating of 20. If you live through the fight, roll one die. If the number you roll is less than the number of rats you have fought, you have been bitten by some of the fleas and have contracted Bubonic Plague. Consult the Disease Chart for details on your illness."
},
{
"3. Leeches: To determine the number, roll one die. The damage they do is determined by the roll of a die. Roll one die for every paragraph of text that you read from this point forward. If the number rolled is less than or equal to the number of leeches you have on you, remove 1 from your CON.\n" \
"  Leeches can be pulled off at a cost of two CON points per leech. They also can be burned off at no cost to CON. If you don't have a torch in your provisions you must tear them off or take your chances with good die rolls. (Be honest with yourself: if you don't have it written down beforehand, you don't have any torches). If you have a torch you can burn off one per paragraph of text[ where you do not have to do anything else]. You must roll for damage while you are burning them off."
},
{
"4. Mermaid/merman (opposite sex of the character): The merperson swims up to you and entices you to frolic. Roll one die and add 1. This is the level of the IQ saving roll you must make to prevent yourself from diving overboard to a watery, but enjoyable, death. (If you can breathe water you get 45 experience points if you go along, and must roll once for a disease in the first category.)"
},
{
"5. Dolphin: This friendly sea creature boosts you back into the boat. In an effort to get you to play with him he tosses you a ruby that is worth (1 die × 100) gp. Scratch him on the dorsal fin and be on your way. (Check for disease, but you need not make a drowning saving roll.)"
},
{
"6. Sea snake: This snake has a MR of (60 times (1 die + 1)). [Any hits on your person will instantly prove fatal. (Sea snake venom has no known antidote.) If you are immune to poison, just kill the snake. A Too-Bad Toxin would stop the poison but it would also turn you into a fish. ]Remember that all your magical protection devices are in the office of the City Guard. You need not make a disease check for this Wandering Monster."
},
{
"7. Jellyfish: The jellyfish has a CON of 20 and a fighting Monster Rating of (20 times (1 die + 2)). The Monster Rating will not decrease, just the CON. Take the MR in experience. Roll for disease on the Disease Chart."
},
{
"8. Alligator: [CON of 40, and fighting ]MR of 2 dice × 20. [Monster Rating will not fall, only the CON. ]Take the MR in experience. Roll for disease on the Disease Chart."
},
{
"9. Mermaid/merman (same sex as character): This merperson is looking for the being that has been fooling around with its mate. The merperson has a CON of 30, and combat adds of 3 dice × 10. The merperson fights with a sax. If you sustain any damage in the fight, roll for Osteomyelitis on the Disease Chart. On a roll of 1-3 on a six-sided die, the merperson has treasure, and you should roll for it on the Treasure Generator in the rulebook. If you take no damage, roll for disease normally."
},
{
"10. Rabid bats: To determine the number you must fight, roll one die and add 3. Each has a Monster Rating of 20. If you take any hits at all check the Disease Chart under Rabies to see if you contract the disease."
},
{
"11. Whirlpool: Add three to the level of the saving roll against drowning[ or rabies, whichever is higher]. Also make a saving roll on Luck for every weapon you have, on the level equal to the number of dice it gets. The whirlpool drags your boat and you down. Ignxx manages to reconstruct the boat, but you lose all treasure in the bottom of the boat. Roll for disease on the Disease Chart."
},
{
"12. Mosquitoes: Roll one die and add 1. This is the number of clouds of these pests around. Roll one die. If the number rolled is less than or equal to the number of mosquitoes around you, you get bitten. Roll one die to see if you contract Malaria (1-3) or Yellow Fever (4-6). Consult the Disease Chart for detail on your illness."
}
}, so_diseasetext[11] = {
{ // 0 (75)
"STAPH: A skin infection that can get into your lungs. It creates sores and abscesses. (Make a note on your character card that this character has sores.) If you are reduced to ½ your CON the disease will limit you to using only one weapon at a time. If you are reduced to ¼ of your CON you may only use a weapon getting 2 dice or less. When you go below ¼ of your CON you must roll one die per regular turn. On a 1 or 6 you take one die damage on your CON and CHR."
},
{ // 1 (76)
"PNEUMONIA: An inflammation of the lungs. Add 1 to the level of your drowning saving roll you must make from now on. For each combat turn you fight roll one die and add 1. If you roll a number less than or equal to the number of combat turns you have fought against this foe, divide your combat roll by your die roll. This is to simulate the clogging of your lungs from exertion during the battle, and the subsequent weakening your attack will suffer. (Example: Hector has pneumonia. He has been fighting rats for three turns. He rolls a 1 and adds 1. His 2 is less than the number of turns he has been fighting. He divides his combat roll by 1, fortunately for him, and continues fighting hoping that the disease won't catch up with him.)"
},
{ // 2 (77)
"CHOLERA: Causes severe gastrointestinal discomfort. To gauge the effect of this, keep track of the number of turns you have had the illness, or the number of full turns since the last \"attack\" of the illness. For each and every paragraph or combat turn, roll two dice. If the number you roll is less than or equal to the number of combat turns and/or paragraphs since you have contracted the disease or since the last attack, you suffer an attack of the disease. (Example: Casius has Cholera. It has been 6 paragraphs since he contracted the disease. He rolls a 5 and has an attack.)\n" \
"  During an attack you take one die of hits off your CON. You are also unable to do *anything* during that turn or combat turn. Restart the count on the following paragraph or combat turn."
},
{ // 3 (78)
"DYSENTRY: Causes severe gastrointestinal discomfort. To gauge the effect of this, keep track of the number of turns you have had the illness, or the number of full turns since the last \"attack\" of the illness. For each and every paragraph or combat turn, roll two dice. If the number you roll is less than or equal to the number of combat turns and/or paragraphs since you have contracted the disease or since the last attack, you suffer an attack of the disease. (Example: Casius has Dysentry. It has been 6 paragraphs since he contracted the disease. He rolls a 5 and has an attack.)\n" \
"  During an attack you take one die of hits off your CON. You are also unable to do *anything* during that turn or combat turn. Restart the count on the following paragraph or combat turn."
},
{ // 4 (79)
"HEPATITIS: This illness causes jaundice. (Note on your card that the character has jaundice.) Jaundice causes a yellowing of your skin and eyes. You also have bouts of nausea. The results of an attack will be the same as Cholera or Dysentery, but jaundice is not quite so violent. Roll three dice and keep track of turns in sets of 18. If you roll less than or equal to the number of combat turns and/or paragraphs since you contracted the disease or since you had the last attack, you suffer an attack. (Example: Achilles has gone 13 turns since his last attack of jaundice-related nausea. He rolls the dice and gets a 4. He has another attack.)\n" \
"  During an attack you take one die of hits off your CON. You are also unable to do *anything* during that turn or combat turn. Restart the count on the following paragraph or combat turn."
},
{ // 5 (80)
"POLIO: This illness causes paralysis. Roll one six-sided die and apply the result as listed below.\n" \
"  1-2: Leg affected: DEX drops to ½ normal; Speed (attribute) drops to 9/10 of normal.\n" \
"  3-4: Arm affected: DEX drops to ¾ normal.[ You may use only one-handed weapons, and only one at a time.]\n" \
"  5: Chest affected: CON drops to ¼ normal. Round fractions down - any CON below 1 means death. (Example: if your Constitution is 12, regardless of what it is when you are fully healed, and you get polio in the chest your CON will be knocked down to 3.)\n" \
"  6: Brain affected: IQ drops to ¼ normal. DEX drops to ¾ normal. All fractions should be rounded down. An IQ of less than 1 means death."
},
{ // 6 (81)
"BUBONIC PLAGUE: This illness creates sores, fever and chills. (Make a note on your card that this character has sores.)\n" \
"  Keep track of the number of turns you have had the illness, or the number of full turns since the last \"attack\" of the illness. For each and every paragraph or combat turn, roll two dice. If the number you roll is less than or equal to the number of combat turns and/or paragraphs since you have contracted the disease or since the last attack, you suffer an attack of the disease. (Example: Casius has Bubonic Plague. It has been 6 paragraphs since he contracted the disease. He rolls a 5 and has an attack.)\n" \
"  During an attack you take one die of hits off your CON. You are also unable to do *anything* during that turn or combat turn. Restart the count on the following paragraph or combat turn."
},
{ // 7 (82)
"MALARIA: This illness is caused by parasites living off your red blood cells. (Or the ones you have borrowed if you are a vampire.) You get bouts of fever and chills. See Malaria for determining frequency and results of attacks."
},
{ // 8 (83)
"YELLOW FEVER: This disease will give you jaundice (note that this character has jaundice), and will also cause internal bleeding and nausea.\n" \
"  Keep track of the number of turns you have had the illness, or the number of full turns since the last \"attack\" of the illness. For each and every paragraph or combat turn, roll two dice. If the number you roll is less than or equal to the number of combat turns and/or paragraphs since you have contracted the disease or since the last attack, you suffer an attack of the disease. (Example: Casius has Yellow Fever. It has been 6 paragraphs since he contracted the disease. He rolls a 5 and has an attack.)\n" \
"  During an attack you take one die of hits off your CON. You are also unable to do *anything* during that turn or combat turn. Restart the count on the following paragraph or combat turn."
},
{ // 9 (84)
"RABIES: This illness causes severe stomach cramps. You contract rabies on a roll of 1-2 on a six-sided die. For every 3 paragraphs you read from here on, you must make a saving roll on your CON as it currently stands. The saving rolls start at first level; add one level for each additional saving roll you must make. If you miss the saving roll, take hits on your CON equal to the number you missed the saving roll by. All rolls are made on current CON. (Example: Menotep has a CON of 20. He must make a fourth level saving roll on CON. He must roll a 15 and he gets a 7. He takes 8 hits on his CON, reducing it to 12 and then adds one to the level of the saving roll on his CON for next time. He must attempt to make that saving roll with a CON of 12.)\n" \
"  You must also make a saving roll any time you enter the water. When you enter the water make a Rabies saving roll and then your drowning saving roll, both on CON. A dip in the water will start the sequence of counting by threes over again."
},
{ // 10 (85)
"OSTEOMYELITIS: This disease results any time a metal object hits a bone and the wound is not cleaned. The bone will eventually rot away, but that will occur long after the character has left the sewers. You will feel pain when your body is subjected to a physical shock of being hit by something. For every hit you take on armour, subtract one from your Strength. Your ST will return like a magic-user's, but if it drops below zero you die - the pain was too much for you. After each time you lose Strength due to damage taken on armour, make a first level saving roll on Strength (20 - ST). If you miss it you pass out from the pain. Record the number you missed the roll by. This is the number of turns you will be out. If you are in the water, you drown. (If you are a water-breather, roll for a Wandering Monster for each turn you are out.) If you are attacked while you are unconscious you will be unable to defend yourself, and will probably die."
}
};

MODULE SWORD so_exits[SO_ROOMS][EXITS] =
{ {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/4A
  { 167,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/4B
  {  39, 142,  74,  -1,  -1,  -1,  -1,  -1 }, //   3/4C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/4D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/5A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/5B
  { 148,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/5C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/5D
  {  91,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/6A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/6B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/6C
  { 142,  74, 205,  -1,  -1,  -1,  -1,  -1 }, //  12/6D
  { 183,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/6E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/6F
  { 129, 169, 188,  74,  -1,  -1,  -1,  -1 }, //  15/7A
  {  44, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/7B
  { 138,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/7D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/7E
  { 135,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/8A
  {  74, 180, 188, 205,  -1,  -1,  -1,  -1 }, //  21/8B
  {  45,  98,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/8C
  { 151, 182,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/8D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/8E
  { 208,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/9A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/9B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/9C
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/9D
  {  85, 109, 100,  -1,  -1,  -1,  -1,  -1 }, //  29/10A
  {  95,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/10B
  {  75, 101, 136,  -1,  -1,  -1,  -1,  -1 }, //  31/10C
  {  84, 171,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/10D
  { 170,  74, 169,  39,  -1,  -1,  -1,  -1 }, //  33/10E
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/11A
  { 119,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/11B
  { 148,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/11C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/11D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/11E
  { 198,  33, 122,  -1,  -1,  -1,  -1,  -1 }, //  39/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/12B
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/12C
  {  32,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/12D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/12E
  {  21, 178,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/13A
  {  63,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/13B
  {  28, 159,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/13C
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/13D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/13E
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/14A
  { 102,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/14B
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/14C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/14D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/14E
  {  71, 136, 101,  -1,  -1,  -1,  -1,  -1 }, //  54/14F
  { 154,  42, 107,  -1,  -1,  -1,  -1,  -1 }, //  55/14G
  {  70,  21,  38,  -1,  -1,  -1,  -1,  -1 }, //  56/15A
  {  32,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/15B
  {  79, 216,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/15C
  {  39, 142,  74,  -1,  -1,  -1,  -1,  -1 }, //  59/15D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/16B
  { 158,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/16C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/16D
  {  30, 188, 136,  74,  -1,  -1,  -1,  -1 }, //  65/16E
  { 127, 215, 111,  -1,  -1,  -1,  -1,  -1 }, //  66/16F
  {  76,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/17A
  {  27,  37,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/17B
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/17C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/17D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/17E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/18A
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/18B
  {  33,  21, 136, 142, 105,  65, 178, 122 }, //  74/18C
  { 194, 104, 165,  -1,  -1,  -1,  -1,  -1 }, //  75/19A
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/19B
  {  29, 124, 195,  -1,  -1,  -1,  -1,  -1 }, //  77/19C
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/19D
  {  36,   7,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/19E
  { 134,  26,  17,  -1,  -1,  -1,  -1,  -1 }, //  80/19F
  {  44, 168,  21, 178,  -1,  -1,  -1,  -1 }, //  81/20A
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/20B
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/20C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/20D
  { 100, 186,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/20E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/21A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/21B
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/21C
  {  33, 122,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/21D
  { 210,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/21E
  {  78, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/21F
  {  58,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/22A
  { 214,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/22B
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/22C
  { 209, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/22D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/22E
  { 105,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/22F
  { 158,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/23A
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/23B
  {  60,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/23C
  {   5, 207,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/23D
  {   1,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/23E
  {  23,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/23F
  { 155,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/24A
  {  74, 169, 136,  15,  -1,  -1,  -1,  -1 }, // 105/24B
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/24C
  { 139, 211,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/24D
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/24E
  {  48,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/25A
  {  33, 122,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/25B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/25C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/25D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/25E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/26A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/26B
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/26C
  { 163,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/26D
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/26E
  {  90, 210,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/27A
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/27B
  {  65,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/27C
  {  23, 142,  39,  74,  -1,  -1,  -1,  -1 }, // 122/27D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/27E
  { 178, 136,  49,  14,  -1,  -1,  -1,  -1 }, // 124/27F
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/27G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/28A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/28B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/28C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/28D
  { 166,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/28E
  { 144, 105,  33,  -1,  -1,  -1,  -1,  -1 }, // 131/29A
  {  80,  33, 122,  -1,  -1,  -1,  -1,  -1 }, // 132/29B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/29C
  { 187,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/29D
  { 160,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/29E
  { 105,  65,  31,  74,  -1,  -1,  -1,  -1 }, // 136/29F
  {   1,  19,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/29G
  { 122,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/30A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/30B
  { 178,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/30C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/30D
  { 122, 178,  74, 174,  -1,  -1,  -1,  -1 }, // 142/30E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/30F
  {  13, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/31A
  { 142, 205,  33,  -1,  -1,  -1,  -1,  -1 }, // 145/31B
  {  41,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/31C
  {  33, 122,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/31D
  {   1, 137,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/32A
  { 214,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/32B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/32C
  {  39, 107,  74,  -1,  -1,  -1,  -1,  -1 }, // 151/32D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/32E
  { 119,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/33A
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/33B
  {  54, 101, 136,  -1,  -1,  -1,  -1,  -1 }, // 155/33C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/33D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/33E
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/33F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/33G
  { 181,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/33H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/34A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/34B
  { 146,  50,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/34C
  { 132,  33, 122,  -1,  -1,  -1,  -1,  -1 }, // 164/34D
  { 101, 136,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165/34E
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/35A
  {  33,  21, 136, 142, 105,  65, 178, 122 }, // 167/35B
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/35C
  { 131, 105,  33,  -1,  -1,  -1,  -1,  -1 }, // 169/35D
  {  99,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170/36A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171/36B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172/36C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173/36D
  { 142, 128,  92,  -1,  -1,  -1,  -1,  -1 }, // 174/36E
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175/37A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176/37B
  { 112, 201,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177/37C
  {  12, 205, 142,  74,  -1,  -1,  -1,  -1 }, // 178/37D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179/37E
  {  21, 149,  93,  -1,  -1,  -1,  -1,  -1 }, // 180/37F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181/37G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182/38A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183/38B
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184/38C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185/38D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186/38E
  {  33, 122,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187/39A
  {  86, 121,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188/39B
  { 111, 215,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189/39C
  { 209,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190/39D
  { 120,  55,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191/39E
  {  29, 195,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192/39F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193/40A
  { 155,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194/40B
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195/40C
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196/40D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197/40E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198/41A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199/41B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200/41C
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201/41D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202/41E
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203/41F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204/42A
  { 133, 178,  21,  -1,  -1,  -1,  -1,  -1 }, // 205/42B
  { 108, 175,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206/42C
  {  47, 123,  83, 179,  -1,  -1,  -1,  -1 }, // 207/42D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208/43A
  {  11,  87,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209/43B
  { 169,  74, 136,  -1,  -1,  -1,  -1,  -1 }, // 210/43C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211/43D
  {   5,  62,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212/43E
  {  21, 178,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213/43F
  {   9,  68,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214/44A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215/44B
  {  52, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216/44C
  { 110,  33, 122,  -1,  -1,  -1,  -1,  -1 }, // 217/44D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218/44E
  { 105,  33,  -1,  -1,  -1,  -1,  -1,  -1 }  // 219/44F
};

MODULE STRPTR so_pix[SO_ROOMS] =
{ "", //   0
  "",
  "",
  "",
  "",
  "so5", //   5
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
  "so20", //  20
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
  "so37",
  "",
  "so39",
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
  "so56",
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
  "so74",
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
  "so86",
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
  "so108",
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
  "so119",
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
  "", // 135
  "",
  "so137",
  "so138",
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
  "so150", // 150
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
  "", // 165
  "",
  "",
  "so168",
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
  "so182",
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
  "so207",
  "",
  "",
  "", // 210
  "",
  "",
  "",
  "",
  "", // 215
  "",
  "",
  "",
  ""  // 219
};

MODULE int                    infected,
                              shiptreasure,
                              warlevel,
                              won;

IMPORT int                    armour,
                              bankcp,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              evil_attacktotal,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              owed_cp, owed_sp, owed_gp,
                              room, prevroom, module,
                              round,
                              spellchosen,
                              spellpower;
IMPORT       SWORD*           exits;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *treasures[MODULES],
                             *wanders[MODULES];
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct LanguageStruct  language[LANGUAGES];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void so_enterroom(void);
MODULE void so_wandering(FLAG mandatory);
MODULE void so_playdice(void);
MODULE FLAG diseased(void);
MODULE void infect(int disease);

EXPORT void so_preinit(void)
{   descs[MODULE_SO]     = so_desc;
    wanders[MODULE_SO]   = so_wandertext;
    treasures[MODULE_SO] = so_diseasetext;
}

EXPORT void so_init(void)
{   int i;

    exits     = &so_exits[0][0];
    enterroom = so_enterroom;
    for (i = 0; i < SO_ROOMS; i++)
    {   pix[i] = so_pix[i];
    }

    warlevel     =
    infected     =
    shiptreasure = 0;
}

MODULE void so_enterroom(void)
{   TRANSIENT int  groups,
                   guards,
                   i,
                   result,
                   result1,
                   result2;
    TRANSIENT FLAG missedit,
                   ok;
    PERSIST   int  missed,
                   zombies;

    if (ability[125].known)
    {   if (dice(1) <= ability[125].known)
        {   templose_con(1);
        }
        if (items[TOR].owned || items[LAN].owned || items[ITEM_BS_UWTORCH].owned)
        {   aprintf("Burnt off a leech.\n");
            lose_numeric_abilities(125, 1);
        }
        if (ability[125].known)
        {   result = getnumber("Pull off how many leeches", 0, ability[125].known);
            templose_con(2 * result);
            lose_numeric_abilities(125, result);
    }   }

    switch (room)
    {
    case 0:
        owed_cp += cp;
        pay_cp_only(cp);
        owed_sp += sp;
        pay_sp_only(sp);
        owed_gp += gp;
        pay_gp_only(gp);
        // %%: probably jewels should be handled similarly

        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].magical)
            {   items[i].borrowed += items[i].owned;
                dropitems(i, items[i].owned);
        }   }
    acase 1:
        return_all();

        if (diseased() && !spell[SPELL_HF].known)
        {   DISCARD pay_gp(dice(1) * 1000);
            spell_hf();
        }
        victory(1000 + ((7 - level) * 100) + ((300 - calc_personaladds(max_st, lk, dex)) * 10) + (infected * 100));
    acase 2:
        create_monster(297);
        fight();
    acase 3:
        give_multi(DRK, zombies);
        give_gp(dice(1) * 10);
    acase 4:
        savedrooms(5, chr, 161, 51);
    acase 5:
        if (ability[86].known)
        {   room = 189;
        } else
        {   room = 66;
        }
    acase 6:
        die();
    acase 7:
        create_monster(299);
        fight();
    acase 8:
        savedrooms(3, iq, 103, 80);
    acase 10:
        result1 = 0;
        do
        {   do
            {   result2 = dice(1);
                result1 += result2;
            } while (result2 == 6);
            if (result1 >= 20)
            {   if (immune_poison())
                {   room = 70;
                } else
                {   die();
            }   }
            else
            {   give(557);
        }   }
        while (result1 < 20 && getyn("Play again (otherwise stop)"));
        if (result1 < 20)
        {   room = 121;
        }
    acase 11:
        die();
    acase 12:
        if (maybespend(1, "Fight"))
        {   warlevel = getnumber("Fight at what level", warlevel + 1, 9999);
            if   (warlevel <=  5) room = 218;
            elif (warlevel <= 10) room =  96;
            elif (warlevel <= 15) room = 162;
            elif (warlevel <= 25) room = 193;
            else                  room =  43;
        }
    acase 14:
        create_monster(301);
        fight();
        room = 192;
    acase 17:
        templose_con(17);
    acase 18:
        savedrooms(4, lk, 98, 199);
    acase 19:
        create_monsters(302, 3);
        fight();
        room = 88;
    acase 21:
        so_wandering(FALSE);
    acase 23:
        zombies = dice(1) + 1;
    acase 24:
        award(1000);
        rb_givejewels(-1, -1, 1, 6);
        bankcp += shiptreasure * 100; // is this the only paragraph where we get to actually keep the ship treasure?
        shiptreasure = 0;
    acase 25:
        award(1000);
        give(639);
    acase 26:
        die();
    acase 27:
        give(553);
        savedrooms(3, lk, 206, 130);
    acase 28:
        create_monster(305);
        for (i = 1; i <= 8; i++)
        {   oneround();
        }
        dispose_npcs();
    acase 29:
        if (getyn("Dive into sewers"))
        {   drop_all();
            if (getyn("Go north (otherwise east)"))
            {   room = 178;
            } else
            {   room = 136;
        }   }
    acase 30:
        if (getyn("Swim"))
        {   if (armour != -1)
            {   dropitem(armour); // %%: what about carried armour?
            }
            room = 190;
        }
    acase 33:
        so_wandering(FALSE);
    acase 34:
        give(544);
        create_monsters(306, 8);
        fight();
    acase 35:
        if (missed == 2)
        {   die();
        } else
        {   templose_con(5);
            gain_flag_ability(87);
            create_monsters(303, dice(3));
        }
    acase 36:
        create_monster(299);
        castspell(-1, TRUE);
        fight();
    acase 37:
        savedrooms(5, dex, 197, 6);
    acase 38:
        savedrooms(7, lk, 177, 140);
    acase 40:
        die();
    acase 41:
        so_wandering(FALSE);
    acase 43:
        good_takehits(dice(7), TRUE); // %%: does armour help? We assume so.
        savedrooms(4, chr, 145, 61);
    acase 44:
        lose_flag_ability(88);
        if (getyn("Fight Morgo (otherwise dive)"))
        {   room = 157;
        } else
        {   drop_all();
        }
    acase 45:
        create_monsters(307, 3);
        fight();
        guards = dice(3);
        groups = guards / dice(1);
        for (i = 1; i <= groups; i++)
        {   if (i == groups)
            {   create_monsters(308, (guards / groups) + (guards % groups));
            } else
            {   create_monsters(308,  guards / groups                     );
            }
            fight();
        }
 /* acase 46:
        ; %%: maybe we should give them a silk hood. */
    acase 47:
        so_wandering(FALSE);
    acase 49:
        good_takehits(1, TRUE); // %%: does armour help? We assume so.
    acase 50:
        create_monster(309);
        fight();
    acase 51:
        spell_hf();
    acase 52:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == WEAPON_DAGGER)
            {   room = 106;
                break; // for speed
        }   }
        // %%: "cutting weapon of some sort"...? We are only supporting daggers.
        if (room == 52)
        {   room = 143;
        }
    acase 53:
        give_gp(dice(2) * 10);
        give(59);
        create_monster(310);
        // %%: we are assuming that the ogre's club isn't usable by the player
        fight();
    acase 54:
        give(545);
    acase 56:
        if (getyn("Emerge peacefully"))
        {   // we don't bother dropping weapons here as we usually pick them up again anyway later
            if (ability[75].known || ability[81].known || ability[79].known || ability[83].known)
            {   room = 140; // %%: is this always, or only if emerging peacefully? We assume the latter.
            } else
            {   room = 81;
        }   }
    acase 59:
        // %%: Can each sword be taken separately on armour? We assume so.
        for (i = 1; i <= missed; i++)
        {   good_takehits(5, TRUE);
        }
        create_monster(328);
        oneround();
        oneround();
        if (countfoes())
        {   create_monsters(328, zombies - 1);
            fight();
            room = 3;
        }
    acase 60:
        give_gp(250 + 1000); // %%: arguably we should have an item "1000 gp worth of stuff".
        award(150);
    acase 61:
        die();
    acase 62:
        if (getyn("Stay with Ignxx"))
        {   shiptreasure = 5000;
            room = 196;
        } else
        {   shiptreasure = 10000;
            room = 126;
        }
    acase 67:
        result = dice(2);
        missedit = FALSE;
        for (i = 1; i <= result; i++)
        {   if (!saved(5, dex))
            {   if (missedit)
                {   die();
                } else
                {   lose_dex(5); // %%: for how long? We assume it is permanent.
                    missedit = TRUE;
        }   }   }
    acase 69:
        give_gp(100);
        rb_givejewels(-1, -1, 1, 3);
    acase 70:
        die();
    acase 71:
        // we don't actually implement the ring, as it seems worthless
        if (getyn("Attack"))
        {   room = 200;
        } elif (been[194])
        {   room = 173;
        } else
        {   // assert(been[104]);
            room = 152;
        }
    acase 72:
        give(544);
        give(546);
        savedrooms(5, iq, 1, 141);
    acase 73:
        give(GRE);
        give(SAX);
        give(547);
        give(548);
        award(151);
    acase 74:
        if (dice(1) == dice(1))
        {   room = 2;
        }
    acase 76:
        spell_hf();
        if (class != WARRIOR && getyn("Learn 2 spells (otherwise take the gold)"))
        {   for (i = 0; i < SPELLS; i++)
            {   if (!spell[i].known && spell[i].level <= 6)
                {   listspell(i, TRUE);
            }   }
            result2 = 0;
            do
            {   result1 = getnumber("Learn which spell (0 for none)", 0, SPELLS) - 1;
                if (result1 == -1)
                {   result2 = 2;
                } elif (spell[result1].known)
                {   aprintf("You already know %s!\n", spell[result1].corginame);
                } elif (spell[result1].level > 6)
                {   aprintf("Only 1st-6th level spells!\n");
                } else
                {   learnspell(result1);
                    result2++;
            }   }
            while (result2 < 2);
        } else
        {   give_gp(1000);
        }
        award(1000);
    acase 78:
        create_monster(311);
        fight();
    acase 79:
        templose_con(6);
        so_drowning(0);
    acase 82:
        lose_flag_ability(86);
    acase 83:
        give(546);
        create_monsters(306, 3);
        oneround();
        oneround();
        create_monsters(306, 5);
        fight();
    acase 84:
        die();
    acase 85:
        give(DRK);
    acase 86:
        if (maybespend(100, "Play game"))
        {   room = 10;
        } else
        {   room = 121;
        }
    acase 87:
        savedrooms(5, lk, 20, 202);
    acase 88:
        spell_hf();
        rb_givejewels(-1, -1, 1, 3);
        award(550);
    acase 89:
        so_wandering(FALSE);
    acase 90:
        create_monsters(330, dice(3));
        fight();
    acase 91: // %%: ambiguous paragraph
        give(MAI);
        give(KNI);
        while (shop_give(2) != -1);
    acase 92:
        if (saved(4, dex))
        {   if (!saved(4, con))
            {   so_wandering(TRUE);
        }   }
        else
        {   if (saved(4, con))
            {   so_wandering(TRUE);
            } else
            {   die();
        }   }
    acase 93:
        so_wandering(TRUE);
    acase 94:
        give(SAX);
        give(GRE);
        give_gp(250);
        give(549);
    acase 97:
        do
        {   so_drowning(0);
            if (dice(1) == dice(1))
            {   rb_treasure(2);
            } else
            {   so_wandering(FALSE);
        }   }
        while (getyn("Dive again"));
    acase 98:
        so_wandering(TRUE);
    acase 99:
        if (saved(4, lk))
        {   if (!saved(4, dex))
            {   good_takehits(misseditby(4, dex), TRUE);
        }   }
        else
        {   good_takehits(misseditby(4, lk), TRUE);
            if (!saved(4, dex))
            {   die();
        }   }
    acase 96:
        create_monster(300);
        npc[0].dice =  4;
        npc[0].con  =      warlevel  + 20;
        npc[0].adds = (4 * warlevel) +  2;
        npc[0].ap   =  8 * warlevel;
        fight();
        while (maybespend(1, "Fight again"))
        {   warlevel = getnumber("Fight at what level", warlevel + 1, 9999);
            if (warlevel <= 10)
            {   create_monster(300);
                npc[0].dice =  4;
                npc[0].con  =      warlevel  + 20;
                npc[0].adds = (4 * warlevel) +  2;
                npc[0].ap   =  8 * warlevel;
                fight();
            } else
            {   break;
        }   }
        room = 12;
    acase 100:
        create_monster(312);
        fight();
    acase 102:
        permlose_st(st / 2);
        lose_iq(iq / 2);
        lose_lk(lk / 2);
        permlose_con(con / 2);
        lose_dex(dex / 2);
        lose_chr(chr / 2);
        lose_spd(spd / 2); // %%: does Speed count? We assume so.
    acase 103:
        ok = FALSE;
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == WEAPON_DAGGER)
            {   ok = TRUE;
                break; // for speed
        }   }
        if (!ok)
        {   room = 80; // %%: what to do if they don't have a dagger?
        } else
        {   do
            {   for (i = 0; i < ITEMS; i++)
                {   if (items[i].owned && items[i].type == WEAPON_DAGGER)
                    {   aprintf("%d: %d %s\n", i + 1, items[i].owned, items[i].name);
                }   }
                result = getnumber("Give which dagger", 1, ITEMS);
            } while (!items[result].owned || items[result].type != WEAPON_DAGGER);
            dropitem(result);
            give(558); // the gems are supposed to be part of the circlet but we handle them separately
            rb_givejewels(-1, -1, 1, 7);
        }
    acase 104:
        create_monster(313);
        fight();
    acase 106:
        create_monster(314);
        fight();
    acase 108:
        create_monster(315);
    acase 109:
        if (!saved(5, dex))
        {   good_takehits(dice(6) + 151, TRUE);
        }
    acase 110:
        if (can_makefire())
        {   if (getyn("Burn mummy on throne"))
            {   room = 147;
            } elif (getyn("Burn mummies within sarcophagi"))
            {   room = 176;
        }   }
    acase 111:
        create_monster(298);
        oneround();
        if (!countfoes())
        {   room = 25;
        } else
        {   do
            {   if (getyn("Flee (otherwise fight)"))
                {   dispose_npcs();
                    room = 215;
                } else
                {   oneround();
                    if (!countfoes())
                    {   room = 25;
            }   }   }
            while (room == 111);
        }
    acase 112:
        create_monster(316);
        fight();
        give_gp(500);
    acase 113:
        gain_flag_ability(165);
        give(639);
        give(550);
        award(500);
    acase 114:
    case 115:
        die();
    acase 116:
        create_monster(317);
        fight();
    acase 117:
        create_monster(318);
        fight();
    acase 118:
        so_wandering(TRUE);
    acase 120:
        module = MODULE_CT;
        room = 59;
    acase 123:
        if (st >= 60)
        {   room = 34;
        } else
        {   so_wandering(TRUE);
            room = 5;
        }
    acase 124:
        give(549);
    acase 125:
        give_gp(1000);
        award(115);
    acase 126:
        if (getyn("Surrender loot (otherwise fight)"))
        {   shiptreasure = 0;
            room = 1;
        } else
        {   create_monster(320);
            fight();
            room = 24;
        }
    acase 127:
        won = 0;
        so_playdice();
        if (room == 127)
        {   so_playdice();
            if (won == 0)
            {   if (ability[3].known) room = 150; else room = 172;
            }
            if (room == 127 && (won == 1 || getyn("Roll for the third gem")))
            {   so_playdice();
            }
            if (room == 127)
            {   room = 1;
        }   }
    acase 128:
        if (saved(3, lk))
        {   so_wandering(TRUE);
            room = 58;
        } else
        {   die();
        }
    acase 129:
        if (saved(5, iq))
        {   if (saved(5, dex))
            {   room = 153;
            } else
            {   missed = 1;
                room = 35;
        }   }
        else
        {   if (saved(5, dex))
            {   missed = 1;
            } else
            {   missed = 2;
            }
            room = 35;
        }
    acase 130:
        create_monster(321);
        fight();
    acase 132:
        if (can_makefire())
        {   if (getyn("Burn mummy on throne"))
            {   room = 147;
            } elif (getyn("Burn contents of sarcophagi"))
            {   room = 176;
        }   }
    acase 133:
        if (!races[race].humanoid) // %%: but non-humanoids aren't allowed in this module anyway!?
        {   room = 140;
        } elif (sex == MALE)
        {   room = 56;
        } else
        {   room = 77;
        }
    acase 134:
        create_monster(322);
        fight();
    acase 135:
        create_monster(309);
        fight();
    acase 136:
        so_wandering(FALSE);
    acase 139:
        create_monsters(326, 3);
        castspell(-1, TRUE);
        if (spellchosen == SPELL_SF || spellchosen == SPELL_BT)
        {   dispose_npcs();
            room = 1;
        }
        if (countfoes())
        {   castspell(-1, TRUE);
            if (spellchosen == SPELL_SF || spellchosen == SPELL_BT)
            {   dispose_npcs();
                room = 1;
        }   }
        if (countfoes())
        {   die();
            // %%: are we allowed to kill them via normal combat? We assume not.
            // %%: are we allowed to cast 2 spells and *then* the SF/BT spell?
        } elif (room == 139)
        {   room = 203;
        }
    acase 140:
        good_takehits(dice(8), TRUE); // cranequin damage
    acase 141:
        module = MODULE_DE;
        room = -1;
    acase 142:
        so_wandering(FALSE);
    acase 143:
        die();
    acase 144:
        so_wandering(TRUE);
    acase 145:
        give_gp(dice(3) * 10);
    acase 147:
        gain_flag_ability(86);
    acase 148:
        give(552);
        give_gp(100);
        rb_givejewels(-1, -1, 1, 2);
    acase 149:
        if (saved(6, dex))
        {   if (!saved(7, lk))
            {   templose_con(dice(misseditby(7, lk)));
        }   }
        else
        {   templose_con(dice(misseditby(6, dex)));
            if (!saved(7, lk))
            {   die();
        }   }
    acase 150:
        die();
    acase 151:
        missed = 0;
        for (i = 1; i <= zombies; i++)
        {   if (!saved(4, dex))
            {   missed++;
        }   }
        if (missed == zombies)
        {   die();
        } elif (missed > 0)
        {   room = 59;
        }
    acase 152:
        gain_flag_ability(73);
        spell_hf();
    acase 153:
        create_monsters(330, dice(3));
        fight();
    acase 154:
        lose_iq(dice(1));
    acase 155:
        award(350);
    acase 156:
        die();
    acase 157:
        if (st > 140)
        {   room = 213;
        } else
        {   room = 185;
        }
    acase 158:
        give_multi(547, 5);
    acase 159:
        die();
    acase 160:
        permlose_st(st / 2);
        lose_iq(iq / 2);
        lose_lk(lk / 2);
        permlose_con(con / 2);
        lose_dex(dex / 2);
        lose_chr(chr / 2);
        lose_spd(spd / 2); // %%: does Speed count? We assume so.
        height /= 2;
        weight /= 2;
    acase 161:
        savedrooms(5, iq, 64, 114);
    acase 162:
        create_monster(300);
        npc[0].dice =  5;
        npc[0].con  =  5 * warlevel;
        npc[0].adds = 15 * warlevel;
        npc[0].ap   = 10 * warlevel;
        fight();
        while (maybespend(1, "Fight again"))
        {   warlevel = getnumber("Fight at what level", warlevel + 1, 9999);
            if (warlevel <= 15)
            {   create_monster(300);
                npc[0].dice =  5;
                npc[0].con  =  5 * warlevel;
                npc[0].adds = 15 * warlevel;
                npc[0].ap   = 10 * warlevel;
                fight();
            } else
            {   break;
        }   }
        room = 12;
    acase 165:
        give(554);
    acase 166:
        create_monsters(323, 3);
        fight();
    acase 167:
        give(555);
    acase 168:
        create_monster(334);
        if (saved(2, dex))
        {   evil_takehits(0, dice(items[DRK].dice) + items[DRK].adds);
        }
        if (countfoes())
        {   fight();
        }
        give(DRK);
        give_gp(500);
    acase 171:
        create_monsters(324, 3);
        fight();
        if (been[57])
        {   room = 69;
        } else
        {   room = 113;
        }
    acase 172:
    case 173:
        die();
    acase 175:
        create_monster(315);
        evil_freeattack();
        fight(); // %%: what if the fight lasts for several rounds?
    acase 176:
        die();
    acase 179:
        if (saved(6, st))
        {   if (saved(6, lk))
            {   room = 72;
            } else
            {   room = 118;
        }   }
        else
        {   if (saved(6, lk))
            {   room = 118;
            } else
            {   room = 156;
        }   }
    acase 181:
        create_monster(325);
        fight();
    acase 182:
        create_monsters(328, zombies);
        fight();
    acase 183:
        die();
    acase 184:
        award(100);
        give(553);
        give_gp(2000);
        gain_flag_ability(74);
    acase 185:
        good_takehits(1, TRUE);
        drop_all();
        // %%: it doesn't say which goods are recovered (we assume it means those lost at SO0).
    acase 186:
        create_monster(329);
        good_freeattack();
        if (countfoes() && npc[0].con >= 2)
        {   room = 204;
        } else
        {   room = 94;
        }
    acase 187:
        give(561);
        rb_givejewels(-1, -1, 1, 3);
    acase 190:
        so_wandering(TRUE);
    acase 192:
        give(556);
    acase 193:
        create_monster(300);
        npc[0].dice =   6;
        npc[0].con  =  10 * warlevel;
        npc[0].adds = (15 * warlevel) + 3;
        npc[0].ap   =  20 * warlevel;
        fight();
        while (maybespend(1, "Fight again"))
        {   warlevel = getnumber("Fight at what level", warlevel + 1, 9999);
            if (warlevel <= 25)
            {   create_monster(300);
                npc[0].dice =   6;
                npc[0].con  =  10 * warlevel;
                npc[0].adds = (15 * warlevel) + 3;
                npc[0].ap   =  20 * warlevel;
                fight();
            } else
            {   break;
        }   }
        room = 12;
    acase 194:
        create_monster(335);
        good_freeattack();
        fight();
    acase 196:
        if (!saved(5, dex))
        {   shiptreasure -= misseditby(5, dex) * 100;
            if (shiptreasure < 0)
            {   shiptreasure = 0;
        }   }
    acase 197:
        give(SAX);
        give(ITEM_SO_HORSE);
        create_monster(336);
        fight();
    acase 198:
        getsavingthrow(TRUE);
        if (madeitby(6, iq) >= 10)
        {   room = 217;
        } elif (madeit(6, iq))
        {   room = 164;
        } else
        {   room = 89;
        }
    acase 199:
    case 200:
        die();
    acase 201:
        good_takehits(dice(2) + 1, TRUE); // dirk damage
        create_monster(316);
        fight();
    acase 202:
        die();
    acase 203:
        give(560);
        templose_st(8); // %%: is this supposed to be modified by eg. staves, being higher/lower level than the spell, etc.?
    acase 204:
        die();
    acase 208:
        die();
    acase 211:
        create_monsters(326, 3);
        give_gp(300 * 3);
        award(80);
    acase 213:
        create_monster(329);
        do
        {   oneround();
        } while (con >= 2 && npc[0].con >= 2);
        if (con == 1 && countfoes())
        {   heal_con(1);
            drop_all();
            if (dice(1) <= 3)
            {   room = 1;
        }   }
        else
        {   room = 73;
        }
    acase 215:
        if (saved(1, spd) && saved(1, spd) && saved(1, spd) && saved(1, spd))
        {   room = 82;
        } else
        {   room = 40;
        }
    acase 218:
        create_monster(300);
        npc[0].dice =  3;
        npc[0].con  =  3 * warlevel;
        npc[0].adds = (3 * warlevel) + 4;
        npc[0].ap   =  6 * warlevel;
        fight();
        while (maybespend(1, "Fight again"))
        {   warlevel = getnumber("Fight at what level", warlevel + 1, 9999);
            if (warlevel <= 5)
            {   create_monster(300);
                npc[0].dice =  3;
                npc[0].con  =  3 * warlevel;
                npc[0].adds = (3 * warlevel) + 4;
                npc[0].ap   =  6 * warlevel;
                fight();
            } else
            {   break;
        }   }
        room = 12;
    acase 219:
        rb_givejewel(-1, -1, 1);
}   }

MODULE void so_wandering(FLAG mandatory)
{   FLAG ok;
    int  i, j,
         result,
         result1,
         result2,
         whichmonster;

    if (!mandatory && dice(1) != 1)
    {   return;
    }

    aprintf(
"WANDERING MONSTER CHART\n" \
"  All fights with Wandering Monsters that live in the water are considered to take place in the water. Any time you are told to check for a Wandering Monster, roll one die. If you roll a 1 on a six-sided die you have met a Wandering Monster. A drowning saving roll (½ your armour's face value is the level for a CON saving roll) must be made *per combat round you spend in the water*. If you survive any fight in the water, turn to the Disease Chart and consult it to determine the possibility of your contracting a disease from the sewer water.\n" \
"  Roll two dice to determine which Wandering Monster you must deal with.\n"
    );

    whichmonster = dice(2);
    aprintf("%s\n", so_wandertext[whichmonster - 2]);

    switch (whichmonster)
    {
    case 2:
        if (room == 190)
        {   return;
        }
        result = dice(1);
        create_monsters(303, result);
        fight();
        if (dice(1) < result)
        {   infect(81); // bubonic plague
        }
    acase 3:
        gain_numeric_abilities(125, dice(1));
    acase 4:
        result = dice(1) + 1;
        if (!saved(result, iq))
        {   if (can_breathewater(TRUE))
            {   award(45);
                so_diseasechart(TRUE);
            } else
            {   die();
        }   }
    acase 5:
        if (room == 93)
        {   die();
        } else
        {   give(536 + dice(1)); // 537..542
        }
    acase 6:
        create_monster(304);
        npc[0].mr = 60 * (dice(1) + 1);
        recalc_ap(0);
        do
        {   so_drowning(0);
            oneround();
        } while (countfoes());
    acase 7:
        create_monster(337);
        recalc_ap(0);
        npc[0].mr = 20 * (dice(1) + 2);
        do
        {   so_drowning(0);
            oneround();
        } while (countfoes());
        so_diseasechart(TRUE);// %%: it's ambiguous whether we can catch everything or only staph
    acase 8:
        create_monster(331);
        npc[0].mr = 20 * dice(2);
        recalc_ap(0);
        do
        {   so_drowning(0);
            oneround();
        } while (countfoes());
        so_diseasechart(TRUE); // %%: it's ambiguous whether we can catch everything or only staph
    acase 9:
        if (sex == MALE)
        {   create_monster(332);
        } else
        {   create_monster(333);
        }
        npc[0].adds = dice(3) * 10;
        // %%: is the osteomyelitis check per round? We assume it is just at the conclusion of the combat.
        // Although in this case it doesn't actually matter.
        ok = TRUE;
        do
        {   so_drowning(0);
            oneround();
            if (good_damagetaken >= 1) // %%: does it mean hits taken or damage taken?
            {   ok = FALSE;
        }   }
        while (countfoes());
        if (!ok)
        {   infect(85); // osteomyelitis
            // %%: WMT implies that osteo isn't automatic, but Disease Chart implies it is.
        } else
        {   so_diseasechart(TRUE); // %%: it's ambiguous whether we can catch everything or only staph
        }
        if (dice(1) <= 3)
        {   rb_treasure(2);
        }
    acase 10:
        if (room == 190)
        {   return;
        }
        create_monsters(327, dice(1) + 3);
        // %%: is the rabies check per round and/or per bat? We assume it is just at the conclusion of the combat.
        ok = TRUE;
        do
        {   oneround();
            if (good_damagetaken >= 1) // %%: does it mean hits taken or damage taken?
            {   ok = FALSE;
        }   }
        while (countfoes());
        if (!ok && dice(1) <= 2)
        {   infect(84); // rabies
        }
    acase 11:
        so_drowning(3);
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && isweapon(i))
            {   for (j = 1; j <= items[i].owned; j++)
                {   if (!saved(items[i].dice, lk))
                    {   dropitem(i);
        }   }   }   }
        shiptreasure = 0;
        so_diseasechart(TRUE); // %%: it's ambiguous whether we can catch everything or only staph
    acase 12:
        if (room == 190)
        {   return;
        }
        result1 = dice(1) + 1;
        result2 = dice(1);
        if (result2 <= result1)
        {   if (dice(1) <= 3)
            {   infect(82); // malaria
            } else
            {   infect(83); // yellow fever
}   }   }   }

MODULE FLAG diseased(void)
{   int i;

    for (i = 75; i <= 85; i++)
    {   if (ability[i].known)
        {   return TRUE;
    }   }

    return FALSE;
}

EXPORT void so_diseasechart(FLAG drowning)
{   int result;

    result = dice(1);
    if (!drowning && result != 1)
    {   return;
    }

    aprintf(
"DISEASE CHART\n" \
"  In a magical world, magic renders most diseases harmless in very little time. The only germs to survive are those that act very quickly or live in a magic-free environment. The germs and parasites in the sewers are incredibly virulent and the incubation period for these illnesses is momentary.\n" \
"  If you have not been instructed to check for a specific disease, consult the next paragraph for directions as to what you should do next. If you have been to check a specific disease look for it below and follow the instructions at that paragraph.\n" \
"  The six diseases listed below are sicknesses that you can pick up from the water itself. If you have not missed a drowning saving roll, then the only disease you can pick up is #1, Staph. If you have taken in water, either from a missed drowning saving roll or from breathing water, you can contract any of the six listed below. Roll accordingly, but you can only get one disease from this group at a time, except that Staph can accompany any other disease. (You can have Staph with any of the others, but for game purposes you won't have Dysentery and Cholera at the same time.)\n" \
"  Roll one six-sided die. If you didn't miss the drowning saving roll, ignore any result but 1. Consult the descriptions below for results of sickness.\n" \
"    1 - Staph\n" \
"    2 - Pneumonia\n" \
"    3 - Cholera\n" \
"    4 - Dysentery\n" \
"    5 - Hepatitis\n" \
"    6 - Polio\n" \
"  All of these diseases can be cured by a Healing Feeling. While in the sewers, use of magic will turn you into a fish. Once outside the sewers, a rogue or magic user can cast the spell upon him or herself and be cured. A series of Restoration spells will repair the damage you sustained.\n" \
"  The symptoms used here are based in fact. Remember that in medieval society, plague and sickness often killed great numbers of the population, even the toughest people around. While a magical world like the setting for this adventure is hardly medieval, without the protective magic that the people are used to, disease becomes as dangerous and as deadly as it is in a world with no medical technology.\n"
    );

    infect(74 + result); // 75..80
}

MODULE void infect(int disease)
{   // assert(disease >= 75);
    // assert(disease <= 85);

    if ((module == MODULE_SO && room == 98) || items[818].owned)
    {   return;
    }

    aprintf("%s\n", so_diseasetext[disease - 75]);

    infected++;
    gain_flag_ability(disease);
}

MODULE void so_playdice(void)
{   int result1, result2;

    result1 = getnumber("1) 7 and below\n2) 8 and above\nWhich", 1, 2);
    result2 = dice(2);
    if (result2 == 2)
    {   if (ability[3].known) room = 150; else room = 172;
    } elif
    (   (result1 == 1 && result2 <= 7)
     || (result1 == 2 && result2 >= 8)
    )
    {   give(547);
        won++;
}   }

EXPORT void so_drowning(int harder)
{   int savelevel;

    if (race != MERMAN && armour != -1)
    {   savelevel = (items[armour].hits / 2) + (items[armour].hits % 2) + harder;
        if (!saved(savelevel, con))
        {   templose_con(misseditby(savelevel, con));
            so_diseasechart(TRUE);
}   }   }
