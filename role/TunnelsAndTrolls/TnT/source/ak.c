#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Ambiguities (%%)/unimplemented:
 ak_missile_far() and ak_missile_near() should probably check the weapon's
  range, a la ak_missile_extreme().
 When fighting several of something, and some but not all are at <= 5
  CON, those ones are presumably considered disabled, and thus should not
  participate in the combat.
 Should the required saving roll "to hit" level for missile attacks
  really be multiplied by the number of foes? We assume so, but it seems
  strange/unfair.
 Against eg. the balrog, if they are using one magic weapon and one non-
  magic weapon, only the magic weapon should generate any hits. Also, it's
  possible, after the magic weapon check is done, to change back to non-
  magical weapon and use those.
 Trolls, ogres and goblins are given in eg. MS as being large-size (ie.
  man-sized), but AK treats them as huge (trolls and ogres) and small
  (goblins).
 Not all Corgi paragraphs have FB equivalents, and vice versa.
Notes:
 Although there is a Magic Matrix (AK113), paragraphs where it applies are
  not marked (eg. by '*'). Instead, the text refers you to AK113.
*/

MODULE const STRPTR ak_desc[AK_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  This solitaire dungeon simulates the adventures possible to characters who wish to compete in the Arena of Khazan, also known as the City of Death. Its dire reputation comes from its ruler, Lerotra'hh, the Death Goddess of Khazan, who has ruled for centuries since slaying the city's founder, the mighty wizard Khazan. Her Trollish hordes and her minion Khara Khang have held the city in an iron grip, although the reign of terror has mellowed over the years. Now most of the bloodletting takes place on the dark sands of the grand Arena.\n" \
"  The Arena is open to all - Wizard, Rogue or Warrior, Human, Elf, Monster or Beast. It is possible to win great prizes for victory, but it is more likely the fighter will die before his/her contract is fulfilled. Be warned: this is an adventure for those who love to fight, not a puzzlebox as are some other solitaires!\n\n" \
"HOW TO READ A PARAGRAPH\n" \
"  Some of the paragraphs here are long and complex. Keep the following suggestions in mind, and you should have no problems.\n" \
"  [1. While playing this solitaire, keep a piece of scratch paper handy to jot down paragraph numbers as you read them. Then, if you are told to return to the paragraph you just came from, you'll get there.\n" \
"  ]2. I have gone to considerable effort to phrase these paragraph with the choices arranged so that when you reach a choice that applies to your character, you may quit reading immediately and go to the next reference.\n" \
"  3. Some of the introductory paragraphs require you to perform some action before the fight can start. Generally, you will have to create a card for your opponent, according to the formula given - when you are told to create a Dwarf, stop everything and create a Dwarf."
"  4. Some paragraphs are divided into subparagraphs in this manner: 7A, 7B, 7C, 7D. All these are subparagraphs of paragraph 7. Usually these subdivisions segment your options in time, ie. what you have the option of doing first, then next, etc. Occasionally you will be sent back to the second or fourth part of a paragraph, like 'go to the fourth part of 7.' This means go *directly* to 7D. You no longer have the option of using any listed choices before 7D now (no 7A or 7B or 7C). Once you have done this a few times, you should have no trouble at all.\n\n~" \
"PARAMETERS FOR ARENA COMBAT\n" \
"  These are listed to give you a good idea *in advance* what kind of things you can and can't do here.\n" \
"  1. You may bring any type or level of character. Once you get the character in, you may find its powers and abilities severely limited. Remember this: if the text doesn't say you can, then you can't (ie. Shadowjacks couldn't just slip into a shadow and disappear). Khara Khang is a higher level wizard than anything you've got, or anything you can protect against, and he actively prevents you from doing things that actually aren't spelled out in the text. It's part of his job to see that the audience gets a good show - even at the price of your blood.\n" \
"  2. You may use enchanted weapons or armour in the Arena, as long as the magic fits into the scheme of regular T&T combat. If you have a ring that makes you invisible to monsters, don't expect it to work, because Khara Khang will simply negate it. The people in the stands come to see a fight, not empty air.\n" \
"  3. It is possible to be defeated in the Arena but not lose your life. If your CON (Constitution) or MR (Monster Rating) is reduced to 5 or less during combat, you will be considered 'disabled'. Usually this means you will have lost the fight, but (under some circumstances), you'll live through it.\n" \
"  4. Like all the solitaire adventures, the Arena of Khazan depends on the honour system to insure fair play. Read the paragraphs only as you reach them, and follow the instructions to the letter as you play out the game. You may expect many of your characters to die, but don't let it discourage you. If you play the game honestly, it has enough variations that it should be able to surprise you for some time to come.\n\n" \
"A QUICK NOTE ABOUT COMBAT\n" \
"  Sometimes the fall of dice will determine that you fight a type of opponent you have already fought once before. You will almost always be instructed to fight one more opponent than you did last time. Usually this is no problem if you assume your foes behave identically. You often have to make certain saving rolls, however, before or during the basic chop and hacks. It is reasonable to assume that extra foes increase the likelihood of danger.\n" \
"  *Therefore: always multiply the level number of saving rolls you are called upon to make times the number of foes you are facing.* For example: if you are fighting 2 Dwarves, and text calls for a L2-SR, you will have to make a *L4-SR in the same situation*. (Yes, I know a L4-SR is more difficult than two L2-SRs, but that is as it should be.)\n" \
"  In similar situations, the problem of using missile weapons may come up. Let us say you can put a crossbow bolt through one of those Dwarves, and you kill him on the spot. But don't think you can do it twice in the time you have. That second Dwarf isn't going to slow his charge to let you shoot at him also. If you manage to shoot and kill one of them, fine - but if you miss, or merely wound the first one, you will then be in close combat with *two* angry Dwarves.\n\n" \
"WHEN YOU ARE READY TO BEGIN, START HERE\n" \
"  It is important to establish why you are fighting in the Arena - not everyone is here voluntarily. Make you L1-SR on Luck (20 - LK). And remember, no matter how high your luck is, you must always make the minimum 5. If you make the roll, go to {71}. If you miss it, go to {77}."
},
{ // 1/1A
"You're dead, but don't feel too badly. 'Tis a condition to be admired, a state of being beyond the pettiness and pain that make up so much of life. Your soul has been liberated to seek out its next incarnation, and besides - you're helping to establish a satisfactory kill-ratio for the Arena! Please make a new character and try again![ To personalize your copy of Arena, and to make the game more interesting, turn to page 162.]"
},
{ // 2/1B
"Your unconscious (or barely conscious) body lies upon the sand at the feet of your conqueror, and at the mercy of the crowd. Thumbs up from the crowd and you will be spared; thumbs down and you will die on the spot. Figure out how many combat turns you battle lasted, then roll 1 die: if the number you have thrown is smaller than the number of combat turns you fought, you will be spared. (Thus, mercy is automatic is you lasted at least 7 combat turns - and death is automatic if you lasted only 1.) You will get no reward for this fight, and any money you bet on yourself will be lost. Still, this does count as one fight in determining your odds in future fights. If you received the mercy of the crowds, go to {144}. If not, look back to {1}."
},
{ // 3 (A-B)/1C (1-2)
"3A: In order to strike first, you will have to use magic or a missile weapon. If you threw magic, write down the spell name and level and go to {113}. If you don't use magic, read on.\n" \
"  3B: If you used a missile, make your L4-SR on Dexterity (35 - DEX). If you missed the roll, you missed the wizard. Go to {115}. If you made the saving roll, your missile struck him and did full damage. He gets 33 hits of armour protection, has a CON of 30 and a ST of 70. If you have slain him, or have reduced his CON to 5 or less so that he passes out, you are the victor - go to {190}. If his CON is still greater than 5, go to {130}."
},
{ // 4/1D
"The ape pretends to accept - but it grabs your arm instead of the banana. If your ST is 100 or greater, go to {98}. If your ST is between 50 and 100, go to {168}. If your ST is less than 50, go to {110}."
},
{ // 5/1F
"If your ST or CON is 50 or greater, then conduct regular T&T combat until one of the following things happens. If you will it or reduce its MR to 20 or less, it falls over and you go to {190}. If it kills you or reduces your CON to 5 or less, then it gets a meal off your body - go to {1}. If neither your ST or CON were at least 50, then it smashed you to the ground, doing 8 dice of damage. If this kills or disables you, you're cat food - go to {1}. If you are only wounded, go to {34}."
},
{ // 6/1G
"If the weapon you are using is enchanted or silver-bladed, go to {176}. If not, go to {11}. If you're unarmed, your days are at an end. The werewolf rips your throat out and howls with diabolical glee. Go to {1}."
},
{ // 7 (A-D)/2A (1-4)
"7A. Your opponent is a Giant. If you have already fought Giants in this Arena, you must now fight one more than you did last time. Create and name the character card for your foe. Give it a ST and CON of 50 each. For all other attributes, roll 3 dice and total, as if you were creating a regular Human character. [(If you have already created a staff of permanent Arena fighters, and you have enough Giants, use them and ignore the previous instruction.) ]Khazan's Arena Giants are clad in baggy trousers and shirts of sewn-together tiger skins. Their own hides are so tough that they can absorb the first 10 hits in a combat round without losing any CON points. These Giants are about 30' tall, and are armed with large spatula-shaped wooden clubs worth 10 dice in combat. (Remember, these Giants also get their personal combat adds.) The clubs are 10'-15' long, and the heads are covered with silver, which enables the Giants to slay magical beings. Go to {112} to figure your odds before reading on.\n" \
"  7B. Now that you have calculated the odds and placed your bet (if any), you are ready to fight. If you wish to cast magic against the Giant (or Giants), write down the spell name and the level you cast it on, and go to {113}. If you use no magic, read on.\n" \
"  7C. If you wish to use a missile weapon against your foe, select one of the following 4 ranges and go to that paragraph: pointblank ({18}); near ({33}); far ({41}); extreme far ({47}). If you don't use a missile, read on.\n" \
"  7D. If you would like to try and dodge the Giant(s) for a combat turn to see what it does, go to {142}. Or, if you simply wish to attack it in regular T&T combat, go to {114}."
},
{ // 8/2B
"Make a L3-SR on IQ (30 - IQ). If you make it, go to {193}; if you miss it, go to {24}."
},
{ // 9/2C
"You are entangled in a bola. The Hobbit(s) gets 1 free attack on you with its knife (2 dice + 4 adds), before anything else happens. If you are killed, go to {1}. If your CON is reduced to 5 or less, go to {2}. If neither of these things has happened, make a L1-SR on Dexterity (20 - DEX). If you make it, you disentangle yourself and can fight hand-to-hand by going to {81}. If you missed the saving roll, you are still helpless, and the Hobbit(s) will get another free combat turn against you. Return to the beginning of this paragraph and go through it as many times as necessary, until one of the above conditions has been fulfilled and you can leave to another paragraph."
},
{ // 10 (A-D)/2D (1-4)
"10A. Your foe is a horror out of a nightmare, a giant spider as large as a man. It scuttles across the sands toward you with its mandibles dripping a green venom.\n" \
"  10B. If you wish to use magic against the spider, write down the spell name and level, and go to {113}. If you don't use magic, read on.\n" \
"  10C. If you wish to use a missile weapon against the spider, choose one of the four ranges to shoot at, and go to the appropriate paragraph: pointblank ({106}); near ({87}); far ({124}); extreme ({135}).\n" \
"  10D. If you intend to fight it at close range with a hand weapon, go to {125}."
},
{ // 11/2E
"The weapon breaks in your hand and does no damage to the werewolf, who leaps right through your attack and sinks his fangs somewhere deep in your flesh! Go to {28}."
},
{ // 12/2F
"*STOMP!!!*\n" \
"  (Go to {1}.)"
},
{ // 13 (A-D)/3A (1-4)
"13A. Your opponent is a Gremlin. If you have fought Gremlins previously in the Arena, you must now fight one more than you did last time. Roll 1 die for each Gremlin that you must fight. If you get an odd number, it is a male; if you rolled an even number, it is female. Each male has the following attributes: ST:7, IQ:8, LK:17, CON:7, DEX:9, CHR:7. The females are a bit tougher - add 1 point to each of the male's attributes. The male gets 3 combat adds; the female gets 5. Each Gremlin is armed with a barbed fish-spear (worth 3 dice in combat), and also carries a short curved dagger (worth 2 dice + 1 add). Go to {112} to figure your odds before reading on.\n" \
"  13B. Now that you have calculated odds and placed bets (if any), get ready to fight. If you wish to use magic against the Gremlin(s), write down the spell name and level, and go to {113}. If no magic, read on.\n" \
"  13C. If you wish to use a missile weapon against the Gremlin(s), make your L1-SR on Speed. [(If you have no Speed rating, make one now: roll 3 dice and total. As a special Arena bonus, you may add and re-roll if you get triples.) ]If you made the saving roll, go to {63}. If you missed it, go to {69}.\n" \
"  13D. If you are reading this, you are in close hand-to-hand combat with your opponent. Go to {126}."
},
{ // 14/3B
"The wizard throws a first level Take That You Fiend spell at you. There is a flash, a bang, and you are rocked back with the impact of the magic. The spell reduces his ST by 5 points - and it reduces your CON by the same number as the wiz's IQ. If that kills you, go to {1}. If it only disables you (drops your CON to 5 or less) go to {2}. If you're only hurt, you now have a chance to retaliate. Go to {20}."
},
{ // 15/3C
"Your foe is an enchantress and has a heart of stone. Your gallant gesture was wasted on her. She blasts you with her prepared spell. Go to {137}."
},
{ // 16/3D
"This will be regular T&T combat...you vs. the Orc warrior-wizard. Normally, his dagger gets 5 dice, but this is tripled for the first combat turn. He also gets all his personal adds (don't triple those). You get your in-hand weapon (whatever it is worth), plus your personal adds. As long as the Orc is winning, you must stay here and fight. If he kills you, go to {1}. If he disables you (CON of 5 or less), go to {2}. If you slay him outright in exactly one combat turn, go to {190}. If you wound him on any combat turn, go to {134}."
},
{ // 17/3E
"If your weapon is inherently magical or has been enchanted for this combat, go to {37}. If not, go to {184}."
},
{ // 18/3F
"You are aiming at a huge target at pointblank range. Make your L1-SR on Dexterity (20 - DEX). If you missed the saving roll, you also missed the target. You must take all the hits it can dish out in one combat round, so make its combat roll and take the hits. If this kills you, go to {1}. If it reduces your CON to 5 or less and your foe is not a Monster or a Beast, go to {2}. If your foe is a Monster or a Beast, it will finish the job before you can be rescued; go to {1}. If you were able to take the hits on your armour, or are not so badly wounded that you can't continue to fight, return to the fourth part of the paragraph that sent you here.\n" \
"  If you made the saving roll, your missile struck true. Your foe must take the full amount of hits you delivered (but it can take those hits on armour or tough skin, just as you can). If you slay it, go to {190}. If you have only wounded it, you will be able to evade it for the rest of this combat round. Return to the second part of the paragraph that sent you here, and continue the fight. (This ends one combat turn.)"
},
{ // 19 (A-D)/4A (1-4)
"19A. Your opponent is a Hobbit. If you've already fought against Hobbits, fight one more than you did last time. Use the Peters-McAllister chart in the T&T rules, and create as many Hobbits as you have to fight. Khazan Hobbits are armed with [a bola and ]a long thin flensing knife (worth 2 dice + 4 adds). Go now to {112} to figure your odds before reading on.\n" \
"  19B. Now that you have calculated odds and placed bets, you are ready to fight. If you wish to cast magic against the Hobbit(s), write down the spell name and level; go to {113}. If not, read on.\n" \
"  19C. If you wish to use a missile weapon against your foe(s), select the range you will shoot from, and go to the indicated paragraph: pointblank ({78}); near ({94}); far ({102}); extreme ({104}).\n" \
"  19D. If you would like to wait or dodge for one combat round to see what the Hobbit(s) do, go to {127}. For hand-to-hand combat, go to {81}."
},
{ // 20 (A-D)/4B (1-4)
"20A. You are fighting a first level wizard; it's your option as to first action.\n" \
"  20B. If you wish to use magic, write down the spell name and level. Go to {113}.\n" \
"  20C. If you wish to use a missile weapon, you're already at near range. Go to {87}.\n" \
"  20D. If you go in for hand strokes against this wizard, you're in for a bit of a surprise. Go to {14}."
},
{ // 21 (A-D)/4C (1-4)
"21A. Your foe is the dreaded Balrog. It is 20' tall, wreathed in flame, and it wields a tremendous whip. When it sees you, it laughs appallingly and snorts,\n" \
"  \"COME TO YOUR DOOM, PIPSQUEAK! I'LL EVEN GIVE YOU FIRST BLOW!\"\n" \
"  If you take the Balrog at his word and rush in to attack him, go to {166}. If not, read on.\n" \
"  21B. If you wish to use magic against the Balrog, write down the name and level of your spell and go to {113}.\n" \
"  21C. If you wish to use a missile weapon against it, it won't dodge your puny weapon. (It wants to laugh at you when you fail to hurt it). Calculate how much damage you could do, then go to {17}.\n" \
"  21D. If you're reading this, you're in close combat with the Balrog. Go to {130}."
},
{ // 22/4D
"These big cats are quicker than they look. Make your L3-SR on Luck (30 - LK). If you make it, deliver all of your hits unscathed; go to {42}. If you missed the roll, the cat hit you with at least one paw, and you must take as many hits as you missed your saving roll by. Also, compare your attack with its attack, and if it beat your roll you must take normal combat hits (the difference between your rolls). If you beat its attack, however, you inflict the difference on the lion, as in regular combat. Go to {52}."
},
{ // 23/4E
"The anaconda fights by using its massive head as a battering ram to stun its prey (you). If you are an Ogre, Troll, or Giant, go now to {35}. If you aren't one of those big guys, you need to make a saving roll on Luck to avoid being struck by the serpent. Roll 1 die - make your saving roll at that level. If you miss the saving roll, go to {92}. If you make the roll, go to {79}."
},
{ // 24/4F
"You are aware that Shoggoths have a weakness for piccolo music, but you never learned how to play the piccolo. A horrible feeling of doom comes over you. Go to {143}."
},
{ // 25 (A-D)/5A (1-4)
"25A. Your opponent is a Dwarf. If you have fought Dwarves previously in this Arena, you must now fight one more than you did last time. Use the Peters-McAllister chart in the introduction, and create as many Dwarves as you have to fight. The Khazan Dwarves wear ring mail (takes 11 hits) and are armed with broadaxes (4 dice; requires a ST of 17 or the fighter will tire). Go to {112} to figure your odds before reading on.\n" \
"  25B. Now that you have calculated your odds and placed your bets (if any), you are ready to fight. If you wish to cast magic against the Dwarf (or Dwarves), write down the spell name and the level you are casting it on and go to {113}. If not, read on.\n" \
"  25C. If you wish to use a missile weapon against your opponent(s), select your range and go to that paragraph: pointblank ({78}); near ({94}); far ({102}); extreme ({104}). If you aren't using a missile weapon, read on.\n" \
"  25D. If you would like to try to evade the foe for the first combat turn to study its method of attack, go to {128}. Otherwise, you must engage in hand-to-hand combat. Go to {88}."
},
{ // 26/5B
"Your opponent, a first-level wizard, wears a dagger (worth 2 dice) and carries a staff ordinaire. Roll up his attributes, adding 2 to each. If he still doesn't have an IQ and DEX of at least 12 each, raise them to 12. Now, roll 1 die for the wizard, and 1 for yourself: whoever has the highest number can strike first. If the wizard gets to strike first, go to {14}. If you get to strike first, go to {20}."
},
{ // 27 (A-D)/5C (1-4)
"27A. You were faster than the Orc and get the first shot. In order to hit him, you will have to use magic, or a missile weapon.\n" \
"  27B. If you use magic, write down the spell name and level, and go to {113}.\n" \
"  27C. If you use a missile weapon, go to {106}.\n" \
"  27D. If you are reading this, the Orc has survived and gets a chance to strike back. Go to {134}."
},
{ // 28/5D
"With a horrible growl, and before you can switch to a close-quarters weapon, the werewolf is upon you. Take its full MR worth of hits. If this kills you or reduces your CON to 5 or less (no mercy from a lycanthrope), go to {1}. If you are still able to fight, you managed to kick it off your body for an instant and draw another weapon (if you have one). Go to {6}."
},
{ // 29/5E
#ifdef CENSORED
"Guess what! You have never murdered anyone. The Unicorn will not fight against you, but instead trots up and nuzzles you gently. If you still want to attack it, go to {145}. If you refuse to attack it, go to {186}."
#else
"Guess what! Your character is a virgin. The Unicorn will not fight against you, but instead trots up and nuzzles you gently. If you still want to attack it, go to {145}. If you refuse to attack it, go to {186}."
#endif
},
{ // 30/5F
"The Dwarf falls over, apparently dead. As you watch in disbelief, you notice that his wound is rapidly closing and that his golden crown is glowing. A minute later he sits up, smiles, and bows to you. He explains that the fight is over, and you are the winner. As a trophy, he gives you his pickaxe. (This is a 12-dice weapon[ that always strikes directly through armour, and will also deflect incoming missiles away from you unless you roll a 2 or a 3 on two dice].) Amazed and happy, you can now go to {190}."
},
{ // 31 (A-D)/6A (1-4)
"31A. Your opponent is a Human warrior. If you have fought Men previously in this Arena, you must now fight one more than you did last time. Create as many standard human characters as you have to fight, but when rolling up their attributes, roll 4 dice each time and only use the 3 highest. These men are armed with a broadsword (3 dice + 4 adds), and are wearing leather armour (takes 6 hits). They also have a target shield (takes 4 hits). Recognize them? Make a character card for each Human you must fight - you will have to refer to their attributes during the battle. Go now to {112} to figure the odds before reading on.\n" \
"  31B. Now that you have calculated the odds and placed your bets (if any), you are ready to fight. If you wish to use magic against the warrior(s), write down the spell name and the level you are casting it on, and go to {113}. If not, read on.\n" \
"  31C. If you wish to use a missile weapon against your foe, select a range and go to the paragraph indicated: pointblank ({106}); near ({87}); far ({124}); extreme ({135}). If you don't use a missile weapon, read on.\n" \
"  31D. If you would like to try and dodge for the first combat turn to see how your foe attacks, go to {129}. If you are willing to engage in hand-to-hand combat, go to {82}."
},
{ // 32/6B
"Your opponent is a 6th-level Human sorceress. She is armed with a special enchanter spear (worth 21 dice), and her flesh is so hard that it will take 20 hits without damage. Create her card as you would any normal human character, but when you've finished go back and add 15 to each of her attributes. Now, roll 1 die. If you throw a 5 or 6 you have the option of striking first; any other number lets her strike first. If you strike first, go to {107}. If she strikes first, go to {137}."
},
{ // 33/6C
"You are aiming at a huge target at near range (more than 10 yards, less than 50). Make your second level saving roll on Dexterity (25 - DEX). If you missed the saving roll, you also missed what you were aiming at; go back to the fourth part of the paragraph that sent you here. If you made the saving roll, your missile struck true. Your foe must take the full amount of hits (it may take hits on armour and tough skin, just as you can). If you have slain it, go to {190}. If it is wounded or unhurt, you just have time to grab another weapon. Go back to the fourth part of the paragraph that sent you here."
},
{ // 34/6D
"You must make your L5-SR on Luck (40 - LK). If you made it, go to {58}. If you missed it, go to {167}."
},
{ // 35/6E
"You are too large to be able to dodge the striking snake while chained to a pole, so you will have to meet it head on. Do regular T&T combat until either you are killed, which would send you to {1}, or until the reptile has been reduced to a MR of 5 or less, which would send you triumphantly to {190}."
},
{ // 36/6F
"You struck the eagle and knocked it out of the sky. Do your full weapons damage. If this has killed the eagle or reduced its MR to 5 or less, it will be unable to continue the attack, and you can go to {190}. If you haven't hurt it quite that badly, it jumps back into the air, and will come in for a second attack. Return to {122}."
},
{ // 37/6G
"If you have reduced the Balrog's MR to 50 or less, it will fall over, and you go to {190} in great triumph. If you only wounded it, go to {158} and fight on."
},
{ // 38 (A-D)/7A (1-4)
"38A. Your opponent is an Orc - one of the dreaded Death-Uruk of the Khazan guard. If you have fought Orcs before in this Arena, you must now fight one more than you did last time. Roll up the Orcish attributes, but roll four dice for Strengh and Constitution, and only roll two dice for Charisma. Each Orc is armed with a large scimitar (worth 4 dice) and carries a spiked shield (worth 2 dice) (takes 4 hits). They wear cuirasses [and helmets ](takes a total of 6 hits). They also have 3 javelins (worth 2 dice), nicely balanced for throwing. Go now to {112} to figure the odds before reading on.\n" \
"  38B. Now that you have calculated your odds and placed bets (if any), you are ready to fight. If you wish to use magic against the orc(s), write down the spell name and level, and go to {113}. If you're not using magic, read on.\n" \
"  38C. If you wish to use a missile weapon against your foe, select your range and go to that paragraph: pointblank ({106}); near ({87}); far ({124}); extreme ({135}). If you don't use a missile weapon, read on.\n" \
"  38D. If you would like to dodge and run for the first combat turn to see what kind of action your foe takes, go to {121}. If you intend to engage in hand-to-hand combat, go to {99}."
},
{ // 39/7B
"The spider was not able to bite you or get any of its venom into your bloodstream. Continue fighting - return to {125}."
},
{ // 40/7C
"Your opponent is a second level orcish warrior-wizard. He is carrying a great shamsheer (worth 5 dice), and is dressed in lizard-scale armour (takes 8 hits). Make a character card for him: for ST, CON and LK roll four dice and add 5. For IQ and DEX, roll three dice and add 4. (If the total is still less than 12 in either case, give the Orc a 12 instead.) For CHR, roll two dice. Now, roll one die for the wizard, and one for yourself. In case of ties, roll again. Whoever has the highest number has the option of striking first. If the Orc gets to strike first, go to {134}. If you get to strike first, go to {27}."
},
{ // 41/7D
"You are aiming at a huge target at far range (more than 50 yards, less than 100). Make your L3-SR on Dexterity (30 - DEX). If you missed the saving roll, you also missed your target. If you would like to try and shoot again, go to {18}. If you want to switch to another weapon, go back to the fourth part of the paragraph that sent you here.\n" \
"  If you made the saving roll, you were right on target. Your foe must take the full amount of hits that you can manage (it can take hits on armour or tough skin, just as you can). If you have slain it, go to {190}. If it still lives and you wish to shoot at it again, go to {18}. If it still lives and you'd prefer to try another weapon, go back to the fourth part of the paragraph that sent you here."
},
{ // 42/7E
"If you killed the lion or have reduced its MR to 8 or less, it falls over and you go to {190} in glory. If it is only wounded, return to {22}, and continue the struggle."
},
{ // 43/7F
"You are not skillful enough to hit an eagle on the wing - let's test your Luck. Make your L5-SR on Luck (40 - LK). If you make it, go to {59}. If you missed it, go to {48}."
},
{ // 44 (A-D)/8A (1-4)
"44A. Your opponent is an Ogre, rather a common one with only one head. It is 12' tall and as gnarled as an oak tree bole. It has three eyes and a horn on the top of its head. (If this is your second or third time here, imagine something similarly ugly). It is armed with a large knotty club (worth 9 dice), and wears a mangy old bearskin wrapped around its loins. If you have fought Ogres previously in the Arena, you must now fight one more than last time. To create your Ogre, roll 4 dice for ST and CON, and multiply each result by 2. LK and DEX are normal 3-dice rolls. IQ and CHR are 3-dice rolls, divided by 2. Go to {112} to figure your odds before reading on.\n" \
"  44B. Now that you have calculated the odds and placed your bets (if any), you are ready to fight. If you wish to use magic against this Ogre (or Ogres), write down the spell name and the level you are casting it on, and go to {113}. If you aren't using magic, read on.\n" \
"  44C. If you wish to use a missile weapon against the Ogre(s), select your range and go to that paragraph: pointblank ({18}); near ({33}); far ({41}); extreme ({47}). If you don't use a missile weapon, read on.\n" \
"  44D. If you haven't stopped the Ogre(s) already, you're in close combat. Go to {93}."
},
{ // 45 (A-D)/8B (1-4)
"45A. If you consider her too beautiful to attack, and wish to throw yourself on her mercy, go to {116}. If her beauty doesn't move you, you can only attack first by using magic or by using a missile weapon.\n" \
"  45B. If you wish to cast magic at her, write down the spell name and level, and go to {113}.\n" \
"  45C. If you intend to propel a missile at her, you can wait until she is only 10 yards away. Go to {87}.\n" \
"  45D. If you are reading this, it is her turn to get nasty. Go to {119}."
},
{ // 46/8C
"If your weapon is enchanted, it takes full effect on the Shoggoth. Compute the number of hits (include poison effects, if any) - if you have reduced the Shoggoth to a MR of 100 or less it will fall over, and you can go to {190}. If you don't have a magic weapon, but your character is a Troll or Giant, go to {189}. If neither of these apply, go to {143}."
},
{ // 47/8D
"You are aiming at a huge target at extreme range (more than 100 yards). Can your weapon really reach this far? If not, go to {41}. If so, then make your L4-SR on Dexterity (35 - DEX). If you missed the saving roll, you missed your foe. If you would like to try another shot, go to {33}. If you would prefer to switch to a hand weapon, go back to the fourth part of the paragraph that sent you here.\n" \
"  If you made the saving roll, you hit the target. Your foe must take the full amount of weapons hits (it can take hits on armour or tough skin, just as you can). If you have slain it, go to {190}. If it still lives, and you'd like to shoot at it again, go to {18}. If it still lives and you'd prefer to try another weapon, go back to the fourth part of the paragraph that sent you here."
},
{ // 48/8E
"The killer eagle strikes and knocks you to the ground. Figure its full MR worth of damage and take that many hits. If you're wearing plate armour, take only half that. If this kills you, go to {1}. If it reduces your CON to 5 or less without killing you, go to {53}. If you are not hurt badly enough to be disabled, go to {59}."
},
{ // 49 (A-D)/9A (1-4)
"49A. Your opponent is a Troll. It is nearly 15' tall, and looks like a cross between a gorilla and a boulder. If you have fought Trolls previously in this arena, now fight one more than you did last time. Arena Trolls are armed with what nature gave them: hands that can pulverize granite, and tusks that any boar would envy. On top of that, trainers have been working with the Arena Trolls, and now they are unusually adept at hand-and-claw battle. ST and CON are 40 each; LK is 14; DEX is 12; IQ is 8; and CHR is 5. Each hand is worth 6 dice in combat (for a total of 12 dice + 30 adds), and its tough skin will take the first 5 hits each combat round without any damage to CON. Go now to {112} to figure your odds before reading on.\n" \
"  49B. Now that you have calculated the odds and placed your bets (if any), you are ready to fight. If you wish to use magic against the Troll(s), write down the spell name and level and go to {113}. If not, read on.\n" \
"  49C. If you wish to use a missile weapon against the Troll(s), select your range and go to that paragraph: pointblank ({18}); near ({33}); far ({41}); extreme far ({47}). If you don't use a missile weapon, read on.\n" \
"  49D. If you would like to try a strategy of hit-and-run against the Troll(s) by dodging for the first combat round, go to {131}. If you're brave enough to engage it fairly in regular T&T combat, go to {105}."
},
{ // 50 (A-D)/9B (1-4)
"50A. In order to strike first you will need magic or a missile weapon.\n" \
"  50B. If you use magic, write down the name and level of your spell and go to {113}. If not, read on.\n" \
"  50C. If you wish to use a missile weapon, fire and go immediately to {76}.\n" \
"  50D. If you can use neither magic nor missiles, you draw your weapon and charge. Go to {96}."
},
{ // 51/9C
"You opponent is a third level Elvish wizard. She is dressed in a robe of woven silver, enchanted to take up to 7 hits in combat each turn. She is armed only with a great staff of elm-wood. Roll up an Elf on the Peters-McAllister chart on p. 8 and add 5 points to each attribute. Now, roll one die for the witch, and one for yourself. Whoever has the highest number has the option of striking first. If you get to strike first, go to {45}. If she gets to strike first, go to {119}."
},
{ // 52/9D
"If you have been killed or reduced to a CON of 5 or less, then the lion is the victor. Go to {1}. If you have killed the lion, or reduced it to a CON of 8 or less, then you are the victor. Go to {190}. If neither of these things has happened, the fight continues. Go back to {22}."
},
{ // 53/9E
"Arena guards drive the eagle off in time to save your life, and drag you back in off the sands. You have been defeated, but you have a chance to live. Go to {144}."
},
{ // 54/9F
"The crocodile surfaced a bit too soon - and you've spotted it. If you wish to carry the attack to it, go to {66}. If you wish to wait for it to attack you, go to {95}."
},
{ // 55/10A
"You will have to fight with one or more wild Beasts. Roll one die, and look on the chart below to see which animal you must fight, and what its Monster Rating is. If you've already fought this type of creature, you will have to fight one more than last time. Remember that fighting two Beasts is twice as hard as fighting one Beast (in terms of saving rolls, missiles and magic), and that fighting three Beasts is three times as hard.[ (It is suggested that each time you fight a given Beast, place a small pencil mark by its name in the table below. You will always have to fight one more creature than there are marks by its name. When using a new character, erase the marks or use a different sign to keep track.)]\n" \
"  Die Roll  Beast                    Monster Rating            Go to\n" \
"  1         Cave Lion                 80 ( 9 dice +  40 adds)  {62}\n" \
"  2         Giant constrictor snake   50 ( 6 dice +  25 adds)  {68}\n" \
"  3         a very big Eagle          50 ( 6 dice +  25 adds)  {72}\n" \
"  4         Crocodile                 30 ( 4 dice +  15 adds)  {85}\n" \
"  5         Elephant                 200 (21 dice + 100 adds)  {89}\n" \
"  6         Carnivorous Great Ape    100 (11 dice +  50 adds)  {100}"
},
{ // 56 (A-D)/10B (1-4)
"56A. Your foe is a manticore. If has been strutting around the Arena accepting the cheers of the crowd before you came out, but the squeak of your Arena gate alerted it. As you walk onto the sand it comes bounding towards you with great leonine leaps. It has the body of a very large lion, but the face of a man. Where the tail should be is a huge scorpion-like stinger. And it is howling with a sound that makes your blood curdle in the veins.\n" \
"  56B. If you wish to use magic against the manticore, write down the spell name and level, and go to {113}. If not, read on.\n" \
"  56C. If you wish to use a missile weapon, choose your range and go to that paragraph: pointblank ({106}); near ({87}); far ({124}); extreme ({135}).\n" \
"  56D. If you would prefer to meet the manticore in close combat, go to {160}."
},
{ // 57 (A-D)/10C (1-4)
"57A. You must fight a unicorn - no sad-eyed gentle beast this, but a creature half as big again as a horse and armed with a long spiral horn that could punch through steel plate. If your character is a human, go immediately to {133}. If you belong to any other kindred, read on.\n" \
"  57B. When the Unicorn scents you in the Arena, it rears and whinnies - a whinny that sounds almost like a roar. When its forefeet touch soil again it begins to gallop towards you. If you wish to use magic against it, write down the spell name and level and go to {113}. If you don't use magic, read on.\n" \
"  57C. If you wish to use a missile weapon, choose your range and go to that paragraph: pointblank ({106}); near ({87}); far ({124}); extreme ({135}).\n" \
"  57D. If you'd prefer to fight it in close combat, go to {182}."
},
{ // 58/10D
"You have lost your primary weapon, but you managed to draw any secondary weapon you may be carrying. Go back to {22} and continue the battle. (Your previous weapon has been destroyed.)"
},
{ // 59/10E
"Make your L3-SR on Luck (30 - LK). If you make it, you escaped with a few scratches. Go to {80}. If you missed it, go to {70}."
},
{ // 60/10F
"The saurian got close enough to lash out with its tail and has struck you in the legs. Take its full MR in hits. If this reduces your CON to 5 or less, you've been killed or disabled, and you're its next meal. Go to {1}. If you are only wounded, you're down with a broken leg. Go to {97}."
},
{ // 61/11A
"Your opponent is a Wizard or Warrior-Wizard. If you have fought Wizards previously in this Arena, you do not have to fight one more than last time. Not even Lerotra'hh is that cruel. Roll one die and refer to the table below. Before going to the indicated paragraphs in the table, stop at {112} to calculate your odds, and then continue on from there to your magical confrontation.\n" \
"    Die Roll    Level of Foe    Go to\n" \
"    1           first           26\n" \
"    2           second          40\n" \
"    3           third           51\n" \
"    4           fourth          101\n" \
"    5           fifth           165\n" \
"    6           sixth           32"
},
{ // 62 (A-D)/11B (1-4)
"62A. You must fight a monstrous, golden-maned cave lion, 8' high at the shoulder and 12' long. When you enter the arena it bounds towards you from the other side. Go to {112} to determine your odds before reading on.\n" \
"  62B. If you want to use magic against it, write down the spell name and level, and go to {113}.\n" \
"  62C. If you wish to use a missile weapon against it, choose your range and go to that paragraph: pointblank ({18}); near ({33}); far ({41}); extreme ({47}).\n" \
"  62D. If you are reading this, the cave lion has reached you and you must meet it with whatever you have in hand. Go to {108}."
},
{ // 63/11C
"The Gremlin sees you shoot, and throws its spear at you - but you dodge nimbly to the side and it misses. However, it charges madly at you - there's no time for missiles or magic. Go to {75}."
},
{ // 64 (A-D)/11D (1-4)
"64A. Your foe is apparently a strange hybrid of wolf and man. It crouches on the far side of the Arena, and gives an eerie howl. It is dusk, and a large full moon is rising. Horrified, you watch as the creature becomes more and more bestial, though it seems to retain a manlike form. With a final howl, it lopes towards you.\n" \
"  64B. If you want to use magic against it, write down the spell name and level, and go to {113}. If you don't use magic, read on.\n" \
"  64C. If you want to shoot at it, make your L4-SR on Dexterity (35 - DEX). If you made the roll, your aim was true; go to {151}. If you missed the roll, you missed your target; go to {28}."
"  64D. If you are reading this, you are fighting at close quarters with the beast. Go to {6}."
},
{ // 65/11E
"You struck the diving raptor a glancing blow. [Divide your weapons hits by 3 (round up); ]the eagle must take that many hits. Now, roll one die and take that number of hits on your CON, regardless of your armour protection. If you have killed the eagle with your hits, then you win and can go to {190}. If its hits have slain you, go to {1}. If it has reduced your CON to 5 or less, go to {53}. If both of you can continue the fight, the eagle will wheel back into the sky to attack again. Go to {80}."
},
{ // 66/11F
"You leap to the attack. If you have killed it after one turn of regular T&T combat, you may climb out of the pit and into {190}. However, if it kills you, or reduces your CON to 5 or less, it has snapped you up as lunch and you must go to {1}. If you wound it, but don't kill it, go to {103}. If it wounds you without killing or disabling you, go to {109}."
},
{ // 67 (A-B)/12A (1-2)
"67A. Your opponent is a bona fide monster, of the type generally regarded as mythical. Don't be deceived, however - they're real. Monsters are seldom slain in the Khazan Arena because they're extremely difficult to replace, and it's tough to train them to fight nicely on command against the gladiator instead of turning on the audience. If you reduce a monster to 1/10 of its Monster Rating, the fight will automatically be stopped, and you will be declared winner - if you are still conscious. If your [ST or ]CON falls to 5 or less, however, you are unconscious, and there is no way to keep the hungry monster from destroying and devouring your senseless carcass. Go to {112} to figure your odds before reading on.\n" \
"  67B. Now that you have calculated the odds, you are ready for combat. Hopeless, isn't it? Roll one die, refer to the chart below, and go to the indicated paragraph. If you have previously fought and defeated one of these monster types and you are called upon to go against the same type again, double its MR the second time around. (The city wizards have enlarged it to give you more of a challenge.)\n" \
"    Die Roll    Monster         Monster Rating                Go to\n" \
"    1           Giant Spider    50 (6 dice + 25 adds)         {10}\n" \
"    2*          Balrog          500 (51 dice + 250 adds)      {21}\n" \
"    3           Manticore       250 (26 dice + 125 adds)      {56}\n" \
"    4           Unicorn         200 (21 dice + 100 adds)      {57}\n" \
"    5*          Werewolf        150 (16 dice + 75 adds)       {64}\n" \
"    6           Shoggoth        1000 (101 dice + 500 adds)    {91}\n" \
"(* indicates the monster may only be wounded or slain with an enchanted weapon.)"
},
{ // 68 (A-D)/12B (1-4)
"68A. You must fight an enormous snake. To prevent you from fleeing, you have been shackled to a post in the centre of the Arena with 15' of heavy chain. The serpent is at least 30' long, and could swallow you in one bit. It slithers rapidly towards you. Go to {112} to figure your odds before reading on.\n" \
"  68B. If you wish to use magic against the snake, write down the spell name and the level you are casting it on, and go to {113}.\n" \
"  68C. If you wish to use a missile weapon, pick your range and go to that paragraph: pointblank ({106}); near ({87}); far ({124}); extreme far ({135}).\n" \
"  68D. You are in close combat with the giant reptile. Go to {23}."
},
{ // 69/12C
"The Gremlin sees that you were preparing to shoot at it, and throws its spear at you first. You try to dodge and fail. The spear has struck you, doing 3 dice worth of damage. If this wound has killed you, go to {1}. If it has reduced your CON to 5 or less without killing you, go to {2}. If you were not hurt that badly, yank the spear out and go to {75}."
},
{ // 70/12D
"You lost an eye - permanently. Roll 1 die. If you roll an odd number, it is the left eye - roll an even number and you've lost your right eye. Go to {80}."
},
{ // 71/13A
"You've heard of the glory and wealth to be won fighting as a Khazan gladiator, and you've just signed a contract with the Arena management to fight at least 3 combat turns against anything they throw against you. You agree to accept whatever rewards they may offer you for your victories, and to pay any debts you incur before you can leave the Arena.\n" \
"  You are permitted to use your own weapons, whether they be normal or magical, and to wear your own armour. If you don't have any equipment, for your first fight the management will loan you a broadsword (worth 3 dice + 4 adds) (requires a ST of 15 or you will tire as you use it, and lose the difference in ST each combat turn). [If you are a rogue or a wizard ]you may cast spells, but be warned: the only truly reliable ones are those which only affect yourself and your belongings! If you're thinking of being tricky, Khara Khang and his staff of lesser wizards may negate your other spells. If you have no magical powers of your own (and even if you do), it is possible to buy certain magicks from the Arena Wizards before you learn what your opponent will be.\n" \
"  If you wish to buy magic for your combat, and have more than 50 gold pieces to spend, go to {155}. If you don't wish to purchase any enchantments, then the sun is bright, the sand is hot, the crowd is in a good mood - it is a fine day to die. Roll 2 dice. If you roll a 2, go to {7A}, 3 go to {13A}, 4 go to {19A}, 5 go to {25A}, 6 go to {31A}, 7 go to {38A}, 8 go to {44A}, 9 go to {49A}, 10 go to {55}, 11 go to {61}, 12 go to {67A}."
},
{ // 72 (A-D)/13B (1-4)
"72A. You must fight a giant eagle that has been trained to dive and attack. Moreover, its talons have been poisoned with a venom that causes paralysis in 4 minutes (2 combat turns) if it enters your bloodstream. Go to {112} to get your odds before reading on.\n" \
"  72B. If you wish to use magic, write down the spell name and level and go to {113}. If you don't use magic, read on.\n" \
"  72C. If you wish to use a missile weapon against it, you will find that shooting even a giant eagle on the wing is no easy task. The eagle's swift movement makes it as difficult to hit as shooting something at extreme range. Go to {135} to see whether you hit the big bird or not.\n" \
"  72D. You are now fighting at close quarters with the beast. Go to {122}."
},
{ // 73/13C
"You successfully dodged the Unicorn's charge and hit it with your own weapons. It must take full weapons damage. If you reduce its MR to 20 or less, it will fall over, and you go triumphantly to {190}. If you only wounded it, go back to {182} and continue fighting."
},
{ // 74/13D
"It's down to hand strokes. She fights with a great elm-wood staff (worth 2 dice + her adds). You may use whatever hand weapon you have, plus your adds. If you kill or disable her (reduce her CON to 5 or less), go to {190}. If she kills you, go to {1}. If she disables you, go to {2}."
},
{ // 75/13E
"The Gremlin leaps on you and grapples, stabbing repeatedly with his dagger (2 dice + 1 add). You're unable to fight with magic, missile weapons, or any other weapon larger than a dagger. Use a knife if you have one, or fight with your hands (worth 1 die total). Fight until one of you is slain or reduced to a CON of less than 5. If you slay or defeat it, go to {190}. If it kills you, go to {1}. If it defeats you without killing you, go to {2}. Keep fighting until one of these results has been achieved and keep track of how many combat turns it takes to accomplish it."
},
{ // 76/13F
"The Dwarf whirls his pickaxe as a shield before him. Roll 2 dice. If you get a 2 or 3, your missile gets through. This Dwarf has a CON of only 1, so you have killed him; go to {30}. If you didn't roll a 2 or 3, he deflected your shot and rushed upon you with a loud war-cry. Go to {96}."
},
{ // 77/14A
"You have been captured by the slavers of Khazan. All money, weapons, armour, and personal belongings have been taken from you. While the slavers are trying to decide whether to sell you to the Dragon Fire Mines, or to the galleys, or to a certain female Ogre they know, a recruiter from the Arena comes by and asks if you'd like a chance to live. (It's all a set-up.)\n" \
"  A few days later you find yourself in a cell in the catacombs beneath the Khazan Kholiseum, keeping company with the other scum of the earth who comprise the lowest gladiatorial class. You have been told that if you win 3 combats, you gain your freedom plus all the rewards accumulated for winning. You know that all you really are is so much sword fodder for the big-name stars of the Arena - still, you're determined not to go down without a fight. The management doesn't want you to die too easily, so if you are a warrior or a rogue they arm you with a broadsword (3 dice + 4 adds) and leather armour (takes 6 hits). If you're a wizard, they give you the leather armour and a sax (2 dice + 5 adds). Of course, this is just a loan, to be paid for at the going rate for weapons and armour (see the T&T rules), as soon as you win any prize money.\n" \
"  Outside, you can hear the crowd roaring for blood. They just dragged a man back into the catacombs in 3 pieces - poor fellow had to go up against a Troll. And now it's your turn. Roll 2 dice. If you roll a 2, go to {7A}, 3 go to {13A}, 4 go to {19A}, 5 go to {25A}, 6 go to {31A}, 7 go to {38A}, 8 go to {44A}, 9 go to {49A}, 10 go to {55}, 11 go to {61}, 12 go to {67A}."
},
{ // 78/14B
"You are aiming at a small target at pointblank range (less than 5 yards). Make your L3-SR on Dexterity (30 - DEX). If you missed the saving roll, you also missed your foe. You must take all the hits it can dish out in one combat round. If this kills you, go to {1}. If it reduces your CON to 5 or less and your foe is not a Beast, go to {2}. If your foe is a Beast, it will finish the job before you can be rescued; go to {1}. If you were able to take the hits on armour, or were only wounded but could keep fighting, go to the fourth section of the paragraph that sent you here.\n" \
"  If you made the saving roll, your aim was true. Your foe must take the full amount of hits for your weapon plus adds (it may take them on armour or tough skin, just as you can). If you have slain it, go to {190}. If you have only wounded it, it will move to hand-to-hand combat. Drop your missile weapon and draw another, and go to the fourth part of the paragraph that sent you here."
},
{ // 79/14C
"You successfully dodged the snake's strike, which allows you to inflict full weapons damage on it without suffering any harm yourself. If you have killed it or reduced its MR to 12 or less, it falls over and you go triumphantly to {190}. If you have only wounded it, it will recover its poise and strike again. Return to {23}."
},
{ // 80/14D
"You have been wounded by the Eagle - and its talons are poisoned. If this is the second time you are reading this, your time just ran out, and you are no longer able to move. Go to {84}. If this is only the first time you have read this paragraph, you have 1 combat turn left in which to win, or else you die. Return to {122}."
},
{ // 81/14E
"You are in a hand-to-hand struggle with one or more Hobbits. Their method of fighting is to get in close and hack with their flensing knives[, which makes it impossible to use long weapons against them]. [You may use a knife if you have one, or your hands (1 die + your adds). ]Each combat turn, make a first level saving roll on Luck (20 - LK). If you miss it, take the difference off your CON for lucky slashes landed by a Hobbit. Continue to fight in this manner until you have slain or disabled your foe (go to {190}), or it has slain you (go to {1}) or it has reduced your CON to 5 or less (go to {2}). Saving rolls are inflicted in addition to, or regardless of, regular combat results hits."
},
{ // 82/15A
"The Man comes in low behind his shield. Make your L1-SR on IQ (20 - IQ). If you missed the saving roll, your foe finds a weakness in your guard, causes you to trip and gets 1 free combat turn (you can't defend yourself). If this kills you, go to {1}. If you are only wounded, or remain unhurt, go to {152}. If you made the saving roll, your form is impeccable and the fight will move to regular T&T combat. Go to {152}."
},
{ // 83/15B
"You have just enough time to get off one more shot at close range. Make your L3-SR on Dexterity (30 - DEX). If you made the saving roll, you hit the foe and it must take full weapons damage. If you have slain it (and it was alone), go to {190}. If one or more foes still live, drop the missile weapon and go to {81}. If you missed the saving roll, you also missed your foe, and quickly find yourself in desperate hand-to-hand combat. Go to {81}."
},
{ // 84/15C
"The poison has had enough time to take effect. You fall over paralyzed. You are still aware as the eagle lands and begins to feast upon your face, but you know only relief when an Arena guard comes out and gives you the coup de grace. Go to {1}."
},
{ // 85 (A-D)/15D (1-4)
"85A. Your foe is a hungry crocodile. In order to give the crocodile a fair chance against you, you have been chained to a pole in the centre of the Arena, in a small pit about 30' in diameter. The pit has been flooded to a depth of 2' so the saurian will be in its own element. Go to {112} to figure your odds before reading on.\n" \
"  85B. If you wish to use magic against the crocodile, write down the name and level number of your spell and go to {113}. If you don't use magic, read on.\n" \
"  85C. You can see the crocodile waddling across the Arena sand before it ever gets to the pit. Because only the head may be used as a target for effective missile fire, it will be considered a small target. Choose your range and go to that paragraph: pointblank ({78}); near ({94}); far ({102}); extreme far ({104}).\n" \
"  85D. If you are reading this, you are in close combat with the reptile. Go to {138}."
},
{ // 86/15E
"The Balrog fights with its flame whip and has a Monster Rating of 500 (gets 51 dice + 250 adds). You fight with your best weapon. If the Balrog kills you, go to {1}. If you kill the Balrog, or reduce it to a MR of 50 or less, go to {190}.[ If the magic wears off your weapon before the Balrog is defeated, the weapon will break, and unless you can switch to another enchanted weapon you must fight weaponless (1 die plus your adds).]"
},
{ // 87/15F
"You are aiming at a large target at near range (more than 10 yards, less than 50). Make your L4-SR on Dexterity (35 - DEX). If you missed the saving roll, you also missed the foe; go back to the fourth part of the paragraph that sent you here and keep fighting with other weapons. If you made the saving roll, you were right on target. Your foe must take the full amount of hits for your weapon plus adds (it may take them on armour or tough skin, just as you can). If you have slain it, go to {190}. If it is only wounded or unhurt, you just have time to grab a non-missile weapon before it is upon you. Go back to the fourth part of the paragraph that sent you here."
},
{ // 88/16A
"A maddened Dwarf with a great axe is hard to beat. Choose your LK or DEX - whichever is higher - to make saving rolls on. There is no time to cast spells. Pick a regular hand weapon and fight. Every time you throw the dice for yourself and the Dwarf, one combat turn passes. Compute and distribute hits in the regular fashion. Make your L1-SR on your chosen attribute - if you miss the roll, take the difference in hits, regardless. On the second combat turn make a L2-SR (25 - attribute); on the third combat turn make a L3-SR (30 - attribute), and so on, for as long as the combat lasts. If at any time you kill or disable all your foes, break off the combat and go to {190}. If the Dwarf should slay you, go to {1}; if your CON falls to 5 or less you're disabled, go to {2}."
},
{ // 89 (A-D)/16B (1-4)
"89A. Your foe is a rogue bull elephant trained to kill. It has a MR of 200 (21 dice + 100 adds), and its thick hide will take 10 weapons hits (like armour) before the MR begins to drop. The ponderous pachyderm plunges perilously near as you watch in dismay. Go to {112} to get your odds before reading on.\n" \
"  89B. If you wish to use magic against the elephant, write down the spell name and level; go to {113}. If not, read on.\n" \
"  89C. If you wish to use a missile weapon against the elephant, choose your range and go to that paragraph: pointblank ({18}); near ({33}); far ({41}); extreme ({47}).\n" \
"  89D. If you are reading this, you are in close combat with the mighty Beast. Go to {149}."
},
{ // 90/16C
"The elephant catches you in its trunk and swings you wildly around, finally releasing you to fly like an arrow into the Arena wall, which you split with your head. If your CON is 5000 or greater, go to {169}. If not, your cranium resembles a squashed tomato. Go to {1}."
},
{ // 91 (A-D)/16D (1-4)
"91A. You're up against a Shoggoth, a giant humanoid creature whose body is covered with what looks like hundreds of living ropes. Its feet are elephantine, and its legs are thick and heavy. It is about 30' tall and doesn't seem to have a face - but it knows where you are because it comes shambling in your direction. Figure your odds by going to {112}, if you haven't done so already. Then read on.\n" \
"  91B. If you wish to use magic against it, write down your spell name and level and go to {113}. If not, read on.\n" \
"  91C. If you use a missile weapon, make your L2-SR on Dexterity (25 - DEX). If you made the saving roll, you hit it. Go to {46}. If you missed the roll, you missed the Shoggoth. Read on.\n" \
"  91D. Like it or not, you are fighting at close quarters with a Shoggoth. Make your L5-SR on IQ (40 - IQ). If you make it, go to {8}. If you miss it, fight the thing with whatever you have. Go to {183}."
},
{ // 92/16E
"The serpent hits you, doing its full MR worth of damage. You may take some of the hits on armour if you have any. Your weapon has been knocked out of your hand and is out of reach, but you did 1 die worth of damage to the snake. Check these things in this order: If the hits you just took have reduced your CON to 5 or less, the giant anaconda coils around you and breaks your bones like toothpicks. It will then ingest you (armour and all). Go to {1}. If you are wounded but your CON is still greater than 5, and your 1 die of damage reduced the snake to a MR of 12 or less, then you win. Go to {190}. If both you and the snake can keep fighting, grab your secondary weapon if you have one. The snake will try to strike again. Return to {23}."
},
{ // 93/17A
"The Ogre comes on strong, and comes in swinging. No normal human arm or armour could withstand the powerhouse blows of its club. (If your character is Ogre, Troll or Giant, disregard the following instructions and conduct regular T&T combat.)\n" \
"  Count the combat turns as you go through them. Before each combat turn, make a saving roll on Luck at the same level as the number of the combat turn. If you make the saving roll, the Ogre misses you entirely and you take no hits, and can apply your full hit total to the Ogre. If you miss the saving roll, you must take in hits the difference between your combat total and the Ogre's total, or the number you missed your saving roll by - whichever number is greater. Also, if you missed the saving roll, you won't get hits on the Ogre unless your combat roll exceeded its. (As you can see, you had better kill it quickly or you won't kill it at all). Continue fighting until either you or the Ogre has been vanquished. If you kill or disable it, go to {190}. If it kills you, go to {1}; if it disables you, go to {2}."
},
{ // 94/17B
"You are aiming at a small target at near range (more than 50). Make your L6-SR on Dexterity (45 - DEX). If you missed the saving roll, you also missed your foe - return to the fourth part of the paragraph that sent you here. If you made the saving roll, you were right on target. Your foe must take the full amount of hits for your weapon plus adds (it can take them on armour or tough skin). If you have slain it, go to {190}. If you have only wounded it, or if it is unhurt, you have just enough time to grab a non-missile weapon. Go back to the fourth part of the paragraph that sent you here."
},
{ // 95/17C
"You see the tail lashing at you and you only have time to jump. If you are wearing any form of armour, make a L4-SR on Strength (35 - ST). If you are not wearing armour, you'll need only a L2-SR on Strength (25 - ST). If you make the saving roll, go to {118}. If you miss it, go to {60}."
},
{ // 96/17D
"Boron the Dwarf Warrior-Wizard has an enchanted pickaxe worth 12 dice in combat. He himself gets 12 dice + 15 adds. You get whatever you can muster in time to meet his charge. [If he gets any hits on you in combat, take them directly off your CON, as his pick will punch neat little holes right through any armour (even enchanted armour) you may be wearing. ]Keep fighting as long as he is winning. If he kills you, go to {1}. If he reduces your CON to 5 or less, go to {2}. But, if on any combat turn you get any hits at all on your foe, go to {30}."
},
{ // 97/17E
"The crocodile now rushes on you with jaws open wide. Engage it in regular T&T combat[, but divide your number of hits by 2 if you have taken hits]. If you kill it or reduce its MR to 7 or less, you are the victor and can go to {190}. If it kills you or reduces your CON to 5 or less, it wins and gets a free snack. Go to {1}. If neither of you is defeated in the combat turn above, roll 1 die and subtract that number from your Strength. Now return to the beginning of this paragraph and run through it again, unless your Strength has fallen to 5 or less, in which case you can pass out and the crocodile wins - go to {1}."
},
{ // 98/17F
"You are stronger than the ape, and it realizes it. It releases its grip, takes the bananas, and shambles away from you at high speed back to its cage. It ain't dumb. This counts as a victory even though the crowd is hissing and booing. Go to {190}."
},
{ // 99/18A
"You have come to hand blows with an Orc. Agility is very important. At the beginning of each combat turn, make L2-SRs on Dexterity (25 - DEX) for both yourself and your foe. If you miss your saving roll, you must take the difference you missed it by in hits off your CON (not armour). The same goes for the Orc if it misses the saving roll. Fight in the normal T&T method until one or the other has been defeated. Each throw of the dice represents one combat turn. If you slay or disable the Orc, go to {190}. If the Orc slays you, go to {1}; if it disables you, go to {2}."
},
{ // 100 (A-D)/18B (1-4)
"100A. You are up against a giant carnivorous ape, about twice as big as a mountain gorilla and many times meaner, with 6\" fangs and dirty fingernails. If you wish to use bananas against it, go to {4}. Otherwise, go to {112} to figure your odds before reading on.\n" \
"  100B. If you want to use magic against the ape, write down the spell name and level and go to {113}. Otherwise read on.\n" \
"  100C. If you use a missile weapon against it, choose your range and go to that paragraph: pointblank ({18}); near ({33}); far ({41}); extreme ({47}).\n" \
"  100D. If you are reading this, you are in close combat with the ape. Go to {159}."
},
{ // 101/18C
"Your opponent is a fourth level Dwarvish warrior-wizard. He is dressed as a common Dwarf without any armour. however, it seems odd that he should be carrying a pickaxe and wearing a golden crown set with emeralds (value: 6000 gp). Roll 2 dice for yourself and 3 dice for the Dwarf. Whoever throws the highest total has the option of striking first. If you get to strike first, go to {50}. If he gets to strike first, go to {96}."
},
{ // 102/18D
"You are aiming at a small target at far range (more than 50 yards, less than 100). Make your L9-SR on Dexterity (60 - DEX). If you missed the saving roll, you also missed your foe. If you would like to try and shoot again, go to {78}. If you want to switch to a non-missile weapon, go back to the fourth part of the paragraph that sent you here. If you made the saving roll, your marksmanship is incredible and you hit it. Your foe must take the full amount of hits that you can manage (it may take them on armour or tough skin if it has any, just as you can). If you have slain it, go to {190}. If it is unhurt, or only wounded, and you wish to shoot at it again, go to {78}. If it still lives and you'd prefer to try another weapon, go back to the fourth part of the paragraph that sent you here."
},
{ // 103/18E
"Continue combat in regular T&T style. If you kill it or reduce the croc to a MR of 7 or less, go to {190} in victory. If it kills you or reduces you CON to 5 or less, it gets a meal, and you go to {1}. Keep on fighting until one of you is defeated."
},
{ // 104/18F
"You are aiming at a small target at extreme range (more than 100 yards). Can your weapon really reach this far? If not, go to {102}. If so, then make your L12-SR on Dexterity (75 - DEX). If you missed the saving roll, you also missed your foe. If you would like to try another shot, go to {94}. If you would prefer to switch to a non-missile weapon, go back to the fourth part of the paragraph that sent you here.\n" \
"  If you made the saving roll, it was one of the most amazing shots that has ever been seen in the Arena. Take 250 adventure points for fantastic shooting. Your foe must take the full amount of hits for your weapon plus adds (it may take them on armour or tough skin if it has any, just as you can). If you have slain it, go to {190}. If it still lives, and you wish to shoot at it again, go to {78} as it will close very rapidly on you in desperation. If it still lives and you'd prefer to try a non-missile weapon, return to the fourth part of the paragraph that sent you here."
},
{ // 105/19A
"If your character is an Ogre, Troll, Giant, or any other form of a non-humanoid Beast or Monster, disregard the rest of the paragraph and fight by regular T&T rules. If you kill your enemy, go to {190}. If it kills you, go to {1}. If it reduces your CON to 5 or less, go to {2}.\n" \
"  If you are a normal-sized humanoid you find yourself in the path of a charging Troll. Fortunately, it is a bit slow. Unfortunately, it does not tire, but you will. You will be able to do full weapons damage to the Troll as long as you can make progressively higher saving rolls on Constitution. (Start with a L1-SR (20 - CON) on the first combat turn. If you make the saving roll, the Troll gets no hits on you. Make a L2-SR (25 - CON) for the second combat turn, and so forth). If you miss any saving roll, you will have to do regular T&T combat for that round. If you kill the Troll, go to {190}. If it kills you, go to {1}. If it disables you, it will kill you on the next round - Trolls don't believe in rules. Continue fighting until you win or are killed."
},
{ // 106/19B
"You are aiming at a large target at pointblank range (less than 5 yards). Make your L2-SR on Dexterity (25 - DEX). If you missed the saving roll, you also missed your foe. You must take all the hits it can dish out in one combat round. If this kills you, go to {1}. If this reduces your CON to 5 or less and your foe is not a Beast or a Monster, go to {2}. If you're fighting a Beast or a Monster, it will finish you off (you're unconscious and can't fight back) before you can be rescued. If you were able to take the hits on armour, or were only wounded but could keep fighting, return to the fourth part of the paragraph that sent you here.\n" \
"  If you made the saving roll, your aim was true. Your foe must take the full amount of hits for your weapon plus adds (it may take them on armour or tough skin if it has any, just as you can). If you have slain it, go to {190}. If you have only wounded it, it will move to hand-to-hand combat. Drop your missile weapon and draw a hand weapon. Go to the fourth part of the paragraph that sent you here."
},
{ // 107 (A-D)/19C (1-4)
"107A. If you are so impressed by her beauty that you will throw yourself on her mercy and not attack her, go to {15}. But, if you wish to attack first, you must use either magic or missiles.\n" \
"  107B. If you want to use magic, write down the spell name and level and go to {113}. If not, read on.\n" \
"  107C. If you wish to use a missile weapon against her, go to {87}.\n" \
"  107D. If you're reading this, you're in deep trouble. Go to {137}."
},
{ // 108/19D
"The lion covers the last 20' between you in one great bound. If you wish to stand and meet it head to head, go to {5}. If you'd prefer to try and dodge it while striking with your weapons, go to {22}."
},
{ // 109/19E
"You've been knocked down and hurt, which helps the saurian in its continuing attack. Go to {97}."
},
{ // 110/19F
"The ape rips your arm completely out of the socket. Take 100 hits on the spot. If this kills you, go to {1}. If you are still alive, go to {123}."
},
{ // 111/19G
"There are weak points in even the best of armour. If you are wearing a complete set of metallic armour, make a L2-SR on Luck (25 - LK). If you are wearing a complete set of leather or silken armour, make a L3-SR on Luck (30 - LK). If you are not wearing any armour, or have only partial armour (back-and-breast, for example), then make a L4-SR on Luck (35 - LK). If you make the roll, go to {39}. If you miss, go to {141}."
},
{ // 112/20A
"`DETERMINING THE ODDS AGAINST YOUR CHARACTER FOR A FIGHT\n" \
"  Before each combat you must determine the odds against (or for) your victory. This represents the official odds on your match which are being offered the bettors in the seats. It is also used to determine how great a prize you should get if you win the fight.\n" \
"  Odds are expressed as a ratio of two numbers, A to Y, where A stands for the Arena and Y for You. This can be written as a ratio (A:Y) or as a fraction (A/Y). If A is larger than Y, the odds are against you; if Y is the larger number, the odds are in your favour.\n" \
"  In the lists, below, you may not need every step for every fight. Just use the pertinent ones for your circumstances. Keep the figures for A and Y separate, but written down as you go through the lists here.\n\n" \
"TO DETERMINE 'A'\n" \
"  1. Use a poly-die or a deck of cards and randomize between 1 and 10. This is the basic number. (Example: you've rolled a 5. Stick with me, and it'll be all clear...)\n" \
"  2. Add to A the number of *extra opponents* you must fight. (Ex: You are fighting 3 dwarves. That is 2 more than usual, so add 2 to A.)\n" \
"  3. If you're fighting Trolls, Giants, or any Animal (not Monster) with a rating above 100, then multiply A times 2.\n" \
"  4. If you're facing any of the Wizards, add 1 to A for each level the sorcerer has attained. (Ex: fighting the fourth level wizard, you must add 4 to A.)\n" \
"  5. If you are facing any of the Monster class, multiply A times 3.\n" \
"  6. If you own character is a Hobbit, Gremlin, Leprechaun, [or any animal or monster with a Monster Rating of 50 or less, ]multiply A times 2.\n\n" \
"TO DETERMINE 'Y'\n" \
"  1. Your basic value for Y *will always start at 1*.\n" \
"  2. Multiply Y times the number of fights you have *already won*. If you have not won a fight (or even fought a fight yet), skip this step and *do not* multiply times 0. (Ex: If you have fought 5 times, and won 4 times, multiply Y times 4 = 4).\n" \
"  3. If you are facing Gremlins, Hobbits, or any Animal (not Monster) with a MR of 50 or less, multiply Y times 2.\n" \
"  4. If you are a wizard or warrior-wizard, add your *level number* to Y. (Ex: a third-level wizard must add 3 to Y.)\n" \
"  5. If you are a Troll, Giant, [or Beast with a MR more than 100, ]multiply Y times 2.\n" \
"  6. If you are a Balrog, Demon, Naga, Lamia, Centaur, or any other non-human character from the monster-creation tables, multiply Y times 3. (If you are not certain whether you fall into this class, then you probably do. So multiply times 3.)\n\n" \
"Now you have numbers for both A and Y. Put these two numbers together as 'A:Y' and reduce the fraction to its lowest common denominator. Let's say you eventually got odds of 5:2. In terms of betting and money, this means that for every 2 pieces gold you bet on yourself, the Arena will pay you 5 gold *if you win*. (If you don't win, but still live, you'll pay 2 gold pieces to the people who put down the 5.)\n" \
"  NOTE: The odds do not always reduce to something simple like '2:1' - they will often be improper fractions like 5:2, 9:4, 13:15. In terms of winning prizes, cut Y to 1 (regardless of what this does to A) and you should get some idea of what your odds are, relative to the prize-odds. In the examples just given, 5:2 is a 2½:1 against you, 9:4 is 2:1 against you, and 13:15 is a little bit more than 1:1 for you.\n" \
"  ~*You can bet on yourself in the arena, but importantly: You are never allowed to bet more than 1000 gold pieces!* This is the easiest way to make extra cash in the arena - if you lose, you will probably be dead. If you do wager on yourself, you must write down how much you want to wager, and at what odds. If you lose the fight and survive, your money is gone. If you win, you keep your money as well as the odds payoff. Do not give yourself experience points for prize money or money won in betting.\n" \
"  Return now to the second part of the paragraph that sent you here, and keep reading."
},
{ // 113 (A-G)/20B (1-7)
"113A. Find the code for your spell on the list below. Note that 'Other' includes all other possible spells. The spellcaster loses Strength for trying to cast the forbidden spell, and Khara Khang and his merry minions negate it instantly - there is no effect except Strength loss when casting a spell in the 'Other' category.\n" \
"  Possible spells are:\n" \
"    Take That You Fiend     TF    Any Wall spell     WA\n" \
"    Vorpal Blade            VB    Zappathingum       ZA\n" \
"    Double-Double           DD    Summoning          SU\n" \
"    Enhance                 EH    Zapparmour         ZP\n" \
"    Blasting Power          BP    Medusa             ME\n" \
"    Icefall                 IF    Death Spell #9     D9\n" \
"    Protective Pentagram    PP    Hellbomb Bursts    HB\n" \
"    Mind Pox                MP    Other              OT\n" \
"Proceed to the Spell Resolution Matrix overleaf. Cross-index down from the spell code (at the top of the table) to the paragraph number that sent you here (along the left side) and read your result. All result symbols are explained below.\n" \
"  113B. SPELL RESOLUTION MATRIX\n" \
"  113C. Your spell worked. Check the list of spell effects below to see what effect it had.\n" \
"  113D. Some spells listed above have shorter durations than the times listed in the T&T rules. Khara Khang is controlling their time of activity to make for a more interesting battle in the Arena. Read on.\n" \
"  113E. If you used magic against anyone from the class of wizards, go now to {150}. If your foe is not a wizard, read on.\n" \
"  113F. If your foe was the Shoggoth and your spell actually took effect, then go to {187}. If the spell did not take effect on the Shoggoth, go to {143}. If you opponent was not the Shoggoth, read on.\n" \
"  113G. Return to the fourth part of the paragraph that sent you here. Your magic will be in effect for the stated duration."
},
{ // 114 (A-C)/21A (1-3)
"114A. Unless you are a Giant or a Troll (or some kind of hero), your fight with a Giant is largely an attempt to avoid being hit. If you are a Giant or a Troll, conduct regular T&T combat until there is a winner. If you kill or disable it, go to {190}. If it kills you, go to {1}; if it disables you (CON of 5 or less) go to {2}. Otherwise read on.\n" \
"  114B. If you are not a Giant or a Troll, you will need all your Strength and skill to avoid getting clobbered. On the first combat round, make a L1-SR on both Strength (20 - ST) and Dexterity (20 - DEX). If you made both saving rolls, you managed to dodge him for 2 minutes while getting your licks. The giant must take all the hits you can give him. (Remember, his skin is so tough that it takes the first 10 hits just as armour would before you start to hurt his Constitution.) If this kills him, or reduces his CON to 5 or less, go to {190}. If you missed either saving roll, you were unable to completely dodge his attack. Do regular T&T combat for the turn. If you slay or disable your foe, go to {190}. If he kills you, go to {1}. If he disables you, go to {2}. If neither happens, read on.\n" \
"  114C. Each successive combat turn, you will find it harder and harder to dodge the Giant's attack. On the second combat round you must make second level saving rolls on Strength and Dexterity to avoid his attack. On the third combat turn, you must make L3-SRs, and so forth. Continue fighting as in {114B} until either you or your foe is defeated or slain; then go to the appropriate paragraph as listed above."
},
{ // 115/21B
"The conjurer throws a Mind Pox on you. Your IQ is reduced to 3 for 30 minutes. This leaves you totally unable to defend yourself. He walks up and knocks you down, thus proving that he has won. Make a L1-SR on Luck (20 - LK). If you make it, go to {144}. If you miss it, go to {2}. You combat has lasted for 2 combat rounds."
},
{ // 116/21C
"She realizes that you had a chance to kill her and that if she spares you will she will lose her job as a gladiator and gain only a lover. So now it comes down to a question of charm. She has allowed you one level for your chivalrous gesture, so you only have to make your L2-SR on Charisma (25 - CHR). If you make it, go to {147}. If you miss it, brace yourself and go to {119}."
},
{ // 117/21D
"She is amazed that you can still fight. Her Strength has gone down by 5 points. If this disables her, go to {190} as you are the winner. If she has more than 6 Strength points left, she skis away from you and gets ready to blast you again. You find you cannot close with her. Go to {32} and try again to beat her to the draw[, but decrease your marksmanship rating (ie. your DEX to hit with missiles) by the number of hits you have just taken]. If she doesn't have 6 or more ST points, she'll hang her head and acknowledge defeat. Go to {190}."
},
{ // 118/21E
"You leaped over the thrashing tail and came down in good position to attack the reptile. Do your full weapons damage without taking any hits in return. If you have killed the croc or reduced its MR to 7 or less, go in triumph to {190}. If you've only wounded it, go to {103}."
},
{ // 119 (A-D)/22A (1-4)
"119A. If her strength is less than 20, she will cast a second level Take That You Fiend at you. If this kills you, go to {1}. If it reduces your CON to 5 or less, go to {2}.\n" \
"  119B. If you can still fight and intended to use magic against her, write down the name and level of your spell and go to {113}.\n" \
"  119C. If you wish to fire a missile weapon at her, go to {87}.\n" \
"  119D. You are not at pointblank distance. Go to {74}."
},
{ // 120/22B
"The war elephant just stampeded over you, but you did score your weapons hits on it. If you inflicted enough hits to reduce its Monster Rating to 20 or less, and survived your own wounds, go to {190}. If the elephant, however, which gets to inflict all the hits it scored (total - not what it beat your roll by) killed you, or reduced your CON to 5 or less without falling over, then it will finish you off, so go to {1}. If you are only wounded, despite being run over by an elephant, go to {139}."
},
{ // 121/22C
"Bad choice. The Orc decides that if you fear to close with him he can use the chance to throw all three missile weapons. Make a first level, second level, and third level saving roll on Luck (20 - LK, 25 - LK, 30 - LK). For each one that you miss, take 2 dice plus the Orc's adds worth of hits. If this kills you go to {1}; if it disables you go to {2}. If the Orc missed or only wounded you, it will leap in, howling. You have no time now for missiles or magic. Go to {99}."
},
{ // 122/22D
"The Eagle is quite fast and never misses its strikes - unless it gets a beak full of weapon, which will usually stop it cold. In order to hit it you must be either very skillful, or extremely lucky. Make your L3-SR on Dexterity (30 - DEX). If you make it, go to {36}; if you miss it, go to {43}."
},
{ // 123/22E
"You fall over unconscious from the shock, but the ape doesn't care. Munching on your arm, it saunters back to its cage. Attendants haul your wounded body off the field, and take you in for medical care. Your CON is permanently reduced by 100 points. Your Strength, Luck, and Charisma are permanently halved because of your injury. [You can get 10 CON points back from medication, but that's all. ]Go to {144}."
},
{ // 124/22F
"You are aiming at a large target at far range (more than 50 yards, less than 100). Make your L6-SR on Dexterity (45 - DEX). If you missed the saving roll, you also missed your foe. If you would like to try and shoot again, go to {106}. If you want to switch to a non-missile weapon, go back to the fourth part of the paragraph that sent you here.\n" \
"  If you made the saving roll, your aim was good. Your foe must take the full amount of hits for your weapon plus adds (it may take them on armour or tough skin if it has any, just as you can). If you have slain it, go to {190}. If it is unhurt, or only wounded, and you wish to shoot at it again, go to {106}. If it still lives and you'd prefer to try another weapon, go back to the fourth part of the paragraph that sent you here."
},
{ // 125/22G
"Do regular T&T combat with the mighty arachnid as it closes with you. If you reduce its MR to 5 or less on the first combat turn, you are the winner, and can go to {190}. If you did not conquer it completely on the first turn, but only wounded it, go to {111}. If it inflicted any hits on you, go to {132}."
},
{ // 126/23A
"The Gremlin comes in slowly, jabbing at you with its spear. Conduct regular T&T combat, figuring each Gremlin at 3 dice plus its adds. If you kill it quickly, go to {190}. If it kills you quickly, go to {1}. If it reduces your CON to 5 or less, go to {2}. If the Gremlin scores hits on you this way without actually killing or disabling you, go back to the beginning of this paragraph and play through it again (now)...but if you scored hits on the Gremlin without killing it, it will change tactics and leap to very close quarters to use its knife - go to {75}."
},
{ // 127 (A-D)/23B (1-4)
"127A. The Hobbit stops about 30' from you and whirls its bola. You see the plan now - it will entangle you and leap upon you when you are helpless. If the Hobbit has a DEX of 16 or higher, your attempt to dodge failed - you are entangled for 1 turn. Go to {9}. If its DEX is lower than 16, roll 1 die. If the number is odd, go to {9}. If it is even, the bola missed you. Read on.\n" \
"  127B. If you wish to use magic, write down the spell name and level, and go to {113}. If not, read on.\n" \
"  127C. If you wish to use a missile weapon against the Hobbit, go to {83}.\n" \
"  127D. If you are reading this, you are at hand strokes with the foe. Go to {81}."
},
{ // 128 (A-D)/23C (1-4)
"128A. You see that the Dwarf is coming in fast and means to chop you up with his axe. You just have time to throw one spell or get off one shot at pointblank range before it will be upon you.\n" \
"  128B. If you wish to use magic, write down the spell name and level you cast it on, and go to {113}. Otherwise read on.\n" \
"  128C. If you wish to use a missile weapon against the Dwarf, go to {78}.\n" \
"  128D. If you are reading this, you are in hand-to-hand combat with the Dwarf. Go to {88}."
},
{ // 129 (A-D)/23D (1-4)
"129A. The Human warrior(s) move towards you cautiously with their swords ready. You have time to throw a spell, or fire a missile if you wish.\n" \
"  129B. If you wish to cast magic, write down the spell name and the level you cast it at and go to {113}. If not, read on.\n" \
"  129C. If you want to use a missile weapon, choose one of the following four ranges: pointblank, go to {106}; near, go to {87}; far, go to {124}; extreme, go to {135}.\n" \
"  129D. If you are reading this, you are in hand-to-hand combat. Go to {82}."
},
{ // 130/23E
"The wizard throws a Dreamweaver spell at you. Total your Strength, IQ, and Charisma. If the total is less than 100, you fell asleep and lost the fight. A kind-hearted fellow, this wiz obtains mercy for you from the crowd. Go to {144}. If your total is 100 or higher, you did not fall asleep. His face goes ashen, and he throws himself down in front of you and begs for mercy. In the stands, Khara Khang is really disgusted, and turns him into a hyena, which scoots away laughing and yelping. You, however, can go in triumph to {190}."
},
{ // 131 (A-D)/23F (1-4)
"131A. [If your character does not have a Speed rating, roll 3 dice to determine your character's Speed (as an Arena special, let triples add and roll over). Then ]make a L2-SR on Speed (25 - SPD). If you miss the saving roll, go to {131D}. If you make the saving roll, you will now have time to cast magic or fire a missile weapon at pointblank range.\n" \
"  131B. If you wish to use magic, write down the spell name and level and go to {113}. If not, read on.\n" \
"  131C. If you want to fire a missile weapon at the Troll, go to {18}.\n" \
"  131D. If you are reading this, you are in regular T&T combat with the Troll. Go to {105}."
},
{ // 132/24A
"If your Constitution has been reduced to 5 or less, the spider will begin wrapping you in a cocoon of spider silk, and when it is finished it will carry you off for future feasting. Check your character card - there's still a chance to live. If you do not have more than 100 gold pieces left unwagered, then you are doomed to a short but agonizing future existence as spider food. If you do indeed have more than 100 gp left over, the spider master will rescue you from  his pet for 100 gold pieces. Pay the travesty of a man and go to {144}."
},
{ // 133/24B
#ifdef CENSORED
"Think about your character's past history. [If you know that you have murdered someone, go straight to {57B}. If you know for sure that you have never murdered anyone, go directly to {29}. If you are not sure, ]make a L1-SR on Charisma. If you make the saving roll, go to {29}. If you miss it, go to {57B}."
#else
"Think about your character's past history. If you know that you are not a virgin, go straight to {57B}. If you know for sure that your character is a virgin, go directly to {29}.[ If you are not sure, make a L1-SR on Charisma. If you make the saving roll, go to {29}. If you miss it, go to {57B}.]"
#endif
},
{ // 134 (A-B)/24C (1-2)
"134A. If the Orc warrior-wizard has been wounded, he throws a second level Take That You Fiend spell at you. (If he doesn't have the 12 ST points necessary to do it, he dies in the attempt, and you may go unharmed to {190}.) If this kills you, go to {1}. If it reduces you to a CON of 5 or less, go to {2}. If your CON is still higher than 5, and your foe's Strength has dropped below 5, then he has passed out, leaving you the victor. Go to {190}. Otherwise read on.\n" \
"  134B. If the Orc is not wounded when you reach this paragraph, he will throw an Enhance spell on his shamsheer[, tripling its effect for 1 combat turn]. He moves to fight you as a warrior would. However, the spell cost him 10 Strength points, and if the loss brought his Strength rating down to 5 or less, he will look foolish and then fall over unconscious. Since you have won by default in this case, go to {190}. [However, you can only take half value for your prize because the crowd was greatly displeased. ]If he does not fall over and you wish to fight him normally, go to {16}. If you'd prefer to use magic or missile against him, go to {27B}."
},
{ // 135/24D
"You are aiming at a large target at extreme range (more than 100 yards). Can your weapon really reach this far? If not, go to {124}. If so, then make your L8-SR on Dexterity (55 - DEX). If you missed the saving roll, you missed your foe. If you would like to try another shot, go to {106}. If you would prefer to switch to a non-missile weapon, go back to the fourth part of the paragraph that sent you here.\n" \
"  If you made the saving roll, it was a good shot, and you hit your target. Your foe must take the full amount of hits for your weapons plus adds (it may take hits on armour or tough skin if it has any, just as you can). If you have slain it, go to {190}. If it still lives, and you wish to shoot at it again, go to {106}. If it still lives and you'd prefer to try a non-missile weapon, go back to the fourth part of the paragraph that sent you here."
},
{ // 136/24E
"You score as many hits on the giant beast as you beat its combat roll by. If this reduced the elephant to a MR of 20 or less, it will fall over, and you go in triumph to {190}. If the elephant is still able to fight, make your L3-SR on Dexterity (30 - DEX). If you make it, go to {178}. If you miss it, go to {171}."
},
{ // 137/25A
"With a fiendish cackle she launches a Blasting Power spell at you. Everything on your body that is flammable goes up with a rush. Take 6 dice plus her adds in hits[ - and only enchanted armour will take hits for you in this case]. If she has killed you, go to {1}. If she has reduced your CON to 5 or less, go to {2}. If neither of these happened, make your L2-SR on Luck (25 - LK). If you made it, you got your eyes closed in time. If you missed it, you were blinded - go to {2}. If you're still able to retaliate, go to {117}."
},
{ // 138/25B
"This is one wise and crafty reptile. It lurk below the surface of the muddy water, and approaches cautiously. Make your L1-SR on Luck (20 - LK). If you make it, go to {54}. If you miss it, go to {60}."
},
{ // 139/25C
"First, you were gored. Then, you were trampled. Take the full MR worth of damage to your CON. Armour won't take any of it. You did not score any weapons hits on the beast. If this has killed you, go to {1}. If it reduced you to a CON of 5 or less, the elephant will step on you one more time, thus reducing you to a thin red paste. Go to {1}. If your CON is so unbelievably large that you are only wounded and would be able to continue to fight, go to {169}."
},
{ // 140/25D
"Unable to get off another spell, the wizard defends himself with his dagger (worth 2 dice). (He also gets his adds.) Fight for 1 combat turn. If you kill him go to {190}. If he kills you go to {1}. If he disables you (CON of 5 or less), go to {2}. If none of the above things happen, he will throw a Panic spell on you at the beginning of the next combat turn. Total up with Wizard's IQ, Luck, and Charisma, and then total your Strength and Constitution. If his total exceeds yours, you will find yourself in abject flight, which the crowd will find amusing. You will have been defeated, but you won't care as long as you get away from that wizard - go to {144} in disgrace. If your total is higher, you are now inspired with a [berserk ]desire to kill this guy. Go to {164}."
},
{ // 141/25E
"The spider has bitten you - some of its paralyzing venom has gotten into your bloodstream. Now, even if you are not badly wounded, you are going to be pressed for time, as you must kill the beast before its venom paralyzes you. Roll 1 regular die and add 5 to it - that's the number of CON hits you must take each combat turn (at the end of the turn). When your CON falls to 5 or less, you will be immobilized, and the spider, if it is still alive, will win. Go to {153}."
},
{ // 142/25F
"The Giant clearly intends to splatter you like a grape with its huge weapon. [Roll 3 dice to determine your Speed (as an Arena special, if you roll triples, add and roll again). ]Make a L1-SR on Speed (20 - SPD). If you made it, the Giant missed on its first attempt - go back to {7D} and take the other option. If you missed the saving roll, you must take all the hits the Giant can deal out. If this kills you, go to {1}; if it reduces your CON to 5 or less, go to {2}. If you are still able to fight and wish now to use magic, go to {7B}, or if you wish to draw your weapon and fight you may do so by going to {114}."
},
{ // 143/26A
"If your character is a Troll or a Giant, you don't belong here. Go to {189}. If your character is of any other short-type kindred, the Shoggoth comes tromping ominously towards you. Go to {12}."
},
{ // 144/26B
"If you were wounded during your combat, you may purchase healing at the rate of 100 gold pieces per Constitution point restored. (This is half the standard rate in the city outside.) Wizards may, of course, cast Restoration on themselves, but only at the rate of 1 CON point per day - this is a magically-enforced clause hidden in the small print of your Arena contract. (Roll 1 poly-die and randomize between 1 and 10 to see how many days you have before your next fight. For example, if you want to restore 8 CON points, but there are only 3 days before your next fight, 3 is the maximum number of CON points you can get back without buying healing.)\n" \
"  If you do not buy healing, or heal yourself magically, you will not get enough rest in the few days before your next fight to recover naturally. If you do not have enough cash to buy healing, and if your CON has been reduced to ½ or less of its original value, or is less than 10 (whichever is less), go to {148}. If you're not that badly hurt, or if you have been healed, go to {192}."
},
{ // 145/26C
"The Unicorn cries and allows you to butcher it. As it dies you feel some changes of your own. Your Charisma drops another 5 points, and your Luck is [permanently ]reduced to a value of 7. [It will remain there until you spare the life or save the life of another Unicorn, at which time it will be unfrozen. ]Nevertheless, you are the winner. Go to {190}."
},
{ // 146/26D
"This is no trial run now. Your new contract calls for you to fight 7 more combats, which will bring your total to 10 - a very respectable achievement, and one that few fighters reach. If this is 4th, 5th, 6th, or 7th combat, go to {155}. (Remember that you don't have to buy magic if you don't want to or can't afford it.) If this is your 8th combat, go first to {155} and then straight to {55}. If it's your 9th, go to {155} and then {61}. If it's your 10th, go to {155} and then to {67}.\n" \
"  If you have survived 10 Arena combats, you will be presented personally to Lerotra'hh, Death Goddess and Empress of Khazan. Go to {170}.[ If this is your 11th fight or more, start at {71} as if it were your first fight in all respects except for figuring the odds and in counting the number of foes you must face.]"
},
{ // 147/27A
"She comes over and plants a kiss upon your brow. Increase your Charisma by 3 points. \"You are a noble soul and shall be my love!\" she declares. Then, arm in arm, to the booing of the crowd, you walk out of the arena and no one dares try to stop you. (Khara Khang could, but he's in a good mood and lets you go.) [Keep her character card and name her as one of your characters. ]She [has 6500 ap and ]owns 22,222 gp. You are also awarded an extra bonus of 1000 experience points. If you wish to depart from the Arena of Khazan without finishing out your contract, you may do so now. But, if you are willing to finish out your contract, go to {192}."
},
{ // 148/27B
"You badly need medical attention, but can't afford it. The Empire of Khazan will pick up your medical bill[ - but you will become an Arena slave and must fight in the Arena until you can pay back ten times what it cost to heal you]. [You will also forfeit the right to win any magical weapons, and the right to meet the Empress should you win 10 fights. ]If you accept these conditions, [note how much it cost to heal you and how much you now owe Khazan; ]go to {192} and keep reading. If you will not accept these terms, go to {154}."
},
{ // 149/27C
"If your character is a Giant, Troll, or Ogre, you are big enough to meet the elephant head on. Go to {156}. If you are any smaller type of character, make your L2-SR on Speed (25 - SPD). [(If you don't already have a Speed rating, roll 3 dice. As an Arena special, triples add and re-roll.) ]If you make the saving roll, go to {157}. If you miss it, go to {139}."
},
{ // 150/27D
"If your opponent has been killed or reduced to a CON of 5 or less by your spell, go to {190} for your reward. If your foe has not been wiped out by your magic, choose the appropriate enemy wizard and go where you are told: 1st level ({14}); 2nd level ({134}); 3rd level ({119}); 4th level (96); 5th level ({115}); 6th level ({137})."
},
{ // 151/27E
"If your missile is enchanted or silver-headed, figure the damage it would do. If you have reduced the werewolf to a MR of 15 or less, it will fall over, and you can go happily to {190}. If you didn't do that much damage, go to {176}. If your missile is neither magical nor silver, it rebounds harmlessly from the wolfman's body, and before you can go for another weapon, the monster is upon you. Go to {28}."
},
{ // 152/-
"Continue fighting the Human warrior(s). If they kill you, go to {1}. If you are reduced to a CON of 5 or less, go to {2}. If you slay all your foes, go to {190}."
},
{ // 153/-
"Do regular T&T combat with the hairy horror. If you reduce its MR to 5 or less, you win. [An Arena wizard will apply a Too-Bad Toxin spell to restore your CON to what it was before you were bitten. ]Go to {190}. If you only wounded it, or it scored hits on you, take the poison hits and go to {132}."
},
{ // 154/28A
"The Arena of Khazan is not a public hospital, and will not maintain the lives of those who are both indigent and unable to fight. They knock you on the head and use your corpse as animal food. Go to {1}."
},
{ // 155/28B
"The Empire of Khazan retains a 30th level wizard to make sure there are no magical surprises or disasters in the Arena. Most of the time the wiz just applies selective, precognitive anti-magic to prevent contestants from throwing spells when they're not allowed to, but Khara Khang also maintains a staff of lesser mages for the more mundane but fairly profitable tasks of enchanting weapons and armour. [You as a contestant in the Arena have the right to purchase certain spells to enchant your weapons, as it is well known that there are some opponents that only magic will stand a chance against. The spells available are listed in a table below, along with their cost and duration. All spells are cash and carry, and will only affect your ability to fight.\n" \
"    Spell Name       Duration                   Cost\n" \
"    Vorpal Blade     1 combat turn              50 gp per combat turn\n" \
"    Double-Double    1 to 6 combat turns        100 gp per combat turn\n" \
"    Enhance          1 combat turn              100 gp per combat turn\n" \
"    ]R[estoration      First time you are         1000 gp\n" \
"                     hurt, it heals up to 10\n" \
"                     CON points of damage\n" \
"    Zappathingum     For the length of your     1000 gp\n" \
"                     combat on one weapon\n"\
"                     only\n" \
"    Zapparmour       For the length of your     1000 gp\n" \
"                     combat\n" \
"You may buy spells in combination, or specify that it will operate at a given time, say, your third combat turn. If a spell is unused, there will be no refund. (For example, if you wished to have a Vorpal Blade on your sword for your first five combat turns, you would pay 250 gp. If you then killed your foe in 4 combat turns, you would not receive a 50 gp refund for the unused fifth turn.) Spells must be decided upon and paid for before you learn who or what your foe will be.\n" \
"  Now, if you've chosen and paid for whatever you wish, r]oll 2 dice: if you roll a 2, go to {7A}, 3 go to {13A}, 4 go to {19A}, 5 go to {25A}, 6 go to {31A}, 7 go to {38A}, 8 go to {44A}, 9 go to {49A}, 10 go to {55}, 11 go to {61}, 12 go to {67A}."
},
{ // 156/28C
"Because you are such a big fellow, you have no chance of dodging the elephant's charge. You must stop it cold. The pachyderm gets its full MR worth of dice and adds, and you will compute your own weapons and adds damage. If you got the same or more hits than the elephant, you stopped it cold. Go to {136}. If you didn't get as many hits as it did, then it ran over you. Go to {120}."
},
{ // 157/28D
"You dodged the elephant's charge and inflicted your weapons hits. Remember that the first 10 don't count. If you do enough damage to reduce its MR to 20 or less, it will fall over and you go in triumph to {190}. If it is still able to fight, go to {161}."
},
{ // 158/28E
"The flaming whip becomes a flaming sword in the Balrog's oversized hand. (A whip is a poor weapon for in-fighting!) Engage in regular T&T combat. If you score hits on the Balrog, go to {17}. If it scores hits on you, go to {173}."
},
{ // 159/29A
"Do regular T&T combat against the ape, allocating hits as you would normally - but you must also make a saving roll on Luck on the same level as the number of the combat turn. On the first turn, make a L1-SR on Luck (20 - LK). On the second combat turn, make a L2-SR on Luck (25 - LK), and so forth. If you missed the roll, you did not escape unscathed even though you wounded your foe. It managed to knock you down, or bite a chunk out of your thigh, or wrap one arm around your ear 3 or 4 times, etc. Take the number you missed the saving roll by in hits to both CON and armour. If you reduce the ape to a MR of 10 or less, it falls over, and you go in triumph to {190}. If your CON is reduced to a 5 or less, you will fall over, and it feasts. Go to {1}."
},
{ // 160/29B
"Fighting a Manticore would be like fighting a larger, stronger lion except for its sting. It can move that scorpion-like stinger with incredible speed and power, and Manticore venom is one of the deadliest known. Before beginning combat on each combat turn, you will need to make a saving roll on Dexterity or Luck (whichever is the higher attribute for your character). If you are wearing plate armour, make a L1-SR; if you are wearing mail or lamellar armour, make a L2-SR; if you are wearing a complete set of leather armour[ or just a mail shirt or cuirass with no arm and leg protection], then make a L3-SR; and if you are wearing no body armour at all (a steel cap doesn't count, nor does a shield in your hand), make a L5-SR. If you make the saving roll, go to {185}. If you miss it, go to {191}."
},
{ // 161/29C
"The elephant rushes by. When it comes for you again, it moves in more slowly, intending to catch you in its trunk before smashing you. If you wish to use magic or a missile weapon against it, return to {89}. If you wish to try and dodge and strike as you did this time, make a L2-SR on Speed (25 - SPD), and a L2-SR on Luck (25 - LK). If you made both of them, return to {157}. If you missed either one, go to {90}."
},
{ // 162/29D
"You feel the Balrog's whip curl around your body as you try to run away. There is a moment of intense pain, and then you burst into flame. When it has burned out, you're just a black spot on the sands. (This is true even if your character thought it was flame-proof.) Go to {1}."
},
{ // 163/29E
"Your timing is off, and the Unicorn is very quick. You find yourself transfixed upon the animal's horn and being tossed through the air. Right through the heart - it was at least a noble death. Go to {1}."
},
{ // 164/29F
"You will fight [as a berserker ]until the wizard is slain. He gets 2 dice and no adds for his dagger. If, by some miracle, he kills you, go to {1}. If you kill him, go to {190}. [If you pass out from Strength loss (see the Berserker fighting rules in the T&T Rulebook), he will slit your throat and consider himself lucky. ]Go to {1}."
},
{ // 165/30A
"Your opponent is a fifth level Human mage. He is wearing enchanted mail beneath his tunic of black silk. (It will take 33 hits in combat for him.) He is armed with a silver-tipped staff 8' long, and is carrying a sax (2 dice + 5 adds). Roll 2 dice for yourself (doubles add and roll over), and 4 dice for the wizard. Whoever gets the highest number has the option of striking first. If you get to strike first, go to {3}. If he gets to strike first go to {115}."
},
{ // 166/30B
"The Balrog scorns your approach and stands there laughing with hands on hips as you come up and strike it with your weapon. If your weapon is inherently magical, or has been enchanted for this fight, go to {180}. If not, go to {184}."
},
{ // 167/30C
"The cave lion stands atop your torn and bloody body. With one horrible snap it takes your head off. Go to {1}."
},
{ // 168/30D
"The ape draws you into a wrestling match with it. If you have a dagger you may use it in the ensuing combat. [Any other weapon is too large and clumsy for such close quarters. If you don't have a knife, you get simply 1 dice plus your adds against the ape's full dice and adds for its MR. ]Continue to fight until one of you is defeated, or until you have broken free. Once each combat turn you get a chance to make your L5-SR on Dexterity (40 - DEX). If you make it, you have escaped the ape's clutches and can go to {159}. If you miss it, fight on. If you reduce the ape's MR to 10 or less, you have conquered and can go to {190}. If your CON is reduced to 5 or less, it has conquered and gets a meal - go to {1}."
},
{ // 169/30E
"Khara Khang stops the fight and teleports you out of the Arena. His comment is that there is no point wasting the small stuff on a character of your magnitude. He heals your wounds, and allows you to re-equip yourself with whatever you can afford. This match with the elephant has counted as one fight, and even though it may have been your third fight, you must now fight at least one more combat. If you're ready for anything, go to {91}."
},
{ // 170/30F
#ifdef CENSORED
"Lerotra'hh receives you in the Royal Box. She is an arresting, unusual figure of a woman, not beautiful so much as strong. She chats with you about your history and some of your best fights. Finally, she kisses you once on the lips. Her mouth is cold, as chilling and forbidding as a glacier, and absolutely tasteless. Your senses swim, and you gain 10,000 adventure points. Since she is the Goddess of Death, and you have served her well, she has just granted you a slight boon. [If you are ever killed (CON reduced to 0), but not dismembered, you will regenerate 10 Constitution points one hour after your death and come back to life with a new Constitution of 10. This is a one-time boon only. If you are killed again, you stay dead. ]Congratulations on your great combat ability, and please exit from the Arena of Khazan. Should you ever wish to return for more battles, go to {71}."
#else
"Lerotra'hh receives you in the Royal Box. She is an arresting, unusual figure of a woman, not beautiful so much as strong. She is wearing the skimpy fighting harness of an orc warrior, leaving her breasts bare, but it is ornamented with jewels. She chats with you about your history and some of your best fights. Finally, she kisses you once on the lips. Her mouth is cold, as chilling and forbidding as a glacier, and absolutely tasteless. Your senses swim, and you gain 10,000 adventure points. Since she is the Goddess of Death, and you have served her well, she has just granted you a slight boon. [If you are ever killed (CON reduced to 0), but not dismembered, you will regenerate 10 Constitution points one hour after your death and come back to life with a new Constitution of 10. This is a one-time boon only. If you are killed again, you stay dead. ]Congratulations on your great combat ability, and please exit from the Arena of Khazan. Should you ever wish to return for more battles, go to {71}."
#endif
},
{ // 171/31A
"Your foe wrapped its tentacular trunk around your weapon and disarmed you. It also wrenched your arm out of its socket, inflicting 2 dice worth of hits. (Roll 2 dice and take that many hits directly off your Constitution.) If that reduces your CON to 5 or less, that's the end of the jungle path for you. Go to {1}. If you are able to continue fighting, draw your secondary weapon and go to {178}."
},
{ // 172/31B
"You are stronger than the Shoggoth, and certainly smarter. In the wrestling contest that follows, you win 2 falls out of 3. Although nothing you do seems to hurt it, you are still accounted the victor. The Shoggoth goes back to its cavern benath the Arena, and you go victoriously to {190}."
},
{ // 173/31C
"If you have been slain, go to {1}. If your CON has been reduced to 5 or less, go to {2}. If you are still able to fight, go to {179}."
},
{ // 174/31D
"You have managed to cut off the Manticore's stinger and are no longer in danger from it. Continue with regular T&T combat until the Manticore has been reduced to a MR of 25 or less (which will send you as the winner to {190}) or until your CON has been reduced to 5 or less (which will send you as the loser to {1})."
},
{ // 175/31E
"Make a L3-SR on Dexterity (30 - DEX). If you make it, go to {73}. If you miss it, go to {163}."
},
{ // 176/31F
"Do regular T&T combat with the loser taking the hits. If at any time your weapon loses its magic, cease fighting here and go to {11}. Otherwise, continue fighting until the werewolf is reduced to a MR of 15 or less, or until your CON is reduced to 5 or less. If the werewolf is defeated, go to {190}. If you lose, go to {1}."
},
{ // 177/31G
"The Take That You Fiend spell works. If you did over 900 hits of damage to the Shoggoth, it falls over with a thump that shakes the walls. Go to {190}. If you did less than 900 hits of damage to the Shoggoth, it keeps coming. Go to {143}."
},
{ // 178/32A
"Do regular T&T combat with the elephant. If you reduce it to a MR of 20 or less, and it cannot continue fighting, go to {190}. If you are reduced to a CON of 5 or less, go to {1}."
},
{ // 179/32B
"If your weapon was not magical, go to {184}. If it was, and you want to continue the combat, go back to {158}. If you would now like to run away from the Balrog, go to {162}."
},
{ // 180/32C
"The Flame-Lord is hurt, and his good humour vanishes in a hurry. If you have reduced him to a MR of 50 or less, he falls over, and you can go in triumph to {190}. If you haven't hurt him that badly, go to {86} and continue the combat."
},
{ // 181/32D
"If you have reduced the Manticore to a MR of 25 or less, then you are the victor. Arena wizards will immediately use Too-Bad toxin spells to save your life if you've been stung by the Manticore and still live. Go in triumph to {190}. If you dealt out more than 50 hits, but not enough to defeat the monster, go to {174}. If you did less than 50 hits of damage, go to {160} and keep fighting."
},
{ // 182/32E
"The Unicorn is charging. If you wish to stand your ground and meet it head-on, go to {188}. If you'd prefer to dodge and strike at it, go to {175}."
},
{ // 183/32F
"If your weapon is enchanted, go to {46}. If it isn't, it will prove worthless against the Shoggoth[ and will shatter]. If your character is a Giant or a Troll, go to {189}. If not, go to {143}."
},
{ // 184/33A
"Non-magical weapons have no effect on the Balrog. Instead, you are enveloped in a magical flame that does 100 hits worth of damage and destroys all non-magical weapons. If this kills you, go to {1}. If it reduces you to a CON of 5 or less, go to {2}. If you are still able to fight[ and have any weapons left], go to {158}. If you [have no weapons and ]want to run away now, go to {162}."
},
{ // 185/33B
"Do regular T&T combat with the Manticore. If it gets enough hits on you to reduce your CON to 5 or less, then go to {1}, because you're a monster meal. If it only wounds you, go to {160} and keep fighting. If you scored hits on the Manticore, go to {181}."
},
{ // 186/33C
"You mount the Unicorn and ride around the Arena. Audience reaction is mixed, but there is no doubt that you have won. Add 20 points to your Charisma and 7 points to your Luck. Also, you have a Unicorn with a Monster Rating of 200 that will come at your command and do your bidding, when you're not fighting in the Arena. Go to {190}."
},
{ // 187/33D
"Since the Shoggoth is a child of the Elder Gods, very little magic will affect it. If you cast a Take That You Fiend at it, go to {177}. If you have enchanted your weapons or armour, and now wish to fight, go to {183}. If it was a Protective Pentagram you cast, you now have a ten-minute grace period in which to think of something else. Go back to {91}."
},
{ // 188/33E
"The Unicorn stops when it is nearly on you and rears up, trying to smash you with its hooves. You duck in under them and hew with all your might. Do regular T&T combat. If you reduce the Unicorn's MR to 20 or less, you win, and must go to {190}. If it reduces your CON to 5 or less, it wins, and you die and go to {1}. Continue fighting until one of these alternatives is achieved."
},
{ // 189/33F
"You are too large for the Shoggoth to stomp in the usual mindless way. It wraps you in its ropy arms and begins to squeeze. If you have a Strength greater than 500, you begin to fight back by going to {172}. Otherwise, you are slowly reduced to a lifeless pulp. Go to {1}."
},
{ // 190 (A-F)/34A (1-6)
"190A. You are the victor. Congratulations! The crowd is cheering you as you deserve, depending on how tremendous the combat was.\n" \
"  190B. First, if you bet on yourself to win, you may now collect those winnings and add the gold to your stock of treasure. If you bet on yourself to lose, don't feel silly paying out that money after winning!\n" \
"  190C. Second, take adventure points equal to either (1) the Monster Rating, if you fought a Beast or a Monster, or (2) 100 times the level number of the wizard, if you fought a wizard, or (3) the sum of the Strength and Constitution for any other type of character you defeated.\n" \
"  190D. If the odds you fought at were in your favour, take 100 gold pieces as your prize for the victory. If the odds were between 1:1 and 3:1 against you, you may either roll 4 dice and multiply by 100 for the number of gold pieces you are awarded, or take any 1 weapon from the T&T weapons charts except a gunne. If the odds were more than 3:1 against you but less than 7:1, roll 5 dice times 100 for the number of gold pieces and take 1 roll for one gem on the jewel generator in the T&T rules. If the odds against you were 7:1 or greater, randomize between 1 and 20 for a magic weapons from the Table of Enchanted Prize Weapons on page 163 of this book, before coming back to {190E}.\n" \
"  190E. If you took any hits of damage during your combat, go to {144}. If not, read on.\n" \
"  190F. If you wish to buy new equipment, or new weapons, armour, poisons, and so forth, do so now from the T&T rules, and then go to {192}."
},
{ // 191/34B
"You have been stung by the Manticore. You must take 200 hits on CON immediately, and 100 more at the beginning of each new combat turn. If at any time this kills you, quit reading everything else and go to {1}. If you are still alive after reading this paragraph, go to {185}."
},
{ // 192/34C
"If this was your first or second combat, go to {155}. If this was your third combat, you have completed your initial contract and you are free to leave with all money and weapons accumulated. However, since you are now something of a star, the management would like to encourage you to keep fighting. They will offer you a bonus of 1000 gold pieces now if you will sign up for an additional 7 fights. If you agree to this, add the gold to your total and go to {146}. If you don't like the bargain, you are out of the Arena of Khazan, but put a little AK146 on your character card in case you ever decide to come back with that character. In that case, you don't get the bonus, but you start at {146}. If this is your 4th through 10th fight, go immediately to {146} and ignore the first 2 sentences."
},
{ // 193/34D
"You are aware that Shoggoths have a weakness for piccolo music. Fortunately, you have brought your piccolo with you. As you begin to play, the Shoggoth ceases its advance upon you and begins to dance ponderously in the sand. It is a ludicrous sight, and you have the whole Arena in stitches. After ten minutes of this, you are declared the victor, and the Shoggoth is packed off to wherever it is kept. Go to {190} for your reward."
},
/*
{ // -/1E (unreachable) (anti-cheat)
"Notice: this paragraph doesn’t exist. Sorry! Your character wasn’t supposed to be here anyway!"
},
{ // -/6H (unreachable)
"You stagger forward, dazed and bleeding, your weapon drops from your hand as the crowd cheers. You and are vaguely aware that someone is approaching from behind. Then all goes black."
},
{ // p162/35A
"SUGGESTIONS TO PERSONALIZE THE ARENA"...
}
*/
}, ak_treasuretext[20] = { // FB 36A
"1 - Egil's Bow...a simple self-bow of linden wood. User hits [automatically ]with the effect of 30 dice. Requires a ST of 16 to string and a ST of 13 to pull.[ Those without sufficient ST will always miss.]",
"2 - The Bronze Bodkin...worth 66 dice in combat.[ (No berserkers.) Cannot be enchanted or poisoned.]",
"3 - Gold Armband...weighs 10 weight units.[ Wearer is immune to Hellbomb Bursts.]",
"4 - The Dagger of Speed...[whoever holds it can always move at twice his normal rate of speed, and gets 2 combat turns to his opponent's one. ]Worth only 1 die in combat.",
"5 - Deth...a great sword, 7' long and worth 21 dice in combat. Can be used by anyone with a minimum ST of 9.",
"6 - Hellslice...a battered-looking falchion with a demon imprisoned in the blade that makes it worth 42 dice in combat.[ Even when the wielder takes hits, he gets to count the 42 dice against his foe.]",
"7 - Finnegan's Flail...[on the first combat turn of any fight it is worth 9 dice + 12 adds. On subsequent turns ]it is only worth 3 dice + 4 adds. Requires a Strength of 20 and a Dexterity of 15 to use.",
"8 - The Heavy Flail...gets 36 dice in combat.[ Subtracts the user's level number in ST points for each combat turn used.]",
"9 - The Frog Axe...gets 6 dice in combat[ and enables the wielder to hop up to 50' in any direction once each combat turn].[ However, it will not allow you to hit and hop the same turn.]",
"10 - Nevermiss...a crossbow worth 5 dice[ that teleports its bolts up to 100 yards to the intended destination], getting 5 dice of hits[ every time].",
"11 - 12 Silver-Tipped Arrows...[each arrow strikes 33 dice worth of hits when shot from any bow - providing the shooter hits his target.]",
"12 - Levity...a small ordinary 3-dice crossbow.[ Its bearer cannot touch the ground (walking 1\" or so above it), and can fly up to 100 yards above the ground at will (top speed is the speed of a crossbow bolt).]",
"13 - Trollbow...a triple-sized arbalest[ made for Trolls]. Gets 42 dice if it hits. Requires a ST of 45 to recock by hand.",
"14 - The Little Silver Thunderstick...a single-shot, muzzle-loading wheel lock pistol, ornamented with silver plates bearing a portrait of Lerotra'hh in miniature. Also, enough powder and shot for 100 firings. Accurate up to 50 yards. Valued at 3000 gold pieces. Gets 8 dice + 25 adds, and must be used like any other missile weapon.",
"15 - Daggered Boots...in combat, daggers extend from the boot toes[, giving 4 dice (total) kicks per combat turn].",
"16 - Cross Kris...a short sword of meteoric iron worth 9 dice in combat.[ Protects the wielder from all 3rd level and lower spells.]",
"17 - The Great Sword Carrot...[anyone or anything taking hits from it is changed into a harmless bunny rabbit with a Monster Rating of 1. Intelligent characters retain their IQ and memory, although they can't talk. ]Carrot gets 8 dice in combat and [d]is[hes out a] 9th level[ curse if hits are scored].",
"18 - A Bottle of Warrior Juice...[any warrior who drink it doubles his ST and CON. Any rogue or magic user who drinks from it loses the ability to work magic. One dose per person. A second dose is fatal. ]Value: 2000 gp.",
"19 - Hardpull the Longbow...requires a minimum ST of 48 to draw. [It gets one die worth of damage for each ST point used in pulling it. ]Good at any distance up to 1 mile, but you have to be able to see what you're shooting at.",
"20 - The Long Golden Thunderstick...a single-shot, muzzle-loading flintlock musket rifle with golden butt-plates and chasing, complete with powder and ammunition for 100 rounds. Valued at 7000 gp. Gets 12 dice + 40 adds. Treat is as any other missile weapon. It is accurate up to 200 yards."
};

