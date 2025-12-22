#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Ambiguities/contradictions (%%):
FB version of DE says only 1st-5th level magic is permitted (Corgi version omits this).
"ST:63...LK:15...DEX:28 [ie. 70 personal adds]...It gets 8 dice in combat and 67 adds." - DE21.
"...a large emerald..." - DE37. But "...roll for its value..." - DE32.
"Reduce CON by half and IQ by 3 because of oxygen starvation to the brain." - DE191. Is this temporary or permanent?
"Haksum gets 6 dice for his 2 weapons, and 15 adds." - DE20. But "He is armed with a broadsword in high right hand; instead of a left hand, he has a double-bladed war axe (6 dice plus 3)." - DE29.
"Monster Rating of 47 each" - DE23. But "...each bear has a Monster Rating of 94." - DE81.
*/

MODULE const STRPTR de_desc[DE_ROOMS] = {
{ // 0
"INTRODUCTION\n" \
"  Umslopagaas of the Shiny Teeth is your host in the Deathtrap Equalizer and it is he who gives out the Frog Rings for those who want to make quick in-and-out excursions, as well as the Lion Ring for anyone who dares try the Trip of the Lion. There are some rules that you, as players, must conform to in order for this game to work. First of all, all the regular rules of Tunnels & Trolls apply in the situations inside. Second, a delver must go alone. Sorry, no groups. Thirdly, you will have to use your imagination and sometimes do the dice-rolling for the monsters as well as for your own character. Some monsters use the Monster Rating system developed in T&T, and some fight as individual characters. Saving rolls are made on a variety of attributes, but the minimum saving roll will always be 5, just as it is in a regular T&T game. Now let's pick up on what Umslop (as his friends call him) is saying...\n" \
"  \"...Most of you will be taking the Frog Trip; that is, you get into one situation, solve it and come back out where I can award experience points, patch up minor wounds, and whatnot. Those who think they are heroes will use the Lion Ring, and will go in sequence through all 16 of the Equalizer situations. I wouldn't try it myself, but the rewards are tremendous if you make it. Each time your ring lights up, you go on to the next adventure. (Instead of going to {3}, you go to the next situation right through to {88}, which is the last situation.) Okay, step right up and take a ring.\"\n" \
"  Umslopagaas continues his pitch. \"Now, as you all know, this is an equal-opportunity dungeon, licensed by the chamber of commerce of downtown Khosht, and in reality it is more of a pocket universe in a close time loop than a conventional complex of tunnels and chambers. Everyone has the same basic chance of getting rich or getting dead. It depends on you. We will allow you to take any magical weapons, protective charms, armour, etc. that you might already own. There is only one catch. In situations where there is a conflict of interests or instructions, the Equalizer instructions take precedence. (If you have a magic weapon that is supposed to be unbreakable, and we say it breaks, then we broke your magic weapon.) Also, those of you who are shape shifters will find you are limited to human form while inside, and no one can be more than 7' tall.\n" \
"  \"Some words of caution. The Equalizer was designed to kill fools. Be wary of making choices, but be not afraid when you must. You would be wise to take some means of making a light, and some money in case you might want to buy anything within. Remember that courtesy may be as important as weapons skill. Now goodbye and good luck. I'll be watching, but you're on your own.\"\n" \
"  Any character going in on a Frog Trip now rolls 3 dice. If you score 3, turn to paragraph {5}; 4, turn to {11}; 5, turn to {18}; 6, turn to {23}; 7, turn to {29}; 8, turn to {34}; 9, turn to {40}; 10, turn to {46}; 11, turn to {51}; 12, turn to {57}; 13, turn to {62}; 14, turn to {67}; 15, turn to {72}; 16, turn to {78}; 17, turn to {83}; 18, turn to {88}. Read each paragraph of information carefully, following instructions as soon as you receive them. You may read a whole paragraph before going to another page unless specifically instructed not to. You may never exercise more than 1 option at a time, nor go back and change your mind after reading the consequences.\n" \
"  If you are taking the Trip of the Lion, begin with {5} and continue through to {88} in the order listed above.[ The time spent in each situation is considered 1 game turn as far as recovering strength goes. Constitution or other depleted attributes may not be recovered until you leave the Equalizer.]"
},
{ // 1/2A
"\"Welcome back!\" cries Umslopagaas. \"I've been watching you in this magic mirror.\" If you've completed the Trip of the Lion, you are awarded a bonus of 10,000 ap, plus whatever experience you gained during your adventures.[ If you brought back any treasure, it is customary to tip your host about 10%.]\n" \
"  If you have completed a Frog Trip, you are awarded a bonus of 100 ap, plus whatever experience you have gained during your adventures.\n" \
"  If you enjoyed this adventure, and would like to re-enter the Equalizer, throw 3 dice. If it is the same as the one you just came back from, add 1 to the number and go to the next situation.[\n" \
"  If you have completed 4 or more adventures in the Equalizer with this character, perhaps it is time you tried another dungeon, or dare to venture the Trip of the Lion. Thank you for playing, and tell your friends.]"
},
{ // 2/2B
"You are dead. Do not use this character ever again. You have been fiendishly bested by Ken St. Andre who is laughing at you. But, don't be discouraged. You can always create a new character and try again. The End."
},
{ // 3/2C
"Bravo, you have resolved the situation and beaten the traps. You get the right to feel proud. No doubt your character will go onto great things if he/she can only avoid a premature demise. Go to {1}."
},
{ // 4/2D
#ifdef CORGI
"Ursla has taken a twisted revenge and sent you into another adventure. Roll a die to see where you find yourself.\n" \
"  1. You are standing on the sands of the Arena of Khazan (AK), facing Ursla's sister sorceress. Go to {32} in that solitaire and fight as best you can. If you survive, you can leave the Arena after only one fight.\n" \
"  2. You are suddenly transported to {44} in Naked Doom (ND). Survive that if you can, taking whatever rewards are offered in that dungeon.\n" \
"  3. You find yourself underground in the dungeons beneath the city of Freegore where the fabled Amulet of the Salkti is said to be hidden. Go to {122} in The Amulet of the Salkti (AS).\n" \
"  4. When your vision clears you are at {88} of Deathtrap Equalizer (DE).\n" \
"  5. Your eyes are open but you are in darkness. Go to paragraph {33} in the solitaire Beyond the Silvered Pane (BS). Get out however you can.\n" \
"  6. You hear the roar of a crowd in the stands. Go to paragraph {46} in the solitaire City of Terrors (CT) and fight. If you survive, you can further explore or leave the city afterwards.\n" \
"  If you don't have the solitaire you are sent to, Ursla takes a more personal revenge. She grins ferociously and casts a spell which cuts all your attributes in half (except your CHR, which drops to 1). She has ensured that you will no longer be attractive to anyone. Go shamefaced to {3}, because your ring is glowing."
#else
"Ursla has taken a twisted revenge and sent you into another universe. Roll a die to see where you find yourself.\n" \
"  1. You are standing on the sands of the Arena of Khazan (AK), facing Ursla's sister sorceress. Go to {32} in that solitaire and fight as best you can. If you survive, you can leave the Arena after only one fight.\n" \
"  2. You are suddenly transported to {44} in Naked Doom (ND). Survive that if you can, taking whatever rewards are offered in that dungeon.\n" \
"  3. You find yourself underground in the sewers of Sewers of Oblivion (SO). Ignxx the demon is standing beside you; you are in a small red boat. Start there at {74}.\n" \
"  4. When your vision clears you are at {88} of Deathtrap Equalizer (DE).\n" \
"  5. Your eyes are open but you are in darkness. Go to paragraph {33} in the solitaire Beyond the Silvered Pane (BS). Get out however you can.\n" \
"  6. You hear the roar of a crowd in the stands. Go to paragraph {46} in the solitaire City of Terrors (CT) and fight. If you survive, you can further explore or leave the city afterwards.\n" \
"  If you don't have the solitaire you are sent to, Ursla takes a more personal revenge. She grins ferociously and casts a spell which cuts all your attributes in half (except your CHR, which drops to 1). She has ensured that you will no longer be attractive to anyone. Go shamefaced to {3}, because your ring is glowing."
#endif
},
{ // 5/3A (Situation 1 of 16)
"You are in a large dark room. High overhead the wind whistles softly and eerily. Do you wish to make a light? If so, go to {47}; if not, go to {73}.\n" \
"  Or, providing you have such magical powers, you may put a Cateyes spell upon yourself, which allows you to see in the dark. The room remains dark, but you can see perfectly well. Go to {47}."
},
{ // 6/3B
"Only a Protective Pentagram could save you in this situation. If you wrote anything else, go first to {30} and from there go directly to {106}. If you called up a Pentagram, go back to {18} and choose another option."
},
{ // 7/3C
"You hit it. Compute the number of hits and compare to its Monster Rating. If you killed it, go to {3}. If not, make a second level saving roll (25 - Luck). If you made it, you nimbly dodged the monster and may continue to fight. Return to {36}. If you missed your saving roll, you were not quick enough, and the thing bit you. Go to {2}."
},
{ // 8/3D
"If you attack with magic, go first to {30} and then directly to {54}. If you use weapons, go to {49}."
},
{ // 9/3E
"You get 300 experience points just for meeting the Tin Trader. Your ring is glowing. Go to {3}."
},
{ // 10/3F
"If you wrote Take That You Fiend, go to {111}. If you wrote Blasting Power or Icefall, go to {113}. If you wrote Protective Pentagram, go to {114}. If you tried anything else, if failed and the bat got 80 hits on you. If you are dead, go to {2}. Should you still live, go to {155}."
},
{ // 11/4A (Situation 2 of 16)
"You are in a large, square, dimly-lit room. The floor is strewn with human bones. If, on general principles, you wish to cast a Concealing Cloak spell on yourself, go to {58}. If you choose to do nothing but wait, you will spend several minutes standing there. Go then to {128}. If you want to explore the room and examine the floor, then go to {68}."
},
{ // 12/4B
"He tells you his name is Vokal the Necromancer, and that he is weary of living, but that his gods will not allow him to die without a fight. He politely requests that you attack him. You don't have to. If you don't want to fight this magical fellow, go to {154}. Or, if you attack him with the scimitar he gave you, go to {77}. Should you prefer to use your own weapons while attacking him, you may do so - go to {120}. And, if you choose to attack him magically, write down your spell and go to {90}."
},
{ // 13/4C
"If you use a Will-o-the-Wisp spell, go to {53}. If you try to strike a flame to a torch or lantern, go to {70}."
},
{ // 14/4D
"If you blast with fire, go to {185}. If you choose to use ice, go to {85}.[ However (remember this instruction as it takes precedence over the instructions at {85}), if you failed to slay it immediately at {85}, turn directly to {36}.]"
},
{ // 15/4E
"You cautiously did not make a light, but you have been in the dark long enough. The place lit up anyway with no harm to you. You receive an extra 100 experience points for your exemplary caution. Now go to {47}."
},
{ // 16/4F
"No physical defence will save you from these swords. Unless you try magic, go to {2}. If you try magic, write down your spell and then go to {129}."
},
{ // 17/4G
"Something large, hairy and heavy landed on you and bit a big hole out of your face and neck. You feel a terrible pain - everything goes black. Go to {2}."
},
{ // 18/5A (Situation 3 of 16)
"You are in a large dark room. With your first step, you feel brittle bones crunching under your feet. Make your L1-SR (20 - LK). If you make it, go to {84}. If you fail, go to {17}."
},
{ // 19/5B
#ifdef CENSORED
"Ursla decides she likes your looks and invites you for an evening's entertainment. You look once from her to her bears, then make a decision. If your decision is to stay with her, go to {180}. If you decide to tell her you are tired and would rather leave, go to {126}."
#else
"Ursla decides she likes your looks and invites you for an evening's dalliance. You look once from her to her bears, then make a decision. If your decision is to stay with her, go to {180}. If you decide to tell her you are tired and would rather leave, go to {126}."
#endif
},
{ // 20/5C
"In combat, Haksum gets 6 dice for his 2 weapons, and 15 adds. He will not go berserk, though you may if it will help. His Constitution is only 10. [If you go berserk and your Strength falls to 5 or less, you pass out and he kills you. ]If he wins, go to {2}. Haksum takes all your possessions and throws your body out for the dungeon rats to gnaw. If you kill him, go to {134}."
},
{ // 21/5D
"Tavashtri's ratings are ST:63, IQ:13, LK:15, CON:77, DEX:28, CHR:0. It gets 8 dice in combat and 67 adds. You may take your first attack directly off its Constitution. If you killed it, go to {171}. If you are using fighting spells such as Take That You Fiend or Blasting Power, you will stay here and fight. Score your hits first, and then if it isn't dead on the 2nd combat turn, calculate its hits on you. If your Constitution drops to 0 or less, go to {2}. [If your weapon is magical in any way, ]stay here and fight until either you or Tavashtri is slain. If you win, go to {171}. If you lose, go to {2}.[ If your weapon is not enchanted in some way, go to {44}.]"
},
{ // 22/5E
"If your total is more than 50 gold pieces, go to {135}. If less, your ring begins to glow. You may either leave (go to {3}), or gather more treasure (go back to {151}), or search for secret doors (go to {143})."
},
{ // 23/6A (Situation 4 of 16)
#ifdef CENSORED
"You are in the bedroom of a very lovely lady. She has a thin oval face, a voluptuous figure scantily clad in an outfit of fur, and glossy black hair. She also has 2 large white bears in the room with her (Monster Rating of 47 each). The walls are hung with mirrors, and if you are a warrior, you sense tremendous magical energies nearby. What is your Charisma? If it is 8 or less, read no further, but turn to {99}.\n" \
"  If your Charisma is 9 or higher, you have 3 options. If you want to attack her, go to {8}. If you speak nicely and apologize for breaking into her boudoir, go to {95}. If you want to be invisible, and cast a Concealing Cloak upon yourself, go to {30}."
#else
"You are in the bedroom of a very lovely lady. She has a thin oval face, a voluptuous figure scantily clad in an outfit of fur, and long glossy black hair. She also has 2 large white bears in the room with her (Monster Rating of 47 each). The walls are hung with mirrors, and even if you are a warrior, you sense tremendous magical energies nearby. What is your Charisma? If it is 8 or less, read no further, but turn to {99}.\n" \
"  If your Charisma is 9 or higher, you have 3 options. If you want to attack her, go to {8}. If you speak nicely and apologize for breaking into her boudoir, go to {95}. If you want to be invisible, and cast a Concealing Cloak upon yourself, go to {30}."
#endif
},
{ // 24/6B
"You may cast any 1st-5th level spell in your power. Write down which spell you used, and then go to {35}."
},
{ // 25/6C
"You have called up a giant blood bat with a Monster Rating of 100. You must defeat it to get away with your life. (In combat it gets 11 dice and 50 adds.) If you fight with magic, write down your spell and go to {10}. If you use weapons, go to {42} and ignore the first sentence."
},
{ // 26/6D
"Behind the door was a cockatrice. It sees you before you saw it and turns you to stone with its glance. Go to {2}."
},
{ // 27/6E
"Make your saving roll (20 - Luck). Haksum has rigged a trap to protect his treasure. If you missed the saving roll, you opened his treasure box the wrong way and released a cloud of poison gas. Go to {2}. If you made your saving roll, go to {96}."
},
{ // 28/6F
"You warded off that first blow and broke free with only a minor wound. Reduce your CON by 1/3, rounding down. The troll gets 7 dice and 20 adds each combat turn, and has a CON of 50. You are no longer able to dodge and duck, but must stand and fight by the normal rules. Whoever's Constitution goes to zero first, dies. If you win, go to {3} (she was worth 50 experience points). If you die, go to {2}."
},
{ // 29/7A (Situation 5 of 16)
"You are standing with your back against a wall in a large red circle. This room is 30' square; on the walls are mirrors and paintings. There is a table and a chair in the centre of the room, carpets on the floor, and couches near the side walls.\n" \
"  In front of the door stands a great hulk of a warrior, 6' 6\" tall, 250# of muscle. He is armed with a broadsword in his right hand; instead of a left hand, he has a double-bladed war axe (6 dice plus 3 adds).\n" \
"  He speaks jauntily. \"Hello, buster. Haksum is my name and robbing people is my game. Har, har! Don't bother going for your magic - none of it will work in this room. Now either lay down your cash, or pull out your weapons.\" Haksum grins ferociously through strong yellow fangs and advances upon you.\n" \
"  If you choose to fight, go to {86}. If you surrender, go to {100}."
},
{ // 30/7B
"It didn't work. Unless you have received other instructions, return to the paragraph you just came from."
},
{ // 31/7C
"As long as you do nothing, the situation remains unchanged. Go back to the paragraph you just came from."
},
{ // 32/7D
"Deluxe staffs are indestructible. You wedge yours between floor and ceiling, and the roof grinds to a stop. Very clever of you. For quick thinking you get 75 experience points. The door pops open. You may take the emerald if you wish (roll for its value on the Jewel Generation chart). You have lost your deluxe staff. Return to {51}.\n" \
"  The ring is now glowing. You may either gather treasure (follow the instructions in {51}), leave (go to {3}), or exit by the other secret door (go to {26})."
},
{ // 33/7E
"You may either grope around with your hands (go to {127}), or use a Revelation spell on the walls around you (go to {119})."
},
{ // 34/8A (Situation 6 of 16)
"You are in a very dark place. You see what appears to be the night sky full of stars directly in front of you and close enough to touch. If you are a magic-user, you sense magic all around you. If not, you deduce that magic may be involved.\n" \
"  If you want to try an Omnipotent Eye, go to {118}. To make some light (either naturally or by magic), go to {71}. If you step forward, or turn around and try to walk away, go to {167}. If you don't move and just wait for something to happen, go to {131}."
},
{ // 35/8B
"If you wrote Mind Pox or Protective Pentagram, the bats will be baffled and fly away, leaving you safe. Go to {60}. If you used any other spell, it was not enough to stop all 8 monsters. They got you. Go to {2}."
},
{ // 36/8C
"The spells you can use are: Take That You Fiend (go to {7}), Blasting Power or Icefall (go to {14}), Smog (go to {69}), or Protective Pentagram (go to {116}). Nothing else will work this time."
},
{ // 37/8D
"The door opens into a small room, 10' by 10'. At the far end of the room in a niche in the wall is a large emerald. You sense no magic in the room. If you enter, go to {153}. If not, return to {156}."
},
{ // 38/8E
"You sense very powerful magic about this fellow and his weapons. It is enough to make you listen to what he has to say. Go to {12}."
},
{ // 39/8F
"First, a magic purse that always has 5 new gold pieces in it at dawn. Then if you are a warrior, she gives you a 3-dice sword that will take as many hits for you as it dishes out on any combat turn. Furthermore, even if you are beaten in combat, when using this sword, your hits will always count against the foe. If you are a magic-user she gives you a special bear-claw necklace that reduces the Strength cost of any spell you throw by half. If you are a rogue or a warrior-wizard, she offers you the choice of one or the other (the sword or the necklace). You also get 1000 experience points for everything you've learned from her. Go to {3}."
},
{ // 40/9A (Situation 7 of 16)
"You have come to the Equalizer Room. Magical rainbow-coloured energies swirl dizzily all around you. Tremendous forces tear at your body - each of your attributes has been altered by 18th level sorcery to 20 (ie. ST:20, IQ:20, LK:20, etc.). Any attribute, whether it was higher or lower than 20 before, is now at 20. Go to {3}."
},
{ // 41/9B
"Make your L3-SR based on IQ (30 - IQ). If you make it, go to {155}. If you failed, go to {65}."
},
{ // 42/9C
"Altogether the bats get 9 dice and 40 adds. Keep fighting until either your CON or their rating has been reduced to zero. If you lose, go to {2}. If you win, go to {60}."
},
{ // 43/9D
"Make your first-level saving roll (20 - LK). If you made it, you eluded Haksum and got out of the room, still naked and unarmed. Your ring begins to glow. Go to {3}.\n" \
"  If you failed to make your saving roll, Haksum got one slash at you with his sword. Roll 2 dice and add 12. Take that number of hits off your CON, and take half that number permanently off your Charisma. If this killed you, go to {2}. If you still live, Haksum laughs at you and throws you out of his chamber. Go to {3}."
},
{ // 44/9E
"Non-magical weapons will inflict hits once only on Tavashtri. In doing so, they shatter and become useless. Go to secondary weapons if you have them. If you are a magic-user, you may switch to combat spells like Blasting Power, by going to {21}.\n" \
"  If you kill Tavashtri, go to {171}. If it kills you, go to {2}."
},
{ // 45/9F
"As you deliver the fatal blow, Vokal cries out, \"Free at last. I reward you!\" Then he is dead. You get 500 experience points. The scimitar is an enchanted weapon whose merest touch (1 hit) will destroy any undead monster (vampires, zombies, etc.). Go now to {3}."
},
{ // 46/10A (Situation 8 of 16)
"You are in Weland's Sword Shoppe: Proprietor, Aloishius W. Dwarfi. To buy a magic sword, go to {123}. To go through the back door and into an adventure, go to {5}. To attack Aloishius, go to {160}."
},
{ // 47/10B
"Okay, you can see the room. It is circular and is 300' in diameter. In the centre of this vast room is a pit 50' across and 50' deep. The bottom is full of spears. Magically suspended in mid-air 10' above the pit and directly over its centre is a huge bat-shaped emerald. You have several options:" \
"  (1) You can make a closer examination of the walls and floor. Go to {93}.\n" \
"  (2) If you can, you may fly yourself to the jewel and take it. It weighs 50 weight units and is worth 10,000 gp. Go to {110}.\n" \
"  (3) If you have a rope, you may improvise either a lasso or net and try to pull the jewel to you. Go to {105}.\n" \
"  (4) You may do nothing at all. Go to {31}."
},
{ // 48/10C
"You turned invisible. Haksum throws his sword down, falls on his knees, and begs you not to kill him. He is helpless. You may kill him if you wish, but he offers you 100 gold pieces to spare his life. If you kill him, go to {134}. (He is worth 37 experience points). If you take the ransom, he leads you outside, shows you a vase down the hall, and then jumps back in the room and locks his door. There are 100 gold pieces in the vase. Your ring begins to glow. Go to {3}."
},
{ // 49/10D
"What an optimist! What a fool! Roll 2 dice for Ursla. Doubles add and roll over. If she gets a 6 or less, you took her by surprise. Go to {81}. If not, the weapons flew right out of your hands. Go to {107}. If you hit her, but with less than 20 hits, go to {107} anyway. If you killed her, go to {81}."
},
{ // 50/10E
"Beneath the moss you found a loose stone which you can pull out with your bare hand. If you want to see what is there, go to {169}. If you don't care to look, go back to {127}."
},
{ // 51/11A (Situation 9 of 16)
"You are in a brightly-lit, marble-walled room 50' square and 100' high. The floor is covered with gold and silver coins. A wave of nausea rolls over you if you have magical abilities, and you know you will not be able to cast any spells while in this treasure room. The logical thing to do would be to gather up some coins or search for a secret door leading out. If you gather coins, write down how many of what kind and go to {22}. If you want to search for concealed doorways, go to {143}."
},
{ // 52/11B
"If you choose to fight with magic, write down your spell and go to {6}. If you flail blindly with weapons, you must inflict 50 hits on it to kill it. You get one-half of your weapons roll each combat turn, but you must also make your first level saving roll (20 - LK) each time.\n" \
"  If you miss your saving roll, go to {17}. If you kill the thing, go to {3}. It is worth 50 experience points and the adventure as a whole is worth 100."
},
{ // 53/11C
"POOF! A cold ball of radiance hangs in the air, and you can see what you're up against. Go to {64}."
},
{ // 54/11D
"You should not have tried to attack a witch in her own house. None of your magic works, but Ursla knows what you tried, and you have made her mad. She sets her bears on you, and with no magic to help you, they tear you to shreds. Go to {2}."
},
{ // 55/11E
"You are temporarily safe. You may apologize and go either to {3} or {11} (your choice)."
},
{ // 56/11F
#ifdef CENSORED
"She is perfectly willing to talk to you. She respects your caution, and offers to do one of two things, either 1) increase your IQ by 5 points; or 2) give you a charm[ which wards off 30 non-magical combat hits]. If you choose option 1 or 2, you've got it, and you go to paragraph {3}. If you want to give her 5 gp as a present, go to {184}."
#else
"She is perfectly willing to talk to you. She respects your caution, and offers to do one of three things, either 1) increase your IQ by 5 points; 2) give you a charm[ which wards off 30 non-magical combat hits]; or 3) let you make love to her. If you choose option 1 or 2, you've got it, and you go to paragraph {3}. If you desire her body, go to {184}."
#endif
},
{ // 57/12A (Situation 10 of 16)
"You are at the bottom of a circular well, knee-deep in water. Far up above you is a dim circle of light, and a great roaring windy noise. The walls are crusted with slimy blue algae. The floor underwater is soft and porous but undeniably rock. If you want to further explore your surroundings, go to {33}. If you just want to get out of this uncomfortable hole, go to {140}."
},
{ // 58/12B
"You are now invisible until you leave this room. [If you are attacked, the monsters will only get half their combat roll against you. ]Return to {11}."
},
{ // 59/12C
"By dropping to the floor and rolling away, you gain a moment of grace, but that's all. You still have these options: fight blindly (go to {52}); make a light (go to {13}); put a Cateyes on yourself to see in the dark (go to {64})."
},
{ // 60/12D
"You may go through the door. If you do, go to {94}. If not, go to {106}."
},
{ // 61/12E
"It is totally dark in this room. Not even a cat could see anything. You wasted your strength on that one. Return to {72}."
},
{ // 62/13A (Situation 11 of 16)
"You meet a tall, thin, bearded man dressed in black, including a black turban, who offers you one of the two scimitars he is holding. Are you a wizard, a warrior-wizard, or a rogue?  If you are, go to {38}; if not, go to {12}."
},
{ // 63/13B
"You have a weak heart, my friend. When the shriek surprised you, you had a mild attack and tumbled into the 100' deep shaft. You broke your neck when you hit the bottom. Go to {2}."
},
{ // 64/13C
"Whether you have a light or Cateyes, you now see that you are in a large triangular room 20' high. The ceiling is a mess of cobwebs, and so is the angle with the door in it. Your foe is an enormous black widow spider with a Monster Rating of 50. To get out alive, you must kill it. If you wish to fight with magic, go to {36}. If you use weapons, go to {85}. If you have open flame and want to see the webs on fire, go to {185}."
},
{ // 65/13D
"The door slides open and in swoop 8 blood bats rated at 10 each. They attack you. If you fight with magic, go to {24}. If you use your weapons, go to {42}."
},
{ // 66/13E
"You are a silly fool! We told you Tavashtri was immortal. Before your horrified eyes, you see the gargoyle pull himself back together. He is stronger than before. All his powers (dice rolled, attributes and therefore combat adds) have doubled. The only way to get out alive is to kill him again. Go to {21}, but remember that he is doubled. The rewards for slaying him do not double."
},
{ // 67/14A (Situation 12 of 16)
"You are in front of the booth of the Tin Trader, who is a Dwarf. He seems to be made entirely out of glittering tin, much like the Tin Woodsman in The Wizard of Oz. He offers to trade you one of his special tin weapons for any one of yours. If you agree, go to {176}. If you refuse, go to {149}. If you do neither, but would like to attack this metallic merchant, go to {187}."
},
{ // 68/14B
"You discover some gold coins scattered among the bones. You also find a crawl passage hidden in one dim corner of the room. If you start to gather up some coins, go to {133}. If you wait with weapons ready to see what comes out of the passage, go to {139}. If you crawl into the passage to see what is beyond it, go to {108}."
},
{ // 69/14C
"Have you ever seen a spider choking? It's ridiculous. Reduce its MR to 25. However, you are in a small room with a lot of smog, which also affects you. Your ST and CON are halved until you leave this dungeon. Return to {36}."
},
{ // 70/14D
"If your DEX is 13 or higher, you successfully make a light. Go to {64}. If not, go to {17}."
},
{ // 71/14E
"You have triggered the solar corona trap. There is a tremendous flash of light and heat from all sides. You also have a sunburn that will peel the first three layers of skin off your body in about two days. Your CON is permanently reduced by 4 points, and your DEX is halved until you regain your sight. (You are blinded until you are healed by a friendly magic-user.) Go to {150}."
},
{ // 72/15A (Situation 13 of 16)
"You are in a totally dark room. If you want to make a light, go to {151}. If you prefer to grope around in the dark, go to {173}. If you are willing and able to use a Cateyes spell on yourself, go to {61}. If you do nothing, you will quickly notice that the room remains perfectly still and quiet. Go to {31}."
},
{ // 73/15B
"You have chosen to remain in the dark. If you change your mind, go to {47}. If not, you may sit tight by going to {31}, or begin to explore. If you choose to explore in the dark, make your first level saving roll (20 - LK).\n" \
"  If you make the saving roll, go to {101}. If you missed, go to {47} - but ignore any instructions there and continue to 2 because you fell into that pit in the middle of the room."
},
{ // 74/15C
"A careful search reveals 109 gold pieces scattered among the bones - take them if you wish. Your ring begins to glow. Go to {3}."
},
{ // 75/15D
"You have discovered a hidden door in the far wall. It is unlocked, and will slide open if you wish. If you open the door now, go to {65}. If not, return to {47}."
},
{ // 76/15E
"Make a level 3 saving roll (30 - LK). If you make it, go to {166}. If not, the spell failed. Too bad! Go to {2}."
},
{ // 77/15F
"You get 4 dice for the scimitar, plus your adds. Vokal gets 4 dice for his scimitar, plus his adds (all 22 of them). He has a CON of 100, but is wearing no armour. Fight it out until one of you is dead. If you die, go to {2}. If you kill him, go to {45}."
},
{ // 78/16A (Situation 14 of 16)
"You are underwater and unable to see anything, not only because your eyes are closed, but also because there is no light. Your ears hurt due to the water pressure. If you are wearing armour and carrying any weapon larger than a knife, go to {125}. If not, go to {163}."
},
{ // 79/16B
"You come shooting up out of the well. There is a female troll at the top with a club. She takes a swipe at you; make a level 2 saving roll (25 - LK).\n" \
"  If you missed the saving roll, take 30 hits. If that killed you, go to {2}. It at least knocked you out of the air so that you will have to fight. Go to {130}.\n" \
"  If you made your saving roll, she missed you cleanly. You can either fly away, or try to defend yourself. If you fly away, go to {3}. If you wish to attack the troll, you must land to attack her, so go to {130}."
},
{ // 80/16C
"You swim strongly with the current and enter a narrow tunnel sloping down. The grade gets very steep, and the current is tremendous. Make a L2-SR on Luck (25 - LK) to avoid being knocked out. If you miss it, glub, glub, go to {2}. If you make it, then try for a second level saving roll on Constitution (25 - CON) to see if you can hold your breath long enough to reach safety. If you miss, go to {191}. If you make it, go to {98}."
},
{ // 81/16D
"You must fight two bears to a finish; each bear has a Monster Rating of 94 (10 dice and 47 adds). If you beat them, go to {91}. If they beat you, go to {2}."
},
{ // 82/16E
"Make a second level saving roll (25 - LK). If you made it, you got out the back way. Go to {11}. If you didn't make it, you were chopped up. Go to {2}."
},
{ // 83/17A (Situation 15 of 16)
#ifdef CENSORED
"You are sitting face to face with the most beautiful person you have ever seen, male or female.\n" \
"  If you have 5 gp and would like to give it to him or her as a present, go to {184}. If you want to attack, go to {170}. If you'd simply rather talk with this gorgeous being, go to {56}."
#else
"You are sitting face to face with the most beautiful person you have ever seen, male or female. This being shifts its form to the gender most appropriate to your preferences...this is your ideal mate.\n" \
"  If you want to make love to this person, go to {184}. If you want to attack, go to {170}. If you'd simply rather talk with this gorgeous being, go to {56}."
#endif
/* And the 1977 edition reads:
"You are sitting face to face with the most beautiful woman you have ever seen. She is your ideal. Everything else sort of fades into nothingness when you see her. If you are a female character, double your CHR and now go to {2C}. If you are male, decide whether you want to make love to her, attack and kill her, or talk to her. For love, go to {35D}. For war, goto {38D}. For talk, go to {39C}."
*/
},
{ // 84/17B
"Something swished by you in the dark. You could feel the long, coarse hairs on its body brush by your neck. There was a loud click, as of clashing mandibles, and a burning liquid splashed on your tunic. Your options are: fight blindly (go to {52}); drop to the floor and roll away from the thing (go to {59}); make a light quickly (go to {13}); use a Cateyes spell on yourself to see in the dark (go to {64})."
},
{ // 85/17C
"[Now that you can see, your blows do double damage to its soft body - but its bite is still deadly. ]It has a Monster Rating of 50. [If it beats your roll by 10 or more at any time, you have been bitten. Go to {2}. Otherwise, you hit it every time. ]If you kill it, go to {3}."
},
{ // 86/17D
"Are you fighting with weapons (go to {20}) or with magic (go to {122})? Remember, Haksum told you that magic wouldn't work."
},
{ // 87/17E
"Despite the pain, you were tough enough to hold on. When you draw back your hand, you find you are holding an enchanted diamond. It has turned your hand into living diamond, adding 7 to your Strength and doubling your Luck and Dexterity.\n" \
"  The jewel is no longer magical, but is still worth 1000 gold pieces. Your hand will now always glow in the dark like a star. It is also a 4-die [enchanted ]weapon when you are fighting at close quarters. Your hand is worth 5000 gold pieces if someone slices it off your wrist, but that would be fatal for you. The entire experience has been worth 1000 experience points. The night sky has vanished into limbo and your ring is glowing. Go to {3}."
},
{ // 88/18A (Situation 16 of 16)
"You are in an octagonal room, totally dominated by a ferociously ugly statue of a gargoyle. It has 4 arms, wings, feet, horns, fangs, talons and a spiked tail. At its feet is a 10# block of mithril worth 1000 gold pieces. You notice that its eyes are alive and watching you. It begins to speak.\n" \
"  \"My name is Tavashtri. I am immortal, and you can be immortal by slaying me in combat. That also happens to be the only way out of this room. It takes an attack (of any kind) to activate me, but you will never get out of here while I am alive. So do your worst, mortal fool. I yearn to rend your feeble flesh.\"\n" \
"  If you attack Tavashtri, go to {21}. If you just stand there in mortal fear, go to {31}."
},
{ // 89/18B
"If you use: Take That You Fiend, go to {145}; Blasting Power or Icefall, go to {172} and fight; Concealing Cloak, go to {148}; Mind Pox, go to {157}. If you tried any other spell, it didn't work and the ape-demons killed you. Go to {2}."
},
{ // 90/18C
"Sorry, no magic works against this guy but his own. He begins to carve you up. You take 29 hits. If this kills you, go to {2}. Otherwise, you realize that your only chance is to fight with the scimitar he gave you. Grab it and go to {77}."
},
{ // 91/18D
"You stand triumphant amid the corpses of a dead witch and 2 large bears. Your ring is glowing but you may plunder Ursla's house first, if you wish. You find 500 gold pieces and the 3 magic gifts described in 39. Also roll for additional treasure 3 times on the Treasure Generation chart in the rules (not just the Jewel Generator). After collecting your loot, go to {3}."
},
{ // 92/18E
"Broadleaf is a wooden practice sword carved in old Egyptian leaf-form. It is enchanted[ and only works for magic-users for whom it also doubles as an ordinary magic staff]. It gets 6 dice in combat, but no adds. [If used against a foe with an edged weapon, the Broadleaf will be destroyed on any combat turn in which you don't make your first level saving roll on Luck (20 - LK). ]Go to {3}."
},
{ // 93/19A
"If your Luck is 12 or higher, go to {75}. If not, return to {47} unless you are a magic-user and wish to try Revelation. In that case, you would also go to {75}."
},
{ // 94/19B
"The door slams behind you and your ring begins to glow. Go to {3}."
},
{ // 95/19C
"You start a rather formal conversation and learn that her name is Ursla. She is a high-level sorceress, and has a few other advantages, like her two pet bears. She has been sizing you up. Make your first level saving roll on Charisma (20 - CHR). If you are male and make the roll, go to {19}. If you are female and make it, go to {115}. If you miss the roll (regardless of your gender), go to {99}."
},
{ // 96/19D
"You opened the treasure box from the hidden panel on the bottom. Inside you find a ruby worth 300 gold pieces, a magical black pearl worth 500 gold pieces (it allows the holder to see in the dark), and 27 copper pieces of a semi-magical nature. If you want to leave the copper pieces behind, go to {3}. Otherwise, go to {121}."
},
{ // 97/19E
"Just how smart are you? If your IQ is 16 or higher, go to {32}. If your IQ is 15 or lower, go to {124}."
},
{ // 98/19F
"You shoot out of a mountainside and go over the falls, a mere 30' drop. You execute a perfect swan dive into the pool below, surface easily, and swim to shore. Go to the Jewel Generation Chart and roll to see which gems you picked up (if any). Compute the value of your gems, and go to {3}."
},
{ // 99/20A
"Ursla doesn't like you. She tells you to give her all your money and weapons and to get out. You may either attack her or comply. If you attack, go to {8}. If you comply, you lose all your money and weapons; go to {3}."
},
{ // 100/20B
"Haksum tells you not to try anything tricky, or he'll cut you to gobbets and feed you to the barracuda. He directs you to lay all weapons, magic staffs, clothing, money, jewels, etc. on the table. If you rebel and attack him, go to {86}. Otherwise, you become naked and helpless and go to {117}. However, Haksum does leave you your frog (or lion) ring."
},
{ // 101/20C
"You have found the edge of a pit. A deep voice cackles laughter and says, \"Make a light, you fool, or you will surely die!\" If you now make a light, go to {47}. If not, go to {15}."
},
{ // 102/20D
"The pain was too much for you. If you missed by 10 or more, go to {2}. If you missed by less than 10, go to {112}."
},
{ // 103/20E
"The Yuurrk looks like a worthless piece of tin, but it has 17th level magic on it. It gets no dice in combat[ and will be destroyed if you try to fight with it, but it will absorb any hits not inflicted by magic while you wear it - up to 100 per combat turn]. Go to {3}."
},
{ // 104/20F
"It was a long way to the top, and guess what? There's no air up here, either. Make a third level saving roll on Constitution (30 - CON) to see if you've run out of air yet. If you miss it, go to {2}. If you are a magic-user, and you made your saving roll just now, you have one chance to save your life. Write down what spell you try, and go to {178}. If you can't use any magic here, but still have a little air left, go to {190}."
},
{ // 105/21A
"Make a second level saving roll based on your Dexterity (25 - DEX) to net or lasso the jewel. For each time you try and fail, subtract 1 from your Strength. If you can't get the jewel, return to the options section of 47 and try something else.\n" \
"  If you net the jewel and pull it in, you summon its demon guardian. Go to {25}."
},
{ // 106/21B
"A deep voice croaks, \"You had your chance!\" The door slams shut and vanishes. You will not be able to find it again. Go back to {47}. You must now get the emerald in order to get out. If you can't get the emerald by any of the means suggested, you will starve to death in here. Go to {2} if you fail to get hold of the jewel."
},
{ // 107/21C
"Ursla's 5th level Take That You Fiend puts 255 hits on you, directly off your CON. If your CON is reduced to zero or less, go now to {2}. If, incredibly, you still live, she lets her bears finish the job. Go to {2} anyway."
},
{ // 108/21D
"You crawl right into the hands of a ferocious carnivorous ape. With tremendous strength, it rips your head off before you can even react. Go to {2}."
},
{ // 109/21E
"Make your first level saving roll (20 - LK) to avoid injury when falling. If you missed your saving roll, take the difference you missed by directly off your CON and subtract 3 from your Strength. If your CON or ST has been reduced to 0 or less, go to {2}. If not, go to {127}."
},
{ // 110/22A
"Before you grab the jewel, you sense operational magic on it. If you don't want to touch it, fly back to solid ground and return to {47}. If you want to take the jewel, go to {41}."
},
{ // 111/22B
"You hit it. If you got 100 hits or more, it is dead. If you didn't get 100 or more, it also hit you. Computer the new MR and make the monster dice roll. Its adds are one half of its rating. If your CON is zero is less, go to {2}. Otherwise, subtract the ST for your spell and return to {10}. If it is dead, go to {3}."
},
{ // 112/22C
"You find that your hand now glows in the dark. It has been turned into a living diamond. Add 7 to your Strength, and your hand is a 4-die [enchanted ]weapon by itself now. Your diamond hand is worth 5000 gold pieces, but if it is cut off, you will die, so you can't collect the money for it. You get 800 experience points for your magical hand. Go to {3}."
},
{ // 113/22D
"Roll your attack and subtract hits from 100. It shied off and did not hurt you. If you killed it, go to {3}. If not, subtract Strength for spellcasting and return to {10}."
},
{ // 114/22E
"You are safe; the blood bat cannot harm you. Your Protective Pentagram wears off after 2 turns of waiting, and the bat is still there. Return to {10}."
},
{ // 115/22F
"Ursla decides she likes your looks and wants to make better friends with you. She tells you to pull up a bench and tell her about your life, because she likes to hear a good tale. Let's hope your tale-weaving is up to it, even if you have to invent most of the story! Roll 2 dice; doubles add and re-roll.\n" \
"  3-8: After a few minutes of your hemming and hawing, Ursla snorts in disgust. She tells you that you must have led a boring trivial piggish life, because you are such a boring trivial person. With a wave of her hand, you're turned into a pig and chased out of her back door into a sty. That's the end of this character; close the book!\n" \
"  9-11: Your story-telling was fairly interesting, and she had a few anecdotes to tell in exchange. These provide insights you may be able to use in the future, so take 500 experience points. Eventually she gets bored, and sends you home to 3.\n" \
"  12 or higher: She is entranced with your witty stories and wild adventures, and you have a long and lively conversation with her. Overcome with affection, she offers you presents for enlivening a long evening. Go to {39} to see what you receive."
},
{ // 116/23A
"In your Pentagram you are protected. Return to {36}. You now have 2 turns of relief before the Pentagram wears off; think of something else because the spider is still out there."
},
{ // 117/23B
"Now that you are humiliated and helpless, Haksum will indulge in some cowardly villainy. (In case you hadn't noticed, he's a truly loathsome character.) If your Charisma is 8 or less, he merely kicks you out of the room; your ring begins to glow and you go to {3}. If your Charisma is 9 or higher, Haksum will try to kill or disfigure you while you are helpless. Go to {43}."
},
{ // 118/23C
"As soon as you cast the spell, you hear the voice of Umslopagaas chanting at what seems like a great distance:\n" \
"    Reach far,\n" \
"    Great pain!\n" \
"    Take star,\n" \
"    Great gain!\n" \
"If you wish to grab a star, go to {159}. If not, return to {34}."
},
{ // 119/23D
"Two things begin to glow a faint purple beneath the moss. One is obviously a series of finger- and toe-holds. If all you want to do is climb up and out, go to {127} and read from the second sentence on. The other thing you see looks like a loose stone, not cemented in like all the rest. You scrape the scum off and see it is small enough to come out in your hands. If you wish to see what is behind it, go to {169}."
},
{ // 120/23E
"Your weapon (even if it is the most powerful enchanted weapon in the world) shatters into little tiny pieces on first contact with his scimitar. You then take 29 hits. If this kills you, go to {2}. If not, you realize that you'd better use the weapon he gave you. Grab the gift and go to {77}."
},
{ // 121/24A
"They are 13 Indian Head pennies (which are perfectly meaningless to your character). If you are a magic-user, when you get out of the Equalizer you may use each one to buy one spell (from 1st to 7th level, only) - the Wizards' Guild has a great curiosity for these things. Warriors may take them to sell to others who can use them. Go to {3}."
},
{ // 122/24B
"Haksum lied. He has no protection against most magic spells. Write down the spell you would like to try on him and go to {144}."
},
{ // 123/24C
"Aloishius shows you a bunch of swords, telling you to pick only one. Your choices are as follows:\n" \
"    1) Caliburn - cost 10 gold pieces. Go to {137}.\n" \
"    2) Bloodlover - cost 20 gold pieces. Go to {142}.\n" \
"    3) Glitterglint - cost 30 gold pieces. Go to {147}.\n" \
"    4) The Nothing Sword - cost 40 gold pieces. Go to {152}.\n" \
"    5) Oiving - cost 50 gold pieces. Go to {158}.\n" \
"    6) Broadleaf - cost 60 gold pieces, wizards only. Go to {92}.\n" \
"    7) Yuurk - free. Go to {103}.\n" \
"You must pay for the sword [and go to {3} ]before reading about your weapon at one of the locations given above. Wizards may buy for resale but cannot use these weapons (except for Broadleaf which is only for wizards)."
},
{ // 124/24D
"You were crushed to a pulp. Go to {2}."
},
{ // 125/24E
"You are weighed down and begin to sink. Make your first level saving roll on DEX to get out of your armour before you run out of breath. You must also let go of any weapons larger than a dagger. If you make it, go to {188}. If you're not wearing any armour, simply drop your larger weapons and choose which direction you wish to swim. Go to {163}. If you missed your saving roll above, you drowned. Go to {2}."
},
{ // 126/24F
"Anger flashes in her eyes, mixed with frustration. \"Get out of here,\" she growls in disgust. \"I'm not sure I feel like expending the magic power to give you the punishment you deserve for scorning me. Leave by that door,\" she says, pointing to the far wall. Go to {4}."
},
{ // 127/25A
"Make a first level saving roll (20 - LK). If you make it, go to {50}. If you miss, you find below the algae some shallow finger- and toe-holds. [You must remove your boots or shoes to use them. ]It takes strength to climb up out of this hole. If your Strength is less than 20, you must make a second level saving roll (25 - LK) five times in order to avoid falling back to the bottom. If you fall, go to {109}. If your Strength is 20 or greater, you need to make five first level saving rolls (20 - LK) to avoid falling. If you should fall, go to {109}. If you manage to climb all the way up without falling, go to {181}."
},
{ // 128/25B
"Four minutes later, three large carnivorous apes crawl into the room with you through a large hole in a dark corner. They each have a Monster Rating of 25, get 3 dice and 12 adds each, and they attack you. You must fight. If you use magic, write down your spell, and go to {89}. If you use your weapons, go to {172}."
},
{ // 129/25C
"If you wrote Protective Pentagram, go to {55}. If you wrote Curses Foiled, go to {76}. Anything else had little effect. Chop, chop! Go to {2}."
},
{ // 130/25D
"If you defend yourself with magic, go to {186}. If you use ordinary (or even magical) weapons, go to {28}."
},
{ // 131/25E
"After many minutes, you hear a voice whispering, \"Walk forward, or reach for a star.\" If you walk forward at all, go to {167}. If you reach for a star, go to {159}."
},
{ // 132/25F
"You have reached the bottom. Groping around, you feel some large sharp stones. You may pick up any number of them that you wish, up to 10. Write down how many you take (you don't have to take any). You also feel a strong current moving along the bottom. If you came to this paragraph from {178}, you may return there successfully after making your second level saving roll on Luck (25 - LK) to see if you can find the air pocket again in the dark. If you came to this paragraph from any paragraph other than {178}, you can either go with the current by going to {80}, or swim desperately for the surface by going to {104}, or try to swim against the current by going to {190}."
},
{ // 133/26A
"You have time to gather up 72 coins when suddenly 3 ape-demons appear. You must defend yourself. If you use magic, write down your spell and go to {89}. If you use weapons, go to {172}."
},
{ // 134/26B
"You killed this stupid bandit. Take 37 experience points. You may either leave, or search his quarters. If you wish to depart, go to {3}. To conduct a quick search of the room, go to {27}."
},
{ // 135/26C
"POOF! You have called up the guardian of the treasure by your greediness. It is a 30' tall giant with a club who intends to smash you. He gets 12 dice and 38 adds and has a CON of 50. You cannot cast any spells. Giving back the money is not sufficient. You must kill the giant to get away. [You may dodge his blows and score hits of your own by making a second level saving roll (25 - LK) once for each combat turn. ]You continue to fight until either of you is slain. If you die, go to {2}. If you kill him, you get 200 experience points and may take as much gold [or silver ]as you can carry. Then go to {3}."
},
{ // 136/26D
"The only logical escape spell is Wings. If you wrote down anything else, consider the Strength wasted to no effect. If you flew out, go to {79}. If you can't fly out and must climb go to {127}."
},
{ // 137/26E
"Caliburn requires neither Strength nor Dexterity to wield. It gets 4 dice[ (if you roll a 6, add and re-roll) - but this sword is only good for one fight]. [After that, it self-destructs and is worth nothing. ]Go to {1}."
},
{ // 138/27A
"You found a secret door in the east wall. There is also a sign cut in small letters into the wall that reads \"49 is safe\". The door gives you a kind of inexplicable bad feeling. If you want to open the door and leave, you can do it now, or at any time you wish in the future by merely declaring that you do so, and then going to {26}. If you want to pick up some coins, return to {51}."
},
{ // 139/27B
"You are waiting when the first cannibal ape sticks its head out. [If you have any weapons worth 3 dice or more in combat, you may take it at a disadvantage and attack it directly without harm to yourself. The same trick will also work on the other two. ]Each ape has a Monster Rating of 25. [If you must use magic to fight them, or fail to kill one of them in 1 round after the ambush, you will be bowled over and all the rest of the apes will get into the room with you. Go to {89}. ]If you killed them all, go to {74}."
},
{ // 140/27C
"Go to {33}. If you can use magic, write down the spell you use to get out, and go to {136}."
},
{ // 141/27D
"To sneak by, you must be invisible. Cast a Concealing Cloak on yourself (if you can) and then go to {165}. Otherwise, go back where you came from, because you have to have another idea."
},
{ // 142/27E
"[Bloodlover feeds the Constitution it destroys in others back to you as extra Strength for your next combat turn (thus temporarily raising your adds). It gets 3 dice in combat. No matter how badly you may be wounded, short of death, Bloodlover gives you the power to fight on. It also reduces your IQ by 1 point every time you use it. If you try to abandon this sword, or use another weapon in preference to it, there is a 17th level curse that will animate the sword and cause it to slay you. ]Go to {1}."
},
{ // 143/28A
"Make the highest level saving roll (on Luck) you can. Roll 2 dice and compare the total to what you would need for a first level saving roll, a second level roll, a third level roll, etc. If you don't even achieve a first level, go back to {51}. There are no secret doors for you. If you make just a first level roll, go to {138}. If you make a second level roll, go to {156}. If you make third level or higher, go to {164}."
},
{ // 144/28B
"If you wrote Concealing Cloak, go to {48}. If you wrote Take That You Fiend, Icefall, or Blasting Power, go to {134}. If you wrote anything else, Haksum was correct and is immune to your magic. Make your second level saving roll (25 - LK) to avoid his return attack. Take 20 hits on CON and armour if you missed the roll. If that killed you, go to {2}. If it didn't, return to {20}."
},
{ // 145/28C
"You stopped one demon, but the other 2 started tearing you to pieces. Make a third level saving roll (30 - LK) or take 40 hits on CON and armour. If that kills you, go to {2}. Otherwise, return to {89}."
},
{ // 146/28D
"Roll 2 dice and cross-reference the result on the chart below. If you picked up more coins than the number on the chart, then you picked up a magically poisoned coin (which works even through gloves or armour). Take the difference between your total and the chart's total as hits from your totalled attributes. Divide the remaining attribute points evenly among your Prime Attributes[, placing remainders where you will]. You may keep as many coins as your new Strength will allow you to carry. If you die (less than 6 attribute points remain for distribution), go to {2}. If you survive, go to {3}.\n" \
"         1    2    3    4    5    6\n" \
"    1 1000   32   47  145  366  225\n" \
"    2   82  800  333  579    1 1515\n" \
"    3   99   71  600    9   13  111\n" \
"    4  127   26  818  400  271  604\n" \
"    5    8  144 1066 1903  300   53\n" \
"    6   56    4  666 1492  446  500"
},
{ // 147/28E
"Glitterglint is very showy, but the ruby in its pommel is paste, and the steel in its blade is of low quality. It is worth 2 dice in combat[, and you must make your first level saving roll on Luck to keep it from breaking each combat turn you try to use it]. Go to {1}."
},
{ // 148/29A
"Invisible, you can elude the ape-demons. You have three chances to slay them by any spells of your choice, if you have sufficient Strength. If you can muster 75 hit points worth of attack, they are dead and you get 75 experience points for killing them. Go to {74}. If you cannot do that, your Concealing Cloak wears off and they kill you anyway. Go to {2}."
},
{ // 149/29B
"The Tin Trader is also a potent wizard. For your discourtesy, he turns you into a living tin statue, leaving only your clothes and weapons untransformed. This spell cannot be overridden or cancelled. Your ST and CON are reduced to ¼ of what they were before your conversion. Your other attributes remain unchanged. He will no longer even consider trading with you. Go to {9}."
},
{ // 150/29C
"Make your first level saving roll (20 - LK). If you fail, you will stagger away from where you are standing. Go to {167}. If you succeed, your ring starts to glow. Go to {3}."
},
{ // 151/29D
"You made a light - torch, Will-o-the-Wisp, lantern - it doesn't matter. The first thing you see is the Mirror of the Tiger, so called because it shows you your new reflection. You are now a sabre-toothed cave tiger[ with a MR of 186]. You retain your old IQ and the ability to growl in the Common Tongue[, but lose all your other old attributes]. [Only by killing and drinking the blood of a real tiger (in the presence of witnesses in some other dungeon) can you regain your human form. ]You must leave all your belongings behind you in this room. A door now opens, showing you the way out. Go to {3}."
},
{ // 152/29E
"The Nothing Sword is the plainest of the lot. It gets only 2 dice in combat[, but it can dig through stone or metal at 5 cubic feet per turn. Dragons will flee from a Nothing wielder, or at least not attack you. Whoever holds this sword is immune to all Take That You Fiend and similar variant spells]. Go to {1}."
},
{ // 153/29F
"No sooner are you inside than the door slams and locks behind you. It is too heavy and solid to break down. With a rumble of machinery, the roof begins to come sliding down. Your magic, if you ever had any, still isn't working. If you have a deluxe staff, go to {97}. If not, go to {124}."
},
{ // 154/30A
"Disgusted with your cowardice and discourtesy, Vokal casts an 18th level spell on you that reduces all your attributes by half (round down). This spell cannot be cancelled by any other mage. He also activates your ring to get you out of his universe. Go to {3}."
},
{ // 155/30B
"You have the jewel, but you have also called up a demon blood bat with a Monster Rating of 100. Since you are a magic-user, you must fight it with magic. Write down your spell and go to {10}."
},
{ // 156/30C
"You found 2 secret doors, one in the east wall, and one in the west. They are easy to open. If you wish to open the eastern door, go to {26}. To open the west door, go to {37}. If you decide not to open either door, go back to {51}."
},
{ // 157/30D
"The apes are completely confused. They go off into a corner and gibber, leaving you unmolested. If you wish to explore the room, go to {74}. If you want to leave by the way they came in, go to {3}. If you want to attack the poor helpless beasties, go to {175}."
},
{ // 158/30E
"[Oiving doubles as a cigarette lighter and first aid kit. (It throws 2 dice worth of flame for a cost of 2 Strength points, and heals 3 hits per combat turn.) ]Used as a sword, it gets 6 dice in battle[ and is guaranteed for 3 full combat rounds. After that you must make a second level saving roll (on Luck) each round you fight to see if Oiving breaks. (It will break if you don't make your saving roll].[)] Go to {1}."
},
{ // 159/31A
"Your fingers close around a star about the size of a large diamond. It feels like you have clutched an ingot of white-hot steel. Make a second level saving roll on Strength (25 - ST). If you make it, go to {87}. If you miss, go to {102}."
},
{ // 160/31B
"The sword seller knows the Protective Pentagram spell. You are unable to harm him. We can't have people robbing and assaulting legitimate business establishments. A dozen magic swords levitate and begin to attack you. If you wish to fight them, go to {16}. If you wish to apologize, you must first throw down your weapons and then make a third level saving roll (30 - LK). If you make it, Aloishius accepts your apology and boots you out the back way. Go to {11}. If you don't make it, you must fight the magic swords. Go to {16}."
},
{ // 161/31C
"Compute the effect of your Take That spell. If it exceeds 50, the troll is dead. Go to {177} and read from \"You get 50 experience points...\" If not, you take 41 hits. If you still live, go to {186} and try again. If you were slain, go to {2}."
},
{ // 162/31D
"You reach the bottom of the shaft 100' down. As you kick around in the dark, you feel a lot of human bones and also piles of coins. A faint glimmer of light begins to glow around you. It is the radiance of your ring. You recognize the dull yellow glint of gold in the coins on the floor. If you wish to leave without touching the treasure, go now to {3}. If you wish to pick up some money, write down any whole number between 1 and whatever you can carry. Then go to {146}."
},
{ // 163/31E
"You must decide if you want to swim up, down, or sideways. For up, go to {104}; for down, go to {132}; for sideways, go to {189}."
},
{ // 164/31F
"You found 2 secret doors, one in the east wall and one in the west. They are easy to open. However, you have a very bad feeling about both of them, especially the eastern door. If you wish to open the eastern door, go to {26}. If you wish to open the west door, go to {37}. If you decide not to open either door, go back to {51}."
},
{ // 165/32A
"You can use a Wings to shoot past the troll, or if you must climb up out of the well, go back to {127}. The troll will not discover you if you climb out, so you will get away in either case. Go to {3}."
},
{ // 166/32B
"The magic swords were neutralized by your spell. Aloishius offers you another chance. Return to {46} and don't attack him again."
},
{ // 167/32C
"You just stepped out into interstellar space. There is no way back, and no way to stay alive. You freeze instantly and haemorrhage a lot around the face. Go to {2}."
},
{ // 168/32D
"Compute the effect of your spell. If it exceeds 50, the troll is dead. You get 50 experience points for killing it. If the troll isn't dead, he gets 41 hits on you. If you are slain, go to {2}. If not, return to {186}, but remember to play the continuing combat with the troll's rating and number of dice to be rolled against you at its new reduced Monster Rating (down from 50)."
},
{ // 169/32E
"Behind the loose stone is a little niche in which is a crudely carved statuette of a female troll. The statue is of pure mithril and is worth 1000 gold pieces. There is magic spell on it. If you wish to use an Omnipotent Eye on it to find out about the enchantment, go to {174}. If you can't use that spell, or don't dare, and just want to get out, then decide if you want to climb or try magic. If you climb, go to {127} and read from the second sentence on. If you're going to use magic, write down your spell and go to {136}."
},
{ // 170/32F
"You are either very suspicious or very foolish. There is a flash of divine lightning and you have just taken one more hit than you are able to take. You are a crispy critter. Go to {2}."
},
{ // 171/33A
"You have slain the toughest monster in the Equalizer dungeon. That is worth 1920 experience points. Write this next part down on your character card. By besting Tavashtri, you have earned one reincarnation (he lied a little bit; you're not immortal). If you are ever slain, you will come back to life in a new body. Your IQ and identity (memory) remain the same, and you keep your previous number of experience points. You must re-roll for all other attributes. You do not come back in the same body you died in, so you do not have your old gold pieces, weapons, clothing, or attributes, except for IQ.\n" \
"  You may also take the block of mithril which is worth 1000 gold pieces. You find a trapdoor beneath the mithril. If you go through it, go to {3}. If not, go to {66}."
},
{ // 172/33B
"You make your combat roll, and the apes make theirs (each has a 25 MR). The loser takes the hits as in any regular T&T combat. If they kill you, go to {2}. If you kill all of them, go to {74}.[ They will not reappear.]"
},
{ // 173/33C
"In the centre of the room you find a shaft with an iron ladder inside it leading downwards. Suddenly you hear a horrible shriek followed by a blood-curdling moan from the bottom of the shaft. Make a first level saving roll on Constitution (20 - CON). If you miss it, go to {63}. If you made it, you have the choice of making a light or climbing down the ladder. If you made a light, go to {151}. If you climb down, go to {162}."
},
{ // 174/33D
"The statuette beings to speak. \"Death waits up outside the well, My mistress troll will smash your head and send your soul to Hell.\" Forewarned is forearmed. Go to {182}."
},
{ // 175/34A
"The apes are helpless and at the mercy of your attack. You show no mercy. After they are all dead, go to {74}."
},
{ // 176/34B
"[He takes your weapon and gives you one just like it made of tin. It is only good for 3 combat rounds. The first time you use it, it gets 10 times its regular dice roll; the second time it gets 5 times its dice roll; the third time it only gets its regular dice roll. After that it is worthless. ]Go now to {9}."
},
{ // 177/34C
"The troll's mind is blasted to silly putty. If has a CON of 50. If you can muster any kind of killing spell that will exceed 50, you kill it and get 50 experience points. If not, you may leave with 25 experience points. In either case, go to {3}."
},
{ // 178/34D
"If you cast anything but Bog and Mire on the ceiling, you drowned. Go to {2}. If you used the Bog and Mire spell, the ceiling goes goosh around you and you pop up into life-giving air. Your ring is now glowing. You may leave by going to {3}, or swim down and explore the bottom of this pool by going to {132}."
},
{ // 179/34E
#ifdef CENSORED
"Make a second level saving roll on Charisma (25 - CHR). If you missed, you may double any two of your attributes and, as an additional gift, you receive a gold ring that leaves another gold ring behind it every time you take it off your finger. If you wish to give her another present, go to {192}. If you've had enough, go to {3}.\n" \
"  If your CHR saving roll was successful, you have charmed the deity - go to {192}."
#else
"Make a second level saving roll on Charisma (25 - CHR). If you missed, you may double any two of your attributes and, as an additional gift, you receive a gold ring that leaves another gold ring behind it every time you take it off your finger. If you wish to make love again, go to {192}. If you've had enough, go to {3}.\n" \
"  If your CHR saving roll was successful, you have charmed the deity - go to {192}."
#endif
},
{ // 180/34F
#ifdef CENSORED
"Roll two dice for how charming you are - let's hope you're up on your etiquette! Doubles add and roll over.\n" \
"  3-8: You are a truly lousy conversationalist. She turns you into a lizard. That's the end of this character - close the book!\n" \
"  9-11: You tell her stories through the night. You get 500 experience points for an interesting night and breakfast. Go to {3}.\n" \
"  12 or higher: You made her very happy. She gives you presents - go to {39}."
#else
"Roll two dice for your bedroom performance - let's hope you're up on your Kama Sutra! Doubles add and roll over.\n" \
"  3-8: You are a truly lousy lover. She turns you into a lizard. That's the end of this character - close the book!\n" \
"  9-11: You were fair and she was great. You get 500 experience points for an interesting night and breakfast. Go to {3}.\n" \
"  12 or higher: Ah, you dog, you! You were magnificent and you made her very happy. She gives you presents - go to {39}."
#endif
},
{ // 181/35A
"Oh, horrors! An ugly female troll reaches down and suddenly as you near the top of the climb, grabs you by the hair, and jerks you out into the open air. She swings a huge club at you. Make a second level saving roll (25 - LK) to see if you were able to react in time to try and defend yourself. If you missed it, go to {2}. If you made it, go to {130}."
},
{ // 182/35B
"You must decide if you want to fight the troll or sneak by it. If you want to fight, go to {186}. If you want to sneak past, go to {141}."
},
{ // 183/35C
"You have become invisible, but the troll is swinging wildly, and still might hit you. Make a first level saving roll (20 - LK) to avoid being hit. If you make it, the troll misses you completely. If you miss, you must take 20 hits. If you CON is reduced to zero or less, go to {2}. Otherwise, return to {186}[ but remain invisible. In each following combat turn you must make your first level saving roll as above to avoid being hit]."
},
{ // 184/35D
#ifdef CENSORED
"This is the deity of love, and he (or she) is pleased by you. Make a first level saving throw on CON. If you make it, you are blessed. Add 10 to either your Strength or your Constitution. If you wish to give her another 5 gp, go to {179}. If you want to leave, go to {3}.\n" \
"  If you missed the saving roll, you over-exerted yourself and the goddess (or god) is concerned for your health. Add 5 to either your Strength or your Constitution, and go directly to 3."
#else
"This is the deity of love, and he (or she) is pleased by you. Make a first level saving throw on CON. If you make it, you are blessed for your resiliency. Add 10 to either your Strength or your Constitution. If you wish to make love again, go to {179}. If you've had enough, go to {3}.\n" \
"  If you missed the saving roll, you over-exerted yourself and the goddess (or god) is concerned for your health. Add 5 to either your Strength or your Constitution, and go directly to 3."
#endif
},
{ // 185/35E
"You have set the webs afire, but now you are trapped in a raging inferno that you must endure. The spider dies, and you get 50 experience points for it. You must make a third level saving roll on your Constitution (30 - CON). If you miss by 10 or more, go to {2}. If you miss by 1 tpo 10, subtract that number from your CON as burns damage, and you dash through the flames through the door, unless your CON has gone to zero, in which case you go to {2}. If you get out the door, go to {3}. If you make your saving roll, the smoke was actually good for you. You gain the spider's Strength of 50, and your CON goes up by 5. Go to {3}."
},
{ // 186/36A
"The troll has a CON of 50 and a club. She gets 7 dice and 20 adds. There are only a few spells that make sense against her. If you try Take That You Fiend, go to {161}; if you try Blasting Power or Icefall, go to {168}; if you try a Mind Pox, go to {177}; if you try Concealing Cloak, go to {183}; if you try any other spell, go to {2}."
},
{ // 187/36B
"The Tin Trader yells, \"Not fair!\" whether you attacked with magic or weapons. There is a tremendous flash of light and heat. Your IQ and Charisma both drop 3 points (this is a permanent loss). The Tin Trader and his booth vanish, leaving you alone in limbo. Go to {9}."
},
{ // 188/36C
"You got out of your armour just as you reached the bottom of the pool. You still have a bit of air left. Go to {132}."
},
{ // 189/36D
"You reached a stone wall, but you are still underwater. Make a second level saving roll on Constitution (25 - CON) to see if you've run out of air yet. If you missed it, you drowned; go to {2}. If you still have some air, you'd better swim up or down. For up, go to {104}. For down, go to {132}."
},
{ // 190/36E
"You blew it, kid, but the gods are kind. They hate to see a really good person drown. They turn you into a blind white fish. Close the book. It's all over for you."
},
{ // 191/36F
"A fisherman saw your body floating in the pool below the falls that come out of the mountainside. He pulled you out and found there was still a spark of life. Reduce CON by half and IQ by 3 because of oxygen starvation of the brain. If you have jewels (rocks picked up from the floor of the black pool), he takes them from you before you regain consciousness. Your ring is glowing. Go to {3}."
},
{ // 192/36G
"The being is the goddess (or god) of love and confers the ultimate boon upon you. Your body disappears in a puff of flame, and your soul is merged with his (or hers) forevermore. Close the book, this character is evermore part of Love itself."
}
};

