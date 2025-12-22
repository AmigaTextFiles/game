#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Ideally, we should integrate the "seconds" count into the general
 timing subsystem.

Ambiguities (%%):
 It doesn't say whether your coins/jewels get borrowed/destroyed along with the
  rest of your equipment. We assume so for destroyed, but not for borrowed.
Errata:
 Appendix claims that Introduction mentions dice-card chart in Appendix,
  but it doesn't (at least for Corgi version).
*/

MODULE const STRPTR gk_desc[GK_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  This solitaire is intended for a single adventurer. Characters able to use magic may play, but they will find the use of magic extremely limited. Around and inside the Gamesmen's building are powerful magnetic disturbances which make most normal spellcasting impossible. Where a player's \"intuition\" tells him a spell might work, the instructions will so indicate. Players may always, at the successful resolution of any sort of combat or action in which they sustained damage, cast a Restoration spell on themselves.[ Strength used to cast spells in this module is always regained at the rate of one point for every six paragraphs completed.]\n" \
"  The Game is designed by the Gamesmen to accommodate all levels of characters. Their laws require the Game to be fair; they do not, however, require it to be easy...\n" \
"  In the game itself, certain saving rolls - designated SR* - are to be made by the player according to the following formula: The level of the saving roll is equal to the attribute it must be made upon divided by ten, all fractions dropped. Example: a saving roll to be made by a character with a DEX of 20 will be 20 ÷ 10 = 2, or a second level saving roll. Any attribute below 10 will result in a level 0 saving roll, which is to say that the character must simply roll a 5, doubles add and reroll, to make the saving roll. To roll a 3 or a non-double 4 is to fail.\n" \
"  The Gamesmen use this formula to tailor each challenge to the character in the interests of fairness.\n" \
"  Players receive adventure points in this module as follows: they get 10 ap per paragraph survived, plus any bonus ap for fighting and killing monsters, plus ap for casting spells and rolling SRs, as given in the Rules Section of this book. Finally, they receive 150 ap per level when they successfully emerge from the GM building, ie. they win the Game.\n" \
"  The Game will test of a player's attributes before it is over. Emphasis is more on saving rolls than on combat. What fighting there is, however, will be hard, and there will be more emphasis on luck (of the dice) and on personal adds than on equipment.\n" \
"  Immortal characters can be killed in the Game. [Wishes and magic devices, except those bestowed on characters during the Game, will absolutely not function inside the GM building. Magnetic fields, remember? ]So, with all the above restrictions and requirements in mind, sharpen your pencil, get your record sheet ready, turn to paragraph {1}, and have at it.\n" \
"APPENDIX\n" \
"  You may be poisoned with spider venom.[ In game terms, this leads to paralysis. One combat round after you are poisoned, you may count only *half* your hit point total when comparing it with your opponent's hit point total. If you can kill your opponent at that point, you will survive even though you are paralysed for another 5 minutes. If you cannot kill your foe then, you will be unable to defend yourself (being completely paralysed) and will suffer the consequences.]\n" \
"  The game's Introduction indicates you can find an appendix in the back of the book which allows you to use dice in place of playing cards (in case you haven't a deck of cards available). There is no appendix; the charts needed are in the text when the topic comes up. You can use [dice or ]cards[, whichever you prefer].\n" \
"  In general, if something is explained in detail in the game text, it usually means you should keep track of it. For example, in one case you will be told how many seconds of air you have available, and how many seconds it will take to accomplish each of several possible tasks. This is followed by an explanation of what happens when you run out of air. It is up to you to keep track of how many seconds have passed as you attempt one or more tasks, and to be honest with yourself if you pass the time limit. This game, like all in the series, relies entirely upon your own honesty. No one will be there to slap your wrist if you fudge, but you will only be cheating yourself if you do.\n" \
"  If something lasts 'one hour', it lasts for 6 paragraphs as you read. This includes the possibility of bouncing between two paragraphs - each time you turn, count it as a new paragraph when figuring time.\n" \
"~  The Gamesmen of Kasar promise you will win your weight in gold - if you win.`[ No standard weight for your character has been provided in order to keep this part interesting. if you character wins, roll 2 dice and use the chart below to determine his or her weight.\n" \
"    2 -  94#     8 - 178#\n" \
"    3 - 112#     9 - 190#\n" \
"    4 - 121#    10 - 209#\n" \
"    5 - 135#    11 - 246#\n" \
"    6 - 144#    12 - 261#\n" \
"    7 - 153#]~"
},
{ // 1/1A
"In the 20th year of the reign of Grand Duke Karl Bronzo, a strange, foreign caravan arrived in Kasar. Its merchants bought a large building near the centre of the city and immediately erected a high wall around it. For weeks after, heavily-guarded wagons delivered thousands of large, heavy crates and boxes to the structure while the foreigners laboured day and night inside. At last it was finished, and, throughout the city, criers spread the news of its opening.\n" \
"  In the Grand Ducal Square of Kasar you hear a crier bellowing his message to the crowds:\n" \
"  \"Come one, come all, and play the Game.\"\n" \
"  \"Risk your life for wealth and fame!\"\n" \
"  Nearby a man is explaining the Game to the crowd. It is simple: you go through a series of special rooms and corridors where you will be challenged by the Gamesman. If you survive, you win your weight in gold coins. When asked about what happens to those who fail to meet the challenges, the agent merely shrugs and smiles.\n" \
"  \"Only the Gamesmen knows what becomes of them,\" he says, \"but to win such a rich prize, one must be willing to risk all.\"\n" \
"  If you want to go straight to the GM building and play the game, go to {15}. If you want to wait until you know more about it, go to {27}."
},
{ // 2/1B
"The man staggers, then turns rapidly. He has some sort of blunt object in his hand. If you want to assume a defensive posture and see what he does, go to {56}. If you want to grapple and try to overpower him, go to {152}. Or, if you decide you had better try to kill him, go to {119}."
},
{ // 3/1C
"You creep painfully along until, finally, another grate appears. Peeking through it, you see an odd-looking, metal man come down the hall pushing a big rubbish cart. He stops the cart directly underneath your grate and goes into a doorway.\n" \
"  If you want to jump down and hide in the rubbish cart, go to {162}. If you want to get out of the air ducts and run off down the hallway, go to {208}. If you want to go on inching your painful way through the ventilation system, go to {125}."
},
{ // 4/1D
#ifdef CENSORED
"Make a SR* on CHR. If you miss it, she hates you; go to {46}. If you make the SR*, she bought your line, you smooth-talking devil, you! But now you have to roll a L1-SR on Luck (20 - LK). If you miss it, she will not let you leave. Your character cannot leave her chamber without going to {46}. If you make the L1-SR on Luck, she reluctantly agrees to let you leave. Go to {201}."
#else
"Make a SR* on CHR. If you miss it, she hates you; go to {46}. If you make the SR*, she bought your line, you smooth-talking devil, you! But now you have to roll a L1-SR on Luck (20 - LK). If you miss it, she wants to keep you for her lover. Your character cannot leave her chamber without going to {46}. If you make the L1-SR on Luck, she reluctantly agrees to let you leave, but only after you spend a night of love with her. Go to {201}."
#endif
},
{ // 5/1E
"G[ood news! You get total surprise on your opponents. They get personal adds only in the first round of combat, and these count only for defence. Now for the bad news, g]o to {120}."
},
{ // 6/1F
"As icicles form on your ears, nose, and other extremities, you wisely discern that you can't stay here. Deduct freeze damage points equal to your level from your CON. If killed, go to {212}. If alive, you can retreat to 91 or press bravely ahead towards the door by going to {156}."
},
{ // 7/2A
// cursed version of 199/30B
#ifdef CENSORED
"A drop poured from this bottle and placed on your tongue makes all your wounds feel better. The bottle contains 6 ounces of liquid.\n" \
"  If and when you or someone else drinks one ounce of this potion, then, and only then, go to {209} and follow the directions there. Return to {110}."
#else
"This bottle is covered with pictures of crying infants, and a drop placed on your tongue makes all your wounds feel better. The bottle contains 6 ounces of liquid.\n" \
"  If and when you or someone else drinks one ounce of this potion, then, and only then, go to {209} and follow the directions there. Return to {110}."
#endif
},
{ // 8/2B
"The fat man has a high-density structure (he comes from a large, high-gravity planet). He has a MR of 200 and can take 11 hits per combat round just as if he were wearing mail. Fight him for one round. If he kills you, go to {212}. If you kill him, you get ap equal to 2000 divided by your level. Before you can start another round of combat, out of the corner of your eye, you see one of this juggernaut's assistants pointing something at you. Go to {56} to see what happened."
},
{ // 9/2C
"When the wizard reaches your cart and pulls off your sheet, you jump him. Boy, is he ever surprised. Unfortunately, he has terrific reflexes. Make a L1-SR on Luck (20 - LK). If you make it, go to {35}. If you miss it, he leaps back out of your reach and blasts you unconscious with a spell; go to {81}."
},
{ // 10/2D
"Desperately, you hurl yourself against the monstrous, metamorphosizing machine. Alas! It is impervious to your assault; your weapons shatter impotently against its steely surface. It seizes you by the throat with cruel metal hands and strangles you. Go to {212}."
},
{ // 11/2E
"Golly! These guys are really fast! One trips you with his staff, and before you can regain your feet, they have pummelled you unconscious. The beating will cost you one-sixth of your CON for bruises and contusions. You wake up, sore, bruised, and stripped of all weapons, armour, and other equipment. You are in a small room. A buzzy-sounding voice from the ceiling says, \"Welcome to the Game!\"\n" \
"  Go to {16}."
},
{ // 12/2F
"You put a coin in the slot and pull the lever. The dials spin vigorously. Roll 2 dice and consult the following table to see what happens next:\n\n" \
"    Die Roll    Symbols Appearing    Go to Paragraph\n" \
"    2           Three skulls         {17}\n" \
"    3           Three trolls         {116}\n" \
"    4           Three serpents       {158}\n" \
"    5           Three clowns         {86}\n" \
"    6           Three daggers        {170}\n" \
"    7           Three coins          {151}\n" \
"    8           Three keys           {186}\n" \
"    9           Three swords         {107}\n" \
"    10          Three gems           {127}\n" \
"    11          Three bottles        {29}\n" \
"    12          Three doors          {87}\n\n" \
"Only the original 12 coins work in the slot machine. Be sure to keep track of these coins as you use them, ie. how many times you play the machine. If you use them all without opening the door, go to {195}."
},
{ // 13/2G
"Potent rays of magic force emanate from this King. Make a SR* on LK, or lose 1-6 points from that attribute. If you make the SR*, you receive gp equal to the margin by which you exceeded the number required and get to add two points to your LK. Return to {184}."
},
{ // 14/2H
"You enter the golden room, and the door closes behind you. There is a huge bar of golden metal on a pedestal at the far end of the room. You approach this brightly-glowing ingot cautiously.\n" \
"  \"Eeeet eees Geeecium,\" says the Gamesman's sad voice from a speaker in the ceiling. \"Alaas, eeets raaadiations aare faaatal tooo aaall leeeving theeengs. Myyy condooolances. You haaave looost theee Gaaame!\"\n" \
"  You suddenly feel very weak and tired. Sooo sleepy...you decide to take a short nap. Go to {212}, and substitute zombies for the robots."
},
{ // 15/3A
"You go to the gate of the GM building and ask to be admitted. You are quickly escorted into the Gamesman's presence where you stare in astonishment: he is the fattest man you have ever seen! He must weigh 800#.\n" \
"  \"Soooo,\" he burbles, his features broadening into an impossibly wide grin, \"you waaant tooo plaaay theee Gaaame?\" As you nod, you notice he is totally bald; his eyebrows and even his fingernails are painted on. How odd!\n" \
"  \"Gooood,\" he purrs, expansively. \"Iii aaam suuure you will haaave aaa veery egsitink tiiime!\" He tells the servant to take you to the Game chambers.\n" \
"  If you want to go and begin the Game, go to {40}.\n" \
"  If you'd rather try to knock out the servant escorting you and go explore the GM building on your own, go to {37}."
},
{ // 16/3B
"A door opens in the far wall.\n" \
"  \"Enter!\" commands the voice. If you obey, go to {99}. If you want to be stubborn and stay where you are, go to {36}."
},
{ // 17/3C
"Three grinning skulls appear on the slot machine's dials. Seconds later, a neuromuscular depolarizer in the device zaps you, turning off your heart and nervous system. The Game is over. Go to {212}."
},
{ // 18/3D
"Your foe shrugs off the punch, grabs you, and throws you against the wall. Subtract one die for impact damage from your CON. As you struggle to get back to your feet, your opponent points something at you. Go to {56} to find out what it is."
},
{ // 19/4A
"You are given a magical broadsword worth 6 dice and 8 adds in combat. [The first time you use it, ]however, you must check to see if it is cursed. Roll one die; if you roll a 1, it is. In this event, [you will lose half your personal adds while wielding it in combat. You will be compelled to use it in preference to all other weapons, and ]you can't get rid of it until someone [else ]casts a Curses Foiled spell[ on you]. Return to {110}. If this paragraph is rolled again, ignore it and go to {54} instead."
},
{ // 20/4B
"Your attack showed more skill than they anticipated. You dodge their blows, and they manage to destroy each other in a shower of sparks.\n" \
"  You pause above the rubble and survey your situation. From both ends of the corridor you hear a snake-like hissing sound. Your only avenue of escape appears to be the air vent on the wall.\n" \
"  If you decide to hang around and wait to see what is coming after you, go to {63}. If you reach for the vent grating, go to {49}."
},
{ // 21/4C
"[Any corpse ]this ointment is applied to [will become an undying monster (well, almost - CON = 500) with a MR equal to twice the adds of ]the corpse[. It will immediately attack the person(s) who applied the salve to it, and will not stop until destroyed (removing or washing off the unguent will kill it) or it has slain its resurrector(s)]."
},
{ // 22/4D
"You drag your weary bones into a large, well-lit room. There are 3 doors in the far wall. In the centre of the room, behind a roulette table, is the broadly-grinning Gamesman.\n" \
"  \"Weeelcooome, Heeerooo!\" he rumbles, happily. \"You haave reeached thee laaast of myyy chaallenges. Beeat thiis wheeel, aaand you wiiin thee Gaaame!\" He then warns you not to attack him; such rashness, he promises, will be fatal.\n" \
"  If you want to take a shot at his pudgy head anyway, go to {130}. If you want to get it over with and start spinning the roulette wheel, go to {110}."
},
{ // 23/4E
"Red tile - A wall of flame blazes up in front of and behind you. The heat is unbearable. To retreat, go to {148}. To stay where you are, go to {95}. To press through it, go to {145}."
},
{ // 24/4F
"The vines lash out like whips, trying to ensnare you. Make a SR* on ST; add +3 to your roll if you have a dagger or +6 if you have a sword. If you make the roll, you break through the foliage and take only one die of damage to your CON. If you miss the SR*, the vines held. Deduct the margin by which you missed the SR* from your CON, and try again. Keep trying until you break through, in which case return to {68}, or the vines kill you, sending you to 212."
},
{ // 25/4G
"Go to {193} and follow the instructions there, except you need only make a L1-SR on Luck (20 - LK) instead of the SR* usually required there."
},
{ // 26/4H
"The fat man speaks: \"We are from the planet Kystrone, about 30 parsecs from here. We Kystroni have developed a very high level of technology which depends on a rare, extremely radioactive element called Gecium. In its unrefined state, Gecium emits potent radiation which can't be shielded and which destroys both living tissue and electronic components. This makes it impossible to safely mine or process it with either living beings or robots. Fortunately, we discovered that zombies animated by magic are only slowly destroyed by Gecium rays and can handle this substance for long periods of time without serious impairment. The only problem is that our laws (we are very civilized) do not allow us to enslave or kill other life forms. Therefore, we are forced to use a loophole - the Game! As long as each player has a chance to survive and win, we can use the losers' bodies to create the zombies on which the continued survival of our race depends.\"\n" \
"  Six guards enter the room. To surrender, go to {100}. If you want to fight the guards, you burst from the room into the hallway and go to {120}. If you want to jump the fat man and try to make him a hostage, go to {207}."
},
{ // 27/5A
"When you return to your room in the inn, you find Alonzo, one of Duke Bronzo's agents, waiting for you. He tells you that the duke wants to know what's going on in the new building, but so far he has been able to learn nothing. Only a few persons who went in to play the game have come out again; they are rich but can't recall anything that happened to them inside. Alonzo says Duke Bronzo will pay you a lot of money if you can find out anything for him. You have a choice of 2 plans: 1) you can try to sneak over the wall and spy around, or 2) go in and play the game but make secret notes to smuggle out.\n" \
"  To try the first plan, go to {131}.\n" \
"  To try the second plan, go to {15}."
},
{ // 28/5B
"You make it over the wall and descend inside. You see no guards, but there is a door in the wall nearby. To take a closer look at this portal, go to {121}. If you'd rather look around for some other way into the building, go to {114}."
},
{ // 29/5C
"Three bottles show on the dials, and a single bottle clunks down into the machine's trough. The bottle's label reads \"Dr Bob's Marvellous Snake Oil Liniment and Healing Potion\". The instructions say that you will be healed of all CON damage by drinking the entire contents of one bottle[, but you can only drink one bottle per week, or it will kill you]. Cache the bottle, or drink it if needed, and return to {12} for another try at the slot machine."
},
{ // 30/5D
"Purple tile - Purple gas fills the corridor ahead of you. To hold your breath and try to run through it, go to {53}. To retreat from the advancing cloud, go to {90}."
},
{ // 31/5E
"Your ruse works. Strong, unsuspecting hands transfer your sheet-covered person to a cart which begins to move. But where are they taking you? If you want to continue to play dead, go to {182}. If you decide to have a little more say about your ultimate destination, throw off your sheet and go to {102}."
},
{ // 32/5F
"You are abruptly disappointed to learn that the shaft is fatally deep.\n" \
"  At a control monitor screen, a surprised Kystroni technician says, \"Well I'll be - the zazbo (Editor's note: This is a Kystronian species equivalent to the terran turkey.) just up and jumped straight on in!\"\n" \
"  Another of the fat, bald men comes over to take a look. \"No kidding? Hah! He must have thought he could fly. Did he try a spell?\"\n" \
"  \"No,\" replies the first tech. \"Well, whatever his reason, the Game is over for him.\" He pushes a button on his control panel. Go to {212}."
},
{ // 33/5G
"This bottle is covered with hundreds of tiny footprints carved in the glass. A drop placed on your tongue makes you feel like dancing.\n" \
"  If and when you or someone else drinks this potion, then and only then go to {177} and read the directions there. Return to {110}."
},
{ // 34/5H
"Finally you hear voices ahead. Inching painfully forward, you come to another grate. Peeking through it, you see one of the weird fat guys talking to a wizard.\n" \
"  \"Huuurreee!\" drones the fat man. \"Weee aaare beeelow ooour Zeeeee quoootaa, aaand Traaansmissiooon Cooontroool eeess iiimpaaatieeent.\" He explains that a recent solar flare may soon initiate a proton storm that will interfere with sending \"theee goooods\" to Kystrone.\"\n" \
"  \"Relax,\" growls the wizard, \"I'm finished.\" He gives a loud command, and, from the tables about the two, 20 zombies rise up. Though stitched and patched back together, all show abundant evidence of the violent way they died: some were burned, others crushed, mangled, drowned, etc. It is a ghastly sight.\n" \
"  \"Oooff wiiith theees caaarrioon!\" commands the fat man, and he exits, lamenting that his race should have to stoop to such means to obtain the \"priiiceleeess Geeeciuuum\". The wizard goes out also, followed by the shuffling host of undead.\n" \
"  At this point, you can push the grate out and drop down into the room (go to {136}), or you can back up to the intersection and take the left branch (go to {3})."
},
{ // 35/6A
"You knock him down and pin him to the floor.\n" \
"  \"Release me,\" he sputters indignantly, \"or it will go hard with you! You cannot escape this building.\"\n" \
"  If you want to call his bluff and demand to know what's going on, he'll show you in 64. If you decide to heed his advice and surrender to the guards he will summon, go to {100}."
},
{ // 36/6B
"The walls of the room you occupy begin to glow. The temperature rises rapidly, and you start to sweat. To leave the room, go to {99}. To stay, and call the Game Master's bluff, go to {72}."
},
{ // 37/6C
"You hit the man leading you to the game-room on his head. If you were only trying to stun him, go to {2}. If you hit him as hard as you could, go to {44}."
},
{ // 38/6D
"Make a L5-SR on Luck (40 - LK). If you make it, you evaded the guards; go to {139}. If you missed it, go to {208}."
},
{ // 39/6E
"Through the window, you see a room with six tables. On each of the first five of the tables lies a sheet-shrouded body. The sixth table is empty. There is no one in the room. To go in for a closer look, go to {124}. To retreat back the way you came in, go to {74}."
},
{ // 40/7A
"The servant leads you into a small room. \"Wait here,\" he says. \"You will receive instructions.\" He leaves, and a gleaming metal door seals the exit.\n" \
"  \"Welcome to the Game,\" says a buzzy, metallic voice from a hidden speaker somewhere in the ceiling. \"Please remove all your weapons, armour, and other equipment. Retain only your non-magical clothing. Your property will be returned when the game is concluded, if you survive.\"\n" \
"  If you obey this order, go to {16}.\n" \
"  If you don't want to comply with the order, go to {57}."
},
{ // 41/7B
"Just as you reach the top, you slip. Make a L1-SR on Luck (20 - LK). If you miss it, go to {73}. If you make the SR, you caught yourself but suffered rope burns on your palms. Subtract 2 points from your CON (1 point for each hand) and painfully ascend to 28."
},
{ // 42/7C
"This potent Queen's arcane symbol forces you to make a SR* on CHR. Failing the SR* will cost you 1-6 points from your LK. If you make the roll, however, you gain one point on both CHR and LK. Return to {184}."
},
{ // 43/7D
"Restoration potions such as this cure 6 points of CON damage per bottle taken.[ Partial doses are allowed.]"
},
{ // 44/7E
"To your amazement and horror, you knock his head completely off his shoulders. But instead of blood, oil spurts up accompanied by a shower of sparks. The body takes another step, stops, totters, and then falls. The head lies on the floor, its eyes regarding you calmly.\n" \
"  You are at a branch in the corridor. Go to {139} to take the left branch. If you'd rather go right, go to {92}."
},
{ // 45/8A
"A great, glowing light appears in the air above you. An imperious voice calls your name. Then, suddenly - Whoosh!! - you are whisked magically away and find yourself standing in front of the Grand Duke, Mort (the Duke's personal assassin), Gorghasty (the royal wizard), and Alonzo!\n" \
"  Gorghasty has been watching the GM building through his scrying crystal and spotted you outside. Taking advantage of your serendipitous appearance and a temporary lapse in the strength of the magnetic fields surrounding the structure, he transported you with a powerful spell to the Ducal palace. Go to {196}."
},
{ // 46/8B
"If you attack it with a weapon, she melts it with a spell. If you attack her bare-handed, she paralyzes you with her magic. If you try a spell of your own on her, write it down and go to {140}. If you don't have any magic to try, you just stand there looking foolish; go to {58}."
},
{ // 47/8C
"The exit door starts to close! If you want to watch it do so, go to {195} and ignore the first sentence. If you'd rather make an attempt to get out, make a SR* on DEX. If you make it, go to {200}. If you miss it, go to {138}."
},
{ // 48/8D
"You plop out of this chute in front of an impressive door. Over it, you see a sign that says, \"Caution: Booby-trapped!\" Being no booby, you examine the door carefully. Make a SR* on IQ. If you make it, go to {101}. If you miss it, go to {169}."
},
{ // 49/8E
"The grate comes off with a loud, angry screech (in a distant control room, a fat, bald monitor on a coffee break doesn't see the red warning light blinking on his control panel). With an effort, you clamber into the shaft. It's a tight squeeze, but you make it. After crawling along like an inchworm for a ways (and rubbing most of the hide off your knees and elbows) you come to an intersection: go to {34} to go right, or go to {3} to go left."
},
{ // 50/8F
"Make a SR* on IQ. If you make it, roll a SR* on DEX. If you make that, you open the hatch; go to {22}. If you miss either SR*, mark off 10 seconds of time and return to {143}. Or you can return to {201} and try another hatch. Remember to mark off time."
},
{ // 51/8G
"Slowly, the ledge on which you are standing starts to disappear into the wall. Now you have to make a decision. If you want to jump into the chasm, go to {32}. If you want to try to cross on the tightrope, go to {166}."
},
{ // 52/8H
"You receive a Deluxe Staff (see section 2.21 of the Rulebook for its characteristics). There is a 1 in 6 chance it is cursed, however. Roll one die; if you get a 1, it is cursed. In this case it works in reverse, adding your level to the cost of each spell you attempt to cast. You won't be able to get rid of the staff until you can [find someone else to ]cast a Curses Foiled spell on you. Return to {110}.\n" \
"  If you roll this paragraph again, go to {147}."
},
{ // 53/8J
"Make a SR* on DEX. If you miss it, you got through but take damage to your CON equal to the margin by which you missed the roll (the gas is absorbed through your skin). If you make the SR*, you get through the cloud before you absorb enough gas to hurt you. If killed, go to {212}. If alive, return to {68}."
},
{ // 54/8K
"The middle door behind the Game Master opens. The faint sound of clinking metal (coins?) can be heard inside. If you want to go and investigate this tantalizing noise, go to {61}. If you want to stay and play a while longer, go to {110} again, but if you spin the wheel again, the door will close until the wheel spins this number to open it again."
},
{ // 55/8L
"Desperately you hurl yourself at the door. Make a SR* on ST. If you make it, you forced the portal open; go to {200}. If you miss the SR*, the obstinate door resists your frantic strivings. You hear an ominous bellow behind you. Go to {10}, and take your medicine like a man."
},
{ // 56/9A
"The tip of the blunt object flashes, and you feel like a house just fell on you. You wake up in a small room. You have a dreadful headache, and all your armour, weapons, and equipment are gone.\n" \
"  \"Welcome to the Game!\" says a mechanical-sounding voice from the ceiling. You don't feel very encouraged. Go to {16}."
},
{ // 57/9B
"Suddenly, from the ceiling, high-pressure jets spray you with a nasty-smelling liquid. All your weapons, armour, clothing, and equipment dissolve and melt. You are left wet and naked, but unharmed. Go to {16}."
},
{ // 58/9C
"The witch upbraids you for a classless lout. How could you resist her obvious charms? She sends you packing to {22}, but only after she makes 100 warts grow on your face where they will stay (reducing your CHR to 3) until you can get someone [else ]to cast a Curses Foiled[ on you]."
},
{ // 59/9D
"You have barely left the GM building when Alonzo, Duke Bronzo's right-hand man, and his bully boys pick you up. These toughs \"escort\" you to the Ducal palace where you are subjected to a gruelling session of questions. The Duke doesn't buy your alibi of amnesia; he has you locked up in a cell in his very secure dungeons. Finally, they release you. It seems the Duke and the Gamesmen have had a couple of meetings, and now the Duke fully understands the situation. Your money and equipment is returned, and you are a free man again, at least until Alonzo finds some other nasty job for you to do..."
},
{ // 60/9E
"This chute dumps you out on a narrow ledge. In front of you is a deep chasm. A tightrope spans the 40' gap to the other side. There doesn't appear to be any way to climb down (or up) the glass-smooth walls of the chasm, and you can't see the bottom. If you want to stay where you are, go to {51}. If you want to try to walk across the tightrope, go to {166}. If you want to chance jumping into the chasm, go to {32}."
},
{ // 61/9F
"You enter the room, and the door closes behind you. Only then do you perceive what is making the clinking noise. It is the armour (lamellar, 10 points) worn by a 10' tall warrior armed with a poleaxe (7 dice). He gets 5 adds for each of your levels and has a CON of 12 plus 6 additional points for each of your levels. If you can kill him, you get ap equal to 10 times his CON plus his adds (10 × CON + 10 × adds), and you stagger off to {123}. If he kills you, he gets an extra ration of monster chow; you go to {212}."
},
{ // 62/10A
"In this hatch is a slot that looks just big enough for a card to fit. If you happen to have a card (perhaps an ace?) and want to put it in the slot, go to {197}. If you want to try inserting anything else in the slot, such as a dagger blade, go to {171}. To try to force open the hatch by brute force, go to {98}. To go try another hatch, return to {201}. Remember to mark off time."
},
{ // 63/10B
"Two silver balls come whirling towards you, one from each end of the hall. With small pops, you see two hooks connected to the balls by a thin silver wire shoot from each ball. You duck, and the hooks catch on the opposite ball.\n" \
"  You chuckle for a moment at the thought that more of the Gamesmen's machines are going to destroy themselves when the balls fly at you and twirl around you, wrapping you with the wire. An electrical current blasts through your body and shocks you into unconsciousness. Go to {81} after collecting 150 ap for the fight with the guards and this encounter."
},
{ // 64/10C
"The wizard gives a piercing whistle, and, from each table in the room, a gruesome zombie rises up. They immediately attack you and, despite your most valiant defence, drag you down and overwhelm you; go to {81}."
},
{ // 65/10D
"The fat man's obesity is illusory. Not only is he as hard as a rock, he is as strong as a giant! He's fast, too. He grabs you with his chubby hands and beats you against the nearest wall until you are unconscious. Go to {81}."
},
{ // 66/10E
#ifdef CORGI
"The air duct maintenance robot (a rugged and efficient machine), sensing an obstruction in the system, executes its program and removes the foreign object, namely you! Alas, it is not programmed to be gentle with adventurers or other living things (deduce one die drag damage from your CON; if killed, go to {212}). It eventually hauls you, kicking and cursing, out of the air duct and drops you into a sort of rubbish dump room. Go to {208}."
#else
"The air duct maintenance robot (a rugged and efficient little bugger), sensing an obstruction in the system, executes its program and removes the foreign object, namely you! Alas, it is not programmed to be gentle with children or other living things (deduce one die drag damage from your CON; if killed, go to {212}). It eventually hauls you, kicking and cursing, out of the air duct and drops you into a sort of rubbish dump room. Go to {208}."
#endif
},
{ // 67/11A
"You scramble up the ladder and, in the hatch, see a keyhole. If you obtained a key from some other part of this adventure, you can try it here; go to {134}. If you don't have a key, you can try to force the hatch by brute force; go to {98}. To go try another hatch, return to {201}. Remember to mark off the time."
},
{ // 68/11B
"As you enter the corridor, a metal door closes behind you. A computer has adjusted to the hall on your level; you will have to make 5 SR*'s on LK to traverse the corridor without stepping on any of the coloured tiles. Each time you miss one of the SR*'s, roll a die and consult the following table to see what has happened:\n" \
"    Die roll                  Result\n" \
"    1............Red tile (Go to {23})\n" \
"    2........Yellow tile (Go to {155})\n" \
"    3..........Blue tile (Go to {118})\n" \
"    4.........Green tile (Go to {105})\n" \
"    5.........Purple tile (Go to {30})\n" \
"    6.........Black tile (Go to {135})\n" \
"After you have rolled the 5th SR*, go to {205}."
},
{ // 69/11C
"The vent is covered by a metal plate. It will require a L1-SR on Strength (20 - ST) to pull it off. If you make the roll, go to {49}. If you miss it, the grate groans protestingly but holds. You have wasted 30 seconds of valuable time. Return to {201}, and try one of the hatches."
},
{ // 70/11D
"You slide down and fall out of the tube onto a wire grid. Twenty thousand volts of electricity at high amperage pass through your body. The odour of burning hair and flesh fills the air, but you don't smell it. Go to {212}."
},
{ // 71/11E
"Make a L4-SR on both ST (35 - ST) and CON (35 - CON) because that's how much strength and guts it's going to take to wedge your body up that long, narrow shaft. If you make both rolls, you make it and crawl gasping out onto the roof; go to {45}. If you miss either SR, go to {66}."
},
{ // 72/11F
"Sorry, the Gamesman wasn't bluffing. Who would have believed that the room could get so hot so fast?\n" \
"  In just a few seconds, all your exposed skin is turning red, and your clothing, if any, is starting to smoke. As you bolt for the door, make a SR* on your DEX. If you make it, you reach safety (99) with negligible damage from the heat. If you missed the SR*, deduct points for thermal injuries equal to the margin which you missed the roll and stumble painfully into 99 cursing your slow reactions."
},
{ // 73/11G
"Just as you reach the top, you slip, lose your grip, and fall. Subtract 2 dice (2-12) points of fall damage from your CON. If you roll doubles, you also broke your right leg. In this case, if you can't heal yourself with Restoration spells, go back to {27} and mend for a month. If you didn't break any bones, you can go to {131} and try again, or you can try the alternate plan, ie. play the Game, by going to {15}."
},
{ // 74/11H
"You go back into the corridor. Make a L1-SR on Luck (20 - LK). If you make it, go to {92}. If you miss it, go to {208}."
},
{ // 75/11J
"This magic Jack requires you to make a SR* on DEX. If you make it, you gain 1-6 points on that attribute. If you miss the SR*, you lose 1-6 points! Return to {184}."
},
{ // 76/11K
"If your DEX is 10 or lower, make a L1-SR (20 - DEX) on it. If you miss it, go to {175}. If you make it, or if your DEX is greater than 10, you climbed all the way down, no problem. Go to {111}."
},
{ // 77/11L
"The powerful King of Spades requires a SR* on ST from you. If you miss it, you lose 1-6 points of ST. If you make the roll, however, he will grudgingly raise your ST one point. Return to {184}."
},
{ // 78/11M
"When you touch this hatch, you stick to it. A powerful magnet immobilizes your weapons so you can't cut yourself loose. Trapped like a rat, you drown. Go to {212}."
},
{ // 79/12A
"The door opens, and you see a rich but oddly furnished room.\n" \
"  \"Come in!\" says a buzzing, mechanical voice. Looking in, you see a huge, totally bald, fat man. The odd voice comes from a shiny black box on a chain around his neck. He looks friendly. If you want to stay and talk to him, go to {133}. If not, excuse yourself and exit hastily by going to {208}."
},
{ // 80/12B
"The Jack on this card is covered with mystic symbols. Make a SR* on IQ, or you lose 1-6 points from that attribute. If you make the SR*, you receive one gold piece and get to add one point to your IQ. Return to {184}."
},
{ // 81/12C
"You wake up, sore and bruised, in a small room. Lots of little injuries have cost you one-sixth of your CON points. Your weapons, armour and equipment have been removed. From a speaker in the ceiling, a buzzy voice announces, \"Welcome to the Game!\"\n" \
"  Go to {16}."
},
{ // 82/12D
"This bottle bears the label \"No See-Me Grease\" and contains a clear, odourless, white salve. There is enough for only one application to a single person and his equipment.\n" \
"  If and when you or someone else uses this salve, then and only then go to {160} and read the directions there. Return to {110}."
},
{ // 83/13A
"Zip! The steps straighten out into an oil-greased, single, smooth, inclined spiral. Down you go! Make a SR* on DEX. If you make it, you slide all the way to the bottom without incident; go to {111}. If you miss the SR*, go to {175}."
},
{ // 84/13B
"You are given a jar of ointment. Hieroglyphs on the label indicate that it should be rubbed on a dead body. Carved in profusion on the glass of the jar are dozens of ankhs, a mystic symbol for life. If and when you apply this salve to a dead body, and only then, go to {21} and read the directions there. Return to {110}."
},
{ // 85/13C
"Make a L3-SR on Luck (30 - LK). If you make it, go to {31}. If you miss it, you didn't fool anyone. You hear a deep voice bellow an order in a strange language. Immediately, strong hands seize you. You struggle futilely in their iron grip until something strikes you on the head, and the lights go out. Go to {81}."
},
{ // 86/13D
"Three laughing clown faces appear on the dials. The slot machine sprays you from head to foot with skunk oil. Your Charisma drops to 3 until you can get a hot bath. If you roll this one again, ignore it and substitute {151}. Return to {12} and try, try again."
},
{ // 87/13E
"Aha!! The dials come up with three doors. Bells ring, lights flash, sirens keen, and a door opens in the wall. The buzzy voice says, \"You have 30 seconds to leave.\" To grab your loot and hurry out, go to {200}. If you want to be extra-cautious, or just stubborn, and take your time, go to {47}."
},
{ // 88/13F
"The key and lock are not easy to figure out. Make a SR* on both DEX and IQ. If you make them both, the key vanishes but the door opens allowing you to escape to {200}. If you miss either or both of the SR*s, your efforts are interrupted by a dreadful roar behind you. Go to {10}, and face the sad music."
},
{ // 89/13G
"As you attack, the Card Shark throws off its cloak and hood, revealing a stocky reptilian body with a shark-like head. Its Monster Rating is equal to 10 plus ten times your level, and its scaly skin takes five hits per turn as armour. Fight it to the death. If you win, you get twice its MR in ap, and you get to advance to {198}. If you are slain, go to {212}."
},
{ // 90/13H
"The gas follows you, rapidly filling the hallway. You will have to go back through it - but now you must go twice as far! The trip will cost you CON damage (the gas is absorbed through your skin) equal to twice your level. If killed, go to {212}. If still alive, go to {53}."
},
{ // 91/13J
"It's even colder back here than ahead, and now you must go twice as far to escape. Deduct freeze damage points from your CON equal to twice your level plus two dice. If killed, go to {212}. If still alive, you finally emerge from the icebox, and go to {68}."
},
{ // 92/13K
"As you proceed down the corridor, you hear an alarm bell and distant sounds of pursuit. You hurry on, but when you round the next turn, the corridor ends in a door. If you want to try the door, go to {79}. Otherwise, you can hurry back the way you came by going to {38}."
},
{ // 93/13L
"This bottle bears the inscription STX2. A drop placed on your tongue makes you feel like doing pushups.\n" \
"  If and when you or someone else drinks this potion, then and only then, go to {203} and follow the directions there. Return to {110}."
},
{ // 94/13M
"You get the feeling that you could Omni-Eye the amulet at this point. If you do, go to {183}. If you can't, or want to wait until later, go to {22}."
},
{ // 95/14A
"Too hot to stay here! Deduct one die of burn damage from your CON. Then, to retreat down the hall, go to {148}. To advance towards the exit, go to {145}. If killed, of course, go to {212}."
},
{ // 96/14B
"Make a SR* on Speed. For every 6 points (base value) of armour worn, raise the level of the saving roll one level to compensate for encumbrance. If you make the SR*, go to {121}. If you miss it, go to {146}."
},
{ // 97/14C
"You are outside, in back of the GM building! A huge, automatic trash compactor suddenly gulps down the contents of the cart you just exited, and...CRUNCH!!! Your knees get a little weak when you realize how close you just came...! Suddenly, you hear someone calling you by name. Go to {45}."
},
{ // 98/14D
"Make a SR on Strength at your level (not an SR*; a 7th level character has to make a 7th level SR here). If you make it, go to {22}. If you miss, return to {201} and try another hatch."
},
{ // 99/15A
"You enter a 40' square room. A large slot machine with 12 odd-shaped gold coins in its trough stands in the middle of the floor. If you want to put on the suit of leather armour (6 points) lying by the slot machine you will find that it is a perfect fit.\n" \
"  \"To escape from this room you must play the slot machine,\" buzzes the mechanical voice.\n" \
"  If you want to put one of the 12 coins in the slot and pull the lever, go to {12}. If you'd rather look around the room first, go to {178}."
},
{ // 100/15B
"You are immediately seized, stripped of your armour, weapons, and equipment, and escorted, under guard, to a small room. They shove you in, and the door slams behind you.\n" \
"  \"Welcome to the Game,\" says a buzzy, mechanical voice from the ceiling. Go to {16}."
},
{ // 101/15C
"You find a devious trigger mechanism, and must disarm it to proceed safely. Make a SR* on DEX. If you make it, you are successful, and the door opens; go to {201}. If you miss the SR*, go to {193}."
},
{ // 102/15D
"The big, fat, bald man is surprised to see you, even if his assistants appear totally unimpressed.\n" \
"  \"Vaaat chew dooink heeere?\" he rumbles. He starts towards one of the controls, perhaps to sound an alarm - or worse!\n" \
"  If you want to run, go to {74}. To try and stop him, go to {65} to grapple with him or go to {8} to attack him with your weapons."
},
{ // 103/15E
"You hear the modes clicking and changing. You get bad vibes, but the blade is whirling closer.\n" \
"  Make a L1-SR on Luck (20 - LK). If you make it, roll for another mode; you fail to panic and are lucky enough to wait. Go to {198}. If you miss, you panic; go to {70}."
},
{ // 104/15F
"A huge automatic trash compactor gulps the contents of the cart you are hiding in (including you) and does its mechanical thing. Although surprised, you do not suffer long. Take consolation in the thought that the poor Kystroni will have one heck of a time trying to figure out where you went."
},
{ // 105/16A
"Green tile - A sickly green light abruptly illuminates the hallway about you triggering the sudden, explosive growth of thousands of thorny tendrils and vines. To make a dash for the exit ahead, go to {24}. To retreat back away from this writhing jungle of vegetation, go to {180}."
},
{ // 106/16B
"You peek through the door's small window. Roll a die. If you roll a 1-3, go to {39}. If you roll a 4-6, go to {187}."
},
{ // 107/16C
"Three swords appear on the dials, and a sword hilt pops out of the slot machine's trough. Cautiously you pull it out and see that it is a longsword worth 3 dice plus 3 adds. It has a strange alloy construction that allows any character but a wizard to use it. If you roll this paragraph again, ignore it and go to {151} instead. Return to {12} and roll again."
},
{ // 108/16D
"This chute drops you down inside a cage of iron bars. You see a door in the wall of the room outside the cage, but you will have to escape from the cage to reach it. Grasp the bars and make a SR* on ST. If you make it, you get out; go to {201}. If you miss it, go to {176}."
},
{ // 109/16E
"Your spell fizzles; you wasted the ST. [Remember, you get one point of ST back for every 6 paragraphs you survive. ]If you want to try another Unlock spell on one of the other portals, return to {149}. If you'd rather start playing the slot machine, go to {12}."
},
{ // 110/16F
"Roll a die and consult the following table to see what happens when you spin the Game Master's roulette wheel:\n" \
"    Die roll    Go to paragraph\n" \
"    1.......................{147}\n" \
"    2........................{54}\n" \
"    3.......................{188}\n" \
"    4.......................{173}\n" \
"    5.......................{192}\n" \
"    6.......................{117}"
},
{ // 111/16G
"At the bottom of the shaft you see a 100' long corridor ending in a door. The floor of this passageway is paved with white tiles. Randomly distributed red, yellow, blue, green, purple, and black tiles are scattered over its surface. The buzzy voice from the ceiling speaks again:\n" \
"  \"Each coloured tile in the floor is a touch-sensitive trigger. Step on them at your peril.\" You look and are not very impressed. The tiles are not so closely spaced as to make them difficult to avoid. Then, abruptly, the lights go out, plunging you into utter darkness. The only thing you can see is a very faint \"Exit Here\" sign on the door 100' away. If you want to advance down the corridor towards this beacon, go to {68}. If you'd rather stay where you are in the nice, safe shaft, go to {191}."
},
{ // 112/16H
"You near this hatch and get a bad feeling about it. Water laps about you, yet you pause. Make a L1-SR on LK (20 - LK). If you succeed, go to {201} and choose another hatch. If you miss, you panic and go for hatch #3 at {78}."
},
{ // 113/16J
"This fearsome creature is called a Soul-eater. Those opponents that it can't scare helpless, it has the power to mimic perfectly right down to armour and armament. You must, in essence, fight yourself. If you slay this monster, collect 10 times your personal adds in ap. In addition, you also earn free passage out of the corridor; ignore any remaining SR*s and proceed straight to {205}. If the Soul-eater killed you, of course, go to {212}."
},
{ // 114/16K
"You approach the building's corner and peek carefully around the edge. You are dismayed to see a patrol of 5 guards trotting purposefully in your direction. To race back to the door you saw, go to {96}. To stay and try to waylay the patrol, go to {5}."
},
{ // 115/16L
"For this Queen, you have to make a SR* on CHR. If you make it, this enchanting lady raises that attribute 1-6 points; if you miss the SR*, she lowers it 1-6 points. Return to {184}."
},
{ // 116/17A
"Three trolls appear on the machine's dials, and one of the doors in the wall opens to admit a large, ugly troll. With a hungry roar, he charges! His MR is equal to your ST or DEX - whichever attribute is higher. If you have received a weapon from the slot machine, you may use it. Otherwise, you fight with your bare hands, getting one die [for each hand ]plus your personal adds.\n" \
"  If the troll slays you, go to {212}. If you kill the troll, you get ap equal to its MR. If you roll this paragraph again, ignore it and substitute {151} instead. Return to {12} and try again."
},
{ // 117/17B
"Roll two dice and consult the following table to see what the wheel has presented you with:\n" \
"    Dice roll    Go to paragraph\n" \
"     2.......................{132}\n" \
"     3.......................{202}\n" \
"     4.........................{7}\n" \
"     5........................{93}\n" \
"     6.......................{154}\n" \
"     7.......................{163}\n" \
"     8.......................{199}\n" \
"     9........................{33}\n" \
"    10.......................{204}\n" \
"    11........................{82}\n" \
"    12........................{84}\n" \
"No number except 7 (paragraph {163}) can be rolled more than once. Treat all duplicate rolls of 2-6 and 8-12 as 7s. Once you have received your gift and recorded it on your record sheet, return to {110} and roll again."
},
{ // 118/17C
"Blue tile - Suddenly, a hurricane-force blast of freezing wind blows at you from the exit. To press on against the gale, go to {156}. To cringe, shivering, where you are, go to {6}. If you'd rather retreat back down the hall, go to {91}."
},
{ // 119/17D
"You swing your weapon at his head, and he ducks. Make a L3-SR (30 - DEX). If you make it, you got him; go to {44}. If you miss the SR, you missed him also; before you can swing again, he points something at you. Go to {56}."
},
{ // 120/17E
"Each of these strangely silent fellows is wearing plate (14 points) and is a warrior[ (double protection)]. Each gets 36 personal adds and has a CON of 25. Each is armed with a staff worth 5 dice. [Each point of damage they inflict counts towards rendering you unconscious, but only 1/36th of damage actually comes off your CON in terms of real injury. ]To attack them with a spell, cast it and then go to {179}. If you fight, try to make a (SR* + 1) on both LK and DEX. If you make both, go to {20}. If you miss one or both of the (SR* + 1)s and you destroy the robots, go to {181}. If you miss one or both of the (SR* + 1)s, and then they beat you unconscious with their brutal but efficient pummelling, go to {81}."
},
{ // 121/17F
"The door opens easily into a long, empty corridor. Spiking the door so it can't close behind you, you go in. Ahead the hallway splits. To explore the right hand branch, go to {92}. To explore the left branch, go to {139}."
},
{ // 122/17G
"When you draw an Ace of any suit, you trigger a potent magic spell. Card Shark and his table vanish. You keep any gold pieces you won, and you may keep the Ace as a souvenir if you like. Go to {198}."
},
{ // 123/17H
"You enter, and the door closes behind you. You see a wizened old man seated at a high desk by a set of scales.\n" \
"  \"Strip and weight yourself,\" he orders. Determine your naked weight and multiply the poundage by ten to see how many gold pieces you win. The old man solemnly pays you and returns any equipment you brought in initially (unless it was destroyed). Before you leave, a wizard probes your mind and erases all memory of the game, the Gamesmen, and their building. You won't be able to tell anyone anything about the Game. You are politely thanked for playing and escorted out of the building. You are indeed a winner! Well, maybe; go to {59}."
},
{ // 124/19A
"The walls of the room are lined with odd devices. Someone has been carefully stitching up and repairing the damage to the bodies on the tables. But why take such trouble to put a corpse back together, you wonder. You hear someone (something?) coming. If you want to run, go to {74}. To wait and confront the intruders, go to {102}. To hide under the sheet on table #6, go to {85}."
},
{ // 125/19B
"You come to a vertical shaft. Above, you can see daylight! If you'd rather not try what looks like a difficult climb, you can try to back out of the shaft you're in (go to {66}). If you want to go on, start wedging your way up towards the sky (go to {71})."
},
{ // 126/19C
"You take only one die of sting damage on your CON before the Yellow Jackets disperse. If this kills you, go to {212}. If still alive, go to {68} and continue."
},
{ // 127/19D
"Three gems show on the dials, and the slot machine coughs up three jewels. Roll up their value from the Treasure Generator (see the Rules Section). If you roll a jewelled item, roll again. Cache your loot, and return to {12} to try again."
},
{ // 128/19E
"On this Queen's robe, you see arcane symbols. Make a SR* on CHR, or you lose 1-6 points from that attribute. If you make the SR*, you receive one gold piece and add one point to your CHR. Return to {184}."
},
{ // 129/19F
"Voila! The hatch opens. You scramble through, safe - for the moment. Go to {22}."
},
{ // 130/19G
"Bad choice. The Gamesman is securely protected by a force field that no force on this world can shatter. You bounce off, only to see him point a death ray at you. It is the last thing you see; go to {212}."
},
{ // 131/19H
"Sneaking through side streets and alleys, you approach the building from the rear. Finally, a 30' high, perfectly smooth wall bars your way. But you, clever fellow, have brought a grappling hook and a rope. You toss it up, and it catches and holds. Up you climb.\n" \
"  Make a L1-SR on DEX (20 - DEX) and a L2-SR on ST (25 - ST). If you make both SRs, go to {28}. If you miss both rolls, go to {73}. If you miss only one of the SRs, go to {41}."
},
{ // 132/20A
"You are given a jar of ointment. Hieroglyphs on the label indicate that it should be rubbed on a dead body. Carved in profusion on the glass of the jar are dozens of ankhs, a mystic symbol for life. If and when you apply this salve to a dead body, and only then, go to {141} and read the directions there. Till then, return to {110}."
},
{ // 133/20B
"\"I am Chief Administrator of this project,\" says the fat man through his cybernetic translator. \"You must be the intruder my aides have reported. You are looking for information, no? Wait here until my guards arrive, and I will gladly tell you why my people have sent me here to bring our Game to Kasar.\"\n" \
"  If you'd rather leave, go to {208}. To stay and hear his story, go to {26}. To attempt to attack him and take him hostage, go to {207}."
},
{ // 134/20C
"The key works; the hatch opens. Scramble through it to {22}."
},
{ // 135/20D
"Black tile - A hideous spectral figure materializes in front of you. make a SR* on IQ. If you miss it, you are paralyzed with fear. Its bony hands reach out and seize you in a soul-freezing grip. Your life drains out like water...cold...darkness...go to {212}.\n" \
"  If you make the SR*, you are scared, but still able to fight this horror; go to {113}."
},
{ // 136/20E
"There are 20 tables in the room. Two large rubbish bins stand against one of the walls. You hear someone coming. To hide in one of the bins, go to {142}. To stay and confront whoever is coming, go to {102}. If you want to run out the door and flee down the hall, go to {208}."
},
{ // 137/20F
"This magic King requires you to make SR* on your CON. If you make it, he will add 1-6 points to your CON. If you miss the SR*, he will subtract 1-6 points from your ST. Return to {184}."
},
{ // 138/20G
"Good try. You got halfway through the door, but it went on closing anyway. I will spare you the gory details. Go to {212}."
},
{ // 139/20H
"Just as you come to a door in the hallway, you hear an alarm bell followed by the distant sound of angry voices. Your escape has been discovered. If you want to duck inside the door you just found and hide, go to {211}. If you'd rather keep running down the hall, go to {208}."
},
{ // 140/21A
"If you attacked \"Her Ugliness\" with a mind spell (such as Witless, Mind Pox, etc.), go to {161}. If you zapped her with a spell that attacks her physically (Take That You Fiend, Blasting Power, etc.), she has an amulet that casts the spell back at you; you take full damage. If you survive the bounced spell, go to {58}. If you killed yourself, go to {212}. If you tried any other type of magic, you wasted the Strength; your charm fizzled miserably. Go to {58}."
},
{ // 141/21B
"This unguent will resurrect one character from death and restore all his attributes, including CON, to full normal value. Once resurrected, the character will be like any other person, still subject to aging and injury. The drawback of the preparation is that if, for any reason, it is washed off or removed, the character will die."
},
{ // 142/21C
"Something very strong comes in, picks up the bin you are hiding in, carries it into the hallway, and dumps its contents (including you) into a large cart. Go to {162} and ignore the first sentence."
},
{ // 143/21D
"A complicated lock holds this hatch shut. To try and figure it out, go to {50}. To try and force it open by brute strength, go to {98}. To go try another hatch, return to {201}, and remember to mark off time."
},
{ // 144/21E
"Make a L3-SR on Luck (30 - LK). If you make it, you escaped unnoticed; go to {208}. If you miss it, the cagey old spellcaster spotted you slinking through the door and commands you to halt and surrender. If you obey his orders, go to {100}. If you want to turn and attack him or run, go to {64}."
},
{ // 145/21F
"Best choice. You suffer only one die of burn damage to your CON before you emerge into the cool darkness of the corridor again. If this killed you, go to {212}. If still alive and kicking, go to {68} again."
},
{ // 146/21G
"A loud voice behind you orders you to halt. Looking back, you see five guards coming at a dead run, fast. You'll never beat them to the door. If you want to surrender, go to {100}. If you want to draw your weapon and make a stand, go to {120}."
},
{ // 147/21H
"The door on the left behind the Gamesman opens. A golden light shines from the doorway. If you want to go out through this door, go to {14}. If you would rather try the roulette wheel again, go to {110}, but if you spin the wheel again, the door will close until the wheel spins this number to open it again."
},
{ // 148/21J
"Bad choice. Now you must go twice as far to escape this furnace. Subtract points equal to twice your level plus two dice of burn damage from your CON before you emerge from the blaze. If killed, go to {212}. If still alive, return to {68}."
},
{ // 149/21K
"There are 3 doors. To cast an Unlock spell on door #1, go to {116}; on door #2, go to {158}. If you chose door #3, go to {109}. As you cast the spell, the slot machine begins to work. The dials spin, and you see..."
},
{ // 150/21L
"You certainly like to do things the hard way! To climb down the wall, you have to make a SR* on both DEX and ST. If you make both, you reach safety below after an arduous descent; go to {111}. If you miss either SR*, go to {175}."
},
{ // 151/21M
"The dials come up with three gold coins, and sure enough, three gold pieces fall into the trough. You recognize the smiling face of Duke Bronzo as the profile on the coin. The motto reads: \"Death and Taxes; you can escape neither\". Even though you can't use them to play the machine (only the original twelve coins will do that) you can see they are good coin of the realm. Go to {12} and keep on trying."
},
{ // 152/22A
"You grapple with the man, who turns out to be very strong. In desperation, you hit him on the side of his head. Make a L4-SR on Strength (35 - ST). If you make it, go to {44}. If you miss it, go to {18}."
},
{ // 153/22B
#ifdef CORGI
"This potion doubles the ST of the person drinking it. Its effects last one hour. Return to the last paragraph you were in."
#else
"This potion doubles the ST of the person drinking it. Its effects last one hour."
#endif
},
{ // 154/22C
"This bottle is covered with hundreds of tiny footprints carved in the glass. A drop placed on your tongue makes you feel like dancing.\n" \
"  If and when you or someone else drinks this potion, then and only then go to {185} and read the directions there. Return to {110}."
},
{ // 155/22D
"Yellow tile - A panel opens at your feet releasing a swarm of Yellow Jackets. The vicious insects swarm over you, stinging savagely. To retreat back down the hallway, go to {165}. To stand where you are, swatting wildly, go to {189}. To run forward up the hall, go to {126}."
},
{ // 156/22E
"You suffer only one die of freeze damage to your CON before you emerge into the warm, dark hallway again. If this killed you, go to {212}. If not, return to {68}."
},
{ // 157/22F
"This salve will make a person invisible, but only to himself and to his friends. Foes and monsters will still be able to see him and will attack him in preference to other targets."
},
{ // 158/23A
"Three serpents appear on the dials, and a hole opens in the wall to admit a gleaming metal serpent. Rearing up, it spreads an impressive hood on which you see a clearly marked \"OFF\" button. Then it comes gliding swiftly towards you, its fangs dripping with purple venom.\n" \
"  The Mekasnake can only be stopped by pushing its button. It requires you to roll a SR* on both DEX and LK to accomplish this. If you have a weapon from the slot machine, you get a bonus towards determining the level of the SR*. If you have a dagger, you may subtract 3 from each attribute for the purpose of figuring out the level of the SR*. If you have a sword, you may subtract 6 from each attribute. If you have both, you may subtract 9. If you miss the SR* on either DEX or LK, the Mekasnake slashes you with its razor-sharp hood, and you must subtract damage points from your CON equal to the margin by which you missed the SR*. If you miss both the SR*s on LK and DEX, the Mekasnake struck you. The Game is over; go to {212}. If you make both SRs, you turned off the device and receive 200 bonus ap. If you turned off the Mekasnake, return to {12} and try the slot machine again. If you roll this paragraph again, ignore it and substitute {151}."
},
{ // 159/23B
"This powerful Queen gives you two dice times 10 gp and adds one point to your Luck. Return to {184}."
},
{ // 160/23C
"This ointment causes any person or object it is used on to become invisible (like a Concealing Cloak spell) and remain so until it is washed or rubbed off."
},
{ // 161/23D
"If you cast a Dreamweaver, Mind Pox, or Witless on the witch, she falls to the floor, helpless. If you tried anything else, it failed; go to {58}. If you zonked her, you can help yourself to the curious-looking amulet she is wearing, in which case go to {94}, or leave the charm with her and go to {22}."
},
{ // 162/23E
"You jump into the cart and cover yourself up with the foul-smelling garbage. Moments later, someone dumps more rubbish into the carts, and it starts moving again. Then it stops. You hear the rumble of heavy machinery but no voices. If you want to climb out of the cart, go to {97}. If you want to stay a while longer where you are, go to {104}."
},
{ // 163/23F
"You receive 7 gp. Return to {110}, and roll again."
},
{ // 164/24A
"The chute dumps you out unceremoniously in front of an extremely ugly old hag. You can tell at a glance that she is some kind of witch. If you want to try to charm your way into her good graces, go to {4}. If you'd rather attack her, go to {46}."
},
{ // 165/24B
"The Yellow Jackets do three dice of stinging damage to your CON before they fly away. If killed, go to {212}. If still alive, you must now make an extra SR* on LK (as described in 68) to exit the corridor because you retreated. Return there, and try, try again."
},
{ // 166/24C
"To cross the tightrope, you have to make 2 SR*s on DEX. If you miss either one, you fall to your death; go to {212}. If you make both, you get across. On the ledge on this side, you see a door in the wall. Go to {201}."
},
{ // 167/24D
"You slide swiftly down and out of the long, slippery chute and land right smack in the middle of a huge, nasty, sticky spiderweb. From the dark shadows at the web's edge, you see eight shiny, beady, black eyes staring hungrily at you. The spider is coming! Make a SR* on ST. If you make it, you rip loose from the web and get to fight the spider on the floor where you get all your personal adds. If you miss the SR*, you are still stuck fast and get only half your adds due to the web's interference. To calculate the spider's Monster Rating, take the average of your ST and LK and add it to 9. If you take any damage while fighting the spider, make a SR* on LK. If you miss the SR*, the spider bit you. If you are not immune to spider venom, you must suffer its effect. If you cannot kill the spider before paralysis sets in, go to {212}. If you make the SR*, no poison this time; keep on fighting. If the spider kills you, go to {212}. If you kill it, you get ap equal to 3 times its MR, and advance to {201}."
},
{ // 168/25A
"You open up the door and see a sort of tray. You pull it out. On it lies the very cold corpse of a dead warrior, its eye staring sightlessly up at the ceiling. Slightly unnerved, you check some more of the vaults. Some are empty, but most contain a corpse. If you want to check out the door at the other end of this room, go to {106}. If you'd rather just leave by way of the door you came in, go to {74}."
},
{ // 169/25B
"Darn! You can't find anything even remotely resembling a trap on this stupid door. Since you can't go back, you must decide either to kick the door down, go to {25}, or open it by turning the doorknob, go to {193}."
},
{ // 170/25C
"Three daggers appear on the dials, and a dagger plops out of the machine. It is worth 2 dice plus 2 adds. If you roll this paragraph again, ignore it and go to {151} instead. Go to {12} and try again."
},
{ // 171/25D
"ZAP!! There is a shower of sparks. Take one die of shock damage from your CON, and make a L1-SR on Luck (20 - LK) to see if you fall. A missed SR will cost you two additional dice of fall damage. If killed, go to {212}. If still alive, return to {201} and try another hatch. Don't forget to mark off time."
},
{ // 172/25E
"This magic Jack awards you a sack containing one die times 10 gp, and you add one point to your IQ. Return to {184}."
},
{ // 173/25F
"Make a SR* on LK. If you miss it, pay the Gamesman gold pieces equal to the margin by which you missed the roll. If you make it, however, he has to pay you twice the number of gold pieces by which your margin exceeded the number needed. If you run out of gp's, the Gamesman will buy (but never sell) attribute points (your choice) from you for 5 gp per point. When you have settled up, go to {110} and roll again."
},
{ // 174/25G
"The Jack of Spades' magic compels you to make a SR* on DEX. If you make it, you gain one point on that attribute, but if you miss the SR* you lose 1-6 points. Return to {184}."
},
{ // 175/25H
"You fall. Roll one die and multiply by ten to see how many feet. For every 10', deduct one die of damage from your CON. If you are killed, go to {212}. If you survive, go to {111}."
},
{ // 176/25J
"Each time you miss the SR* on ST, you fail to bend or break the bars, and the cage decreases 50% in size. If you miss 3 consecutive SR*s, the cage compresses you to death; go to {212}. If you escape being squashed, go to {201}."
},
{ // 177/25K
"This potion is cursed. Taking it is the same as having a Delay spell cast on you."
},
{ // 178/25J
"Set at regular intervals in the wall are three metal panels that might be doors. Your intuition tells you that an Unlock spell might work here. To try it, go to {149}. If you don't know or can't use the spell, go back to {12} and play the slot machine."
},
{ // 179/25M
"If you cast a Take That You Fiend, Blasting Power, Icefall, or Hellbomb Bursts, it worked[, but only one of the guards was affected; he takes the full force of the spell]. Any other spell had no effect; you wasted the ST used to cast it. Now you have to fight the survivors; go to {120} and this time ignore the magic option (you are too busy). Or you can surrender; go to {100}."
},
{ // 180/25N
"Alas, this error is fatal. Before you realize your mistake, the vines have grown too thick for you to ever penetrate them. They overwhelm and strangle you. Go to {212}."
},
{ // 181/26A
"Boy, are you ever tough! Unfortunately, you are about to get your comeuppance. A shadow alerts you to the presence of something behind you. You turn rapidly, weapon ready, only to confront a large metal spheroid floating in the air. Before you can react, it points something at you. Go to {56} to see what happens.\n" \
"  Incidentally, you receive 250 ap for each guard that you killed."
},
{ // 182/26B
"The cart stops. Footsteps recede. A door closes. You hear a muffled, nearby voice intoning an unfamiliar magic spell. Daring a peek from under your sheet, you see a tall wizard working on a body 2 tables away. If you want to wait until he gets closer and jump him, go to {9}. If you'd rather try to roll quietly off the table and sneak out, go to {144}."
},
{ // 183/26C
"[The amulet will cast back at the spellcaster 1) one Hellbomb Bursts, or 2) three Blasting Power or three Icefall spells, or 3) ten Take That You Fiend spells before it burns out. The first spell cast at it determines what spell it will work against. It must be worn to be effective. ]Go to {22}."
},
{ // 184/27A
"The hooded figure introduces himself as the Card Shark. He shuffles the cards quickly and professionally, spreading them into a fan, then cutting them into two neat piles by the action of one hand alone. Finally, the spots and face cards becoming a blur of colour as they are manipulated, he lays the cards out in a row before you.\n" \
"  \"The card game is simple,\" he says and explains the rules. You draw a card. If it is a number card (two through ten), the Card Shark must draw a card. If he draws a face card (worth ten points) or a card with a higher number than the card you drew, he wins the difference between his card and yours in gold pieces. If he draws an ace (worth one point) or a card with a lower number than the one you drew, he pays you the difference in gold pieces. Neither player pays on ties.\n" \
"  The Card Shark will buy (but never sell), for five gold pieces, one point of any of your attributes (ST, IQ, LK, etc.) you wish to sell him. If you go broke or just get tired of playing cards, you can always go back to {89} and attack the dealer.[\n" \
"  Cards can be selected by die rolls as follows: Roll one die twice:\n\n" \
"    Roll #1    Roll #2    Card Drawn\n" \
"       1         1-3      Ace (Go to {122})\n" \
"       1         4-6      Deuce (two)\n" \
"       2         1-3      Three\n" \
"       2         4-6      Four\n" \
"       3         1-3      Five\n" \
"       3         4-6      Six\n" \
"       4         1-3      Seven\n" \
"       4         4-6      Eight\n" \
"       5         1-3      Nine\n" \
"       5         4-6      Ten\n" \
"       6         1-6      Roll again below\n\n" \
"    Roll #1    Roll #2    Face Cards           Paragraph\n" \
"       1         1-3      Jack of Clubs        {80}\n" \
"       1         4-6      Queen of Clubs       {128}\n" \
"       2         1-3      King of Clubs        {13}\n" \
"       2         4-6      Jack of Diamonds     {172}\n" \
"       3         1-3      Queen of Diamonds    {159}\n" \
"       3         4-6      King of Diamonds     {194}\n" \
"       4         1-3      Jack of Hearts       {75}\n" \
"       4         4-6      Queen of Hearts      {115}\n" \
"       5         1-3      King of Hearts       {137}\n" \
"       5         4-6      Jack of Spades       {174}\n" \
"       6         1-3      Queen of Spades      {42}\n" \
"       6         4-6      King of Spades       {77}]"
},
{ // 185/28A
"Taking this potion is the same as having a Swiftfoot spell cast on you."
},
{ // 186/28B
"Three keys appear on the dials, and a big brass key cast in the semblance of a skeleton falls into the trough. You can leave it where it is or take it with you (note which on your record sheet). If you roll this paragraph again, ignore it and go to {151} instead. Return to {12} and roll again."
},
{ // 187/28C
"Through the window, you see six tables. Each of the first five has a sheet-covered body lying on them; two men in white coveralls are removing a corpse from the sixth table. Standing next to them is a very fat and utterly bald man, supervising.\n" \
"  If you want to go in and confront the three (they appear unarmed), go to {102}. If you'd rather retreat quietly, go to {74}."
},
{ // 188/28D
"The door on the right behind the Gamesman opens. It looks cold and uninviting. To investigate, go to {123}. To stay and play again, go to {110}, but if you spin the wheel again, the door will close until the wheel spins this number to open it again."
},
{ // 189/28E
"You take two dice of sting damage on your CON before the Yellow Jackets disperse. If killed, go to {212}. If not, return to {68} and roll again."
},
{ // 190/28F
"Zwiiick!! A crossbow bolt is shot into the room from the ceiling. The quarrel is aimed purely at random. If you want to avoid it, you must make a SR* on your LK. If you miss the SR*, it hit you doing 5 dice damage to your CON. Another bolt will be shot into the room every 30 seconds until you are killed, go to {212}, or until you decide to leave, go to {200} again."
},
{ // 191/29A
"Poof! The shaft fills up with chlorine gas. If you want to mosey on down the hall, go to {68}. If you want to stay and choke to death, go to {212}."
},
{ // 192/29B
"If you are a wizard or a warrior-wizard, go to {52}. If you are a rogue or a warrior, go to {19}."
},
{ // 193/29C
"As the door opens, a razor-sharp, heavy blade guillotines the doorway. Make a SR* on LK. If you make the SR*, the blade missed you. If you missed the roll, deduct the margin by which you missed it from your CON. If killed, go to {212}. If still alive, proceed to {201}."
},
{ // 194/29D
"This King awards you four dice times 10 gp and adds two points to your ST. Return to {184}."
},
{ // 195/29E
"Your coins all gone, you step back somewhat frustrated, wondering what to do next. Suddenly the lights fade until they are very dim. A door with a big doorhandle and a keyhole appears in the wall. The voice from the ceiling rasps, \"You have 30 seconds to escape before the slot machine kills you!\" The device has already started to sprout gangling arms and knobby legs, and a grotesque face is forming on its front panel. Now you have only 27 seconds left. If you want to try and batter down the door, go to {55}. If you got a skeleton key when you were playing the slot machine, you can try to open the door with that; go to {88}. If you decide that you want to attack the metamorphosing slot machine - an obviously stupid move - go to {10}."
},
{ // 196/29F
"You gladly tell the stern, old Duke all you know. After some debate and more questioning, they decide you are telling the truth. They give you 250 gp, return your equipment, and, after warning you to keep quiet about all this, set you at liberty.\n" \
"  Later you hear that Bronzo's agents met with the Gamesmen and worked out a deal. The Duke, for a \"commission\", is sending prisoners from his royal dungeon to the GM building to \"play\"; if they win, he grants them a royal pardon, but only after he confiscates their prize!\n" \
"  You are pretty happy. Kystroni agents found you and, to your great surprise, returned any undestroyed equipment you left in their building. They also, in return for your silence, paid you your weight in pounds × 10 gp. After all, you did win, and they are a civilized race..."
},
{ // 197/29G
"Your Ace disappears into the slot. You hear tumblers click, and the hatch swings open. Climb in by going to {22}."
},
{ // 198/30A
"In the distance you see a doorway. You pass through it into a circular room, and a metal door closes behind you. Centred in the floor of the room is a hole, 3' in diameter. Inspection reveals it to be a chute which curves so you cannot see where it leads.\n" \
"  \"One setting of the chute leads to certain death,\" says the buzzy voice. \"The others lead to a chance for life and wealth. Hope for the best, and descend.\" You hear a whirring noise. Looking up, you see a huge, whirling blade descending rapidly from the ceiling. Unless you want to end up a puree, you must jump down the chute, and quickly! Roll one die to see what mode the chute is in.\n" \
"    Die Roll    Go to paragraph\n" \
"    1.......................{103}\n" \
"    2.......................{167}\n" \
"    3........................{60}\n" \
"    4.......................{164}\n" \
"    5.......................{108}\n" \
"    6........................{48}"
},
{ // 199/30B
#ifdef CENSORED
"A drop poured from this bottle and placed on your tongue makes all your wounds feel better. The bottle contains 6 ounces of liquid.\n" \
"  If and when you or someone else drinks one ounce of this potion, then, and only then, go to {43} and follow the directions there. Return to {110}."
#else
"This bottle is covered with pictures of crying infants, and a drop placed on your tongue makes all your wounds feel better. The bottle contains 6 ounces of liquid.\n" \
"  If and when you or someone else drinks one ounce of this potion, then, and only then, go to {43} and follow the directions there. Return to {110}."
#endif
},
{ // 200/30C
"You go through a short corridor, and enter a circular room 30' in diameter. A metal door closes behind you. In the centre of the room is a 12' wide pit. You see 5 ways to descend. First of all, you can jump; go to {32}. Second, you can walk down the narrow flight of stairs around its border; go to {206}. Third, there is a ladder of metal rungs you could use; go to {76}. Fourth, there is a rope tied securely to a peg in the floor; go to {210}. Finally, the walls of the pit are very rough and uneven, and you could probably clamber down spider-style if you wanted to risk it; go to {150}. If you want to stop and rest, and think about it for a while, go to {190}."
},
{ // 201/31A
"You go through the door, descend down a narrow stairway, and enter a room with walls of glass through which you see exotic fish and see life swimming languidly about. At regular intervals around the room are ladders leading up six 20' tubular glass shafts to six round hatches. The monitor's buzzy voice speaks:\n" \
"  \"One hatch dooms you. One hatch is free.\n" \
"  \"Four can be opened if you figure out the key.\"\n" \
"  The door you entered suddenly closes. With equal abruptness, the glass room starts to fill with water. The air in the chamber, displaced by the rapidly-rising liquid, whistles out through a vent in the ceiling.\n" \
"  \"In two minutes,\" the voice buzzes, \"the room will be completely filled with water. Happy hunting!\"\n" \
"  It will take an average of 20 plus 5d6 (5-30) extra seconds for you to examine each hatch. After 120 seconds, you must start making saving rolls on CON, starting at level 2 and going up 2 levels for each additional hatch you have to check out in order to escape from this room. If you miss a SR on CON, you run out of air before you can get the hatch open; go to {212}.\n" \
"    To check hatch #    Go to paragraph\n" \
"    one..............................{67}\n" \
"    two..............................{62}\n" \
"    three...........................{112}\n" \
"    four............................{213}\n" \
"    five............................{143}\n" \
"    six.............................{129}\n" \
"Or, to check out that large grate-covered vent in the ceiling, go to {69}."
},
{ // 202/32A
"This bottle bears the label \"No-See-Me Grease\" and contains a clear, odourless, white ointment. There is only just enough for one application to a single person and his equipment.\n" \
"  If and when you use this salve by applying it to someone or something, then and only then go to {157} and follow the directions there. Till then, return to {110}."
},
{ // 203/32B
"This potion is cursed and halves the character's ST instead of doubling it. Be sure to check and make sure you can still wear and wield the weapons and armour you have on when you take this."
},
{ // 204/32C
"This bottle bears the inscription STX2. A drop placed on your tongue makes you feel like doing pushups.\n" \
"  If and when you or someone else drinks this potion, then and only then go to {153} and read the directions there. Return to {110}."
},
{ // 205/32D
"The exit door opens when you reach it. You pass through into a huge dark room. In the distance you see a light. Moving cautiously towards it, you soon see a squat, hooded figure seated behind a candle-lit table. It shuffles a deck of cards with its scaly reptilian hands.\n" \
"  \"Welcome,\" it hisses in an odd, sibilant voice. \"To escape from this room you can play the card game. That's the easy way. Or you can try to kill me. That's the hard way. Make up your mind.\"\n" \
"  If you want to attack this strange creature, go to {89}. If you'd rather play cards with it first, go to {184}."
},
{ // 206/32E
"Make a SR* on LK. If you make it, congratulations. You missed all the triggers and reached the bottom safely. Go to {111}. If you missed the SR*, you stepped on something that went \"click\". Go to {83} to see what happened next."
},
{ // 207/32F
"You leap towards the bulky administrator, but before you get to him, you feel a sudden sensation of crushing weight. Your weapons and armour seem to weigh tons. Overcome by the invisible pressure, you fall to the floor. The guards, unaffected by the invisible force, come forward to seize and disarm you. As they drag you away, the fat man speaks once more: \"Kystrone is a large, very dense planet. I keep a high gravity field around me to protect me and make me feel more at home here.\" His laughter mocks you as the guards escort you down the hall to {100} (ignore the first sentence)."
},
{ // 208/33A
"You haven't gone a dozen steps when six warriors armed with staves trot around the corner in front of you. If you want to run for it, go to {11}. To surrender, go to {100}. To draw your weapon and attack them, go to {120}."
},
{ // 209/33B
"These Restoration potions are, on a roll of 1-3 on a six-sided die, likely to be seriously flawed. In this case, the drinker will lose 6 points from his CON instead of being healed."
},
{ // 210/33C
"To descend safely via the rope will require you to make a L2-SR on ST (25 - ST). If you make it, go to {111}. If you miss it, go to {175}."
},
{ // 211/33D
"You stand in a room 30' wide and 100' long. At the far end of the room is a door, and on each wall is a double row of 3' square metal doors, one over the other. The room is very cold.\n" \
"  If you want to open one of the square vault doors to see what's inside, go to {168}. If you want to peek through the little window in the door at the far end of the room, go to {106}."
},
{ // 212/33E
"Robots enter and carefully collect your remains. From here you will be taken to a special room where your body will be repaired. A wizard will then animate you with a permanent Zombie Zonk spell, and you will be shipped to the planet Kystrone to mine the deadly element, Gecium, until its rays disintegrate you into dust. But that's death..."
},
{ // 213/33F
"Nothing but brute strength will force this hatch open. Make a SR* on ST. If you make it, you opened the hatch; go to {22}. If you missed the SR*, [your intuition tells you that further attempts are fruitless; ]return to {201}, and remember to mark off time."
}
};

