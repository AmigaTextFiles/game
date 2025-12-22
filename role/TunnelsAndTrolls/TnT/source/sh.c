#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Not currently implemented:
(Tracking and) sharing of treasure, neither with Mongo nor with Six Pack.
 Particularly, we are ignoring everything except coins, and are assuming that the player
  was broke at the start.
Keeping track of whether they were going eg. east or west in a particular room (eg. SH138).
Implicit been[] handling. Currently been[] is only handled where
 explicitly mentioned in the text.
*/

MODULE const STRPTR sh_desc[SH_ROOMS] = {
{ // 0
#ifdef CORGI
"I`NSTRUCTIONS\n" \
"  The dungeon is designed for lower level fighters. Rogues too may enter, although they will find little chance to use their magical abilities. The dungeon is open to humans and hobbits, but Mongo the wizardly proprietor has an irrational prejudice against elves and dwarves. However, you may take them in, if you keep in mind that this dungeon is design to best accommodate human-sized (no larger) warriors whose attributes average about 14.[ (To those players who like to take in monsterish types, the same thing applies - but no beasts may be taken in. Humanoids only, and no larger than a human.)]\n" \
"  You will find the dungeon is set up as a maze and that you can retrace your steps. If a character kills a monster and/or loots a given room, that room remains empty to the character thereafter on that trip (regardless of the original room description). Should that character die, and you begin again with another character, only then will the rooms restock. Since in time you will learn all the 'safest' choices to make, it is suggested that you should roll a die when you come to a choice, and then make your decision based on the die-roll.\n" \
"  In this dungeon, there are optional wandering monster rooms. When this given, you should roll a six-sided die - if it comes up a 1, there is a monster in that room when you enter. You will then need to roll a second time on the Wandering Monster List given at the end of this dungeon to see which monster you are facing. There are some places you will find which give you no option - you must fight a wandering monster.[ If you wish to make the dungeon a little tougher to challenge stronger characters, you may decide to make the optional wandering monster rooms always produce a monster.]\n" \
"  Your character should have at least a few gold pieces in hand; i~f you are ready, go to {118}."
#else
"I`NSTRUCTIONS\n" \
"  This is a solitaire dungeon for Tunnels & Trolls players. Each paragraph presents a situation with one or more alternatives for what you may do. As the choices are made, the text refers you to a new location to see what occurs. This booklet is NOT meant to be read like a book; for maximum enjoyment you should read the paragraphs only when you are instructed to go to them. You will need only a copy of the T&T rules, paper, pencil, and a few six-sided dice to play.\n" \
"  Only one character at a time is permitted inside the dungeon, which is designed for lower level fighters. Rogues too may enter, although they will find little chance to use rneir magical abilities. The dungeon is open to humans and hobbits, but Mongo the wizardly proprietor has an irrational prejudice against elves and dwarves. However, you may take them in, if you keep in mind that this dungeon is design to best accommodate human-sized (no larger) warriors whose attributes average about 14.[ (To those players who like to take in monsterish types, the same thing applies - but no beasts may be taken in. Humanoids only, and no larger than a human.)]\n" \
"  You will find the dungeon is set up as a maze and that you can retrace your steps. If a character kills a monster and/or loots a given room, that room remains empty to the character thereafter on that trip (regardless of the original room description). Should that character die, and you begin again with another character, only then will the rooms restock. Since in time you will learn all the 'safest' choices to make, it is suggested that you should roll a die when you come to a choice, and then make your decision based on the die-roll.\n" \
"  In this dungeon there are optional wandering monster rooms. When this is given, you should roll a six-sided die - if it comes up a 1, there is a monster in that room when you enter. You will then need to roll a second time on the Wandering Monster List given in the back of this booklet to see which monster you are facing. There are some places you will find which give you no option - you must fight a wandering monster. If you wish to make the dungeon a little tougher to challenge stronger characters, you may decide to make the optional wandering monster rooms always produce a monster.\n" \
"  Your character should have at least a few gold pieces in hand; i~f you are ready, go to {118}."
#endif
},
{ // 1/1A
"You find yourself in a short torchlit tunnel with a door to the south and a rune-covered door to the north. If you want to leave by the south door, go to {116}. If you want to leave by the north door, go to {128}."
},
{ // 2/1B
"This room is pitch black. If you want to light the torch Mongo handed to you, [you must carry it in your shield hand and sling your shield (if you have one) on your back. If you decide to do this, ]go to {136}. If you prefer to keep your guard up, your shield forward, and enter the room in darkness, go to {41}. Or, you can back away and close the door: return to {67}."
},
{ // 3/1C
"You leave the cavern and enter another tunnel. The dwarf delights a torch and asks you to pay in gold for his ferrying services, and to please put the coins in the iron strongbox. You may put any number of coins in the box, and then go to {6}. You may thank the dwarf for the ride but keep your gold, and go to {63}."
},
{ // 4/1D
"The alcove closes to become an ordinary-looking door once again, then the whole thing clicks open. Go to {125}."
},
{ // 5/1E
"Six Pack and you are on the north side of the firepit. [The fumes from the pit have made all the poison on your weapon non-toxic; you will have to wipe it clean and recoat the weapon. ]Six Pack sniffs the tunnel and wants to get going. He thinks he may have come this way before. If you want to enter the tunnel you will need to light a torch (if you need spares, there are some in the room south of the pit...you will have to cross the pit again to gather any). If you have extra torches of your own, go to {92}. If you can see in the dark, go to {92}. (Six Pack is smug because he can see in the dark himself.) If you want to go back across the firepit by the west ledge, go to {117}. If you want to go back by the east ledge, go to {64}. If you want to enter the tunnel without a torch and let Six Pack guide you, go to {124}."
},
{ // 6/2A
"If you put in half or more of the gold you are carrying, go to {73}. If you put in less than half, go to {63}."
},
{ // 7/2B
"Through misfortune, stupidity, or clumsiness, you tripped the mechanism which protects the contents of this box. A cloud of red dust puffs out and covers you head to foe. Your armour, if not Blue Elf, turns to a powdery rust; the leather rots and everything falls off. If you are carrying a shield, it goes the way of the armour. All your weapons are gone (except for your magic weapon). Six Pack is sniggering, but points out that, although the dust has largely destroyed the box and its contents, something still might be salvaged. Roll once on the Treasure Generation Table (no magical treasure, roll again). Decide who will carry the treasure, and go to {67}."
},
{ // 8/2C
"You walk for what seems like hours until the red and black poppies give way to yellow ones. You see a golden tower hazy in the distance. You can continue on towards the tower of gold, and go to {140}. Six Pack wants to go back; if you go with him, go to {59}."
},
{ // 9/2D
"The priests attack. There are six, but they can only reach you two at a time. They carry magical staffs, pulsing with death runes, which get 3 dice in attack. Each priest has 12 adds and a Constitution of 20. With a mutter about what a stupid partner he has, Six Pack steps away from the wall to join the fight. If you stand and fight to the death, Six Pack at your side, go to {101}. If you decide to run for the entrance, with the priests hot on your heels (and Six Pack left behind), go to {132}."
},
{ // 10/2E
"You enter a torchlit room through a doorway in the south wall; after you have passed through, the door suddenly slams shut and a great grinding noise tells you it is locked and blocked. You see another door to the north. (This is an optional wandering monster room.) Along the east and west walls are rows of small rune-covered oak kegs. Six Pack's eyes light up and he wanders to the kegs and mutter strange words. \"Malt, Stout, Light, Dark, Bock...Look! A dark heavy malt!\" Six Pack grabs a wood mug off the wall and fills it from a dusty keg and offers you the first drink. You may drink the beer, go to {137}. You may turn down Six Pack's offer and try to hurry him out the north door, go to {116}."
},
{ // 11/3A
"You are in a torchlit room with a door to the south. In the middle of the room is a golden piggy bank on an altar. The north end of the room opens on a large circular shaft with flames flickering from the depths. If you want to pick up the piggy bank, go to {50}. If you want to go to the edge of the firepit, go to {52}. If you want to go out the door, back the way you came, go to {35}."
},
{ // 12/3B
"Make L1-SRs on Luck, Intelligence, and Dexterity (20 - LK/IQ/DEX). If you make them, go to {77}. If you miss any of the three, go to {7}."
},
{ // 13/3C
"As you enter this dimly-lit room, the door snaps shut and locks behind you. Six Pack yells at you to look at the east wall. There you can see a red button and the glowing words 'PUSH ME'. You can search for a secret door, and go to {94}. You can try the locked door on the west wall, go to {30}. You can push the button - go to {102}."
},
{ // 14/3D
"The ledge ahead of you is gone. You cannot get by this way. You will have to use the west ledge. Go to {117}."
},
{ // 15/3E
"The skiff picks up speed until you are directly over the glowing orb, and then comes to a dead stop. As the orb gets closer and closer to the surface you can see it extends a full 50' around you. Just before the orb reaches the surface, there is a *pop* - you and the skiff are sucked under the waters and into the orb. You are now immortal; however, you have lost your identity to the all-powerful orb. Close the book, and no, you cannot run the orb as a character elsewhere..."
},
{ // 16/3F
"Mongo closes the entrance and asks you what you have found. If you have treasure to split with him, go to {150}. If you have no treasure, go to {51}."
},
{ // 17/3G
"Slowly, a barge packed with wood rune-covered crates comes out of the south tunnel and stops at the pier. A greybearded dwarf with green eyes tells you hurry, he is late. You may board the barge and go north downstream: go to {108}. You may board the barge and climb off immediately onto the opposite pier. If you were going down the west tunnel, go to {42}. If you were going down the east tunnel, go to {119}."
},
{ // 18/4A
"The ledge is only wide enough for one person, and the rocks look slippery, so you move slowly. After 100', the ledge slopes under the water. You look at Six Pack and he shrugs his shoulders, so you keep going. The water covers your feet and then your knees. Six Pack stops you, the water is up to his waist. Six Pack looks you in the eye and tells you this is dumb, he is going back for a boat. Retrace your steps back to the beach and roll for a wandering monster. Fight it and then go to {31}, if you still live."
},
{ // 19/4B
"After walking west, the corridor turns north and ends in a rune-covered wooden door. You can see light coming out of a peephole at eye level. Go to {111}."
},
{ // 20/4C
"What are you doing looking for a secret door in a 21st level Wizard's Tower? You'll never find it! Take one point off your Intelligence. Go back to {118} and make another choice."
},
{ // 21/4D
"Every time you pluck a flower from its stem, it screams horribly. For each flower you pick, make a L1-SR. Keep track of how many of what colour you pick before you miss your SR. If you miss the saving roll, go to {53}. If you decide to stop picking flowers before you miss the roll, you can venture out into the field (go to {8}). Or you can go back through the door (go to {79})."
},
{ // 22/4E
"The walls stop and rumble back. The door parts to reveal a small alcove. In it is a ruby amulet (worth 1200 gp) hanging between two buttons. The inscription under the amulet tells you it will heal any hits to Constitution if pressed to your heart, but that it may only be used three times. [However, the amulet can be recharged once a month by the light of a full moon. ]You may press the button to the left of the amulet, go to {4}. You may press the button to the right of the amulet, go to {143}."
},
{ // 23/5A
"Six Pack falls screaming through a secret door in the floor. You make a dive for the door but are caught by the walls and crushed. Close the book."
},
{ // 24/5B
"You are in a long, dark, north/south tunnel. Ahead you can see that the tunnel joins another dark east/west tunnel. Six Pack hisses a warning. \"Put out the torch!\" He jumps against the wall, and disappears. You can put out the torch and flatten out against the wall, go to {80}. You can put out the torch and ask Six Pack what's wrong, go to {149}. You can leave the torch lit and peer around the corner, go to {156}."
},
{ // 25/5C
"Six Pack leads you to the torchlit end of the tunnel. Go to {130}."
},
{ // 26/5D
"Six Pack belches and says, \"This is a piece of cake, let's grab the statue too.\" Go back to {91}."
},
{ // 27/5E
"Mongo disappears in a flash of green light. You gain 1000 experience points[ and keep half of all the treasure you found. Six Pack keeps the other half]. You can part with Six Pack at this time - for your adventures in this dungeon are over[ - or you team up with him]. Remember, it takes a wagonload of beer to keep a Rock Demon happy. When dry, they turn mean, rotten, evil, and will kill and eat anything they can see...beware!"
},
{ // 28/5F
"The Rock Demon hiccups and tells you his name is Six Pack. He is a little bit lost and offers to join you and search for the exit. Six Pack has found a magic never-empty beer keg, but he won't go out the tower entrance, for fear the Wizard will take the keg away from him. Rock Demons get their name from the fact that when they stand by a rock wall they become invisible. Very antisocial unless full of beer, they fight 4 dice and 18 adds in combat, and can take 12 hits on armour each combat round. (Rock Demons wear no armour or clothes, but their hide is so tough it is treated as armour.) They also have a Constitution of 30[, and poison has no effect on them]. If you accept Six Pack's offer, go to {69}. If you reject his offer, go to {90}."
},
{ // 29/6A
"After offering you refreshments, Mongo explains he acquired the tower from a red wizard, and as the former owner had to leave in a hurry, he never got the blueprints for the sub-basement. Mongo could use his great powers to explore the sub-levels; however, he is busy with other occult matters and doesn't have the time right now. If you map out the area and find the exit, you may keep whatever you find in exchange for the map.[ If you can't find the exit and must return to the entrance, Mongo will take half of the value of all treasures you find. The Wizard will pay you in gold or jewels for your half share of any magic item you find - or, if you're a rogue and can use magic, you can pay the Wizard half of its value and keep it.]\n" \
"  Mongo warns you that normal poison will not work in the sub-levels, but he has a poison from a rare flower[ that should be effective]. He offers you a flask with five applications of this poison.[ If you get any hits on a monster it will then double your hits on its Constitution, although it will wear off after three combat rounds in which you got hits.]\n" \
"  [Mongo cautions you that any magic armour and weapons you may have will not work. ]However he does have two weapons that will work. He offers you a magic sword (you must have a Strength of 9 to use), or a magic axe (which requires a Strength of 15 to use). You must pick one, and only one, before Mongo will tell you its magic powers. If you picked the sword, go to {89}. If you picked the axe, go to {47}. If these weapons are too heavy for you, go to {112}."
},
{ // 30/6B
"You were told the door was locked. Take one point from your Intelligence and push the button; go to {102}."
},
{ // 31/6C
"You and Six Pack are on a small sandy beach in an underground cavern. (This is an optional wandering monster beach!) To the south is the door with the Death Vortex Lock. There is a dark lark almost filling the cavern. Starting at the beach and running parallel with the lake is a ledge leading east. Water from the lake laps over the ledge and it stretches as far as you can see by torchlight. On the beach is a bamboo raft and some poles. Alongside the raft is a strange coloured lilypad skiff. If you want to follow the ledge, go to {18}. If you want to use the raft, go to {134}. If you want to use the giant lilypad, go to {126}."
},
{ // 32/6D
"You must fight three combat rounds. If you're still alive, go to {84}."
},
{ // 33/6E
"You feel good all over. Roll 1 die and add that number to your Strength. Roll again and add that number to your Constitution. Now go to {74}."
},
{ // 34/7A
"If you went to open the door, go to {128}. If Six Pack went to open the door, go to {133}. If you're not sure, or didn't say, roll one die. If you roll a 1, 2, or 3, you went to the door. Rolling a 4, 5, or 6 means Six Pack went to the door."
},
{ // 35/7B
"You are standing in the north branch of an 'L' shaped corridor (the other branch bends to the west). There is a rune-covered wooden door at the end of the north corridor. Six Pack sniffs the door, puts his ear against it, and says he thinks it's safe to enter. You may enter the room (go to {11}). You may go around the corner back the way you came (go to {58})."
},
{ // 36/7C
#ifdef CORGI
"As you apply poison to your new weapon, Mongo tells you it is yours to keep if you map his dungeon and find the exit. He then offers you any supplies - but no weapons or armour (take your pick from the weapons and armour in the Rules Section). Mongo takes you down to the entrance, an ironbound wooden door. If you come back this way, just knock and Mongo will let you out. Mongo mutters a word of power and the door opens. He hands you a torch and bids you good luck.\n" \
"  There are stairs going down 10' to a small wooden door. As you go down the stone stairs the entrance slams shut and locks. At the bottom of the stairs make a L1-SR on Intelligence (20 - IQ). If you make the saving roll, go to {76}. If you missed, open the door and go to {65}."
#else
"As you apply poison to your new weapon, Mongo tells you it is yours to keep if you map his dungeon and find the exit. He then offers you any supplies - but no weapons or armour (go to the T&T Rule Book and take your pick). Mongo takes you down to the entrance, an ironbound wooden door. If you come back this way, just knock and Mongo will let you out. Mongo mutters a word of power and the door opens. He hands you a torch and bids you good luck.\n" \
"  There are stairs going down 10' to a small wooden door. As you go down the stone stairs the entrance slams shut and locks. At the bottom of the stairs make a L1-SR on Intelligence (20 - IQ). If you make the saving roll, go to {76}. If you missed, open the door and go to {65}."
#endif
},
{ // 37/7D
"A rock slides open and a tall green-robed figure steps out and looks you over. \"Well, I suppose you'll do. I'm Mongo, come on in. I have some tea that will warm you up.\" Go to {29}."
},
{ // 38/7E
"The dwarf hurled a magic water bag at you, and it burst. It didn't hurt you, though - you have been turned into a goldfish. You will stay a goldfish until you can overcome a killer guppy in hand to hand - er, fin to fin - combat. At that time you will become a killer guppy, and must fight a mock turtle. These incarnations will keep you occupied until you become too old to care about becoming human again. Better luck next time..."
},
{ // 39/7F
"You are on a 10' stairway. If you want to go through the north door at the bottom of the stairs, go to {49}. If you want to try the south door at the top landing, go to {132}."
},
{ // 40/8A
"This room is a junction, with stairs leading up to the south, stairs leading upwards to the west, and a door to the east. (This is an optional wandering monster room.) If you want to go south, go to {122}. If you want to go west, go to {153}. If you want to try the east door, go to {144}."
},
{ // 41/8B
"As you enter the room, the door snaps shut behind you. You hear Six Pack give a scream of rage, followed by two thumps, a bump, and a sigh. One second later a huge hairy paw smashes into your guard and you must take 15 hits (armour and shields are acceptable, but you never got your weapon into play). You may now stand and fight in the darkness - go to {96}. You may flee for the dungeon entrance by going to {115}."
},
{ // 42/8C
"You and Six Pack are standing on the west side of a pier beside a canal which runs north and south. You may enter the tunnel on the west, go to {81}. You may jump to the east pier by going to {138}. You may blow on the horn which hangs within reach on the wall; go to {17}."
},
{ // 43/8D
"There is a flash of light and a tall black shadow appears. \"It is not nice to kill off a Rock Demon in only one combat round. You are much too powerful for this dungeon. Return to the tavern and let a weaker character try this dungeon, or I shall slay you on the spot.\""
},
{ // 44/8E
"Make a L1-SR on Constitution (20 - CON). If you make it, go to {33}. If you miss, it was spiked: go to {87}."
},
{ // 45/9A
"You find a secret door on the east wall. If you want to enter, go to {153}. If you don't want to go through the door, go back to {151}."
},
{ // 46/9B
"The door softly closes behind you, and as you turn, you come face to face with a Basilisk, and keel over dead."
},
{ // 47/9C
"The war axe is worth 4 dice plus 5 adds in combat, and will take 3 hits each combat round. [If anything happens to the axe, it may be called back to your hand if you shout the ancient and mystical word 'HELP'! ]You chose the axe and may not exchange it for any of the Wizard's other weapons. Go to {36}."
},
{ // 48/9D
"Make a L1-SR on your Luck (20 - LK). If you make it, go to {33}. If you miss, the stuff was drugged - go to {55}."
},
{ // 49/9E
"This is a room with two doors. If you want to exit by the north door, Six Pack hiccups, steps away from the wall, and goes with you. Go to {67}. If you want to exit by the south door (if Six Pack is with you he will not go through this door but will hide along the wall), go to {39}."
},
{ // 50/9F
"A Wandering Monster appears in a puff of smoke the instant you touch the piggy bank. Roll on the Wandering Monster List at the end of this dungeon to see which one materializes. If you survive the fight, and still want to take the piggy bank, go to {135}. If you want to leave it alone, you can go to the edge of the firepit (go to {52}), or you can go back the way you came (go to {35})."
},
{ // 51/10A
"You have returned empty-handed, and Mongo is not pleased. He politely asks you to return his weapon and to leave his tower. If you leave, go to {97}. If you beg Mongo for one last chance, go to {154}."
},
{ // 52/10B
"You are on the south side of a huge, apparently bottomless firepit. To the north is a dark tunnel: around the pit is a narrow ledge. You will have to press your shoulders against the wall in order to use the ledge. Six Pack wants to get out of here as quickly as possible. If you want to go around the east side of the pit, go to {64}. If you want to go around the west side, go to {117}. If you want to return to the south end of the room, go to {11}."
},
{ // 53/10C
"While you were picking flowers a gardener has rushed up to see why his flowers are screaming. He is 12' tall, green in colour, and has leaves for hair. He is carrying a large hoe. You may fight him - go to {110}. You may make a run for the door - go to {88}. (Note: if you are a bright shade of green, you may go to {68} instead.)"
},
{ // 54/10D
"Six Pack lights a torch, takes a drink from his keg, and offers you one. You may go south by going to {151}. If you want to go north into the 'T' intersection the priests came from, go to {58}."
},
{ // 55/10E
"You wake up with a terrible hangover, lying at the base of the Wizard's Tower. You are missing all of your armour, weapons, gold, treasure, and clothes. You get 300 experience points for getting as far as you did. However, not only is your head ringing - the gong is, too. If you want to stay and see what happens, go to {157}. If you want to get away as quickly as possible, and try adventuring in another dungeon, close this book and get another Corgi Tunnels and Trolls Two-in-One Adventure."
},
{ // 56/10F
"The Rock Demon goes berserk for one combat round. He fights 4 dice and 18 adds in combat and can take 12 hits as if on armour each combat round. (Rock Demons wear no armour or clothes, but their hide is tough enough to be treated as armour.) He also has a Constitution of 20[, and poison has no effect on him]. If you are still alive after one combat round, the Rock Demon snaps out of his madness and calls for a parley. If you parley, go to {28}. If you want to continue the fight, go to {90}. However, if you killed the Rock Demon in the first combat round, then by all means go to {43}."
},
{ // 57/11A
"You gain 50 experience points, and Six Pack offers you a toast from his keg. You may call back your magic weapon but you will have to put on fresh poison. The ink on your map has washed out, and you will have to start a new one. The north wall is bare - no more treasure. Exit by the west door and go to {40}."
},
{ // 58/11B
"You are in the 'T' of a dark tunnel. If you want to go south, go to {151}. If you want to go west, go to {19}. If you want to go east, go to {35}."
},
{ // 59/11C
"You open the door and find yourself facing a vast open field in which black and red poppies stretch row after row to the limits of the horizon. You realize that there cannot be this much room inside any wizard's tower. The door is still open, hanging in the air behind you, and you can go around the corner back the way you came (go to {119}). You can wander out farther (being careful not to touch or pluck the poppies) and look for an end to the field - something Six Pack isn't too eager to undertake - by going to {8}. If you want to pick the flowers around you, go to {21}."
},
{ // 60/11D
"You and Six Pack wade through the base of the waterfall and find yourselves standing in a small stream in the woods near the wizard's tower. You have stumbled upon Mongo's secret entrance! You climb out of the stream and relax on the bank while you dry off. There is a flash of green light and Mongo appears, pleased to see that you have gotten out safely. He takes your map and tells you if you want to keep your magic weapon it will cost you 10% of the treasure you found (and cheap at the price). You may keep the weapon and pay Mongo his 10% by going to {27}. For that matter, if you decide not to pay him, and return the weapon to him, go to {27}. If you decide to be belligerent and ask him if he'd like to taste the edge of his magic weapon, go to {114}."
},
{ // 61/11E
"As you keep one eye on the Demon, and one eye on the north door, you slip on a puddle of spilled beer and fall to the floor. Subtract one point from your Dexterity as the Demon notices you. Go to {28}."
},
{ // 62/11F
"A cloud of green dust puffs out of the altar, and covers you head to toe. You turn a bright shade of green and all your hair falls out. Take one point off your Charisma[ until your hair grows back]. Six Pack admires your new colour and tries to change colour to match. Go to {93}."
},
{ // 63/12A
"The barge pulls up at a cross tunnel. The dwarf thanks you and tells you to disembark here. Six Pack can't wait to get off. He thinks the west landing would be quicker, but that the east landing might be more interesting. You may take a torch and enter the east tunnel (go to {146}). You may take a torch and enter the west tunnel (go to {42}). You can also stay on the barge (go to {108})."
},
{ // 64/12B
"As you are halfway around the ledge, the stone gives way under you. Make your L1-SR on Dexterity (20 - DEX). If you missed, you tumble to your death, and you might as well close the book. If you made the saving roll, go to {14}."
},
{ // 65/12C
"In the centre of the torchlit room is a mean-looking, short, red-eyed Rock Demon. He is leaning against a small rune-covered oak keg. If you want to attack him, go to {56}. If you want to try to talk to him, go to {28}. If you want to go around him to the door on the north side of the room, go to {61}."
},
{ // 66/12D
"Make a L1-SR on your Strength (20 - ST). If you make it, go to {55}. If you miss, go to {87}."
},
{ // 67/12E
"You enter a torchlit, rock-walled room with four doors. (This is an optional wandering monster room.) Six Pack sniffs the west door and the east door and wants to try both of them! If you want the north door, go to {120}. If you'd rather use the west door, go to {2}. If you like the east door, go to {125}. For the south door, go to {49}."
},
{ // 68/13A
"Six Pack is going crazy trying to match colours with you and the Giant. His colour flickers from too dark to too light. The Giant scratches his head and bids you and your pet rock a good day. He thinks you are one of the new gardeners and doesn't know what to make of your strange flickering rock. Your rock is starting to growl. Head for the door before he bites the Giant. Quickly - go to {79}."
},
{ // 69/13B
"You both take an oath to help each other and to share any treasure 50/50. [If you get in a fight you may share any hits with Six Pack - however, if Six Pack dies you will also die (MAGIC OATH). ]Six Pack takes a drink from the keg and offers you one. Then, tucking the keg under his arm, he opens the north door. Go to {67}."
},
{ // 70/13C
"Six Pack won't go with you. He sadly bids you farewell. You may pass up this room and stay with Six Pack (return to {111}). You may tell Six Pack to stay put, you'll be right back, and enter the room (go to {46})."
},
{ // 71/13D
"You reach Six Pack and hang onto the other side of the keg. Your torch has gone out; however, as your eyes become accustomed to the darkness, you can see that the cavern has a faint glow. You can no longer see the skiff or the glowing orb. You are caught by a current that takes you to the east side of the cavern and into a tunnel. Your feet can touch bottom and you and Six Pack stand in the stream. Ahead is a circle of light coming through a small waterfall. Go to {60}."
},
{ // 72/13E
"As the sound of the gong dies away, a strange silence descends upon the forest. Suddenly, you see a minidragon charging from the road by the woods - directly towards you! You will have to fight it. It has a MR of 68 (7 dice and 34 adds). If the minidragon kills you, shut the book. If you're still alive, you get 100 experience points, but lose one point from your Intelligence for messing up the wizard's garbage disposal. Go back to {118} and choose again."
},
{ // 73/13F
"Roll two dice. If you roll doubles, the dwarf is amazed at your generosity. One good turn deserves another, he tells you, and hands you a vial of liquid which he says will make you immune to poisons[ for an entire day]. He had only one dose of this marvellous medicine, but Six Pack reminds you with a superior air that he is immune to poisons anyway. If you did not roll doubles, the dwarf failed to realize how open-handed you were, and you should go to {63}, unless you decide he is a bore and attack him after all (in which case go to {38})."
},
{ // 74/14A
"The dwarf yawns and warns you that a dangerous part of the tunnel is ahead, and that all lights must be extinguished. He has an evil gleam in his eye. If you wish to keep your torch lit, go to {100}. If you put out your torch, go to {3}. (Six Pack couldn't care less, since he can see in the dark.)"
},
{ // 75/14B
"Six Pack throws his keg and jumps after it. The keg floats like a cork and Six Pack hangs on to it. You dive after Six Pack. Make a L1-SR on Luck (20 - LK). If you make it, go to {71}. If you miss, you have been sucked into the strangely-glowing, powerful orb. You gain immortality, but lose your identity. Farewell!"
},
{ // 76/14C
"You listen at the door and hear a belch and a giggle. Then the room on the other side is deathly silent. Open the door and go to {65}."
},
{ // 77/14D
"Inside the chest is a small pouch. Roll twice on the Treasure Generation Table to see what kind of coins or gems are inside (no magical treasure, roll again). In the bottom of the chest you will find a Grey Elf cloak. If you wear it and do not move, you become invisible. This cloak can be sold for 100 gp if you decide not to keep it. [Decide who will carry the pouch of treasure and ]go to {67}."
},
{ // 78/14E
"Roll two dice. If you rolled doubles, Six Pack hears you coming and tosses the nearest beer keg at you. You are hit in the head and your brains turn to beer, which finishes your adventures. However, if you did not roll doubles, you catch Six Pack by surprise with the flat of your weapon and knock him out cold. As the door closes behind you, you find that you are in a short torchlit tunnel. The door you came through is at the south end of the tunnel and there is another door covered with runes towards the north.\n" \
"  There is a groan and Six Pack wakes up. He looks at you and asks \"What happened?\" You tell him you were jumped by a band of dwarves. You fought them off and just barely managed to drag Six Pack and his gear out of the door before reinforcements arrived. Six Pack rubs his head, takes a drink from his keg, laughs and offers you a drink. You may now exit by the rune-covered north door; go to {34}. If you want to try the door to the south, you find it is solidly locked behind you."
},
{ // 79/15A
"You and Six Pack are on the south side of the door which leads to the poppy fields. The door has dissolved into mist and you cannot reenter it ever again with this character! The gardeners have noted the missing poppies - they are waiting for you, and would slay you the moment you entered.\n" \
"  Six Pack has finally remembered the nature of the flowers. [Each red poppy can be used to coat a weapon with an exotic poison that is worth 2 times the hit value of the weapon; this is the same poison Mongo gave you. Each black poppy is of arcane use to wizards, and can be exchanged, one for any single 1st to 4th level spell (if the character is capable of learning magic). Or, ]the black poppies can be sold for 500 gp each. Walk around the corner of the 'L' tunnel you are in, and go to {119}."
},
{ // 80/15B
"A red-robed priest bearing a torch comes out of the east tunnel. He glances down the south tunnel, then enters the west tunnel. If for any reason you are invisible, go to {54}. If you can only flatten against the wall and hope you won't be seen, make a L1-SR on Luck (20 - LK) six times to see if this priest, or the five others that follow him, have noticed you. If you are not seen, go to {54}. If one of the priests sees you, go to {9}."
},
{ // 81/15C
"You are at a turn in an 'L' shaped tunnel. To the east is a wood pier which faces a north/south canal. To the north is a wooden door. If you want to go to the pier, go to {42}. If you would rather use the door, go to {91}."
},
{ // 82/15D
"Six Pack gasps and mutters under his beery breath, \"Let me down.\" He doesn't like the looks and he doesn't like the smell - go back to {111}."
},
{ // 83/15E
"The walls of the pit are smooth and can't be climbed. Six Pack peers down at you from above. You'll have to drop your weapons, any shield, and any gold, to keep afloat. The water is ice-cold, and you have only three chances to throw Six Pack a rope. If you don't have a rope, you drown - close the book.\n" \
"  If you do have a rope, throw it to Six Pack. Make a L1-SR on Dexterity (20 - DEX). If you make it, he catches the rope and you are pulled out. Go to {57}. You have three tries to make the saving roll: if you miss, the water numbs you and you are killed by shock, or drown - take your pick."
},
{ // 84/16A
"Six Pack wakes up, weaves to his feet[ and helps you attack the Knuckle Duster]. You must fight it to the death[, and any hits must be shared with Six Pack (you always take the extra hit, if any)]. If you survive, go to {147}."
},
{ // 85/16B
"Make L1-SRs on your Luck (20 - LK) and Charisma (20 - CHR). If you make both, go to {155}. If you miss either roll, go to {139}."
},
{ // 86/16C
"You have only searched for a few minutes when Six Pack scrapes away the dirt along one wall and uncovers a rune which warns, 'PUSH BUTTON, THEN TRY DOOR'. You can try the door, and go to {30}. If you push the button, go to {102}."
},
{ // 87/16D
#ifdef CORGI
"Add 10 to your Strength and Constitution. You wake up in chains, a galley slave. Roll 1 die: this is the number of years you must serve before you can make good an escape. Also, if you ever pass this way again, Mongo will refuse to rehire you. Perhaps you could apply for work at Blue Frog Tavern instead? If you would like to do so, turn to p. 69."
#else
"Add 10 to your Strength and Constitution. You wake up in chains, a galley slave. Roll 1 die: this is the number of years you must serve before you can make good an escape. Also, if you ever pass this way again, Mongo will refuse to rehire you. Perhaps you could apply for work at the Blue Frog instead?"
#endif
},
{ // 88/16E
"Make L1-SRs on Strength (20 - ST), Luck (20 - LK), and Dexterity (20 - DEX). If you make all three rolls, you were able to scamper through the doorway to 79. Otherwise, you were knocked flat from being whacked in the back with a hoe. Roll 1 die and take that number from your Constitution. Furthermore, you must now fight the Giant. Go to {110}."
},
{ // 89/16F
"The long sword is worth 4 dice in combat and will take 8 hits each combat round. If anything should happen to the sword, you may call it back to your hand by shouting the ancient and mystical word 'HELP'! You have chosen this sword, and may not exchange it for any of the Wizard's other weapons. Go to {36}."
},
{ // 90/17A
"The Rock Demon goes totally berserk and hurls the magic keg. You are hit in the head, and your brains turn to beer. This character is totally useless from this point on - close the book."
},
{ // 91/17B
"You are standing in a torchlit room which you entered from the door in the south wall. There is also a door in the north wall. (This is an optional wandering monster room.) In the centre of the room is an altar upon which stands an 8\" high statue of carved jade depicting a Knuckle Duster (so named because its arms reach the floor). The statue is worth 1000 gp; 6 emeralds worth 200 gp each are set into the altar itself. Around the altar are six life-sized green statues of warriors.\n" \
"  Note: if this character has been to this room before, go to {127}. Otherwise, you may leave by the south door, go to {81}. If you want to leave by the north door, go to {152}. If you pick up the emeralds, go to {26}. If you pick up the jade statue, go to {98}."
},
{ // 92/17C
"You are in an 'L' shaped tunnel. (This is an optional wandering monster place.) If you go south, go to {5}. If you go west, go to {130}."
},
{ // 93/17D
"The Piggy Bank is worth 100 gp and contains 50 gold coins. This is a Magic Bank[ - no matter how many gold coins you put it, it will hold them all and will only weigh 10 gp]. You will be able to remove only as many coins from the bank as you put in. Go to {106}."
},
{ // 94/17E
"Make a L1-SR on Luck (20 - LK). If you make it, go to {86}. If you missed, you can try the door on the west wall (go to {30}). However, you can always push the button (go to {102})."
},
{ // 95/17F
"Make L1-SRs on Luck (20 - LK) and Intelligence (20 - IQ). If you make both, go to {103}. If you miss either roll, go to {139}."
},
{ // 96/18A
"This great bulk you're fighting has a MR of 26, but its matted hairy hide gives it the ability to take an additional 8 hits as if on armour. You must fight 3 turns in the dark alone, because Six Pack is out cold on the floor. [Remember, your attack is halved, since you can't see in the dark. ]If you survive, go to {104}."
},
{ // 97/18B
"You got out alive and gained 50 experience points. Close the book."
},
{ // 98/18C
"The warrior-statues in the room react to the desecration of the jade Knuckle Duster. Roll 1 die: this is the number of warriors you must fight. Each is armed with an axe which gets 3 dice; each warrior has a Constitution of 10, has 10 adds and can take 5 hits as if on armour. If you kill them[ with Six Pack's help], take 50 experience points for each warrior you have to fight and kill. If you were killed, why are you reading this?\n" \
"  You can go back out the door you entered, and into the corridor; go to {81}. You can go out the door to the north, go to {10}."
},
{ // 99/18D
"Take 1000 experience points and keep [half of ]all treasures left. [Six Pack keeps the other half. ]You can part company with Six Pack at this time, for your dungeon adventure here is finished.[ Or, you can team up with him - but remember that it takes a wagonload of beer to keep a Rock Demon happy! If he should go dry, he turns mean, evil, rotten, and will kill and eat anything - up to and including erstwhile partners...]"
},
{ // 100/18E
"Yours is the only torch alight as the barge enters a vast cavern. There is a strange humming, and suddenly a vast horde of skunk mites attack you. Roll one die and take that number off your Charisma, until you smell better[ (the effects will last for six months)]. Now go to {3}."
},
{ // 101/19A
"As you sigh with relief, Six Pack tells you not to bother looting the bodies, as the priests carry no money. He also warns you not to touch the magical staves, as they are enchanted and will kill anyone but their individual owners. Go to {54}."
},
{ // 102/19B
"Six Pack cries \"Let's not be hasty -\" but you have already pushed the button. With a click of a lock and a groan of gears the north and south walls start to slide together. Six Pack is jumping up and down screaming \"I told you so! I told you so!\" You may frantically search the room (go to {148}). If you push the button again, go to {23}. If you try the door, go to {22}."
},
{ // 103/19C
"The sack contains 100 gold coins. [Decide who will carry the sack. ]You may now exit the room by going to {40}. If you put on the armour (if you haven't already done so), go to {85}."
},
{ // 104/19D
"Six Pack wakes up, snarls at you for being a fool to fight in the dark, and hastily lights a torch which has fallen from your pack. You find you are trading blows with an 8' tall, snow-white Knuckle Duster (so named because his arms reach the floor). [Fight one more turn alone, and if you still live, Six Pack will get into the fight. Any hits must be shared with the Rock Demon (you will always take the extra hit, if any). ]If you kill the Knuckle Duster and live, go to {147}."
},
{ // 105/19E
"The barge is loaded with bulging leather sacks. You and a muttering Six Pack make yourselves comfortable on them; the barge pulls away and enters the north tunnel. A female dwarf comes out of the cabin and offers refreshments. Six Pack won't have anything to do with them and takes a drink from his keg. If you take wine, go to {66}. If you take tea, go to {44}. If you take milk, go to {48}. If you say no thank you go to {74}."
},
{ // 106/19F
"If you want to go to the edge of the firepit, go to {52}. If you go out the door, back the way you came, go to {35}."
},
{ // 107/20A
"Six Pack grabs you, pulls you back to the ledge and safety, and mutters \"What a clumsy clod.\" If you are going south, go to {52}. If you are going north, go to {5}."
},
{ // 108/20B
"The barge pulls away from the landing and the dwarf hands you a wine flash. \"It will be a long cold trip,\" says the dwarf. You may take a drink from the flask, and go to {87}. If you refuse the drink, go to {123}."
},
{ // 109/20C
"Mongo looks sheepish and vaguely mumbles, \"Oh, that's right, I forgot. You can keep it.\" Go to {99}."
},
{ // 110/20D
"It may look like a hoe, but the Giant gets 6 dice while wielding it, plus 30 personal adds. He has a Constitution of 50. If you manage to avoid being hoed to death, take 400 experience points. As the Giant breathes his last there is a flash of green light. Go to {79}."
},
{ // 111/20E
"Six Pack thinks you should look before you leap. If you ignore him and just open the door, go to {70}. If you look through the peephole, go to {141}. If you would rather pick up Six Pack and let him look through the peephole, go to {82}. If you go back around the corner the way you came, go to {58}."
},
{ // 112/20F
"Mongo looks at you and shakes his head. \"You are a little small for a hired sword - but I may have a weapon to help you.\" Mongo goes over to a dust-covered chest, and opens it with a creak of protesting hinges. From the chest, Mongo lifts a black velvet bundle. Unwrapping the cloth, he hands you a small thin blade. As he warns you not to stare at the runes on the blade, they seem to blur and start to move. You feel a warm glow in your hand[, and your Strength is increased by 10 points]. [If you remove your hand from the hilt, your Strength goes back to normal. ]The weapon is worth 4 dice, plus 8 adds in combat, and will take 10 hits each combat round. If anything happens to the blade, you can summon it back to your hand if you shout the ancient and mystical word 'HELP!!!' Now go to {36}."
},
{ // 113/21A
"You cannot feel the bottom, and withdraw your weapon from the waters. [If you had a sword, it is now only 6\" long (worth 1 die). If you had an axe, you now hold a 1' billy club (worth 1 die). If you used Mongo's Magic Weapon to test the water, all is not lost. It will still take the same number of hits to protect you each combat round. ]You can tell [by the size of your weapon ]that it would be very unhealthy to get in the water. Besides, Six Pack is sniggering at you. Go to {130}."
},
{ // 114/21B
"Make a L1-SR on your Charisma (20 - CHR). If you make it, go to {109}. If you miss the roll, Mongo zapped you with a Take That You Fiend for 46 hits. Then he disappeared in a flash. If perchance you have not disappeared in a flash yourself, you can keep weapon and treasure. Go to {99}."
},
{ // 115/21C
"As you turn, you trip and fall over Six Pack's prone body (he knocked himself out cold) and that's all you have time to notice before the creature in the room destroys you."
},
{ // 116/21D
"Six Pack is in a huff. He throws the mug down, grabs another off the wall, turns his back to you and fills his mug from the keg. He mutters he is not going to leave here until he tries each and every keg, maybe more than once, too. You may make amends and drink from the mug Six Pack offered you (go to {137}). If you try to bop Six Pack over the head and drag him and his gear out the north door, go to {78}. You may also leave Six Pack here [with his share of the treasure, if any, ]and leave by the north door (go to {1})."
},
{ // 117/21E
"As you are halfway around the ledge, a belch of gas from the pit makes you dizzy. Make a L1-SR on Luck (20 - LK). If you miss, you tumble to your death. If you make it, go to {107}."
},
{ // 118/22A
"You stop for a drink and some gossip at the 'Blue Frog', a small country crossroads tavern. It is early in the day and business is slow, so the Innkeeper stops and chats with you. You hear that a 21st level wizard called 'Mongo the Dark' is seeking a sword for hire, and will pay well for a few days' services. The Innkeeper warns that other mercenaries before you have answered this call - and have never been seen again.\n" \
"  A band of boisterous dwarves comes into the tavern, and the Innkeeper has to leave you to tend bar. A little while later, after you have been ejected from the tavern due to a shortage of funds, you pick yourself up and weave off down the road. Entering the dark woods by the tavern you come upon a heavily armoured woodcutter. He tells you to follow the third path on the left. You can't miss it, the path is paved with yellow bricks.\n" \
"  Thanking the woodcutter, you continue into the woods and turn off onto the yellow brick path. A short journey down the path brings you to a clearing, and there ahead of you is a tall and crazy tower. This must be the abode of 'Mongo the Dark', and a more evil-looking tower would be hard to find.\n" \
"  The road ends at the base of the tower. There are no doors or openings anywhere at ground level; however, there is a brass gong at the hitching post, and some bleached bones scattered beneath it. You may hail the Wizard from the road (go to {37}). You may strike the gong (go to {72}). You may explore the base of the tower for a secret door (go to {20})."
},
{ // 119/22B
"You and Six Pack are standing on the east side of a pier beside a canal which runs north and south. You may jump across to the west side of the pier - go to {138}. You may blow on the horn which is hanging on the wall - go to {17}. You may go east - go to {146}."
},
{ // 120/22C
"The door opens on a long pitch-black tunnel. You may take a torch from the room you're in. Carry it in your shield hand, and sling any shield you might have on your back - and go to {142}. However, if you like, you may back away from the tunnel and close the door. Go to {67}."
},
{ // 121/22D
"There is a muffled oath, and a red-robed priest rounds the corner hunting for the source of the sound he has heard (you!). He's carrying a torch, and there are five more priests behind him. It's too late to hide, so go to {9}."
},
{ // 122/23A
"This is a stairway on the south side of an open but dimly lit room. If you want to go through the door at the top of the stairs (heading south), go to {13}. If you wish to descend the stairs and go into the room to the north, go to {40}."
},
{ // 123/23B
"A magical cold wind blows across the deck and freezes you into an ice statue. Close the book."
},
{ // 124/23C
"Six Pack leads you into the tunnel. You make a turn to the left and can no longer see the room with the firepit. Suddenly, Six Pack turns and knocks you flat on the floor, and tells you to keep still, that it would be deadly to stand and fight. You hear something squeaking: Blood Bats!\n" \
"  Roll two dice to see how many Blood Bats are attacking. Each is worth 1 die and 4 adds in combat, and has a MR of 8. Blood Bats refuse to touch Rock Demons - they taste bad. [Six Pack will fight for you, but any hits will be taken off your Constitution. ]If [Six Pack ]can kill the bats before they kill you, go to {25}."
},
{ // 125/23D
"You enter a corridor with glowing walls; there is a door to the east. Six Pack is a little uneasy about this door, but he does want to keep exploring. If you use the east door, go to {13}. If you want to go to the west door, go to {67}."
},
{ // 126/23E
"Six Pack loads the skiff and holds a torch. You grab a pole and push off. You follow the ledge in an easterly direction for 250' when the skiff starts to swing away from the cavern wall and heads for the centre of the lake. Six Pack asks you what you are doing. You tell him you can't control the skiff, that it seems to be caught in a strange current. Six Pack gives a muffled oath and points to the centre of the lake. Under the water you can see a huge glowing orb slowly rising from the depths - and the skiff is headed straight for it! If you stay aboard the skiff, go to {15}. If you jump overboard and swim for the ledge, go to {75}."
},
{ // 127/24A
"Since you have been in this room before, there is no jade statue now for taking or breaking. Furthermore, the north door is locked, bolted, and sealed off by an iron plate. You may leave again by the south door; go to {81}."
},
{ // 128/24B
"As you touch the door, the runes on it begin to whirl. You can't pull away - you are caught by a Death Vortex Lock! You turn to dust, and continue life only a short time as a Dust Devil. You blew it. Close the book."
},
{ // 129/24C
"A voice chuckles, \"Try the door.\" You may try the door, go to {22}. You may push the button, go to {23}."
},
{ // 130/24D
"You are standing at a torchlit 'T' intersection. To the east is a dark tunnel; to the west is a tunnel with a black water-filled canal which runs north/south. Six Pack hiccups and points to a moss-covered horn hanging from the wall. You may test the depth of the water with your weapon, to see if you can wade upstream or downstream (go to {113}). You may blow on the horn (go to {145}). You may go back the way you came (go to {92})."
},
{ // 131/24E
"[Your torch is out, but as your eyes become accustomed to the darkness ]you can see that the cavern has a faint glow. To the east, Six Pack is standing on the submerged ledge, fishing out his gear. You swim to the ledge and pull yourself out of the lake. You shout the magic word, and your weapon returns. [The poison has been washed off, so if you have any left, put it on. ]If you have a spare dry torch, light it. Six Pack is a little upset, and is going back to the other boat on the beach, and is going to teach that overgrown monster not to mess with a Rock Demon. Follow the ledge back to the beach and roll for a wandering monster. Fight it - if you survive, go to {26}."
},
{ // 132/24F
"You pound on the door for Mongo to open up. Roll one die: if you roll a 6, Mongo opens the door and you escape anything chasing you. Go to {16}. If you roll 1 to 4, that's how many combat rounds you will have to fight anything chasing you. If you roll a 5, Mongo has forgotten you, and you will have to fight to the death anything chasing you. [Since you are at the top of the stairs, you can add 5 to your combat die roll. Also, anything that's after you can only advance two at a time. ]If you're still alive, keep pounding on the door until Mongo hears you and remembers you're down there. Go to {16}."
},
{ // 133/25A
"Six Pack sniffs the door and backs away, spitting \"A Death Vortex Lock! I know how to fix that!\" He shakes his keg, and points the spigot at the door. Opening the spigot, the canny Rock Demon blasts the door with foam. Then, calmly walking over to the door, Six Pack kicks it open and tells you to hurry before the trap goes back into operation. Go to {31}."
},
{ // 134/25B
"Six Pack loads the raft and holds a torch. You grab a pole and push off. You follow the ledge in an easterly direction for about 250' when Six Pack screams in terror and points to the water. Coming at the raft, just above the water, are two large shining eyes - and 9' in front of the eyes are two huge nostrils. The monster opens its jaws and all you can see are teeth. He crunches the raft in two, and you and Six Pack fall into the water. Snorting in disgust, the monster turns around and swims away (you would, too, if you had just gotten a mouthful of bamboo). If you have any armour on (other than Blue Elf armour), make a L1-SR on Dexterity (20 - DEX) to see if you can get out of it in time. If you make it, go to {131}. If you miss, you sink. You drown. You close the book."
},
{ // 135/25C
"Make L1-SRs on Intelligence (20 - IQ) and Luck (20 - LK). If you make them, go to {93}. If you miss either of them, go to {62}."
},
{ // 136/25D
"The door closes behind you, and you find yourself in a large circular domed room. In the centre of this room is an 8' tall, snowy white 'Knuckle Duster' (so named because its arms reach the floor). The creature has a MR of 26, but its matted hairy hide gives it the ability to take an additional 8 hits as if on armour. It paws the ground and charges you. Six Pack screams with rage and charges - stumbles - does a double backflip - and passes out cold on the dungeon floor. The Knuckle Duster ignores Six Pack and heads straight for you. If you stand and fight, go to {32}. If you run for the dungeon entrance, with the Knuckle Duster close on your heels (and thus abandoning Six Pack), go to {132}."
},
{ // 137/26A
"Roll one die and add that number to your Charisma. You wake up to find yourself in a bare torchlit room with Six Pack. One half of your gold and jewels are gone, but now there are two rune-covered oak kegs.\n" \
"  Six Pack tells you that after you took your first swig from the mug, you shouted, \"I'll buy a round for the house!\" and then passed out cold on the floor. The next thing Six Pack knew, there were dwarves all over the place. So, Six Pack gave them your share of the gold and jewels, and bought you a never-empty keg like his (which is worth 5000 gp). After a few friendly hours of drinking, Six Pack told the dwarves he wanted the best place in the dungeon to take a nap. As near as he can remember, the dwarves picked your slumbering body up, and everyone trouped down a secret passage, stopped once for a round of drinks, and ended up here. After one more round, Six Pack caught a few winks. However, Six Pack tells you not to be so upset, that the dwarves said that the first drink from a new magic keg will knock you flat - but after that, it's just like real ale!\n" \
"  If your head wasn't throbbing so badly, you would probably kill Six Pack. As you look around the room, it comes to you that this is where you first met the obnoxious little Rock Demon. You ask about the secret door, but Six Pack remembers telling the dwarves to lock the door so he could get some rest; anyway, he tries it and it is locked tight. Six Pack refuses to leave by the south door, because that way leads to the Wizard, who might take away his magic keg. So back you go, to 67.\n" \
"  (Note: you may not take any treasures from rooms you have already looted. Use the optional wandering monster chart. Watch out for the red-robed priests, they are holding another service. Your friendly barge man will let you try any options you haven't tried before. Good luck.)"
},
{ // 138/26B
"Make a L1-SR on Dexterity (20 - DEX). If you made it, and were jumping west, go to {42}. If you were jumping east, go to {119}. If you missed, you fell into the river and have been wiped out by a school of killer guppies. Close the book."
},
{ // 139/26C
"The floor opens under you, and you drop 15' into a water-filled pit. If you're wearing any armour except Blue Elf Armour, you drown. If you survive, go to {83}."
},
{ // 140/26D
"As you walk among the yellow poppies, you quietly fall asleep. You never wake up."
},
{ // 141/27A
"You can see the torchlit Treasure Room of the Red Priests. Bags of gold, heaps of jewels, glowing magic arms and armour, all are stacked along the walls. Go back to {111}."
},
{ // 142/27B
"You are in the south end of a long tunnel. If you want to open the south door, go to {67}. If you want to go north, go to {151}."
},
{ // 143/27C
"The wall to the north opens, revealing descending stairs. Go to {122}."
},
{ // 144/27D
"You are in a dimly lit room with a suit of dusty chain mail hanging on the north wall. Under the chain mail is a bulging leather sack. Six Pack sniffs the armour, and the sack and says they both stink of elves. You may leave by the west door, go to {40}. If you put on the armour, go to {85}. If you pick up the sack, go to {95}."
},
{ // 145/27E
"A barge slowly emerges from the south tunnel with a red-bearded, one-eyed dwarf at the helm. He tells you to hurry up, he is late. The dwarf winks at Six Pack and says he hasn't been around in some time. Six Pack tries, but cannot remember the dwarf. Anyway, he doesn't like the looks of him. (Six Pack doesn't like dwarves - or anyone else, for that matter. Rock Demons are violently antisocial.) If you attack the dwarf (which would please Six Pack to no end), go to {38}. If you board the barge, dragging Six Pack with you, go to {105}."
},
{ // 146/28A
"You are in an 'L' shaped tunnel. To the north is a wood door; to the west is a wood pier. If you want to use the door, go to {59}. If you want to go to the pier, go to {119}."
},
{ // 147/28B
"As you walk around the cooling corpse, you see the dusty wood chest by the far wall. If you leave the room by the single exit, go to {67}. If you open the chest, go to {12}."
},
{ // 148/28C
"Make a L1-SR on Luck (20 - LK). If you make it, go to {129}. If you missed, the walls are getting closer and closer. Six Pack is babbling in terror. You may push the button again, and go to {23}. If you try the door, go to {22}."
},
{ // 149/28D
"You are a little stupid. Take one point from your Intelligence. Six Pack won't answer you. Make a L1-SR on Luck (20 - LK) - if you make it, go to {80}. If you missed, go to {121}."
},
{ // 150/28E
"You may return Mongo's weapon and leave his services, and that is the end of your adventuring here. Close the book. Or, you may rest up and try again. Mongo will heal any hurts, and resupply you - but you took his last flask of poison, and so will have to make do with what you have left, if any. Now go to {39}."
},
{ // 151/28F
"You are in the middle of a dark north/south tunnel. If you want to stop and search for a secret door, make a L1-SR on Luck (20 - LK). If you make it, go to {45}. If you want to go south, go to {142}. If you want to go north, go to {24}."
},
{ // 152/29A
"As you go for the exit, Six Pack swings with his long sword at the statue of the Knuckle Duster, and shatters it into tiny pieces. Go to {98}."
},
{ // 153/29B
"You are on a stairway. You may descend eastward to the dimly lit room at the bottom (go to {40}). To the west, at the top of the stairs, is a concealed door which you may open (go to {151})."
},
{ // 154/29C
"You already had your chance. With a look of disgust, Mongo waves his hand, and you turn into a blue frog (blue frog legs are a gourmet delight that Mongo is exceedingly fond of)."
},
{ // 155/29D
"The armour is Blue Elf and can be sold for 2000 gp. It weighs only 20 weight units, and will take 10 hits each combat round. You may exit the room (go to {40}). You may pick up the sack if you haven't already done so, and go to {95}."
},
{ // 156/29E
"Not a wise move. A capricious deity removes 2 points from your Intelligence. You see a long line of red-robed priests coming from the east end of the tunnel - they also see you! Go to {9}."
},
{ // 157/29F
"As the sound of the gong dies away, the forest becomes strangely silent. From the road by the woods charges an attacking minidragon. It has a MR of 68 (7 dice and 34 adds). If you're still alive after the fight, you get 100 experience points, but lose one point from your Intelligence for messing up the wizard's garbage disposal. If you want to reenter the dungeon, and start over again, go to {118}. If you have any sense at all, you'll just go back to the tavern and drown your sorrows in as much ale as you can afford. If you call it a day, take 100 ap for escaping alive. Then close the book..."
}
}, sh_wandertext[18] = {
{ // 0
"1; 1,2: Ice giant. 10' tall, armed with a great sword which glitters like ice.\n" \
"  If you're defeated, you'll provide frozen dinners for tall the dungeon monsters...\n"
"  MR 48 (5 + 24)"
},
{ // 1
"1; 3,4: Crystal demon. 6' tall, looks like a warrior made all of crystal quartz. Armed with a transparent sword.\n" \
"  If you had a torch lit, the light reflects so brightly that it shocks you at first. Roll 1 die and subtract that from your DEX for 1 combat turn.\n" \
"  MR 50 (6 + 25)"
},
{ // 2
"1; 5,6: Manticore. This legendary creature has the body of a lion, a scorpion's tail, and a human face with three jaws. Let Six Pack fend off that tail, because it has venom enough to lay you flat at a stroke...\n" \
"  MR 66 (7 + 33)"
},
{ // 3
"2; 1,2: Wild dogs. Lean and hungry, spotted and mangy. You look like dinner to them.\n" \
"  Roll 1 die to determine the number which appears.\n" \
"  MR 12 each (2 + 6)"
},
{ // 4
"2; 3,4: Blood bats. Distant and voracious relatives of vampire bats, these attack in swarms.\n" \
"  Roll 2 dice to determine the number of bats attacking.\n" \
"  MR 8 each (1 + 4)"
},
{ // 5
"2; 5,6: Werewolf. Ugly, hairy, and stooped to about 5' tall. Armed with tooth & claw. Can only be affected by silver or magic weapons. Normal weapons will provide defence for you, but will not damage the werewolf.\n" \
"  MR 32 (4 + 16)"
},
{ // 6
"3; 1,2: Giant spiders. Each one is the size of a human fist, and is poisonous. If hits are taken on CON, in two turns you will be paralyzed, unless you get back to Mongo.\n" \
"  Roll 2 dice to determine the number which attacks.\n" \
"  MR 6 each (1 + 3)"
},
{ // 7
"3; 3,4: 2 toad warriors. Short, green and ugly, they carry axes coated with a poison similar to that which Mongo gave you. Any hits to your CON must be doubled to account for this.\n" \
"  MR 26 each (3 + 13)"
},
{ // 8
"3; 5,6: 3 ghouls. Grey-green skin and bad breath from unsavoury eating habits. Armed with the white thighbones of past feasts.\n" \
"  MR 12 each (2 + 6)"
},
{ // 9
"4; 1,2: 2 stone men. 6' tall, lumbering men who seem to be carved from granite. Every combat turn make a L1-SR on Luck (20 - LK). If missed, your weapon has shattered on their rocky bodies, and you must go to a secondary weapon or flee.\n" \
"  MR 22 each (3 + 11)"
},
{ // 10
"4; 3,4: Minotaur. 7' tall, with shoulders fully 3' wide! Armed with an ironbound club.\n" \
"  MR 60 (7 + 30)"
},
{ // 11
"4; 5,6: Fire giant. One head, 9' tall, armed with a massive two-handed sword that blazes with its own light. The flame cannot hurt Six Pack, but it can hurt you! All hits must be taken by you.\n" \
"  The sword and the giant both go up in smoke if you defeat him.\n" \
"  MR 52 (6 + 26)"
},
{ // 12
"5; 1,2: Shadow demon. 7' black shadow with glowing red eyes. Armed with a black mace. Must make a L1-SR on DEX (20 - DEX) each combat turn to avoid an unexpected attack. Even if you hit it, and you miss your SR, you must take the difference in his to CON.\n" \
"  MR 68 (7 + 34)"
},
{ // 13
"5; 3,4: 2 enchanted warriors. Undead but still fighting. Wearing glowing leather, armour, armed with pitted broadswords. Regenerate 2 points per combat turn until killed outright.\n" \
"  MR 20 each (3 + 10)"
},
{ // 14
"5; 5,6: Rats. Stinking, sharp-toothed, and nasty. These also run in packs.\n" \
"  Roll 3 dice for the number you encounter.\n" \
"  MR 2 each (1 + 1)"
},
{ // 15
"6; 1,2: Sphinx. Body of a lioness with a woman's torso. This one is too mindless to be captured by riddles.\n" \
"  MR 54 (6 + 27)"
},
{ // 16
"6; 3,4: 2 cave lions. 4' high at the shoulder, with greasy whitish coats.\n" \
"  MR 24 each (3 + 12)"
},
{ // 17
"6; 5,6: 2 warriors of the undead. Bad breath and body odour, 6' tall, armed with glowing swords.\n" \
"  Unaffected by poison.\n" \
"  MR 28 each (3 + 14)"
}
};