MODULE SWORD ak_exits[AK_ROOMS][EXITS] =
{ {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  28,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  { 137,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  { 143,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  { 145, 186,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  { 190,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  { 144,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {  66,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  {  75,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  80,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/14A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  { 190,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  {   5,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  {  97,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  { 144,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  { 153,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  { 190,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168
  {  91,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  { 190,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  { 158, 162,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  { 188, 175,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  { 190,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192
  { 190,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 193
};

MODULE STRPTR ak_pix[AK_ROOMS] =
{ "", //   0
  "ak1",
  "",
  "",
  "",
  "", //   5
  "",
  "ak7",
  "",
  "",
  "", //  10
  "",
  "",
  "ak13",
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
  "ak25", //  25
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
  "ak38",
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
  "", //  80
  "",
  "",
  "",
  "",
  "", //  85
  "ak86",
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
  "ak137",
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
  "",
  "",
  "",
  "ak160", // 160
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
  ""  // 193
};

EXPORT int                    ak_fights,
                              ak_won;

IMPORT int                    armour,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              evil_attacktotal,
                              evil_hitstaken,
                              good_attacktotal,
                              good_hitstaken,
                              good_shocktotal,
                              gp, sp, cp, rt, lt, both,
                              height, weight, sex, race, class, size,
                              missileammo,
                              missileweapon,
                              room, prevroom, module,
                              spellchosen,
                              theround;
IMPORT       TEXT             userstring[40 + 1];
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *treasures[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];

MODULE int                    a,
                              betagainst,
                              betfor,
                              fought[21],
                              opponent,
                              poisonstrength,
                              weak,
                              wizlevel,
                              y;

IMPORT void (* enterroom) (void);

MODULE void ak_enterroom(void);
MODULE void ak_wandering(void);
MODULE void ak_missile(int size);
MODULE void ak_missile_pb(int size);
MODULE void ak_missile_near(int size);
MODULE void ak_missile_far(int size);
MODULE void ak_missile_extreme(int size);
MODULE void ak_odds(void);
MODULE void ak_treasure(void);
MODULE void ak_tacky(void);

EXPORT void ak_preinit(void)
{   descs[MODULE_AK]     = ak_desc;
    treasures[MODULE_AK] = ak_treasuretext;
}

EXPORT void ak_init(void)
{   int i;

    exits     = &ak_exits[0][0];
    enterroom = ak_enterroom;
    for (i = 0; i < AK_ROOMS; i++)
    {   pix[i] = ak_pix[i];
    }

    for (i = 0; i < 21; i++)
    {   fought[i] = 0; // we should probably track this throughout the character's life like we do with ak_fights and ak_won
}   }

MODULE void ak_enterroom(void)
{   FLAG  ok;
    int   i,
          limit,
          needed,
          prize,
          result1,
          result2,
          target;
    float normalized_a;

    switch (room)
    {
    case 0:
        if (ak_fights >= 10) // *not* ak_fights % 10
        {   room = 77;
        } elif (ak_fights >= 3) // *not* ak_fights % 10
        {   room = 146;
        } else savedrooms(1, lk, 71, 77);
    acase 1:
        die();
    acase 2:
        dispose_npcs();
        if (dice(1) < theround)
        {   room = 144;
        } else
        {   room = 1;
        }
    acase 3:
        // 3A
        if (!castspell(-1, TRUE))
        {   // 3B
            if (shooting() && shot(RANGE_NEAR, SIZE_LARGE, FALSE))
            {   evil_takemissilehits(0);
            }
            if (npc[0].con <= 5)
            {   room = 190;
            } else
            {   room = 130;
        }   }
    acase 4:
        if (st >= 100)
        {   room = 98;
        } elif (st >= 50)
        {   room = 168; // misprinted as 30D in book
        } else
        {   room = 110;
        }
    acase 5:
        if (st >= 50 || con >= 50)
        {   do
            {   oneround();
                if (con <= 0)
                {   room = 1;
                } elif (highesthp() <= 20)
                {   room = 190;
                } elif (con <= 5)
                {   room = 1;
            }   }
            while (room == 5);
        } else
        {   good_takehits(dice(8) * countfoes(), TRUE); // %%: we assume they all get to do this
            if (con <= 5)
            {   room = 1;
            } else
            {   room = 34;
        }   }
    acase 6:
        if (!armed())
        {   room = 1;
        } elif (enchantedorsilver_melee())
        {   room = 176;
        } else
        {   room = 11;
        }
    acase 7:
        if (prevroom != 142)
        {   // 7A
            opponent = 0;
            fought[0]++;
            create_monsters(144, fought[0]);
            for (i = 0; i < fought[0]; i++)
            {   npc[i].iq  = dice(3);
                npc[i].lk  = dice(3);
                npc[i].dex = dice(3);
                npc[i].chr = dice(3);
                npc[i].spd = dice(3);
                recalc_ap(i);
            }
            ak_odds();
        }
        // 7B
        if (!castspell(-1, TRUE))
        {   // 7C
            ak_missile(SIZE_HUGE);
        }
        // 7D
        if (room == 7)
        {   if (!countfoes())
            {   room = 190;
            } elif (getyn("Dodge (otherwise fight)"))
            {   room = 142;
            } else
            {   room = 114;
        }   }
    acase 8:
        savedrooms(3, iq, 193, 24);
    acase 9:
        do
        {   evil_freeattack();
            if (con <= 0)
            {   room = 1;
            } elif (con <= 5)
            {   room = 2;
            } elif (saved(countfoes(), dex))
            {   room = 8;
        }   }
        while (room == 9);
    acase 10:
        // 10A
        // already created at AK67
        // 10B
        if (!castspell(-1, TRUE))
        {   // 10C
            ak_missile(SIZE_LARGE);
        }
        // 10D
        if (room == 10)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 125;
        }   }
    acase 13:
        // 13A
        opponent = 1;
        fought[1]++;
        for (i = 1; i <= fought[1]; i++)
        {   if (dice(1) % 2 == 1)
            {   create_monster(145);
            } else
            {   create_monster(146);
        }   }
        ak_odds();
        // 13B
        if (!castspell(-1, TRUE))
        {   // 13C
            if (shooting())
            {   savedrooms(countfoes(), spd, 63, 69);
        }   }
        // 13D
        if (room == 13)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 126;
        }   }
    acase 14:
        npc_templose_st(0, 5); // %%: it doesn't say what happens if this kills him
        if (npc[0].st >= 0)
        {   good_takehits(npc[0].iq, TRUE);
        }
        if (con <= 0)
        {   room = 1;
        } elif (!countfoes())
        {   room = 190;
        } elif (con <= 5)
        {   room = 2;
        } else
        {   room = 10;
        }
    acase 16:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (con <= 5)
            {   room = 2;
            } elif (!countfoes())
            {   room = 190;
            } elif (evil_hitstaken >= 1)
            {   room = 134;
        }   }
        while (room == 16);
    acase 17:
        if
        (   (prevroom ==  21 && enchanted_missile())
         || (prevroom == 158 && enchanted_melee())
        )
        {   room = 37;
        } else
        {   room = 184;
        }
    acase 19:
        // 19A
        opponent = 2;
        fought[2]++;
        create_monsters(147, fought[2]);
        // %%: it doesn't say what the player should do if they only have MS, not RB. Not that it affects us in this case anyway...
        for (i = 0; i < fought[2]; i++)
        {   npc[i].st  = dice(3) / 2;
            npc[i].iq  = dice(3);
            npc[i].lk  = dice(3);
            npc[i].con = dice(3) * 2;
            npc[i].dex = dice(3) * 3 / 2;
            npc[i].chr = dice(3);
            npc[i].spd = dice(3);
            npc[i].max_st  = npc[i].st;
            npc[i].max_con = npc[i].con;
            // we could generate eg. heights for them, but that's rather pointless
            recalc_ap(i);
        }
        ak_odds();
        // 19B
        if (!castspell(-1, TRUE))
        {   // 19C
            ak_missile(SIZE_SMALL);
        }
        // 19D
        if (room == 19)
        {   if (!countfoes())
            {   room = 190;
            } elif (getyn("Dodge (otherwise fight)"))
            {   room = 127;
            } else
            {   room = 81;
        }   }
    acase 20:
        // 20A
        // 20B
        if (!castspell(-1, TRUE))
        {   // 20C
            if (shooting())
            {   ak_missile_near(SIZE_LARGE);
        }   }
        // 20D
        if (room == 20)
        {   room = 14;
        }
    acase 21:
        // 21A
        // already created at AK67
        if (getyn("Attack"))
        {   room = 166;
        } else
        {   // 21B
            if (!castspell(-1, TRUE))
            {   // 21C
                if (shooting())
                {   room = 17;
        }   }   }
        // 21D
        if (room == 21)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 130;
        }   }
    acase 22:
        if (saved(3 * countfoes(), lk))
        {   good_freeattack();
            room = 42;
        } else
        {   good_takehits(misseditby(3 * countfoes(), lk), TRUE);
            oneround();
            room = 52;
        }
    acase 23:
        if (race == OGRE || race == TROLL || race == GIANT)
        {   room = 35;
        } else
        {   savedrooms(dice(1) * countfoes(), lk, 79, 92);
        }
    acase 25:
        // 25A
        opponent = 3;
        fought[3]++;
        create_monsters(148, fought[3]); // %%: "ring mail (takes 11 hits)" is assumed to equal "complete mail" rather than "complete ring-jointed plate"
        for (i = 0; i < fought[3]; i++)
        {   npc[i].st  = dice(3) * 2;
            npc[i].iq  = dice(3);
            npc[i].lk  = dice(3);
            npc[i].con = dice(3) * 2;
            npc[i].dex = dice(3);
            npc[i].chr = dice(3) * 2 / 3;
            npc[i].spd = dice(3);
            // %%: what if they are too weak/clumsy for their weapon(s)/armour? It doesn't say. We are ensuring they are strong and dextrous enough.
            if (npc[i].st <= 17)
            {   npc[i].st = 17;
            }
            if (npc[i].dex <= 8)
            {   npc[i].dex = 8;
            }
            npc[i].max_st  = npc[i].st;
            npc[i].max_con = npc[i].con;
            // we could generate eg. heights for them, but that's rather pointless
            recalc_ap(i);
        }
        ak_odds();
        // 25B
        if (!castspell(-1, TRUE))
        {   // 25C
            ak_missile(SIZE_SMALL);
        }
        // 25D
        if (room == 25)
        {   if (!countfoes())
            {   room = 190;
            } elif (getyn("Dodge (otherwise fight)"))
            {   room = 128;
            } else
            {   room = 88;
        }   }
    acase 26:
        opponent = 14;
        fought[14]++;
        create_monster(153);
        npc[0].st      = dice(3) + 2;
        npc[0].iq      = dice(3) + 2;
        npc[0].lk      = dice(3) + 2;
        npc[0].con     = dice(3) + 2;
        npc[0].dex     = dice(3) + 2;
        npc[0].chr     = dice(3) + 2;
        npc[0].spd     = dice(3) + 2;
        if (npc[0].iq  < 12)
        {   npc[0].iq  = 12;
        }
        if (npc[0].dex < 12)
        {   npc[0].dex = 12;
        }
        npc[0].max_st  = npc[0].st;
        npc[0].max_con = npc[0].con;
        // we could generate eg. height for him, but that's rather pointless
        recalc_ap(0);
        ak_odds();
        do
        {   result1 = dice(1);
            result2 = dice(1);
        } while (result1 == result2);
        if (result1 > result2)
        {   room = 14;
        } else
        {   room = 20;
        }
    acase 27:
        // 27A
        // 27B
        if (!castspell(-1, TRUE))
        {   // 27C
            if (shooting())
            {   ak_missile_pb(SIZE_LARGE);
        }   }
        if (room == 27)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 134;
        }   }
    acase 28:
        good_takehits(npc[0].mr, TRUE); // %%: do they mean to give it a free attack, or just to take its MR as hits? We assume the latter.
        // %%: does this count as a round?
        if (con <= 5)
        {   room = 1;
        } else
        {   room = 6;
        }
/*  acase 30:
        // the pickaxe gets autolooted
        // it doesn't seem to be allowed to steal his crown
*/  acase 31:
        // 31A
        opponent = 4;
        fought[4]++;
        create_monsters(149, fought[4]);
        for (i = 0; i < fought[4]; i++)
        {   npc[i].st      = best3of4();
            npc[i].iq      = best3of4();
            npc[i].lk      = best3of4();
            npc[i].con     = best3of4();
            npc[i].dex     = best3of4();
            npc[i].chr     = best3of4();
            npc[i].spd     = best3of4();
            npc[i].max_st  = npc[i].st;
            npc[i].max_con = npc[i].con;
            // we could generate eg. heights for them, but that's rather pointless
            recalc_ap(i);
        }
        ak_odds();
        // 31B
        if (!castspell(-1, TRUE))
        {   // 31C
            ak_missile(SIZE_LARGE);
        }
        // 31D
        if (room == 31)
        {   if (!countfoes())
            {   room = 190;
            } elif (getyn("Dodge (otherwise fight)"))
            {   room = 129;
            } else
            {   room = 82;
        }   }
    acase 32:
        opponent = 14;
        fought[14]++;
        create_monster(158);
        npc[0].st      = dice(3) + 15;
        npc[0].iq      = dice(3) + 15;
        npc[0].lk      = dice(3) + 15;
        npc[0].con     = dice(3) + 15;
        npc[0].dex     = dice(3) + 15;
        npc[0].chr     = dice(3) + 15;
        npc[0].spd     = dice(3) + 15;
        npc[0].max_st  = npc[0].st;
        npc[0].max_con = npc[0].con;
        // we could generate eg. height for her, but that's rather pointless
        recalc_ap(0);
        ak_odds();
        if (dice(1) >= 5)
        {   room = 107;
        } else
        {   room = 137;
        }
    acase 34:
        savedrooms(5 * countfoes(), lk, 58, 167);
    acase 35:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (highesthp() <= 5)
            {   room = 190;
        }   }
        while (room == 35);
    acase 36:
        good_freeattack();
        if (highesthp() <= 5)
        {   room = 190;
        } else
        {   room = 122;
        }
    acase 37:
        good_freeattack();
        if (npc[0].mr <= weak)
        {   room = 190;
        } else
        {   room = 158;
        }
    acase 38:
        // 38A
        opponent = 5;
        fought[5]++;
        create_monsters(150, fought[5]);
        for (i = 0; i < fought[5]; i++)
        {   npc[i].st      = dice(4);
            npc[i].iq      = dice(3);
            npc[i].lk      = dice(3);
            npc[i].con     = dice(4);
            npc[i].dex     = dice(3);
            npc[i].chr     = dice(2);;
            npc[i].spd     = dice(3);
            npc[i].max_st  = npc[i].st;
            npc[i].max_con = npc[i].con;
            // we could generate eg. heights for them, but that's rather pointless
            recalc_ap(i);
        }
        ak_odds();
        // 38B
        if (!castspell(-1, TRUE))
        {   // 38C
            ak_missile(SIZE_LARGE);
        }
        // 38D
        if (room == 38)
        {   if (!countfoes())
            {   room = 190;
            } elif (getyn("Dodge (otherwise fight)"))
            {   room = 121;
            } else
            {   room = 99;
        }   }
    acase 40:
        opponent = 14;
        fought[14]++;
        create_monster(154); // we are assuming "lizard-scale armour" is the same as ordinary scale mail.
        npc[0].st      = dice(4) + 5;
        npc[0].iq      = dice(3) + 4;
        npc[0].lk      = dice(4) + 5;
        npc[0].con     = dice(4) + 5;
        npc[0].dex     = dice(3) + 4;
        npc[0].chr     = dice(2);
        npc[0].spd     = dice(3);
        if (npc[0].st < 12)
        {   npc[0].st = 12;
        }
        if (npc[0].iq < 12)
        {   npc[0].iq = 12;
        }
        if (npc[0].lk < 12)
        {   npc[0].lk = 12;
        }
        if (npc[0].con < 12)
        {   npc[0].con = 12;
        }
        if (npc[0].dex < 12)
        {   npc[0].dex = 12;
        }
        if (npc[0].spd < 12)
        {   npc[0].spd = 12;
        }
        npc[0].max_st  = npc[0].st;
        npc[0].max_con = npc[0].con;
        // we could generate eg. height for him, but that's rather pointless
        recalc_ap(0);
        ak_odds();
        do
        {   result1 = dice(1);
            result2 = dice(1);
        } while (result1 == result2);
        if (result1 > result2)
        {   room = 134;
        } else
        {   room = 27;
        }
    acase 42:
        if (highesthp() <= 8)
        {   room = 190;
        } else
        {   room = 22;
        }
    acase 43:
        savedrooms(5 * countfoes(), lk, 59, 48);
    acase 44:
        // 44A
        opponent = 6;
        fought[6]++;
        create_monsters(151, fought[6]);
        for (i = 0; i < fought[6]; i++)
        {   npc[i].st      = dice(4) * 2;
            npc[i].iq      = dice(3) / 2;
            npc[i].lk      = dice(3);
            npc[i].con     = dice(4) * 2;
            npc[i].dex     = dice(3);
            npc[i].chr     = dice(3) / 2;
            npc[i].spd     = dice(3);
            npc[i].max_st  = npc[i].st;
            npc[i].max_con = npc[i].con;
            // we could generate eg. heights for them, but that's rather pointless
            recalc_ap(i);
        }
        ak_odds();
        // 44B
        if (!castspell(-1, TRUE))
        {   // 44C
            ak_missile(SIZE_HUGE);
        }
        // 44D
        if (room == 44)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 93;
        }   }
    acase 45:
        // 45A
        if (getyn("Yield (otherwise attack)"))
        {   room = 116;
        } else
        {   // 45B
            if (!castspell(-1, TRUE))
            {   // 45C
                if (shooting())
                {   ak_missile_near(SIZE_LARGE);
            }   }
            // 45D
            if (room == 45)
            {   if (!countfoes())
                {   room = 190;
                } else
                {   room = 119;
        }   }   }
    acase 46:
        if (prevroom == 91)
        {   if (enchanted_missile())
            {   evil_takemissilehits(0);
            } elif (race == TROLL || race == GIANT)
            {   room = 189;
            } else
            {   room = 143;
        }   }
        elif (prevroom == 183)
        {   if (enchanted_melee())
            {   good_freeattack();
            } elif (race == TROLL || race == GIANT)
            {   room = 189;
            } else
            {   room = 143;
        }   }
        if (room == 46 && npc[0].mr <= weak)
        {   room = 190;
        }
    acase 48:
        // %%: do they mean to give it a free attack, or just to take its MR as hits? We assume the latter.
        for (i = 0; i < MAX_MONSTERS; i++) // %%: we assume if there are several that they all get to hurt the player
        {   if (npc[i].mr)
            {   if (armour == PLA || armour == RIN)
                {   good_takehits(npc[i].mr / 2, TRUE);
                } else
                {   good_takehits(npc[i].mr, TRUE); // %%: does "complete ring-jointed plate" count as "plate"? We assume so.
        }   }   }
        if (con <= 0)
        {   room = 1;
        } elif (con <= 5)
        {   room = 53;
        } else
        {   room = 59;
        }
    acase 49:
        // 49A
        opponent = 7;
        fought[7]++;
        create_monsters(152, fought[7]);
        for (i = 0; i < fought[7]; i++)
        {   npc[i].st      = dice(4) * 2;
            npc[i].iq      = dice(3) / 2;
            npc[i].lk      = dice(3);
            npc[i].con     = dice(4) * 2;
            npc[i].dex     = dice(3);
            npc[i].chr     = dice(3) / 2;
            npc[i].spd     = dice(3);
            npc[i].max_st  = npc[i].st;
            npc[i].max_con = npc[i].con;
            // we could generate eg. heights for them, but that's rather pointless
            recalc_ap(i);
        }
        ak_odds();
        // 49B
        if (!castspell(-1, TRUE))
        {   // 49C
            ak_missile(SIZE_HUGE);
        }
        // 49D
        if (room == 49)
        {   if (!countfoes())
            {   room = 190;
            } elif (getyn("Dodge (otherwise fight)"))
            {   room = 131;
            } else
            {   room = 105;
        }   }
    acase 50:
        // 50A
        // 50B
        if (!castspell(-1, TRUE))
        {   // 50C
            if (shooting()) // %%: what range?
            {   room = 76;
        }   }
        // 50D
        if (room == 50)
        {   room = 96;
        }
    acase 51:
        opponent = 14;
        fought[14]++;
        create_monster(155);
        npc[0].st      =  dice(3)          + 5;
        npc[0].iq      = (dice(3) * 2    ) + 5;
        npc[0].lk      =  dice(3)          + 5;
        npc[0].con     = (dice(3) * 2 / 3) + 5;
        npc[0].dex     = (dice(3) * 2    ) + 5;
        npc[0].chr     = (dice(3) * 2    ) + 5;
        npc[0].spd     =  dice(3)          + 5;
        npc[0].max_st  = npc[0].st;
        npc[0].max_con = npc[0].con;
        // we could generate eg. height for her, but that's rather pointless
        recalc_ap(0);
        ak_odds();
        do
        {   result1 = dice(1);
            result2 = dice(1);
        } while (result1 == result2);
        if (result1 > result2)
        {   room = 119;
        } else
        {   room = 45;
        }
    acase 52:
        if (con <= 0)
        {   room = 1;
        } elif (highesthp() <= 8)
        {   room = 190;
        } elif (con <= 5)
        {   room = 1;
        } else
        {   room = 22;
        }
    acase 55:
        result1 = dice(1);
        opponent = 7 + result1;
        fought[7 + result1]++;
        switch (result1)
        {
        case 1:
            create_monsters(138, fought[8]);
            room = 62;
        acase 2:
            create_monsters(139, fought[9]);
            room = 68;
        acase 3:
            create_monsters(140, fought[10]);
            room = 72;
        acase 4:
            create_monsters(141, fought[11]);
            room = 85;
        acase 5:
            create_monsters(142, fought[12]);
            room = 89;
        acase 6:
            create_monsters(143, fought[13]);
            room = 100;
        }
        ak_odds();
    acase 56:
        // 56A
        // already created at AK67
        // 56B
        if (!castspell(-1, TRUE))
        {   // 56C
            ak_missile(SIZE_LARGE);
        }
        // 56D
        if (room == 56)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 160;
        }   }
    acase 57:
        // 57A
        if (prevroom != 133 && race == HUMAN)
        {   room = 133;
        } else
        {   // 57B
            if (!castspell(-1, TRUE))
            {   // 57C
               ak_missile(SIZE_LARGE);
            }
            // 57D
            if (room == 57)
            {   if (!countfoes())
                {   room = 190;
                } else
                {   room = 182;
        }   }   }
    acase 58:
        // %%: what if they have 2 primary weapons (1 in each hand)?
        if (both != EMPTY)
        {   dropitem(both);
        }
        if (rt != EMPTY)
        {   dropitem(rt);
        }
        if (lt != EMPTY)
        {   dropitem(lt);
        }
    acase 59:
        savedrooms(3 * countfoes(), lk, 80, 70);
    acase 60:
        for (i = 0; i < MAX_MONSTERS; i++) // %%: we assume if there are several that they all get to hurt the player
        {   if (npc[i].mr)
            {   good_takehits(npc[i].mr, TRUE); // %%: do they mean to give it a free attack, or just to take its MR as hits? We assume the latter.
        }   }
        if (con <= 5)
        {   room = 1;
        } else
        {   room = 97;
        }
    acase 61:
        wizlevel = dice(1);
        switch (wizlevel)
        {
        case 1:
            room = 26;
        acase 2:
            room = 40;
        acase 3:
            room = 51;
        acase 4:
            room = 101;
        acase 5:
            room = 165;
        acase 6:
            room = 32;
        }
    acase 62: // Lion (Beast)
        // 62A
        // 62B
        if (!castspell(-1, TRUE))
        {   // 62C
            ak_missile(SIZE_HUGE);
        }
        // 62D
        if (room == 62)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 108;
        }   }
    acase 64: // Werewolf (Monster)
        // 64A
        // 64B
        if (!castspell(-1, TRUE))
        {   // 64C
            if (shooting())
            {   if (shot(RANGE_NEAR, SIZE_LARGE, FALSE))
                {   room = 151;
                } else
                {   room = 28;
        }   }   }
        if (room == 64)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 6;
        }   }
    acase 65:
        good_freeattack();
        templose_con(dice(countfoes())); // %%: we assume this is per eagle
        if (con <= 0)
        {   room = 1;
        } elif (!countfoes())
        {   room = 190;
        } elif (con <= 5)
        {   room = 53;
        } else
        {   room = 80;
        }
    acase 66:
        oneround();
        if (!countfoes())
        {   room = 190;
        } elif (con <= 5)
        {   room = 1;
        } elif (evil_hitstaken >= 1)
        {   room = 103;
        } else
        {   room = 109;
        } // %%: what if it is a draw? and what if someone took all their hits on armour?
    acase 67:
        result1 = dice(1);
        opponent = 14 + result1;
        fought[14 + result1]++;
        switch (result1)
        {
        case 1:
            create_monster(159);
            poisonstrength = 0;
            room = 10;
        acase 2:
            create_monster(160);
            room = 21;
        acase 3:
            create_monster(161);
            room = 56;
        acase 4:
            create_monster(162);
            room = 57;
        acase 5:
            create_monster(163);
            room = 64;
        acase 6:
            create_monster(164);
            room = 91;
        }
        if (fought[14 + result1] >= 2)
        {   npc[0].mr *= 2;
        }
        weak = npc[0].mr / 10;
        ak_odds();
    acase 68: // Snake (Beast)
        // 68A
        // 68B
        if (!castspell(-1, TRUE))
        {   // 68C
            ak_missile(SIZE_LARGE);
        }
        // 68D
        if (room == 68)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 23;
        }   }
    acase 69:
        for (i = 0; i < MAX_MONSTERS; i++) // %%: we assume if there are several that they all get to hurt the player
        {   if (npc[i].mr)
            {   good_takehits(dice(3), TRUE);
        }   }
        if (con <= 0)
        {   room = 1;
        } elif (con <= 5)
        {   room = 2;
        } else
        {   room = 75;
        }
    acase 70:
        if (dice(1) % 2 == 1)
        {   gain_flag_ability(39);
        } else
        {   gain_flag_ability(40);
        }
    acase 71:
        ok = FALSE;
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && (items[i].dice || items[i].adds))
            {   ok = TRUE;
                break;
        }   }
        if (!ok)
        {   give(BRO);
        }
        if ((gp * 100) + (sp * 10) + cp >= 5000 && getyn("Buy magic"))
        {   room = 155;
        } else
        {   ak_wandering();
        }
    acase 72: // Eagle (Beast)
        // 72A
        // 72B
        if (!castspell(-1, TRUE))
        {   // 72C
            if (shooting())
            {   ak_missile_extreme(SIZE_LARGE);
        }   }
        // 72D
        if (room == 72)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 122;
        }   }
    acase 73:
        good_freeattack();
        if (npc[0].mr <= weak)
        {   room = 190;
        } else
        {   room = 182;
        }
    acase 74:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (npc[0].con <= 5)
            {   room = 190;
            } elif (con <= 5)
            {   room = 2;
        }   }
        while (room == 74);
    acase 75:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (highesthp() <= 5)
            {   room = 190;
            } elif (con <= 5)
            {   room = 2;
        }   }
        while (room == 75);
    acase 76:
        result1 = dice(2);
        if (result1 == 2 || result1 == 3)
        {   room = 30;
        } else
        {   room = 96;
        }
    acase 77:
        drop_all();
        give(LEA);
        if (class == WIZARD)
        {   give(SAX);
        } else
        {   give(BRO);
        }
        ak_wandering();
    acase 79:
        good_freeattack();
        if (highesthp() <= 12)
        {   room = 190;
        } else
        {   room = 23;
        }
    acase 80:
        if (been[80])
        {   room = 84;
        } else
        {   room = 122;
        }
    acase 81:
        do
        {   if (!saved(countfoes(), lk))
            {   templose_con(misseditby(countfoes(), lk)); // %%: does armour help?
            }
            oneround();
            if (con <= 0)
            {   room = 1;
            } elif (highesthp() <= 5)
            {   room = 190;
            } elif (con <= 5)
            {   room = 2;
        }   }
        while (room == 81);
    acase 82:
        if (!saved(countfoes(), iq))
        {   evil_freeattack();
        }
        if (con <= 0)
        {   room = 1;
        } else
        {   room = 152;
        }
    acase 83:
        target = gettarget();
        if (target != -1 && saved(3 * countfoes(), dex))
        {   evil_takehits(target, dice(items[rt].dice) + items[rt].adds);
        }
        if (!countfoes())
        {   room = 190;
        } else
        {   room = 81;
        }
