/* Ambiguities (%%):
 CT90: "His combat adds are 27..." Does this include the 5 adds from his sax?
  And similarly with CT92. We are assuming no.
 CTp96: Falchion (4-4), madu (1-3), war hammer (5-1)
  are presumably misprints for 4+4, 1+3, 5+1 (corresponding to RB).
 CT211: It is ambiguous what should happen to female characters in the
  Corgi version. The censorship has been botched. We are interpreting
  the line "The female slaves are led away" as "The other female slaves are
  led away", and note what the dT&T edition says on p. "i": "Girl-girl...
  are equally possible erotic adventures."

Errata (FB and Corgi editions):
 CT0: "go to 4D/11" should be "go to 4E/12".
 CT76: "In the Flying Buffalo edition, paragraph 18F says "go to 25C".
  That should be "go to 26C". If you have the pocket edition printed by
  Corgi in the UK, paragraph 76 says "go to 98" and it should say "go to
  102". (The English editors just copied the US typo!)"
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

MODULE const STRPTR ct_desc[CT_ROOMS] = {
{ // 0
"INTRODUCTION\n" \
"`  Welcome to the City of Terrors. This is the first open-air solitaire adventure. It is set in the City of Gull on the sun-baked tropical island of Phoron. You come by ship, disembark, and are taken by carriage to the hotel.\n" \
"  You take a room and tip the clerk 20 gp to make sure that your things don't get ripped off. Between adventures, you may drop stuff off in your room, change your clothing, or exchange your weapons.\n" \
"  Any humanoid creature, be it orc, ogre, or elf may journey here. If you happen to be a man-tiger (courtesy of the justifiably infamous Deathtrap Equalizer dungeon), you will find what you are looking for to the east of the hotel.\n" \
"  Magic may be used, but only in the very limited way it is allowed here. If I don't specifically say you can use it, you can't. There are job openings in Gull - if you sign on, follow the directions at your place of employment.\n" \
"  This adventure was designed with the well-rounded, mid-level character in mind. However, at times, a first-leveller will win out where a superhero loses. Keep this in mind. If you are killed as the result of missing a saving roll, you may go to {12} and get another chance at life. If you forget to go there - and you are not reminded inside - then you die.]\n" \
"  At times your rewards will be in technologically advanced or magical devices. If you recover any of these, they are worth 1000 experience points (ap)[ when you leave the adventure].\n" \
"  Whenever you come to an intersection, you must roll up a Wandering Person (WP) and figure out what happens to you. The WPs are listed at the back of the book. It is worth your while to read through that section before beginning.\n" \
"  There are a couple of places where you can leave the dungeon without returning to your hotel, if you do so, you forfeit all the equipment, treasure, and what have you which you left behind in your hotel room.\n" \
"  Saving rolls are made on all attributes at one point or another. Unless specified, all saving rolls will be made on Luck, and they are to be made at the character's own level.\n" \
"  You will need dice, the rules to Tunnels and Trolls, and maybe a deck of cards. Paper and pencil are vital as well.\n~" \
"  Good luck. Be wary. The City of Terrors can live up to its name. Keep your weapon handy, a hand on your money belt, and go to {115} to begin.`\n" \
"SPECIAL NOTE\n" \
"  At the back of this adventure are the Wandering People (see page 95).[ You may wish to keep track of the points the Wandering People amass, and as they get enough ap, they too will advance. In this manner, the dungeon will get tougher as you go along. You can use the Peters-McAllister chart in the T&T Rule Book p. 58 to create more wanderers.]~"
},
{ // 1/1A
"As you walk down this road into the alley, you hear someone hail you. You look up and see a man walking towards you.\n" \
"  Do you approach him: {31}; ignore him: {142}; or attack him: {52}?"
},
{ // 2/1B
"Before you looms a dark building. You can see that the building is very old, and the type of construction is unlike any you have seen before. The door in front of you is open.\n" \
"  If you are a rogue, go to {43}. You may call it a night, {144}, or you may enter by {208} if you are not a rogue."
},
{ // 3/1C
// %%: it says "17th level" but it is a 20th level spell!
#ifdef CENSORED
"As you approach her, you see that her mouth is open, and you notice that her canine teeth are very long. Before you can scream, she sinks her teeth into you. She drinks of your blood for a moment before you stop panicking.\n" \
"  You throw her off and run from the castle, yet her voice is ringing in your ears.\n" \
"  \"You have been bitten. There are two ways you can be cured. Find a 20th level wizard and have him cast a Born Again spell on you. The only other way to escape the curse is to kill every single vampire you encounter from this day forward.[ If one escapes, you will be cursed to forever be a vampire yourself.]\n" \
"  \"You don't have to run...you can come back...\"\n" \
"  You keep running, and go to {115}."
#else
"You find she is an amorous lover. It is one of your greatest experiences. As you lay panting, she advances again.\n" \
"  Her mouth is open, and you notice that her canine teeth are very long. Before you can scream, she sinks her teeth into you. She drinks of your blood for a moment before you stop panicking.\n" \
"  You throw her off and run from the castle, yet her voice is ringing in your ears.\n" \
"  \"My love, you have been bitten. There are two ways you can be cured. Find a 20th level wizard and have him cast a Born Again spell on you. The only other way to escape the curse is to kill every single vampire you encounter from this day forward.[ If one escapes, you will be cursed to forever be a vampire yourself.]\n" \
"  \"You don't have to run...you can come back...\"\n" \
"  You keep running, and go to {115}."
#endif
},
{ // 4/1D
"Two hundred yards from the gate you see a trench with steps leading down into it. The mage directs you to it. As you walk towards it, you feel fierce cold for the first hundred yards. If it were not for the sun, you would think you were in the middle of a blizzard.\n" \
"  The second hundred yards, it seems to you, is in the middle of some blazing hot desert. The heat feels like it is 150°F in the shade. The heat stops at the steps.\n" \
"  The mage, Biorom, is in the room you find at the bottom of the stairs. \"You are my slaves,\" he says. \"To escape from here, you must defeat me or run out the gate.\"\n" \
"  To fight him, go to {85}. To say nothing and stay where you are, go to {180}. To run out the gate, go to {149}."
},
{ // 5/1E
"You have climbed into a balcony that overlooks the large meeting hall in the building. Directly beneath you is the orc leader. \"Tonight we will attack the town and raze it!\" he cries. This suggestion seems to meet with the general approval of the thousand orcs gathered there.\n" \
"  Being the brave, heroic person you are, you leap from the balcony and slay the orc leader. You look up and see one thousand orcs glaring at you.\n" \
"  If you are an orc, go to {220}. If you are anything else, you may try to fight your way out of here by going to {210}, or you can commit suicide so you won't be tortured by the advancing orcs, {153}."
},
{ // 6/2A
"From their bodies you get a pouch of stuff they put into your drink. You recognize it as Wombat Venom.[ You know that when a weapon is coated with it, it will immobilize a man-sized foe for one combat turn if you can get five hits on him. He will stay immobilized for that combat turn (in which you got the five hits on him) and also for one additional combat turn for every two hits over and above the original five.]\n" \
"  Go to {115}."
},
{ // 7/2B
"Roll two dice. This number will tell you the change made in you by the operation. This change is permanent unless you can get a Curses Foiled spell cast upon you (L9 magic).\n" \
"  (2) A prehensile tail is added to your body.[ It is capable of grasping like a monkey's tail. It can hold up to a two-die weapon, and you can get three dice worth of striking or strangling from it.]\n" \
"  (3) The auditory system of a bat is given to you.[ You can hear a monster breathing through up to a foot of solid oak door. You can also understand and communicate with bats, though not necessarily with vampires.]\n" \
"  (4) The olfactory nerves of a dog are added to you.[ You can smell any monster and tell what type it is from a hundred yards off.]\n" \
"  (5) You now have gills. You can go underwater and breathe.[ However, you need to bathe in water once an hour (every 6 turns). If you don't, you get two hours (12 turns) to live. In that time, you must operate at half strength.]\n" \
"  (6) Your brain is now in the body of a giant spider. [Each leg is worth one die in combat, and the web acts like a bola. ]CHR is cut to one.\n" \
"  (7) Your right arm, from the wrist down, is a giant lobster claw: [It can't hold any weapon, but it is worth three dice in combat. ]CHR becomes 3.\n" \
"  (8) Half of your brain is replaced with that of an ape.[ In combat, on a roll of 2, 3, 11, or 12 on two dice, you will go berserk and cannot stop fighting until subdued (CON reduced to 3 or less).]\n" \
"  (9) Biorom added two tentacles to your body. They are 10' long and join your body below the arms.[ They are worth two dice in combat, or they can hold two-die weapons. The suckers permit you to climb smooth, sheer walls.]\n" \
"  (10) The eyes in your head are now those of a tiger. You can see clearly in the dark for up to 50' without light.\n" \
"  (11) Your hands have been taken and replaced by two claws taken from a giant bird. [There are four talons, and you find you can grasp up to a 3-die weapon with them. The talons are themselves worth one die each in combat (total of 8 dice). ]CHR is reduced to 3.\n" \
"  (12) You have been given wings.[ They are large enough (wingspan of 14') to lift you and equipment equal to your weight.]\n" \
"  Biorom watches you and records your reactions and adjustments to the surgery. When he is through with you, you are free to go. You get 1000 ap and free passage to {115}."
},
{ // 8/4A
#ifdef CENSORED
"She tells you she is Madame Chayalla. She says she does not like intruders; she usually deals with them ruthlessly.\n" \
"  However, she thinks you are cute (if your CHR is less than 8, you can rightfully assume she's going blind), and she will give you a chance to save yourself. Behind her are two doors. Choose one.\n" \
"  If you go to the left, go to {198}. If you want to go to the right, go to {51}."
#else
"She tells you she is Madame Chayalla. She says she does not like intruders; she usually deals with them ruthlessly.\n" \
"  However, she thinks you are cute (if your CHR is less than 8, you can rightfully assume she's going blind), and she will give you a chance to save yourself. Behind her are two doors. Choose one.\n" \
"  If you go to the left, go to {198}. If you want to go to the right, go to {51}. If you want to make love to her, go to {233}."
#endif
},
{ // 9/4B
"Ralf falls over dead. You're quite good with that magic stuff. Defeating Ralf is worth 50 ap. If you wish to advance into the cave, you may go to {158}. If you don't want to go into the cave, go to {97}."
},
{ // 10/4C
"Poor move. These men are from the Anti-Slavery League. With a deft movement, they toss a rope around the highest branch of the nearest tree and fasten the other end to your neck.\n" \
"  Make a L4-SR on LK (35 - LK). If you miss, they hang you. Your charges of late laugh as the rope is pulled tight. If you make the roll, someone remembers that the Marshalls of Gull have recently been getting picky about such summary justice. Despite some grumbling, you are bustled back into town under heavy guard and slapped in chains in the hold of a ship bound for Khazan where you will be sentenced to the Royal Khazan Gauntlet of Criminal Retribution and Rehabilitation, better known as the Naked Doom dungeon. Follow the instructions given in the prologue of that dungeon. If you haven't got Naked Doom (also published by Corgi Books), then they'll string you up themselves.\n" \
"  If you made the saving roll at 6th level, they hauled you up, but you should go to {213}."
},
{ // 11/4D
"This is the home of Scycor the Healer. One of Scycor's aides comes to you and decides if you need to be seen right away. If you have lost a hand in this trip, go to {163}. Any other problems and/or injuries will be seen to in the Clinic; go to {64}. If you have no need for Healer's services at this time, go to {185}."
},
{ // 12/4E
"As you feel yourself slipping into the numbness of death, you hear a loud snap. Before your eyes, a bright light flashes. You are engulfed by a mist that slowly dissolves.\n" \
"  You find yourself in a large room. It is totally constructed of white marble that is flecked and streaked with grey and black. The marble is polished so finely that it is almost like a mirror. The whole sight is awesome.\n" \
"  The ceiling is upheld by four pillars that are marble pyramids. You are in the centre of these four pyramids. You look up and see a human form seated in a marble throne in front of you.\n" \
"  The figure speaks: \"I am Cronus, the Steward of Time. You have been plucked from your death-moment because you did not have a chance to influence your end. Had you died in combat, you would now be dead, but since an unfortunate turn of events led to your downfall, you are here.\n" \
"  \"I have decided to give you one chance to live. You must defeat a Champion of Time. You have your choice of Past, Present, or Future.\"\n" \
"  As he says this, three of the pyramids open to reveal dark and misty interiors. To fight in the Past, go to {214}. To fight the Future, go to {128}. To fight the Present, go to {181}. To attack Cronus, go to {117}. To refuse his boon and die, go to {94}."
},
{ // 13/4F
"Thinking quickly, you take the rope and fasten it to the table. You toss it out the window and proceed to climb down. You find yourself 20' short of the ground when you get to the end of the rope, however. If you can use 11th level magic or higher, go to {137}.\n" \
"  If you are not an 11th level magician or better, you'll have to drop the last 20'. Make a saving roll at your level on your LK. If you miss it, take the number you missed it by in hits. If you make the roll, you take the fall and escape unharmed. This experience is worth 500 ap for you; go now to {115}."
},
{ // 14/5A
"He continues to laugh as he dodges and casts a Witless spell on you. As you stare stupidly at him, you realize his attributes are these: ST 22, IQ 16, LK 32, CON 11, DEX 15, and CHR 10. He has combat adds of 33 and fights with a bec-de-corbin (6 dice).\n" \
"  If you kill him, go to {89}."
},
{ // 15/5B
"Write down the amount of your bet. The man you are arm-wrestling is named d'Icsta. His attributes are: ST 25, IQ 20, LK 22, CON 40, DEX 20, and CHR 10. Combat adds of 31 make him a tough opponent.\n" \
"  To wrestle him, you must treat it as if you were fighting him barehanded, ie. you get only 2 dice plus your adds, and he gets 2 dice and his adds. Your loser level is half your current CON, and d'Icsta's loser level is 20. Hits taken in wrestling do not come off your CON, as it is only a measure of your endurance in this case.\n" \
"  If you lose, compute the consequences, and then you may return to {109}. If you win go to {101}."
},
{ // 16/5C
"The archers are appalled that you, a bow bearer, would break into a house. They take your bow and break it. Then they break your hands so that you can never hold any bow again. Roll one die and take that many hits to both your CON and DEX. They throw you out into the street. Go to {125}."
},
{ // 17/5D
"Leave the card in the adventure at {63}. You will handle the operations for Biorom. For each successful operation, you may add one to either your IQ or your DEX. After five successful operations, you may leave, if you want to do so, and go to the city square at {115}.\n" \
"  If any operation fails, you have the choice of having an operation yourself or running for the gate. If you want an operation, go to {63} and follow the instructions there. If you wish to run, go to {149} and follow those instructions. If you want to back out of your deal with Biorom, tell him so and go to {85}."
},
{ // 18/5E
"The sword you have in your hand is a vampire sword.[ It drains CON points from the people you are fighting. It takes one CON point per combat turn after you first draw blood (if the creature or being you are fighting has a Monster Rating instead of attributes, it steals five MR points per combat turn).\n" \
"  The sword drains these points even if you become wounded. But if you are wounded, it drains them from you as well (but only while you are actually fighting) until you can get cured. A Restoration spell or magical herbs in a poultice should do the trick. Scycor can cure you in this adventure.]\n" \
"  There are five 40 MR guards between you and freedom: two come in the first wave, you meet one in the hall outside this room, and then you have to battle two more to get out of the gate.\n" \
"  If you can get through the gate, you are free. Go to {115}."
},
{ // 19/6A
"There may be as many as six other people besides yourself in on the poker game. Decide how many people you want playing, and deal out that number of hands. Look only at your own hand and bet. All the rest of the players will bet as much as you do. After betting, look at all the hands, and the winning poker hand wins the pot. [You might like to make the WPs the other players at the table for the sake of realism. ]If your hand wins, multiply the bet you made by the number of hands which were dealt out. You have won that much money. Play as long as you want and leave when you wish. Go then to {33}."
},
{ // 20/6B
"A kindly little old man leads you to the target range. There he teaches you the proper way to use a bow. You learn quickly and he is very happy. [Because of his instructions, you will always hit a target at pointblank range. You will always have, at the worst, a 1-4 roll to hit something at near range, regardless of your, DEX. ]You thank your host and he leads you to the door. Go to {125}."
},
{ // 21/6C
"As you turn to run, you run into an ogre. His name is Ralf. You twist away from him and prepare to attack. If you wish to fight him with magic, go to {145}. If you wish to fight him with regular weapons, go to {126}."
},
{ // 22/6D
"At the bar are two orcs. They have had a few, and they are making comments about you. They say that tracing your genealogy would doubtlessly lead you to a kennel.\n" \
"  If you would like to fight them, go to {203}. If you wish to hit them with a Panic spell, go to {70}. If you wish to ignore them and finish your drink, go to {60}."
},
{ // 23/6E
"You get 68 ap for this battle. You also get to take the three gems that are set in his belt buckle. Use the Treasure Generator to determine the value of the gems. You may keep any weapon you picked up in this fight as well. Go to {189}."
},
{ // 24/7A
"If the spell you wrote down was not ESP or Omnipotent Eye, it did not take effect. Return to {152}. If you wrote down one of those spells, go to {84}."
},
{ // 25/7B
"The gods are appalled by your lack of courage, guts, and adventurer's spirit. Halve your CHR while you are in this adventure. [Moreover, make that change forever if you refuse another combat or challenge situation! ]Return to {59} and proceed."
},
{ // 26/7C
"\"Murderer!\" cries the girl. The Sheik's guards come in and cut you down. You fall face to face with the Sheik's brother. You both glare at each other and try to look brave as life ebbs from your bodies."
},
{ // 27/7D
"You don't look too bright to him. He does not want to hand you a complex weapon for fear that you will kill yourself with it by accident. However, he takes from you your most valuable piece of treasure. He puts it into a machine which makes 2 dice worth of exact copies of the item. Any magic will not be copied, but the material value of the items is still there, and they will still be accepted as legal tender anywhere.\n" \
"  Continuing on your way to the Master Rogue's house, you go to {44}. You may, if you wish, return to the city square by going to {115}."
},
{ // 28/7E
"Since you are not a warrior, this gem does you no good. However, it does show you that greed at odd times can lead to an early demise. You will be happy to know that the gem released a demon that killed the man who slew you."
},
{ // 29/8A
"You are smart enough to realize that the hot and cold cones are set up to kill people trying to escape. The hot zone will make you sweat, and the cold zone will then freeze you to death. You grab a blanket and begin to run.\n" \
"  Make a 2nd level saving roll on your DEX (25 - DEX). If you make it, you get out the gate to freedom. Go to {115}, taking 100 ap.\n" \
"  If you missed the saving roll, it means you slipped in the cold zone. You froze before you could regain your feet. The trap has served its purpose - you didn't escape Biorom."
},
{ // 30/8B
"[You stay at {67} and fight any character that comes along. If you defeat him (i.e., reduce his CON to 3 or less), he is made a slave of yours. You get all of his weapons and treasure as well as 250 ap for selling him into slavery (that character should follow the directions for someone made a slave). When you tire of this game, ]go to {115}.[\n" \
"  If you do not sell out immediately, you may save up to five slaves and go on a slave caravan. If you would like to do this, go to {40} when you have five slaves.]"
},
{ // 31/8C
"You should know that Gull is not a place to trust strangers. This is Barth Bladehand. He is a two-time loser thief who had both hands cut off. He has had them replaced with razor-sharp knives that look like hands.\n" \
"  As he draws close to you, he extends a hand as if he wants to shake hands with you. You extend your hand, and he steps inside your guard and stabs you in the stomach. Take three dice worth of damage.\n" \
"  If you still survive, go to {52} and ignore the first paragraph."
},
{ // 32/8D
"You come to a large room in the cave. In a black marble chair is a man-like creature. He is covered with short black fur and is very well muscled. He has claws and fangs.\n" \
"  \"You come without fear,\" he notes. \"I admire that. [For that reason I'll allow you to select the weapons we will use to fight to the death.\"\n" \
"  He shows you a large armoury. You may choose any weapon in the rules, and you will both use the same kind of weapon to fight with. Make your choice, ]go to {188}[, and ignore the note about the Stalker's weapons]."
},
{ // 33/9A
"If you lost cash tonight at the games, go directly to {109}.\n" \
"  If you were a winner, you feel rough hands upon you the moment you step from the tavern. Suddenly your head feels like it is going to explode and coloured lights dance before your eyes. As you lapse into unconsciousness, you hear one of your attackers speak: \"Well, Marek, we did very well this evening.\"\n" \
"  When you awaken later, you remember that Marek is the name of the Master Rogue in the city. If you would like to get directions to his place, go to {86}. If you want to play it safe and return to the tavern, go to {156}."
},
{ // 34/9B
"They each have a MR of 20. If you can't kill them with magic, finish them off with a weapon. If you kill them, you note that there is a door out of this place just behind them. If you want to go through the door, go to {159}. You hear more people coming, so you can grab the pouch with 250 gp from the little skinny one and split on down the corridor the way they came to {115}."
},
{ // 35/9C
"You saw that spell coming. You were smart enough to cast a Hidey Soul into a bird which you sensed above you. This bird leaves the adventure. You may enter another body if you can find one in your travels. You will retain your ap, IQ, and your knowledge of magic, but you will have to use the attributes of that body otherwise. Good luck!"
},
{ // 36/9D
"Doubtlessly you advance carefully, but you don't see the hole in the floor. Suddenly you find yourself falling. With a splash, you land in an underground branch of the Cial River. You are washed out to sea and picked up by a slave galley. There you will spend the rest of your days unless you have 100 gp on you with which to buy your freedom.\n" \
"  If you have the money, go to {115}. If not, you will learn to enjoy rowing eventually. It isn't that tough, but it is hell when the captain wants to water ski..."
},
{ // 37/9E
"Scycor says, \"I have no human hands to put on your wrist. None would work anyway, since the damage to that limb is so extensive. However, I will graft on you a gremlin's fist.\"\n" \
"  When you awaken from the anaesthesia, you find a three-fingered claw at the end of your wrist. You flex it and find that it has much of the power that your old hand had.[ It also has three long talons that can be sheathed like a cat's claws, and they make the hand worth three dice in a bare-handed fight.]\n" \
"  \"The operation was a success, my son,\" says Scycor. He opens a back door and points out a path to you. \"That way will lead you to the Sheik's tent. There you may exact your revenge.\" Go to {131}."
},
{ // 38/10A
"This guy's idea is to put two scorpions on the table right where the wrist of the loser would touch. You know that the sting of a scorpion would take three points off your CON and halve your ST while you were in this adventure, unless you could get to Scycor the Healer.\n" \
"  People crowd around to watch. Go to {15} and ignore the first sentence."
},
{ // 39/10B
"Make a first level saving roll on your CHR (20 - CHR). If you make it, go to {58}. If you don't make it, then go to {110}."
},
{ // 40/10C
"As you are conducting your slaves down the road, you see a group of three men. They stop and ask if you are a slaver. If you say yes, go to {10}. If you say no, go to {134}."
},
{ // 41/10D
"The orc that was looking out from that window sees you. Your hands are engaged in holding you up, and he neatly lops off your head.\n" \
"  If you were still alive, you would note that your body made much the same thud as did the rock from the wall."
},
{ // 42/11A
"Each of them has a Monster Rating of 20 - cannon fodder. If you waste them, you note that there is an open door behind them. It leads to the outside. You pick up a 100 gp gem from the body of the fat one and make your way to {187}."
},
{ // 43/11B
"Being a sneaky rogue, you do not go into the open front door. Instead, you go to the back door and find Marek the Master Rogue there. He looks at you and laughs.\n" \
"  If you wish to attack him, go to {14}. If you wish to speak to him, go to {111}."
},
{ // 44/11C
"By the side of the road you hear something. As you turn to look you see three men. They look as if they are trying to hide from your sight.\n" \
"  If you wish to attack them go to {67}. If you want to talk to them, go to {77}. If you decide to ignore them completely, go to {57}."
},
{ // 45/11D
"You refuse to help someone when they need help!? The gods are dismayed. They cut your DEX in half while you are in this adventure. [The cut will be for good if you refuse any more combat situations! ]Go to {132} and make a choice."
},
{ // 46/11E
"You are conducted into a large amphitheatre. You see the floor is a large net made of stout cord. Beneath the net, about 15' down, are a large number of very sharp, poison-tainted spikes.\n" \
"  From a doorway across from you comes the Netmaster. He is armed with a heavy flail and a sax. His attributes are. ST 25, IQ 20, LK 25, CON 20, DEX 40, and CHR 15. He rolls five dice and has 63 combat adds (including the weapons adds). No poison is allowed.\n" \
"  [If your DEX is 12 or less, he gets double hits on you. If your DEX is from 13 to 29, you get half hits on him (figure your hits and divide by two). If you have a DEX of 30 or more, you fight on even terms.\n" \
"  ]If your DEX is less than 30, you have the option of cutting the net cords. You must have a bladed weapon to do this. If you choose this option, go to {54}.\n" \
"  If you don't or can't take this option, fight him. If you kill him, go to {56}."
},
{ // 47/11F
"You made a mistake in drawing blood on the ogre. The odour of the blood drifts into the cave, and Ralf's twin brother, Flar, comes out and attacks. His attributes are the same as Ralf's[, but he fights as a berserker because you have slain his brother]. He uses the same weapon as Ralf, also.\n" \
"  If you defeat him, you may enter the cave, {158}, or return towards town, {97}."
},
{ // 48/13A
"You and the man in white, Ran, work as a perfect team. He beams you a warning about the sonic sword, and you find an opening in Rinth's, the other man's, defence. With ease, you slip inside his guard and finish him.\n" \
"  Ran claps you on the back and invites you into his spaceship. If you are a magic-user, go to {221}. If you don't want to go into the ship, beg off and go to {121}. You may go with him at {227} if you wish."
},
{ // 49/13B
#ifdef CENSORED
"You note that there is a lamp by her bed, and you are not sure that you would like to look at her before you get any nearer.\n" \
"  To look upon her by lighting the lamp, go to {127}. If you wish to leave her, despite the fact that she calls for you, go to {65}."
#else
"She is fabulous! She requires, however, that you do not look upon her. You note, however, that there is a lamp by her bed, and you are not sure that you would like to look upon such a fantastic lover.\n" \
"  To look upon her by lighting the lamp, go to {127}. If you wish to leave her, despite the fact that she calls for more, go to {65}."
#endif
},
{ // 50/13C
"Not making a saving roll was what the man at the mouth of the cave did. As a result, he walked into an ambush, just as you have done.\n" \
"  The Stalker attacks you. He gets 6 dice and 48 combat adds. You don't even clear leather with your weapon, he attacks so fast. If you survive this initial onslaught, battle him. He has a CON of 20. If you win, then go to {228}."
},
{ // 51/13D
"Before you is a tiger with a MR of 100. Behind it is a door through which you see sunlight streaming.\n" \
"  If you are a magic-user and you want to fight with magic or escape the situation via a spell of any sort, write down your spell and go to {148}. If you are a man-tiger (courtesy of the Deathtrap Equalizer Dungeon, also available from Corgi Books) and you kill this tiger, go to {174}. If you are not covered by either of the above options and you kill the tiger, go to {125}."
},
{ // 52/14A
"This is Barth Bladehand. He lost his hands when he was caught stealing; twice he was caught. He has had his hands replaced with specially designed blades that are razor-sharp and shaped like hands.\n" \
"  His attributes are ST 18, IQ 13, LK 12, CON 25, DEX 25, and CHR 8. Each hand is worth three dice, and he has combat adds of 19. When his CON reaches 15, one of his hands is out of commission.\n" \
"  If you wish to use magic to fight him, go to {167}. To kill him with weapons, close and fight. If you kill him, go to {207}."
},
{ // 53/14B
"Brandishing your weapon, you keep the rabble back. You reach down and release the person on the altar. He rises and strangles the high priest.\n" \
"  \"I am Oramusis, the real high priest of the Blue Beetle.\" He points to the Beetle and the dead priest. \"This was a false god and a false priest. This man saved me. For this I give him the Sacred Scarab amulet.\"\n" \
"  Around your neck he attaches a beetle carved from girasol (fire opal). Its colours change from red to a deep purple. Oramusis informs you that this will show that you are a friend of the Blue Beetle God[ and it will allow you to question him once a day on any subject (that means one Dear God question per day, gang)]. He thanks you and you are allowed to leave to {115}."
},
{ // 54/14C
"Make a saving roll at your level on ST. If it is successful, you have cut the cord. From now on, make a saving roll for the Netmaster each combat turn on his LK at third level (30 - LK). If he misses, he falls through and dies on the spikes. You must also make a saving roll on LK at your level to see if you fall through.\n" \
"  Make his saving roll first. Even if he falls, however, you also must make yours to see that you do not fall.\n" \
"  If you missed the original saving roll on ST, return to {46}[ and fight]. If you win by killing the Netmaster yourself or by making him fall through the net, go to {69}."
},
{ // 55/14D
"This was not one of your better ideas. The torch makes you a sitting duck for the Sheik's archers. You feel one arrow glance off your shoulder, drawing a little blood, and you realize your mistake. You toss the torch aside and begin to run. If you run towards them, then go to {205}. If you return to the wilderness, go to {182}."
},
{ // 56/15A
"Good job! You get the gem. [The barker asks you if you would like to become the new Netmaster. You will get 250 gp for each man you defeat as the Netmaster. To do this, place this player's card at {46} and use his attributes and weapons until he wishes to quit or is killed.\n" \
"  You may stay or leave now. If you decide to leave, ]go to {129}."
},
{ // 57/15B
"Never ignore slavers. They capture you, strip you of your weapons and treasure, and put you in chains. Make a saving roll at your own level on CHR. If you make it, go to {164}. If you don't, then go to {106}."
},
{ // 58/15C
"She decides you are too cute to kill right off-hand. She has you sent down to the cells so she can have you at a later time. Go to {216}."
},
{ // 59/15D
"In front of you is a cave. You hear a sound by the entrance and see a man, bloodied and obviously dying. You rush to aid him, but he is sinking fast. All he says is \"Beware the Stalker!\" and then he dies.\n" \
"  If you wish to enter the cave, go to {195}. If you don't want to, go to {25}."
},
{ // 60/15E
"Bad choice. Obviously you did not see the orcs put that mickey in your drink. Halve your current CON and fight them now. They have a combined MR of 80. If you win, go to {6}."
},
{ // 61/15F
"The faithful watch in horror as you hack into the Blue Beetle God. It does not roll on the first combat turn, as you have surprised it. Take your combat roll directly off its MR of 200. If that does not kill it, you must fight it conventionally. If you kill it, go to {53}."
},
{ // 62/16A
"A plaque above the door of this building reads, \"The Archer's Guild\". On the door is the sign of four arrows hitting head on. The building itself is a small two-storey house.\n" \
"  If you would like to enter, go to {120}. To leave this spot; go to {232}. You may sneak around the back and break in if you wish; to do so go to {209}."
},
{ // 63/16B
"This is the lab. Because Biorom did not think you were too terribly smart, you are here to be worked on.\n" \
"  Biorom likes to experiment with animal features on humans. In some experiments, he has bred humans with animals and controlled the mutations. The guards at the doors, the ones with human form and animal attributes, are examples of these experiments. His greatest effort, a man-panther, has escaped and is at large somewhere.\n" \
"  To see if the operation was a success on you, roll two dice. If they come up doubles, it worked, and you should now go to {7}. If they don't come up doubles, you died on the operating table."
},
{ // 64/16C
"You are given a mysterious fluid that pumps your CON to full strength. It also counters any poison in your system. The bill comes to 1000 gp - if you don't have that much with you, he'll bill you later[ (and he has a notorious collection agency; when you finally get 1000 gp, be sure to send it to this man...)].\n" \
"  Go to {185}."
},
{ // 65/16D
"Leaving a woman in need? Ah well, you end up in the Sheik's brother's bedroom. Go to {136}."
},
{ // 66/16E
"He hands you the sonic sword that used to belong to Ran. It gets 3 dice + 5 with no base ST required, making it well suited for hobbit-use. [After two combat turns, it will destroy any armour your foe is wearing. ]If you wish to sell it, you will receive 100 gp.\n" \
"  You may now continue on to the house of the Master Rogue, {2}, or return to the city square, {115}."
},
{ // 67/16F
"These three men are slavers. You immediately recognize them for the loathsome creatures they are. With weapon in hand, you tear into them; they each have a MR of 40.\n"
"  If you kill them, you should roll one die and take 100 times that number in treasure value from them. Take it in [weapons, armour, and/or ]gold. From here you may go to {2} towards the house of the Master Rogue or return to the city square at {115}.[\n" \
"  If the battle goes poorly for you, the slavers will not kill you. Instead, they knock your CON to 3 and take you as a slave. You lose all treasure and weapons you had on you.\n" \
"  If you are made a slave, make a saving roll at your level on CHR. If you make it, go to {164}. If you don't, then go to {106}.]"
},
{ // 68/17A
"The door closes behind you. You find yourself in a corridor that is 100 yards long. In the wall at the far end of the corridor, you see a gem set above the door. As you watch, it begins to glow a deep red and a great lightning bolt suddenly flashes out of it. It takes a huge divot from the wall beside you. You begin to run for the door beneath the gem.\n" \
"  Add your ST and your DEX. Divide this number by 10, and then subtract that number from 10 (rounding fractions down). This number is how many times the gem can sight-in on you. If this number is negative, treat it as zero. Example: the Wandering Person Mingor has a ST of 60, a DEX of 20. 60 + 20 = 80. 80 ÷ 10 = 8. 10 - 8 = 2. Thus, Mingor will only be hit by the lightning bolt twice.\n" \
"  The gem tracks its targets at 10 yards per second (note that Mingor can run at 8 yards per second and, running a zig-zag course, the gem can only sight him twice). For each time the gem sights on you, roll one die and take that many hits against your CON.\n" \
"  If you survive the run through the electric gauntlet, you may exit through the door by going to {78}, or you may try to pry the gem from its socket above the door by going to {82}."
},
{ // 69/17B
"The fans are irate. You didn't fight fairly, they feel. Make an L3-SR on your LK (30 - LK). If you make it, you get out with your skin.\n"
"  If you don't make it, then you got flustered and fell through the net.\n"
"  If perchance you still live, go to {129}."
},
{ // 70/17C
"Each of them has a MR of 40. Ugly they well may be, but they are also tough! If your IQ, LK, and CHR do not total up to more than 80, you had better prepare to defend yourself. If you defeat them in combat, go to {114}.\n" \
"  If your spell did work, however, you have the joy of watching them sail through the bat-wing doors and into the street. You may return do the tavern proper, {109}, or go back to the bar for another drink, {162}."
},
{ // 71/18A
"You grab a weapon and stab upwards. You hear him groan in pain, but you feel his club land against your arm. Pain shoots through your body, and you realize that, although your foe is dead, you are in great danger; the bones in your arm and shoulder are shattered.\n" \
"  Cut weight possible in half. Recalculate how much you are carrying compared with how much you can carry now. If you are carrying too much equipment, treasure, and/or armour, you cannot pull yourself to the top of the ledge. Your fingers on your good hand falter, fail, and you fall onto the spikes below you.\n" \
"  If you can manage to drag yourself up, you find a door on the ledge. Go to {78}."
},
{ // 72/18B
"Roll three dice. If you get a straight (three numbers in sequence, such as 1, 2, 3), you win half again as much as you bet. If you get a pair (such as 2, 2, 3), you double your bet. If you get a triple (such as 5, 5, 5), you get four times your bet.\n" \
"Play as long as you like, and when you are done, go to {33} (remember, though, that money is its own reward. If you win here, you win cash, but not aps)."
},
{ // 73/18C
"The man you choose to arm-wrestle says he would like to make it more interesting. He says he will match any bet you care to make, or he can think of other ways to make the contest exciting. To place a bet, go to {15}. For something more interesting, go to {38}."
},
{ // 74/18D
"As you break the line, a savage scream is heard. You look back and see that one of the guards has leaped off the wall and is coming after you.\n" \
"  As it nears, you get a good look at it. You can see that it has the body of a man with the head and skin of a jackal. Its jaws are open and saliva drips from its fangs.\n" \
"  It has a Monster Rating of 80[, and it is immune to all magic. You are unarmed.] If you can defeat it, go to {115}; you have made good your escape."
},
{ // 75/18E
"Since you are not a magician, this gem does you no good. However, it does show you that greed at odd times can lead to an early demise. You will be happy to know that the gem released a demon that killed the man who had already killed you."
},
{ // 76/18F
"You have to be very lucky. Add 3 to your LK. The light you made temporarily blinded the two orcs who had just entered the room.\n" \
"  You kill one outright. The second (MR 40) recovers and advances on you. If the battle is going badly, you may jump into the hole in the middle of the floor by going to {36} (ignore the first sentence). If you kill the orc, go to {102}." // it says 98 but this is an errata (see http://www.flyingbuffalo.com/errata.htm)
},
{ // 77/19A
"They explain that they are slavers. They think you look reasonably bright, and like one who might go far. They ask you if you would care to become a slaver.\n" \
"  If you would like to, go to {30}. If you wouldn't, go to {226}."
},
{ // 78/19B
"This door opens into a long corridor that leads to a room. You make your way down to its end and find a large room that has a table laden with food. At one end of the table sits Marek the Master Rogue.\n" \
"  \"Few people make it out of those rooms,\" he says to you. \"I have great respect for those who do so. Sit, eat, and I will weave a little spell to repair you.\"\n" \
"  As you eat, he casts a Restoration spell that will restore to you half of any hits you may have taken in this trip through the city of Gull. It will, of course, repair and cure any broken bones, cuts, and the like.\n" \
"  When you are finished, he shows you to the door. He hands you a satchel that contains the winnings that were taken from you earlier. He says that no rogue will bother you again in Gull. Go to {115}."
},
{ // 79/19C
"You are halfway up the wall. Below you two orcs come searching in the darkness for whatever made the noise.\n" \
"  To jump the orcs, go to {87}; to stay right where you are, go to {183}; to continue to climb upwards and towards the window, go to {41}."
},
{ // 80/19D
"D'Icsta was a rogue. From around his neck, you take a charm[ that will dispel any first-level magic cast upon you, and it will also reveal, by looking into it, the location of the person who cast the spell].\n" \
"  You recover, too, a ruby that is worth 1000 gp. You notice as you walk by two orcs at the bar that the gem begins to get warm. You know that it is enchanted[ and will warn when orcs are around by getting warmer].\n" \
"  Go now to {33}."
},
{ // 81/20A
"In the back room, there is a poker game going on. It will cost you 100 gp to get into the game. If you don't have the money, they toss you back into the main room - go to {109}. If you have the cash, put it in the pot and go to {19}."
},
{ // 82/20B
"Trying to pry this gem out of its place in the wall is akin to sticking a fork in an electric socket while sitting in a bathtub full of water. For one second you feel the greatest pain you have ever felt. Then you fall, your hands and feet smoking. You are dead."
},
{ // 83/21A
"You look intelligent enough to understand some of his devices. He takes two wristlets and gives them to you to put on. He tells you that they have two abilities.\n" \
"  The first is shown when you push the little red button that is on each one. A small, yet still very strong, grappling hook is ejected from each bracelet. A strong and thin cord is attached. You can use these hooks and cord to scale cliffs and buildings. Their maximum range is 50'.\n" \
"  [The other ability is to open doors into a fourth dimension. All you need to do is tap them together, and a dimensional warp will surround you. You will not be able to fight anyone, but neither will they be able to reach you. It will simply seem that you disappeared (it is up to the GM you encounter in the future to decide if the fourth dimension is populated). To return to normal space, you need merely hit them together again.\n" \
"  ]From here you may go on your way to the house of the Master Rogue, {44}, or go on to the city square, {115}."
},
{ // 84/21B
"These spells tell you that all the cats are men who have been turned into cats by Madame Chayalla, grand-daughter of Circe. The cats tell you that you are lucky to get out with your skin. They also tell you to choose the right door. Go to {8}."
},
{ // 85/21C
"This is the most stupid move you have made in your short career. This mage, Biorom, is a 17th level wizard, and he tolerates no back-talk, disrespect, or attack from his slaves.\n" \
"  He zaps you with a Hellbomb Bursts and reduces you to a fine white ash (if perchance you are an 18th level wizard or higher yourself, go to {35}!)."
},
{ // 86/21D
"You go back into the tavern and demand directions to the home of the Master Rogue. You have blood in your eye, and they quickly point you in the right direction. You loosen your weapon in its sheath and go to {173}."
},
{ // 87/22A
"Each one has a MR of 40. Your attack from above takes them unawares. You can do one combat turn worth of damage to one of the orcs before they can even roll. After that, you must fight them as usual."
"  More orcs pour out of the building after you kill those two, assuming that you do so. Make a LK saving roll at your level as you run for the road at {187}. If you make the roll, you out-distance them and make it safely to the road. Otherwise, you are dragged back to the orc house and there subjected to the Orc High Torture, which is too horrible to describe here. You do escape the torture eventually - unfortunately, it is only by death."
},
{ // 88/22B
"There will be no better time, for she belatedly detected the charm on you. The guards take it from you and slap you in irons. They lead you to the wall above the gate. There you are drawn and quartered. She has no use for magickers who would seek to destroy her."
},
{ // 89/22C
"An even dozen rogues come out of the house and grab you. They overpower you, force you to the ground, and with a dagger proceed to slice up your face. Halve your CHR and lose any and all treasure you have on you. Also, take one die worth of CON hits. If you had a living diamond hand, you don't any more. They cut it off, killing you. If you survive this ordeal, go to {115}."
},
{ // 90/22D
"His brother uses a scimitar (4 dice) and a sax (2 dice + 5). His combat adds are 27 and his CON is 15. If you lighten the load on his shoulders by knocking his head off, you get 70 ap and the ring for which you were fighting. Roll for its value on the treasure generation table. Then go to {189}."
},
{ // 91/22E
"This one-armed bandit will work only with money of any type, not attributes. [Write down your bet. ]When you are ready, go to {72}."
},
{ // 92/24A
"The door closes behind you and you find yourself floating in midair! \"You are in the Room of No Gravity,\" calls a warrior from across the room. \"This is my element, and I am going to kill you!\"\n" \
"  With that, he launches himself at you and aims a vicious cut at you with his dagger. You manage to twist out of his way. However, you quickly discover that trying to use any weapon larger than a dagger throws you off what little balance you have. Y[ou cast your larger weapon aside and draw your dagger. If you don't have one, then y]ou will find a misericorde - 2 dice and no adds - floating near your hand.\n" \
"  His CON is 25 and he has combat adds of 15. He fights with a sax (2 dice plus 5 adds).[ For each combat turn, you must make a saving roll at your level on your LK. If you miss, halve your attack (combat roll and adds) for that combat turn...you are having trouble because you can't quite get the hang of fighting without gravity, unlike your practised opponent.]\n" \
"  If you kill him, go to {78}."
},
{ // 93/24B
"Make a L2-SR on DEX (25 - DEX). If you make it, go to {206}. If not, go to {184}."
},
{ // 94/24C
"\"So be it!\" cries Cronus. You are put back into the situation you came from and you die. Close the book, turkey."
},
{ // 95/24D
"You take out your weapon and cut the man in white down, or at least you try to. He turns and attacks you. [The sonic sword will shatter any armour you wear in two combat turns. ]This man, Ran, has these attributes: ST 35, IQ 18, LK 20, CON 5, DEX 18, and CHR 15. He is an extraterrestrial criminal who has overpowered his guard - Rinth, the man in black - and he is seeking to escape. He has no armour, and his combat adds are 37. The sonic sword gets 3 dice plus 5 adds. If you defeat him, go to {103}."
},
{ // 96/25A
"You make the jump. Your fingers find the top of the other ledge. You look up and see the club flashing down and in the nick of time you move your hand and prevent it from being smashed.\n"
"  You must now deal with this character on the ledge. If you are a magic-user, rogue, or warrior-wizard, go to {176}. If you are a warrior, go to {71}."
},
{ // 97/25B
"Here a wilderness path cuts the Ranger Road. You may take the path south by going to {108}, or you may take the Ranger Road east to the direction sign at {187}."
},
{ // 98/25C
"The gods were planning to destroy this ship anyway. Admiring your bravery, they rescue you and double your lowest attribute. Also, add 500 ap immediately.\n" \
"  You may be set at the city square, {115}, or whisked along to the house of the Master Rogue, {2}. The choice is yours. In your money belt you find too that the gods have bestowed upon you 1000 gp. With that in mind, go on your way."
},
{ // 99/25D
"Biorom notes that you are an intelligent person. He offers you a chance to become his aide. If you take this offer, go to {17}. If you refuse it, go to {63}."
},
{ // 100/26A
"[You may buy any bow on the weapons list for 5 gp over the regular price. These are hand-crafted bows, and as such are not the cheap ones offered by the merchants. They are so good that you only need roll a 1-5 on one die to hit a target at pointblank range, regardless of your marksmanship rating.\n" \
"  After you have made your purchase, ]proceed to {125}."
},
{ // 101/26B
"Roll two dice. A 2-4 or 10-12 means that d'Icsta accuses you of cheating. He tosses the table aside and draws his weapon. It is a flamberge (6 dice + 1). He has leather armour (6 hits) and combat adds of 31. His CON is 40. If he was stung, you'll notice d'Icsta isn't hurt - do you think he would play a game where he might lose and hurt himself?!\n" \
"  If he doesn't accuse you of cheating, go to {109}. If you defeat him after he accuses you, go to {80}."
},
{ // 102/26C
"This is the treasure room of the orcs. Granted their treasure isn't the greatest, but amid the trinkets you do find some valuable stuff. There is a ring worth 150 gp and a golden buckle worth 200 gp.\n" \
"  Before you can poke around any more, you hear other orcs coming. Being intelligent and brave, you pull yourself out the window and escape to {187}."
},
{ // 103/26D
"The man in black, Rinth, gets up. He explains that Ran was a criminal who had overpowered him, and he is grateful for your help. As a reward, he will give you something. Make a saving roll at your own level on IQ.\n" \
"  If you make it at your level, go to {66}. If you don't make it at all, go to {27}. If you make it one level above yours, go to {83}. If you make it two or more levels higher, go to {178}."
},
{ // 104/27A
"The gods are amazed that a human could be so indifferent. They have other uses for Phoron, however, and will not let it be destroyed. They blast the ship into fragments, you along with it. Your card is to be folded, spindled, and mutilated. Never use this card [or name ]again."
},
{ // 105/27B
"You find nothing of value on the altar. However, your eye catches movement at both doors behind the altar. If you wish to go into the left door, go to {93}. If you want to go into the right-hand door, go to {168}."
},
{ // 106/27C
"The slavers bring you to the place called the Magetower (it is called that because there is a mage who lives in it). He is a strange old bird, they say, who uses people as other experimenters use rats.\n" \
"  The tower is surrounded by a large thick wall. In the wall is a gate, in front of which you are now standing. Upon the wall appear two human-looking guards flanking an old man in a flowing black robe. He tosses a sack of gold to the slavers and they depart.\n" \
"  The doors open slowly and he commands you to enter. To do so go to {4}. If you wish to run, go to {74}."
},
{ // 107/27D
"As you run near her you feel the sliver of wood growing. It becomes a 6' javelin, the runes issuing an unholy black light. The javelin draws your arm back, and from 3' away, you let it fly into her chest.\n" \
"  Blood bubbles up from the wound, and she gnashes her lips into a crimson foam. She screams out in a forgotten tongue and then dies.\n" \
"  All the people in the castle are overjoyed. They had been bitten by her, and with her re-death, they will no longer have to worry about becoming vampires when they die[ (note: her death affects none of the characters that might have been put through this adventure before this magic-user killed her; they will become vampires upon their death if they do not abide by what was said earlier about their salvation)].\n" \
"  You are hailed as a hero. You are presented with a ring[ that reduces the cost of casting spells by two]. They ask you to stay and rule them, but you must decline. As you leave, they give you 1000 gp[ and promise to come to your aid if ever you should need it].\n" \
"  Return to the city square, {115}. If you want to continue your quest for the house of the Master Rogue, go to {2}."
},
{ // 108/27E
"In the distance you see the tent of the Sheik. You walk towards it and are invited in. You enter the tent and see the Sheik sitting in front of a dancing girl. He motions you to join him.\n" \
"  As you are walking towards him a man comes by and bumps you. You feel his hand inside your jerkin going for your money belt.\n" \
"  You may attack him, {197}; you can accuse him of thievery, {190}; or you can simply let it go, {160}."
},
{ // 109/32A
"In front of you is a tavern. The sign above it announces that this is the famed \"Black Dragon Tavern\". When you enter, you see that the \"Black Dragon\" offers to its customers nearly all the various modes of entertainment known to man.\n" \
"  You can play the one-armed bandit in the corner, {91}. You may arm-wrestle with the man on your left, {73}, or play poker with some toughs in the back room, {81}. Of course you can drink, {22}, or leave the tavern and return to the city square, {115}."
},
{ // 110/32B
"She takes a better look at you and decides that she was mistaken in choosing you in the first place. She is very angry that you refused her. She feels that a suitable punishment is to break your arms and legs and impale you on a blunt stake.\n" \
"  As you die, you hear her make a note to get her money back for you. She hates defective goods. Go to {12}."
},
{ // 111/32C
"\"Ah, a fellow rogue! I fear we have wronged you,\" he says. \"Come in and enjoy the hospitality of my home.\"\n" \
"  He ushers you in and you are seated at a table laden with food. As you eat, you regain any Strength points you have lost, save those you lost because of poison.\n" \
"  Marek returns all of the winnings which were stolen from you and, if you wish, even casts a Restoration on you, giving you back half the CON points you may have lost in this trip.\n" \
"  As you leave, he apologizes again. [He offers you a meal any time you are in the area. ]This is worth 2000 ap and, moreover, you can now cast a Restoration spell (assuming you have the IQ and DEX to handle L2 magic) because of Marek's instructions to you. Go to {115}."
},
{ // 112/32D
"Make a saving roll at your level on LK. If you make it, go to {105}. If you miss, go to {217}."
},
{ // 113/33A
"This is the Temple of the Blue Beetle. The Temple is long and dark. The altar is a giant carved beetle. There is a hole in the middle and what seem to be blood grooves. There are two doors behind the altar.\n" \
"  Off to your right you see two orcs. They are talking in hushed tones and pointing at you.\n" \
"  In the front of the Temple, you see the skulking form of an ogre. It is trying to hide in the shadows but is having little or no success.\n" \
"  To approach the altar, go to {112}. To move in the direction of the orcs, go to {157}. If you want to trail the ogre, who just left via a secret panel in the north wall of the Temple, go to {200}."
},
{ // 114/33B
"Good job. Raise your CHR by three points and your LK by four. No one in the bar liked the orcs anyway, and they consider your killing them to be a public service. From the orcs' bodies you get a diamond ring[ that glows when it nears gold in any quantity of more than 100 gp]. Go to {109}."
},
{ // 115/33C
"This is the city square. Here is your hotel, along with a carriage ready to take you to your ship at {143}, if you wish to leave now.\n" \
"  If you want to explore, you may go east on the Dark Way to {152}. You may also go into the wilderness by going south to {189}. To the north, the Rogue Route will take you to the Black Dragon Tavern, {109}. For those of you who are of a religious bent, you find your interests lie to the west on the Ranger Road, {113}."
},
{ // 116/33D
"One of the slavers comes up to you. Pressing something into your hand, he says, \"I know you are a magic-user. I have a sense about these things. I give this to you because I wouldn't wish this on anyone.\"\n"
"  If you want to cast an Omnipotent Eye on the thing in your hand, go to {191}. If you don't want to, or can't cast such a spell, go to {124}."
},
{ // 117/33E
"As you begin to stride across the floor towards Cronus, you notice your knees start to weaken. You look down and note that the skin is stretched tight across them and your leg muscles are beginning to atrophy.\n" \
"  Your vision blurs and you barely hear the clatter of your weapon hitting the marble floor. You realize that Cronus has sped up the ageing process as far as you are concerned.\n" \
"  You try to mouth an apology, but it does no good. Before the words are out of your throat, all that is left of you is a pile of whitened bones..."
},
{ // 118/33F
"The Sheik laughs and says that his brother, the man you face, plays tricks. He tells you that if you look in your money belt you will find a ring. You check and one is there. You are satisfied, but you continue to glare at the Sheik's brother.\n"
"  The Sheik has grown tired of his brother's tricks. He demands that you two fight to the death for the ring. Go now to {90}."
},
{ // 119/34A
"Make a saving roll at your own level on your CHR. If you make it, they tolerate you training them. If you miss the roll, three or four of the big ones rip you limb from limb.\n" \
"  Any ogre this character meets will follow his orders. The ogres he commands will do whatever he says, either attacking or refraining from attacking (GMs should note the ogres will tend to revolt if the character tells them to attack an invincible position, and they should attack the character instead; this is a good way to get rid of a pesky player like this one...).\n" \
"  You get 5000 ap for this situation. However, it lowers your CHR by three. This character should be taken from this adventure and never return, as the citizens of Gull might take a terminal dislike to him.\n"
},
{ // 120/34B
"If you carry one of the bow-type weapons, go to {20}. If you don't carry a bow weapon, go to {100}."
},
{ // 121/34C
"He says he understands. As you turn to leave, he blasts you with the sonic sword. Take 3 dice + 5 hits worth of damage (your armour, if you are wearing any, is effective).\n" \
"  If you are not killed, you watch him take off in the ship. As you watch, it rises, then explodes. When you recover, you may return to the city square, {115}, or go on your way to the house of the Master Rogue, {44}."
},
{ // 122/34D
"The Sheik looks long and hard at you. \"You have killed my brother, yet you have killed an evil man. I found out tonight that he was planning to kill me and to take all of this for himself. I am grateful to you.\"\n" \
"  He wines and dines you. He gives you a chain of gold (worth 550 gp) and an emerald ring (worth 1000 gp). His final gift to you is a very attractive slave of the opposite sex worth 500 gp should you decide to sell.\n" \
"  In the morning you take your leave. Go to {189}."
},
{ // 123/35D
"Raise your IQ by three because you saw the ogre in the corner aiming a crossbow at you...\n" \
"  You tell them their king says for them to let you pass. If you make a saving roll at your level on CON, you escape due to the sheer gutsiness of that move. If you miss, then your guts are spilled all over the floor by mad ogres.\n" \
"  If you make the saving roll, you escape with the royal baton in hand. Its shaft is made of gold and it is worth 500 gp.[ It has seven jewels in the head of it, which can be rolled for on the jewel generation table.]\n" \
"  You may travel in the wilderness from here by going to {189}, or head back into town, {97}."
},
{ // 124/35B
"You toss the thing away because you think it is useless. Go to {211}."
},
{ // 125/35C
"This is where the Range Sea Road and the Dark Way intersect. Taking the Dark Way, you may go east to {62}, or west to {115}. The Range Sea Road goes north to a dark alley, {1}, or south to {129}."
},
{ // 126/35D
"Ralf's attributes are ST 26, IQ 13, LK 7, CON 26, DEX 14, and CHR 13. He attacks you with an ogre's pilum (which gets 10 dice), and he has combat adds of 14. If you kill him, go to {47}."
},
{ // 127/35E
#ifdef CENSORED
"You should have left the lamp unlit. The woman is a gorgon. By looking at her, you have turned yourself to stone."
#else
"You should have left the lamp unlit. You made love to a gorgon. By looking at her, you have turned yourself to stone. That's the biz, sweetheart."
#endif
},
{ // 128/36A
"Before you is a man, or at least that is what you believe the form in front of you to be. It has short spindly legs and thin, stick-like arms. Its body is weak and skinny. Its head, however, is huge, about three times a normal-sized head.\n" \
"  It has an IQ of 277. It attacks you by a mental blast which generates 150 hit points per combat turn. If has a CON of 25.\n" \
"  Your armour will protect you, oddly enough, for the normal number of hits your kind of armour can take. Any hits you generate via your combat roll will be subtracted from his regular 150 hits. These hits go for defensive measures, i.e. mental armour. If you kill him, go to {135}."
},
{ // 129/36B
"This is the intersection of the Range Sea Road and Peril Street. To the east is your ship, {143}. To the north, the Range Sea Road will take you to {125}. You may take Peril Street west to {189} from here. Or you can go south along the Range Sea Road to {151}."
},
{ // 130/36C
"In the brush you find 300 warriors massed for an attack. You join them and, with a yell, they assault the house.\n" \
"  Make two saving rolls at one level above your own on your LK to see if the orcish archers miss you. If you miss one of the two rolls, take 5 hits in arrow damage. If you miss both rolls, take 12 hits. Once you get inside the house, you will find that your men are outnumbered 3 to 1. You must fight three orcs, each one with a MR of 40. Then when you are done with them, you must roll two dice - if you roll anything but doubles, you must battle two more.\n" \
"  If you survive all that, go to {201}."
},
{ // 131/36D
"The road under your feet leads through the wilderness to the tent of the Sheik. As you come to the edge of the wilderness, you see that there is much activity around the tent. You hide in the wilderness until night falls.\n" \
"  With pitch black around you, you move out. If you wish to light a torch first, go to {55}. If you don't have a torch, or don't want a light, magical or otherwise, go to {204}."
},
{ // 132/36E
"You come upon a clearing. In it is a large white metallic craft that looks somewhat like a crab, sans claws. A hatch opens and two men come rolling out, locked in combat.\n" \
"  They spring apart and each draws a sonic sword. When this weapon touches an opponent, it releases enough sound that the vibration causes damage to the body.\n" \
"  As you watch, both men receive blows from the weapons. In your head you hear someone calling for help. You know it is telepathy, but you can't decide which man is calling for help.\n" \
"  To help the man in the black uniform, go to {95}. To help the man in the white suit, go to {48}. To leave this spot, go to {45}."
},
{ // 133/36F
"You surprised him. He has a CON of 20. If you kill him in the initial ambush (he doesn't get to roll for that combat round), go to {222}.\n" \
"  If you didn't kill him, you must fight conventionally with him. He gets 6 dice and 48 combat adds. If you defeat him now, go to {23}."
},
{ // 134/37A
"One of the slaves blurts out that indeed you are a slaver and adds that, if you weren't, what the hell would you be doing with five slaves!?\n" \
"  One of the men walks over and decks that slave. They offer to buy the slaves from you for 300 gp each. You sell them. Count your money all the way to the bank and cut your CHR by 3. Go to {115}."
},
{ // 135/37B
"\"Well, well,\" says Cronus. \"Few men have done what you have done. You have earned the right to live. You will be placed in the city square and allowed to go to the adventure that almost killed you, or you may go on another altogether. You are granted 2000 ap for this as well.\"\n" \
" To go to the city square, go to {115}. If you want to attack Cronus, go to {223}."
},
{ // 136/37C
"You find the Sheik's brother in bed with a beautiful woman. He begins to quake and shiver. He gathers himself up and makes a lunge for his scimitar. You step in and stop his arm with your foot.\n" \
"  Do you cut off his hand, {154}, or do you kill him, {26}?"
},
{ // 137/37D
// This is somewhat different in the dT&T (at least) FB version
"As you hang there, you cast a Bigger is Better spell on the rope. It is enchanted so that it doubles in length, and you safely climb to the ground. You give the rope a tug and it falls down behind you.\n" \
"  As you begin to walk away you look at the rope. It has shrunk back down to a length of 6'. The Omnipotent Eye you cast on it shows it to be enchanted at around 4th level.\n" \
"  [It will grow to any length you need, up to 60'. It will fasten itself into any wall that has even a crack in it, making climbing easier. It cannot be destroyed, but a Dispel or the AntiMagic (see the Rule Book) spell will hamper its activities severely. ]Go to {115}."
},
{ // 138/37E
"Your fall is broken by two of the faithful. Many seek to lay hands on you, but you tear free of their grasp. You run towards the altar and the hole in it. As it presents the only avenue of escape, you dive into it and go to {159}."
},
{ // 139/37F
"Inside the mouth of the cave, you find a small path up the side of the cavern wall on the right. You move along it and soon detect a light inside the cave.\n" \
"  You look down and see a black-furred humanoid creature. It is the Stalker. You may speak to him, {161}, or attack him outright, {133}."
},
{ // 140/38A
"For a second you catch a glimpse of some white plants around you. As the light bathes their leaves, the plants begin to grow at an incredible rate. Unfortunately for you, they are carnivorous, but then, this wasn't that hot a character anyway..."
},
{ // 141/38B
"As you approach the front door, you hear a voice whisper, \"Not that way. Come here.\" The voice comes from the brush that was across from your hiding place.\n" \
"  If you wish to go to the voice, go to {130}. If you wish to go to the door, ignoring the voice, go to {192}."
},
{ // 142/38C
"This was not the best idea you have had while in the dungeon! This man, Barth Bladehand, stabs you in the back. As you wheel, he aims a cut at your throat, slitting it neatly from ear to ear. You die in a gurgle of blood, and Barth gets all the treasure you had on you."
},
{ // 143/38D
"This is the ship. Pick one WP and decide his disposition towards you. Do whatever has to be done, collect any ap, plus 250 more points for leaving this adventure successfully, and you are done. Bon Voyage!"
},
{ // 144/39A
"These men have beaten you and they have robbed you, yet you would let them keep their booty? The gods can't understand this way of thinking.\n" \
"  The gods now decree that you should go to {208}[ unless you would like to be cursed with impotence or a case of terminal acne, or both, forever]!"
},
{ // 145/39B
"Ol' Ralf is a young ogre. He is not too well versed in the ways of magickers. His attributes are ST 26, IQ 13, LK 7, CON 26, DEX 14, and CHR 13. He uses an ogre pilum (10 dice). Your magic spell hits him before he can fully get his pilum into play.\n" \
"  If your magic kills him outright, then go to {9}. If you must resort to weapons of any sort and then kill him, go to {47}."
},
{ // 146/39C
"As the blood of the Blue Beetle drips down your weapon and touches your skin, you feel your body changing (if you are wearing gloves or armour, forget it - the blood seeps right through). In the place of the beetle, you see another man's body. Suddenly you realize that you are becoming a giant Blue Beetle.\n" \
"  Your weapons clatter to the ground. Your clothes are torn to shreds as your body begins to harden. As you lose all semblance of human form, you hear the laughter of the gods. \"Foolish mortal,\" they chide, \"we cannot allow gods to be killed. If one is killed, then the penalty the slayer has to pay must be eternal.\" The words have meaning, but you no longer care. You make happy clicking sounds as you move towards the body there on the floor; you are so hungry."
},
{ // 147/39D
"If your DEX is less than 18, you must make three saving rolls on your DEX at second level (25 - DEX). If your DEX is 29 or 30, make two saving rolls. If it is 31 to 44, you need make only one. If Your DEX is 45 or greater, you scale the wall like a veritable fly and don't even knock a pebble loose. However, if you should miss any one of them, it means you knocked a stone out of the wall. It lands with a thud on the ground.\n" \
"  If you did knock a stone loose, go to {79}. If you made the climb safely, go to {5}."
},
{ // 148/39E
"If you wrote Blasting Power, Swiftfoot, or Take That You Fiend, you got by it. If so, go to {125}. If you wrote anything else, it didn't take effect and you must defend yourself with weapons. Go to {51}."
},
{ // 149/39F
// This is somewhat different in the dT&T (at least) FB version
"Make a saving roll at your own level based on your IQ. If you make it, go to {29}. If you don't make it, go to {231}."
},
{ // 150/40A
"You stand victorious. Ogara's body is beneath your feet, and you are the chieftain of the ogres on Phoron. You see the ogres are restless and you fear they may revolt.\n" \
"  If you would like to do nothing and see what they will do, go to {170}. If you would like to whip them into a fighting force, go to {119}. If you would like to just give up the throne, go to {123}."
},
{ // 151/40B
"You find yourself in front of a little sideshow. There is a barker out front, and you pause to listen to what he has to say.\n" \
"  \"A gem worth 1000 gp to any man or woman who can defeat the Netmaster!\" he cries. \"This is a game only for those who are brave. The weak of heart need not try, for surely they will perish.\"\n" \
"  If you want the gem and are willing to fight for it, go to {46}. If you aren't interested, go to {129}."
},
{ // 152/40C
#ifdef CENSORED
"In the centre of this room you have just entered from the Dark Way, you see an old woman. She has grey hair and her shoulders are covered with a shawl. Cats are all over the place.\n" \
"  If you intend to speak with her, go to {8}. If you are a magic-user and want to cast a spell, go to {24}, after writing it down. If you are a man-tiger from the Deathtrap Equalizer Dungeon, go to {196}."
#else
"In the centre of this room you have just entered from the Dark Way, you see an old woman. She has grey hair and her shoulders are covered with a shawl. Cats are all over the place.\n" \
"  If you intend to speak with her, go to {8}. If you want to make love to her, go to {233}. If you are a magic-user and want to cast a spell, go to {24}, after writing it down. If you are a man-tiger from the Deathtrap Equalizer Dungeon, go to {196}."
#endif
},
{ // 153/40D
"You were expecting some sympathetic god to whisk you out of trouble, maybe? No way. You are dead."
},
{ // 154/40E
"The Sheik rushes in to see his brother's hand severed off. He realizes that you are an honest man and that his brother was wrong. He notes that you could have killed his brother and you didn't. He hands you a chain of gold (worth 500 gp) and shows you the way back to the road. Go to {189}."
},
{ // 155/41A
"Two acolytes are walking down the hall. They draw their weapons and attack in silence.\n" \
"  If you want to fight them with conventional weapons, go to {42}. To battle them with magic, write down a spell and go to {34}."
},
{ // 156/41B
// This is somewhat different in the dT&T (at least) FB version
"You are refusing an adventure? The gods are maddened by this. [They curse you into going berserk in your next combat situation. ]Now go to {86}[ or the berserkergang will last outside this adventure forever as well]!"
},
{ // 157/41C
"The orcs run in terror at being seen. Stealthfully you follow and you see that they are leading to an old house in a wooded section of town. It is quite old and worn, but some of the original beauty can still be seen.\n" \
"  The orcs go inside. You, being intelligent and brave, decide that you will enter the building too. You see that there are three ways to enter. You may climb up the worn stonework to a second-storey window, go to {147}; you may enter through the front door, {141}; or you may enter through a basement window, going to {169}."
},
{ // 158/42A
"The reason the cave sounds like there is an ogre meeting in it is because there is an ogre meeting in it. You peer from behind a stalagmite and watch as two ogres fight to the death.\n" \
"  The larger one is slower than his small opponent. The large one aims a swipe with his bec de corbin at the little one's head; it connects in a glancing blow. The smaller ogre steps inside the larger one's guard and delivers a savage blow to the midsection with a mace.\n" \
"  The large ogre grunts and lowers the boom on the little one. The bec crashes into the small ogre's skull. You watch with horror as the big one, Ogara, stoops and bites the throat out of his vanquished foe.\n" \
"  Suddenly you feel strong hands upon you; you have been discovered. Make a saving roll at your level on IQ. If you make the roll, go to {218}. If you don't make it, go to {171}."
},
{ // 159/42B
"A foul odour assaults your nostrils as you enter this room. With the faint light that seeps in from the hole above, you detect movement in the corner. You stare hard and see a giant Blue Beetle.\n" \
"  To your horror, it makes a happy clicking sound and closes upon you. The only way to continue living is to kill the Blue Beetle God. Its MR is 200[, and it is immune to magical attacks, though not to enchanted weapons].\n" \
"  If you kill it, go to {146}."
},
{ // 160/42C
// This is somewhat different in the dT&T (at least) FB version
"The Sheik's guards search you. In your money belt, they find a ring that belongs to the Sheik. It was planted by his brother. You say that, but they don't believe you.\n" \
"  They decide you are a thief. You will have to be dealt with in the manner their holy book dictates. They strap you to a stake and leave one arm free. Drawing a sword, the Sheik cuts off the hand on that arm. He orders the wound cauterized and bound up. You are sent packing.\n" \
"  Subtract 3 from your DEX and you may now use only one weapon at a time. The weapon must be one-handed, and all bows are out. If you can find Scycor the Healer on this trip, you may have a chance at revenge. Go to {185}."
},
{ // 161/42D
"You had been warned! The Stalker wheels and strikes. His claws rip the flesh from your face and his fangs tear into your throat.\n" \
"  You die gurgling a warcry. The last thing you hear is the Stalker's laughter ringing in your ears."
},
{ // 162/42E
"Despite the fact that no one liked orcs, they like magic-users even less. The bartender asks you to leave.\n" \
"  As you step out of the tavern, two shadows disengage themselves from the alley. Too late, you see a flashing blade coming towards you. Make an L3-SR on LK (30 - LK). If you make it, you take three hits for the nasty gash now leaking crimson all over your arm. The orcs disappear as suddenly as they came, and you go to {115}.\n" \
"  If you didn't make the saving roll, the orcs got you. They don't really like magic-users either, but you don't care; you are just simply dead."
},
{ // 163/43A
"When you see Scycor you note that he too has only one hand. \"I have been a 'guest' of the Sheik. I did not exact a revenge because I am a Healer; however, I think that the Sheik's brother has cost too many people a hand. If you wish, I shall replace that hand and allow you to avenge us all.\"\n" \
"  If you want a new hand, go to {37}. If you don't, then leave by going to {185} with your CON at full strength. Remember the conditions of being one-handed, and go with Scycor's blessing."
},
{ // 164/43B
"The slavers conduct you to a large gloomy castle. It is made of weathered stone that is charred and black. There is a large wall around it; the wall is relatively unguarded.\n" \
"  One man comes out of the huge gate in the front wall. A slaver heads for him, and you see money change hands. With a command, the line of slaves starts forward.\n" \
"  If you are a wizard, rogue, or warrior-wizard, go to {116}. If you are not a magic-user, follow the man in front of you to {211}."
},
{ // 165/43C
"Poor move. Achmed, brother of the Sheik, plants his sword in your chest. This ruptures your heart and causes terminal damage to the other internal organs."
},
{ // 166/43D
"You have just killed the toughest monster in this adventure. You now become the Steward of Time.[ From Cronus' head you take the Helm of Time, and from his neck you take the token of your new office: a chain and medallion. From his hand you take the weapon, called a sare, that is used by the Steward of Time.\n" \
"  Being Steward of Time, you have three powers which concern time:\n" \
"  One, at the cost of 8 ST points, you may cause any metal weapon to decay by speeding up rusting. The ST points will be regained at one per turn, as magic-users regain ST.\n" \
"  Two, at the cost of 40 ST points, you can kill any single foe you face. You simply speed up the ageing process and he dies.\n" \
"  Three, at the cost of 15 ST points per combat turn, you may attack faster than your foe can for one combat turn. For example, for 45 ST points you can get three combat turns before your foe gets even one. As with the above powers, your ST will be regained at one per turn.\n" \
"  Also, you may meddle with the fabric of time. You should always inform the GM as to what is happening. For example, going back in time may inform you what a structure or device was used for. However: paradoxes must be avoided at all costs! A paradox will result in annihilation of all parties concerned and the loss of your abilities and your life as the gods take revenge for you overstepping the bounds of your office!]\n" \
"  You receive 9999 ap for this adventure and 12 jewels from the pouch on Cronus' belt. Roll for their value on the Jewel Generator in the T&T Rule Book or in the Rule Section at the beginning of this book.[\n" \
"  However, being Steward of Time entails a certain responsibiltiy. You must defend your title with honour hereafter. Although you are permitted to leave the adventure now, you also must leave a copy of the character's card at {223} and deal appropriately and honourably with those who come against you.]"
},
{ // 167/43E
"Any attack spell, save a Panic from which he is protected, will work on him. If you killed him, go to {207}. Otherwise, he decorated your throat with a new kind of gaping grin just as you completed your spell. You don't survive it."
},
{ // 168/44A
"The right side leads to a stairway. Cautiously you climb upwards. At the top of this winding stairway, you see a light.\n" \
"  As you come to the top of the staircase, you find yourself on a balcony that is located behind the altar. You duck down; some of the faithful are coming into the Temple. You realize that soon you will be trapped in the Temple.\n" \
"  If you wish to climb upwards on the ornately carven column to your right, go to {224}. If you just want to wait around and perhaps get out later, go to {219}."
},
{ // 169/44B
"You find the window is a tight fit. If you have plate armour and/or any shield larger than a buckler, you will have to leave it behind to get through the window. Moreover, you find that you can't reach up high enough to drag the stuff in behind you.\n" \
"  The basement of this house is very dark. If you wish to make a light, magical or otherwise, go to {76}. If you can't or don't want a light, go to {36}."
},
{ // 170/44C
"They cheer and yell a lot (ogres ain't too bright). They didn't like Ogara that much anyway. They tell you that you cannot rule them forever because you are not an ogre.\n" \
"  They give you an amulet, red in colour, carven like an ogre. It is called the Amulet of the Red Ogre and will be recognized by any ogre.[ Ogres will let you and your party pass in any adventure if they don't outnumber you (they'll respect you if they can't kill you).]\n" \
"  You hand over the crown to another ogre and you leave. You may head for the city, {187}, or you can go into the wilderness, {97}."
},
{ // 171/45A
"Ogara does not like prisoners who struggle. You were not smart enough to figure out that struggling might be harmful to your health. Make a saving roll on IQ again. If you make this one, go to {218. If you don't make it, Ogara gives you cranial capacity for more brains by lifting out a handful. As he didn't wash his hands first, you don't survive this crude lobotomy."
},
{ // 172/45B
"You travel along, one hand in front of you and one on the wall. You travel up three long flights of stairs and come to a dimly lit corridor. 150' further along that corridor you come to a door.\n" \
"  Suddenly you hear someone coming. If you wish to slip inside the door, go to {159}. If you wish to wait and see who is coming, go to {155}."
},
{ // 173/45C
"As you pass along this road, you notice a strange glowing in the glen to your left. If you wish to investigate, go to {132}. If you want to continue along your way, go to {44}."
},
{ // 174/45D
"Roll two dice. If you get a 2 or 12, [Madame Chayalla decides to keep you to be her new tiger. Leave this character's card here until he destroys another man-tiger or racks up the equivalent of his MR in CON points. When he is released, ]he also gains 1000 ap.\n" \
"  [If you rolled anything else, you can leave a new person. ]Go to {125}."
},
{ // 175/45E
"The Sheik's guards have sighted in on you with their bows. With a twang, you become a human pincushion. It is a good thing this character dies right here - he doesn't have brains enough to survive in this cruel world."
},
{ // 176/45F
"Any magic spell (ie. Take That You Fiend or some other [combat ]spell) will vanquish the man on the ledge. Take off the ST points that the spell cost you to cast (minimum of 1). Compute your new weight-possible. If you are overloaded by carrying more stuff than you can, your grip slips and you fall to your death.\n" \
"  If what you carry doesn't cause you to fall, you drag yourself onto the ledge. There you find a door and go through it. Go to {78}."
},
{ // 177/46A
#ifdef CENSORED
"You hear the giggle again as you crawl through the cut in the tent wall. You feel her reaching for you.\n" \
"  If you wish to go towards her, go to {49}. If you wish to continue on your way, go to {65}."
#else
"You hear the giggle again as you crawl through the cut in the tent wall. You feel her reaching for you and moaning softly. She calls for you to make love to her.\n" \
"  If you wish to make love to her, go to {49}. If you wish to continue on your way, go to {65}."
#endif
},
{ // 178/46B
"You seem very intelligent to him. He invites you into the ship. Once inside, he moves to a locked panel on the wall. He presses a series of buttons and the panel springs open. From it he withdraws a grey metal device that looks like a bulky glove.\n" \
"  \"This,\" he says, \"is one of the most powerful weapons my people have. It is called a War Gauntlet. Give me your left arm.\"\n" \
"  You comply and he slips it onto your arm. It goes all the way up your arm to the elbow. You make a fist and feel the power surge through your body.\n" \
"  [Once every five game turns, you can use the gauntlet to punch with. Such a punch gets as many dice as half your ST rating, up to 10 dice. The index finger fires a dart that does 2 dice worth of damage to any being at a range up to 30' away. The middle finger shoots out a 20' blast of flame which will take 3 dice worth of hits directly off the CON or MR of any foe, even before your opponent gets to roll. The dart and the flame each work only once every ten combat turns.\n" \
"  ]You thank him and watch him blast off. You may now continue to the Master Rogue's house, {2}, or you can return to the city square at {115}."
},
{ // 179/46C
"You should have called it an evening. You just rushed into the building where 50 orcs were preparing to go join a larger group of orcs to help raze the city. Make a saving roll on LK three levels above your own. If you make it, you saw them before they saw you, and you were able to make a strategic withdrawal. Go to {115}.\n" \
"  If you didn't make it, you have just become what is known as \"Monster Fodder\"."
},
{ // 180/46D
"Make a saving roll at second level on your IQ (25 - IQ). If you make it, go to {99}. If you don't, go to {63}."
},
{ // 181/47A
"As the mist clears from this room, you begin to think you are looking at yourself in two mirrors. You continue to believe this a few moments more until the images of you start moving when you are motionless. You set yourself for battle as they move in to attack you.\n" \
"  You are the Champion of the Present. You must battle two copies of yourself. They will arm themselves as you do[ and weave the same spells as you. The only point of difference is that if you have an uncommonly enchanted weapon, they will get only the non-magical version of it (note that spells like Vorpal Blade, Enhance, and Zappathingum are considered common enchantments)].\n" \
"  If you defeat them both, go to {135}."
},
{ // 182/47B
"The smell of blood draws wilderness creatures towards you. All you see is their eyes glowing in the darkness. You hear a snarl and you wheel to see a lion in midflight at you. You make a feeble attempt yourself, but it fails. The lion kills you instantly, snapping your neck, because he was told as a cub never to play with his food."
},
{ // 183/47C
"The orcs never thought of looking up. You continue climbing when they have left and make it to {5}."
},
{ // 184/47D
"You tried to enter the treasure room of the Temple. You were so shocked at the sight of all that loot that you didn't see the blade that came from the ceiling and split you from throat to groin. This gives you a case of terminal heartburn."
},
{ // 185/47E
"This is the intersection of Wilderness Road and Peril Street. To go east, Peril Street runs to {129}. To the west it goes to {108}. The Wilderness Road runs north to {115} or south to {59}."
},
{ // 186/47F
"The Sheik's brother, Achmed, has a CON of 15 and combat adds of 27. He fights with a scimitar (4 dice) and a sax (2 dice + 5). If you defeat him, go to {122}."
},
{ // 187/47G
"The direction sign here reads: \"This is the Ranger Road. It goes east to {115} or west to {97}. For those who can't read, enquire at the city square.\""
},
{ // 188/48A
"Before you stands the Stalker. He is the result of crossing a man with a panther. His attributes are ST 30, IQ 30, LK 24, CON 20, DEX 30, and CHR 18. He has 48 combat adds. He uses his claws and teeth as his weapons; they are worth 6 dice, which makes him one of the tougher monsters in this adventure.\n" \
"  He attacks you without hesitation. If you kill him, go to {23}."
},
{ // 189/48B
"This is the intersection of the Wilderness Road and Peril Street. To go to the east, Peril Street will take you to {129}. To go west, head for {108}. The Wilderness Road runs north to {115}, and south to {59}. To the southeast there is a path that runs off into the brush; it goes to {11}."
},
{ // 190/48C
"The Sheik rises up and orders his guards to take you. He says no one will accuse his brother of being a thief. Go to {160}."
},
{ // 191/48D
"You look in your hand and you see a sliver of wood. As the spell takes effect, you note that it is carven with many runes, the meaning of which escapes you. You are aware, however, that this artifact will be fatal to a vampire. This causes you to suspect that your new master is indeed a vampire. Go to {202}."
},
{ // 192/48E
"Only an idiot would walk in the door of a building where orcs are known to be. You get the singular privilege of having a tulwar inserted into your chest cavity. You die due to excessive internal lacerations, abrasions, and general cardiopulmonary arrest."
},
{ // 193/48F
"He hates magic-users and is himself unharmed by magic. He takes this as an unwarranted attack on him. He grabs you and forces you into the space ship. He stuffs you into the overspace drive, and you live long enough to learn what it feels like to be rocket fuel. Go to {12}."
},
{ // 194/48G
"If you are a magic-user, go to {28}. If you are not a magic-user, but a weapons-user only, go to {75}."
},
{ // 195/49A
"Make a saving roll on LK at your level. If you make it, go to {188}. If you don't make it, go to {50}. If you make it one level higher than your own, go to {32}. If you make it two or more levels higher, then go to {139}."
},
{ // 196/49B
"Madame Chayalla senses your distress. She says she knows where there is a tiger you can fight. If you want to regain your human form, go to {51}. If you don't want to regain your human form, you might as well leave this adventure."
},
{ // 197/49C
"You knock him sprawling, He rises, hate in his eyes, sword in his hand.\n" \
"  Your own weapon is drawn.\n" \
"  You may explain your attack, {118}, or sheath your weapon, {165}."
},
{ // 198/49D
"Good choice! You have found the door to Madame Chayalla's treasure hoard. You may take one piece of treasure and roll for it on the Jewel Generator in the Rule Book (or in the Rules Section at the beginning of this book). If you get a necklace, go to {212}.\n" \
"  If you get anything else, pocket it and go to {125}."
},
{ // 199/49E
"The orcs hear you and turn to fight. They each have a MR of 40; there are two of them. If you kill them, roll one die and multiply it by 50 to see how many g. p.'s each one was carrying. Go to {115}."
},
{ // 200/49F
"The ogre you are following picks his way through the city carefully. He uses each shadow to its fullest. When he reaches the wood on the outskirts of town, he begins to move at a very fast pace. Fortunately, you are quick enough to keep after him.\n"
"  He slows as he reaches a cave. He enters it, and from the sounds issuing from there, it sounds like a large meeting is taking place inside.\n"
"  If you wish to follow him inside, go to {158}. If you want to turn and run, go to {21}."
},
{ // 201/49G
"You amass the ap for all the orcs you have slain, plus another 250 for bravery. You also get 500 gp from Ardop, the primary Gull banker, who didn't want the orcs to attack the city and ruin his business. Now go to {115}."
},
{ // 202/49H
"You are conducted into a large room. It is dimly lit and the only piece of furniture is a large throne covered in black velvet. A beautiful raven-haired and white-skinned woman is seated on the throne.\n" \
"  She looks over the line of the slaves in front of her. She selects one. She waves to the guards and the rest of you are conducted out of the room.\n" \
"  If you want to break the line and attack her with the sliver of wood, go to {107}. If you want to await a better chance, go to {88}."
},
{ // 203/50A
"You draw your weapon and they run. To run after them and engage them in battle, go to {199}. To follow them and see where they are going, go to {229}."
},
{ // 204/50B
"You manage to sneak up to the tent. You hear a female giggle, and you see the single light that was burning wink out. You may burst in, cutting through the tent where you are by going to {177}, or you may go through the door (or tent flap to you purists!) by going to {136}."
},
{ // 205/50C
"Torches are lit all over now. The Sheik comes from his tent with several guards. The Sheik's brother comes from his tent, scimitar in hand.\n" \
"  If you want to attack him immediately, go to {186}. If you would like to explain to the Sheik what you are doing, then go to {175}."
},
{ // 206/50D
"Entering this door, you tripped a trap. A blade came from the ceiling and would have cut you in two. Due to the fact that you are so quick, you find yourself standing in the treasure room of the Temple.\n" \
"  You see gold all over the place. You may pick up your remaining weight-possible in gp or take one jewelled piece of treasure. If you take the jewellery, you will have to roll for its value on the Jewel Generation Table.\n" \
"  When you have made your choice, leave through an open door to {115}."
},
{ // 207/51A
"The lawman of the city comes around and sees Barth's body. He thanks you and gives you 100 gp as a reward for ridding the city of this scum. Go to {125}."
},
{ // 208/51B
"The second you step through the door, it closes behind you. You find yourself in the main foyer of the building. Before you are three doors.\n" \
"  \"You are an intruder in the house of the Master Rogue,\" booms a bodiless voice. \"Choose one of the three doors in front of you. If you survive, you may be permitted to leave here.\"\n" \
"  To choose the first door, go to {230}; the second door, go to {68}; the third door, go to {92}."
},
{ // 209/51C
"This is the main room of the Archer's Guild. It is 20' long by 20' wide. You notice that it has no windows, only four long thin slits in the walls. They look disturbingly like archer's ports. That's because they are archer's ports. Behind each one is a master archer with a drawn bow. They are aiming at you because you broke in.\n" \
"  Each one of them rolls two dice and gets five adds. Five hits against any of the archers will mortally wound him. For each archer still in action during any combat round, you should take one hit directly against your CON.\n" \
"  Because of the size of the room, you can only attack the archers one at a time. Every fifth combat turn, a fresh archer will step in and replace one who was killed.\n" \
"  If you are carrying a bow, they won't shoot you. If so, go to {16}. If you kill them all, go to {225}."
},
{ // 210/51D
"Immediately you put your back to a wall. You note that 300 men are pouring into the building, but you realize that you will never be able to fight your way to them.\n" \
"  Most of the orcs turn to face these invaders, but ten advance to take care of you. They fight in three waves, as they can't all reach you at the same time. Each orc has a Monster Rating of 40. The first two waves have three orcs each, and the last wave has four orcs in it. The following waves only advance when the preceding wave is destroyed.\n" \
"  If you survive, go to {201}."
},
{ // 211/51E
#ifdef CENSORED
"You are led into a large chamber with the other slaves. It is dimly lit and you note that the only furniture is a large throne covered in black velvet. The floor is littered with animal skins and silk pillows.\n" \
"  The female slaves are led away.\n" \
"  As they leave the room, a beautiful woman comes into the room. She sits on the throne and, after looking over the slaves, singles you out. The rest are led out of the chamber and you and she are alone.\n" \
"  She looks at you with desire and says, \"Come closer to me.\" If you say yes, go to {3}. If you say no, go to {39}."
#else
"You are led into a large chamber with the other slaves. It is dimly lit and you note that the only furniture is a large throne covered in black velvet. The floor is littered with animal skins and silk pillows.\n" \
"  The female slaves are led to {216}.\n" \
"  As they leave the room, a beautiful woman comes into the room. She sits on the throne and, after looking over the slaves, singles you out. The rest are led out of the chamber and you and she are alone.\n" \
"  She looks at you with desire and says, \"Come, let us make love.\" If you say yes, go to {3}. If you say no, go to {39}."
#endif
},
{ // 212/52A
"You have taken an enchanted piece of jewellery. Madame Chayalla turns you into a cat and this necklace will serve as your collar.\n" \
"  Enjoy your stay!"
},
{ // 213/52B
"What luck! The rope snapped. Due to an old custom, you must be allowed to go free. The men break your knees and let you go.\n" \
"  Halve ST, LK, and DEX. Add 2 to your IQ. You may continue to go to the house of the Master Rogue by going to {2}, or you can commit suicide, which means simply that you are dead. If you want to crawl back to town, then go to {115}."
},
{ // 214/52C
"You enter the pyramid and the mist falls away. You see you are in a swamp and you recognize the animals of which there are only bones left now. You come face to face with the champion of the past: Tyrannosaurus Rex! This creature has a MR of 300. Magical attacks will work on it[, but poison has only half effectiveness (they are hardy beasts, after all!)]. If you defeat it, go to {135}."
},
{ // 215/52D
"This is a palantir. [It will work once every five game turns. To use it, you should roll two dice. If you get doubles, the GM has to correctly answer one yes-or-no question. Even if it doesn't work, you must wait five turns to use it again. ]Go to {189}."
},
{ // 216/53A
"As you walk down this hall, you discover that your shackles are loose. You slip them from your wrists and cut for the door to your right.\n" \
"  In a second you are in the door. You quickly shut it and throw the bolt. You hear the guards calling for a ram or crowbar to open the door. You must find a way out.\n" \
"  You find the room is empty except for a table. There is a window above the table, and you can reach it by standing on the table. On the table are three things: one is a sword, one an emerald, and the last is a length of rope.\n" \
"  The door is beginning to give way. With a metallic cry of pain, one of the hinges bursts out of the wall. You must choose one of the articles on the table to help you make your escape.\n" \
"  If you take the gem, go to {194}. If you take the rope, go to {13}. If you take the sword, go to {18}."
},
{ // 217/53B
"You didn't notice the trap door beneath your feet. The floor opens up and swallows you whole...\n" \
"  You are whipped down a lightning-fast slide. Quickly you multiply your rate of descent by the time elapsed, and you deduce that you are 200' below the surface of the isle of Phoron. The door above you closes and you are plunged into darkness.\n" \
"  If you would like to strike a light and explore, go to {140}. If you can't make a light or would prefer to explore in the dark, go to {172}."
},
{ // 218/54A
"You are smart enough to realize three things. First is that you don't have long to live. The second is that you have just witnessed a Chief Challenge, in which Ogara retained the title of chief. Third, you see a way out. You hear your voice cry out, \"I challenge Ogara for the office of chief!\"\n" \
"  The ogre chuckles and refuses until he is reminded that, by tribal law, he must fight you. His attributes are ST 60, IQ 16, LK 8, CON 20, DEX 7, and CHR 10. He has combat adds of 45, and his hands are worth 3 dice in barehanded combat[, which is how you will fight (your hands are worth 2 dice only)].\n" \
"  If you kill him, go to {150}."
},
{ // 219/54B
"You see a struggling figure being brought in. That poor person is dragged to and strapped onto the altar. A priest comes out and offers up a prayer.\n" \
"  A door in the altar opens up. Out of it crawls a huge Blue Beetle. It begins to close on the figure strapped to the altar.\n" \
"  You may wait in the balcony and watch the sacrifice, and afterwards leave by going to {187}, or you may attack the Blue Beetle and save the man on the altar, {61}."
},
{ // 220/54C
"[As an orc, you take command of the forces in this orc house. There are a full thousand orcs, each with a MR of 40.\n" \
"  If you wish, you could have someone design a city for you to attack. Gull is currently home of some 30,000 people, but only 10% of these residents are warriors. If Gull is built, don't forget to include the Wandering People in the fight.\n" \
"  ]You are done here, so go to the exit, {143}, and leave."
},
{ // 221/54D
"You get very bad vibes about this character. If you want to attack him with magic, write down a spell and go to {193}. If not, retum to {48} and continue."
},
{ // 222/54E
"You notice he casts a dying glance at a chest. You go over and open it. In it you see (and presumably take) one die times 1000 gp. Amid the gold pieces you also find a round clear piece of glass. If your IQ is 25 or more, take it and go to {215}. If your IQ is 24 or less, you don't care about it, and you leave the cave by going to {189}."
},
{ // 223/55A
"Cronus steps from his throne. He dons a helm that covers his head completely. From the front, it looks like a clock. His voice rumbles out of it.\n" \
"  \"Many men have wanted to fight what I do to them. They seek to deny the effects Time has on them. You are one of the few who does get to fight Time.\"\n" \
"  From his belt he takes a thin, foot-long tube. He presses a stud on it, and it telescopes out to its full 5' length. One end is a pendulum-like fanblade that is razor-sharp. At the other end is a sax blade. Altogether, the weapon gets 5 dice + 5.\n" \
"  Cronus' attributes are: ST 112, IQ 40, LK 112, CON 25, DEX 112, and CHR 13. Combat adds are 300.\n" \
"  If you kill him, go to {166}."
},
{ // 224/55B
// %%: text says "20 - LK"!
"This was one of your poorer choices. The column is old and the ornate carvings crumble beneath your weight. You scramble to the top of the lofty column and find there is no way onto the roof. Below you are the irate worshippers of the Blue Beetle.\n" \
"  The carvings break off and you fall.\n" \
"  Make a L3-SR on LK (30 - LK). If you make it, go to {138}. If you don't, then you were killed in the fall."
},
{ // 225/55C
"After the battle you rest for a second. In that second, two huge men come in and grab you. They force you down and hold your body and head still on the floor.\n" \
"  The Master Archer comes in with a brand, white-hot, and applies it to your forehead. It is the broken A rune, and it means that you have killed an archer.\n" \
"  [Every time you see a man with a bow, you must make a LK saving roll at this level to see if he knows what that letter means. If you do not make the saving roll, he understands and must decide what to do with you.\n" \
"  ]Go to {125}."
},
{ // 226/55D
"It is bad policy to refuse the slavers' offer. Because you did refuse, they planted a knife neatly betwixt your shoulder blades. This causes extreme trauma to your heart, a condition which is necessarily very fatal."
},
{ // 227/55E
"Once inside he says he is a criminal from another world. You are his prisoner, and you are going to get a ringside seat as he turns the advanced weapons of this ship on Phoron and obliterates the island.\n" \
"  If you want to sit back and watch the show, go to {104}. If you wish to jam a knife in the controls, sacrificing yourself for the island, go to {98}."
},
{ // 228/55F
"Despite the fact that you blew your saving roll, you are incredibly lucky! In the Stalker's lair, you will find a small vial of liquid that will bring your CON back up to its normal level.\n" \
"  You also find a charm[ that prevents 20 hits resulting from missed saving rolls (note: instant death is considered to be an infinite number of hits). It is good in this adventure, and in all others where it is permitted by the GM. It is non-transferable, however, except upon the death of the current owner]. Go to {189}."
},
{ // 229/56A
"You follow them to the seaside section of town. They enter an old building that looks both decrepit and dismal. If you wish to call it a night, you may go to {115}. If you want to sally forth and go adventuring, go to {179}."
},
{ // 230/56B
"The door closes behind you, and you find yourself on a ledge that is only 6' long and 6' wide. Across a 12' chasm and 10' overhead is another ledge. On that ledge is a man with a club.\n" \
"  In your right mind, you would not attempt that jump with that man there to mash your fingers. However, the wall that contained the door starts to slowly move in your direction, forcing you to jump or be pushed from the ledge onto a collection of sharpened stakes 140' below.\n" \
"  Make a saving roll at your level on your DEX to see if you make the jump successfully. If you do so, go to {96}. If you don't, then you fall to your death."
},
{ // 231/56C
"You were not bright enough to figure out why the zones of hot and cold were set up like they were. The hot zone made you sweat profusely, and the cold zone then froze that sweat on you. This means that you die in the cold zone. You will be happy to know that your body will go to feed the guards. They love frozen dinners!"
},
{ // 232/56D
"What is the purpose of buying a solitaire adventure if you are not willing to try out the adventures? The gods are saddened that you would not want to go in the front door of this building, and they demand that you sneak around the back of the building and enter that way. Go to {209}.\n" \
"  If you do not, a loud divine voice that sounds very much like your own will say that you think that archers are all sissies. At that time; your feet will become rooted to the spot in front of the Archer's Guild, and you will be peppered with feathered shafts. Go to {12}."
},
{ // 233/50E
"You cad! It takes a real degenerate to proposition an old lady who is a grandmother-type!\n" \
"  She says it is the best offer she's had all day. She makes love to you after she casts a modified Bigger is Better spell on you. Raise your CHR by three and go to {125} with her undying gratitude."
}
// There are extra paragraphs (57A..57F) in the dT&T FB version
}, ct_wandertext[10] = {
{ // 0
"Nathan the Tax Collector (MF - Level 1)\n" \
"ST 12 - IQ 14 - LK 14 - CON 15 - DEX 10 - CHR 8\n" \
"When you meet him, give him 10% of all the treasure you are carrying."
},
{ // 1
"Mardoc the Medic (MF - Level 1)\n" \
"ST 14 - IQ 15 - LK 10 - CON 12 - DEX 12 - CHR 15\n" \
"He replenishes 2 CON points for you per meeting. Pay him 10 gp for his services."
},
{ // 2
"Dar the Bully (ZZ - Level 1)\n" \
"ST 13 - IQ 7 - LK 13 - CON 10 - DEX 13 - CHR 9\n" \
"Roll one die. On a roll of 1-4, he has a friend with him who is Monster Rated at 40. In this case, he will automatically attack. He fights with a pilum (5 dice). He has 100 gp on him and is worth 20 ap."
},
{ // 3 (aka "Jimbob the Hillbilly Trader" in FB edition)
"Uriah the Trader (MF - Level 2)\n" \
"ST 10 - IQ 16 - LK 10 - CON 13 - DEX 12 - CHR 12\n" \
"He will offer to buy all the treasure you want to sell for 10% less than it is worth."
},
{ // 4
"Pietr the Pickpocket (P - Level 4)\n" \
"ST 14 - IQ 13 - LK 22 - CON 15 - DEX 25 - CHR 13\n" \
"Lose all your gold to him. Roll one die. If you roll a 1 or 2, you notice and fight him. He fights with a falchion (4 + 4) and a madu (1 + 3, takes 1 hit). Take 27 ap and your gold back if you win."
},
{ // 5
"Seth the Slaver (AA - Level 2)\n" \
"ST 16 - IQ 12 - LK 14 - CON 12 - DEX 16 - CHR 9\n" \
"Slavers are loathsome. Kill him when you see him. You get 500 gp as reward. He fights with a war hammer (5 + 1), wears leather armour (6 hits) and carries a knight's shield (5 hits)."
},
{ // 6
"Mingor Diamondfist (CA - Level 8)\n" \
"ST 60 - IQ 20 - LK 106 - CON 20 - DEX 20 - CHR 20\n" \
"Mingor made the Trip of the Lion in the Deathtrap Equalizer Dungeon. His hand is a four-die weapon[ worth 5000 gp if you can remove it]. He fights with a pilum (5 dice) in the other hand. He wears mail (11 hits) and has combat adds of 150. He'll fight if you want, or if you roll 2 or 12 on two dice."
},
{ // 7
"Zaarg the Vampire (AA - Level 1)\n" \
"ST 37 - IQ 12 - LK 15 - CON 8 - DEX 8 - CHR 15\n" \
"Zaarg has 27 combat adds and gets 3 dice in a fight. [He is immune to poison. Any player killed by him has become a vampire: multiply ST by 5/2, LK and IQ by 3/2. The character should now be put in the Wandering Person pile, as he is subservient to Zaarg. ]Zaarg, if killed, is worth 52 ap."
},
{ // 8
"Inram the Wizard (MT - Level 9)\n" \
"ST 40 - IQ 42 - LK 30 - CON 8 - DEX 16 - CHR 12\n" \
"[He will cast any spell you want (that he can) for 100 gp times the ST cost to him. ]He has a deluxe staff[ and uses higher-level Take That You Fiend when he fights]."
},
{ // 9
"Jokar the Small (CA - Level 4)\n" \
"ST 18 - IQ 7 - LK 19 - CON 7 - DEX 8 - CHR 11\n" \
"Jokar is small, wiry, and speaks with a lisp. Roll two dice; if you roll doubles, he thinks that you are laughing at him. He has combat adds of 12, fights with a bec de corbin (6 dice), wears mail (11 hits), and uses a tower shield (6 hits). He is worth 25 ap.\n"
}
};

MODULE SWORD ct_exits[CT_ROOMS][EXITS] =
{ { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  31, 142,  52,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  { 144, 208,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  85, 180, 149,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  { 210, 153,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/2A
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/2B
#ifdef CENSORED
  { 198,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/4A
#else
  { 198,  51, 233,  -1,  -1,  -1,  -1,  -1 }, //   8/4A
#endif
  { 158,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/4C
  {  64, 185,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/4D
  { 214, 128, 181, 117,  94,  -1,  -1,  -1 }, //  12/4E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/4F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/5A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/5B
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/5C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/5D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/5E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/6A
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/6B
  { 145, 126,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/6C
  { 203,  60,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/6D
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/6E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/7A
  {  59,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/7B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/7C
  {  44, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/7D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/7E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/8A
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/8B
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/8C
  { 188,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/8D
  {  86, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/9A
  { 159, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/9B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/9C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/9D
  { 131,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/9E
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/10A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/10B
  {  10, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/10C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/10D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/11A
  {  14, 111,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/11B
  {  67,  77,  57,  -1,  -1,  -1,  -1,  -1 }, //  44/11C
  { 132,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/11D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/11E
  { 158,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/11F
  { 121, 227,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/13A
  { 127,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/13B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/13C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/13D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/14A
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/14B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/14C
  { 205, 182,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/14D
  { 129,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/15A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/15B
  { 216,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/15C
  { 195,  25,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/15D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/15F
  { 120, 232, 209,  -1,  -1,  -1,  -1,  -1 }, //  62/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/16B
  { 185,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/16C
  { 136,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/16D
  {   2, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/16E
  {   2, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/16F
  {  78,  82,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/17A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/17B
  { 109, 162,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/17C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/18A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/18B
  {  15,  38,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/18C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/18D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/18E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/18F
  {  30, 226,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/19A
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/19B
  {  87, 183,  41,  -1,  -1,  -1,  -1,  -1 }, //  79/19C
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/19D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/20A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/20B
  {  44, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/21A
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/21B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/21C
  { 173,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/21D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/22A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/22B
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/22C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/22D
  {  72,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/22E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/24A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/24B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/24C
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/24D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/25A
  { 108, 187,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/25B
  { 115,   2,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/25C
  {  17,  63,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/25D
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/26A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/26B
  { 187,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/26C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/26D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/27A
  {  93, 168,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/27B
  {   4,  74,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/27C
  { 115,   2,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/27D
  { 197, 190, 160,  -1,  -1,  -1,  -1,  -1 }, // 108/27E
  {  91,  73,  81,  22, 115,  -1,  -1,  -1 }, // 109/32A
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/32B
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/32C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/32D
  { 112, 157, 200,  -1,  -1,  -1,  -1,  -1 }, // 113/33A
  { 109,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/33B
  { 143, 152, 189, 109, 113,  -1,  -1,  -1 }, // 115/33C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/33D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/33E
  {  90,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/33F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/34A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/34B
  { 115,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/34C
  { 189,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/34D
  { 189,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/35A
  { 211,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/35B
  {  62, 115,   1, 129,  -1,  -1,  -1,  -1 }, // 125/35C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/35D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/35E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/36A
  { 143, 125, 189, 151,  -1,  -1,  -1,  -1 }, // 129/36B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/36C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/36D
  {  95,  48,  45,  -1,  -1,  -1,  -1,  -1 }, // 132/36E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/36F
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/37A
  { 115, 223,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/37B
  { 154,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/37C
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/37D
  { 159,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/37E
  { 161, 133,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/37F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/38A
  { 130, 192,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/38B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/38C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/38D
  { 208,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/39A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/39B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/39C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/39D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/39E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/39F
  { 170, 119, 123,  -1,  -1,  -1,  -1,  -1 }, // 150/40A
  {  46, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/40B
#ifdef CENSORED
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/40C
#else
  {   8, 233,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/40C
#endif
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/40D
  { 189,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/40E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/41A
  {  86,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/41B
  { 147, 141, 169,  -1,  -1,  -1,  -1,  -1 }, // 157/41C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/42A
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/42B
  { 185,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/42C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/42D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/42E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/43A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/43B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165/43C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/43D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/43E
  { 224, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/44A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169/44B
  { 187,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170/44C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171/45A
  { 159, 155,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172/45B
  { 132,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173/45C
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174/45D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175/45E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176/45F
  {  49,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177/46A
  {   2, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178/46B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179/46C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180/46D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181/47A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182/47B
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183/47C
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184/47D
  { 129, 108, 115,  59,  -1,  -1,  -1,  -1 }, // 185/47E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186/47F
  { 115,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187/47G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188/48A
  { 129, 108, 115,  59,  11,  -1,  -1,  -1 }, // 189/48B
  { 160,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190/48C
  { 202,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191/48D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192/48E
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193/48F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194/48G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195/49A
  {  51,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196/49B
  { 118, 165,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197/49C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198/49D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199/49E
  { 158,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200/49F
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201/49G
  { 107,  88,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202/49H
  { 199, 229,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203/50A
  { 177, 136,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204/50B
  { 186, 175,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205/50C
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206/50D (50E is later!)
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207/51A
  { 230,  68,  92,  -1,  -1,  -1,  -1,  -1 }, // 208/51B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209/51C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210/51D
  {   3,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211/51E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212/52A
  {   2, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213/52B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214/52C
  { 189,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215/52D
  { 194,  13,  18,  -1,  -1,  -1,  -1,  -1 }, // 216/53A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217/53B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218/54A
  { 187,  61,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219/54B
  { 143,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220/54C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221/54D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222/54E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223/55A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224/55B
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 225/55C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 226/55D
  { 104,  98,  -1,  -1,  -1,  -1,  -1,  -1 }, // 227/55E
  { 1189  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 228/55F
  { 115, 179,  -1,  -1,  -1,  -1,  -1,  -1 }, // 229/56A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 230/56B
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 231/56C
  { 209,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 232/56D
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 233/50E
};

MODULE STRPTR ct_pix[CT_ROOMS] =
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
  "ct49",
  "", //  50
  "",
  "",
  "",
  "ct54",
  "", //  55
  "",
  "ct57",
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
  "ct71",
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
  "ct95", //  95
  "ct96",
  "",
  "",
  "",
  "", // 100
  "",
  "",
  "ct103",
  "",
  "", // 105
  "",
  "",
  "ct108",
  "ct109",
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
  "ct127",
  "ct128",
  "",
  "", // 130
  "",
  "ct132",
  "",
  "",
  "", // 135
  "",
  "",
  "",
  "ct139",
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
  "ct150", // 150
  "",
  "",
  "",
  "",
  "", // 155
  "",
  "",
  "ct158",
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
  "",
  "", // 170
  "",
  "",
  "",
  "",
  "", // 175
  "",
  "",
  "ct178",
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
  "", // 225
  "",
  "",
  "",
  "",
  "ct230", // 230
  "",
  "",
  "",  // 233
};

#define SOF       "\0x1B[0;40;37m" // start of file (light grey fgc, black bgc)

#define DARKGREY   "\0x1B[0;30m"
#define RED        "\0x1B[0;31m"
#define DARKGREEN  "\0x1B[0;32m"
#define PURPLE     "\0x1B[0;35m"
#define LIGHTGREY  "\0x1B[0;37m"
#define PINK       "\0x1B[1;31m"
#define LIGHTGREEN "\0x1B[1;32m"
#define YELLOW     "\0x1B[1;33m"
#define WHITE      "\0x1B[1;37m"

MODULE TEXT cardimage_ansi[52][12][23 + 1] = {
{ "¶2     þ/¶\\      ",
  "þ     (__¶)     ",
  "þ      ]¶[      ",
  "              ",
  "              ",
  "              ",
  "              ",
  "              ",
  "þ      ]¶[      ",
  "þ     (¯¶¬)     ",
  "þ      \\/      ",
  "              ",
},
{ "¶3     þ/¶\\      ",
  "þ     (__¶)     ",
  "þ      ]¶[      ",
  "              ",
  "þ      /¶\\      ",
  "þ     (__¶)     ",
  "þ      ]¶[      ",
  "              ",
  "              ",
  "þ      ]¶[      ",
  "þ     (¯¶¬)     ",
  "þ      \\/      ",
},
{ "¶4 þ/¶\\      þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "              ",
  "              ",
  "              ",
  "              ",
  "þ  ]¶[      þ]¶[  ",
  "þ (¯¶¬)    þ(¯¶¬) ",
  "þ  \\/      \\/  ",
  "              ",
},
{ "¶5  þ/¶\\    þ/¶\\   ",
  "þ  (__¶)  þ(__¶)  ",
  "þ   ]¶[    þ]¶[   ",
  "              ",
  "þ      /¶\\      ",
  "þ     (__¶)     ",
  "þ      ]¶[      ",
  "              ",
  "              ",
  "þ   ]¶[    þ]¶[   ",
  "þ  (¯¶¬)  þ(¯¶¬)  ",
  "þ   \\/    \\/   ",
},
{ "¶6 þ/¶\\      þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "þ  /¶\\      þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "              ",
  "þ  ]¶[      þ]¶[  ",
  "þ (¯¶¬)    þ(¯¶¬) ",
  "þ  \\/      \\/  ",
},
{ "¶7 þ/¶\\      þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[  þ/¶\\  þ]¶[  ",
  "þ     (__¶)     ",
  "þ  /¶\\  þ]¶[  þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "              ",
  "þ  ]¶[      þ]¶[  ",
  "þ (¯¶¬)    þ(¯¶¬) ",
  "þ  \\/      \\/  ",
},
{ "¶8 þ/¶\\      þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[  þ/¶\\  þ]¶[  ",
  "þ     (__¶)     ",
  "þ  /¶\\  þ]¶[  þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[  þ]¶[  þ]¶[  ",
  "þ     (¯¶¬)     ",
  "þ      \\/      ",
  "þ  ]¶[      þ]¶[  ",
  "þ (¯¶¬)    þ(¯¶¬) ",
  "þ  \\/      \\/  ",
},
{ "¶9 þ/¶\\      þ/¶\\  ",
  "þ (__¶)    þ(__¶) ",
  "þ  ]¶[      þ]¶[  ",
  "þ  /¶\\      þ/¶\\  ",
  "þ (__¶) þ/¶\\ þ(__¶) ",
  "þ  ]¶[ þ(__¶) þ]¶[  ",
  "þ  ]¶[  þ]¶[  þ]¶[  ",
  "þ (¯¶¬)    þ(¯¶¬) ",
  "þ  \\/      \\/  ",
  "þ  ]¶[      þ]¶[  ",
  "þ (¯¶¬)    (¯¶¬) ",
  "þ  \\/      \\/  ",
},
{ "¶10 þ/¶\\    þ/¶\\   ",
  "þ  (__¶)  þ(__¶)  ",
  "þ   ]¶[    þ]¶[   ",
  "þ  /¶\\  þ/¶\\  þ/¶\\  ",
  "þ (__¶)þ(__¶)þ(__¶) ",
  "þ  ]¶[  þ]¶[  þ]¶[  ",
  "þ  ]¶[  þ]¶[  þ]¶[  ",
  "þ (¯¶¬)þ(¯¶¬)þ(¯¶¬) ",
  "þ  \\/  \\/  \\/  ",
  "þ   ]¶[    þ]¶[   ",
  "þ  (¯¶¬)  þ(¯¶¬)  ",
  "þ   \\/    \\/   ",
},
{ "¶J          þ/¶\\ ",
  "¶.-------- þ(__¶)",
  "¶|    æ[.]   þ]¶[ ",
  "¶|  æ...§Tæ...  ¶| ",
  "¶| æ`l'¬¶Yæ¬þ`æ¬' ¶| ",
  "¶| þ, ¶. . þ..· ¶| ",
  "¶|   · þ· ¶· þ` ¶| ",
  "¶|   þ' ²¤ þ`   ¶| ",
  "¶|  ·þ/| |\\·  ¶| ",
  "þ ]¶[ --------' ",
  "þ(¯¶¬) T¢UNNELS  ",
  "þ \\/  ¶& T¢ROLLS ",
},
{ "¶Q          þ/¶\\ ",
  "¶.-------- þ(__¶)",
  "¶|  ç·¯³)(ç··³) þ]¶[ ",
  "¶| ³(ç·³(ç¯))(.³)ç.¶| ",
  "¶|ç·¯³))ç)   (³(ç.¶| ",
  "¶|ç.³((ç(æ-  -ç(( ¶| ",
  "¶|ç.-³)ç))   þ'ç)³)¶| ",
  "¶| ç·³(ç(.þ--'ç(³(ç¯¶| ",
  "¶|þ·¯ç.³)ç)  þ'ç.)·¶| ",
  "þ ]¶[ --------' ",
  "þ(¯¶¬) T¢UNNELS  ",
  "þ \\/  ¶& T¢ROLLS ",
},
{ "¶K          þ/¶\\ ",
  "¶.-------- þ(__¶)",
  "¶|ç.   ..   .þ]¶[ ",
  "¶|ç:.··  ··.: ¶| ",
  "¶|·        · | ",
  "¶|  §*    §*  ç.¶| ",
  "¶|           | ",
  "¶|  þ`VvvV'   ¶| ",
  "¶|   þ·^^·    ¶| ",
  "þ ]¶[ --------' ",
  "þ(¯¶¬) T¢UNNELS  ",
  "þ \\/  ¶& T¢ROLLS ",
},
{ "¶A             ",
  "þ      /¶\\      ",
  "þ    .·  ¶·.    ",
  "þ  .·      ¶·.  ",
  "þ |          ¶| ",
  "þ `.__....__.¶' ",
  "þ   ¯¯ || ¯¯   ",
  "þ     _¦¶¦_     ",
  "þ     ¯¯¯¯     ",
  "¶   T¢UNNELS    ",
  "¶   & T¢ROLLS   ",
  "              ",
},
{ "¶2             ",
  "þ      (¶)      ",
  "þ     ()(¶)     ",
  "þ      ]¶[      ",
  "              ",
  "              ",
  "              ",
  "              ",
  "þ      ]¶[      ",
  "þ     ()(¶)     ",
  "þ      (¶)      ",
  "              ",
},
{ "¶3     þ(¶)      ",
  "þ     ()(¶)     ",
  "þ      ]¶[      ",
  "              ",
  "þ      (¶)      ",
  "þ     ()(¶)     ",
  "þ      ]¶[      ",
  "              ",
  "þ      ]¶[      ",
  "þ     ()(¶)     ",
  "þ      (¶)      ",
  "              ",
},
{ "¶4             ",
  "þ  (¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "              ",
  "              ",
  "              ",
  "þ  ]¶[      þ]¶[  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  (¶)      þ(¶)  ",
  "              ",
},
{ "¶5             ",
  "þ  (¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[      þ]¶[  ",
  "þ      (¶)      ",
  "þ     ()(¶)     ",
  "þ      ]¶[      ",
  "              ",
  "þ  ]¶[      þ]¶[  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  (¶)      þ(¶)  ",
  "              ",
},
{ "¶6             ",
  "þ  (¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "þ  (¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "þ  ]¶[      þ]¶[  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  (¶)      þ(¶)  ",
},
{ "¶7             ",
  "þ  (¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[  þ(¶)  þ]¶[  ",
  "þ     ()(¶)     ",
  "þ  (¶)  þ]¶[  þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[      þ]¶[  ",
  "              ",
  "þ  ]¶[      þ]¶[  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  (¶)      þ(¶)  ",
},
{ "¶8             ",
  "þ  (¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[  þ(¶)  þ]¶[  ",
  "þ     ()(¶)     ",
  "þ  (¶)  þ]¶[  þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[  þ]¶[  þ]¶[  ",
  "þ     ()(¶)     ",
  "þ  ]¶[  þ(¶)  þ]¶[  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  (¶)      þ(¶)  ",
},
{ "¶9 þ(¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[      þ]¶[  ",
  "þ  (¶)      þ(¶)  ",
  "þ ()(¶) þ(¶) þ()(¶) ",
  "þ  þ]¶[ þ()(¶) þ]¶[  ",
  "þ  þ]¶[  þ]¶[  þ]¶[  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  (¶)      þ(¶)  ",
  "þ  ]¶[      þ]¶[  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  (¶)      þ(¶)  ",
},
{ "¶10þ(¶)      þ(¶)  ",
  "þ ()(¶)    þ()(¶) ",
  "þ  ]¶[  þ(¶)  þ]¶[  ",
  "þ  (¶) þ()(¶) þ(¶)  ",
  "þ ()(¶) þ]¶[ þ()(¶) ",
  "þ  ]¶[      þ]¶[  ",
  "þ  ]¶[      þ]¶[  ",
  "þ ()(¶) þ]¶[ þ()(¶) ",
  "þ  (¶) þ()(¶) þ(¶)  ",
  "þ  ]¶[  þ(¶)  þ]¶[  ",
  "þ ()(¶)    ()(¶) ",
  "þ  (¶)      (¶)  ",
},
{ "¶J          þ(¶) ",
  "¶.-------- þ()(¶)",
  "¶|    æ[.]   þ]¶[ ",
  "¶|  æ...§Tæ...  ¶| ",
  "¶| æ`l'¬¶Yæ¬þ`æ¬' ¶| ",
  "¶| þ, ¶. . þ..· ¶| ",
  "¶|   · þ· ¶· þ` ¶| ",
  "¶|   þ' ²¤ þ`   ¶| ",
  "¶|  ·þ/| |\\·  ¶| ",
  "þ ]¶[ --------' ",
  "þ()(¶) T¢UNNELS  ",
  "þ (¶)  & T¢ROLLS ",
},
{ "¶Q          þ(¶) ",
  "¶.-------- þ()(¶)",
  "¶|  ç·¯³)(ç··³) þ]¶[ ",
  "¶| ³(ç·³(ç¯))(.³)ç.¶| ",
  "¶|ç·¯³))ç)   (³(ç.¶| ",
  "¶|ç.³((ç(æ-  -ç(( ¶| ",
  "¶|ç.-³)ç))   þ'ç)³)¶| ",
  "¶| ç·³(ç(.þ--'ç(³(ç¯¶| ",
  "¶|þ·¯ç.³)ç)  þ'ç.)·¶| ",
  "þ ]¶[ --------' ",
  "þ()(¶) T¢UNNELS  ",
  "þ (¶)  & T¢ROLLS ",
},
{ "¶K          þ(¶) ",
  "¶.-------- þ()(¶)",
  "¶|ç.   ..    þ]¶[ ",
  "¶|ç:.··  ··.: ¶| ",
  "¶|·        · | ",
  "¶|  §*    §*  ç.¶| ",
  "¶|           | ",
  "¶|  þ`VvvV'   ¶| ",
  "¶|   þ·^^·    ¶| ",
  "þ ]¶[ --------' ",
  "þ()(¶) T¢UNNELS  ",
  "þ (¶)  & T¢ROLLS ",
},
{ "¶A             ",
  "¶    .--¢--.    ",
  "þ    l    ¢|    ",
  "þ  .--¶·  ·-¢-.  ",
  "þ  |        ¢|  ",
  "þ  `--·..·--¶'  ",
  "þ      |¶|      ",
  "þ    .-'¢`-.    ",
  "þ    ¯¯¯¯¯¯    ",
  "¶   T¢UNNELS    ",
  "¶   & T¢ROLLS   ",
  "              ",
},
{ "ð2             ",
  "§     (ð¬¯)     ",
  "§      \\/      ",
  "              ",
  "              ",
  "              ",
  "              ",
  "              ",
  "§      /ð\\      ",
  "§     (_,ð)     ",
  "              ",
  "              ",
},
{ "ð3             ",
  "§     (ð¬¯)     ",
  "§      \\/      ",
  "              ",
  "              ",
  "§     (ð¬¯)     ",
  "§      \\/      ",
  "              ",
  "              ",
  "§      /ð\\      ",
  "§     (_,ð)     ",
  "              ",
},
{ "ð4             ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "              ",
  "              ",
  "              ",
  "              ",
  "              ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§ (_,ð)    §(_,ð) ",
  "              ",
},
{ "ð5             ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "              ",
  "              ",
  "§     (ð¬¯)     ",
  "§      \\/      ",
  "              ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§ (_,ð)    §(_,ð) ",
  "              ",
},
{ "ð6             ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "              ",
  "              ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "              ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§ (_,ð)    §(_,ð) ",
  "              ",
},
{ "ð7             ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "§     (ð¬¯)     ",
  "§      \\/      ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "              ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§ (_,ð)    §(_,ð) ",
  "              ",
},
{ "ð8             ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "§     (ð¬¯)     ",
  "§      \\/      ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "§      /ð\\      ",
  "§     (_,ð)     ",
  "§  /ð\\      §/ð\\  ",
  "§ (_,ð)    §(_,ð) ",
  "              ",
},
{ "ð9§(ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "              ",
  "§ (ð¬¯)    §(ð¬¯) ",
  "§  \\/      \\/  ",
  "§     (ð¬¯)     ",
  "§      \\/      ",
  "§  /ð\\      §/ð\\  ",
  "§ (_,ð)    §(_,ð) ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§ (_,ð)    §(_,ð) ",
},
{ "ð10§(ð¬¯)  §(ð¬¯)  ",
  "§   \\/    \\/   ",
  "              ",
  "§ (ð¬¯)§(ð¬¯)§(ð¬¯) ",
  "§  \\/  \\/  \\/  ",
  "              ",
  "              ",
  "§  /ð\\  §/ð\\  §/ð\\  ",
  "§ (_,ð)§(_,ð)§(_,ð) ",
  "              ",
  "§   /ð\\    §/ð\\   ",
  "§  (_,ð)  §(_,ð)  ",
},
{ "ðJ         §(ð¬¯)",
  "¶.--------- §\\/ ",
  "¶|    æ[.]    ¶. ",
  "¶|  æ...§Tæ...  ¶| ",
  "¶| æ`l'¬¶Yæ¬þ`æ¬' ¶| ",
  "¶| þ, ¶. . þ..· ¶| ",
  "¶|   · þ· ¶· þ` ¶| ",
  "¶|   þ' ²¤ þ`   ¶| ",
  "¶|  ·þ/| |\\·  ¶| ",
  "¶`-----------' ",
  "§ /ð\\  ¶T¢UNNELS  ",
  "§(_,ð) ¶& T¢ROLLS ",
},
{ "ðQ         §(ð¬¯)",
  "¶.--------- §\\/ ",
  "¶|  ç·¯³)(ç··³)  ¶. ",
  "¶| ³(ç·³(ç¯))(.³)ç.¶| ",
  "¶|ç·¯³))ç)   (³(ç.¶| ",
  "¶|ç.³((ç(æ-  -ç(( ¶| ",
  "¶|ç.-³)ç))   þ'ç)³)¶| ",
  "¶| ç·³(ç(.þ--'ç(³(ç¯¶| ",
  "¶|þ·¯ç.³)ç)  þ'ç.)·¶| ",
  "¶`-----------' ",
  "§ /ð\\  ¶T¢UNNELS  ",
  "§(_,ð) ¶& T¢ROLLS ",
},
{ "ðK         §(ð¬¯)",
  "¶.--------- §\\/ ",
  "¶|ç.   ..     ¶. ",
  "¶|ç:.··  ··.: ¶| ",
  "¶|·        · | ",
  "¶|  §*    §*  ç.¶| ",
  "¶|           | ",
  "¶|  þ`VvvV'   ¶| ",
  "¶|   þ·^^·    ¶| ",
  "¶`-----------' ",
  "§ /ð\\  ¶T¢UNNELS  ",
  "§(_,ð) ¶& T¢ROLLS ",
},
{ "ðA             ",
  "              ",
  "ð   __    __   ",
  "§ .·ð¯¬·§..·ð¯¬·. ",
  "§ l          ð; ",
  "§  ·.      .·  ",
  "§    ·.  .·    ",
  "§      \\ð/      ",
  "              ",
  "¶   T¢UNNELS    ",
  "¶   & T¢ROLLS   ",
  "              ",
},
{ "ð2             ",
  "              ",
  "§      /ð\\      ",
  "§      \\/      ",
  "              ",
  "              ",
  "              ",
  "              ",
  "§      /ð\\      ",
  "§      \\/      ",
  "              ",
  "              ",
},
{ "ð3             ",
  "§      /ð\\      ",
  "§      \\/      ",
  "              ",
  "              ",
  "§      /ð\\      ",
  "§      \\/      ",
  "              ",
  "              ",
  "§      /ð\\      ",
  "§      \\/      ",
  "              ",
},
{ "ð4             ",
  "              ",
  "§   /ð\\    §/ð\\   ",
  "§   \\/    \\/   ",
  "              ",
  "              ",
  "              ",
  "              ",
  "§   /ð\\    §/ð\\   ",
  "§   \\/    \\/   ",
  "              ",
  "              ",
},
{ "ð5             ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
  "§      /ð\\      ",
  "§      \\/      ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
  "              ",
},
{ "ð6             ",
  "§   /ð\\    §/ð\\   ",
  "§   \\/    \\/   ",
  "              ",
  "              ",
  "§   /ð\\    §/ð\\   ",
  "§   \\/    \\/   ",
  "              ",
  "              ",
  "§   /ð\\    §/ð\\   ",
  "§   \\/    \\/   ",
  "              ",
},
{ "ð7             ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "§      /ð\\      ",
  "§      \\/      ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
},
{ "ð8             ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "§      /ð\\      ",
  "§      \\/      ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "§      /ð\\      ",
  "§      \\/      ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
},
{ "ð9 §/ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/  /ð\\  §\\/  ",
  "§      \\/      ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
},
{ "ð10§/ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "§      /ð\\      ",
  "§  /ð\\  §\\/  /ð\\  ",
  "§  \\/      \\/  ",
  "              ",
  "§  /ð\\  §/ð\\  §/ð\\  ",
  "§  \\/  \\/  \\/  ",
  "              ",
  "§  /ð\\      §/ð\\  ",
  "§  \\/      \\/  ",
  "              ",
},
{ "ðJ          §/ð\\ ",
  "¶.--------- §\\/ ",
  "¶|    æ[.]    ¶. ",
  "¶|  æ...§Tæ...  ¶| ",
  "¶| æ`l'¬¶Yæ¬þ`æ¬' ¶| ",
  "¶| þ, ¶. . þ..· ¶| ",
  "¶|   · þ· ¶· þ` ¶| ",
  "¶|   þ' ²¤ þ`   ¶| ",
  "¶|  ·þ/| |\\·  ¶| ",
  "¶`-----------' ",
  "§ /ð\\  ¶¢TUNNELS  ",
  "§ \\/  ¶& T¢ROLLS ",
},
{ "ðQ          §/ð\\ ",
  "¶.--------- §\\/ ",
  "¶|  ç·¯³)(ç··³)  ¶. ",
  "¶| ³(ç·³(ç¯))(.³)ç.¶| ",
  "¶|ç·¯³))ç)   (³(ç.¶| ",
  "¶|ç.³((ç(æ-  -ç(( ¶| ",
  "¶|ç.-³)ç))   þ'ç)³)¶| ",
  "¶| ç·³(ç(.þ--'ç(³(ç¯¶| ",
  "¶|þ·¯ç.³)ç)  þ'ç.)·¶| ",
  "¶`-----------' ",
  "§ /ð\\  ¶¢TUNNELS  ",
  "§ \\/  ¶& T¢ROLLS ",
},
{ "ðK          §/ð\\ ",
  "¶.--------- §\\/ ",
  "¶|ç.   ..     ¶. ",
  "¶|ç:.··  ··.: ¶| ",
  "¶|·        · | ",
  "¶|  §*    §*  ç.¶| ",
  "¶|           | ",
  "¶|  þ`VvvV'   ¶| ",
  "¶|   þ·^^·    ¶| ",
  "¶`-----------' ",
  "§ /ð\\  ¶T¢UNNELS  ",
  "§ \\/  ¶& T¢ROLLS ",
},
{ "ðA             ",
  "              ",
  "ð      /\\      ",
  "§     /  ð\\     ",
  "§    /    ð\\    ",
  "§    \\    ð/    ",
  "§     \\  /     ",
  "§      \\/      ",
  "              ",
  "¶   T¢UNNELS    ",
  "¶   & T¢ROLLS   ",
  "              ",
} };

/* MODULE const STRPTR cardimage[52][14] = {
{ ".--------------.",
  "|2     /\\      |",
  "|     (__)     |",
  "|      ][      |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|      ][      |",
  "|     (¯¬)     |",
  "|      \\/      |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|3     /\\      |",
  "|     (__)     |",
  "|      ][      |",
  "|              |",
  "|      /\\      |",
  "|     (__)     |",
  "|      ][      |",
  "|              |",
  "|              |",
  "|      ][      |",
  "|     (¯¬)     |",
  "|      \\/      |",
  "`--------------'", },
{ ".--------------.",
  "|4 /\\      /\\  |",
  "| (__)    (__) |",
  "|  ][      ][  |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|  ][      ][  |",
  "| (¯¬)    (¯¬) |",
  "|  \\/      \\/  |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|5  /\\    /\\   |",
  "|  (__)  (__)  |",
  "|   ][    ][   |",
  "|              |",
  "|      /\\      |",
  "|     (__)     |",
  "|      ][      |",
  "|              |",
  "|              |",
  "|   ][    ][   |",
  "|  (¯¬)  (¯¬)  |",
  "|   \\/    \\/   |",
  "`--------------'", },
{ ".--------------.",
  "|6 /\\      /\\  |",
  "| (__)    (__) |",
  "|  ][      ][  |",
  "|              |",
  "|  /\\      /\\  |",
  "| (__)    (__) |",
  "|  ][      ][  |",
  "|              |",
  "|              |",
  "|  ][      ][  |",
  "| (¯¬)    (¯¬) |",
  "|  \\/      \\/  |",
  "`--------------'", },
{ ".--------------.",
  "|7 /\\      /\\  |",
  "| (__)    (__) |",
  "|  ][  /\\  ][  |",
  "|     (__)     |",
  "|  /\\  ][  /\\  |",
  "| (__)    (__) |",
  "|  ][      ][  |",
  "|              |",
  "|              |",
  "|  ][      ][  |",
  "| (¯¬)    (¯¬) |",
  "|  \\/      \\/  |",
  "`--------------'", },
{ ".--------------.",
  "|8 /\\      /\\  |",
  "| (__)    (__) |",
  "|  ][  /\\  ][  |",
  "|     (__)     |",
  "|  /\\  ][  /\\  |",
  "| (__)    (__) |",
  "|  ][  ][  ][  |",
  "|     (¯¬)     |",
  "|      \\/      |",
  "|  ][      ][  |",
  "| (¯¬)    (¯¬) |",
  "|  \\/      \\/  |",
  "`--------------'", },
{ ".--------------.",
  "|9 /\\      /\\  |",
  "| (__)    (__) |",
  "|  ][      ][  |",
  "|  /\\      /\\  |",
  "| (__) /\\ (__) |",
  "|  ][ (__) ][  |",
  "|  ][  ][  ][  |",
  "| (¯¬)    (¯¬) |",
  "|  \\/      \\/  |",
  "|  ][      ][  |",
  "| (¯¬)    (¯¬) |",
  "|  \\/      \\/  |",
  "`--------------'", },
{ ".--------------.",
  "|10 /\\    /\\   |",
  "|  (__)  (__)  |",
  "|   ][    ][   |",
  "|  /\\  /\\  /\\  |",
  "| (__)(__)(__) |",
  "|  ][  ][  ][  |",
  "|  ][  ][  ][  |",
  "| (¯¬)(¯¬)(¯¬) |",
  "|  \\/  \\/  \\/  |",
  "|   ][    ][   |",
  "|  (¯¬)  (¯¬)  |",
  "|   \\/    \\/   |",
  "`--------------'", },
{ ".--------------.",
  "|J          /\\ |",
  "|.-------- (__)|",
  "||    [.]   ][ |",
  "||  ...T...  . |",
  "|| `l'¬Y¬`¬' | |",
  "|| , . . ..· | |",
  "||   · · · ` | |",
  "||   ' ¤ `   | |",
  "|·  ·/| |\\·  | |",
  "| ][ --------' |",
  "|(¯¬) TUNNELS  |",
  "| \\/  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|Q          /\\ |",
  "|.-------- (__)|",
  "||  ·¯)(··) ][ |",
  "|| (·(¯))(.).. |",
  "||·¯)))   ((.| |",
  "||.(((-  -(( | |",
  "||.-)))   '))| |",
  "|| ·((.--'((¯| |",
  "|··¯.))  '.)·| |",
  "| ][ --------' |",
  "|(¯¬) TUNNELS  |",
  "| \\/  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|K          /\\ |",
  "|.-------- (__)|",
  "||.   ..   .][ |",
  "||:.··  ··.: . |",
  "||·        · | |",
  "||  *    *  .| |",
  "||           | |",
  "||  `VvvV'   | |",
  "|·   ·^^·    | |",
  "| ][ --------' |",
  "|(¯¬) TUNNELS  |",
  "| \\/  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|A             |",
  "|      /\\      |",
  "|    .·  ·.    |",
  "|  .·      ·.  |",
  "| |          | |",
  "| `.__....__.' |",
  "|   ¯¯ || ¯¯   |",
  "|     _¦¦_     |",
  "|     ¯¯¯¯     |",
  "|   TUNNELS    |",
  "|   & TROLLS   |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|2             |",
  "|      ()      |",
  "|     ()()     |",
  "|      ][      |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|      ][      |",
  "|     ()()     |",
  "|      ()      |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|3     ()      |",
  "|     ()()     |",
  "|      ][      |",
  "|              |",
  "|      ()      |",
  "|     ()()     |",
  "|      ][      |",
  "|              |",
  "|      ][      |",
  "|     ()()     |",
  "|      ()      |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|4             |",
  "|  ()      ()  |",
  "| ()()    ()() |",
  "|  ][      ][  |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|  ][      ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|5             |",
  "|  ()      ()  |",
  "| ()()    ()() |",
  "|  ][      ][  |",
  "|      ()      |",
  "|     ()()     |",
  "|      ][      |",
  "|              |",
  "|  ][      ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|6             |",
  "|  ()      ()  |",
  "| ()()    ()() |",
  "|  ][      ][  |",
  "|              |",
  "|  ()      ()  |",
  "| ()()    ()() |",
  "|  ][      ][  |",
  "|              |",
  "|  ][      ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "`--------------'", },
{ ".--------------.",
  "|7             |",
  "|  ()      ()  |",
  "| ()()    ()() |",
  "|  ][  ()  ][  |",
  "|     ()()     |",
  "|  ()  ][  ()  |",
  "| ()()    ()() |",
  "|  ][      ][  |",
  "|              |",
  "|  ][      ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "`--------------'", },
{ ".--------------.",
  "|8             |",
  "|  ()      ()  |",
  "| ()()    ()() |",
  "|  ][  ()  ][  |",
  "|     ()()     |",
  "|  ()  ][  ()  |",
  "| ()()    ()() |",
  "|  ][  ][  ][  |",
  "|     ()()     |",
  "|  ][  ()  ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "`--------------'", },
{ ".--------------.",
  "|9 ()      ()  |",
  "| ()()    ()() |",
  "|  ][      ][  |",
  "|  ()      ()  |",
  "| ()() () ()() |",
  "|  ][ ()() ][  |",
  "|  ][  ][  ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "|  ][      ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "`--------------'", },
{ ".--------------.",
  "|10()      ()  |",
  "| ()()    ()() |",
  "|  ][  ()  ][  |",
  "|  () ()() ()  |",
  "| ()() ][ ()() |",
  "|  ][      ][  |",
  "|  ][      ][  |",
  "| ()() ][ ()() |",
  "|  () ()() ()  |",
  "|  ][  ()  ][  |",
  "| ()()    ()() |",
  "|  ()      ()  |",
  "`--------------'", },
{ ".--------------.",
  "|J          () |",
  "|.-------- ()()|",
  "||    [.]   ][ |",
  "||  ...T...  . |",
  "|| `l'¬Y¬`¬' | |",
  "|| , . . ..· | |",
  "||   · · · ` | |",
  "||   ' ¤ `   | |",
  "|·  ·/| |\\·  | |",
  "| ][ --------' |",
  "|()() TUNNELS  |",
  "| ()  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|Q          () |",
  "|.-------- ()()|",
  "||  ·¯)(··) ][ |",
  "|| (·(¯))(.).. |",
  "||·¯)))   ((.| |",
  "||.(((-  -(( | |",
  "||.-)))   '))| |",
  "|| ·((.--'((¯| |",
  "|··¯.))  '.)·| |",
  "| ][ --------' |",
  "|()() TUNNELS  |",
  "| ()  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|K          () |",
  "|.-------- ()()|",
  "||.   ..    ][ |",
  "||:.··  ··.: . |",
  "||·        · | |",
  "||  *    *  .| |",
  "||           | |",
  "||  `VvvV'   | |",
  "|·   ·^^·    | |",
  "| ][ --------' |",
  "|()() TUNNELS  |",
  "| ()  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|A             |",
  "|    .----.    |",
  "|    l    |    |",
  "|  .--·  ·--.  |",
  "|  |        |  |",
  "|  `--·..·--'  |",
  "|      ||      |",
  "|    .-'`-.    |",
  "|    ¯¯¯¯¯¯    |",
  "|   TUNNELS    |",
  "|   & TROLLS   |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|2             |",
  "|     (¬¯)     |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|      /\\      |",
  "|     (_,)     |",
  "|              |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|3             |",
  "|     (¬¯)     |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "|     (¬¯)     |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "|      /\\      |",
  "|     (_,)     |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|4             |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|  /\\      /\\  |",
  "| (_,)    (_,) |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|5             |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|              |",
  "|              |",
  "|     (¬¯)     |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "|  /\\      /\\  |",
  "| (_,)    (_,) |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|6             |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|              |",
  "|              |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|              |",
  "|              |",
  "|  /\\      /\\  |",
  "| (_,)    (_,) |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|7             |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|     (¬¯)     |",
  "|      \\/      |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|              |",
  "|              |",
  "|  /\\      /\\  |",
  "| (_,)    (_,) |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|8             |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|     (¬¯)     |",
  "|      \\/      |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|      /\\      |",
  "|     (_,)     |",
  "|  /\\      /\\  |",
  "| (_,)    (_,) |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|9(¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|              |",
  "| (¬¯)    (¬¯) |",
  "|  \\/      \\/  |",
  "|     (¬¯)     |",
  "|      \\/      |",
  "|  /\\      /\\  |",
  "| (_,)    (_,) |",
  "|              |",
  "|  /\\      /\\  |",
  "| (_,)    (_,) |",
  "`--------------'", },
{ ".--------------.",
  "|10(¬¯)  (¬¯)  |",
  "|   \\/    \\/   |",
  "|              |",
  "| (¬¯)(¬¯)(¬¯) |",
  "|  \\/  \\/  \\/  |",
  "|              |",
  "|              |",
  "|  /\\  /\\  /\\  |",
  "| (_,)(_,)(_,) |",
  "|              |",
  "|   /\\    /\\   |",
  "|  (_,)  (_,)  |",
  "`--------------'", },
{ ".--------------.",
  "|J         (¬¯)|",
  "|.--------- \\/ |",
  "||    [.]    . |",
  "||  ...T...  | |",
  "|| `l'¬Y¬`¬' | |",
  "|| , . . ..· | |",
  "||   · · · ` | |",
  "||   ' ¤ `   | |",
  "||  ·/| |\\·  | |",
  "|`-----------' |",
  "| /\\  TUNNELS  |",
  "|(_,) & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|Q         (¬¯)|",
  "|.--------- \\/ |",
  "||  ·¯)(··)  . |",
  "|| (·(¯))(.).| |",
  "||·¯)))   ((.| |",
  "||.(((-  -(( | |",
  "||.-)))   '))| |",
  "|| ·((.--'((¯| |",
  "||·¯.))  '.)·| |",
  "|`-----------' |",
  "| /\\  TUNNELS  |",
  "|(_,) & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|K         (¬¯)|",
  "|.--------- \\/ |",
  "||.   ..     . |",
  "||:.··  ··.: | |",
  "||·        · | |",
  "||  *    *  .| |",
  "||           | |",
  "||  `VvvV'   | |",
  "||   ·^^·    | |",
  "|`-----------' |",
  "| /\\  TUNNELS  |",
  "|(_,) & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|A             |",
  "|              |",
  "|   __    __   |",
  "| .·¯¬·..·¯¬·. |",
  "| l          ; |",
  "|  ·.      .·  |",
  "|    ·.  .·    |",
  "|      \\/      |",
  "|              |",
  "|   TUNNELS    |",
  "|   & TROLLS   |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|2             |",
  "|              |",
  "|      /\\      |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|      /\\      |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|3             |",
  "|      /\\      |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "|      /\\      |",
  "|      \\/      |",
  "|              |",
  "|              |",
  "|      /\\      |",
  "|      \\/      |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|4             |",
  "|              |",
  "|   /\\    /\\   |",
  "|   \\/    \\/   |",
  "|              |",
  "|              |",
  "|              |",
  "|              |",
  "|   /\\    /\\   |",
  "|   \\/    \\/   |",
  "|              |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|5             |",
  "|              |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "|      /\\      |",
  "|      \\/      |",
  "|              |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|6             |",
  "|   /\\    /\\   |",
  "|   \\/    \\/   |",
  "|              |",
  "|              |",
  "|   /\\    /\\   |",
  "|   \\/    \\/   |",
  "|              |",
  "|              |",
  "|   /\\    /\\   |",
  "|   \\/    \\/   |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|7             |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|      /\\      |",
  "|      \\/      |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "|              |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|8             |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|      /\\      |",
  "|      \\/      |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|      /\\      |",
  "|      \\/      |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|9 /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "|  /\\      /\\  |",
  "|  \\/  /\\  \\/  |",
  "|      \\/      |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|10/\\      /\\  |",
  "|  \\/      \\/  |",
  "|      /\\      |",
  "|  /\\  \\/  /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "|  /\\  /\\  /\\  |",
  "|  \\/  \\/  \\/  |",
  "|              |",
  "|  /\\      /\\  |",
  "|  \\/      \\/  |",
  "|              |",
  "`--------------'", },
{ ".--------------.",
  "|J          /\\ |",
  "|.--------- \\/ |",
  "||    [.]    . |",
  "||  ...T...  | |",
  "|| `l'¬Y¬`¬' | |",
  "|| , . . ..· | |",
  "||   · · · ` | |",
  "||   ' ¤ `   | |",
  "||  ·/| |\\·  | |",
  "|`-----------' |",
  "| /\\  TUNNELS  |",
  "| \\/  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|Q          /\\ |",
  "|.--------- \\/ |",
  "||  ·¯)(··)  . |",
  "|| (·(¯))(.).| |",
  "||·¯)))   ((.| |",
  "||.(((-  -(( | |",
  "||.-)))   '))| |",
  "|| ·((.--'((¯| |",
  "||·¯.))  '.)·| |",
  "|`-----------' |",
  "| /\\  TUNNELS  |",
  "| \\/  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|K          /\\ |",
  "|.--------- \\/ |",
  "||.   ..     . |",
  "||:.··  ··.: | |",
  "||·        · | |",
  "||  *    *  .| |",
  "||           | |",
  "||  `VvvV'   | |",
  "||   ·^^·    | |",
  "|`-----------' |",
  "| /\\  TUNNELS  |",
  "| \\/  & TROLLS |",
  "`--------------'", },
{ ".--------------.",
  "|A             |",
  "|              |",
  "|      /\\      |",
  "|     /  \\     |",
  "|    /    \\    |",
  "|    \\    /    |",
  "|     \\  /     |",
  "|      \\/      |",
  "|              |",
  "|   TUNNELS    |",
  "|   & TROLLS   |",
  "|              |",
  "`--------------'", } }; */

