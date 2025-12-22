#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Perhaps we should edit the text to explicitly incorporate the extra 10
MR and gracious loser bonuses for 5th edition.

Errata:
 LA69: Probably cp is meant rather than sp.
*/

MODULE const STRPTR la_desc[LA_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  Because of the increased dice and adds given to weapons and armour in the revised fifth edition of the Tunnels & Trolls rulebook, you may find that this dungeon will be too weak to properly challenge your characters - the Wanderers will be relatively weak, as this solitaire was designed under earlier editions of the rulebook.\n" \
"  To return the balance of play, and a personal sense of 'fairness' to this solitaire, it is suggested that you increase Monster Ratings and 'gracious loser ratings' by 10 points. This should make the dungeon a challenge once again, without becoming an unforgiving deathtrap.\n" \
"  Also, in accordance with the new 5th edition of the T&T rules, sometimes we use the term \"adventure points\". Adventure points (ap) and experience points (ep) are the same thing, and these terms are used interchangeably throughout this dungeon.\n" \
"INTRODUCTION\n" \
"  Labyrinth is an adventure with an ancient Grecian theme. Mythology, legend, and history are herein mingled with no regard for proper chronology. Absolutely no medieval or modern characters or monsters abide in Labyrinth. And no Roman variants of Grecian names or ideas will be found, either. (A Roman dungeon would be fun too, but this is a Greek dungeon.)\n" \
"  Those of you who are learned in the stories of ancient Greece are asked to lay your serious scholarship aside in Labyrinth and just enjoy the fun. Those of you who are unfamiliar with the stories of ancient Greece are happily invited to discover a whole new world of wonders.\n" \
"  Only 1st and 2nd level human warriors may enter the Labyrinth, and only one character may enter at a time. Advanced characters with advanced weapons belong elsewhere. And barbarian magic simply doesn't work in the clear rational light of civilized Greece (nor in the dark, for you hair-splitters). What appears to be magic in the Labyrinth is actually divine intervention. From time to time, a character may be given a divine charm which functions as a magical device and takes no wizardry or strength to use. These charms may be taken out of the Labyrinth and will continue to work (unless nay-sayed by individual Game Masters).\n" \
"  To adventure into the Labyrinth, you will need the usual assortment of pencils, paper, dice and the T&T rules. All native fighters in the Labyrinth have monster ratings and fight according to the T&T combat rules. Whenever you are told to roll for treasure, use the Treasure Generator in the T&T rulebook.\n" \
"  *All saving rolls will be made at your character level.* If you are a 1st level character, you'll always make first level saving rolls (20 - LK); if you are a 2nd level character, you'll make 2nd level saving rolls (25 - LK). (Note: LK is Luck.)\n" \
"  *Invocations and saving rolls are the same thing.* Whenever the instructions tell you to \"make an invocation\" or \"invoke the gods\", you make a saving roll. The reason for this is that the Labyrinth contains gods and goddesses. An invocation is a prayer for intervention in your behalf by a divine power. In most dungeons there are no divine powers, so blind luck must be invoked with a saving roll. It's the same thing, only in the Labyrinth the powers invoked have personalities.\n" \
"  Occasionally you will be told to make an invocation based on some other attribute - such as Charisma or Dexterity. Just substitute that attribute for Luck. (It's easy.)\n" \
"  The gods and goddesses in the Labyrinth are immortal, and if they fight you, you can't kill them. But they will have both a \"Monster Rating\" and a \"Gracious Loser Rating\". The gracious loser rating is a number on the Monster Rating scale. Whenever you reduce an immortal combatant to his/her/its gracious loser rating, the fight is conceded to you - you win.\n" \
"  There will be times when you will need to keep track of turns in the Labyrinth. In non-combat situations, a turn will consist of the length of time you spend on one paragraph before you turn to another paragraph. Five combat turns equal one regular turn. If you have 10 go-rounds of combat at paragraph {97A}, that counts as 2 turns.[ Round off partial turns to the highest whole before going on (if you have 7 or 8 combat go-rounds at {97A}, that also counts as 2 turns).\n" \
"  Any time you are drunk in the Labyrinth, you will stay drunk for 4 regular non-combat turns. Or, since activity and adrenalin burn the alcohol out of the system, 2 combat turns will sober you right up.]\n" \
"  Both monsters and deities roam the Labyrinth as Wanderers. Whenever you are told to meet one or to see if you've met one, consult the instructions on the Wanderers page.\n" \
"  After you have read these instructions carefully, go to the Entrance on the next page.\n" \
"~ENTRANCE\n" \
"  The Cretan soldier you have bribed to take you to Labyrinth has led you to a cave-like entrance some distance from the palace. He has told you that if you can find them, there are other ways out of the Labyrinth. He has also told you that the clear light of ancient Greece permeates, at least dimly, even into the depths of the Labyrinth. He also tells you that he thinks you are some crazy kind of barbarian for wanting to go into the Labyrinth and take a chance on running into the famous Minotaur.\n" \
"  Just after you step inside the Labyrinth, a minor earthquake (a prelude to the major one that will someday destroy both the palace and the Labyrinth) closes the entrance behind you. You can stay here and try to get out until you starve - or you can go to {149}."
},
{ // 1/1A
"The man smiles and tells you that his land is indeed a bountiful land where few need hunger. He gives you 10 gp as evidence of bountifulness. Thank him and go to {13}."
},
{ // 2/1B
"You are in a corridor running east-west. To the east, the corridor ends in a wall with a door. If you wish to open the door, go to {66}. If you wish to go west, go to {29}."
},
{ // 3/1C
"You are in a north-south corridor. If you wish to go north, go to {160}. If you wish to go south, go to {95}."
},
{ // 4/1D
"You dine handsomely on mutton and wine. The food is safe and Polyphemus enjoys your stories. He gives you a golden apple as a host-gift when you leave. The apple is worth 5 gp, and weighs accordingly. Return to {66} and leave this room."
},
{ // 5/1E
"You are in a north-south corridor. If you wish to go north, go to {16}. If you wish to go south, go to {144}."
},
{ // 6/1F
"You are in a corridor running north-south. To your east is a door. If you wish to open the door, go to {38}. If you wish to go north, go to {28}. If you wish to go south, go to {110}."
},
{ // 7/1G
"The Mother blesses you, raising your Constitution by 1 point. If you wish to go through the curtain behind the altar, go to {84}. If you wish to leave by the north door, go to {31}. If you wish to leave by the east door, go to {74}.[ (If you just came in from behind the curtain, you must now leave by one of the doors.)]"
},
{ // 8/2A
"You are in a north-south corridor. If you wish to go north, go to {156}. If you wish to go south, go to {142}."
},
{ // 9/2B
"You are unable to resist the Siren song, and sail too close to the island. You are caught in dangerous waters. The last sight you see is a dream-image of a beautiful face dissolving into a laughing skull, before you are smashed to death against the rocks."
},
{ // 10/2C
"You see 3 men standing in the centre of the room, engaged in a discussion. They are all unarmed and simply dressed. (If you have been in this room before, the men are now gone. Roll to see if you meet a Wanderer.)\n" \
"  If you wish to fight, go to {78}. If you wish to speak to the men, go to {170}. If you wish to leave the room without distracting them, it will be easy to do. To leave by the north door, go to {107}. To leave by the south door, go to {85}."
},
{ // 11/2D
"You are at an L-intersection. To the west is a wall with a door. If you wish to open the door, go to {38}. If you wish to go north, go to {116}. If you wish to go east, go to {26}."
},
{ // 12/2E
"She tells you that she is lonely and issues a double-entendre sexual invitation that you may choose to accept or refuse without seeming to insult her either way. If you accept, go to {62}. If you refuse, go to {126}."
},
{ // 13/2F
"You must leave this room now. If you wish to leave by the east door, go to {139}. If you wish to leave by the north door, go to {47}. If you wish to leave by the south door, go to {67}."
},
{ // 14/2G
"You are at a T-intersection. If you wish to go north, go to {67}. If you wish to go south, to {102}. If you wish to go west, go to {46}."
},
{ // 15/3A
"You have opened the door to a room containing a smallish, seven-headed hydra. If you wish to skip this room after seeing what it contains, go to {130}. If you wish to try and fight your way into the room, go to {169}. (If you've been to this room before, the hydra is gone and you roll to see if you meet a Wandering Monster or Deity.)"
},
{ // 16/3B
"You are in a T-intersection. If you wish to go west, go to {53}. If you wish to go south, go to {5}. If you wish to go east, go to {50}."
},
{ // 17/3C
"Failure to get involved in another's troubles is judged by the gods to be cowardice. The gods do understand. And in order to help you better understand what it is like to need help, your Luck is reduced by 1 point. Gain 10 ap for this valuable lesson. Go to {157}."
},
{ // 18/3D
"The room contains a large, ornately carved treasure chest. It is labelled \"Gifts of the Gods\". If you wish to open it, go to {120}. If you wish to leave (without opening it) by the west door, go to {107}. If you wish to leave by the east door, go to {144}."
},
{ // 19/3E
"You are in a corridor running east-west. If you wish to go east, go to {95}. If you wish to go west, go to {79}."
},
{ // 20/3F
"You are in a corridor running north-south. To the east is a door. If you wish to open the door, go to {131}. If you wish to go north, go to {159}. If you wish to go south, go to {70}."
},
{ // 21/4A
"Roll one die.\n" \
"  1 or 2: You have killed two harmless innocents. (You should be keeping track of how many of these you kill.) They had no money or treasure. Go to {13}.\n" \
"  3 or 4: You have attacked a god or goddess in disguise. They prevent anything from happening in the combat round of your unprovoked attack, and let you know that they are deities. Make 2 enthusiastic invocations. If both are successful, they decide that it's too pleasant a day to be bothered with feisty mortals, and zap you to 141. If only one invocation was successful, you get off pretty lightly with taking 1 hit to your CON and being pushed back out the door you came in. If both saving rolls were unsuccessful, you are in big trouble, friend. The deities decide that since you want to fight so badly, they will give you something to fight. You are zapped to {63}.\n" \
"  5 or 6: You are fighting Theseus, King of Athens and Hippolyta, Queen of the Amazons. Normally you wouldn't have a chance, but you caught them on a picnic with only their second-best weapons. Hippolyta takes you on first while Theseus lays back to enjoy watching her fight. She has a MR of 25. If you beat her down to a 9, Theseus takes over while she rests. He has a MR of 29. If you reduce him to a 9, Hippolyta takes over again, refreshed to a MR of 15. If you again reduce her to a 9, Theseus, refreshed to a rating of 20, takes over again. (Important note: Whenever your CON is reduced to 5 or less, [except during the first round with Hippolyta, ]you are captured from behind by whichever of the two you are not actively fighting at the moment. When this happens, go to {133}.) If you beat Theseus to yet another 9, he concedes that you are the better fighter and he offers you treasure and his hand in friendship to stop the fight now. If you accept, go to {45}. If you refuse, go to {86}."
},
{ // 22/4B
"She gives you a magic ball of string and tells you that you may use it any time you wish[ to return to her. (Make a note of how it works!) [Once per non-combat turn, you may take out the ball of string and make a saving roll/-invocation based on your CHR. If it is unsuccessful, you must wait one turn before trying again. If it is successful, it will take you instantly to {13}]. Now, go to {7}."
},
{ // 23/4C
"If you have not yet killed the famous Minotaur, this is your chance. Ariadne was his half sister, and he intends to avenge her death. (See the Wanderers section for instructions on encountering the Minotaur. If you are victorious, see the treasure rules.)\n" \
"  If you kill him now, or have previously killed him, you now learn that by killing Ariadne you have eliminated the easiest way out of the Labyrinth. Invoke the gods. If you are successful, go to {52}. If you are unsuccessful, go to {103}."
},
{ // 24/5A
"He offers you food and drink in exchange for tales of your adventures. If you accept, go to {4}. If you decline, you must make a decent excuse and return to {66} to exit the room."
},
{ // 25/5B
"You have entered the workship of the armourer and metal-smith of the gods. Hephaestus is a powerfully built, ugly god. He tells you that he is rather busy, but he does have time to sell you one item.\n" \
"  If you wish to buy a new sword, go to {163}; a new shield, go to {69}.\n" \
"  Or, you can leave without buying anything. If you wish to leave by the east door, go to {104}.\n" \
"  If you wish to leave by the north door, go to {125}."
},
{ // 26/5C
"You are at a T-intersection. If you wish to go east, go to {93}. If you wish to go west, go to {11}. If you wish to go south, go to {108}."
},
{ // 27/5D
"Roll one die. If it comes up 1, Ariadne will accept a token offering of 10 gold pieces. Any other result of the die roll, and you must pay 1/10th of all the treasure you have. After you have paid up, go to {80}."
},
{ // 28/5E
"You are in a 4-way intersection. Roll to see if you meet any kind of Wanderer and return here afterwards. Then, if you wish to go north, go to {85}. If you wish to go south, go to {6}. If you wish to go east, go to {97}. If you wish to go west, go to {74}."
},
{ // 29/5F
"You are in a T-intersection. If you wish to go north, go to {171}. If you wish to go east, go to {2}. If you wish to go south, go to {56}."
},
{ // 30/5G
"Aristotle teaches you how to untie Gordian knots. (This is a lesson, by the way, that his famous pupil, Alexander of Macedon, was too impatient to master.) Ten points have been added to your Dexterity. You must now leave this room. If you wish to leave by the north door, go to {107}. If you wish to leave by the south door, go to {85}."
},
{ // 31/5H
"You are in a corridor running north-south. To the south the corridor ends in a wall with a door. If you wish to open the door, go to {118}. If you wish to go north, go to {87}."
},
{ // 32/6A
"You are in a corridor running east-west. To the west, the corridor ends at a wall with a door. If you wish to open the door, go to {106}. If you wish to go east, go to {125}."
},
{ // 33/6B
"After each of the first six heads was killed, it was sloughed off (if it hadn't already been severed), and the Hydra has grown two heads to replace each one lost. You must now fight the 12 new mortal heads as they appear in the doorway - two at a time, this time. They still have a Monster Rating of 10 each.\n" \
"  If you decide it's time to give up and leave, go to {60}. If you fight and defeat these twelve heads, go to {148}."
},
{ // 34/6C
"You see a small forest and, on the edge of it, gazing at you in wonder, is a beautiful naked nymph. If you pursue her with lust in your heart, go to {51}. If you speak to her, go to {164}.\n" \
"  Or, you can leave, without doing anything. To leave by the south door, go to {138}. To leave by the west door, go to {59}."
},
{ // 35/6D
"The cyclops sees you - and attacks! Proceed at once to {115}."
},
{ // 36/6E
"Exit from room. If you wish to leave by the south door, go to {171}. If you wish to leave by the east door, go to {46}."
},
{ // 37/6F
"You are in an east-west corridor. To the west, the corridor ends in a wall with a door. If you wish to open the door, go to {92}. If you wish to go east, go to {70}."
},
{ // 38/6G
"Upon entering the room, you see clearly that it is totally empty. But you seem to hear very faint, far-off music. If you wish to leave the room immediately by the door you came in, do so. If you wish to stay and investigate for a minute or two, go to {91}."
},
{ // 39/7A
"You are in a T-intersection. To the north there is a door - if you wish to open it, go to {131}. If you wish to go east, go to {53}. If you wish to go west, go to {99}. If you wish to go south, go to {114}."
},
{ // 40/7B
"You see a spry, ugly little man dressed in a goatskin. He has the horns, tail and hooves of a goat, as well as a goatee-type beard.\n" \
"  (If you have been in this room before, it is empty now. Roll to see if a Wanderer appears. Then go to {36}.)\n" \
"  The little man is frolicking and playing a primitive reed instrument. If you wish to join the fun, go to {127}. If you wish to fight him, go to {96}. If you wish to leave the room (without doing anything) go to {135}."
},
{ // 41/7C
"He offers you food and drink. If you accept his hospitality, go to {76}. If you would rather not partake, exit the room in peace. To leave by the east door, go to {37}. To leave by the south door, go to {47}."
},
{ // 42/7D
"For each innocent death you are guilty of, invoke the goddess. Each succssful invocation cleanses you of one death. For each unsuccessful invocation, you must fast for a period of time and try again. (Each fasting period will cost you 1 Constitution point and 1 Strength point). Again, for each unsuccessful invocation, you must fast and try again. You may not leave until you are purified.\n" \
"  If you CON is reduced to 0, know that dying in the presence of the Mother cleanses you of all your sins in life and you will go to a place of the blessed dead.\n" \
"  Purified survivors, go to {7}."
},
{ // 43/7E
"If you run while the hydra is still half-tangled in the wall, go to {162}. If you fight, go to {83}."
},
{ // 44/8A
"The menaeds tear you limb from limb. You have just been sacrificed to the god."
},
{ // 45/8B
"Theseus gives you 500 gp and if you are guilty of the killing of any innocents, he absolves you here and now. If you wish to leave the Labyrinth now, go to {57}. If you don't wish to leave yet, go to {13}."
},
{ // 46/8C
"You are in a corridor running east-west. To the west is a wall with a door in it. If you wish to open the door, go to {40}. If you wish to go east, go to {14}."
},
{ // 47/8D
"You are in a north-south corridor. Each end of the corridor ends in a wall with a door. If you wish to open the north door, go to {92}. If you wish to open the south door, go to {165}."
},
{ // 48/8E
"This is understandable behavior. After the eagles have done with their bloody feast, they fly off. Their victim, the immortal, long-suffering Prometheus, tells you that men will one day be wiser and more just than the gods. Although it may take centuries, perhaps even millenia for your descendants to accomplish this, you yourself gain 50 immediate adventure points just for the knowledge. Go to {157}."
},
{ // 49/8F
"You are in a 4-way intersection. If you wish to go north, go to {75}. If you wish to go south, go to {104}. If you wish to go west, go to {125}. If you wish to go east, go to {59}."
},
{ // 50/8G
"You are in an east-west corridor. To the east, the corridor ends in a wall with a door. If you wish to open the door, go to {73}. If you wish to go west, go to {16}."
},
{ // 51/9A
"The dryad calls upon Artemis for help. You are turned into a tree. (And now you know how a forest got into a dungeon.)"
},
{ // 52/9B
"Hermes appears with the message that you may have a chance to get out of the Labyrinth if you can find either Theseus or Daedalus. (If you've already med Daedalus and killed Theseus, you're in a heap of trouble. In fact, the only way out of the Labyrinth now is for you to have Zeus' child.) If you want to go on, go to {7}."
},
{ // 53/9C
"You are in a corridor running east-west. If you wish to go east, go to {16}. If you wish to go west, go to {39}."
},
{ // 54/9D
"The Invincible Achilles weighs 350 and will absorb 2 hits per combat turn when in use[ (1 hit if carried on your back)]. It is also a great work of art, worth 750 gp if you can get it out of the Labyrinth intact.[ Every hit it absorbs will reduce its value at the rate of 30 gp a whack.]\n" \
"  [And, by the way, if you have ever been seduced by Aphrodite (Hephaestus' *wife*, you fool), the shield will crumble to dust the first time it is hit.\n" \
"  ]Now, you must leave the room. If you wish to leave by the east door, go to {104}. If you wish to leave by the north door, go to {125}."
},
{ // 55/9E
"Invoke the gods. If you are successful, you have drunk pure, sweet water. Double your ap from your invocation and return to {131} to exit the room.\n" \
"  If you were unsuccessful, you get a second chance. This time if you are successful, your plea has reached the ears of one god only: Dionysus. He changes the water to wine. You will be drunk (½ CON, ½ DEX, 1½ LK)[ for 4 regular turns or 2 combat turns]. Return to {131} and exit the room.\n" \
"  If both invocations/saving rolls were unsuccessful, you have drunk from Lethe, the river of forgetfulness. Since you have forgotten everything you ever learned from experience, your ap is reduced to zero and you are now a first-level character. Return to {131} and do what you think best."
},
{ // 56/9F
"You are in a corridor running north-south. To the south, the corridor ends in a wall with a door. If you wish to open the door, go to {106}. If you wish to go north, go to {29}."
},
{ // 57/9G
"Theseus leads you safely out of the Labyrinth. Along the way, he does all the killing and treasure-collecting, but of course, you may keep whatever you already have, and collect 100 ap for getting out of the Labyrinth alive."
},
{ // 58/10A
"He has a Monster Rating of 25. If you kill him, collect 25 gold pieces and leave the room. If you wish to leave by the east door, go to {37}. If you wish to leave by the south door, go to {47}."
},
{ // 59/10B
"You are in a corridor running east-west. To the east the corridor ends at a wall containing a door. If you wish to open the door, go to {34}. If you wish to go west, go to {49}."
},
{ // 60/10C
"Two of the hydra heads snake out together and nip you on your retreating behind, one on each cheek. Take 2 painful and embarrassing hits, and go to {162}."
},
{ // 61/10D
"Neither man nor youth offers resistance. You kill two innocents (keep track of how many innocent lives you take in the Labyrinth). The room's only treasure is the window - a source of sunshine and fresh sea breezes in the otherwise dank, dingy Labyrinth. You must now leave the room - go to {159}."
},
{ // 62/10E
"Afterwards, she gives you 100 gold pieces and offers to show you the way out of the Labyrinth any time you wish to leave. If you wish to leave now, go to {80}. If you don't want to leave yet, go to {22}."
},
{ // 63/10F
"You are in an obscure, dimly lit corridor somewhere in the Labyrinth. You are facing the Minotaur. (If you've already killed him, the joke is on the gods.) Follow the instructions for fighting the Minotaur in the Wanderers section. If you kill him, go to {28} and proceed as if you already met a Wandering Monster, which you did."
},
{ // 64/10G
"You are in a corridor running north-south. To the north the corridor ends in a wall with a door. If you wish to open the door, go to {71}. If you wish to go south, go to {93}."
},
{ // 65/11A
"Invoke Artemis with a saving roll. If you are successful, keep the leaves you have chosen. If you are unsuccessful, the dryad's laughter blows the leaves away. You must now leave this room. To exit by the south door, go to {138}. To leave by the west door, go to {59}."
},
{ // 66/11B
"You have entered the room of the cyclops, Polyphemus. (If you have been in this room before, the cyclops is gone. Roll to see if you meet a Wandering Monster or Deity.)\n" \
"  Polyphemus is a giant with one eye in the middle of his forehead, where two normal eyes should be. He stands by a tree which bears golden apples. He is watching some sheep graze.\n" \
"  If you try to steal the apples, go to {35}. If you wish to talk to him, go to {24}. If you wish to fight the cyclops, go to {115}. If you wish to leave by the east door, go to {79}."
},
{ // 67/11C
"You are in a corridor running north-south. To the north is a wall with a door. If you wish to go through the door, go to {165}. If you wish to go south, go to {14}."
},
{ // 68/11D
"She puts a curse on you for your unfriendliness. Your Luck is thereby reduced by 2 points. Go to {7}."
},
{ // 69/11E
"You may buy one of these two shields: the Invincible Achilles or the Labyrinth Special.\n" \
"  The Invincible Achilles is a great, huge shield, beautifully decorated with athletes contesting in foot races and wrestling matches, a peasant harvest scene, a royal wedding feast, the Caledonian boar hunt, the founding Thebes, the twelve labors of Herecles, and the entire Trojan war. This magnificent shield was commissioned for Athena Nike, but since her patron city is Athens, not Thebes, the Invincible Achilles is now on sale for the ridiculously low price of only 29 gp and 98 cp. If you wish to purchase the Invincible Achilles, go to {54}.\n" \
"  Or, there's the Labyrinth Special, a smaller and lighter shield quite suitable for mortals. It is decorated simply but nicely with the bull of Minos, and, for you, Hephaestus is willing to sell it for 15 gp even. If you wish to purchase the Labyrinth Special, go to {77}.\n" \
"  If you've decided not to buy a shield after all, you must leave this room. If you wish to leave by the east door, go to {104}. If you wish to leave by the north door, go to {125}."
},
{ // 70/12A
"You are in a the middle of a four-way intersection. If you wish to go north, go to {20}. If you wish to go south, go to {154}. If you wish to go west, go to {37}. If you wish to go east, go to {99}."
},
{ // 71/12B
"You see a group of drunken women engaged in a Dionysian Mystery Rite (for initiates only). If you wish to back out the way you came in without being noticed, you may do so in safety. If you wish to approach the women peacably, go to {44}. If you wish to fight the women, go to {150}. If you wish to invoke Dionysus at this point, go to {94}."
},
{ // 72/12C
"First, multiply your Strength by 100, divide by 2, and add 10 for each Dexterity and Strength point over 12. If this total is *less* than the total amount of weight you have decided to take with you, you are too heavy - you fall into the ocean. If you have a Shell-Sea Charm, go to {89}. Otherwise, both you and Icarus drown.\n" \
"  If you are not carrying too much weight, make your saving roll on IQ. If you fail, you fly too high with foolish Icarus, the sun melts the wax off your wings and you fall into the ocean. If you have a Shell-Sea Charm, go to {89}. Otherwise, both you and Icarus drown.\n" \
"  If you are neither too heavy nor too foolish, you fly safely to land and you are out of the Labyrinth with your loot, your life, and 100 extra adventure points."
},
{ // 73/12D
"This is a Wanderer room. Go to the Wanderer's section and roll to see which Wandering Monster or Deity you have met. After you are through with it, return here and leave the room by the west door - go to {50}."
},
{ // 74/12E
"You are in a corridor running east-west. To the west the corridor ends in a wall with a door. If you wish to open the door, go to {118}. If you wish to go east, go to {28}."
},
{ // 75/12F
"You are in a north-south corridor. If you wish to go north, go to {79}. If you wish to go south, go to {49}."
},
{ // 76/13A
"The food is vegetarian and the drink is water, but they are quite good. After dinner, your host offers to sell you up to 5 vials of the medicine which the centaurs make and use themselves. Each vial restores 1 Constitution point lost due to illness or injury. The vials cost 20 gold pieces each, and weigh 10 weight units apiece (it's pretty heavy medicine).\n" \
"  You may buy what you want, and then you must leave this room. To leave by the east door, go to {37}. To leave by the south door, go to {47}."
},
{ // 77/13B
"The Labyrinth Special weighs 50 and absorbs 2 hits per combat turn[, except when used in combat against the famous Minotaur. When used in fighting the Minotaur, this shield becomes a 1-die weapon itself, and absorbs 10 hits per combat turn].\n" \
"  [However, if you happen to have ever made love to Aphrodite (did you know she was married to Hephaestus?), the shield will crumble to dust the first time it is hit.\n" \
"  ]You must now exit from the room. To leave by the north door, go to {125}. To leave by the east door, go to {104}."
},
{ // 78/13C
"You kill them without encountering resistance. They were innocents, and you must keep track of how many innocents you kill. And, because you have just murdered Plato, Socrates, and Aristotle, your IQ is reduced to 3! And it won't return to normal when you leave the Labyrinth, either. Boy, are you dumb! The philosophers have no treasure that you would recognize.\n" \
"  You must now leave this room. To exit by the north door, go to {107}. To exit by the south door, go to {85}."
},
{ // 79/13D
"You are at a T-intersection. To the west is a wall with a door. If you wish to open the door, go to {66}. If you wish to go north, go to {102}. If you wish to go east, go to {19}. If you wish to go south, go to {75}."
},
{ // 80/13E
"Ariadne takes you through a secret passageway that leads safely out of the Labyrinth. Collect 100 ap for getting out - and congratulations!"
},
{ // 81/13F
"You are in an east-west corridor. If you wish to go east, go to {110}. If you wish to go west, go to {95}."
},
{ // 82/14A
"You are in a north-south corridor. To the south the corridor ends in a door. To open the door, go to {155}. To go north, go to {95}."
},
{ // 83/14B
"The hydra's vulnerable belly is now exposed and the beast can be killed. And since the hydra is still hung up on the wall, it only has an overall MR of 12 on the first combat turn, and on the second combat turn, 18 minus hits taken on the first turn. By the third combat turn, the hydra is free of the wall and has a MR of 35 minus hits taken on the first and second turn. If it kills you, you are dead. If you kill it, you may enter its room - go to {143}."
},
{ // 84/14C
"You see a beautiful young woman dressed in clothes that indicate she is a royal princess or a sacred priestess, or both. She is sitting on the small bed, and she looks silently at you as you enter.\n" \
"  If you wish to fight her, go to {152}. If you wish to speak to her, go to {12}. If you would rather leave without doing anything, go to {68}. If you have been in this room before and chose to fight on that occasion, you must now go to {23}."
},
{ // 85/14D
"You are in a north-south corridor. To the north, the corridor ends in a door. To open the door, go to {10}. To go south, go to {28}."
},
{ // 86/14E
"Fighting together, both will now fight to the death. They have a combined MR of 25, tired as they are - they are fighting for their lives. If you kill them, you find they carry 20 gp between them, and Theseus wears a necklace worth 5 gp. Don't take their weapons - if they were recognized, you would be chased, caught, and horribly killed by 3 or 4 armies. Go to {13}."
},
{ // 87/14F
"You are in a four-way intersection. Roll to see if you meet a Wanderer here, and return here afterwards. If you wish to go north, go to {154}. If you wish to go south, go to {31}. If you wish to go east, go to {128}. If you wish to go west, go to {139}."
},
{ // 88/14G
"You see a man and a youth standing before an open window. Through the window you can see sky above, ocean below, and land beyond. Both the man and the boy seem to have feathered arms, but no apparent weapons.\n" \
"  (If you have been here before, the man and youth are gone. Roll to see if a Wanderer appears.)\n" \
"  If you wish to fight, go to {61}. If you wish to talk to the man and youth, go to {151}. If you wish to leave without doing anything, go to {159}."
},
{ // 89/15A
"The Shell-Sea Charm prevents you from drowning and takes you safely to shore, but Father Poseidon takes to himself all of your weapons, armour, loot, clothes, magical devices, etc. You do, however, gain adventure points equal to the weight of what you lost to the sea, and 100 extra adventure points for getting out of the Labyrinth alive."
},
{ // 90/15B
"You are in a corridor running east-west. To your east, the corridor ends at a wall with a door in it. If you wish to open the door, go to {100}. If you wish to go west, go to {149}."
},
{ // 91/15C
"The music gets a bit louder and entrances you. You may not leave now, but you may invoke the gods to be kind.\n" \
"  If you are successful, a young man appears, seemingly from nowhere, and plays the lyre and sings for you. He is Orpheus, and his music teaches you things in the heart which you could never fully know with your head alone. Multiply your IQ by 10, and gain that many adventure points. You must leave this room now. To exit by the west door, go to {6}. To exit by the east door, go to {11}.\n" \
"  If your invocation/saving roll was unsuccessful, your scene and situation change, as if in a dream, until you find yourself sailing a ship past an island. The music of the Sirens singing on the island is drawing you to them. Make a saving roll based on your current Constitution. If it is successful, go to {111}. If it is unsuccessful, go to {9}."
},
{ // 92/15D
"You come upon a magnificent-looking creature with the body of a stallion and the upper torso and head of a man. If you wish to fight him, go to {58}. If you wish to talk to him, go to {41}. If you wish to tame and ride him, go to {117}.\n" \
"  Or, you can leave without doing anything. If you wish to leave by the east door, go to {37}. If you wish to leave by the south door, go to {47}."
},
{ // 93/16A
"You are at an L-shaped intersection. If you wish to go north, go to {64}. If you wish to go west, go to {26}."
},
{ // 94/16B
"If you are drunk, you are automatically protected and may proceed as if your invocation was successful. Otherwise, you have to make the invocation first. If you are unsuccessful, go to {44}. If you are successful, go to {124}."
},
{ // 95/16C
"You are at a four-way intersection. If you wish to go north, go to {3}. If you wish to go south, go to {82}. If you wish to go east, go to {81}. If you wish to go west, go to {19}."
},
{ // 96/16D
"Pan is a god, minor but still immortal. He has a Monster Rating of 20 and a gracious loser rating of 10. If you beat him, roll for treasure and then leave this room. If you wish to leave by the south door, go to {171}. If you wish to leave by the east door, go to {46}."
},
{ // 97/16E
"You are in an east-west corridor. If you wish to go west, go to {28}. If you wish to go east, go to {142}."
},
{ // 98/16F
"Alcibades was absolutely the most charismatic figure in all the Greek legend, history or mythology. The Joy-of-Death, weighing 150, is [therefore two things in one. First, it is ]a 3 dice plus 3 adds weapon.[ And second, it causes all your opponents to like you so much that they hate to fight you, thereby reducing their Monster Ratings by 5 points in Labyrinth (and by five points per level in all other dungeons).]\n" \
"  Just choosing this weapon makes Hephaestus like you so much that he compliments your taste and forgives you of anything you might have done, knowingly or unknowingly, to make him mad at you.\n" \
"  You must now leave this room. To exit the east door, go to {104}. To exit by the north door, go to {125}."
},
{ // 99/16G
"You are in an east-west corridor. If you wish to go east, go to {39}. If you wish to go west, go to {70}."
},
{ // 100/17A
"You see a man lying on his back on a large rock. He is chained down. Several huge predatory eagles are attacking him. Even as you watch, the eagles tear at his chest and stomach, and begin to eat his liver.\n" \
"  If you rush in and attack the man, go to {122}. If you rush in and attack the eagles, go to {119}. If you stand and watch in horrified fascination, go to {48}. If you ignore the man and the birds but search the room for something of value, go to {109}. If you wish to leave the room without doing anything, go to {17}."
},
{ // 101/17B
"Plato gives you an answer you cannot question. Add one point to your IQ and leave the room. To leave by the north door, go to {107}. To leave by the south door, go to {85}."
},
{ // 102/17C
"You are in a north-south corridor. If you wish to go north, go to {14}. If you wish to go south, go to {79}."
},
{ // 103/17D
"The gods do not hear you. Proceed at once to {7}."
},
{ // 104/17E
"You are in a corridor going north-south. To your west is a door. If you wish to open the door, go to {25}. If you wish to go north, go to {49}. If you wish to go south, go to {149}."
},
{ // 105/17F
"You are in a T-intersection. If you wish to go north, go to {153}. If you wish to go west, go to {121}. If you wish to go east, go to {129}."
},
{ // 106/18A
"This is a Wanderer room. Go to the back of this booklet and roll to see which Wandering Monster or Deity you have met. After you have done that, return here and leave the room. If you wish to exit by the north door, go to {56}. If you wish to leave by the east door, go to {32}."
},
{ // 107/18B
"You are in a right angle intersection. Both the south and east walls have doors in them. If you wish to open the east door, go to {18}. If you wish to open the south door, go to {10}. If you wish to go north, go to {114}. If you wish to go west, go to {128}."
},
{ // 108/18C
"You are in a north-south corridor. If you wish to go north, go to {26}. If you wish to go south, go to {123}."
},
{ // 109/18D
"You find nothing and the gods are displeased with your callous opportunism. Reduce your Strength by 5.\n" \
"  You must now leave the room. If you wish to leave by the north door, go to {145}. If you wish to leave by the west door, go to {90}."
},
{ // 110/18E
"You are at a T-intersection. If you wish to go south, go to {132}. If you wish to go north, go to {6}. If you wish to go west, go to {81}."
},
{ // 111/18F
"Again, as if in a dream, the scene shifts. You are fighting a beautiful woman with a Monster Rating of 10.\n" \
"  If you kill her, she rises still fighting as a fatherly man with a MR of 15.\n" \
"  If you kill him, he rises as a giant, still fighting, with a MR of 20.\n" \
"  If you kill him, he rises as a vicious she-wolf with a MR of 25.\n" \
"  If you kill her, she rises as a demon-child of indeterminant sex with a 30 MR.\n" \
"  If you kill the child, you have successfully, albeit symbolically resisted the siren song of death. The dream images fade away and you find you are in the empty, and now silent, room.\n" \
"  You must now leave this room. If you wish to exit by the west door, go to {6}. If you wish to exit by the east door, go to {11}."
},
{ // 112/19A
"You are in a corridor going east-west. To the west the corridor ends in a door. To open the door, go to {155}. To go east, go to {141}."
},
{ // 113/19B
"He advises you to seek Ariadne and honour the Mother. Go to {13}."
},
{ // 114/19C
"You are in a north-south corridor. If you wish to go north, go to {39}. If you wish to go south, go to {107}."
},
{ // 115/19D
"He has a Monster Rating of 35, but because of his incredibly poor depth perception he misses you entirely on his first combat turn and on every odd-numbered combat turn thereafter.\n" \
"  If you kill him, take a maximum of 35 golden apples. Each apple is worth 5 gold pieces and weighs accordingly.\n" \
"  You must now leave this room. If you wish to leave by the west door, go to {2}. If you wish to leave by the east door, go to {79}."
},
{ // 116/19E
"You are in a north-south corridor. If you wish to go north, go to {142}. If you wish to go south, go to {11}."
},
{ // 117/19F
"He fights to the death at this insult. Go to {58}."
},
{ // 118/19G
"This room contains the altar of the Earth Mother. All who enter her presence must be purified of the blood of any innocents they have killed. If you need to be purified, go to {42}. If you are presently clean of any innocent deaths, go to {7}."
},
{ // 119/19H
"Roll one die to see how many eagles you are fighting. Each eagle has a MR of 15. You may fight them one at a time, or all at once - however you wish. If you choose to fight them all at once, double your ap for the fight.\n" \
"  If you kill them all, the man tells you that he is the immortal Titan, Prometheus, chained here unjustly by Zeus. The chains are unbreakable and more eagles will come tomorrow, but Prometheus is grateful for your kindness of today.\n" \
"  Prometheus tells you how to make a poultice from a plant which grows from the blood of his torn body.[ When applied before combat, the poultice enables the wearer to absorb 25 hits each combat turn for the duration of the fight. One fight uses the poultice.]\n" \
"  You must now leave this room. If you wish to leave by the north door, go to {145}. If you wish to leave by the west door, go to {90}."
},
{ // 120/20A
"You have opened Pandora's Box. Roll 2 dice to see what emerges.\n" \
"  2 - A poisonous snake bites you, and you die.\n" \
"  3 - A non-fatal disease reduces your CON by half. You may recover at the rate of 1 Constitution point per turn.\n" \
"  4 - A lion leaps out and attacks you. It has a Monster Rating of 15.\n" \
"  5 - A dirty old man with bad breath and a MR of 10 leaps out and attacks you.\n" \
"  6 - A Wandering Monster or Deity appears. Follow instructions on Wanderers.\n" \
"  7 - A chimera leaps out. It does not attack you - but it boggles your mind with its utterly impossible and inharmonious biology. A boggled mind is reduced by one IQ point, permanently.\n" \
"  8 - Harpies fly out and spoil your provisions. If you go 10 consecutive turns without eating or drinking, lose 1 point from your CON. Lose 2 CON points for the next 10 turns, 3 for the next, and so on until you eat or drink or die. (CON lost due to hunger is restored when you eat.)\n" \
"  9 - A great feeling of hope comes over you, because your Luck has just increased by 10 points.\n" \
"  10 - A sphinx leaps out and tells you that the answer to all riddles is always the same answer. Make a saving roll to see if she landed on you when she leaped out. If your saving roll fails, roll 1 die to see how many hits you take being landed on.\n" \
"  11 - A sophist leaps out and teaches you false logic. You lose 3 points from your IQ, permanently.\n" \
"  12 - A Spartan warrior with a MR of 15 leaps out and attacks you.\n" \
"  Note: whatever happened, if you lived through it you get 30 additional adventure points. You may open this box as many times as you enter the room.\n" \
"  Now, however, you must leave Pandora's Box behind, and you must exit this room. If you wish to exit by the west door, go to {107}. If you wish to exit by the east door, go to {144}."
},
{ // 121/20B
"You are in an east-west corridor. If you wish to go east, go to {105}. If you wish to go west, go to {138}."
},
{ // 122/20C
"What a sick, perverted thing to do! The gods are outraged and release the man from his bondage in order to put you in his place. You are granted freedom from death but not from pain. Your only solace at this point is the promise that when the gods tire of punishing you, you will be allowed to die."
},
{ // 123/21A
"You are at a T-intersection. If you wish to go north, go to {108}. If you wish to go south, go to {136}. If you wish to go west, go to {168}."
},
{ // 124/21B
"If you wish to leave by the west door, go to {142}. If you wish to leave by the south door, go to {64}."
},
{ // 125/21C
"You are in a corridor running east-west. To the south is a door. If you wish to open the door, go to {25}. If you wish to go west, go to {32}. If you wish to go east, go to {49}."
},
{ // 126/21D
"She tells you that if you will offer her, in her capacity as priestess, a portion of your treasure for the goddess, she will show you the secret way out of the Labyrinth. If you accept her offer, go to {27}. If you don't wish to leave the Labyrinth yet, go to {22}."
},
{ // 127/21E
"All female characters not possessing Chastity Charms yield to a moment of impetuous passion and are seduced. You don't get pregnant or anything like that, but you do get 10 adventure points for the experience.\n" \
"  Both male and female characters will yield to the attractions of a few drinks, and get drunk. It's a pleasant, harmless high, but of course, when you leave this room, you will remain drunk (½ CON, ½ DEX, 1½ LK)[ for 4 regular turns or 2 combat turns].\n" \
"  When you are through playing around, collect 30 ap for learning to take time out from treasure hunting and monster fighting to relax and have a little fun. Go to {36}."
},
{ // 128/21F
"You are in an east-west corridor. If you wish to go east, go to {107}. If you wish to go west, go to {87}."
},
{ // 129/22A
"You are in a corridor going east-west. To the east, the corridor ends in a wall with a door. If you wish to open the door, go to {15}. If you wish to go west, go to {105}."
},
{ // 130/22B
"One of the hydra heads snakes out and nips you on your retreating behind. Take one embarrassing hit and go to {162}."
},
{ // 131/22C
"The room contains an underground river. If you drink from it, go to {55}. If you bathe in it, go to {158}. Or, you may leave without doing anything. To leave by the west door, go to {20}. To leave by the south door, go to {39}."
},
{ // 132/22D
"You are in a north-south corridor. If you wish to go north, go to {110}. If you wish to go south, go to {141}."
},
{ // 133/22E
"[If you were captured from behind by Hippolyta during your first go-round with Theseus, go directly to {13}. If you were captured from behind on any subsequent round, ]you are given food and drink which restore your Constitution by 1 point[, and you double your adventure points for the fight]. Go to {13}."
},
{ // 134/23A
"The Doric Silencer is as efficient as it is simple. It is a 3-die weapon which weighs 70. But, if you've ever made love to Hephaestus' wife, Aphrodite, you have purchased an exact replica of a Doric Silencer. Made of clay, it breaks uselessly the first time you bump it on anything.\n" \
"  You must now leave the room. To exit by the east door, go to {104}. To exit by the north door, go to {125}."
},
{ // 135/23B
"If your Charisma is 9 or less, go to {36}. If your Charisma is 10 or more, Pan plays an enticing melody on his pipes and you must go to {127}."
},
{ // 136/23C
"You are in a corridor running north-south. To the south, the corridor ends in a door. To open the door, go to {15}. To go north, go to {123}."
},
{ // 137/23D
"Roll one die.\n" \
"  1 or 2: Nothing happens. Go to {13}.\n" \
"  3 or 4: They laugh at you. Somehow, their laughter affects you profoundly, [temporarily ]reducing your Charisma by 5. [You will regain it at a rate of 1 point per turn. ]Go to {13}.\n" \
"  5 or 6: The man asks you where you are going in such a hurry that you haven't time to accept a bite to eat. If you say you are looking for treasure, go to {140}. If you say you are trying to get out of the Labyrinth, go to {113}. If you say you are just not hungry, go to {1}."
},
{ // 138/23E
"You are at an L-intersection. To the north is a door. If you wish to open the door, go to {34}. If you wish to go east, go to {121}. If you wish to go south, go to {145}."
},
{ // 139/23F
"You are in a corridor running east-west. To the west, the corridor ends in a door. To open the door, go to {165}. To go east, go to {87}."
},
{ // 140/24A
"The man laughs and wishes you luck, and now you must leave this room. If you wish to leave by the east door, go to {139}. If you wish to leave by the north door, go to {47}. If you wish to leave by the south door, go to {67}."
},
{ // 141/24B
"You are in a 4-way intersection. If you wish to go north, go to {132}. If you wish to go south, go to {153}. If you wish to go east, go to {168}. If you wish to go west, go to {112}."
},
{ // 142/24C
"You are at a T-intersection. To the east is a wall with a door in it. If you wish to open the door, go to {71}. If you wish to go north, go to {8}. If you wish to go south, go to {116}. If you wish to go west, go to {97}."
},
{ // 143/24D
"You find 250 gold pieces, and now you must exit. If you wish to leave by the north door, go to {136}. If you wish to leave by the east door, go to {129}."
},
{ // 144/24E
"You are in a corridor running north-south. To the west is a door. If you wish to open the door, go to {18}. If you wish to go north, go to {5}. If you wish to go south, go to {156}."
},
{ // 145/24F
"You are in a corridor running north-south. To the south the corridor ends in a wall with a door. If you wish to open the door, go to {100}. If you wish to go north, go to {138}."
},
{ // 146/24G
"Socrates asks you a question you cannot answer. Add 3 points to your IQ for thinking about it.\n" \
"  You must now leave this room. If you wish to exit by the north door, go to {107}. If you wish to leave by the south door, go to {85}."
},
{ // 147/24H
"This is a possible Wanderer room. Go to the Wanderers section and roll to see if you have met a Wandering Monster or Deity. After you finish there, return here and exit the room by the west door - go to {167}."
},
{ // 148/25A
"The immortal head, faced with the prospect of 24 supra-generated heads for company in the small room, is overcrowded and angry. It leads the entire hydra charging right through the wall at you. Make an invocation to keep from being crushed by the collapsing wall. If you are uncrushed, go to {43}."
},
{ // 149/25B
"You are in a T-intersection. If you wish to go west, go to {161}. If you wish to go east, go to {90}. If you wish to go north, go to {104}."
},
{ // 150/25C
"The women are menaeds and have a combined Monster Rating of 50. If you use missile weapons, you may hit them without being hit back. When the menaeds are reduced to Dionysus' gracious loser rating of 20, the surviving women will run away. Roll on the treasure table to see how much treasure they leave behind.\n" \
"  However, Dionysus is unhappy with you for interfering with his worship. Take 5 points off your LK[ until he gets over it (in 4 turns)]. Go to {124}."
},
{ // 151/25D
"The man introduces himself as Daedalus and the youth as his son, Icarus. He says that he is the original designer of the Labyrinth, but now he has been imprisoned in it.\n" \
"  Daedalus, however, has devised a way to escape with his son. They have attached feathers to their arms with melted wax and are going to fly out the window. They have extra feathers and wax, if you would like to go with them.\n" \
"  If you decide to stay in the Labyrinth, leave this room by going to {159}. If you make up your mind to fly out, first decide which of your possessions you want to take with you and add up their total weight. Then go to {72}."
},
{ // 152/25E
"You have killed Ariadne, royal princess of Crete and high priestess of Gaea. You find 1000 gp worth of treasure in her room. Since you have no choice but to exit through the altar room (because it's the only exit), and since Ariadne was an innocent and a priestess, you must make 5 successful invocations to the Mother as per instructions in {118}. Go on, go to {118}."
},
{ // 153/26A
"You are in a north-south corridor. If you wish to go north, go to {141}. If you wish to go south, go to {105}."
},
{ // 154/26B
"You are in a north-south corridor. If you wish to go north, go to {70}. If you wish to go south, go to {87}."
},
{ // 155/26C
"This is a possible Wanderer room. Go to the Wanderers section and roll to see if you have met a Wandering Monster or Deity. After you are through, return here and leave the room. If you wish to exit by the east door, go to {112}. If you wish to leave by the north door, go to {82}."
},
{ // 156/26D
"You are in a T-intersection. If you wish to go north, go to {144}. If you wish to go south, go to {8}. If you wish to go east, go to {167}."
},
{ // 157/26E
"Exit the room. If you wish to leave by the north door, go to {145}. If you wish to leave by the west door, go to {90}."
},
{ // 158/26F
"Invoke the gods. If you fail, the current sweeps you away and you drown. (Holders of Shell-Sea Charms are saved by Poseidon, but the result is *not* the same as making a successful invocation. Just return to {131} and exit the room.)\n" \
"  If the invocation was successful, roll one die. If you roll 1-5, the river is filled with safe, sweet water. Add 2 points to your Charisma for cleanliness, and return to {131} to exit the room.\n" \
"  If your die roll was a 6, you have bathed in the river Styx. Had you bathed in it deeper in the earth, it would have made you invulnerable (like Achilles, except for his heel). [At this level, your bath has given your naked body the protective qualities of a complete suit of ring mail. ]Any [additional ]baths in Styx will add nothing to your protection. You do get 2 Charisma points for this, and every subsequent bath in Styx. Return to {131} and leave the room."
},
{ // 159/27A
"You are in a corridor running north-south. To the north, the corridor ends in a wall with a door. If you wish to open the door, go to {88}. If you wish to go south, go to {20}."
},
{ // 160/27B
"You have fallen into a trap. To be more specific, you have fallen through a hole and into Hades. Don't panic. If Odysseus, Orpheus, Aneas, Psyche, Heracles, and Theseus could get in and out alive, surely a hero like yourself can do likewise. All you have to do is make 6 successful saving rolls, one on each of your basic attributes. Don't despair - you get 3 tries on each attribute.\n" \
"  Once you have succeeded on all six, return to {3}. If you fail on even one attribute, though, you are attacked by the three-headed dog Cerebus, the guardian of Hades. Cerebus kills you so you can stay in Hades, since you can't get out anyway."
},
{ // 161/27C
"You are in a corridor running east-west. To your west is the sealed entrance to the Labyrinth. If you wish to go east, go to {149}."
},
{ // 162/27D
"Return to the place you were at on the turn immediately before {15}. Proceed from there."
},
{ // 163/27E
"You may buy either the Doric Silencer or the Alcibades Joy-of-Death. The Silencer is a slim, grim weapon made with typical Spartan lack of elaboration. It costs 50 gp.\n" \
"  The Joy-of-Death is a bright, shining thing - a wonder to behold. The hilt and handle are decorated with bisexual erotica (which will *not* be illustrated, sorry) and the sheath is made of genuine griffinhide. It costs 75 gp.\n" \
"  If you wish to purchase the Doric Silencer, go to {134}. If you wish to purchase the Alcibades Joy-of-Death, go to {98}. If you've decided not to buy a sword after all, you must leave the room. If you wish to exit by the east door, go to {104}. If you wish to exit by the north door, go to {125}."
},
{ // 164/27F
"She leads you to a tree with golden leaves. Although it is pure gold leaf, each one is worth only 1 sp. Decide how many leaves you wish to take and go to {65}."
},
{ // 165/27G
"You see an attractive, happy young couple having a picnic. They see you and offer you food and drink. If you wish to fight, go to {21}. If you accept the invitation, go to {166}. If you wish to decline the invitation, go to {137}."
},
{ // 166/28A
"Roll one die.\n" \
"  1 or 2: You have just eaten highly addictive food. The picnickers are Lotus-eaters and now you are. Now, you are fated to remain on this pleasant picnic for the rest of your life.\n" \
"  3 or 4: The picnickers reveal that they are actually deities in human disguise, after you have partaken. You have just tasted ambrosia and nectar. The effect of this food on mortals is to restore weakened Constitutions to full power and to impart a [temporary ]Charisma glow of 5 points[ (which will fade at the rate of 1 point per turn)]. Say thank-you and go to {13}.\n" \
"  5 or 6: The food is quite safe but the strong wine makes you drunk. Your hosts find this amusing. Being drunk means your Dexterity and Constitution will be reduced by half and your Luck increased by 1½[ for 4 regular turns or 2 combat turns]. Stagger to {13}."
},
{ // 167/28B
"You are in a corridor running east-west. To the east the corridor ends at a wall with a door. If you wish to open the door, go to {147}. If you wish to go west, go to {156}."
},
{ // 168/28C
"You are in an east-west corridor. If you wish to go east, go to {123}. If you wish to go west, go to {141}."
},
{ // 169/28D
"Each of the seven heads pokes through and attacks you one at a time, with a Monster Rating of 10 each. The seventh head is immortal and won't die, but will withdraw when its MR is reduced to 1. If you defeat all 7 heads, go to {33}."
},
{ // 170/28E
"The three men greet you pleasantly and introduce themselves as Plato, Socrates, and Aristotle. You may choose one of them to learn something from. If you choose Plato, go to {101}. If you choose Socrates, go to {146}. If you choose Aristotle, go to {30}."
},
{ // 171/28F
"You are in a corridor running north-south. To the north, the corridor ends in a wall with a door. If you wish to open the door, go to {40}. If you wish to go south, go to {29}."
}
}, la_wandertext[12] = {
{ // 0
"2. Zeus (the far-seeing, the Father)\n" \
"  Special instructions for female characters: If your Charisma is higher than your Luck, make your invocation/saving roll. If successful, follow instructions for male characters making unsuccessful invocations. If unsuccessful, and you have no Chastity Charm, you have just been seduced. Roll 2 dice to see if you are pregnant. If you roll anything but a 2, you are not pregnant and Zeus is no longer interested in you. If you rolled a 2, congratulations!! Zeus whisks you out of the Labyrinth to safety, and gives you 1000 gp for you and the child. (Take 1000 ap for the extraordinary situation.) Roll up a new character, a male human warrior to represent your son. His personal attributes will be doubled due to his divine heritage, but he, himself, is mortal. There is a geas upon him to protect his mother at all times and to avenge her death if she is killed.\n" \
"  Male characters must invoke the god. If you are unsuccessful, he fails to notice you and nothing happens. If you are successful and your CHR is 9 or higher, he bestows you a gift of 1 point to the personal attribute of your choice. If your invocation was successful but your CHR is below 9, Zeus gives you a gold piece to go away."
},
{ // 1
"3. Artemis (virgin goddess of the hunt)\n" \
"  Invoke the goddess.\n" \
"  If you are a virgin character and your invocation was unsuccessful, nothing happens. If you are a virgin and made a successful invocation, both males and females may roll for treasure. Virgin females also receive a Chastity Charm which protects them from seduction as long as they keep it continuously in their possession.\n" \
"  If you aren't a virgin and your invocation was successful, nothing happens. If your invocation was unsuccessful, Artemis shoots you with an arrow, and departs. Roll one die to see how many hits you take."
},
{ // 2
"4. Apollo (god of truth and light)\n" \
"  Invoke the god.\n" \
"  If unsuccessful, you are cursed with lies (reduce your LK by half) for as long as you remain in the Labyrinth.\n" \
"  If your invocation was successful, roll 1 die. If you roll 1-5, you receive the gift of prophecy[ for any one turn (ie. you may peek once to see what the alternative results of any one decision may be)]. If you roll a 6, Apollo gives you a golden lyre (weighs 10).[ If both your DEX and CHR are above 15, you may play the lyre and use it as a Divine Charm to soothe all berserk beasts and beings.]"
},
{ // 3
"5. Ares (god of war)\n" \
"  If you have never been seduced by his mistress, Aphrodite, he has a MR of 50 and challenges you to a fight. He tells you straight out that if you refuse, he'll kill you. His gracious loser rating is only 30. (Unlike the Roman concept of Mars, the Greeks thought of their war god as a rather big mean bully. And like most bullies, he quickly loses the desire to fight any fight that he's losing.) If you do beat Ares, he will preserve his image by rewarding you for your valour in arms. [If you have taken any hits in this fight, ]he restores your CON[, and he also grants you 5 permanent combat adds].\n" \
"  If you are male and have been favoured by Aphrodite's favours, Ares is enraged with jealousy[ and fights according to berserker rules]. In this case, his genuine passion reduces his gracious loser rating to 20. If you beat him here, receive the same gift as above and, in addition, roll for treasure and trade dirty jokes."
},
{ // 4
"6. Athena (goddess of wisdom and sometimes war)\n" \
"  Invoke the goddess.\n" \
"  If you are successful, add 2 (permanent) points to your IQ. If the invocation was unsuccessful, you must fight her. She has a MR of 40 and a gracious loser rating of 15. If you win, double your ap for this encounter."
},
{ // 5
"7. Hermes (messenger, god of commerce and cunning)\n" \
"  Invoke the god.\n" \
"  If the invocation is unsuccessful, the handsome young god has picked your pocket. You lose 30 gold pieces and gain 30 ap.\n" \
"  If the invocation is successful, roll for treasure[ and split the take with Hermes]."
},
{ // 6
"8. Poseidon (god of the sea)\n" \
"  Invoke the god.\n" \
"  If the invocation is successful, Poseidon is pleased to see you. If your Charisma is under 12, he gives you a friendly wave (which doesn't drown you). If your Charisma is 12 or higher, he gives you a Shell-Sea Charm which protects you from drowning.\n" \
"  If the invocation was unsuccessful, Poseidon is displeased to see you and decides to fight you. He has a Monster Rating of 40, and a gracious loser rating of 10. If you defeat him, roll for treasure."
},
{ // 7
"9. Dionysus (god of the vine)\n" \
"  If you happen to be drunk when you encounter this god, be of good cheer - you are under his protection. Just roll for treasure and stagger right along.\n" \
"  If you are sober, invoke the god. If the invocation is successful, the god offers you a drink. Roll 1 die to see how many drinks you take. More than 3 drinks makes you drunk and you are under the god's protection and may roll for treasure. If the invocation was unsuccessful, you must fight Dionysus. He has a Monster Rating of 35 and a gracious loser rating of 20. When he gets to his gracious loser rating, he stops fighting and offers you a drink. Roll 1 die to see how many drinks you take. You are tired after combat, and more than 2 drinks makes you drunk, which puts you under the god's protection and lets you roll for treasure.\n" \
"  Everyone, drunk or sober, gets 25 ap for meeting the god. (Being drunk in the Labyrinth will always reduce your CON and DEX by half and raise your LK by 1½[ for a period of 4 regular turns or 2 combat turns].)"
},
{ // 8
"10. Hera (queen of heaven)\n" \
"  If you have ever been seduced by her husband, Zeus, she zaps you dead. (It doesn't matter that it wasn't your fault, dear. Being a god means you don't have to be unfair unless you feel like it.)\n" \
"  If you have not been seduced by Zeus, invoke the goddess. If you are successful, roll for treasure. If you invocation is unsuccessful, you are disdainfully ignored."
},
{ // 9
"11. Gaea (the earth mother)\n" \
"  If you are stained with the blood of any innocents killed in the Labyrinth, you are instantly whisked to 118. Otherwise, there is no need to invoke the goddess. All of Earth's children are loved and cared for by the Mother. Add 1 point to your permanent CON."
},
{ // 10
"12. Aphrodite (goddess of love)\n" \
"  Special instructions for male characters: Make an invocation/saving roll based on your Charisma, to see if Aphrodite seduces you. If you are unsuccessful, proceed to the instructions for female characters. (Your male character should not take this as an insult to his manhood, unless his IQ is 8 or less - in which case Aphrodite will reduce his Strength by 1 point and he may leave now.)\n" \
"  If your saving roll was successful, you enjoy the pleasures of the goddess. Now, make 2 separate saving rolls - one on your CON and one on your DEX - to see if you please Aphrodite. If both are successful, she is very pleased and adds 5 points to your Strength, and gives you a chance roll for treasure. If only 1 roll is successful, she is moderately pleased and you may roll for treasure. But if both rolls are unsuccessful, Aphrodite is sorry she messed with you. She tells Ares what you did, and you must now confront that god.\n" \
"  Female characters must invoke the goddess with a regular invocation/saving roll. If you are unsuccessful, the goddess is too busy to bother her pretty head about you, and nothing happens. If you are successful, add 1 point to your Strength as a gift of the goddess."
},
{ // 11
"THE MINOTAUR\n" \
"  You have met the famous Minotaur. He has a Monster Rating of 86 (the wine merchants won't serve him) and attacks immediately. Fortunately, you smelled him coming and are prepared for his attack.\n" \
"  If you kill the Minotaur, you need not roll for him again on this visit to the Labyrinth. After the Minotaur is dead, roll for treasure - and because he was such a famous monster, double the result of the treasure roll and gain 86 additional adventure points."
}
};