/*  acase 84:
        // %%: what if you are immune to poison?
*/  acase 85: // Crocodile (Beast)
        // 85A
        // 85B
        if (!castspell(-1, TRUE))
        {   // 85C
            ak_missile(SIZE_SMALL);
        }
        // 85D
        if (room == 85)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 138;
        }   }
    acase 86:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (npc[0].mr <= weak)
            {   room = 190;
        }   }
        while (room == 86);
    acase 88:
        do
        {   oneround();
            if (con > 5 && countfoes())
            {   if (lk > dex)
                {   if (!saved(theround * countfoes(), lk))
                    {   good_takehits(misseditby(theround, lk), TRUE);
                }   }
                else
                {   if (!saved(theround * countfoes(), dex))
                    {   good_takehits(misseditby(theround, dex), TRUE);
            }   }   }
            if (con <= 0)
            {   room = 1;
            } elif (highesthp() <= 5) // %%: we assume this is what it means here by "disable"
            {   room = 190;
            } elif (con <= 5)
            {   room = 2;
        }   }
        while (room == 88);
    acase 89: // Elephant (Beast)
        // 89A
        // 89B
        if (!castspell(-1, TRUE))
        {   // 89C
            ak_missile(SIZE_HUGE);
        }
        // 89D
        if (room == 89)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 149;
        }   }
    acase 90:
        if (con >= 5000)
        {   room = 169;
        } else
        {   room = 1;
        }
    acase 91: // Shoggoth (Monster)
        // 91A
        // 91B
        if (!castspell(-1, TRUE))
        {   // 91C
            if (shooting() && shot(RANGE_NEAR, SIZE_HUGE, FALSE))
            {   room = 46;
        }   }
        // 91D
        if (room == 91)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   savedrooms(5, iq, 8, 183);
        }   }
    acase 92:
        for (i = 0; i < MAX_MONSTERS; i++) // %%: we assume if there are several that they all get to hurt the player
        {   if (npc[i].mr)
            {   good_takehits(npc[i].mr, TRUE); // %%: do they mean to give it a free attack, or just to take its MR as hits? We assume the latter.
        }   }
        evil_takehits(0, dice(1));
        if (con <= 5)
        {   room = 1;
        } elif (highesthp() <= 12)
        {   room = 190;
        } else
        {   room = 23;
        }
    acase 93:
        if (race == OGRE || race == TROLL || race == GIANT)
        {   do
            {   oneround();
                if (con <= 0)
                {   room = 1;
                } elif (highesthp() <= 5)
                {   room = 190;
                } elif (con <= 5)
                {   room = 2;
            }   }
            while (room == 93);
        } else
        {   do
            {   if (saved((theround + 1) * countfoes(), lk))
                {   good_freeattack();
                } else
                {   good_takehits(misseditby((theround + 1) * countfoes(), lk), TRUE);
                }
                if (con <= 0)
                {   room = 1;
                } elif (highesthp() <= 5)
                {   room = 190;
                } elif (con <= 5)
                {   room = 2;
            }   }
            while (room == 93);
        }
    acase 95:
        if (armour == EMPTY)
        {   savedrooms(2 * countfoes(), st, 118, 60);
        } else
        {   savedrooms(4 * countfoes(), st, 118, 60);
        }
    acase 96:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (con <= 5)
            {   room = 2;
            } elif (evil_hitstaken)
            {   room = 30;
        }   }
        while (room == 96);
    acase 97:
        do
        {   oneround();
            if (st <= 5 || con <= 5)
            {   room = 1;
            } elif (highesthp() <= 7)
            {   room = 190;
            } else
            {   templose_st(dice(1) * countfoes()); // %%: we assume this is per crocodile
        }   }
        while (room == 97);
    acase 99:
        if (!saved(2 * countfoes(), dex))
        {   templose_con(misseditby(2 * countfoes(), dex));
        }
        getsavingthrow(FALSE);
        for (i = 0; i < MAX_MONSTERS; i++)
        {   // %%: does each orc have to do this? We assume so.
            if (npc[i].con && !madeit(2, npc[i].dex))
            {   npc_templose_hp(i, misseditby(2, npc[i].dex));
        }   }
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (st <= 5 || con <= 5)
            {   room = 2;
            } elif (highesthp() <= 5)
            {   room = 190;
        }   }
        while (room == 99);
    acase 100: // Ape (Beast)
        // 100A
        if (getyn("Use bananas")) // %%: it doesn't say whether you always carry bananas around :-)
        {   room = 4;
        } else
        {   // 100B
            if (!castspell(-1, TRUE))
            {   // 100C
                ak_missile(SIZE_HUGE);
            }
            // 100D
            if (room == 100)
            {   if (!countfoes())
                {   room = 190;
                } else
                {   room = 159;
        }   }   }
    acase 101:
        opponent = 14;
        fought[14]++;
        create_monster(156);
        // we could generate eg. height for him, but that's rather pointless
        ak_odds();
        do
        {   result1 = dice(2);
            result2 = dice(3);
        } while (result1 == result2);
        if (result1 > result2)
        {   room = 50;
        } else
        {   room = 96;
        }
    acase 103:
        do
        {   oneround();
            if (con <= 5)
            {   room = 1;
            } elif (highesthp() <= 7)
            {   room = 190;
        }   }
        while (room == 103);
    acase 105:
        if (race == OGRE || race == TROLL || race == GIANT || !races[race].humanoid)
        {   do
            {   oneround();
                if (con <= 0)
                {   room = 1;
                } elif (!countfoes())
                {   room = 190;
                } elif (con <= 5)
                {   room = 2;
            }   }
            while (room == 105);
        } else
        {   do
            {   if (saved((theround + 1) * countfoes(), con))
                {   good_freeattack(); // %%: "gets no hits on you" is rather ambiguous
                } else
                {   oneround();
                }
                if (con <= 0)
                {   room = 1;
                } elif (!countfoes())
                {   room = 190;
                } elif (con <= 5)
                {   room = 1;
            }   }
            while (room == 105);
        }
    acase 107:
        // 107A
        if (getyn("Yield"))
        {   room = 15;
        } else
        {   // 107B
            if (!castspell(-1, TRUE))
            {   // 107C
                if (shooting())
                {   ak_missile_near(SIZE_LARGE);
            }   }
            if (room == 107)
            {   if (!countfoes())
                {   room = 190;
                } else
                {   // 107D
                    room = 137;
        }   }   }
    acase 110:
        good_takehits(100, TRUE); // %%: does armour help? We assume so.
        // %%: what if there are multiple apes? We are assuming only one of our arms get ripped out.
        // when we implement the missing arm properly, we will have to determine which arm it was (or assume right arm), then modify right()/left() as appropriate.
        if (con <= 0)
        {   room = 1;
        } else
        {   room = 123;
        }
    acase 111:
        if (armour >= PLA && armour <= RIN)
        {   if (saved(2, lk))
            {   room = 39;
        }   }
        elif (armour >= LEA && armour <= QUI)
        {   if (saved(3, lk))
            {   room = 39;
        }   }
        else
        {   if (saved(4, lk))
            {   room = 39;
        }   }
        if (room == 111)
        {   room = 141;
        }
    acase 114:
        if (race == GIANT || race == TROLL) // %%: OGRE is omitted, but this might be intentional
        {   do
            {   oneround();
                if (con <= 0)
                {   room = 1;
                } elif (highesthp() <= 5)
                {   room = 190;
                } elif (con <= 5)
                {   room = 2;
            }   }
            while (room == 114);
        } else
        {   do
            {   if (saved((theround + 1) * countfoes(), st) && saved((theround + 1) * countfoes(), dex))
                {   good_freeattack();
                } else
                {   oneround();
                }
                if (con <= 0)
                {   room = 1;
                } elif (highesthp() <= 5)
                {   room = 190;
                } elif (con <= 5)
                {   room = 2;
            }   }
            while (room == 114);
        }
    acase 115:
        theround = 2;
        savedrooms(1, lk, 144, 2);
    acase 116:
        savedrooms(2, chr, 147, 119);
    acase 117:
        // her ST loss is handled at AK137
        if (npc[0].st <= 5)
        {   room = 190;
        } else
        {   room = 32;
        }
    acase 118:
        good_freeattack();
        if (highesthp() <= 7)
        {   room = 190;
        } else
        {   room = 103;
        }
    acase 119:
        // 119A
        if (npc[0].st < 20)
        {   npc_templose_st(0, 11); // (6*2)-1
            if (npc[0].st >= 0)
            {   good_takehits(2 * npc[0].iq, TRUE);
            }
            if (con <= 0)
            {   room = 1;
            } elif (con <= 5)
            {   room = 2;
        }   }
        if (room == 119)
        {   // 119B
            if (!castspell(-1, TRUE))
            {   // 119C
                if (shooting())
                {   ak_missile_near(SIZE_LARGE);
            }   }
            // 119D
            if (room == 119)
            {   if (!countfoes())
                {   room = 190;
                } else
                {   room = 74;
        }   }   }
    acase 120:
        evil_freeattack();
        if (con <= 0)
        {   room = 1;
        } else
        {   good_freeattack(); // %%: it's ambiguous about whether we get all our hits or only some of them
            if (highesthp() <= 5)
            {   room = 190;
            } elif (con <= 5)
            {   room = 1;
            } else
            {   room = 139;
        }   }
    acase 121:
        // %%: it's ambiguous about what happens if there are multiple orcs
        if (!saved(    countfoes(), lk))
        {   good_takehits(dice(2) + calc_personaladds(npc[0].st, npc[0].lk, npc[0].dex), TRUE);
        }
        if (!saved(2 * countfoes(), lk))
        {   good_takehits(dice(2) + calc_personaladds(npc[0].st, npc[0].lk, npc[0].dex), TRUE);
        }
        if (!saved(3 * countfoes(), lk))
        {   good_takehits(dice(2) + calc_personaladds(npc[0].st, npc[0].lk, npc[0].dex), TRUE);
        }
        if (con <= 0)
        {   room = 1;
        } elif (con <= 5)
        {   room = 2;
        } else
        {   room = 99;
        }
    acase 122:
        savedrooms(3, dex, 36, 43);
    acase 123:
        permlose_con(100); // %%: it's ambiguous about medication
        permlose_st(st / 2);
        lose_lk(lk / 2);
        lose_chr(chr / 2);
        gain_flag_ability(41);
    acase 125:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (npc[0].mr <= weak)
            {   room = 190;
            } elif (con <= 5)
            {   room = 132;
            } elif (good_hitstaken >= 1)
            {   room = 111;
        }   }
        while (room == 125);
        // %%: this paragraph is really ambiguous and/or illogical
    acase 126:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (!countfoes())
            {   room = 190;
            } elif (con <= 5)
            {   room = 2;
            } elif (evil_hitstaken >= 1)
            {   room = 75;
            } // %%: ambiguous about a draw
        } while (room == 126);
    acase 127: // Hobbit(s)
        // 127A
        if (npc[0].dex >= 16 || dice(1) % 2 == 1) // %%: does each hobbit get a chance, or just one? Should we randomly choose which one it is?
        {   room = 9;
        } else
        {   // 127B
            if (!castspell(-1, TRUE))
            {   // 127C
                if (shooting())
                {   room = 83;
            }   }
            if (room == 127)
            {   if (!countfoes())
                {   room = 190;
                } else
                {   room = 81;
        }   }   }
    acase 128: // Dwarf/Dwarves
        // 128A
        // 128B
        if (!castspell(-1, TRUE))
        {   // 127C
            if (shooting())
            {   ak_missile_pb(SIZE_SMALL);
        }   }
        // 128D
        if (room == 128)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 88;
        }   }
    acase 129: // Man/Men
        // 129A
        // 129B
        if (!castspell(-1, TRUE))
        {   // 129C
            ak_missile(SIZE_LARGE);
        }
        // 129D
        if (room == 129)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 82;
        }   }
    acase 130:
        if (!ability[22].known && st + iq + chr < 100)
        {   room = 144;
        } else
        {   room = 190;
        }
    acase 131:
        // 131A
        if (saved(2 * countfoes(), spd))
        {   // 131B
            if (!castspell(-1, TRUE))
            {   // 131C
                ak_missile_pb(SIZE_HUGE);
        }   }
        // 131D
        if (room == 131)
        {   if (!countfoes())
            {   room = 190;
            } else
            {   room = 105;
        }   }
    acase 132:
        if (con <= 5)
        {   if (pay_gp(100))
            {   room = 144;
            } else
            {   die();
        }   }
        // %%: it doesn't say what to do if your CON is >= 6
    acase 133:
#ifdef CENSORED
        savedrooms(1, chr, 29, 57);
#else
        room = ability[88].known ? 29 : 57;
#endif
    acase 134:
        // 134A
        if (npc[0].con < npc[0].max_con)
        {   npc_templose_st(0, 12);
            if (npc[0].st >= 0)
            {   good_takehits(npc[0].iq * 2, TRUE);
            }
            if (con <= 0)
            {   room = 1;
            } elif (con <= 5)
            {   room = 2;
            } elif (npc[0].st <= 5)
            {   room = 190;
        }   }
        // 134B
        if (room == 134 && npc[0].con == npc[0].max_con)
        {   npc_templose_st(0, 10);
            if (npc[0].st <= 5)
            {   room = 190;
        }   }
        if (room == 134)
        {   if (getyn("Use magic/missiles"))
            {   room = 27;
            } else
            {   room = 16;
        }   }
    acase 136:
        damage_enemies(good_attacktotal - evil_attacktotal);
        if (highesthp() <= 20)
        {   room = 190;
        } else
        {   savedrooms(3 * countfoes(), dex, 178, 171);
        }
    acase 137:
        npc_templose_st(0, 5); // see AK117
        good_takehits(dice(6) + calc_personaladds(npc[0].st, npc[0].lk, npc[0].dex), TRUE);
        if (con <= 0)
        {   room = 1;
        } elif (con <= 5)
        {   room = 2;
        } else
        {   savedrooms(2, lk, 177, 2);
        }
    acase 138:
        savedrooms(countfoes(), lk, 54, 60);
    acase 139:
        templose_con(npc[0].mr); // %%: do they mean to give it a free attack, or just to take its MR from CON? We assume the latter.
        if (con <= 5)
        {   room = 1;
        } else
        {   room = 169;
        }
    acase 140:
        ; // this isn't implemented as there's no way to get here!
    acase 141:
        poisonstrength = dice(1) + 5;
        room = 153;
    acase 142:
        if (saved(countfoes(), spd))
        {   room = 114;
        } else
        {   evil_freeattack();
            if (con <= 0)
            {   room = 1;
            } elif (con <= 5)
            {   room = 2;
            } elif (getyn("Use magic (otherwise fight)"))
            {   room = 7;
            } else
            {   room = 114;
        }   }
    acase 143:
        if (race == TROLL || race == GIANT)
        {   room = 189;
        } else
        {   room = 12;
        }
    acase 144:
        ak_fights++;

        if (betfor)
        {   pay_cp(betfor);
        }
        if (betagainst)
        {   normalized_a = (float) a / (float) y;
            prize = (int) (betagainst / normalized_a);
            give_money(prize);
        }

        healall_st();

        result1 = anydice(1, 10);
        aprintf("%d days until next fight.\n", result1);

        for (i = 1; i < result1; i++)
        {   if (spell[SPELL_RS].known)
            {   heal_con(1);
            }
            elapse(ONE_DAY, FALSE);
        }

        limit = max_con - con;
        if (money < 10000 * limit)
        {   limit = money / 10000;
        }
        if (limit >= 1)
        {   result1 = getnumber("Heal how many CON points @ 100 gp each", 0, limit);
            if (result1 && pay_gp(100 * result1))
            {   heal_con(result1);
        }   }

        if ((max_con >= 20 && con < 10) || (max_con < 20 && con <= max_con / 2))
        {   room = 148;
        } else
        {   room = 192;
        }
    acase 145:
        lose_chr(5);
        change_lk(7);
        gain_flag_ability(42);
    acase 146:
        if (ak_fights % 10 == 10)
        {   room = 170;
        } elif (ak_fights >= 11) // *not* ak_fights % 10 (of course)
        {   room = 71;
        } else
        {   room = 155;
        }
    acase 147:
        dispose_npcs();
        gain_chr(3);
        give_gp(22222);
        award(1000);
        give(395);
        if (getyn("Depart arena"))
        {   victory(0);
        } else
        {   room = 192;
        }
    acase 148:
        if (getyn("Accept conditions"))
        {   healall_con();
            room = 192;
        } else
        {   room = 154;
        }
    acase 149:
        if (race == GIANT || race == TROLL || race == OGRE)
        {   room = 156;
        } else
        {   savedrooms(2, spd, 157, 139);
        }
    acase 150:
        if (npc[0].con <= 5)
        {   room = 190;
        } else
        {   switch (wizlevel)
            {
            case 1:
                room = 14;
            acase 2:
                room = 134;
            acase 3:
                room = 119;
            acase 4:
                room = 96;
            acase 5:
                room = 115;
            acase 6:
                room = 137;
        }   }
    acase 151:
        if (enchantedorsilver_missile())
        {   evil_takemissilehits(0);
            if (npc[0].mr <= weak)
            {   room = 190;
            } else
            {   room = 176;
        }   }
        else
        {   room = 28;
        }
    acase 152:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (!countfoes())
            {   room = 190;
            } elif (con <= 5)
            {   room = 2;
        }   }
        while (room == 152);
    acase 153:
        do
        {   oneround();
            templose_con(poisonstrength);
            if (con <= 0)
            {   room = 1;
            } elif (npc[0].mr <= weak)
            {   room = 190;
            } elif (con <= 5)
            {   room = 132;
        }   }
        while (room == 153);
        // %%: this paragraph is really ambiguous and/or illogical
    acase 155:
        if (ak_fights % 10 == 7)
        {   room = 55;
        } elif (ak_fights % 10 == 8)
        {   room = 61;
        } elif (ak_fights % 10 == 9)
        {   room = 67;
        } else
        {   ak_wandering();
        }
    acase 156:
        goodattack();
        evilattack();
        if (good_attacktotal >= evil_attacktotal)
        {   room = 136;
        } else
        {   room = 120;
        }
    acase 157:
        good_freeattack();
        if (highesthp() <= 20)
        {   room = 190;
        } else
        {   room = 161;
        }
    acase 158:
        do
        {   goodattack();
            evilattack();
            if (good_attacktotal > evil_attacktotal)
            {   room = 17;
            } else
            {   room = 173;
        }   }
        while (room == 158);
        // %%: does "scores hits on" mean before or after armour is taken into account.
    acase 159:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (highesthp() <= 10)
            {   room = 190;
            } elif (con <= 5)
            {   room = 1;
            } elif (!saved(theround * countfoes(), lk)) // %%: it doesn't say exactly when to do this saving roll
            {   good_takehits(misseditby(theround * countfoes(), lk), TRUE); // %%: does it mean to do a good_takehits() and also a templose_con()? We assume not.
        }   }
        while (room == 159);
    acase 160:
        if (armour == PLA || armour == RIN) // %%: we assume "ring-jointed plate" qualifies
        {   needed = 1;
        } elif (armour == MAI || armour == LAM)
        {   needed = 2;
        } elif (armour == LEA)
        {   needed = 3;
        } else
        {   needed = 5; // %%: what about eg. complete scale?
        }
        savedrooms(needed, lk > dex ? lk : dex, 185, 191);
    acase 161:
        if (getyn("Cast/shoot (otherwise dodge)"))
        {   room = 89;
        } elif (saved(2 * countfoes(), lk) && saved(2 * countfoes(), spd))
        {   room = 157;
        } else
        {   room = 90;
        }
    acase 164:
        ; // this isn't implemented as there's no way to get here!
    acase 165:
        opponent = 14;
        fought[14]++;
        create_monster(157);
        ak_odds();
        do
        {   result1 = daro();
            result2 = dice(4); // %%: do doubles add and roll over for him too? We assume not.
        } while (result1 == result2);
        if (result1 > result2)
        {   room = 50;
        } else
        {   room = 96;
        }
    acase 166:
        if (enchanted_melee())
        {   room = 180;
        } else
        {   room = 184;
        }
    acase 168:
        do
        {   if (saved(5 * countfoes(), dex))
            {   room = 159;
            } else
            {   oneround();
                if (con <= 0)
                {   room = 1;
                } elif (highesthp() <= 10)
                {   room = 190;
                } elif (con <= 5)
                {   room = 1;
        }   }   }
        while (room == 168);
    acase 169:
        ak_fights++;
        healall_st();
        shop();
    acase 170:
        gain_flag_ability(43);
        victory(10000);
    acase 171:
        templose_con(dice(2));
        if (con <= 5)
        {   room = 1;
        } else
        {   room = 178;
        }
    acase 173:
        if (con <= 0)
        {   room = 1;
        } elif (con <= 5)
        {   room = 2;
        } else
        {   room = 179;
        }
    acase 174:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (npc[0].mr <= weak)
            {   room = 190;
            } elif (con <= 5)
            {   room = 1;
        }   }
        while (room == 174);
    acase 175:
        savedrooms(3, dex, 73, 163);
    acase 176:
        do
        {   if (!enchantedorsilver_melee()) // %%: we assume they mean "loses its magic or silvering"
            {   room = 11;
            } else
            {   oneround();
                if (con <= 0)
                {   room = 1;
                } elif (npc[0].mr <= weak)
                {   room = 190;
                } elif (con <= 5)
                {   room = 1;
        }   }   }
        while (room == 176);
    acase 177:
        // spell already took effect back at paragraph 91
        if (npc[0].mr <= weak) // %%: the book assumes the Shoggoth is undoubled, and similarly for other Monsters in other situations
        {   room = 190;
        } else
        {   room = 143;
        }
    acase 178:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (highesthp() <= 20)
            {   room = 190;
            } elif (con <= 5)
            {   room = 1;
        }   }
        while (room == 178);
    acase 179:
        if (!enchanted_melee())
        {   room = 184;
        }
    acase 180:
        if (npc[0].mr <= weak)
        {   room = 190;
        } else
        {   room = 86;
        }
    acase 181:
        if (npc[0].mr <= weak)
        {   room = 190;
        } elif (evil_hitstaken > 50)
        {   room = 174;
        } else
        {   room = 160;
        }
    acase 183:
        if (enchanted_melee())
        {   room = 46;
        } elif (race == GIANT || race == TROLL)
        {   room = 189;
        } else
        {   room = 143;
        }
    acase 184:
        good_takehits(100, TRUE); // %%: it doesn't say whether armour helps
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && (items[i].hits || items[i].adds) && !items[i].magical)
            {   dropitems(i, items[i].owned);
        }   }
        if (con <= 0)
        {   room = 1;
        } elif (con <= 5)
        {   room = 2;
        } elif (getyn("Flee (otherwise fight)"))
        {   room = 162;
        } else
        {   room = 158;
        }
    acase 185:
        oneround();
        if (con <= 5)
        {   room = 1;
        } elif (good_attacktotal >= evil_attacktotal) // %%: it's ambiguous, especially about draws
        {   room = 181;
        } else
        {   room = 160;
        }
    acase 186:
        gain_chr(20);
        gain_lk(7);
        give(394);
    acase 187:
        if (spellchosen == SPELL_TF)
        {   room = 177;
        } elif (spellchosen == SPELL_PP)
        {   // spell already took effect back at paragraph 91
            room = 91;
        } else
        {   room = 183;
        }
    acase 188:
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (npc[0].mr <= weak)
            {   room = 190;
            } elif (con <= 5)
            {   room = 1;
        }   }
        while (room == 188);
    acase 189:
        if (st > 500)
        {   room = 172;
        } else
        {   room = 1;
        }
    acase 190:
        // 190A
        ak_fights++;
        ak_won++;
        dispose_npcs();
        if (opponent == 5)
        {   give_multi(CAP, fought[5]);
            give_multi(JAV, fought[5] * 3);
        }
        // 190B
        if (betfor)
        {   normalized_a = (float) a / (float) y;
            prize = (int) (betfor * normalized_a);
            give_money(prize);
        }
        if (betagainst)
        {   pay_cp(betagainst);
        }
        // 190C
        // %%: it doesn't say whether this is in addition to the normal ap awards for killing them. We assume not.
        // if we defeat but don't kill them, we won't get the ap award. Strictly speaking, we should.
        // 190D
        if (y > a)
        {   give_gp(100);
        } elif (y * 3 >= a)
        {   if (getyn("Take weapon (otherwise gold)"))
            {   shop_give(1);
            } else
            {   give_gp(dice(4) * 100);
        }   }
        elif (y * 7 >= a)
        {   give_gp(dice(5) * 100);
            rb_givejewel(-1, -1, 1); // %%: we assume items are not allowed
        } else
        {   ak_treasure();
        }
        // 190E
        if (con < max_con)
        {   room = 144;
        } else
        {   // 190F
            while (shop_buy(100, 'X') != -1);
            room = 192;
        }
    acase 191:
        templose_con(200);
        if (con <= 0)
        {   room = 1;
        } else
        {   room = 185;
        }
    acase 192:
        if (ak_fights % 10 <= 2)
        {   room = 155;
        } elif (ak_fights % 10 == 3)
        {   if (getyn("Sign up for 7 more fights"))
            {   give_gp(1000);
                room = 146;
            } else
            {   victory(0);
        }   }
        elif (ak_fights % 10 >= 4)
        {   room = 146;
}   }   }