MODULE int                    winnings;
MODULE FLAG                   wp[10];

IMPORT FLAG                   rawmode,
                              logconsole;
IMPORT TEXT                   screen[65536 + 1],
                              userstring[40 + 1];
IMPORT int                    been[MOST_ROOMS + 1],
                              column,
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              owed_st,
                              max_st, max_con,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, module,
                              row,
                              spellchosen,
                              target, throw,
                              theround;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];
IMPORT struct SpellInfoStruct spellinfo[20 + 1];

IMPORT void (* enterroom) (void);

MODULE void ct_enterroom(void);
MODULE int halfof(int number);
MODULE void ct_wandering(void);

EXPORT void ct_preinit(void)
{
#ifdef WIN32
    int i, j, k;
#endif

    descs[MODULE_CT]   = ct_desc;
    wanders[MODULE_CT] = ct_wandertext;

#ifdef WIN32
    for (i = 0; i < 52; i++)
    {   for (j = 0; j < 12; j++)
        {   k = 0;
            while (cardimage_ansi[i][j][k] != EOS)
            {   if (istrouble(cardimage_ansi[i][j][k]))
                {   // aprintf("%d,%d,%d: $%X!\n", i, j, k, (TEXT) cardimage_ansi[i][j][k]);
                    cardimage_ansi[i][j][k] = '!';
                }
                k++;
    }   }   }
#endif
}

