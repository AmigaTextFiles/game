#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

MODULE const STRPTR ss_desc[SS_ROOMS] = {
{ // 0
"`Enter the forbidden realm of true magic. The Sorcerer Solitaire will kill any warrior or blackhearted rogue who enters. Only the cunning, sly, and the lucky will survive.\n" \
"  Many of the T&T solo dungeons kill mages, mostly because mages are terrible fighters. After I had a mage killed off by a monster with a 10 Monster Rating, I decided it was time for a dungeon designed purely for magic-users. (Here at Flying Buffalo we had decided that some time ago, and hopefully awaited the appearance of such a dungeon. Walker brought this one, and we bring it to you. - Ed.)\n" \
"  One reason magical dungeons have perhaps not been produced in the past is that the nature of magic is complex. You may find yourself with a dungeon that has several options in each paragraph, but the choices are only between one spell or another. Thus there are fewer scenes, fewer possible adventures. In an effort to supply variety of scenes, the spells have been limited to first-level magic only. The dungeon is for characters of 1st through 3rd level, mages only, and characters must travel alone (no parties, please). No warriors or rogues are permitted, and if they should attempt to come, they will be fried at the entrance. (The GM knows!) Aside from that, all general rules in the T&T Rulebook apply.\n" \
"  A note concerning the passage of time: [Unless otherwise stated, each paragraph may be considered 1/3 of a turn, ie. three paragraphs equal one full turn. ]As per the T&T rules, a mage can regain Strength at 1 point every full turn UNLESS he or she is strenuously engaged in activity.\n" \
"  So practice up on your magic, exercise those fingers, and start delving! There are indeed traps and monsters that can kill if the character makes a mistake. As the mystic-minded astrologers say when Mars sets in Aries,\n" \
"  \"Have a Bloody Good Time!\"\n" \
"  (When you are ready to start, go to {1}.)~"
},
{ // 1/1A
"It's an evil night out. Velvet black clouds litter the sky. The full moon occasionally peeps out to illuminate the weird night creatures that prowl at such times. The howl of a timber wolf echoes out of the trees. In short, it is a night for evil-doing and treasure-hunting. As a sudden gust tosses about you, you see you are standing near the front porch of an enormous mansion which reeks of rotting corpses. The building storm sends blinding bolts of lightning to the ground. These flashes reveal that heavy iron bars seal all entrances to the mansion except for the front door. The door is locked, but an Unlock spell will open it. The lightning is getting closer; already rain is pouring. Are you willing to enter by casting an Unlock spell, or do you prefer to stay outside? If you enter, go to {15}. If you stay, go to {8}."
},
{ // 2/1B
"The first step creaks threateningly under your weight. (The last repairman who visited here died over a century ago...) The second step sags precipitously. Make a L1-SR on your Luck (20 - LK). If you make it, go to {28}. If you missed your saving roll, go to {32}."
},
{ // 3/1C
"He learns the spell without difficulty. He explains that it is dangerous to walk around this dungeon without knowing some magic. Although his clothes are so torn and smelly that a wretched beggar would look prosperous, he can repay you. Thanking you profusely, he hands you a small diamond. It is all he can give you, he says. It is worth 100 gp. He says that he now has a job to complete and marches off. You get 50 ap for teaching him the spell. Go to {10}."
},
{ // 4/1D
"Your champion's sword finally connects with the enemy. Blood and guts fly everywhere; parts of the black warrior litter the floor. The white warrior ignores you. Exhausted, he picks over the body and then starts to leave. If you let the bloody ingrate leave, go to {24}. If you aren't a lily-livered coward and want to fight him for the loot, go to {12}."
},
{ // 5/1E
"The area succumbs to serene silence. Moss clings to the damp cold clay walls. You have the option of waiting here or you may continue. If you decide to wait here for five turns, go to {13}. If you prefer to leave, go to {110}."
},
{ // 6/1F
"The chartreuse dragon slows down. It is so close that you can see the red-hot glimmer in its eyes. You recognize it as a baby from its size, and by its underdeveloped wing sheaths. It rubs its back along your thigh, much like a cat would. You have tamed it, and it thinks you are its father (mother?). This dragon will follow you anywhere[ and will defend you if you are attacked. It will not aid you, however, if you initiate an attack.) This dragon begins with a Monster Rating of 50; this will increase by 10 every time your character is raised a level. This dragon will singlemindedly attempt to kill any other pet you may have. It will be able to fly after it reaches a Monster Rating of 150]. Go to {110}."
},
{ // 7/1G
"A pale green light sprouts from your fingers; the light slices through the ghosts like a light-sabre through butter. Their lifeless mists disperse, leaving a musty order behind. You are unhurt. Take 80 ap for brilliance and go to {57}."
},
{ // 8/2A
"The lightning flashes look like a fireworks display. The thunder drowns out the screams of the small creatures of the forest as they run to safety. This leaves you standing out like a lightning rod, watching the activities. Make a L1-SR on your IQ (20 - IQ) to see if you are hit. If you miss, a little finger of sparkling electricity found you, frying 10 points off your Constitution. Armour doesn't help. The storm dies down a little. Now go to {1} if you still live. If the lightning killed you, tear up the card and try again."
},
{ // 9/2B
"The corridor glows eerily in the magic light. It extends into the distance. There are no nearby exits. The floor is stone and the walls and ceiling are heavy oak. Thousands of spiderwebs (ancient as well as those still occupied) adorn the walls and roof. You can see dozens of eyes staring out of the webs, watching you. If you continue walking down the corridor, go to {16}. If you want to do a Detect Magic first, go to {156}."
},
{ // 10/2C
"You continue to walk briskly down the winding hallway. Suddenly the hair rises on the back of your neck. You have a feeling of being watched. A cold damp breeze causes shivers to run down your spine. The section ahead is completely dark. You now have four options for survival: if you conjure up a Will-of-the-Wisp in the dark section of rotten hallway, go to {17}; if you casually walk through this section, go to {27}; if you prefer to run through the dark, to avoid what may lurk therein, and so plunge headfirst into the unknown, go to {40}; if you are an incurable coward, and cast the arcane spell known to non-magicians as a Detect Magic, you may go to {56}."
},
{ // 11/2D
"You get 85 ap for helping him. He spends two turns cleaning up, and you may use the turns to regain Strength. The warrior splits up the treasure from the dead man and you each get 90 gp. Then he says he must leave, and he urges you to go the opposite direction. Friends of the dead man may come, he says, and they'll seek revenge. You may await them and be killed, or you may leave. If you leave, go to {81}."
},
{ // 12/2E
"He was watching you closely, so your attacks are simultaneous. If you attempt to scare him off with a Panic spell, go to {19}. If you fight with a physical weapon, go to {41}. If you are stupid enough to cast a mighty Take That You Fiend while he is slicing you to ribbons, go to {162}."
},
{ // 13/2F
"Make a L1-SR on Luck (20 - LK). If you make it, you survive five turns without anything popping up. You can leave by going to {110}. If you missed your saving roll, something happened on the 3rd turn. That 'something' is big and noisy and approaching fast. It smells like burnt sulphur, and the reverberations feel like a railroad train, with you on the tracks! Go to {20}."
},
{ // 14/2G
"A majestic, mystical battle ensues. Bolts of energy leap from your fingers and mingle with the cold anti-matter of the spirits. Phosphorescent vapors dance like the rainbow aurora of the far north. The ghosts are snuffed out, one at a time. Each ghost has a Constitution of 3. If any ghosts survive your attack, they will each subtract 2 points from your Constitution. You must attack any surviving ghosts on the second combat turn in order to be rid of them. After you have destroyed all 8 ghosts, you can rest five turns without being disturbed. Then go to {57}. On the other hand, if you were killed, go to {98}."
},
{ // 15/3A
"The door opens with a loud 'Haunted House Standard Creak #1'. You enter a room which is quite dark. You dimly see a glowing skull which is magic in the middle of the room. Behind it is a staircase which leads up. There are open doorways to your left and right. The door behind you suddenly slams shut with a loud bang. If you try it, you will find it firmly locked. If you would like to cast magic, go to {23}. If you want to go upstairs, go to {2}. If you go through the door on the left, go to {70}. If you go through the door to the right, go to {146}. If you approach the skull, go to {31}."
},
{ // 16/3B
"You run straight into an invisible wall. It is covered with invisible spikes and many bumps. Take five hits; this may be taken on your armour if you wear any. Now go to {156}."
},
{ // 17/3C
"The light startles the ghouls that were following you. They run away. You get 250 ap for scaring them away. Now go to {57}."
},
{ // 18/3D
"You trip over something lying on the floor of the tunnel. Make a L1-SR on your Luck (20 - LK). If you make your saving roll, go to {190}. You did not fall down. On the other hand, if you missed the saving roll, you did fall down, spraining your shoulder. Subtract two hits directly off your Constitution. You swear quietly, wishing that you had extra eyes in the back of your head so that you could see everything. Bammo! You do! Go to {35}, four-eyes!"
},
{ // 19/3E
"If you did less than 24, go to {52}. If you did 24 or better, you scare him in his wounded condition. He runs off, leaving all the loot behind. Go to {29}."
},
{ // 20/3F
"Several small animals run past you. You see a cloud of fire and smoke approaching; this is followed closely by a large lizard-like head. If you want to run, go to {176}. If you would rather stay, make a L1-SR on your current Constitution (20 - CON). If you make it, you may go to {50}. Otherwise, terror takes over and you must flee to 176."
},
{ // 21/3G
"The button breaks into a dozen pieces when you depress it. The Gobbler continues to gobble monsters and equipment uncontrollably. Make a L1-SR on Luck (20 - LK). If you miss your saving roll, you were right in the path of the Gobbler and it just ate you. Tear up the card and start with another character. Otherwise, if you make the saving roll, go to {43}."
},
{ // 22/3H
"To exit the room, the princess must make a first-level saving roll on her Luck, which is 11. If she makes the roll, go to {192}. If she misses her saving roll, go to {200}."
},
{ // 23/4A
"As you cast a spell, the magic skull disappears. If you cast an Unlock spell on the front door, go to {103}. If you cast a Detect Magic, go to {61}. If you cast a Lock Tight, Will-o-Wisp, Vorpal Blade, or Panic, go to {132}. If you cast a Take That You Fiend, go to {71}. If you cast a Revelation, go to {46}. If you cast a Concealing Cloak, go to {79}."
},
{ // 24/4B
"You will find a usable suit of ring mail armour on the body. The armour is magical. [It will adjust its size to fit any wearer. ]You will find only one unbroken weapon, a main gauche. He is carrying a bag of 10 pearls (total weight units: 10) that are worth 75 gp all together. You get 125 ap for helping in the kill. Now go to {33}."
},
{ // 25/4C
"These mushrooms melt in your mouth. They are very succulent. Soon you see dots before your eyes and you get a bad stomach ache. You realize that you should have washed off the carcasses before you ate the mushrooms. Now roll 1 die: if you roll 1-5, go to {34}. If you roll a 6, however, go to {224}."
},
{ // 26/4D
"As you reach the other end of the corridor, you come upon a lit room. You hear shuffling noises. When you look inside, you see a...(go to {30}!)"
},
{ // 27/4E
"You see a sapphire faintly glowing in the dark. It is just lying there on the floor. If you choose to do a Detect Magic, go to {56}. If you pick it up and continue, go to {36}."
},
{ // 28/4F
"You slip when the step breaks, but you are uninjured. In the dark beneath the stairs is a glittering. Pick it up and you will find it is a gold ring that does 10 free Restoration spells (at 1 Constitution point regained each time) before it burns out. Afterwards, the ring can be sold for 30 gp. Go to {49}."
},
{ // 29/4G
"The floor is cluttered with broken and unusable junk. Only a few undamaged items remain, but you may take them. There is a buckler[ (worth 1 hit as armour)], and a main gauche[ (1 die in combat)]. On one of the bodies is a set of magical ring mail (takes 7 hits). [The magic is that it adjusts its size to fit the wearer. ]You can also scrounge up 240 gp and a small magical piece of jade that raises your Dexterity by 5. Then the magic disappears and the jade is worth 60 gp (weighs 25). You get 250 ap for eliminating both warriors. It took you 3 turns to search the rubble. Afterwards you can go to {33}."
},
{ // 30/5A
"You encounter a nasty-looking, badly scarred rogue. His clothes are unwashed rags. Upon seeing you, and recognizing you as a mage, he asks you if you would teach him to throw a Take That You Fiend. If you can stand the stench emanating from his body long enough to teach him the spell, go to {3}. If you toss a Panic at him, go to {47}. If you want to fight him, go to {125}. If you are invisible (cast a Concealing Cloak) and you want to pass him by, go to {118}, but first consult the Magic Effects Table. If you cannot go invisible and would rather beg off of the loathsome task, make a saving roll on your Charisma (20 - CHR). If you make it, he'll let you pass; go to {118}. Otherwise, he attacks you for your unhelpful impertinence; go to {125}."
},
{ // 31/5B
"As you approach the skull it brightens. Its radiance fills the room. You feel yourself changing. If any of your attributes are greater than 50, they are reduced to 50. If any of your attributes are less than 12, you may reroll those characteristics using the following method - roll 5 six-sided dice and make that total the new attribute. You may do this for any attribute less than 12, but only once for any single attribute, regardless of whether the total was greater or less than before. When you are through, the skull becomes a burnt-out cinder. Go to {37}."
},
{ // 32/5C
"The second step breaks under your weight. Take hits equal to the number you missed your saving roll by. You crawl out of the stairs and continue climbing without further incident. Go to {49}."
},
{ // 33/5D
"You may wait here until you have regained all your Strength. The exit is well lit. When you decide to leave, go to {81}."
},
{ // 34/5E
"This bit of knowledge increases your IQ by 5 points. The food increases your Dexterity by another 3 points. You may wait for 2 turns until you feel better, then go to {91} with no other ill effects."
},
{ // 35/5F
"Your two extra eyes notice a genie standing behind you. He is hovering over the lamp you tripped on. \"What is your next wish?\" he asks. \"That last one was certainly unusual.\" The extra eyes will increase your Luck by 8, and decrease your Charisma by the same amount. The genie tells you that you have one wish remaining. If you wish you had only 2 eyes, go to {42}. If you wish for health, go to {51}. If you wish for wealth, go to {58}. If you wish for happiness, go to {99}."
},
{ // 36/5G
"The sapphire is worth 100 gp. Now go to {57}."
},
{ // 37/6A
"The room is now dark. If you go up the staircase, go to {2}. If you go through the door on the left, go to {70}. If you go through the door on the right, go to {146}."
},
{ // 38/6B
"The things taste squishy and bitter. Roll one six-sided die. If you roll a 1-5, you got good ones and they do satisfy your hunger. You are so glad, your Charisma increases by 2. If you rolled a 6, however, you got rotten ones, and they destroy both your digestion and your attitude. Take 4 from Charisma. Go to {91}."
},
{ // 39/6C
"The troll is frightened. He runs away, leaving his treasure behind him. Go to {73}."
},
{ // 40/6D
"Make a first-level saving roll on your Dexterity (20 - DEX). If you miss, you tripped in the dark, and fall over. You must absorb 8 hits if you fall. All of this may be taken on armour, if applicable. You reach the other end safely if you continue running (or limping). Go to {57}."
},
{ // 41/6E
"He gets 2 dice and 4 adds. His remaining Constitution is 3. If you win, go to {29}. If you lose, go to {98}."
},
{ // 42/6F
"The genie says \"What a shame! You looked much better with four eyes!\" Make a L1-SR on your Luck (20 - LK). If you miss, go to {193}. If you made your saving roll, the genie snaps his fingers. The two eyes in the back of your head disappear. Your Luck and Charisma are restored to what they were before. The genie and the lamp disappear. Go to {106}."
},
{ // 43/6G
"If you run fast, you can stay ahead of the Gobbler. You run so fast, in fact, that you run clear out of the dungeon, up to a nearby hilltop. There you can watch the dungeon slowly be consumed. [You get 1 experience point for each gp worth of treasure you got on the trip. ]Unfortunately, that character will no longer be able to enter this dungeon since he destroyed it. However, he does get an extra 300 ap for obliterating the dungeon!"
},
{ // 44/6H
"It doesn't work against the demon. The cold permeates your leg, then it fills your torso, and finally your mind freezes over. The character is dead, his soul consumed. His body will merely whet the appetites of the dungeon's roaming vermin. Close the book."
},
{ // 45/7A
"You see two warriors fighting each other in the room. They notice you and both call out, asking for your help. They are very evenly matched. Your aid - tossing a Vorpal Blade spell - could affect the battle one way or the other. One warrior, named Edgard, is dressed in black; the other, Henry, is in white. If you help the black warrior, go to {53}. If you help the white warrior. go to {4}. If you watch but help neither, go to {154}. If you cross the room and go out the door, go to {62}."
},
{ // 46/7B
"You find a gold bar that weighs 200 gp. It becomes visible when you pick it up. Consult the Magic Effects Table, and then go to {37}."
},
{ // 47/7C
"If you tossed more than 24 at him, he runs away. Go to {118}. If you tossed 24 or less, go to {125}."
},
{ // 48/7D
"The door clicks. Shoving it open, you see that it is the entrance to a pitch-dark room. If you have a lamp or if you wish to do a Will-o-the-Wisp, go to {59}. If you enter in the darkness, go to {75}. If you decide that you'd rather not enter after all, go to {18}."
},
{ // 49/7E
"You reach the top of the stairs and enter into the short hallway before you. You hear a strange type of laughter coming from downstairs. Furthermore, there is the sound of chains clanking up the stairs. There is an iron door at the end of the hallway - if you want to do an Unlock spell on the door, go to {83}. If you do a Revelation, go to {92}. If you go back to the top of the stairs to see what is following you, go to {68}."
},
{ // 50/7F
"The dragon gets closer and closer. It is the most terrifying thing you have ever seen, and it is in a big rush! If your Charisma is greater than 15, go to {6}. If your Charisma is 15 or less, go to {67}."
},
{ // 51/7G
"The genie increases each of your attributes by 1 point. Then he and the lamp both disappear. Go to {106}."
},
{ // 52/7H
"He didn't scare, and you must fight him. Go to {41}."
},
{ // 53/8A
"He wins with your help. The warrior thanks you and gives you a knife and sheath. It's the perfect weapon for a mage, he explains. The dirk is silver, but it is the sheath that is magic. It 'vorpals' the blade on the first turn the knife is used, doubling the attack of the weapon for 1 combat turn. He explains that it belonged to his grandfather who was also a mage. Now go to {11}."
},
{ // 54/8B
"Several bats attack you on the way out. You've approached too close to their nesting area. Roll one die to determine how many bites (hits!) you have to take - directly off your Constitution, please! Now roll two dice; this is how many bats you have killed. You get 1 ap for each bat slain. You may stay and fight another round (at the same odds) or you can exit to {65}."
},
{ // 55/8C
"If your Panic is greater than 30, go to {66}. If it is 30 or less, go to {119}."
},
{ // 56/8D
"You detect 8 ghosts about to attack you. You hear their moans as their cold bodies cluster around you. If you do a Will-o-the-Wisp, go to {7}. If you do a Take That You Fiend, go to {14}. If you do a Panic on the largest ghost, go to {76}. If you fight with a weapon, go to {84}."
},
{ // 57/8E
"The area that you are in is suddenly plunged into darkness. You feel the presence of something incredibly evil lurking nearby. Your torch or lantern will not work, and a Will-o-the-Wisp fails as well. An overpowering feeling of doom surrounds you. You now have just two choices: you may grope blindly around in the darkness, or you may try your magic. If you grope blindly, go to {210}. If you try your magic spells, go to {69}."
},
{ // 58/8F
"A pile of 2000 gold pieces appears, shining brightly at your feet. You may take only what you can carry, but you may, of course, discard some of your armour and other useless trinkets. The genie and the lamp both disappear. Go to {106}."
},
{ // 59/8G
"You can see into the room. Glaring at you from one corner is a large brown saber-tooth tiger. Trapped, it is ready to pounce. If you cast Detect Magic, go to {163}. If you want to attack, go to {134}. If you turn and run away, go to {18}. If you want to try to talk with this creature, then go to {104}."
},
{ // 60/8H
"Now go to {197}."
},
{ // 61/9A
"The area where the skull was is magic. You already knew that. If you try a Revelation, go to {46}. Otherwise, go to {37}."
},
{ // 62/9B
"[If you are already invisible, you made it. Otherwise, ]make a first level saving roll on Luck (20 - LK). If you miss, go to {72}. If you make the saving roll, go to {126}."
},
{ // 63/9C
"They taste as bad as they looked. However, when picked at the right time, they can improve your health. Roll one six-sided die: if you roll a 1-5, add 2 to your Strength and 2 to your Constitution. If you rolled a 6, you picked them at the wrong time, and they are highly toxic. Subtract 2 from Strength and 2 from Constitution. (These are permanent; you will not regain your lost Strength by waiting two turns.) Now go to {91}."
},
{ // 64/9D
"You wait until he leaves and then check out the treasure. Go to {73}."
},
{ // 65/9E
"You may wait 5 turns outside the cave to regain your Strength. You feel the bites of the bats invading your body. If you are poison-proof, or if you have a Too-Bad Toxin or its equivalent, go to {213}. You have just one other chance. Roll one 6-sided die: if you roll evens, you can also go to {213}. But if you rolled odds, go to {203}."
},
{ // 66/9F
"You scared away the troll. He dropped the treasure he was carrying. Now go to {73}."
},
{ // 67/9G
"The dragon doesn't notice you. It rushes past you and into the next room. Go to {110}."
},
{ // 68/9H
"You can see nothing coming up the stairs. However, you do feel a cold draft on your back, and then something cold taps you on the shoulder. Go to {77}."
},
{ // 69/9I
"An icy cold tentacle grips your ankle. It contracts tighter and tighter, and begins sucking the heat from your body. You have little chance to save yourself from the dungeon's demon soulsucker. If you choose to cast a Panic, go to {88}. If you cast a Take That You Fiend, go to {44}. If you cast a Concealing Cloak, go to {182}. If you cast a Revelation, go to {141}."
},
{ // 70/10A
"You stumble into a long dark eerie tunnel. There is sufficient light coming from the far end for you to see vague shapes. Several small furry creatures with long tails scurry away at your approach. You see some large bones lying on the floor; they are human bones. The tunnel suddenly gets darker, and it also gets colder. You can hear something growling at the other end. You now have two choices: you can search the tunnel or wait to see what is at the other end. If you do a Revelation, go to {78}. If you prefer to make your way between the bones and so to the other end of the tunnel, go without searching to {87}."
},
{ // 71/10B
"Since the skull disappeared before your spell, nothing happens. There is nothing living left to hit. Go to {37}."
},
{ // 72/10C
"You are hit by flying fragments of armour, broken swords and the like. You take 6 hits, although your armour will protect you in the usual way. Go to {126} if you survive. Close the book if you've perished."
},
{ // 73/10D
"You pick up his treasure. You get get 80 ap for defeating the troll. You will find an old pouch which contains 210 gp worth of rubies, and there is also a magic marble. It will increase your IQ by 1 point when you touch it, and then it ceases to be magic. You also find a magic ring which does free Will-o-Wisp spells. Continue on your way, and go to {5}."
},
{ // 74/10E
"[You may add 1 to your Strength every time you drink blood out of a human body. This must be done inside a dungeon, however. You may not increase your Charisma through level raises. ]Go to {106}."
},
{ // 75/10F
"You bump into something warm and hairy in the room. Reaching up, you feel stalactites coming from the ceiling, or are they teeth?! They move. If you run back outside, go to {18}. If you do a Will-o-the-Wisp, go to {59}. If you try to talk, go to {85}. If you do a Panic, go to {93}. If you attack blindly, go to {134}."
},
{ // 76/10G
"The ghostly leader has a Monster Rating of 30. If you didn't scare him, they all tore you limb from limb. If you were attacked, go to {98}. If you succeeded in driving off the ghost leader, you must still contend with the other 7 ghosts. Roll a L1-SR on Luck (20 - LK). If you make the roll, go to {187}. If you miss, go to {205}."
},
{ // 77/10H
"Something has reduced your Luck by 2! Turning, you see a ghost bedecked with chains. He reaches out to touch you again. If you do a Will-o-the-Wisp, go to {86}. If you cast a Take That You Fiend, go to {94}. If you do a Panic, go to {100}."
},
{ // 78/11A
"Refer to the Magic Effects Table to see what you found, and double that (whether treasure, Monster Rating, or length of time). You may continue down the tunnel or turn back. If you continue the way you are going, go to {87}. If you turn back, go to {197}."
},
{ // 79/11B
"You are now invisible. [You will remain invisible until you reach an option of \"D\" or higher (eg. 7D, 3G, 19F, etc.). Your combat adds are doubled until then. ]Now check the Magic Effects Table, and go to {37}."
},
{ // 80/11C
"You enter a room full of bats. Many furry bodies flitter away as you near them. 1' of bat guano covers the floor; you can feel it ooze around your feet. A luminescent fungus lights your way through the cave. Go to {89}."
},
{ // 81/11D
"You slowly descend a steep flight of stairs that are carved out of solid rock. You move deeper and deeper underground. On every 10th step is a pile of rotting bones. If you stop to examine them, you will see that they are human remains and the bones have been well-gnawed by rats. Above each pile is an iron neck-collar which is still firmly set in the wall. Go to {96}."
},
{ // 82/11E anti-cheat
"Your toes are starting to rot. You can tell because they are already starting to smell. Your teeth all fall out. You know that, because your friends comment on your bad breath. YOU! Not your character! This is the curse of the Dungeon Master for reading something you can't possibly get to! Go to {98}."
},
{ // 83/11F
"The lock clicks. Turning the handle, you swing the door open. The room appears to be empty except for a table in the middle of the floor. The room is well-lit. Something is still coming down the hall behind you. If you turn to face it, go to {157}; if you enter the room and slam the door, go to {101}."
},
{ // 84/11G
"You should know that ordinary weapons are useless against ghosts! Take 8 hits directly off your Constitution. The ghosts taste blood and keep coming. If you do a Will-o-the-Wisp, go to {7}. If you cast a Take That You Fiend, go to {14}. If you try a Panic, go to {76}. If you died, go to {98}."
},
{ // 85/11H
"The creature is friendly. He offers you a small treasure if you will just leave him alone. Go to {129}."
},
{ // 86/11I
"He has reduced your Luck by 2 again, for this ghost is immune to light. He appears even happier for finding such a stupid victim. If your Luck has been reduced to 0, go to {98}. If you live, and want to cast a Take That You Fiend, go to {94}. If you would rather try a Panic, go to {100}."
},
{ // 87/12A
"Now the sound is a deep rumbling. It is an empty stomach. The noise continues to get louder until it is only a few feet ahead of you. Go to {95}."
},
{ // 88/12B
"If you cast a Panic greater than 37, you scared the demon so that he ran away. If you did less than this, you died, and should go to {98}. If you survived, you will find that the blackness leaves when the demon does. You find yourself teleported to a new room. Go to {153}."
},
{ // 89/12C
"At the other end of the cave, near the exit, there are three growths of mushrooms (or possibly toadstools). The first group of mushrooms has one dot on each cap. The second group has two, and they are covered with dead flies. The third group of mushrooms has three dots and they are barely visible under a pile of dead bats, flies, and other insects. They also appear to be oozing purple filaments. Still, you do feel hungry. If you leave this cave without eating, go to {54}. If you choose to eat some mushrooms, you will find that, you must be careful wending your way among them - one slip and you will crush them all. Gathering a few mushrooms from one patch will mean you have trampled and crushed the others, so you may only eat one kind of mushroom. If you pick those with one spot, go to {38}. If you eat those with two spots, go to {63}. If you eat those with three dots, go to {25}."
},
{ // 90/12D
"You may subtract your Take That You Fiend from the troll's Monster Rating of 30. You must then fight the troll. [If you use magic, he will get all his hits on you, although you may do further damage to him. ]If you fight with weapons, consider that he gets ½ his current Monster Rating plus 1 die for each 10 left of his rating. If he wins, go to {98}. If you win, go to {73}."
},
{ // 91/12E
"The smell of the guano is getting to you. Quickly exit the cave, and go to {106}."
},
{ // 92/12F
"Consult the Magic Effects Table. Aside from any effect so generated, you also find a magic vase which has hitherto been invisible. It is about the size of a cereal bowl, has a mouth 6\" in diameter, and it can hold up to 2 cubic feet of stuff (assuming it can fit in the mouth of the bowl in the first place). It can hold up to 4000 weight units and remain the same weight. Some people would call this a modified kind of foldbox. The noise behind you continues. If you go back to the stairs, go to {68}. If you use an Unlock spell to open the door, go to {83}."
},
{ // 93/12G
"You hear a terrible moan. Now go to {134}."
},
{ // 94/12H
"The ghost has sucked 2 more Luck points from you. If your Luck has been reduced to 0, go to {98}. You may subtract your IQ in points from the Constitution of the ghost; Constitution is 17. If you killed the ghost, go to {124}. If you failed to kill the ghost, go to {107}."
},
{ // 95/13A
"You notice an immense green troll, dead ahead. It nearly blocks the passageway. As it moves, the malformed skull scrapes the ceiling. Its arms, which could be mistaken for moss-covered tree trunks, bump along the walls. The only way you can pass is between the troll's massive legs. If you are [already ]invisible, go to {102}. If you light the passage with a Will-o-the-Wisp, go to {39}. If you try to scare away this dim-witted creature of the underworld, casting a Panic, go to {55}. If you attempt to destroy him with that mighty incantation Take That You Fiend, go to {90}. If you think your tongue is more powerful than the troll's pea-sized brain and attempt communication, go to {127}. If you draw your puny weapons and try to fight the malodourous green beast, go to {119}."
},
{ // 96/13B
"Arriving at the bottom of the steps, you look around. To your right is another pile of decaying bones, the 13th pile. To your left is a grey stone door, discoloured here and there with purple lichen. That door is locked. Directly in front of you is a dimly illuminated hall. If you cast an Unlock spell on the stone door, go to {48}. If you walk down the passage, go to {18}. If you stick around this unhealthy place and cast a Revelation, go to {105} to see if you find anything but diptheria."
},
{ // 97/13C anti-cheat
"The battle-scarred, blue-grey octopus wraps 8 slimy, sinuous tentacles around your body, crushing your puny bones to powder. \"How many times must you be warned?\" hisses the creature from the deep. \"It makes the Dungeon Master very angry to find you reading passages you cannot reach!\""
},
{ // 98/13D
"Your body crumples to the floor. Your blood runs like a river, first into puddles and then in streams across the dusty, musty floor, finally congealing like raspberry jello. Ultimately it runs down a filthy sewer drain. Already rodents and other unmentionable creatures of the night are disposing of the edible parts of your body. Your bones will rot. Your character is dead. Tear up the card and close the book."
},
{ // 99/13E
"\"Indeed! What a fine wish! If only everyone could be so easily satisfied,\" says the genie. He picks up the brass lamp, rubs it three times and murmurs something in an ancient foreign tongue. There is a bright flash and when your eyes recover, the lamp and genie have disappeared. Mysteriously, there is a permanent smile on your face. A perpetual optimist, nothing can make you unhappy, even if a monster were dissecting you one cell at a time with porcupine quills. Now go to {106}, smiley."
},
{ // 100/13F
"The ghost grows ghastly. It looks - as if it had seen a ghost! It blanches and trembles, then regains its composure. \"That was very good,\" whispers the ghost. \"You must be one of us; I'm sorry to have disturbed you.\" It touches you again and a piercing hot pain rips into your chest where his fingers touched. Your Luck, however, is restored to its previous value. The ghost turns around, spinning faster and faster, looking like a white tornado, and then it vanishes. Go to {115}."
},
{ // 101/13G
"You are in the centre of a large dusty room. Rodent tracks crisscross the room and run across the wooden table. The table is 3' high, and on it are three boxes. One box is gold, one silver, and one is made of paper mache. A deep voice behind you moans eerily, \"One of these boxes contains gold. The rest contain something else! Seek, and ye shall be found.\" The voice is choked off, and you now have three choices. If you want to open a box, go to {108}. If you are afraid and seek an exit from the room, go to {121}. If you are totally frustrated, undecided, or foolhardy, you may kick over the table, spilling the boxes onto the floor, and then jump out the window. Should you choose to adopt this irrational action, go to {128}."
},
{ // 102/14A
"That lumbering hairy blob of a troll that's in front of you doesn't even see you yet! If you can't stand the sight of the ugly troll and want to fight it, go to {119}. If you'd rather try to quietly slip past the troll, go to {110}."
},
{ // 103/14B
"The door doesn't budge. You hear a loud \"HA-HA, HO-HO, HE-HE,\" from a hidden ghostly choir. The booming voice of the Dungeon Master rings out, \"When you're in, you're in!\" You realize that you can't get out this way. You may wait undisturbed two turns to regain your Strength. Then go to {37}."
},
{ // 104/14C
"The tiger, huge muscles rippling along its 12' frame, growls out that it has a thorn stuck in its paw. It asks you to come closer and pull out the thorn. It says its name is Mauler, the Claw, Pussycat. If you want to try to pull out the thorn, go to {130}. If you change your mind and try to attack the cat, go to {134}."
},
{ // 105/14D
"Your Revelation reveals that the 13th iron collar is really made of solid gold. [A knife or other sturdy weapon will easily pry it out of the wall. ]It is worth 125 gp. Now check the Magic Effects Table and see what else has happened. If you would like to continue down the hallway afterwards, go to {18}. If you cast an Unlock spell on the grey lichenous sandstone door, go to {48}."
},
{ // 106/14E
"You enter a small, well-lit room. On the far right wall is a giant green nostril. There are two other exits from the room which are both on the left side of the room. As you approach the quivering nose, it twitches (being allergic to delvers) and sneezes, blowing you backwards out an exit. Make a L1-SR on your Luck (20 - LK). If you miss, go to {221}. If you make the roll, you were blown out one of the two doorways with all you carry. Roll one die: if you rolled evens, go to {122}. If you roll odds, go to {136}."
},
{ // 107/14F
"\"Mooooooooooaaan,\" cries the ghost as he attacks again. His cold blue-white fingers freeze your skin where they touch. You lose 2 more points from your Luck. Your final attack should destroy the ghost, but if your Luck was reduced to 0, you have died. Go to {98} if this is so. If you survived, however, go to {124}."
},
{ // 108/14G
"You must choose which box to open. All three are clean of dust or any sign of tinkering. If you open the gold box, go to {138}. If you open the silver box, go to {143}. If you open the paper mache box, go to {150}."
},
{ // 109/14H
"A ghastly quiet pervades the halls. A light is on in the large room on the second floor. You are attracted to the middle of the room. Go to {101}. After you enter the room, the door swings shut and locks behind you."
},
{ // 110/15A
"Make a L1-SR on Luck (20 - LK). If you miss, go to {219}. Otherwise, you walk briskly for 5 turns and reach the end of the tunnel. [You may recover two of your lost Strength points (if necessary.) ]Now go to {161}."
},
{ // 111/15B
"He tells you to cast a Revelation when you leave. Then he hands you a glowing green diamond. Its value is 40 gp[ but more importantly, it increases your IQ by 1 when you touch it. Then the glow fades and the magic disappears]. Go to {147}."
},
{ // 112/15C
"You see a long dark stairway leading to the top floor of the mansion. You may walk or run up the stairs, for you can hear some creepies coming up behind you. If you walk up the stairs, and risk letting the indescribable crawling creepies catch up with you, go to {145}. If you run, go to {177}."
},
{ // 113/15D anti-cheat
"You were warned! You are turned into a granite statue. That's what you get for reading passages you cannot reach! Nowhere does it say \"...go to {113}.\" Cease and desist! Stone statues can't read anyway."
},
{ // 114/15E
"The hairy red wart rushes past your shoulder, hits the cold stone floor and dies. You get 5 ap for killing a poor defenceless little creature, you brute. You will find the red alcove to be empty, just for that. Now you must go back down the cold, dark, damp tunnel all alone! If you run, go to {161}. If you walk, go to {214}."
},
{ // 115/15F
"You notice a cloud of dust in the air where the ghost was. Close examination of this cloud reveals it is diamond dust. You may pick up your IQ's worth of diamond powder. (That is, an IQ of 10 gets 10 weight units of dust at 10 gp per weight unit, or 100 gp.). Now go to {109}."
},
{ // 116/15G
"Make a L1-SR on Luck (20 - LK). If you miss this roll, go to {223}. If you make the roll, you will travel down the corridor in the dark without noticing anything. If you make the roll, go to {26}."
},
{ // 117/15H
"The witch will talk, but she isn't very friendly. She suspects that you may be the demon that she unsuccessfully tried to conjure last week. So she won't attack you yet! She spits out some expletives at you and says you are to leave the area immediately. You spy a partly open secret panel which exposes a flight of stairs leading down. If you want to stay and fight with the witch, go to {211}. If you would rather escape while you are still humanoid, go to {220}."
},
{ // 118/16A
"You notice a glitter on the floor just as you leave the area. It is a jewel worth 20 gp, weighs 2. You may pick it up as you walk by. You also get 30 ap for your encounter. Now go to {10}."
},
{ // 119/16B
"The ugly troll has a Monster Rating of 30, giving him 3 dice and 15 adds on the first combat turn. [However, because he hates pain so, if you get hits against him, you find his Constitution is only 15. ]If you survive, killing the troll, go to {73}. If you lose and die, go to {98}."
},
{ // 120/16C
"There is nothing else to be seen in the area. It is as bare as the stomach of a hungry dungeon delver. You continue calmly down the corridor and come to a fork. Three turns passed while you were walking; these turns may be used to regain lost Strength. If you take the left passageway at the fork, go to {10}. If you go to the right, go to {148}."
},
{ // 121/16D
"You were warned, \"If you seek, you shall be found.\" You see no other exit from the room except for the window. Since it is now night, you can see nothing outside. You hear something rustling inside one of the boxes; then it pounces. Go to {143}."
},
{ // 122/16E
"You are in a large room. There are three long tables in the room which are lined with bottles of chemicals, beakers, glass tubes and lit bunsen burners. A sign on the far wall says:\n" \
"    SILENCE\n" \
"    MONSTER LABORATORY\n" \
"    (NO GROWLING)\n" \
"There are four glasses at the end of one table, and three of them are full of sweet-smelling, bubbling liquid. There is a sign near each glass, and each sign says the same thing: \"You may drink only one.\" Each sign is imprinted over a red skull and crossbones. You may drink from the glass of red liquid and go to {167}, or from the glass of green solution, and go to {131}. If you drink the blue liquid, go to {174}. If you mix them together in the empty beaker, and drink that, go to {151}."
},
{ // 123/16F
"You can hear obnoxious noises from various weird beasties as you cross the room, but because it is dark they cannot see you. Emerging from the dark room, you come into another room that is well-lit. Go to {195} to see what is in the next room."
},
{ // 124/16G
"As the ghost moans his last moan and clanks his last chain, you get 65 ap for dissipating the little beggar. His chains, you discover, are solid gold and worth 15 gp. You may rest up to 10 turns to regain your Strength, if you wish. Then you may continue down a lit corridor to {26}."
},
{ // 125/17A
"Defend yourself! You are under attack. Your opponent gets 2 dice plus 12 adds every turn. If you are lucky enough to get hits on him, you will find that his Constitution is 12. You will probably die, however; if you do, go to {98}. If somehow you escape premature death, go to {139}."
},
{ // 126/17B
"Your feet patter lightly across the stone floor. At last you make it to the other side. After you leave the room, go to {81}."
},
{ // 127/17C
"The monster's reaction will depend on how likeable you are. If you have a Charisma less than 12, well, good luck and nice having you, but go to {119} and see what happens to you. If your Charisma is 12 or more, make a first-level saving roll on Charisma (20 - CHR) and if you miss that, then follow the unlikeables to 119. If you made the saving roll, however, go to {133}."
},
{ // 128/17D
"The heavy oaken table crashes to the floor, crushing all three boxes. The treasure they contain is destroyed, but so are the monsters. As the thin blue blood trickles out from under the table and you realize what you've done. Take 75 ap for being a mad killer. Now make a saving roll (20 - LK). If you miss your saving roll, you must take the difference in hits to your Constitution. You jumped through a glass window, you dummy! Next time, open it first. If you made your saving roll, you miraculously escaped serious injury. Now you are flying out into the brisk night air, high above the ground. Falling, falling, falling, you finally fall into {186}."
},
{ // 129/17E
"You get a treasure of 15 diamonds, each worth 10 gp and weighing 1 weight unit. If you use a light, natural or magical, to look around the room, you will not see or find anything else of value. There are no other exits, so you leave by going back into the corridor. Something large and nasty is making its way down the stairs. The only safe path you can take is deeper down the long dark tunnel. You can walk, or you can run down the corridor. If you walk, go to {206}. If you run, go to {18}."
},
{ // 130/17F
"He does in fact have a large rose thorn in his front paw. It comes out with little difficulty, and he is so happy he licks your face. In reward, he gives you the jewels he has collected from previous deceased dungeon delvers. Jewels are of no use to a cat, after all. You get 245 gp worth of rubies, with total weight of 30. There is nothing else of value in the room. If you wish to wait until your Strength returns, you may. Then you must leave by going down the long hallway, for there are no other exits from the room. Go to {18}."
},
{ // 131/17G
"Your nostrils burn as the cool liquid flows down your gullet. Make a L1-SR on your Luck (20 - LK). If you miss the saving roll, go to {207}. If you make the roll, add 10 to your Charisma. Then you pass out cold. Go to {169}."
},
{ // 132/18A
"The skull vanished as you started your magic, so your spell is irrelevant although it worked normally. You may wait 2 turns to regain your Strength, then must move on to {37}."
},
{ // 133/18B
"He likes you! If your Charisma is 20 or greater, go to {140}. If your Charisma is less than 20, go to {111}."
},
{ // 134/18C
"Mauler, the Claw, Pussycat, has been watching you closely. Then he reels back into his corner at your approach. Then he mews piteously \"Don't hurt me, please don't hurt me! You can take all my treasure, anything, but don't hurt me!\" If you maliciously continue your attack, go to {166}. If you stop and talk with him, he puts out his forepaw towards you. Go to {130}."
},
{ // 135/18D
"\"Woe is me,\" cackles the wart. \"I have lost my monster. My name is Wally; Wally the Wart is what my old troll used to call me.\" It edges closer to you, moaning hypnotically. Then it leaps out at you. If you let it land on you, go to {183}. If you try to duck out of the way, make a L1-SR (20 - LK). If you miss the roll, go to {183}. If you make the roll, go to {114}."
},
{ // 136/18E
"You enter a huge well-lit room. There was a sign just outside the door which read \"Monster Reconditioning and Experimentation\". Inside is a small man in a white lab coat. He is pushing buttons, pulling levers, stepping on switches. Sparks fly, radiation pulses, bells ring and buzzers buzz. A dozen dead monsters line the walls. Go to {144}."
},
{ // 137/18F
"Finally, when both warriors are nearly exhausted, they turn to you. Both are unhappy you haven't helped. Their disagreement is minor compared to your arrogance. They nod to each other and then attack you. They have lost or broken their own weapons and are attacking you with their bare hands. Roll one die to find the results of the battle:\n" \
"    1 - You kill Edgard but Henry kills you. Go to {98}.\n" \
"    2 - You kill Henry but Edgard kills you. Go to {98}.\n" \
"    3 - You kill both but must take 15 hits.\n" \
"    4 - You kill both but must take 10 hits.\n" \
"    5 - You kill both but must take 5 hits.\n" \
"    6 - You kill both and are unhurt.\n" \
"You may take hits on your armour, if applicable. If you survive, go to {168}."
},
{ // 138/18G
"A small snake, a delicate green viper with glistening fangs, leaps out at you. Make a L1-SR on your Dexterity (20 - DEX) to avoid its strike. If you miss the saving roll, the fangs sink into your flesh and its fatal venom quickly destroys your nervous system. Go to {98} if this is so. If you make the saving roll or if you are immune to poison, take one hit directly off your Constitution and then kill that obnoxious green reptile. If you survive, go to {225}."
},
{ // 139/19A
"Congratulations! You can take 3 items off the body. First is a lucky rabbit's foot. [This adds 2 to your Luck when it is touched. It only works once. ]Second, there is an ordinary buckler[, which takes one hit in combat]. Last, there is a dagger which emanates magic. He didn't use it, you recall. If you pick up the dagger, go to {149}. If you do not take the dagger, but take the other items, go to {120}."
},
{ // 140/19B
"He loves you so much that he turns over his treasure and leaves. Go to {64}."
},
{ // 141/19C
"Make a L1-SR on your IQ (20 - IQ). If you make the roll go to {217}. If you miss your saving roll, go to {44}. In either case, do *not* refer to the Magic Effects Table for this time only."
},
{ // 142/19D
"Make a L1-SR on Dexterity (20 - DEX). If you make the saving roll, you were able to snatch the jewel, a topaz worth 50 gp and weighing 5 weight units. However, if you missed the saving roll, it slipped from your grasp and you dropped it. It rolls away out of reach. Now you must make a L1-SR on Luck (20 - LK) to see if you escape. If you escape, you may run out the door into the long corridor, and on to 18. If you missed the saving roll, you must turn and face the giant saber-tooth tiger who has growled out his name - Mauler, the Claw, Pussycat - so draw your weapon and go to {134}."
},
{ // 143/19E
"Out leaps a small jumping tarantula. It is angry at being disturbed. You may attack it simultaneously. It gets just 2 dice, and you may take hits on your armour. If you successfully parry the furry fiend's attack, go to {175}. If you have been killed (unlikely, unless you are a 97# weakling), it will suck out your blood, as much as it can hold. Go to {98}."
},
{ // 144/19F
"Suddenly, the technician who is operating the controls sees you. He immediately screams out, \"Help! A delver is loose in the Reconditioning Room!\" Then he flees out of the room. As he leaves, the monster he was working on (a giant Gobbler) gets out of control. Mindlessly, the Gobbler starts eating everything in sight. You realize that the giant brown Gobbler will quickly eat you, the lab, and finally the whole dungeon! And even then, it will still be hungry. You are near the console that the technician was working at. On the console are 5 buttons - each button has a label, but the labels are written in a language you cannot read. You must punch the correct button to save yourself and indeed, the whole dungeon. The five buttons are coloured red, yellow, green, blue and white. If you punch the red button, go to {159}. If you hit the yellow button, go to {184}. If you tap the green button, go to {21}. If you press the white button, go to {178}. If you stab the blue button, go to {204}."
},
{ // 145/19G
"As you climb the stairs, your footsteps reverberate in the stairway. The creepies think you must be an army, and they retreat. Go to {185}."
},
{ // 146/20A
"The door leads to a long dark corridor. You can see a light in the distance. There is some noise at the other end, too. If you toss a Will-o-the-Wisp so that you can see, go to {26}. If you walk in the dark, go to {116}."
},
{ // 147/20B
"About 200' further down the way you detect that part of the wall is magical. Do you trust the troll's advice and do a Revelation? Is so, go to {155}. If not, go to {110}."
},
{ // 148/20C
"This path is getting colder and darker fast. If you go back, go to {10}. If you do a Will-o-the-Wisp, go to {9}. If you cast a Detect Magic, go to {156}."
},
{ // 149/20D
"The dagger has been ensorcelled by a 17th level mage. The demon of black mindless madness was trapped inside the dagger's hilt. When you picked up the dagger, the demon entered your body. [This demon will force you to go berserk whenever you see blood: yours, a friend's or monsters'. If you are alone, the berserkness will cease after 3 combat turns once your foe is slain. If you are with anyone else, you must be calmed, be killed, or you will try to kill everything near you. (See the Berserker rules in the Rulebook). The demon also speeds up time, so that you get two combat turns to every one of your foes'. This works only when you are actually in combat. ]You may not get rid of the dagger[, for Krwonsku, the demon inhabiting your body, will kill you and send your soul to slavery]. Go to {120}."
},
{ // 150/20E
"Inside the box is one gold piece. Also, there is one more item in the box. Roll 1 six-sided die to determine what else there is.\n" \
"    1 - Vial of green liquid: one application of Too-Bad Toxin liquid.\n" \
"    2 - Vial of blue liquid: 1 application of Cateyes liquid.\n" \
"    3 - Vial of clear liquid: 1 deadly dose of arsenic, clearly labelled.\n" \
"    4 - 1 flawless sapphire, worth 20 gp, weight of 1.\n" \
"    5 - 1 scorpion, MR of 10 which attacks. All hits may be taken on your armour, if applicable, but it *will* get hits on you if you use magic.\n" \
"    6 - 1 demon, MR of 500 which attacks all elves. Other characters it will ignore unless attacked first.\n" \
"The vials may be saved. If you die, go to {98}. Otherwise, go to {158}."
},
{ // 151/20F
"The words \"Drink only one\" rattle through your empty brain. You suffer spontaneous combustion and are reduced to a pile of ashes. You are dead. Close the book."
},
{ // 152/20G
"As you leave the room, a heavy iron door drops down, sealing the princess inside the room. It is too heavy to lift and magic does not affect it. The princess is trapped once more. Go on to {188}."
},
{ // 153/20H
"Take 50 ap for defeating the dungeon's demon soulsucker. You appear to be in a safe place. If you wish to leave immediately, go to {112}. If you want to rest for 2 turns, go to {80}. If you take a short nap and recover all your Strength, go to {45}."
},
{ // 154/21A
"The battle continues to rage. The white warrior hacks with his falchion repeatedly at his opponent's target shield until the shield is reduced to tatters. Chunks of rended armour, shields, and broken weapons litter the floor. The white warrior's buckler is shredded with a deft slash from the knife of the black warrior. Now go to {137}."
},
{ // 155/21B
"As soon as you cast your Revelation, a 5' section of the wall vanishes, exposing a cold little alcove, glowing with an unearthly red light. Cringing in a corner is a hairy red wart. Though it has no legs, it moves; though it has no mouth, it speaks. Check the Magic Effects Table and then go to {135}."
},
{ // 156/21C
"A wall of prickly pear cactus magically appears to bar further forward progress. The cactus is almost as tough as steel; its spines are tougher yet. It extends from floor to ceiling; the branches are so close together that even a cockroach could not squeeze through. As you glance around, you notice four cracks in the left wall that seem to outline a doorway. It slithers back when you touch it. If you want to go into the blackness behind the doorway, go to {165}. If you are chicken, your lily-white knees shaking uncontrollably, and want to turn back at this critical moment, go to {10}."
},
{ // 157/21D
"You are face to face with an old, faded ghost with a reddish beard. He stretches out a faded, misty arm to touch you. His fingers suck 2 points off your Luck. He withdraws for a second, then reaches out to touch you with both hands! If you cast a Will-o-the-Wisp, go to {86}. If you do a Take That You Fiend, go to {94}. If you throw a Panic, go to {100}."
},
{ // 158/21E
"You may look in another box if you like, or you can jump out the window. [Do not look in any box you have already looked in, because you know what is in it. ]If you want to look in the gold box, go to {138}. If you try the silver box, go to {143}. If you try the paper mache box, go to {150}. There is no other exit from the room except for the window. You can stay here and starve or you can leap from that window. If you jump into the black void, go to {186} to see what you fall into."
},
{ // 159/21F
"When you hit the red button, another monster is released! Now there are two monsters rampaging in the lab. When the two monsters see each other, they turn and fight. The two Gobblers are evenly matched and after a few minutes they have consumed each other. Nothing is left, not even a drumstick. You have saved yourself, and the dungeon too. Go to {171}."
},
{ // 160/21G
"You may strip her of all her belongings. She has a battered, non-magical medallion worth 2 gp which weighs 20. You may also take her other treasure. Roll one die to determine what else; she has only one of the following:\n" \
"    1 - Nonmagical emerald worth 15 gp, weighs 2.\n" \
"    2 - Nonmagical amethyst, worth 20 gp, weighs 5.\n" \
"    3 - Magical ruby worth 75 gp but subtracts 1 from your Constitution when touched. Weighs 10.\n" \
"    4 - Magical sapphire, worth 90 gp, subtracts 1 from your Dexterity. Weighs 10.\n" \
"    5 - Magical topaz, worth 105 gp, adds 1 to Luck. Weighs 15.\n" \
"    6 - She hits you over the head with her chains and when you regain consciousness, she is gone. So is everything you were carrying. The Dungeon Master thinks you are an inconsiderate cur and subtracts one from your Charisma automatically.\n" \
"Exit the room and go to {188}."
},
{ // 161/22A
"Leaving the damp tunnel, you enter a room hewn from solid rock. Something tiny hits you on the shoulder with a splat! Water is dripping from the ceiling, running down the walls, and out through cracks along the floor. Except for the sounds of the water, there is absolute silence; you could hear a worm belch. Phosphorescent fungus coats the walls and emits a dim yellow glow so that you can see about you. Now go to {57}."
},
{ // 162/22B
"While you are casting magic, the warrior in white lunges at you. Brandishing his falchion wickedly, he carves into you with 3 dice + 2. (These hits may be taken on armour, if applicable.) Your spells will kill him also, as he has only a small Constitution left. However, if you have died, go to {98}. If you survive his attack, go to {168}."
},
{ // 163/22C
"Your spell reveals a magic panel just inside the door. The monster has its eyes glued to your every movement. The panel slides open at your touch, and the sound annoys the cat. You feel the cat's breath on your neck; it smells like decayed human flesh, dragon vomit, and minced dwarf liver. Inside the panel is a topaz. You can take the jewel and try to run, or you can turn and fight. If you grab the jewel, go to {142}. If you turn and face the cat, 134."
},
{ // 164/22D anti-cheat
"A large purple troll approaches. The foolish creature trips on a blade of grass, it is so stupid and clumsy. When the troll and you eventually meet, the creature pulls off your right arm in excitement. Realizing its mistake, it puts your arm back in the sleeve and pulls off your other arm, the one holding this copy of the dungeon. The troll won't give you the book back until you promise to stop reading sections - like this one - that you were never told to go to! So stop already!"
},
{ // 165/22E
"As you step out into the darkness you hear a \"Skreeee-CLICK!\" as the door closes tightly behind you. A cobweb brushes your forehead and something cold and small runs down your arm. Nearby you hear the drip...drip...drip of leaking water. Cast a Will-o-the-Wisp and you find you are in a small cave decorated with stalactites and stalagmites. Ten gold nuggets are lying on the floor. They weigh 50 each and are worth the same, making a total of 500 gp. When you leave you must use an Unlock spell on the door; there is no other escape. You may wait to regain Strength. To leave, go to {10}. If you can't cast the spell, you are trapped, so count your days and close the book."
},
{ // 166/22F
"Mauler, the Claw, Pussycat clearly did not desire a fight. In the barbaric crudeness of continuing your attack, you discover just what kind of Monster Rating he's got. You suspect it must be at least three or four digits long as he rips you to shreds, favouring one paw all the while..."
},
{ // 167/23A
"Your throat burns and the room spins through a red veil. Roll 1 six-sided die to determine the effect:\n" \
"    1 - Add 4 to your IQ.\n" \
"    2 - Add 8 to your IQ.\n" \
"    3 - Add 12 to your IQ.\n" \
"    4 - You are turned into a solid gold, living statue worth your weight in gold. Monsters are more prone to trick or kill for your body; anyone with a Charisma less than 11 will automatically attack. Your attributes are unchanged. Because gold is soft, it does not act as armour. You can't swim, but you don't need to breathe either.\n" \
"    5 - Subtract 5 from your IQ.\n" \
"    6 - Subtract 10 from your IQ.\n" \
"Then you pass out. When you awaken, go to {169}."
},
{ // 168/23B
"You collect 175 ap for beating Henry and Edgard. Most of their gear was destroyed in the fight, but, searching about, you can find a good buckler and a main gauche. There is a magic set of ring mail (takes 7 hits). [Its magical property is that it will adjust to fit anyone. ]You find 240 gp and a bottle of cobra venom. You may rest for up to 6 turns to regain Strength. Then leave by going down the stairs to {81}."
},
{ // 169/23C
"You awaken outside the dungeon where the guards dumped you with all your gear. It is dusk now, and you have slept all night and most of the day. (You were left in a shady spot if you were a vampire; the sun's rays did not find you). You may now leave, or you may reenter the dungeon. If you go back inside, wait for night and go to {1}. If you leave now, take 100 ap for exiting the dungeon alive."
},
{ // 170/23D
"You get 10 ap and a box worth 90 gp. Now go to {158}."
},
{ // 171/23E
"You will find lots of treasure here. There is more copper than you can carry. There are 1000 silver pieces (worth 100 gp, remember) and 120 gp. There is also a pouch of jewels worth a total of 135 gp; the pouch weighs 40. You may sleep to regain your Strength; then go to {169}."
},
{ // 172/23F
"If you search the alcove, you notice several rocks are really large rubies, but they are very hard to discern in the red light that floods the area. You may gather your IQ's worth of 1-weight rubies, each worth 8 gp. If you are a dwarf, human, or hobbit, you may also locate your Luck's worth of 1-weight diamonds, each worth 10 gp. If you wish to further search the area by casting a Detect Magic or a Revelation, go to {218}. If you leave to return down the tunnel, go to {161}."
},
{ // 173/23G
"Roll one 6-sided die to determine what you get. Do this only once. When done, go to {191}.\n" \
"    1 - A warty toad that passes on its affliction to you. Lose 5 Charisma points.\n" \
"    2 - Fool's gold. Lose 100 gp worth of treasure.\n" \
"    3 - A chicken dinner. Add 2 Strength and 1 Constitution point.\n" \
"    4 - A fish dinner. Add 3 IQ points.\n" \
"    5 - A toadstool dinner. Make your L1-SR (20 - LK), or die!\n" \
"    6 - A dream of hearty adventure; get 250 ap."
},
{ // 174/24A
"Blue dots appear in front of your eyes, and they get closer and closer. Then they touch you and the room fades away. Roll one 6-sided die to determine the effect.\n" \
"    l - Add 5 to your Strength.\n" \
"    2 - Add 5 to your Constitution.\n" \
"    3 - Add 5 to your Luck.\n" \
"    4 - Add 5 to your Dexterity.\n" \
"    5 - Divide your Luck in half.\n" \
"    6 - Divide your Constitution in half.\n" \
"Then you pass out. When you waken, go to {169}."
},
{ // 175/24B
"You get 5 ap for killing the spider. The silver box is empty, but it is worth 10 gp (weighs 100). If you are a vampire, you cannot take it. Go to {158}."
},
{ // 176/24C
"Make a L1-SR on Luck (20 - LK). If you miss, you dropped all the treasure you were carrying. Lucky for you, the dragon didn't notice you, as there were dozens of other small creatures fleeing. Now go to {110}."
},
{ // 177/24D
"As you run up the stairs, ahead of the slow-moving creepies, your foot gets caught and twists your ankle. As you frantically pull away, the shoe comes lose and comes off. You have two choices. You may go back for the shoe, {208}, or you can limp along without it, {216}."
},
{ // 178/24E
"A large \"Out Of Order\" sign flashes vividly over the buttons. Nothing seems to happen. The monster continues to rage out of control, and it has already destroyed half the room. If you don't hit the right button this time, you will be dead. For the red button, go to {159}. Yellow button, {184}. If you poke the green button, {21}. If you stab the blue button, go to {204}."
},
{ // 179/24F
"You immediately notice a deluxe staff propped in the corner of the room. You may pick it up if you first throw away your old staff. It is worth 500 gp resale value and it knows all the first level spells. If you already have a deluxe staff, you will not be able to pick up this one. There is nothing else of value in the room, so go your way to {195}."
},
{ // 180/24G
"Go to {202}."
},
{ // 181/24H
"Go to {191}."
},
{ // 182/24I
"The thing found you in the dark, remember? It doesn't need to see you to destroy you. Go to {44}; you needn't bother checking the Magic Effects Table."
},
{ // 183/25A
"Wally the Wart lands on your cheek, digs its extremities into your flesh and merges into your skin. You now have a large, red, hairy wart on your cheek. It is virtually impossible to remove. It is over half the size of your own nose, so it looks like you have two noses. The wart subtracts half your Charisma but adds 5 to your Constitution. (It is a very tough wart!) Your second nose sighs, \"Ah, home sweet home,\" and then remains silent. Go to {172}."
},
{ // 184/25B
"When you hit the button, a register glows red and burns out with a loud bang! The Gobbler stops dead in its tracks and falls over. For saving the dungeon you will be rewarded. Go to {171}."
},
{ // 185/25C
"You emerge out of breath but safe at the top of the stairs. You are in a cold dark room and cannot see. If you strike a match, or make any kind of light, go to {179}. If you proceed across the room in the darkness, go to {123}."
},
{ // 186/25D
"Down, down, down you go, and where you stop, the GM knows! You crash through a tin roof. Make a L1-SR on Luck (20 - LK). If you make the roll, go to {209}. If you missed the saving roll, take the number you missed by directly off your Constitution. You landed right on top of a tough little witch and killed her. Go to {212}."
},
{ // 187/25E
"The other ghosts, seeing the leader leaving, mingle about, confused. Then they also leave. Take 100 ap for defeating the ghosts. You find a golden sceptre on the ground - it is worth 1 die in combat and is worth 100 gp for its decoration (which you may mar if you use it as a weapon. It weighs 50, and that is also its value if you batter it into a shapeless piece of metal). It is non-magical. Finish walking the path you were on when the ghosts interrupted you and go to {57}."
},
{ // 188/25F
"Leaving the room behind, you start down a narrow corridor. Make a L1-SR (20 - LK). If you miss this saving roll, go to {202}. If you make the roll, you successfully get through the corridor. Go on to {194}."
},
{ // 189/25G
"Roll 1 six-sided die; the roll determines what you get.\n" \
"    l - Inflatable air mattress[, good for 1 person in quiet water].\n" \
"    2 - Beryl worth 100 gp, weighs 20.\n" \
"    3 - Magic ring.[ Adds 1 to your roll when you need to make a saving roll.]\n" \
"    4 - Silver arrow, through your chest for 18 hits.\n" \
"    5 - A poison capsule[, which will kill anything that eats it, if they miss their SR].\n" \
"    6 - A tuft of Samson's hair in an amulet[ - add 2 Strength points].\n" \
"Now go to {191}."
},
{ // 190/26A
"Looking back, you see you stumbled over an old brass lamp. With an outstanding display of pyrotechnics, an old gnarled genie appears. He says he is the genie of the lamp and will grant you one wish. If you wish for health, go to {51}. If you wish for wealth, go to {58}. If you wish for happiness, go to {99}."
},
{ // 191/26B
"You find a large door marked \"EXIT\". Go to {106}."
},
{ // 192/26C
"The princess walked safely out of the room, down the corridor and entered the room with the fountain. Now it is your turn! Make a L1-SR on Luck (20 - LK). If you make it, go to {215}. If you missed, you stumbled into something - go to {180}."
},
{ // 193/26D
"He snaps his fingers and the 2 eyes on the *front* of your head are gone! Now you indeed have only 2 eyes, but they are on the *back* of your head. Your Luck drops 8 points, to what it was before, but you are just as ugly as ever. You can now see only behind you. The genie and lamp disappear. Go to {106}."
},
{ // 194/26E
"You enter a small room with a fountain. The sparkling waters glisten with all the colours of the spectrum. The sign over the fountain reads \"Wishing Well\". You may bypass the fountain and leave the room - go to {181}. If you toss a gold coin in the fountain and wish, go to {201}. If you toss a silver coin, go to {189}. If you toss a copper coin, go to {173}."
},
{ // 195/26F
"You enter a small, dimly lit room. A young red-headed girl is chained to the wall. She doesn't appear dangerous, nor does she seem to have anything of value. You can rob, rescue, or simply ignore the pitiful girl. If you free her from her chains, rescuing her, go to {198}. If you search her for treasure, stripping her naked in your pursuit of loot, go to {160}. If you'd rather just ignore her and leave the room, go to {188}."
},
{ // 196/26G
"You are fighting a demon with a Monster Rating of 1250. [Remember that you are in darkness, so the rating is doubled (2500). All of your non-magical weapons will work, but no others. ]If you die in battle (you call that battle?!), go to {98}. If you survive, the DM tosses you out of the dungeon and fines you 1000 ap for being so tacky as to take that character in this dungeon!"
},
{ // 197/26H
"You hear a loud crash, and dust and flying pebbles fill the air. There has been a cave-in back the way you came. You must proceed the way you were going, now, because the tunnel is completely blocked with dirt and boulders. Go to {87}."
},
{ // 198/27A
"The girl thanks you for rescuing her. She says she is a princess, and that you will be well rewarded for helping her to escape from the dungeon. You will receive 300 ap *if* you can escort her safely out of the dungeon. You can see she is telling the truth by her demeanor, posture, and noble bearing. Also by the bracelet she gives you; it has the seal of the royal house on it, and it is worth 125 gp. You must leave quickly now, as the ogre who had captured her (and was going to force her to a fate worse than death!) will return soon. There is only one exit from the room, a locked heavy iron door. An Unlock spell will open it. Will you be gallant and allow her to exit first, or will you nobly scout ahead of her? If you leave first, go to {152}. If the princess leaves first, go to {22}. ([Before you go, however, roll up the other attributes of the princess. ]She has a Luck of 11[, and will get twice what you roll for Charisma]. She has no magical ability.)"
},
{ // 199/27B anti-cheat
"The genie grabs you by the neck and twists your head off. \"That will make it hard,\" says he, \"to read passages you can't reach properly!\" Close the book, you fool."
},
{ // 200/27C
"A 3' wide hole opens up in the floor and you can hear the princess' screams fade into the distance. It is a bottomless pit. Too bad - you won't get any experience points for saving her. A careful search shows no other traps to menace you. Go to {194}."
},
{ // 201/27D
"After you toss a coin into the fountain, you feel a bit dizzy and different. Roll one 6-sided die to determine what happens.\n" \
"    1 - Attacked by a frog with a Monster Rating of 15.\n" \
"    2 - Find 100 gp in the fountain.\n" \
"    3 - Find a Staff Ordinaire in the fountain.\n" \
"    4 - Find an EverRite Quill Pen that writes anywhere, any time.\n" \
"    5 - Increase all attributes by 2.\n" \
"    6 - Decrease IQ by 5.\n" \
"Now go to {191}."
},
{ // 202/27E
"As you started up the corridor a bit of sand sprinkled down your neck. Glancing up, you see the sand followed by dirt, large rocks and heavy oaken roofing beams. One of the beams smashes into your head for 10 hits. [(You may only count helms, steel caps and the like as armour in this instance.) ]If you die, go to {98}. If you survive, the room will spin dizzily for a while, but you can continue. Go to {194}."
},
{ // 203/27F
"The bat bites take effect! You have become a vampire! Double your Strength but cut Charisma in half (rounding up). [Vampires thus created cannot be killed by normal combat (the pieces will crawl back together in time), but magic, silver, or wooden weapons have FIVE TIMES normal effect. Full sunlight will kill in 3 turns. You are now forever repelled by religious objects, silver, and light. You may add 1 to your Strength every time you drink blood from a human *if* you are inside a dungeon only! You may not increase your Charisma through level adds. ]Now go to {74}."
},
{ // 204/28A
"Make a L1-SR on Luck (20 - LK). If you missed, the monster killed you before you could press the button. If this is the case, go to {98}. If you made your saving roll, you stabbed the button and a violent stream of sparks shot out of the wall, killing the Gobbler. The fried corpse grunts once, then topples and lands with a loud crash. For your reward, go to {171}."
},
{ // 205/28B
"Your attack made the other ghosts angry. Their cold mists settle around your helpless body and your limbs become numb and useless from the chill. In moments you become a flesh-flavoured popsicle, as the ghosts suck out 70 Constitution points each turn. You have died. Close the book."
},
{ // 206/28C
"You notice several glittering golden nuggets in the walls of the corridor. You may collect your IQ's worth of gold nuggets which each weigh 1 and are worth 1 gold piece. Go to {18}."
},
{ // 207/28D
"The cool liquid causes your Charisma to be cut in half. Then you pass out. Go to {169}."
},
{ // 208/28E
"Your shoe is several steps back down the stairs, if you go back for it. Meanwhile, the creepies scent fresh meat (your dainty toes) and decide to attack. You are buried under an avalanche of creeping, slithering, quivering, slimy creepies. Their green and pink bodies hold you down and convert you into raw hamburger. You are dead. Close the book and tear up the card."
},
{ // 209/28F
"You have landed in a potful of watery goop. Nearby is a frail-looking old hag dressed in black. She reeks of magical ability and you are standing in her latest pot of Black-Magic Mush. Roll one die to see what effect it has on you:\n" \
"    1 - Turns you into a large green toad. The witch then slices you into parts suitable for use in her next recipe. Close the book.\n" \
"    2[ - Permanently nullifies all magical items you carry, including staves.]\n" \
"    3 - Cast a Witless on you, reducing your IQ to 3.\n" \
"    4[ - Will allow you to do a Summoning spell once only for free, if you have the IQ and Dexterity to handle a 7th level spell. The demon will last a maximum of 10 turns, and then will vanish.]\n" \
"    5 - The foul-smelling brew makes you poison-proof.\n" \
"    6 - The stew increases your IQ by 4.\n" \
"The witch is still startled by your sudden and unorthodox appearance. You may try to talk to her by going to {117}, or you can attack her by going to {211}."
},
{ // 210/28G
"You search and search fruitlessly. The darkness extends infinitely in all directions. You feel the evil drawing closer, and soon it will be upon you. If you want to use your magic, go to {69}. If you wish to fight with weapons, although you are in the dark, go to {222}."
},
{ // 211/29A
"The battle is simultaneous but brief. Roll one 6-sided die to determine the result:\n" \
"    l:   You are turned into a hollow log. The witch's pet termites deliver a slow and agonizing death. Tear up the card and close the book.\n" \
"    2:   You kill the witch, but with her last gasp, she turns you into a butterfly with a Monster Rating of 1. Consider yourself dead. Close the book.\n" \
"    3:   You kill the witch, but she tosses off a final Take That You Fiend which knocks 12 from your Constitution. If you die, go to {98}.\n" \
"    4-6: You kill the witch and escape unharmed.\n" \
"If you survive, go to {212}...the next paragraph...to see what there is to see."
},
{ // 212/29B
"You get 100 ap for disposing of the witch. Now you may tame her black cat (originally named 'Blackie') if you can make a L1-SR on your Charisma (20 - CHR). If you miss the roll, the cat ignores your overtures of companionship, scratches you, and flees. The cat can obey simple commands, and if he crosses the path of any creature, that creature will fail to make its next saving roll. The cat has a Monster Rating of 10. Although there are no doors leading from the room, you can locate a partly open panel hidden in one wall. It opens out onto a flight of stairs which lead down. Go to {220}."
},
{ // 213/29C
"The bat bites had no effect on you. Go to {106}."
},
{ // 214/29D
"You find 75 gp worth of jade. This weighs 10 weight units. Now go to {161}."
},
{ // 215/29E
"You may continue on without encountering wandering monsters, tripping traps, or having any other bad encounters. To see what is in the next room, go to {194}."
},
{ // 216/29F
"It is harder to move, travel, and fight effectively when you are missing your shoe. For the rest of this trip, you must subtract 1 from any saving roll you are told to make. (That is, if you need to roll an 8 to make the roll, you will hereafter have to roll a 9.) [Also, subtract 2 from any weapons attacks you make. ]You may now limp along to {185}, as the creepies have given up."
},
{ // 217/29G
"You see a small nude demon. It has the body of a snake, the wings of a buzzard, and the head of a giant mosquito. Its tail is coiled about your ankle. The blackness vanishes. When the demon realizes that it has been seen, it flees (after all, it has no clothes!). You are instantly transported into the next room, so go to {153}."
},
{ // 218/30A
"Your spells and searching locate nothing. The room is bare. Do not roll (this time) on the Magic Effects Chart. Go to {161}."
},
{ // 219/30B
"An ugly hairy red wart leaps out of a hidden cubbyhole. In the narrow corridor, with no warning, it is impossible to duck. It hits you in the face. Go to {183}."
},
{ // 220/30C
"The stairs descend just 5' into a small room. Go to {57}."
},
{ // 221/30D
"When the giant nostril sneezes, you are smashed against the wall from the concussion. Unfortunately for you, you landed in such a way that it instantly broke every bone in your body. At least this way you won't catch the nose's cold...Close the book, it's all over."
},
{ // 222/30E
"Ha, ha, ha! You want to pit your puny weapons against the invisible, magical, maliciously evil demon - and on the demon's home turf yet! You must surely have an IQ under 5! Make a L1-SR on Luck (20 - LK). If you make this roll, go to {196}. If you miss, go to {44}."
},
{ // 223/30F
"What a pity - you stepped on a secret panel which triggered a trap. A square panel 10' wide and 10' high and covered with long steel spikes, pops out of the left wall and pins you to the right wall. If you can take 100 hits, you can survive. Extricate yourself and go to {26}. If you died, go to {98}."
},
{ // 224/30G
"You'll know better next time, so increase your IQ by 3, but take a cut of 5 from your Dexterity. Return now to {91}."
},
{ // 225/30H
"There is more than just a snake in this box. Roll 1 six-sided die to determine what it is.\n" \
"    l - A moonstone, nonmagical, worth 100 gp, weighs 5.\n" \
"    2 - A stubborn, tough gnome. MR of 20[, but he is immune to magic cast by fairies & elves. If you're an elf or fairy, you must fight with weapons; otherwise, fight with magic].\n" \
"    3 - A vial of mercury, worth 100 gp, weighs 50.\n" \
"    4 - A bag of sulfur, worth 10 gp, weighs 100.\n" \
"    5 - Magnetic compass. Resale value, 5 gp.\n" \
"    6 - Small diamond worth 10 gp, weighs 1.\n" \
"Now go to {170}."
}
};

