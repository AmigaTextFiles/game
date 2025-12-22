/* %%: Ambiguities/contradictions:
 Ogre (NDp103) and shoggoth (NDp104) have possible magic treasure, yet "Go back to 47
  in Naked Doom (the only paragraph that should have sent you here)" (NDp106).
 Big man (CD55/59) is described as wearing chainmail which should take 12 hits but only takes 10.

Errors in original:
 In ND5 it states that you dodged both arrows even if you were hit by arrows in ND10.
 It allows endless iterations of 5, 15, 20/24, 12/13, 5, 15, 20/24, 12/13, etc. (ie. endless tries
  for the Hero and Hopeless Swords). We have changed it so such play will go 5, 15, 20/24, 12/13,
  5, 15, 20/24 -> 25.
*/

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

MODULE const STRPTR nd_desc[ND_ROOMS] = {
{ // 0
#ifdef CORGI
"`INSTRUCTIONS\n" \
"  This is a very tough dungeon. To compensate for that, I have made it very high-paying in terms of money and magic to take out if you play well and survive. Characters who run this gauntlet of death and survive should be bonafide heroes, and there are some truly nifty items inside that I would dearly love to have for my own characters. There is a direct link between Naked Doom and the following adventure in this Two-In-One, Deathtrap Equalizer.\n" \
"~INTRODUCTION\n" \
"  They caught you. I don't know what they thought your crime was, whether you were suspected of defacing pictures of the Empress, or spitting on the sidewalk, or running away with old ladies' purses, or defaulting on your tab at the local tavern, or skinning cats on a Holy Day. But whatever it was, you are in trouble now, because the city of Khazan does not believe in coddling criminals. In fact, the people of Khazan have a very interesting method of dealing with petty criminals and minor malefactors: they give you your choice of death by torture, or of going into the NAKED DOOM dungeon.\n" \
"  NAKED DOOM isn't the official name, of course. In the Books of Justice, it is listed as the Royal Khazan Gauntlet of Criminal Retribution and Rehabilitation. You can see why everyone calls it NAKED DOOM. Officially, it was built as a testing maze for potential heroes. But not enough heroes ever came out of it to make it worthwhile, so the city justice department took over. It has been very effective in disposing of unwanted prisoners.\n" \
"  There have been survivors. Twice the relief has arrived at the exit to find the garrison all slain. Five times men have emerged and jumped at the chance to join an elite unit of the Khazan army. No one except the wizard who built the dungeon knows what happened to the several hundred other men and women who have been sent there to die.\n" \
"  Picture this: your character, a person who knows no magic, is taken under heavy guard down into the catacombs beneath the Khazan Courthouse, where you are stripped of your clothing (and of course all jewellery, amulets, and other devices you might have once owned). You are told that if you can make it successfully through the series of tunnels and caves that lie ahead, you will escape with your life, and perhaps treasure. None of your guards has ever been inside past the first turn, so they cannot tell you what dangers to expect - only that less than one man in ten comes out alive.\n" \
"  Two of your guards begin stringing self bows and selecting their best arrows - arrows whose points are darkly stained. An iron gateway is swung open. The archers step through and then you are roughly heaved through the portal. You see a stone corridor about 10' wide and 10' high, stretching in a straight line for a hundred feet before it abruptly turns. A few torches throw a flickering light along its length.\n" \
"  The captain of the guards points a stern finger and says, \"Run, dog!\" If you know what is good for you, you take off at top speed. Turn to paragraph {1} below. Read, make your choices, and follow the instructions given. Good luck."
#else
"`INSTRUCTIONS\n" \
"  This is the fourth in a series of programmed dungeons from Flying Buffalo. It was created for the benefit of unfortunately people who don't have friends handy at the moment to play Tunnels & Trolls. It consists of several pages with about four paragraphs on each page. Each paragraph presents a situation with one or more alternatives of what to do. You make your choices, and the text refers you to a new location to see what happened.\n" \
"  NAKED DOOM is not meant to be read like a book. For maximum enjoyment you should only read the paragraphs you are instructed to read, and only when you are instructed to read them. If you play by this rule, you should be able to run 10 or more characters through the dungeon without exhausting all the possibilities. After you have played many times in this dungeon, you should know all the possible combinations as well as I do, but it can still remain an interesting way of using 15 minutes or so if you randomly decide which of the choices to take for the characters you send in.\n" \
"  One thing that is very poor sportmanship is to find out where all the good things in the dungeon are, then run dozens of characters through and collect the best treasures over and over. However, if you do not play fairly in programmed dungeons like these, you will primarily be cheating yourself.\n" \
"  When I first designed the DEATHTRAP EQUALIZER dungeon I thought it would be tough, but really it is a pushover. There are too many situations in DE where you can walk in, do nothing, and walk out again better than when you started. This dungeon is not that way at all. I admit it at the beginning: I am honestly trying to kill your first-level characters when they go into this dungeon, and I think I have a good chance of getting them right at the start. This is a very tough dungeon. To compensate for that, I have made it very high-paying in terms of money and magic to take out if you play well and survive. Characters who run this gauntlet of death and survive should be bonafide heroes, and there are some truly nifty items inside that I would dearly love to have for my own characters.\n" \
"  In order to play this game you will need paper, pencil, several ordinary six-sided dice, the rules to Tunnels & Trolls, and maybe the DEATHTRAP EQUALIZER dungeon (there is one place where you can exit directly from NAKED DOOM to DE if you have DE). It will also help to have a lot of courage! You can run dwarves, elves, hobbits or humans in NAKED DOOM as long as they have *no magical powers*. Funny characters like centaurs and trolls wouldn't logically get sent in, so forget them. You should start with first or second level characters who know no magic. Now: if you are ready, turn to the Introduction on the next page.\n" \
"~INTRODUCTION\n" \
"  They caught you. I don't know what they thought your crime was, whether you were suspected of defacing pictures of the Empress, or spitting on the sidewalk, or running away with old ladies' purses, or defaulting on your tab at the local tavern, or skinning cats on a Holy Day. But whatever it was, you are in trouble now, because the city of Khazan does not believe in coddling criminals. In fact, the people of Khazan have a very interesting method of dealing with petty criminals and minor malefactors: they give you your choice of death by torture, or of going into the NAKED DOOM dungeon.\n" \
"  NAKED DOOM isn't the official name, of course. In the Books of Justice, it is listed as the Royal Khazan Gauntlet of Criminal Retribution and Rehabilitation. You can see why everyone calls it NAKED DOOM. Officially, it was built as a testing maze for potential heroes. But not enough heroes ever came out of it to make it worthwhile, so the city justice department took over. It has been very effective in disposing of unwanted prisoners.\n" \
"  There have been survivors. Twice the relief has arrived at the exit to find the garrison all slain. Five times men have emerged and jumped at the chance to join an elite unit of the Khazan army. No one except the wizard who built the dungeon knows what happened to the several hundred other men and women who have been sent there to die.\n" \
"  Picture this: your character, a person who knows no magic, is taken under heavy guard down into the catacombs beneath the Khazan Courthouse, where you are stripped of your clothing (and of course all jewellery, amulets, and other devices you might have once owned). You are told that if you can make it successfully through the series of tunnels and caves that lie ahead, you will escape with your life, and perhaps treasure. None of your guards has ever been inside past the first turn, so they cannot tell you what dangers to expect - only that less than one man in ten comes out alive.\n" \
"  Two of your guards begin stringing self bows and selecting their best arrows - arrows whose points are darkly stained. An iron gateway is swung open. The archers step through and then you are roughly heaved through the portal. You see a stone corridor about 10' wide and 10' high, stretching in a straight line for a hundred feet before it abruptly turns. A few torches throw a flickering light along its length.\n" \
"  The captain of the guards points a stern finger and says, \"Run, dog!\" If you know what is good for you, you take off at top speed. Turn to paragraph {1} below. Read, make your choices, and follow the instructions given. Good luck."
#endif
},
{ // 1/1A
"The bowmen behind you are both excellent shots. They could easily hit you if you ran in a straight line. You will have to run fast and dodge well to escape. You must make two first level saving rolls: one on Speed and one on Luck (20 - rating).\n" \
"  If you make both saving rolls, go to {5}. If you miss one or both, go to {10}."
},
{ // 2/1B
"As you walk in this direction you notice the air gets worse and worse, fouler and fouler. Make a first level saving roll on IQ (20 - IQ). If you make it, go to {16}. If not, go to {19}."
},
{ // 3/1C
"Roll 1 die. If you roll 1-5 you find that this fountain tastes sweet, but is deadly poison. Subtract 20 from your Constitution. If you rolled a 6, the water was sweet indeed: you can now see in the dark - even total dark. If the water was poison and killed you, close the book. If you are still alive, go to {11} and make another choice."
},
{ // 4/1D
"You get 500 adventure points for killing the troll. Going on down the tunnel for a long way, you finally come to a secret door (which is no secret on your side of the wall). If you wish to go through, go to {28}. If you want to go back, go to {5} and make another choice."
},
{ // 5/2A
"You dodged both arrows and got safely around the corner. The tunnel here is much darker, but there is enough light from phosphorescent moss so that you can dimly see. The passage divides into 3 separate tunnels. If you want to go to the left, go to {2}. If you want to go up the middle, go to {11}. If you want to go right, go to {15}."
},
{ // 6/2B
"Having decided not to drink, you pass through the room of bones and find yourself in another tunnel. You follow it for more than an hour and come out in a large cavern. Go to {28}."
},
{ // 7/2C
"The sword slides out of the wall into your hand, and a voice like thunder says, \"Truly hopeless!\" You suddenly feel like a great warrior. The voice belongs to the sword which is alive and gets a straight 200 hit points per combat turn when you are in combat. [This sword will not work at all for anyone else, and if you should die, it will disappear. ]After you have taken the sword, a block of stone slides across the passage behind you. You can no longer see the Hero Sword, but in front of you is an open doorway leading into a very large and fairly bright cavern. Go to {28}."
},
{ // 8/2D
"The sword slides out of the wall and a deep voice says, \"Truly a hero!\" This sword gets 100 hit points per combat turn when you are in combat[, and if you have it out you can bat arrows out of the air with it]. It is 6' long[ and shines dimly with a golden light]. It is alive, and the voice belongs to it. The sword will warn you when enemies are about to attack, unless you are using it in a programmed dungeon, where it will (of course) remain silent. [You are the only person who can wield the Hero Sword. If it is lost or stolen, or if you die, this sword will disappear. ]The passageway behind you is sealed off by a sliding stone block, and you find yourself looking through an opening into a very large, fairly bright cavern. If you look for the Hopeless Sword, it has vanished. Go to {28}."
},
{ // 9/2E
"Delicious is not quite the word for these thallophytes. Interesting would be a fair description. Nevertheless, you wolf down several. A few moments later you begin to feel dizzy and a little sick; there seem to be things lurking at the corners of your vision. Suddenly you feel a presence behind you. You whirl to see - oh, Gris! a tooth-beaked, red-eyed crocodile bird! Uncertain whether to run or right, you are still standing there when it speaks: \"I'd like you to meet some of my friends,\" it says. \"They're dying to eat you.\" As you watch in horror, several indescribable THINGS emerge from the very walls of the cavern and stalk ominously towards you. This is too much for you - the world spins and goes black. Go to {56}."
},
{ // 10/3A
"For each saving roll you missed, you were hit in the back with one arrow. Each arrow that hits you takes 10 off your CON. Furthermore, they were poisoned. Every time you are asked to make a saving roll of any kind, take off 1 more point of CON. If you are now dead, close the book. If you are still alive, despite having arrows in your back, you may crawl to safety around the corner. Go to {5}."
},
{ // 11/3B
"After walking for several hundred feet (or staggering, if you are wounded), you come into a large natural grotto. The floor of this room is littered with human bones. There are 3 pools of water, black and thick-looking. They are too widely separated for you to reach more than one of them at a time. The first has one skull by it; the second has two skulls sitting nose-hole to nose-hole. The third has three skulls, with one stacked atop the other two. You are probably hot and thirsty. If you want to drink from Fountain 1, go to {3}. If you want to drink from Fountain 2, go to {17}. If you prefer the third pool of slimy-looking water, turn to {23}. If you refuse to drink from any of them, go to {6}."
},
{ // 12/3C
"If you made any of your saving rolls, add 10 points to each attribute that you succeeded on. The sword remains stuck in the wall. A deep voice booms, \"Not entirely hopeless!\" If you wish to try for this sword again, go to {25}. If you'd like to try for the Hero Sword, go to {24}. If you give up and head back, go to {5}."
},
{ // 13/3D
"If you missed any of your saving rolls, add 10 points to the attributes you missed. The sword remains stuck in the wall. A deep voice chuckles, \"Not really a hero.\" If you wish to try for this sword again, go to {25}. You no longer see the Hopeless Sword. If you don't want to try again, you will have to go back. Go to {5}."
},
{ // 14/3E
"As you start back for the grotto and the spring, you're jumped by 6 spear-wielding goblins who are angry that you're stealing their mushrooms. Each goblin has a CON of 7 and a 2-dice spear with adds of -2. (Total, 12 dice minus 12.) If you kill them all, you may randomize for treasure, but they won't have anything magical. If they kill you, close the book. If you're still alive, go to {72}."
},
{ // 15/4A
"You walk for a long way and come out in a small room with 2 swords stuck halfway up their blades into the stone wall. Beneath each sword is one word. The first says, \"Hopeless\". The second says, \"Hero\". You probably remember some legends about magical swords stuck into stone, and even if you don't, you may be desperate enough to try to pull one of the swords loose. If you try to pull out the Hopeless Sword, go to {20}. If you wish to try for the Hero Sword (which is by far the larger), go to {24}. If you don't want to try for either of them, you can walk back to the 3 tunnels. Go to {5} and try another branch."
},
{ // 16/4B
"You recognize the bad smell as the odour of rock troll. (Rock trolls never bathe, dirtiness being next to demonliness in their piggish little red eyes.) If you wish to go on, go to {19}. If you want to run back and try another tunnel, go to {5}."
},
{ // 17/4C
"This fountain tastes bitter, but it is an antidote for all poisons. Henceforth, you are immune to poisons. However, the drink knocks you out. Go to {28}."
},
{ // 18/4D
"You realize that you can make a crude spear out of the bamboo you find growing by the spring. You can either make a spear or not, but if you don't have any kind of weapon, it will seem like a good idea and you should do it. Your new spear consists of a flaked piece of sharpened stone wedged into a bamboo pole, and tied in place with water weeds. It is not very strong, but it is worth 2 dice in combat. Go back to {32} and continue reading from where you left off."
},
{ // 19/5A
"Suddenly a small, filthy, naked rock troll leaps out on you, and you must fight for your life! The troll gets 2 dice and 15 adds. You get 1 die and whatever your adds are. The rock troll has a Constitution of 25. On the second combat turn (if it gets that far), the troll will get 2 dice and 10 adds (he gets tired fast). On the third combat turn, the troll gets 2 dice and 5 adds. For any other combat rounds the troll gets only 2 dice. Fight until one of you is slain. If you die, close the book. If the troll dies, go to {4}."
},
{ // 20/5B
"Try to make a first level saving roll on each attribute in order (20 - attribute). If you miss all seven (including Speed), go to {7}. If you make even one saving roll, go instead to {12}."
},
{ // 21/5C
"Near the spring you find a tunnel slanting down into the floor with one runic word hacked into the rock nearby: OUT! If you wish to follow this tunnel, go to {44}. If you change your mind and don't want to leave now, then go to {36}."
},
{ // 22/5D
"You are halfway across the chasm when a cloud of vampire blood bats rises and attacks you. Before you can do anything to defend yourself, you are bitten by several of them. If you are immune to poison, take 7 hits from your Constitution and go to {48}. Otherwise you feel a wave of nausea, grow dizzy, lose your hold, and plummet to your death below. Close the book."
},
{ // 23/6A
"This is the pool of greatness. It tastes terrible, but you can feel yourself changing. A cold sweat breaks out on your forehead, though - roll a first level saving roll on your current CON to see if you have an allergic reaction to elements in the water (this is not the same thing as being poisoned). If you miss the saving roll, your skin turns cherry red, itches horribly, and swells to monstrous proportions. Your heart labours, and eventually you suffocate under your own inflamed bulk. Close the book. On the other hand, if you make the saving roll, hope is in sight: multiply your Strength, Dexterity, and Charisma by 3. After drinking, you pass out. Go to {28}."
},
{ // 24/6B
"Try to make a saving roll on all 7 attributes including Speed (20 - attribute). If you make all 7, go to {8}. If you miss any of the rolls, keep track of which ones you missed, and then go to {13}."
},
{ // 25/6C
"Two deep voices thunder, \"YOU GET JUST ONE CHANCE - YOU ONLY GO AROUND ONCE IN THIS LIFE!\" A stone door slides across the passage behind you, and the room, magically, instantly, begins to fill up with beer. You drown. Close the book."
},
{ // 26/6D
"After the fight, you realize there is no real safety here. The next monster you meet may be tougher. Now you must decide whether you really want to stay. Go to {21}."
},
{ // 27/6E
"Make an L1-SR on Luck (20 - LK). If you make it, go directly to {28}. If you miss, you must fight one wandering monster before going to {28}. Randomize for a monster. If you win the fight, you may collect your treasure and go directly to {28}. Otherwise, you will be dead."
},
{ // 28/7A
"You find yourself in a very large cavern. Sunlight is coming in from somewhere high overhead, but you don't see the source and the walls are slick with moisture: quite unclimbable. As you wander around exploring the place, roll 1 die to see if you meet a wandering monster. If you roll a 1, go to page 103 and randomize to see what monster has found and attacked you. Then come back here to this paragraph and fight until either you or the monster is dead. If you kill a wandering monster, you get the adventure points and treasure (if any) indicated on page 103. If you do not encounter anything ugly or dangerous, or if you have already slain it, go to {32}."
},
{ // 29/7B
"A cloud of vampire bats rises out of the chasm and begins to dive at you and attack. If you have a bamboo spear with you, add 5 to your DEX to represent your ability to keep your balance and to drive back the swooping mammals (this DEX raise is only temporary, for the saving roll which follows only!). Now make a first level saving roll on DEX and a saving roll on LK (20 - attribute). If you make both saving rolls, go to {48}. If you missed either one of them, go to {33}."
},
{ // 30/7C
#ifdef CORGI
"The frog ring begins to glow and you are magically transported into the Deathtrap Equalizer dungeon. Roll 3 dice, and consult the table at the beginning of that adventure."
#else
"The frog ring begins to glow and you are magically transported into the Deathtrap Equalizer dungeon. [(If you do not have DE, then the spell does not take effect. However, you may keep the ring - it is worth 10 gold pieces. Go to {44} and make another choice.) ]Roll 3 dice, and go to the \"A\" paragraph for that page number in DE."
#endif
},
{ // 31/7D
"Make your first level saving roll on Strength (20 - ST). If you make it, go to {34}. If you miss the roll, go to {37}."
},
{ // 32/8A
"After a while, you discover a large warm spring. There are lots of frogs, insects and small fish in it. Many water plants grow in and around it. If you do not have a weapon make your first level saving roll on IQ (20 - IQ). If you make it, go now to {18}. If you already have a weapon, or did not make your saving roll, read on. Hungry, you contrive to capture several frogs, and you pick some watercress which is sufficient to provide you with a meal, although not a very appetizing one. You know that a person could survive here in this cavern. If you want to stay here, and not try to get out, go to {36}. But if you are determined to escape from these caverns, go to {21}."
},
{ // 33/8B
"In fighting off the blood bats, you lost your balance and fell from your precarious perch to an early and unpleasant doom. Close the book."
},
{ // 34/8C
"You jumped across the trench safely and can go on down the tunnel. You get 100 adventure points for making the leap. Go to {49}."
},
{ // 35/8D
"As soon as you start walking back, you are attacked by 6 goblins with daggers. If you choose not to fight, but to run away, go to {45}. If you stay and fight them, you will see they each get 1 die and 5 adds per combat turn. They can each take 9 hits. If you fight and they kill you, close the book. If you destroy them all, you get 300 adventure points, and then you can go to {65}."
},
{ // 36/9A
"You decided to stay here where you think it is safe. One of the first things you discover is a tunnel slanting down through the floor near the spring - above it is one word carved in the stone: OUT! But you do not explore it. You also find a small stream leading away from the spring through a series of caves. Some of them are quite small and dark, while others are large, well-lit grottoes like the one you just left. After several hours of exploration you come to a large dim cavern where a few stunted bushes are growing. You stumble across many a broken skeleton of man, beast, and monster mouldering in the mud underfoot. Then you find something really amazing: a field of large purple-grey mushrooms planted in neat rows. You know some fungi are edible, and the fact that these are practically in a garden reassures you they are not poisonous. By this time you are quite hungry, and the spring is far away. If you want to pick and eat some of these mushrooms, go to {9}. If you decide not to eat any now, but to carry some back with you to the main grotto, go to {14}. If you wish to avoid them completely and keep exploring, go to {27}."
},
{ // 37/9B
"You fell short and dropped to a fiery doom. Close the book."
},
{ // 38/9C
"You get 1200 adventure points for killing the Balrog. All the goblins run away from you in terror. Searching the room, you find 10 gems. Randomize for them in the jewels section of the treasure generator on page 104. There is also a pouch to carry them in, and you are able to make a crude belt from yourself from a fragment of the Balrog's whip. There is no clothing. You also find another door leading out of the chamber. If you want to try it, go to {42}. If you'd prefer to retrace your steps to the lava trench, go to {52}.[ Do not come back this way again via {41}.]"
},
{ // 39/9D
"If you are immune to all poisons, go to {53}. If you are not immune, go to {43}."
},
{ // 40/11A
"To the left you find nothing, but around a corner to the right, you come across an enormous jade idol of a frog. On the altar before it is a small bronze ring in the form of a frog biting its own hind legs. If you want to put it on, go to {30}. If you decide to leave it alone, go back to {44} and make another choice."
},
{ // 41/11B
"The muffled drumming stops, but as you continue to go down the passageway, the sniggering behind you gets louder. If you wish to go back and see what is following you, go to {35}. If you ignore it and go on, go to {45}."
},
{ // 42/11C
"The door leads to an iron bridge that spans the lava trench. Crossing it, you find yourself in a side tunnel that leads back to the main passage via a secret door. Go to {49}."
},
{ // 43/11D
"The mist in this room is a deadly acidic poison. Roll 5 dice and take that many hits on CON before you get through. If you survive, go to {57}. If not, close the book."
},
{ // 44/12A
"Once again you are in a dimly-lit tunnel. You follow its twists and turns for several miles until the walls fall away on the sides, and you find yourself at the edge of a mighty chasm. It is bridged by smooth arching stone, not too wide, but wide enough to walk across. Your choices are these: you can try to walk across, try to crawl or slither across, go back to the large cavern, or explore along the edge of the chasm. If you walk across, go to {29}. If you crawl, go to {22}. If you go back to the cavern, you will arrive there safely (but shame on you for cowardice!). Go to {36}. If you explore the edge of the chasm then go to {40}."
},
{ // 45/12B
"\"WELCOME, LITTLE MAN!!!\" You have come out in the chamber of the Balrog. It looks like a tall black shadow, wreathed in flames, and armed with an enormous whip. Hundreds of goblins suddenly crowd the tunnel behind you and block the way back with their spears. You will have to fight the Balrog. It gets 8 dice and 96 adds, and has a CON of 84. Fight hard - if it kills you, close the book. If you kill it, go to {38}."
},
{ // 46/12C
"Make your saving roll on IQ (20 - IQ). If you make it, go to {58}. If you miss the saving roll, then you don't notice anything unusual. Go to {39}."
},
{ // 47/12D
"Almost through the room, you find a movable stone in the floor; there is the rune for treasure carved in the stone. You open it. To find out what treasure is there, randomize on the Treasure Generator on page 104. If you get a magical treasure, turn to page 106 and roll 1 die to see what magic treasure you have found. After collecting, go to {57}."
},
{ // 48/13A
"You kept your balance and beat off the bats long enough to reach the other side of the chasm. You get 100 times the numbers you rolled as saving rolls in adventure points. Ahead of you is a lightless tunnel into which you must go. Go to {52}."
},
{ // 49/13B
"You follow the tunnel for an hour and then it ends in a wooden door. You open it to see a room full of silvery mist. If you want to walk straight into this room for the exit that you can barely see across from you, go to {39}. If you want to study the room from the doorway first, go to {46}."
},
{ // 50/13C
"You have been transported into a magical arena. [The weapon in your hand is enchanted to double its normal dice and adds. ]Randomize on page 103 for a monster to fight. [The enchantment on your weapon lasts only as long as you are in this arena, beyond time and space. ]If you kill your foe, you get your adventure points and treasure (if any) as listed - then go to {54}. If your foe slays you, then just close the book."
},
{ // 51/13D
"You follow him into a large guardroom. Roll 2 dice: that is how many other guards are present, dressed as he is dressed. They offer to enlist you in their own elite section of the Khazan Army. If you wish to join these men, known as the Khazan Killers, go to {66}. If you decide not to join them, but to attack them instead now that you can see how many of them there are, go to {67}."
},
{ // 52/14A
"Slowly, light begins to show again. The rock beneath your feet gets very warm, and you hear a muffled booming noise. The tunnel comes to an end in front of a trench about 10' deep and a little wider, and the tunnel continues on the other side. You also see a side tunnel 20' wide and 30' high paralleling the lava trench. If you wish to try to jump the trench, go to {31}. If you want to explore the side tunnel, go to {41}. There is a crash of falling stone in the tunnel behind you, and you hear high-pitched sniggering. You know now you can't go back..."
},
{ // 53/14B
"You walk right through the room and come out into another small room, and then out into yet another small chamber. Go to {57}."
},
{ // 54/14C
"You are in a short tunnel. Ahead of you a good way you hear human voices and then an alarm bell goes off. A door opens at the far end of the passage, and a big man in chainmail comes to the doorway and yells at you, \"All right now, come on out of there with your hands up! There is no place to retreat to, and we have you outnumbered.\" If you follow his order, go to {51}. If you attack him as soon as you get close enough, go to {59}. If you'd rather try to go back, go to {63}."
},
{ // 55/14D
"For the first combat turn he fights you alone. On the second combat turn 2 of his fellows join him, and after that 2 more men join the fight every combat turn until either you are dead, or all the guards are in the fight. All other fighters have swords and shields, and they are all wearing mail. They each get 3 dice and 10 adds. They can take 10 hits per combat turn on their armour. You must kill them all to survive. If they kill you, close the book. If you slay them all, go to {64}."
},
{ // 56/14E
"When you awaken, you are alone and unharmed. You look around for the way back to the grotto, but it has vanished. Instead, you find a streak of yellow rock in the floor, and a sign which reads \"Follow the gold to the Palace of Delight\". There's nothing else to do, so you walk along the trail, which gets smoother and brighter as you go. Finally you arrive at a palace of shimmering white marble. A beautiful gauze-clad houri is waiting to greet you. She claps her hands, and you are no longer naked - instead, you are dressed as a prince in the finest of jewelled silken robes. She leads you inside, and introduces you to her six sisters, each more gorgeous than the one before. Go to {61}."
},
{ // 57/16A
"You come into a room that has a purple, orange, and blue (the royal colours of Khazan) tunic laid out on a couch. It is just your size and bears the national emblem of Khazan in an embroidered design on the front. You may put it on if you wish. There is also one weapon in the room. To see what it is, go to {62}."
},
{ // 58/16B
"You notice that it is not nearly so misty close to the floor as it is higher up in the room. You decide to squirm through on your stomach in case the mist is dangerous (good guess!). If you are immune to poison, you will be totally unhurt. If you are not immune, roll 1 die and take that number of hits from your CON. If you died, close the book. If you are still alive, go to {47}."
},
{ // 59/16C
"He is armed with a spear and is wearing mail - he shouts for help. Roll 2 dice to see how many other guards armed with swords and wearing mail will come to his aid. In combat he gets 4 dice and 12 adds. He has a CON of 15, and his mail will take 10 hits for him. Go to {55}."
},
{ // 60/16D
"YOU WIN!!!!! The End."
},
{ // 61/16E
"The seven houris beg you to stay with them, calling you master and offering you everything your heart desires. If you accept their offers, go to {68}. If you would rather have your freedom, and beg them to help you escape from these caves, go to {70}."
},
{ // 62/17A
"[You will need your copy of the ]T[unnels & Trolls Rule Book. Turn to the weapons section, then roll one die.\n" \
"    1 - Swords\n" \
"    2 - Pole Weapons\n" \
"    3 - Hafted Weapons\n" \
"    4 - Daggers\n" \
"    5 - Spears\n" \
"    6 - Bows and other projectile weapons\n" \
"Now roll 2 dice; doubles add and roll over. Start at the top of the section indicated and count down from the top the number you rolled on 2 dice. If you reach the end of a list, start again at the top of the same list. The one you stop on is the weapon which is waiting for you in this room. (If you don't have a copy of the Rule Book, t]urn to the Rules Section at the beginning of this book and consult the weapons section. This has twenty weapons: roll a twenty sided die to see which weapon is waiting for you.) If you pick up the weapon, go to {50}. If you don't touch it, but go through the room into the tunnel beyond, go to {54}."
},
{ // 63/17B
"You find you can't get back into the room where you found the weapon. You will have to deal with this man. Go back to {54} and make another choice."
},
{ // 64/17C
"You can plunder the guardroom. There is [food, drink, clothing, ]mail, shields, weapons of all classes. Randomize 3 times for treasure on page 104, but there will be nothing magical here. [There are horses in the barn outside. ]You get 5000 adventure points for surviving and conquering the Naked Doom dungeon, along with adventure points for saving rolls, and any foes you have conquered. You are no longer naked or doomed. Y[ou may take any level bonuses coming to you now, and y]ou are totally free to do what you want. However, first go to {60}."
},
{ // 65/17D
"After killing the goblins, you discover to your dismay that a stone block now seals off the way back to the lava trench. But you can take a goblin dagger worth 1 die in combat, and use it as an extra weapon. They do not have any treasure on them, or any other useful items. You must go to {45}."
},
{ // 66/19A
"You are safe. Your new comrades demand that you share any treasure brought out of the tunnels. If you agree, divide any monetary treasure you have by the number of men in the room. If you don't agree to share your loot, go to {67}. You get another 1000 adventure points for surviving Naked Doom[, and you may take your level bonuses now]. Eventually, your term of service will expire or you will see a good chance to desert, and you are finally totally free. Your sordid criminal career is a thing of the past. From now on you can spend your time robbing dungeons. Go to {60}."
},
{ // 67/19B
"You have to fight them all. There is a tremendous battle. They each fight with a broadsword, and get 3 dice and 10 adds in combat; they can take 7 hits on armour. They each have a CON of 12 except for the leader, who has a CON of 15. If they kill you, close the book. If you kill them, go to {64}."
},
{ // 68/19C
"Roll 1 die. For that number of days you live in perfect bliss. You go to sleep in the arms of your favourite on the last night. Go to {71}."
},
{ // 69/19D
"You awaken naked and cold in the cavern of the mushrooms. Roll 1 die and subtract that from your ST (you have gone that many days without food while unconscious). If your ST is reduced to 0 or less, you die of starvation. Close the book. If you're still alive and wish to eat more mushrooms, go to {9}. If you'd rather go back to the pool, go to {27}."
},
{ // 70/20A
"One of the houris brings out an old oil lamp and rubs it. Smoke issues forth and condenses to form a most ominous-looking genie. \"Take this man (or woman) wherever he or she would like to go.\" You feel yourself grabbed in a mighty embrace; your fine robes are ripped away, and the world begins to spin and then fades away. Go to {69}."
},
{ // 71/20B
"You wake up sprawled among the mushrooms on the cavern floor. Each day of bliss that you thought you experienced was actually one day you lay unconscious without food or water. Subtract that number from your ST (this is a permanent loss[ until you get plenty of food and drink]). If your ST reached zero or less, you died of starvation shortly after awakening. In this case, just close the book. However, if you are still alive, go to {73}."
},
{ // 72/20C
"You get back to the grotto with the mushrooms. When you eat them, they cause you to fall into a deep and nightmare-ridden slumber. Roll 1 die and subtract that from your ST (you slept that many days without food or water. This loss is permanent[ until you get ample food and drink. Frogs and watercress don't cut it].). If your ST dropped to zero or less, you died in your sleep. When you awaken, you realize that your only chance is to go on before you get too weak to continue. Go to {21}."
},
{ // 73/20D
"Make a third level saving roll on Luck. If you made the roll, your journey is uneventful. Go to {28}. If you miss the saving roll, turn to page 103 and randomize to see which wandering monster you have met. You must fight it. If you kill it, go on to {28}."
}
}, nd_wandertext[11] = {
{ // 0
"2 - CAVE DRAGON: 9' long, 8' high, whitish-green scales. CON of 225. Gets 15 dice and 104 adds. Has a hoard of treasure, but you'll never find it. Worth 600 ap."
},
{ // 1
"3 - BALROG: 12' tall black shadow wreathed in flames and armed with a whip. CON of 98. Gets 8 dice and 77 adds. Worth 500 ap."
},
{ // 2
"4 - TROLL: 8' tall, strong and ugly, skin almost as hard as rock. CON of 39. Uses its hands to try to rip you apart. Gets 3 dice and 12 adds. Worth 200 ap."
},
{ // 3
"5 - GIANT COCKROACH: 6' high with clacking mandibles. CON of 15. Gets 2 dice and 5 adds. Its hits are poison. Unless you are immune to poison, you will lose consciousness one complete combat turn after it first hits you. (This means you have 1 chance to kill it before it kills you automatically.) Worth 100 ap."
},
{ // 4
"6 - EVIL DWARF: 4' tall. CON of 20. Uses a pickaxe. Gets 2 dice and 17 adds, and he will try to kill you even if you're a dwarf. He is searching for the dragon's hoard and doesn't want any competition. Randomize for treasure, but he won't have anything magical. Worth 80 ap."
},
{ // 5
"7 - NAKED HUMAN WITH A BAMBOO SPEAR: The poor fellow has been down here so long that he has gone mad and sees you as food. (He's very tired of eating frogs.) CON of 15. Gets 2 dice and 1 add. Worth 40 ap."
},
{ // 6
"8 - GOBLINS (from 1-6: roll 1 die): Each one has a CON of 7 and uses a spear worth 2 dice. Each goblin gets -4 adds. Randomize for treasure. They will not have anything magical. Worth 30 ap each."
},
{ // 7
"9 - OGRE: Two-headed, ugly, with bad breath and body odour. CON of 20. Gets 2 dice and 3 adds. Randomize for treasure. Worth 100 ap."
},
{ // 8
"10 - GHOULS (from 1-6, roll 1 dice): Each has a CON of 51. Gets 3 dice and 10 adds. Worth 150 ap each. No treasure."
},
{ // 9
"11 - CHIMERA: Lion's head, goat's body, serpent's tail and wolf's claws. Breathes clouds of poison. If you are not immune to all poison, take 10 points off your CON each combat turn you are fighting (even if you are winning). CON of 27. Gets 4 dice and 16 adds. Worth 400 ap."
},
{ // 10
"12 - SHOGGOTH: You hear piccolo music first. Make a third level saving roll on Luck (30 - LK) to see if you are a piccolo player and therefore valuable to the shoggoth. It is a huge, blind, hairy, ponderous dancer. CON of 850. (It is also semidivine.) Gets 20 dice and 267 adds. Randomize for treasure if you beat it. If it beats you, and if you made your saving roll, it captures you, permanently enslaves you, and gives you a piccolo - you will play dance music for it for a very long time to come. There is no escape. Worth 5000 ap."
}
};