MODULE void ak_wandering(void)
{   int result;

    result = dice(2);
    switch (result)
    {
    case   2: room =  7; // Giant
    acase  3: room = 13; // Gremlin
    acase  4: room = 19; // Hobbit
    acase  5: room = 25; // Dwarf
    acase  6: room = 31; // Human warrior
    acase  7: room = 38; // Orc
    acase  8: room = 44; // Ogre
    acase  9: room = 49; // Troll
    acase 10: room = 55; // Beast
    acase 11: room = 61; // Wizard/war-wiz
    acase 12: room = 67; // Monster
}   }

MODULE void ak_odds(void)
{   int limit;

    aprintf("#112:\n%s\n\n", descs[MODULE_AK][112]);
    // %%: should we increase time by 10 mins (and then another 10 when returning to previous paragraph)?

    // A1
    a = anydice(1, 10);
    // A2
    a += fought[opponent] - 1;
    // A3
    if (opponent == 7 || opponent == 0 || (opponent >= 8 && opponent <= 13 && npc[0].mr > 100))
    {   a *= 2;
    } elif (opponent == 14)
    {   // A4
        a += wizlevel;
    } elif (opponent >= 15)
    {   // A5
        a *= 3;
    }
    // A6
    if (race == WHITEHOBBIT || race == GREMLIN || race == LEPRECHAUN)
    {   a *= 2;
    }

    // Y1
    y = 1;
    // Y2
    if (ak_won >= 2)
    {   y *= ak_won;
    }
    // Y3
    if (opponent == 1 || opponent == 2 || (opponent >= 8 && opponent <= 13 && npc[0].mr <= 50))
    {   y *= 2;
    }
    // Y4
    if (class == WIZARD || class == WARRIORWIZARD)
    {   y += level;
    }
    // Y5
    if (race == TROLL || race == GIANT)
    {   y *= 2;
    }
    // Y6
    if (race == BALROG || race == DEMON || race == NAGA || race == LAMIA || race == CENTAUR || !races[race].humanoid) // %%: rather ambiguous, as it admits
    {   y *= 3;
    }

    aprintf("A:Y odds are %d:%d.\n", a, y);
    if (money > 100000)
    {   limit = 100000;
    } else
    {   limit = money;
    }
    betfor = getnumber("Bet how many gp on yourself", 0, limit / 100) * 100;
    limit -= betfor;
    betagainst = getnumber("Bet how many gp against yourself", 0, limit / 100) * 100;

    DISCARD showansi(4);
}