MODULE SWORD la_exits[LA_ROOMS][EXITS] =
{ { 149,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  66,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  { 160,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  66,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  16, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  38,  28, 110,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  {  84,  31,  74,  -1,  -1,  -1,  -1,  -1 }, //   7/1G
  { 156, 142,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/2A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2B
  { 107,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2C
  {  38, 116,  26,  -1,  -1,  -1,  -1,  -1 }, //  11/2D
  {  62, 126,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2E
  { 139,  47,  67,  -1,  -1,  -1,  -1,  -1 }, //  13/2F
  {  67, 102,  46,  -1,  -1,  -1,  -1,  -1 }, //  14/2G
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/3A
  {  53,   5,  50,  -1,  -1,  -1,  -1,  -1 }, //  16/3B
  { 157,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/3C
  { 120, 107, 144,  -1,  -1,  -1,  -1,  -1 }, //  18/3D
  {  95,  79,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/3E
  { 131, 159,  70,  -1,  -1,  -1,  -1,  -1 }, //  20/3F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/4A
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/4C
  {   4,  66,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/5A
  { 163,  69, 104, 125,  -1,  -1,  -1,  -1 }, //  25/5B
  {  93,  11, 108,  -1,  -1,  -1,  -1,  -1 }, //  26/5C
  {  80,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/5D
  {  85,   6,  97,  74,  -1,  -1,  -1,  -1 }, //  28/5E
  { 171,   2,  56,  -1,  -1,  -1,  -1,  -1 }, //  29/5F
  { 107,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/5G
  { 118,  87,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/5H
  { 106, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/6A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/6B
  {  51, 164, 138,  59,  -1,  -1,  -1,  -1 }, //  34/6C
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/6D
  { 171,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/6E
  {  92,  70,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/6F
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/6G
  { 131,  53,  99, 114,  -1,  -1,  -1,  -1 }, //  39/7A
  { 127,  96, 135,  -1,  -1,  -1,  -1,  -1 }, //  40/7B
  {  76,  37,  47,  -1,  -1,  -1,  -1,  -1 }, //  41/7C
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/7D
  { 162,  83,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/7E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/8A
  {  57,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/8B
  {  40,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/8C
  {  92, 165,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/8D
  { 157,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/8E
  {  75, 104, 125,  59,  -1,  -1,  -1,  -1 }, //  49/8F
  {  73,  16,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/8G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/9A
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/9B
  {  16,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/9C
  { 104, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/9D
  { 131,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/9E
  { 106,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/9F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/9G
  {  37,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/10A
  {  34,  49,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/10B
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/10C
  { 159,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/10D
  {  80,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/10E
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/10F
  {  71,  93,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/10G
  { 138,  59,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/11A
  {  35,  24, 115,  79,  -1,  -1,  -1,  -1 }, //  66/11B
  { 165,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/11C
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/11D
  { 104, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/11E
  {  20, 154,  37,  99,  -1,  -1,  -1,  -1 }, //  70/12A
  {  44, 150,  94,  -1,  -1,  -1,  -1,  -1 }, //  71/12B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/12C
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/12D
  { 118,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/12E
  {  79,  49,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/12F
  {  37,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/13A
  { 125, 104,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/13B
  { 107,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/13C
  {  66, 102,  19,  75,  -1,  -1,  -1,  -1 }, //  79/13D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/13E
  { 110,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/13F
  { 155,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/14A
  { 143,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/14B
  { 152,  12,  68,  -1,  -1,  -1,  -1,  -1 }, //  84/14C
  {  10,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/14D
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/14E
  { 154,  31, 128, 139,  -1,  -1,  -1,  -1 }, //  87/14F
  {  61, 151, 159,  -1,  -1,  -1,  -1,  -1 }, //  88/14G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/15A
  { 100, 149,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/15B
  {   6,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/15C
  {  58,  41, 117,  37,  47,  -1,  -1,  -1 }, //  92/15D
  {  64,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/16B
  {   3,  82,  81,  19,  -1,  -1,  -1,  -1 }, //  95/16C
  { 171,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/16D
  {  28, 142,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/16E
  { 104, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/16F
  {  39,  70,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/16G
  { 122, 119,  48, 109,  17,  -1,  -1,  -1 }, // 100/17A
  { 107,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/17B
  {  14,  79,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/17C
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/17D
  {  25,  49, 149,  -1,  -1,  -1,  -1,  -1 }, // 104/17E
  { 153, 121, 129,  -1,  -1,  -1,  -1,  -1 }, // 105/17F
  {  56,  32,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/18A
  {  18,  10, 114, 128,  -1,  -1,  -1,  -1 }, // 107/18B
  {  26, 123,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/18C
  { 145,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/18D
  { 132,   6,  81,  -1,  -1,  -1,  -1,  -1 }, // 110/18E
  {   6,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/18F
  { 155, 141,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/19A
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/19B
  {  39, 107,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/19C
  {   2,  79,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/19D
  { 142,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/19E
  {  58,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/19F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/19G
  { 145,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/19H
  { 107, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/20A
  { 105, 138,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/20B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/20C
  { 108, 136, 168,  -1,  -1,  -1,  -1,  -1 }, // 123/21A
  { 142,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/21B
  {  25,  32,  49,  -1,  -1,  -1,  -1,  -1 }, // 125/21C
  {  27,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/21D
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/21E
  { 107,  87,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/21F
  {  15, 105,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/22A
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/22B
  {  20,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/22C
  { 110, 141,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/22D
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/22E
  { 104, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/23A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/23B
  {  15, 123,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/23C
  { 140, 113,   1,  -1,  -1,  -1,  -1,  -1 }, // 137/23D
  {  34, 121, 145,  -1,  -1,  -1,  -1,  -1 }, // 138/23E
  { 165,  87,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/23F
  { 139,  47,  67,  -1,  -1,  -1,  -1,  -1 }, // 140/24A
  { 132, 153, 168, 112,  -1,  -1,  -1,  -1 }, // 141/24B
  {  71,   8, 116,  97,  -1,  -1,  -1,  -1 }, // 142/24C
  { 136, 129,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/24D
  {  18,   5, 156,  -1,  -1,  -1,  -1,  -1 }, // 144/24E
  { 100, 138,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/24F
  { 107,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/24G
  { 167,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/24H
  {  43,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/25A
  { 161,  90, 104,  -1,  -1,  -1,  -1,  -1 }, // 149/25B
  { 124,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/25C
  { 159,  72,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/25D
  { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/25E
  { 141, 105,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/26A
  {  70,  87,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/26B
  { 112,  82,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/26C
  { 144,   8, 167,  -1,  -1,  -1,  -1,  -1 }, // 156/26D
  { 145,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/26E
  { 131,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/26F
  {  88,  20,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/27A
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/27B
  { 149,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/27C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/27D
  { 104, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/27E
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/27F
  {  21, 166, 137,  -1,  -1,  -1,  -1,  -1 }, // 165/27G
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/28A
  { 147, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/28B
  { 123, 141,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/28C
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169/28D
  { 101, 146,  30,  -1,  -1,  -1,  -1,  -1 }, // 170/28E
  {  40,  29,  -1,  -1,  -1,  -1,  -1,  -1 }  // 171/28F
};

MODULE STRPTR la_pix[LA_ROOMS] =
{ "la-p0", //   0
  "",
  "",
  "",
  "",
  "", //   5
  "",
  "la-p19",
  "",
  "",
  "la-p17", //  10
  "",
  "",
  "",
  "",
  "", //  15
  "",
  "",
  "la-p3",
  "",
  "", //  20
  "",
  "",
  "",
  "",
  "la-p23", //  25
  "",
  "",
  "",
  "",
  "", //  30
  "",
  "",
  "",
  "la-p6",
  "", //  35
  "",
  "",
  "",
  "",
  "la-p7", //  40
  "",
  "la-p19",
  "",
  "",
  "la-p8", //  45
  "",
  "",
  "",
  "",
  "", //  50
  "la-p6",
  "",
  "",
  "",
  "", //  55
  "",
  "la-p8",
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
  "la-p17",
  "",
  "", //  80
  "",
  "",
  "",
  "",
  "", //  85
  "la-p8",
  "",
  "",
  "la-p15",
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
  "la-p17",
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
  "la-p19",
  "",
  "", // 115
  "",
  "",
  "la-p19",
  "",
  "la-p20", // 120
  "",
  "",
  "",
  "",
  "", // 125
  "",
  "",
  "la-p21",
  "",
  "", // 130
  "",
  "",
  "la-p22",
  "la-p23",
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
  "la-p17",
  "",
  "",
  "",
  "", // 150
  "la-p25",
  "la-p19",
  "",
  "",
  "", // 155
  "",
  "",
  "la-p15",
  "",
  "", // 160
  "",
  "",
  "la-p23",
  "",
  "", // 165
  "",
  "",
  "",
  "",
  "la-p17", // 170
  ""  // 171
};

MODULE FLAG                   forgot,
                              foughtminotaur,
                              fuckedaphrodite,
                              fuckedzeus;
MODULE int                    innocents;

IMPORT int                    been[MOST_ROOMS + 1],
                              evil_damagetaken,
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_damagetaken,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, prevroom, module,
                              round,
                              thethrow;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];

IMPORT void (* enterroom) (void);

MODULE void la_enterroom(void);
MODULE void la_wandering(FLAG mandatory);
MODULE void la_fight(int grace);

EXPORT void la_preinit(void)
{   descs[MODULE_LA]   = la_desc;
    wanders[MODULE_LA] = la_wandertext;
}

EXPORT void la_init(void)
{   int i;

    exits           = &la_exits[0][0];
    enterroom       = la_enterroom;
    for (i = 0; i < LA_ROOMS; i++)
    {   pix[i] = la_pix[i];
    }

    innocents            = 0;
    forgot               =
    foughtminotaur       =
    fuckedaphrodite      =
    fuckedzeus           = FALSE;
}

MODULE void la_enterroom(void)
{   TRANSIENT FLAG ok;
    TRANSIENT int  i,
                   result,
                   result2;
    PERSIST   int  rememberroom;

    switch (room)
    {
    case 1:
        give_gp(10);
    acase 4:
        give(189);
        // %%: it doesn't say whether we must check for a wanderer at LA66. We assume so.
    acase 7:
        gain_con(1);
    acase 9:
        die();
    acase 10:
        if (been[10])
        {   la_wandering(FALSE);
        } else
        {   if (getyn("Attack"))
            {   room = 78;
            } elif (getyn("Speak"))
            {   room = 170;
        }   }
    acase 15:
        rememberroom = prevroom;
        if (been[15])
        {   la_wandering(FALSE);
        } else
        {   if (getyn("Attack"))
            {   room = 169;
        }   }
    acase 17:
        lose_lk(1);
        award(10);
    acase 21:
        result = dice(1);
        if (result <= 2)
        {   innocents += 2;
            room = 13;
        } elif (result <= 4)
        {   if (saved(level, lk))
            {   if (saved(level, lk))
                {   room = 141;
                } else
                {   templose_con(1);
                    room = prevroom;
            }   }
            else
            {   if (saved(level, lk))
                {   templose_con(1);
                    room = prevroom;
                } else
                {   room = 63;
        }   }   }
        else
        {   create_monster(75);
            la_fight(9);
            if (room == 21)
            {   create_monster(338);
                la_fight(9);
                if (room == 21)
                {   create_monster(75);
                    npc[0].mr = 15 + 10;
                    recalc_ap(0);
                    la_fight(9);
                    if (room == 21)
                    {   create_monster(338);
                        npc[0].mr = 20 + 10;
                        recalc_ap(0);
                        la_fight(9);
                        if (room == 21)
                        {   if (getyn("Accept their surrender"))
                            {   room = 45;
                            } else
                            {   room = 86;
        }   }   }   }   }   }
    acase 22:
        give(562);
    acase 23:
        if (!foughtminotaur)
        {   create_monster(355);
            fight();
            rb_treasure(2);
            rb_treasure(2); // strictly speaking, we should just call rb_treasure() once and double its value
            award(86); // %%: probably we should give an extra 10 points because of the raised MR?
            foughtminotaur = TRUE;
        }
        savedrooms(level, lk, 52, 103);
 /* acase 24:
        // %%: it doesn't say whether we must check for a wanderer at LA66. We assume so.
 */ acase 27:
        if (dice(1) == 1 && money >= 1000)
        {   pay_gp(10);
        } else
        {   pay_cp_only(cp / 10);
            pay_sp_only(sp / 10);
            pay_gp_only(gp / 10);
            // %%: pay a tenth of "all the treasure you have": does this include eg. jewels, etc.?
        }
    acase 28:
        if (prevroom != 63)
        {   la_wandering(FALSE);
        }
    acase 30:
        gain_dex(10);
    acase 33:
        if (getyn("Fight (otherwise leave)"))
        {   for (i = 1; i <= 6; i++)
            {   create_monsters(357, 2);
                fight();
            }
            room = 148;
        } else
        {   room = 60;
        }
    acase 38:
        if (getyn("Leave (otherwise stay)"))
        {   room = prevroom;
        }
    acase 40:
        if (been[40])
        {   la_wandering(FALSE);
            room = 36;
        }
    acase 42:
        if (innocents)
        {   for (i = 1; i <= innocents; i++)
            {   ok = FALSE;
                do
                {   if (saved(level, lk))
                    {   ok = TRUE;
                    } else
                    {   templose_con(1);
                        templose_st(1);
                }   }
                while (!ok);
            }
            innocents = 0;
        }
    acase 44:
        die();
    acase 45:
        give_gp(500);
        innocents = 0;
    acase 48:
        award(50);
    acase 51:
        die();
    acase 52:
        if (getyn("Commit suicide"))
        {   die();
        }
    acase 54:
        give(563);
    acase 55:
        if (saved(level, lk))
        {   award(level * thethrow);
        } elif (saved(level, lk))
        {   gain_flag_ability(91);
        } else
        {   award(-xp);
            level = 1;
            forgot = TRUE;
        }
    acase 57:
        victory(100);
    acase 58:
        create_monster(339);
        fight();
        give_gp(25);
    acase 60:
        templose_con(2); // %%: does armour help?
    acase 61:
        innocents += 2;
    acase 62:
        lose_flag_ability(88);
        give_gp(100);
    acase 63:
        create_monster(355);
        fight();
        rb_treasure(2);
        rb_treasure(2); // strictly speaking, we should just call rb_treasure() once and double its value
        // %%: we presumably get his treasure and the doubled ap, it doesn't explicitly say
        award(86); // %%: probably we should give an extra 10 points because of the raised MR?
        foughtminotaur = TRUE;
        // %%: "joke is on the gods": what does this mean?
    acase 65:
        if (!saved(level, lk))
        {   dropitems(569, items[569].owned);
        }
    acase 66:
        if (been[66])
        {   la_wandering(FALSE);
            room = 79; // %%: are the trees gone too? We assume so.
        }
    acase 68:
        lose_lk(2);
    acase 69:
        if (money >= 2998 && getyn("Buy Invincible Achilles shield"))
        {   pay_cp(2998);
            room = 54;
        } elif (maybespend(15, "Buy Labyrinth Special shield"))
        {   room = 77;
        }
    acase 71:
        if (getyn("Back out"))
        {   room = prevroom;
        }
    acase 72:
        result = st * 50;
        if (dex > 12)
        {   result += (dex - 12) * 10;
        }
        if (st > 12)
        {   result += (st  - 12) * 10;
        }
        result2 = gp + sp + cp;
        for (i = 0; i < ITEMS; i++)
        {   result2 += items[i].weight * items[i].owned;
        }
        if (result < result2 || !saved(level, iq))
        {   if (items[572].owned)
            {   room = 89;
            } else
            {   die();
        }   }
        else
        {   victory(100);
        }
    acase 73:
        la_wandering(TRUE);
    acase 76:
        result2 = money / 2000;
        if (result2 > 5)
        {   result2 = 5;
        }
        result = getnumber("Buy how many vials of medicine", 0, result2);
        pay_gp(result * 20);
        give_multi(564, result);
    acase 77:
        give(565);
    acase 78:
        innocents += 3;
        change_iq(3);
    acase 80:
        victory(100);
    acase 83:
        create_monster(358);
        oneround();
        if (countfoes())
        {   result = evil_damagetaken;
            npc[0].mr = 18 + 10 - result;
            recalc_ap(0); // %%: how many ap should they get?
            oneround();
            if (countfoes())
            {   result += evil_damagetaken;
                npc[0].mr = 35 + 10 - result;
                recalc_ap(0); // %%: how many ap should they get?
                fight();
        }   }
    acase 84:
        if (been[152])
        {   room = 23;
        }
    acase 86:
        // perhaps we should do this pair as a single monster?
        create_monster(75);
        npc[0].mr = 12 + 5; // %%: or perhaps +10?
        recalc_ap(0);
        create_monster(329);
        npc[1].mr = 13 + 5; // %%: or perhaps +10?
        recalc_ap(1);
        fight();
        give_gp(20);
        give(573);
    acase 87:
        la_wandering(FALSE);
    acase 88:
        if (been[88])
        {   la_wandering(FALSE);
            room = 159;
        }
    acase 89:
        result = gp + sp + cp;
        for (i = 0; i < ITEMS; i++)
        {   result += items[i].weight * items[i].owned;
        }
        drop_all();
        victory(result + 100);
    acase 91:
        if (saved(level, lk))
        {   change_iq(iq * 10);
            award(10);
        } else
        {   savedrooms(level, con, 111, 9);
        }
    acase 94:
        if (ability[91].known || saved(level, lk))
        {   room = 124;
        } else
        {   room = 44;
        }
    acase 96:
        create_monster(340);
        la_fight(10);
        rb_treasure(2);
    acase 98:
        give(566);
        fuckedaphrodite = FALSE;
    acase 101:
        gain_iq(1);
    acase 106:
        la_wandering(TRUE);
    acase 109:
        permlose_st(5); // %%: is this permanent or temporary?
    acase 111:
        create_monster(341);
        fight();
        create_monster(342);
        fight();
        create_monster(343);
        fight();
        create_monster(344);
        fight();
        create_monster(345);
        fight();
    acase 115:
        create_monster(346);
        do
        {   good_freeattack();
            oneround();
        } while (countfoes());
        give_multi(189, getnumber("Take how many golden apples", 0, 35));
    acase 118:
        if (innocents)
        {   room = 42;
        } else
        {   room = 7;
        }
    acase 119:
        result = dice(1);
        if (getyn("Fight all at once (otherwise one at a time)"))
        {   create_monsters(347, result);
            fight();
            award((15 + 10) * 2 * result);
        } else
        {   for (i = 1; i <= result; i++)
            {   create_monster(347);
                fight();
                award((15 + 10) * result);
        }   }
        give(567);
    acase 120:
        result = dice(2);
        switch (result)
        {
        case 2:
            if (!immune_poison())
            {   die();
            }
        acase 3:
            templose_con(con / 2);
        acase 4:
            create_monster(348);
            fight();
        acase 5:
            create_monster(349);
            fight();
        acase 6:
            la_wandering(TRUE);
        acase 7:
            lose_iq(1);
        acase 8:
            dropitems(PRO, items[PRO].owned);
        acase 9:
            gain_lk(10);
        acase 10:
            if (!saved(level, lk))
            {   good_takehits(dice(1), TRUE); // %%: does armour help?
            }
        acase 11:
            lose_iq(3);
        acase 12:
            create_monster(350);
            fight();
        }
        award(30);
    acase 122:
        die();
    acase 127:
        if (sex == FEMALE && !items[570].owned)
        {   lose_flag_ability(88);
            award(10);
        }
        gain_flag_ability(91);
        award(30);
    acase 130:
        good_takehits(1, TRUE); // %%: does armour help?
    acase 131:
        if ((prevroom != 55 || forgot) && prevroom != 158)
        {   forgot = FALSE;
            if (getyn("Drink"))
            {   room = 55;
            } elif (getyn("Bathe"))
            {   room = 158;
        }   }
    acase 133:
        heal_con(1);
    acase 134:
        give(fuckedaphrodite ? 834 : 568);
    acase 135:
        if (chr <= 9)
        {   room = 36;
        } else
        {   room = 127;
        }
    acase 137:
        result = dice(1);
        if (result <= 2)
        {   room = 13;
        } elif (result <= 4)
        {   lose_chr(5);
            room = 13;
        }
    acase 143:
        give_gp(250);
    acase 146:
        gain_iq(3);
    acase 147:
        la_wandering(FALSE);
    acase 148:
        if (!saved(level, lk))
        {   die();
        }
    acase 150:
        create_monster(356);
        while (countfoes() && npc[0].mr > 20 && shooting())
        {   if (shot(RANGE_NEAR, SIZE_LARGE, FALSE)) // %%: it doesn't say the range. We assume near range.
            {   evil_takemissilehits(0);
        }   }
        if (countfoes())
        {   if (npc[0].mr > 20)
            {   la_fight(20);
            } else
            {   kill_npcs();
        }   }
        rb_treasure(2);
        owe_lk(5);
    acase 152:
        give_gp(1000); // %%: is it given in coins, or should there be an item for "1000 gp worth of treasure"?
        innocents += 5; // %%: does this replace the existing number of innocents, or is it added to it?
    acase 155:
        la_wandering(FALSE);
    acase 158:
        if (saved(level, lk))
        {   if (dice(1) == 5)
            {   gain_flag_ability(90);
            }
            gain_chr(2);
        } else
        {   if (!items[572].owned)
            {   die();
        }   }
    acase 160:
        if
        (   (!saved(level, st)  && !saved(level, st)  && !saved(level, st))
         || (!saved(level, iq)  && !saved(level, iq)  && !saved(level, iq))
         || (!saved(level, lk)  && !saved(level, lk)  && !saved(level, lk))
         || (!saved(level, con) && !saved(level, con) && !saved(level, con))
         || (!saved(level, dex) && !saved(level, dex) && !saved(level, dex))
         || (!saved(level, chr) && !saved(level, chr) && !saved(level, chr))
        )
        {   die();
        }
    acase 162:
        room = rememberroom;
    acase 163:
        if (maybespend(50, "Buy Doric Silencer sword"))
        {   room = 134;
        } elif (maybespend(75, "Buy Joy-of-Death sword"))
        {   room = 98;
        }
    acase 164:
        give_multi(569, getnumber("Take how many golden leaves", 0, 9999));
    acase 166:
        result = dice(1);
        if (result <= 2)
        {   die();
        } elif (result <= 4)
        {   healall_con();
            gain_chr(5);
        } else
        {   gain_flag_ability(91);
        }
    acase 169:
        for (i = 1; i <= 6; i++)
        {   create_monster(357);
            fight();
        }
        create_monster(357);
        la_fight(1);
}   }

MODULE void la_wandering(FLAG mandatory)
{   int result,
        whichmonster;

aprintf(
"WANDERERING MONSTERS/DEITIES\n" \
"  The Labyrinth contains only one wandering monster: the famous Minotaur. The rest of the Wanderers in the Labyrinth are some equally famous Greek gods and goddesses, referred to as Wandering Deities.\n" \
"  If you have met a Wanderer or if you have been told to roll to see if you have, roll 2 dice to see if you have run into the Minotaur. You have met him if you rolled a 2. Go to the paragraph below labelled \"The Minotaur\".\n" \
"  If the Minotaur does not appear, those of you who have a definite Wanderer will encounter a Wandering Deity. Those of you who don't know yet, roll one die. If it comes up 1 or 6, you have a Wandering Deity to contend with. If you roll 2 through 5, you meet no one this time.\n" \
"  To determine which Wandering Deity you have met, roll 2 dice and refer to the Wandering Deity list. The total of your dice roll is the number of your deity.\n"
    );

    if (dice(2) == 2)
    {   whichmonster = 11; // minotaur
    } else
    {   if (!mandatory)
        {   result = dice(1);
            if (result >= 2 && result <= 5)
            {   return;
        }   }
        whichmonster = dice(2) - 2; // 0..10
    }

    aprintf("%s\n", la_wandertext[whichmonster]);

    switch (whichmonster)
    {
    case 2 - 2:
        if (sex == FEMALE && chr > lk)
        {   if (!saved(level, lk) && !items[570].owned)
            {   fuckedzeus = TRUE;
                lose_flag_ability(88);
                if (dice(2) == 2)
                {   give_gp(1000);
                    victory(1000);
        }   }   }
        else
        {   if (saved(level, lk))
            {   if (chr >= 9)
                {   result = getnumber("1) Strength\n2) Intelligence\n3) Luck\n4) Constitution\n5) Dexterity\n6) Charisma\n7) Speed\nRaise which attribute", 1, 7);
                    switch (result)
                    {
                    case 1:  gain_st(1);
                    acase 2: gain_iq(1);
                    acase 3: gain_lk(1);
                    acase 4: gain_con(1);
                    acase 5: gain_dex(1);
                    acase 6: gain_chr(1);
                    acase 7: gain_spd(1);
                }   }
                else
                {   give_gp(1);
        }   }   }
    acase 3 - 2:
        if (saved(level, lk))
        {   if (ability[88].known)
            {   rb_treasure(2);
                if (sex == FEMALE)
                {   give(570);
        }   }   }
        else
        {   if (!ability[88].known)
            {   good_takehits(dice(1), TRUE);
        }   }
    acase 4 - 2:
        if (saved(level, lk))
        {   if (dice(1) <= 5)
            {   gain_flag_ability(89);
            } else
            {   give(571);
        }   }
        else
        {   owe_lk(lk / 2);
        }
    acase 5 - 2:
        if (fuckedaphrodite)
        {   create_monster(351);
            la_fight(20);
            healall_con(); // %%: does he heal all CON, or just the damage that was sustained in this fight?
            rb_treasure(2);
        } else
        {   create_monster(351);
            la_fight(30);
            healall_con(); // %%: does he heal all CON, or just the damage that was sustained in this fight?
        }
    acase 6 - 2:
        if (saved(level, lk))
        {   gain_iq(2);
        } else
        {   create_monster(352);
            la_fight(15);
            // %%: double ap "for this encounter": does that mean the saving throw too, or just the combat?
            // We assume it is just for the combat.
            award(40 + 10);
        }
    acase 7 - 2:
        if (saved(level, lk))
        {   rb_treasure(2);
        } else
        {   pay_gp(30);
            award(30);
        }
    acase 8 - 2:
        if (saved(level, lk))
        {   if (chr >= 12)
            {   give(572);
        }   }
        else
        {   create_monster(353);
            la_fight(10);
            rb_treasure(2);
        }
    acase 9 - 2:
        if (ability[91].known)
        {   rb_treasure(2);
        } else
        {   if (saved(level, lk))
            {   if (dice(1) > 3)
                {   gain_flag_ability(91);
                    rb_treasure(2);
            }   }
            else
            {   create_monster(354);
                la_fight(20);
                if (dice(1) > 2)
                {   gain_flag_ability(91);
                    rb_treasure(2);
        }   }   }
        award(25);
    acase 10 - 2:
        if (fuckedzeus)
        {   die();
        } elif (saved(level, lk))
        {   rb_treasure(2);
        }
    acase 11 - 2:
        if (innocents)
        {   room = 118;
        } else
        {   gain_con(1);
        }
    acase 12 - 2:
        if (sex == MALE)
        {   if (saved(level, chr))
            {   fuckedaphrodite = TRUE;
                lose_flag_ability(88);
                if (saved(level, con))
                {   if (saved(level, dex))
                    {   gain_st(5);
                    }
                    rb_treasure(2);
                } else
                {   if (saved(level, dex))
                    {   rb_treasure(2);
                    } else
                    {   create_monster(351);
                        la_fight(20);
                        healall_con(); // %%: does he heal all CON, or just the damage that was sustained in this fight?
                        rb_treasure(2);
            }   }   }
            elif (iq <= 8)
            {   permlose_st(1); // %%: is this temporary or permanent?
            } elif (saved(level, lk))
            {   gain_st(1);
        }   }
        else
        {   if (saved(level, lk))
            {   gain_st(1);
        }   }
    acase 11:
        if (!foughtminotaur)
        {   create_monster(355);
            fight();
            rb_treasure(2);
            rb_treasure(2); // strictly speaking, we should just call rb_treasure() once and double its value
            award(86); // %%: probably we should give an extra 10 points because of the raised MR?
            foughtminotaur = TRUE;
}   }   }

MODULE void la_fight(int grace)
{   grace += 10;

    do
    {   oneround();
        if (room == 21 && con <= 5) // %%: it's possible to die, which might not be what was intended...?
        {   dispose_npcs();
            room = 133;
            return;
    }   }
    while (npc[0].mr > grace);

    kill_npcs();
}
