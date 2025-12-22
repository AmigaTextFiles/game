#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Issues (%%):
 This seems designed for an older (4th?) edition of the rules.
 Perhaps we should bump up MRs/CONs by 10, a la BC?
 Perhaps we should bump up weapon dice by 1 (eg. RB notes that all weapons in 5th edition do at least 2 dice damage).
*/

MODULE const STRPTR gl_desc[GL_ROOMS] = {
{ // 0
"The original Goblin Lake was located in the old Dungeon of the Bear before it was remodeled to suit the needs of Flying Buffalo. Now, you have a chance to explore it in a way that ordinary dungeon delvers never got. Your character for this adventure will be a goblin who has been wandering the world in search of his kin. I don't want to say too much more - you must create a character and start to play.`\n" \
"  (Note: [if you have already played this adventure as a Goblin, ]you do not have to be a Goblin[ the second time through]. A Hobbit or a Dwarf, or even a small man, could enter through this little cave. For such a character the adventure might go differently. If you wish to take another type of character, roll it up in the standard manner and go to {13}, but ignore the stuff about your sense of smell.)\n" \
"  You are a Goblin. (Try to pick a suitable name.) You have pointy ears, pointy teeth, and a rough scaly green skin. Your body is hairless and smaller than a man's, with arms and legs that are slightly too long, a sunken chest, and a hard little pot belly. Find your height and weight by rolling on the Size and Weight chart in the T&T rules; then multiply the results by ¾ for both size and weight. (You are a large Goblin.)\n" \
"  [You will need to know your attributes. For Strength, roll 3 dice and multiply the total by ¾. You may round up. For Intelligence, roll 4 dice, but only count the total of the 3 highest. For Luck, roll 4 dice and count all 4. For Constitution, roll 3 dice and multiply the total by ¾. For Dexterity, roll 3 dice and multiply the total by 3/2. For Charisma, roll 2 dice only. Do not bother to roll for gold - you don't have any. You are superbly attired (for a Goblin) in a rough lizard-skin loincloth, and you have an unusual flint dagger worth 2 dice in combat. You also carry a ragged net suitable for trapping small frogs and minnows.\n" \
"  ]After your character is created (you can make it a rogue or magic-user if you wish, though warrior is preferred), go to {13}.~"
},
{ // 1/1A
"You tell Blimpo, your second-in-command, that he's the new king if you don't come up. You know that there is a monster in the lake, but you take your dagger that glows in the dark, and you're willing to take your chances. Go to {49}."
},
{ // 2/1B
"Your wounds were too severe. You passed out while swimming, and drowned. Go to {79}."
},
{ // 3/1C
"The voice means nothing to you. If you wish to stop and try speaking in your own language, go to {54}. If you just keep walking, go to {27}. If you decide to turn back and not antagonize the Goblins, go to {33}. If you would like to run forward and dive into the lake, go to {60}. If you have the ability and wish to make a light, go to {24}."
},
{ // 4/1D
"Snorkin begs for mercy, offers you the mastery and his treasure if you will only let him live. If you accept his surrender, go to {77}. If you prefer to keep fighting, go to {44}."
},
{ // 5/1E
"You paddle across the lake and come to a stone landing. There are no weeds here, but in the far wall is a heavy iron door. It is locked shut from the other side. If you know an Unlock spell and wish to open the door, go to {42}. If you can't get it open, you turn and discover that something is towing the raft away from shore at a good speed. You didn't need it anyway. Go to {73}."
},
{ // 6/1F
"You swim out a few strokes, but the Goblins turn and attack you in the water. They are armed with daggers and get 1 die + 3 adds each - there are 5 of them. [You may only use your natural weapons or a dagger if you have one. ]Fight 1 combat round. If you are wounded, go to {22}. If you are slain, go to {79}. If you best them, go to {28}."
},
{ // 7/1G
"During one of the irregular attacks on Goblin Lake your luck ran out and you were killed. It was truly an insignificant death. Go to {79}."
},
{ // 8/1H
"You move out with a smooth breaststroke. The lapping of the waves and squeaking of Goblin voices covers the sound that you make. Ahead of you, you can dimly make out a raft with 3 goblins on it. You decide to dive beneath them. If you wish to come up beneath them and dump them into the lake, go to {62}. If you decide to swim past them, go to {67}."
},
{ // 9/2A
"More and more tentacles wrap around you. The water grows black with ink that the monster has released. If you have already been killed, go to {79}. If you still live despite the hits taken on the first combat turn, you will go berserk, and continue fighting berserkly turn after turn until either you die from hits taken, or 5 combat turns go by and you have drowned, or you manage to inflict some hits and break free. Remember, the giant octopus gets 8 dice and 50 adds to start with (it has a Monster Rating of 100, but only 8 tentacles. If the MR decreases because you inflict hits, it will release you.). If you break free, go to {65}. If it kills you, go to {79}."
},
{ // 10/2B
"You decide to get while the getting is good. A couple of arrows whistle by, but none hit, and in seconds you are out of Goblin Country and heading back for {33}."
},
{ // 11/2C
"You are at the bottom of the garbage pit. It is slimy and foul down here, and there are a lot of bones, some of fish, frogs, turtles, and some that seem to be of men. As you muck about you find a small pouch of gems on one skeleton. They are small diamonds, and would be worth 2000 gold pieces in the outside world. You may keep them or leave them as you please, but in the end you will have to try to climb out of this pit. To do so you must make 3 L1-SRs on Strength (30 - ST), then 3 L1-SRs on Constitution (30 - CON), then 1 L2-SR on Luck (25 - LK). If you miss a saving roll you will fall back and must take whatever you missed by in hits. If you take enough hits to kill you, go to {79}. If you manage to climb out, then you will have a chance to escape. Go to {52} and take the exit."
},
{ // 12/2D
"There's no point in attacking these silly little Goblins. Let them keep their old lake. Return to {33}."
},
{ // 13/2E
"For days you have been searching through the forest where Goblin Lake is rumoured to be. Now you think you have found it - the entrance to the underground domain is through a small cleft with a stream trickling out of the scrub-covered hillside. Your sense of smell is quite keen, and you detect other Goblins at a distance. So you crawl in. It's tight going at first, even for a little guy like yourself. Before long the tunnel branches, but you stick with the stream. It gets so dark that even you can't see anything, but then the darkness begins to weaken and a very dim light from the walls themselves enables you to make out your surroundings. Go to {40}."
},
{ // 14/2F
"As you grope over the bony hands of a skeleton, you feel a metallic ring. You slip it off the bone, and onto your own finger. Immediately you feel tremendous. The ring is enchanted[ and doubles all of your attributes (but only while you wear it)]. You decide it's time to get some air. Go to {20}."
},
{ // 15/3A
"\"Welcome to Fishsquish Lake,\" says one of the Goblins who is bigger and nastier looking than the others. He has 3 distinctive fangs, 2 that come up from the bottom of his mouth at the corners and a third that comes down from the top lip to the middle of his receding chin. \"I'm Snorkin, King of the Lake Goblins,\" he explains. \"We can always use a new recruit - you look like a stalwart fellow, want to join my band? All the fish you can eat and a life of ease.\" If you accept his offer, go to {72}. If you decide to return to the rest of the dungeon, you take your leave and retrace your steps to {33}. If you decide to challenge him for the kingship, go to {53}."
},
{ // 16/3B
"You find a small ledge leading to a bunch of caves above the lake. It is too small for you. You can either go swimming or head back. If you wish to leave Goblin Grot, go to {33}. If you wish to go down to the caves, go to {39}. If you don't mind getting wet, go to {36} and start swimming."
},
{ // 17/3C
"The rope cuts easily. You have nothing to paddle the raft with but your hands. If you wish to continue across the lake, go to {5}. If you wish to return the way you came, go to {52}."
},
{ // 18/3D
"You are in the Goblin King's Cave. There is a large pile of fishbones and other garbage at the rear. If you wish to investigate it, go to {57}. If this trash doesn't intrigue you, you turn back to the raft, only to discover that it is rapidly moving away from you. If you want to dive in and swim after it, go to {73}. If you don't know what to do, go to {31}."
},
{ // 19/3E
"Give yourself the number you just rolled in experience points and go to {52}."
},
{ // 20/3F
"You reach the surface and take a breath of air. If you are a Goblin and wish to dive again, go to {32}. If you are a Goblin and wish to swim to shore, go to {69}. If you are not a Goblin, you start to swim for the other shore, hoping it is there. Go to {8}."
},
{ // 21/3G
"Give yourself 10 experience points for the prank you played. Go now to {67}, but ignore the line about forbearance and charity."
},
{ // 22/4A
"As your blood seeps into the water you begin to suspect you're not going to win this fight. Suddenly, one of the Goblins is dragged below the surface by something from below, and you feel harsh, leathery skin grate against your leg. Your remaining foes drop their knives and swim as fast as they can off to the right. You decide that you'd better get to shore quickly, too, and start back the way you came. Go to {63}."
},
{ // 23/4B
"Make your third level saving roll on Luck (30 - LK). If you make it, go to {14}. If you miss it, go to {41}."
},
{ // 24/4C
"By some means or another you have brightened up the dim surroundings. You realize immediately that this was not a good move as a number of small missiles home unerringly on your body. Roll 13 dice and take that number of hits. (Your armour, if you have any, will take half the total because of the nature of the missiles.) If that killed you, go to {79}. If you are still alive you will have noticed that you are in a fairly big grotto which is mostly a small pond. There are 3 groups of Goblins visible; the nearest group is only 50', off to your right. If you wish to slip into the tunnel behind you and retreat, go to {12}. If you want to charge and attack the nearest bunch of Goblins, go to {75}."
},
{ // 25/4D
"There are 2 ways to get Snorkin's treasure away from him. Either defeat him in combat and become king, or swipe it when he isn't looking. If you wish to challenge him to a duel, go to {53}. If you want to try to swipe it, go to {35}."
},
{ // 26/4E
"You grow bored with flunkyhood and all the fish you can eat. To liven things up you can go diving for treasure ({49}), challenge Snorkin for the kingship ({53}), sneak away and leave the lake (go to {33}), or climb down into the garbage pit ({39}). Pick one of these options."
},
{ // 27/4F
"You keep walking. Make your L1-SR on Luck (20 - LK), 4 times. If you make all 4 saving rolls, take the numbers you rolled as experience points and go to {70}. If you missed one or more saving rolls, go to {37}."
},
{ // 28/4G
"The Goblins have Constitutions of 8. For each one that you have killed, take 22 experience points. The survivors split and swim in different directions. As you are savoring your triumph there in the bloody water, a mighty tentacle wraps around your legs and drags you underwater. Go to {73} and start reading with the second sentence."
},
{ // 29/4H
"Battered unconscious, the breathing reflex takes over. Sorrowfully, we turn our eyes from your waterlogged little corpse. Go to {79}."
},
{ // 30/5A
"Snorkin gives you a chance to surrender. If you wish to give up, go to {56}. If you wish to fight on, go to {44}."
},
{ // 31/5B
"As you are trying to decide what to do, all the Goblins come up on rafts with bows and torches and besiege you. They are making a lot of noise, and you have to duck out of sight to keep from being shot. You can either go back and look through the garbage ({57}) or dive into the water and try to elude the Goblins ({73}). Pick one."
},
{ // 32/5C
"There must be something worthwhile down there somewhere. Taking a deep breath you head for the bottom and aim towards a skeleton at random. Go to {48}."
},
{ // 33/5D
"On your way out you follow the stream that guided you in. Before long you squeeze back out through the cleft and are in the outside world once more. Congratulations and good luck on your further adventures wherever you go. The End."
},
{ // 34/5E
"Give yourself 88 experience points for killing Snorkin. You are now King of the Fishsquish Goblins. One of your trusty followers leads you to Snorkin's Cave in a stone wall above the side of the lake, and indicates a pile of old fishbones in the rear. \"Beneath that,\" he tells you, \"is our treasure, which it is now your duty to guard.\" You go over to see what it is, and it proves to be 1 gold piece, ½ of a silver piece, 9 bent copper coins, a broken mirror, a small dagger that glows in the dark, and the last 3 issues of Goblin Gazette. You must make a decision. If you decide to run off with the treasure, go to {76}. If you decide to stay and rule your loyal subjects, go to {47}."
},
{ // 35/5F
"You pick a time when Snorkin is out fishing on the raft and sneak into his cave. Throwing aside the fishbones you grab the turtleshell box and race out along the path for the shore. The treasure box is too large to hide about your person, so you will have to dash past the guard post at a run. Make your second level saving roll on Dexterity (25 - DEX). If you make it, go to {48}. If you miss it, go to {64}."
},
{ // 36/6A
"The water is colder than ever. You swim over to explore the far side of the lake that you have not yet seen. Suddenly a whirlpool forms around you. Helplessly caught you spin madly and go under. A strong current sweeps you into a hole in the lake wall. Bang! Crash! You smash into the rocky walls as you are hurtled along. Make your second level saving roll on Constitution (25 - CON). If you make it, go to {59}. If you miss it, go to {29}."
},
{ // 37/6B
"For each time you missed your saving roll, throw 1 die and take that number of hits. You may count armour as protection[ once only]. If these arrows killed you, go to {79}. If you are still alive, take twice the number of hits sustained as experience points. If you would now like to make a hasty retreat, go to {10}. If you want to attack somebody, you see a group of Goblins off to your right, go to {75}. If you want to throw yourself into the lake, go to {60}."
},
{ // 38/6C
"You pull the raft along by the rope for a few minutes and come to a stone wall that is full of small holes - big enough for Goblins to live in. One of them is larger than the rest and within your reach. If you wish to enter that cave, go to {18}. If you don't want to enter, then you will decide that poling the raft around with your fingers is too slow and that you can swim more easily. Go to {73}."
},
{ // 39/6D
"The first thing you find is a rather steep shaft going almost straight down into the rock. Handholds are cut into the sides of one wall. They are close together and shallow, suitable for use by Goblins. If you wish to climb down this shaft, go to {11}. If you'd prefer to keep on exploring, go to {16}."
},
{ // 40/6E
"As you walk down the corridor the walls disappear and you come out into a rather large grotto. In the darkness you can hear the quiet lapping of water against stone, and you can make out the dim forms of reeds. Suddenly, a shrill voice squawks at you in the language of the Goblins. If you speak Goblin, go to {78}; if not, go to {3}."
},
{ // 41/6F
"Suddenly a sense of doom fills your heart as a vast shadow detaches from the bottom and mighty tentacles reach out for you. One wraps around your legs. Go to {73} and start reading with the second sentence."
},
{ // 42/6G
"The door swings open and a hallway is before you. 100' away you see a large stairway arching above a crystal clear pool, and at the top of the stairs are 2 bronze doors from beneath which you can see glints of daylight. You can walk out of the dungeon if you wish, or you can reenter Fishsquish Lake and continue your adventures. If you wish to exit, go to {74}. If you reenter the lake, go to {73}."
},
{ // 43/7A
"You have been teleported out of Fishsquish Lake to the home of Mogul the Gobbling Wizard. This wiz is a Goblin half-breed, second cousin to old Snorkin. He lives in the city of Khosht, and you have no trouble sneaking out of his house with your stolen treasure. Give yourself 500 experience points for escaping alive. The End."
},
{ // 44/7B
"Fight another combat round. Snorkin gets 2 dice + 15 adds, while you get 2 dice + whatever your adds are. If you are slain, go to {79}. If you killed Snorkin, go to {34}. If neither of you are slain, keep fighting here, combat turn after combat turn, until one of you dies."
},
{ // 45/7C
"You quickly discover that the raft is tied to something. If you wish to cut the rope, go to {17}. If you wish to draw yourself along it, go to {38}."
},
{ // 46/7D
"Your feet slipped out from under you. First you slide a ways, and then you find yourself falling. There is nothing but dark empty space around you, although now and then you carom off a rocky wall. On one of these ricochets you bang your head and the stars come out. Finally you hit bottom with a mighty crash. Roll 10 dice and take that many hits directly off CON. (Armour won't take any of them for you.) If that kills you, go to {79}. If you still live, go to {11}."
},
{ // 47/7E
"Being king of the Fishsquish Goblins proves to be rather dull. Once in a while a delver or dungeon inhabitant tries to invade your territory. After six months you decide to do something to break the boredom (you have earned 120 ap in this time). If you wish to dive for treasure on the bottom of the lake, go to {1}. If you wish to explore the pit, go to {39}. If you want to leave, go to {33}."
},
{ // 48/7F
"Give yourself 100 ap for the theft. You have slipped past the guard and are now back out in the tunnel that first led you in here. Go to {33}."
},
{ // 49/7G
"It is dark and cold, but you can dimly make out that something lies on the bottom. Swimming close you find that it is bones and old rusty armour. You realize that there may be treasure down here, but that only great good luck would enable you to find it. If you wish to try a corpse at random while your air lasts, go to {23}. If you'd rather just swim back to the surface, go to {20}."
},
{ // 50/8A
"You explain that you are not a Goblin, but would like to wander around and explore the place. You hear a deeper voice snarl, \"It's probably after my treasure.\" The original voice yells, \"No non-goblins allowed! Go back, or we'll feed you to the fishes!\" By this time you've located the source of the challenge. It's coming from a group of water weeds about 50' off to your right. You can also make out 4 or 5 pairs of glowing little yellow eyes. If you decide to leave them alone, go back to {33}. If you have the ability and want to make a light, go to {24}. If you wish to charge and attack them, go to {75}."
},
{ // 51/8B
"Now begins a period of flunkyhood. Roll 1 die for the number of months you remain with Snorkin's band. Multiply that number by 10 for the number of experience points you pick up for various defensive actions against delvers and other dungeon inhabitants - nothing major. Make a first level saving roll on Luck (20 - LK). If you make it, go to {26}. If you miss it, go to {7}."
},
{ // 52/8C
"You are back on the marshy shore. If you wish to go exploring, you set out cautiously. Go to {39}. If you're ready to leave, go to {33}."
},
{ // 53/8D
"All the Goblins are very excited. Snorkin sneers confidently. As they lead you to the sacred dueling ground, which is beyond but near a shaft leading sharply down out of the grotto, they explain the rules. You are both to be armed with tridents (2 dice), and the winner shall be the new king but the loser will be exiled. Fight the fight. Snorkin gets 2 dice + 15 adds for each combat turn. [You get 2 dice + your adds, whatever they are. ]Stop at the end of the first combat round. If you have been slain, go to {79}. If you have killed Snorkin, who has a Constitution of 12, go to {34}. If you are wounded, but not slain, go to {30}. If Snorkin is wounded but not dead, go to {4}."
},
{ // 54/9A
"Obviously they don't understand you, and don't want to. Make your first level saving roll (20 - LK) 3 times. If you made all 3, take the numbers you rolled as experience points and go to {70}. If you missed one or more saving rolls, go to {37}."
},
{ // 55/9B
"\"Eeeep! Urrk! Gleep! Argle!\" SPLASH, SPLASH, SPLASH, SPLASH, and SPLASH! The Goblins ran away. You find their weapons, a bunch of puny little self-bows, but they didn't leave their arrows behind when they dived into the lake. If you wish to explore the land around the lakeshore, go to {39}. If you want to dive into the lake and swim after them, go to {6}."
},
{ // 56/9C
"Snorkin accepts your surrender. Take twice as many experience points as you took hits, and leave. There is no place for you here. Go to {33}."
},
{ // 57/9D
"You find a turtleshell box. Inside it is the Goblin treasure: 1 gold coin, ½ of a silver coin, and 9 bent, tooth-marked copper coins. There is also a dagger (worth 1 die in combat), a broken mirror, and the last 3 issues of Goblin Gazette. As you look at this trash you slip on a fishbone and fall against the back wall. To your amazement it rotates, and you fall through it, dropping the treasure in Snorkin's Cave. You fall a few feet and land on some kind of silver plate. There is a flash of light and a sharp pain. Go to {43}."
},
{ // 58/9E
"You have slain the devilfish, a practically impossible feat. Give yourself 1000 experience points and take a level bonus on the attribute of your choice as soon as you get out of the water. Tiredly you pull yourself to shore. Go to {52}."
},
{ // 59/9F
"Holding your breath, you swim desperately with the current. Then...light! You are tossed upon a grassy bank near the bottom of a cliff face out in the forest. You have escaped from Goblin Lake. Take 100 experience points and go on your way to some new adventure. The End."
},
{ // 60/9G
"You leap forward, and hear a shrill cry of alarm. There is a hissing in the air that denotes arrows, but they're all behind you as you reach the shore and throw yourself into the water. It's icy cold, and faintly luminescent. There are some low weeds and rushes around the edge. If you wish to hide in the weeds and try to ambush a Goblin, go to {68}. If you wish to start swimming for the other shore, go to {8}. If you wish to dive deep and explore the bottom of the lake, go to {49}."
},
{ // 61/10A
"Snorkin decides that he can trust you enough to show you his treasure. He invites you into his warren, and in the back beneath a pile of old fishbones in a turtleshell box is the fabled hoard: 1 gold piece, ½ a silver piece, 9 bent copper coins with toothmarks in them, a broken mirror, an enchanted dagger (worth 1 die) that glows in the dark when you say \"Glitterglim\", and the last 3 issues of Goblin Gazette. If you feel yourself fired by greed, go to {25}; otherwise, go to {51}."
},
{ // 62/10B
"Feeling like a malevolent hippopotamus, you come up under their raft. Shrill cries of terror and 3 splashes indicate that you have dumped them all into the suds with you. If you wish to ignore them now and keep swimming, go to {21}. If you want to climb on the raft and paddle it away with your hands, go to {45}. If you wish to attack them in the water, go to {71}."
},
{ // 63/10C
"Make a first level saving roll on Constitution (20 - CON). If you make it, go to {19}. If you miss it, go to {2}."
},
{ // 64/10D
"A flying tackle from behind brings you down as you dash for the exit. It is Snorkin, and he's very mad. Several other Goblins come up, and they pummel you mercilessly. Reduce your Constitution by half. They then take your semi-conscious form and throw it down the garbage pit. Go to {46} and skip the first two sentences."
},
{ // 65/10E
"In your desperate struggle you have broken free of the monster of Fishsquish Lake. If you did more than 100 hits worth of damage to it, go to {58}. If you didn't hurt it that badly, you decide that speed is the better part of valour and swim ashore quickly back where you came in. You decide that this is not a good place for a character like you to be. Go to {33}. Give yourself 50 experience points for surviving the fight."
},
{ // 66/10F
"You quickly explain that you too are a Goblin, __________ by name. The voice squeaks, \"That's different. Come down to the lake, off to the right, and get acquainted.\" If you decide to do that, go to {15}, but if you decide not to bother, go to {33}."
},
{ // 67/10G
"You bypass them. Give yourself 5 experience points for forbearance and charity. In a few more minutes you can make out a shoreline sloping up before you. You climb out and explore it. There are no water weeds here, just a fairly large landing of solid stone. At the far end of the stone you locate a large iron door, but it seems to be locked shut from the other side. If your character knows an Unlock spell, go to {42}. If not, you will have to go back, across the pond. Go to {73}."
},
{ // 68/11A
"You are getting colder and colder. Small fish and crabs are nipping at your toes, and no Goblins come. After a while you realize that they are waiting for you to make a move. If you would like to strike out and try to swim across the lake, go to {8}. If you want to dive down and explore the bottom of it, go to {49}. If you'd like to make a break for the door you came in by, go to {10}."
},
{ // 69/11B
"If you are now King of the Goblins, go to {47}. If you are just one of Snorkin's flunkies, return to {51}. If neither of those is true, you'd better get out of here; go to {8}."
},
{ // 70/11C
"Arrows have swished by, narrowly missing you in the dark. You realize these little fellows mean business, and you'd better do something quick. If you want to run away, you will be able to retrace your steps to {33}. If you'd like to dive quickly into the lake, go to {60}."
},
{ // 71/11D
"Each goblin gets 1 die + 3 adds and there are 3 of them armed with daggers. [You may use only your natural weapons or a dagger. ]Fight 1 combat round. If you best them, go to {28}. If they beat you, go to {22}. If they kill you, go to {79}."
},
{ // 72/11E
"You are now a member of Snorkin's band - judging from the general air of poverty and lack of clothing, it is a ragtime band. They lead you around the lake and show you a narrow path hewn on a cliff face that leads to a maze of filthy warrens where they all hang out. After a few days you begin to hear about Snorkin's fabulous treasure. All the other Goblins are very proud of it. Go to {61}."
},
{ // 73/11F
"You slip into the water and are swimming back across when suddenly a mighty tentacle wraps around your legs and drags you under. You turn to see what has attacked you, but all you see is a vast shadowy bulk below you and more tentacles coming up. It is a giant devilfish, and you're on its menu. Fight. [You can only use your natural weapons or a dagger if you have one. ]It gets 8 dice and 50 adds. If you beat it on the first combat turn, go to {65}. If it beats you, go to {9}."
},
{ // 74/11G
"You have come out into the Dungeon of the Bear, run by Max the Magic Ogre. Max will appear in a puff of smoke, and offer you a job as a dungeon monster with him, but you as a person will lose the character. Or you can exit, which will allow you to keep the character, and you can also give yourself 1000 experience points for getting out alive. If you want to be one of Max's monsters, send the character card to Jim \"Bear\" Peters, c/o Flying Buffalo. Thank you! Goodbye!"
},
{ // 75/12A
"Make your second level saving roll on Luck (25 - LK). If you make it, go to {55}. If you miss it go to {46}."
},
{ // 76/12B
"A few days later you have sent all your minions out fishing on the farthest parts of the lake. You pack up the Goblin hoard, leaving behind the 3 copies of Goblin Gazette, and sneak ashore. You tell your sentries that you just want to check something. If you wish to go back out the way you entered, go to {33}. If you want to climb down the unknown shaft, go to {39}. Give yourself 15 experience points for the successful theft."
},
{ // 77/12C
"Snorkin says he'll leave just as soon as he has shown you what the King's duties are. The minute you turn your back he yells, \"Get him, men!\" and a wave of goblins, at least 8 of them, pour over you. You struggle, but it is in vain. They hold you down and take your weapons away from you. Then they go over to a good-sized hole in the ground (their garbage pit), and with a heave and a ho, they fling you down it. Go to {46} and start reading with the third sentence."
},
{ // 78/12D
"The voice said, \"Halt! Who goes there? Only us Goblins are allowed at Fishsquish Lake.\" If you wish to turn back and retrace your steps, go to {33}. If you are a Goblin, and would like to join your kindred, go to {66}. If you are not a Goblin, but want to try talking to them, go to {50}. If you want to take them by surprise by running forward and diving into the lake, go to {60}. If you have the ability and want to make a light go to {24}."
},
{ // 79/12E
"Hello, I thought I'd take this opportunity to speak to you personally. You are likely to read this paragraph a lot, as I believe in dangerous dungeons, and that's going to kill a lot of characters. I want to ask you to help me in a little experiment. Please drop me a postcard telling what kind of character you were playing, which paragraph killed it, the character name, and how you like this dungeon on the whole. Yes, I'm keeping statistics.\n" \
"  Also, since you're reading this, you are eligible for inclusion in the annual T&T Directory. For that, I need your name, address, dungeon name and description if you have any, favourite character name and description, and any general comments you want to make. Inclusion is free, and to order a copy send $1.00 in check or money order to:\n" \
"    Flying Buffalo Inc.\n" \
"    PO Box 1467\n" \
"    Scottsdale AZ 85252\n" \
"    USA\n" \
"and ask for the \"T&T Directory\". I'll be hoping to hear from you. My address is:\n" \
"    Ken St. Andre\n" \
"    3421 E. Yale\n" \
"    Phoenix AZ 85008\n" \
"    USA\n" \
"Meanwhile, you might as well try again. Better luck next time. - Ken"
}
};