MODULE void ak_missile(int size)
{   int result = getnumber("0: None\n1: Pointblank\n2: Near\n3: Far\n4: Extreme far\nShoot at which range", 0, 4);

    switch (result)
    {
    case 1:
        ak_missile_pb(size);
    acase 2:
        ak_missile_near(size);
    acase 3:
        ak_missile_far(size);
    acase 4:
        ak_missile_extreme(size);
}   }

MODULE void ak_missile_pb(int size)
{   int notroom = 0, // initialized to avoid a spuriou SAS/C optimizer warning
        target;

    switch (size)
    {
    case SIZE_SMALL:
        notroom =  78;
    acase SIZE_LARGE:
        notroom = 106;
    acase SIZE_HUGE:
        notroom =  18;
    }

    aprintf("#%d:\n%s\n\n", notroom, descs[MODULE_AK][notroom]);

    if (getmissileweapon() == EMPTY || useammo() == EMPTY)
    {   return;
    }
    target = gettarget();
    if (target != -1 && shot(RANGE_POINTBLANK, size, FALSE))
    {   evil_takemissilehits(target);
        theround++;
        elapse(2, FALSE);
        if (!countfoes())
        {   room = 190;
        }
        // %%: AK18 says "second" (ie. "B") not "fourth" (ie. "D") but is probably wrong
    } else
    {   evil_freeattack();
        if (con <= 0)
        {   room = 1;
        } elif (con <= 5)
        {   if
            (   (opponent >=  8 && opponent <= 13) // Beast
             || (opponent >= 15 && opponent <= 20) // Monster
            )
            {   room = 1;
            } else
            {   room = 2;
}   }   }   }