EXPORT void ct_init(void)
{   int i;

    exits     = &ct_exits[0][0];
    enterroom = ct_enterroom;
    for (i = 0; i < CT_ROOMS; i++)
    {   pix[i] = ct_pix[i];
    }

    for (i = 0; i < 10; i++)
    {   wp[i] = TRUE; // alive
}   }

MODULE void ct_enterroom(void)
{   TRANSIENT int  archers,
                   besttreasure,
                   bestvalue,
                   bet,
                   choice,
                   evilcon,
                   eviltotal,
                   goodcon,
                   goodtotal,
                   halfcon,
                   i,
                   result1,
                   result2,
                   result3,
                   temp;
    TRANSIENT FLAG ok;

    switch (room)
    {
    case 0:
        winnings = 0;
        if (!been[0])
        {   DISCARD pay_gp(20); // %%: what happens if you can't pay the tip? We assume nothing happens.
        }
    acase 2:
        if (class == ROGUE)
        {   room = 43;
        }
    acase 3:
#ifndef CENSORED
        lose_flag_ability(88);
#endif
        gain_flag_ability(2);
    acase 5:
        if (race == ORC)
        {   room = 220;
        }
    acase 6:
        give(169);
    acase 7:
        result1 = dice(2);
        switch (result1)
        {
        case 2:
            gain_flag_ability(4);
        acase 3:
            gain_flag_ability(5);
        acase 4:
            gain_flag_ability(6);
        acase 5:
            gain_flag_ability(7);
        acase 6:
            gain_flag_ability(8);
            change_chr(1);
        acase 7:
            gain_flag_ability(9);
            change_chr(3);
        acase 8:
            gain_flag_ability(10);
        acase 9:
            gain_flag_ability(11);
        acase 10:
            gain_flag_ability(0);
        acase 11:
            gain_flag_ability(12);
            change_chr(3);
        acase 12:
            gain_flag_ability(13);
        }
        award(1000);
    acase 9:
        award(50);
    acase 10:
        getsavingthrow(TRUE);
        if (madeit(6, lk))
        {   room = 213;
        } elif (madeit(4, lk))
        {   module = MODULE_ND;
            room = 0;
        } else
        {   room = 12;
        }
    acase 11:
        if (ability[18].known) // lost a hand
        {   room = 163;
        }
    acase 13:
        if (cast(SPELL_BB, FALSE) && cast(SPELL_OE, FALSE))
        {   room = 137;
        } else
        {   if (!saved(level, lk))
            {   good_takehits(misseditby(level, lk), TRUE); // %%: if this would kill you, we should perhaps go to CT12
            }
            award(500);
            room = 115;
        }
    acase 14:
        change_iq(3);
        create_monster(0);
        npc_templose_st(0, 8); // for casting the spell
        fight();
        room = 89;
    acase 15:
        bet = getnumber("Bet how many gp", 0, gp); // %%: are we allowed to bet 0 gp?
        goodcon = con;
        halfcon = halfof(con);
        evilcon = 40;
        do
        {   goodtotal = dice(2) + calc_personaladds(st, lk, dex);
            eviltotal  = dice(2) + 31;
            if (goodtotal > eviltotal)
            {   evilcon -= (goodtotal - eviltotal);
            } elif (eviltotal > goodtotal)
            {   goodcon -= (eviltotal - goodtotal);
        }   }
        while (goodcon > halfcon && evilcon > 20);
        // %%: it's ambiguous about whether the scorpion affects the loser of each round, or just the overall loser.
        if (evilcon <= 20)
        {   // winner
            aprintf("You won!\n");
            give_gp(bet);
            winnings += bet;
            room = 101;
        } else
        {   // loser
            aprintf("You lost!\n");
            templose_con(3); // %%: it's ambiguous about whether this is for the rest of the adventure
            owe_st(st / 2);
            pay_gp(bet);
            winnings -= bet;
            room = 109;
        }
    acase 16:
        gain_flag_ability(14);
        result1 = dice(1);
        templose_con(result1); // %%: do they mean current CON or maximum CON?
        lose_dex(result1);
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].type == WEAPON_BOW)
            {   dropitems(i, items[i].owned);
        }   }
    acase 17:
        choice = getnumber("1) Handle the operations for Biorom\n2) Back out of your deal with Biorom\nWhich", 1, 2);
        if (choice == 1)
        {   for (i = 1; i <= 5; i++)
            {   if (dice(1) == dice(1))
                {   aprintf("Operation #%d was successful.\n", i);
                    choice = getnumber("1) Gain 1 IQ\n2) Gain 1 DEX\nWhich", 1, 2);
                    if (choice == 1) gain_iq(1); else gain_dex(1);
                } else
                {   aprintf("Operation #%d failed.\n", i);
                    choice = getnumber("1) Have an operation yourself\n2) Run for the gate\nWhich", 1, 2);
                    if (choice == 1) room = 63; else room = 149;
                    break;
                }
                while (room == 17 && getyn("Operate again (otherwise leave)"))
                {   if (dice(1) == dice(1))
                    {   aprintf("This operation was successful.\n");
                        choice = getnumber("1) Gain 1 IQ\n2) Gain 1 DEX\nWhich", 1, 2);
                        if (choice == 1) gain_iq(1); else gain_dex(1);
                    } else
                    {   aprintf("This operation failed.\n");
                        choice = getnumber("1) Have an operation yourself\n2) Run for the gate\nWhich", 1, 2);
                        if (choice == 1) room = 63; else room = 149;
                        break;
            }   }   }
            if (room == 17)
            {   room = 115;
        }   }
        else
        {   room = 85;
        }
    acase 18:
        award(1000);
        give(173);
        create_monsters(1, 2);
        fight();
        create_monster(1);
        fight();
        create_monsters(1, 2);
        fight();
        room = 115;
    acase 19:
        ct_poker();
    acase 20:
        gain_flag_ability(19);
    acase 22:
        if (cast(SPELL_PA, FALSE))
        {   room = 70;
        }
    acase 23:
        award(68);
        rb_givejewels(-1, -1, 1, 3);
    acase 24:
        if (spellchosen == SPELL_ES || spellchosen == SPELL_OE)
        {   room = 84;
        } else
        {   room = 152;
        }
    acase 25:
        owe_chr(chr / 2);
    acase 26:
        die();
    acase 27:
        besttreasure =
        bestvalue    = -1;
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && !items[i].magical && items[i].cp >= bestvalue)
            {   besttreasure = i;
                bestvalue = items[i].cp;
        }   }
        if (besttreasure != -1)
        {   give_multi(besttreasure, dice(2));
        }
    acase 28:
        die();
    acase 29:
        if (saved(2, dex))
        {   award(100);
            room = 115;
        } else
        {   room = 12;
        }
    acase 31:
        good_takehits(dice(3), TRUE); // %%: are these taken directly off CON, or does armour help?
    acase 33:
        if (winnings <= 0) // %%: it doesn't say what happens if you neither won nor lost
        {   room = 109;
        } else
        {   pay_gp(winnings);
        }
    acase 34:
        create_monsters(2, 2);
        payload(TRUE);
        if (countfoes())
        {   fight();
        }
        give_gp(250); // %%: can you loot the pouch if going to 159? We assume so.
    acase 35:
        gain_flag_ability(3);
        drop_all();
        victory(0);
    acase 36:
        if (pay_gp(100))
        {   room = 115;
        } else
        {   die();
        }
    acase 37:
        lose_flag_ability(18);
        gain_flag_ability(20); // this hand can indeed wield a weapon, eg. see AK13.
    acase 39:
        if (saved(1, chr))
        {   room = 58;
        } else
        {   room = 110;
        }
    acase 41:
        die();
    acase 42:
        create_monsters(2, 2);
        fight();
        give(238); // these kinds of things would be better handled as real jewel[]s
        room = 187;
    acase 45:
        owe_dex(dex / 2);
    acase 46:
        if (dex < 30)
        {   ok = FALSE;
            for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && (items[i].type == WEAPON_SWORD || items[i].type == WEAPON_POLE || items[i].type == WEAPON_DAGGER))
                {   ok = TRUE;
                    break; // for speed
            }   }
            if (ok)
            {   if (getyn("Cut rope"))
                {   room = 54;
        }   }   }
        if (room == 46)
        {   create_monster(4);
            fight();
            room = 56;
        }
    acase 47:
        create_monster(3);
        fight();
    acase 48:
        if (class == WIZARD) // %%: "magic-user" seems to mean only "wizard" (eg. see CT96)
        {   room = 221;
        }
    acase 50:
        create_monster(5);
        evilattack();
        fight();
        room = 228;
    acase 51:
        if (castspell(-1, FALSE))
        {   room = 148;
        } else
        {   create_monster(6);
            fight();
            if (ability[16].known)
            {   room = 174;
            } else
            {   room = 125;
        }   }
    acase 52:
        if (castspell(-1, FALSE))
        {   room = 167;
        } else
        {   create_monster(7);
            do
            {   oneround();
                if (npc[0].con <= 15)
                {   npc[0].dice = 3;
            }   }
            while (countfoes());
            room = 207;
        }
    acase 53:
        give(181);
    acase 54:
        create_monster(4);
        if (saved(level, st))
        {   do
            {   getsavingthrow(FALSE);
                if (madeit(3, npc[0].lk))
                {   kill_npc(0);
                }
                if (!saved(level, lk))
                {   dispose_npcs();
                    room = 12;
                }
                if (countfoes())
                {   oneround();
            }   }
            while (countfoes());
            room = 69;
        } else
        {   room = 46;
        }
    acase 56:
        give(547);
    acase 57:
        drop_all();
        if (saved(level, chr))
        {   room = 164;
        } else
        {   room = 106;
        }
    acase 60:
        templose_con(con / 2);
        create_monsters(8, 2);
        fight();
        room = 6;
    acase 61:
        create_monster(9);
        good_freeattack();
        fight();
        room = 53;
    acase 63:
        if (dice(1) == dice(1)) // 1 in 6 chance
        {   room = 7;
        } else
        {   die(); // %%: because presumably this doesn't count as missing a saving roll
        }
    acase 64:
        DISCARD pay_gp(1000);
        healall_con();
        lose_flag_ability(17);
        lose_flag_ability(28);
        if (owed_st)
        {   gain_st(owed_st);
            owed_st = 0;
        }
    acase 66:
        // we don't give(170) because they already looted it from the corpse
        award(1000);
    acase 67:
        create_monsters(10, 3);
        fight();
        give_gp(dice(1) * 100);
    acase 68:
        temp = 10 - ((st + dex) / 10);
        if (temp >= 1)
        {   for (i = 1; i <= temp; i++)
            {   templose_con(dice(1));
        }   }
    acase 69:
        if (saved(3, lk))
        {   room = 129;
        } else
        {   room = 12;
        }
    acase 70:
        if (iq + lk + chr < 80)
        {   create_monsters(8, 2);
            fight();
            room = 114;
        }
    acase 71:
        if (carrying() > st * 50)
        {   die();
        } else
        {   room = 78; // we could have a "broken" arm flag but this gets healed in the next room anyway
        }
    acase 72:
        for (;;)
        {   bet = getnumber("Bet how much (0 to quit)", 0, gp);
            if (bet == 0)
            {   break;
            }
            pay_gp(bet); // %%: maybe they only pay this if they lose?
            winnings -= bet;
            result1 = dice(1);
            result2 = dice(1);
            result3 = dice(1);
            if     (result1 == result2 && result1 == result3)
            {   give_gp(bet * 4);
                winnings += bet * 4;
            } elif (result1 == result2 || result1 == result3 || result2 == result3)
            {   give_gp(bet * 2);
                winnings += bet * 2;
            } elif
            (   (result2 == result1 + 1 && result3 == result1 + 2) // 1,2,3 (or 2,3,4, etc.)
             || (result2 == result1 + 2 && result3 == result1 + 1) // 1,3,2
             || (result2 == result1 - 1 && result3 == result1 + 1) // 2,1,3
             || (result2 == result1 + 1 && result3 == result1 - 1) // 2,3,1
             || (result2 == result1 - 2 && result3 == result1 - 1) // 3,1,2
             || (result2 == result1 - 1 && result3 == result1 - 2) // 3,2,1
            ) // straight
            {   give_gp(bet + (bet / 2));
                winnings += bet + (bet / 2);
        }   }
        room = 33;
    acase 74:
        create_monster(11);
        fight();
        room = 115;
    acase 75:
        die();
    acase 76:
        gain_lk(3);
        create_monster(8);
        do
        {   if (getyn("Flee (otherwise fight)"))
            {   room = 36;
                dispose_npcs();
            } else
            {   oneround();
        }   }
        while (room == 76 && countfoes());
        if (room == 76)
        {   room = 102;
        }
    acase 78:
        heal_con((max_con - con) / 2);
        lose_flag_ability(14);
        give_gp(winnings);
        winnings = 0;
    acase 80:
        give(196);
        give(197);
    acase 81:
        if (gp >= 100 && getyn("Play poker"))
        {   DISCARD pay_gp(100); // %%: if we win the first hand we are probably supposed to get this back
            room = 19;
        } else
        {   room = 109;
        }
    acase 82:
        die();
    acase 83:
        give(237);
        award(1000);
    acase 85:
        if (cast(SPELL_HS, FALSE))
        {   room = 35;
        } else
        {   die();
        }
    acase 87:
        create_monsters(8, 2);
        good_freeattack();
        fight();
        if (saved(level, lk))
        {   room = 187;
        } else
        {   room = 12;
        }
    acase 88:
        die();
    acase 89:
        lose_chr(chr / 2);
        drop_all();
        templose_con(dice(1));
        if (ability[27].known)
        {   die();
        }
    acase 90:
        create_monster(12);
        fight();
        rb_givejewelleditem(JEWELLEDITEM_RING);
        room = 189;
    acase 92:
        give(MIS);
        create_monster(13);
        fight();
        room = 78;
    acase 93:
        if (saved(2, dex))
        {   room = 206;
        } else
        {   room = 184;
        }
    acase 94:
        die();
    acase 95:
        create_monster(14);
        fight();
        room = 103;
    acase 96:
        if (class == WARRIOR)
        {   room = 71;
        } else
        {   // assert(class == WIZARD || class == WARRIORWIZARD || class == ROGUE);
            room = 176;
        }
    acase 97:
        ct_wandering(); // %%: we're assuming CT97 is considered to be an "intersection"
    acase 98:
        // %%: is Speed considered to be an "attribute"? We are assuming so, in this case.
        // %%: it's ambiguous, as usual, about how to handle attributes that are temporarily less than the maximum.
        // %%: probably if there are several lowest attributes the player should be allowed to choose which one.
        if (max_st <= iq && max_st <= lk && max_st <= max_con && max_st  <= dex && max_st  <= chr && max_st  <= spd)
        {   permchange_st(max_st * 2);
        } elif (            iq     <= lk && iq     <= max_con && iq      <= dex && iq      <= chr && iq      <= spd)
        {   change_iq(iq * 2);
        } elif (                            lk     <= max_con && lk      <= dex && lk      <= chr && lk      <= spd)
        {   change_lk(lk * 2);
        } elif (                                                 max_con <= dex && max_con <= chr && max_con <= spd)
        {   permchange_con(max_con * 2);
        } elif (                                                                   dex     <= chr && iq      <= spd)
        {   change_dex(dex * 2);
        } elif (                                                                                     chr     <= spd)
        {   change_chr(chr * 2);
        } else
        {   change_spd(spd * 2);
        }
        award(500);
        give_gp(1000);
    acase 101:
        result1 = dice(2);
        if (result1 <= 4 || result1 >= 10)
        {   create_monster(15);
            fight();
            room = 80;
        } else
        {   room = 109;
        }
    acase 102:
        give(233);
        give(234);
    acase 103:
        getsavingthrow(TRUE);
        if (madeit(level + 2, iq))
        {   room = 178;
        } elif (madeit(level + 1, iq))
        {   room = 83;
        } elif (madeit(level, iq))
        {   room = 66;
        } else
        {   room = 27;
        }
    acase 104:
        die();
    acase 107:
        give(240);
        give_gp(1000);
    acase 109:
        winnings = 0;
    acase 111:
        healall_st();
        give_gp(winnings);
        winnings = 0;
        heal_con((max_con - con) / 2);
        lose_flag_ability(14);
        award(2000);
        if (iq >= spellinfo[2].iq && dex >= spellinfo[2].dex)
        {   learnspell(SPELL_RS);
        }
    acase 112:
        savedrooms(level, lk, 105, 217);
    acase 114:
        gain_chr(3);
        gain_lk(4);
        give(241);
    acase 115:
        ct_wandering();
    acase 116:
        if (cast(SPELL_OE, FALSE))
        {   room = 191;
        } else
        {   room = 124;
        }
    acase 117:
        die();
    acase 119:
        if (saved(level, chr))
        {   gain_flag_ability(29);
            victory(5000);
        } else
        {   room = 12;
        }
    acase 120:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == WEAPON_BOW)
            {   room = 20;
                break; // for speed
        }   }
        if (room == 120)
        {   room = 100;
        }
    acase 121:
        good_takehits(dice(3) + 5, TRUE);
    acase 122:
        give(176);
        give(177);
        if (sex == MALE)
        {   give(178);
        } else
        {   give(179);
        }
    acase 123:
        gain_iq(3);
        if (saved(level, con))
        {   give(242);
        } else
        {   room = 12;
        }
    acase 125:
        ct_wandering();
    acase 126:
        create_monster(16);
        fight();
        room = 47;
    acase 127:
        race = STATUE;
        die();
    acase 128:
        create_monster(17);
        fight();
        room = 135;
    acase 129:
        ct_wandering();
    acase 130:
        getsavingthrow(TRUE);
        result1 = madeitby(level + 1, lk);
        getsavingthrow(TRUE);
        result2 = madeitby(level + 1, lk);
        if (result1 < 0 && result2 < 0) // %%: it doesn't say whether armour helps
        {   good_takehits(12, TRUE);
        } elif (result1 < 0 || result2 < 0)
        {   good_takehits(5, TRUE);
        } // %%: if those hits killed us, we should probably go to 12
        create_monsters(8, 3);
        fight();
        if (dice(1) != dice(1))
        {   create_monsters(8, 2);
            fight();
        }
        room = 201;
    acase 131:
        makelight();
        if
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
         || lightsource() == LIGHT_WO
        )
        {   room = 55;
        } else // LIGHT_NONE or LIGHT_CE
        {   room = 204;
        }
    acase 133:
        create_monster(5);
        good_freeattack();
        fight();
        room = 23;
    acase 134:
        give_gp(1500);
        lose_chr(3);
    acase 135:
        award(2000);
    acase 137:
        give(195);
    acase 140:
    case 142:
        die();
    acase 143:
        ct_wandering();
        victory(250);
    acase 145:
        create_monster(16);
        DISCARD castspell(-1, TRUE);
        if (!countfoes())
        {   room = 9;
        } else
        {   fight();
            room = 47;
        }
        // %%: if you take several rounds to kill him but use magic every time, would you go to CT9 or CT47?
    acase 146:
        die();
    acase 147:
        ok = TRUE;
        if (dex < 18)
        {   if (!saved(2, dex))
            {   ok = FALSE;
        }   }
        if (dex < 29)
        {   if (!saved(2, dex))
            {   ok = FALSE;
        }   }
        if (dex < 45)
        {   if (!saved(2, dex))
            {   ok = FALSE;
        }   }
        if (ok)
        {   room = 5;
        } else
        {   room = 79;
        }
    acase 148:
        if (spellchosen == SPELL_BP || spellchosen == SPELL_SF || spellchosen == SPELL_TF)
        {   room = 125;
        } else
        {   room = 51;
        }
    acase 149:
        if (saved(level, iq))
        {   room = 29;
        } else
        {   room = 231;
        }
    acase 152:
        if (ability[16].known) // %%: what if they are a man-tiger but want to cast a spell? We don't allow it.
        {   room = 196;
        } elif (castspell(-1, FALSE))
        {   room = 24;
        }
    acase 153:
        die();
    acase 154:
        give(243);
    acase 155:
        if (castspell(-1, FALSE))
        {   room = 34;
        } else
        {   room = 42;
        }
    acase 158:
        if (saved(level, iq))
        {   room = 218;
        } else
        {   room = 171;
        }
    acase 159:
        create_monster(9);
        fight();
        room = 146;
    acase 160:
        gain_flag_ability(18);
        lose_dex(3);
    acase 161:
        die();
    acase 162:
        if (saved(3, lk))
        {   good_takehits(3, TRUE); // %%: it doesn't say whether armour will help
            room = 115;
        } else
        {   room = 12;
        }
    acase 163:
        // %%: it's ambiguous whether he would replace a hand not lost in this adventure
        if (getyn("Do you want a new left hand"))
        {   room = 37;
        } else
        {   healall_con();
            room = 185;
        }
    acase 164:
        if (class == WARRIOR)
        {   room = 211;
        } else
        {   room = 116;
        }
    acase 165:
        die();
    acase 166:
        gain_flag_ability(30);
        give(245);
        rb_givejewels(-1, -1, 1, 12);
        victory(9999);
    acase 167:
        create_monster(7);
        if (spellchosen != -1 && spellchosen != SPELL_PA && spell[spellchosen].combat)
        {   payload(TRUE);
        }
        if (countfoes())
        {   die();
        } else
        {   room = 207;
        }
    acase 169:
        makelight();
        if
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
         || lightsource() == LIGHT_WO
         || lightsource() == LIGHT_CRYSTAL
        )
        {   room = 76;
        } else // LIGHT_NONE or LIGHT_CE
        {   room = 36;
        }
    acase 170:
        give(171);
        award(1000);
    acase 171:
        if (saved(level, iq))
        {   room = 218;
        } else
        {   room = 12;
        }
    acase 174:
        result1 = dice(2);
        if (result1 == 2 || result1 == 12)
        {   award(1000);
        }
    acase 175:
        die();
    acase 176:
        DISCARD castspell(-1, FALSE);
        if (spellchosen != -1 && spell[spellchosen].combat)
        {   if (carrying() > st * 100)
            {   die();
            } else
            {   room = 78;
        }   }
        else
        {   die(); // %%: it's ambiguous about what to do if we can't cast a spell
        }
    acase 178:
        give(244);
        award(1000);
    acase 179:
        savedrooms(level + 3, lk, 115, 12);
    acase 180:
        savedrooms(2, iq, 99, 63);
    acase 181:
        makeclone(0);
        makeclone(1);
        fight();
        room = 135;
    acase 182:
        die();
    acase 184:
        room = 12;
    acase 185:
        ct_wandering();
    acase 186:
        create_monster(12);
        fight();
        room = 122;
    acase 187:
        ; // %%: is this considered to be an "intersection" (we are assuming not)?
    acase 188:
        create_monster(5);
        fight();
        room = 23;
    acase 189:
        ct_wandering();
    acase 192:
        die();
    acase 194:
        if (class == WARRIOR)
        {   room = 75;
        } else
        {   room = 28;
        }
    acase 195:
        getsavingthrow(TRUE);
        if (madeit(level + 2, lk))
        {   room = 139;
        } elif (madeit(level + 1, lk))
        {   room = 32;
        } elif (madeit(level, lk))
        {   room = 188;
        } else
        {   room = 50;
        }
    acase 198:
        rb_givejewel(-1, -1, 2);
        if (0) // (jewel[jewels - 1].itemtype == JEWELLEDITEM_NECKLACE)
        {   room = 212;
        } else
        {   room = 125;
        }
    acase 199:
        create_monsters(8, 2);
        fight();
        give_gp(dice(1) * 100);
        room = 115;
    acase 201:
        award(250);
        give_gp(500);
    acase 206:
        // %%: what exactly is meant by "one jewelled piece of treasure"?
        if (getyn("Take gold (otherwise jewel)"))
        {   encumbrance();
            give_gp((st * 100) - carrying());
        } else
        {   rb_givejewel(-1, -1, 2);
        }
    acase 207:
        give_gp(100);
    acase 209:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == WEAPON_BOW)
            {   room = 16;
                break; // for speed
        }   }
        if (room == 209)
        {   create_monster(18);
            archers = 5;
            // %%: do they all get to attack together?
            do
            {   oneround();
                if (theround % 5 == 0)
                {   archers++;
                }
                if (!countfoes() && archers)
                {   archers--;
                    create_monster(18);
                }
                templose_con(archers);
            } while (archers);
            room = 225;
        }
    acase 210:
        create_monsters(8, 3);
        fight();
        create_monsters(8, 3);
        fight();
        create_monsters(8, 4);
        fight();
        room = 201;
    acase 211:
#ifndef CENSORED
        if (sex == FEMALE)
        {   room = 216;
        }
#endif
    acase 212:
        die();
    acase 213:
        permlose_st(st / 2); // %%: it doesn't say whether permanent or temporary
        lose_lk(lk / 2);
        lose_dex(dex / 2);
        gain_iq(2);
        if (getyn("Commit suicide"))
        {   die();
        }
    acase 214:
        create_monster(19);
        fight();
        room = 135;
    acase 215:
        give(182);
    acase 217:
        makelight();
        if
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
         || lightsource() == LIGHT_WO
         || lightsource() == LIGHT_CRYSTAL
        )
        {   room = 140;
        } else // LIGHT_NONE or LIGHT_CE
        {   room = 172;
        }
    acase 218:
        create_monster(20);
        fight();
        room = 150;
    acase 221:
        if (castspell(-1, FALSE))
        {   room = 193;
        } else
        {   room = 48;
        }
    acase 222:
        give_gp(dice(1) * 1000);
        if (iq >= 25)
        {   room = 215;
        } else
        {   room = 189;
        }
    acase 223:
        create_monster(21);
        fight();
        room = 166;
    acase 224:
        if (saved(3, lk))
        {   room = 138;
        } else
        {   room = 12;
        }
    acase 225:
        gain_flag_ability(31);
    acase 226:
        die();
    acase 228:
        // %%: perhaps you are expected to quaff this vial immediately
        give(246);
        give(247);
    acase 230:
        if (saved(level, dex))
        {   room = 96;
        } else
        {   room = 12;
        }
    acase 233:
        lose_flag_ability(88);
        gain_chr(3);
}   }

