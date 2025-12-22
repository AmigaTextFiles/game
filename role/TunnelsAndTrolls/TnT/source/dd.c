#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Ambiguities/errata (%%):
 Magic Matrix: 34, 73, 103 and 141 have "[15@]" for Panic spell. What does it mean?
 Various non-star paragraphs say to check the Magic Matrix and then turn to another paragraph.
  In these cases, the destination paragraph is the one to use with the Magic Matrix.
 LA127/28D cannot be reached (and yet is not an anti-cheat)!
 Magic Matrix: 1-2[18] presumably means 1-2:¶18.
 Magic Matrix: Witless spell at paragraph 2 gives result #17, which seems intended for Smog spell.
 21, 30, 48, 72: "treat ST/IQ/DEX/LK as a kind of 'Monster Rating'; damage comes off
  ST/IQ/DEX/LK": it is ambiguous whether the attribute should be used as an MR for the purposes of
  generating the Hit Point Total, or whether the normal rules for generating the HPT should be
  used. We assume the former.

These paragraphs are only for multiplayer (and thus are not implemented):
 31, 39, 53, 69, 111, 135.
*/

MODULE const STRPTR dd_desc[DD_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  You will need the Tunnels & Trolls rules (Fifth Edition, preferably), a pencil, paper, and as many 6-sided dice as you can get your hands on.\n" \
"  [Three ]humanoid characters, from 1st-3rd level, with no more than 90 (combined total) combat adds, may adventure inside Dargon's Dungeon. Up to 4th level magic is allowed.\n" \
"  To play, read the description of the situation your characters are involved in. Then, you must react - either by choosing one of the options provided, or by casting magic and using the Magic Matrix (located on page 38 of this booklet) to determine the results. Don't read paragraphs before you are told to, or you will spoil the adventure for yourself.\n" \
"  When you are told to roll for a Wandering Monster, roll 1d6. If it comes up a 1, you have encountered a Wandering Monster - consult the Wandering Monster Chart at the back of this booklet. If you return to a room, that room will house a Wandering Monster and nothing else, even if you did nothing the first time you went through. The only exception is the main entrance room.\n" \
"  When a magic user must rest to regain Strength spent in spell-casting, you must roll once each turn you wait, to see if you are found by a Wandering Monster.\n" \
"[  Keep track of combat turns as they pass during melee; if a combat lasts more than 5 combat rounds, another Wandering Monster will appear as reinforcement for the first one.\n]" \
"  Occasionally you may face a situation where one party member might hold off an attack so the rest of the party can escape. This is permitted only if the \"hero\" can survive at least combat round alone against the attacker. He must have a CON of at least 1 after facing and fighting the opponent, even if he lost that round. If the character who made the stand is killed in one combat round, the attackers didn't even slow down, and the rest of the party must face them.\n" \
"  A * beside a paragraph number means that paragraph is referenced in the Magic Matrix (page 38 of this booklet). When casting magic, choose the spell before consulting the Magic Matrix. (Note: the Too-Bad Toxin spell is not effective inside of Dargon's Dungeon. A few other spells were never judged useful in the context of the dungeon: Detect Magic, Unlock, Hocus Pocus, Omnipotent Eye, and Hard Stuff).\n" \
"  Begin your adventure by going to {114}.\n" \
"~INTRODUCTION\n" \
"  When Dargon, a seventeenth-level wizard, grew tired of conducting esoteric magical research for the Wizard's Guild, he created a dungeon to amuse himself. His labyrinth became known as the \"Four Paths of Darkness\", and it occupies a feared and shunned region of many a delver's memory. Exactly how many adventures transpired within those mysterious walls is unknown, but Dargon eventually grew tired of his original complex, and set about to redesign it.\n" \
"  The time it took to construct the new dungeon was measured in months, leaving delvers the world over ample time to wonder what new horrors the wizard was preparing. Eventually, Dargon felt satisfied with his work, and once again the doors of Dargon's Dungeon stood open to adventurers and thrill-seekers everywhere.\n" \
"  The entrance to the new dungeon stands high upon a sheer and forbidding cliff wall, accessible only by the narrowest of trails. After an afternoon of strenuous climbing, you arrive before the large, rune-covered door to the dungeon. You pause to take stock of your situation. You've been told that a few of the original traps and rooms have been retained from the original dungeon, but that Dargon has added new rooms and dangers to offer challenges to even the most skilled of adventurers. Steeling your nerve, you lead your party through the ominous portal.\n" \
"  Beyond is a small room, occupied by a glowing black sphere which floats before you, throbbing dully. With a chill, you realize that you are rooted to the ground - and the globe closes rapidly on you! You try to scream, but your throat is paralyzed. A voice echoes within your head.\n" \
"  \"Welcome to the Four Gauntlets of Chromatic Doom, oh foolish one...\"\n" \
"  The sphere engulfs you. For the first time, you wonder if this trip was such a good idea."
},
{ // 1/1A
"* The colour of the path darkens into deep brown. You follow it until you find yourself in a field, surrounded by piles of organic fertilizer. The stench is overpowering, and you begin to feel somewhat ill. If you beat a hasty retreat to the northeast, go to {95}. If you run off to the southwest, go to {67}. If you think there might be something of value hidden here, you're free to dig around in the dung heaps at {29}."
},
{ // 2/1B
"* Decide which character is grabbing for gold. When that character disturbs the fluid, the gargoyle springs to life. His talons close over that character's upper body, and forces his or her head underwater.\n" \
"  The gargoyle has a Monster Rating of 70. For every combat turn it is still alive, the character underwater must make a L2-SR on Constitution (25 - CON) to avoid drowning. (If you can breathe water, that's not good enough - this isn't really water!). The character being held under must take hits directly against CON equal to the number by which the saving roll is missed. The person in the water may not fight or cast magic, so if you're alone, write this character off. The gargoyle, however, can hold someone down and fight at the same time! If you destroy the gargoyle, you find 100 gold pieces in the bottom of the basin, and get 70 ap. Return to {26} and leave this room. Or, you can abandon your \"friend\" to his fate and flee - your choices can be found at {26}, you coward!"
},
{ // 3/1C
"* If the archer in question can make a L10-SR on Dexterity (65 - DEX), go to {46}. If your archer misses, and the centaur's aim was true, figure damage against his target. You may try to blast either of the next two arrows out of the air by repeating the procedure above, each time randomly selecting a new target for the centaur (don't forget to include the archer). If you want to fire directly at the centaur with either missiles or magic, go to {41}. To close and attack, go to {24}."
},
{ // 4/1D
"In your hand you hold the card called \"The Ten of Swords\". It shows a body lying face down with ten swords protruding from its back. Suddenly you feel a stabbing pain near your spine, and bright arterial blood warms your back as it flows from the ten deep stab wounds which have appeared there. Your comrades lose sight of you as the mist swirls about and you die. If there are others in the party, go to {74}; your corpse will wait for them there."
},
{ // 5/1E
"* The chest has a complex lock mechanism that reminds you of a little door. A wizard would suspect that an Unlock spell might actually take effect. If a magic-user wishes to cast an Unlock spell to open the chest, go to {75}. Those without access to magic must attempt a L2-SR on DEX. Choose one person to try this - if you make it, go to {75}. If you miss the roll, go to {138}."
},
{ // 6/1F
"You search the area and you locate two magical items cleverly hidden away. (Roll for these on the chart in the back of this booklet.) You also find the loot the merman had stolen in the past - 400 gold pieces. Any weapons and armour stashed here have corroded, and are worthless.\n" \
"  You gather up your booty and join your friends, who have headed off to the northwest at {26} or southeast at {95}."
},
{ // 7/2A
"Each surviving character - who was not immune to fire - has been cleansed. Fire can no longer harm those who have walked this bridge, if the character involved can make a saving roll on IQ at a level dictated by the GM as appropriate. (If someone casts a Blasting Power, for example, a saving roll on the caster's level would be appropriate.) While concentrating (i.e. the combat turns spent, shown by making the IQ roll),the character cannot do much more than move at a walk, and he cannot defend himself or attack anything.\n" \
"  Those previously immune to fire are not cleansed and receive no additional benefits.\n" \
"  From here you may continue east to {57} or west to {102}[, whichever direction you crossed the bridge to reach]."
},
{ // 8/2B
"An incredible amount of power surges into the room, and everyone's skin begins to tingle. Each character must make a L1-SR on ST. If a character misses the roll, add the number missed by to ST; if the roll is made, add the roll of a six-sided die to ST. Mark on each character card that the character has entered this room - if he or she ever enters it again, [this strength will be lost as well as ]another one die of ST points. (Where do you think this room gets its power from, anyway?) From here, you may go out the west door to {144}, or out the east door to {95}."
},
{ // 9/2C
"The door opens easily from the inside, and you step out. A freezing wind blasts you in the face with powdery stinging snow. Squinting, you look out from your aerie over the narrow valley where last you saw the frost giant. If you decide you'd rather go down the loose rock slope again, return to {18}. Otherwise, go to {78}."
},
{ // 10/2D
"You enter this room and halt in your tracks. You see a mummy standing inside a circle of gold coins and a few gems. The mummy makes no move towards you, as long as you do not enter his circle of riches.\n" \
"  If you attack this mummy with weapons, go to {83}. If you set the mummy afire (by [magical or ]mundane means), go to {161}. If you leave this room, you may go west to {95} or east to {71}."
},
{ // 11/2E
"Your fortune was as poor as those who preceded you. A cockatrice has chosen this area to spawn, and its deadly gaze fell upon you before you saw it. You have been turned to stone, and you are now a truly lifelike statue, well and cunningly made, worth more than 1000 gp to one who collects such items. Now, however, you will decorate the back hallways of Dargon's private rooms..."
},
{ // 12/3A
"This is a small room. Inside, you find two simple chests set side by side. They are made of oak bound about with silver, and they radiate magic.\n" \
"  If you would like to open the chest on the right, go to {5}. If you want to open the left chest, go to {61}. If you would like to open both at the same time (one person can reach both), go to {28}.\n" \
"  If you would like to leave the chests, you may head west to {120}, southeast to {157}, east to {102}, or northeast to {51}."
},
{ // 13/3B
"You avert your eyes in horror as the priest atop the pyramid lifts a gleaming obsidian dagger high in the air and then plunges it into the breast of his captive. The priest rips the still-beating heart from the chest of the sacrifice and holds it high. A shaft of sunlight strikes it, and a blood-red glow washes over the priest. It fades, but a jade cat-face on the gold pectoral plate he wears begins to pulse. He speaks a word in a tongue you fail to understand, and the warriors behind you stir, then rise to advance upon you again.\n" \
"  You are in a delicate situation. You should kill the sorcerer/priest - but the warriors will attack you from behind if you ignore them. You can fight by going to {64}, or flee by going to {37}."
},
{ // 14/3C
"* You draw the card known as \"The Devil\" from the table; the mists swirl wildly about you. When they clear, you are standing in the middle of a sun-drenched arena. Crowds call from the stands. Across the sand from you stands a demon; he is your foe.\n" \
"  The demon has a Monster Rating of 40 (5 dice + 20). He may hold a magical item. (Roll once on the Magical Treasure Chart in the back of this booklet. The demon holds this treasure[; if it is a magical weapon, you must deal with it in the fight accordingly].)\n" \
"  If you survive the battle, you may keep the demon's magical treasure. You also receive the adulation of the crowds. A woman as dark as night and as alluring as death presents you with a gold-and-amber bracelet worth 2000 gp. Return to your own world by going to {74}; wait there for the rest of your party."
},
{ // 15/3D
"* Roll two dice and multiply the result by 5. This is the merman's Monster Rating. If you kill him, go to {6}."
},
{ // 16/3E
"You were far more fortunate than your companions. You saw the cockatrice before it saw you. In its rage, it has turned itself to stone, and is now a beautifully realistic statue of a lizard-like creature. A collector would probably pay 1000 gp for it, so take it with you.\n" \
"  You also stink to high heaven. Cut your CHR by 3 until you have a chance to take a bath. (If you have an elemental in your service, it's now trying to kill you.) Go northeast to {95}, or southwest to {67}."
},
{ // 17/4A
"* In the centre of this room you find a pit. Delicately balanced across a slender iron beam over the pit, you see a plank with a box set on each end - a teeter-totter device. It is painfully obvious that the removal of one box will cause the second to fall into the deep pit. The box on the right is made of gold; the box on the left is crafted of silver.\n" \
"  From this room you may go south to {57}, or north on the blue path to {26}. If you're more interested in the boxes on the teeter-totter, you can try to take the golden box on the right by going to {86}. You can try for the silver box by going to {133}. You may attempt to take both at the same time by going to {66}."
},
{ // 18/4B
"The tunnel ends abruptly, and you are standing in an opening that looks down and out over a vast dark jungle. A red gravel path leads down from your perch, into a long wide scree slope of loose shale and rock that looks more than merely treacherous.\n" \
"  If you want to return, go back to {9}. If you want to try to go down the slope, go to {80}."
},
{ // 19/4C
"* The giant is a huge target at far range; you will need to make a L3-SR on Dexterity (30 - DEX) to hit him. His CON is 40, and the exchange of missiles is simultaneous. You are a large target at far range, and so the giant must make a L6-SR on DEX to hit you (his DEX is 42, and he must roll a 5 on 2 dice to hit you; if the target size is smaller, recalculate the SR required according to the rules). If more than one character is present, randomly decide who is the giant's target. Fight until one side or the other is slain - the giant's snowballs each deliver 3 dice + 100 adds. If any among your party remain alive, send them to {54}. If you close and fight at the end of any combat round, go to {126}."
},
{ // 20/4D
"The chest springs open and a small earth elemental (MR 25) hops out. It stands before the character who released it, and pledges to serve him from this time on, until either of them dies. However, you know a little bit about elementals, and realize that if your Charisma ever drops, the elemental will try to kill you. The other chest has vanished. From here you can go west to {120}, southeast to {157}, east to {102}, or northeast to {51}."
},
{ // 21/4E
"You awake to find yourself stripped of all clothing and armour. You are seated in a circle which is divided once down the middle. Your left hand is extended, and grasps the left hand of someone who appears to be your mirror image. You suspect this spot may be a nexus of adjoining universes - in another universe, your analog entered the area at the same time. Now, only one of you may leave.\n" \
"  Hanging in mid-air behind you, just out of arm's reach, is a sax; another hangs behind your analog. To reach your sax, you must drag your analog over to your side of the circle. He will be trying to drag you to his side. This is a contest of Strength against Strength.\n" \
"  Your double has your ST rating. For this combat, treat ST as a kind of \"Monster Rating\", and take damage off Strength. The first one whose Strength goes to zero or below is exhausted by the fight, dragged to the other side and killed with the sax. If you are the survivor, go to {35}."
},
{ // 22/5A
"You hold the card called \"The Chariot\" in your hand, and stare at it. Suddenly you find yourself in a real chariot, flying a blazing trail across the sky. The horses are huge brutes and no one is at the reins. In fact, you are the only one in the chariot!\n" \
"  The chariot begins to dive towards the earth. If you make a L2-SR on your Dexterity (25 - DEX) *and* on your ST (25 - ST), you will be able to guide the chariot to a safe landing. If you miss both saving rolls, the chariot smashes into the earth, completely out of control, and you die. If you miss only one of the saving rolls, take the number you missed by in damage to your CON: the horses over-reacted to an inept move and spilled you out of the chariot. Your armour may take damage[ (but cannot be doubled)].\n" \
"  If you landed the chariot safely, the horses turn and nicker, and you see an awesome intelligence in their eyes. Into your mind comes the knowledge that this chariot and these steeds are yours[ to command three times (and three times only), out of respect for your ability]. [You can summon this chariot three times to get you out of trouble during any adventure. You must be in some place where two horses and this chariot can teleport into (at least 8x15' of unobstructed space). Then you (that is *you* the player, not just your character!) must stand up and say in a clear strong voice: \"Swing low sweet chariot, Coming for to carry me home!\" The horses and chariot will appear, and you alone can climb aboard. The chariot will deliver you to your home. No magical weapons, treasure, or anything gained during that trip will go with you. However, nothing will stop the chariot from rescuing you and carrying you home, once you've summoned it.\n" \
"  For now, the chariot and its steeds vanish. ]Go to {74} and wait for the rest of your party."
},
{ // 23/5B
"Your Luck returns to what it was before your escapade in this room. You retrieve the paired dirks from the body of your analog. These dirks are balanced well for throwing, and are magical. [If you use them as missile weapons and miss the Dexterity saving roll to hit a target, you can try to make a Luck saving roll at the same level to see if you might hit by luck instead of skill. (If you missed the DEX roll, but made the LK roll, you would not get any DEX adds for that missile attack.) ]In all other respects, these dirks are like any other daggers you have ever seen. Go to {90}."
},
{ // 24/5C
"As you close, the centaur has time to shoot at the lead character (the one with the highest Speed rating). The centaur will not release the arrow until his target is at pointblank range. Determine the saving roll for the centaur (his DEX is 30) and see if he makes it. If he does, the arrow does 6d+62 in damage. Once this has been figured, go to {68} and fight him at close range."
},
{ // 25/6A
"\"For you, a warrior, I have a choice. I can give you an item which is defensive, or one that is offensive.\" For the offensive gift, go to {52}. For the defensive gift, go to {85}."
},
{ // 26/6B
"In the northeast corner of this room you see a large stone basin. It collects the fluid which pours from the mouth of a stone gargoyle that is perched on the side of the basin. If you would like to inspect the basin and the gargoyle, go to {97}. If you would rather leave, you can go north to {76}, south to {17}, southwest to {51}, or southeast to {130}."
},
{ // 27/6C
"It is not healthy to drink liquid mercury. Dargon knows you'll suffer debilitating, degenerative diseases for the rest of your natural life, and mercifully strikes you dead. Any surviving party members should return to {102} and make a new choice (although they are free to drink from this lake, if they wish!)."
},
{ // 28/6D
"* Although the chests have unusual locks, an attempt to open both simultaneously will bypass the mechanisms. As the lids open, you find you have released an earth elemental from one chest, and an air elemental from the other. These two beings immediately attack each other. Wind and sand blast furiously about the room.\n" \
"  Any character not in armour must take 2 dice worth of hits from the sand-blasting. Those in armour take only 1 die worth of hits, as the sand and grit penetrate every cranny in your armour and cause an aggravating chafe. Both chests are destroyed, and the elementals tear each other to pieces. You can scavenge for silver fragments; you'll find about 25 gp worth.\n" \
"  You can go west to {120}, southeast to {157}, northeast to {51}, or east to {102}."
},
{ // 29/6E
"Each character who searches must make a L2-SR on LK. If all succeed, go to {62}. If not everyone makes the roll, those that missed should go to {93}, and those who made the roll should go to {159}."
},
{ // 30/6F
"You awaken to find yourself naked, paralyzed, and seated inside a circle. Facing you, from the other side of the circle, is someone who looks exactly like you. From tales you've heard, you deduce that this is a dimensional nexus, and you will have to battle to the death against your analog in order to leave this place.\n" \
"  In the centre of the circle, hanging in mid-air, is a haladie dagger. One of its curving blades points to your heart - the other is aimed at the heart of your analog. Because neither of you can move, you must force the dagger forward with your minds.\n" \
"  Your double has the same IQ rating you do. For this combat, treat IQ as a kind of \"Monster Rating\", and take all hits off IQ: The first of you to have your IQ reduced to zero or below cannot prevent the knife from plunging into your heart. If you are the survivor of this bizarre contest, go to {136}."
},
{ // 31/7A
"Both characters grabbed their respective boxes at the same moment. Their screams make it clear that the boxes are stuck to the plank - and the characters cannot free their hands from the boxes! The heavier character falls, and the teeter-totter pivots. The lighter character is thrown high into the air, and smashes down against the edge of the pit, as the lower man completes an abbreviated arc which slams him into the pit wall.\n" \
"  Figure the weight of the heavier person (including armour, weapons, pack, etc.) in weight units. Divide this number by 100, and the result is the number to use as a \"Monster Rating\" to be delivered directly against each character involved. (If the heavy character has a total weight of 1500, this would result in a \"MR\" of 15, and 2d+8 is delivered as damage against each of the two characters. armour can take damage, but warriors cannot double armour).\n" \
"  If either character is dead, and/or the third party member has brought no rope, go to {53}. If neither character is dead and you have some rope, go to {135}. If there is no third party member, go to {53}."
},
{ // 32/7B
"The green path leads you into a room that is a perfect cube. Each wall, the ceiling, and the floor are made of a seamless, silvery metal. In the north wall is a panel with a single unmarked button. To the west is a door that leads to {144}, and to the east is a door that leads to {95}.\n" \
"  If you don't leave the room, and you press the button on the panel, roll 1 die. If you roll a 1, go to {155}; a 2, go to {8}; a 3, go to {59}; a 4, go to {81}; a 5, go to {152}; a 6, go to {108}."
},
{ // 33/7C
"\"Ungrateful dogs!\" she cries, and casts a Mind Pox upon you before you can raise a defence. As the spell wears off, you find that during your incapacitation she slushed the floor, and stood you in the quicksand up to your neck. The ground has hardened around you, and you are in a gentle basin filled with wine which laps at the bottom of your throat. Hanging above you, just out of reach of your teeth, are bunches of grapes.\n" \
"  \"Such is the manner in which I deal with ungrateful guests,\" she sneers. \"I ask little and offer much. I hope now you will enjoy my hospitality!\"\n" \
"  Those of you who may be immortal will find yourself here forever, unable to drink or eat although wine and food are all about. The mortals are more fortunate, for they will simply die..."
},
{ // 34/7D
"* Roll 1 die and add 1. This is the number of ulogulos that have jumped you. You have time for magic, but missiles will require twice their usual saving rolls to hit, because of the gusting wind and bad visibility. (Each ulogulo presents a \"large\" target at \"pointblank\" range - doubled - meaning a L4-SR on Dexterity (35 - DEX) to hit.)\n" \
"  Each ulogulo has a Monster Rating of 15. If you kill all that have attacked within two combat turns, take 10 ap for each one killed (to a maximum of 50 ap) and go down to the frost giant's valley at {67}, or to the south door at {73}.\n" \
"  If any beasts live at the end of the second combat turn, more may arrive. Roll 1 die; if you roll 1, 2, or 3, that number is the number of additional attackers. If you roll 4, 5, or 6, no more come - yet.\n" \
"  If you kill all the ulogulos, you can go down into the valley at {67}, or to the south door at {73}."
},
{ // 35/7E
"The second sax has vanished, but yours is gripped firmly in your hand, won by the strength of your body. Your Strength returns to what it was before the battle. This dagger, a fine sax, will never leave your grip unless you wish it to, and it is unbreakable. In all other respects, it is like any other sax you have ever seen. Go to {90}."
},
{ // 36/8A
"Mercury has splashed into your eyes. If this is the first time you have missed the second level saving roll on Luck (25 - LK), you are only partially blinded. [From now on, cut your attack by ¼ (you'll only do 75% of your normal damage, rounded down). However, if you were fighting in complete darkness, you would be as bad off as everyone else, so you wouldn't have to cut your attack. If you do not have a Too-Bad Toxin cast on you within two weeks of leaving this adventure, you will be permanently blinded. ]Return to {147} and continue your battle...\n" \
"  If this is the second time (or more) you have missed the roll, you are completely blinded. [Cut all your attacks in half (round down) until you can get a Too-Bad Toxin cast upon you. If you do not have the spell cast within a week of leaving this adventure, your eyes have been destroyed and nothing will restore normal sight. (Magic-users take note: spells which require line-of-sight aiming are now beyond your abilities.) ]Return to {147} and continue as best you can."
},
{ // 37/8B
"* The undead warriors lurch to cut you off. Try to make a first level saving roll on the average of your Dexterity and IQ (25 - ((DEX + IQ) ÷ 2)). If you make it, you dodge between two warriors and flee. You can go back to the scree slope where you left the tunnels by going to {50}. If you wish to leave the adventure, you can walk the red-lighted path you saw earlier by going to {71}.\n" \
"  If you miss the saving roll, a warrior grabbed your arm, and you must fight one combat round one-on-one with the ghastly creature. If you defeat it in the first combat round, you can break free and leave. But for each combat round you do not break free, another warrior joins the fight. If you incapacitate all six zombie warriors, you can turn and see that the priests have fled inside the pyramid, and have sealed the door behind them. You hear a hideous rustling and the warriors are reanimating for another attack. Flee screaming into the jungle by running towards the slope of loose shale ({50}), or to the red-lit path out of this adventure ({71}). This fight was worth 200 ap."
},
{ // 38/8C
"As you follow the blue path north, you come to a small room which contains a great throne of ebon stone. The throne radiates evil magic so strongly that even warriors can sense its malice. If you wish to back away and leave this throne, you may go north to {71}, or return to the south by going to {76}. If one of the characters in the party wishes to sit in the throne, go to {98}."
},
{ // 39/9A
"Both characters deftly pluck their box from the teeter-totter. The gold box is worth 250 gp, and the silver box worth about 150 gp. Both are empty. From this room, you can follow the blue path north to {26}, or south to {57}."
},
{ // 40/9B
"The white path leads you towards an open pit in the floor. Heat waves twist the image of what lies beyond. In the pit itself you squint your eyes against the heat and see glowing coals and white-hot metals - the remnants of weapons and armour of those who failed to cross the narrow rock bridge over the pit. You jump back, startled, when a hollow voice from nowhere booms around you. \"This is the path of Purity. Those who pass are cleansed; those who fail are punished.\" If you have come from the east, you may return without difficulty to {57}. If you came from the west, you may return to {102}. If you wish to cross the bridge, go to {156}."
},
{ // 41/9C
"* A L4-SR on DEX is required to hit the centaur with missiles. He will shoot an arrow at the same time you shoot your first. Choose another target randomly (don't forget to include yourself) and try for his SR to hit (DEX of 30). If the centaur does score a hit, his arrow does 6d+62 in damage. If you hit the centaur, remember he has a CON of 30 and wears mail. If you kill him, go to {54}. If you want to close and attack him at the end of any combat round, go to {24}."
},
{ // 42/9D
"* If you can burn these down with a flame-device[ or spell], do so and flee to the rocky slope at {50}, or the red-lit exit at {71}. If you have at least a 4-die slashing sword or slicing axe, you may leave unhurt also. Otherwise, you will have to crush down the thorn bushes as best you can - you must make a L6-SR on Luck (45 - LK) or you will fall asleep. If you make the Luck roll, you can leave. If you fail the saving roll, the thorns have penetrated your body somewhere, and you fall into a deep sleep. How long you remain asleep matters little, because before you awaken, you too will have been sacrificed."
},
{ // 43/9E
"You hold the card called \"Strength\". As you look into it, it changes into an exquisite goblet of gold worked about with jewels. The cup is filled with liquid, and you gulp it down. Roll 1 die. If you roll 1-5, you may roll the die again and add that number to your Strength. If you rolled a 6 you may roll 2 dice and add that number to your Strength. The empty goblet remains; it is worth 300 gp. Go now to {74} and wait there for the rest of your party."
},
{ // 44/9F
"* The circle of wealth was composed of four hundred gold coins and three gems (roll for them on the Jewel Generator in the rules).[ To leave this room, you must break down one of the doors by delivering 100 hits to it with reasonable weapons (swords are not reasonable, for instance).\n" \
"  For each combat turn you spend working on one of the doors, roll to see if a Wandering Monster is teleported in by Dargon to harass you for destroying his mummy. You won't be able to leave this room until the Wandering Monster(s) are dead...]\n" \
"  If you break down the east door, go to {71}. If you break down the west door, go to {95}."
},
{ // 45/10A
"You leap upward and catch your fingers on the rim of the hole. Your body swings, and your fingers almost slip. Quickly you draw yourself up through the hole. As you stand, you notice a wizardly-looking man watching you. \"I am Dargon,\" he says. \"Is there something I can do for you?\"\n" \
"  If you are a warrior, go to {25}. If you are a rogue, go to {96}. If you are a wizard, go to {154}. If you are a warrior-wizard, you may choose either {25} or {154}. (If this character has ever been here before, go directly to {71}.)"
},
{ // 46/10B
"\"Whoa, good archer! I'll not trouble you any more!\" the centaur cries. \"I was set here to guard a treasure that is both a danger and a boon, and I have been instructed to bestow that treasure on any being who can shoot my arrow from the air.\"\n" \
"  He removes his quiver, pulling out any remaining arrows first, and hands it to the archer. \"Within this quiver are ten arrows fletched with the feathers of Ghost Hawks,\" he explains. You feel around and find there are indeed arrows in the quiver, although they are invisible to the naked eye. [These arrows will fly the maximum distance your bow can send them, and will not be affected by any intervening terrain except magic walls or spells like the Protective Pentagram. If you make your DEX targeting roll, the arrows will hit your intended target, doing whatever damage your bow is normally rated at. You must know exactly where your target lies. (If you know a monster waits on the other side of a wall, that's all right - but you can't assassinate the local king by firing the arrow into the air blindly, not knowing anything except that the king is within range!) The arrows will pierce armour as though it did not exist, *even magical armour*.\n" \
"  That is the boon. The danger is that if you miss your DEX targeting roll by rolling a 3, the arrow generates its damage *directly to you*. ]Once an arrow has been used, it is destroyed.\n" \
"  From here you can go north to {57} or south to {67}."
},
{ // 47/10C
"The jungle path is dark and wet. Every so often you catch sight of amber eyes burning from beyond the jungle walls that enclose your path. The screams of jaguars and their prey cause shivers beyond what the dampness might produce. Roll once for a Wandering Monster. Finally, the jungle opens before you and sunlight falls again upon your shoulders. In the clearing before you stands a grey stone pyramid. It has blocky stepped sides; intricate stone carvings adorn each corner. Halfway to the top you see a small procession: a priest, six warriors bearing a bound captive, and one lesser priest who holds a bowl of beaten gold in both hands. More gold glints from jewellery worn by the priests and warriors.\n" \
"  To your left you can see a side path with a red glow around it, and you sense it is an exit from this place. If you wish to go there, go to {71}. If you wish to rush up the pyramid in an attempt to save the captive, go to {92}."
},
{ // 48/11A
"Your mind slowly clears, and the first thing you see is a person who appears to be your twin. Your possessions have been stripped from you - you are naked and seated on a very soft, bouncy, pink pad. Resting beside you is a nicely-balanced broadsword. You swiftly deduce that you have somehow stumbled into a dimensional nexus - a point between universes - and the person opposite you is your analog. You also know that only one of you can leave here alive.\n" \
"  Your analog rises to its feet, grabs up its broadsword, and begins to bounce on the pad. You also rise and begin to jump. Suddenly your double leaps forward and aims a cut at your head. You dodge to the side and bounce away to safety. This fight will be decided by your Dexterity as you bounce and fight.\n" \
"  You both have the same DEX rating. For this combat, treat DEX as a kind of \"Monster Rating\"; damage comes off DEX. As you battle, the first whose DEX reaches zero or below has failed to dodge a fatal swing and dies. If you are the survivor, go to {70}."
},
{ // 49/11B
"The throne writhes up about your limbs, nearly cutting off your supply of air. The sensations are so unpleasant you must make a second level saving roll on IQ (25 - IQ) to control yourself enough to stay put. If you make the saving roll, go to {112}. If you miss, you panic and attempt to fight your way free. Go to {160}."
},
{ // 50/11C
"* You must return up the steep slope of sliding rock and loose shale. This will be very exhausting. Make a L3-SR on Strength (30 - ST) as you climb. If you miss, take the number you missed by from your Strength. You'll make it to the top regardless, but if your ST falls to zero or below, your heart gives out at the top and you die of overexertion. [You can rest at the top to recover your Strength (1 point per turn), but you must roll for a Wandering Monster each turn you rest. ]Return to {9}."
},
{ // 51/11D
"The floor of this room has been painted a pale blue. In the southwest corner is a doorway, and another is set into the northeast corner. Against the east wall is a strange box-like object; its purpose seems to be to dispense liquid refreshment. Magic-users sense a dampening of certain spells they might know, and suspect a Too-Bad Toxin would have no effect on the drinks taken from this machine.\n" \
"  If you want to leave this room, you may go northeast to {26}. If you would rather go southwest, go to {12}. If you want to buy a drink, push 5 gp into the machine's coin slot and it will dispense a cup of liquid. They all look pretty much the same, so drink it and turn to {84} to discover the effects of what you have consumed."
},
{ // 52/12A
"Dargon hands you a sword.[\"This sword will use your life force as offensive power in a fight,\" he explains. \"In the same manner a magician spends Strength points to power a spell, you may use CON points to power this sword. For every CON point of your own that you put into the sword (to a maximum of 50 points), you'll get 1 combat add on the sword. The additional combat adds only last 1 combat round, but you can regain what you lost by resting, just as a mage regains Strength.\"\n" \
"  (For example, Thongeer has a CON of 30. He puts 20 of those points into the sword, and gets 20 extra weapon adds - but his CON is no more than 10 until he rests. When he rests, he'll regain his CON at one point per full turn. If Thongeer took 10 hits after he put 20 CON points into the sword, he'd die. If he only took 5 hits, he'd have a CON of 5, and couldn't regain the 5 lost from hits by resting.)]\n" \
"  Go to {71}."
},
{ // 53/12B
"* The dead character slips from its end of the plank. If this is the heavier character, the weight shifts, flipping the lighter character into the pit. If the lighter character had died, his falling body batters the lower person again - he loses what was left of his grip and plummets into the darkness below. The survivor - if there is one - may go along the blue path north to {26} or south to {17}."
},
{ // 54/12C
"The reason the snowballs delivered so much damage (aside from the fact that they were the size of large pumpkins), was because the giant had packed them around \"ice\". Not being exceptionally bright, the giant used a 100-gp diamond for the centre of each snowball. There were 12 snowballs, so you can find a maximum of 1200 gp in blue-white diamonds. From here, you may go out the odd doors north to {134}, south to {78}, northeast to {1} or northwest to {157}."
},
{ // 55/12D
"The card you hold is the \"Ace of Wands\". It moves under your fingers and becomes a deluxe staff. If you are a wizard, you discover that the staff holds all the spells from first through third level, and one fourth level spell (choose one).\n" \
"  If you weren't a wizard before, you are now - *regardless* of what you were before. Your larger weapons have vanished, and your class has been changed to wizard. If your IQ was less than 10, it has become 10. The deluxe staff is the same as described above. Go to {74} and wait for the rest of your party."
},
{ // 56/12E
"* Each fencing dummy has a MR of 10; there are between 2 and 12 of them (roll 2d6). [Any weapon which hits them will stick! You get a normal attack, but if you haven't destroyed a dummy on the first combat round, you must fall back on secondary weapons. If you can make a L2-SR on DEX, you can hit the painted heart on the dummy's chest, which will turn it off. (If you miss the SR, your weapon is stuck in the dummy - try again.) ]If you destroy [or turn off ]all the dummies, Entak attacks you - go to {132}."
},
{ // 57/13A
"As you re-enter this room, the floor moves under your feet, It moves slowly at first, but quickly picks up speed, until it whirls you around faster and faster. The swirling pattern of light and dark mesmerizes you, and you feel very dizzy and very unsteady on your feet. Overhead, a hole opens in the ceiling; you hear a loud click as foot-long spikes spring from the walls. Each spike seems to beckon you to a painful rest.\n" \
"  You may dive for anyone of the doors that lead out of this room (make a L2-SR on DEX), or you can try to leap up to the hole in the ceiling (make a L3-SR on DEX). Parties may split up if they wish, but this is not advised. If you fail to make either saving roll, you are flung against the spikes - take hits equal to the number you missed the saving roll by. (Do not count armour - the spikes will punch right through even the heaviest plate.)\n" \
"  If you make it through the blue door (north), go to {17}. If you make it through the red door (south), go to {134}. If you make it through the green door (east), go to {144}. If you make it through the white door (west), go to {40}. If you make it up to the hole in the ceiling, go to {45}.\n" \
"  Characters who miss the DEX saving roll are impaled on the spikes. The floor grinds to a halt, and they should go to {139}."
},
{ // 58/13B
"Roll 2 dice and subtract that number from your Strength permanently. If your ST goes to zero or below, you are dead. If your ST is 1, you are in a coma and will not revive until you have left this dungeon, carried out by companions. (If you're alone, or if your \"friends\" leave you behind, you'll die quickly; the first Wandering Monster to come along will eat you for dinner.) If your companions carry you along, you cannot make saving rolls other than on CHR or LK; if you're called upon to make any others you must assume the roll was missed. Characters still conscious should make sure they are not now overloaded with treasure or equipment.\n" \
"  [A Too-Bad Toxin will cure this problem, but for some curious reason the spell doesn't work inside this dungeon. ]Now go to {26} and exit this room."
},
{ // 59/13C
"* You have just activated Dargon's magical microwave oven! Any character with \"silver\" skin may go freely to the west door and {144}, or to the east door and {95}. Other characters (armoured or not) are swiftly cooked from the inside out. Magic *might* actually help you survive; choose your spell carefully and check the Magic Matrix."
},
{ // 60/13D
"The display is fantastic and delightful; watching it is worth 100 adventure points. After the water quiets, you can leave by going west to {32}, east to {10}, northwest to {130} or southwest to {1}."
},
{ // 61/13E
"* The chest has an odd lock mechanism that looks suspiciously like a tiny door. Someone suggests that an Unlock spell might actually take effect. If a magic-user casts an Unlock spell, go to {20}. Otherwise, someone will have to pick the lock - to do so requires a L2-SR on Dexterity (25 - DEX). Choose one person to try. If the roll is made, go to {20}. If that character misses the roll, go to {148}."
},
{ // 62/14A
"Beneath a pile of manure you find a small statue of a serpent-like creature. It is beautifully crafted, and the statue appears very life-like although it is clearly not alive. A collector would probably pay 1000 gp for it. From here you may wend your smelly way to the northeast (go to {95}) or to the southwest (go to {67}). Because you smell so bad, cut your Charisma by 3 until you get a chance to take a bath. (If you have an elemental in your service, it's now trying to kill you.)"
},
{ // 63/14B
"You find she is an excellent conversationalist, intelligent and witty. She tells you that to the north is a thing of great evil, but she refuses to elaborate. You continue to swap stories and entertain her with good conversation until finally she insists she is weary and bids you a fond farewell. Her conversation has been worth 50 adventure points to everyone present. Go north to {38} or south to {26}."
},
{ // 64/14C
"* If only one character remains alive, you must fight the warriors before you can attack. If you have more than one character here, you may divide up your opponents. Choose who will attack the priests and who will hold off the warriors. If the warriors kill their opponent(s) before both priests are dead, they will swarm up the pyramid to attack you. If you kill the high priest who controls these undead warriors, those warriors will drop immediately.\n" \
"  The lesser priest protects the high priest, and you must kill him to reach the other. The lesser priest has a Monster Rating of 15 and uses no weapon.\n" \
"  The high priest gets 2d-1 for the obsidian dagger. [After each combat round, roll 2 dice for him. A result of 2 to 7 means the knife shattered, and the high priest must fight bare-handed (1 die). ]The priest/sorcerer gets 30 combat adds and has a CON of 15. He wears no armour, and any undead warriors still fighting drop dead when he dies.\n" \
"  If any of your party survive, go to {87}."
},
{ // 65/14D
"* You were in the lead when something suddenly grabbed your legs and dragged you underwater. You have been snatched by a giant octopus that lives beneath the water in an underground cavern behind the dungeon walls.\n" \
"  Roll one six-sided die. Multiply this by 10, and the result is the creature's Monster Rating. It has dragged you into its lair - fortunately for you, there is an air pocket, and the lair isn't deep. You can get to your feet to fight, and you aren't restricted to daggers. Battle this thing as best you can; if you kill it, go to {124}."
},
{ // 66/15A
"Trying to take both boxes at the same time is easiest with two characters. However, one alone may try (with a greater chance of failure). If a single character makes the attempt, send that character to {121}.\n" \
"  Otherwise, decide which two characters will grab for chests, and which chest each tries for. Each must make a L2-SR on Dexterity (25 - DEX). If both make the roll, go to {39}. If only one makes it, go to {111}. If neither character makes the roll, go to {31}."
},
{ // 67/15B
"When you enter this room, a blast of cold snowy wind hits you in the face, nipping your nose and ears. You are in a narrow, snow-choked valley, and the primary focus of your attention is a huge frost giant standing in the middle. Near him is a pile of eleven giant-sized snowballs, and he holds another snowball in his hands. At each end of the valley you see exits - three in the northern area (leading north, northeast, and northwest), and one door set high in the valley wall, leading south.\n" \
"  The frost giant grins hugely, and readies himself to fling his snowball at you. If you would like to run for one of the exits, note which one you head for and go to {110}. If you wish to trade missiles with the giant, go to {19}. If you want to run in to attack at close range with melee weapons, go to {126}. Magical attacks should be dealt with at {19}[ after you write down your chosen spell]."
},
{ // 68/15C
"* The centaur warrior has only a kris knife as a weapon suited for in-fighting. He has a CON of 30, 44 adds, and wears mail (11 hits, doubled). If you kill him, go to {145}."
},
{ // 69/15D
"* You were second in line to enter the water. It isn't very deep along the central pathway, but the edges drop off abruptly. Suddenly, a large hairy hand grabs your calf and drags you underwater. The troll who has grabbed your leg is trying to use his weight to sink you deep, deep, deep, and plans to hold you under until your lungs burst. (Oddly enough, the troll doesn't seem to be having any difficulty breathing.) The only weapon you can reach is a dagger (if you don't have one, you must fight bare-handed). The troll has a CON of 30; he is simply holding you tightly (he isn't actually *attacking* you). For each combat turn you fight, you must make a saving roll on your current CON. (For the first combat round you must make a L1-SR, for the second combat round a L2-SR, and so forth.) For each roll you miss, you must take damage to your CON equal to the number you missed the roll by. Each SR must be made on your *current* CON, and simulates the strain of holding your breath and the great pressure. (Even if you can breathe underwater, you aren't free yet - subtract one level from the required SR, but continue combat as described above.) If you kill the troll before you succumb to water and pressure, go to {146}."
},
{ // 70/15E
"Your DEX returns to what it was before this fight, and you realize that the broadsword you hold is enchanted. [While in hand-to-hand combat, if you can make a DEX-SR against the number of hits a foe (or group of foes) has as combat total, you will have parried those blows and they cannot hit you. (If your DEX is 40, and your opponent has a hit point total of 52, you must roll L2 as your \"saving roll\" - and if you make it, that opponent cannot hit you that round, no matter what *you* rolled as a hit point total). ]In all other respects this is a normal broadsword, worth 3d+3 in combat. Go to {90}."
},
{ // 71/16A
"A roar like rending steel freezes you in your tracks, and once again you feel an all-too familiar paralysis grip your body. The throbbing black sphere that carried you into this dungeon bounds out of nowhere to block your path. You experience an agonizing moment of terror as the sphere closes over you...\n" \
"  You soon find yourself in the original entrance room. Your treasure and magic items are heaped around you; you have lost no experience points. The black globe recedes from view into some unknown netherworld, wailing ominously.\n" \
"  Your time within Dargon's Dungeon is at an end. [As a reward for escaping, you may take 10% of the experience points you earned within the dungeon as additional adventure points. ]You can now leave the dungeon without difficulty. You've avoided doom once again - your destiny lies before you."
},
{ // 72/16B
"You slowly come to, and realize all your clothing and possessions have been removed. You float serenely within a pale pink sphere; opposite you floats a person who looks exactly like you. Suddenly you realize you are in a nexus of the universes - only one of you may leave alive.\n" \
"  Two dirks appear suddenly within the sphere, and fly behind you, whirling around the walls at high speed. You twist and dodge, but only your luck seems to influence how close the blades come to you. Your analog has the same Luck rating that you do. For this combat, treat LK as a kind of \"Monster Rating\" and take damage off Luck. The first to have his Luck driven to zero or below finds both dirks driven deep into his heart. If you are the survivor, go to {23}."
},
{ // 73/16C
"* This door is a blue rune-covered stone; there is no latch. An Unlock spell will open the door (casting it will take one combat turn). A rogue may unlock this door without magic if he can make a L1-SR on DEX (this will take one combat turn). Any other character can try to open the door by making a L1-SR on LK *and* a L1-SR on DEX (this will take two combat turns).\n" \
"  You're limited by time. If you can't open the door after one combat turn, more ulogulos will be drawn by the smell of blood. Roll 1 die for each combat turn, starting with the second combat round. If you roll 4, 5, or 6, no more attack - that turn. If you roll 1, 2, or 3, that is the number of additional attackers which arrive.\n" \
"  If you open the door, you can slip in (this occurs at the beginning of the combat turn after the roll is made, even if there are still ulogulos alive). Go to {18}. Take 10 experience points for each ulogulo killed, up to a maximum of 50 ap."
},
{ // 74/16D
"The mist that obscured your fellows (if you have any) has now vanished, and they return to your sight. From here, you may go west to {57}, or east to {32}."
},
{ // 75/16E
"The chest springs open and an air elemental (MR 25) flies out. It floats before the character who released it, and pledges to serve that character only from this time on, until either the character or the elemental is killed. What the elemental does *not* say, however, is if that character ever suffers a drop in Charisma, the elemental will immediately turn and try to kill him (for such is the nature of elemental beings). The other chest has vanished.\n" \
"  From here, you may go west to {120}, southeast to {157}, northeast to {51} or east to {102}."
},
{ // 76/17A
"* The blue path leads you to a room where you find a banquet table laid out, The food is heaped high: game fowls steaming, roast pigs with a glistening glaze, joints of beef, and other savory viands piled on silver platters; mugs of foaming beers and delicate glassware full of sparkling wines. It is enough to set anyone's mouth watering. At the far end of the table is seated a beautiful red-headed woman; her clothing reveals a figure which males in the party might find as delicious, and perhaps as inviting, as the banquet itself.\n" \
"  She smiles graciously and beckons you to seat yourselves and enjoy. If you decline, there are doorways that lead north to {38} or south to {68}. If you attack her out of hand, go to {33}. If you wish only to speak with her, go to {63}. If you want to partake of her wines and beers, go to {107}. If you dig into the banquet itself, go to {165}. If you wish to suggest amorous activities (only one at a time), keep any other characters present here at this paragraph and take that bold character to {91}."
},
{ // 77/17B
"The centaur pulls his bow back and shoots immediately. If there are several members in your party, randomly choose one character to be the centaur's target. The range is \"near\" and the centaur's DEX is 30. Determine his SR and see if he hits his target. Each of his arrows will do 6 dice + 62 damage. His CON is 30, and his mail takes 11 hits (doubled in close combat, because he is a warrior[; not doubled for protection from missiles]).\n" \
"  This is the first combat round; in it, the centaur got one free shot. Your choice of action (offered below) begins the second round...\n" \
"  If you trade missiles and magic with this centaur, go to {41}. If one of your archers tries to shoot the centaur's arrow out of the air, go to {3}. If you close with him, go to {24}."
},
{ // 78/18A
"You slog through freezing snow on the cliffside. Down to your right lies the valley where the frost giant stood. To your left, just overhead, is the rune-carved door which leads through a tunnel to the south. You hear a coughing snarl behind you, and whirl around. The curtain of snow parts to show at least two shadowy forms with lots of teeth, talons, and spines - the dangerous long-faced ulogulo, ferocious carnivores of the ice crags. If you race for the frost giant's valley, go to {103}. If you run to the rune-carved door leading south, go to {141}. To stand and fight, go to {34}."
},
{ // 79/18B
"The strain is incredible. Sweat pours from your face as you drag the boxes closer together. Nearer and nearer they move until they finally touch. You are blasted with an electrical jolt that flings you back across the room. The boxes have disappeared; the plank slowly dips back and forth.\n" \
"  You suddenly feel different - your body is alive with electricity.[ Any time a foe strikes you with a steel weapon (or any weapon made of a metal that conducts electricity), that enemy must immediately take 5 direct hits on CON. You can also absorb electrical (not magical) energy and reuse it. Each time you do this, you must *permanently* reduce your CON by 1; to re-use the energy, total the damage you should have taken from the electrical blast - you can use this as extra combat adds during the very *next* combat round. (You can't store it: the energy must be used within two minutes, or it is gone for good.) The energy can be used in melee or as a missile attack, but if it is used as a missile (i.e. cast as a lightning bolt) you can only throw *half* the damage you should have taken, and you must aim as for any missile weapon.]\n" \
"  From this room, you can continue on the blue path north to {26}, or south to {57}."
},
{ // 80/18C
"* Negotiating this rockslide is not that easy. You sink down to your knees in the loose shale and rubble, and then must leap forward to slide down the hill in great skidding steps. Make a L2-SR on DEX (25 - DEX). If you miss, you are out of control and fall down the hill. Take hits equal to the number by which you missed the saving roll. The rocks are jagged and while simply rolling down a hill might not severely damage you, stopping against a heavy tree or rolling through briars makes it all add up. Armour [(but not shields) ]will take damage[, but cannot be doubled].\n" \
"  Now make a L1-SR on Dexterity (20 - DEX) - if you succeed, you have managed to hang on to your primary weapon (the one you always have in your hand). If you've missed the roll, your weapon has disappeared among the rocks. Those who make the L2-SR, or who survive the fall, must go to {106}."
},
{ // 81/18D
"A soft soothing music hums from the walls. You feel relaxed and refreshed, and your wounds pain you less. As you watch, they close over and heal without scars. If your CON was damaged when you entered this room, it no longer is! However, this room will not add to your Constitution - it will only restore it. To leave, go east to {95} or west to {144}."
},
{ // 82/18E
"Your armour and all non-magical weapons you're carrying swiftly rusts and rots away. In moments, your equipment has been reduced to flakes and splinters. From here, you may go northwest to {130}, southwest to {1}, west to {32}, or east to {10}."
},
{ // 83/19A
"* The mummy fights like fury itself. He has a Monster Rating of 75 (8d+38). If and when you finish him off, go to {129}."
},
{ // 84/19B
"Roll 2 dice and find the results of your folly below. These drinks are special preparations, and a character may only drink here once during his or her entire lifetime. When everyone has drunk who can or wishes to, leave this room to go northeast to {26}, or southwest to {12}. Getting a drink here is worth 100 experience points.\n" \
"2. CHAMELEON BLOOD.[ Your body will always shift colour to blend with your background. This is an interesting effect, potentially useful in an ambush. However, clothes and armour mask much of the effect while they are worn, since they conceal the camouflage.]\n" \
"3. GORGON BLOOD. You take on some of the powers and attributes of a gorgon. Your hair grows longer and assumes a snaky life of its own.[ If you wish to turn something to stone, you may attempt it once per combat turn by rolling two dice. A result of 2 or 12 means that you are successful, and anyone looking at you will be turned to stone unless they can each make a LK-SR at your level to avoid it. If your companions take reasonable precautions (if they avert their eyes or keep their backs to you), they won't have to make the saving roll.]\n" \
"4. TROLLCRUSHER BEER.[ When faced with a Troll, you can do damage to it through limited mental attacks, regardless of your class. You must make an IQ-SR roll against the Troll's CON or MR. (for example, if a Troll has a MR of 54, then 54 is the number you shoot for, starting from your IQ rating. If your IQ is 29, you need to roll 25 on two dice as for any saving roll.) ERROR If you miss the saving roll, nothing happens. That particular Troll is immune to your attack, and you cannot damage it in this manner. If you make the roll exactly, you do no damage to the Troll, but it can't hurt you either. If you make the roll with anything to spare, that extra is counted as direct damage against the Troll - and the Troll can't damage you. You cannot control the creature, and the effect will wear off after you leave the adventure. You may only do this once to each Troll you meet in an adventure.]\n" \
"5. ANTIVENOM. You are now immune to all venoms and poisons[ produced by animals]. No poisoned weapon will do the added poison damage.[ You are still vulnerable to plant and heavy metal poisons...]\n" \
"6. DIET DRINK. Subtract 30 pounds and 1 CON point from this character permanently. If your CON or weight drops to zero or below, you are dead. (This potion was designed for humans, so it a lightweight fairy drinks it, he or she dies...)\n" \
"7. HUMAN BLOOD. This has no effect on humans, but all non-humans must multiply their originally-modified attributes by the inverse fraction of the modifier used to make them non-human in the first place. In short, all non-humans who drink this are transformed into humans. (For example, a dwarf who drinks this must multiply his ST and CON by ½ and his CHR by 3/2.)\n" \
"8. POISON. This drink confers instant and unpleasant death to anyone not immune to heavy-metal poisoning.\n" \
"9. DEMON 'RUMM'. The \"drink\" roils in your stomach, and the demon Rumm strikes from the inside out. He has a MR of 8; it will take him 3 turns to get out through your stomach. Roll up 3 attacks for a MR of 8 and apply it directly against your CON. If you survive this hatching, Rumm will be your slave for life (either his or yours).\n" \
"  If you happen to have metallic skin, the demon will race around the inside of your body, seeking an easy exit - and he'll rip you up much worse inside. In this event, Rumm will take 6 turns to find an exit - but he won't emerge through your stomach wall...If you survive, the above pertains.\n" \
"10. WEREWOLF BLOOD.[ During a full moon (once a month for three consecutive days)] you [will ]become a werewolf[ from sunset to sunrise]. All attributes should be adjusted according to the multipliers in the rules.\n" \
"11. HYDRA BLOOD. If you ever lose a limb (except your head or neck), that limb will regenerate.[ The regeneration time will vary, depending on what limb is lost, but approximate times are: a week for a toe, a month for a foot, six months for a lower leg, a year for an entire leg. Equivalent times apply for arms. The GM running the adventure should decide exactly how long the regeneration will take, within the framework suggested.]\n" \
"12. MAGIC DRINK. This drink was magical. It has no apparent effect, but seems to have imparted some of its magic to the drinker.[ You should now be treated as using a \"magical weapon\" when fighting hand-to-hand combat against anything which requires magic or magical weapons to vanquish. Vampires, werewolves, zombies, and ghosts will have nothing to do with you, and will not be polite. On the other hand, they won't attack you. either...]"
},
{ // 85/20A
"Dargon hands you a neck chain with a clear quartz projectile point hanging from it.[ \"This amulet will allow up to two ordinary missile weapons to pass harmlessly through you in any combat turn,\" he explains. \"A third projectile, or any magical one, will strike you and do damage normally - although you can use armour normally.\"\n" \
"  Even though projectiles will pass through you, anyone who stands behind you will be in trouble. (Comets, planets, meteors, and other heavenly bodies are not \"projectiles.\")]\n" \
"  Go to {71}."
},
{ // 86/20B
"Snatching the gold box posed no problems, but the silver box has fallen into the pit. The gold box appears to be worth about 250 gp. When you open it (it has a simple catch), each character in the room must make a L2-SR on Luck (25 - LK).\n" \
"  Write down how much each individual made or missed the roll by, and go to {101}."
},
{ // 87/20C
"In addition to 2500 gp in gold and jewels you may loot from the bodies of the priests and warriors, you have the high priest's magical gold and jade pectoral. [This device stores ST which can be used to cast magic. It is charged up by sacrificing a living humanoid to the sun. The pectoral will then store that being's CON as Strength points which can be accessed for use in spell-casting. (If the being has only a Monster Rating, the pectoral will store half the MR it had just before death.) The sacrifice must take place in the open air in full sunlight, and you must lift up the still-beating heart into the air for the gold and jade chest plate to be charged with the Strength. It will store a maximum of 30 ST points. If you are not a magic-user and have no use for such an item, ]you may charge all the market will bear for it (no less than 750 gp). Also, take 50 experience points.\n" \
"  You may go back up the jungle path to the rocky slope (go to {50}), or you may exit this adventure by going to the path of red light (go to {71})."
},
{ // 88/20D
"As you add the 78th card to your hand, completing the deck, power courses through your whole being. You see all things happen - past, present, and future - before your mind's eye. You relive your future from before birth, and then follow it into the far future. You must make a L6-SR on IQ (45 - IQ). If you make it, go to {117}. If you fail, go to {142}."
},
{ // 89/20E
"The elemental pales, then turns and flees, burrowing through one of the walls. In its wake you see a glint and glimmer, for it has passed beside a hidden cache of jewels. There are three gems (roll for them on the Jewel Generator in the rules). If you rummage around in the debris, you'll find some scraps of silver (worth 25 gp total) from the destroyed chests. From here you may go west to {120}, southeast to {157}, east to {102}, or northeast to {51}."
},
{ // 90/20F
"Your clothing and possessions have re-appeared, and you are no longer naked and unarmed. You may rejoin any surviving comrades now, for the dimensional nexus has released you and faded away. Go northwest to {12}, or southeast to {67}."
},
{ // 91/21A
"You take her aside and make your suggestion, and her green eyes blaze with indignation.\n" \
"  \"All you wanderers assume every female wishes to consort with you,\" she hisses, shaking her fiery red hair. \"I would no more consort with you than I would a cockroach!\" With a sharp gesture she uses the Mutatum Mutandorum to transform you into a lame cockroach. Without remorse she tromps on you, crushing your life away. In the next moment she weaves a spell of her own devising which causes your compatriots to forget you ever existed, so they have no cause to revenge your truly ignoble death. If there are others in your party, return to {76} to choose their direction."
},
{ // 92/21B
"* As you rush forward, the zombie warriors release the captive. The two priests drag the bound captive up to the high altar as the warriors step down to stop you. Each warrior has a CON of 20, wears an unusual suit of leather armour fashioned from heavy hides (takes 6 hits - doubled for warriors). Each warrior also has 20 combat adds, and their weapons are like nothing you have ever seen - wooden clubs edged with gleaming chips of obsidian. These \"swords\" start with 3d+4[, but lose 1 add for every combat turn they inflict damage on metal shields or armour, or are parried with metal weapons]...\n" \
"  If you defeat the six warriors in one, two, or three combat rounds, go to {131}. If it takes longer than that, go to {13}."
},
{ // 93/21C
"You have been digging around in the spawning ground of a cockatrice, a lizard-like creature hatched by a toad from the egg of a rooster laid on a dungheap. Its history isn't always well-known, but its effect on living beings is: it saw you before you saw it and you have been turned to stone."
},
{ // 94/21D
"Dargon gestures and the world begins to spin. You feel the bones in your body dissolve. Your flesh, nerves and organs are reduced to their most basic form - sea water. \"Be one with the immortal sea,\" Dargon says. \"Thus you will never die.\" He smiles benignly as you drain through a well-worn crack in his floor."
},
{ // 95/21E
"The green path leads you to a white marble room. There are four doors in the room, one at each cardinal point. There are also four marble basins, each covered by green ivy. Each basin is filled with water, which begins to writhe and twitch as you enter the room. Soon the water appears to be boiling, and rises in the form of a humanoid being, a different creature for each basin. These water beings dance and juggle, changing shape constantly in a beautiful display. If you take a seat and watch, go to {60}. If you wish to attack these things, go to {153}. If you wish to drink from the fountains while they perform, go to {118}."
},
{ // 96/22A
"\"Rogues are often hated by wizards like myself,\" Dargon tells you. \"I actually enjoy your inventiveness. To you, I give this pair of gloves. [While you wear them, your hands are completely protected from such traps as come suddenly from chests and doors - poison needles, guardian spiders and the like.\" Dargon's gift covers physical attack, *and* magical attacks of 5th level or lower. ]Go to {71}."
},
{ // 97/22B
"The bottom of the basin appears to be covered with gold coins, as though those who passed had made wishes and tossed in coins. The gargoyle is a little larger than a man, has long stony talons, arching bat-like wings, and a face like a bird of prey. If you want to recover some of the coins, go to {2}. If you try to drink some of the fluid spilling from the gargoyle's mouth, go to {125}. If you throw in a coin and make a wish, go to {116}. If none of these choices appeal to you, return to {26} and leave the room."
},
{ // 98/22C
"As you sit in the throne, it begins to change. The arms rise up to entrap your arms; the canopy lowers itself around your head and face. Within seconds, the chair has completely engulfed you. If you struggle to free yourself, go to {160}. If you hold still and see what happens, go to {49}."
},
{ // 99/22D
"The warriors lurch to cut you off, and the priest/sorcerer knows when to strike - when *he* has the advantage. Before you springs up a thick mass of thorn bushes: the magical Wall of Thorns. The warriors are on one side, and the wall of thorns is on the other. Choose your poison. Characters may attempt to split up here (one choosing to brave the thorns of sleep, and one remaining to fight), but you will be pressed by circumstances into doing one or the other. Decide who does what and send them to face the thorns at {42}, or to face the warriors at {104}."
},
{ // 100/22E
"As you pickup this card, \"Judgement\", the mist washes over you, and you find yourself in a courtroom. On the bench are three hooded judges; in the jury box is a collection of animals and monsters. Your accuser is a human who has been horribly burned and scarred; his face is unrecognizable.\n" \
"  \"This one has harmed us a thousand times over!\" the scarred man declaims. \"Our homes were destroyed and our people slain. Find this one guilty as charged, and declare the penalty: Death!\"\n" \
"  A whispery, almost bodiless voice comes from behind one of the judges' hoods. \"Defend yourself against these charges, if you can. Let us hear what you have to say.\"\n" \
"  Add your IQ and Charisma together, then divide by two. Use this average to attempt a saving roll at your own level. (This is to simulate your use of your intelligence, personality, and appearance to justify the deeds and actions of your past.)\n" \
"  If you fail the saving roll by 10 or more, you are judged to be incredibly guilty, and are taken away to be slain out of hand. [If you miss the roll by 9 or less, you are placed on probation. You must foreswear wanton murder, robbery, and careless destruction for the rest of your life - the first such unjustified action will summon forth a terrible being, which will carry you to an unbelievably unpleasant and eternal death. ]If you make the saving roll, you are acquitted, and you may raise your Charisma by the roll of a six-sided die. Go on your way to {74}, and wait there for the rest of your party."
},
{ // 101/23A
"The chest was enchanted, and is a reservoir of considerable electrical energy. All who missed the saving roll were struck by small lightning bolts; they must take hits against their CONs equal to the number they missed the roll by. [Only leather and cotton/silk ]armour will help[ at all].\n" \
"  Those who made the saving roll each find a gem worth ten [times the number they made the saving roll by ](in gp).[ Each gem is now attuned to its owner, and will absorb up to 3 magical hits each combat round (for its owner only). Upon the death of the gem's owner, the gem disappears. It cannot be loaned out, and will disappear if stolen and not recovered within one day.]\n" \
"  From here you may go along the blue path, north to {26} or south to {57}."
},
{ // 102/23B
"The room you have entered is 30' in diameter, with a 15' ceiling. Around the base of the curving walls is a 3'-wide pathway. The centre of the room holds a 3'-high cylindrical pedestal, upon which stands a skeleton. The floor between the walkway and the pedestal is covered by a placid lake of silvery metal.\n" \
"  The skeleton itself is a curious thing. All the cartilage has long since rotted away, but has been replaced by bands of silvery metal. Thin silver ribbons replace the ligaments. Each tooth has been set with a single jewel, and on the bones of the right hand are two rings.\n" \
"  If you would approach and loot the skeleton, go to {162}. To drink from the silvery lake, go to {27}. If you'd rather leave this room entirely, go west to {12}, or east to {40}."
},
{ // 103/23C
"* You hear the click of talons on stone as the ulogulos give chase. The character with the lowest Speed rating must make a L1-SR on LK to avoid being overtaken by these pack hunters. If the roll is successful, go to {67}.\n" \
"  Otherwise, roll 1 die and add 1 to determine how many beasts chase you (each has a Monster Rating of 15). If you cannot defeat them within two combat rounds, more may come. Roll 1 die each combat turn, starting at the beginning of the third combat round. If you roll 1, 2, or 3, that is the number of additional attackers. If you roll 4, 5, or 6, no more come - yet.\n" \
"  If you kill all you face, you can run through the valley to the other exits by going to {67}. (Take 10 experience points for each ulogulo killed, up to a maximum of 50 ap.) If you die, the ulogulos get a warm dinner on a cold day."
},
{ // 104/23D
"* You are hemmed in between the warriors and the thorn bushes. If there are two of you, three zombies attack each of you; if there are three in your party, you face two warriors each. Every combat turn, you must make a L2-SR on LK to avoid accidentally brushing against the thorns. If you miss the roll, you fall asleep instantly, and are out of the action. The zombies will attack anyone who still stands. If all of you fall asleep, it will not matter for how long...for you will be sacrificed before you awaken.\n" \
"  If at least one person remains awake and defeats the zombies, he or she will have one combat turn to flee - with or without the bodies of sleeping companions. If you carry your companions, take the exit at the red-lit path (at {71}). You can't carry anyone up the scree slope at {50} - only living, awake characters can negotiate the loose rocks (with one magical exception). Survivors should each take 200 adventure points."
},
{ // 105/24A
"The card you hold is called the \"Ace of Swords\". It suddenly changes into a one-handed magical broadsword that gets 6d+8 adds[, *plus* your level number,] in combat adds (as well as your regular combat adds). [Anyone who grasps the hilt of this sword (as you are doing now) becomes capable of using it, at the price of all magical abilities. ]You are now a warrior, *regardless of what character class you were previously*, and you have no more knowledge of the magical arts. Go to {74} and wait for the rest of your party."
},
{ // 106/24B
"After negotiating the rocky slope, you find the path heads off into the lush jungle. To follow the jungle path, go to {47}. To climb back up the slope, go to {50}."
},
{ // 107/24C
"As you sip her draughts, you find they are magical, and that they modify your Constitution. If you were wounded, your current CON is increased 5 points, and that becomes your new, permanent CON rating. (In other words, if you were suffering 8 points in wounds, then 5 points worth are healed and your new CON is 3 points lower than it was before. If you were only carrying 2 points in wounds, then your permanent CON will become 3 points higher than it was before.) If you were not wounded, your CON is only raised by 1 point.\n" \
"  The woman smiles and tells you she has business elsewhere, and asks you to leave. She points out that you have two choices: you can go north to {38}, or south to {26}. If you wish to be ungrateful cads, you can pull out your weapons and tell her she has overlooked another alternative - in which case, go to {33}."
},
{ // 108/24D
"* The doors slam shut, and you feel the air pressure lessening around you. In a flash, you deduce that all the air in the room is being pumped out, and that your only hope of escape is to break down one of the two doors.\n" \
"[  Each character must make a L2-SR on Constitution (25 - CON) (from the lack of air). If you miss, you must take damage equal to the number you missed the roll by. You must make these rolls each and every combat round you are in this room. The doors will take 50 hits apiece before they buckle - choose one door and attack it with your weapons to gain your freedom. If you take more than 5 combat turns to escape, all the air is gone and everyone will die.\n]" \
"  If you break down the east door, go to {95}. If you have shattered the west door, go to {144}."
},
{ // 109/24E
"\"I'm the greatest swordsmaster there ever was!\" Entak cries, obviously unbalanced by your rejection. \"Fools! Think of the opportunities you've missed!\" With that, the fencing dummies attack. To hit them with weapons, go to {56}. To hit them with magic, [cast your spell and check the Magic Matrix, and then ]go to {56}. Entak stands behind the fencing dummies, his face contorted with rage; to attack him, you'll have to fight off the dummies first."
},
{ // 110/25A
"* The giant has a DEX of 42. To hit you, a \"large\" target (human-sized), at far range, he must make a L6-SR on DEX. He must roll at least a 5 on two dice (doubles add and re-roll). Randomly decide which character is his target. (If the target is not human-sized, adjust the saving roll according to the missile weapon rules.)\n" \
"  If the giant hits his mark, that character must take 3 dice + 100 adds in damage. Armour and shields may be used in normal fashion. Survivors will flee out the exit previously chosen: north to {134}, south to {78}, northeast to {1}, or northwest to {157}."
},
{ // 111/25B
"The character who made the saving roll managed to clutch his box just seconds before the other character. That side of the teeter-totter with the box still on it dropped away from the second character's fingers, and the box fell into the pit. Unfortunately, the character going after the second box grabbed for it as it fell, and overbalanced...and followed the box down into the pit. His screams echo in your ears.\n" \
"  If you have the gold box, go to {86}. If you have the silver box, go to {133}."
},
{ // 112/25C
"The throne entombs you, and a demonic voice echoes within your head. \"By seating yourself in this place of evil, you have closed the pact. Your soul is mine now, but in trade I grant you immunity from fire and flame for the remainder of your mortal days.\" The throne spits you out, and you may rejoin your friends. However, your eyes now lack a certain luster, for you have no soul. Some may even consider you to be one of the undead. However, you will take no damage from fire, magical or otherwise, for the rest of your life. From this place you can go north to {71}, or south to {76}."
},
{ // 113/25D
"Try to make a L4-SR on Luck (35 - LK). If you make it, go to {16}. If you fail, go to {11}. (If there is more than one character here, they must roll separately.)"
},
{ // 114/26A
"The globe deposits you in a circular room about 20' in diameter. The floor is painted in a swirling pattern of black and white. You gaze at it and feel dizzy - you'll have to get out of here soon. You see four doors which lead out of this room. To the north is a blue door (go to {17}); to the east the door is green (go to {144}). A white door is set into the west wall (go to {40}), and a blood-red door leads to the south (go to {134})."
},
{ // 115/26B
"Your companions don't even notice your exit as something with scaly hands suddenly yanks you underwater. You surface with a gasp in a stagnant air pocket, facing a roguish merman. \"All right, air-breather, hand over all your cash, goods, and armour - everything you have - or I'll drown you,\" he snarls.\n" \
"  If you fight for your belongings, go to {15}. If you comply with his demands, go to {164}."
},
{ // 116/26C
"When the coin enters the water, the gargoyle's eyes open, and its beak moves. \"Beware the witch,\" it says in a voice like gravel.\" Share her draught but not her meat.\" With that, it resumes its silent vigil over the basin. (It wasn't a wishing well, after all...) Go to {26} if you wish to leave the room, or else return to {97} and do something else."
},
{ // 117/26D
"Insanity tore at your brain, but you shook off the effects. You now own a deck of tarot cards which can reveal the form of future events to you. In face-to-face games, you may take one full turn to do a reading, and thereby get the equivalent of a free Mystic Visions (regardless of your natural class). If you go into business with these cards, giving readings for peasants at taverns, you will be accepted as a good fortune-teller, and you should be able to get at least 5 gp per reading (or however much more you can wheedle out of the petitioner). [You must not permit another living being to touch a single card of this deck - if this happens, the cards will lose their potency, and you will do no more accurate readings. ]For now, go to {74} and wait there for the rest of your party."
},
{ // 118/26E
"As you might have guessed, the water is magical. Roll three six-sided dice. If you roll triples, you were unable to handle the power of the water. Divide the number you rolled by 3, and subtract the result from your Luck.\n" \
"  Any character that drank and didn't roll triples now finds he or she has a strange new ability. You can command and control a cup of water, using this magical ability to form a cupful of water into a sphere which will break only when thrown (better than water balloons!), or into tiny animals and fencers to entertain children - or any number of things. However, the amount of water can never be more than one ordinary cupful, and you can only control one cupful at a time. Furthermore, anything you fashion in this manner cannot be used to cause overt harm to any other creature (living, dead, undead, or otherwise). This is not a fighter's kind of magic, but it does have its uses. Have fun playing with it!\n" \
"  From here you can go northwest to {130}, southwest to {1}, west to {32}, or east to {10}."
},
{ // 119/27A
"\"With knowledge, you are better equipped to accomplish the things you must do,\" Dargon declaims. \"I will prepare for you a scroll containing up to ten level points worth of spells - choose them now. You, and you alone, will be able to read and master them, once your IQ and Dexterity are sufficient to allow you to cast them.\"\n" \
"  A character's level need not be as high as the spell's level - you only need the IQ and DEX high enough to use them. The spell can then be cast, but if it is of a level higher than the caster's own, there is an additional ST cost (described in the rules).\n" \
"  Go to {71}."
},
{ // 120/27B
"A white-hued path leads you to a room that is 40' square. This room is hung about with fencing dummies and practice shields; the wood floor is marked off for footwork exercises. In the middle of this room stands a warrior. He is dressed comfortably, without armour, and looks both young and strong. A broadsword hangs from his belt; wizards will sense magic from the sword.\n" \
"  \"My name is Entak,\" he says, bowing low. \"For a small fee, I will teach you how to improve your abilities with a sword.\"\n" \
"  If you want to learn from Entak, go to {150}. Only characters presently bearing swords may take this option - Entak would frown on trading weapons about, so don't do it! If you wish to attack Entak, go to {132}. If you decline his lessons, the fencing dummies come to life, and stand between your party and the doors; go to {109}. (If there are only wizards present, Entak is disgusted and shoves you out the door to {71}.)"
},
{ // 121/27C
"You slowly inch the boxes closer to the centre of the plank. Soon they are close enough to grab at the same time, but the moment you grab them, the boxes begin to return to their original positions on the plank. You cannot free your hands, no matter how hard you try. In desperation, you realize the only chance you have is to force the boxes together so they are touching. This requires a L3-SR on Strength (30 - ST). If you make the roll, go to {79}. If you miss the saving roll, you are torn in two, fall from the teeter-totter, and vanish. Survivors in your party (if any) may leave the grisly place by going north to {26} or south to {57}."
},
{ // 122/27D
"To your unconscious form she mutters, \"If you cannot entertain me, perhaps you can entertain others.\" She draws a sharp knife from the table and quickly slits your throat. Your spirit watches in horror as she butchers your corpse, prepares, and cooks it - then lays it out on huge silver platters to welcome the next group of wandering adventurers who even now enter the room..."
},
{ // 123/27E
"The silver liquid seeps back into the pool. You gather up the scattered bones; if you wish, you can scrape away the platinum and silver. The teeth are more widely scattered; roll two dice (doubles add and re-roll). This is the number of teeth you can find (up to 32). When you pry the jewels loose, you'll find most of the gems are of \"average\" size, but one out of every eight will be \"large\". Roll for the kinds of gems you have on the Jewel Generator.\n" \
"  The metals taken from the bones, plus the two small rings, are worth a total of 240 gp. From here you may go west by going to {12}, or east to {40}."
},
{ // 124/28A
"The grotto is filled with ink and blood. You're tired, and flop down on the sand - and land on a hard object. When you dig it out, you find it is a golden baton set with three jewels. The gold in the baton is worth 50 gp; roll 3 times on the Jewel Generator in the rules to determine the value of the gems.\n" \
"  You slip the baton into your belt and swim back to your compatriots. You can continue either northwest at {26}, or southeast at {95}."
},
{ // 125/28B
"The character who drinks must make a L2-SR on Strength (25 - ST). If the roll is successful, go to {140}. If it is missed, go to {58}. If this character is immune to poison, there is no effect. Choose another option at {97}, or return to {26} and leave the room."
},
{ // 126/28C
"* Running toward the giant quickly makes you a large target at pointblank range. The giant will throw his snowball at the character with the highest Speed rating; at this range, he only needs to roll a 5 on two dice in order to hit. If he succeeds, the target must absorb 3 dice + 100 adds. Armour and shields function normally.\n" \
"  When you close, the giant will fight bare-handed. He has a CON of 40, 70 combat adds, and gets 5 dice in hand-to-hand combat. If you can make a L5-SR on Dexterity (40 - DEX), you can dodge all his blows and deliver your damage directly against him. Any character who misses the saving roll will be in standard combat, and must face the damage the giant can dish out, divided by the number of characters attacking him. (Even though he may only hit one character, the giant has still tried to hit the others).\n" \
"  Fight until one side or the other is killed. If any among your party survive, the giant was worth 90 experience points. Go to {54}."
},
{ // 127/28D
"If you're alone, and you turn to run away, go to {37}. If you are in a group of two or more, go to {99}."
},
{ // 128/28E
"The card you hold is \"Death\". A chill creeps from your hand, up your arm. Your heart feels like a crystal of ice within you. [However, Death no longer holds any fear for you, because you realize that you have already experienced a kind of death and your body will regenerate damage taken. Unless burned, your body will regain 1 CON point per full turn, even if your CON drops to zero. However, each time this happens, you must drink the warm, freshly-obtained blood and life of a fellow member of your kindred. Should you fail to do this, Death will believe you wish to relinquish your hold on the mortal world, and summon you to join him. (Although this is similar to vampirism, you are not a vampire and should not even be classified as \"undead\".)\n" \
"  If you were wounded, those wounds begin to heal - and your fate awaits you. ]Go to {74} and wait for the rest of your party."
},
{ // 129/28F
"You find three gems and four hundred gold coins scattered on the floor. Roll for the gems on the Jewel Generator in the rules. Leave by going east to {71} or west to {95}."
},
{ // 130/29A
"The corridor slopes downward and slowly changes colour to a rich aquamarine. You are halfway down the corridor when the path drops at least 6' and ends in a pool of blue water. You aren't sure how deep the water is, but you can see the other end of the path rising from the pool 20' farther down the passage.\n" \
"  If you decide to press onward, go to {158}. If you turn around and go back, you must return where you came from: either go southeast to {95} or northwest to {26}."
},
{ // 131/29B
"You overtake the priests even before they reach the altar atop the pyramid. You knock them down the steps, head over heels, and free their captive. He is a young man; he mumbles what you take to be thanks and scrambles away into the jungle. You loot the bodies of the priests and warriors. Including the gold bowl, you find 2500 gp worth of jewels and soft gold. Having taken everything of value, you descend the pyramid steps with a light heart. You can climb back up the scree slope by going to {50}, or you may exit this adventure by returning to the red-lit path and going to {71}."
},
{ // 132/29C
"* This young warrior has a CON of 60, and 45 personal combat adds. His broadsword [will dispel any first to fourth level magic cast against him (a kind of fancy kris). It ]gets 6 dice and he needs only one hand to wield it.\n" \
"  If you slay Entak and search his body, you'll find 240 gp. His sword weighs 150; you'll need a ST of 15 and a DEX of 11 to use it. [(Only Entak knew the secret of wielding it one-handed.) ]To leave this room, go west to {71} or east to {12}."
},
{ // 133/29D
"You have no trouble grabbing the silver box, although the gold one has fallen into the pit. The silver box is worth 150 gp, for it is a fine piece of craftmanship. When you open the box, you find a ring inside. The character who slips this ring on finds that it is magical.\n" \
"[  The ring will allow its wearer to control a bolt of lightning. Whenever you are in a situation where lightning may already be present (out in the open under heavy clouds, for instance),you may command a bolt to strike anywhere. This bolt will do as many dice in damage as you wish, provided you first make a LK-SR at the level equal to the number of dice in damage you are calling for. (In other words, a lightning bolt worth 10 dice requires a L10-SR on LK.) If you miss the saving roll, the bolt will strike *you*, and you must take double the damage rolled (nothing will save you from it). lightning bolts should be resolved during missile and magic combat phases. In addition, the bolts cannot be controlled more than once each *regular* turn (once each five combat turns).\n]" \
"  From here, you may go along the blue path north to {26}, or south to {57}."
},
{ // 134/30A
"* As you enter, you see a centaur standing in the centre of the room. He wears mail and holds a bow in his hands; he has an arrow already nocked, and two more are in the quiver at his flank. Behind him is a small cabinet. Both doorways into this room follow the red path; to the north is {57} and to the south is {67}. The centaur moves, drawing your attention.\n" \
"  \"You may pass through,\" he says in a matter-of-fact tone. \"But unless you leave immediately, I must kill you.\"\n" \
"  If you run away, go through one of the doorways. If you choose to stay, go to {77}."
},
{ // 135/30B
"* You throw one end of the rope to one of the people on the plank. Total the weight (including armour, pack, etc.) of the person you want to rescue. If you can lift that much, you can pull that person to freedom. If you don't have enough Strength, you can still try to make a saving roll on ST one level above your own. If you fail, you are dragged into the pit with your comrades, and all of you die. Even if you make it, bid farewell to the person you abandoned on the plank, for he is now at the bottom of the pit. Both boxes were lost in the rescue. Survivors can follow the blue path north to {26}, or south to {57}."
},
{ // 136/30C
"Your IQ returns to what it was when you entered this room. You cross the circle and pull free the haladie dagger, and sense magic on it[ - it will not allow certain mind-damaging or mind-altering spells to be effectively cast upon you (Panic, Dreamweaver, Witless, Mind Pox, ESP, Seek Ye)]. This protection only lasts while you carry the dagger, and you may still cast these spells on others. Go to {90}."
},
{ // 137/30D
"The card you hold is called \"Temperance\". It depicts an angel-like being holding two cups, with water flowing between the cups. As you stare at the card, the water seems to flow out and wash over you. Total your prime attributes and add 10. Then divide the result by the number of attributes you have. These are your new attributes, with all remainders going on Charisma. (If Harok has a 10 for each prime attribute, he totals them and gets 60. Adding 10, he gets 70 - and divides by the number of attributes he has - 6. Now each attribute becomes 11, except for Charisma to which goes the remainder of 4 and is now 15.)\n" \
"  When this has happened, go to {74} and wait for the rest of your party."
},
{ // 138/30E
"* Although the chests have unusual locks, an attempt to open both simultaneously will bypass the mechanisms. As the lids open, you find you have released an earth elemental from one chest, and an air elemental from the other. These two beings immediately attack each other. Wind and sand blast furiously about the room.\n" \
"  Any character not in armour must take 2 dice worth of hits from the sand-blasting. Those in armour take only 1 die worth of hits, as the sand and grit penetrate every cranny in your armour and cause an aggravating chafe. Both chests are destroyed, and the elementals tear each other to pieces. You can scavenge for silver fragments; you'll find about 25 gp worth.\n" \
"  Go west to {120}, southeast to {157}, northeast to {51}, or east to {102}."
},
{ // 139/31A
"* Ogilvy the Ogre drops from the hole in the ceiling. He shambles toward the party member with the lowest CHR. (If more than one character has the same low CHR, randomize between them.) Ogilvy yanks a sax from his vest and prepares to slit that character's throat.\n" \
"  Remember, you are all impaled on the wall spikes. To get free, a character must make a ST-SR on a level equal to the number of hits he took from the spikes. A character cannot fight back until he or she is freed.\n" \
"  Ogilvy has a CON of 30, gets 18 combat adds, and wields a sax.[ If the ogre attacks someone still pinned to the wall, that character gets no protection from armour.]\n" \
"  If any characters survive and can free themselves from the spikes, they may proceed. Also, other characters can free a pinned character if one of them can make the required saving roll. [After the death of the ogre, roll for a Wandering Monster each turn you remain in the room. ](Dargon won't reanimate his favourite ogre until or unless someone enters this room again.) For now, you must leave. The doors leading out of this room are: blue (go to {17}), red (go to {134}), green (go to {144}), or white (go to {40}). The hole in the ceiling has closed."
},
{ // 140/31B
"The moment you swallowed the first gulp of liquid, a searing pain coursed through your body. However, your system was strong enough to handle the toxin. Your skin takes on a granular texture and becomes tougher, and your fingernails grow stronger, sharper, and longer. The gargoyle toxin has given you stony skin[, capable of absorbing 4 hits in combat (does not double for warriors)]. [Your talons (fingernails) make your hands worth 3 dice total in barehanded combat. ]Your weight has also doubled. [(Any previous alteration to your skin surface vanishes when this occurs.) ]Go to {26} and exit this room."
},
{ // 141/31C
"* The ulogulos continue to trail you, snarling all the while. The rune-covered door is fashioned of smooth blue stone, and there is no latch. As you turn to examine the door, the ulogulos attack. (To determine how many attack, roll 1 die and add 1. Each has a 15 MR.) An Unlock spell will open this door, but it will take the spellcaster one combat turn to cast it. A rogue can unlock the door without magic if he can make a L1-SR on Dexterity (20 - DEX) (this will also take one combat turn). Any other character can try to open the door by making a L1-SR on Luck (20 - LK) and a L1-SR on Dexterity (20 - DEX) (this will take two combat turns).\n" \
"  While someone is trying to get the door open, the other party members must fend off the attackers. If you're alone, you must first kill all the ulogulos; you can only open the door when no more show up - because at the sound of a hunt, additional creatures will arrive. [If you have not gotten off the ledge after killing all the ulogulos, ]roll one die at the beginning of each combat round, starting with the 3rd combat turn. If you roll 4, 5, or 6, no more show up this combat turn. If you roll a 1, 2, or 3, that is the number of ulogulos which arrive.[ If you kill all the ulogulos, you will have 1 combat turn's respite before you must roll to see if more show up.]\n" \
"  When you win free, go to {18}, taking 10 ap for each ulogulo killed (up to a maximum of 50 ap). If you die, the ulogulos sleep with full stomachs tonight."
},
{ // 142/31D
"The visions which assailed you were simply too much for your mind. Take the number you missed your saving roll by in damage against your IQ. If your IQ goes to zero or below, your brain ceases to function and you die. If your IQ drops to 2 or 1, you fall into a coma - roll 3 dice to determine the number of turns you are unconscious. If you survive, you awaken at {74}; wait there for the rest of your party. The cards are back on the table, and you cannot touch them again."
},
{ // 143/32A
"\"Magnificent!\" she cries, clapping her hands in delight. \"This is far beyond my expectations, so I must reward you for your efforts.\" She reaches into a pouch at her belt and draws forth a ring for each person in the party. \"These rings are each worth 500 gp. They are also magical[ - they offer limited protection against Take That You Fiend spells].\"\n" \
"[  Every time a Take That You Fiend is cast against a character wearing this ring, that character must roll two dice (doubles add and re-roll). If the number rolled is higher than the level of the spell, the spell is negated and dispelled. The rings cannot be given away, and will disappear upon the deaths of their owners.\n]" \
"  The red-headed witch thanks you again, and directs you to leave by the north door (at {38}) or by the south door (at {26})."
},
{ // 144/32B
"This room is filled with a smoky swirling mist, and it is so magical that even warriors sense its tingle. You enter cautiously, and come upon a table. This table is covered with a great number of cards, face down, each from a different deck of tarot cards. These cards seem to be the source of the magic.\n" \
"  If you'd rather leave these cards alone, you may go west to {57} or east to {32}. If a character would like to gather together a complete deck of the tarot, do so and go to {88}. If any character would like to pick up one card (this must be done individually), roll two dice to see which card has been picked up. (If you rolled: 2 - go to {4}; 3 - go to {137}; 4 - go to {22}; 5 - go to {43}; 6 - go to {55}; 7 - go to {149}; 8 - go to {105}; 9 - go to {100}; 10 - go to {128}; 11 - go to {14}; 12 - go to {151}.)"
},
{ // 145/32C
"From the body of the centaur you may take his extra-heavy selfbow and his kris. The mail he wears is designed for a centaur, and therefore is unsuitable for use by anyone but another centaur. When you search the cabinet he guarded, you find a pouch full of gold coins (roll 3 dice and multiply by 100 to determine the number of coins). Take 92 ap for killing the centaur, and go north to {57} or south to {67}."
},
{ // 146/32D
"Out of the blood surrounding the troll's body swims a tiny creature. It is about the size of a gold piece, and flickers past your erratic attempts to fend it off. It drives towards your neck, and lodges near your Adam's apple. You feel an abrupt stinging sensation, then your tortured lungs report an influx of fresh oxygen.\n" \
"  This parasite is a gillfish. It allows you to breathe water, as it gives off significant amounts of oxygen as a byproduct of its strange life. While out of the water, you will be able to breath air normally, and the gillfish will not affect your ability to speak.[ However, you must douse it at least once every two hours with salt water (no, wine won't do in a pinch!), or it will begin to die, swelling and drying out, which will constrict your windpipe and suffocate you. A damp cloth around your neck will allow you to sleep at night, or you might consider sleeping in a tub of salt water.]\n" \
"  You swim to the surface, where you rejoin your companions. Continue on towards the northwest (at {26}), or southeast (at {95})."
},
{ // 147/33A
"* Magic and magical weapons work perfectly. All who use these to attack need not be concerned with receiving extra damage as noted below, and should drop to the last part of this paragraph.\n" \
"  Anyone without a magic weapon will have problems. The skeleton's skin and muscles are mercury, and will fragment into tiny droplets when struck by ordinary weapons. Each combat turn you fight this metal creature you must make a L2-SR on Luck (25 - LK), and then a L1-SR on Luck (20 - LK). If you ever miss the L2-SR, you should go immediately to 36. If you miss the L1-SR, you inhaled some of the mercury; take damage directly off your CON equal to the number you missed the saving roll[ - and for 3 turns (in this solitaire, 3 paragraphs) you lose 1 Strength point each turn].[ If you miss the L1-SR twice, you lose 2 ST points, and so on. If your Strength drops to zero or below, you die. If you can get out of this adventure and find someone to cast a Too-Bad Toxin on you, you'll live but you can't regain the lost Strength automatically.]\n" \
"  The mercury-covered skeleton attacks with 12 dice and 38 combat adds. It has a CON of 100. If you defeat it, you have gained 100 adventure points - go to {123}."
},
{ // 148/33B
"* Your fumbling efforts to open the chest have angered that which is within. The lid flies off to reveal a craggy earth elemental who is clearly upset by your rough handling. He rises to his full height; the stone floor twists about its legs and then seems to bite both chests in two! [Two blocks of stone fly from the wall towards the party members, who have been thrown about by the rocking floor.\n" \
"  *Each* block will take 50 hits before it shatters. Every combat round that either block is aloft, each party member must make a L2-SR on DEX to dodge the blocks. If the roll is missed, that character has been struck and must take damage equal to half the number of hits left to destroy the stone block. (An undamaged block generates 25 hits against anyone who is struck.) All hits against the blocks are figured at the *end* of the combat round, and all saving rolls and hits by the blocks are figured at the *beginning* of the round. Armour will take hits normally, and warriors double.\n" \
"  When both blocks have been demolished, survivors should ]go to {89}."
},
{ // 149/33C
"This card is the \"Nine of Wands\". It depicts a man leaning on a stout staff, with eight more staves standing upright behind him. The card stands for preparedness and now you will always \"be prepared\" - you will always be aware of an ambush. In face-to-face games, the GM must always tell you that the hair on the nape of your neck begin to rise, as a sixth sense warns you of any foe in ambush within 15'. Walls will not affect this power; mechanical traps are not the same as an actual ambush. Go to {74} and wait there for the rest of your party."
},
{ // 150/33D
"Each turn of instruction will cost 20 gp (paid in advance). Entak has to leave to meet someone for a dinner date in about two hours, so he has 12 turns available to instruct you. Further, Entak will never *reinstruct* someone, no matter how many times they enter this room. He also knows better than to try to teach wizards anything...After you decide how many turns of instruction you can or will pay for, go to {163}."
},
{ // 151/34A
"You hold \"The Wheel of Fortune\" in your hand. The mists darken your sight, and when they lift you find yourself inside a dimly-lit casino. You see every game of chance being played around you, but you are drawn towards the roulette wheel.\n" \
"  To play this Wheel, you may bet on any single number you wish, or bet on \"even\" or \"odd\". The numbers range from 3 to 18, and payoff according to the table below. You may play until you run out of money or wish to stop. Pick either a *single number*, or *even*, or *odd*, and then roll 3 dice. If your choice turns up an exact match, you get paid. Otherwise, you lose the money you bet with. Only gold[, jewels, or jewellery] can be bid - the wheel will freeze if you bet silver or copper, and will only unfreeze if you retract the bid and replace it with one of gold[ or jewels].\n" \
"  3, 18               - pays 36 to 1\n" \
"  4, 5, 16, 17        - pays 24 to 1\n" \
"  6, 7, 8, 13, 14, 15 - pays 6 to 1\n" \
"  9, 10, 11, 12       - pays 2 to 1\n" \
"  even or odd         - pays 1½ to 1\n" \
"When you stop playing, go to {74} and wait there for the rest of your party."
},
{ // 152/34B
"The walls all about you light up. Gigantic, two-dimensional humanoids move across the walls, speaking in strange tongues. On one wall, a tall beautiful blonde dressed in a silky gown sings to a mattress. Across another wall, many thick-bodied men are working at chores that seem hot and difficult - but the men all smile as they produce glasses of amber liquid (beer?). Scenes flash across the room; you are dazed as you gaze upon unusual people in strange clothing, all locked in dramatic conflict with each other. These scenes are neatly spaced with scenes of enthusiastic users of soap.\n" \
"  Make a L2-SR on your IQ (25 - IQ), or you cannot tear your eyes away from the pictures. If you miss the roll, subtract the number you missed by from your IQ, and then attempt the roll again. If you miss again, repeat the roll and continue to take damage until you escape or succumb with no IQ. If your IQ is reduced to 0, you are absorbed by the walls, and are trapped here forever in a meaningless parade of charades. Survivors may leave east to {95}, or west to {144}."
},
{ // 153/34C
"* If you are attacking with conventional or magical weapons, make a L2-SR on Constitution (25 - CON). The water beings wash over you in an attempt to drown you. (If you cannot be drowned, ignore this saving roll and fight normally). If you miss the saving roll, take damage directly off your CON (armour won't help) equal to the number you missed the roll by. You must make this saving roll each combat turn you fight.\n" \
"  Each water sprite has an effective CON of 40 (once you inflict 40 hits on it, it leaves you alone). Three of the sprites fight back if you attack any one of them. If there are three of you, you must fight one-on-one, but if there are fewer of you, you fight general melee. Bear in mind that if hand-to-hand weapons *and* magic are used against the same sprite, the character in hand-to-hand conflict will also suffer damage (divide equally), because these water sprites are *all over* the character they're fighting.\n" \
"  The remaining water sprite merely continues its dance as any survivors go to {82}."
},
{ // 154/34D
"\"To you I can give knowledge, or I can give immortality,\" Dargon says. If you want knowledge, go to {119}. If you choose immortality, go to {94}."
},
{ // 155/35A
"* When you pushed the button, the doors slammed shut. The north and south walls begin to move, slowly but steadily closing in on the party. You may try to halt their advance with your collective strength - total the ST rating of the entire party. If the total is 50 or more, you stop the walls. If you don't have that much strength, you find you can't jam the walls with anything that doesn't crumple or shatter - unless you have a deluxe staff. If you *do* have a deluxe staff, you can jam it between the approaching walls, and they will stop. If you attempt to remove the staff, the walls will try to finish closing; to leave the room, you'll have to abandon the staff.\n" \
"  If you can't stop the walls, they meet under considerable pressure in the middle of the room, and everyone is reduced to a two-dimensional character. (In short, they die.)\n" \
"  If you survive, the doors open. Exit through the east door ({95}), or the west door ({144})."
},
{ // 156/35B
"* Each character who is not immune to fire and flames and who attempts to pass over the open pit must attempt a L2-SR on IQ (25 - IQ). If the roll is failed, the character's concentration was shattered by recollection of unworthy deeds. The character slips and bursts into flame before striking the coals. Any who succeed in making the saving roll may go to {7}."
},
{ // 157/35C
"As you walk down this corridor, the pathway slowly becomes a bright pink. Your eyes don't seem to focus correctly; your movements slow and you feel groggy. A bit later, you notice your companions have vanished. You black out.\n" \
"  All warriors should go to {21}. All wizards should go to {30}. All rogues should go to {72}. Any warrior-wizards should go to {48}. (If there is more than one of any character type, they should be sent and run individually.)"
},
{ // 158/35D
"* Choose the order in which your characters will pass through the water. For each character, one at a time, roll 2 dice (doubles add and re-roll). As soon as one character rolls less than 7, note where he stood in line, and go directly to the option written for him.\n" \
"  If the first character rolled less than 7, go to {65}. If the second character rolled less than 7, go to {69}. If the third character rolled less than 7, go to {115}. If no one rolled below a 7, you may continue along your path - either northwest to {26} or southeast to {95}."
},
{ // 159/35E
"While the others in your party dig around in the mounds, you move a little away, digging in a different area. You hear a short, strangled cry from one of your fellows and wheel about to find them all turned to stone. If you run towards them to come to their aid, go to {113}. If you beat a hasty retreat, go northeast to {95} or southwest to {67}. Because you smell so bad, cut your CHR by 3 until you have a chance to take a bath. (If you have an elemental in your service, it's now trying to kill you.)"
},
{ // 160/35F
"Make a L2-SR on Strength (25 - ST). If you succeed, you break free. If you fail, the throne continues to writhe about you until it engulfs you. Your struggles expend the last of your air, and you smother. Survivors can go to the north at {71}, or turn back south by going to {76}."
},
{ // 161/36A
"* He catches fire quickly, but as soon as he begins to burn a piercing wail cuts through the room. The doors slam shut, and a magical sprinkler system (built into the walls and ceiling of this room) floods the area with water. Magical fire or not, before much damage is done the water puts it out - soaking the mummy in the process. The weight of the water he has absorbed makes him very heavy-handed - he attacks with a MR of 100 (11d+50). If you defeat this sopping wet horror, go to {44}."
},
{ // 162/36B
"* As you approach the silver lake, the silvery liquid recedes away from your feet like a wave pulling away from a beach. It flows, up towards the skeleton and rises, inching its way up the bare bones. Within seconds, the bones are covered in a silvery skin of shimmering metal. When the silver wave has surged up about the skull, the glistening eyelids open and dark hollow eyes gaze upon you. A chill takes your breath away for a moment, for the eyes contain a malevolent emptiness that bodes ill.\n" \
"  If you attack this thing with material weapons, go to {147}. If you wish to use magic, [choose your spell and consult the Magic Matrix before ]go[ing] to {147}."
},
{ // 163/36C
"For each turn of instruction that each character took, you must make a L1-SR on Luck (20 - LK) to see if you strained something. Take damage off your DEX. [If your DEX drops to zero, you must stop taking lessons. ]You won't recover any damage to your DEX until you are out of the dungeon and can recuperate for a few days.[ After making the SR, roll a six-sided die. This is the number of additional adds you'll receive from now on while using a sword from the same class you took instruction with (i.e. a straight sword, curved, unusual, or towne sword).]\n" \
"  Entak bids you a fond farewell, good luck, and tells you to go west to {71} or east to {12}."
},
{ // 164/36D
"He accepts all your money, goods, and any armour you have, in exchange for your life. As he swims away, you rejoin your party, heading either northwest to {26} or southeast to {95}."
},
{ // 165/36E
"* She sits silently at the head of the table while you feast. When you finish and sit back with a sigh, she speaks. \"You have partaken of my food, strangers. In payment, I wish only entertainment. I want one of you to dance for me. \"She points to the character with the highest Charisma, and gestures. That person stands and begins to dance. She summons a wind to aid the dancer, so the whirls and turns quickly take on a feverish speed.\n" \
"  Roll 1 die. The result is the number of turns the character must dance. It is also the level of the CON saving roll this character must make in order to continue dancing. If the saving roll is missed, the dancer's CON falls to 1 and he or she falls unconscious from exhaustion. If there are others in the party, she selects the next most engaging (ie. the one with the next highest CHR) and starts the dance again.\n" \
"  If you want to attack her, either at the end of a successful dance or before she can make the second person dance, go to {33}. If no one completes the dance, go to {122}. If everyone dances (you may join in of your own volition any time you wish, but under the same constraints of time and exertion), and everyone completes the dance, go to {143}. If at least one person completes the dance and you want to leave, you can go south to {26} or north along the blue path to {38}."
}
}, dd_wandertext[11] = {
{ // 0
"2. Your opponent is a filthy rat which is roughly the size of a german shepherd. It has a MR of 15, but makes up for its weakness in speed and viciousness. The rat picks one member of the party at random to attack. Unless that character can make a L2-SR on Dexterity (25 - DEX), the rat will dodge through his guard and do full damage - the character who was attacked can't produce a combat roll in his defence. The other party members can do direct damage to the rat while it is in its berserk fury; the rat can offer no defence. The rat carries no treasure."
},
{ // 1
"3. A giant wolf leaps out of nowhere, hoping to surprise you. Unless each party member can make a L2-SR on Luck (25 - LK), he does just that, and gets a free combat round against the whole group. If even one of the party members makes the roll, however, consider your party to be on guard. Then, surprise the wolf - he has a mere 20 MR. The wolf has no pockets, and hence no treasure."
},
{ // 2
"4. A single ugly orc strides forward and demands that you give him all your treasure, weapons, magic items and armour in exchange for your continued existence. If you comply, he makes like a bandit - and you're as naked as the day you were born. If you don't like his plan, then kill this stupid orc. His MR is 30."
},
{ // 3
"5. A goblin with cataracts over his eyes and a strange row of spikes running along his spine charges towards you. A scream hangs on his lips, and murder is on his mind. Dispatch the bugger and be done with it - his Monster Rating is 40."
},
{ // 4
"6. Towards you shambles a horrible heap of decomposing flesh and tattered bandages. This mummy has a MR of 45, and does not like open flames. Show him one and he'll run like the devil - a guy doesn't stay dead as long as this fellow has by getting into fights that are too tough for him."
},
{ // 5
"7. With a bovine roar, an 8' minotaur launches a furious attack against your party. He has a MR of 40 (including axe and horns), and his furry hide will take 5 hits each round."
},
{ // 6
"8. An enormous cave bear pads towards you upon huge, clawed paws. Madness glows from his eyes, and foam drips from his jowls. With a roar, he is in your midst, striking out furiously with his massive arms. Fight or die - he has a Monster Rating of 65. He has no use for treasure, and so he isn't carrying any."
},
{ // 7
"9. Before you stands the world-famous Troll with the Roofing Beam, fresh from a long and successful run at the world-famous Dungeon of the Bear and the labyrinth within the castle Overkill. He's a bit tired after being on the road so long, but he's still good for a Monster Rating of 70."
},
{ // 8
"10. A demented dwarf with a meat-axe drops out of nowhere and attempts to turn your party into cheese. All characters present must make a L2-SR on Luck (25 - LK) to react in time to participate in the first combat round. If you miss the roll, but live to see the second round, you can fight normally. Those who make the roll conduct normal combat. The dwarf has a MR of 75[; in addition, his axe gets 4 dice in combat]."
},
{ // 9
"11. With a puff of brimstone, a demon materializes before your party. If you agree to sacrifice one of your party members, he'll let the rest of you pass by without a fight. Otherwise, he'll attack and try to sacrifice all of you by himself. He has a Monster Rating of 100[, but direct combat magic (Take That You Fiend, Blasting Power, etc.) scores double damage on him]."
},
{ // 10
"12. Your opponent is one of Dargon's favourite pets, a giant serpent common to the jungles of Gull. It intends to make you its dinner. Unless this idea appeals to you, fight the fight of your life. The serpent has a Monster Rating of 120, and carries no treasure."
}
}, dd_treasuretext[11] = {
{ // 0
"2. A bronzed skullcap with elvish runes (transcribing to \"D'Savoc\") etched upon it.[ When worn, this cap will allow a character to understand, speak, or write any language he or she is exposed to. The cap is very fragile, however, and will break easily if struck.]"
},
{ // 1
"3. A high-impact helmet with an elaborate face bearing a runic letter \"B\" upon its sides.[ This helmet will double its wearer's adds in hand-to-hand combat, but robs him temporarily of his memory. Unless his fellow party members can make a Charisma saving roll at the wearer's level, they will be mistaken for enemies and attacked! Whenever no further combat options present themselves, the helmet can be removed.]"
},
{ // 2
"4. An elaborate copper ring[, proof against 4 physical hits per combat round]."
},
{ // 3
"5. A small, glowing ring, barely large enough to fit on a finger.[ When worn, this ring gives a person the ability to levitate fractions of an inch off the surface of the earth below him, which allows him to walk on water, stride over pools of acid, etc.]"
},
{ // 4
"6. An elaborate gilded amulet.[ It is proof against up to 10 hits of magical attack per combat round.]"
},
{ // 5
"7. A skull-shaped amulet that will repair hits taken on CON, at the rate of one per (regular) turn."
},
{ // 6
"8. A pair of winged boots[ which, when worn by a character with magical abilities, allows the wearer to cast a Wings spell upon himself at the cost of only 1 ST point].[ (The wearer can't use the boots if he doesn't know the spell!)]"
},
{ // 7
"9. A magical shuriken (1 die)[ that never misses when thrown with sufficient force to reach its target].[ This shuriken works for everyone, so if it hits someone and fails to kill him, don't be surprised if it gets thrown back!]"
},
{ // 8
"10. A magic sword, with no ST or DEX requirements, worth 6d+6 in combat. [This sword will also provide as many hits as it generates as armour against physical attack. ](Weight: 50.)"
},
{ // 9
"11. An [indestructible ]iron spear, worth 5 dice in combat[, that rolls berserkly without forcing its wielder to go into the battle rage]."
},
{ // 10
"12. An enchanted war hammer with the word \"Moe\" etched upon it. Worth 5d+1 in combat, it weighs 100 and requires a ST of 17 to wield.[ The hammer is worth twice its die roll when fighting any troll not armed with a roofing beam.]"
}
};