MODULE void ak_missile_near(int size)
{   int notroom = 0, // initialized to avoid a spurious SAS/C optimizer warning
        target;

    switch (size)
    {
    case SIZE_SMALL:
        notroom = 94;
    acase SIZE_LARGE:
        notroom = 87;
    acase SIZE_HUGE:
        notroom = 33;
    }

    aprintf("#%d:\n%s\n\n", notroom, descs[MODULE_AK][notroom]);

    if (getmissileweapon() == EMPTY || useammo() == EMPTY)
    {   return;
    }
    target = gettarget();
    if (target != -1 && shot(RANGE_NEAR, size, FALSE))
    {   evil_takemissilehits(target);
        if (!countfoes())
        {   room = 190;
}   }   }

MODULE void ak_missile_far(int size)
{   int notroom = 0, // initialized to avoid a spurious SAS/C optimizer warning
        target;

    switch (size)
    {
    case SIZE_SMALL:
        notroom = 102;
    acase SIZE_LARGE:
        notroom = 124;
    acase SIZE_HUGE:
        notroom =  41;
    }

    aprintf("#%d:\n%s\n\n", notroom, descs[MODULE_AK][notroom]);

    if (getmissileweapon() == EMPTY || useammo() == EMPTY)
    {   return;
    }
    target = gettarget();
    if (target != -1 && shot(RANGE_FAR, size, FALSE))
    {   evil_takemissilehits(target);
        if (!countfoes())
        {   room = 190;
    }   }
    if (room != 190 && shooting())
    {   ak_missile_pb(size);
}   }