MODULE SWORD nd_exits[ND_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  11,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  28,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {   2,  11,  15,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {   3,  17,  23,   6,  -1,  -1,  -1,  -1 }, //  11
  {  25,  24,   5,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  25,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  72,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  20,  24,   5,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  19,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  {  32,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {   4,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  44,  36,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  21,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  32,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  36,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {   9,  14,  27,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  42,  52,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  30,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  35,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  29,  22,  36,  40,  -1,  -1,  -1,  -1 }, //  44
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  39,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  66,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  31,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {  51,  59,  63,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  61,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  {  47,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  55,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  68,  70,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  {  54,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  60,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {   9,  27,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  {  21,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  //  73
};

MODULE STRPTR nd_pix[ND_ROOMS] =
{ "", //   0
  "nd1",
  "",
  "",
  "",
  "", //   5
  "",
  "",
  "nd8",
  "nd9",
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
  "nd28",
  "",
  "", //  30
  "",
  "",
  "",
  "nd34",
  "", //  35
  "nd36",
  "",
  "",
  "",
  "nd40", //  40
  "",
  "nd42",
  "",
  "",
  "nd45", //  45
  "",
  "",
  "",
  "nd49",
  "", //  50
  "",
  "",
  "",
  "nd54",
  "", //  55
  "nd56",
  "nd57",
  "",
  "",
  "", //  60
  "nd61",
  "",
  "",
  "",
  "", //  65
  "",
  "",
  "",
  "",
  "nd70", //  70
  "nd71",
  "",
  ""  //  73
};

IMPORT int                    been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, module,
                              theround,
                              thethrow;
IMPORT       SWORD*           exits;
IMPORT const int              ms_weapons[20];
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];

MODULE int                    bonus,
                              guards;
MODULE FLAG                   halfway_32;

IMPORT void (* enterroom) (void);

MODULE void nd_enterroom(void);
MODULE void nd_treasure(FLAG magic);
MODULE void nd_wandering(void);
MODULE void nd_givejewel(void);

EXPORT void nd_preinit(void)
{   descs[MODULE_ND]   = nd_desc;
    wanders[MODULE_ND] = nd_wandertext;
}

EXPORT void nd_init(void)
{   int i;

    exits     = &nd_exits[0][0];
    enterroom = nd_enterroom;
    for (i = 0; i < ND_ROOMS; i++)
    {   pix[i] = nd_pix[i];
    }

    bonus      =
    guards     = 0;
    halfway_32 = FALSE;
}

MODULE void nd_enterroom(void)
{   TRANSIENT int  amount,
                   i,
                   which;
    TRANSIENT FLAG ok;
    PERSIST   int  oldstat;

    switch (room)
    {
    case 0:
        drop_all();
    acase 1:
        oldstat = 0;
        if (!saved(1, spd))
        {   oldstat++;
        }
        if (!saved(1, lk))
        {   oldstat++;
        }
        if (oldstat)
        {   room = 10;
        } else
        {   room = 5;
        }
    acase 2:
        savedrooms(1, iq, 16, 19);
    acase 3:
        if (dice(1) <= 5)
        {   if (!immune_poison())
            {   templose_con(20);
        }   }
        else
        {   gain_flag_ability(0);
        }
    acase 4:
        award(500);
    acase 7:
        give(168);
    acase 8:
        give(366);
    acase 10:
        templose_con(oldstat * 10);
        if (!immune_poison())
        {   gain_flag_ability(17); // %%: when does this wear off?
        }
    acase 14:
        create_monsters(42, 6);
        fight();
        nd_treasure(FALSE);
        room = 72;
    acase 17:
        gain_flag_ability(1);
    acase 18:
        give(367);
        halfway_32 = TRUE;
    acase 19:
        create_monster(43);
        npc[0].adds = 15;
        theround = 0;
        do
        {   oneround();
            if (npc[0].adds >= 1)
            {   npc[0].adds -= 5;
        }   }
        while (countfoes());
    acase 20:
        if (been[20])
        {   room = 25;
        } else
        {   room = 7;
            // strictly speaking we should do the gain_foo()s at ND12, but it doesn't matter.
            if (saved(1, st))
            {   gain_st(10);
                room = 12;
            }
            if (saved(1, iq))
            {   gain_iq(10);
                room = 12;
            }
            if (saved(1, lk))
            {   gain_lk(10);
                room = 12;
            }
            if (saved(1, dex))
            {   gain_dex(10);
                room = 12;
            }
            if (saved(1, con))
            {   gain_con(10);
                room = 12;
            }
            if (saved(1, chr))
            {   gain_chr(10);
                room = 12;
            }
            if (saved(1, spd))
            {   gain_spd(10);
                room = 12;
        }   }
    acase 22:
        if (immune_poison())
        {   templose_con(7);
            room = 48;
        } else
        {   die();
        }
    acase 23:
        if (saved(1, con))
        {   permchange_st(max_st * 3);
            change_iq(    iq     * 3);
            change_chr(   chr    * 3);
        } else
        {   die();
        }
    acase 24:
        if (been[24])
        {   room = 25;
        } else
        {   room = 8;
            // strictly speaking we should do the gain_foo()s at ND13, but it doesn't matter.
            if (!saved(1, st))
            {   gain_st(10);
                room = 13;
            }
            if (!saved(1, iq ))
            {   gain_iq(10);
                room = 13;
            }
            if (!saved(1, dex))
            {   gain_dex(10);
                room = 13;
            }
            if (!saved(1, lk ))
            {   gain_lk(10);
                room = 13;
            }
            if (!saved(1, con))
            {   gain_con(10);
                room = 13;
            }
            if (!saved(1, chr))
            {   gain_chr(10);
                room = 13;
            }
            if (!saved(1, spd))
            {   gain_spd(10);
                room = 13;
        }   }
    acase 25:
        die();
    acase 27:
        if (!saved(1, lk))
        {   nd_wandering();
        }
    acase 28:
        if (dice(1) == 1)
        {   nd_wandering();
        }
    acase 29:
        getsavingthrow(TRUE);
        if
        (   ( items[367].owned && madeit(1, dex + 5))
         || (!items[367].owned && madeit(1, dex    ))
        )
        {   bonus = thethrow;
            if (saved(1, lk))
            {   bonus += thethrow;
                room = 48;
            } else
            {   room = 33;
        }   }
        else
        {   room = 33;
        }
    acase 30:
        module = MODULE_DE;
        room = -1;
    acase 31:
        if (saved(1, st))
        {   room = 34;
        } else
        {   room = 37;
        }
    acase 32:
        if (halfway_32)
        {   halfway_32 = FALSE;
        } else
        {   ok = TRUE;
            for (i = 0; i < ITEMS; i++)
            {   if (items[i].type >= FIRSTWEAPON && items[i].type <= LASTWEAPON) // or we could just do it by whether the item has dice & adds
                {   ok = FALSE;
                    break; // for speed
            }   }
            if (ok && saved(1, iq))
            {   room = 18;
        }   }
    acase 33:
        die();
    acase 34:
        award(100);
    acase 35:
        if (getyn("Run away (otherwise fight)"))
        {   room = 45;
        } else
        {   create_monsters(44, 6);
            fight();
            award(300);
            room = 65;
        }
    acase 37:
        die();
    acase 38:
        for (i = 0; i < 10; i++)
        {   nd_givejewel();
        }
        give(174); // pouch
        give(175); // crude belt
    acase 39:
        if (immune_poison())
        {   room = 53;
        } else
        {   room = 43;
        }
 /* acase 40:
        ; we could implement frog rings (and lion rings) as real items */
    acase 43:
        templose_con(dice(5));
    acase 45:
        create_monster(45);
        fight();
    acase 46:
        savedrooms(1, iq, 58, 39);
    acase 47:
        nd_treasure(TRUE);
    acase 48:
        award(bonus * 100);
        // bonus = 0;
    acase 50:
        nd_wandering();
        room = 54;
    acase 51:
        guards = dice(2);
    acase 55:
        create_monster(46);
        theround = 0;
        do
        {   oneround();
            if (guards >= 1)
            {   create_monster(47);
                guards--;
            }
            if (guards >= 1)
            {   create_monster(47);
                guards--;
        }   }
        while (guards >= 1 || countfoes());
        room = 64;
    acase 59:
        guards = dice(2);
    acase 60:
        victory(0); // they already received their APs at ND64/66
    acase 62:
        // we are using the mini rules option rather than the rulebook option
        which = ms_weapons[anydice(1, 20) - 1];
        aprintf("You see a %s.\n", items[which]);
        if (getyn("Take it"))
        {   give(which);
            room = 50;
        } else
        {   room = 54;
        }
    acase 64:
        shop_give(12);
        nd_treasure(FALSE);
        nd_treasure(FALSE);
        nd_treasure(FALSE);
        give_multi(ITEM_SO_HORSE, 2);
        award(5000);
    acase 66:
        if (getyn("Share treasure (otherwise fight)"))
        {   pay_cp_only((cp / (guards + 1)) * (cp / guards));
            pay_sp_only((sp / (guards + 1)) * (sp / guards));
            pay_gp_only((gp / (guards + 1)) * (gp / guards));
            award(1000);
            room = 60;
        } else
        {   room = 67;
        }
    acase 67:
        create_monster(48);
        if (guards >= 2)
        {   create_monsters(49, guards - 1);
        }
        fight();
        room = 64;
    acase 69:
        amount = dice(1);
        permlose_st(amount);  // %%: it doesn't say how permanent this is
        elapse(ONE_DAY * amount, FALSE);
    acase 71:
        amount = dice(1);
        permlose_st(amount); // strictly speaking we should roll the die at ND68, but it doesn't matter
        elapse(ONE_DAY * amount, FALSE);
    acase 72:
        permlose_st(dice(1));
    acase 73:
        if (!saved(3, lk))
        {   nd_wandering();
}   }   }

MODULE void nd_wandering(void)
{   int i,
        result1,
        result2;

    aprintf(
"WANDERING MONSTER LIST\n" \
"  Roll two ordinary 6-sided dice to determine which monster you must fight (2-12). Adventure points (ap) and treasure are listed with each monster. If a monster is listed as carrying a weapon, and you kill it, you may take the weapon to use for yourself. {Such weapons are worth only the dice ratings shown, not the adds which are personal to the monster.} When combat is over, return to the paragraph that sent you here.\n"
    );
    result1 = dice(2);
    aprintf("%s\n", nd_wandertext[result1 - 2]);

    switch (result1)
    {
    case 2:
        create_monster(50);
    acase 3:
        create_monster(51);
    acase 4:
        create_monster(52);
    acase 5:
        create_monster(53);
    acase 6:
        create_monster(54);
    acase 7:
        create_monster(55);
    acase 8:
        result2 = dice(1);
        for (i = 0; i < result2; i++)
        {   create_monster(56);
        }
    acase 9:
        create_monster(57);
    acase 10:
        result2 = dice(1);
        for (i = 0; i < result2; i++)
        {   create_monster(58);
        }
    acase 11:
        create_monster(59);
    acase 12:
        create_monster(60);
    }

    do
    {   theround = 0;
        oneround();
        if (!immune_poison())
        {   if (result1 == 5)
            {   if (countfoes())
                {   die();
            }   }
            elif (result1 == 10)
            {   templose_con(10);
    }   }   }
    while (countfoes() && con >= 1);

    if (result1 == 6 || result1 == 8)
    {   nd_treasure(FALSE);
    } elif (result1 == 9 || result1 == 12)
    {   nd_treasure(TRUE);
}   }

MODULE void nd_treasure(FLAG magic)
{   int amount,
        result1,
        result2,
        result3,
        result4;

    if (magic)
    {   result1 = dice(2);
        if (result1 == 2 || result1 == 12)
        {   // magic item

            result2 = dice(1);
            switch (result2)
            {
            case 1:
                aprintf("ROBES OF TUCHMI K'NOTT: Flowing robes in the Roman toga fashion that are magical armour. When wearing these robes you can take up to 200 hits in a combat turn before you can be hurt. [But if you are ever defeated for 3 combat turns in a row, you will be overpowered, disarmed, and captured, and then the robes won't help you a bit. If the robes are taken away from you, they become worthless cloth and the enchantment will be broken.]\n");
                give(368);
            acase 2:
                aprintf("A RING OF FIRE: [It enables the wearer to cast fireballs worth 100 hits once each combat turn. However, if you use the ring in hand-to-hand or any kind of close combat, you will be at the centre of the fireball (which is about 5' in diameter) and you will have to take 50 of the 100 hits yourself.]\n");
                give(369);
            acase 3:
                aprintf("A 20th LEVEL ANTI-MAGIC BELT: [Whoever wears this belt cannot be affected by any other spell, either FOR or AGAINST the warrior (only warriors can wear it).]\n");
                give(370);
            acase 4:
                aprintf("THE DAGGER \"DRAINER\": [While you are using it, your foes lose all their combat adds, and their weapons become worth only 1 die each (unless they are magical weapons, in which case, no effect on the weapon).] You get your adds and 2 dice for the dagger. [This is a 10th level spell.]\n");
                give(371);
            acase 5:
                aprintf("A FUNNY-ONCE GEM: Death is funny - once. [If you are killed while carrying this gem, you will come back to life unharmed in the Temple of Peace in Khazan - safely out of an adventure you may have been in, but without the adventure points gained for it. At this time your CHR will drop to 7 and the jewel will be gone.]\n");
                give(372);
            acase 6:
                aprintf("A BOX OF MAGIC POWDER: with instructions to sniff it. [This is 8th level magic. Roll one die, for odd or even. ODD: Sniffing the powder makes you truly invisible - not as in a Concealing Cloak, but truly invisible. The spell does *not* affect objects you may be carrying, like clothes, armour or weapons. EVEN:] The powder doubles your intelligence. There is just enough powder for one application.\n");
                // %%: do you have to sniff it immediately? We assume not.
                give(167);
            }

            return;
    }   }

    // money
    result1 = dice(1);
    switch (result1)
    {
    case 1:
        nd_givejewel();
    acase 2:
    case 3:
        amount = 0;
        do
        {   result2 = dice(1);
            result3 = dice(1);
            result4 = dice(1);
            amount += (result2 + result3 + result4) * 10;
        } while (result2 == result3 && result2 == result4);
        give_gp(amount);
    acase 4:
    case 5:
    case 6:
        amount = 0;
        do
        {   result2 = dice(1);
            result3 = dice(1);
            result4 = dice(1);
            amount += (result2 + result3 + result4) * 10;
        } while (result2 == result3 && result2 == result4);
        give_sp(amount);
}   }

MODULE void nd_givejewel(void)
{   rb_givejewel(-1, -1, 1); // should really use the proper ND/MS table
}