MODULE SWORD ss_exits[SS_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  24,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  13, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/1G
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/2A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2B
  {  27,  40,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/2D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/2F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/2G
  {  23,   2,  70, 146,  31,  -1,  -1,  -1 }, //  15/3A
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/3B
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/3C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/3D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/3E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/3F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/3G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/3H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/4A
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/4C
  {  30,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/4D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/4E
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/4F
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/4G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/5A
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/5B
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/5C
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/5D
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/5E
  {  42,  51,  58,  99,  -1,  -1,  -1,  -1 }, //  35/5F
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/5G
  {   2,  70, 146,  -1,  -1,  -1,  -1,  -1 }, //  37/6A
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/6B
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/6C
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/6D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/6E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/6F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/6G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/6H
  { 154,  62,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/7A
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/7B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/7C
  {  75,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/7D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/7E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/7F
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/7G
  {  41,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/7H
  {  11,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/8A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/8B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/8C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/8D
  { 210,  69,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/8E
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/8F
  { 134,  18, 104,  -1,  -1,  -1,  -1,  -1 }, //  59/8G
  { 197,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/8H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/9A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/9B
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/9C
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/9D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/9E
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/9F
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/9G
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/9H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/9I
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/10A
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/10B
  { 126,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/10C
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/10D
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/10E
  {  18,  85, 134,  -1,  -1,  -1,  -1,  -1 }, //  75/10F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/10G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/10H
  {  87, 197,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/11A
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/11B
  {  89,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/11C
  {  96,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/11D
  {  98,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/11E
  { 157, 101,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/11F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/11G
  { 129,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/11H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/11I
  {  95,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/12B
  {  54,  38,  63,  25,  -1,  -1,  -1,  -1 }, //  89/12C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/12D
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/12E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/12F
  { 134,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/12G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/12H
  { 127, 119,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/13A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/13B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/13C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/13D
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/13E
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/13F
  { 108, 121, 128,  -1,  -1,  -1,  -1,  -1 }, // 101/13G
  { 119, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/14A
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/14B
  { 130, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/14C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/14D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/14E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/14F
  { 138, 143, 150,  -1,  -1,  -1,  -1,  -1 }, // 108/14G
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/14H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/15A
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/15B
  { 145, 177,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/15C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/15D
  { 161, 214,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/15E
  { 109,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/15F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/15G
  { 211, 209,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/15H
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/16B
  {  10, 148,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/16C
  { 143,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/16D
  { 167, 131, 174, 151,  -1,  -1,  -1,  -1 }, // 122/16E
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/16F
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/16G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/17A
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/17B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/17C
  { 186,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/17D
  { 206,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/17E
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/17F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/17G
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/18A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/18B
  { 166, 130,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/18C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/18D
  { 144,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/18E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/18F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/18G
  { 149, 120,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/19A
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/19B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/19C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/19D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/19E
  { 159, 184,  21, 178, 204,  -1,  -1,  -1 }, // 144/19F
  { 185,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/19G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/20A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/20B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/20C
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/20D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/20E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/20F
  { 188,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/20G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/20H
  { 137,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/21A
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/21B
  { 165,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/21C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/21D
  { 138, 143, 150, 186,  -1,  -1,  -1,  -1 }, // 158/21E
  { 171,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/21F
  { 188,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/21G
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/22A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/22B
  { 142, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/22C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/22D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165/22E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/22F
  { 169,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/23A
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/23B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169/23C
  { 158,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170/23D
  { 169,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171/23E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172/23F
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173/23G
  { 169,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174/24A
  { 158,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175/24B
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176/24C
  { 208, 216,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177/24D
  { 159, 184,  21, 204,  -1,  -1,  -1,  -1 }, // 178/24E
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179/24F
  { 202,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180/24G
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181/24H
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182/24I
  { 172,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183/25A
  { 171,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184/25B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185/25C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186/25D
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187/25E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188/25F
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189/25G
  {  51,  58,  99,  -1,  -1,  -1,  -1,  -1 }, // 190/26A
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191/26B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192/26C
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193/26D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194/26E
  { 198, 160, 188,  -1,  -1,  -1,  -1,  -1 }, // 195/26F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196/26G
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197/26H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198/27A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199/27B
  { 194,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200/27C
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201/27D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202/27E
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203/27F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204/28A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205/28B
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206/28C
  { 169,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207/28D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208/28E
  { 117, 211,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209/28F
  {  69, 222,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210/28G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211/29A
  { 220,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212/29B
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213/29C
  { 161,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214/29D
  { 194,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215/29E
  { 185,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216/29F
  { 153,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217/29G
  { 161,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218/30A
  { 183,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219/30B
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220/30C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221/30D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222/30E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223/30F
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224/30G
  { 170,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 225/30H
};

MODULE STRPTR ss_pix[SS_ROOMS] =
{ "", //   0
  "",
  "",
  "ss-p1",
  "ss-p22",
  "", //   5
  "ss-p7",
  "",
  "ss-p2",
  "",
  "", //  10
  "",
  "ss-p7",
  "",
  "",
  "ss-p5", //  15
  "",
  "",
  "",
  "",
  "", //  20
  "",
  "",
  "",
  "ss-p4",
  "", //  25
  "",
  "ss-p1",
  "",
  "",
  "", //  30
  "ss-p5",
  "",
  "",
  "",
  "", //  35
  "",
  "",
  "",
  "",
  "", //  40
  "ss-p22",
  "",
  "",
  "",
  "ss-p18", //  45
  "",
  "",
  "",
  "",
  "ss-p7", //  50
  "",
  "ss-p22",
  "",
  "",
  "", //  55
  "",
  "",
  "",
  "",
  "", //  60
  "",
  "ss-p18",
  "",
  "",
  "", //  65
  "",
  "",
  "",
  "",
  "", //  70
  "",
  "ss-p18",
  "",
  "",
  "", //  75
  "",
  "ss-p10",
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
  "ss-p16", //  90
  "",
  "",
  "",
  "ss-p10",
  "ss-p16", //  95
  "",
  "",
  "",
  "",
  "ss-p10", // 100
  "",
  "ss-p16",
  "",
  "ss-p8",
  "", // 105
  "",
  "ss-p10",
  "",
  "",
  "", // 110
  "ss-p16",
  "",
  "",
  "",
  "ss-p15", // 115
  "",
  "",
  "ss-p1",
  "ss-p16",
  "", // 120
  "",
  "",
  "",
  "ss-p10",
  "", // 125
  "",
  "ss-p16",
  "",
  "",
  "ss-p8", // 130
  "",
  "",
  "",
  "ss-p8",
  "", // 135
  "",
  "ss-p18",
  "",
  "ss-p20",
  "", // 140
  "",
  "",
  "",
  "",
  "", // 145
  "",
  "",
  "",
  "ss-p20",
  "", // 150
  "",
  "",
  "",
  "ss-p18",
  "", // 155
  "",
  "",
  "",
  "",
  "", // 160
  "",
  "ss-p22",
  "",
  "",
  "", // 165
  "",
  "",
  "ss-p4",
  "",
  "", // 170
  "",
  "",
  "",
  "",
  "", // 175
  "ss-p7",
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
  "ss-p26", // 195
  "",
  "",
  "ss-p26",
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
  "",
  "", // 215
  "",
  "",
  "",
  "",
  "", // 220
  "",
  "",
  "",
  "",
  ""  // 225
};

IMPORT int                    level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, module,
                              round,
                              spellchosen,
                              spellpower;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

MODULE int                    lk_stolen,
                              princess;

IMPORT void (* enterroom) (void);

MODULE void ss_enterroom(void);
MODULE void ss_magiceffects(int doubler);

EXPORT void ss_preinit(void)
{   descs[MODULE_SS] = ss_desc;
}

EXPORT void ss_init(void)
{   int i;

    exits     = &ss_exits[0][0];
    enterroom = ss_enterroom;
    for (i = 0; i < SS_ROOMS; i++)
    {   pix[i] = ss_pix[i];
    }

    princess  = 0;
    lk_stolen = 0;
}

MODULE void ss_enterroom(void)
{   int  choice,
         i,
         result;
    FLAG ok;

    switch (room)
    {
    case 1: // 1A
        if (cast(SPELL_KK, FALSE))
        {   room = 15;
        } else
        {   room = 8;
        }
    acase 2: // 1B
        savedrooms(1, lk, 28, 32);
    acase 3: // 1C
        give(253);
        award(50);
    acase 6: // 1F
        give(254);
    acase 7: // 1G
        award(80);
    acase 8: // 2A
        if (!saved(1, iq))
        {   templose_con(10);
        }
    acase 9: // 2B
        if (cast(SPELL_DM, FALSE))
        {   room = 156;
        } else
        {   room = 16;
        }
    acase 10:
        if (cast(SPELL_WO, TRUE))
        {   room = 17;
        } elif (cast(SPELL_DM, FALSE))
        {   room = 56;
        }
    acase 11: // 2D
        award(85);
        elapse(20, TRUE);
        give_gp(90);
        if (getyn("Leave (otherwise be killed)"))
        {   room = 81;
        } else
        {   die();
        }
    acase 12: // 2E
        if (cast(SPELL_PA, FALSE))
        {   room = 19;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 162;
        } else
        {   room = 41;
        }
    acase 13: // 2F
        if (saved(1, lk))
        {   elapse(50, TRUE);
            room = 110;
        } else
        {   elapse(20, TRUE);
            room = 20;
        }
    acase 14: // 2G
        create_monsters(108, 8);
        do
        {   oneround();
            if (countfoes())
            {   templose_con(2 * countfoes());
            }
            if (con <= 0)
            {   room = 98;
        }   }
        while (countfoes() && room == 14);
        if (room == 14)
        {   elapse(50, TRUE);
            room = 57;
        }
    acase 16: // 3B
        good_takehits(5, TRUE);
    acase 17: // 3C
        award(250);
    acase 18: // 3D
        if (saved(1, lk))
        {   room = 190;
        } else
        {   templose_con(2);
            gain_flag_ability(33);
            gain_lk(8);
            lose_chr(8);
            room = 35;
        }
    acase 19: // 3E
        if (spellpower < 24)
        {   room = 52;
        } else
        {   room = 29;
        }
    acase 20: // 3F
        if (getyn("Stay (otherwise run)") && saved(1, con))
        {   room = 50;
        } else
        {   room = 176;
        }
    acase 21: // 3G
        if (saved(1, lk))
        {   room = 43;
        } else
        {   die();
        }
    acase 22: // 3H
        getsavingthrow(FALSE);
        if (madeit(1, 11))
        {   room = 192;
        } else
        {   room = 200;
        }
    acase 23: // 4A
        if (cast(SPELL_KK, FALSE))
        {   room = 103;
        } elif (cast(SPELL_DM, FALSE))
        {   room = 61;
        } elif
        (   cast(SPELL_LT, FALSE)
         || cast(SPELL_WO, TRUE)
         || cast(SPELL_VB, FALSE)
         || cast(SPELL_PA, FALSE)
        )
        {   room = 132;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 71;
        } elif (cast(SPELL_RE, FALSE))
        {   room = 46;
        } elif (cast(SPELL_CC, FALSE))
        {   room = 79;
        } else
        {   die(); // %%: it's ambiguous about what to do in this situation
        }
    acase 24: // 4B
        give(255);
        give(MAG);
        give_multi(256, 10);
        award(125);
    acase 25: // 4C
        if (dice(1) <= 5)
        {   room = 34;
        } else
        {   room = 224;
        }
    acase 27: // 4E
        if (cast(SPELL_DM, FALSE))
        {   room = 56;
        } else
        {   room = 36;
        }
    acase 28: // 4F
        give(257);
    acase 29: // 4G
        give(BUC); // %%: it's described as "undamaged", yet supposedly only takes 1 hit?
        give(MAG); // %%: it's described as "undamaged", yet supposedly only deals 1 die?
        give(255);
        give_gp(240);
        give(258);
        award(250);
        elapse(30, TRUE);
    acase 30: // 5A
        if (cast(SPELL_PA, FALSE))
        {   room = 47;
        } elif (cast(SPELL_CC, FALSE))
        {   ss_magiceffects(1);
            room = 118;
        } elif (spell[SPELL_TF].known && cast(SPELL_TE, FALSE))
        {   room = 3;
        } elif (getyn("Pass him (otherwise fight)") && saved(1, chr))
        {   room = 118;
        } else
        {   room = 125;
        }
    acase 31: // 5B
        if (max_st  > 50) permchange_st(50);
        if (iq      > 50)     change_iq(50);
        if (lk      > 50)     change_lk(50);
        if (max_con > 50) permchange_con(50);
        if (dex     > 50)     change_dex(50);
        if (chr     > 50)     change_chr(50);
        if (spd     > 50)     change_spd(50);
        // %%: it doesn't say whether current or maximum attributes are meant
        if (max_st  < 12 && getyn("Reroll Strength"    )) permchange_st(dice(5));
        if (iq      < 12 && getyn("Reroll IQ"          ))     change_iq(dice(5));
        if (lk      < 12 && getyn("Reroll Luck"        ))     change_lk(dice(5));
        if (max_con < 12 && getyn("Reroll Constitution")) permchange_con(dice(5));
        if (dex     < 12 && getyn("Reroll Dexterity"   ))     change_dex(dice(5));
        if (chr     < 12 && getyn("Reroll Charisma"    ))     change_chr(dice(5));
        if (spd     < 12 && getyn("Reroll Speed"       ))     change_spd(dice(5));
    acase 32:
        good_takehits(misseditby(1, lk), TRUE); // %%: does armour help?
    acase 33:
        waitforever();
    acase 34: // 5E
        gain_iq(5);
        gain_dex(3);
        elapse(20, TRUE);
    acase 36: // 5G
        give(259);
    acase 38: // 6B
        if (dice(1) <= 5)
        {   gain_chr(2);
        } else
        {   lose_chr(4);
        }
    acase 40: // 6D
        if (!saved(1, dex))
        {   good_takehits(8, TRUE);
        }
    acase 41: // 6E
        create_monster(109);
        fight();
        if (con > 0)
        {   room = 29;
        } else
        {   room = 98;
        }
    acase 42: // 6F
        if (saved(1, lk))
        {   lose_flag_ability(33);
            lose_lk(8);
            gain_chr(8);
            room = 106;
        } else
        {   room = 193;
        }
    acase 43: // 6G
        victory(300 + princess);
    acase 44: // 6H
        die();
    acase 45: // 7A
        if (castspell(SPELL_VB, FALSE))
        {   choice = getnumber("1) Help Edgard (in black)\n2) Help Henry (in white)\nWhich", 1, 2);
            if (choice == 1)
            {   room = 53;
            } else
            {   room = 4;
        }   }
    acase 46: // 7B
        ss_magiceffects(1);
        give(260);
    acase 47: // 7C
        if (spellpower > 24)
        {   room = 118;
        } else
        {   room = 125;
        }
    acase 48: // 7D
        if (makelight())
        {   room = 59;
        }
    acase 49: // 7E
        if (cast(SPELL_KK, FALSE))
        {   room = 83;
        } elif (cast(SPELL_RE, FALSE))
        {   room = 92;
        } else
        {   room = 68;
        }
    acase 50: // 7F
        if (chr > 15)
        {   room = 6;
        } else
        {   room = 67;
        }
    acase 51: // 7G
        gain_st(1);
        gain_iq(1);
        gain_lk(1);
        gain_con(1);
        gain_dex(1);
        gain_chr(1);
        gain_spd(1);
    acase 53: // 8A
        give(261);
    acase 54: // 8B
        do
        {   templose_con(dice(1));
            award(dice(2));
        } while (getyn("Stay (otherwise exit)")); // %%: are they allowed to stay only once, or infinite times? We assume infinite.
        room = 65;
    acase 55: // 8C
        if (spellpower > 30)
        {   room = 66;
        } else
        {   room = 119;
        }
    acase 56: // 8D
        if (cast(SPELL_WO, TRUE))
        {   room = 7;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 14;
        } elif (cast(SPELL_PA, FALSE))
        {   room = 76;
        } else
        {   room = 84;
        }
    acase 58: // 8F
        give_gp(2000);
    acase 59: // 8G
        if (cast(SPELL_DM, FALSE))
        {   room = 163;
        }
    acase 61: // 9A
        if (cast(SPELL_RE, FALSE))
        {   room = 46;
        } else
        {   room = 37;
        }
    acase 62: // 9B
        savedrooms(1, lk, 126, 72);
    acase 63: // 9C
        if (dice(1) <= 5)
        {   gain_st(2);
            gain_con(2);
        } else
        {   permlose_st(2);
            permlose_con(2);
        }
    acase 65: // 9E
        elapse(50, TRUE);
        if (immune_poison() || cast(SPELL_TT, FALSE) || dice(1) % 2 == 0)
        {   room = 213;
        } else
        {   room = 203;
        }
    acase 69: // 9I
        if (cast(SPELL_PA, FALSE))
        {   room = 88;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 44;
        } elif (cast(SPELL_CC, FALSE))
        {   room = 182;
        } elif (cast(SPELL_RE, FALSE))
        {   room = 141;
        } else
        {   die();
        }
    acase 70: // 10A
        if (cast(SPELL_RE, FALSE))
        {   room = 78;
        } else
        {   room = 87;
        }
    acase 72: // 10C
        good_takehits(6, TRUE);
    acase 73: // 10D
        award(80);
        give(262);
        give(263);
        give(264);
    acase 75: // 10F
        if (cast(SPELL_WO, TRUE))
        {   room = 59;
        } elif (cast(SPELL_PA, FALSE))
        {   room = 93;
        }
    acase 76: // 10G
        if (spellpower <= 30)
        {   room = 98;
        } else
        {   savedrooms(1, lk, 187, 205);
        }
    acase 77: // 10H
        lose_lk(2);
        lk_stolen += 2;
        if (cast(SPELL_WO, TRUE))
        {   room = 86;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 94;
        } elif (cast(SPELL_PA, FALSE))
        {   room = 100;
        } else
        {   die(); // %%: it's ambiguous about what to do in this situation
        }
    acase 78:
        ss_magiceffects(2);
    acase 79:
        ss_magiceffects(1);
    acase 84: // 11G
        templose_con(8);
        if (con <= 0)
        {   room = 98;
        } elif (cast(SPELL_WO, TRUE))
        {   room = 7;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 14;
        } elif (cast(SPELL_PA, FALSE))
        {   room = 76;
        } else
        {   room = 98; // %%: we assume this is the intended outcome
        }
    acase 86: // 11I
        lose_lk(2);
        lk_stolen += 2;
        if (lk <= 0)
        {   room = 98;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 94;
        } elif (cast(SPELL_PA, FALSE))
        {   room = 100;
        } else
        {   room = 98; // %%: we assume this is the intended outcome
        }
    acase 88: // 12B
        if (spellpower > 37)
        {   room = 153;
        } else
        {   room = 98;
        }
    acase 90: // 12D
        create_monster(110);
        payload(TRUE);
        if (countfoes())
        {   fight();
        }
        if (con <= 0)
        {   room = 98;
        } else
        {   room = 73;
        }
    acase 92: // 12F
        ss_magiceffects(1);
        give(265);
        if (cast(SPELL_KK, FALSE))
        {   room = 83;
        } else
        {   room = 68;
        }
    acase 94: // 12H
        lose_lk(2);
        lk_stolen += 2;
        if (lk <= 0)
        {   room = 98;
        } else
        {   create_monster(111);
            payload(TRUE);
            if (countfoes())
            {   room = 107;
            } else
            {   room = 124;
        }   }
    acase 95: // 13A
        if (cast(SPELL_CC, FALSE))
        {   room = 102;
        } elif (cast(SPELL_WO, TRUE))
        {   room = 39;
        } elif (cast(SPELL_PA, FALSE))
        {   room = 55;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 90;
        }
    acase 96: // 13B
        if (cast(SPELL_KK, FALSE))
        {   room = 48;
        } elif (cast(SPELL_RE, FALSE))
        {   room = 105;
        } else
        {   room = 18;
        }
    acase 97: // 13C
        die();
    acase 98: // 13D
        die();
    acase 99: // 13E
        gain_flag_ability(34);
    acase 100: // 13F
        gain_lk(lk_stolen);
        lk_stolen = 0;
    acase 103: // 14B
        elapse(20, TRUE);
    acase 105: // 14D
        give(266);
        ss_magiceffects(1);
        if (cast(SPELL_KK, FALSE))
        {   room = 48;
        } else
        {   room = 18;
        }
    acase 106: // 14E
        if (saved(1, lk))
        {   oddeven(136, 122);
        } else
        {   room = 221;
        }
    acase 107: // 14F
        lose_lk(2);
        lk_stolen += 2;
        if (lk <= 0)
        {   room = 98;
        } else
        {   room = 124;
        }
    acase 110: // 15A
        if (saved(1, lk))
        {   elapse(50, TRUE); // %%: why does it say to only get 2 Strength points back, it should be 5!?
            room = 161;
        } else
        {   room = 219;
        }
    acase 111: // 15B
        give(267);
    acase 113: // 15D
        race = STATUE; // rather pointless
        die();
    acase 114: // 15E
        award(5);
    acase 115: // 15F
        give_multi(268, iq);
    acase 116: // 15G
        savedrooms(1, lk, 26, 223);
    acase 118: // 16A
        give(269);
        award(30);
    acase 119: // 16B
        create_monster(110);
        fight();
        if (con > 0)
        {   room = 73;
        } else
        {   room = 98;
        }
    acase 120: // 16C
        elapse(30, TRUE);
    acase 124: // 16G
        kill_npcs();
        award(65);
        give(270);
        elapse(100, TRUE);
    acase 125: // 17A
        create_monster(118);
        fight();
        if (con <= 0)
        {   room = 98;
        } else
        {   room = 139;
        }
    acase 127: // 17C
        if (chr < 12 || !saved(1, chr))
        {   room = 119;
        } else
        {   room = 133;
        }
    acase 128: // 17D
        award(75);
        if (!saved(1, lk))
        {   templose_con(misseditby(1, lk)); // %%: armour might help
        }
    acase 129: // 17E
        give_multi(271, 10);
    acase 130: // 17F
        give(272);
        waitforever();
    acase 131: // 17G
        if (saved(1, lk))
        {   gain_chr(10);
            room = 169;
        } else
        {   room = 207;
        }
    acase 132: // 18A
        elapse(20, TRUE);
    acase 133: // 18B
        if (chr >= 20)
        {   room = 140;
        } else
        {   room = 111;
        }
    acase 135: // 18D
        if (getyn("Duck") && saved(1, lk))
        {   room = 114;
        } else
        {   room = 183;
        }
    acase 137: // 18F
        result = dice(1);
        switch (result)
        {
        case 1:
        case 2:
            room = 98;
        acase 3:
            good_takehits(15, TRUE);
        acase 4:
            good_takehits(10, TRUE);
        acase 5:
            good_takehits(5, TRUE);
        }
        if (room == 137)
        {   room = 168;
        }
    acase 138: // 18G
        if (immune_poison() || saved(1, dex))
        {   templose_con(1);
            room = 225;
        } else
        {   room = 98;
        }
    acase 139: // 19A
        give(273);
        give(BUC); // %%: it says it is "ordinary" but that it only takes 1 hit (instead of 3)!?
    acase 141: // 19C
        savedrooms(1, iq, 217, 44);
    acase 142: // 19D
        if (saved(1, dex))
        {   give(274);
        }
        savedrooms(1, lk, 18, 134);
    acase 143: // 19E
        create_monster(112);
        oneround(); // %%: the instructions for this fight are rather ambiguous
        if (con <= 0)
        {   room = 98;
        } else
        {   if (countfoes())
            {   kill_npc(0);
            }
            room = 175;
        }
    acase 146: // 20A
        if (cast(SPELL_WO, TRUE)) // %%: what about eg. Cateyes, torch, etc.?
        {   room = 26;
        } else
        {   room = 116;
        }
    acase 147: // 20B
        if (cast(SPELL_RE, FALSE))
        {   room = 26;
        } else
        {   room = 110;
        }
    acase 148: // 20C
        if (cast(SPELL_WO, TRUE))
        {   room = 9;
        } elif (cast(SPELL_DM, FALSE))
        {   room = 156;
        } else
        {   room = 10;
        }
    acase 149: // 20D
        give(275);
    acase 150: // 20E
        give_gp(1);
        result = dice(1);
        switch (result)
        {
        case 1:
            give(276);
        acase 2:
            give(277);
        acase 3:
            give(278);
        acase 4:
            give(279);
        acase 5:
            create_monster(113);
            fight();
        acase 6:
            if (race == ELF || getyn("Fight demon"))
            {   create_monster(114);
                fight();
        }   }
        if (con <= 0)
        {   room = 98;
        } else
        {   room = 158;
        }
    acase 151:
        die();
    acase 152:
        princess = 0;
    acase 153: // 20H
        award(50);
        choice = getnumber("1) Do not rest\n2) Rest for 2 turns\n3) Nap", 1, 3);
        switch (choice)
        {
        case 1:
            room = 112;
        acase 2:
            elapse(20, TRUE);
            room = 80;
        acase 3:
            waitforever();
            room = 45;
        }
    acase 155: // 21B
        ss_magiceffects(1);
    acase 157: // 21D
        lose_lk(2);
        lk_stolen += 2;
        if (cast(SPELL_WO, TRUE))
        {   room = 86;
        } elif (cast(SPELL_TF, FALSE))
        {   room = 94;
        } elif (cast(SPELL_PA, FALSE))
        {   room = 100;
        } else
        {   die(); // %%: it's ambiguous about what to do in this situation
        }
    acase 160: // 21G
        give(280);
        result = dice(1); // %%: is it compulsory to do this? We assume so.
        switch (result)
        {
        case 1:
            give(281);
        acase 2:
            give(282);
        acase 3:
            give(283);
        acase 4:
            give(284);
        acase 5:
            give(285);
        acase 6:
            drop_all();
            lose_chr(1);
        }
    acase 162: // 22B
        good_takehits(dice(3) + 2, TRUE);
        if (con <= 0)
        {   room = 98;
        } else
        {   room = 168;
        }
    acase 165: // 22E
        if (cast(SPELL_WO, TRUE))
        {   give_multi(286, 10);
            waitforever();
            if (cast(SPELL_KK, FALSE))
            {   // %%: are you allowed to wait at this point too (to regain the ST expended for the Unlock spell)? We assume not.
                room = 10;
            } else
            {   die();
        }   }
        else
        {   die(); // %%: we assume this is the intended behaviour
        }
    acase 166: // 22F
        die();
    acase 167: // 23A
        result = dice(1);
        switch (result)
        {
        case 1:
            gain_iq(4);
        acase 2:
            gain_iq(8);
        acase 3:
            gain_iq(12);
        acase 4:
            race = STATUE; // maybe we should have an ability[] entry for this too?
        acase 5:
            lose_iq(5);
        acase 6:
            lose_iq(10);
        }
    acase 168: // 23B
        award(175);
        give(BUC);
        give(MAG);
        give(255);
        give_gp(240);
        give(287);
        for (i = 1; i <= 6; i++)
        {   if (st < max_st)
            {   elapse(10, TRUE);
            } else
            {   break; // for speed
        }   }
    acase 169: // 23C
        if (getyn("Leave (otherwise go back inside)"))
        {   victory(100 + princess);
        } else
        {   room = 1;
        }
    acase 170: // 23D
        award(10);
        give(288);
    acase 171: // 23E
        give(289);
        give_sp(1000);
        give_gp(120);
        encumbrance();
        give_cp((st * 100) - carrying());
        waitforever();
    acase 172: // 23F
        give_multi(290, iq);
        if (race == DWARF || race == HUMAN || race == WHITEHOBBIT)
        {   give_multi(291, lk);
        }
        if (cast(SPELL_DM, FALSE) || cast(SPELL_RE, FALSE))
        {   room = 218;
        } else
        {   room = 161;
        }
    acase 173: // 23G
        result = dice(1);
        switch (result)
        {
        case 1:
            lose_chr(5);
        acase 2:
            DISCARD pay_gp(100); // %%: what exactly is meant by "100 gp worth of treasure"?
        acase 3: // %%: it doesn't say whether this is permanent or temporary, we are assuming permanent.
            gain_st(2);
            gain_con(1);
        acase 4:
            gain_iq(3);
        acase 5:
            if (!saved(1, lk))
            {   die();
            }
        acase 6:
            award(250);
        }
    acase 174: // 24A
        result = dice(1);
        switch (result)
        {
        case 1:
            gain_st(5); // %%: it doesn't say whether this is permanent or temporary, we are assuming permanent.
        acase 2:
            gain_con(5); // %%: it doesn't say whether this is permanent or temporary, we are assuming permanent.
        acase 3:
            gain_lk(5);
        acase 4:
            gain_dex(5);
        acase 5:
            lose_lk(lk / 2);
        acase 6:
            permlose_con(max_con / 2); // %%: it doesn't say whether this is permanent or temporary, we are assuming permanent.
            // %%: it doesn't say whether it affects current or maximum
        }
    acase 175: // 24B
        award(5);
        if (race != VAMPIRE)
        {   give(292);
        }
    acase 176: // 24C
        if (!saved(1, lk))
        {   drop_all(); // %%: how is "treasure" defined?
        }
    acase 179:
        if (!items[DEL].owned)
        {   if (items[MAK].owned || items[ORD].owned || items[ORQ].owned)
            {   ok = FALSE;
                if   (items[MAK].owned && getyn("Throw away makeshift staff"       )) { destroy(MAK); ok = TRUE; }
                elif (items[ORQ].owned && getyn("Throw away ordinaire quarterstaff")) { destroy(ORQ); ok = TRUE; }
                elif (items[ORD].owned && getyn("Throw away ordinaire staff"       )) { destroy(ORD); ok = TRUE; }
            } else
            {   ok = TRUE;
            }
            if (ok)
            {   give(DEL);
        }   }
    acase 183: // 25A
        lose_chr(chr / 2);
        gain_con(5);
        // there doesn't seem to be a need to use an ability[] slot for this
    acase 185: // 25C
        if (makelight())
        {   room = 179;
        } else
        {   room = 123;
        }
    acase 186: // 25D
        if (saved(1, lk))
        {   room = 209;
        } else
        {   templose_con(misseditby(1, lk));
            room = 212;
        }
    acase 187: // 25E
        award(100);
        give(293);
    acase 188: // 25F
        savedrooms(1, lk, 194, 202);
    acase 189: // 25G
        result = dice(1);
        switch (result)
        {
        case 1:
            give(294);
        acase 2:
            give(295);
        acase 3:
            give(296);
        acase 4:
            good_takehits(18, TRUE); // %%: we're assuming armour helps with this
        acase 5:
            give(297);
        acase 6:
            give(298); // %%: it's ambiguous about whether this is an object or an event
        }
    acase 192: // 26C
        savedrooms(1, lk, 215, 180);
    acase 193: // 26D
        lose_flag_ability(33);
        gain_flag_ability(35);
        lose_lk(8);
    acase 194: // 26E
        result = throwcoin();
        switch (result)
        {
        case 0:
            room = 181;
        acase 1:
            room = 173;
        acase 2:
            room = 189;
        acase 3:
            room = 201;
        }
    acase 196:
        create_monster(115);
        fight();
        if (con <= 0)
        {   room = 98;
        } else
        {   victory(-1000 + princess);
        }
    acase 198: // 27A
        give(299);
        princess = 300;
        if (cast(SPELL_KK, FALSE))
        {   if (getyn("Lead (otherwise follow)"))
            {   room = 152;
            } else
            {   room = 22;
        }   }
        // %%: why do we need to roll up all her stats? Maybe she is meant to fight alongside us.
    acase 199: // 27B
        die();
    acase 200: // 27C
        princess = 0;
    acase 201: // 27D
        result = dice(1);
        switch (result)
        {
        case 1:
            create_monster(116);
            fight();
        acase 2:
            give_gp(100);
        acase 3:
            give(ORD);
        acase 4:
            give(300);
        acase 5:
            gain_st(2);
            gain_iq(2);
            gain_lk(2);
            gain_con(2);
            gain_dex(2);
            gain_chr(2);
            gain_spd(2);
        acase 6:
            lose_iq(5);
        }
    acase 202: // 27E
        templose_con(10);
        if (con <= 0)
        {   room = 98;
        } else
        {   room = 194;
        }
    acase 203: // 27F
        race = VAMPIRE; // perhaps we should also have an ability[] slot for whether we are a vampire
        gain_st(max_st);
        lose_chr(chr / 2);
    acase 204: // 28A
        savedrooms(1, lk, 171, 98);
    acase 205: // 28B
        die();
    acase 206: // 28C
        give_multi(301, iq); // this could be handled as ordinary gold pieces
    acase 207: // 28D
        lose_chr(chr / 2);
    acase 208: // 28E
        die();
    acase 209: // 28F
        result = dice(1);
        switch (result)
        {
        case 1:
            die();
        acase 3:
            change_iq(3);
        acase 4:
            gain_flag_ability(36);
        acase 5:
            gain_flag_ability(1);
        acase 6:
            gain_iq(4);
        }
    acase 211: // 29A
        result = dice(1);
        switch (result)
        {
        case 1:
        case 2:
            die();
        acase 3:
            good_takehits(12, TRUE);
            if (con <= 0)
            {   room = 98;
        }   }
        if (room == 211)
        {   room = 212;
        }
    acase 212: // 29B
        award(100);
        if (saved(1, chr))
        {   give(302);
        }
    acase 214: // 29D
        give(303);
    acase 216:
        gain_flag_ability(38);
    acase 221: // 30D
        die();
    acase 222: // 30E
        savedrooms(1, lk, 196, 44);
    acase 223: // 30F
        good_takehits(100, TRUE); // %%: presumably armour is effective
        if (con > 0)
        {   room = 26;
        } else
        {   room = 98;
        }
    acase 224: // 30G
        gain_iq(3);
        lose_dex(5);
    acase 225: // 30H
        result = dice(1);
        switch (result)
        {
        case 1:
            give(304);
        acase 2:
            create_monster(117);
            fight();
        acase 3:
            give(305);
        acase 4:
            give(306);
        acase 5:
            give(COM);
        acase 6:
            give(271);
}   }   }

MODULE void ss_magiceffects(int doubler)
{   int result;

    aprintf
("MAGIC EFFECTS TABLE\n" \
"Magic is an art, not a science. the difference is that science deals with certainties: if you do A, then B must follow. This is not so true for magic. By casting magic, you alter the state of the universe, and if you do A, then C, D, or E may happen, as well as the intended result, B. The tables given below are an effort to reflect this aspect of magic. Whenever you cast the spells concerned, you must consult the appropriate table to see if there is undesired side effects, or perhaps completely unexpected results from your conjuring. Among the 1st level spells, only the Revelation and a Concealing Cloak have recurrent side effects. For both tables, roll 2 dice - the sum of those dice will tell you the effect.\n" \
"REVELATION (to be used each time you cast the spell)\n" \
"    2  - You find a magic acorn. {This allows you to do free Concealing Cloaks.}\n" \
"    3  - You find a magic topaz worth 8 gp. It weights 8 {and does 10 free Healing Feelings. It can only increase Constitution by 1 each time, and after 10 uses, it becomes non-magical}.\n" \
"    4  -.You find an antique marble worth 231 gp, used by Alexander the Great.\n" \
"    5  -.You find an inscribed golden trinket worth 49 gp.\n" \
"    6  - You find a pewter dinner fork, good for 1 die in combat {against an unarmoured foe}.\n" \
"    7  - No noticeable side effects.\n" \
"    8  - You see purple grapes all around you for 1 turn. Distracting, isn't it?\n" \
"    9  - You see pink elephants for 1 turn. Lose 1 IQ point permanently.\n" \
"    10 - You disturb a rabid rabbit which attacks you instantly. Monster Rating = 10. {You may take hits on armour, but if you take hits against your Constitution, you'll die, as the cure for rabies hasn't been discovered yet.}\n" \
"    11 - You are attacked by a poisonous lizard, Monster Rating of 20. {You can take hits on armour once again, but you will die if it bites into you directly. However, you can survive if you are poison-proof, or have access to a Too-Bad Toxin or repeated Healing Feelings.}\n" \
"    12 - You inturrupted a 17th level mage who was attempting a dangerous spell. Irritated, she zaps you with a Blasting Power of fire worth 84 hits.\n" \
"CONCEALING CLOAK\n" \
"    2    - {You are rendered permanently invisible.}\n" \
"    3-11 - No side effects; the spell works normally.\n" \
"    12   - You disappear entirely from this world, fading completely away. Tear up the card and try again with another character.\n"
);

    result = dice(2);
    if (spellchosen == SPELL_RE)
    {   switch (result)
        {
        case 2:
            give_multi(218, doubler);
        acase 3:
            give_multi(249, doubler);
        acase 4:
             give_multi(250, doubler);
        acase 5:
            give_multi(251, doubler);
        acase 6:
            give_multi(252, doubler);
        acase 9:
            lose_iq(doubler);
        acase 10:
            if (doubler == 1)
            {   create_monster(106);
            } else
            {   create_monster(119);
            }
            fight();
        acase 11:
            if (doubler == 1)
            {   create_monster(107);
            } else
            {   create_monster(120);
            }
            fight();
        acase 12:
            good_takehits(84 * doubler, TRUE); // %%: is this meant to be doubled?
    }   }
    elif (spellchosen == SPELL_CC)
    {   if (result == 2)
        {   gain_flag_ability(32);
        } elif (result == 12)
        {   die();
}   }   }