MODULE void ak_missile_extreme(int size)
{   int notroom = 0, // initialized to avoid a spurious SAS/C optimizer warning
        target;

    switch (size)
    {
    case SIZE_SMALL:
        notroom = 104;
    acase SIZE_LARGE:
        notroom = 135;
    acase SIZE_HUGE:
        notroom =  47;
    }

    aprintf("#%d:\n%s\n\n", notroom, descs[MODULE_AK][notroom]);

    if (items[missileweapon].range <= 100)
    {   ak_missile_far(size);
        return;
    }

    if (getmissileweapon() == EMPTY || useammo() == EMPTY)
    {   return;
    }
    target = gettarget();
    if (target != -1 && shot(RANGE_EXTREME, size, FALSE))
    {   if (size == SIZE_SMALL)
        {   award(250);
        }
        evil_takemissilehits(target);
        if (!countfoes())
        {   room = 190;
        } elif (shooting())
        {   ak_missile_pb(size);
    }   }
    else
    {   if (shooting())
        {   if (size == SIZE_LARGE)
            {   ak_missile_pb(SIZE_LARGE);
            } else
            {   ak_missile_near(size);
}   }   }   }

#define is ==
#define or ||

EXPORT void ak_magicmatrix(void)
{   aprintf("#113:\n%s\n\n", descs[MODULE_AK][113]);

    // 113A
    // 113B
    switch (spellchosen)
    {
    case SPELL_TF:
        if
        (   room is 3
         or room is 7
         or room is 10
         or room is 13
         or room is 19
         or room is 20
         or room is 21
         or room is 25
         or room is 27
         or room is 31
         or room is 38
         or room is 44
         or room is 45
         or room is 49
         or room is 50
         or room is 56
         or room is 62
         or room is 64
         or room is 68
         or room is 85
         or room is 91
         or room is 100
         or room is 119
         or room is 127
         or room is 128
         or room is 129
         or room is 131
        )
        {   fulleffect();
        } elif (room is 57 or room is 107)
        {   rebound(FALSE);
        } elif (room is 72)
        {   maybeeffect(3);
        } elif (room is 89)
        {   maybeeffect(5);
        }
   acase SPELL_VB:
   case SPELL_EH:
   case SPELL_ZA:
   case SPELL_ZP:
        fulleffect();
   acase SPELL_DD:
        if (room is 91)
        {   noeffect();
        } else
        {   fulleffect();
        }
   acase SPELL_BP:
        if     (room is 21 or room is 50 or room is 64)
        {   rebound(FALSE);
        } elif (room is 57 or room is 91)
        {   noeffect();
        } elif (room is 72)
        {   maybeeffect(3);
        } elif (room is 85 or room is 89)
        {   maybeeffect(5);
        } else
        {   fulleffect();
        }
   acase SPELL_IF:
        if     (room is 21 or room is 50 or room is 64)
        {   rebound(FALSE);
        } elif (room is 49 or room is 57 or room is 91)
        {   noeffect();
        } elif (room is 72)
        {   maybeeffect(3);
        } elif (room is 85 or room is 89)
        {   maybeeffect(5);
        } else
        {   fulleffect();
        }
   acase SPELL_PP:
        if (room is 45 or room is 50)
        {   noeffect();
        } else
        {   fulleffect();
            aprintf("Lasts for only 1 turn (10 minutes) but protects you from anything for that 1 turn. However, your foe will wait patiently for it to wear off. (Or maybe impatiently, with howls and curses.) Go back to the second part of the paragraph that sent you here, and try something else.\n");
            elapse(10, TRUE);
        }
   acase SPELL_MP:
        if (room is 3 or room is 100)
        {   maybeeffect(4);
        } elif
        (   room is 7
         or room is 20
         or room is 25
         or room is 31
         or room is 127
         or room is 128
         or room is 129
        )
        {   maybeeffect(5);
        } elif
        (   room is 10
         or room is 56
         or room is 57
         or room is 62
         or room is 64
         or room is 68
         or room is 72
         or room is 85
         or room is 89
         or room is 91
        )
        {   noeffect();
        } elif (room is 13 or room is 19)
        {   fulleffect();
        } elif (room is 21 or room is 45 or room is 119)
        {   maybeeffect(2);
        } elif
        (   room is 27
         or room is 38
         or room is 44
         or room is 49
         or room is 107
         or room is 131
        )
        {   maybeeffect(3);
        } elif (room is 50)
        {   rebound(FALSE);
        }
    acase SPELL_WA:
    case SPELL_WF:
    case SPELL_WN:
    case SPELL_W1:
    case SPELL_W2:
    case SPELL_WS:
    case SPELL_WT:
    case SPELL_W3:
    case SPELL_W4:
    case SPELL_W5:
    case SPELL_IW: // %%: does this count as a Wall spell? We assume so.
    case SPELL_BI:
    case SPELL_OW:
        if (room is 89)
        {   fulleffect();
            aprintf("The wall materialized right in front of the charging elephant and it knocked itself silly. Go to {190}.\n");
            room = 190;
        } else
        {   noeffect();
        }
    acase SPELL_SU:
        if
        (   room is 10
         or room is 49
         or room is 56
         or room is 57
         or room is 62
         or room is 64
         or room is 100
         or room is 131
        )
        {   maybeeffect(4);
        } elif
        (   room is 7
         or room is 13
         or room is 19
         or room is 25
         or room is 27
         or room is 31
         or room is 38
         or room is 44
         or room is 68
         or room is 85
         or room is 89
         or room is 127
         or room is 128
         or room is 129
        )
        {   maybeeffect(5);
        } elif (room is 3 or room is 45 or room is 119)
        {   maybeeffect(3);
        } elif (room is 20 or room is 50)
        {   maybeeffect(2);
        } elif
        (   room is 21
         or room is 72
         or room is 91
         or room is 107
        )
        {   noeffect();
        }
    acase SPELL_ME:
        if
        (   room is 3
         or room is 10
         or room is 21
         or room is 25
         or room is 44
         or room is 49
         or room is 56
         or room is 64
         or room is 89
         or room is 100
         or room is 107
         or room is 131
        )
        {   maybeeffect(4);
        } elif
        (   room is 7
         or room is 13
         or room is 19
         or room is 27
         or room is 31
         or room is 38
         or room is 127
         or room is 128
         or room is 129
        )
        {   maybeeffect(5);
        } elif (room is 20 or room is 45 or room is 119)
        {   maybeeffect(3);
        } elif (room is 68)
        {   maybeeffect(2);
        } elif
        (   room is 50
         or room is 57
         or room is 62
         or room is 72
         or room is 85
         or room is 91
        )
        {   noeffect();
        }
    acase SPELL_D9:
        if (room is 3 or room is 56)
        {   maybeeffect(4);
        } elif
        (   room is 7
         or room is 10
         or room is 13
         or room is 19
         or room is 20
         or room is 25
         or room is 27
         or room is 31
         or room is 38
         or room is 72
         or room is 85
         or room is 127
         or room is 128
         or room is 129
        )
        {   ak_tacky();
        } elif
        (   room is 21
         or room is 45
         or room is 49
         or room is 64
         or room is 100
         or room is 107
         or room is 119
         or room is 131
        )
        {   maybeeffect(3);
        } elif (room is 44)
        {   fulleffect();
        } elif (room is 50 or room is 62 or room is 91)
        {   noeffect();
        } elif (room is 57)
        {   rebound(FALSE);
        } elif (room is 68 or room is 89)
        {   maybeeffect(2);
        }
    acase SPELL_HB:
        if (room is 62 or room is 68)
        {   maybeeffect(4);
        } elif
        (   room is 3
         or room is 7
         or room is 10
         or room is 13
         or room is 19
         or room is 20
         or room is 25
         or room is 27
         or room is 31
         or room is 38
         or room is 44
         or room is 72
         or room is 85
         or room is 107
         or room is 127
         or room is 128
         or room is 129
        )
        {   ak_tacky();
        } elif
        (   room is 45
         or room is 49
         or room is 56
         or room is 119
         or room is 131
        )
        {   maybeeffect(3);
        } elif (room is 21 or room is 89)
        {   fulleffect();
        } elif (room is 50 or room is 91)
        {   noeffect();
        } elif (room is 57)
        {   rebound(FALSE);
        } elif (room is 64 or room is 100)
        {   maybeeffect(2);
        }
    adefault:
        noeffect();
    }

    // 113C
    // 113D
    // 113E
    if (opponent == 14) // wizard
    {   room = 150;
    } else
    {   // 113F
        if (opponent == 20) // shoggoth
        {   if
            (   spellchosen == SPELL_TF
             || spellchosen == SPELL_VB
             || spellchosen == SPELL_EH
             || spellchosen == SPELL_PP
             || spellchosen == SPELL_ZA
             || spellchosen == SPELL_ZP
            )
            {   room = 187;
            } else
            {   room = 143;
    }   }   }
    // 113F
}

MODULE void ak_treasure(void)
{   int result;

    // p163/36A
    aprintf(
"TABLE OF ENCHANTED WEAPONS\n" \
"  Because of your great valour in the face of very high odds, the Arena Judges have decided to award you one of the special items listed below. Weapons may be used in the Arena in later fights. Randomize between 1 and 20 to see which of the special items you are given. {Weapons on this table may only be awarded once (overall, not once per character). After you have given away a weapon, replace it on the table with 1000 gold pieces.}\n"
    );

    result = anydice(1, 20);
    aprintf("%s\n", ak_treasuretext[result - 1]);
    give(346 + result - 1);
    if (result == 11)
    {   give_multi(357, 11);
    } elif (result == 14 || result == 20)
    {   give_multi(386, 100); // %%: it doesn't say whether these use normal black powder or not. We assume that they do.
}   }

/* Errata:
 AK4: AK168 is meant instead of 30D.
 AK18 says "second" (ie. "B") not "fourth" (ie. "D") but is probably wrong
 AK137: AK117 is meant instead of AK177.
 125: more logical that if it wounds you, go to 111, and if it reduces your CON to 5 or less, go to 132.
  and similarly for 153.
 AK140 and AK164 (male wizard) are impossible to reach.
 AK190E is mislabelled as 190D.
 AK190F is mislabelled as 190E.

Monsters vs. paragraphs:
 0-2,71,77,112,113,144,146,148,154,155,170,190,192: miscellaneous
                                                    missile attacks (extreme, far, near, pointblank ranges):
 104,102,94,78:                                     small target
 135,124,87,106:                                    large target
 47,41,33,18:                                       huge  target
                                                    opponents:
7,114,142:                                          giant                                    [ 0]
13,63,69,75,126:                                    gremlin                                  [ 1]
19,9,81,83,127:                                     white hobbit                             [ 2]
25,76,88,128:                                       dwarf                                    [ 3]
31,82,129,152:                                      man                                      [ 4]
38,99,121:                                          orc                                      [ 5]
44,93:                                              ogre                                     [ 6]
49,105,131:                                         troll                                    [ 7]
55:                                                 beast
 62,5,22,34,42,52,58,108,167:                       lion                                     [ 8]
 68,23,35,79,92:                                    snake                                    [ 9]
 72,36,43,48,53,65,70,80,84,122:                    eagle                                    [10]
 85,54,60,66,95,97,103,109,118,138:                 crocodile                                [11]
 89,90,120,136,139,149,156,157,161,169,171,178:     elephant                                 [12]
 100,4,98,110,123,159,168:                          ape                                      [13]
61,150:                                             wizard/warrior-wizard                    [14]
 26,14,20:                                          L1 male   human wizard
 40,16,27,134:                                      L2 male   orc   warrior-wizard
 51,45,74,116,119,147:                              L3 female elf   wizard
 101,30,50,96:                                      L4 male   dwarf warrior-wizard ("Boron")
 165,3,115,130:                                     L5 male   human wizard
 32,15,107,117,137:                                 L6 female human wizard
67:                                                 monster
 10,39,111,125,132,141,153:                         spider                                   [15]
 21,17,37,86,158,162,166,173,179,180,184:           balrog                                   [16]
 56,160,174,181,185,191:                            manticore                                [17]
 57,29,73,133,145,163,175,182,186,188:              unicorn                                  [18]
 64,6,11,28,151,176:                                werewolf                                 [19]
 91,8,12,24,46,143,172,177,183,187,189,193:         shoggoth                                 [20]
*/

MODULE void ak_tacky(void)
{   fulleffect();
    aprintf("Tacky. Your spell worked and killed your foe, but it was tremendous overkill and very unsporting, not considered a fair victory. [Any treasure you have won in the arena is confiscated, and] you are expelled from the Arena [permanently]. Scratch off your winnings, take no extra experience points, and close the book.\n");
    dispose_npcs();
    // %%: presumably your current bet is forfeited?
    victory(0);
}

EXPORT void ak_viewman(void)
{   if (ak_fights)
    {   aprintf("\n³Arena of Khazan: ¢%d fights (%d victories, %d losses)", ak_fights, ak_won, ak_fights - ak_won);
}   }