MODULE SWORD gk_exits[GK_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  15,  27,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  56, 152, 119,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  { 162, 208, 125,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  91, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/2A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/2B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2C
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2D
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/2E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2F
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/2G
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/2H
  {  40,  37,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/3A
  {  99,  36,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/3B
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/3C
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/3D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/4A
  {  63,  49,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/4C
  { 130, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/4D
  { 148,  95, 145,  -1,  -1,  -1,  -1,  -1 }, //  23/4E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/4F
  { 193,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/4G
  { 100, 120, 207,  -1,  -1,  -1,  -1,  -1 }, //  26/4H
  { 131,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/5A
  { 121, 114,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/5B
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/5C
  {  53,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/5D
  { 182, 102,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/5E
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/5F
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/5G
  { 136,   3,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/5H
  {  64, 100,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/6A
  {  99,  72,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/6B
  {   2,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/6C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/6D
  { 124,  74,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/6E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/7A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/7B
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/7D
  { 139,  92,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/7E
  { 196,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/8A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/8B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/8C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/8D
  {  34,   3,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/8E
  { 143, 201,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/8F
  {  32, 166,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/8G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/8H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/8J
  {  61, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/8K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/8L
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/9A
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/9B
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/9C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/9D
  {  51, 166,  32,  -1,  -1,  -1,  -1,  -1 }, //  60/9E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/9F
  { 171,  98, 201,  -1,  -1,  -1,  -1,  -1 }, //  62/10A
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/10B
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/10C
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/10D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/10E
  {  98, 201,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/11A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/11B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/11C
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/11D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/11E
  {  99,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/11F
  { 131,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/11G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/11H
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/11J
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/11K
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/11L
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/11M
  { 133, 208,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/12A
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/12B
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/12C
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/12D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/13A
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/13B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/13C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/13D
  { 200,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/13E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/13F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/13G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/13H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/13J
  {  79,  38,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/13K
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/13L
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/13M
  { 148, 145,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/14A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/14B
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/14C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/14D
  {  12, 178,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/15A
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/15B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/15C
  {  74,  65,   8,  -1,  -1,  -1,  -1,  -1 }, // 102/15D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/15F
  {  24, 180,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/16B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/16C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/16D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/16E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/16F
  {  68, 191,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/16G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/16H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/16J
  {  96,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/16K
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/16L
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/17A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/17B
  { 156,   6,  91,  -1,  -1,  -1,  -1,  -1 }, // 118/17C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/17D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/17E
  {  92, 139,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/17F
  { 198,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/17G
  {  59,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/17H
  {  74, 102,  85,  -1,  -1,  -1,  -1,  -1 }, // 124/19A
  {  66,  71,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/19B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/19C
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/19D
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/19E
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/19F
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/19G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/19H
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/20A
  { 208,  26, 207,  -1,  -1,  -1,  -1,  -1 }, // 133/20B
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/20C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/20D
  { 142, 102, 208,  -1,  -1,  -1,  -1,  -1 }, // 136/20E
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/20F
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/20G
  { 211, 208,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/20H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/21A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/21B
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/21C
  {  50,  98, 201,  -1,  -1,  -1,  -1,  -1 }, // 143/21D
  { 100,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/21E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/21F
  { 100, 120,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/21G
  {  14, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/21H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/21J
  { 116, 158, 109,  -1,  -1,  -1,  -1,  -1 }, // 149/21K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/21L
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/21M
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/22A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/22B
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/22C
  { 165, 189, 126,  -1,  -1,  -1,  -1,  -1 }, // 155/22D
  { 212,  68,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/22E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/22F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/23A
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/23B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/23C
  {  94,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/23D
  {  97, 104,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/23E
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/23F
  {   4,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/24A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165/24B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/24C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/24D
  { 106,  74,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/25A
  {  25, 193,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169/25B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170/25C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171/25D
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172/25E
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173/25F
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174/25G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175/25H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176/25J
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177/25K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178/25L
  { 120, 100,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179/25M
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180/25N
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181/26A
  {   9, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182/26B
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183/26C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184/27A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185/28A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186/28B
  { 102,  74,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187/28C
  { 123, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188/28D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189/28E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190/28F
  {  68, 212,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191/29A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192/29B
  { 201,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193/29C
  { 184,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194/29D
  {  55,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195/29E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196/29F
  {  22,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197/29G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198/30A
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199/30B
  {  32, 206,  76, 210, 150, 190,  -1,  -1 }, // 200/30C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201/31A
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202/32A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203/32B
  { 110,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204/32C
  {  89, 184,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205/32D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206/32E
  { 100,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207/32F
  {  11, 100, 120,  -1,  -1,  -1,  -1,  -1 }, // 208/33A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209/33B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210/33C
  { 168, 106,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211/33D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212/33E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 213/33F
};

MODULE STRPTR gk_pix[GK_ROOMS] =
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
  "gk15", //  15
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
  "gk61",
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
  "gk116",
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
  "gk131",
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
  "gk158",
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
  "gk181",
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
  "gk212",
  ""  // 213
};

MODULE FLAG                   rolled[12 + 1];
MODULE int                    secs,
                              hatches,
                              tiles;

IMPORT int                    age,
                              armour,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              prevroom, room, module,
                              spellchosen,
                              spelllevel,
                              spellpower,
                              theround;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void gk_enterroom(void);
// MODULE void gk_wandering(FLAG mandatory);
MODULE void drawcard(void);
MODULE FLAG gk_saved(int stat);

EXPORT void gk_preinit(void)
{   descs[MODULE_GK]   = gk_desc;
 // wanders[MODULE_GK] = gk_wandertext;
}

EXPORT void gk_init(void)
{   int i;

    exits     = &gk_exits[0][0];
    enterroom = gk_enterroom;
    for (i = 0; i < GK_ROOMS; i++)
    {   pix[i] = gk_pix[i];
    }

    secs      =
    hatches   =
    tiles     = 0;
    for (i = 0; i <= 12; i++)
    {   rolled[i] = FALSE;
}   }

MODULE void gk_enterroom(void)
{   int choice,
        i,
        result,
        result1,
        result2;

    switch (room)
    {
    case 4:
        if (gk_saved(chr) && saved(1, lk))
        {   lose_flag_ability(88);
            elapse(ONE_DAY / 2, TRUE);
            room = 201;
        } else
        {   room = 46;
        }
    acase 6:
        templose_con(level);
        if (con <= 0)
        {   room = 212;
        }
    acase 7:
        give(482);
    acase 8:
        create_monster(241);
        oneround();
        if (countfoes())
        {   dispose_npcs();
        } else
        {   award(2000 / level);
        }
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 56;
        }
    acase 9:
        savedrooms(1, lk, 35, 81);
    acase 11:
        templose_con(con / 6);
        borrow_all();
    acase 12:
        if (items[830].owned == 0)
        {   room = 195;
        } else
        {   destroy(830);
            result = dice(2);
            switch (result)
            {
            case 2:
                room = 17;
            acase 3:
                room = 116;
            acase 4:
                room = 158;
            acase 5:
                room = 86;
            acase 6:
                room = 170;
            acase 7:
                room = 151;
            acase 8:
                room = 186;
            acase 9:
                room = 107;
            acase 10:
                room = 127;
            acase 11:
                room = 29;
            acase 12:
                room = 87;
        }   }
    acase 13:
        if (gk_saved(lk))
        {   give_gp(madeitby(lk / 10, lk));
            gain_lk(2);
        } else
        {   lose_lk(dice(1));
        }
    acase 18:
        templose_con(dice(1));
    acase 19:
        if (been[19])
        {   room = 54;
        } else
        {   if (dice(1) == 1)
            {   give(833);
            } else
            {   give(483);
            }
            room = 110;
        }
    acase 20:
        dispose_npcs();
    acase 24:
        if (items[489].owned)
        {   result = 6;
        } elif (items[493].owned)
        {   result = 3;
        } else
        {   result = 0;
        }
        do
        {   getsavingthrow(TRUE);
            if (madeit(st / 10, st + result))
            {   templose_con(dice(1));
                room = 68;
            } else
            {   templose_con(misseditby(st / 10, st + result));
            }
            if (con <= 0)
            {   room = 212;
        }   }
        while (room == 24);
    acase 29:
        give(484);
    acase 33:
        give(485);
    acase 38:
        savedrooms(5, lk, 139, 208);
    acase 40:
        if (getyn("Obey"))
        {   borrow_all();
            room = 16;
        } else
        {   room = 57;
        }
    acase 41:
        if (saved(1, lk))
        {   templose_con(2);
            room = 28;
        } else
        {   room = 73;
        }
    acase 42:
        if (gk_saved(chr))
        {   gain_chr(1);
            gain_lk(1);
        } else
        {   lose_lk(dice(1));
        }
    acase 46:
        if (castspell(-1, FALSE))
        {   room = 140;
        } else
        {   room = 58;
        }
    acase 47:
        if (getyn("Escape (otherwise wait)"))
        {   if (gk_saved(dex))
            {   room = 200;
            } else
            {   room = 138;
        }   }
        else
        {   room = 195;
        }
    acase 48:
        if (gk_saved(iq))
        {   room = 101;
        } else
        {   room = 169;
        }
    acase 50:
        if (gk_saved(iq) && gk_saved(dex))
        {   room = 22;
        } else
        {   secs += 10;
            room = 143;
        }
    acase 52:
        if (been[52])
        {   room = 147;
        } else
        {   if (dice(1) == 1)
            {   give(ITEM_GK_CDELUXE);
            } else
            {   give(DEL);
            }
            room = 110;
        }
    acase 53:
        if (!gk_saved(dex))
        {   templose_con(misseditby(dex / 10, dex));
        }
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 68;
        }
    acase 55:
        if (gk_saved(st))
        {   room = 200;
        } else
        {   room = 10;
        }
    acase 56:
        borrow_all();
    acase 57:
        drop_all();
    acase 58:
        gain_flag_ability(62);
    acase 59:
        return_all();
        victory(150);
    acase 61:
        create_monster(242);
        npc[0].con += 6 * level;
        npc[0].adds = 5 * level;
        // recalc_ap(); not needed
        fight();
        if (con <= 0)
        {   room = 212;
        } else
        {   award(120 + (110 * level));
        }
    acase 62:
        if (items[490].owned && getyn("Insert ace card"))
        {   room = 197;
        }
    acase 63:
        award(150);
    acase 66:
        templose_con(dice(1));
        if (con >= 1)
        {   room = 208;
        } else
        {   room = 212;
        }
    acase 67:
        if (items[494].owned && getyn("Use skeleton key"))
        {   room = 134;
        }
    acase 68:
        while (room == 68 && tiles < 5)
        {   tiles++;
            if (!gk_saved(lk))
            {   result = dice(1);
                switch (result)
                {
                case 1:  room =  23;
                acase 2: room = 155;
                acase 3: room = 118;
                acase 4: room = 105;
                acase 5: room =  30;
                acase 6: room = 135;
        }   }   }
        if (room == 68)
        {   room = 205;
        }
    acase 69:
        if (saved(1, st))
        {   room = 49;
        } else
        {   secs += 30;
            room = 201;
        }
        // %%: "try one of the hatches": this implies we can't retry the vent? What about later?
    acase 71:
        if (saved(4, st) && saved(4, con))
        {   room = 45;
        } else
        {   room = 66;
        }
    acase 72:
        if (!gk_saved(dex))
        {   templose_con(misseditby(dex / 10, dex));
        }
    acase 73:
        result1 = dice(1);
        result2 = dice(1);
        templose_con(result1 + result2);
        if (result1 == result2)
        {   while (cast(SPELL_RS, TRUE));
            if (con < max_con)
            {   elapse(ONE_MONTH, FALSE);
                room = 27;
        }   }
    acase 74:
        savedrooms(1, lk, 92, 208);
    acase 75:
        if (gk_saved(dex))
        {   gain_dex(dice(1));
        } else
        {   lose_dex(dice(1));
        }
    acase 76:
        if (dex <= 10 && !saved(1, dex))
        {   room = 175;
        } else
        {   room = 111;
        }
    acase 77:
        if (gk_saved(st))
        {   gain_st(1);
        } else
        {   permlose_st(dice(1));
        }
    acase 80:
        if (gk_saved(iq))
        {   give_gp(1);
            gain_iq(1);
        } else
        {   lose_iq(dice(1));
        }
    acase 81:
        templose_con(con / 6);
        borrow_all();
    acase 82:
        give(486);
    acase 83:
        if (gk_saved(dex))
        {   room = 111;
        } else
        {   room = 175;
        }
    acase 84:
        give(487);
    acase 85:
        savedrooms(3, lk, 31, 81);
    acase 86:
        if (been[86])
        {   room = 151;
        } else
        {   gain_flag_ability(63);
            room = 12;
        }
    acase 88:
        if (gk_saved(dex) && gk_saved(iq))
        {   dropitem(494);
            room = 200;
        } else
        {   room = 10;
        }
    acase 89:
        create_monster(243);
        npc[0].mr += 10 * level;
        recalc_ap(0);
        fight();
        if (con <= 0)
        {   room = 212;
        } else
        {   award(20 + (20 * level));
            room = 198;
        }
    acase 90:
        templose_con(level * 2);
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 53;
        }
    acase 91:
        templose_con((level * 2) + dice(2)); // %%: ambiguous about order of operations
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 68;
        }
    acase 93:
        give(488);
    acase 94:
        give(498);
        if (cast(SPELL_OE, FALSE))
        {   room = 183;
        } else
        {   room = 22;
        }
    acase 95:
        templose_con(dice(1));
        if (con <= 0)
        {   room = 212;
        }
    acase 96:
        if (armour == -1)
        {   if (gk_saved(spd))
            {   room = 121;
            } else
            {   room = 146;
        }   }
        else
        {   if (saved((spd / 10) + (items[armour].hits / 6), spd))
            {   room = 121;
            } else
            {   room = 146;
        }   }
    acase 98:
        if (saved(level, st))
        {   room = 22;
        } else
        {   room = 201;
        }
    acase 99:
        give_multi(830, 12);
        give(LEA);
    acase 100:
        borrow_all();
    acase 101:
        if (gk_saved(dex))
        {   room = 201;
        } else
        {   room = 193;
        }
    acase 103:
        savedrooms(1, lk, 198, 70);
    acase 104:
        die();
    acase 106:
        if (dice(1) <= 3)
        {   room = 39;
        } else
        {   room = 187;
        }
    acase 107:
        if (been[107])
        {   room = 151;
        } else
        {   give(489);
            room = 12;
        }
    acase 108:
        if (gk_saved(st))
        {   room = 201;
        } else
        {   room = 176;
        }
    acase 109:
        if (cast(SPELL_KK, FALSE))
        {   room = 149;
        } else
        {   room = 12;
        }
    acase 110:
        result = dice(1);
        switch (result)
        {
        case 1:
            room = 147;
        acase 2:
            room = 54;
        acase 3:
            room = 188;
        acase 4:
            room = 173;
        acase 5:
            room = 192;
        acase 6:
            room = 117;
        }
    acase 112:
        savedrooms(1, lk, 201, 78);
    acase 113:
        makeclone(0);
        npc[0].ap = calc_personaladds(st, lk, dex) * 10;
        recalc_ap(0);
        fight();
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 205;
        }
    acase 115:
        if (gk_saved(chr))
        {   gain_chr(dice(1));
        } else
        {   lose_chr(dice(1));
        }
    acase 116:
        if (been[116])
        {   room = 151;
        } else
        {   create_monster(244);
            if (st > dex)
            {   npc[0].mr = st;
            } else
            {   npc[0].mr = dex;
            }
            recalc_ap(0);
            fight();
            if (con <= 0)
            {   room = 212;
            } else
            {   room = 12;
        }   }
    acase 117:
        result = dice(2);
        if (rolled[result])
        {   result = 7;
        }
        rolled[result] = TRUE;
        switch (result)
        {
        case 2:   room = 132;
        acase 3:  room = 202;
        acase 4:  room =   7;
        acase 5:  room =  93;
        acase 6:  room = 154;
        acase 7:  room = 163;
        acase 8:  room = 199;
        acase 9:  room =  33;
        acase 10: room = 204;
        acase 11: room =  82;
        acase 12: room =  84;
        }
    acase 119:
        savedrooms(3, lk, 44, 56);
    acase 120: // %%: ambiguous paragraph
        if (prevroom != 179)
        {   create_monsters(245, 5);
            if (castspell(-1, FALSE))
            {   room = 179;
        }   }
        if (room == 120)
        {   if (saved((lk / 10) + 1, lk) && saved((dex / 10) + 1, dex))
            {   room = 20;
            } else
            {   fight();
                if (!countfoes())
                {   room = 181;
        }   }   }
    acase 122:
        give(490);
    acase 123:
        give_gp(weight);
        return_all();
    acase 126:
        templose_con(dice(1));
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 68;
        }
    acase 127:
        rb_givejewels(-1, -1, 1, 3);
    acase 128:
        if (gk_saved(chr))
        {   give_gp(1);
            gain_chr(1);
        } else
        {   lose_chr(dice(1));
        }
    acase 131:
        if (saved(1, dex))
        {   savedrooms(2, st, 28, 41);
        } else
        {   savedrooms(2, st, 41, 73);
        }
    acase 132:
        give(491);
    acase 134:
        ; // %%: it doesn't say that the key disappears, so we let them keep it
    acase 135:
        if (gk_saved(iq))
        {   room = 113;
        } else
        {   room = 212;
        }
    acase 136:
        if (gk_saved(con))
        {   gain_con(dice(1));
        } else
        {   permlose_st(dice(1));
        }
    acase 140:
        if (spellchosen == SPELL_WL || spellchosen == SPELL_MP || spellchosen == SPELL_DW)
        {   room = 161;
        } elif (spellchosen == SPELL_TF || spellchosen == SPELL_BP || spellchosen == SPELL_IF || spellchosen == SPELL_HB)
        {   rebound(FALSE);
        }
        if (con <= 0)
        {   room = 212;
        } elif (room == 140)
        {   room = 58;
        }
    acase 144:
        if (saved(3, lk))
        {   room = 208;
        }
    acase 145:
        templose_con(dice(1));
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 68;
        }
    acase 148:
        templose_con((level * 2) + dice(2)); // %%: ambiguous about order of operations
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 68;
        }
    acase 150:
        if (gk_saved(st) && gk_saved(dex))
        {   room = 111;
        } else
        {   room = 175;
        }
    acase 151:
        give_gp(3);
    acase 152:
        savedrooms(4, lk, 44, 18);
    acase 154:
        give(492);
    acase 156:
        templose_con(dice(1));
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 68;
        }
    acase 158:
        if (been[158])
        {   room = 151;
        } else
        {   result = 0;
            if (items[493].owned)
            {   result += 3;
            }
            if (items[489].owned)
            {   result += 6;
            }
            do
            {   if (saved((dex - result) / 10, dex))
                {   if (saved((lk - result) / 10, lk))
                    {   award(200);
                        room = 12;
                    } else
                    {   templose_con(misseditby((lk - result) / 10, lk));
                        if (con <= 0)
                        {   room = 212;
                }   }   }
                else
                {   templose_con(misseditby((dex - result) / 10, dex));
                    if (con <= 0 || !saved((lk - result) / 10, lk))
                    {   room = 212;
            }   }   }
            while (room == 158);
        }
    acase 159:
        give_gp(dice(2) * 10);
        gain_lk(1);
    acase 161:
        if (spellchosen != SPELL_WL && spellchosen != SPELL_MP && spellchosen != SPELL_DW)
        {   room = 58;
        }
    acase 163:
        give_gp(7);
    acase 165:
        templose_con(dice(3));
        if (con <= 0)
        {   room = 212;
        } else
        {   tiles--;
            room = 68;
        }
    acase 166:
        if (gk_saved(dex) && gk_saved(dex))
        {   room = 201;
        } else
        {   room = 212;
        }
    acase 167:
        create_monster(246);
        npc[0].mr += (st + lk) / 2;
        npc[0].ap = npc[0].mr * 3;
        recalc_ap(0);
        theround = 0;
        do
        {   oneround();
            if
            (   con <= 0
             || (good_damagetaken >= 1 && !immune_poison() && !gk_saved(lk))
            )
            {   room = 212;
        }   }
        while (room == 167 && countfoes());
        if (room == 167)
        {   room = 201;
        }
    acase 170:
        if (been[170])
        {   room = 151;
        } else
        {   give(493);
            room = 12;
        }
    acase 171:
        templose_con(dice(1));
        if (!saved(1, lk))
        {   templose_con(dice(2));
        }
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 201;
        }
    acase 172:
        give_gp(dice(1) * 10);
        gain_iq(1);
    acase 173:
        if (gk_saved(lk))
        {   give_gp(madeitby(lk / 10, lk));
        } else
        {   result = misseditby(lk / 10, lk) * 100;
            while (money < result)
            {   choice = getnumber("1) Sell 1 ST\n2) Sell 1 IQ\n3) Sell 1 LK\n4) Sell 1 CON\n5) Sell 1 DEX\n6) Sell 1 CHR\n7) Sell 1 SPD\nWhich", 1, 7);
                switch (choice)
                {
                acase 1:
                    permlose_st(1);
                    give_gp(5);
                acase 2:
                    lose_iq(1);
                    give_gp(5);
                acase 3:
                    lose_lk(1);
                    give_gp(5);
                acase 4:
                    permlose_con(1);
                    give_gp(5);
                acase 5:
                    lose_dex(1);
                    give_gp(5);
                acase 6:
                    lose_chr(1);
                    give_gp(5);
                acase 7:
                    lose_spd(1);
                    give_gp(5);
            }   }
            pay_cp(result);
        }
    acase 174:
        if (gk_saved(dex))
        {   gain_dex(1);
        } else
        {   lose_dex(dice(1));
        }
    acase 175:
        templose_con(dice(dice(1)));
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 111;
        }
    acase 176:
        for (i = 1; i <= 3; i++)
        {   if (gk_saved(st))
            {   room = 201;
                break;
        }   }
        if (room == 176)
        {   room = 212;
        }
    acase 178:
        if (cast(SPELL_KK, FALSE))
        {   room = 149;
        } else
        {   room = 12;
        }
    acase 179:
        if (spellchosen == SPELL_TF || spellchosen == SPELL_BP || spellchosen == SPELL_IF || spellchosen == SPELL_HB)
        {   payload(TRUE);
        }
    acase 184:
        drawcard();
    acase 186:
        if (been[186])
        {   room = 151;
        } else
        {   give(494);
            room = 12;
        }
    acase 189:
        templose_con(dice(2));
        if (con <= 0)
        {   room = 212;
        } else
        {   room = 68;
        }
    acase 190:
        do
        {   if (!gk_saved(lk))
            {   templose_con(dice(5)); // %%: armour doesn't help?
                if (con <= 0) room = 212;
        }   }
        while (room == 190 && getyn("Wait (otherwise leave)"));
        if (room == 190)
        {   room = 200;
        }
    acase 192:
        if (class == WIZARD || class == WARRIORWIZARD)
        {   room = 52;
        } else
        {   room = 19;
        }
    acase 193:
        if (prevroom == 25)
        {   if (!saved(1, lk))
            {   templose_con(misseditby(1, lk));
        }   }
        else
        {   if (!gk_saved(lk))
            {   templose_con(misseditby(lk / 10, lk));
        }   }
        if (con <= 0)
        {   room = 212;
        }
    acase 194:
        give_gp(dice(4) * 10);
        gain_st(2);
    acase 195:
        if (items[494].owned && getyn("Use skeleton key"))
        {   room = 88;
        }
    acase 196:
        give_gp(250);
        return_all();
        give_gp(weight);
        victory(150);
    acase 197:
        dropitem(490);
    acase 198:
        result = dice(1);
        switch (result)
        {
        case 1:
            room = 103;
        acase 2:
            room = 167;
        acase 3:
            room = 60;
        acase 4:
            room = 164;
        acase 5:
            room = 108;
        acase 6:
            room = 48;
        }
    acase 199:
        give_multi(495, 6);
    acase 201:
        secs += 20 + dice(5); // %%: we assume the vent counts as a "hatch" for timing purposes
        if (secs >= 120)
        {   if (!saved(2 + hatches, con))
            {   room = 212;
            } else
            {   hatches += 2;
        }   }
        result = getnumber(
            "1-6) Hatch #1-#6\n" \
            "7) Vent\n" \
            "Open what", 1, 7);
        switch (result)
        {
        case 1:
            room = 67;
        acase 2:
            room = 62;
        acase 3:
            room = 112;
        acase 4:
            room = 213;
        acase 5:
            room = 143;
        acase 6:
            room = 129;
        acase 7:
            room = 69;
        }
    acase 202:
        give(496);
    acase 204:
        give(497);
    acase 206:
        if (gk_saved(lk))
        {   room = 111;
        } else
        {   room = 83;
        }
    acase 207:
        borrow_all(); // %%: or just weapons?
    acase 210:
        savedrooms(2, st, 111, 175);
    acase 212:
        die();
    acase 213:
        if (gk_saved(st))
        {   room = 22;
        } else
        {   room = 201;
}   }   }

MODULE FLAG gk_saved(int stat)
{   if (saved(stat / 10, stat))
    {   return TRUE;
    } else
    {   return FALSE;
}   }

MODULE void drawcard(void)
{   TRANSIENT       int    card1, card2,
                           choice,
                           value1, value2;
    PERSIST   const STRPTR cardnames[13] =
    { "Ace",   //  0
      "2",     //  1
      "3",     //  2
      "4",     //  3
      "5",     //  4
      "6",     //  5
      "7",     //  6
      "8",     //  7
      "9",     //  8
      "10",    //  9
      "Jack",  // 10
      "Queen", // 11
      "King"   // 12
    }, suits[4] =
    { "Spades",
      "Clubs",
      "Hearts",
      "Diamonds"
    };

    while (room == 184)
    {   if (gp == 0)
        {   room = 89;
        } else
        {   choice = getnumber("0) Done\n1) Sell 1 ST\n2) Sell 1 IQ\n3) Sell 1 LK\n4) Sell 1 CON\n5) Sell 1 DEX\n6) Sell 1 CHR\n7) Sell 1 SPD\n8) Play\nWhich", 0, 8);
            switch (choice)
            {
            case 0:
                room = 89;
            acase 1:
                permlose_st(1);
                give_gp(5);
            acase 2:
                lose_iq(1);
                give_gp(5);
            acase 3:
                lose_lk(1);
                give_gp(5);
            acase 4:
                permlose_con(1);
                give_gp(5);
            acase 5:
                lose_dex(1);
                give_gp(5);
            acase 6:
                lose_chr(1);
                give_gp(5);
            acase 7:
                lose_spd(1);
                give_gp(5);
            acase 8:
                card1 = rand() % 52;
                aprintf("Your card is the %s of %s.\n", cardnames[card1 % 13], suits[card1 / 13]);
                switch (card1)
                {
                case 0:
                case 13:
                case 26:
                case 39:
                    room = 122; // Ace
                acase 10: // Jack of Spades
                    room = 174;
                acase 11: // Queen of Spades
                    room = 42;
                acase 12: // King of Spades
                    room = 77;
                acase 23: // Jack of Clubs
                    room = 80;
                acase 24: // Queen of Clubs
                    room = 128;
                acase 25: // King of Clubs
                    room = 13;
                acase 36: // Jack of Hearts
                    room = 75;
                acase 37: // Queen of Hearts
                    room = 115;
                acase 38: // King of Hearts
                    room = 137;
                acase 49: // Jack of Diamonds
                    room = 172;
                acase 50: // Queen of Diamonds
                    room = 159;
                acase 51: // King of Diamonds
                    room = 194;
                }

                if (room == 184)
                {   card2 = rand() % 52;
                    aprintf("His card is the %s of %s.\n", cardnames[card2 % 13], suits[card2 / 13]);

                    value1 = (card1 % 13) + 1;
                    value2 = (card2 % 13) + 1;
                    if (value2 > 10)
                    {   value2 = 10;
                    }
                    if (value1 > value2)
                    {   give_gp(value1 - value2);
                    } elif (value1 < value2)
                    {   pay_gp(value2 - value1);
}   }   }   }   }   }