MODULE SWORD dd_exits[DD_ROOMS][EXITS] =
{ { 114,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  95,  67,  29,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  41,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  26,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  {  57, 102,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/2A
  { 144,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/2B
  {  18,  78,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2C
  {  83,  95,  71,  -1,  -1,  -1,  -1,  -1 }, //  10/2D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/2E
  { 120, 157, 102,  51,  -1,  -1,  -1,  -1 }, //  12/3A
  {  64,  37,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/3B
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/3C
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/3D
  {  95,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/3E
  {  57,  26,  86, 133,  66,  -1,  -1,  -1 }, //  17/4A
  {   9,  80,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/4C
  { 120, 157, 102,  51,  -1,  -1,  -1,  -1 }, //  20/4D
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/4E
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/5A
  {  90,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/5B
  {  68,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/5C
  {  52,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/6A
  {  76,  17,  51, 130,  -1,  -1,  -1,  -1 }, //  26/6B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/6C
  { 120, 157,  51, 102,  -1,  -1,  -1,  -1 }, //  28/6D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/6E
  { 136,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/6F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/7A
  { 144,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/7B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/7C
  {  67,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/7D
  {  90,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/7E
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/8A
  {  50,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/8B
  {  71,  76,  98,  -1,  -1,  -1,  -1,  -1 }, //  38/8C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/9A
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/9B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/9C
  {  50,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/9D
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/9E
  {  71,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/9F
  {  25, 154,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/10A
  {  57,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/10B
  {  71,  92,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/10C
  {  70,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/11A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/11B
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/11C
  {  26,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/11D
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/12B
  { 134,  78,   1, 157,  -1,  -1,  -1,  -1 }, //  54/12C
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/12D
  { 132,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/12E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/13A
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/13B
  { 144,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/13C
  {  32,  10, 130,   1,  -1,  -1,  -1,  -1 }, //  60/13D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/13E
  {  95,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/14A
  {  38,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/14B
  {  87,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/14C
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/14D
  { 121,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/15A
  {  19, 126,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/15B
  { 145,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/15C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/15D
  {  90,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/16A
  {  23,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/16B
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/16C
  {  57,  32,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/16D
  { 120, 157,  51, 102,  -1,  -1,  -1,  -1 }, //  75/16E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/17A
  {  41,   3,  24,  -1,  -1,  -1,  -1,  -1 }, //  77/17B
  { 103, 141,  34,  -1,  -1,  -1,  -1,  -1 }, //  78/18A
  {  26,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/18B
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/18C
  {  95, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/18D
  { 130,   1,  32,  10,  -1,  -1,  -1,  -1 }, //  82/18E
  { 129,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/19A
  {  26,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/19B
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/20A
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/20B
  {  50,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/20C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/20D
  { 120, 157, 102,  51,  -1,  -1,  -1,  -1 }, //  89/20E
  {  12,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/20F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/21A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/21B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/21C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/21D
  {  60, 153, 118,  -1,  -1,  -1,  -1,  -1 }, //  95/21E
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/22A
  {   2,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/22B
  { 160,  49,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/22C
  {  42, 104,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/22D
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/22E
  {  26,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/23A
  { 162,  27,  12,  40,  -1,  -1,  -1,  -1 }, // 102/23B
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/23C
  {  71,  50,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/23D
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/24A
  {  47,  50,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/24B
  {  38,  26,  33,  -1,  -1,  -1,  -1,  -1 }, // 107/24C
  {  95, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/24D
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/24E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/25A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/25B
  {  71,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/25C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/25D
  {  17, 144,  40, 134,  -1,  -1,  -1,  -1 }, // 114/26A
  {  15, 164,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/26B
  {  26,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/26C
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/26D
  { 130,   1,  32,  10,  -1,  -1,  -1,  -1 }, // 118/26E
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/27A
  { 132, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/27B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/27C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/27D
  {  12,  40,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/27E
  {  26,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/28A
  {  97,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/28B
  {  54,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/28C
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/28D
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/28E
  {  71,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/28F
  { 158,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/29A
  {  50,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/29B
  {  71,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/29C
  {  26,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/29D
  {  57,  67,  77,  -1,  -1,  -1,  -1,  -1 }, // 134/30A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/30B
  {  90,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/30C
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/30D
  { 120, 157,  51, 102,  -1,  -1,  -1,  -1 }, // 138/30E
  {  17, 134, 144,  40,  -1,  -1,  -1,  -1 }, // 139/31A
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/31B
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/31C
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/31D
  {  38,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/32A
  {  57,  32,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/32B
  {  57,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/32C
  {  26,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/32D
  { 123,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/33A
  {  89,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/33B
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/33C
  { 163,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/33D
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/34A
  {  95, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/34B
  {  82,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/34C
  { 119,  94,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/34D
  {  95, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/35A
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/35B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/35C
  {  26,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/35D
  {  95,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/35E
  {  71,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/35F
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/36A
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/36B
  {  71,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/36C
  {  26,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/36D
  {  26,  38,  -1,  -1,  -1,  -1,  -1,  -1 }  // 165/36E
};

MODULE STRPTR dd_pix[DD_ROOMS] =
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
  "dd-p2", //  10
  "",
  "dd-p3",
  "",
  "",
  "", //  15
  "",
  "",
  "",
  "",
  "", //  20
  "dd-p5",
  "",
  "dd-p5",
  "",
  "", //  25
  "",
  "",
  "dd-p3",
  "",
  "", //  30
  "",
  "",
  "",
  "",
  "", //  35
  "",
  "",
  "dd-p8",
  "",
  "", //  40
  "",
  "",
  "",
  "",
  "dd-p10", //  45
  "",
  "",
  "",
  "dd-p8",
  "", //  50
  "dd-p11",
  "",
  "",
  "dd-p25",
  "dd-p28", //  55
  "",
  "",
  "",
  "",
  "dd-p21", //  60
  "",
  "dd-p14",
  "dd-p17",
  "",
  "", //  65
  "",
  "dd-p25",
  "",
  "",
  "", //  70
  "",
  "dd-p5",
  "",
  "",
  "dd-p3", //  75
  "dd-p17",
  "",
  "",
  "",
  "", //  80
  "",
  "",
  "",
  "",
  "dd-p20", //  85
  "dd-p29",
  "",
  "",
  "",
  "", //  90
  "",
  "",
  "",
  "",
  "dd-p21", //  95
  "",
  "",
  "dd-p8",
  "",
  "", // 100
  "",
  "",
  "",
  "",
  "dd-p24", // 105
  "",
  "dd-p17",
  "",
  "",
  "dd-p25", // 110
  "dd-p29",
  "dd-p8",
  "",
  "",
  "", // 115
  "",
  "",
  "",
  "",
  "", // 120
  "",
  "dd-p17",
  "",
  "dd-p28",
  "", // 125
  "dd-p25",
  "",
  "",
  "dd-p2",
  "", // 130
  "",
  "",
  "dd-p29",
  "",
  "", // 135
  "",
  "",
  "dd-p3",
  "",
  "", // 140
  "",
  "",
  "dd-p32",
  "",
  "", // 145
  "",
  "",
  "dd-p3",
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
  "dd-p17"  // 165
};

EXPORT FLAG                   wanderer = FALSE;

MODULE FLAG                   living;
MODULE int                    lostitem;

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
                              gp, sp, cp, rt, lt, both,
                              height, weight, sex, race, class, size,
                              room, prevroom, module,
                              spellchosen,
                              spelllevel,
                              spellpower,
                              theround;
IMPORT       TEXT             userstring[40 + 1];
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

MODULE void dd_enterroom(void);
MODULE void dd_treasure(void);
MODULE void dd_wandering(void);

EXPORT void dd_preinit(void)
{   descs[MODULE_DD]     = dd_desc;
    wanders[MODULE_DD]   = dd_wandertext;
    treasures[MODULE_DD] = dd_treasuretext;
}

EXPORT void dd_init(void)
{   int i;

    exits     = &dd_exits[0][0];
    enterroom = dd_enterroom;
    for (i = 0; i < DD_ROOMS; i++)
    {   pix[i] = dd_pix[i];
}   }

MODULE void dd_enterroom(void)
{   TRANSIENT int  good,
                   evil,
                   i,
                   result,
                   result1,
                   result2,
                   result3,
                   target;
    TRANSIENT FLAG ok;
    PERSIST   int  oldstat,
                   zombies;

    switch (room)
    {
    case 1:
        DISCARD castspell(FALSE, -1);
    acase 2:
        create_monster(359);
        DISCARD castspell(FALSE, -1);
        do
        {   if (saved(2, con))
            {   oneround();
            } else
            {   die();
        }   }
        while (countfoes());
        give_gp(100);
    acase 3:
        DISCARD castspell(FALSE, -1);
        for (i = 1; i <= 3; i++)
        {   if (shooting()) // %%: Do they need to shoot at least once?
            {   if (shot(RANGE_NEAR, SIZE_TINY, FALSE))
                {   room = 46;
                } else
                {   getsavingthrow(FALSE);
                    if (madeit(evil_getneeded(RANGE_NEAR), npc[0].dex))
                    {   good_takehits(dice(6) + 62, TRUE);
            }   }   }
            else
            {   break;
        }   }
    acase 4:
        die();
    acase 5:
        if (cast(SPELL_KK, FALSE))
        {   room = 75;
        } else
        {   savedrooms(2, dex, 75, 138);
        }
    acase 6:
        dd_treasure();
        dd_treasure();
        give_gp(400);
    acase 7:
        gain_flag_ability(93);
    acase 8:
        if (been[8])
        {   permlose_st(dice(1));
        } elif (saved(1, st))
        {   gain_st(dice(1));
        } else
        {   gain_st(misseditby(1, st));
        }
    acase 10:
        if (can_makefire() && getyn("Burn mummy"))
        {   room = 161;
        }
    acase 11:
        die();
    acase 12:
        result = getnumber("1) Right\n2) Left\n3) Both\n4) Neither\nOpen which chest", 1, 4);
        if   (result == 1) room =  5;
        elif (result == 2) room = 61;
        elif (result == 3) room = 28;
    acase 14:
        create_monster(361);
        // %%: it says he "may" hold a treasure; however, he will always have one!
        fight();
        dd_treasure();
        give(578);
    acase 15:
        create_monster(362);
        npc[0].mr = dice(2) * 5;
        recalc_ap(0);
        fight();
    acase 16:
        give(579);
        gain_flag_ability(92);
        if (items[574].owned) { create_monsters(319, items[574].owned); dropitems(574, items[574].owned); }
        if (items[602].owned) { create_monsters(384, items[602].owned); dropitems(602, items[602].owned); }
        fight();
    acase 19:
        create_monster(387);
        while (countfoes())
        {   if (castspell(-1, TRUE))
            {   getsavingthrow(FALSE);
                if (madeit(evil_getneeded(RANGE_FAR), 42))
                {   good_takehits(dice(3) + 100, TRUE);
            }   }
            elif (shooting())
            {   getsavingthrow(FALSE);
                if (madeit(evil_getneeded(RANGE_FAR), 42))
                {   good_takehits(dice(3) + 100, TRUE);
                }

                if (shot(RANGE_FAR, SIZE_HUGE, FALSE))
                {   evil_takemissilehits(0);
            }   }
            else
            {   break;
        }   }
        if (countfoes())
        {   room = 126;
        } else
        {   room = 54;
        }
    acase 20:
        give(574);
    acase 21:
        oldstat = st;
        makeclone(0);
        do
        {   aprintf("Your ST: %d. Clone's ST: %d.\n", st, npc[0].st);
            good = dice((       st / 10) + 1) + (       st / 2) + (       st % 2);
            evil = dice((npc[0].st / 10) + 1) + (npc[0].st / 2) + (npc[0].st % 2);
            aprintf("Your HPT: %d. Clone's HPT: %d.\n", good, evil);
            if (good > evil)
            {   npc_permlose_st(0, good - evil);
            } else
            {   templose_st(evil - good);
        }   }
        while (npc[0].st >= 1);
        kill_npcs();
    acase 22:
        if (saved(2, dex))
        {   if (!saved(2, st))
            {   good_takehits(misseditby(2, st), TRUE);
        }   }
        else
        {   good_takehits(misseditby(2, dex), TRUE);
            if (!saved(2, st))
            {   die();
        }   }
        give(575);
    acase 23:
        change_lk(oldstat);
        give_multi(576, 2);
    acase 24:
        getsavingthrow(FALSE);
        if (madeit(evil_getneeded(RANGE_POINTBLANK), npc[0].dex))
        {   good_takehits(dice(6) + 62, TRUE);
        }
    acase 26:
        if
        (   prevroom != 58
         && prevroom != 125
         && prevroom != 140
         && getyn("Inspect basin and gargoyle (otherwise leave)")
        )
        {   room = 97;
        }
    acase 27:
        die();
    acase 28:
        if (armour == -1)
        {   templose_con(dice(2));
        } else
        {   templose_con(dice(1));
        }
        give(577);
        DISCARD castspell(-1, FALSE);
    acase 29:
        savedrooms(2, lk, 62, 93);
    acase 30:
        oldstat = iq;
        makeclone(0);
        do
        {   aprintf("Your IQ: %d. Clone's IQ: %d.\n", iq, npc[0].iq);
            good = dice((       iq / 10) + 1) + (       iq / 2) + (       iq % 2);
            evil = dice((npc[0].iq / 10) + 1) + (npc[0].iq / 2) + (npc[0].iq % 2);
            aprintf("Your HPT: %d. Clone's HPT: %d.\n", good, evil);
            if (good > evil)
            {   npc_lose_iq(0, good - evil);
            } else
            {   lose_iq(evil - good);
        }   }
        while (npc[0].iq >= 1);
        kill_npcs();
    acase 32:
        if (getyn("Press button"))
        {   result = dice(1);
            switch (result)
            {
            case  1: room = 155;
            acase 2: room =   8;
            acase 3: room =  59;
            acase 4: room =  81;
            acase 5: room = 152;
            acase 6: room = 108;
        }   }
    acase 33:
        die();
    acase 34:
        result = dice(1) + 1;
        create_monsters(363, result); // %%: presumably they are near enough to do melee attacks
        do
        {   if (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, TRUE))
                {   evil_takemissilehits(target);
                }
                evil_freeattack();
            } else
            {   oneround();
            }
            if (theround >= 2) // %%: can more ulogulos arrive only now, or now and on every subsequent combat round?
            {   result2 = dice(1);
                if (result2 <= 3)
                {   create_monsters(363, result2);
                    result += result2;
        }   }   }
        while (countfoes());
        award(result <= 5 ? (result * 10) : 50);
    acase 35:
        heal_st(oldstat - st);
        give(580);
    acase 36:
        if (!ability[94].known && !ability[95].known)
        {   gain_flag_ability(94);
        } elif (ability[94].known && !ability[95].known)
        {   lose_flag_ability(94);
            gain_flag_ability(95);
        }
    acase 37:
        if (!saved(1, (dex + iq) / 2))
        {   // %%: "defeat it": do they mean kill it, or just have a higher combat total?
            // %%: instructions are ambiguous anyway
            create_monster(364);
            zombies--;
            do
            {   oneround();
                if (countfoes() && zombies)
                {   create_monster(364);
                    zombies--;
            }   }
            while (countfoes());
            award(200);
        }
    acase 40:
        if ((prevroom == 57 || prevroom == 114 || prevroom == 139) && getyn("Return east"))
        {   room = 57;
        } elif ((prevroom == 102 || prevroom == 123) && getyn("Return west"))
        {   room = 102;
        }
    acase 41:
        while (countfoes())
        {   if (castspell(-1, TRUE))
            {   getsavingthrow(FALSE);
                if (madeit(evil_getneeded(RANGE_NEAR), npc[0].dex))
                {   good_takehits(dice(6) + 62, TRUE);
            }   }
            elif (shooting())
            {   getsavingthrow(FALSE);
                if (madeit(evil_getneeded(RANGE_NEAR), npc[0].dex))
                {   good_takehits(dice(6) + 62, TRUE);
                }

                if (shot(RANGE_NEAR, SIZE_LARGE, FALSE))
                {   evil_takemissilehits(0);
            }   }
            else
            {   break;
        }   }
        if (countfoes())
        {   room = 24;
        } else
        {   room = 54;
        }
    acase 42:
        living = FALSE;
        DISCARD castspell(-1, FALSE);
        if (!living && !can_makefire())
        {   ok = FALSE;
            for (i = 0; i < ITEMS; i++)
            {   if
                (   items[i].owned
                 && (items[i].type == WEAPON_SWORD || items[i].type == WEAPON_HAFTED) // strictly speaking, it's only axes, not all hafted weapons
                 && items[i].dice >= 4
                )
                {   ok = TRUE;
                    break;
            }   }
            if (!ok && !saved(6, lk))
            {   die();
        }   }
    acase 43:
        if (dice(1) <= 5)
        {   gain_st(dice(1));
        } else
        {   gain_st(dice(2));
        }
        give(597);
    acase 44:
        give_gp(400);
        rb_givejewel(-1, -1, 1);
        DISCARD castspell(-1, FALSE);
    acase 45:
        if (been[45])
        {   room = 71;
        } elif (class == WARRIOR)
        {   room =  25;
        } elif (class == ROGUE)
        {   room =  96;
        } elif (class == WIZARD)
        {   room = 154;
        }
    acase 46:
        dispose_npcs();
        give_multi(598, 10);
    acase 47:
        dd_wandering();
    acase 48:
        oldstat = dex;
        makeclone(0);
        do
        {   aprintf("Your DEX: %d. Clone's DEX: %d.\n", dex, npc[0].dex);
            good = dice((       dex / 10) + 1) + (       dex / 2) + (       dex % 2);
            evil = dice((npc[0].dex / 10) + 1) + (npc[0].dex / 2) + (npc[0].dex % 2);
            aprintf("Your HPT: %d. Clone's HPT: %d.\n", good, evil);
            if (good > evil)
            {   npc_lose_dex(0, good - evil);
            } else
            {   lose_dex(evil - good);
        }   }
        while (npc[0].dex >= 1);
        kill_npcs();
    acase 49:
        savedrooms(2, iq, 112, 160);
    acase 50:
        if (!saved(3, st))
        {   templose_st(misseditby(3, st));
        }
        DISCARD castspell(-1, FALSE);
    acase 51:
        if (maybespend(5, "Buy a drink"))
        {   room = 84;
        }
    acase 52:
        give(599); // %%: what's the dice+adds of this sword?
    acase 54:
        give_multi(253, 12);
    acase 55:
        if (class != WIZARD)
        {   class = WIZARD;
            for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && items[i].dice > 2)
                {   dropitems(i, items[i].owned);
            }   }
            if (iq < 10)
            {   change_iq(10);
        }   }
        give(DEL);
        for (i = 0; i < SPELLS; i++)
        {   if (spell[i].level <= 3)
            {   learnspell(i);
        }   }
        for (i = 0; i < SPELLS; i++)
        {   if (!spell[i].known && spell[i].level == 4)
            {   listspell(i, TRUE);
        }   }
        result = getspell("Learn which spell (ENTER for none)");
        if (result != -1 && !spell[result].known && spell[result].level == 4)
        {   learnspell(result);
        }
    acase 56:
        create_monsters(365, dice(2));
        fight();
    acase 57:
        dispose_npcs();
        result = getnumber("1) Ceiling\n2) North door\n3) South door\n4) East door\n5) West door\nLeap/dive for which", 1, 5);
        if (result == 1)
        {   if (saved(3, dex))
            {   room = 45;
            } else
            {   templose_con(misseditby(3, dex));
                room = 139;
        }   }
        else
        {   if (saved(2, dex))
            {   if   (result == 2) room =  17;
                elif (result == 3) room = 134;
                elif (result == 4) room = 144;
                else               room =  40;
            } else
            {   oldstat = misseditby(2, dex);
                templose_con(oldstat);
                room = 139;
        }   }
    acase 58:
        permlose_st(dice(2));
        if (st == 1)
        {   die();
        }
    acase 59:
        if (!ability[24].known)
        {   living = FALSE;
            castspell(-1, FALSE);
            if (!living)
            {   die();
        }   }
    acase 60:
        award(100);
    acase 61:
        if (cast(SPELL_KK, FALSE)) // %%: also apparently DD and PP can be cast, but they don't make sense!
        {   room = 20;
        } else
        {   savedrooms(2, dex, 20, 148);
        }
    acase 62:
        give(802);
        gain_flag_ability(92);
        if (items[574].owned) { create_monsters(319, items[574].owned); dropitems(574, items[574].owned); }
        if (items[602].owned) { create_monsters(384, items[602].owned); dropitems(602, items[602].owned); }
        fight();
    acase 63:
        award(50);
    acase 64:
        fight();
        create_monster(366);
        fight();
        create_monster(367);
        fight();
    acase 65:
        create_monster(368);
        npc[0].mr = dice(1) * 10;
        recalc_ap(0);
        fight();
    acase 67:
        dispose_npcs();
        if ((oldstat = getnumber("0) Nowhere\n1) North\n2) Northeast\n3) Northwest\n4) South\nRun where", 0, 4)))
        {   room = 110;
        }
    acase 68:
        create_monster(360);
        fight();
    acase 69:
        DISCARD castspell(-1, FALSE);
        // this paragraph is not implemented, because we only support one character
    acase 70:
        change_dex(oldstat);
        give(601); // %%: a normal broadsword is actually worth 3d+4, not 3d+3.
    acase 71:
        victory(100);
    acase 72:
        oldstat = lk;
        makeclone(0);
        do
        {   aprintf("Your LK: %d. Clone's LK: %d.\n", lk, npc[0].lk);
            good = dice((       lk / 10) + 1) + (       lk / 2) + (       lk % 2);
            evil = dice((npc[0].lk / 10) + 1) + (npc[0].lk / 2) + (npc[0].lk % 2);
            aprintf("Your HPT: %d. Clone's HPT: %d.\n", good, evil);
            if (good > evil)
            {   npc_lose_lk(0, good - evil);
            } else
            {   lose_lk(evil - good);
        }   }
        while (npc[0].lk >= 1);
        kill_npcs();
    acase 73:
        result = 0;
        elapse(2, TRUE);
        if (cast(SPELL_KK, FALSE))
        {   ;
        } elif (class == ROGUE)
        {   while (!saved(1, dex))
            {   result2 = dice(1);
                if (result2 <= 3)
                {   create_monsters(363, result2);
                    result += result2;
                }
                if (countfoes())
                {   oneround();
                } else
                {   elapse(2, TRUE);
            }   }
            dispose_npcs();
        } else
        {   // %%: do we have to do both rolls each attempt? We assume so.
            // %%: does each attempt take 2 rounds? We assume so.
            result2 = dice(1);
            if (result2 <= 3)
            {   create_monsters(363, result2);
                result += result2;
            }
            if (countfoes())
            {   oneround();
            } else
            {   elapse(2, TRUE);
            }
            while (!saved(1, lk) || !saved(1, dex))
            {   result2 = dice(1);
                if (result2 <= 3)
                {   create_monsters(363, result2);
                    result += result2;
                }
                if (countfoes())
                {   oneround();
                } else
                {   elapse(2, TRUE);
                }
                result2 = dice(1);
                if (result2 <= 3)
                {   create_monsters(363, result2);
                    result += result2;
                }
                if (countfoes())
                {   oneround();
                } else
                {   elapse(2, TRUE);
            }   }
            dispose_npcs();
        }
        award(result <= 5 ? (result * 10) : 50);
    acase 75:
        give(602);
    acase 76:
        DISCARD castspell(-1, FALSE);
        if (room == 76)
        {   result = getnumber("1) Go north\n2) Go south\n3) Attack\n4) Speak\n5) Drink\n6) Eat\n7) Seduce\nWhich", 1, 7);
            switch (result)
            {
            case  1: room =  38;
            acase 2: room =  68;
            acase 3: room =  33;
            acase 4: room =  63;
            acase 5: room = 107;
            acase 6: room = 165;
            acase 7: room =  91;
        }   }
    acase 77:
        getsavingthrow(FALSE);
        if (madeit(evil_getneeded(RANGE_NEAR), npc[0].dex))
        {   good_takehits(dice(6) + 62, TRUE);
        }
    acase 79:
        gain_flag_ability(96);
    acase 80: // %%: ambiguous paragraph
        lostitem = -1;
        if (!saved(2, dex))
        {   good_takehits(misseditby(2, dex), TRUE);
        }
        if (!saved(1, dex) && rt != -1)
        {   lostitem = rt;
            dropitem(rt);
        }
        DISCARD castspell(-1, FALSE);
    acase 81:
        healall_con();
    acase 82:
        for (i = 0; i < ITEMS; i++)
        {   if
            (   items[i].owned
             && (   items[i].type == ARMOUR // %%: all armour, or only worn armour?
                 || (isweapon(i) && !items[i].magical)
            )   )
            {   dropitems(i, items[i].owned);
        }   }
        // %%: what exactly is meant by "equipment"?
    acase 83:
        create_monster(369);
        fight();
    acase 84:
        if (!been[84])
        {   result = dice(2);
            switch (result)
            {
            case 2:
                gain_flag_ability(103);
            acase 3:
                gain_flag_ability(104);
            acase 4:
                gain_flag_ability(105);
            acase 5:
                gain_flag_ability(1);
            acase 6:
                weight -= 300;
                if (weight <= 0)
                {   die();
                }
                permlose_con(1);
            acase 7:
                if (race != HUMAN)
                {   race = HUMAN;
                    if (races[race].ht1 && races[race].ht2)
                    {   height = height * races[race].ht2 / races[race].ht1;
                    }
                    if (races[race].wt1 && races[race].wt2)
                    {   weight = weight * races[race].wt2 / races[race].wt1;
                    }
                    if (weight == 0)
                    {   weight = 1;
                }   }
            acase 8:
                if (!immune_poison())
                {   die();
                }
            acase 9:
                create_monster(386);
                evil_freeattack();
                evil_freeattack();
                evil_freeattack();
                if (ability[24].known)
                {   evil_freeattack();
                    evil_freeattack();
                    evil_freeattack();
                }
                // Strictly speaking, armour shouldn't help.
                dispose_npcs();
                give(617);
            acase 10:
                race = WEREWOLF;
                changerace();
            acase 11:
                gain_flag_ability(106);
            acase 12:
                gain_flag_ability(107);
            }
            award(100);
        }
    acase 85:
        give(603);
    acase 86:
        give(604);
        getsavingthrow(TRUE);
    acase 87:
        give_gp(2500); // %%: "in gold and jewels"
        give(605);
        award(50);
    acase 88:
        savedrooms(6, iq, 117, 142);
    acase 89:
        rb_givejewels(-1, -1, 1, 3);
        give(577);
    acase 91:
        die();
    acase 92:
        create_monsters(364, 6);
        oneround();
        oneround();
        oneround();
        if (countfoes())
        {   zombies = countfoes();
            room = 13;
        } else
        {   room = 131;
        }
    acase 93:
    case 94:
        die();
    acase 96:
        give(606);
    acase 97:
        if (prevroom != 116)
        {   result = throwcoin();
            if (result)
            {   room = 116;
        }   }
        if (room == 97 && prevroom != 125 && getyn("Drink fluid"))
        {   room = 125;
        }
    acase 100:
        if (saved(level, (iq + chr) / 2))
        {   gain_chr(dice(1));
        } elif (madeitby(level, (iq + chr) / 2) <= -10)
        {   die();
        }
    acase 101:
        if (madeit(2, lk))
        {   give(618);
        } else
        {   good_takehits(misseditby(2, lk), TRUE);
        }
    acase 103:
        if (!saved(1, lk))
        {   room = 67;
        } else
        {   result = dice(1) + 1;
            create_monsters(363, result);
            oneround();
            oneround();
            while (countfoes())
            {   result2 = dice(1);
                if (result2 <= 3)
                {   create_monsters(363, result2);
                    result += result2;
                }
                oneround();
            }
            award(result <= 5 ? (result * 10) : 50);
        }
    acase 104:
        create_monsters(364, 6);
        living = FALSE;
        DISCARD castspell(-1, FALSE);
        do
        {   if (!living && !saved(2, lk))
            {   die();
            } else
            {   oneround();
        }   }
        while (countfoes());
        award(200);
    acase 105:
        give(607);
        if (class != WARRIOR)
        {   become_warrior();
        }
    acase 107:
        if (con == max_con)
        {   gain_con(1);
        } else
        {   permchange_con(con + 5);
        }
    acase 108:
        DISCARD castspell(-1, FALSE);
    acase 110:
        getsavingthrow(FALSE);
        if (saved(evil_getneeded(RANGE_FAR), 42))
        {   good_takehits(dice(3) + 100, TRUE);
        }
        if   (oldstat == 1) room = 134;
        elif (oldstat == 2) room =   1;
        elif (oldstat == 3) room = 157;
        elif (oldstat == 4) room =  78;
        DISCARD castspell(-1, FALSE);
    acase 112:
        gain_flag_ability(97);
    acase 113:
        savedrooms(4, lk, 16, 11);
    acase 117:
        give(608);
    acase 118:
        result1 = dice(1);
        result2 = dice(1);
        result3 = dice(1);
        if (result1 == result2 && result1 == result3)
        {   lose_lk((result1 + result2 + result3) / 3);
        } else
        {   gain_flag_ability(98);
        }
    acase 119:
        result2 = 10;
        do
        {   for (i = 0; i < SPELLS; i++)
            {   if (!spell[i].known && spell[i].level <= result2)
                {   listspell(i, TRUE);
            }   }
            result = getspell("Learn which spell (ENTER for none)");
            if (result == -1)
            {   result2 = 0;
            } elif (!spell[result].known && spell[result].level <= result2)
            {   learnspell(result);
                result2 -= spell[result].level;
        }   }
        while (result2);
    acase 120:
        if (class == WIZARD)
        {   room = 71;
        } elif
        (   (   (both != EMPTY && items[both].type == WEAPON_SWORD)
             || (rt   != EMPTY && items[rt  ].type == WEAPON_SWORD)
             || (lt   != EMPTY && items[lt  ].type == WEAPON_SWORD)
            )
         && getyn("Take lessons")
        )
        {   room = 150; // %%: does "bearing" mean carrying or wielding? We assume wielding.
        }
    acase 121:
        savedrooms(3, st, 79, -1);
    acase 122:
        die();
    acase 123:
        result = daro();
        if (result > 32)
        {   result = 32;
        }
        for (i = 0; i < result; i++)
        {   if (i % 8 == 0)
            {   rb_givejewel(-1, SIZE_LARGE,   1);
            } else
            {   rb_givejewel(-1, SIZE_AVERAGE, 1);
        }   }
        give(609);
    acase 124:
        give(610);
        rb_givejewels(-1, -1, 1, 3);
    acase 125:
        if (saved(2, st))
        {   room = 140; // %%: even if immune to poison?
        } elif (!immune_poison())
        {   room = 58;
        }
    acase 126:
        if (!countfoes())
        {   create_monster(387);
        }
        getsavingthrow(FALSE);
        if (madeit(evil_getneeded(RANGE_POINTBLANK), npc[0].dex))
        {   good_takehits(dice(3) + 100, TRUE);
        }
        do
        {   if (saved(5, dex))
            {   good_freeattack();
            } else
            {   oneround();
        }   }
        while (countfoes());
    acase 128:
        gain_flag_ability(99);
    acase 129:
        rb_givejewels(-1, -1, 1, 3);
        give_gp(400);
    acase 130:
        if (getyn("Go back (otherwise press onward)"))
        {   if (prevroom == 60 || prevroom == 82 || prevroom == 118)
            {   room = 95;
            } elif (prevroom == 26)
            {   room = 26;
        }   }
    acase 131:
        give(611);
    acase 132:
        create_monster(370);
        fight();
        give_gp(240);
    acase 133:
        give(613);
        give(614);
    acase 134:
        create_monster(360);
        DISCARD castspell(-1, FALSE);
    acase 136:
        change_iq(oldstat);
        give(615);
    acase 137:
        result1 = (st + iq + lk + con + dex + chr + 10) / 6;
        result2 = (st + iq + lk + con + dex + chr + 10) % 6;
        // %%: do we use maximum or current values?
        // %%: does Speed count? We assume not.
        permchange_st(result1);
        change_iq(result1);
        change_lk(result1);
        permchange_con(result1);
        change_dex(result1);
        change_chr(result1 + result2);
    acase 138:
        if (armour == -1)
        {   templose_con(dice(2));
        } else
        {   templose_con(dice(1));
        }
        give(577);
        DISCARD castspell(-1, FALSE);
    acase 139:
        create_monster(371);
        for (;;)
        {   if (saved(oldstat, st))
            {   break;
            } else
            {   evil_freeattack();
        }   }
        DISCARD showansi(4);
        do
        {   oneround();
        } while (countfoes());
    acase 140:
        gain_flag_ability(100);
        weight *= 2;
    acase 141:
        result = dice(1) + 1;
        create_monsters(363, result);
        DISCARD showansi(4);
        oneround();
        oneround();
        while (countfoes())
        {   result2 = dice(1);
            if (result <= 3)
            {   create_monsters(363, result2);
                result += result2;
            }
            oneround();
        }
        if (cast(SPELL_KK, FALSE))
        {   elapse(2, TRUE);
        } elif (class == ROGUE)
        {   do
            {   elapse(2, TRUE);
            } while (!saved(1, dex));
        } else
        {   do
            {   elapse(4, TRUE);
            } while (!saved(1, lk) || !saved(1, dex));
        }
        award(result <= 5 ? (result * 10) : 50);
    acase 142:
        lose_iq(misseditby(6, iq));
        if (iq <= 2)
        {   elapse(dice(3) * 10, TRUE);
        }
    acase 143:
        give(616);
    acase 144:
        if (!been[142])
        {   if (getyn("Take all cards"))
            {   room = 88;
            } elif (getyn("Take one card"))
            {   result = dice(2);
                switch (result)
                {
                case   2: room =   4;
                acase  3: room = 137;
                acase  4: room =  22;
                acase  5: room =  43;
                acase  6: room =  55;
                acase  7: room = 149;
                acase  8: room = 105;
                acase  9: room = 100;
                acase 10: room = 128;
                acase 11: room =  14;
                acase 12: room = 151;
        }   }   }
    acase 145:
        give(XSB);
        if (race == CENTAUR)
        {   give(MAI);
        }
        give_gp(dice(3) * 100);
    acase 146:
        gain_flag_ability(101);
    acase 147:
        if (prevroom != 36)
        {   create_monster(385);
        }
        do
        {   oneround();
            if
            (   usedweapons
             && (   (rt >= 0 && !items[rt].magical && isweapon(rt))
                 || (lt >= 0 && !items[lt].magical && isweapon(lt))
            )   )
            {   if (!saved(2, lk))
                {   room = 36;
                } elif (!saved(1, lk))
                {   templose_con(misseditby(1, lk));
        }   }   }
        while (countfoes());
    acase 148:
        DISCARD castspell(-1, FALSE);
    acase 149:
        gain_flag_ability(102);
    acase 150:
        if (!been[150] && class != WIZARD)
        {   result = money / 2000;
            if (result > 12)
            {   result = 12;
            }
            oldstat = getnumber("How many turns", 0, result);
            pay_gp(oldstat * 20);
        } else
        {   oldstat = 0;
        }
    acase 151:
        do
        {   result1 = getnumber("Bet how many gp", 0, gp);
            pay_gp_only(result1);
            if (result1)
            {   result2 = getnumber("1) Odd\n2) Even\3-18) That number\nWhich", 1, 18);
                result3 = dice(3);
                if
                (   (result2 == 1 && result3 % 2 == 1)
                 || (result2 == 2 && result3 % 2 == 0)
                )
                {   give_gp(result1 * 3 / 2);
                } elif (result2 == result3)
                {   switch (result2)
                    {
                    case 3:
                    case 18:
                        give_gp(result1 * 36);
                    acase 4:
                    case 5:
                    case 16:
                    case 17:
                        give_gp(result1 * 24);
                    acase 6:
                    case 7:
                    case 8:
                    case 13:
                    case 14:
                    case 15:
                        give_gp(result1 * 6);
                    adefault: // 9..12
                        give_gp(result1 * 2);
        }   }   }   }
        while (result1);
    acase 152:
        while (!saved(2, iq))
        {   lose_iq(misseditby(2, iq));
        }
    acase 153:
        create_monsters(388, 3);
        do
        {   oneround();
            if (usedweapons && !can_breathewater(TRUE) && !saved(2, con))
            {   templose_con(misseditby(2, con));
            }
        } while (countfoes());
    acase 155:
        if (st < 50)
        {   if (items[DEL].owned)
            {   dropitem(DEL);
            } elif (items[ITEM_AS_SDELUXE].owned)
            {   dropitem(ITEM_AS_SDELUXE);
            } elif (items[ITEM_GK_CDELUXE].owned)
            {   dropitem(ITEM_GK_CDELUXE);
            } else
            {   living = FALSE;
                DISCARD castspell(-1, FALSE);
                if (!living)
                {   die();
        }   }   }
    acase 156:
        if (!immune_poison() && !saved(2, iq))
        {   living = FALSE;
            DISCARD castspell(-1, FALSE);
            if (!living)
            {   die();
        }   }
    acase 157:
        if   (class == WARRIOR      ) room = 21;
        elif (class == WIZARD       ) room = 30;
        elif (class == ROGUE        ) room = 72;
        elif (class == WARRIORWIZARD) room = 48;
    acase 158:
        if (prevroom != 65 && prevroom != 69)
        {   living = FALSE;
            DISCARD castspell(-1, FALSE);
            if (!living && daro() < 7)
            {   room = 65;
        }   }
    acase 159:
        // %%: arguably we shouldn't allow going to 113, since there is only one character?
        if (!getyn("Retreat"))
        {   room = 113;
        } else
        {   gain_flag_ability(92);
            if (items[574].owned) { create_monsters(319, items[574].owned); dropitems(574, items[574].owned); }
            if (items[602].owned) { create_monsters(384, items[602].owned); dropitems(602, items[602].owned); }
            fight();
        }
    acase 160:
        if (!saved(2, st))
        {   die();
        }
    acase 161:
        create_monster(372);
        fight();
    acase 163:
        if (oldstat)
        {   for (i = 1; i <= oldstat; i++)
            {   elapse(10, TRUE);
                if (!saved(1, lk))
                {   owe_dex(misseditby(1, lk));
        }   }   }
    acase 164:
        drop_all(); // %%: what about eg. weapons?
    acase 165:
        DISCARD castspell(-1, FALSE);
        if (room == 165 && !saved(dice(1), con))
        {   templose_con(con - 1);
            room = 122;
}   }   }

MODULE void dd_treasure(void)
{   int result;

    aprintf(
"MAGIC ITEMS CHART\n" \
"  When you must roll for a magic item, roll two six-sided dice, and read that number on the chart below. [No single character may own more than one ot the items below, on pain of swift and permanent death.]\n"
    );

    result = dice(2);
    aprintf("%s\n", dd_wandertext[result - 2]);
    give(582 + result - 2);
}

MODULE void dd_wandering(void)
{   FLAG treasure;
    int  whichmonster;

    aprintf(
"WANDERING MONSTER CHART\n" \
"  When you are told to roll for a Wandering Monster, you must roll a six-sided die. If it comes up a 1, you have encountered a Wandering Monster.\n" \
"  When facing a WM, roll two dice and consult the table below. All WMs attack immediately, so there is no chance of a first round of missile fire. Combat and attack magic works normally for WMs; do not consult the Magic Matrix.\n" \
"  If you have determine d that you are facing a WM, check to see if it has a treasure (unless the instructions specifically say the create in question has no loot) by rolling one die. If you roll a 1 or a 2, the monster has treasure.\n" \
"  *Roll the die again*. If it comes up anything but 1, generate the WM's treasure by using the standard T&T rules. If you roll a 1, however, it means that the WM has a *magic treasure*. Turn to the Magic Item Chart to see just what treasure the monster has. [If it is some sort of weapon or defensive item, the WM will use it in combat if at all possible.]\n"
    );

    if (dice(1) >= 2)
    {   return;
    }
    wanderer = TRUE;

    whichmonster = dice(2) - 2;
    treasure = TRUE;
    switch (whichmonster)
    {
    case 2 - 2:
        create_monster(373);
        if (!saved(2, dex))
        {   evil_freeattack();
        }
        fight();
        treasure = FALSE;
    acase 3 - 2:
        create_monster(374);
        if (!saved(2, lk))
        {   evil_freeattack();
        }
        // %%: "surprise the wolf": does this mean we get a free attack? We assume not.
        fight();
        treasure = FALSE;
    acase 4 - 2:
        if (getyn("Comply (otherwise attack)"))
        {   drop_all();
            treasure = FALSE;
        } else
        {   create_monster(375);
            fight();
        }
    acase 5 - 2:
        create_monster(376);
        fight();
    acase 6 - 2:
        if (can_makefire() && getyn("Make fire"))
        {   treasure = FALSE;
        } else
        {   create_monster(377);
            fight();
        }
    acase 7 - 2:
        create_monster(378);
        fight();
    acase 8 - 2:
        create_monster(379);
        fight();
        treasure = FALSE;
    acase 9 - 2:
        create_monster(380);
        fight();
    acase 10 - 2:
        create_monster(381);
        if (!saved(2, lk))
        {   evil_freeattack();
        }
        fight();
    acase 11 - 2:
        create_monster(382);
        fight();
    acase 12 - 2:
        create_monster(383);
        fight();
        treasure = FALSE;
    }

    if (treasure && dice(1) <= 2)
    {   if (dice(1) == 1)
        {   dd_treasure();
        } else
        {   rb_treasure(2);
    }   }

    wanderer = FALSE;
}

#define is ==
#define or ||

EXPORT void dd_magicmatrix(void)
{   int i,
        oventimer,
        result;

    inmatrix = TRUE;

    switch (spellchosen)
    {
    case SPELL_RE:
        if (room is 80)
        {   aprintf("#7. You found the weapon. Each time you cast this spell, roll for a Wandering Monster. (You can't find a kris this way!)\n");
            if (lostitem != -1 && lostitem != 73)
            {   give(lostitem);
                lostitem = -1;
            }
            dd_wandering();
        } else
        {   noeffect();
        }
    acase SPELL_TF:
        if
        (   room is 19
         or room is 37
         or room is 64
         or room is 65
         or room is 69
         or room is 83
         or room is 92
         or room is 104
         or room is 126
         or room is 139
         or room is 147
         or room is 161
         or room is 162
        )
        {   fulleffect();
        } elif
        (   room is 2
         or room is 15
         or room is 34
         or room is 73
         or room is 103
         or room is 141
        )
        {   maybeeffect(5);
        } elif (room is 14)
        {   maybeeffect(4);
        } elif (room is 56)
        {   maybeeffect(3);
        } elif (room is 138 or room is 148)
        {   maybeeffect(2);
        } elif (room is 76 or room is 165)
        {   room = 33;
        } elif (room is 153)
        {   halfeffect();
        } else
        {   noeffect();
        }
    acase SPELL_VB:
        if
        (   room is 1
         or room is 2
         or room is 19
         or room is 44
         or room is 69
         or room is 108
         or room is 158
        )
        {   fulleffect();
        } elif
        (   room is 14
         or room is 15
         or room is 34
         or room is 37
         or room is 56
         or room is 64
         or room is 65
         or room is 73
         or room is 83
         or room is 92
         or room is 103
         or room is 104
         or room is 126
         or room is 132
         or room is 138
         or room is 139
         or room is 141
         or room is 147
         or room is 148
         or room is 153
         or room is 161
         or room is 162
        )
        {   aprintf("#14. During the combat turn you spend casting this spell, your opponent(s) get 1 free attack against you (unless you have a companion who is fighting for you both).\n");
            evil_freeattack();
            fulleffect();
        } elif (room is 76 or room is 165)
        {   room = 33;
        } else
        {   noeffect();
        }
    acase SPELL_PA:
        if (room is 2)
        {   powereffect(70);
        } elif (room is 14)
        {   maybeeffect(3);
        } elif (room is 15 or room is 65)
        {   powereffect(npc[0].mr);
        } elif (room is 19 or room is 126)
        {   powereffect(97);
        } elif
        (   room is 34
         or room is 73
         or room is 103
         or room is 141
        )
        {   powereffect(15); // %%: "[15@]"
        } elif (room is 56)
        {   powereffect(10);
        } elif (room is 69)
        {   if (spellpower >= 60)
            {   aprintf("#6. Go to {158} and leave.\n");
                room = 158;
        }   }
        elif (room is 76 or room is 165)
        {   room = 33;
        } elif (room is 83 or room is 161)
        {   maybepowereffect(3, 75);
        } elif (room is 139)
        {   powereffect(35);
        } elif (room is 147 or room is 162)
        {   if (spellpower >= 50)
            {   room = 123;
        }   }
        else
        {   noeffect();
        }
    acase SPELL_CF:
        if (room is 1)
        {   room = 62;
        } elif
        (   room is 2
         or room is 15
         or room is 37
         or room is 56
         or room is 64
         or room is 83
         or room is 92
         or room is 104
         or room is 126
         or room is 132
         or room is 147
         or room is 161
         or room is 162
        )
        {   fulleffect();
        } elif (room is 19 or room is 110)
        {   aprintf("#3. [He can't see a target. Double the level of his saving roll. If he hits, roll randomly to see who he struck.]\n");
        } elif
        (   room is 34
         or room is 65
         or room is 69
         or room is 73
         or room is 103
         or room is 141
        )
        {   aprintf("#10. Your opponent does not need to see you to fight you. The Concealing Cloak does you no good, though you've used the Strength to cast it.\n");
        } elif (room is 76 or room is 165)
        {   room = 33;
        } else
        {   noeffect();
        }
    acase SPELL_BM:
    case SPELL_RH:
        if
        (   room is 15
         or room is 34
         or room is 73
         or room is 92
         or room is 126
         or room is 139
         or room is 141
         or room is 153
        )
        {   fulleffect();
        } elif (room is 148)
        {   aprintf("#19. [You must make a saving roll only every second combat round, instead of every round.]\n");
        } else
        {   noeffect();
        }
    acase SPELL_DW:
        if
        (   room is 2
         or room is 15
         or room is 19
         or room is 34
         or room is 56
         or room is 64
         or room is 73
         or room is 92
         or room is 103
         or room is 110
         or room is 126
         or room is 132
         or room is 141
         or room is 147
         or room is 162
        )
        {   fulleffect();
        } elif (room is 138)
        {   aprintf("#19. [You must make a saving roll only every second combat round, instead of every round.]\n");
        } else
        {   noeffect();
        }
    acase SPELL_DS:
        if
        (   room is 19
         or room is 110
         or room is 126
        )
        {   aprintf("#2. [You have made another \"mirage\" target for each person in the party. Roll randomly to see what he hits: characters or mirages. If he hits a mirage, it will dis-spell the entire spell.]\n");
        } else
        {   noeffect();
        }
    acase SPELL_BP:
        if
        (   room is 1
         or room is 2
         or room is 34
         or room is 64
         or room is 73
         or room is 80
         or room is 92
         or room is 138
         or room is 139
         or room is 141
         or room is 148
        )
        {   fulleffect();
        } elif
        (   room is 14
         or room is 37
         or room is 104
        )
        {   aprintf("#14. During the combat turn you spend casting this spell, your opponent(s) get 1 free attack against you (unless you have a companion who is fighting for you both).\n");
            evil_freeattack();
            fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_IF:
        if
        (   room is 1
         or room is 19
         or room is 44
         or room is 69
         or room is 108
         or room is 158
        )
        {   living = TRUE; // for DD158
            fulleffect();
        } elif
        (   room is 2
         or room is 14
         or room is 15
         or room is 34
         or room is 37
         or room is 56
         or room is 64
         or room is 65
         or room is 73
         or room is 83
         or room is 92
         or room is 103
         or room is 104
         or room is 126
         or room is 132
         or room is 138
         or room is 139
         or room is 141
         or room is 147
         or room is 148
         or room is 153
         or room is 161
         or room is 162
        )
        {   aprintf("#14. During the combat turn you spend casting this spell, your opponent(s) get 1 free attack against you (unless you have a companion who is fighting for you both).\n");
            evil_freeattack();
            fulleffect();
        } elif (room is 76 or room is 165)
        {   room = 33;
        } else
        {   noeffect();
        }
    acase SPELL_WI:
    case SPELL_BG:
        if
        (   room is 1
         or room is 2
         or room is 15
         or room is 64
         or room is 65
         or room is 83
         or room is 92
         or room is 138
         or room is 139
         or room is 148
         or room is 153
         or room is 161
        )
        {   fulleffect();
        } elif (room is 37 or room is 104)
        {   aprintf("#14. During the combat turn you spend casting this spell, your opponent(s) get 1 free attack against you (unless you have a companion who is fighting for you both).\n");
            evil_freeattack();
            fulleffect();
        } else
        {   noeffect();
        }
    acase SPELL_CC:
        if
        (   room is 37
         or room is 64
         or room is 104
        )
        {   aprintf("#13. The spell works if you [can] cast it at the level noted on the matrix. (For instance, \"L8\" means cast the spell, augmented, at Level 8.) [You do not have to be that level character.] If you know the basic spell, and have the IQ and DEX for the augmented level, and sufficient ST to cast the spell at that level, you may cast it.\n");
            leveleffect(8);
        } else
        {   noeffect();
        }
    acase SPELL_DE:
        if (room is 83)
        {   aprintf("#16. The mummy, coins, gems and all sink to the same depth and are now truly entombed together. Leave the room empty-handed - go west to {95} or east to {76}.\n");
            dispose_npcs();
            result = getnumber("1) West\n2) East\nWhich", 1, 2);
            if (result == 1) room = 95; else room = 76;
        } elif (room is 148)
        {   aprintf("#5. [Destroys one totally.]\n");
        } else
        {   noeffect();
        }
    acase SPELL_SF:
        if (room is 14)
        {   maybeeffect(4);
        } elif (room is 19 or room is 126)
        {   powereffect(97);
        } elif
        (   room is 34
         or room is 73
         or room is 103
         or room is 141
        )
        {   maybepowereffect(3, 15);
        } elif (room is 69)
        {   if (spellpower >= 80)
            {   aprintf("#6. Go to {158} and leave.\n");
                room = 158;
        }   }
        elif (room is 76 or room is 165)
        {   room = 33;
        } elif (room is 139)
        {   powereffect(55);
        } else
        {   noeffect();
        }
    acase SPELL_MI:
        if
        (   room is 37
         or room is 64
         or room is 104
        )
        {   aprintf("#13. The spell works if you [can] cast it at the level noted on the matrix. (For instance, \"L8\" means cast the spell, augmented, at Level 8.) [You do not have to be that level character.] If you know the basic spell, and have the IQ and DEX for the augmented level, and sufficient ST to cast the spell at that level, you may cast it.\n");
            leveleffect(8);
        } elif (room is 42)
        {   aprintf("#13. The spell works if you [can] cast it at the level noted on the matrix. (For instance, \"L8\" means cast the spell, augmented, at Level 8.) [You do not have to be that level character.] If you know the basic spell, and have the IQ and DEX for the augmented level, and sufficient ST to cast the spell at that level, you may cast it.\n");
            leveleffect(6);
        } elif (room is 138 or room is 148)
        {   aprintf("#13. The spell works if you [can] cast it at the level noted on the matrix. (For instance, \"L8\" means cast the spell, augmented, at Level 8.) [You do not have to be that level character.] If you know the basic spell, and have the IQ and DEX for the augmented level, and sufficient ST to cast the spell at that level, you may cast it.\n");
            leveleffect(15);
        } else
        {   noeffect();
        }
    acase SPELL_RS:
        if (room is 2 or room is 14)
        {   halfeffect();
        } elif
        (   room is 15
         or room is 34
         or room is 37
         or room is 42
         or room is 56
         or room is 64
         or room is 73
         or room is 92
         or room is 103
         or room is 104
         or room is 108
         or room is 138
         or room is 139
         or room is 141
         or room is 148
        )
        {   fulleffect();
        } elif
        (   room is 19
         or room is 126
         or room is 147
         or room is 162
        )
        {   doubleeffect();
        } elif (room is 76 or room is 165)
        {   room = 33;
        } elif (room is 83)
        {   room = 161;
        } elif (room is 153)
        {   maybeeffect(4);
        } else
        {   noeffect();
        }
    acase SPELL_EH:
        if
        (   room is 2
         or room is 19
         or room is 69
         or room is 126
        )
        {   halfeffect();
        } elif
        (   room is 14
         or room is 15
         or room is 37
         or room is 56
         or room is 64
         or room is 65
         or room is 83
         or room is 92
         or room is 108
         or room is 138
         or room is 139
         or room is 148
        )
        {   fulleffect();
        } elif
        (   room is 34
         or room is 73
         or room is 103
         or room is 141
        )
        {   maybeeffect(2);
        } elif (room is 76 or room is 165)
        {   room = 33;
        } elif
        (   room is 147
         or room is 161
         or room is 162
        )
        {   aprintf("#1. This makes his form more dense, and raises his dice to 18. His CON is now 150.\n");
            npc[0].dice = 18;
            npc[0].con = 150;
        } elif (room is 153 or room is 158)
        {   maybeeffect(4);
        } else
        {   noeffect();
        }
    acase SPELL_MF:
        if (room is 1)
        {   room = 93;
        } elif (room is 17)
        {   aprintf("#4. You can only get one of the two boxes in this fashion. Choose which box you're trying for, and go to the appropriate paragraph noted in {17}. If two wizards cast spells to reach both boxes, go to {31}.\n");
            result = getnumber("1) Gold box\n2) Silver box\nWhich", 1, 2);
            if (result == 1) room = 86; else room = 133;
        } elif
        (   room is 34
         or room is 50
         or room is 53
         or room is 73
         or room is 80
         or room is 103
         or room is 110
         or room is 135
         or room is 158
        )
        {   fulleffect();
        } elif (room is 37)
        {   room = 50;
        } elif (room is 42 or room is 104)
        {   aprintf("#11. You need not make the indicated saving rolls to pass safely through the situation.\n");
            living = TRUE;
        } elif (room is 92)
        {   room = 131;
        } elif (room is 156)
        {   aprintf("#12. You'll still need to make the saving roll noted at {156}. If you make it, go to {7}. Otherwise, you perish.\n");
            savedrooms(2, iq, 7, -1);
        } else
        {   noeffect();
        }
    acase SPELL_WG:
        if
        (   room is 3
         or room is 41
         or room is 68
         or room is 134
        )
        {   maybeeffect(2);
        } elif (room is 17)
        {   aprintf("#4. You can only get one of the two boxes in this fashion. Choose which box you're trying for, and go to the appropriate paragraph noted in {17}. If two wizards cast spells to reach both boxes, go to {31}.\n");
            result = getnumber("1) Gold box\n2) Silver box\nWhich", 1, 2);
            if (result == 1) room = 86; else room = 133;
        } elif
        (   room is 19
         or room is 53
         or room is 103
         or room is 110
         or room is 135
         or room is 158
        )
        {   fulleffect();
        } elif (room is 37)
        {   room = 50;
        } elif (room is 42 or room is 104)
        {   aprintf("#11. You need not make the indicated saving rolls to pass safely through the situation.\n");
            living = TRUE;
        } elif (room is 50 or room is 80)
        {   aprintf("#20. It will take two Wink-Wings to cover the distance safely, without saving rolls. [If you can only cast 1 and must climb the rest of the way, subtract 1 from the level of the SR required to negotiate the slope, to account for travelling the remaining distance. If you rest to regain your ST before casting the second spell, you must roll for a WM each turn you rest.]\n");
            if (cast(SPELL_WG, FALSE))
            {   if (room == 50) room = 9; else room = 106;
        }   }
        elif (room is 92)
        {   room = 131;
        } else
        {   noeffect();
        }
    acase SPELL_SG:
        if
        (   room is 3
         or room is 41
         or room is 68
         or room is 134
        )
        {   if (dice(1) <= 2)
            {   aprintf("#18. Halve your opponent's CON or MR.\n"); // %%: what about multiple opponents?
                for (i = 0; i < MAX_MONSTERS; i++)
                {   if (npc[i].mr)
                    {   npc_templose_hp(i, npc[i].mr / 2);
                    } elif (npc[i].con)
                    {   npc_templose_hp(i, npc[i].con / 2);
        }   }   }   }
        elif
        (   room is 15
         or room is 83
         or room is 138
         or room is 161
        )
        {   aprintf("#17. No effect on your opponent. You must make a L1-SR on Luck (20 - LK) to avoid breathing it yourself because you're in an enclosed area. If you miss the roll, roll 2 dice and take that many hits directly against your CON (except from paragraph 138; there you must take the CON damage regardless of SR).\n");
            if (room == 138 || !saved(1, lk))
            {   templose_con(dice(2));
        }   }
        elif (room is 76 or room is 165)
        {   room = 33;
        } else
        {   noeffect();
        }
    acase SPELL_WL:
        if (room is 2)
        {   aprintf("#17. No effect on your opponent. You must make a L1-SR on Luck (20 - LK) to avoid breathing it yourself because you're in an enclosed area. If you miss the roll, roll 2 dice and take that many hits directly against your CON (except from paragraph 138; there you must take the CON damage regardless of SR).\n");
            if (room == 138 || !saved(1, lk))
            {   templose_con(dice(2));
        }   }
        elif
        (   room is 3
         or room is 41
         or room is 68
         or room is 134
        )
        {   if (dice(1) <= 2)
            {   room = 145;
        }   }
        elif (room is 14)
        {   maybeeffect(5); // %%: maybe we should reduce our own IQ to 3, if it fails
        } elif (room is 15)
        {   fulleffect();
        } elif (room is 69)
        {   aprintf("#6. Go to {158} and leave.\n");
            room = 158;
        } elif (room is 76 or room is 165)
        {   room = 33;
        } elif (room is 153)
        {   maybeeffect(2); // %%: maybe we should reduce our own IQ to 3, if it fails
        } else
        {   noeffect(); // %%: maybe we should reduce our own IQ to 3
        }
    acase SPELL_DD:
        if
        (   room is 1
         or room is 2
         or room is 5
         or room is 15
         or room is 19
         or room is 28
         or room is 34
         or room is 37
         or room is 42
         or room is 44
         or room is 56
         or room is 61
         or room is 64
         or room is 65
         or room is 69
         or room is 73
         or room is 83
         or room is 92
         or room is 103
         or room is 104
         or room is 108
         or room is 126
         or room is 132
         or room is 138
         or room is 139
         or room is 141
         or room is 147
         or room is 148
         or room is 153
         or room is 155
         or room is 156
         or room is 158
         or room is 161
         or room is 162
        )
        {   fulleffect();
            living = TRUE; // for DD155/156
        } elif
        (   room is 3
         or room is 41
         or room is 68
         or room is 134
        )
        {   maybeeffect(2);
        } elif (room is 14)
        {   aprintf("#14. During the combat turn you spend casting this spell, your opponent(s) get 1 free attack against you (unless you have a companion who is fighting for you both).\n");
            evil_freeattack();
            fulleffect();
        } elif (room is 76 or room is 165)
        {   room = 33;
        } else
        {   noeffect();
        }
    acase SPELL_PP:
        if (room is 2)
        {   aprintf("#9. The spell cannot be cast around the person being held. Otherwise, it works normally.\n");
        } elif
        (   room is 3
         or room is 41
         or room is 68
         or room is 134
        )
        {   maybeeffect(2);
        } elif
        (   room is 5
         or room is 19
         or room is 28
         or room is 34
         or room is 37
         or room is 56
         or room is 61
         or room is 64
         or room is 73
         or room is 108
         or room is 126
         or room is 132
         or room is 138
         or room is 139
         or room is 141
         or room is 148
         or room is 155
        )
        {   fulleffect();
        } elif (room is 59)
        {   aprintf("#8. Roll 1d6. This is how many turns the \"oven timer\" is set for. If you must (or can) keep recasting it, go ahead. If you're not bubbling nicely when the time expires, you can escape.\n");
            oventimer = dice(1) * 10;
            elapse(oventimer <= 20 ? oventimer : 20, TRUE);
            if (oventimer <= 20)
            {   living = TRUE;
            } elif (cast(SPELL_PP, FALSE))
            {   elapse(oventimer <= 40 ? oventimer - 20 : 20, TRUE);
                if (oventimer <= 40)
                {   living = TRUE;
                } elif (cast(SPELL_PP, FALSE))
                {   elapse(oventimer - 40, TRUE);
                    living = TRUE;
        }   }   }
        elif (room is 65 or room is 69)
        {   aprintf("#6. Go to {158} and leave.\n");
            room = 158;
        } elif (room is 76 or room is 165)
        {   room = 33;
        } else
        {   noeffect();
        }
    acase SPELL_UP:
        if (room is 17)
        {   aprintf("#4. You can only get one of the two boxes in this fashion. Choose which box you're trying for, and go to the appropriate paragraph noted in {17}. If two wizards cast spells to reach both boxes, go to {31}.\n");
            result = getnumber("1) Gold box\n2) Silver box\nWhich", 1, 2);
            if (result == 1) room = 86; else room = 133;
        } elif
        (   room is 50
         or room is 53
         or room is 80
         or room is 135
         or room is 158
        )
        {   fulleffect();
        } elif (room is 104)
        {   aprintf("#15. You can bring an unconscious character up the slope through use of this spell, if you can cast it for 2 consecutive turns. You must roll for a Wandering Monster if you rest between castings to regain your Strength.\n");
            // Not implemented, as it is multiplayer-only.
        } else
        {   noeffect();
    }   }

    inmatrix = FALSE;
}
