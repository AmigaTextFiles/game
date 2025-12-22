#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Errata:
 BF17 aka 2M is unreachable, in both versions.
 BF144 aka 18G should presumably say "three" sentences, not "two" sentences.
Also, there are these errors in the FB edition, but not in the Corgi edition:
 3A: "go to 6K" should be "go to 6L".
 WMT: part 5 (Vampires), "go to 117" should be "go to 3K".
*/

MODULE const STRPTR bf_desc[BF_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  A single humanoid character, with a maximum of 15 personal combat adds, may adventure in the Blue Frog Tavern.[ Spell-casting is not allowed in this dungeon, but rogues and warrior-wizards may still enter as long as they use no magic.]\n" \
"  When you are told to roll for a wandering monster, roll a six-sided die. If it comes up 1, you have encountered a Wandering Monster. Consult the Wandering Monster chart on page 65 of this book and follow the directions given. If you defeat the monster(s), return to the paragraph you came from.\n" \
"~INTRODUCTION\n" \
"  At the end of the day you come across a small country tavern near a dark forest. Over the door is hung a wooden sign with a blue frog painted on it. Entering the tavern, you make your way through the dimly-lit common room and take your seat at a table with your back to the wall. As your eyes become accustomed to the lighting, you size up the other customers.\n" \
"  Across the room, beside the bar, stands a black-bearded dwarf with a patch over his right eye; he is talking to a short, blue-eyed rock demon. At a table near the door is a merry group of hobbits. Near the fireplace are hunched two villainous-looking humans casting dice. A big, mean-looking troll leans against the bar. The barman appears human, but tough, with numerous scars running across his body; you get a better look at him as he comes over to your table to take your order.\n" \
"  You ask the barman about the local gossip, and he tells you the new tavern owner is looking for a sword for hire. He also tells you the local order of Red Robed Priests have been swarming over the countryside, questioning strangers. There has been some talk that their treasure room was looted. The accursed Priests have been causing trouble, and their actions have hurt the tavern business.\n" \
"  The barman notices that you have been trying not to stare at the troll, and laughs. He leans close to you and whispers, \"That's the bouncer. He's an outcast among trolls, because his name is 'Butterfly-Dances-In-The-Morning-Dew'. Don't ever call him by his name - don't even call him 'Butterfly'! A customer forgot once, and he -\" the man gestures towards the troll, \"- ripped his arm off!\"\n" \
"  As the barman brings your order, a fight breaks out between the dwarf and the rock demon. The rock demon breaks a beer mug over the dwarf's head. The troll lurches erect, grabs the rock demon with one hand and casually tosses him over his shoulders. The rock demon hurtles across the room and slides across your table head-first into the wall.\n" \
"  If you try to impress the tavern owner and end the fight by knocking out the rock demon with your beer mug, go to {131}. If you draw your weapon and stop the troll (after all, the rock demon was struck from behind, and is not a match for the troll) go to {41}. If you sit quietly at your table and sip your drink, go to {27}."
},
{ // 1/1A
"The wizard beings to curse the rug; he stops short and explains that the rug is a flying carpet. He was trying it out and cast a teleport spell; the magic backfired and he was trapped inside the rug's pattern. He gives you the rug as a reward for setting him free.\n" \
"  The rug is worth 2000 gp; it weighs 500. It will carry up to 22,000 weight units, but is useless here because it cannot corner in tunnels and you must dismount to open doors. To make the rug fly, sit in the middle and say \"Get-em-up Scout!\" The rug will obey a voice command and will fly at speeds ranging from a slow walk to a fast gallop (same speed as a horse). However, wizards must remember not to cast teleport or flying spells while riding the rug, or they'll be locked into the pattern.\n" \
"  The wizard shakes the dust from his robe, waves his left hand, and disappears in a flash of blue light. You can roll the rug up and take it with you, or leave it here. Go to {108}."
},
{ // 2/1B
"The silver shield glows and will act as a torch when you wear it. It will take 5 hits each combat round; due to the light it reflects against your opponent, it will give you one additional add when fighting. Go to {159}."
},
{ // 3/1C
"The hobgoblin gets 8 dice plus 30 combat adds; he has a CON of 45. If you are still alive when the fight is over, take 60 adventure points. If you're not, then why are you reading this? If there is any beer left in the keg, Quartz will share it with you. When the keg is empty, go to {61}."
},
{ // 4/1D
"You have passed through the magic green door. If you carry any gold coins, go to {82}. If you have no gold, go to {133}."
},
{ // 5/1E
"As you walk across the room, you sink deeper into the floor until you reach the mid-point of the room. The floor is now up to your neck. Quartz looks down at you, shakes his head, and offers you a drink from his wine skin.\n" \
"  Suddenly your body from the neck down feels cool and damp. As you walk to the door, Quartz shouts and points to you. You look down and see that all your clothes, armour, weapons, supplies, and treasures are gone - everything that you wore or carried from your neck down has disappeared. Anything that you kept above the floor is still with you.\n" \
"  If you're not sure if you carried anything above your head, roll one die. If you rolled a 1, you carried one weapon above your head. If you rolled 2-6, everything is gone. If this was your first time in this room and you kept your weapons safe (without rolling a die) take 50 experience points for your intelligence.\n" \
"  If you were going south, go to {99}. If you were going north, go to {29}. If you were dumb enough to wade into the floor with your weapons and now you are unarmed, go to {125}."
},
{ // 6/1F
"In the room are two grinning warriors of the undead. Their flesh rots upon their bones, and they point their swords menacingly in your direction as their dead eyes survey you from behind ghastly skull faces. Each one gets 4 dice and 20 adds in combat, has a CON of 10, and can take 2 hits on armour. You must fight to the death. If you are killed, close the book. If you win, take 35 experience points and go to {103}."
},
{ // 7/2A
"The troll sniffs and then gives you a hug and a kiss, saying, \"You look ugly but smell beautiful!\" With a look of disgust, Quartz tells you that you make a cute couple but you'd best be going.\n" \
"  The troll wants to go along with you. Quartz reminds you that you are his employee and that he's not going to take some dumb lovesick troll along. Tell the troll to meet you at the Blue Frog Tavern, or to wait here because you'll be back. (It would be best to handle this matter as diplomatically as possible, for there is no telling what a love-spurned troll could do.)\n" \
"  You bid a fond farewell to the troll and leave. If you climb the stairs, go to {152}. If you try the south door, go to {116}."
},
{ // 8/2B
"Quartz wipes his face and takes a drink from the wineskin. The snake glows green for a moment, then turns to dust and disappears. In its place you find a 30' coil of dark green rope. If you throw the rope into the air, it will hang in mid-air, becoming as rigid as a steel pipe and sturdy enough to climb up or down on. If you twist either end of the rope, it will become limp and fall down. The rope is worth 600 gold pieces. Go to {89}."
},
{ // 9/2C
"In the red pouch are 30 rubies, each worth 200 gp. Return to {112}."
},
{ // 10/2D
"Quartz likes the way you handled yourself and makes you an offer. He has a nasty job to do tonight and needs a bodyguard. You may keep any loot you may find and Quartz will pay you 200 gold coins when you get back.\n" \
"  If you decline his offer, close the book. If you accept the job, go to {147}."
},
{ // 11/2E
"You are in the middle of a long dark east-west tunnel. Roll for a wandering monster. To the north is a stairway which leads up. At the west and east ends of the tunnel are doorways. If you want to go up the stairs, go to {64}. If you want to enter the west door, go to {112}. If you want to enter the east door, go to {164}."
},
{ // 12/2F
"You have walked into a room that is lit by a glowing pattern on the floor. A green frog rests in the centre of the pattern. There is no one else in the room, and there is only one door in the west wall.\n" \
"  Quartz says the room reeks of magic. If you walk the pattern to the centre, go to {49}. If you leave the room the way you came, go to {77}."
},
{ // 13/2G
"Gina daintily places two fingers in her mouth and lets out an ear-piercing whistle. A gnome crawls out from under the desk, yawning and rubbing his eyes. She introduces him as Snavely the Gnome, and tells him to serve refreshments to Quartz. She then turns, winks at you, and leads you to the study door. She waves you ahead, so you open the door...(Go to {87}.)"
},
{ // 14/2H
"The Priests take one look at you and run screaming out the east door. Quartz is impressed by the way you handled them; however, you can't go around looking like that or you will scare off the dwarf. Quartz picks up the bucket of water and empties it on you. With a crackle and pop, you lose your invisibility. Quartz looks you over and tells you he liked you better when he couldn't see most of you. Go to {30}."
},
{ // 15/2K
"If you carefully placed the sword canes and bumbershoots against the wall, go to {166}. If you tossed them onto the floor, go to {139}. If you aren't sure what you did with them, go to {79}."
},
{ // 16/2L
"The dwarf waves goodbye and floats down the canal. Behind you is a tunnel with stairs leading up to a small door to the west. Quartz motions you forward and you climb the stairs and open the door. Go to {164}."
},
{ // 17/2M
"Each gets 4 dice plus 30 adds in combat, and has a CON of 20. If you kill all of them, take 150 experience points and continue your journey."
},
{ // 18/3A
"You can feel all your weapons, armour, clothes, and supplies melting away. If you duck under the floor and search for your equipment, go to {47}. If you forge ahead to the door, go to {76}."
},
{ // 19/3B
"You are at the top of a stairway that winds clockwise down and around a dark pit. To the north is a door. If you want to try the door, go to {46}. If you want to go down the stairs, go to {127}."
},
{ // 20/3C
"The rug won't say another word. Quartz thinks you scared it. If you continue across the rug to the door, go to {108}. If you do as the rug requested, go to {143}."
},
{ // 21/3D
"You are in a small, dimly-lit cave. There are doors to the east, west, and south. Mushrooms of various sizes are growing all over the floor. The mushrooms give off a green glow.\n" \
"  Quartz sniffs the mushrooms, and tells you the little ones are edible but he's not sure of the large green spotted ones. If you leave the way you entered, or go across the cave to another door, go to {37}.\n" \
"  However, you may also pick some mushrooms; write down how many and what kind. If you picked some small mushrooms, go to {173}. If you picked some big mushrooms, go to {93}. If you picked both kinds, go to {158}."
},
{ // 22/3E
"You find yourself in a small storeroom filled with food, torches, and an extra set of robes for the Priests. There is nothing of value here. Leave by the east door and return to the temple by going to {38}."
},
{ // 23/3F
"The dwarves are impressed by your tattoo. They want to keep you for good luck - after all, you're a colourful character! Whether you want it or not, they give you a free ride to their next port of call, leaving Quartz and his friend behind. You have earned 2000 adventure points; take any treasure you have won to the City of Terrors. Close the book.\n" \
"  If you don't have a copy of City of Terrors, the dwarves will drop you off at the port of your choice. You have earned 2000 adventure points and are free to adventure as you please. Close the book."
},
{ // 24/3G
"The wizard snaps his fingers and you pop out of the floor. However, you are stark naked - your armour, clothes, and equipment are still in the floor[ (though you still have the weapon you held over your head)].\n" \
"  The wizard looks at you with a puzzled expression. You are not the sorcerer he came to visit! Then his face brightens; he clears his throat and says he accepts your surrender. He tells you to put on the chains on the table.\n" \
"  If you put on the silver chains, go to {104}. If you ask the rummy old wizard if he has lost his mind, go to {34}. If you want to run the wizard through with your weapon, go to {56}."
},
{ // 25/3H
"Any loose jewels you carry [(other than pearls) ]have disappeared. Go to {116}."
},
{ // 26/3K
"[Once you kill the vampires, you must use wooden stakes on them, or they will return to life. Hack off the wooden shafts from your arrows, or chop off the handles of your weapons or shields for wood. If you can make wooden stakes, finish off the vampires and continue your journey. If you have no wood, ]go to {75}."
},
{ // 27/4A
"The barman comes over to your table. He shakes his head. \"That's Quartz,\" he says, pointing to the rock demon. \"He's the manager of this tavern.\"\n" \
"  You help the manager to his feet, and tell him you are looking for a job. Quartz isn't very impressed with you, and Butterfly-Dances-In-The-Morning-Dew lurches over to your table with a worried expression on his face. Quartz waves him away, telling the troll he did the right thing - he would have killed the dwarf when he lost his temper.\n" \
"  Quartz tells you to sit tight, and bounds over to the dwarf. He helps him up, dusting bits of broken mug from his head. After a short whispered conversation, Quartz hands the dwarf a leather purse. The dwarf hides the leather purse somewhere within his clothing, hands Quartz a horn, and weaves out of the tavern while muttering to himself about crazy rock demons. Quartz grabs a new mug of beer and returns to your table. He settles himself down and sips his beer.\n" \
"  Suddenly the tavern door bursts open, and in stalk two Red Robed Priests. A deathly silence descends on the room. The Priests look around, and then one points with his rune staff in your direction and says \"There is the little toad - and a stranger is with him!\"\n" \
"  Butterfly-Dances-In-The-Morning-Dew hurls a stool - it catches one of the Priests in the back of the head and then slams into the second priest, sending both to the floor. One Red Priest is sprawled on the floor with his neck broken, but the other picks himself up and heads for your table.\n" \
"  Quartz waves back the troll and barman, turns to you, and coolly says, \"Kill him!\" The Priest is armed with a pulsing rune death-staff that gets 4 dice + 22 adds in combat. He has no armour and has a CON of 10 (he was hurt by the fall). You must fight to the death. If you die, close the book. If you win, take 50 adventure points and go to {162}."
},
{ // 28/4B
"Make two L1-SRs (one on Luck (20 - LK) and one on Intelligence (20 - IQ)) to see if you are smart enough to look for a trap, and lucky enough to find it. If you miss one or both rolls, go to {81}. If you make both rolls, go to {153}."
},
{ // 29/4C
"You are on the north side of a torchlit room. A door is set in the south wall. Within this room are tables and shelves, all littered with strange-shaped bottles and flasks, rune-covered boxes and iron-bound chests. By the east wall is a desk cluttered with scrolls and bound books of all sizes. On top of the desk is propped a sign which reads, \"Out to Lunch\".\n" \
"  Quartz sniffs the air and looks the room over. \"This is a wizard's den,\" he says, \"and from the smell of it, the wizard must be at least 21st level. Let's get out of here!\"\n" \
"  If you leave through the north door, go to {148}. If you examine one of the boxes on the shelves to your right, go to {109}. If you stride across the room to the south door, go to {59}. If you carefully tip-toe around the edge of the room to the south door, go to {70}."
},
{ // 30/5A
"You walk over to the mirror. It asks for your name and the name of your pet rock. Quartz begins to growl. The mirror is worth 500 gp and weighs the same. (Talking mirrors are cheap, as wizards tend to become disgusted with them after they make them.)\n" \
"  The mirror tells you that if you finish polishing it, it will tell you where the doors lead to. Quartz stops growling, grabs a rag, and starts to polish. The mirror gives a sigh and tells Quartz to polish a little more to the right side. Magic mirrors love to be polished.\n" \
"  The mirror thanks Quartz and tells you that the door to the north leads to the Blue Frog Tavern; the door to the west leads to death; and the door to the east goes elsewhere. Quartz says you can have the mirror, if you want to lug it around yourself. Go to {77}."
},
{ // 31/5B
"\"Not bad!\" calls a voice from behind you. You turn from your dead foes and see the rock demon standing upon the path. His eyes are bright and he is carrying a 6' sword. \"I came looking for the person that hit me...\" he says. This sounds ominous.\n" \
"  If you'd like to run away, go to {140}. If you stand and talk, go to {55}. If you attack the rock demon, go to {69}."
},
{ // 32/5C
"The dead warrior vanishes in a poof of gold dust. Take 20 adventure points for defeating him. If you decide to help yourself to the gold, plunge your greedy fists into the heap and go to {50}. If you're not sure what will happen next and would rather leave while you still can, go to {160}."
},
{ // 33/5D
"You are in a short dark tunnel. There is a door at the west end, and a door at the east end. Roll for a wandering monster.\n" \
"  To enter the west door, go to {152}. To enter the east door, go to {129}."
},
{ // 34/5E
"The wizard slams his fist down on the table and roars with laughter. The humour of the situation escapes you, but you laugh politely and hope he'll explain the joke. Make a first level saving roll on your Charisma (20 - CHR). If you are successful, go to {115}. If you miss the roll, go to {78}."
},
{ // 35/5F
"The keg is empty and Quartz is furious. He flies into a rage. You obviously didn't have time to drink all the beer - so he attacks the obvious culprits, the other occupants of the room. [Quartz now gets an additional 10 points added to his die roll each combat round. ]Go to {3}."
},
{ // 36/5G
"You are chained and taken to the pits in the Arena of Khazan. [To regain your freedom, you must fight six combats. ]You fight as a slave. Close the book.\n" \
"  If you don't have a copy of Arena of Khazan, you toil as a slave for a year before you finally escape - without your possessions (including any swords you may have which come to you when you call them). Close the book."
},
{ // 37/5H
"Make a first level saving roll on Luck (20 - LK). If you fail the roll, go to {138}. If the roll is successful, go to {71}."
},
{ // 38/6A
"Quartz tells you to hurry. The dragon is starting to wake up, and the whistle won't work a second time. Quartz hustles you towards the north door in the temple; leave quickly and go to {154}."
},
{ // 39/6B
"You are in a short, dark tunnel. Roll for a wandering monster. If you want to try the door to the north, go to {163}. If you want to try the south door, go to {102}."
},
{ // 40/6C
"You have earned experience points equal to the total MR you fought. If the bumbershoots have aroused your curiosity and you'd like to open one, go to {117}. If you would rather leave them alone and go to the other door, go to {92}."
},
{ // 41/6D
"The troll looks at you with a bewildered expression on his face. The barman laughs uproariously; when he calms down he tells you the rock demon is the manager of the tavern. With a sinking feeling in your heart, you help the manager to his feet and tell him you are looking for a job.\n" \
"  \"My name's Quartz,\" the manager says. \"I like the way you handled yourself!\" He makes you an offer: he has a nasty job to do tonight and he needs a bodyguard. You can keep any loot you find, and he'll pay you 200 gold coins when you return. If you decline, Quartz decides you're a lily-livered coward and a backstabber to boot, and tosses you out the door. Close the book. If you accept his offer, go to {111}."
},
{ // 42/6E
"In the white pouch are 50 pearls, each worth 100 gp. Return to {112}."
},
{ // 43/6F
"You are at the east end of a dark east-west tunnel. In the north wall is the entrance to a steep stairway that leads upward. If you want to climb the stairs, go to {113}. If you want to go west, go to {130}."
},
{ // 44/6G
"You're still thirsty as you leave the tavern, and you get even thirstier in the hot afternoon sun. After trudging about 330' on the dusty path to the next city, you hear a stream trickling along the side of the road. You leave the road and crouch among the bushes to drink. Cupping your hands, you dip them into the cool stream, and stop suddenly. You hear voices - someone is approaching!\n" \
"  Two Red Robed Priests are walking down the road towards the Blue Frog Tavern. One turns to the other and says \"Once inside we'll wait for the rock toad. When he enters his room, zap!\" He punctuates his last remark by thrusting his rune staff into the air. It crackles with energy.\n" \
"  If you choose to ignore them and leave, go to {140}. If you want to attack them right now, go to {90}. If you would rather be cautious and follow them, go to {72}."
},
{ // 45/6H
"You walk across the sand to the bridge, cross over the canal, and walk to the pier. Go to {149}."
},
{ // 46/6K
"You are in a short dark north-south tunnel. Roll for a wandering monster. If you want to enter the doorway in the north wall, go to {99}. If you want to enter the doorway in the south wall, go to {19}."
},
{ // 47/6L
"When you duck under, you can see nothing but grey. You smell a strange sweet odour, and pass out.\n" \
"  When you wake up, you find that you have been enslaved in the pits of the Arena of Khazan[, sentenced to fight 3 combats to regain your freedom]. This character may not enter this adventure again.\n" \
"  If you don't have a copy of Arena of Khazan, the grey stuff fills your lungs. You never regain consciousness."
},
{ // 48/7A
"The rock demon surveys the ruins of his room. \"Damn, they are messy,\" he comments, and then pauses for a minute, thinking. \"I'm Quartz,\" he finally says. \"I need a companion with your skills. I'll give you 200 gold pieces and all the loot you can haul if you'll help me tonight.\"\n" \
"  If you decline his offer, leave the tavern and go to {140}. If you decide to join him, follow him to {147}."
},
{ // 49/7B
"Roll two dice and go to the first paragraph on that page in the solitaire dungeon Deathtrap Equalizer. This is where you have been teleported. This character may not enter this dungeon again.\n" \
"  If you don't own a copy of Deathtrap Equalizer, the teleport mechanism has malfunctioned. Go back to {77} and return the way you came."
},
{ // 50/7C
"The coins on the top of the pile cascade away, and the gnome peeks his head out. He is very angry, and demands that you give him all the gold you carry. Of course, he has no way to enforce his demands, so give him as much as you want. Quartz is disgusted by the entire affair and won't let you attack the gnome again, and insists that you get a move on. He's the boss, so go to {160}."
},
{ // 51/7D
"The troll has a Constitution of 60. He gets 7 dice plus 50 adds as his attack. If you kill him and live, take 45 experience points. To leave, climb the stairs (go to {152}) or go through the south door (go to {116})."
},
{ // 52/7E
"As you reach the centre of the room, you hear faint whispers coming from the rug. If you ignore the whispers and continue across the rug to the door, go to {108}. If you quickly jump off the rug, go to {129}. If you stop and bend down to hear the whispering better, go to {97}."
},
{ // 53/7F
"You are in a dark L-shaped tunnel. Roll for a wandering monster. There are doors to the north and east. To go through the north door, go to {112}. To go through the east door, go to {21}."
},
{ // 54/7G
"The target shield will take 5 hits each combat round. It will attract any missiles fired at you, causing them to fall harmlessly to the ground when they reach you. However, if the shield attracts a missile akin to a two-ton rock fired from a catapult, you would almost certainly be crushed to jelly by the impact damage (although the shield would not be harmed). You may sling this shield on your back, if you wish. Remember, however, that an arrow will take the shortest possible route to reach the shield - if the shield is on your back, this could very well mean the arrow would travel through your body to reach it.\n" \
"  Now go to {159}."
},
{ // 55/7H
"\"I couldn't believe that you had knocked me out,\" the rock demon says as he leads you back to the Blue Frog. \"I'm Quartz, the tavern manager, and I could use someone like you. You aren't going to be too popular with the Red Robed Priests, and I've got a little job that will bedevil them. If you want in, you'll get 200 gold pieces and all the loot you can carry.\"\n" \
"  If you decline his offer, go to {140} and leave. If you take him up on it, go to {147}."
},
{ // 56/7K
"You must be the one who has lost his mind. You have been turned into a 2\" turtle. Close the book, for it will take years to crawl out of here."
},
// 7L is omitted from the Corgi edition!
{ // 57/8A
"You have passed through the magic red door. If you are carrying any gold coins, go to {82}. If you have no gold, go to {100}."
},
{ // 58/8B
"If your quest is over (you should have the Blue Frog Amulet), open the door and go to {124}. If your quest is not over, why are you trying the door? Take one point off your Intelligence. Quartz is mad at you for wasting time. Go back to {96}."
},
{ // 59/8C
"As you start to walk across the room, you have the strange feeling that you are shrinking. You look down at the floor - and your feet have disappeared! When you look at Quartz, you see that he's standing on the floor, happy as a clam - he didn't sink into the floor one inch! If you came in through the north door and wish to return to it, go back to {29}. If you came in through the south door and wish to return to it, go back to {99}. If you would rather continue across the room to the opposite door, go to {121}."
},
{ // 60/8D
#ifdef CENSORED
"If you are wearing black leather armour, go to {120}. Otherwise, you must go to {165}."
#else
"If you are wearing black leather armour and boots with silver spurs, go to {120}. Otherwise, you must go to {165}."
#endif
},
{ // 61/8E
"If you leave by the west door, go to {11}. To leave by the south door, go to {119}."
},
{ // 62/8F
"There is an eyehole in the centre of this door. You peek into it and see piles of gold and jewels, and stacks of glowing magic arms and armour. However, Quartz says he won't go into the room. He has what he came for, and wants to go back to the pier before the dragon wakes up. If you want to enter the room, go to {161}. If you would rather leave the treasure alone, go back to {107}."
},
{ // 63/8G
"There is nothing under the rug. Quartz tells you to stop fussing with the rug because it's getting late. Go back to {129}."
},
{ // 64/9A
"You are at the top of a stairway in a north-south tunnel. Also at the top of the stairway is a door to the north; at the bottom is a tunnel running east-west. To go through the north door, go to {129}. To go to the bottom of the stairs, go to {11}."
},
{ // 65/9B
"You are in a short dark east-west tunnel. Roll for a wandering monster. At the east end there is a door in the-north wall of the hallway. Opposite this door, in the south wall of the corridor, is a steep stairway which leads downward.\n" \
"  If you want to go west, go to {163}. If you want to try the door, go to {122}. If you want to go down the stairs, go to {43}."
},
{ // 66/9C
"In the green pouch are 20 emeralds, each worth 400 gp. Return to {112}."
},
{ // 67/9D
"You land with a thud on something soft at the bottom of the dark pit and, out of breath, you lay there for a moment. Finally you can see Quartz, torch in hand, hurrying down the stairs toward you.\n" \
"  Quartz helps you up and offers you a drink from his wineskin. You landed on a troll, and now he's out cold! Quartz picks the troll's head up, sniffs him, and lets his head fall back to the floor with a thump. \"Dumb troll reeks of wine. You're lucky he passed out on the floor, nice and soft, too much fat!\"\n" \
"  As Quartz frisks the troll, you look around. To the west is an alcove, and to the south is an iron-bound door. Quartz wanders over to the alcove and shouts with joy - he's found a pile of wineskins. Decide which direction you want to go, and pull Quartz away from the wineskins. You may leave by climbing the stairs (go to {152}) or by going through the south door (go to {116})."
},
{ // 68/9E
"Quartz looks at you and shakes his head. It's late and you'll have to be going. The gnome wishes you luck as he crawls back under the desk to continue his nap. If you were going south, go to {99}. If you were going north, go to {29}."
},
{ // 69/9F
"With one hand upon the sword the rock demon parries your attack. His other hand smashes into your stomach. You collapse, but before you black out you hear him say in disgust, \"I told that bartender it was a lucky shot.\" Go to {140}."
},
{ // 70/9G
"Quartz thinks you're too cautious. He strolls across the centre of the room and waits for you by the opposite door. \"See?\" he says, and gestures impatiently. As you reach the centre of the west wall, the floor goes soft and you sink into the floor up to your chin. If you kept your weapon above your head, go to {136}. If your weapons are ready but under the floor, go to {18}."
},
{ // 71/9H
"You may now leave the mushroom cave. If you were going east, go to {119}. If you were headed west, go to {53}. If you were going south, go to {83}."
},
{ // 72/9K
"As the Red Robed Priests enter the area in front of the tavern, each mutters a spell. Both fly up one floor and enter an open window. From the window's position, you figure that they went into the room at the head of the stairs. The tavern settles into an unnatural and ominous silence.\n" \
"  If you would like to burst into the tavern, race up the stairs, and confront the priests, go to {135}. If you would rather enlist the aid of those inside the tavern to destroy the priests, go to {105}."
},
{ // 73/9L
"The barge pulls away from the pier and enters another dark tunnel. It seems to run straight north, and after a few minutes you come to a second torchlit pier on the left side of the canal. The barge stops at the pier, and the dwarf asks you to get off.\n" \
"  Quartz lifts his wineskin to his mouth, then turns slightly green and hastily lowers it. He would really like to disembark, as he is getting seasick. If you get off, go to {174}. If you would like to stay on, go to {114}."
},
{ // 74/10A
"If you used your hand, go to {63}. If you used something else, go to {170}."
},
{ // 75/10B
"While you were standing there with your thumb in your ear, Quartz took care of one of the vampires with a wooden stake he carved off the dungeon door (he's not as dumb as he looks). The remaining vampire comes to life and is enraged by the death of its mate. It now gets 6 dice plus 60 adds in combat. If you kill the last vampire, Quartz hacks another stake from the door and finishes it off. You may now continue your journey."
},
{ // 76/10C
"As you walk to the door, you emerge from the floor. Quartz is shaking his head - you have lost everything you carried! Quartz picks up a brass candlestick, gives it a few test swings, and hands it to you. The candlestick will make a serviceable bludgeon (2 dice). You have gained 30 experience points, but now you must continue. If you were headed north, go to {148}. If you were going south, go to {46}."
},
{ // 77/10D
"If you leave by the north door, go to {83}. If you use the west door, go to {167}. If you go to the east door, go to {12}. If you use the south door, go to {110}. If you have tried the south door before, go to {137}."
},
{ // 78/10E
"The wizard is only mildly offended, and only places a small curse on you. From now on, your eyes will glow a fiery red in the dark. (Your ability to hide in the dark and your love life are about to hit an all-time low.) The wizard throws you an old cape and orders you and Quartz to leave. Take 150 adventure points for this experience. If you are going north, go to {148}. If you're headed south, go to {46}."
},
{ // 79/10F
"Roll one die. If you rolled a 1, you were careful with the canes; go to {166}. If you rolled 2-6, you were careless; go to {139}."
},
{ // 80/10G
"You hear screams and thuds as bodies hit the wall. A sudden silence is broken by the sound of the dragon crunching bones. Behind you, Quartz whispers, \"Blow the silver whistle.\"\n" \
"  You fumble for the whistle, blow a high note, and the dragon begins to snore. Quartz enters the room and tells you to open your eyes and get off the floor. \"You look silly,\" he snorts. You look around the torchlit temple and see the broken bodies of Red Robed Priests scattered everywhere. The dragon sleeps peacefully in the centre of the temple. There are doors to the east and west, and a double door to the south. Beside the dragon is a blood spattered altar; on the floor is the magic Blue Frog Amulet, a small frog-shaped container that has been tightly corked.\n" \
"  Quartz shouts with joy and grabs the amulet. The dwarf opens the west door and hauls out a double armload of gold. If you wish, go to the west door and get as much gold as you can carry. To leave by the north door, go to {154}. To try the east door, go to {22}. To try the south door, go to {107}."
},
{ // 81/10H
"Roll one die. If you roll 1-3, take one point off your Charisma. If you roll 4-6, take two points off your Charisma. You have acquired an unpleasant odour of fermented mushrooms which will last for one year. Quartz sniggers at you. Go to {153}."
},
{ // 82/10K
"As you pass the door, you are transformed into a stack of gold coins. A magic wind blows you back into the room, where the mad gnome sweeps you up into his pile. Quartz was not dumb enough to carry any gold, so he escaped the curse. Close the book, for you are dead."
},
{ // 83/11A
"You are in a short dark tunnel that slopes downward to the south. At the bottom of the tunnel is a door leading north. To open the north door, go to {21}. To open the south door, go to {156}."
},
{ // 84/11B
"There is one drink left in the keg. Quartz will drain the keg, missing one combat round. Go to {3}."
},
{ // 85/11C
"The wizard tenders cool thanks, and tosses you a leather sack. He snaps his fingers, and he and the rug disappear in a flash of blue light.\n" \
"  Roll one die to see how many jewels the bag contains; roll on the jewel generation table in the T&T Rulebook for the kind of stones, base value, and size (no magic gems - roll again). Quartz is underwhelmed by the wizard's generosity. Go to {108}."
},
{ // 86/11D
"The slain warrior disappears in a cloud of golden dust. The fight was worth 10 experience points to you. You may help yourself to the gold (go to {150}) or leave. If you leave through the north door, go to {123}. If you leave through the south door, go to {4}. If you leave through the east door, go to {57}."
},
{ // 87/11E
"...and walk into the main room. Quartz looks up from his fourth mug of beer and raises his eyebrows. You feel a bit confused and sit at the desk; Gina closes the door and pours you a mug of ale. You feel weak and dehydrated.\n" \
"  On the desk are your weapons, clothes, and equipment. However, your body armour has been replaced by a silver scale mail shirt. Gina tells you that it's magic (it will take 10 hits each combat round[; warriors can't double it]). It will also become invisible whenever you put it on.\n" \
"  Gina thanks you for the lock of hair, winks at you, and goes back into her study. Quartz finishes off his mug and asks you where you got that neat-looking tattoo. You tell him you have no tattoo, and ask him if he's lost his mind.\n" \
"  Quartz peers behind you and describes the tattoo: hearts and flowers, little cherubs with bows and arrows, and the name \"GINA\" in big red letters. Now you remember that it hurt when you sat down. You put on your new armour anyway.\n" \
"  Quartz gasps and starts to laugh. You look down - and all your clothes and armour are now invisible - however, you are still very much in sight. Quartz chokes, wipes the tears from his eyes, and says that's the best trick he's ever seen. You'll kill any monsters with laughter, especially when you run away and they see your tattoo, he chortles.\n" \
"  Still snickering, Quartz leads you to the door. You gain 1500 experience points, and add 3 points to your Charisma. If you're headed north, go to {148}. If you're going south, go to {46}."
},
{ // 88/11F
"The drink restores any hits you took on your Constitution. If you did not take any hits, you may add one point to your basic CON. Unfortunately, that was the last flask Quartz had. Go to {10}."
},
{ // 89/11G
"You are in a dark room with a door to the north and a round lid in the centre of the floor. If you want to leave by the north door, go to {39}. If you want to leave by the hole in the centre of the floor, you will need a rope that is at least 20' long. If you have such a rope, use it and go to {130}."
},
{ // 90/12A
"You rush from the bushes - your first shot kills one of the Red Robed Priests outright. The second Priest wheels, thrust his rune staff towards you, and snarls, \"Die, unbeliever!\"\n" \
"  He has a CON of 10, and gets 4 dice plus 11 adds in combat. He wears no armour. You must fight to the death; the fanatic light in his eyes tells you he will stop at nothing short of spilling your lifeblood.\n" \
"  If you defeat him, go to {31}."
},
{ // 91/12B
"If this character is male, go to {118}. If this character is female, go to {134}. If you have been to this paragraph before, the mage scolds you for repeating yourself, and makes a magical gesture. You and Quartz are teleported to 46. Don't come back here again!"
},
{ // 92/12C
"If you want to cross the floor inside the elephant's foot, go to {166}. If you want to walk across the centre of the room, go to {5}. If you would rather walk carefully around the edge of the room to reach the opposite door, go to {70}."
},
{ // 93/12D
"As you pick your last mushroom, you turn into a 10# blue frog. With a look of disgust, Quartz picks you up and takes you back to the tavern.\n" \
"  Roll one die. You must wait that many years before Quartz finds a wizard who will change you back. Until then, you serve as a sort of tavern mascot; on slow days, Quartz threatens to let the bouncer play frog ball with you. You have lost any gold and treasure you had, and this character cannot enter this adventure again. Close the book."
},
{ // 94/12E
"The moment you touch your weapons, the dwarves mob you. There are too many of them - you never had a chance. If this character is male, go to {141}. If this character is female, go to {60}."
},
{ // 95/12F
"The demon shield is a Shield Leech; the moment you place it on your arm, it attaches itself firmly and begins to drain your life force. Take one point off your CON each turn you wear it.\n" \
"  The only way to remove the leech is by fire; Quartz holds his torch under it. Roll one die: 1-2, the leech falls off your arm; 3-6, no effect. Each time you roll, take one point off your CON. If you are still alive, go to {159}."
},
{ // 96/12G
"You are on a dark stairway. If you want to open the south door at the bottom, go to {163}. If you want to open the north door at the top, go to {58}."
},
{ // 97/12H
"In a tiny voice the rug screams, \"Get off my head, you fool, or you'll be turned into a frog!\"\n" \
"  You move your feet back, and Quartz peers down at the centre of the rug. Quartz tells the rug not to be silly - rugs don't have heads - and to be polite or he'll turn a moth loose on it.\n" \
"  The pattern on the rug seems to quiver. Then, in a more polite voice, it asks you to please hold it up and give it a shake. If you ignore the rug and go to the door, go to {108}. If you do as the rug requests, go to {143}. If you wave your weapon and ask the rug to explain itself, go to {20}."
},
{ // 98/12K
"Halfway down the beach you slip into quicksand. Make a L1-SR on LK (20 - LK), and another on DEX (20 - DEX), to see of you can throw Quartz something to drag you out with: a rope, a spear, or a belt. If you fail either or both rolls, close the book. If both rolls are successful, you escape from the quicksand. You'll have to try the counter-clockwise route; go to {45}."
},
{ // 99/12L
"You are on the south side of the wizard's torchlit den. If you want to cross the room to the door on the north wall, go to {59}. If you want to peek inside a green rune-covered box on a shelf near the south wall, go to {146}. If you want to leave by the south door, go to {46}. If you walk carefully around the edge of the room to the north door, go to {70}."
},
{ // 100/13A
"Any loose jewels you carry [(other than rubies) ]have vanished. Go to {11}."
},
{ // 101/13B
"If Quartz was right behind you, he grabbed you; continue onward. If you were climbing the stairs, go to {19}. If you were going down the stairs, go to {152}. If you aren't sure if Quartz was behind you, roll one die. If you rolled 1, Quartz was indeed close behind and you are safe. If you rolled anything else, go to {67}."
},
{ // 102/13C
"You are in a dark room with a door to the north. In the centre of the room is a giant 30' long king cobra. If you have been in this room before and killed the cobra, go to {89}.\n" \
"  If the cobra is not dead, you must fight it. The cobra gets no dice or adds; instead, it fights by a special set of rules. Every round you fight the cobra, roll two dice. If you roll a 2, the cobra bit you and a burning poison races through your body, killing you. On a roll of 12, your weapon breaks. On a roll of 3 or 11 your weapon is torn from your grasp, and you lose it unless you can kill the cobra. (Roll anything else and you attack normally.) Poison has no effect on a rock demon; the cobra knows this so he will strike only at you. The cobra has a CON of 60 and is immune to poison; its natural armour of scales provides 40 hits of armour. Roll up whatever damage you and Quartz do, and apply the total directly to the snake's armour (and, possibly, CON). Remember to roll the cobra's two dice each round, to see if anything happens to you.\n" \
"  Any time you want to give up the fight and run for the door you may do so, but the cobra will get one free strike on you (roll the dice to determine the effects). If you successfully flee the room, go to {39}. If you kill the snake, go to {8}."
},
{ // 103/13D
"Quartz takes a drink from his wineskin and then sniffs the corpse. He warns you that the arms and armour are cursed. There is a long thin shallow case along the west wall; if you open the chest, go to {28}. If you want to leave the chest alone and exit the room, return to {163}."
},
{ // 104/13E
"Quartz flips out. He pleads with the wizard to set you free. The wizard is a bit confused, and tells Quartz that as soon as you serve your time, you will be freed.\n" \
"  Roll one die for the number of years you must serve the old wizard. At the end of your service, the wizard will return your weapons and armour, plus 200 gp for each year spent in his service. This character may never adventure here again."
},
{ // 105/13F
"The barman begins to protest your reentry into the Blue Frog, but you wave him off. The rock demon glares in your direction - but his expression swiftly changes as you stammer an explanation. \"My sword,\" the demon calls to the barman, who brings a 6' sword from beneath the bar and hands it to him.\n" \
"  The demon looks at Butterfly-Dances-In-The-Morning-Dew and points at you. \"Fastball Express 'em!\" Before you can protest the troll picks you up, carries you outside and throws you up through the window that the Red Robed Priests had entered.\n" \
"  As you fly through the room you see the door fly off its hinges. The rock demon dodges to the left and cleaves through one priest with his sword. You hit a wall and land upon the bed, bounce to your feet and face an enraged Red Robed Priest. He has a CON of 10 and gets 4 dice plus 11 adds in combat; he wears no armour. If you kill him, go to {48}."
},
{ // 106/13G
"You and Quartz settle on the bow of the barge. The dwarf shoves off, merrily humming to himself. Quartz leans over and whispers, \"Don't take any refreshments from the dwarf.\"\n" \
"  The barge enters the tunnel, and the only light is from the barge lamps. The moss-covered walls slip by faster than you could walk. The canal bends to the left; after a few minutes, it reaches a torchlit pier on the left side of the canal. The dwarf brings the barge to the pier and good-naturedly asks if this is close enough.\n" \
"  Quartz shrugs and looks at you. If you want to get off, go to {16}. If you want to stay on, go to {73}."
},
{ // 107/14A
"You are in the middle of a torchlit east-west tunnel. To the north is a double door; there are doors at the west and east ends of the tunnel. To go through the west door, go to {62}. To go through the east door, go to {128}. If you want to return to the temple, go to {38}."
},
{ // 108/14B
"If you went through the west door, go to {33}. If you went through the south door, go to {64}."
},
{ // 109/14C
"Why are you poking around in the belongings of a twenty-first level wizard? You must have either an overly inquisitive mind or a death wish. You are zapped by a protection spell. Take one point off your Intelligence, and go back to {29}."
},
{ // 110/14D
"You find yourself in the middle of a long torchlit east-west tunnel. A 20' wide canal runs down the centre of the tunnel. Directly across the canal from where you stand is a short pier; at the end of the pier is a stairway which leads up into another tunnel. A door behind you leads northward.\n" \
"  You are standing on a 5' sandy ledge which runs parallel to the canal. At the west end of the tunnel is a 20' high stone bridge over the canal entrance; an identical bridge at the east end rises over the canal exit. The far bank is a sandy ledge which runs to the pier.\n" \
"  Quartz tells you that he expects to meet the dwarf on the pier. To go east, go to {98}; west, go to {45}. If you can fly across the water, go to {149}."
},
{ // 111/14E
"The bouncer lurches over to your table with a worried expression on his face. Quartz waves him away and tells the troll he did the right thing - otherwise he would have killed the dwarf when he lost his temper.\n" \
"  Quartz tells you to stay put, then bounds over to the dwarf and helps him up, dusting bits of broken mug from his head. After a short whispered conversation, Quartz gives the dwarf a leather purse. The dwarf clutches the purse, hands Quartz a horn, and weaves out the tavern muttering to himself about crazy rock demons. Go to {147}."
},
{ // 112/14F
"You are in a torchlit room. A white door is set into the north wall, a green door in the south wall, and a red door in the east wall. Carved on the wall around each door is a grotesque face. The doors look as though they are part of the mouths.\n" \
"  In the centre of the room is a 4' high pile of gold; on top of the pile, fondling the gold, squats a mad gnome. The gnome will let you pass safely if you give him all your gold. However, the gnome doesn't look very dangerous, so keep any gold you have or give it all or part of it to the gnome.\n" \
"  In addition, if you have any food with you, the gnome will trade you a coloured pouch (red, white, or green) for all your food. If you trade for the red pouch, go to {9}. If you take the green pouch, go to {66}. If you take the white pouch, go to {42}.\n" \
"  If you want to fight the gnome, go to {145}. Quartz is terrified of him and wants to leave quickly. If you listen to Quartz and leave through one of the doors, go to {160}."
},
{ // 113/15A
#ifdef CORGI
"As you ascend the stairs, they look endless. It seems as if you'll never get to the top. Quartz tells you to halt, and you turn and look down. You are only one third of the way up.\n" \
"  Quartz is worried. Something is wrong with the stairs, you have been on them too long. He wipes the sweat from his brow, looks at you and turns down the stairs. You follow and in a few moments you are at the bottom. Quartz tells you to stand aside and watch. He makes a run at the stairs. When he gets one third of the way up, the stairs flow under his feet and he gets no further. You tell him to stop. He turns, dazed, and quickly walks down. The stairs were enchanted and will only allow you to walk down. Go to {43}."
#else
"As you ascend the stairs, they look endless. It seems as if you'll never get to the top. Quartz tells you to halt, and you turn and look down. You are only one third of the way up.\n" \
"  Quartz is worried. Something is wrong with the stairs, you have been on them too long. He wipes the sweat from his brow, looks at you and turns down the stairs. You follow and in a few moments you are at the bottom. Quartz tells you to stand aside and watch. He makes a run at the stairs. When he gets one third of the way up, the stairs flow under his feet and he gets no further. You tell him to stop. He turns, dazed, and quickly walks down. The stairs are enchanted and will only allow you to walk down. Go to {43}."
#endif
},
{ // 114/15B
"The barge pulls away from the pier and enters another dark tunnel. The dwarf groans as a black war barge slips out of a side tunnel and cuts you off. Boarding planks slam down and a press gang of twenty dwarves come aboard.\n" \
"  The marine captain asks to see all your papers. Everyone's papers are in order - except yours. Quartz tries to slip the captain a bribe, but he knocks it to the deck. You are surrounded by armoured dwarves with weapons at ready. They want you. If you surrender, go to {36}. If you fight, go to {94}."
},
{ // 115/15C
"The wizard likes your spunk. He offers you a magic scale mail shirt to replace your lost armour. It will take 10 hits each combat round[ (warriors cannot double this)]. He also brings out a new set of clothes and supplies, and offers both you and Quartz a mug of ale apiece.\n" \
"  You may not trust the old wizard, but Quartz downs the ale, wipes the foam off his nose, belches, and scratches his tummy. (He is being very polite today.) You thank the old wizard, grab Quartz, and head for the door. Take 80 experience points for this encounter.\n" \
"  If you were going north, go to {148}. If you were headed south, go to {46}."
},
{ // 116/15D
"You are in a short dark north-south tunnel. An iron-bound door is set into the wall at the north end; a standard door is set into the wall at the south end. Roll for a wandering monster.\n" \
"  To try the north door, go to {144}. To try the south door, go to {112}."
},
{ // 117/15E
"As you open the bumbershoot, a blue flame runs up your arm and over your body. You feel very unlucky, for you have lost half of your Luck points (round down). The bumbershoot is worth 10 gp. It is also bad luck to open one indoors. Go to {92}."
},
{ // 118/16A
#ifdef CENSORED
"The wizard is a very good-looking woman with red hair. She says hello and introduces herself: her name is Gina.\n" \
"  She steps back and snaps her fingers; you pop out of the floor without the armour, clothes, and supplies you might have worn. Gina walks around you and shakes her head.\n" \
"  She asks if you would like to put your weapons down and go into her private study for a small glass of wine. If you accept, go to {13}. If you thank her but say you must leave with Quartz, go to {78}."
#else
"The wizard is a very good-looking woman with red hair. She says hello and introduces herself; her name is Gina. As your head is at floor level and she is standing on the floor over you, her robes are not quite long enough, and you can't help noticing that she has great legs.\n" \
"  Unfortunately, Gina caught you peeking. She steps back and snaps her fingers; you pop out of the floor without the armour, clothes, and supplies you might have worn. Gina walks around you and shakes her head.\n" \
"  She asks if you would like to put your weapons down and go into her private study for a small glass of wine. If you accept, go to {13}. If you thank her but say you must leave with Quartz, go to {78}."
#endif
},
{ // 119/16B
"You are in a dark L-shaped tunnel. Roll for a wandering monster. There are doors to the north and west. To enter the north door, go to {164}. To enter the west door, go to {21}."
},
{ // 120/16C
"The dwarves are impressed; you must be Zandar's new lady friend. They insist on escorting you to their next port of call, leaving Quartz and his friend behind. You have earned 2000 experience points; take any treasure you have won to the City of Terrors. Close the book.\n" \
"  If you don't have a copy of City of Terrors, you can put into port at the city of your choice. You are then free to adventure as you please. Close the book."
},
{ // 121/16D
"You take one more step into the floor, and Quartz tells you to stop. He has an idea. He wants you to walk back out of the floor to the door, then take the sword canes and bumbershoots out of the elephant foot, and stand in the empty foot while he pushes you across the floor to the other door!\n" \
"  If you want to try Quartz's idea, go to {155}. If you have second thoughts about messing around with a wizard's bumbershoots, then you'll have to continue into the floor; go to {5}."
},
{ // 122/16E
"You are in a torchlit room with a door on the south wall. Sitting in this room are six small goblins eating their lunch. (If you have been in this room before, you must leave through the south door by going to {65}).\n" \
"  The goblins see you, drop their food, grab their weapons and attack. Each goblin fights with 2 dice and 3 adds in combat, and has a CON of 12.[ You and Quartz may only kill a maximum of two goblins per combat round - any extra hits (overkill) will not affect the remaining goblins.]\n" \
"  If you die, close the book. If you are still alive, take 36 experience points and go to {151}."
},
{ // 123/16F
"You have passed through the magic white door. If you are carrying any gold coins, go to {82}. If you have none, go to {25}."
},
{ // 124/16G
"You are back in the tavern basement, and you have earned 3000 experience points. Quartz pays you the bonus (200 gold pieces), and gives you a horse and pack animal so you can leave the area quickly. Warning you to avoid any Red Robed Priests, he bids you luck. Close the book."
},
{ // 125/16H
"A small gnome scurries out from under the desk, wrings his hands, and apologizes to you.\n" \
"  \"You got caught in the dry-cleaner,\" he explains as he looks you over. He goes back to the desk and returns with a magic sword to match your size. The sword gets 6 dice + 5 in combat, and is worth 500 gold pieces. The gnome apologizes again, but tells you his master just doesn't stock clothes. However, he does have armour that will fit a hobbit.\n" \
"  If you are a hobbit, go to {168}. If you are not a hobbit, go to {68}."
},
{ // 126/16K
"The keg is half full, and Quartz is pleased. He sits down to drain it - instead of helping you fight. Go to {3}."
},
{ // 127/16L
"As you wind around the stairs, you slip and teeter on the edge of the pit. Make a L1-SR on Luck (20 - LK). If you miss, you fall to your death. If you make it, go to {101}."
},
{ // 128/17A
"Quartz puts his ear to the door and swears as he pulls you back to the temple. There are more Priests coming! Go to {38}."
},
{ // 129/17B
"You are in a torchlit room; there is a door to the west and a door to the south. In the centre of the room is a 4'x8' rug; it has a thick pile, and was hand-woven with bright geometric designs. (If you have been inside this room before, the room is bare; go to {108}.)\n" \
"  If you walk around the rug, go to {108}. If you walk over the rug, go to {52}. If you peek under the rug, go to {74}."
},
{ // 130/17C
"You are at the midpoint of a long, dark tunnel running east and west. Roll for a wandering monster. Overhead, the tunnel swells to a dome with a round trapdoor in its centre; the door is 20' from the floor. If you have some way to get to the trapdoor, go to {102}. If you want to go east, go to {43}. If you want to go west, go to {148}."
},
{ // 131/17D
"The barman comes over to your table, shaking his head. \"I guess I forgot to tell you,\" he says. \"That demon you knocked out is the manager of this tavern. You had best leave before he wakes up.\"\n" \
"  Butterfly-Dances-In-The-Morning-Dew has been staring at you, his mouth hanging open. His face turns angry, and he lurches toward you. You hastily leave the tavern; go to {44}."
},
{ // 132/17E
"The Priests see you, and attack! Each Priest is armed with a pulsing rune death staff and gets 4 dice plus 22 adds in combat; each has a CON of 20. You must fight all three Priests at once; you gain 30 experience points for each Priest you kill. If you kill all three Priests, go to {30}."
},
{ // 133/17F
"Any loose jewels you carry [(other than emeralds) ]have disappeared. Go to {53}."
},
{ // 134/17G
"The wizard is a tall, good-looking man with salt-and-pepper hair. He says hello and introduces himself as Zandar. As your head is at floor level and he is standing on the floor over you, his robes are not quite long enough, and you can't help but notice what wizards wear under their robes.\n" \
"  Unfortunately Zandar caught you peeking. Shame on you! He steps back and snaps his fingers; you pop up out of the floor without your armour, clothing, and supplies.\n" \
"  For a moment Zandar looks startled. Then, with a big grin on his face, he apologizes and wraps his cape around you. He winks and asks you if you would like to put your weapon down and go into his private study for a small glass of wine.\n" \
"  If you accept, go to {157}. If you thank him but say you must leave with Quartz, go to {78}."
},
{ // 135/17H
"A brave but foolish move. You race through the tavern and up the stairs. You dimly remember the rock demon chasing you as you dash to his room.\n" \
"  You blast through the door, and as it dissolves into splinters you see the Red Robed Priests waiting for you. One pokes his rune staff at you and hits you in the chest with a 6th level spell - take 22 hits on your CON.\n" \
"  If you survive, you black out; go to {48}. If you die, console yourself with the fact that Quartz names a drink after you: The Dead Fool."
},
{ // 136/17K
"There is a pop! like a cork coming from a champagne bottle - and the wizard is standing over you. Make a Ll-SR on Charisma (20 - CHR). If the roll is successful, go to {91}. If you fail the roll, go to {24}."
},
{ // 137/17L
"The door is locked tight. Go back to {77} and try something else."
},
{ // 138/18A
"You brushed against one of the green spotted mushrooms, and now you are covered with spores from your neck down. Quartz didn't get any spores on him, but he stops and stares at you, a shocked expression on his face. You look down at yourself - and you can't see anything but the weapon you're carrying. No hand - no arm - no body! Go to {71}."
},
{ // 139/18B
"Roll two dice. This is the number of sword canes on the floor. They sparkle with a green fire, then rise from the floor and attack. Each sword has a MR of 12. If you destroy the canes, go to {40}. If you are killed, start a new character of the same general abilities and level but of the opposite sex back at the tavern."
},
{ // 140/18C
"Collect 20 adventure points and close the book. This character may not enter this adventure again."
},
{ // 141/18D
"If you appear to be naked with a strange tattoo on your backside, go to {23}. If you're dressed and have no tattoo, go to {165}."
},
{ // 142/18E
"There are two drinks left in the keg. Quartz misses two combat rounds while he drains the keg. Go to {3}."
},
{ // 143/18F
"You and Quartz grab opposite ends of the rug, pick it up, and shake it. There is a sharp pop! and a short, fat, blue-robed wizard tumbles from the centre of the rug onto the floor. He picks himself up and tells you to close your mouth or you will catch a fly. Make a L1-SR on Charisma (20 - CHR). If you succeed, go to {1}. If you miss the roll, go to {85}."
},
{ // 144/18G
"You are at the bottom of a dark pit. To the north are stairs that wind counter-clockwise up and around the pit. To the south is an iron-bound door. To the west is a small alcove; within this chamber is a troll. If this is the first time you have been inside this chamber, go to {169}. However, if this is the first time and you reek of fermented mushrooms, go to {7}. If this character has been here before, go to {51} and ignore the first two sentences."
},
{ // 145/18H
"The gnome dives into the pile of gold, out of sight - then a magic golden warrior emerges from the mound. The warrior gets 6 dice plus 50 adds in combat; he has a CON of 30 and no armour. If he kills you, close the book. If you kill him, go to {86}."
},
{ // 146/18K
"Never, never peek into a twenty-first level wizard's belongings. One of these days, your curiosity will get you killed. You have been zapped by a protection spell. Take one point from your IQ and go back to {99}."
},
{ // 147/19A
"Quartz takes you to a storeroom in the tavern and tells you he must recover a Blue Frog Amulet which was used to guard the tavern against magic. Quartz has learned from the one-eyed dwarf that the amulet was taken by a thief hired by the Red Robed Priests and is now in their local temple.\n" \
"  You take a magic blood oath, swearing to help and protect Quartz on his quest.[ The oath ensures that if Quartz is killed, you will also die. You may take any extra hits in combat that you wish if it will mean keeping Quartz alive.]\n" \
"  Go the T&T Rulebook and outfit yourself with any supplies you think you might need (there is no armour or poison in this storeroom). Quartz grabs his one-handed 6' sword, slings a fat wineskin over his shoulder next to the horn the dwarf gave him, and picks up and lights a torch. He tells you that this is all he will carry - you must carry any loot found.\n" \
"  [Quartz fights with 6 dice and 28 adds in combat with his sword, has a CON of 30, and can take 12 hits on his rocky hide each round as if it were armour. Poison has no effect on rock demons. If a rock demon stands against a tunnel wall or any bare earth section he will become invisible.\n" \
"  ]Quartz leads you down into the sub-basements of the tavern. On the last level are 7' tall wine kegs. Going down to the last keg, Quartz twists the spigot and a hidden door springs open on the keg. The keg opens on a stairway going down to the depths. Quartz leads the way down, and motions you to follow him. Go to {96}."
},
{ // 148/19B
"You are at the west end of dark east-west tunnel. A door is set in the south wall. If you try to open the door, go to {29}. If you would rather head east, go to {130}."
},
{ // 149/19C
"You have reached the pier. Quartz blows on the horn he has been carrying; as the last echo dies away, a barge emerges from the west end of the canal. It slowly pulls up. Quartz catches a line and ties the barge to the pier.\n" \
"  The one-eyed dwarf that Quartz was talking to in the tavern is the only person on the barge. In the centre of the barge is a 7' mound covered with canvas. Quartz is jumping up and down with excitement.\n" \
"  The dwarf smirks and pulls away the canvas, uncovering a cage made of silver bars. Inside the cage is a 6' long green minidragon. Quartz tells you not to worry, as the cage was made by elves and will hold anything you can cram into it.\n" \
"  The dwarf digs his hand into his pouch and draws out a silver whistle which he hands to you. Quartz clears his throat and tells you this is where you earn your pay. You are to stand by the south tunnel entrance and make rude faces at the dragon. When you attract its attention, the dwarf and Quartz will turn it loose. Then you will run up the stairs, throw open the door, flatten out on the floor, and let the dragon clean out the temple.\n" \
"  The dwarf tells you not to worry - the dragon can't see very well, and won't kill you if you don't move. The only danger is there may be a guardian inside the temple that will turn you to stone if you look at it - he warns you to close your eyes before you open the door.\n" \
"  You tell Quartz that you'd be happy to play tag with the dragon, but he may not have noticed that you twisted your ankle on the sand and can't run too good right now! Quartz looks embarrassed, and the dwarf doesn't believe you either.\n" \
"  Quartz tells you to get ready. You stalk over to the tunnel entrance, turn, and shout at the dragon. The dwarf opens the cage and you bound up the stairs. You shut your eyes, open the door, and dive for the floor. Make a L1-SR on Luck (20 - LK). If you make it, go to {80}. If you missed, go to {172}."
},
{ // 150/20A
"The moment you grabbed ten gold coins, another golden warrior emerged from the mound and attacked you. He gets 6 dice plus 50 adds in combat; he has a CON and wears no armour. If you kill him, go to {32}."
},
{ // 151/20B
"There are three circular shields hanging on the north wall. The shield on the right has a bulls-eye painted on it, the centre one has a demon head etched on it, and the one on the left is a blank silvery mirror. You may take down and try out any or all of the shields. Quartz is not interested in the shields and is amusing himself with the dead goblins.\n" \
"  If you try the silver shield, go to {2}. If you try the demon shield, go to {95}. If you try the target shield, go to {54}. If you want to leave, go to {65}."
},
{ // 152/20C
"You are on a stairway which winds around a dark pit. In the east wall is a doorway. If you want to go through it, go to {33}. To climb the stairs, go to {127}. To descend the stairs, go to {144}."
},
{ // 153/20D
"The case contains a long, thin, one-handed sword worth 1000 gp. This is a Death Vortex Blade, worth 6 dice and 24 adds in combat. [Each combat round that you use this sword, take one point off your CON (permanently). When you kill an opponent with the sword, add two points to your CON (permanently). However, this sword will not add points to your CON if it is used against the undead (vampires, ghouls, skeletons, etc.). ]Go back to {163}."
},
{ // 154/20E
"Quartz slams the door and the dwarf drives a wedge into it to keep it from being opened. Then everyone tramps down the stairs to the pier. The dwarf offers you and Quartz a lift. If you ride with the dwarf, go to {106}. If you want to cross the canal and leave by the north door, go to {77}."
},
{ // 155/20F
"You rush back to the door with Quartz at your heels, and remove the sword canes and bumbershoots. Go to {15}."
},
{ // 156/20G
"You are in a torchlit room; there are doors in the north, south, east, and west walls. If you have been here before, go to {77}.\n" \
"  In the centre of the room are three Red Robed Priests; they are washing and polishing a 6' upright mirror. If you are invisible from the neck down, go to {14}. If you are not invisible, go to {132}."
},
{ // 157/20H
"Zandar snaps his fingers, and a gnome scurries out from under the desk, yawning and rubbing his eyes. The wizard introduces you to Snavely the Gnome, and tells him to serve refreshments to Quartz.\n" \
"  Zandar opens the door to his small, neat study and waves you in. You walk forward...(Go to {171})."
},
{ // 158/20K
"What are you on, a quest or a mushroom hunt? Take one point from your IQ and go to {93}."
},
{ // 159/21A
"Quartz replaces the lid on the pit he found, and takes a swig from his wineskin. You look for the other two shields, but they are gone. Quartz shrugs his shoulders and says he didn't know you wanted them. He dumped them and the goblins in the water. He thinks the water comes out at a cove the smugglers use. Grumbling to yourself, you leave the room. Go to {65}."
},
{ // 160/21B
"If you leave through the north door, go to {123}. If you leave through the south door, go to {4}. If you leave through the east door, go to {57}."
},
{ // 161/21C
"As you rush into the treasure room, the cockatrice over the door casts its gaze upon you. Close the book, for you have been turned to stone."
},
{ // 162/21D
"Quartz orders the bouncer to get rid of the Priests and their rune staffs, and orders a round of drinks for the house. The barman brings over a small flask. Quartz tells you to drink it. If you do so, go to {88}. If you don't drink it, go to {10}."
},
{ // 163/21E
"You are in a dark room with a door to the north, a door to the east, and a door to the south. If this is your first time through this room with this character, go to {6}. If this is not your first time through, you may leave by the north door (go to {96}), the south door (go to {39}), or the east door (go to {65})."
},
{ // 164/21F
"You are in a torchlit room; there are doors to the west and south. In the middle of the room, on the floor, sits a hobgoblin who is playing with his toes and drinking beer from a keg. (If you have been here before, the room is bare; go to {61}.)\n" \
"  The hobgoblin lurches erect and charges at you with a battle axe in hand. Quartz sees an opening and makes a mad dash to the keg. Roll one die. If you rolled a 1, go to {35}; 2, go to {126}; 3 or 4, go to {84}; 5 or 6, go to {142}."
},
{ // 165/21G
#ifdef CORGI
"The dwarves are impressed by your bravery. They take in style to the pits of the Arena of Khazan[; you are sentenced to fight one combat (as a free man) to regain your freedom]. This character may not adventure in this dungeon again; close the book.\n" \
"  If you don't have a copy of Arena of Khazan (also published by Corgi Books), the dwarves escort you to the winecellars of the Blue Frog Tavern, and threaten to make you an honourary dwarf (even if you already are a dwarf) - you must promise to grow a beard, or they will saw your legs off. If this character is female, they give you a phoney beard and spirit gum instead. You all sit around and drink toasts to your newfound friendship. You drink prudently; the dwarves do not. When the dwarves finally pass out, you depart. Close the book."
#else
"The dwarves are impressed by your bravery. They take in style to the pits of the Arena of Khazan[; you are sentenced to fight one combat (as a free man) to regain your freedom]. This character may not adventure in this dungeon again; close the book.\n" \
"  If you don't have a copy of Arena of Khazan, the dwarves escort you to the winecellars of the Blue Frog Tavern, and threaten to make you an honourary dwarf (even if you already are a dwarf) - you must promise to grow a beard, or they will saw your legs off. If this character is female, they give you a phoney beard and spirit gum instead. You all sit around and drink toasts to your newfound friendship. You drink prudently; the dwarves do not. When the dwarves finally pass out, you depart. Close the book."
#endif
},
{ // 166/21H
"You climb into the elephant's foot and Quartz pushes you across the floor. You don't sink, and you reach the other door. As you climb out and place your first foot on the floor, you are startled by a loud thud. When your other foot hits the floor there is another thud!\n" \
"  Quartz growls and says you have the \"elephant foot curse\". Whenever you walk, run, or tip-toe, you will make as much noise as an elephant would! However, you [have gained the ability to kick down doors (treat this talent like an Unlock spell) and ]are now richer by 200 experience points.\n" \
"  You may now leave the room. If you were headed north, go to {148}. If you were going south, go to {46}."
},
{ // 167/21K
"Quartz is dragging his feet. You tell him not to worry. When you go through the door, you find yourself in a large dark cave; your torchlight reflects off two large eyes that hover about 30' from the ground.\n" \
"  Quartz screams, \"Dragon!\" and dives through the door. Make a L1-SR on Luck (20 - LK), and another on Dexterity (20 - DEX). If you missed either or both, you were caught in the dragon's fiery blast and have been burned to a crisp. If both saving rolls were successful, you managed to follow Quartz and closed the door in time. Go back to {77}."
},
{ // 168/22A
"He gives you a suit of chain mail that will take 11 hits each round, and a shield that will take 8 hits each round. This armour weighs a total of 1 weight unit. Go to {68}."
},
{ // 169/22B
"The troll lumbers out, dragging a club with iron spikes. He grunts viciously, and tells you in a guttural voice that he will let you pass if you give him one wineskin. Otherwise, you must fight him to the death.\n" \
"  You look at Quartz, but he shakes his head. \"No way I'm giving my only wineskin to some dumb troll!\"\n" \
"  If you are carrying a wineskin, you may give it to the troll and pass safely to the stairs (go to {152}) or through the south door (go to {116}). If you fight the troll, go to {51}."
},
{ // 170/22C
"There is some hope for you yet. Add one point to your Intelligence (if you peeked under the rug before, you may *not* add to your IQ). Quartz tells you to stop fooling around with the rug because it's getting late. Return to {129}."
},
{ // 171/22D
#ifdef CENSORED
"...and find yourself in the main room! Quartz looks up from his fourth mug of beer and lifts his eyebrows quizzically. You feel a bit confused, and sit at the desk. Zandar closes the door and pours you a goblet of cool spring wine. You feel strangely weak and dehydrated.\n" \
"  Zandar thanks you for the lock of hair, kisses your hand, and reels back to his study. You turn back to the desk and find your weapons and supplies, but no [clothes or ]body armour. Quartz asks you why you're dressed so strangely, so you look down at yourself - and receive the shock of your life!\n" \
"  You discover that you're wearing bright black leather armour, and knee-high leather boots.\n" \
"  Snavely told Quartz that somehow you impressed the wizard. Your [magic boots double your speed; your ]magic armour will take 12 hits each combat turn[ (warriors cannot double this)]. Take 800 experience points, and add 7 to your Charisma.\n" \
"  If you're going north, go to {148}. If you're headed south, go to {46}."
#else
"...and find yourself in the main room! Quartz looks up from his fourth mug of beer and lifts his eyebrows quizzically. You feel a bit confused, and sit at the desk. Zandar closes the door and pours you a goblet of cool spring wine. You feel strangely weak and dehydrated.\n" \
"  Zandar thanks you for the lock of hair, kisses your hand, and reels back to his study. You turn back to the desk and find your weapons and supplies, but no clothes or body armour. Quartz asks you why you're dressed so strangely, so you look down at yourself - and receive the shock of your life!\n" \
"  You discover that you're wearing bright black leather armour, and knee-high leather boots with strange long heels and silver spurs. A long leather bullwhip is attached to a silver-trimmed belt you wear around your waist. Quartz is stunned by your new outfit, and compliments you on the matching gauntlets.\n" \
"  Snavely told Quartz that somehow you impressed the wizard. Your [magic boots double your speed; your ]magic armour will take 12 hits each combat turn[ (warriors cannot double this); your magic whip will never fail to pull any weapon out of an enemy's hand or paw]. Take 800 experience points, and add 7 to your Charisma (you have a strange swagger to your walk, although that may be due to your unfamiliarity with those heels).\n" \
"  If you're going north, go to {148}. If you're headed south, go to {46}."
#endif
},
{ // 172/22E
"The dragon stepped on you. Roll one die and take that number from your CON. If you're still alive, go to {80}."
},
{ // 173/22F
"The small mushrooms are very good; you can sell them at any marketplace, 200 mushrooms for 1 gold coin. You can stuff 400 mushrooms into an ordinary knapsack. Now return to {21}."
},
{ // 174/22G
"The barge pulls away and floats down the canal. To the west is a tunnel with stairs leading high up to a small door. You must go up the stairs and open the door; go to {122}."
},
{ // 175/7L anti-cheat
"You are a very talented individual, for this paragraph cannot be reached through any other paragraph in this book. Quartz suggests that you cease and desist, and play this adventure the way it was meant to be played."
}
}, bf_wandertext[6] = {
{ // 0
"1. Four Black Hobbits. Each gets 4 dice in combat and has a CON of 12. If you kill them, take a total of 30 experience points."
},
{ // 1
"2. One Dwarf Giant. He stands 6' tall and is armed with a heavy mace. He's worth 8 dice in combat, and has a CON of 45. If you kill him, take 50 experience points."
},
{ // 2
"3. One Shadow Demon. He gets 5 dice in combat and has a CON of 60. If you fight in the dark, double the demon's dice. If you want Quartz to light a torch, you must fight the demon by yourself for one combat round in the dark. If you kill him, take 80 ap."
},
{ // 3
"4. One Crystal Demon. He gets 5 dice in combat and has a CON of 60. If you fight by torchlight, double the demon's dice. If you fight the demon in the dark and you cannot see in the dark, then you must halve your attack. Rock Demons can see in the dark, so Quartz is not affected. If you want Quartz to put out the torch(es), you must fight the demon by yourself for one combat round in the light. If you kill him, take 80 ap."
},
{ // 4
"5. Two Vampires (male and female). Each gets 6 dice plus 20 adds in combat and has a CON of 40. If you kill them, take 40 ap and go to {117}."
},
{ // 5
"6. Three Red Robed Priests. Armed with a pulsing rune death-staff, each Priest has a CON of 20 and gets 4 dice plus 22 adds in combat. You must fight all three Priests at once; you gain 30 adventure points for each Priest you kill."
}
};