MODULE SWORD sh_exits[SH_ROOMS][EXITS] =
{ { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  { 116, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  41,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  { 117,  64, 124,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  { 140,  59,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  { 101, 132,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  { 137, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  50,  52,  35,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  94,  30, 102,  -1,  -1,  -1,  -1,  -1 }, //  13
  { 117,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  { 108,  42, 119,  -1,  -1,  -1,  -1,  -1 }, //  17
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  { 111,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {   8,  79,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {   4, 143,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  { 149, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  69,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  89,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  { 102,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  18, 134, 126,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  11,  58,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  29,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  49, 132,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  { 122, 153, 144,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  96, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  81, 138,  17,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  { 153, 151,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  67,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  { 135,  52,  35,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  97, 154,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  64, 117,  11,  -1,  -1,  -1,  -1,  -1 }, //  52
  { 110,  88,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  { 151,  58,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  28,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  40,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  { 151,  19,  35,  -1,  -1,  -1,  -1,  -1 }, //  58
  { 119,   8,  21,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  93,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  { 146,  42, 108,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  56,  28,  61,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  { 120,   2, 125,  49,  -1,  -1,  -1,  -1 }, //  67
  {  79,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  { 111,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  {  60,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  63,  38,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  {  34,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  { 119,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  42,  91,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  { 111,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  30, 102,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  {  81, 152,  26,  98,  -1,  -1,  -1,  -1 }, //  91
  {   5, 130,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  { 106,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {  30, 102,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  {  81,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  54,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  { 148,  23,  22,  -1,  -1,  -1,  -1,  -1 }, // 102
  {  40,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  66,  44,  48,  74,  -1,  -1,  -1,  -1 }, // 105
  {  52,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  52,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  {  87, 123,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  {  99,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  70, 141,  82,  58,  -1,  -1,  -1,  -1 }, // 111
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  { 137,  78,   1,  -1,  -1,  -1,  -1,  -1 }, // 116
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  {  37,  72,  20,  -1,  -1,  -1,  -1,  -1 }, // 118
  { 138,  17, 146,  -1,  -1,  -1,  -1,  -1 }, // 119
  { 142,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  {  13,  40,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  13,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {  15,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  {  22,  23,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  { 113, 145,  92,  -1,  -1,  -1,  -1,  -1 }, // 130
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  {  32, 132,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  42, 119,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  {  83,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  { 111,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  {  67, 151,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  { 122,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  40,  85,  95,  -1,  -1,  -1,  -1,  -1 }, // 144
  {  38, 105,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  59, 119,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {  67,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  {  23,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  {  39,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  { 142,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  {  98,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  40, 151,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  {  40,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 157
};

MODULE STRPTR sh_pix[SH_ROOMS] =
{ "", //   0
  "",
  "",
  "",
  "",
  "", //   5
  "",
  "",
  "sh8",
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
  "sh37",
  "",
  "",
  "", //  40
  "",
  "",
  "",
  "",
  "", //  45
  "",
  "sh47",
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
  "sh60", //  60
  "",
  "",
  "",
  "",
  "sh65", //  65
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
  "sh118",
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
  "sh134",
  "", // 135
  "sh136",
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
  ""  // 157
};

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

MODULE void sh_enterroom(void);
MODULE void sh_wandering(FLAG mandatory);

EXPORT void sh_preinit(void)
{   descs[MODULE_SH]   = sh_desc;
    wanders[MODULE_SH] = sh_wandertext;
}

EXPORT void sh_init(void)
{   int i;

    exits     = &sh_exits[0][0];
    enterroom = sh_enterroom;
    for (i = 0; i < SH_ROOMS; i++)
    {   pix[i] = sh_pix[i];
}   }

MODULE void sh_enterroom(void)
{   TRANSIENT int i,
                  result;
    PERSIST   int gpgiven,
                  priests;

    switch (room)
    {
    case 2:
        DISCARD makelight();
        if (lightsource() != LIGHT_NONE)
        {   room = 136;
        }
    acase 3:
        gpgiven = getnumber("Give how many gp", 0, gp);
        pay_gp(gpgiven);
        if (gpgiven == 0)
        {   room = 63;
        } else
        {   room = 6;
        }
    acase 5:
        makelight();
        if (lightsource() != LIGHT_NONE)
        {   room = 92;
        }
    acase 6:
        if (gpgiven >= gp)
        {   room = 73;
        } else
        {   room = 63;
        }
    acase 7:
        if (armour != EMPTY && armour != 459)
        {   dropitem(armour);
        }
        if (rt != EMPTY && items[rt].type == SHIELD)
        {   dropitem(rt);
        }
        if (lt != EMPTY && items[lt].type == SHIELD)
        {   dropitem(lt);
        }
        // %%: what about carried armour/shields?
        for (i = 0; i < ITEMS; i++)
        {   if ((i < 451 || i > 453) && items[i].owned)
            {   dropitems(i, items[i].owned);
        }   }
        rb_treasure(2);
    acase 9:
        create_monsters(227, 2);
        priests = 4;
    acase 10:
        sh_wandering(FALSE);
    acase 12:
        if (saved(1, lk) && saved(1, iq) && saved(1, dex))
        {   room = 77;
        } else
        {   room = 7;
        }
    acase 15:
        die();
    acase 18:
        sh_wandering(TRUE);
        room = 31;
    acase 20:
        lose_iq(1);
    acase 21:
        do
        {   result = getnumber("0) Neither\n1) Red\n2) Black\nPick which", 0, 2);
            if (result == 1)
            {   give(449);
                if (!saved(1, lk))
                {   room = 53;
            }   }
            elif (result == 2)
            {   give(450);
                if (!saved(1, lk))
                {   room = 53;
            }   }
        } while (result != 0 && room == 21);
    acase 22:
        give(448);
    acase 23:
        die();
    acase 24:
        DISCARD makelight();
        if
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
         || lightsource() == LIGHT_WO
         || lightsource() == LIGHT_CRYSTAL
        )
        {   room = 156;
        }
    acase 26:
        give_multi(457, 6);
    acase 27:
        victory(1000);
    acase 28:
        dispose_npcs();
    acase 29:
        give_multi(449, 5); // maybe we should implement this as a separate "flask of poppy poison" item?
        if (st < 9)
        {   room = 112;
        } elif (st < 15)
        {   room = 89;
        }
    acase 30:
        lose_iq(1);
    acase 31:
        sh_wandering(FALSE);
    acase 32:
        oneround();
        oneround();
        oneround();
        room = 84;
    acase 33:
        gain_st(dice(1));
        gain_con(dice(1));
    acase 34:
        result = getnumber("1) You\n2) Six Pack\n3) Not sure\nWhich", 1, 3);
        if (result == 1)
        {   room = 128;
        } elif (result == 2)
        {   room = 133;
        } else
        {   // assert(result == 3);
            if (dice(1) <= 3) room = 128; else room = 133;
        }
    acase 36:
        // %%: this paragraph contradicts itself
        // %%: and are shields considered to be armour? We are assuming yes.
        while (shop_give(6) != -1);
        give(TOR);
        savedrooms(1, iq, 76, 65);
    acase 38:
        die();
    acase 40:
        sh_wandering(FALSE);
    acase 41:
        good_takehits(15, TRUE);
    acase 43:
        victory(0);
    acase 44:
        savedrooms(1, con, 33, 87);
    acase 46:
        die();
    acase 47:
        give(451);
    acase 48:
        savedrooms(1, lk, 33, 55);
    acase 50:
        sh_wandering(TRUE);
    acase 53:
        if (ability[55].known && getyn("Go to paragraph 68"))
        {   room = 68;
        }
    acase 55:
        drop_all();
        award(300);
        if (getyn("Stay"))
        {   room = 157;
        } else
        {   victory(0);
        }
    acase 56:
        create_monster(222);
        oneround();
        if (!countfoes())
        {   room = 43;
        }
    acase 57:
        award(50);
        // we didn't take their magic weapon in SH83, so we don't have to give it back to them now
    acase 60:
        result = getnumber("1) Pay 10%\n2) Return weapon\n3) Threaten Mongo\nWhich", 1, 3);
        if (result == 1)
        {   pay_cp(money / 10);
            room = 27;
        } elif (result == 2)
        {   dropitem(451);
            dropitem(452);
            dropitem(453);
            room = 27;
        } else
        {   // assert(result == 3);
            room = 114;
        }
    acase 61:
        lose_dex(1);
    acase 62:
        gain_flag_ability(55);
    acase 63:
        give(TOR);
        DISCARD makelight();
        if (lightsource() == LIGHT_NONE)
        {   room = 108;
        }
    acase 64:
        savedrooms(1, dex, 14, -1);
    acase 66:
        savedrooms(1, st, 55, 87);
    acase 67:
        sh_wandering(FALSE);
    acase 72:
        create_monster(223);
        fight();
        lose_iq(1);
    acase 73:
        if (dice(1) == dice(1))
        {   give(454);
        }
    acase 74:
        DISCARD makelight();
        if (lightsource() == LIGHT_NONE)
        {   room = 3;
        } else
        {   room = 100;
        }
    acase 75:
        savedrooms(1, lk, 71, -1);
    acase 77:
        rb_treasure(2);
        rb_treasure(2);
        give(455);
    acase 78:
        if (dice(1) == dice(1))
        {   die();
        }
    acase 80:
        if
        (   items[455].owned // we assume they are also wearing it
         || (   saved(1, lk)
             && saved(1, lk)
             && saved(1, lk)
             && saved(1, lk)
             && saved(1, lk)
             && saved(1, lk)
        )   )
        {   room = 54;
        } else
        {   room = 9;
        }
    acase 83:
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && (i < 451 || i > 453))
            {   if (isweapon(i) || items[i].type == SHIELD)
                {   dropitems(i, items[i].owned);
        }   }   }
        pay_gp(gp);
        if
        (   gotrope(1)
         && (saved(1, dex) || saved(1, dex) || saved(1, dex))
        )
        {   room = 57;
        } else
        {   die();
        }
    acase 84:
        fight();
        room = 147;
    acase 85:
        if (saved(1, lk) && saved(1, chr))
        {   room = 155;
        } else
        {   room = 139;
        }
    acase 87:
        gain_st(10);
        gain_con(10);
        result = dice(1);
        elapse(ONE_YEAR * result, TRUE);
#ifdef CORGI
        if (getyn("Go to Blue Frog Tavern"))
#else
        if (0)
#endif
        {   room = 0;
            module = MODULE_BF;
        } else
        {   victory(0);
        }
    acase 88:
        if (saved(1, st) && saved(1, lk) && saved(1, dex))
        {   room = 79;
        } else
        {   templose_con(dice(1));
            room = 110;
        }
    acase 89:
        give(452);
    acase 90:
        die();
    acase 91:
        sh_wandering(FALSE);
        if (been[91])
        {   room = 127;
        }
    acase 92:
        sh_wandering(FALSE);
    acase 93:
        give(458);
        give_gp(50);
    acase 94:
        if (saved(1, lk))
        {   room = 86;
        }
    acase 95:
        if (saved(1, lk) && saved(1, iq))
        {   room = 103;
        } else
        {   room = 139;
        }
    acase 96:
        create_monster(224);
        oneround();
        oneround();
        oneround();
        room = 104;
    acase 97:
        dropitem(451);
        dropitem(452);
        dropitem(453);
        victory(50);
    acase 98:
        create_monsters(225, dice(1));
        fight();
    acase 99:
        victory(1000);
    acase 101:
        do
        {   oneround();
            result = countfoes();
            if (result < 2 && priests)
            {   create_monster(227);
                priests--;
                if (result < 1 && priests)
                {   create_monster(227);
                    priests--;
        }   }   }
        while (con >= 1 && countfoes());
    acase 103:
        give_gp(100);
    acase 104:
        fight();
        room = 147;
    acase 110:
        create_monster(226);
        fight();
    acase 112:
        give(453);
    acase 114:
        if (saved(1, chr))
        {   room = 109;
        } else
        {   good_takehits(46, TRUE);
            room = 99;
        }
    acase 115:
        die();
    acase 117:
        savedrooms(1, lk, 107, -1);
    acase 120:
        give(TOR);
        makelight();
        if (lightsource() == LIGHT_NONE)
        {   room = 67;
        }
 /* acase 121:
        ; // %%: we should perhaps let the player loot the torch(es) after the battle
 */ acase 123:
        die();
    acase 124:
        create_monsters(208, dice(2));
        fight();
    acase 128:
        die();
    acase 131:
        makelight();
        sh_wandering(TRUE);
        room = 126;
    acase 132:
        if (prevroom == 9)
        {   // assert(priests == 4);
            create_monsters(227, priests); // create the other 4 priests
        }
        result = dice(1);
        if (result == 5)
        {   fight();
        } elif (result <= 4)
        {   for (i = 1; i <= result; i++)
            {   oneround();
        }   }
        dispose_npcs();
        room = 16;
    acase 134:
        if (armour != -1 && armour != 459 && !saved(1, dex))
        {   die();
        } else
        {   room = 131;
        }
    acase 135:
        if (saved(1, iq) && saved(1, lk))
        {   room = 93;
        } else
        {   room = 62;
        }
    acase 136:
        create_monster(224);
    acase 137:
        gain_chr(dice(1));
        pay_gp(gp / 2);
        give(460);
    acase 138:
        if (!saved(1, dex))
        {   die();
        }
    acase 139:
        if (armour != -1 && armour != 459)
        {   die();
        }
    acase 140:
        die();
    acase 148:
        if (saved(1, lk))
        {   room = 129;
        }
    acase 149:
        lose_iq(1);
        savedrooms(1, lk, 80, 121);
    acase 150:
        if (getyn("Leave (otherwise try again)"))
        {   dropitem(451);
            dropitem(452);
            dropitem(453);
            victory(0);
        } else
        {   healall_st();
            healall_con();
            while (shop_give(6) != -1);
            room = 39;
        }
    acase 151:
        if (getyn("Search for secret doors") && saved(1, lk))
        {   room = 45;
        }
    acase 154:
        die();
    acase 155:
        give(459);
    acase 156:
        lose_iq(2);
    acase 157:
        create_monster(223);
        fight();
        lose_iq(1);
        if (getyn("Reenter dungeon"))
        {   room = 118;
        } else
        {   victory(100);
}   }   }

MODULE void sh_wandering(FLAG mandatory)
{   int result;

    aprintf(
"WANDERING MONSTER TABLE\n" \
"  Roll one ordinary six-sided die twice to determine which monster(s) you must fight. If you defeat a monster, you get its MR in adventure points. [(However, if you kill 10 rats, you still get only 2 points - what's the difference in killing 1 rat or 10, all at the same time and place?) You may not loot a dead monster of its weapons or armour, as these will most likely disappear when the creature(s) disappear, anything left has powerful curses which will kill you if you try to use it. If you have a favourite wandering monster list, or if you want to use the list from another dungeon, go ahead.] Note, however, that this system of obtaining wandering monsters provides more variety than simply rolling two dice (two dice will give a number which tends towards the mean - this system is more assuredly random).\n" \
"  If you kill a wandering monster, return to the paragraph which sent you here.\n"
    );

    if (!mandatory && dice(1) >= 2)
    {   return;
    }

    result = ((dice(1) - 1) * 3) + ((dice(1) - 1) / 2);
    aprintf("%s\n", sh_wandertext[result]);
    switch (result)
    {
    case 3: // dogs
        create_monsters(204 + result, dice(1));
    acase 4: // bats
    case 6: // spiders
        create_monsters(204 + result, dice(2));
    acase 7: // toad warriors
    case 9: // stone men
    case 13: // enchanted warriors
    case 16: // sphinxes
    case 17: // warriors of the undead
        create_monsters(204 + result, 2);
    acase 8: // ghouls
        create_monsters(204 + result, 3);
    acase 14: // rats
        create_monsters(204 + result, dice(3));
    adefault: // giants, demons, manticore, werewolf, minotaur, sphinx
        create_monster(204 + result);
    }

    fight();
}