MODULE int halfof(int number)
{   if (number % 2)
    {   return((number / 2) + 1);
    } else
    {   return(number / 2);
}   }

MODULE void ct_wandering(void)
{   int choice,
        result,
        whichwp;

    aprintf(
"WANDERING PEOPLE\n" \
"  In this adventure, we have Wandering People instead of Wandering Monsters. This list is a motley crew that one might find in a city the size of Gull. These creatures have their attributes written out[, and you may want to make up cards for many of them as well and include them among the other Wandering People].\n" \
"  You should make up a character card for all the people below. Put the cards in a pile, face down, and when you meet a Wandering Person (which is every time you come to an intersection of roads while in the adventure and any other time you are specifically instructed to do so), pull off the top card. Decide what action should take place, do it, and then return the card to the bottom of the pile.\n" \
"  A note on Status Codes: these refer to the general status behaviour-types of the person or people involved.\n" \
"  (MF): Monster Fodder. These are characters that go around unarmed and are worth about 25 ap to anyone who kills them.\n" \
"  (ZZ): Bully Type. Will only attack if he has a friend there or is clearly stronger than the person he faces.\n" \
"  (P): Perilous. These are scoundrels and thieves, but they are quite dangerous. They can kill and should be regarded with caution.\n" \
"  (AA): Always Attack. These are really rotten characters who ought to be killed. Would you want one to marry your sister?\n" \
"  (CA): Conditional Attack. Mostly good people, they will attack if provoked.\n" \
"  (MT): Monster-Tough. Monsters ought to find these characters rather tough to deal with. [If a monster kills one of these, he should get three times the total of the attributes in ap.]\n"
    );

    whichwp = anydice(1, 10) - 1;
    if (wp[whichwp] == FALSE)
    {   return; // already dead
    }
    aprintf("%s\n", ct_wandertext[whichwp]);

    switch (whichwp)
    {
    case 0:
        choice = getnumber("1) Attack\n2) Give him 10%\nWhich", 1, 2);
        if (choice == 1)
        {   create_monster(22);
            fight();
            wp[0] = FALSE;
        } else
        {   pay_cp_only(cp / 10);
            pay_sp_only(sp / 10);
            pay_gp_only(gp / 10);
            // %%: does "10% of all the treasure" include jewels, items, etc.?
            // he should keep this money on his "card", and if you kill him later, you could get it back.
        }
    acase 1:
        choice = getnumber("1) Attack\n2) Heal 2 CON for 10 gp\n3) Neither\nWhich", 1, 3);
        if (choice == 1)
        {   create_monster(23);
            fight();
            wp[1] = FALSE;
        } elif (choice == 2)
        {   if (pay_gp(10))
            {   // he should keep this money on his "card", and if you kill him later, you could get it back.
                heal_con(2);
        }   }
    acase 2:
        if (dice(1) <= 4)
        {   create_monster(24);
            create_monster(32);
            fight();
            wp[2] = FALSE;
        } elif (getyn("Attack"))
        {   create_monster(24);
            fight();
            wp[2] = FALSE;
        }
    acase 3:
        // %%: it doesn't say whether we can sell jewels to him. We assume so.
        choice = getnumber("1) Attack\n2) Sell\n3) Neither\nWhich", 1, 3);
        if (choice == 1)
        {   create_monster(25);
            fight();
            wp[3] = FALSE;
        } elif (choice == 2)
        {   shop_sell(90, 90);
        }
    acase 4:
        if (dice(1) <= 2)
        {   create_monster(26);
            fight();
            wp[4] = FALSE;
        } else
        {   pay_gp(gp);
            // he should keep this money on his "card", and if you kill him later, you could get it back.
        }
    acase 5: // Seth the Slaver
        create_monster(27);
        fight();
        give_gp(500);
        wp[5] = FALSE;
    acase 6:
        result = dice(2);
        if (result == 2 || result == 12 || getyn("Attack"))
        {   create_monster(28);
            fight();
            give_gp(5000); // for his diamond hand
            wp[6] = FALSE;
        }
    acase 7:
        create_monster(29);
        fight();
        wp[7] = FALSE;
    acase 8:
        if (getyn("Attack"))
        {   create_monster(30);
            fight();
            wp[8] = FALSE;
        }
    acase 9:
        if (dice(1) == dice(1) || getyn("Attack"))
        {   create_monster(31);
            fight();
            wp[9] = FALSE;
}   }   }