MODULE SWORD gl_exits[GL_ROOMS][EXITS] =
{ {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  49,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  79,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  54,  27,  33,  60,  -1,  -1,  -1,  -1 }, //   3/1C
  {  77,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  {  79,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/1G
  {  62,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/1H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2A
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/2C
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2D
  {  40,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/2E
  {  20,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/2F
  {  72,  33,  53,  -1,  -1,  -1,  -1,  -1 }, //  15/3A
  {  33,  39,  36,  -1,  -1,  -1,  -1,  -1 }, //  16/3B
  {   5,  52,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/3C
  {  57,  73,  31,  -1,  -1,  -1,  -1,  -1 }, //  18/3D
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/3E
  {  32,  69,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/3F
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/3G
  {  63,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/4A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/4B
  {  12,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/4C
  {  53,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/4D
  {  49,  53,  33,  39,  -1,  -1,  -1,  -1 }, //  26/4E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/4F
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/4G
  {  79,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/4H
  {  56,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/5A
  {  57,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/5B
  {  48,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/5C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/5D
  {  76,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/5E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/5F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/6A
  {  10,  75,  60,  -1,  -1,  -1,  -1,  -1 }, //  37/6B
  {  18,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/6C
  {  11,  16,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/6D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/6E
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/6F
  {  74,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/6G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/7A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/7B
  {  17,  38,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/7D
  {   1,  39,  33,  -1,  -1,  -1,  -1,  -1 }, //  47/7E
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/7F
  {  23,  20,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/7G
  {  33,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/8A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/8B
  {  39,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/8C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/8D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/9A
  {  39,   6,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/9B
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/9C
  {  43,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/9D
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/9E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/9F
  {  68,   8,  49,  -1,  -1,  -1,  -1,  -1 }, //  60/9G
  {  25,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/10A
  {  21,  45,  71,  -1,  -1,  -1,  -1,  -1 }, //  62/10B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/10C
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/10D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/10E
  {  15,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/10F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/10G
  {   8,  49,  10,  -1,  -1,  -1,  -1,  -1 }, //  68/11A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/11B
  {  33,  60,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/11C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/11D
  {  61,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/11E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/11F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/11G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/12A
  {  33,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/12B
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/12C
  {  33,  60,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/12D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  //  79/12E
};

MODULE STRPTR gl_pix[GL_ROOMS] =
{ "gl0", //   0
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
  "gl15", //  15
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
  "gl35", //  35
  "",
  "",
  "",
  "",
  "", //  40
  "",
  "",
  "gl43",
  "",
  "", //  45
  "",
  "",
  "",
  "",
  "", //  50
  "",
  "",
  "gl53",
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
  ""  //  79
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

MODULE void gl_enterroom(void);

EXPORT void gl_preinit(void)
{   descs[MODULE_GL]   = gl_desc;
 // wanders[MODULE_GL] = gl_wandertext;
}

EXPORT void gl_init(void)
{   int i;

    exits     = &gl_exits[0][0];
    enterroom = gl_enterroom;
    for (i = 0; i < GL_ROOMS; i++)
    {   pix[i] = gl_pix[i];
}   }

MODULE void gl_enterroom(void)
{   TRANSIENT int result;
    PERSIST   int savesmissed;

    switch (room)
    {
    case 1:
        give(511);
    acase 3:
        DISCARD makelight();
        if
        (   lightsource() != LIGHT_NONE
         && lightsource() != LIGHT_CE
        )
        {   room = 24;
        }
    acase 5:
        if (cast(SPELL_KK, FALSE))
        {   room = 42;
        } else
        {   room = 73;
        }
    acase 6:
        create_monsters(282, 5);
        oneround();
        if (con <= 0)
        {   room = 79;
        } elif (good_damagetaken >= 1)
        {   room = 22;
        } else
        {   room = 28;
        }
    acase 9:
        if (con <= 0)
        {   room = 79;
        }
        // %%: does the 5 turns include the first (already-fought) round? We assume so.
        oneround();
        if (con <= 0)
        {   room = 79;
        } elif (evil_damagetaken >= 1)
        {   room = 65;
        } else
        {   oneround();
            if (con <= 0)
            {   room = 79;
            } elif (evil_damagetaken >= 1)
            {   room = 65;
            } else
            {   oneround();
                if (con <= 0)
                {   room = 79;
                } elif (evil_damagetaken >= 1)
                {   room = 65;
                } else
                {   oneround();
                    if (con <= 0)
                    {   room = 79;
                    } elif (evil_damagetaken >= 1)
                    {   room = 65;
                    } else
                    {   room = 79;
        }   }   }   }
    acase 11:
        give(508);
        if (!saved(3, st )) good_takehits(misseditby(3, st ), TRUE); // %%: does armour help for these? We assume so.
        if (!saved(3, st )) good_takehits(misseditby(3, st ), TRUE);
        if (!saved(3, st )) good_takehits(misseditby(3, st ), TRUE);
        if (!saved(3, con)) good_takehits(misseditby(3, con), TRUE);
        if (!saved(3, con)) good_takehits(misseditby(3, con), TRUE);
        if (!saved(3, con)) good_takehits(misseditby(3, con), TRUE);
        if (!saved(2, lk )) good_takehits(misseditby(2, lk ), TRUE);
        if (con <= 0)
        {   room = 79;
        } else
        {   room = 52;
        }
    acase 14:
        give(509);
    acase 19:
        award(thethrow);
    acase 20:
        if (race != GOBLIN)
        {   room = 8;
        }
    acase 21:
        award(10);
    acase 22:
        dispose_npcs();
    acase 23:
        savedrooms(3, lk, 14, 41);
    acase 24:
        if (armour == -1)
        {   templose_con(dice(13));
        } else
        {   templose_con(dice(13) / 2);
        }
        if (con <= 0)
        {   room = 79;
        }
    acase 27:
        savesmissed =
        result      = 0;
        if (saved(1, lk))
        {   result += thethrow;
        } else savesmissed++;
        if (saved(1, lk))
        {   result += thethrow;
        } else savesmissed++;
        if (saved(1, lk))
        {   result += thethrow;
        } else savesmissed++;
        if (saved(1, lk))
        {   result += thethrow;
        } else savesmissed++;
        if (savesmissed == 0)
        {   award(result);
            room = 70;
        } else
        {   room = 37;
        }
    acase 28:
        dispose_npcs();
    acase 33:
        victory(100); // %%: we give them 100 ap based on the rule given in MS22.
    acase 35:
        savedrooms(2, dex, 48, 64);
    acase 36:
        savedrooms(2, con, 59, 29);
    acase 37:
        result = dice(savesmissed);
        good_takehits(result, TRUE); // %%: is it done a die at a time, or all at once? We assume all at once.
        if (con <= 0)
        {   room = 79;
        } else
        {   award(result * 2);
        }
    acase 40:
        if (language[9].fluency >= 1) // Goblin
        {   room = 78;
        } else
        {   room = 3;
        }
    acase 43:
        victory(500);
    acase 44:
        do
        {   oneround();
            if (con <= 0)
            {   room = 79;
            } elif (!countfoes())
            {   room = 34;
        }   }
        while (room == 44);
    acase 46:
        templose_con(dice(10));
        if (con <= 0)
        {   room = 79;
        } else
        {   room = 11;
        }
    acase 47:
        elapse(ONE_MONTH * 6, TRUE);
        award(120);
    acase 48:
        award(100);
    acase 50:
        DISCARD makelight();
        if
        (   lightsource() != LIGHT_NONE
         && lightsource() != LIGHT_CE
        )
        {   room = 24;
        }
    acase 51:
        result = dice(1);
        elapse(ONE_MONTH * result, TRUE);
        award(result * 10);
        savedrooms(1, lk, 26, 7);
    acase 52:
        if (prevroom == 11)
        {   room = 33;
        }
    acase 53:
        give(950);
        create_monster(283);
        oneround();
        if (con <= 0)
        {   room = 79;
        } elif (!countfoes())
        {   room = 34;
        } elif (good_damagetaken >= 1)
        {   room = 30;
        } else // %%: what if neither was wounded?
        {   room = 4;
        }
    acase 54:
        savesmissed =
        result      = 0;
        if (saved(1, lk))
        {   result += thethrow;
        } else savesmissed++;
        if (saved(1, lk))
        {   result += thethrow;
        } else savesmissed++;
        if (saved(1, lk))
        {   result += thethrow;
        } else savesmissed++;
        if (savesmissed == 0)
        {   award(result);
            room = 70;
        } else
        {   room = 37;
        }
    acase 55:
        // %%: how many self-bows? We assume 3.
        give_multi(VSB, 3);
    acase 56:
        dispose_npcs();
        award(good_hitstaken * 2);
    acase 57:
        give_gp(1);
        give(510);
        give_cp(9);
        give(511);
        give(512);
        give_multi(513, 3);
        // %%: it's ambiguous about this treasure, it implies that you drop it, but then GL43 implies you still have it. We assume you still have it.
    acase 58:
        award(1000);
        // %%: what exactly does it mean by "take a level bonus on the attribute of your choice"?
        result = getnumber("1) ST\n2) IQ\n3) LK\n4) CON\n5) DEX\n6) CHR\n7) SPD\nIncrease which attribute", 1, 7);
        switch (result)
        {
        case 1:  gain_st(level);
        acase 2: gain_iq(level);
        acase 3: gain_lk(level);
        acase 4: gain_con(level);
        acase 5: gain_dex(level);
        acase 6: gain_chr(level);
        acase 7: gain_spd(level);
        }
    acase 59:
        victory(100);
    acase 63:
        savedrooms(1, con, 19, 2);
    acase 64:
        templose_con(con / 2);
    acase 65:
        // %%: "more than 100" seems to really mean "100 or more" in this case (eg. GL9 says it has 100 MR, not 101).
        if (!countfoes())
        {   room = 58;
        } else
        {   dispose_npcs();
            award(50);
            room = 33;
        }
    acase 67:
        if (prevroom != 21)
        {   award(5);
        }
        if (cast(SPELL_KK, FALSE))
        {   room = 42;
        } else
        {   room = 73;
        }
    acase 69:
        if (been[34])
        {   room = 47;
        } elif (been[51])
        {   room = 51;
        } else
        {   room = 8;
        }
    acase 71:
        create_monsters(282, 3);
        oneround();
        if (con <= 0)
        {   room = 79;
        } elif (good_hitstaken == 0)
        {   room = 28;
        } else // %%: what if it is a draw?
        {   room = 22;
        }
    acase 73:
        create_monster(284);
        oneround();
        if (good_hitstaken == 0)
        {   room = 65;
        } else // %%: what if it is a draw?
        {   room = 9;
        }
    acase 74:
        if (getyn("Accept job"))
        {   die();
        } else
        {   victory(1000);
        }
    acase 75:
        savedrooms(2, lk, 55, 46);
    acase 76:
        give_gp(1);
        give(510);
        give_cp(9);
        give(511);
        give(512);
        award(15);
    acase 77:
        dispose_npcs();
    acase 78:
        DISCARD makelight();
        if (lightsource() != LIGHT_NONE && lightsource() != LIGHT_CE)
        {   room = 24;
        } elif (race == GOBLIN && getyn("Join your kindred"))
        {   room = 66;
        } elif (race != GOBLIN && getyn("Talk to them"))
        {   room = 50;
        }
    acase 79:
        die();
}   }