MODULE SWORD bf_exits[BF_ROOMS][EXITS] =
{ { 131,  41,  27,  -1,  -1,  -1,  -1,  -1 }, //   0
  { 108,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  { 159,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  99,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  { 152, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/2A
  {  89,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/2B
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2D
  {  64, 112, 164,  -1,  -1,  -1,  -1,  -1 }, //  11/2E
  {  49,  77,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2F
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/2G
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/2H
  { 166, 139,  79,  -1,  -1,  -1,  -1,  -1 }, //  15/2K
  { 164,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/2L
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/2M
  {  47,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/3A
  {  46, 127,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/3B
  { 108, 143,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/3C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/3D
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/3E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/3F
  { 104,  34,  56,  -1,  -1,  -1,  -1,  -1 }, //  24/3G
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/3H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/3K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/4A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/4B
  { 148, 109,  59,  70,  -1,  -1,  -1,  -1 }, //  29/4C
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/5A
  { 140,  55,  69,  -1,  -1,  -1,  -1,  -1 }, //  31/5B
  {  50, 160,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/5C
  { 152, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/5D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/5E
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/5F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/5G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/5H
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/6A
  { 163, 102,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/6B
  { 117,  92,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/6C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/6D
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/6E
  { 113, 130,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/6F
  { 140,  90,  72,  -1,  -1,  -1,  -1,  -1 }, //  44/6G
  { 149,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/6H
  {  99,  19,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/6K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/6L
  { 140, 147,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/7A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/7B
  { 160,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/7D
  { 108, 129,  97,  -1,  -1,  -1,  -1,  -1 }, //  52/7E
  { 112,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/7F
  { 159,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/7G
  { 140, 147,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/7H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/7K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/8A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/8B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/8C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/8D
  {  11, 119,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/8E
  { 161, 107,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/8F
  { 129,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/8G
  { 129,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/9A
  { 163, 122,  43,  -1,  -1,  -1,  -1,  -1 }, //  65/9B
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/9C
  { 152, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/9D
  {  99,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/9E
  { 140,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/9F
  { 136,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/9G
  { 119,  53,  83,  -1,  -1,  -1,  -1,  -1 }, //  71/9H
  { 135, 105,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/9K
  { 174, 114,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/9L
  {  63, 170,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/10A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/10B
  { 148,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/10C
  {  83, 167,  12, 110,  -1,  -1,  -1,  -1 }, //  77/10D
  { 148,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/10E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/10F
  { 154,  22, 107,  -1,  -1,  -1,  -1,  -1 }, //  80/10G
  { 153,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/10H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/10K
  {  21, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/11A
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/11B
  { 108,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/11C
  { 150, 123,   4,  57,  -1,  -1,  -1,  -1 }, //  86/11D
  { 148,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/11E
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/11F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/11G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/12B
  { 166,   5,  70,  -1,  -1,  -1,  -1,  -1 }, //  92/12C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/12D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/12E
  { 159,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/12F
  { 163,  58,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/12G
  { 108, 143,  20,  -1,  -1,  -1,  -1,  -1 }, //  97/12H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/12K
  {  59, 146,  46,  70,  -1,  -1,  -1,  -1 }, //  99/12L
  {  11,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/13A
  {  19, 152,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/13B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/13C
  {  28, 163,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/13D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/13E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/13F
  {  16,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/13G
  {  62, 128,  38,  -1,  -1,  -1,  -1,  -1 }, // 107/14A
  {  33,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/14B
  {  29,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/14C
  {  98,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/14D
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/14E
  { 145, 160,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/14F
  {  43,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/15A
  {  36,  94,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/15B
  { 148,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/15C
  { 144, 112,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/15D
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/15E
  {  13,  78,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/16A
  { 164,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/16B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/16C
  { 155,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/16D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/16E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/16F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/16G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/16H
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/16K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/16L
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/17A
  { 108,  52,  74,  -1,  -1,  -1,  -1,  -1 }, // 129/17B
  {  43, 148,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/17C
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/17D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/17E
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/17F
  { 157,  78,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/17G
  {  48,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/17H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/17K
  {  83, 167,  12,  -1,  -1,  -1,  -1,  -1 }, // 137/17L
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/18A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/18B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/18C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/18D
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/18E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/18F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/18G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/18H
  {  99,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/18K
  {  96,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/19A
  {  29, 130,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/19B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/19C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/20A
  {   2,  95,  54,  65,  -1,  -1,  -1,  -1 }, // 151/20B
  {  33, 127, 144,  -1,  -1,  -1,  -1,  -1 }, // 152/20C
  { 163,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/20D
  { 106,  77,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/20E
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/20F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/20G
  { 171,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/20H
  {  93,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/20K
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/21A
  { 123,   4,  57,  -1,  -1,  -1,  -1,  -1 }, // 160/21B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/21C
  {  88,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/21D
  {  96,  39,  65,  -1,  -1,  -1,  -1,  -1 }, // 163/21E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/21F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165/21G
  { 148,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/21H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/21K
  {  68,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/22A
  { 152, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169/22B
  { 129,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170/22C
  { 148,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171/22D
  {  80,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172/22E
  {  21,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173/22F
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174/22G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 175/7L
};

MODULE STRPTR bf_pix[BF_ROOMS] =
{ "bf0", //   0
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
  "bf31",
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
  "",
  "",
  "",
  "bf80", //  80
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
  "bf102",
  "",
  "",
  "", // 105
  "bf106",
  "",
  "",
  "",
  "", // 110
  "",
  "bf112",
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
  "bf147",
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
  "", // 165
  "",
  "",
  "",
  "bf169",
  "", // 170
  "",
  "",
  "",
  "",
  ""  // 175
};

MODULE FLAG                   fought[6],
                              killedsnake;
MODULE int                    wmroom;

IMPORT int                    age,
                              armour,
                              been[MOST_ROOMS + 1],
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
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void bf_enterroom(void);
MODULE void bf_wandering(FLAG mandatory);

EXPORT void bf_preinit(void)
{   descs[MODULE_BF]   = bf_desc;
    wanders[MODULE_BF] = bf_wandertext;
}

EXPORT void bf_init(void)
{   int i;

    exits     = &bf_exits[0][0];
    enterroom = bf_enterroom;
    for (i = 0; i < BF_ROOMS; i++)
    {   pix[i] = bf_pix[i];
    }

    fought[0] = fought[1] = fought[2] = fought[3] = fought[4] = fought[5] =
    killedsnake = FALSE;
}

MODULE void bf_enterroom(void)
{   TRANSIENT int  i,
                   result,
                   torn1, torn2;
    TRANSIENT FLAG fighting;
    PERSIST   int  small;

    switch (room)
    {
    case 1: // 1A
        give(461);
    acase 2: // 1B
        give(462);
    acase 3: // 1C
        create_monster(234);
        fight();
        room = 61;
    acase 4: // 1D
        if (gp)
        {   room = 82;
        } else
        {   room = 133;
        }
    acase 5: // 1E
        result = getnumber("Was weapon above your head?\n1) Yes\n2) No\n3) Maybe\nWhich", 1, 3);
        torn1 = EMPTY;
        if (result == 1)
        {   award(50);
            if (both != EMPTY)
            {   torn1 = both;
            } elif (rt != EMPTY)
            {   torn1 = rt;
            } elif (lt != EMPTY)
            {   torn1 = lt;
        }   }
        elif (result == 3 && dice(1) == 1)
        {   if (both != EMPTY)
            {   torn1 = both;
            } elif (rt != EMPTY)
            {   torn1 = rt;
            } elif (lt != EMPTY)
            {   torn1 = lt;
        }   }
        drop_all();
        if (torn1 != EMPTY)
        {   give(torn1);
        }
        if (both == EMPTY && rt == EMPTY && lt == EMPTY)
        {   room = 125;
        }
    acase 6: // 1F
        create_monsters(235, 2);
        fight();
        award(35);
        room = 103;
    acase 8: // 2B
        give(463);
    acase 9: // 2C
        give_multi(538, 30);
    acase 10: // 2D
        if (getyn("Accept offer"))
        {   room = 147;
        } else
        {   victory(0);
        }
    acase 11: // 2E
        bf_wandering(FALSE);
    acase 14: // 2H
        lose_flag_ability(61);
    acase 21: // 3D
        small  = getnumber("Pick how many small mushrooms", 0, 400);
        result = getnumber("Pick how many large mushrooms", 0, 400);
        if (small && result)
        {   room = 158;
        } elif (small)
        {   room = 173;
        } elif (result)
        {   room = 93;
        } else
        {   room = 37;
        }
    acase 22: // 3E
        result = getnumber("Take how much food",    0, 999); // arbitrary limit
        give_multi(PRO, result);
        result = getnumber("Take how many torches", 0, 999); // arbitrary limit
        give_multi(TOR, result);
        give(831);
    acase 23: // 3F
        award(2000);
        module = MODULE_CT;
        room = 0;
    acase 25: // 3H
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == JEWEL)
            {   dropitems(i, items[i].owned);
        }   }
    acase 26: // 3K
        if (0)
        {   room = wmroom;
        } else
        {   room = 75;
        }
    acase 27: // 4A
        create_monster(233);
        npc[0].con = 10;
        recalc_ap(0);
        fight();
        award(20); // already gave them the other 30
        room = 162;
    acase 28: // 4B
        if (saved(1, iq) && saved(1, lk))
        {   room = 153;
        } else
        {   room = 81;
        }
    acase 30: // 5A
        give(465);
    acase 32: // 5C
        award(20);
    acase 33: // 5D
        bf_wandering(FALSE);
    acase 34: // 5E
        drop_all();
        savedrooms(1, chr, 115, 78);
    acase 36: // 5G
        module = MODULE_AK;
        room = 77; // slave
    acase 37: // 5H
        savedrooms(1, lk, 71, 138);
    acase 39: // 5L
        bf_wandering(FALSE);
    acase 41:
        if (getyn("Accept offer"))
        {   room = 111;
        } else
        {   victory(0);
        }
    acase 42:
        give_multi(466, 50);
    acase 46: // 5L
        bf_wandering(FALSE);
    acase 47:
        // %%: we assume that their equipment didn't melt, but it doesn't matter as they are about to lose it anyway
        module = MODULE_AK;
        room = 77; // slave
    acase 49:
        module = MODULE_DE;
        room = -1;
    acase 50:
        pay_gp(getnumber("Give how many gp", 0, gp));
    acase 51:
        if (prevroom != 144)
        {   create_monster(236);
            fight();
        }
    acase 54:
        give(467);
    acase 56:
        die();
    acase 57:
        if (gp)
        {   room = 82;
        } else
        {   room = 100;
        }
    acase 58:
        if (been[80])
        {   room = 124;
        } else
        {   lose_iq(1);
            room = 96;
        }
    acase 59:
        if (getyn("Cross floor (otherwise return)"))
        {   room = 121;
        } else
        {   if (prevroom == 29)
            {   room = 29;
            } else
            {   // assert(prevroom == 29 || prevroom == 99);
                room = 99;
        }   }
    acase 60:
        if (armour == 477)
        {   room = 120;
        } else
        {   room = 165;
        }
    acase 65:
        bf_wandering(FALSE);
    acase 66:
        give_multi(468, 20);
    acase 67:
        give(481); // %%: we assume you are allowed to take a wineskin because of BF169
        // %%: probably you should be allowed to take several?
    acase 75:
        create_monster(232);
        npc[0].adds = 60;
        recalc_ap(0);
        fight();
        room = wmroom;
    acase 76:
        drop_all();
        give(469);
        award(30);
    acase 77:
        if (been[110])
        {   room = 137;
        }
    acase 78:
        drop_all();
        gain_flag_ability(57);
        award(150);
    acase 79:
        if (dice(1) == 1)
        {   room = 166;
        } else
        {   room = 139;
        }
    acase 80:
        encumbrance();
        give_gp(getnumber("Take how many gp", 0, (st * 100) - carrying()));
    acase 81:
        gain_flag_ability(58);
    acase 82:
        die();
    acase 85:
        rb_givejewels(-1, -1, 1, dice(1));
    acase 86:
        award(10);
    acase 87:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == ARMOUR)
            {   dropitems(i, items[i].owned);
        }   }
        give(470);
        gain_flag_ability(59);
        award(1500);
        gain_chr(3);
    acase 88:
        if (con == max_con)
        {   gain_con(1);
        } else
        {   healall_con();
        }
    acase 89:
        if (gotrope(20))
        {   room = 130;
        } else
        {   room = 39;
        }
    acase 90:
        create_monster(233);
        npc[0].con = 10;
        npc[0].adds = 11;
        recalc_ap(0);
        fight();
        room = 31;
    acase 91:
        if (been[91])
        {   room = 46;
        } elif (sex == MALE)
        {   room = 118;
        } else
        {   room = 134;
        }
    acase 93:
        drop_all();
        result = dice(1);
        elapse(ONE_YEAR * result, TRUE);
        victory(0);
    acase 94:
        if (sex == MALE)
        {   room = 141;
        } else
        {   room = 60;
        }
    acase 95:
        do
        {   result = dice(1);
            if (result >= 3)
            {   templose_con(1); // %%: we assume this is temporary
        }   }
        while (result >= 3);
    acase 98:
        if (saved(1, lk) && saved(1, dex))
        {   room = 45; // %%: what if they don't have a rope/spear/belt?
        } else
        {   die();
        }
    acase 100:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == JEWEL)
            {   dropitems(i, items[i].owned);
        }   }
    acase 101:
        result = getnumber("Was Quartz right behind you?\n1) Yes\n2) No\n3) Maybe", 1, 3);
        if (result == 2 || (result == 3 && dice(1) >= 2))
        {   room = 67;
        }
    acase 102:
        if (killedsnake)
        {   room = 89;
        } else
        {   create_monster(237);
            torn1 = torn2 = EMPTY;
            fighting = TRUE;
            while (con >= 1 && countfoes() && fighting)
            {   fighting = getyn("Fight (otherwise run)");
                result = dice(2);
                if (result == 2)
                {   die();
                } elif (result == 3 || result == 11)
                {   if (both != EMPTY && isweapon(both))
                    {   torn1 = both;
                        dropitem(both);
                    } else
                    {   if (rt != EMPTY && isweapon(rt))
                        {   torn1 = rt;
                            dropitem(rt);
                        }
                        if (lt != EMPTY && isweapon(lt))
                        {   torn2 = lt;
                            dropitem(lt);
                }   }   }
                elif (result == 12)
                {   if (both != EMPTY && isweapon(both))
                    {   dropitem(both);
                    } else
                    {   if (rt != EMPTY && isweapon(rt))
                        {   dropitem(rt);
                        }
                        if (lt != EMPTY && isweapon(lt))
                        {   dropitem(lt);
                }   }   }
                if (fighting && con >= 1)
                {   good_freeattack();
            }   }
            if (countfoes())
            {   dispose_npcs();
                room = 39;
            } else
            {   killedsnake = TRUE;
                if (torn1 != EMPTY)
                {   give(torn1);
                }
                if (torn2 != EMPTY)
                {   give(torn2);
                }
                room = 8;
        }   }
    acase 104:
        result = dice(1);
        elapse(ONE_YEAR * result, TRUE);
        give_gp(200 * result);
        victory(0);
    acase 105:
        create_monster(233);
        npc[0].con = 10;
        npc[0].adds = 11;
        recalc_ap(0);
        fight();
        room = 48;
    acase 109:
        lose_iq(1);
    acase 110:
        if (canfly(TRUE))
        {   room = 149;
        }
    acase 112:
        pay_gp(getnumber("Give how many gp", 0, gp));
        if (items[PRO].owned)
        {   result = getnumber("1) Red\n2) White\n3)Green\n4) None\nTrade food for which pouch", 1, 4);
            if (result <= 3)
            {   dropitems(PRO, items[PRO].owned);
            }
            if (result == 0)
            {   room = 9;
            } elif (result == 1)
            {   room = 42;
            } elif (result == 2)
            {   room = 66;
        }   }
    acase 115:
        give(471);
        give(CLO);
        give(DEP);
        award(80);
    acase 116:
        bf_wandering(FALSE);
    acase 117:
        lose_lk(lk / 2);
        give(472);
    acase 119:
        bf_wandering(FALSE);
    acase 120:
        award(2000);
        module = MODULE_CT;
        room = 0;
    acase 122:
        if (been[122])
        {   room = 65;
        } else
        {   create_monsters(238, 6);
            fight();
            room = 151;
        }
    acase 123:
        if (gp)
        {   room = 82;
        } else
        {   room = 25;
        }
    acase 124:
        give_gp(200);
        // give horse and pack animal
        victory(3000);
    acase 125:
        give(473);
        if (race == WHITEHOBBIT)
        {   room = 168;
        } else
        {   room = 68;
        }
    acase 127:
        savedrooms(1, lk, 101, -1);
    acase 129:
        if (been[129])
        {   room = 108;
        }
    acase 130:
        bf_wandering(FALSE);
        if (canfly(TRUE))
        {   room = 102;
        }
    acase 132:
        create_monsters(233, 3);
        fight();
        room = 30;
    acase 133:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == JEWEL)
            {   dropitems(i, items[i].owned);
        }   }
    acase 135:
        good_takehits(22, TRUE); // %%: does armour help?
        room = 48;
    acase 136:
        savedrooms(1, chr, 91, 24);
    acase 138:
        gain_flag_ability(61);
    acase 139:
        create_monsters(239, dice(2));
        fight();
        room = 40;
    acase 140:
        victory(20);
    acase 141:
        if (ability[59].known)
        {   room = 23;
        } else
        {   room = 165;
        }
    acase 143:
        savedrooms(1, chr, 1, 85);
    acase 144:
        if (been[144])
        {   room = 51;
        } else
        {   if (ability[58].known)
            {   room = 7;
            } else
            {   room = 169;
        }   }
    acase 145:
        create_monster(240);
        fight();
        room = 86;
    acase 146:
        lose_iq(1);
    acase 147:
        while (shop_give(7) != -1);
    acase 149:
        savedrooms(1, lk, 80, 172);
    acase 150:
        give_gp(10);
        create_monster(240);
        fight();
        room = 32;
    acase 153:
        if (!been[153])
        {   give(474);
        }
    acase 156:
        if (been[156])
        {   room = 77;
        } elif (ability[61].known)
        {   room = 14;
        } else
        {   room = 132;
        }
    acase 158:
        lose_iq(1);
    acase 161:
        die();
    acase 163:
        if (!been[163])
        {   room = 6;
        }
    acase 164:
        if (been[164])
        {   room = 61;
        } else
        {   dicerooms(35, 126, 84, 84, 142, 142);
        }
    acase 165:
        module = MODULE_AK;
        room = 71; // free man
    acase 166:
        gain_flag_ability(60);
        award(200);
    acase 167:
        if (saved(1, lk) && saved(1, dex))
        {   room = 77;
        } else
        {   die();
        }
    acase 168:
        give(475);
        give(476);
        // %%: is it half a weight unit for the armour and half a weight unit for the shield?
    acase 169:
        if (items[481].owned && getyn("Give wineskin to troll (otherwise fight)"))
        {   dropitem(481);
        } else
        {   room = 51;
        }
    acase 170:
        if (!been[63])
        {   gain_iq(1);
        }
    acase 171:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == ARMOUR)
            {   dropitems(i, items[i].owned);
        }   }
        give(477);
        give(478);
        give(479);
        award(800);
        gain_chr(7);
    acase 172:
        templose_con(dice(1));
    acase 173:
        give_multi(480, small);
}   }

MODULE void bf_wandering(FLAG mandatory)
{   int result;

    if (prevroom == 26 || prevroom == 75)
    {   return;
    }

    aprintf(
"WANDERING MONSTER TABLE\n" \
"  Below is a list of Wandering Monsters. These monsters carry no treasure; their arms and armour are cursed or will disappear at death, so you cannot use them.\n" \
"  Roll one die to see which monster you fight. If you kill them, go back to the paragraph that brought you here. You may not fight the same monster twice until you have gone through this list once. Then reactivate the monsters[, try another list, or use some of your favourite monsters].\n"
    );

    if (!mandatory && dice(1) >= 2)
    {   return;
    }

    if (fought[0] && fought[1] && fought[2] && fought[3] && fought[4] && fought[5])
    {   fought[0] = fought[1] = fought[2] = fought[3] = fought[4] = fought[5] = FALSE;
    }
    do
    {   result = dice(1) - 1;
    } while (fought[result]);
    fought[result] = TRUE;

    aprintf("%s\n", bf_wandertext[result]);

    switch (result)
    {
    case 0:
        create_monsters(228, 4);
    acase 1:
        create_monster(229);
    acase 2:
        create_monster(230);
    acase 3:
        create_monster(231);
    acase 4:
        create_monsters(232, 2);
    acase 5:
        create_monsters(233, 3);
    }

    wmroom = room;

    fight();
    if (result == 0)
    {   award(30);
    } elif (result == 4)
    {   room = 26;
}   }