EXPORT void ct_poker(void)
{   TRANSIENT       FLAG   dealt[52],
                           flush,
                           straight;
    TRANSIENT       int    besthand,
                           bestplayer,
                           bestplayers,
                           bet,
                           card[7][5],
                           sortedcard[7][5],
                           i, j, k, l,
                           oddcard[5] = {0, 0, 0, 0, 0},       // initialized to avoid spurious SAS/C warnings
                           players,
                           points[7]  = {0, 0, 0, 0, 0, 0, 0}, // initialized to avoid spurious SAS/C warnings
                           pot,
                           setof[13]  = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                           twos, threes, fours,
                           which;
    TRANSIENT       STRPTR verdict[7] = {NULL, NULL, NULL, NULL, NULL, NULL, NULL}; // initialized to avoid spurious SAS/C warnings
    PERSIST   const STRPTR cardnames[13] =
    { "2    ",
      "3    ",
      "4    ",
      "5    ",
      "6    ",
      "7    ",
      "8    ",
      "9    ",
      "10   ",
      "Jack ",
      "Queen",
      "King ",
      "Ace  "
    };
    PERSIST  const TEXT    suits[4] =
    { 'S', // 0x06 Spades
      'C', // 0x05 Clubs
      'H', // 0x03 Hearts
      'D'  // 0x04 Diamonds
    };
    PERSIST  const STRPTR  /* longsuits[4] =
    { "Spades",
      "Clubs",
      "Hearts",
      "Diamonds"
    }, */ longnames[52] =
    { "   2 of Spades  ",
      "   3 of Spades  ",
      "   4 of Spades  ",
      "   5 of Spades  ",
      "   6 of Spades  ",
      "   7 of Spades  ",
      "   8 of Spades  ",
      "   9 of Spades  ",
      "  10 of Spades  ",
      " Jack of Spades ",
      " Queen of Spades",
      " King of Spades ",
      "  Ace of Spades ",
      "   2 of Clubs   ",
      "   3 of Clubs   ",
      "   4 of Clubs   ",
      "   5 of Clubs   ",
      "   6 of Clubs   ",
      "   7 of Clubs   ",
      "   8 of Clubs   ",
      "   9 of Clubs   ",
      "   10 of Clubs  ",
      "  Jack of Clubs ",
      " Queen of Clubs ",
      "  King of Clubs ",
      "  Ace of Clubs  ",
      "   2 of Hearts  ",
      "   3 of Hearts  ",
      "   4 of Hearts  ",
      "   5 of Hearts  ",
      "   6 of Hearts  ",
      "   7 of Hearts  ",
      "   8 of Hearts  ",
      "   9 of Hearts  ",
      "  10 of Hearts  ",
      " Jack of Hearts ",
      " Queen of Hearts",
      " King of Hearts ",
      "  Ace of Hearts ",
      "  2 of Diamonds ",
      "  3 of Diamonds ",
      "  4 of Diamonds ",
      "  5 of Diamonds ",
      "  6 of Diamonds ",
      "  7 of Diamonds ",
      "  8 of Diamonds ",
      "  9 of Diamonds ",
      " 10 of Diamonds ",
      "  Jack of Dmnds ",
      " Queen of Dmnds ",
      "  King of Dmnds ",
      " Ace of Diamonds",
    };

 /* for (i = 0; i < 7; i++)
    {   for (j = 0; j < 5; j++)
        {   sortedcard[i][j] = 0; // initialized to prevent spurious SAS/C warnings, but does no fucking good
    }   } */

    players = getnumber("How many other players", 1, 6);
    // %%: are jokers supposed to be included? Currently we don't support them.
    for (;;)
    {   for (i = 0; i < 52; i++)
        {   dealt[i] = FALSE;
        }

        for (i = 0; i <= players; i++)
        {   for (j = 0; j < 5; j++)
            {   do
                {   which = rand() % 52;
                } while (dealt[which]);
                card[i][j] = which;
                dealt[which] = TRUE;
            }

            l = 0;
            for (k = 12; k >= 0; k--)
            {   for (j = 0; j < 5; j++)
                {   if (card[i][j] % 13 == k)
                    {   sortedcard[i][l++] = card[i][j];
            }   }   }

            if
            (   card[i][0] / 13 == card[i][1] / 13
             && card[i][0] / 13 == card[i][2] / 13
             && card[i][0] / 13 == card[i][3] / 13
             && card[i][0] / 13 == card[i][4] / 13
            )
            {   flush = TRUE;
            } else
            {   flush = FALSE;
            }
            for (j = 0; j < 13; j++)
            {   setof[j] = 0;
            }
            for (j = 0; j < 5; j++)
            {   setof[card[i][j] % 13]++;
            }
            twos = threes = fours = 0;
            for (j = 0; j < 13; j++)
            {   if (setof[j] == 2)
                {   twos++;
                } elif (setof[j] == 3)
                {   threes++;
                } elif (setof[j] == 4)
                {   fours++;
            }   }
            if   (setof[ 8] == 1 && setof[ 9] == 1 && setof[10] == 1 && setof[11] == 1 && setof[12] == 1) straight = 10; // TJQKA
            elif (setof[ 7] == 1 && setof[ 8] == 1 && setof[ 9] == 1 && setof[10] == 1 && setof[11] == 1) straight =  9; // 9TJQK
            elif (setof[ 6] == 1 && setof[ 7] == 1 && setof[ 8] == 1 && setof[ 9] == 1 && setof[10] == 1) straight =  8; // 89TJQ
            elif (setof[ 5] == 1 && setof[ 6] == 1 && setof[ 7] == 1 && setof[ 8] == 1 && setof[ 9] == 1) straight =  7; // 789TJ
            elif (setof[ 4] == 1 && setof[ 5] == 1 && setof[ 6] == 1 && setof[ 7] == 1 && setof[ 8] == 1) straight =  6; // 6789T
            elif (setof[ 3] == 1 && setof[ 4] == 1 && setof[ 5] == 1 && setof[ 6] == 1 && setof[ 7] == 1) straight =  5; // 56789
            elif (setof[ 2] == 1 && setof[ 3] == 1 && setof[ 4] == 1 && setof[ 5] == 1 && setof[ 6] == 1) straight =  4; // 45678
            elif (setof[ 1] == 1 && setof[ 2] == 1 && setof[ 3] == 1 && setof[ 4] == 1 && setof[ 5] == 1) straight =  3; // 34567
            elif (setof[ 0] == 1 && setof[ 1] == 1 && setof[ 2] == 1 && setof[ 3] == 1 && setof[ 4] == 1) straight =  2; // 23456
            elif (setof[12] == 1 && setof[ 0] == 1 && setof[ 1] == 1 && setof[ 2] == 1 && setof[ 3] == 1) straight =  1; // A2345
            else                                                                                          straight =  0;

            if (straight && flush)
            {   verdict[i] = "STRT FLUSH";
                points[i] = 8000000 + straight;
            } elif (fours)
            {   verdict[i] = "4 of kind ";
                for (j = 12; j >= 0; j--)
                {   if (setof[j] == 4)
                    {   points[i] = 7000000 + j;
                        break;
            }   }   }
            elif (threes && twos)
            {   verdict[i] = "Full house";
                for (j = 12; j >= 0; j--)
                {   if (setof[j] == 3)
                    {   points[i] = 6000000 + j;
                        break;
            }   }   }
            elif (flush)
            {   verdict[i] = "Flush     ";
                k = 0;
                for (j = 0; j <= 12; j++)
                {   if (setof[j] == 1)
                    {   oddcard[k++] = j;
                }   }
                points[i] = 5000000
                          + (oddcard[4] * 13 * 13 * 13 * 13)
                          + (oddcard[3] * 13 * 13 * 13     )
                          + (oddcard[2] * 13 * 13          )
                          + (oddcard[1] * 13               )
                          +  oddcard[0];
            } elif (straight)
            {   verdict[i] = "Straight  ";
                points[i] = 4000000 + straight;
            } elif (threes)
            {   verdict[i] = "3 of kind ";
                for (j = 12; j >= 0; j--)
                {   if (setof[j] == 3)
                    {   points[i] = 3000000 + j;
                        break;
            }   }   }
            elif (twos == 2)
            {   verdict[i] = "2 pairs   ";
                for (j = 12; j >= 0; j--)
                {   if (setof[j] == 2)
                    {   oddcard[0] = j;
                        break;
                }   }
                for (j = 0; j <= 12; j++)
                {   if (setof[j] == 2)
                    {   oddcard[1] = j;
                        break;
                }   }
                for (j = 0; j <= 12; j++)
                {   if (setof[j] == 1)
                    {   oddcard[2] = j;
                        break;
                }   }
                points[i] = 2000000
                          + (oddcard[2] * 13 * 13)
                          + (oddcard[1] * 13     )
                          +  oddcard[0];
            } elif (twos)
            {   verdict[i] = "1 pair    ";
                for (j = 12; j >= 0; j--)
                {   if (setof[j] == 2)
                    {   oddcard[3] = j;
                        break;
                }   }
                k = 0;
                for (j = 0; j <= 12; j++)
                {   if (setof[j] == 1)
                    {   oddcard[k++] = j;
                }   }
                points[i] = 1000000
                          + (oddcard[3] * 13 * 13 * 13)
                          + (oddcard[2] * 13 * 13     )
                          + (oddcard[1] * 13          )
                          +  oddcard[0];
            } else
            {   verdict[i] = "Nothing   ";
                k = 0;
                for (j = 0; j <= 12; j++)
                {   if (setof[j] == 1)
                    {   oddcard[k++] = j;
                }   }
                points[i] = (oddcard[4] * 13 * 13 * 13 * 13)
                          + (oddcard[3] * 13 * 13 * 13     )
                          + (oddcard[2] * 13 * 13          )
                          + (oddcard[1] * 13               )
                          +  oddcard[0];
        }   }

     /* aprintf("Your cards are: ");
        if (!userstring[0])
        {   for (i = 0; i < 5; i++)
            {   if (i >= 1)
                {   aprintf("                ");
                }
                aprintf
                (   "%s of %s\n",
                    cardnames[sortedcard[0][i] % 13],
                    longsuits[sortedcard[0][i] / 13]
                );
        }   } */

        rawmode = TRUE;
        for (i = 0; i < 5; i++)
        {   aprintf("¶.--------¢------.");
        }
        maybelf();

        for (i = 0; i < 12; i++)
        {   for (j = 0; j < 5; j++)
            {   if (i <= 8)
                {   aprintf("¶");
                } else
                {   aprintf("þ");
                }
                aprintf("|%s", cardimage_ansi[sortedcard[0][j]][i]);
                if (i <= 3)
                {   aprintf("¢");
                } elif (i <= 7)
                {   aprintf("¶");
                } else
                {   aprintf("þ");
                }
                aprintf("|");
            }
            maybelf();
        }
        for (i = 0; i < 5; i++)
        {   aprintf("þ`-----¶---------'");
        }
        maybelf();
        aprintf
        (   "%s%s%s%s%s",
            longnames[sortedcard[0][0]],
            longnames[sortedcard[0][1]],
            longnames[sortedcard[0][2]],
            longnames[sortedcard[0][3]],
            longnames[sortedcard[0][4]]
        );
        maybelf();
        rawmode = FALSE;

        aprintf("¢Your hand is: %s\n", verdict[0]);
        bet = getnumber("Bet how many gp", 0, gp);
        if (bet == 0)
        {   if (module == MODULE_CT && room == 19)
            {   room = 33;
            }
            return;
        }

        pay_gp(bet);
        winnings -= bet;
        pot = bet * (players + 1);

        aprintf("You        ");
        for (i = 1; i <= players; i++)
        {   aprintf("Player %d   ", i);
        }
        aprintf("\n");
        for (i = 0; i <= players; i++)
        {   aprintf("---------- ");
        }
        aprintf("\n");
        for (j = 0; j < 5; j++)
        {   for (i = 0; i <= players; i++)
            {   aprintf("%s of %c ", cardnames[sortedcard[i][j] % 13], suits[sortedcard[i][j] / 13]);
            }
            aprintf("\n");
        }
        for (i = 0; i <= players; i++)
        {   aprintf("---------- ");
        }
        aprintf("\n");
        for (i = 0; i <= players; i++)
        {   aprintf("%s ", verdict[i]);
        }
        aprintf("\n");

        besthand   =
        bestplayer = -1;
        for (i = 0; i <= players; i++)
        {   if (points[i] >= besthand)
            {   bestplayer = i;
                besthand   = points[i];
        }   }

        bestplayers = 0;
        for (i = 0; i <= players; i++)
        {   if (points[i] == besthand)
            {   bestplayers++;
        }   }

        j = 1;
        for (i = 0; i <= players; i++)
        {   if (points[i] == besthand)
            {   if (bestplayers >= 2)
                {   aprintf("WINNER #%d  ", j++);
                } else
                {   aprintf("**WINNER** ");
            }   }
            else
            {   aprintf("LOSER      ");
        }   }
        aprintf("\n");

        if (bestplayers >= 2 && points[0] == besthand)
        {   give_gp(pot / bestplayers);
            winnings += pot / bestplayers;
        } elif (bestplayer == 0)
        {   give_gp(pot);
            winnings += pot;
        }
        aprintf("\n");

        if (userstring[0])
        {   enterkey(FALSE);
}   }   }