MODULE SWORD de_exits[DE_ROOMS][EXITS] =
{ {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  30,  49,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  { 128,  68,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  { 154,  77, 120,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  47,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  { 180, 126,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {   3,  51, 143,  -1,  -1,  -1,  -1,  -1 }, //  22
  {   8,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  86, 100,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  51,   3,  26,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  { 167, 131,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  { 153, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  { 123,   5, 160,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  93,  31,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  { 169, 127,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  {   3,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  33, 140,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  {  11,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  94, 106,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  72,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  24,  42,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  21,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  { 176, 149, 187,  -1,  -1,  -1,  -1,  -1 }, //  67
  { 133, 139, 108,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  { 150,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  { 173,  31,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  65,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  { 184, 170,  56,  -1,  -1,  -1,  -1,  -1 }, //  83
  {  52,  59,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  20, 122,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {  21,  31,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {   3, 121,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  47,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  {  47,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  47,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  { 159,  34,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  { 127, 169,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  { 144,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {   4,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  { 167, 159,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  {  80, 104, 190,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  {   3,  27,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  26,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  {  26,  37,  51,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  74,   3, 175,  -1,  -1,  -1,  -1,  -1 }, // 157
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162
  { 104, 132, 189,  -1,  -1,  -1,  -1,  -1 }, // 163
  {  26,  37,  51,  -1,  -1,  -1,  -1,  -1 }, // 164
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  {   3,  66,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  { 182,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177
  {   3, 132,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  { 192,   3,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  { 186, 141,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183
  { 179,   3,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187
  { 132,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188
  { 104, 132,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 192
};

MODULE STRPTR de_pix[DE_ROOMS] =
{ "de0", //   0
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
  "de11",
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
  "de23",
  "",
  "", //  25
  "",
  "",
  "",
  "de29",
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
  "",
  "", //  50
  "de51",
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
  "de62",
  "",
  "",
  "", //  65
  "",
  "de67",
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
  "de80", //  80
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
  "de91",
  "",
  "",
  "",
  "", //  95
  "de96",
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
  "de135", // 135
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
  "",
  "",
  "de149",
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
  "de181",
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
  ""  // 192
};

MODULE const int situations[16] =
{    5, //  0 (=  3)
    11, //  1 (=  4)
    18, //  2 (=  5)
    23, //  3 (=  6)
    29, //  4 (=  7)
    34, //  5 (=  8)
    40, //  6 (=  9)
    46, //  7 (= 10)
    51, //  8 (= 11)
    57, //  9 (= 12)
    62, // 10 (= 13)
    67, // 11 (= 14)
    72, // 12 (= 15)
    78, // 13 (= 16)
    83, // 14 (= 17)
    88  // 15 (= 18)
};

IMPORT int                   level, xp,
                             st, iq, lk, con, dex, chr, spd,
                             max_st, max_con,
                             armour,
                             good_attacktotal,
                             good_shocktotal,
                             gp, sp, cp, rt, both,
                             height, weight, sex, race, class, size,
                             owed_con,
                             room, prevroom,
                             module,
                             spellchosen,
                             spellpower,
                             theround;
IMPORT       SWORD*          exits;
IMPORT       STRPTR          pix[MOST_ROOMS];
IMPORT const STRPTR*         descs[MODULES];
IMPORT struct AbilityStruct  ability[ABILITIES];
IMPORT struct ItemStruct     items[ITEMS];
IMPORT struct LanguageStruct language[LANGUAGES];
IMPORT struct NPCStruct      npc[MAX_MONSTERS];

MODULE FLAG                  donethis[16],
                             doubled,
                             marathon;
MODULE int                   situation;

IMPORT void (* enterroom) (void);

MODULE void de_enterroom(void);

EXPORT void de_preinit(void)
{   descs[MODULE_DE] = de_desc;
}

EXPORT void de_init(void)
{   int i;

    exits     = &de_exits[0][0];
    enterroom = de_enterroom;
    for (i = 0; i < DE_ROOMS; i++)
    {   pix[i] = de_pix[i];
    }

    doubled  =
    marathon = FALSE;

    for (i = 0; i <= 15; i++)
    {   donethis[situation] = FALSE;
    }
    if (room == -1)
    {   room = situations[dice(3) - 3]; // 0..15
}   }

MODULE void de_enterroom(void)
{   TRANSIENT     int  amount,
                       choice,
                       choice2,
                       i,
                       result;
    TRANSIENT     FLAG done;
    PERSIST const int cointable[6][6] = {
{ 1000,   32,   47,  145,  366,  225 },
{   82,  800,  333,  579,    1, 1515 },
{   99,   71,  600,    9,   13,  111 },
{  127,   26,  818,  400,  271,  604 },
{    8,  144, 1066, 1903,  300,   53 },
{   56,    4,  666, 1492,  446,  500 }
};
    PERSIST       int  coins,
                       numcp,
                       numsp,
                       numgp,
                       numstones;

    switch (room)
    {
    case 0:
    case 1: // not acase!
        if (room == 1)
        {   if (marathon)
            {   award(10000);
            } else
            {   award(100);
                donethis[situation] = TRUE;
        }   }
        marathon = FALSE;
        do
        {   choice = getnumber("0) None\n1) Trip of the Frog\n2) Trip of the Lion\n3) Shop\nWhich trip", 0, 3);
            switch (choice)
            {
            case 0:
                victory(0);
            acase 1:
                marathon = FALSE;
                situation = dice(3) - 3;
                if (donethis[situation])
                {   if (situation == 15) // means 18
                    {   situation = 0;
                    } else
                    {   situation++;
                }   }
                room = situations[situation]; // 0..15
            acase 2:
                marathon = TRUE;
                situation = 0;
                room = situations[situation];
            acase 3:
                shop(); // %%: it's ambiguous about whether you can go shopping.
                // %% Also, it's ambiguous about Umslop "patch[ing] up minor wounds".
        }   }
        while (choice == 3);
    acase 2:
        die();
    acase 3:
        if (marathon)
        {   situation++;
            if (situation <= 16)
            {   room = situations[situation];
        }   }
    acase 4:
        i = dice(1);
        switch (i)
        {
        case 1:
            module = MODULE_AK;
            room = 32;
        acase 2:
            module = MODULE_ND;
            room = 44;
        acase 3:
#ifdef CORGI
            module = MODULE_AS;
            room = 122;
#else
            module = MODULE_SO;
            room = 74;
#endif
        acase 4:
            // module = MODULE_DE;
            room = 88; // %%: if on the Trip of the Lion, does this mean you can skip all the intervening quests?
        acase 5:
            module = MODULE_BS;
            room = 33;
            marathon = FALSE;
        acase 6:
            module = MODULE_CT;
            room = 46;
        }
    acase 5:
        if (makelight())
        {   room = 47;
        } else
        {   room = 73;
        }
    acase 6:
        if (spellchosen == SPELL_PP)
        {   room = 18;
        } else
        {   room = 106;
        }
    acase 7:
        payload(TRUE);
        if (saved(2, lk))
        {   room = 36;
        } else
        {   room = 2;
        }
    acase 9:
        award(300);
    acase 10:
        switch (spellchosen)
        {
        case SPELL_TF:
            room = 111;
        acase SPELL_BP:
        case SPELL_IF:
            room = 113;
        acase SPELL_PP:
            room = 114;
        adefault:
            good_takehits(80, TRUE);
            if (con <= 0)
            {   room = 2;
            } else
            {   room = 155;
        }   }
    acase 11:
        if (cast(SPELL_CC, FALSE))
        {   room = 58;
        }
    acase 12:
        if (castspell(5, FALSE))
        {   room = 90;
        }
    acase 13:
        if (lightsource() == LIGHT_WO || lightsource() == LIGHT_CRYSTAL)
        {   room = 53;
        } elif
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
        )
        {   room = 70;
        } else
        {   room = 59; // this should never occur?
        }
    acase 14:
        if (spellchosen == SPELL_BP)
        {   room = 185;
        } elif (spellchosen == SPELL_IF)
        {   room = 85;
        }
    acase 15:
        award(100);
    acase 16:
        if (castspell(5, FALSE))
        {   room = 129;
        } else
        {   room = 2;
        }
    acase 18:
        if (saved(1, lk))
        {   room = 84;
        } else
        {   room = 17;
        }
    acase 20:
        if (!countfoes())
        {   create_monster(76);
        }
        fight();
        if (con <= 0)
        {   room = 2;
        } else
        {   room = 134;
        }
    acase 21:
        create_monster(77);
        theround = 0;
        if (doubled)
        {   npc[0].st   *= 2;
            npc[0].iq   *= 2;
            npc[0].lk   *= 2;
            npc[0].con  *= 2;
            npc[0].dex  *= 2;
            npc[0].chr  *= 2;
            npc[0].spd  *= 2;
            npc[0].dice *= 2;
            npc[0].adds *= 2;
        }
        good_freeattack();
        while (countfoes() && con >= 1)
        {   oneround();
        }
        if (con >= 1)
        {   room = 171;
        } else
        {   room = 2;
        }
    acase 22:
        give_gp(numgp);
        give_sp(numsp);
        give_cp(numcp);
        if ((numgp * 100) + (numsp * 10) + numcp > 5000)
        {   room = 135;
        }
    acase 23:
        if (chr <= 8)
        {   room = 99;
        } elif (cast(SPELL_CC, FALSE))
        {   room = 30;
        }
    acase 24:
        castspell(5, FALSE);
    acase 25:
        create_monster(85);
        if (castspell(5, FALSE))
        {   room = 10;
        } else
        {   room = 42;
        }
    acase 27:
        if (saved(1, lk))
        {   room = 96;
        } else
        {   room = 2; // %%: but what if you are immune to poison?
        }
    acase 28:
        templose_con(con / 3);
        if (!countfoes())
        {   create_monster(79);
        }
        fight();
        if (con >= 1)
        {   room = 3;
        } else
        {   room = 2;
        }
    acase 30:
        if (prevroom == 8)
        {   room = 54;
        } else
        {   room = prevroom;
        }
    acase 31:
        room = prevroom;
    acase 32:
        award(75);
        dropitem(58);
        rb_givejewel(EMERALD, -1, 1);
        // %%: it says "return to 51" but then gives three choices
    acase 33:
        if (cast(SPELL_RE, FALSE))
        {   room = 119;
        } else
        {   room = 127;
        }
    acase 34:
        if (cast(SPELL_OE, FALSE))
        {   room = 118;
        } elif (makelight())
        {   room = 71;
        }
    acase 35:
        if (spellchosen == SPELL_MP || spellchosen == SPELL_PP)
        {   room = 50;
        } else
        {   room = 2;
        }
    acase 36:
        castspell(5, FALSE);
        switch (spellchosen)
        {
        case SPELL_TF:
            room = 7;
        acase SPELL_BP:
        acase SPELL_IF:
            room = 14;
        acase SPELL_SG: // Smog
            room = 69;
        acase SPELL_PP:
            room = 116;
        adefault:
            room = 2; // %%: do what if player can't cast any of the above spells?
        }
    acase 39:
        give(184);
        if (class == WARRIOR)
        {   give(185);
        } elif (class == WIZARD)
        {   give(186);
        } else
        {   if (getyn("Take sword (otherwise necklace)"))
            {   give(185);
            } else
            {   give(186);
        }   }
        award(1000);
    acase 40:
        permchange_st(20);
        change_iq(20);
        change_lk(20);
        change_dex(20);
        permchange_con(20);
        change_chr(20);
        change_spd(20);
    acase 41:
        if (saved(3, iq))
        {   room = 155;
        } else
        {   room = 65;
        }
    acase 42:
        // %%: what if already fighting eg. giant bat?
        create_monsters(81, 8);
        fight();
        if (con <= 0)
        {   room = 2;
        } else
        {   room = 60;
        }
    acase 43:
        if (saved(1, lk))
        {   room = 3;
        } else
        {   result = dice(2) + 12;
            good_takehits(result, TRUE); // %%: does armour, etc. help against these "hits"? presumably yes...
            lose_chr(result / 2);
            if (con <= 0 || chr <= 0)
            {   room = 2;
            } else
            {   room = 3;
        }   }
    acase 44:
        if (castspell(5, FALSE))
        {   room = 21;
        } else
        {   fight();
            if (con >= 1)
            {   room = 171;
            } else
            {   room = 2;
        }   }
    acase 45:
        award(500);
        gain_flag_ability(26);
        // they already have the scimitar Vokal gave them and also the one they looted from his corpse
    acase 47:
        if (prevroom == 73)
        {   room = 2;
        } elif (getyn("Fly to jewel") && canfly(TRUE))
        {   room = 110;
        } elif (gotrope(25) && getyn("Lasso/net jewel")) // we are letting the player tie the ropes together
        {   room = 105;
        }
    acase 48:
        if (getyn("Kill Haksum"))
        {   room = 134;
        } else
        {   give_gp(100);
            room = 3;
        }
    acase 49:
        if (daro() <= 6)
        {   room = 81;
        } else
        {   room = 107;
        }
    acase 51:
        numgp = getnumber("Gather how many gp", 0, 999999);
        numsp = getnumber("Gather how many sp", 0, 999999);
        numcp = getnumber("Gather how many cp", 0, 999999);
        if (numgp == 0)
        {   room = 143;
        } else
        {   room = 22;
        }
    acase 52:
        create_monster(80);
        theround = 0;
        if (castspell(5, FALSE))
        {   room = 6;
        } else
        {   do
            {   // %%: it doesn't say at exactly which point we make the saving roll
                if (saved(1, lk))
                {   good_freeattack();
                } else
                {   room = 2;
            }   }
            while (countfoes() && room == 52);
            if (room == 52)
            {   award(50 + 100);
                room = 3;
        }   }
    acase 56:
        choice = getnumber("1) Increase your IQ by 5 points\n2) Give you a charm\n3) Fuck her\nWhich", 1, 3);
        switch (choice)
        {
        case 1:
            gain_iq(5);
            room = 3;
        acase 2:
            give(192);
            room = 3;
        acase 3:
            room = 184;
        }
    acase 59:
        makelight();
        if (lightsource() == LIGHT_CE)
        {   room = 64;
        } elif
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
         || lightsource() == LIGHT_WO
         || lightsource() == LIGHT_CRYSTAL
        )
        {   room = 13;
        } else
        {   room = 52;
        }
    acase 62:
        if (class == WARRIOR)
        {   room = 12;
        } else
        {   room = 38;
        }
    acase 64:
        // %%: "if you have open flame" is assumed to mean if you are using that as your light source
        // (as opposed to just carrying flint & tinder, etc.)
        create_monster(80);
        if (can_makefire() && getyn("Light webs"))
        {   room = 185;
        } elif (castspell(5, FALSE))
        {   room = 36;
        } else
        {   room = 85;
        }
    acase 66:
        doubled = TRUE;
    acase 69:
        npc_templose_hp(0, 25);
        owe_st(st / 2);
        owe_con(con / 2);
    acase 70:
        if (dex >= 13)
        {   room = 64;
        } else
        {   room = 17;
        }
    acase 71:
        permlose_con(4);
        gain_flag_ability(15);
    acase 72:
        makelight();
        if (lightsource() == LIGHT_CE)
        {   room = 61;
        } elif (lightsource() != LIGHT_NONE)
        {   room = 151;
        }
    acase 73:
        if (makelight())
        {   room = 47;
        } elif (getyn("Explore in the dark"))
        {   if (saved(1, lk))
            {   room = 101;
            } else
            {   room = 47;
        }   }
        else
        {   room = 31;
        }
    acase 74:
        give_gp(109);
    acase 76:
        if (saved(3, lk))
        {   room = 166;
        } else
        {   room = 2;
        }
    acase 77:
        give(194);
        create_monster(82); // Vokal
        fight();
        if (con <= 0)
        {   room = 2;
        } else
        {   room = 45;
        }
    acase 78:
        room = 163;
        if (armour != -1)
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && (items[i].dice || items[i].adds) && items[i].type != WEAPON_DAGGER)
                {   room = 125;
                    break; // for speed
        }   }   }
    acase 79:
        if (saved(2, lk))
        {   if (getyn("Fly away (otherwise attack)"))
            {   room = 3;
            } else
            {   room = 130;
        }   }
        else
        {   good_takehits(30, TRUE);
            room = 130;
        }
    acase 80:
        if (saved(2, lk))
        {   if (saved(2, con))
            {   room = 98;
            } else
            {   room = 191;
        }   }
        else
        {   room = 2;
        }
    acase 81:
        create_monsters(78, 2); // %%: it is ambiguous about whether you fight them together or separately. We assume together.
        fight();
        if (con >= 1)
        {   room = 91;
        } else
        {   room = 2;
        }
    acase 82:
        if (saved(2, lk))
        {   room = 11;
        } else
        {   room = 2;
        }
 /* acase 83:
        ; the censored version is not implemented */
    acase 84:
        makelight();
        if (lightsource() == LIGHT_CE)
        {   room = 64;
        } elif (lightsource() == LIGHT_WO || lightsource() == LIGHT_CRYSTAL)
        {   room = 53;
        } elif
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_LANTERN
        )
        {   room = 70;
        }
    acase 85:
        fight();
        room = 3;
    acase 87:
        gain_st(7);
        gain_lk(lk);
        gain_dex(dex);
        give(231);
        gain_flag_ability(27);
        award(1000);
    acase 89:
        switch (spellchosen)
        {
        case SPELL_TF:
            room = 145;
        acase SPELL_BP:
        case SPELL_IF:
            room = 172; // %%: so is the spell used to generate the combat total?
        acase SPELL_CC:
            room = 148;
        acase SPELL_MP:
            room = 157;
        adefault:
            room = 2;
        }
    acase 90:
        good_takehits(29, TRUE);
        if (con <= 0)
        {   room = 2;
        } else
        {   room = 77;
        }
    acase 91:
        give_gp(500);
        give(184);
        give(185);
        give(186);
        rb_treasure(2);
        rb_treasure(2);
        rb_treasure(2);
    acase 92:
        give(232);
    acase 93:
        if (lk >= 12 || cast(SPELL_RE, FALSE))
        {   room = 75;
        } else
        {   room = 47;
        }
    acase 95:
        if (saved(1, chr))
        {   if (sex == MALE)
            {   room = 19;
            } else
            {   room = 115;
        }   }
        else
        {   room = 99;
        }
    acase 96:
        give(ITEM_DE_PEARL);
        give(539);
    acase 97:
        if (iq >= 16)
        {   room = 32;
        } else
        {   room = 124;
        }
    acase 98:
        if (numstones)
        {   rb_givejewels(-1, -1, 1, numstones);
        }
    acase 99:
        if (getyn("Comply (otherwise attack)"))
        {   drop_all(); // %%: but only "money and weapons"
            room = 3;
        } else
        {   room = 8;
        }
    acase 100:
        if (getyn("Comply (otherwise attack)"))
        {   drop_all();
            room = 117;
        } else
        {   room = 86;
        }
    acase 101:
        if (makelight() == LIGHT_NONE)
        {   room = 15;
        } else
        {   room = 47;
        }
    acase 102:
        if (madeitby(2, st) <= -10)
        {   room = 2;
        } else
        {   room = 112;
        }
    acase 103:
        give(190); // Yuurrk
    acase 104:
        if (saved(3, con))
        {   if (castspell(5, FALSE))
            {   room = 178;
            } else
            {   room = 190;
        }   }
        else
        {   room = 2;
        }
    acase 105:
        done = FALSE;
        do
        {   if (saved(2, dex))
            {   give(336);
                room = 25;
                done = TRUE;
            } else
            {   templose_st(1); // %%: we assume it's temporary
                if (!getyn("Retry"))
                {   room = 47;
                    done = TRUE;
        }   }   }
        while (!done);
    acase 109:
        if (!saved(1, lk))
        {   templose_con(misseditby(1, lk));
            templose_st(3);
        }
        if (st <= 0 || con <= 0)
        {   room = 2;
        } else
        {   room = 127;
        }
    acase 111:
        payload(TRUE);
        if (countfoes())
        {   evil_freeattack();
        }
        if (con <= 0)
        {   room = 2;
        } elif (!countfoes())
        {   room = 3;
        } else
        {   castspell(5, FALSE); // casting another spell
            room = 10;
        }
    acase 112:
        gain_st(7);
        gain_flag_ability(27);
        award(800);
    acase 113:
        payload(TRUE);
        if (countfoes())
        {   castspell(5, FALSE); // casting another spell
            room = 10;
        } else
        {   room = 3;
        }
    acase 114:
        thewait(2);
        castspell(5, FALSE); // casting another spell
    acase 115:
        amount = daro();
        if (amount <= 8)
        {   die();
        } elif (amount <= 11)
        {   award(500);
            room = 3;
        } else
        {   room = 39;
        }
    acase 116:
        thewait(2);
    acase 117:
        if (chr <= 8)
        {   room = 3;
        } else
        {   room = 43;
        }
    acase 120:
        if (both != EMPTY)
        {   destroy(both);
        }
        if (rt != EMPTY)
        {   destroy(rt);
        }
        good_takehits(29, TRUE);
        if (con <= 0)
        {   room = 2;
        } else
        {   room = 77;
        }
    acase 121:
        give_multi(225, 13);
    acase 122:
        castspell(5, FALSE);
    acase 123:
        do
        {   result = getnumber("Buy which sword", 1, 7);
            switch (result)
            {
            case 1:
                if (pay_gp(10))
                {   room = 137;
                }
            acase 2:
                if (pay_gp(20))
                {   room = 142;
                }
            acase 3:
                if (pay_gp(30))
                {   room = 147;
                }
            acase 4:
                if (pay_gp(40))
                {   room = 152;
                }
            acase 5:
                if (pay_gp(50))
                {   room = 158;
                }
            acase 6:
                if (pay_gp(60))
                {   room = 92;
                }
            acase 7:
                room = 103;
        }   }
        while (room == 123);
    acase 125:
        if (armour == -1)
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned)
                {   if (items[i].type != WEAPON_DAGGER && (items[i].dice || items[i].adds)) // %%: maybe we should do this by actual weight, not weapon type
                    {   dropitems(i, items[i].owned);
                }   }
                // %%: should we drop all carried armour too? We assume not.
            }
            room = 163;
        } elif (!saved(1, dex))
        {   room = 2;
        } else
        {   dropitem(armour);
            armour = -1;
            for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned)
                {   if (items[i].type != WEAPON_DAGGER && (items[i].dice || items[i].adds)) // %%: maybe we should do this by actual weight, not weapon type
                    {   dropitems(i, items[i].owned);
                }   }
                // %%: should we drop all carried armour too? We assume not.
            }
            room = 188;
        }
    acase 127:
        if (prevroom != 50 && prevroom != 119)
        {   if (saved(1, lk))
            {   room = 50;
        }   }
        if (room == 127)
        {   if (st < 20)
            {   for (i = 1; i <= 5; i++)
                {   if (!saved(2, lk))
                    {   room = 109;
                        break; // %%: we assume we go immediately to 109
            }   }   }
            else
            {   for (i = 1; i <= 5; i++)
                {   if (!saved(1, lk))
                    {   room = 109;
                        break; // %%: we assume we go immediately to 109
            }   }   }
            if (room == 127)
            {   room = 181;
        }   }
    acase 128:
        elapse(4, TRUE);
        create_monsters(84, 3);
        if (castspell(5, FALSE))
        {   room = 89;
        } else
        {   room = 172;
        }
    acase 129:
        switch (spellchosen)
        {
        case SPELL_PP:
            room = 55;
        acase SPELL_CF:
            room = 76;
        adefault:
            room = 2;
        }
    acase 130:
        if (castspell(5, FALSE))
        {   room = 186;
        } else
        {   room = 28;
        }
    acase 132:
        numstones = getnumber("Take how many stones", 0, 10); // maybe these should be implemented as proper items
        if (prevroom == 178 && saved(2, lk) && getyn("Return to 178"))
        {   room = 178;
        }
    acase 133:
        give_gp(72);
        create_monsters(84, 3);
        if (castspell(5, FALSE))
        {   room = 89;
        } else
        {   room = 172;
        }
    acase 134:
        award(37);
    acase 135:
        create_monster(83);
        fight();
        encumbrance();
        give_gp((st * 100) - carrying());
        room = 3;
    acase 136:
        if (canfly(FALSE))
        {   room = 79;
        } else
        {   room = 127;
        }
    acase 137:
        give(188);
    acase 139:
        create_monsters(84, 3);
        fight();
        room = 74;
    acase 140:
        if (castspell(5, FALSE))
        {   room = 136;
        } else
        {   room = 33;
        }
    acase 141:
        if (cast(SPELL_CC, FALSE))
        {   room = 165;
        } else
        {   room = prevroom;
        }
    acase 142:
        give(226);
    acase 143:
        getsavingthrow(TRUE);
        if (madeit(3, lk))
        {   room = 164;
        } elif (madeit(2, lk))
        {   room = 156;
        } elif (madeit(1, lk))
        {   room = 138;
        } else
        {   room = 51; // %%: is it allowable then to come back and search again?
        }
    acase 144:
        switch (spellchosen)
        {
        case SPELL_CC:
            room = 48;
        acase SPELL_TF:
        case SPELL_IF:
        case SPELL_BP:
            room = 134;
        adefault:
            if (!saved(2, lk))
            {   good_takehits(20, TRUE);
            }
            if (con <= 0)
            {   room = 2;
            } else
            {   room = 20;
        }   }
    acase 145:
        kill_npc(2);
        if (!saved(3, lk))
        {   good_takehits(40, TRUE);
            if (con <= 0)
            {   room = 2;
            } else
            {   room = 89;
        }   }
        else
        {   room = 89;
        }
    acase 146:
        give_gp(coins);
        result = cointable[dice(1) - 1][dice(1) - 1];
        if (coins > result)
        {   amount = max_st + iq + lk + max_con + dex + chr + result - coins;
            if (amount < 6) // %%: it's implied that Speed isn't a Prime Attribute
            {   room = 2;
            } else
            {   permchange_st( amount / 6);
                change_iq(     amount / 6);
                change_lk(     amount / 6);
                permchange_con(amount / 6);
                change_dex(    amount / 6);
                change_chr(    amount / 6);
        }   }
        if (room == 146)
        {   room = 3;
        }
    acase 147:
        give(227);
    acase 148:
        DISCARD castspell(5, TRUE);
        if (countfoes())
        {   DISCARD castspell(5, TRUE);
            if (countfoes())
            {   DISCARD castspell(5, TRUE);
                if (countfoes())
                {   room = 2;
        }   }   }
        if (room == 148)
        {   award(75);
            room = 74;
        }
    acase 149:
        race = STATUE;
        gain_flag_ability(37);
        permchange_st(max_st / 4);
        permchange_con(max_con / 4);
    acase 150:
        if (saved(1, lk))
        {   room = 3;
        } else
        {   room = 167;
        }
    acase 151:
        gain_flag_ability(16);
        for (i = 0; i < LANGUAGES; i++)
        {   set_language(i, 0);
        }
        set_language(LANG_COMMON, 1); // growler
        set_language(LANG_CAT   , 2);
        drop_all();
        race = ANIMAL;
    acase 152:
        give(191);
    acase 153:
        if (items[DEL].owned >= 1)
        {   room = 97;
        } else
        {   room = 124;
        }
    acase 154:
        permchange_st(max_st  / 2);
        permchange_st(    iq  / 2);
        permchange_st(    lk  / 2);
        permchange_st(max_con / 2);
        permchange_st(    dex / 2);
        permchange_st(    chr / 2);
        permchange_st(    spd / 2); // %%: is this one considered an "attribute"?
    acase 155:
        give(336);
        DISCARD castspell(5, FALSE);
        room = 10;
    acase 158:
        give(228);
    acase 159:
        if (saved(2, st))
        {   room = 87;
        } else
        {   room = 102;
        }
    acase 160:
        if (getyn("Fight"))
        {   room = 16;
        } else
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && (items[i].dice || items[i].adds))
                {   dropitems(i, items[i].owned);
            }   }
            if (saved(3, lk))
            {   room = 11;
            } else
            {   room = 16;
        }   }

    acase 161:
        if (spellpower >= 50)
        {   room = 177;
        } else
        {   // %%: does the spell still take effect?
            evil_takehits(0, spellpower);
            good_takehits(41, TRUE);
            if (con <= 0)
            {   room = 2;
            } else
            {   room = 186;
        }   }
    acase 162:
        encumbrance();
        coins = getnumber("Take how many coins", 0, (st * 100) - carrying());
        if (coins == 0)
        {   room = 3;
        } else
        {   room = 146;
        }
    acase 165: // %%: ambiguous paragraph
        if (canfly(TRUE))
        {   room = 3;
        } else
        {   room = 127;
        }
    acase 168:
        payload(TRUE);
        if (countfoes())
        {   good_takehits(41, TRUE);
            if (con <= 0)
            {   room = 2;
            } else
            {   room = 186;
        }   }
        else
        {   award(50);
            room = 177;
        }
    acase 169:
        give(229);
        if (castspell(5, FALSE))
        {   if (spellchosen == SPELL_OE)
            {   room = 174;
            } else
            {   room = 136;
        }   }
        else
        {   room = 127;
        }
    acase 171:
        award(1920);
        gain_flag_ability(25);
        give(230);
    acase 172:
        fight();
        if (con <= 0)
        {   room = 2;
        } else
        {   room = 74;
        }
    acase 173:
        if (saved(1, con))
        {   if (makelight())
            {   room = 151;
            } else
            {   room = 162;
        }   }
        else
        {   room = 63;
        }
    acase 177:
        castspell(5, TRUE);
        if (countfoes())
        {   award(25);
            evil_takehits(0, 999999);
        } else
        {   award(50);
        }
    acase 178:
        if (prevroom == 104)
        {   if (spellchosen != SPELL_BM && spellchosen != SPELL_RH)
            {   room = 2;
        }   }
        else
        {   // assert(prevroom == 132);
            if (numstones)
            {   rb_givejewels(-1, -1, 1, numstones);
        }   }
    acase 179:
        if (saved(2, chr))
        {   room = 192;
        } else
        {   choice = getnumber("1) ST\n2) IQ\n3) LK\n4) DEX\n5) CON\n6) CHR\n7) SPD\nWhich first", 1, 7);
            switch (choice)
            {
            case 1:
                gain_st(max_st);
            acase 2:
                gain_iq(iq);
            acase 3:
                gain_lk(lk);
            acase 4:
                gain_dex(dex);
            acase 5:
                gain_con(max_con);
            acase 6:
                gain_chr(chr);
            acase 7:
                gain_spd(spd);
            }
            do
            {   choice2 = getnumber("1) ST\n2) IQ\n3) LK\n4) DEX\n5) CON\n6) CHR\n7) SPD\nWhich second", 1, 7);
            } while (choice2 == choice);
            switch (choice2)
            {
            case 1:
                gain_st(max_st);
            acase 2:
                gain_iq(iq);
            acase 3:
                gain_lk(lk);
            acase 4:
                gain_dex(dex);
            acase 5:
                gain_con(max_con);
            acase 6:
                gain_chr(chr);
            acase 7:
                gain_spd(spd);
            }
            give(183);
        }
    acase 180:
        amount = daro();
        if (amount <= 8)
        {   die();
        } elif (amount <= 11)
        {   award(500);
            room = 3;
        } else
        {   room = 39;
        }
    acase 181:
        if (saved(2, lk))
        {   room = 130;
        } else
        {   room = 2;
        }
    acase 183:
        if (!saved(1, lk))
        {   good_takehits(20, TRUE);
        }
        if (con <= 0)
        {   room = 2;
        } else
        {   room = 186;
        }
    acase 184:
        lose_flag_ability(88);
        if (saved(1, con))
        {   choice = getnumber("1) Add 10 to ST\n2) Add 10 to CON\n", 1, 2);
            if (choice == 1) gain_st(10); else gain_con(10);
            if (gp < 5)
            {   room = 3;
        }   }
        else
        {   choice = getnumber("1) Add 5 to ST\n2) Add 5 to CON\n", 1, 2);
            if (choice == 1) gain_st(5); else gain_con(5);
            room = 3;
        }
    acase 185:
        kill_npcs();
        award(50);
        getsavingthrow(TRUE);
        if (madeitby(3, con) <= -10)
        {   room = 2;
        } elif (!madeit(3, con))
        {   templose_con(misseditby(3, con));
            if (con <= 0)
            {   room = 2;
            } else
            {   room = 3;
        }   }
        else
        {   gain_st(50); // %%: assumes "gain" in text means "add", not "change to"
            gain_con(5);
            room = 3;
        }
    acase 186:
        switch (spellchosen)
        {
        case SPELL_TF:
            room = 161;
        acase SPELL_BP:
        case SPELL_IF:
            room = 168;
        acase SPELL_MP:
            room = 177;
        acase SPELL_CC:
            room = 183;
        adefault:
            room = 2;
        }
    acase 187:
        lose_iq(3);
        lose_chr(3);
    acase 189:
        if (!saved(2, con))
        {   room = 2;
        }
    acase 190:
        die();
    acase 191:
        lose_iq(3);
        permchange_con(max_con / 2);
    acase 192:
        die();
}   }

