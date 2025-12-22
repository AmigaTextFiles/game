#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

#define TABLE_A 0
#define TABLE_B 1
#define TABLE_C 2
#define TABLE_D 3

/* Official errata (already applied):
Paragraph 247 tells you to go to paragraph 281 on a roll of 5-6. This should be 271.
Paragraph 295: the GOTO 269 should be GOTO 279.
Some issues:
DT323: it implies Ulkara has 18 CON/MR, but in the next paragraph (DT376), he "has an MR of 48".
DT339: it says Mortol "he has no armour or other protection", but in the next paragraph (DT376), he "has cloth armour (2 hits)".
 And if cloth armour is supposed to be the same as "complete quilted silk/cotton", that normally takes 3 hits anyway.
 And it wants 21 damage to kill him, when it should be 18 (assuming no armour) or 20 (assuming the cloth armour takes 2 hits).
 And DT390 says his cloth armour takes 4 hits!
DT353: it tells us to go to DT1 afterwards, but DT15 (which is the only paragraph that leads to DT353) tells us to go to DT33 afterwards.
DT328: it says he has 10 points of armour, but DT364 says it is chainmail.
Table B of the Encounter Chart is never used!
What does "disabled" mean? DT292 provides an answer: "Constitution or Strength under 6".
*/

MODULE const STRPTR dt_desc[DT_ROOMS] = {
{ // 0
"±`INSTRUCTIONS\n" \
"  Dark Temple is a solitaire adventure for Tunnels & Trolls; you must own a copy of the rules to play. Some ordinary dice, lots of scrap paper, pencil, eraser, and a Tunnels & Trolls character are also required.\n" \
"  Abbreviations used:\n" \
"    ap = Adventure Points (also known as \"Experience Points\")\n" \
"    gp = Gold Pieces\n" \
"    L1 = Level 1, L2 = Level 2, etc.\n" \
"    MR = Monster Rating\n" \
"    sp = Silver Pieces\n" \
"    SR or ST = Saving Roll or Saving Throw (same thing)\n" \
"If you haven't tried a solitaire adventure before, here are the basic rules. Each numbered section in the booklet describes a situation, some instructions, and several alternatives that you must choose from. When you've made a choice, turn to the new paragraph listed under the course of action you have chosen. For example:\n" \
"  \"45. As you climb up the sheer rock face, you notice a number of fist-sized holes leading into the rock. If you continue climbing, turn to {67}. If you stick your hand in one of the holes, see {78}. If you put your face up to a hole to look inside, turn to {88}.\"\n" \
"  Do not read through the booklet from beginning to end; do not read ahead to see what will happen if you choose x instead of y. This is cheating!\n" \
"  Sometimes, the paragraph you turn to may be determined by a die roll, or the results of a saving roll. Read the paragraph carefully to determine how to make the roll. Two examples:\n" \
"  \"69. You stumble blindly through the forest, struggling to remove the bucket glued on your head. Forest animals cry in fear and flee when they catch sigh of you...except for a few crows, who merely laugh. At long last, you get the bucket off. Roll a die to determine where you are.\n" \
"    1-3: Go to {80}\n" \
"    4-5: Turn to {101}\n" \
"    6:   Go to {92}\"\n" \
"  \"89. The panther woman pounces on you as you try to flee the sacred grove. You try to squirm out of her grasp, to no avail; in seconds she has you thoroughly pinned. You wince at the smell of blood and raw flesh on her breath as she fastens her fangs on your throat. Make an L3-SR vs. Charisma (30 - CHR). çA±dd 10 to your roll if you have the power to control or befriend cats. If you make the roll, turn to {177}. If you miss the roll, she bites your head off.\"\n" \
"  From time to time you will be told to roll on the Encounter Table. You can find this section near the back of the book. There are several tables included in this section, plus some details on how the encountered beings fight. Roll a die on the appropriate table, to determine who (or what!) you have run into. Some encounters have valuable clues or are mini-adventures that you must make choices in; these will direct you to a numbered section in the text. Others are simple fights that you can take care of on the spot. Be sure to keep a note or bookmark of your location in the main adventure when you roll for an encounter! You won't be sent back to a specific paragraph and will lose your place otherwise!\n" \
"  Dark Temple is designed for *low and mid-level characters, with adds of 10-75 points*. Only limited magic is allowed. In combat, your character may cast simple spells (like Take That You Fiend and Blasting Power) to his or her heart's content. Complex spells are usually not allowed; if your champion is in a tough spot where high-level magic might help, you will be given the chance to use it.[ Note that exceedingly gross magic items (ie. magic swords or weapons that get more than 9 dice and/or 50 adds, or wands that can fire 100-point balls of fire constantly while polishing your shoes) are not allowed due to local firearms laws; your character can claim them again when the adventure is over!]\n" \
"  In a \"dungeon\" situation, or when wandering around in a building, each paragraph is considered to be ten minutes long (enough to regenerate one expended Strength point).[ If you are travelling in the wilderness, all Strength is restored between encounters. (Note that Strength only regenerates to half normal if your food is gone...see below.)]\n" \
"  Combat: Most combat in Dark Temple is conducted using normal T&T rules. You must roll the dice for your enemies (and any allies you pick up). Note that some creatures and humanoid enemies have armour; this can be actual armour or shields, or simply tough hide and fur. Deduct armour protection from the creature's share of hits if they should lose a combat round.[ Don't double armour protection for warriors unless instructed to.]\n" \
"  Experience: If you kill a creature or enemy, you earn adventure points. Unless told otherwise, take 1 ap (adventure point) for each point of MR (Monster Rating) the monster started with. If you fought a monster with the help of allies, split the aps you earned between yourselves. If you go up a level in this adventure, you may raise your attributes as normal, but may not buy new spells if you are a wizard or rogue...the Wizard's Guild has not opened a chapter house in this area!\n" \
"  Travel: In Dark Temple, your character may spend much time on the road wandering through untracked wilderness. It is important to keep track of the number of days you spend on the trip. Each travel paragraph indicates the number of days spent travelling through this. (If no time is mentioned, no significant time is spent passing through.) You may also spend days and weeks in jails or dungeons or important side-missions; be sure to record time spent in these situations as well. Note that there are several routes through this adventure; you will have to play several times before finding the shortest route! It is also important to record how many villages you pass through.\n" \
"  Food: You start out the game with aç copious \"ration bag\", which should last for your entire adventure. ±There are a few encounters, however, that result in you losing your food. [If this happens, your Strength is reduced by half until you can restock the bag. There is no other effect. ]If food is available at a town, or is carried or offered by someone you meet, you will be told of the fact. çYou do not need to keep track of individual food units; the ration bag is either full or empty.±\n" \
"  ~When you are ready, turn to paragraph {1} to start your journey. Good luck!ç"
},
{ // 1
"Ah, the simple joys of life on the road! Plenty of fresh air, sleeping under the stars, new sights to see with every passing mile. While walking through the remote province of Myre, you find a pleasant inn to spend the night; a rarity in these parts! The common room is lively with conversation, games, and bawdy singing. After spending a gold hekkat and three silver kaboobs on a mug of cider and a half roast fowl, you look for a place to sit. If you'd like to join the knuckle-toss in the corner, turn to {9}. If you join the crowd listening to the tales of the scarred old mercenary with the missing leg, see {20}. If you prefer a quiet meal, and would like to sit at the table with the group of sombre-looking men dressed in green, go to {28}."
},
{ // 2
"A young man, almost a boy, wishes to accompany you on your quest. He wants to leave the inn to find his fortune, and seek out his uncle who lives near the Granite River. [You may roll up the boy as an ordinary character, but all characteristics but Luck top off at 12; you may roll twice for Luck, taking the higher of the two rolls. The boy has clothing, boots, and a poniard, but no other equipment. ]An orphan, he remembers enough about the country to the north to act as a guide. Go to {4} if you take the mountain path, {46} if the forest trail is more appealing."
},
{ // 3
"The men in green claim to be pilgrims travelling to the temple of Krestok the Lustrous. The leader explains that the troupe of faithful must keep as quiet as possible, lest they disturb the Omnipresent Sphere of Krestok. This behaviour is often mistaken for unfriendliness; in fact, the seemingly gruff exteriors the cultists display is an expression of inspired joy and pleasantness. \"Not everyone believes this,\" says the leader. \"The old adventurer yonder, for example, has taken our silence as an extreme affront, and follows us constantly, spreading horrid tales and lies about the Lustrous one.\" The old cultist mentions that one of his companions overheard the adventurer planning to ambush and rob them. To prevent an unseemly interruption of their journey, the pilgrim suggests you delay the man while his band slips away during the night. He gives you a blowgun of fine silver foil, and three darts[: \"The drug on these will put the rascal in a deep slumber for several hours, but not harm him a lick,\" reassures the cultist, who taps his purse suggestively]. If you take the pilgrim up on his deal, go to {30}. If you refuse, turn to {33}."
},
{ // 4
"Having decided to take the mountain route, you consider what equipment you will need. Your ration bag contains sufficient food for a fair amount of time; in addition, tough hemp rope is available for 2 silver pieces per foot and a piton and hammer set for 12 gold pieces. After buying what you need, you set off. The path is well marked at first, passing a few small farms and a mine where some dwarves and men are at work. All too soon, the path becomes faint and steep; you will need all your skill to continue. If you press on, go to {10}. If you go back to the mine to ask the workers if they know of a better route, see {38}."
},
{ // 5
"The pilgrims continue to eat their gruel, oblivious to all but bowl and spoon. Roll a L2-SR on Charisma (25 - CHR). You may add 6 to the dice roll if you are a rogue. If you fail the roll, see {23}. If you passed the roll, the oldest of the robed men turns to you and begins to talk with you quietly. He asks you for some help, of an unspecified nature. If you agree to his vaguely worded request, see {3}. If you refuse, see {23}."
},
{ // 6
"\"HAH!\" shouts one of the dwarves, \"You're the one who's been stealing our gold, and now you ask us to show you our mine! At 'em, boys!\" The miners grab picks, shovels, and rocks and advance towards you menacingly. There are six miners: three men with MRs of 12, 14, and 14, and three dwarves with MRs of 24, 24, and 36. They are far enough away for you and your companions to get one spell or missile weapon shot off before they close into melee. You may also try to run; this requires a L1-SR on Speed (20 - SPD) to accomplish successfully. You may only try to run before combat and after each time you kill someone. If you are driven off, go to {10}. If you kill them all, you may take the long way ({10}), or explore the mine ({44})."
},
{ // 7
"The trail leads you into a swamp! You spend three days crossing the bog. On each day, roll a die: On a roll of 6, your Ration Bag is lost. On a roll of 1-2, you have met something. To see what it is, roll on Table A of the Encounter Chart. If you survive, you may continue. Roll a die, adding one to the roll if you have a guide with you. On a roll of 1-2, go to {36}. If the die comes up 3-5, see {49}. If you rolled 6 or more, see {55}."
},
{ // 8
"You find a morose, sullen man who agrees to accompany you through the wilderness. He asks for 30 gold pieces[ plus expenses for food (5 gp per day for trail rations) for the trip; he will leave you at the Granite River up north. The guide has attributes of 11 throughout; he wears a leather jerkin and steel cap for protection and carries a sling and dirk. Not one for excitement, the guide will desert you temporarily if wounded in combat]. Go to {4} to travel on the mountain path, {46} to start your journey on the forest route."
},
{ // 9
"The four men already in the game welcome you gladly...if you have some money! If you don't have at least six gold pieces go back to {1} and choose again. If you're monetarily blessed, you can play. The knuckle bones being tossed have five symbols; three are thrown at a time. Roll a die for each bone tossed, rerolling if a 6 comes up. [(If your Dexterity or Luck is over 25, you may instead let the 6 stand for another symbol, to give yourself an edge!) ]See the table below to discover your fortune.\n" \
"    Rolled Number    Symbol    Once    Twice    Thrice\n" \
"          1          Goat      Lose    -        Privy\n" \
"          2          Rooster   -       Even     Double\n" \
"          3          Bull      -       Double   Triple\n" \
"          4          Fox       Double  Double   Triple\n" \
"          5          Bat       Triple  Triple   Quintuple\n" \
"          6          ------------ Roll Again ------------\n" \
"The rolls are always interpreted in the worst way. If you get a double bat and one goat, you lose. A bat and a double rooster only pays double. A \"-\" means that those rolls don't counter against the roller. A bull-rooster-bat roll would pay triple, for example; a goat-goat-bat pays triple your bet. You may bet a number of gold pieces equal to half your Charisma at any one time. A triple goat means that you must pay each person in the game an amount equal to your bet or be thrown in the outhouse pit. If this happens to you, see {15}. You may roll seven times tonight, thirteen if you are a rogue. When you're done, go to {33}."
},
{ // 10
"The way is steep and dangerous. Icy patches and slippery moss make footing difficult; crumbling rock faces shower debris on you as you creep along narrow ledges. Make a L2-SR vs. the average of your Luck and Dexterity (25 - (LK + DEX ÷ 2)). Add 4 to the roll if you have pitons, rope, or a flying spell. If you make the roll, you may make a day's worth of travel uninjured. If the roll is failed by less than your IQ, you don't make any progress but are safe. If you missed by more than your IQ, bad judgement has led to an accident, taking 2 dice worth of hits directly off CON. Repeat the roll until you make five days' worth of progress. If and when you succeed, see {32}. If you are ever so severely injured that your CON falls below 5, see {14}."
},
{ // 11
"You get an uneasy feeling in the pit of your stomach as you survey the plain from the last of the foothills. Something bothers you about the place, and the screams of the old man in the distance don't help. Make a L1-SR on Luck (20 - LK). If you make it, you find yourself drawing your weapon and running towards the brigands (go to {58}) with your weapon drawn. If you fail the roll, you gather your courage and stride out onto the plain. (Turn to {71}.)"
},
{ // 12
"±Quickly buckling on your sword, you rush out of the inn, looking for the source of the disturbance. You hear a faint cry, and follow it to find the old adventurer lying in some bushes. \"The cultists!\" he gasps. \"çThe±y're up to mischief! I tried to stop them...no good. Take thisç key to the±irç temple± You've got to stop them before they get the scroll!\" With an agonized cryç, ±the man suddenly stiffens and becomes still. The object he handed you is ça triangle of dark, grey metal, looking like a piece of silvered glass reflecting a cloudy sky. Mystic figures are inlaid in a metallic green material; you have no clue as to their meaning.± Investigation shows that the old adventurer was hit with a tiny, poisoned dart. His pouch contains a map, which you quickly pocket when other people from the inn join you. It is revealed that the cultists left earlier in the night in a great hurry; the innkeeper shakes his head and helps you bury the body.\n" \
"  In the morning, you must make your choice: follow the map, seeking to prevent whatever catastrophe the old adventurer warned of, or try to find another to take the chore. For adventure, see {18}. For the easy way out, see {35}.ç"
},
{ // 13
"The griffin, half-starved and badly mistreated, lunges at you, grabs you in silvery talons, and pops your body down in one gulp. This gives him indigestion; when his master rides to get the Phoenix Scroll, the creature has a convulsion and both plummet to the ground to be smashed among the sharp crags and spires of the mountains.\n" \
"  Though you're not around to appreciate it fully, you have saved the day.[ In gratitude, the gods place your character's soul in the body of an infant prince/princess, to replace one stolen and carelessly lost by an evil magician. In about twenty years, your character's memories will be restored and a kingdom will be his or hers. Hope you don't mind the wait!]"
},
{ // 14
"Too weak to move, you lie on the bleak mountainside for a day before, by a miracle, help arrives. A hermit finds you and binds up your wounds, restoring you to a CON of 10 (if it was over that to begin with) or its normal level. He also strips you of any gold or gems you may have, and takes all of your rations! You are left in a valley at the other side of the mountain (go to {32})."
},
{ // 15
"If you cannot pay off after getting a triple goat, your fellow gamers follow the age-old rules for Myrean Knuckle-Toss and throw you in the privy out back. If you let them do this, make a L1-SR vs. Luck (20 - LK). If you miss it, go to {405}. If you make it, your clothes are begrimed and reputation impeached; for the duration of this adventure, your Charisma is halved until you can take a hot bath (believing such things are harmful to one's internal humours, the innkeeper refuses to provide you with one!). Go to {33} after shaking off the worst of the filth. If you would like to defend yourself, see {353}. Go to {33} after dealing with them there."
},
{ // 16
"You are in luck. An experienced guide and fighter is available for hire. For 100 pieces of gold, Goldara the half-elven warrior maid will accompany you to the Granite River[, and assist you in combat].[ She has these stats:]\n" \
"  [  ST: 15  LK: 15  CON: 10  DEX: 16  IQ: 14  CHR: 18  Adds: 10/14\n" \
"She carries a medium longbow and a sax, and wears leather armour and a buckler. Goldara uses her bow on the first through third round of combat, even if you are in melee. ]Turn to {4} to take the trail through the mountains; see {46} if you'd prefer a walk in the woods."
},
{ // 17
"You have arrived at the Granite River, and are nearing the end of your overland trek. Here, any guide you may have [takes his or her pay and ]bids you farewell. After you wave goodbye, you turn and face the path ahead. The river is easily crossed by a rope bridge, but after that the trail becomes steep, treacherous and fatiguing: In the days that follow, you finish off the food in your ration bag. You must also roll to see if you meet anybody during the trip. Roll one die: On a roll of 1, you meet someone from Table A. On a roll of 2 or 3, roll for an encounter on Table D...You're in Krestok Country! (Make a note of this paragraph so that you may return when you are finished.) Go to {50} if you live through the five-day trip to the temple."
},
{ // 18
"The map given to you shows two paths to your destination, the temple of Krestok. One path leads through a chain of low mountains, visible on the horizon. If you take the mountain path, go to {4}. The other trail goes northeast through a dense forest. If you take the path through the forest, see {46}. If you'd like to hire a guide first, roll a die: on a roll of 1-2, see paragraph {2}. On a roll of 3-5, see {8}. On a roll of 6, see {16}."
},
{ // 19
"The hut belongs to an ugly old woman. After some introductions, she explains that she lives in the swamp because the soil allows her to grow special herbs. After seeing how tired and dirty you look, she invites you to eat with her. She listens attentively as you tell her of your mission and journey thus far. Roll a die: On a roll of 1 or 2, go to {27}. On a roll of 3-5, see {34}. If you roll a 6, turn to {51}."
},
{ // 20
"The Old Soldier enthrals you with tales of battles and adventure. He recounts his harrowing journey through the Dragon Strait, an encounter with a diamond-footed man, and his life as a pot boy in an inn in Gull. After finishing for the evening, you and the others in the audience contribute a silver piece or two for the entertainment. As you give him your donation, he slips you a note: \"Meet me in the stable when the moon rises over the eastern hills.\" If you follow these instructions, go to {48}. If you'd rather get a decent night's sleep, see {33}."
},
{ // 21
"The miners suspect your story, but are willing to let you into their mine if you do them a favour: \"Our vein of gold goes right through the lair of some horrid beastie,\" explains the miner, \"and we would be right grateful if you cleared it out. The tunnel goes out the other side of the mountain, which should speed you on your way!\" If you accept the offer, go to {44}. If you'd rather chance the overland route, see {10}."
},
{ // 22
"Because there are quite a variety of people in the little village surrounding the temple proper, you are not immediately recognized and detained as an enemy of the faith. But you soon learn that Krestok's dread \"Seers\" watch the town vigilantly. Without a plan of action you may soon be captured. If you'd like to go directly to the temple gates, see {78}. If you ask a dependable-looking person about the ways of the valley, see {45}. If you disguise yourself as a cultist to gain entry to the temple and assure your safety, see {60}."
},
{ // 23
"The men in green stop eating their porridge and raise their hands over their heads. They begin snapping their fingers, stand up, and shuffle out of the room single file. Everyone in the room stares at you for a moment, then go back to their business after you shrug and smile sheepishly. You finish your meal alone and get ready for bed: go to {33}."
},
{ // 24
"Oh, well! You weren't too keen on this quest, were you? I hope not, because you just blew it! Your character escapes with his or her life and possessions, but is forced to flee the country to avoid the depredations of the powerful cultists. Take 200 ap for the experience, anyway!"
},
{ // 25
"±\"Ah, what troubles afflict the world!\" sighs the innkeeper as he serves you breakfast. \"While you slept, the old yarn-spinner was killed outside these very walls!\" Your host tells of how a pot boy found the adventurer, cold and staff with a poison dart in his neck. çA±fter a few minutes of hinting and bargaining, you agree to help the innkeeper bury the body. You receive 2 pieces of gold for your troubles, and manage to sneak a piece of paper out of the old mercenary's pouch...aç map showing a path to a valley in a range of mountains far to the north.± The adventurer's sword shows a trace of blood at its tip, and a small tatter of green fabric is caught on a nick in the blade. Some sixth sense tells you the pilgrims you saw dining in the common room the previous night are responsible. If you follow the map, hoping to catch those responsible, turn to {18}. If you play it safe leaving the adventuring to others, go to {35}.ç"
},
{ // 26
"The trail through the woods soon becomes faint and hard to follow; hills and ridges make progress slow. After two days, you come upon a small house surrounded with a white picket fence. It looks like a very nice place; if you knock on the door to see if you can get some directions, see {64}. If you'd rather be on your way, see {62}."
},
{ // 27
"The old woman is unimpressed by your tales. She asks that you help her clean the windows in payment for your meal. Go to {62} when you are done."
},
{ // 28
"You bring your bowl and mug over to a quiet table. There, several men dressed in green robes and hoods slowly eat meagre portions of cheap porridge. From their dressed, bare callused feet, and simple, light baggage you judge them to be pilgrim, or perhaps acolytes of an order of wandering monastics. They take no notice of you, even when you accidentally spill a bit of cider on the robe of the oldest, meanest looking member. If you try to strike up a conversation, see {5}. If you turn the other cheek, and finish your meal in peace, go to {33}."
},
{ // 29
"You have found a side entrance to the temple located in a lonely, windswept moor a few miles from the Temple Valley. The squat stone tower doesn't seem to have door though, just a slab of featureless stone. Closer inspection reveals that the slab has a small triangular depression in it. If you still have the key the old mercenary gave you, you may use it now, and enter the tower (see {42}). If you don't have the key, or a way to blast the stone (Bog and Mire, magically enhanced rock-picks, and/or a fourth level of higher Unlock spell), you must take another approach...see {50}."
},
{ // 30
"The cultists give you a bag of 150 pieces of gold and a small vial which contains a healing potion. (The single dose heals 10 points of CON damage when consumed.) You are taken to a clearing where the adventurer and his gang plan to set up their ambush. The pilgrim's leader slaps you on the back. \"Thanks to you,\" he says, \"we can continue our journey in peace.\" The green-swathed cultists leave, snapping their fingers over their heads. An hour later, the old adventurer comes into the clearing. An L2-SR vs. Dexterity (25 - DEX) is required to hit the man. If you succeed, see {40}. If you miss, the angry old soldier draws his sword and rushes you! He has an MR of 40, and wears armour that takes a total of 8 hits per round in combat. If you are killed, close the book. If you are wounded (Strength or Constitution below 7), see {48}. If the old adventurer is wounded or killed, turn to {40}."
},
{ // 31
"By killing the griffin, you've delayed but not stopped the cult from retrieving the Phoenix Scroll. Things at the temple soon turn too hot for you to handle...choosing the better (well, easier) part of valour, you leave the area. Chalk up 500 ap for your character; better luck next time!"
},
{ // 32
"The trail through the mountains ends in an isolated valley. There seem to be no human inhabitants, but plenty of wildlife and forage. After resting and filling your ration bag, you must decide whether to continue (see {61}) or explore a little first (see {26})."
},
{ // 33
"After a visit to the privy and a last drink, you head for your room. The straw in the burlap mattress is fresh and the blankets clean; the window is tightly shuttered against intruders and the cold wind. You soon fall asleep and spend several restful hours in dreamland. Around midnight your repose is interrupted by a terrifying scream! You leap from bed and throw open the shutters. Though the moon is full and bright, you cannot see much from the window. If you try to get back to sleep, go to {25}. If you'd like to go out and investigate, see {12}."
},
{ // 34
"The old woman is a magician of some power. She gives you a small bottle containing two sips of a magic liquor; if drunk, the liquor negates poisons and drugs; if put on a wound it cures 5 points of damage. She gives you a sack full of apples (enough to fill your food sack) and show you the way out of the swamp. Turn to {62}."
},
{ // 35
"For shame! Refusing an adventure! Unopposed by doughty heroes like yourself, the cultists of Krestok soon roam the land freely, spreading their foul faith by force and magic! You are forced to flee, losing half of your gold[ and gems and any one magical item]. Close the book; don't use this character in this adventure again!"
},
{ // 36
"Oh, drat! Bad weather and a poor sense of direction has led you astray. You spend four more days slogging through an especially dismal part of the bog. Roll a die for each day of travel. On a 6, your food is ruined. On a 1, you must roll for an encounter on Table C. When you have finished your wanderings, see {62}."
},
{ // 37
"A day's journey brings you to a mine run by the temple. From your vantage point, you can see the mine entrance, crude barracks where the slaves who run the mine are kept, and a water-wheel and mill for crushing stones; a tributary of the river rushes through the mine valley. If you go back to the valley, see {50}. If you enter the valley, circling to the east to enter via the main road (you see a steady stream of merchants' carts and guess you have a fair chance of getting in without being captured), turn to {382}."
},
{ // 38
"You get to the mine just as the sun is setting. A group of tough-looking men and dwarves sits around the campfire eating stew and hard bread. They welcome you for a bite to eat before getting down to business. After dinner, you give them a carefully edited version of your recent experiences and ask whether there is a shortcut through the mountains. The miners nod to each other knowingly, and two of the dwarves whisper in each other's ears conspiratorially. If you leave now to avoid trouble, go to {10}. If you wait to see what happens, make a L2-SR vs. Charisma (25 - CHR). If you character is a dwarf or a gnome, add 3 to the total. If you blow the roll, turn to {6}. If you succeed, see {21}."
},
{ // 39
"Not so quick! As you leave the vicinity of the orcs' camp, you run into a patrol of orcish bowmen. They are at long range; on the first round of combat, each needs a roll of 19 or more (a saving roll) to hit you and/or your guide. On the second round, they'll be at medium range and need a roll of 9 or more to hit you; on the third round they will hit you on a roll of 5 or more. Thereafter, they will be in melee. Each of the four orcs has an MR of 24, and bears a bow that gets 2 dice plus 4 adds when they hit (subtract armour from each hit). You may try to run by making a L2-SR vs. Speed or Luck (25 - SPD or LK); if you succeed, or kill them all, go to {69}. Each orc has 1d6 gold pieces."
},
{ // 40
"\"Fool!\" gasps the man as his life ebbs away. \"Those cultists are dangerous! You have to carry out my mission...stop them from getting the Phoenix Scroll! I have been under a curse, and since you have killed me, the curse falls on you!\" The adventurer gives you a triangular piece of grey metal (\"The key to the temple\") and a map to the cultists' stronghold. Deduct 2 points from your Charisma for having a hero's blood on your hands, until you succeed in his mission. And if you fail, or give up the mission, deduct 3 more points permanently. This is a 7th level curse, that can only be removed by a powerful wizard, or by successfully completing the quest! Go to {18} to continue."
},
{ // 41
"You follow the woman's shortcut out of the forest. It seems to wind around quite a bit, but after four days of travel it straightens out and runs due north. On each of the four days of travel, roll a die: on a roll of one, you meet someone from Encounter Table A. (Make a note of this paragraph and return here after you finish unless instructed otherwise.) If you survive your journey out of the woods, go to {62}."
},
{ // 42
"You open (or chop away, or melt) the secret door and find yourself in a dimly-lit tower. A crumbling stone staircase descends deep into the earth; you descend many feet before entering a dark, extremely damp tunnel. If you have torches or a light source, proceed to {107}. If you have no light, you must feel your way along. Make two L1-SRs vs. Dexterity (20 - DEX). If you make the first but not the second, see {100}. If you fail the first, see {117}."
},
{ // 43
"The eastern path takes you north for three days, then peters out. You must do a little bushwhacking; roll a die, adding 1 if your guide (if any) is still with you. On a roll of 1-2, see {56}. On a roll of 3-5, see {73}. If the roll totals 6 or more, see {81}."
},
{ // 44
"The miners' tunnel leads right into the lair of a dangerous subterranean beast! Standing 7' tall, it has eyes as large as saucers and pale, greenish skin. As you enter its foul-smelling lair, it stands up and faces you, clawed fingers curled and fangs bared. It knows the caves too well for you to run; you must fight or die! The cave thing has an MR of 40, but its tough skin takes 6 hits a turn just like armour. If you wish to cast a spell other than ordinary combat magic, see {53} after writing your choice down. If you kill it by ordinary means, you get for your trouble the miners' treasure: 300 gp in virtually pure ore, and a magic rock-pick, dwarvish in origin, which can chew through stone at a rate of 6' per 10-minute turn. Continue your journey by turning to {59}."
},
{ // 45
"You wander the streets of the small village, looking for an honest person who will tell you about ways of the temple. It is no easy task: everybody is either in cahoots with the Krestok authorities or scared silly about being reported. To find someone, you must make a L2-SR vs. Intelligence or Charisma (25 - IQ or CHR). If you came here via {90} (and were successful there!) you may add 4 to the die roll. If you make the roll, go to {115}. If you blow it by less than 10 points, you have no luck and must try some other plan...see {22}. If you roll 10 or more over your Intelligence or Charisma, turn to {66}."
},
{ // 46
"Choosing to take the low road, you set out on your quest. The path leads through an area of farmland, then plunges deep into the woods. The way is pleasant at first, with sunlight streaming through the branches overhead, but you soon come to a fork in the road. If you take the right path, which goes up a hillside and over a ridge, go to {26}. If you take the left branch of trail, which leads down into an open area, see {7}."
},
{ // 47
"You spend a day on a rough trail that winds through a treacherous region of cliffs and chasms, eventually coming to a small tower. You wisely observe the keep before approaching it, and discover that the gate is guarded by two green-robed warriors. You've found a side entrance to the temple! You may take one missile weapon or spell shot at the guards at medium range before they engage you in melee...each has an MR of 24, and wears armour worth 6 hits under his robes. You may slip away at any time if you wish, going to the front entrance by default (see {22}). If you slay the guards, see {29}."
},
{ // 48
"The old adventurer talks with you in the moonlight outside the old inn, binding any wounds you may have suffered. \"I am on a mission to stop the Followers of Krestok,\" he tells you. \"It is vitally important that someone keep them from gaining possession of a valuable scroll; with it their foul deity will gain great power over these lands. But I fear I have become too well-known for the quest; you must take over for me. Here is a map to the temple, and a key to open one of the entrances.\" You pause to examine the map, which has a path marked in red leading to a range of mountains, and the key, a triangular piece of silvery grey metal. The old mercenary shakes you hand and point the way to the path north. You find it hard to believe that this old man, who you just tried to kill, expects you to take up his mission. You start to laugh, but are suddenly overcome by a feeling of dread. Suddenly you realize that you have been afflicted by a magical curse the instant you touched the triangular \"key\". If you fail in this quest, or refuse to take it up, you will lose 5 points from your Charisma, permanently. If you follow the path as directed, go to {18}. If you try to find another to go on the quest, in spite of the curse, see {35}. (And don't forget to deduct 5 from your Charisma!)"
},
{ // 49
"After spending another day in the wilderness, you come upon a village on the edge of a small lake. Add one to the number of villages you've been to. The inhabitants are a taciturn people who live off of what fish they can catch and roots they can gather in the swamp. You may buy food here (8 gp to refill your pack) and/or rest for a few days. A dry room and medicinal herbs will cost you 3 gp per day. Each day spent cures a hit point of CON damage. When you are ready to leave, you may ask one of the fishermen to take you to the north shore of the lake in his boat (this costs you 5 gp; see {62} if you hire him), or leave the village on foot ({55})."
},
{ // 50
"The trail through the mountains is twisty, slippery and boulder-strewn. You cry out in joy when the path ends at last, in a high pasture tended by shepherds. Exultation turns to foreboding when you see the three iron spires of the Temple of Krestok hearing over the horizon. Even from many miles away, you seem to be able to see the horrid gargoyles that encrust the towers. AT THIS TIME, total the number of days it took you to reach the temple. Include travel time as well as time spent in jails, resting in towns or enspelled by witches. If you lost track of time, roll 3 dice and add 20 to the total to find the time you took. If you took LESS than thirty (30) days, turn now to {57}. If you took thirty or MORE days, turn to {63}."
},
{ // 51
"The old woman seems impressed by your mission. To help you complete it, she gives you a vial containing a magical liquor; the potion negates poisons and drugs if drunk, or if put in a wound cures 5 points of damage. In addition, she repeats a rumour she'd heard: Roughly along the path you are taking is a canyon lined with cliffs etched with ancient writings. \"A secret door is hidden somewhere in these cliffs,\" she reveals. \"It is marked by a slab of missing stone; find the stone and replace it and the door will open!\" She hands you a bag of powder. \"From what I've heard tell, the door leads to a hidden valley where grows a magic tree. This may help you deal with whatever is there.\" After packing away her gift, you head north to {62}."
},
{ // 52
"The path to the Granite River is a long one; you spend five days in the mountains before finding the valley. On each day, you must roll a die to see if you encounter something unpleasant. On a roll of 1, you must roll on Table C of the Encounter Chart to see if something nasty is encountered (make a note of this paragraph number so that you may return here when you are finished). On the last day of your travels, you find a path that might be a shortcut to the Krestok Temple. If you take it, your guide leaves you now: go to {47}. If you keep on your original path, turn to {17}."
},
{ // 53
"If you cast Revelation, Will-o-Wisp, or any other spell that creates large amounts of bright light (including Blasting Power if you cast it already, in combat), the monster shrieks and disappears down a side passage. Go back to {44} to claim your reward. If you cast anything but a normal combat spell, the best had time to get through your guard and begins tearing you to pieces! Roll 5 dice and add 20, subtract your armour and Luck, and take that many hits! If you survive the round, return to {44} and continue combat."
},
{ // 54
"You are in the grand entrance hall of the temple. Far above you is the gilded dome of the temple, supported by giant stone pillars inscribed with sacred signs and pictures illustrating stories of the faith. Above you on either wall are balconies where scores of acolytes chant a depressing psalm. If you'd like to inspect the nearer of the balconies, see {68}. If you proceed straight ahead, towards the far end of the hall, see {116}. If you'd like to check out one of the portals on the sides of the hall, see {72}."
},
{ // 55
"You spend two more days in the swamp, looking for a clear path out. Eventually, you find a little island in the midst of a sea of reeds. Behind a stone wall in the middle of the island is a neatly tended garden and fruit orchard; a small hut is visible in the distance. If you approach the hut and seek aid, go to {19}. If you'd rather get on with your journey, see {62}."
},
{ // 56
"You wander through the mountains, making little progress. Eventually, you find what seems to be a promising path...that gradually leads you back to the plain of obelisks! An avalanche cuts off the way back, forcing you to cross the plain again; go to {61} but you need only roll two times to get to Ghem. If you wish, you may instead travel to the northeast (see {189})."
},
{ // 57
"You use a little-travelled path to reach the valley, and find a ridge from which to survey the temple. You discover that the huge temple is set at the edge of a bustling little village with many small buildings, vegetable fields, and plazas. The path you took is apparently little used; larger ones at either end of the valley carry a constant traffic of pilgrims, merchants' wagons, and companies of disreputable-looking mercenaries.\n" \
"  After getting a good night's sleep, you awake refreshed and ready to make a decision. If you would like to approach the temple valley directly, go to {22}. If you'd like to explore the area around the valley first, see {47} to go west, {37} to go east. If you have a plan that you might think will work, write it down and then see {90}."
},
{ // 58
"The brigands described in paragraph {360} are beating and questioning an old man who seems about to collapse. You have two chances to toss spells or cast missiles before the miscreants notice you and close to melee. On each round of combat, roll a die: on a roll of 6, the old man is wounded in the tumult of melee. When he's taken six wounds, he dies and those questioning him suddenly break ranks and run; you may attempt to defend him by taking these hits yourself (1 point per wound rolled, taken directly off Constitution). If you are driven off, or the attackers leave, you may head north (turn to {61}) or east, towards the distant lake (go to {189}). If you save the old man by killing his attackers, see {67}."
},
{ // 59
"The tunnel emerges on the far side of the mountain after two days' travel. A faint trail leads you to a ridge above a valley. You may enter the valley (turn to {32}), or follow the trail a bit further (go to {26})."
},
{ // 60
"In your search for a green robe, you must do a little spying and perhaps some stealing. Roll a die, adding 2 to the roll if you came here from {22}, down in the village:\n" \
"    1:   Go to {74}.\n" \
"    2-4: Go to {82}.\n" \
"    5-6: Go to {93}.\n" \
"    7:   Go to {101}.\n" \
"    8:   Go to {108}."
},
{ // 61
"The plain is not empty. Every few miles, you pass an obelisk of weathered black granite. Odd runes have been carved in each of the plinths; bas-relief carving depict the horrid uses the standing stones were once used for. At first you ignore the obelisks as you would trees in a forest, but soon you find yourself entranced by them. As you pass one, it seems to call out to you; you find yourself staring at the runes, making reverent gestures to the images of the deities serviced by the obelisks.\n" \
"  You must summon all your reserves of will to cross this plain; average your Strength, Intelligence, and Luck. Add 3 to the result if your character is an elf, or a cleric/monk type character. You must make 7 L2-SRs vs. this total; one for each day's journey across the plain. If you make the roll, you make a day's progress. If you miss the roll by less than 6, you are exhausted by your attempts to resist the obelisks' magic and make no progress that day. If you ever miss the roll by 6 or more, see {71}."
},
{ // 62
"You soon find a clear path out of the wilds. The trail leads north into some hills, eventually coming to an end on the southern edge of a small, dusty plain; this jaunt takes you one day. You can see the mountains where the temple lies to the north; odd, tree-like objects dot the plain itself. These give you a bad feeling. If you brave the danger and decide to set off now, crossing the plain right away, see {61}. If you'd like to explore a bit first on this end of the plain, see {75}."
},
{ // 63
"Oh, dread! You may be too late! You find a path to a secluded ridge overlooking the temple valley and see a scene of utter horror: a dour little village that surrounded the temple is a patch of charred ruins. Even from here, you can smell blood and the brimstone stench of evil magic. The temple grounds and the streets and fields of the valley are crowded with green tents, and aswarm with thousands of disreputable-looking mercenaries, bands of orcish soldiers, and a vast horde of green-robed fanatic soldiers. The sound of chanting comes from the temple, which fairly reeks of demonic mana. You must make a decision. You can leave now, making your way back to civilization and the safety of another country (turn to {400}), seek to warn the king and nobles of Myre by going to {350}, or try to raise an army of your own (go to {381}). Lastly, you can try to storm the temple alone, right now! If you choose this last course, take 1000 ap. Raise your attributes if you've gone up a level and turn to {340}."
},
{ // 64
"The door is opened by a beautiful, red-haired woman dressed in simple clothing. She invites you (and your guide, if any) in for some herb tea. She tells you of a shortcut out of the woods and invites you to stay the night and have supper with her. If you accept, see {70}. If you leave now, see {41}."
},
{ // 65
"The orcs' tents contain food (more than enough to fill your ration sack), weapons (mostly crude short swords and small self bows), and small trove of treasure: 345 gp, 432 sp, 4 gems, and a bottle of curare. When you're done looting, go to {69}."
},
{ // 66
"Uh-oh! You've alerted the guards, and must enter the temple while it is aswarm with fanatic warriors and acolytes hungry for martyrdom! At the gates, you run into four guards led by a priest. You may try to sneak past them. Roll two saving rolls: one L1-SR vs. Speed (20 - SPD), one L1-SR vs. Luck (20 - LK). If you make both, turn to {78}. If you fail either roll, turn to {80}."
},
{ // 67
"After a drink of water, the old man thanks you profusely. \"Those bandits were after my secret,\" he tells you. \"Only I know the secret of how to cross these miles unharmed. I learned it by studying ancient lore I found in an old tomb in my youth. For your help, I will pass it on to you.\" The man describes a mystic rite which will allow you to pass by the obelisks set out on the plain unharmed. If you are a magic user or rogue, he will in addition give you a little book containing a first-level spell that allows the caster to make a person's face grow a huge crop of warts and pimples (cost 5 ST, range 30').\n" \
"  Go to {61} (to go north) or {189} (to head for the lake to east) after saying goodbye to the old man. On your way across the plain, add 10 to any saving rolls or Battle of Wills combat rolls you make, as a bonus for knowing the old fellow's secret.[ (The bonus only applies to rolls made on the plain).]"
},
{ // 68
"You find an alcove containing a stair to the left balcony. If you have a robe, the person standing guard gives you a wooden board inscribed with the words of the hymn. Proceed up the stairs to {91}, and warm up your throat. If you lack a robe, make a L1-SR vs. Charisma (20 - CHR). If you fail it, the chant master rings a loud bell; see {95}. If you make it, the man shoots you a nasty look and shoos you away...see {72}."
},
{ // 69
"The path through the mountains soon becomes indistinct; you must cross wild country to find your way to the Granite River, the largest landmark on the map. Roll a die, adding 1 to the roll if you've a guide with you. On a roll of 1-2, go to {52}. On a roll of 3-5, see {83}. On a roll of 6 or more, see {56}."
},
{ // 70
"The woman, whose name is Sravindii, gives you a fine dinner and sings you a beautiful song before retiring. Too late, you realize that she is a witch! Roll 3 dice, subtracting Luck and Intelligence, adding your Charisma if your character is male, then consult the chart below to see what becomes of you!\n" \
"    Below 1: Go to {79}.\n" \
"    1-6:     Go to {87}.\n" \
"    6-12:    Go to {92}.\n" \
"    13+:     Go to {99}."
},
{ // 71
"In ancient times, this plain was the site of a forest sacred to a people now all but forgotten by present-day historians. This lost race left obelisks dedicated to their strange deity all across the plain to protect it from desecration by barbarians. As you pass one of these obelisks, the powerful magic latent in it discharges; there's a blazing flash, then everything goes dark. When you regain consciousness, you find yourself in the form of a wind wraith, forever doomed to whistle across the plain, blowing dust and sand before you. Ah, well...this wasn't your favourite character anyway, was it?"
},
{ // 72
"You are in an alcove off the grand entrance hall of the Krestok temple. Acolytes, high-level cultists in green robes, and a few scared-looking tradesmen wander through the hall. If you leave the alcove, see {116}. If you use the door ahead of you, see {140}. If you take the forbidding-looking stairs that descend into the earth to the north, see {114}. If you climb the ladder set in the wall, see {106}."
},
{ // 73
"The way you've taken seems promising, avoiding the most difficult ridges and deepest valleys. Along the path are numerous small ruins and stretches of crumbling paved road; at one time a great civilization occupied these mountains! To see if you run into anybody along the way, roll a die four times. On each roll of 1, roll on Table A of the Encounter Chart. On a roll of 2, roll on Table C (make note of this paragraph number so you may return after you finish). Any other roll indicates no encounters of note. Four days after leaving Ghem, you arrive at a small temple; turn to {216}."
},
{ // 74
"You find a careless cultist bathing in an icy mountain stream near the valley. You snatch his robe from where it was hanging on a branch, taking a small pouch with food and papers as well. Go to {78}."
},
{ // 75
"You spend a day walking east along the southern edge of the plain. You find two things: To the east light glimmers off a lake, which might provide transportation to the north. You also come upon a fellow traveller beset by brigands! There are six of them, all of whom seem quite absorbed in chasing a helpless-looking old man. If you decide to intervene, see {58}. If you'd rather head for the body of water in the distance, see {11}."
},
{ // 76
"You avoid the charging acolyte's skilful attack and riposte, tossing him expertly into the dark shaft he intended to stuff you into. A shriek of horrible agony lasting eighteen seconds reaches your ears from the bottom of the shaft; a puff of steam and a sound not unlike a giant burp follows. You secure the hatch and walk out into the hall, patting off your hands. Turn to {54}."
},
{ // 77
"On top of a high crag, you come across an unusual sight: A nest built out of stones and charred stacks and leaves. A heap of ashes and what might be burnt feathers fill the nest. You are overcome with awe when you realize you've found a phoenix's nest! If you run away in fear (phoenixes are considered semi-divine and seeing a nest an event of legend!) take 50 ap and proceed immediately to {89}. If you dismantle the nest, to gather the valuable magic ashes of the phoenix, see {109}. If you try to remember what the old adventurer in the inn said about phoenixes during his tale-telling, go to {85}."
},
{ // 78
"You are at the gates of the temple, seeking entrance. Roll a die: Add 4 to the roll if you are wearing a green robe. Add 2 if you have a merchant's wagon. Consult the chart below to see how the guards react to your request to enter.\n" \
"    1-3:  Go to {88}.\n" \
"    4-5:  Go to {98}.\n" \
"    6-7:  Go to {103}.\n" \
"    8-10: Go to {111}."
},
{ // 79
"Quick thinking and no mean amount of luck allows you to slip away before the witch can harm you: earn 25 ap for the experience! Go to {41}."
},
{ // 80
"You are fighting the guards at the temple gates. The four warriors have MRs of 16, and wear armour that gives them 4 points of protection each turn. The priest has an MR of 12, and is immune to magic below third level. You may try to run at any time. This requires a L1-SR vs. Speed (20 - SPD); add 2 to the roll as a bonus for every man you kill. If you escape, go to {22}. You may also surrender at the end of any round (see {112}).\n" \
"  If you win fairly, go to {78}[, but each time you turn to a new paragraph, roll a die: on a roll of 1, a host of guards descend on you and hustle you off to a dungeon...see {112}].[ Such is the price of entering a temple on red alert!]"
},
{ // 81
"One uneventful day after leaving the village, you find a hidden path that runs up to the top of a high crag. If you climb the crag, make a L2-SR vs. Dexterity (25 - DEX). (Add 3 to the dice roll if you have rope and/or pitons.) If you make the roll, see {77}. If you fail the roll, the climb is beyond your abilities; turn to {89}. If you don't try the climb in the first place, also go to {89}."
},
{ // 82
"You must face a live and angry cultist to get a robe. He has an MR of 16, and fights with a poison dagger. [Besides doing double hits on you, ]the dagger may nick you accidentally. Each combat turn, you must make a L1-SR vs. Luck (20 - LK) to avoid taking 2 hits directly off CON due to a small wound. If you kill the cultist, take his belongings and go to {78}."
},
{ // 83
"After a day of wandering, you find a riverbed that leads more or less directly to the Granite River. The trip takes a total of three days. To see if you've run into anybody while travelling, roll a die three times (once for each day on the trail). On a roll of 1, see Table C of the Encounter Chart. If you roll a 2, see Table D (make a note of this paragraph number so that you may return when you have finished). If you make it, go to {17}."
},
{ // 84
"As you near the edge of the mysterious, dusty plain of obelisks, you come across a ruined tower. If you enter the tower, turn to {166}. If you'd rather be on your way, continue north into the foothills (turn to {94})."
},
{ // 85
"As you try to recall if the old mercenary said anything about phoenixes, a wondrous thing happens. The ashes in the nest begin to burn; a glowing aura forms in the air, and a blazing worm-like creature forms in the nest. You stare slack-jawed at the rebirth of the phoenix, and feel yourself being changed: increase your IQ by 50%, and add 6 to your Luck. This is the positive side of the change. As the phoenix stops blazing and flies off, the world becomes darker. You find your vision has been damaged, reducing your Dexterity and Speed by two each and making missile and spell casting beyond 20' all but impossible. Still shaking from the awe-inspiring experience, you descend the crag to {89}."
},
{ // 86
"Gratefully, you relax on your pallet of straw. You are awakened five hours later by the ringing of a huge, evil-toned bell. The other acolytes in your chamber wonder why they were given two extra hours of sleep, and why the great bell was used to wake them. Groggily, you shuffle to the morning chant; there, the chant leader answers your questions: \"Brothers, we are victorious! The Phoenix Scroll has been captured...a whole army of unbelieving dogs was wiped out by a single blow during the night! Each of you will be raised to the status of warrior in celebration...\" You sit, slack-jawed as he continues, realizing that your mission was a failure; betrayed by fatigue! \"Tomorrow, you will march on the kingdom of Myre,\" continues the chant master, \"to spread our faith, to become martyrs for the glory of Krestok! Victory! Victory!\" Sadder but wiser, you make your plans to desert. Take 500 ap and close the book."
},
{ // 87
"Alas, you were not quick enough to get away from the witch, and not pretty enough to convince her to save you for something else! She changes you into a stoat and tosses you out into the night. You spend a number of months equal to a toss of 2 dice in the form of a weasel, eating mice and insects. You come out of the experience being able to talk with rodents, foxes, and creatures in the weasel family. Alas, it's too late for you to save the day in this adventure. Close the book!"
},
{ // 88
"You blow it. Either the guards don't believe your story, or you are caught sneaking in. Go to {66}."
},
{ // 89
"You spend three days on the trail. Roll a single dice three times (once for each day on the road): on a roll of 1, roll on Table A of the Encounter Table. On a roll of 2, roll on Table C of the Table (make note of this paragraph number so that you may return when you finish.) If you survive, you find that the path takes you to a pleasant little shrine nestled in the hills. (Go to {216}.)"
},
{ // 90
"Do you have a plan written down? If not, you've not thought things out properly and do something stupid...see {66}. If you have a plan written down, check those listed below to see if yours has been anticipated:\n" \
"  * Dress up as a cultist by mugging one of the fellows on the road to the temple...quietly, of course (see {60}).\n" \
"  * Go into the valley disguised as a merchant, hijacking a wagon bringing supplies into the valley...go to {280} to capture the wagon, then go to {78}. Write {78} down as the combat paragraph will not send you there.\n" \
"  * Mug someone on the road or village to get information on the operations of the temple first...foreknowledge is as good as hindsight. See {45}.\n" \
"  If your plan was not given above, you must try a more direct approach. Go to {22}."
},
{ // 91
"You are set to singing a dull sonorous chant. After four mind-numbing hours you are relieved and sent to work scrubbing a floor. After five hours of that you follow a group of fellow toilers to rest on a thin pallet in a dim, unheated cell. You may proceed from there, [at half Strength from exhaustion for the rest of the adventure (or until you get a chance to sleep), ]or call it a day and get some rest to continue tomorrow. See {121} for adventure, {86} for rest."
},
{ // 92
"The witch charms you to work for her for two weeks. At the end of this time, she takes you, stripped of all but your clothes and the map, to {62}."
},
{ // 93
"You find a likely prospect for a mugging, but he turns out to have friends. On the first two rounds of combat, you must face one cultist (who has an MR of 16, and fights with a poison dagger. [Besides doing double hits on you, ]the dagger may nick you accidentally. Each combat turn, you must make a L1-SR vs. Luck (20 - LK) to avoid taking 2 hits directly off CON due to a small wound). On each odd-numbered turn after that, another MR 12 cultist joins him! If you surrender or are disabled, go to {112}. If you kill all the cultists facing you at any one time, see {78}."
},
{ // 94
"The Plain of Obelisks ends in a line of rolling foothills. After a day of wandering, you find a little-used road leading into the mountains. Following it brings you to an isolated village named Ghem. Be sure to record that you've been here! The inhabitants feed you well, stuff your pack with local delicacies, and give you a room for the night in exchange for news from outside. They also give you news; the cultists of Krestok are becoming more and more active, sending warriors into villages like theirs to convert people and kick out the holy men of other faiths. Rumours abound that the cultists are close to finding some sort of mysterious magical item that will allow them to control all the lands visible from their mountaintop temple.\n" \
"  You decide to leave as quickly as possible. The villagers tell you of two passes through the mountains. The western path, though shorter, is said to be prowled by a tribe of orcs. The eastern path, they add, runs through an area of ruins which might be haunted. If you take the eastern path through the mountains, go to {43}. If you take the western pass, see {97}."
},
{ // 95
"The temple alarm bell is ringing...guards and acolytes eager for salvation through death in combat with unbelievers swarm around the great hall. The only thing to do is run. Roll a die, adding 2 to the roll if you are wearing a green robe disguise!\n" \
"    1-3: Go to {102}.\n" \
"    4-5: Go to {110}.\n" \
"    6-7: Go to {118}.\n" \
"    8+:  Go to {124}."
},
{ // 96
"Your body has been vaporized by the birth-fire of a phoenix. In the unbelievable heat and spiritual flux of the miraculous process, your soul is fused with that of the creature. All knowledge of magic is forgotten; past memories grow dim. You wake in a marvellous winged body, with these new physical attributes (Luck and IQ remain the same):\n" \
"    ST: 20  DEX: 20  CON: 16  CHR: 15  SPD: 25\n" \
"[Phoenix talons get 4 dice and 5 adds in combat; a phoenix's silvery beak (usable as a spear in flight at triple effect) gets 2 dice, and is a \"magical\" weapon, able to harm creatures such as werewolves and incorporeal undead menaces. Unfortunately, the talons aren't really hands. You can pick up almost any object, but tool or weapons use is now beyond your powers.\n]" \
"  Besides the power of flight, you now have Wizard Speech (telepathy with any lifeform), immunity to poisons[ and curses of evil origin], and power to command any lesser bird of a non-magical nature (ie. crows and even small eagles are fine, but harpies and rocs are out). [On the bad side, you can no longer handle weapons and most tools, and must face the threat of human hunters. Be sure to keep this in mind when you run this character in a campaign! ]For now, you find yourself in a fit of rapturous joy, playing with some peregrine falcons among the mountain peaks, totally forgetting your quest. This adventure is for you over; close the book."
},
{ // 97
"The western path runs through orc country! Two days out from the village, you run across an encampment. If you'd like to sneak into their camp, see {104}. If you'd rather get on your way, see {39}."
},
{ // 98
"You must face a single guard to get in the temple. He has an MR of 16, and wears armour that gives him 5 points of protection. At the beginning of each combat turn, roll a die; on a roll of 5-6, the alarm is sounded and you must go to {66}. If you kill him without giving alarm, see {54}."
},
{ // 99
"Ah, well! Good looks have doomed you to spend the rest of your days as a slave to Sravindii.[ Leave your card in the book at this point; if another becomes trapped or enslaved by the witch, this character may go free. (Go to {62} if this happens.)]"
},
{ // 100
"You stumble through the dark tunnels underneath the mountains for what seems like hours. Many times you make your way towards what seems to be carved stone arches and torchlight...that turn out to be weirdly shaped rock formations and phosphorescent fungi. You receive numerous gashes on your head from low ceilings, countless bashes on the elbows, and nearly tumble into a bottomless pit on two occasions. Eventually, you find a room that seems dryer and warmer than the rest; it might even be artificial. If you enter, see {127}. If you prefer to wander a bit more, see {117}."
},
{ // 101
"You find a laundry specializing in the cleaning of green robes. If you can make a L1-SR vs. Intelligence or Luck (use the highest), you succeed (see {115}). If you fail, see {108}."
},
{ // 102
"You are captured after a brief and inglorious fight; go to {112}."
},
{ // 103
"The guards listen to whatever story you give them, and let you in, but only at the cost of all the gold and silver coins in your possession! Either pay the bribe and turn to {54}, or go to {98}."
},
{ // 104
"Orc sentries guard the camp, but you sneak past most of them. One, however, has a keen eye. He silently leaps behind you and issues a challenge. He has an MR of 40, and wears armour that takes 4 hits a round. If you kill him in under four rounds of combat, the camp is not alerted to your presence (go to {65}). If the fight goes beyond four rounds, one orc per turn joins the fight; these have MRs of 30 and no armour. A maximum of four can fight you at one time. If you kill seven of them without being [disabled or ]killed yourself, they run off in a panic, allowing you to investigate their tents unopposed. You may try to run at any time by making a L1-SR vs. Speed. If you run away successfully, see {69}."
},
{ // 105
"You pull your guide into an alcove and ask him to wait while you tie a sandal strap. He nods, smiling, and turns to inspect a lurid tapestry hanging on a nearby wall, happily humming a fanatical ditty about hewing the heads of unbelievers. You pull out your weapon and let him have it. If your weapon roll gets at least a 20, the acolyte goes down without so much as a sigh. Turn to {72}. If you get less than a 20 on the roll, he cries out (go to {95})."
},
{ // 106
"The ladder takes you high, high into the west tower. Exhausted, you rest a moment on a landing and look around, admiring the magnificent view out of a window. Before you is a bell; if you ring it, go to {95}. If you take the ladder back down, go to {72}. If you go down the staircase to your right, see {138}."
},
{ // 107
"You spend a while exploring the tunnels under the temple. The going is perilous; you skirt numerous pits and underground streams and must be on constant guard against bloodthirsty bats and cave leeches. After a mile or two, you find yourself in a cavern outside a large room. Inside, you see a huge green dragon! If you enter the chamber, see {119}. If you go up the flight of stairs just to your left, go to {72}. If you take the tunnel to your right, go to {134}."
},
{ // 108
"You stumble into a trap! The cultists pounce on you and toss you in a cell. At least you made it into the temple without a fight! See {112}."
},
{ // 109
"The nest comes apart easily. You find a piece of cloth to wrap the ashes in. As you gather the last motes into the pouch, however, something happens. The pouch catches on fire, a glowing aura surrounds the crag, and you begin to feel very hot. You try to scramble to your feet in panic, but it's too late. Your body is vaporized by the intense heat and flame of the phoenix's rebirth...even magical protection is of no help, since the phoenix is a divine creature. If your character is immortal, or if you can at this time make a L4-SR vs. Luck (35 - LK), see {96}."
},
{ // 110
"Slipping down a staircase, you find yourself in inky darkness; go to {114} if you have a torch or light-source, {100} if you have none."
},
{ // 111
"The guards let you in, but send a cultist in with you to guide you to a waiting area. If you let him accompany you, see {113}. If you stab the fellow as soon as you are out of sight of the gate guards, see {105}."
},
{ // 112
"Oh boy, are you in trouble! You've been tossed into the dungeon of the Temple of Krestok! The food isn't terrible, and you get exercise once a week cleaning out privies, but escape seems very remote. [There are two ways for you to escape:\n" \
"  You may leave your character card in the book at {179}, hoping that another character will let you out, if he or she gets that far!\n" \
"  You may also try to escape yourself. ]Once each [REAL ]day, make two saving rolls: a L2-SR vs. both Intelligence and Charisma (25 - IQ or CHR). If you win only one of the two rolls, you don't escape but earn a +1 bonus (cumulative) to further rolls against that attribute. (Add the bonus to the die roll each time you roll to escape. The bonus only counts against the attribute you won the roll with, and only applies to rolls made trying to escape.) If you fail both, you don't get a bonus, and risk death: if either roll was missed by more than 5, you are given to the temple dragon for lunch...see {119}. If you make both rolls, you get out of your cell and grab a torch. [The torch gets 2 dice + 3 adds as a weapon, but you must make a L1-SR vs. Luck (20 - LK) each turn to keep it from blowing out, turning into a 2-die club. ]Go to {130} to attack the guard; if you win, you may take his scimitar."
},
{ // 113
"The smiling, shaven-headed acolyte leads you by the hand through the immense main hall of the temple. After politely brushing aside your questions, he brings you to a small alcove in the side of the hall. The alcove contains nought but a round wooden hatch, which the acolyte removes. He motions for you to look inside; before you can refuse or ask why, he leaps at you, legs and arms flailing. Roll a L3-SR vs. Dexterity (30 - DEX). If you make the roll, turn to {76}. If you miss the roll, the acolyte whips you around as though you were a pillow and pops you into the uncovered shaft. Everything goes black. Turn to {112}."
},
{ // 114
"If you have no light source (be it spell, torch, or lamp), go directly to {100}. If you have a light, you light it up and find yourself in a small room with a staircase up (see {72} if you ascend), an irregular hole in the wall leading to natural caves and tunnels, and a heavy wooden door to the temple dungeons. If you have a key to the temple, or a second level or higher Unlock spell, you may open the door and go to {134}. If you'd like to try and find a back way into the dungeon or just do some exploring, go to {107} to try the caves."
},
{ // 115
"You meet a dour laundry woman who goes into the temple daily to collect dirty sheets, green robes, and handkerchiefs. For ten gold pieces, and your promise that you will free her son from the temple dungeon, she will hide you in her cart with the clean linens and give you an acolyte's robe as well. \"I'll leave you in the big storeroom,\" she says. \"The dungeon steps are north of there; the big mumbo lives in the east tower. Remember...I want me son Podlo out of that place!\"\n" \
"  After giving you a meal and letting you stay the night in a damp crawl space, she hides you under a bundle of freshly starched sheets. The cart rumbles over the rough cobblestoned streets of the village and jounces up to the temple gates. You hear the old woman moan her way past the cruel guards at the gate, grimace as an acolyte takes charge of the load, and breathe in relief when the cart is wheeled to a dark room where you can get out and look around. See {140}."
},
{ // 116
"You continue to the end of the great hall. If you are not wearing a green robe, the guard here stops you. \"You tradesmen-scum can't enter the holy of holies!\" he says. \"Be off with you!\" If you are wearing a green robe and proceed, see {145}. If you retreat, see {72}. If you force your way pas him, see {95}."
},
{ // 117
"Ooops! A badly placed step results in a tumble down a flight of stairs. You flail your limbs and grab at the walls to stop yourself, wincing at the sound your equipment makes as it clatters down the stairs. Roll a die. If the roll is even, you badly sprain an ankle and are soon found by temple guards; see {112}. If you rolled odd, you come to a stop in a dimly lit room, bruised but otherwise hurt. Turn to {134}."
},
{ // 118
"Two guards and an acolyte face you...you must surrender (see {112}) or fight. The guards have MRs of 16 and have 5 points of armour protection; the acolyte has an MR of 12. If you are disabled, go to {112}. If you kill them off, go back to {95} and roll again, adding 3 to the roll."
},
{ // 119
"You are in a large, very warm cavern with a large, grumpy dragon. A plume of flame illuminates the chamber. \"WELL,\" he bellows. \"LUNCH. GOT ANYTHING TO SAY? I LIKE DINNER CONVERSATION, BUH-HUH-HUH!\" The dragon looks at you, flaming eyes seeming to drill into your soul. If you try to run, see {128}. If you attack the wyrm, see {135}. If you converse with him, see {146}."
},
{ // 120
"There are eight prison cells. To open one, go to the paragraph listed below. If you have the name of a particular one in mind, write it down if it isn't already and go to {193}.\n" \
"  Cells:\n" \
"    1: {137}\n" \
"    2: {143}\n" \
"    3: {152}\n" \
"    4: {157}\n" \
"    5: {164}\n" \
"    6: {172}\n" \
"    7: {179}\n" \
"    8: {186}\n" \
"If you would like to taunt the men in the cells and see what they're like first, see {132}."
},
{ // 121
"You are in the sleeping quarters of the temple acolytes. Hundreds of pallets of green burlap lie on the floor here; many are occupied by dead-tired cultists. If you have no green robe, go now to {95}. If you are properly equipped, you may leave by the south door (see {145}), the north door ({141}), or talk with some of the cultists (go to {184})."
},
{ // 122
"The guards draw their swords and wait for your assault. [Due to the size of the room, only two can attack you at a time. ]Each of the three guards has an MR of 16, and wears armour that takes 8 hits a turn. You also have to deal with the old man, a wizard with a Strength of 18[. On each turn, roll a die. On a 1-3, he does nothing. On a 4-5, he casts Vorpal Blade on one of the warriors' blades, doubling that guard's roll (this also costs the wizard 2 Strength points). On a roll of 6, the wizard casts a third-level Curse You spell that reduces your Charisma or Luck (your choice) by 3 points. Each curse costs him 1 Strength point. If you kill two warriors, you may also try to attack the wizard]; he has an MR of 12[, and is effectively immune to magic]. If you kill all four of the men in the room, see {162}. If you are disabled, see {112}."
},
{ // 123
"The griffin stares at you through the bars of the cage with glazed eyes. It croaks weakly, as though trying to talk...or is it sniffing you to see how you taste? If you open the cage to listen to what it has to say, go to {203}. If you open the cage to attack it, see {149}. If you'd like to question the gardener who's weeding a flower bed to the south, see {187}."
},
{ // 124
"By some miracle, the guards ignore you; you are free to continue. Go to {145}."
},
{ // 125
"You are stranded on a world far from your own. You know that a magical gate hangs in the air far above you, but even if you could reach it, you don't know how to activate it. Resigned, you begin to stake out a farm and learn the lay of the land. [Leave your character's card here; if another adventurer comes through, he or she may rescue you. ]Give yourself 500 ap for your efforts in this adventure!"
},
{ // 126
"Yastri falls to the floor. His followers stare in a horror for a few minutes before fleeing the room. Quickly rifling the desk and Yastri's corpse, you find a small amulet and a map. You examine these, trying to puzzle out their meaning. But after a few minutes you hear the sound of an angry mob coming up the stairs! You head for the ladder to the roof after stuffing the map and amulet in your pocket. See {207}."
},
{ // 127
"The room you've entered is rather warm; almost hot in fact. You feel your way about, finding a few skulls, a human thigh-bone scored with what might be what might be tooth marks, many pleasantly dense coins, and some sharp rocks that might be gems. Further exploration reveals a curving wall that seems to have been covered with scales. Oddly, the walls seem to be moving slightly. After a time, you realize that you are feeling up a large dragon. Amused at your antics, it provides a light so it can talk to you better. See {119}."
},
{ // 128
"The dragon laughs loudly as you try to flee. Gouts of flame and choking vapour shoot out of his nostrils as he chortles, endangering your continued existence. You must make a series of four L2-SRs vs. Speed or Luck (25 - SPD or LK) to escape; choose your attribute and roll. If you fail the first, you are fried or chewed up. If you fail the second, go to {146}. If you fail the third, you are hit with a plume of dragon's breath and must take 3 dice worth of hits directly off your Constitution (immunity to fire helps; armour doesn't!). If you fail the fourth, the dragon outmanoeuvres you, laughing incandescently. Begin rolling again, starting with the second roll! If you make all four at one time or another, see {107}."
},
{ // 129
"You are in the garden of the temple; a cage with a tired-looking griffin is north of you. As you recover from your battle, a large force of men enters the garden from the north. The leader looks at you evilly. \"Well!\" he says. \"What have we here? My griffin's next meal coming right to his cage!\" You are tackled and shoved into the griffin's cage. You cower in the corner of the cage in terror as the best approaches you, mouth twitching. Go to {203}."
},
{ // 130
"The guard leaps out from behind his desk when he sees you brandishing your weapon. \"HAH!\" he shouts. \"A prisoner trying to escape! Back into your cell, now!\" If you obey, and go into one of the cells, see {112}. If you fight him, limber up your dice fingers. He has an MR of 32, and wears 4 points of armour. On each turn, roll a die: on a roll of 1, the alarm is given and you must go to {95} after finishing off the guard. If you kill him, you may take his weapons or armour, and keys. To leave the dungeon, see {114}; to inspect the cells, see {120}."
},
{ // 131
"The hobbit drops to the floor, stone dead. As you watch, the purple colouring fades. Nothing else happens; you shrug and head for the tree where the griffin waits. There you remount and take off. See {213}."
},
{ // 132
"You walk from cell to cell, joking with the men behind them. The one in cell seven seems especially put off by your taunts. \"Huh!\" he sneers. \"You spend valuable time in this cell and we'll see if you feel like laughing!\" he shouts. The other cells contain an assortment of prisoners ranging from scared-looking peasants to muscular warriors. Two cells, four and five, hold imprisoned cultists. Go to {120} if you set anyone free; {107} if you leave the area."
},
{ // 133
"Yastri Kroll, evil leader of the cult of Krestok, climbs up to the roof, followed by many warriors. He puts an amulet about his head, and whistles. From the garden to the north flies a large, bedraggled griffin; with the guards and thousands of acolytes cheering, Yastri mounts the beast. The cult leader then does...something. He and the griffin disappear, vanishing in a cloud of sand. You realize that the pattern in the sand is some sort of magic teleportation gate. You can delay no longer; avoiding the honour guard, you leap into the pattern in the sand...turn to {156}."
},
{ // 134
"You are in the dungeon of the temple...outside of a cell, fortunately. There are eight cells at hand, as well as a desk, behind which is a muscular guard with a whip and an axe. He is looking at you suspiciously. If you attack him, see {130}. If you tell him you are his replacement, see {155}."
},
{ // 135
"\"MUM TOLD ME NEVER TO PLAY WITH MY FOOD,\" laughs the dragon as you advance on it, weapon drawn, \"BUT SHE DIDN'T SAY ANYTHING ABOUT WHAT TO DO WHEN FOOD FOOLED WITH ME!\" It has an MR of 120; its scales take 8 points of damage a turn as armour.[ On turns when it wins a combat round (even if it doesn't hit you due to armour protection), roll a die. On a roll of 6, it breathes fire, doing 2 dice of flame and smoke damage. Armour counts at base value in this case.]\n" \
"  [In return, you may try to stab or bash the dragon in its weak spot; a successful L3-SR vs. Intelligence or Luck (30 - IQ or LK) is needed to find it. You may roll each turn to find it, earning a bonus of 1 to the roll each time you fail. If you succeed, the dragon takes 60 hits! You may only strike at the weak spot once. ]If you win, go to {231}."
},
{ // 136
"You walk over to the cultists and stare at them curiously. They hover a good 3' over their meditation mats. The acolyte's eyes are closed, their faces serene. You are about to leave when an arrow from the archery range hits you in the seat of your pants. No harm is done, but your cry of surprise disturbs the levitators, who break out of their meditative trances and tumble to the ground. Furious, they surround you and wait for an excuse to kick you black and blue. If you attack them, go to {191}. If you would like to talk with them, see {184}."
},
{ // 137
"The man in this cell is a townsman caught stealing from the temple stores. He thanks you, then leaves; only later do you discover one-third of any gold you were carrying gone! Oh well, maybe the next guy will be more grateful. Go to {120}."
},
{ // 138
"You are on the roof of the temple. A narrow staircase leads from here to the west tower. A creaky ladder descends to the halls of the temple. You may also try shimmying across the roof to the east tower. If you climb the stairs, go to {106}. If you descend the ladder, see {145}. If you walk across the roof, make a L2-SR vs. Dexterity (25 - DEX). Add 5 to the roll if you have a rope with you, or can fly or levitate. If you succeed, go to {162}. If you fail the roll, take 2 dice of damage (armour counts, but subtract only the basic protection from damage!), and go to {141}."
},
{ // 139
"Suddenly, all is quiet. The griffin overcomes his fear and flies to the top of the tower, now lit in the light of twin sunsets. He finds a collection of blackened bones and bits of blasted metal scattered about the summit. Only one skeleton is intact. Still smoking, this one sits in a lotus position, ashes and half-melted armour still clinging to its bones. The griffin croaks in dismay, then notices a roll of paper clasped in one of the hands. The creature takes it, and flies off to the south, wondering how the Phoenix Scroll got there. Close the book...you've won, if not exactly in the way you expected!"
},
{ // 140
"You are in a huge storeroom. Shelves stacked with green robes, lamps, buckets, flints, food and rope tower on all sides. A few cultists are at work here, but you find that you can easily avoid detection by ducking behind shelves. You may take any items you wish, but roll a die after each; add 2 to the roll if you were wearing a green robe when you came in. On a roll of 1-2, see {95}. On a 3-4, the acolyte in charge takes your latest acquisition and shoos you out to {72}. On a roll of 5 or greater, you may continue pilfering. When you are done, see {72} to exit."
},
{ // 141
"You are in the temple's great courtyard. In one corner, a group of acolytes is practicing levitating; in another a troupe of warriors is training with bows. If you approach the eerily hovering acolytes, see {136}. If you walk over to the archery range, see {169}. If you'd like to go back inside, see {121}."
},
{ // 142
"Podlo bows and leads you to a strange pattern of coloured sand laid out on the roof of the tower. \"Well, that's half the job,\" says the rebel. \"Now we have to get the Phoenix Scroll to somewhere where it will be safe from villains like Yastri. I'm afraid that I am too weak to make the trip...you will have to go.\" After some experimentation you find that an amulet found on Yastri's corpse, in connection with a sharp whistle, summons Yastri's griffin. The beast curiously sniffs at Yastri's corpse (which he eats[ whole, magic armour and all]!) then lets you climb on his back. When you are ready, turn to {194}."
},
{ // 143
"This cell contains a young man named Podlo, a troublemaker from the village above. If you were given the task of rescuing Podlo[ AND remembered his name (is it written down?)], go now to {188}. If you [didn't remember his name, or ]got here by chance, Podlo thanks you and tells you to avoid the guy in the next cell. He also thinks to tell you that the prisoner in cell seven might be able to help. Turn to {120}."
},
{ // 144
"You find the cave where the guardian ogre lives and the Phoenix Scroll is hidden, in two days. There is some trouble though; high winds make the approach to the clifftop ledge before the cave difficult. The griffin grounds itself on a crag and tells you to continue on foot. As you head for the cave, you find something...a wooden club about 5' long, looking like it has seen a lot of use. When you lift it to get it off your path, you find that it is incredibly light. Examination proves that it is made of a flimsy, porous wood that would hardly dent the softest skull. You take it with you and head for the ogre's cave. Go to {178}."
},
{ // 145
"You are in the middle of a long corridor. Ahead of you is a door through which acolytes constantly pass in and out; if you enter, see {121}. Far to the left, you see a set of stairs leading upwards; if you climb them see {150}. Lastly, a ladder mounted on a wall nearby leads upwards. Climb it to {138}."
},
{ // 146
"Bad news...the dragon has trapped you in conversation! His piercing gaze freezes you in your tracks and paralyzes your sword arm. Your mouth is still functional, however; your only hope of escape is to talk your way out! Try to make three L1-SRs vs. Charisma (20 - CHR). If you blow all three, the dragon is disgusted and burn you to a cinder after knocking your head off. If you miss two, he is somewhat entertained; you are not eaten, but the dragon calls the cultists and tells them to bring him a more agreeable supper (go to {112} if you follow the guards that come, {128} if you try to get out while the going's good). If you miss only one roll, the dragon is stumped; you slip away to {117} while he scratches his chin and wrinkles his brow. If you make all three rolls, the dragon is embarrassed by the superiority of your rhetoric and burns you to a crisp. No one likes a smart arse!"
},
{ // 147
"Battered and fatigued, you slip beneath the waves. If you are immortal or can breathe water, you are carried south and east by the swift, chill current. Eventually you wash ashore (in your new body if you reincarnated) on the far side of Grey Lake, too far from the temple to even consider getting to the temple in time. You earn 200 ap for your work in the adventure thus far. If you don't have the power to resist drowning, your life passes before you and everything...goes...DARK."
},
{ // 148
"You bark at the guard to release one of the prisoners. He looks at you angrily; roll a die, adding 2 if you are in a green robe. On a 1-3, see {130}. On a 4-5, he leaves the room, telling you to stay put (after freeing your prisoner, see {95}. On a 6 or higher, he gets out his keys and asks you what the prisoner's name is. If you have the name written down, go to {143}. If you don't know and try to guess, see {193}."
},
{ // 149
"The griffin is rather weak from mistreatment...if it had been in good health it would rip you to shreds in no time. As things stand, the griffin has an MR of 40. If you kill it, see {31}. If you are disabled, see {13}."
},
{ // 150
"You are in an anteroom high in the eastern tower. Three guards and a feeble-looking old man guard a door to the north; a staircase leads down to the temple halls. If you go down the stairs, see {145}. If you ask the guards to let you into the room they are guarding, see {160}. If you attack them, see {122}."
},
{ // 151
"Yastri Kroll sneers and gets off the griffin, which slinks off under some bushes. The cult leader has these attributes:\n" \
"    ST 17  IQ: 14  LK: 13  DEX: 16  CON: 24  CHR: 25  Adds: 10/13\n" \
"His armour takes 20 hits a round[, and acts as a barrier to magic below third level: When a spell under level four hits him, he gets to make a L1-SR vs. Luck (20 - LK) to deflect it]. He wields a two-handed broadsword (5 dice + 2 adds) in combat, and has a sax as a backup. If you die, close the book. If you disable or kill Yastri, the griffin approaches you...turn to {223}. If you are disabled by Yastri, see {125}."
},
{ // 152
"The man is this cell is a surly-looking barbarian. He tells you to hurry up when you approach his cell. After you open it, roll a die, adding 2 if you taunted the prisoners before opening the cages. On a 3-5, he thanks you and leaves. On a 1-2, he offers his services to you: he [has an MR of 30, halved because he currently has no weapon, and ]will stay with you until you leave the temple. On a roll of 6 or more, he pretends to leave, then leaps at you with a garrotte made of woven ratskin and trail vertebrae. If you fail a L1-SR vs. Constitution (20 - CON), you are knocked out and stripped of your weapons. The cultists find you later and dump you in a cell (turn to {112}). If the garrotting attempt fails, the bully fights you for four rounds, he has an MR of 15. Go to {120} if you survive."
},
{ // 153
"With a mighty bound, you leap for the ladder leading to the roof. Yastri Kroll, cult leader, takes exception to this act and draws his dagger. He tosses it expertly. He is at short range; if you are over 5' tall, he needs an SR of 9 or more to hit. If you're a little dude, he needs a 14 or more to hit. If he strikes, take 2 dice plus 13 adds (minus armour) in hits. If this disables you, go to {159}. If you take more than 8 hits, you are temporarily stunned and must fight ({198}), or try talking your way of your situation (see {174}). If you are not hit, or not seriously injured, you make it to the roof...turn to {183}."
},
{ // 154
"If you haven't looted his cave already, here is the ogre's swag: 126 gp, 487 sp, 11 random gems in a gold cup (the cup is worth 250 gp and weighs 2#), and a pair of ogre's gloves which add 2 dice to your combat roll when fighting unarmed. Packing everything up, you head back to the griffin. On your way back to the gate, you spot a small farm where you trade a tale for some food [(turn now to {125}; if there are any characters there you may rescue them. Keep your place marked here!) ]before starting off on the final leg of the journey. Your trip back to your own world takes five days; at the end of it you give the griffin the scroll to be brought to the proper authorities and prepare for your next adventure...after a suitable rest, of course! This adventure earns you 1500 ap for a job well done!"
},
{ // 155
"The guard glares at you, suspicious of trickery. Make an L1-SR vs. Charisma (20 - CHR). If you don't make it, go to {130}. If you succeed, the guard gets up and hands you his keys. \"About time,\" he says as he leaves the dungeon. \"Watch out for the one in seven!\" Go to {120}."
},
{ // 156
"As you enter the pattern in the sand, you feel yourself being lifted away. The world fades, and you perceive that you are travelling at great speed through a dimly-lit abyss. Suddenly, with a THUNK and a SLAM, you find yourself back in the world again. After a short blackout, you wake amidst a patch of bushes. From the aches and bruises you've suffered, you estimate that you feel from several dozen feet in the air. A short distance away is a clearing. Approaching cautiously, you see a man dressed in green riding a tired-looking griffin. If you approach the man to talk with him, see {215}. If you attack him, see {151}. If you wait to see what he does, turn to {24}."
},
{ // 157
"This cell contains a man dressed in a green robe. [He claims to be a hero like yourself and wishes to assist you on your mission. He has an MR of 8 due to starvation, however, and lacks a weapon. ]He will stay with you until you leave the grounds. Go to {120}."
},
{ // 158
"You wait bravely for something to happen...and something does. A massive bolt of lightning strikes the tower. Then another, and another! Soon, the whole sky is alive with a sea of forking, sparking bolts of lightning! If you try to leave, go to {182}. If you stay to see what happens, go to {212}."
},
{ // 159
"Straining against your captors, you are trussed up and put in a tiny cell. After a time you are untied and brought out into a beautiful courtyard garden. Set in the middle of the pleasant place is a large cage holding a griffin. The animal stares at you with great golden eyes as you are unbound, given a final knock on the head to stun you and shoved into the griffin's cage. They leave you, laughing at your fate. Make a L1-SR vs. Charisma (20 - CHR). If you've ever killed innocents ([pilgrims, old ladies, or honest merchants, ]in [this or ]an[y ]other adventure!) make the saving roll at THIRD level (30 - CHR)! [(If you have any charms or spells that might help, now is the time to use them!) ]If you miss the roll, {13}. If you win the roll, the griffin stares at you and approaches menacingly. If you attack the handsome beast, see {149}. If you talk to it soothingly, see {203}."
},
{ // 160
"The men in the anteroom look at you oddly. Roll a die, adding 2 if you wear a green robe. On a 1-2, the old man wiggles a finger at you, blasting you with a 22-point Take That You Fiend spell. Go to {122} if you still live. On a 3-4, the guards attack; see {122}. On a roll of 5 or 6, you are pushed out a window...after a short fall you find yourself in a courtyard (see {141}). On a roll of 7 or 8, the guards like your reasoning and let you into the tower chamber. See {167}."
},
{ // 161
"The storm rages about you as you scramble to the top of the mysterious tower. Scattered on the flat upper surface are several skeletons' worth of human bones, blackened and cracked as though blasted by some incredible force. If you have the good sense to run for it and jump for the ladder, go to {202}. If you stay put to see what happens, see {158}."
},
{ // 162
"You step into a room in the east tower. It is furnished with a table, chairs and desk; a ladder leads to a hatch in the roof. Sitting with his back to you at the desk is a man in an ornate green robe. If you stab him in the back while he scribbles on a paper on his desk, see {181}. If you call to him and try to strike up a conversation, see {174}. If you run for the ladder, see {153}."
},
{ // 163
"The hobbit has an MR of 22, but his combat total is halved because he is unarmed. \"Big dope!\" he cries as you begin swinging. \"I come here to get away from it all and big stupid oafs come to my door and bother me anyway!\" Fight one round of combat; if he survives the round, you may stop fighting (go to {210}), or continue clobbering the hobbit until he's dead (see {131} if you finish him off)."
},
{ // 164
"The cell contains a woman dressed in a green robe. She begs for water when you approach; you get it for her[, but while your back is turned she leaps with sudden energy to the guards' alarm bell. This woman cultist was being punished for laziness; turning you in will redeem her in the eyes of the Seers. You have time to open one more cell, then see {95}]."
},
{ // 165
"The dead acolytes begin to attract attention, not to mention a few flies; after looting the bodies (you find 34 sp, two poniards [coated ]with spider venom, and a small pipe full of potent pipeweed), you look for a place to hide. For the cellar, go to {107}; for an aboveground bolt hole, see {177}."
},
{ // 166
"Exploration of the ruins adds one day to your travel time. In the dusty, crumbling builds and old foundations you find much old pottery, a tarnished copper dagger (worth 10 gp for its value as an antique), and an intriguing limestone bas-relief carving. The block pictures the heads and upper bodies of two heroic men locked in mortal combat. Something tells you it may have some value. It weighs 30#. If you keep it, record the fact (and the weight!) and turn to {94}."
},
{ // 167
"You are in a room high in the temple's eastern tower. The leader of the cult, Yastri Kroll, looks you over from behind his desk. \"Well, whelpling? What is your business with me?\" He is a tall man, dressed in a green robe; it is more ornate than the standard model and looks like it may cover armour. The office is bare but for some functional furniture and a ladder leading to a hatch in the roof. If you attack Yastri, see {198}. If you try to reason with him, convincing him to stop his reign of terror, go to {174}. If you make a dash for the ladder, see {153}."
},
{ // 168
"You quickly find the cave. The griffin lands on a ledge and lets you off. \"Good luck,\" he says as you check your equipment. \"I wish I could help further, but I am too weak to fight a creature as great as the ogre.\" You tell the griffin you will be alright, and head for the cave. Go to {178}."
},
{ // 169
"The warriors are all fairly good shots, but one has a grudge against an acolyte who looks like you. Roll a die. On a roll of 1-3, an arrow hits you doing 1 die of damage directly off your Constitution. On a roll of 6, you catch the arrow before the amazed eyes of the warriors and their trainers. Convinced that you deserve special training, they send you to see the boss (go to {167}). If you don't roll lucky, you pass by the warriors to an exit on the far side; see {177}."
},
{ // 170
"Podlo tells you that some friends of yours might be cell number seven (go to {179}, then return here), then leaves the dungeon. You follow him to a high tower, where together you easily defeat a group of warriors guarding a stout door. Podlo knocks the door down, and confronts Yastri Kroll. If you help Podlo fight the cult leader, see {190}. If you look for others to fight by climbing the ladder leading to the roof of the tower, go to {175}."
},
{ // 171
"The peddler and hobbit are startled, but eventually gain their composure. When you start to talk, they wave their hands in dismissal and shake their heads. \"We are busy men,\" they say. \"I must go to the south to sell my wares,\" claims the peddler. \"And I must finish my housekeeping!\" says the hobbit. If you leave in disgust, go to {213}. If you want to walk along with the peddler, offering him protection in exchange for information, see {197}. If you want to help the hobbit with his housework in order to start a conversation, see {210}."
},
{ // 172
"This cell contains four captive miners who stumbled into the Temple's tunnel complex last year. They warn you that a dragon's lair is somewhere nearby. [The miners will stay with you until after your first combat; they have MRs of 12 each. ]Go to {120}."
},
{ // 173
"FROM MEMORY, write down the poem given to you. Then turn to {192}. No cheating!"
},
{ // 174
"Yastri Kroll, leader of the Krestok faith, listens to you as you plead for an end to his faith's tyranny. After a time, he laughs evilly. \"Surrender my power? Now?\" he asks, leering. \"Why, by the end of the day the Phoenix Scroll will be in my possession! Guards! Take this cur to feed my mount!\" If you attack Kroll, see {198}. If you leap for the ladder, see {153}. If you let the guards take you, see {159}."
},
{ // 175
"You find an unusual pattern of coloured sand on the roof. The lines forming the pattern seem to shift and blur, rising out of the sand as if rotating out of the plain of the floor. As you watch in fascination, a scream cuts the air from below. Roll a die: on a roll of 1-2, Podlo pops out of the hatch, battered but smiling triumphantly. Go to {142}. If the roll is anything else, you recognize the death-cry as Podlo's and hide behind a cistern; turn to {133}."
},
{ // 176
"Your spell bounces off the hobbit; as it does, the purple shade of his skin virtually disappears. \"WOW!\" cries the fellow. \"Do that again!\" If you do do that again, see {185}. If you'd rather take out a real weapon and fight him, see {163}. If you would rather talk and find out what's going on, see {210}."
},
{ // 177
"The rear exit of the courtyard leads into a walled garden. A staircase spirals around the east tower from here; go to {183} if you climb it. If you walk a bit farther into the garden, you see a griffin in a cage, and a gardener tending the herbs grown in the garden. If you go to the cage, see {123}. If you bother the gardener, see {187}."
},
{ // 178
"You are at the mouth of the ogre's cave. You see bones, a collection of pointy elf-ears strung on a piece of twine, several half-eaten legs of ram, and other assorted garbage heaped by the entrance. If you enter, go to {200}. If you want to recite some poetry, see {173}. If you have a certain club with you, you may choose one of the above, or write down something special to try. See {195} if you have a special plan."
},
{ // 179
"\"About time!\" shouts this cell's occupant. [He (or she) is the last character to be imprisoned here. (See {112} for details.) He or she will accompany you until you leave the temple, then leave to take care of business. If this is one of your characters, you may choose which one will be your main character and who the spear carrier; the spear carrier will do nothing but fight in combat. If there are no characters imprisoned here, an NPC warrior with an MR of 18 is in the cell. ]Go to {120}."
},
{ // 180
"The griffin asks you to ride on him to get the Phoenix Scroll. Both of you will have to pass through a magical gate, located on the roof of Yastri's tower, to get to the realm where the scroll is hidden. You help the griffin out of the cage and get him some water and food from your pack. Partially restored, he allows you to climb aboard for the flight to the roof. Go to {194}."
},
{ // 181
"You raise your blade and bring it down between the shoulder blades of the man in green. Roll the weapon's combat dice, and add your [Strength ]adds[ (only)]. If the result is over 20, the blade strikes true and the man cries out in agony. If you did more than 26 hits total, he slumps forward on the desk, blood gushing out of his mouth...turn to {126}. If you did between 21 and 25 hits, the man takes that many hits minus 20, but is still in fighting shape; go to {198}. If you didn't penetrate at all, you may fight him (see {198}) or back away, begging for mercy (go to {159})."
},
{ // 182
"You try to get to the edge of the tower, but a sliver of lightning finds you, doing 4 points of damage directly to your Constitution. You look over the edge of the tower, and see its sides glowing with intense green light; St. Elmo's fire creeps up the buttresses you ascended the tower by and collects in globes of ball lightning at their tops. You realize that the only thing to do is stay near the edge of the tower top and dodge like mad to avoid the lightning bolts slamming into the centre. Make three L2-SRs vs. Dexterity (25 - DEX); if you make all of them, you get through unharmed. For each point you miss by, take a hit ([cloth, wood and leather ]armour [DO ]count[ in this ca]s[e]); if you ever miss one by more than your Luck, however, your good fortune runs out and a bolt hits you full-on, killing you instantly. If you live through the storm, see {218}."
},
{ // 183
"You have climbed to the roof of the eastern tower of the temple. A stairway winds around the edge of the tower, down to a walled garden. The slate floor of the roof is covered with a layer of pure white sand, on which coloured sands have been trickled to form a complex pattern. For some odd reason, the lines seem to jump out at you, to rise from the flat surface of the roof. If you study the patterns further, see {156}. If you hide behind something to avoid further trouble, see {133}. If you head for the garden in the courtyard below, see {177}."
},
{ // 184
"The acolytes are anxious to pay you back for their sore posteriors, but listen to your explanation. If you don't have a green robe on, see {95}. If you do, roll a die: On a roll of 1-3, you are stonily ignored. On a roll of 4, an instructor comes to you and chastises you for breaking silence in the cells; he sets you to work scrubbing the walks of the garden; see {177}. If you roll a 5-6, you are recognized as an outsider! Turn to {191}."
},
{ // 185
"You hit the hobbit repeatedly with your spells; eventually, the purple colouring wears off. \"Oh, thank you! At last I can go home and not be laughed at. How can I help you adventurer?\" You tell the hobbit that you need guidance, a way to get to a certain location far to the north. \"I have just the thing,\" he tells you. \"I bought this from a peddler to decorate my wall.\" The hobbit gives you a map of the northern mountains. For further aid, see {210}. [Note: Due to a slight magical backwash, your magic-casting abilities have been strained somewhat. Each time you cast a spell, from now until the end of the adventure, you must make a saving roll vs. Luck on the level of the spell. If failed, the spell fails also, though at no Strength cost. ]Good luck!"
},
{ // 186
"The man in this cell is shackled to the wall. His thumbs are tied with Xerexes's Bane, a quaint method of preventing wizards from casting spells. You release the mage, who agrees to come along[ and help you in combat. He is second level, has an IQ of 16, carries a makeshift staff, and has an MR of 20. Spellcasting will drain MR instead of Strength, and is recovered up to the limit of MR spent on spells, not wounds. The wizard has the Restoration and Enhance spells on the second level; these you may use as convenient]. [The wizard will leave you after thirteen more turns of a page...keep track! ]Go to {120}."
},
{ // 187
"You tap the gardener on the shoulder. You freeze in shock when he turns to you. His head is bare of flesh, eye sockets coal-black pits of darkness. You stand there, shivering, as the gardener gets back to his work. When you recover, you find yourself surrounded by temple warriors. There are six of them; each has an MR of 16, and has armour worth 4 points of protection. If you defeat all of them, see {129}; if you are disabled, see {159}."
},
{ // 188
"Podlo is a brave rebel seeking to throw off the rule of Krestok over his native village. He asks that you accompany him to the east tower to defeat the cult's evil leader. If you agree to his request, go to {170}. If you would rather lead, go to {196}. If you want to do this thing alone, go to {120}."
},
{ // 189
"Leaving the foothills on the south side of the plain, you head east. In the distance glimmers a large body of water...Grey Lake, if you remember your local geography. Though the dusty, treeless plain you are crossing seems quite deserted, the plain is studded with obelisks of weathered granite. Odd runs have been carved in each of the stones; bas-relief carvings illustrate what horrid uses the standing stones were once used for. At first you ignore the obelisks as you would trees in a forest, but soon you find them terribly frightening. As you pass each in turn, reedy, tortured-sounding voices seem to call out to you. Strange dust-devils that travel against the steady wind cluster around you as you approach an obelisk. Two days into your three-day journey, you find yourself fighting to regain your sanity: You must fight a Battle of Wills to keep from being possessed by the wind-wraiths that haunt this part of the plain.\n" \
"  MARK YOUR PLACE HERE and look at {408} for rules on Mental Combat & Battles of Will. You must fight three wind wraiths; each has a Mental Integrity of 12. They get 2 dice and 6 adds in combat. If your mind is defeated in the intellectual struggle, you become a wind wraith yourself, doomed to whistle across the Plain of Obelisks forever. If you are disabled in the combat, you wander aimlessly for seven days, eventually coming to a darkened tower (turn to {354}). If you win, you earn 30 ap. Mark down the three days your passage took and turn to {208}."
},
{ // 190
"See {198} to find Yastri's attributes and fighting style, then return here. [Podlo has an MR of 16 (he's been in jail for quite awhile) and will fight until he is disabled or killed; you may give him a shield to help defend himself if you wish. ]If you kill Yastri and Podlo lives, see {142}. [If you kill Yastri but lose Podlo in the attempt, see {126}. ]If you are disabled, see {159}. (Podlo will flee through the roof if you are disabled, telling you to be brave...)"
},
{ // 191
"You are facing twenty angry acolytes, most looking for some action after weeks of dull temple routine. They assume a strange, spread-armed posed and wait for you to attack. You come in with sword swinging. Each skinny acolyte has an MR of 10; four can fight you at a time. Because the cultists know some martial arts, however, roll a L2-SR vs. Luck (25 - LK) each turn: if you miss, take hits equal to half of the amount you missed by. If you manage to kill them all, see {165}. If you surrender or are disabled, see {112}."
},
{ // 192
"If the poem you wrote was:\n" \
"    Ogre smelly, Ogre dull,\n" \
"    how thick is your tiny skull?\n" \
"    Thicker than my thigh, I'd say.\n" \
"    Pray, show me by the light of day?\n" \
"The ogre bellow furiously and charges out into the daylight; go to {209}. If you failed to remember correctly, you may go in after the ogre (see {200}), or try to think of something to do with any oddly constructed clubs you've found (go to {195} if you have the club only!)."
},
{ // 193
"If you have \"Podlo\" written down, you may now go to cell {143} and open it to release the laundry woman's son. If you wrote the name down, go to {188} from there. If you [guessed wrong, or ]didn't write your guess down, go to {120}."
},
{ // 194
"The griffin dances a little jig on a pattern of coloured sand on the tower roof. You feel light-headed and see the world fade around you. The griffin strokes its huge wings, driving you through a misty realm between worlds. After what seems like an eternity, you emerge in a forested realm. Two suns hang in the bright purple sky; far to the north a range of snow-capped mountains glimmer on the horizon. The griffin lands in a clearing to rest. Turn to {223}."
},
{ // 195
"If you plan was to substitute the flimsy club you found for the ogre's, you do so; a quick trip into the cave allows you to place it by his doorway without attention. If you go in to investigate, with or without switching clubs, you may now enter by going to {200}. If you have poetry to recite, see {173}."
},
{ // 196
"\"Suit yourself,\" Podlo shrugs. \"I'll sit back and watch. Pardon me; I'm going to get some front-row seats.\" Podlo leaves the dungeon, smirking. Go to {}120} if you want to free some more prisoners, {162} if you follow Podlo to see where his \"front-row seats\" are located."
},
{ // 197
"The peddler accepts your company. You get him talking about the northern mountains, and he offers you a map of the area for 100 pieces of gold. If you have that much, he sells you the map. If you don't, you must fight him for it...turn to {257} to find the peddler's characteristics. Go to {213} when and if you defeat him. If you don't purchase the map, and don't wish to fight the peddler for it, go to {213} without the map."
},
{ // 198
"The cult leader, Yastri Kroll, is no weakling. He has these attributes:\n" \
"    ST: 17  IQ: 14  LK: 13  DEX: 16  CON: 24  CHR: 25  Adds: 10/14\n" \
"Kroll uses a two-handed broadsword in combat (5 dice + 2 adds). His magic armour absorbs 20 hits a round in combat. [The armour also absorbs or nullifies spells of 1st through 3rd level. To get through this protection, Yastri must fail a L1-SR vs. Luck (roll under 7). ]On each turn following the second, roll a die. If the roll comes up 5 or 6, an MR 16 warrior steps into the room to join the melee. If you surrender, go to {159}. If you try to get to the ladder, see {153}. If you manage to kill Yastri, see {126}."
},
{ // 199
"That afternoon, you and the three grim fishermen raise sail and turn north. Through the mists that cover the lake, you can see the pine forests on the western shore slip quickly by. The day passes uneventually; the men catch some fish, fry it on a brazier and break out a bottle of rum for dinner. As your party heads for shore for the night, however, trouble strikes. The boat shudders and tilts; one of the men screams and is knocked to the deck by something that rises out of the lake. You hastily grab your weapon and prepare to fight. [The two fishermen still on their feet have MRs of 10 each; the third man will join you on the third combat round with an MR of 8. ]The face of the enemy is revealed by the dim oil lights; a boat-sized creature with five tentacles, covered in rubbery black skin. The beast has an MR of 80. Its skin takes 6 hits. [On each turn that it wins the round, roll a die: On a roll of 1, it grabs at someone on deck and tosses them out on the lake instead of doing normal hits. (If this happens to you, turn to {211}). If the die roll comes up 2, the monster attacks the boat instead; the craft can take 40 hits. If the boat is sunk, turn to {220}. ]If you defeat the creature, turn to {241}."
},
{ // 200
"The ogre's quarters are horrible-smelling, dirty and dark. The weight of the mountain above you is oppressive and scary. Since he is not in sight, you begin to ransack the ogre's cave. You find three bags of coins (126 gp and 487 sp total), a gold cup full of gems (the cup weighs 2#, and is worth 250 gp; there are 11 gems inside it that you may roll on the treasure generator to identify), and a pair of ogre's gloves...you can't use them in this adventure because you don't know how to use them yet, but the gloves add an extra die each to your combat roll when in unarmed combat. As you finish stuffing these items in your bag and start wondering where the Phoenix Scroll is, the ogre enters the cave. \"RAUGHH! Intruders! LUNCH!\" he bellows as he grabs for his club and rushes you. The ogre has an MR of 60[, but his adds are increased by 50% because he is in his home territory]. You may not retreat! If you win, turn to {228}. If you did something tricky with a club earlier, see {238} before fighting!"
},
{ // 201
"You wait for about an hour before somebody shows up at the house, an ordinary-looking man wearing a huge pack over his tattered clothing. He knows at the door of the cottage; the door is answered by a short creature resembling a hobbit...one with bright purple skin. The man with the pack - obviously a peddler - strikes up a conversation with the purple hobbit. They get down to haggling; eventually the hobbit buys a large bottle of mysterious-looking liquid. If you barge in now to see what's up, see {171}. If you'd rather wait to see the hobbit alone later, see {219}."
},
{ // 202
"You leap for the buttress, your only path to safety. As you scramble for the edge, tripping on the bones that litter the roof of the tower, you feel the hair at the back of your neck tingling. Make a L2-SR vs. Dexterity (25 - DEX). If you make it, you get to the bottom of the tower unharmed; if you fail, take the amount you failed by in hits. If you reach the mesa alive, you may stay and see what happens, avoiding the storm, or leave now while the leaving's good. Go to {205} if you stay, {144} if you leave now."
},
{ // 203
"The griffin creeps very close, then whispers in your ear: \"This evil one, my 'master', grows too bold. You must fly away with me. Together we can steal the Phoenix Scroll and bring it to safety before the Krestok can wreak havoc.\" If you take the griffin up on his offer, go to {180}. If you beg off, go to {13}."
},
{ // 204
"The griffin lands on the edge of the mesa. After letting you off to investigate the pillar, it cowers behind a large boulder which sits at the edge of the otherwise level platform. As you approach the red sandstone monolith, the sky suddenly darkens with wind-driven clouds and thunder rumbles among the mountain peaks. A chill wind whistles overhead mysteriously; as it blows through the tower supports a soul-chilling moaning is produced. You circle the obelisk, examining it carefully. The runes carved into its sides are like nothing you've seen...and yet somehow strangely familiar. Though the monolith looks freshly carved, you somehow sense it is immensely old. If you climb up one of the buttresses, using the incised runes as handholds, go to {221}. If you'd rather leave, you rush back to the griffin and fly before the storm gains too much power - go to {217}."
},
{ // 205
"As you watch in awe, bolts of lightning begin to strike the tower. In fact, clouds for miles around are having blazing white sheets of lightning pulled from them, forming an inverse cone with the tower at the bottom. The stone of the tower emits a dull brownish-red light as the summit blazes with a brilliant golden aurora; the mystic runes on the sides of the great tower emit beams of intense emerald-green light that play across distant mountain sides throughout the range. The griffin, hiding by the edge of the mesa, huddles into a little ball; you get the urge to do the same. If you leave now, go to {144}. If you stay till the end, go to {218}."
},
{ // 206
"Look at the descriptions below. If they match the plan you wrote down, turn to the listed paragraph. If you didn't write a plan down, or it wasn't listed, your efforts were futile. Turn to {248} to continue.\n" \
"  * Replace the stone...turn to {214}.\n" \
"  * Use a Revelation spell to look for secret doors...turn to {227}. Similar spells or abilities (such as vision through rock) will work as well.\n" \
"  * Use a flight spell or ability...turn to {236}.\n" \
"  * Use Bog and Mire, Blasting Power, Hellbomb Bursts or sheer strength and a rock-pick to tunnel into the wall...see {250}."
},
{ // 207
"You emerge on the roof to find a large, if somewhat sickly-looking griffin waiting for you. \"About time,\" it mutters. \"I was waiting for you. Do you have the map and amulet?\" You nod, and wonder what the heck is going on. The griffin tells you that, as the one who killed Yastri, you are his new master...at least until the job at hand is over. Knowing that even noble beasts of the air will be affected by the evil Yastri Kroll can wreak if he completes his maniacal plan, the griffin asks you to help him find the Phoenix Scroll and put it in responsible hands. If you refuse the griffin's plea, see {24}. If you climb on the griffin's back and tell him to proceed, see {194}."
},
{ // 208
"You are on the eastern shore of a large body of water, a chilly freshwater lake. To the west is a dusty grey plain, covered with strange obelisks and ruins; its sight fills you with foreboding. South of you lies impassable swamp; to the north is a pleasant-looking wooded area. As best you an tell, the Krestok temple lies to the northwest, where you can see the peaks of many high mountains. If you go north, following the well-travelled road leading in that direction, turn to {345}. If you'd like to travel north and east, following the shore of the lake in hopes of finding water transport, turn to {224}."
},
{ // 209
"The ogre is outside his element, but he fights bravely nonetheless. He has an MR of 60. If you did something clever with a club earlier, turn to {238} before starting combat. If you win, see {228}."
},
{ // 210
"The hobbit (for that is what he is) introduces himself as Grundo Shackrabbit. A confirmed homebody, Grundo was forced into going on an adventure by two cousins. Grundo ran afoul of a magician who turned his skin bright purple. Unable to face the folks back home in this condition, he made his way here by unspecified means. \"Fortunately, the folk here are quiet and speak our tongue. They're all very non-adventuresome, of which I greatly approve.\" You convince Grundo that you, too, are a stay-in-hole type, and milk him for information on the region to the north. \"I can't promise you anything,\" he tells you, \"but I've heard that there's a nasty ogre who lives in the mountains. To get into his hole, you must recite this verse:\n" \
"    Ogre smelly, Ogre dull,\n" \
"    how thick is your tiny skull?\n" \
"    Thicker than my thigh, I'd say.\n" \
"    Pray, show me by the light of day?\n" \
"\"I couldn't imagine anyone wanting to face an ogre in the open or the dark, but I've heard that he is invincible in the depths of his cave.\" The hobbit gives you some tea and biscuits; you thank him and ask to hear the funny poem again. (You may spend all the time you wish memorizing it, but since you have no pen and ink with you, you may not write it down; when it is needed you will be tested!) After helping Grundo wash the dishes you leave and board your griffin. As you head north, you hear the hobbit squeaking behind you: \"Oh, my! I've had lunch with an adventurer! Eeek!\"...Go to {213}."
},
{ // 211
"Stunned by the fury of the beast's attack, you are caught by surprise when it wraps its sucker-covered tentacle around your leg and flings you far out into the lake. Make a L2-SR vs. Luck (25 - LK); take the amount you missed the roll by in his directly off your Constitution. If this disables you (Constitution 5 or less), you drown immediately. If you still live, you begin to frantically shuck armour and other impediments to swimming. Roll a saving roll vs. combined Speed and Dexterity: The roll is made at second level (25 - (SPD + DEX)) if you have no armour, fourth level (35 - (SPD + DEX)) if you were wearing leather, cloth or scale armour, sixth level (45 - (SPD + DEX)) if you had the bad luck to be clad in metal armour. If you miss the roll, turn to {147}. If you make the roll, you remove and drop your armour and all baggage but one weapon and a number of small objects (gems, a bag of ten coins, a small amulet or book) equal to your Luck. You can then try to swim for the shore or the boat. To get into the boat, you must make a L2-SR vs. Strength (25 - ST); to get to the shore, you must make two L2-SRs vs. Strength (25 - ST). If you miss any rolls, turn to {147}. If you make all the required rolls, continue fighting the creature on the boat (turn to {241} if you win) or begin walking on shore (turn to {334})."
},
{ // 212
"You stand bravely at the centre of the circle of bones until a bolt of lightning strikes next to you. Terrified, you huddle against the tower-top, whimpering as bolt after bolt of lightning strikes near you; trembling, you twitch and crawl about until you seem to find a position of safety. After a time you realize that you are in a minute pocket of safety, the eye of the storm, in the middle of the tower. You look up in amazement to see that you are at the base of an immense inverted cone of crystal-clear air: The sides of the cone are solid lightning; the wide end, high overhead, is a night sky full of brilliant stars. Standing up, you notice that the crackle of lightning striking has grown faint. You begin to hear a chorus of far-off voices, changing in an alien tongue to a frightening 3/7 beat. In the most terrifying, soul-shaking, slack-jawed, wide-eyed moment of horror in your life, you see the stars overhead begin to move in time to the singing.  You realize you are on the verge of witnessing one of those things that man was not meant to know. If you avert your eyes, and huddle to the floor to block out the mystic signs in the heavens and clasp hands over your ears, go to {218}. If you continue to watch bravely, accepting whatever happens, see {139}."
},
{ // 213
"The griffin nods to you as you climb the tree and mount his back. He leaps into the air and heads north as you discuss your adventures at the cabin. Soon, you reach the first peaks of the northern mountains. The griffin flitters about, looking for landmarks. Roll a die: If you have the map from the cult leader's desk, or the one from the peddler or hobbit, add 2 to the die roll. Go to the paragraph appropriate to the roll you obtained:\n" \
"    1-3: {226}\n" \
"    4-5: {217}\n" \
"    6-7: {144}\n" \
"    8:   {168}"
},
{ // 214
"If you have the appropriate stone (you'll know if you do!), you insert it and watch in wonder as a section of the wall slides open to reveal a narrow passage through the rock. Turn to {255} to enter. If you don't go in, or don't have the correct stone, turn to {248} to continue."
},
{ // 215
"The man on the griffin is Yastri Kroll, the evil leader of the cult of Krestok! \"So, fool!\" he bellows cruelly. \"You follow me to this place. Your punishment will be to stay here, an aeon's journey from our world!\" The man laughs, and you notice for the first time that there are two suns in the sky. Stunned for a moment by the terror of your position, you recover just in time to see Yastri whip his mount to action. If you wait to see what happens, turn to {125}. If you leap to knock Yastri off the griffin, make two saving rolls: one L1-SR vs. Strength (20 - ST), one L1-SR vs. Dexterity (20 - DEX). If you miss either, see {125}. If you make both, see {151}."
},
{ // 216
"You are at a pleasant little shrine located high in the mountains. A group of monks greet you politely and allow you to stay the night. Roll a L1-SR vs. your [ordinary, unmodified ]Charisma[ (the monks can see through illusions made by magic, makeup or clothing)]. If you miss the roll, you are bid to be on your way the following morning and asked for alms. (You must pay a number of gold pieces equal to the amount you missed the roll by. If you don't have the money, the monks GIVE you that amount!) Turn to {233} to continue. If you make the roll, you manage to impress the wise leader of the order: The monks feed you well and give you a pack of trail food (replenishing your food supply), remove [any one ]curse of up to sixth level, ]and a bit of advice: \"Many of the people in the village around the temple hate the cult,\" says the abbot. \"Search the town carefully and you may find a friend.\" If you make any saving rolls vs. Charisma in the town or at the temple gate, you may now add 5 to your roll. Write the details of this boon down! Once in the temple this bonus is lost. Turn to {233} to continue."
},
{ // 217
"The search for the cave where the Phoenix Scroll is hidden takes three days. Your search is not unopposed; when you approach the cave, a flock of bats attacks you and the griffin. The are twenty bats; the griffin will kill one die worth each turn, but you must attack them in ordinary combat. Each has an MR of 8[; you must fight them with your hands (which get 2 dice in this situation), magic, or any small one-handed weapon]. [Any hits given will be divided between you and the griffin; the griffin takes 40 hits total...if he dies, you both hurtle to the rocks below and are crushed and smashed by the spires of sharp stone. ]If you survive, see {178}."
},
{ // 218
"Suddenly, all is quiet. You look about the top of the tower to find it clean. Well, almost clean: Scattered about the summit are four egg-shaped pieces of polished alabaster, in beautiful colours. As you pick them, they begin to glow, giving out as much light as ten torches. You may keep them, or sell them for 1000 gp each. For witnessing the incredible events at the tower, take 125 ap. You leave the tower and continue with your journey...go to {168}."
},
{ // 219
"The door is answered by what could be a hobbit, were it not for its bright purple skin. \"Well,\" he asks, \"what does a big, stupid oaf like you want to bother me for?\" The little man defiantly waits for your answer, arms akimbo. If you smash the little beggar with you weapon, see {163}. If you blast him with a spell, see {176}. If you talk with him, see {210}."
},
{ // 220
"The lake monster breaks the boat in half; a deafening crack echoes across the misty lake. You frantically grab for a piece of wood, shucking your armour, ration bag and all but two weapons and two pieces of equipment (a bag of coins counts as a piece of equipment). The monster grabs one of the fishermen and begins to sink beneath the water. You have one chance to attack the monster; if your blow kills it, go to {229}. If you miss, you begin to swim for shore alone. Make two L2-SRs vs. Strength or Constitution (25 - STR or CON); if you make both, you emerge on shore at {334}. If you miss either, turn to {147}."
},
{ // 221
"Make two L1-SRs. The first is made vs. Dexterity (20 - DEX). If you fail it, you cannot hold onto the hand-holes and give up (go to {217}). If you make the first roll, try to make one more on Strength (20 - ST); if you fail this, you fall from 40' up the tower and take 2 dice worth of hits to your CON directly; go to {217}. If you make it up the tower, go to {161}."
},
{ // 222
"Do you really have the bag of the witch's magic powder? If not, you blunder and attack the tree half-cocked...turn to {225}. If you do have the powder, you unwrap it carefully; as it is exposed to the air a freak wind catches it and blows it towards the tree. With a moan and a shudder, the tree and its guardian creatures collapse and lie still.[ You have three turns to gather treasure from the tree...turn to {225} and roll three times on the treasure table. If you grab more items, you must fight the tree as normal.]"
},
{ // 223
"You are resting in a glade in some far-off realm, discussing the adventure business with a griffin. The creature explains that to ensure that the Cult of Krestok or some other evil power don't get their hands on the Phoenix Scroll, the artefact must be retrieved and brought to where no one can use it for evil. \"I am too weak to face the guardian of the scroll alone,\" croaks the griffin, pausing to cough up some blood. \"You must come with me to best it.\" If you take it up on its offer, go to {230}. If you decide to stay here, the griffin shrugs its wings and flies off to the north. Go to {125}."
},
{ // 224
"You travel along the shore of the lake for a day, reaching a small village at nightfall. It's little more than a cluster of rude huts around a wharf, but it has what you're looking for: a few sturdy-looking boats. (Remember to keep track of the number of villages you've been to!) Though there's no real inn, a friendly fisherman who was once a soldier in the King's army takes you in and gives you a hearty meal and advice. Taking out his map of the area, he shows you a route to your goal. \"I'm sure you could get to the temple (though Britmu knows why!) by taking this road into the mountains,\" he tells you, pointing to a path beginning at a town at the north end of Grey Lake. \"The problem is the lake. While the shores are safe, we've lost three boats this year to a horrible beastie that lives on the bottom, out that-a-way.\" If you try to convince the villagers to take you to the head of the lake, turn to {235}. If you'd rather take the land route, go north to {345}."
},
{ // 225
"The tree in the centre of the garden is a monstrous, god-created creature from a distant past epoch. Besides being very alive itself, it is guarded by many dangerous creatures. You may make any number of sorties again the tree, hoping to grab some of the treasure heaped about the trunk. Roll 2 dice and total them for each sortie. The roll represents the monster or monsters you must fight. [Weapons work against the creatures normally; to make a spell stick, you must make saving roll vs. your Luck on the level of the spell. ]If you win, roll on the treasure chart.\n" \
"    Roll    Monster\n" \
"    2       Ogre: A three-eyed, gnarley-limbed ogre with a huge club menaces you. It has an MR of 50.\n" \
"    3-4     Troll: A short, pig-faced bridge troll enthralled by the tree leaps in front of you, squealing in glee. It has an MR of 35, with skin that takes 4 hits.\n" \
"    5-9     Man: An emaciated adventurer sneers at you, eyes glazed and mouth slavering. He has an MR of 12, but carries a shield which takes 4 hits a turn.\n" \
"    10      Wolf: Huge and malformed from the tree's magic, this wolf has wiry metallic fur that takes 6 hits as armour[ and poison fangs...you lose 2 points of Strength the first time it gets hits on you]. It has an MR of 24.\n" \
"    11-12   Limb: One of the limbs of the tree slashes out and strikes you, doing one die of damage directly to your Constitution.[ As you recover from the blow, another creature attacks. Roll again: if another tree limb strikes you, turn to {240}.]\n" \
"(Turn page for Treasure Chart)\n" \
"TREASURE CHART\n" \
"  If you win against a creature, roll on the chart below to determine the treasure you've won. Roll one die:\n" \
"    Roll    Treasure\n" \
"    1       You find a nicely preserved weapon left by the last person to attack the tree. Pick any weapon from the book.\n" \
"    2       You gather a number of gold pieces equal to a roll of 5 dice, times 20.\n" \
"    3       You find gold equal to a roll of 4 dice times 10, plus a number of gems equal to a roll of 2 dice!\n" \
"    4       You find a \"dead\" limb of the tree. It proves to be an ordinaire staff at later inspection! The staff is worth 100 gp.\n" \
"    5       In your haste to grab treasure, you touch a live branch of the tree. Turn to {240}.\n" \
"    6       Roll another die:\n" \
"            1-2: You find a potion which will heal any one curse or disease.\n" \
"            3-4: You find a magician's book! Roll 2 dice, halve the total, and round down to find the level of the spellbook. There are 3 spells in the book at that level. Determine which randomly.\n" \
"            5:   You find a gold cup worth 200 gp. If you roll this again, you find a mithril poniard.\n" \
"            6:   You find a deluxe staff! Roll 3 dice, halve the total and round down to find the level of the magician who used to own it. It has a number of spells equal to twice the level; choose them randomly.\n" \
"When you are done stealing from the tree, leave by turning to {248}. Take 100 ap for finding the tree."
},
{ // 226
"You have trouble finding the cave where the Phoenix Scroll is hidden. You and the griffin spend four days searching before finding an odd little platform or mesa atop a mountain. A tall obelisk stands there; a 50' tall octagonal tower supported by flying buttresses. The pillar is composed of red sandstone, which seems to glow as the sun sets behind the high mountains that surround the mesa. The monolith is incised with runes and symbols and bas-reliefs of mysterious creatures and people dressed in unfamiliar costumes. The griffin shudders and whines as you approach. \"I don't like this place,\" it moans fearfully. \"Let us go, and quickly!\" If you leave now, see {217}. If you wish to investigate, go to {204}."
},
{ // 227
"Your spell reveals a small passageway through the stone. Unfortunately, you'll need more than a detection spell to open it. If you use Bog and Mire or some other blasting-type spell, or cut into the rock with a pick or other cutting magic, turn to {250}. If you'd like to use sheer strength to lift the huge stone slab covering the passage, roll a L2-SR vs. Strength (35 - ST). If you fail the roll, you stamp off frustrated to {248}. If you make the roll, turn to {255} after awarding yourself 50 ap for completing a tremendous feat!"
},
{ // 228
"The guardian ogre staggers to the ledge in front of his cave and tumbles off...you go down to the ledge where he fell to make sure the job is done and find, hidden in the ogre's splintered club, the Phoenix Scroll! The folk who put the ogre here to guard the Scroll placed it in the monster's most prized possession so he wouldn't forget it somewhere. You place the scroll in a roll of cloth and climb back up the scarp to raid the ogre's cave...see {154}."
},
{ // 229
"Soaked and fatigued, you administer the fatal blow. With a gurgling cry, the monster slips beneath the waves. Chalk up 100 ap, plus 75 for each fisherman who survives the battle. If you give the fishermen 100 gp to replace their boat, take another 50 ap. With the help of any surviving fishermen, you make a crude raft and begin to paddle north. After five days (for a total of six days on the lake), you make a landfall at a town far to the north. Please turn to {344}."
},
{ // 230
"The griffin takes off and turns north. For two days you travel over trackless forests and a barren, misty moor studded with barrows and ancient ruins. Finally, your mount lights on a tree blasted by lightning. Nearby is a small hut. \"Perhaps whoever lives there can help us,\" says the griffin. \"You should go first. No telling how the natives will react to me.\" You dismount, climb down the tree and approach the cabin. If you knock first, see {219}. If you hide in some shrubs and wait to see if the inhabitants show themselves, see {201}."
},
{ // 231
"Very good! Give yourself 200 ap for defeating the dragon. Heaped in a niche under the wyrm's decaying corpse are 398 gp, 2417 sp, seven gems, [four jewelled items, ]two staves ordinaire and a rapier that gets doubled dice in combat due to a permanent Vorpal Blade spell worked into its fibre. If you are a fighter, you remember your drill instructor's advice and are able to safely extract two doses of dragon's venom from the beast's poison glands. Go to {107}; do not reenter this room, however."
},
{ // 232: Table A only
"A slightly built man dressed in a blue tunic, stockings and conical hat is sitting on a stump by the side of the path, playing a lively tune on some pipes. He looks up and nods at you as your pass by, then goes back to his music. If you listen for a while, go to {243}. If you interrupt and ask him what he's up to, see {234}. If you draw a weapon and have a whack at him, see {258}. If you blast him with a spell, see {268}."
},
{ // 233
"Leaving the monks' shrine, you continue north. The path winds treacherously around towering peaks and under overhanging ledges of crumbling rock. In several places, the trail crosses rope bridge which sway in the wind that roars continuously through the valleys and passes of the range. Then, after three days of narrow escapes and harrowing danger, the path enters a spear-straight narrow canyon that runs directly north-south. The valley becomes narrower, and the walls vertical and very regular. A chill runs down your spine when you realize that the \"natural\" irregularities in the stone are in fact weathered bas-relief carvings and inscribed runes. The canyon walls seem to be a vast record of some lost civilization! Something makes the hair on the back of your neck stand on end. If you stop to investigate the carvings, turn to {245}. If you continue on your way, turn to {248}."
},
{ // 234: Tables A-C only
"Magicians are subtle and quick to anger. For angering one, you've had a spell cast at you that causes an immense crop of warts and pimples to sprout on your face. Unless you go around with a bag over your head, reduce your Charisma to 4 and get on with your travels."
},
{ // 235
"A good night's sleep and a hearty meal in the old soldier's home heals one-half of any damage you may have suffered. In the morning, you meet with the men of the village to make your request. They demand a payment of 100 gp (to be left at home, for the possible widows) for the use of their best boat. Three men, armed with spears, will accompany you on the boat. If you don't have the money, start walking to {345}. If you give them the money, turn to {199}."
},
{ // 236
"You easily fly over the edge of the valley wall and into a steep-walled, circular area. You suspect it may be an old volcanic crater, or perhaps an ancient sinkhole. The floor of the pocket valley is covered with a carpet of short green grass and many trees. White marble benches and gravel paths complete the garden-like atmosphere. In the centre of this idyllic scene is a huge tree with violently moving limbs. As you come in for a landing a branch lashes out and wraps around your chest! You look down in horror to see that the limb is turning into a huge, poisonous snake! The snake has an MR of 30; its scales take 4 points of damage (as armour). [Your combat roll is halved until the first time you win a combat roll and get a point of damage on the limb-snake. ]Defeating the snake is worth 30 ap. If you live, turn to {255}."
},
{ // 237: Tables A & B only
"Your foe strains his magic power to the limits and really lets you have it. You hear a faint humming noise in your ears, and find it difficult to move. As you watch, your metal weapons and armour turn into useless, tarnished lead and crumbling tin. Your clothing and leather thongs become sheets of muddy, rotting leaves held together with spiderwebs and a paste of rat droppings and monkey bile.\n" \
"  After discarding the mess, you pause to scratch your leg. A painful itch has developed there; it is caused by the first many ulcers, boils and wens which soon cover your body. Your gums begin to bleed; your teeth turn yellow. Arthritis sets in, making your joints ache and giving you shaking fits that make you drop a small glass mirror which mysteriously appeared in your hand. The mirror hits a stone and breaks, scaring the dickens out of the thirteen-toed black cat that was licking one of the festering sores on your ankle.\n" \
"  The humming in your ears rises in tone and intensity, making hearing and thinking difficult. On a hunch, you inspect your sack of rations, and find that the yummy dried meat, cheese and hard biscuits you had there have been transformed into live slugs, earwax and pancakes made of ashes and donkey dung.\n" \
"  The above causes ALL of your attributes to be lowered by 7[, down to a minimum of 1]. The curse is seventh level. (If it is removed, your attributes return to normal but your lost equipment is not restored.) If you wish to leave the adventure now, you may do so, earning 200 ap. [If you carry on, DOUBLE any and all experience awards you receive for carrying on against all odds! ](Return to where you came from, if you wish to continue.)"
},
{ // 238
"When the ogre lands his first hard blow on you, the club splinters as though it was made of balsa wood...which indeed it is. The ogre looks at the broken club stupidly for a minute before resuming the fight. He still has an MR of 60[, but his combat total is halved each turn due to insufficient armament]...when you kill him, see {228}."
},
{ // 239: Table B only
"Oh, my! You've run into a company of enemy soldiers on a raid. Make a L1-SR vs. Charisma (20 - CHR); if you are a warrior, add twice your level; if a rogue or warrior-wizard, add your level to the roll. If you make the roll, the army captain likes you and takes you in. Go to {264} for the battle. If you fail the roll, you are stripped of all your possessions and put to work doing the dirty work around camp. Ten days later, you escape after stealing some food and a poniard. Return to the adventure by turning to {208}."
},
{ // 240
"The tree is a creature made by a now-dead god...a god who died a raving lunatic! By touching a live part of the tree, or getting hit by one of its limbs, your very existence is imperilled! You must fight a Battle of Wills with the creature. Consult {408} for the rules on intellectual combat. The tree has a Mental Integrity of 40; it gets 5 dice and 20 mental combat adds. If has 4 points of \"armour\". If you are killed or disabled by the creature, your body becomes one of its servants. If you disable the tree, you may loot its treasure while it lies helpless...make 10 rolls on the treasure chart in section {225}. Ignore rolls of 5 on the treasure chart. Disabling the tree is worth 200 ap. If you kill the tree, you may also make 10 treasure rolls. You also receive 250 ap, and may carve a piece of the trunk into any one weapon. [This weapon will be unbreakable and be able to hit enchanted creatures. ]Carving it takes three days. When you are done looting and/or carving, turn to {248}."
},
{ // 241
"The fishermen give a feeble cheer when you finish off the creature; after pausing to pick up anyone who was tossed overboard by the monster, you continue north. Take 100 ap for killing the monster, plus 50 ap for each fisherman left alive after the battle. After another day's travel (two total) you arrive at the town at the north end of the lake. Turn to {344}."
},
{ // 242: Table A only
"You succeed in attracting the dragon's attention. The great green-scaled beast swings round and heads back in your direction. He hovers above you menacingly; great buffets of air stir up the dust in the road and whip your hair and clothing about violently. \"SORRY,\" bellow the giant wyrm, \"NO HITCHHIKERS!\" He laughs, sending little bursts of flame down at you. Roll 5 dice; for each die that comes up 2 or 4, that many hits are dealt against you. (If you are fireproof, ignore this damage.) Armour counts at face value only, subtracted from the total. If you live, you may attack the dragon as he soars away (see {343}), or simply continue on your way."
},
{ // 243: Table A only
"You spend about ten minutes listening to the man play. At the end of his performance, he gets up and bows to your applause. \"Thank you,\" he says. \"I just won a large wager with your help, and I'd like to show my appreciation.\" If you have any wounds or diseases, he cures them now. If you are suffering any curses of the fifth level and under, he rids you of those, too. [If you have no malady or bad magic bothering you, the man gives you a wooden branch. \"If you are a mage, you will notice that this a makeshift staff of excellent quality (it will last twice the usual time!). Whether you are or aren't a follower of the art, you may use this stick in your defence; break it in a fight, and the stick will sprout into a fire-snake with a power reflecting your fame.\" (When broken the stick becomes a snake with a Monster Rating equal to twice your Charisma. The fire-snake lasts for 4 combat rounds.) \"Use it in good health!\" ]The man winks at you, then disappears in a flash of blue light. (If you encounter this fellow again, he cures two hits of CON damage but has no other gifts.) (Return to where you came from.)"
},
{ // 244: Table B only
"You share some food with the refugees and let them tell you of their plight. \"The lord of our castle was bewitched by a sorcerer,\" the leader of the band tells you. \"We were told to bring our children to the castle or face death ourselves; we had no choice but to flee!\" You ponder the man's words and wonder how best you can help. For each 10 gp worth of alms you give them, take 10 ap as a bonus. If you travel with them until they reach a safe haven you will get a bonus of 150 ap, plus doubled ap for any foes you slay on the way. (This detour takes a total of eight days. Roll for a definite encounter on Table A each day you travel. The refugees won't help in any battles.) If you go all-out and go to the tower of the ensorcelled lord, you must travel east for four days (turn to {345})."
},
{ // 245
"As you pause to inspect the carvings, you begin to hear sinister howls and shrieks of terror. Anybody with you begins to back away from the towering limestone wall you are examining; they will not participate in what is to come. Inspection of the wall shows that it is covered with untold thousands of slabs of marble and sandstone. One of the pieces of facing is missing, marring a beautifully carved battle scene: the heads of the two opposing generals are on the missing piece. Some hunch tells you that there is something peculiar about this particular stretch of the wall. If you have a plan to get through, write it down and turn to {206}. If you'd rather keep walking, turn to {248}."
},
{ // 246: Table C only
"Roll a L2-SR vs. Charisma (25 - CHR). If you fail it, you are rude enough not to care what people think about you and tear your rations away from the eater; turn to {253}. If you make the roll, you let him eat everything (see {262})."
},
{ // 247: Table A only
"You lead the impostor on, but eventually can't help from resorting to harsh sarcasm. He recognizes your intent and drops his guise: A horrible death's head with eye sockets aflame peers from the horseman's hood! \"Enough foolishness!\" He croaks evilly, \"Come with me or be doomed forever!\" If you follow, the spectre takes you to a tall, dark tower (see {354}). If you draw a dagger and throw it into the face of the apparition before it does any more evil, roll a die: On a roll of 1-4, see {300}. On a 5-6, see {271}."
},
{ // 248
"The remainder of your journey through the valley of runes takes two days. On each of these days, you must roll for an encounter on Table C. Retreat will not be possible in these combats due to the width of the path. If you survive the encounters, you may continue down the valley. At its end, you hear a roar in the distance...the Granite River! You soon find a path leading down to this famous mountain torrent. Turn to {17}."
},
{ // 249: Table B only
"You join the four bandits in the mugging of an old man on a lonely country path. He is easy work, and you soon finish off the man. The bandits thank you, and give you a share of the man's belongings...some food and 50 gp. One of the bandits looks at you oddly. \"Say!\" he says, \"aren't you Olstace the Knikky, the one the boss has been waiting for?\" If you say yes, they bring you to their camp for a feast (see {275}). If you say no, they shrug and leave after stripping the old man of any usable clothing. Deduct 2 points from your Charisma for aiding and abetting criminals!"
},
{ // 250
"As your pick crushes and gouges the stone, the entire wall of the valley begins to rumble. Make a L2-SR vs. Speed (25 - SPD). If you succeed by less than 5 points, you manage to avoid the collapse of the wall...rejoin your friends, if any, at {248}. If you miss the roll, you are buried in the rubble, taking 4 dice worth of hits (armour doesn't count in this case). If you live, you may enter the secret passage revealed by the collapse ({255}), or continue on your way ({248}). If you make the roll by 5 or more, you may escape damage by either rushing up the passage (turn to {255}) or north, up the valley ({248})."
},
{ // 251: Table A only
"A man riding a large black horse gallops towards you. As he gets nearer, you notice his face is covered by a black mask. He is wearing a suit of chainmail; a shield is strapped to his back and a large sword flops in its scabbard against the side of the horse. If you run, see {261}. If you attack now, [you will have two chances to shoot arrows or magic at him before he reaches you (]see {269}[)]. If you wait to see what the fellow is up to, see {290}."
},
{ // 252: Table B only
"A company of soldiers from the army of the King of Myre march by. They look worn and dispirited. You are briefly questioned and let free; the captain explains that raiders have been terrorizing the countryside and he has no time to deal with people who merely seem suspicious. If you volunteer to help the company, go to {281}."
},
{ // 253: Table C only
"You grab the last piece of dried meat and hard tack away from the man, who is now pear-shaped. He looks at you forlornly. \"Ah well, I got something out of you...BURP!\" The creature drops his disguise; a short green-skinned imp with moth antennae for ears appears. He snaps his fingers and vanishes in a puff of smoke. Take 120 ap for getting away with being rude to a fairy lord! You have enough food[ to tide you over to the next place you can buy rations]."
},
{ // 254: Table B only
"The eight pilgrims welcome your aid; the day passes uneventfully. As you prepare to leave them, however, the leader of the group asks you to accompany them to their destination, a shrine high in the mountains which they believe is on your way. They will provide food for you (one is an excellent forager) and will try to get help for your quest at their destination, but have no money. The shrine is four days away. If you accept the offer, roll a die four times; on a roll of 1, roll for an encounter on Table A. If you roll a 2, roll for an encounter on Table C. The pilgrims are all MR 10 humans; they will fight as best they can. If you make it to the shrine with at least one live pilgrim, see {307}."
},
{ // 255
"You are near the western wall of a peculiar little circular valley. A tunnel leads down and to the west into the rock wall surrounding the crater. The floor of the area is covered by a carpet of smooth green grass; a gravel-covered path leads from the tunnel to wind among small, well-tended trees and plots of flowers. There are a few white marble benches as well. The only disturbing note in this pleasant scene: a huge ugly, tree set in the centre of the garden. The tree's stiff, mouldy-looking limbs constantly writhe and quiver. A host of shady figures cluster about the trunk, staring at you with glowing red eyes. If you leave now, you walk back down the tunnel, and turn north, to {248}. If you attack the tree and the creatures around it, turn to {225}. If you have a certain bag of magic powder, turn to {222}."
},
{ // 256: Table A only
"The horseman is dead. Gingerly, you go through his effects. Besides the armour and arms mentioned above, you find a pack is stuffed with food, a bag of 135 gp, and a silk-wrapped poniard [coated ]with dragon's venom. Hanging around the horseman's neck is an amulet studded with three magic gems (worth 300 gp, weighs 1.5#). If you are a wizard or rogue, you sense magic on the amulet; if you can cast an Omnipotent Eye spell on it, turn to {274}.\n" \
"  Take 150 ap for defeating the horseman![ (NOTE: If you killed the horseman at the gate to the dark castle, turn to {334} to continue the adventure...you've ridden too far to find your old trail!)]"
},
{ // 257 (not only WMT)
"The peddler's eyes gleam; his mouth twists into a smile as you advance on him. He flicks his wrist and a long, shining blade flicks out of his walking stick. \"Rolgan the Surgeon was my name when I served under Pargan the Black,\" he tells you. \"I quit his scurvy crew to find some peace...and I'll not let you disturb it!\" The \"peddler\" has these stats:\n" \
"    ST: 15  IQ: 12  DEX: 24  LK: 15  CON: 19  CHR: 17  Adds: 18/30\n" \
"Rolgan fights with a sword cane (3 dice), and wears an arming doublet [and greaves ]for protection[ (3 + 2 = 5, doubled to 10)]. If you kill Rolgan, a search of his pack turns up 25 gp, a lantern and oil, a compass, [pots and pans, ]and a bottle containing curare.\n" \
"  [(If you encounter and fight the peddler again, roll up a new character here, using 4 dice for each attribute.) ](Return to where you came from.)"
},
{ // 258: Table A only
"\"Oh, foo!\" shouts the man in blue. He pockets his pipes and takes a wand from a fold of his cloak. Roll 2 dice for yourself and add your character level; roll 2 for the man and add 5. If the rolls are a tie, or the man rolls higher, see {277}. If you roll higher, you get the first blow. The wizard has 6 points of armour and a CON of 18; on the first round he has a [defensive ]combat roll of 10 (and then only if you attack with a melee weapon; missiles need only penetrate armour). If you kill or disable him in the first round, you find a staff ordinaire, a sax [coated ]with curare, and a set of golden pipes worth 100 gp. If he lives after the first round, see {277}."
},
{ // 259: Table C only
"When you get closer, you see that the camp is not a peaceful caravan at rest. The wagons contain sacks of grain, household goods, fancy carpets, weapons and other booty; the men guarding them are a rabble of disreputable types with beards and dirty clothing. Someone approaches as you enter; if you talk with him, see {275}. If you run, you must make a L1-SR vs. Speed (20 - SPD). If you succeed, you escape; if you fail, you must fight two of the bandits. Each bandit has an MR of 14, and armour that takes 4 hits. If you defeat them, roll again to escape and fight two more bandits if you fail!"
},
{ // 260: Table B only
"The merchant talks with you about local matters, discusses his fears about the coming of a strange new cult to the region, and tells you of a shortcut through the mountains to the north: if a paragraph tells you that a certain number of days are needed to cross an area, you may shave two days off this time once (ie. if a range of hills normally takes five days to cross, you could do it in three. Crossing a region always takes at least one day!) The merchant will restock your ration pouch for 10 gp. (Return to where you came from.)"
},
{ // 261: Table A only
"Run from a man on a horse? Interesting. If you've got a Blow Me To... or Swiftfoot spell, you escape neatly; continue with the adventure. If you aren't blessed with appropriate magic, roll a L2-SR vs. Speed (25 - SPD). If you make the roll, take 25 ap for extraordinary running and continue on your way. If you blow it, you may attack (go to {269}) or ask the horseman what he wants (turn to {290})."
},
{ // 262: Table C only
"The \"poor man\", now as stuffed as a pig before winter solstice, lets out a tremendous burp. He laughs when he notices you glaring at him, empty ration sack in your hand. \"Thank you,\" he says. \"I needed something to tide me over.\" He begins to fade from view[, but not before throwing a charm on you. You now have ten points of Good Fortune. You may use these points to power spells, or to add to the total of saving roll die throws which you would otherwise miss. The points disappear as you use them]. You are also out of food.[ You will be at half Strength until you restock your ration bag!]"
},
{ // 263: Table B only
"The nobleman has four retainers with him; sturdy sergeants on horseback. Fortunately, they are only equipped for hunting! If you begin the fight before talking with the noble, you and the four guards will have two rounds each in which to loose arrows before melee. The rules for missile combat are given at the beginning of the encounter section. If you came here from {273}, you start in melee by default. The guards have an MR of 16, wear 6 points worth of armour, and get an extra 2 dice in combat because they are fighting from horseback. The nobleman has an MR of 24, and wears armour worth 8 points. He too gets an extra 2 dice for fighting on horseback. You may try to run away by rolling a L2-SR vs. Speed (25 - SPD). If you succeed, you get away (though the men will have your description); if you fail, you must continue fighting.\n" \
"  If you kill or disable all five men, you may loot the bodies. The weapons and armour are too identifiable, unfortunately, but you find three random gems and 180 gp in coins amidst the carnage. You earn 100 ap for the feat. If you surrender, or are disabled, go to {306}."
},
{ // 264: Tables B & C only
"The raiders make a number of attacks on farmers, caravans and travellers. In your four days with the raiders, you get some booty: Choose any weapon from the book, and roll 4 dice and multiply times 10 to find how much gold you earn. Alas, soon after one very successful raid you learn that a company of the king's men is nearby. If you turn on the bandits, roll a die: on a 1-2 you are able to sneak away to join the king's men; see {281}. If you fail, or stick with the bandits with hopes of getting further booty, turn to {412}."
},
{ // 265: Table B only
"The farmer tells you that he is a simple man and not wise in the ways of the world, and knows little that could help you. He does, however, know of a pond inhabited by a wise old gnome. \"The gnome's help has brought me good fortune, a veritable flood of riches,\" the farmer tells you. \"Only my spendthrifty nature has prevented me from becoming a baron meself!\" The farmer warns you to beware, however; the gnome is an unrepentant kleptomaniac and steals the possessions of those who seek him. If you ask the farmer to show you the hiding place of the gnome, see {287}. If you leave, continue on your way."
},
{ // 266: Table C only
"Your spell seems to have no effect on the figure! It seems to absorb your magic, and then advances a step towards you. If you wish to run from the figure, go to {301}. If you stand your ground, see {312}."
},
{ // 267: Table C only
"When you get closer, you see that the camp is not a peaceful caravan at rest. The wagons contain sacks of grain, household goods, fancy carpets, weapons and other booty; the men guarding them are a rabble of disreputable types with beards and dirty clothing. Someone approaches as you enter; if you talk with him, see {275}. Or you may choose to leave and go back to the adventure where you left it."
},
{ // 268: Table A only
"\"Damn!\" shouts the man, who quickly pulls a wand out of his sleeve. \"You made me lose a big bet and I'm MAD!\" Roll a die and add your level to it; roll another for the man and add 5 to it. If you come out higher, you get a spell off at him; if your spell kills or disables him (see magic rules), you get his staff ordinaire, a sax [coated ]with curare, and pipes worth 100 gp. Take 50 ap for defeating the mage and continue on your way! If you roll equal or lower than him, the wizard throws a Witless spell at you, making you magically impotent; go to {234} if you leave, {258} if you have at him with weapons. The mage's stats are:\n" \
"    ST: 30  IQ: 18  DEX: 13  LK: 14  CON: 18  CHR: 15\n" \
"He has leather armour and a sax [poisoned ]with curare in addition to his staff ordinaire. If he survives your spelling, go to {277}."
},
{ // 269: Table A only
"If you used magic, write down the spell and see {283}. If you shot missiles, roll to hit and see below for his armour and Constitution. The man has these statistics:\n" \
"    ST: 18  IQ: 14  LK: 19  DEX: 12  CON: 23  CHR: 19  Adds: 13/16\n" \
"The horseman uses a broadsword (3 dice + 4 adds), wears mail (11 hits taken per round), and a knight's shield (takes 5 hits a round). [Unless you are fighting with spells, polearms or a spear, you will be at a disadvantage because of his high position on the horse; make a L2-SR vs. Dexterity (25 - DEX) each round to avoid taking 2 dice of damage (only body armour counts, at face value) due to the horse's kicks or a lucky blow from on high. You may try to unhorse your assailant by making a L2-SR vs. Strength (25 - ST); add your level to the roll if the character is a warrior. If the roll fails, you do no hits that round even if you win; if you succeed, the man is disabled. ]If you kill the horseman, see {256}. If you disable him, tear away his face mask and go to {300}."
},
{ // 270: Table C only
"The man on the pegasus is at 20 yards range; the target is large. He is wearing chainmail, which reduces damage done by arrows, crossbow bolts or other physical weapons by 11. [If you used magic that damages or disables, the spell works; other magics are useless in this situation. ]If you dealt the man at least 18 points of damage via spell or arrow, or disabled him magically, the man falls limp against the neck of his mount; the pegasus whinnies in panic and flies off to the north. You earn 200 ap for this feat. If you miss, fail to penetrate, or do less than 18 points of damage, see {297}."
},
{ // 271: Table A only
"The horseman gets off a dying curse. Roll a die and see below:\n" \
"    1-3: The curse is verbal, not magical. After a moment of embarrassment, you begin to loot the body. See {256}.\n" \
"    4-5: Uh-oh! See {234}, then turn to {256}.\n" \
"    6:   Oh well! See {237}, then turn to {256}."
},
{ // 272: Table B only
"The peddler gives you the bottle of potion and careful instructions on its use. \"This is a distilled spirit,\" he tells you, showing you a label covered with mysterious runes and illuminations, \"famed through the world for its powers. If you are faced with danger beyond you ability to handle, break the bottle against the ground and step back. The spirit will emerge and take on the foe!\" You pay the peddler the 100 gp agreed to and continue on your journey. The spirit works as described; it has an MR of 100, and is resistant to normal weapons, which do only half damage even if the opponent wins the round. The spirit will only fight for you for one combat; it lasts until you flee, are killed yourself, or are victorious. (Return to where you came from.)"
},
{ // 273: Table B only
"The noble and his four horsemen-guards approach. If you are a criminal (ie. you have killed pilgrims or merchants, participated in banditry, or attacked soldiers), make a L1-SR vs. Charisma (20 - CHR). If you MAKE the roll, you are recognized, and the noble takes you into custody (see {306} if you surrender, {263} if you want to fight for your freedom). If you are not a criminal, or are not recognized, the noble greets you. You describe your quest and adventures thus far. \"I am impressed by your bravery,\" he tells you. \"Perhaps I may be of help.\" Roll a die, adding 2 to the roll if you are a warrior. Consult the table below to see how the noble helps you:\n" \
"    1-3: The noble gives you a fine meal cooked by one of his guards. This cures half of any wounds you have and restores you to health if you were starving. However, as a \"favour\", the noble makes you give him a small treasure (any two gems, or one jewelled or magical item) as a gift. If you refuse, or have nothing, the word gets around and you suffer a penalty when dealing with townsmen, nobles or soldiers. (Add a level to any Charisma saving rolls you make until the end of the adventure.)\n" \
"    4-5: The noble takes you on a hunt in the forest. This takes two days, and allows you to stock your ration bag if it is empty. Roll 2 dice, adding your character's level if a warrior or warrior-wizard. The total, multiplied by 5, is the number of ap gained on the hunt.\n" \
"    6+:  The noble asks that you join him on his current mission; he is riding to join the king's army in a campaign against raiders from a neighbouring kingdom. If you join him, see {281}. If you refuse the request, then see the result for 1-3 above."
},
{ // 274: Table A only
"The amulet is a real prize. The first gem casts the Will-o-Wisp spell[ for one hour a day; the second acts as a constantly active Revelation spell. The third gem allows the user to cast a hypnotic spell: The appearance of your face, voice and manner can be taken from those of a person in the victim's past. The spell, which is only usable by rogues and wizards, costs 5 Strength points to activate. It has a range of 15' and lasts 6 turns per casting. For the purposes of this adventure, the gem makes saving rolls vs. Charisma easier; add 10 to the total of such rolls! The amulet also has a protective charm that allows the user a L2-SR vs. Luck to avoid the effects of incoming spells].\n" \
"  Return to {256} and read the last paragraph."
},
{ // 275: Tables B & C only
"The bandits seem to have been expecting you! They think you are a famous rogue from the south who has come to help them take on the local army. Roll a die, adding 2 if you are a rogue, 1 if you are a wizard:\n" \
"    1-3: You are soon found out by the bandits, and must escape by night before you are confronted by the leader...see {285}.\n" \
"    4-6: You are able to pass yourself off as the missing rogue for four days, and take a share of the bandit's booty! Take any five pieces of equipment from the book and 200 gp. The rogue you are impersonating soon shows up, however, and you must fight him before he spills the beans. He has an MR of 40[; on each round, roll a die:\n" \
"         1-3: Fight normally.\n" \
"         4-5: He shoots a 13-point Take That You Fiend at you.\n" \
"         6:   See {234}.\n" \
"         If you live, take 200 ap for a good show].\n" \
"    7-8: Through judicious use of magic and weapons, you are able to pass yourself off as the rogue for twelve days. You get 5 dice times 10 gp, four gems, a second level spell (your choice[, in a book so you keep it till you can use it]), and all the food you can carry. You may stay on, by going to {264}, or leave before trouble happens."
},
{ // 276: Table D only
"The warriors, armed with bronze swords etched with green tarnish, look at you solemnly. \"It is not pleasant to talk with unbelievers,\" says the leader, a tall man with a long black beard. \"Their breath, like that of the swine, is not sweetened with the wisdom of Krestok.\" The warriors continue on their way. If you follow them, see {305}. If you attack them, turn to {299}."
},
{ // 277: Table A only
"Do not trouble wizards, for they are subtle and quick to anger! Roll a die[, adding 2 to the roll if you put hits on the mage]:\n" \
"    1-3: He hits you with a level 5 curse that reduces your Luck by 5.\n" \
"    4-5: He hits you with a level 5 curse that reduces your Strength by 5.\n" \
"    6:   Turn to {237}.\n" \
"The magician disappears after you get over the initial shock of the curse."
},
{ // 278: Table C only
"The man on the toad listens to your introduction, then sighs in boredom. \"It is a wonder,\" he observes, \"that one such as you does not find standing erect difficult. Do the rocks in your head not make getting up in the morning a chore?\" He snaps his fingers and grabs hold of the toad's reins, which seem to be made of spiderwebs. If you let the rude man leave, continue with the adventure. If you attack him, see {291}. If you have a special plan, write it down and see {316}."
},
{ // 279: Table A only
"You pull out a jug of wine from your pack and pour a bit for the old man. You ask him how your fellow students are doing. Oddly, he can't seem to remember. In fact, he seems to have forgotten your name! You suddenly remember that your old master died shortly after you began adventuring! Whoever this impostor is, he's up to no good! If you run while you can, see {234}. If you try to get him angry and make him slip up, see {247}. If you attack the impostor now, see {269}."
},
{ // 280 (not only WMT)
"You approach the wagon, wondering how best to take it. If you are a warrior, you may try to ambush the wagon. This requires a successful L1-SR vs. Intelligence (20 - IQ). Add your level to your IQ for this roll only to reflect experience gained through the years. If you make the roll, you leap into the wagon from a convenient tree; see below for the merchant's attributes and tactics. If you blow the roll, or are not a warrior, you must make a headlong rush to catch up to the wagon. This requires a L1-SR vs. Speed (20 - SPD). If you miss, the wagon trundles off into the distance. If you make it, you land in the back of the wagon after a final leap.\n" \
"  As you land in the wagon, the merchant whips his horses to greater speed and turns around to meet you, bearing a large cudgel. The merchant has an MR of 18, and wears a padded jerkin that takes 3 points of damage a round. At the end of each round, you must make a saving roll to avoid tumbling off the speeding wagon. The roll is made at first level (20 - DEX)[ if you won the combat round, second level (25 - DEX) if you lost]. If you ever fail the roll, you fall off the wagon and must take 8 hits directly off Constitution. The merchant will get away in such a case[, spreading your description to all of his fellows so none will deal with you again]!\n" \
"  If you defeat the merchant, he falls off the speeding cart to a quick death. If you came here from {90}, you may take the cart and proceed with your plan...otherwise, the cart turns over and the horses run off, whinnying in fear. In the cart you find some dried meat and biscuits (you may restock your ration bag if it was emptied by some untoward event), 200' of rope, a case of 24 arrows, and a set of fine clothing.[ This noble garb will add 2 to your Charisma when worn. It will last until your next combat or the end of the adventure, whichever comes first.]"
},
{ // 281: Tables B & C only
"The soldiers find a party of raiders two days later. Things go badly at first, but you see an opening and rush forwards to attack the bandit leader. There are two guards with him, and many enemy archers on all sides. The leader has an MR of 24 and armour of 8; the two guards have MRs of 14 but no armour. On each turn that you fight them, roll a die; if a 1, 2 or 3 comes up, that many arrows hit you. The bolts do 3 dice of damage each, minus armour protection. If you survive and kill the bandit leader, you are given your choice of the bandits' booty (take any five items from the list of equipment, arms or armour in the book), and a bag of 250 gp and five gems. Take 200 ap for heroism and choosing the right side!\n" \
"  Your brief stint in the army has taken you far from your original path. To continue the adventure, turn to {344}."
},
{ // 282: Table C only
"You climb a ridge and see, nestled in a grove of trees, a crowded campsite. There are many armed men about, and quite a few horses, but the place looks more like a merchant's camp than a bandits' retreat. If you wait until night to make sure, see {285}. If you approach now, see {259} if you do so openly, {267} if you sneak in."
},
{ // 283: Table A only
"Your target has some magical protection[! For each spell you cast], roll 2 dice (doubles add and roll over): if the total is over 8, the spell fails. If you cast Mind Pox, Witless, Dreamweaver, or any other spell which disables the man, see {300}. If you are still in combat with him, go back to {269} and continue fighting.[ Remember to roll each time you cast magic.]"
},
{ // 284: Table C only
"The ghostly figure raises its arms to the sky in a dramatic gesture. All is quiet but for a slight breeze which stirs the grass about your feet. Suddenly, an enraged basso-profundo voice echoes through your mind: \"GET OWWWWTTTTT!\" If you make tracks, go to {301}. If you stand your ground, see {312}."
},
{ // 285: Tables B & C only
"You sneak about the camp at night, finding carts and wagons full of stolen goods and wine-sodden bandits resting up for another raid. Make a L1-SR vs. Luck (20 - LK), adding 5 to your roll if you have the Concealing Cloak spell, invisibility or hide-in-shadows powers, or are a sneaky rogue. If you make the roll, you get away with a bag of gold (roll 5 dice and multiply by 10 for the amount), all the food you can carry, and one weapon chosen from the book. You also free a captive; the daughter of a local baron.\n" \
"  If you fail the roll, a muscular bandit sees you and attacks. He has an MR of 20, and uses a shield for 6 points of protection. [You may try to run at any time, but you must stay at least four rounds to get the booty mentioned above. ]The bandit shouts for his friends after the second round; an MR 14 bandit shows up on a roll of 1-2 on one die each round after that.\n" \
"  If you survive your trip into the bandits' camp, you may continue with your adventure, or return the young noblewoman to her father (see {368})."
},
{ // 286: Table B only
"You draw your weapon (or begin mumbling the power-syllables of your spell) and rush to the aid of the man in trouble. The muggers are four swarthy-looking men with clubs and daggers; they give their victim a last bop on the head and face you. Each has an MR of 12, but fight dirty. Each combat round, make a L1-SR vs. Luck (20 - LK) to avoid taking hits due to sneak knife tosses and sand thrown in your face. If you fail the roll, take hits equal to the amount you missed by. If you defeat the bandits, see {309}."
},
{ // 287: Table B only
"The farmer shows you the pond, and suggests you bury your valuables so the gnome will not steal them. You wait for the farmer to leave, then find a place where the soil is loose and digging easy. Goods concealed, you head back to the pond just as the sun is setting. Silhouetted against the darkening sky, you see a figure with a pointed cap and long nose. It seems to be sitting on a log in the water, holding very still. If you run up and grab the gnome, see {310}. If you wait a while longer, see {320}. If you clear your throat and approach the fairy creature quietly, see {333}."
},
{ // 288: Table D only
"Within the black robes you find a white-haired old man, holding a wand and wearing tough leather armour. His purse contains 118 gp and five random gems. His dagger is a sax with a spell on it[ that will last the rest of the day]. The cantrip doubles the weapon's combat dice and adds. If you take the magician's wand (a length of hard material in the shape of a crow's leg; an amber gem is grasped in the talons), see {324}."
},
{ // 289: Table B only
"The refugees scream and scatter as you race towards them, weapon drawn. You cut down two and knock one to the ground, an old man with a cane. You search the packs you've found and find 12 pieces of copper, 5 silver coins and a single gold piece. There are a set of spikes and pitons, however, and a 50' roll of hemp rope. You are about to leave the scene when you see the old man trying to hide something; an old medallion, encrusted with opals and amber. The old man groans as you tear it away from him. \"Please!\" he moans. \"It's an heirloom, no good to you! It...it has a curse on it!\" If you take the amulet anyway, see {237}."
},
{ // 290: Table A only
"The horseman stops a few yards from you and tears off his mask. You gasp in astonishment when you see it is your old mentor from (magic school, the academy, the Crooksborough school of hard knocks...). \"At last, I've found you!\" He cries, \"We've been looking for you; thousands of crazed, green-cloaked fanatics are raiding a nearby town and you must help!\" If you ask your old master how you can help, go to {295}. If you'd rather go about your way, see {234}."
},
{ // 291: Table C only
"The man's (?) eyes glow red as his face twists into a mask of petulant anger. \"OHHHHhhhh!\" he cries. \"Foolish mortal insect! No one sets his hand on a noble of Faerie and forgets the insult!\" Quick as a flash, he draws his weapon (a tiny whip of weasel skin) from his belt in response to your threat. On each round of combat, the whip will either do 7 dice in combat, or be used to flick spells back at you. The toad rider has these statistics:\n" \
"    ST: 12  IQ: 30  LK: 20  DX: 18  CON: 20  CHR: 9  Adds: 14/20\n" \
"To flick spells, the faerie knight must first succeed in a first level saving roll vs. Dexterity (a roll of 5 or more). If the roll is over 9, the spell is not only deflected, but strikes you on the rebound!\n" \
"  If you are disabled, or get hit with a deflected spell that knocks you dizzy (Witless, Mind Pox, Dreamweaver, etc.), the nasty sprite approaches you, sneering...see {336}. If you disable or otherwise defeat alive the impertinent toad-rider, go in triumph to {348}. If you kill the weirdling, see {355}."
},
{ // 292: Tables B & D only
"The pilgrims smile nastily, and bring daggers and clubs out from under their robes. Each has an MR of but 12, but four have daggers with poison: on each turn, roll 4 dice, one for each cultist with a dagger. For each die that comes up 1 or 2, take that many hits directly off your Strength to account for the effects of small nicks and scratches by the daggers. If you are disabled (Constitution or Strength under 6), see {305}. If you kill the cultists, you may keep the daggers (four poniards with curare), the cultists' food (restock your ration bag), and the leader's key, a mysterious-looking triangular piece of grey metal. Chalk up 18 ap for each cultist you kill, even if you must flee."
},
{ // 293: Table B only
"The pilgrims shout and begin to run; the oldest shouts something, however, and they stop and charge you. Staves waving, they surround you and begin pounding. Each of the eight pilgrims has an MR of 10. \"Bandit!\"...\"Non-believer!\" they shout, poking walking sticks into your ear and stomach as you try to get in a position to defend yourself. You may run at any time, losing 4 points of your Charisma as a penalty for foolishness and cowardice, fight them to the finish (see {317}), or shout for mercy and offer to protect them as compensation for your assault (go to {254}, but you must go to the shrine with them.)"
},
{ // 294: Table D only
"The whirlwind descends on you, tugging at your clothing, hair and armour. Sand and grit propelled by the wind gets in your eyes as you futilely wave your weapon about. You sense that the vaporous demon cannot be fought by mere matter; you must deal with the creature via a Battle of Wills or be torn to pieces! Keep your place here and look at {408} to find the rules for Battles of Will. The whirlwind gets 4 dice and 4 adds in mental combat; it is a Mental Integrity of 10. If you are disabled but not beaten in the mental combat, the whirlwind sucks you into the air and deposits you at the temple of Krestok, in the dungeon! Go to {112} if this fate befalls you. If you destroy the whirlwind's Mental Integrity, give yourself 50 ap. Further encounters with the whirlwind may be ignored. If you merely disable the demon, it flees; you get the adventure points but it will return if rolled again."
},
{ // 295: Table A only
"Your mentor lets you ride behind him on his horse, explaining your mission along the way. \"The evil Baron Ulkara has a valuable book in his possession. You must steal it so that he can do no mischief with the magic the book controls,\" he tells you. \"It is a risky assignment, but we know you are the right one for the job.\" If you ask him what this has to do with the cult of Krestok, turn to {279}. If you continue your ride quietly, turn to {304}."
},
{ // 296: Table C only
"The flier continues on his way, ignoring you! Breathe a sigh of relief and continue the adventure. (Return to where you came from.)"
},
{ // 297: Table C only
"You have wounded a mighty elf captain on an important mission. Enraged, he swoops around to engage you. You have one more chance (at near range) to hit the pegasus rider. On the first round of melee, his combat roll is doubled because of the force of his aerial charge. These are the elf's stats:\n" \
"    ST: 17  IQ: 16  LK: 13  DX: 21  CN: 14  CH: 25  Adds: 15/24\n" \
"The elf wears chainmail (11 hits) and wields an enchanted hand-and-a-half sword (5 dice; can hit enchanted creatures normally immune to weapons. The sword glows blue near evil creatures or magic.) The winged horse contributes 3 dice of kicks and buffets; it has 21 hits. If you kill the pegasus first, see {319}. If you kill the warrior, see {329}. If you are disabled, the elf ties you up and drops you off at the nearest town (turn to {306})."
},
{ // 298: Table C only
"The snake is about 10' wide and a good 500' long. You make a testing blow to the massive belly scutes, and have as much effect as a feather hitting a cathedral's buttresses. After a few more futile blows, you look up to see the snake's boat-sized head above you. It regards you for a long moment before clearing its throat. \"If you wanted me to move,\" it scolds in a deep hissing voice, \"you should have asked politely in the first place.\" It begins to shift position slowly. After fifteen minutes, the serpent makes an arch high enough for you to walk through. You quickly pass under it, knowing better than to look a gift horse in the mouth."
},
{ // 299: Table D only
"The warrior-mystics begin to chant; flashes of light play upon their bronze swords and the sky seems to grow dark. You have one chance to shoot a missile weapon or spell at the warriors; you find, however, that magic has only half effect: damage done or number of people affected is halved. By the time you reach melee, you notice the sky has become black as on an overcast night; the mystics have stopped chanting but strange sonorous voices continue to sing in your mind. Prepare to fight: each warrior has an MR of 24, and 4 points of armour. By skilfully dodging, you manage to keep all but three of the mysterious warriors out of striking range. If you are disabled, see {305}. If you kill all of them, you find no treasure among the bodies but salvage a green robe, a temple key and one of the bronze swords (a bronze gladius, enchanted[ to act as a kris blade. Your own spellcasting will be affected by the charm on the blade]). Each warrior-mystic killed is worth 30 ap."
},
{ // 300: Table A only
"The horseman tumbles off his horse, stricken. You strip off his mask to find his face shifting, changing to resemble relatives, friends and enemies, strangers, even animals. Disgusted at his trickery, you slap him viciously. His features settle down into those of a cruel, swarthy man with a greasy beard. \"PAH!\" he cries. \"I should have knocked your head off when I first saw you. The Master can find his own victims! Let me go for I really let you have it!\" The man spits at you and tries to struggle to his feet. Take 100 ap for defeating him. If you let him go, he totters off moaning. If you strike him dead, turn to {271}."
},
{ // 301: Table C only
"You run from the spectre, screaming and waving your arms frantically. Anyone with you can't keep up and is lost. It takes you an extra day to find the path again. Take 25 ap for quick thinking and quicker running...and return to where you came from."
},
{ // 302: Table D only
"The dancers, though unarmed, know how to defend themselves! Each is a skilled acrobat as well as a dancer. Each has a Monster Rating of 12. Fight them normally, but at the end of each lost round note by how much they beat your roll and adds by. If over 10, you are buffeted about and disarmed; on the next round you may pick up the weapon (taking 2 dice of hits, minus basic body armour) or continue the fight bare-handed. If they ever beat your total by 20 or more, the dancers skilfully wrap you up in a length of green ribbon. Trussed up like a turkey, they carry you to a deserted town in a forsaken wilderness (go to {305}).\n" \
"  If you kill or disable them all, you may loot the bodies. Besides enough food to restock your ration bag, each has a bag of silver coins equal in number to 10 rolls of the dice."
},
{ // 303: Table D only
"The figure clears its throat. \"Thank you,\" it says. \"You have been of help.\" It extends a hand encased in a black glove. If you shake, see {338}. If you refuse, see {321}."
},
{ // 304: Table A only
"You and your mentor ride for two days, riding through dense forests and sparsely settled plains in an easterly direction. At long last, your mentor leaves you off in front of a tall tower. A single window is lit, high up in the structure; you see none of the signs of the evil armies and teams of slaves that your mentor told you of. As you stare at the tower in puzzlement, your mentor prepares to leave. \"Good luck,\" he tells you. \"You'll need it.\" His tone of voice seems a bit strange. If you ask your mentor to tell you more of the mission over dinner, see {279}. If you face him down in a rude manner, see {247}. If you go inside, see {354}."
},
{ // 305: Tables B & D only
"You are a captive of the cult of Krestok. Wrapped in green silk rope and drugged to prevent you from casting spells, you are brought to an abandoned tower under cover of darkness. You regain consciousness as your captors are setting up a makeshift torture chamber. You notice a fellow captive; a young noblewoman. You steel yourself for a horrible death when an alarmed cultist, disguised as an ordinary shepherd, runs into the basement room. \"Soldiers!\" he cries. \"We must flee!\" The leader of the villainous band shouts orders; you are apparently forgotten in the rush. The cultists leave after carefully snuffing out the fire.\n" \
"  Roll a die: On a roll of 1 or 2, your captors return and take you to their sulphur mine in the mountains (see {330}); the young woman is never seen again. If the roll was more than 3, soldiers under the command of the brave king of Myre rescue you and the lady from the dungeon. As your original path now lies far off, you decide after consultation to take a route around the mountains and approach the temple from the east. If you go directly to the temple, turn to {334}. If you return the noblewoman to her father (a local baron), you must make a slight detour; follow the instructions in {368} then go to {334}."
},
{ // 306: Tables A-C only
"You are imprisoned in a small tower belonging to a powerful baron of Myre, accused of banditry and perhaps spying. Roll a die, adding 2 to the roll if your Charisma is over 13, adding one if you are a wizard or warrior-wizard:\n" \
"    1-3: Go to {315}.\n"
"    4-6: Go to {325}.\n" \
"    7+:  Go to {335}."
},
{ // 307: Table B only
"The pilgrims' shrine is a pleasant place, and you are rewarded for your dedication in helping the faith's followers. You are provided with the services of a healer (cures 5 points of CON damage), given free meals and a room for your two-day stay, and receive a supply of trail food. Before you leave, the monks in charge of the shrine give you a boon; a charm which will allow you to fool an evil person once. (You may, before making a saving roll vs. Charisma in the Krestok temple, elect to use this boon. If you do, the roll is automatically won. The boon is good only once and only against evil persons.) When you've recorded this information, continue on your journey. Turn to {216} to continue; you are too far from your old trail to go back."
},
{ // 308: Table C only
"The dragon looks back and sees you grovelling. He makes an immelmann and dives, landing in a swirl of dust and sulphurous smoke not ten yards away. \"MY!\" shouts the great beast, knocking down a few saplings and setting a bush on fire with the force of his exclamation. \"A WORSHIPPER! DID YOU WANT...A LIFT?\" If you meekly nod assent, the wyrm gives you a lift. Go to {112}. If you refuse, the dragon is insulted and prepares to torch you. You have one chance to loose a spell or missile weapon at the wyrm before it closes to melee. The dragon has an MR of 120; his scales take 8 hits. If you are disabled, the dragon remembers his orders about the disposal of stray travellers and flies you to his headquarters; see {112}. If you beat the dragon, chalk up 200 ap and add 2 to your Charisma for having a set of dragon's ears to show off!"
},
{ // 309: Table B only
"You wipe the blood from your blade and turn to the bandit's elderly victim. \"Thank you,\" he says in a weak voice. \"In better times I would be able to reward you richly, but I now have nothing more for you than this bag of magic beans.\" He sighs and gives them to you, then walks east mumbling something about the good old days when he killed giants and dealt in livestock.[ Though you won't be able to use them in this adventure, you eventually find out that the beans grow into magic plants that sprout gourmet fare: each plant yields one meal per day. There are five beans in the sack. You may start each campaign month or solo dungeon trip with two units of free provisions for each plant that you keep.]"
},
{ // 310: Table B only
"You rush forwards, leap into the pond, and grab the gnome. Or, more properly, what seemed to be the gnome. You find yourself holding a chunk of rotting wood covered with moss and weeds; it does indeed resemble a gnome when seen in the light of the moon. You chuckle at the foolishness of peasants and go to where your belongings were buried. There, you see the farmer gloating over your gems and coins and equipment. He sees you, gives a horrified gasp, and runs away with your ration bag and a handful (25 gp) of gold [and silver ]coins. You try in vain to find the farm. Give yourself 25 ap for learning a valuable lesson and continue on your way."
},
{ // 311: Table B only
"You have found a trading post, a well-stocked way station where caravans stop to rest and buy the goods of local farmers. The local folk seem less than normally hospitable, and the visiting travellers whisper nervously to each other. Tales of strange beasts and rumours of fanatical cultists have put the good folk of the land in a suspicious mood. Some equipment is available (roll 1-3 for a particular weapon or piece of armour or item to be in stock), but prices are doubled. You can restock an empty ration bag for 20 gp. If you leave on your own, go back to the paragraph that led you here. If you wish to seek employment in a caravan, see the first entry on Table B of the Encounter Chart."
},
{ // 312: Table C only
"You are in a Battle of Wills with a powerful witch-spirit. Rules for mental combats are given in {408}; consult these rules after marking your place here. The spirit has a Mental Integrity of 20; it gets 3 dice and 10 adds in mental combat. If you lose the battle, or are disabled, your spirit is consumed and your emptied body used for evil deeds. If you destroy or disable the spirit, see {322}."
},
{ // 313: Table D only
"The whirlwind descends on you, tugging at your clothing and hair. You realize that if you do not act, it will tear you to pieces. If you try to engage it in a Battle of Wills, see {294}. If you have the Strength, you can let it have it with Take That You Fiend or Panic spells. The whirlwind has a \"Constitution\" of 50 points, but is resistant to magic. Each time you throw a spell, you must make a L1-SR vs. Luck (20 - LK) to successfully hit the extra-dimensional creature. If you hit, Take That You Fiend will do full damage, Panic will drive it away if powerful enough. At the end of each round you are in combat with the creature, roll a die to find the number of hits done directly to your Constitution as a result of the whirlwind's tugs and tearings. If you destroy the creature with magic, take 100 ap."
},
{ // 314: Table C only
"The misty figure seems entirely unaffected by your weapons! It seems to stare at you balefully as you back away in shock and horror, then swiftly raises its arm and points a bony finger at you. A teeny bolt of blackish-green lightning strikes you square in your forehead; though it hurts not a bit you feel a scream ripped from your throat. Several grey hairs sprout from your scalp and you come close to fouling your armour. Your Luck has been reduced by 2. If you run now, continue with the adventure. If you zap the apparition with a spell, turn to {266}. If you wait to see what it does, go to {284}."
},
{ // 315: Tables A-C only
"Oh, my! You are sentenced to die by hanging. Any magic powers you have are nullified by the baron's wizard; a troop of armed guards and archers line the way to the gallows. After some jeering and fruit-throwing, the crowd settles down for a final reading of the charges and sentence. A hood is put on your head, the floor drops out from beneath you, and all goes dark. Your body is dumped into the river for the fishes; if you are an immortal you wake up far downstream, too far from Myre to continue this adventure. Close the book."
},
{ // 316: Table C only
"Do you have a plan written down? If not, the faerie knight stares at you with a bored expression on his sharp-featured face as you run around in uncoordinated circles, babbling incoherently. After a moment the man spurs his mount; the toad spits a gob of stinking black slime right into your face. By the time you wipe the mess off, the toad-rider is a league away. See {234} for the effects of the spit.\n" \
"  If you DID have a plan, compare it to the two below. If it matches one of them, follow the directions. If it didn't, the man rides away in alarm...take 25 ap for at least trying!\n" \
"  * Steal the man's hat: Faerie folk often have a strong attachment to their headgear. You've remembered this and make a lunge for his cap. To get it you must ace a L2-SR vs. Dexterity or Luck (25 - DEX or LK), whichever is better for you. If you make it, see {327}. If you blow it, see {234}.\n" \
"  * Challenge the man to a riddle contest: This is tricky, but possible. Roll a L2-SR vs. Intelligence (25 - IQ). You may add your level to your IQ for the purpose of this roll. Add another 2 if your character is a hobbit, fairy, leprechaun, or rogue of any sort. If you blow the roll, you incur the wrath of the petulant creature...see {348}. If you make the SR, you come up with a riddle which stuns the faerie knight. After a moment, your adversary thinks up one in return:\n" \
"    \"In backwards lands, I am celebrated\n" \
"    at the beginning, a holiday,\n" \
"    thou might say in other words.\n" \
"    Here, I am less, I am, truly!\"\n" \
"Write down your answer, then see {359}."
},
{ // 317: Table B only
"The god being honoured by the pilgrims' voyage happens to be watching and sees your unprovoked attack. A bolt of lightning strikes the earth 1' behind you as you loot the bodies. Take 4 hits directly off Constitution, and reduce your Luck to 3. If you continue your quest under this onus, the angered god will take pity: change the attribute to half normal level instead; if you leave the adventure now, or kill ANY pilgrims of ANY sort during the remainder, your Luck will again drop to 3."
},
{ // 318: Tables B & D only
"You are facing eight pilgrims journeying to the temple of Krestok. The devotees of the cult are not evil, but they are persistent. You talk to four of them while the others continue, listening earnestly to their passionate catechism. After hearing more about Krestok and his teachings than any sane person would wish to know, you get a chance to put a word in edgewise. If you wish, you can try talking them into taking you to their temple; roll a L2-SR vs. Charisma (25 - CHR) to try. If you make the roll, you spend twenty days on the road with the cultists; [roll four times for an encounter on Table A if you ]travel [with them. (If you engage in combat, they will hide behind bushes and thank you heartily afterward.) After rolling for the encounters and resolving battles, go ]to {17}.\n" \
"  If you missed the saving roll by 5 or less, turn to {292}. If you missed by more than 5, see {305}."
},
{ // 319: Table C only
"As you strike the blow that kills the pegasus, the elf warrior gives a mighty cry. He leaps from the dying horse and faces you, eyes glowing with rage. The elf attacks with renewed vigour[, ignoring magical effects and attacks for the rest of the combat]. Continue the battle[; the elf is now fighting berserkly]. If you win, turn to {329} and read the second paragraph."
},
{ // 320: Table B only
"You wait for quite a while, and gradually come to realize that the \"gnome\" you've been wasting your time on is just an old mossy log standing in the water! You fume and shake your fists, damning the stupidity of superstitious peasants. When you get back to where your belongings were buried, you discover that the farmer has been there already, and he has stolen your ration bag and all your gold. You try in vain to find the farm. Give yourself 25 ap for learning a valuable lesson, and continue on your way."
},
{ // 321: Table D only
"The mysterious stranger clenches its fists in anger and growls menacingly; you seem to catch a glimpse of fiery red eyes peeping out of the figure's hood. \"YOU WILL KNOW MY WRATTHHHH!\" it screams, plunging a hand into its robes. Before you can tackle the wight, it brings forth a horrid talisman made from the bones of young goats and otters' eyeballs. You must act quickly; only a weapon or combat spell will stop him from doing you dire harm! Roll 2 dice for yourself, adding your level. Roll 2 for the figure and add 4. If you roll equal or higher than the spectre, you may swing your weapon or cast a quick spell. The creature has 12 points of armour, and a Constitution of 25. If you reduce your foe's Constitution to 5 or less, see {288}. If you fail the roll, or didn't get enough hits to slay or cripple the wight, you are hit with a crackling ball of magical fire (a Blasting Power spell with 5 dice of power); the figure walks away chuckling from your corpse or near-dead body. If you live, continue with the adventure."
},
{ // 322: Table C only
"You have vanquished a powerful spirit with the force of your will! A tremendous feeling of power fills you; any curses on you are lifted by the backwash. If you disabled the spirit, it cowers before you[ and offers you a piece of its power]. [You now have 10 points of bonus Strength chalked up in a cosmic account; you may use these points to power spells or give you extra adds. They burn up and are gone once used. ]If you utterly destroyed the spirit, take 50 ap[ instead]. (Return to where you came from.)"
},
{ // 323
"Roll to hit: you are at pointblank range. The baron is wearing leather armour (worth 6 points in combat). If your weapon or spell did less than 18 hits after armour, see {376}. If you did 18 points or more, the baron dies. His accomplice cries out in fear and stumbles backwards into a bank of strange metallic machinery. They spark and sizzle, sending deadly magic into the body of the villain; he turns into a charred skeleton as you watch in horror. The machinery survives, however, and roars into full life. If you watch, enraptured, at what follows, go to {396}. If you rush forwards to demolish the machine, see {386}."
},
{ // 324: Table D only
"You grasp the wand and begin to stick it in your pack. Halfway through the motion, however, you find yourself paralyzed as tendrils of alien thought invade your mind. You must battle the spirit of the wand, a deluxe staff, or be taken over and used as a tool of evil! Turn to {408} for rules on mental battles; that paragraph will give you details on how to find your own intellectual combat strengths. The wand gets 7 dice and 7 adds in this sort of combat and has 10 points of Mental Integrity. If you are defeated by the staff, you will be used as its tool, defeating enemies of Krestok until a stronger vehicle comes by. If you totally destroy the staff (Mental Integrity reduced to zero or less), it will blow up, doing 4 hits to you but giving you 200 ap. If you disable the wand's spirit, you may keep it[ (if you are a wizard)], learn spells from it[ (if you are a rogue)], or sell it ([if you are a warrior; ]it is worth 6000 gp).\n" \
"  The staff has all first and second level spells, and a good number from higher levels. (Roll a die for each spell on levels 3 to 7). On a roll of 6, the spell is in the wand. [Rogues may learn a number of spells equal to their Luck. ]The Dexterity and Intelligence requirements MUST be met to learn a spell, however; no \"saving up\" spells for later use is allowed!). [Trained wizards may also use the staff's spirit to power their own spells; it has a Strength of 10 which regenerates and is expended as the magician's own. If reduced to zero Strength the spirit dies, however. ]Continue with your adventure."
},
{ // 325: Tables A-C only
"Through magic or charm or both, you manage to get out of jail. Roll 2 dice for the number of days spent in the dungeon; your Constitution will be reduced by half this number due to poor diet and filthy conditions. You manage to grab some clothing, a club, and [two days' worth of ]food, but are otherwise unarmed. You beat a hasty retreat north; go to {62}."
},
{ // 326
"During the night, the Baron and Mortol come to your room and view your slumbering form. \"The spleen on our specimen is no good. We must take a fresh one from this insect!\" whispers the man in white. \"And we'll have none of your 'chivalry' mucking up our effort!\" The Baron nods dumbly and trusses you up in your blankets. You never regain consciousness."
},
{ // 327: Table C only
"After lulling the vain creature with a bit of obsequious malarky, you snatch the hat from the faerie toad-rider. The knight immediately falls into a fit of rage, threatening to hit you with his little whip of weasel skin. \"Give it back! Give it BACK,\" he cries, trembling in anger. \"Foolish mortals mustn't fool with such things! GIVE IT BACK!!\" You have better sense than to comply, and calmly parley with the enraged sprite. Eventually, he gives you a scrap of paper with a charm written on it. \"Read it[ once a day]. If you do so[ faithfully, on the rise of the sun], you will not suffer from curses[ for more than two days].\" You inspect the paper to make sure it is readable; when you look up, the toad-rider is gone. The charm works; any [new ]curses you acquire will fade[ after two days]. If you meet the faerie again, he will flee in embarrassment and fear."
},
{ // 328
"The guard, afraid of the things that have been lurking around the keep of late, is carrying a loaded crossbow. If you do not have a missile weapon yourself, he gets a shot off at you; the bolt hits on a roll of 8 or better on two dice, and does 4 dice + 5 adds. If you have a bow or sling, or wish to toss a combat spell, roll a die and add your level. Roll another die and add 1. If the first roll is higher, you get off a spell or shot first; if the second roll is higher, he does. If the guard survives, he shoots the crossbow and then closes to melee. He has an MR of 14 and 10 points of armour. If you survive, see {332}."
},
{ // 329: Table C only
"As you strike the final blow, the pegasus cries in fear and rage and launches itself into the sky; it moves too fast for you to even consider catching it.\n" \
"  Upon inspection, you find the elf was carrying several pieces of waybread (restock your ration bag), a bag of herbs (a tea which will remove any [one ]curse), and seven mithril rings (worth 150 gp each). You also find a triangular piece of silvery-grey metal...a key to the Cult of Krestok temple. You realize with sadness that the elf warrior was probably on the same mission you were. Deduct a point from your Charisma to reflect your intense guilt feelings about this dastardly crime!"
},
{ // 330 (not only WMT)
"You are a captive in the Krestok sulphur mine. It is a miserable, unhealthy place to work. Begin counting off the days. On each day, roll two dice.\n" \
"    2:       You become temporarily blind. You can't escape or leave via the mine for seven days.\n" \
"    3-5,7-9: Working in a sulphur mine is a miserable, boring existence. Nothing of note happened today.\n" \
"    6:       You are taken to the temple dungeon itself! Your blindness, if any, is cured first. Turn to {112}.\n" \
"    10:      A careless guard leaves your chain off while you work in the mine. You may slip away now, hoping to find something to help you deeper in the mine. Turn to {369}, or continue rolling.\n" \
"    11-12:   You manage to escape! You have several choices of action. You can try to raise a slave revolt (turn to {387}), run for help from the army ({350}), or head for the temple, which is two days to the west (see {50})."
},
{ // 331: Table D only
"The dancers smile and nod at you when you join them in their sacred twists and contortions. It seems easy at first, but you find continuing the dance a real chore. You can quit now and continue, or keep dancing. To keep dancing, make two L2-SRs, one vs. Constitution (25 - CON), another vs. Dexterity (25 - DEX). If you make both, see {341}. If you fail the Constitution roll, you tire out and can't continue; if you fail the Constitution roll but fail the one vs. Dexterity, see {305}. If you fail both, you are left behind and must go your own way."
},
{ // 332
"The guard moans miserably and clutches at his wounds. \"Fool!\" he croaks as you bend over him. \"The master of the tower will surely have noticed you. Now you are doomed...\" The man falls and lays still. You must now enter the tower. See {384}."
},
{ // 333: Table B only
"You approach the pond, clearing your throat to politely warn the gnome. When you get to the edge of the pond, you realize that the \"gnome\" you've been wasting your time on is just an old mossy log standing in the water! You fume and shake your fists, damning the stupidity of superstitious peasants. As you give the log a last kick, you feel an odd little tape on your ankle. You find no one when you turn around, but do notice a length of string lying on the ground. Following it into the woods leads you to the spot where you buried your goods. Tied to a tree with the remainder of the string is the farmer, who you notice is carrying a shovel and pick. Laughing at the gagged farmer, you gather your treasures and as much string as you can get without freeing the farmer. \"The gnome will probably free you when you've had enough,\" you tell the farmer. \"Let's hope he's not as busy tonight as you were!\" You leave, calling a loud thank you to the gnome, or whatever arranged the events of the night. The faerie string is as strong as rope, but weighs virtually nothing. You are able to gather 100' of the string."
},
{ // 334
"You are in an area of lonely, fog-covered moors southeast of the mountains where the Temple lies. Following directions given by a friendly shepherd, you choose to travel north, to a point where the Granite River empties out into Grey Lake. The trip takes two days; roll a die for each. On a roll of 1 or 2, roll for an counter on Table C. If you survive the trip across the moors, you find a road which brings you to the town of Molstan. Turn to {344}."
},
{ // 335: Tables A-C only
"Razzle-dazzle and good luck result in you being freed[; your possessions are returned to you] after you pay a fine of 120 gp. If you don't have it, see {325}. If you can pay the fine, you are escorted to the edge of town. The path leads north...turn to {62}."
},
{ // 336: Table C only
"You have been defeated by a knight of the faerie realm. You lie on the ground groaning in pain as the awful little man dances a jig about you. \"Fool!\" he cries petulantly, whirling his whip ahead his head. \"No one lays hands on the mighty Scruffus KnickleKnees without being very, very sorry for it!\" After a bout of bragging and abuse, he calms down and wrinkles his brow in thought, wondering what to do with you. Make a L2-SR vs. Charisma or Luck (whichever you prefer) (25 - CHR or LK). If you fail the roll, the malignant faerie pulls off your nose and puts it on upside down. Next, he takes off one of your feet and puts it on backwards. Besides making walks in the rain terribly dangerous, these disfigurements halve your current Charisma and reduce your Speed by 5. Take 125 ap for merely surviving your fight with the obnoxious sprite!"
},
{ // 337
"You have convinced the enslaved miners to rebel! They are a tired, dispirited bunch, however. How well they do depends on you. Under your guidance, the ten strongest slaves bash off their hobbles. The guard is tricked into a vulnerable position by a craft dwarf woman and silently killed. Your chosen band sneaks out into the dark. Choose now: If you head for the mine, turn to {399}. If you run for the hills, see {402}. If you attack the headquarters shack, where it is said that many swords are kept, turn to {379}."
},
{ // 338: Table D only
"You shake the gloved hand and feel a strange, prickly sensation climb up your arm, spread through your chest, and shoot up your neck. It fills your head, making you feel as if you've just eaten a barrel of hot peppers. When your eyes settle back in their sockets and your hair quits standing on end, you shake your head and look about. The mysterious cloaked figure is gone; you find, however, that any curses you've suffered from are gone and a red witch-mark is burned into the palm of your hand. Shown to the right people, it will prevent you from being molested by evil magicians, witches, and demon worshippers. Others will take the mark as a sign of evil and attack you. (The mark is of no use in this adventure, consult your local Game Master for house rules.)"
},
{ // 339
"Roll to hit or mark off Strength for your spell. You are at pointblank range firing at a man-sized target. [He has no armour or other protection. ]If you do [more than ]20 hits of damage, the villain dies; see {362}. If you did [20 or ]fewer points, turn to {376}."
},
{ // 340
"Thou art brave, but foolish. You must run the gauntlet to get to the heart of enemy territory. You must run the gauntlet to get to the heart of enemy territory. You must first sneak through the village to the gates of the temple. Make a L4-SR vs. Luck (35 - LK). Add 10 to your roll if you can become invisible; add your level to the roll if you are a sneaky rogue. Add 2 to the roll if you are a hobbit, fairy or leprechaun. If you make the roll, go directly to {375}. If you fail the roll, note by how many points you failed. This is the number of warriors you must fight. [If it's an odd number, you must fight them in groups of three. If the number is even, take them on separately. ]Each warrior has an MR of 18, plus armour that takes 4 hits. If you win, turn to {370}. After combat, roll one die to see how many turns of rest you get before going on."
},
{ // 341: Table D only
"The dancers travel several miles; you keep up, dancing vigorously and imitating their precise moves and gestures. The cultists, when they break for the night, congratulate you warmly and let you have a meal with them. They don't seem like bad sorts, merely misled. They give you a green robe (you wear it until they are out of eyeshot, but keep it carefully for later use!) and a herbal poultice[ that will prevent bleeding from blade wounds].[ (When you next receive hits in combat, keep track of the hits you take. After the fight, you may erase half of those done by blades or arrows.)]"
},
{ // 342
"You travel a suitable distance down the road and wait for a caravan. After questioning, the master lets you join. The long train of pack animals and carts at last enters the valley; you help unload the goods and receive permission to stay at the inn. The conversation in the common room is rather subdued, but you gather that the Krestok cultists are shortly to raise an army. The sulphur being mined is part of their dreadful plan...it is to be used in some sort of horrible demon-summoning ritual. You must now decide on a course of action. If you go to bed to sleep on it, turn to {352}. If you sneak to a building where you can eavesdrop on some plans, turn to {363}. If you go to the slave barracks, turn to {374}."
},
{ // 343: Table A only
"You have three chances to shoot missiles or spells at the dragon: once at far range, once at near, once at pointblank range, in that order. The dragon is huge. He has armour worth 8 points and has an MR of 120. If you don't kill him with spells or missiles, the dragon will breathe fire at you, doing 4 dice of damage (armour counts), and then join in melee. If you should win, chalk up 200 ap. If you are a warrior, you locate and remove the dragon's poison glands, gaining one dose of dragon's venom poison. Any character type may remove the dragon's ears to claim the 1000 gp bounty on the winged menaces."
},
{ // 344
"You are in the lake shore town of Molstan. Just west of town, the Granite River pours into Grey Lake. If you hired a guide at the inn where you started the adventure, he or she now leaves you.\n" \
"  The town is small but friendly; you find an inn with reasonable prices and shops where provisions and equipment can be bought. After buying a few drinks (10 gp if you have it) for the patrons in a local tavern, you learn that the road north of town parallels the course of the river, leading to a sulphur mine run by the Temple. This seems the best route to your goal.\n" \
"  A night at the inn costs 15 gp. For each night that you stay, you may erase one point of wounds. (If you don't have the money, you can work for your board; every two days spent in this manner cures one wound point). Before you leave, you must refill your ration bag with fresh food (10 gp or one day's work) and perhaps get a new set of clothing (15 gp for a sturdy set of adventurer's gear in the local style. [You will get a bonus of 2 points to Charisma saving rolls if you buy the clothing. The bonus is good until you enter the Temple of Krestok). ]When you are ready to leave, turn to {358}."
},
{ // 345 (not only WMT)
"You have entered the fief of a cruel baron. The once-rich fields are poorly tended; the skeletons of wayland travellers hang from roadside gibbets. Rag-clad peasants bearing their few meagre possessions pass you on the road. They urge you flee with them; you are undaunted.\n" \
"  A short time later, five of the baron's horsemen approach and ask you to state your business. After explaining your mission, they nod gravely. \"indeed, we have heard of the foul creed of Krestok; the blight on our land started when our good baron took in a sorcerer of that foul coven,\" says the leader of the patrol. \"The wizard has turned him to evil, but we can do nothing because of our oaths of loyalty. If you could dispose of the magician, we and the people of this land would be eternally grateful!\"\n" \
"  If you accept the mission, the soldiers urge that you avoid harming the baron, believing he will come to his senses once the evil wizard Mortol is slain. Go to {354} to proceed to the baron's tower. If you'd rather take on one quest at a time, continue on your way by turning to {334}."
},
{ // 346
"The slaves include women, children and old folk. Those who can't haul repair the baskets and sludge-filtering cloth filters. You are overcome with pity. If you fall in with them so you can encourage them to rebel, turn to {374}. If you sneak further back into the mine, turn to {369}. If you exit the tunnels under cover of darkness, in order to spy on the leaders of this operation, turn to {363}."
},
{ // 347
"The baron and his servant show you to a comfortable room where you freshen up. After dressing in a suit provided by the strange-mannered lackey, you share an excellent meal with the baron. The noble entertains you with war stories and tales of his \"court\"...though you have yet to see anyone but one servant, his advisor, and a few guards. \"I must beg your leave now. There is much work to be done tonight,\" he tells you as the plates are cleared. \"There's a storm brewing, you know!\" Indeed, the sounds of distant thunder and flashes of lightning begin leaking through the boarded windows. The baron leaves, chuckling. You return to your room, snuff the candles, and try to get some sleep. Unfortunately, the sounds of the storm and strange thumping noises from the roof of the tower keep you awake. If you investigate, see {378}. If you are determined to get some rest, go to {357}."
},
{ // 348: Table C only
"You have defeated Scruffus KnickleKnees, a knight of the local faerie kingdom. \"OOOOHHHHhhhh!\" he cries. \"The shame! The hurt! Struck down by a mere mortal! OOhhhh!\" You watch, embarrassed and amazed, as the knight flops to the ground and begins pounding his fists and kicking his legs, moaning frantically. Your amazement turn to wonder as he begins to sink into the ground, disappearing into the pothole he is creating. When he is out of sight, you and the toad edge up to the pit for a better look but only hear faint sobs and curses. After determining that the toad is an inoffensive creature, you raid its saddle bags. You find a sack of gold (348 gp), four magic arrows[ (these always hit, and pierce all but magic armour automatically)], a bottle of fine magic wine (in a non-solo adventure, you may get people super-sloshed with this vintage; it acts like a super micky finn), and seven elf-wafers. These wafers last indefinitely[, are theft and rot proof, and provide several days' worth of nutrition (for the purposes of this adventure, each wafer is worth a \"ration bag\" of food. You can hide the wafers from thieves who might otherwise steal your entire food supply)]. Defeating Scruffus is worth 150 ap."
},
{ // 349
"You have ended the cruel reign of the ensorcelled Baron Ulkara. Chalk up 500 ap for yourself. The news spreads and you are hailed as a hero. You aid the scattered knights of the fief in freeing prisoners from the tower dungeons, selecting a new baron and redressing the wrongs done to the oppressed peasants. The new baron tells you that he will knight you if you are able to complete your current quest...If you successfully conclude this adventure, your character returns here to claim the title. Knighthood entitles you to various privileges and recognition: consult your local GM or solo dungeon rules for these.\n" \
"  In addition, you are given 1000 gp, a suit of chainmail, and all the food you can carry. The knights of the area conduct you to the edge of the fief and wish you luck. Continue with the adventure by turning to {334}."
},
{ // 350
"After a harrowing trip through the mountains, you make it to an outpost of the king's army. The captain of the post agrees to meet you. He, he is not convinced as you try to impress upon him the danger the cultists pose. You prepare to defend your case.\n" \
"  You must make a L3-SR vs. Charisma (30 - CHR). If you are a warrior, add your level to the roll as a bonus; if you are a rogue, subtract your level from the number you roll! In addition, add 1 to the roll for each of the following you have done:\n" \
"[    * Fought with the Myrean army.\n" \
"    * Rescued Baron Ulkara, or been knighted by his vassals.\n]" \
"    * Have a green robe with you.\n" \
"[    * Rescued a caravan from horrible death at the mine.\n" \
"    * Each battle you've had with someone from Table D (Krestok pilgrims, warriors, dancers, etc.).\n" \
"If you've fought alongside bandits, attacked soldiers of Myre, or attacked merchants or pilgrims, SUBTRACT 5 from your roll. ]Compare your roll with the number needed; if you missed the roll, you can either leave the country ({400}), or try to raise an army of your own (turn to {381}). If you MAKE the roll, the points over the number needed, times 10, is the percentage of the army you and the captain manage to convince to take the Krestok threat seriously. Each percentage point is worth one combat point. Write this down. Multiply the number by 10 to find how many ap you get for this feat! Finally, if you got the army to listen, you must determine who wins the crucial battle in the hills. Turn to {361}."
},
{ // 351
"You poke around the room, looking for items of interest. You find several interesting maps (\"A chart of the witch-plains of Dreadall\", \"Atlas of the Seventh Demon-Sphere\", \"The Alimentary Canal and Surrounding Regions\"), a book on necromancy, anatomical dummies of men and several other kindred races, and a cabinet full of polished bones and picked body parts. You quickly return to your seat when you hear the baron coming down the stairs. Go to {401}."
},
{ // 352
"In the middle of the night, a sack is put over your head. Bound tightly, you are dumped in the sulphur mine to work. Turn to {330}."
},
{ // 353
"The four men have Monster Ratings of 12, 13, 13 and 14. The weakest has a chair that takes 4 hits as though it were a shield. [Because this is more of a brawl than a blood feud, hits will come off your Strength rather than Constitution. ]If you disable any of the men (reduce MR to 5 or less), they surrender and leave you alone; give yourself 25 ap for defending your honour and go to {1} to choose a new course of honour (the game is over for the night...don't choose {9} as an option again.) If you are disabled[ (you cannot be killed)], you are tossed into the privy, irreparably dirtying your clothes. If you don't buy a new pair immediately, your Charisma will be halved for the remainder of the adventure. Go to {1} to choose a new course of action."
},
{ // 354 (not only WMT)
"You are in the yard of a great, gloomy shell keep. There are a few outbuildings, but they seem deserted and run down. You may enter the tower proper (see {384}), or poke around the grounds first (go to {364})."
},
{ // 355: Table C only
"As you strike the killing blow, something amazing happens: with a puff of soiled smoke, the wicked faerie's toad-mount turns into a small, shaggy bridge troll. The troll kneels before you and licks your boots (or sandal straps), thanking you profusely between laps. The grateful creature, long trapped in the form of a giant toad, pledges you [five ]services. [The troll will come to your aid, anywhere on the continent, one hour after you whistle for him. The troll has an MR of 50, skin that takes 8 hits a round, and immense strength (he can easily dig tunnels through dirt and bend iron bars). A \"service\" consists of a single combat, use of strength, or the like. ]If you bring this character into an ordinary campaign, be sure you have the GM's permission to use the troll! Defeat of the faerie knight is worth 150 ap."
},
{ // 356
"Reading the scroll causes you no harm. Alas, the spell the reading sets off does: everyone in earshot melts into a puddle of blue slime. The mountains around you shake and crumble, sending an avalanche of boulders rolling into the tent. Some peaks begin erupting, covering the boulder-strewn camp in a thick layer of incandescent lava. Poison gases from the volcanoes settle over the area, sealing the fate of any Krestok marauders who have avoided being crushed and burned. If you are physically immortal, you live on in exquisite agony, entombed in the cooling lava. Madness soon sets in. Eventually, a kind god releases you from the curse of immortality.[ If you reincarnate, take 1500 ap for doing in Yastri Kroll and foiling the Krestok plot. Unfortunately, no one will recognize you for all your heroic deeds.]"
},
{ // 357
"The thumping from the roof grows louder, and is joined by a grinding shriek that sets your teeth on edge. Make a L1-SR on Luck (20 - LK). If you make it, you realize that the only way to get some sleep is to go up and ask the baron, politely, to keep the noise down. You bundle up against the rain and walk upstairs to {378}. If you miss the roll, you wander about your room in frustration until you find a bottle of strong red wine from Baron Ulkara's vineyards. Drinking it sends you into a deep slumber. Dream your way to {326}."
},
{ // 358
"You are travelling west along a road which twists and turns through the eastern range of the Granite Mountains. The trip to the Temple's sulphur mine, where you think you can pick up some valuable information, takes three days. On each day, roll a die and consult the table below:\n" \
"    1-3: Clear weather and speedy travel.\n" \
"    4-5: Roll for an encounter on Table D.\n" \
"    6:   Landslide! Make a L1-SR vs. Speed or Luck (20 - SPD or LK). If you fail, you are struck with rocks and take 2 dice of hits. Also, you must find a side trail around the obstruction in the narrow road; this adds two days to your travel time.\n" \
"When you complete your journey, turn to {371}."
},
{ // 359: Table C only
"If your answer was \"a yam\", \"a sweet potato\", or \"may\", you are correct. If you've come this way before and knew the answer, or if you guessed wrong, the faerie knight gives you one more chance: You must roll a L3-SR vs. Intelligence or Luck (30 - IQ or LK) to think of an original comeback. If you guessed right, or succeed with the roll, the knight howls with rage and falls off his toad...see {348}. If you fail the roll, [or guess wrong, ]see {336}.[ (Note: you may, if you wish, put a new riddle of your own at {316}. Leave the answer here: __________ ).]"
},
{ // 360
"There are six brigands, each with an MR of 12. You may attempt to run from them (L1-SR vs. Speed (20 - SPD)), but roll a die if you succeed: on a roll of 1 or 2, you had to drop your ration bag to trip one of them. Each of the brigands has food and one random treasure."
},
{ // 361
"Roll 2 dice and multiply by 10. Subtract 20 from the dice if you fight in the battle yourself. If the number rolled is less than or equal to the strength of the army you convinced to fight, the Krestok forces are defeated! If more than the total, turn to {392} now. If you won the battle, you must now determine your part in the conflict. Roll a die. Add your level if you are a warrior; add 5 if you actually fought in the battle. Consult the chart below.\n" \
"    Roll    Result\n" \
"    1-6:    Go to {372}.\n" \
"    7-8:    Go to {388}.\n" \
"    9+:     Go to {404}."
},
{ // 362
"The baron's eyes clear; he shakes his head and clears his throat. A strange expression comes over his face; \"This...villain...must...die,\" he chants in a dull tone. He draws his dagger, whirls around, and plunges it into the chest of his advisor. The man screams and topples to the floor, killed in a single blow. \"FREE!\" cries the baron. \"Free at last, and I have you to thank! A great boon shall be yours!\" With your help, the baron dismantles an infernal machine he and the white-robed wizard had been building on the roof. Over the next week, you assist the baron in calling back Ulkara's vassals and apologizing to the sorely mistreated peasants of the fief. Half of any wounds you've suffered are cured from the rest and fine food the baron provides.\n" \
"  As a reward, you are given 1000 gp and Mortol's dagger. This is a katar, enchanted to get a doubled die roll (roll 4 dice instead of 2)[ and able to hit magical creatures as though it were a combat spell]. Chalk up 250 ap and turn to {334}."
},
{ // 363
"You wait for night to fall before sneaking to the valley. Make a L1-SR vs. Luck (20 - LK). If you make it, turn to {374}. If you fail, a guard spotted you...you are forced to hide in the slave barracks! Go to {387}."
},
{ // 364
"The courtyard of the tower seems deserted. The stables contain a few dispirited, sickly-looking horses, and the bakery seems to have been used within a week or so. All signs indicate that the inhabitants of the tower are few in number and stay indoors. As you turn to the tower you see a guard heading for a privy. He is dressed in chainmail and is carrying a crossbow. If you approach him, see {373}. If you attack the guard, turn to {328}."
},
{ // 365
"Baron Ulkara listens to your speech with a set face. Occasionally, Mortol bends over to whisper in the baron's ear. When you describe the sad state of the lands and people, you seem to strike a nerve: sweat breaks out from the noble's forehead and small squeaking sounds come from his throat, as though he were trying to say something. Ulkara's advisor looks very nervous, and whispers continuously to the baron. Roll a L2-SR vs. Charisma (25 - CHR). If you succeed, turn to {362}. If you fail the roll, see {376}."
},
{ // 366
"You and the slaves gleefully torch the mine's headquarters building. Grabbing weapons and shields, the slaves become an armed force. The guards remaining in the valley die horribly. Now, count up the days since you started the adventure. Be sure to include days in captivity as well as actual travel time. If the total is more than 30, turn to {377}. If the result is under this, you may either head for the temple, taking up to ten slaves with you (they now have MRs of 14, and 4 points of armour apiece) by turning to {50}, or help the slaves get home. If you choose the latter, the adventure will end for you now. Take 1000 ap, remove any curses you may have suffered (one of the slaves was a powerful witch-woman and herbalist healer), and close the book. Though you didn't stop the hordes of Krestok, you delayed their plans by razing their sulphur mine!"
},
{ // 367
"GABOOOOMMMMMMM! In a panic, the wizard-spirit blasts you with a Hellbomb Burst. The wizard, having overestimated his Strength, drops dead. The Krestok general's staff is reduced to bits of charred bone and half-melted chainmail. This feat will earn you 200 ap if you live. Make another L1-SR vs. Luck (20 - LK); if you make it, Yastri Kroll and the Phoenix Scroll also go up in flames.\n" \
"  Now...did YOU survive? If you are immune to tenth level magic, or can resist more than 100 points of fire damage, or survive 10 dice worth of blast damage, you live. Alas, all of your non-magical equipment is utterly destroyed. If you took out everybody, turn to {394}. If Yastri Kroll still lives, note that he has taken 10 hits and turn to {406}. If you are dead, be cheered that your demise has decimated the Krestok leadership! You have won, even though you don't get to enjoy it. You are made the subject of numerous songs and legends[; if you wish you may start a new character now with the same first name and class, adding 5 to either his (or her) Luck, Intelligence or Strength because he or she has a great role model]!"
},
{ // 368: Tables B-D
"The young maiden's father lives two days' journey away, four days total for the round trip. [On each day, roll a die: a roll of 1 means you must roll on Table A of the Encounter Chart. ]If you make it to the baron's castle with the young noblewoman in tow, you will be given 250 gp and four random gems as a reward. The baron also gives you any food you require as a matter of course. Return to the paragraph that sent you on this adventure unless otherwise instructed."
},
{ // 369
"You sneak deep into the mines, entering a dangerous area of collapsing tunnels and pools of cold, soupy water mixed with mud and sulphur. Exploration reveals a tunnel out of the mine. If you came here directly from outside and have a light source, or can cast a light spell, turn to {107}. If you have no source of light, make two L2-SRs vs. Dexterity (25 - DEX). If you make the first roll but not the second, see {100}. If you fail the first, see {117}. If you make both, turn to {107}."
},
{ // 370
"You have cut a bloody swath through the village. In the square before the temple gates is a troop of mercenaries who have been alerted to your presence. They rush you, spears at level! Make a L2-SR vs. Speed (25 - SPD). Add your level if you are a warrior. Add 10 if you are under 5' in height! If you make the roll, you evade the charge and get among them. If you miss the roll, you are skewered by the many spears. This does as many DICE of damage as you missed the roll by! Armour counts. If you live, you must fight the warriors. There are ten of them to start; [you can take them on in any amount you wish, but ]every three rounds another will join them. Only if you kill all present will the reinforcements stop coming! Each mercenary has an MR of 18, and 6 points of armour. If you live, turn to {375} to continue. You may also withdraw at this point, running to get help from the Myrean army (turn to {350}), raise your own force (see {381}), or simply leave while you are still alive (turn to {400} for this option)! If you continue, roll one die to see how many turns of rest you get before the next combat."
},
{ // 371
"Following the road from Molstan into the mountains brings you to the heart of enemy territory; a sulphur mine run by the cult of Krestok. You slip off the main road and take a poorly marked path up a mountainside; at the top is a cliff overlooking the valley. You can see the road leading into the valley, a cluster of grim buildings where the miners are imprisoned, and a small inn where traders bringing food to the mine stay. Straddling a tributary of the Granite River is a water wheel, an extraordinary contraption that spins around and grinds rocks into sulphur dust. The whole scene is depressing and grim, but you steel yourself for action. If you descend to the road again, turn to {382}. If you decide to avoid the mine altogether, and continue on to the main temple, and must travel for three more days...turn to {50} after marking down the time."
},
{ // 372
"How embarrassing...in the general confusion, the fierce battles, and interplay of many famous and powerful generals and nobles, you are overlooked! Take 500 ap consolation. Turn to {411}."
},
{ // 373
"The guard sees you and waves frantically. \"Flee! Go! Begone, traveller!\" he whispers when you get close enough. \"The master of this castle is mad and will have your head if you are not careful. Beware!\" You calm him down and ask for explanation, but you are interrupted by a shout from above. The guard scrambles for his post, whispering to you that it is not too late to run. If you leave, continue on your journey north by turning to {334}. If you enter the tower, see {384}."
},
{ // 374
"Stealthily, you make your way to the mine's headquarters building, a simple shack built on stilts. You crawl underneath and lie quietly to listen. \"Of course, this will mean fewer guards here,\" says a pompous voice. \"But these wretches can't count. I doubt we'd get any trouble out of them even if they did notice!\" Another voice, less sure, replies \"Bah! It's not the slaves I'm worried about! If you send those soldiers out now, someone may suspect something! Disguise them as merchants or something!\" You listen in dread as the two officials plan the murder of all the merchants in a caravan in order to take their identities. In horror, you gasp. Someone hears. Make a L1-SR vs. Speed (20 - SPD). If you fail, turn now to {330}. If you make it, you may either warn the people at the inn (see {395}) or sneak to the slave barracks at {387}."
},
{ // 375
"You are at the temple gates. The stairs to the huge double doors are guarded by giants wearing dragon-skull helmets. Piles of skulls are heaped all around. If you have a green robe, enter now by going to {389}. If you fight your way in, turn to {380}. If you try to talk your way in, roll a L3-SR vs. Charisma (30 - CHR). Turn to {380} if you fail, {389} if you win."
},
{ // 376
"\"Baron!\" cries the advisor. \"This one is a traitor! A foul villain out to destroy you and the kingdom!\" The baron's eyes cloud; he draws his sword and advances on you. \"Die, fiend!\" he cries hysterically. \"Torment us no longer!\" The baron has an MR of 48; his armour is worth 6 points. Mortol stays well away, jeering at you. On each round in which you win a combat roll (your total is higher than his, though you need not actually damage him), you may try to strike the advisor. To do this, you must win a L1-SR vs. Dexterity (20 - DEX). If you make the roll, you may direct half the hits you win by to the white-robed villain. Magic may be targeted against Mortol, but you will be defenceless against the baron's mighty blows if you stop to cast a spell (full damage vs. armour and Constitution).\n" \
"  The baron's advisor has cloth armour (2 hits) and a Constitution of 18. If you kill him first, see {362}. If you kill the baron first, turn to {390}."
},
{ // 377
"Evidence left around the mine reveals a horrible fact; the hordes of Krestok have begun their march to conquer Myre! Without warning, the armies of Myre will be caught unprepared! If you take your slaves out of the mountains to act as the nucleus of an army of your own, turn to {381}. If you leave to summon the army of Myre to arms, turn to {350}. If you wish to attack the forces of Krestok at their source, by assaulting the temple by yourself[ and with up to ten of your fellows (the former slaves have an MR of 14, plus 4 points of armour)], you make your way west to {340}."
},
{ // 378
"You draw your weapon and creep upstairs. There, you see Baron Ulkara and Mortol, his advisor, at work on a huge internal machine. As you watch from hiding, the baron and his white-robed advisor get into an argument. The villain pulls a lever on the machine, causing a great display of flashing lights, showers of sparks, and loud noises. The two men battle while the machine does its horrible work. By a fluke, Mortol topples the baron over a battlement to his death. By a fluke, Mortol topples the baron over a battlement to his death. If you attack the man in white as he passes you on his way to get a bandage for his cut arm, see {390}. If you let him go and wait to see what happens, go to {396}."
},
{ // 379
"The headquarters building is guarded by ten men. They have an MR of 14 each, and wear leather armour (6 hits protection). [The slaves with you have an MR of 10 each; as you kill the guards, you may take their swords. A sword raises the MR of a slave by 2 points. ]If you are disabled by the soldiers, [or outnumbered 5:1 at any point, ]you are captured and must turn to {330}. If you win, see {366}."
},
{ // 380
"You are fighting two giants. They are about 15' high, hairy and muscled, and clad in shorts and tunics of green canvas. If you are a giant, or have friends with you, you must fight both at once. If you are alone, the giants know better than to get in the way. Each has an MR of 50. You may make a L1-SR vs. Speed (20 - SPD) each round to try fancy manoeuvres. If you fail, fight normally. If you make the roll by 0-5 points, you do 10 hits to one of the giants. If you make the roll by 6 or more points, you run past into the temple, to {389}. If you win, turn to {389} as well. Roll one die after combat to see how many turns you get to rest before going to the next combat."
},
{ // 381
"HMMPH! You have a rather high opinion of yourself. Let's see if you've got what it takes to be a true leader of men! You must see how many people you can convince to join you. Do you have the number of villages you've visited written down? If you don't, you have a \"notoriety\" of 1. If you did write the number down, you have a notoriety equal to this total.\n" \
"  Now, make a L1-SR vs. your Intelligence (20 - IQ). If you make it, multiply the number you beat the roll by times your notoriety. This is an indication of how many people you sway to your cause by intelligent argument. If you are a rogue, double this total for being a tricky devil! Next, make a L1-SR vs. Charisma (20 - CHR). Add your level to the die roll if you are a warrior. Multiply the number you beat the roll by times your notoriety to find how many people you can get to join by your personality. If you are a knight, captain, or other notable with a title, double this subtotal.\n" \
"  Next, you can call on the people you may have made friends with in this adventure. [If you rescued Baron Ulkara from bewitchment, add 20 to the total; if you defeated him without saving him, only add 10. If you have an army of slaves, add 20 to the total. ]If you befriended a certain troll[ and want to use his services], add 5 to the total. If you rescued a baron's daughter, add another 5.\n" \
"  When you have determined the strength of your army, record the number. Add a number of ap equal to 10 times the total to your experience total for accomplishing this feat, then turn to {361}."
},
{ // 382
"You are on the road leading to the Krestok sulphur mine. Careful scouting reveals three courses of action: you could blend in with the caravan entering the valley (turn to {342} to try this), enter the town alone and spy on the guards and officials (see {363}), or make a dash for the mine entrance itself (go to {399})."
},
{ // 383
"The remnants of the Krestok army staff looks at you fearfully. You smile and begin to unroll the scroll; with a shriek, the generals and aides run out of the tent. The black figure moans and disappears in a puff of pink smoke that smells like garlic and pine tar. If you actually read the scroll, turn to {356}. If you'd rather deliver it to proper authorities, turn to {394}."
},
{ // 384
"You enter the tower through a pair of huge double doors...which swing shut behind you. It is dark inside (the windows have been boarded over), but before you can light a torch, a hunched-over, grey-haired man hobbles out of a side room. He wears tattered livery hobbles and holds a candelabra. \"Welcome! Welcome!\" cackles the servant. \"The lord and his advisor have been waiting to see you!\" The man takes your cloak, and after looking at it admirably and checking its size, brings you to a nicely furnished second-storey room. You sit in a comfortable chair, admiring the tapestries on the wall. \"Stay right there,\" says the servant. \"The master will be down in a moment!\" If you follow him up the stairs quietly, see {393}. If you look around the room before your host arrives, see {351}. If you sit quietly for the baron to greet you, go to {401}."
},
{ // 385
"\"Ah!\" says the green-clocked general. \"Here is our entertainment! And you got the time of his arrival right down to the minute. Thank you, Sormoss!\" The figure in black bows silently. Roll a L2-SR vs. Luck (25 - LK). If you make it, turn to {406}. If you fail, {398}."
},
{ // 386
"You charge the machine, weapon swinging. The glass and wire coils fly to shards before your blows, but after a few swings you are jolted by an immense bolt of lightning that seems to come from inside the machine. If you can generate 40 points of damage in one blow (weapon roll plus adds), you stop the machine cold; go to {349}. If you don't manage to get that much damage, you are stunned by the energy discharge and must watch helplessly as the process started completes itself. Turn to {396}."
},
{ // 387
"You are in the slave barracks, a filthy place with a dirt floor and walls that are more crack than wood. Hundreds of tired, dirty men and women wearing dusty robes lie on pallets, moaning miserably. Many are blind from the toxic sulphur. If you leave, you may either run for the mine by turning to {399}, or head for the temple proper by heading west (this takes three days. Turn to {50}). You may also try to raise the slaves to rebellion. Make a L2-SR vs. Charisma (25 - CHR). [If you yourself were a slave, add 5 to your roll. ]If you make the roll, turn to {337}. If you fail, someone hears you shouting; you can either run for the mine or face capture! Turn to {399} for the mine, see {330} for capture."
},
{ // 388
"Your heroic action in warning the people of Myre of the danger make you a minor hero. Alas, you are not conspicuous in the battle proper. Take 600 ap. In addition, an outfit of tough mercenaries, the Gheton Company, makes you an honorary captain for aiding them in defence of a supply train they were guarding against Krestok raiders. [In times of need, you can call for the company to aid you in military battle. Calling out the company takes about a week, and must be done in a large city. A L2-SR vs. Charisma (25 - CHR) is needed to convince the company that your mission requires their help. A number of men equal to a roll of 2 dice times 10 will come; each has chainmail, a broadsword, a target shield and javelins. ]Turn to {411}."
},
{ // 389
"You are in the temple! Soon after entering, you knock out a guard and take his armour (leather...takes 6 hits) and weapons (either a heavy mace (5 dice + 2 adds) or a pilum (5 dice)). If you are a wizard, you may dress up as an acolyte instead (cloth armour, plus a sax). There is no other way to avoid detection! Disguised, you wander about the temple. Make a L2-SR vs. Charisma (25 - CHR). If you FAIL the roll, you are not noticed and may now continue to {397}. If you make the roll, an officer notices you, admires the steely look in your eye, and asks you to come with him. You realize that he is taking you to the front to fight and kill on the side of Krestok! You must fight him now to stay in the temple. He has an MR of 24, wears leather armour, and carries a target shield (10 points of armour). If you win, turn to {397}. If you are disabled, you are roasted alive to entertain the giants who guard the front entrance. If you survive, roll one die to see how many turns of rest you get before the next combat."
},
{ // 390
"You face the white-robed advisor and demand he surrender. \"Bah!\" he shouts. \"Out of my way or I'll reduce you to sawdust!\" He turns to leave, then suddenly whirls around and lunges at you with a long dagger. He has a Constitution 18, and wears cloth armour under his robes[ that takes 4 hits]. The dagger gets 4 dice and 4 adds. Mortol himself has 6 adds. If you kill the villain, see {396}."
},
{ // 391
"You have a shot at the wizard-spirit! It is at pointblank range for missile-firing purposes. To hit it with a magic spell, you need to make a L1-SR vs. your own Luck (20 - LK). If you miss, the spell is cancelled by a powerful amulet. Only spells which do direct damage will work in this case; a Panic spell must beat a total of 70 to work.\n" \
"  Total your damage; if you did over 50 points of physical damage in a single blow, or scare it away with Panic, the wizard-spirit's connection with our world is disrupted and it flees: this earns you 100 ap. [If you do over 100 points of magic damage, the creature is utterly destroyed. Take 200 ap for this feat! ]If you beat the creature, turn to {406}. If you can't kill it, roll a L1-SR vs. Luck (20 - LK). Turn to {409} if you fail; turn to {367} if you make the roll."
},
{ // 392
"Uh-oh! Though you tried very hard, you didn't convince enough people to fight the Krestok hordes. The mercenaries, battle-crazed fanatic acolytes, and gruesome monsters allied with Krestok sweep out of the mountains, taking the strategic passes and several towns in the foothills. It is only a matter of time before the forces of green-robed darkness push south and occupy all of Myre! If you didn't join in the battle, turn now to {400}. If you did fight with the troops, you have one last chance to save the day. In the battle, you penetrated deep behind Krestok lines. Now, as the troops bring in the spoils of war and gruesome trophies, you sneak about like a rat. Heady with victory, the Krestokkers don't notice you! If you sneak away, turn to {400}. If you try to assassinate the leaders of the movement, turn to {410}."
},
{ // 393
"You tiptoe up the stairs after the bug-eyed servant, eventually emerging on the flat roof of the tower. You spot a pile of boxes and quickly conceal yourself behind them. In the middle of the roof, two men (one strong-looking and wearing fine clothes, the other in a threadbare white robe) work around a large wooden table. Complex coils of wire and glass tubing surround the table, on which you can dimly see a human form covered with a white sheet. The servant delivers a tray to the men before scampering down the stairs. If you quickly retreat to the lower levels of the tower, see {401}. If you shoot a missile or cast a combat spell at the man in fine clothes, turn to {323}. If you attack the man in white in the same manner, see {339}. If you wait to see what happens, go to {378}."
},
{ // 394
"Over the next few days, the folk of Myre are startled and overjoyed to hear that the forces of Krestok are disappearing, slinking off into the mountains or melting into piles of greasy ash. Rumours run rampant until a figure on a grey horse rides into Ghem, leading a ragged band of Myrean soldiers and armed yeomen. The figure waves a somewhat battered piece of vellum; the Phoenix Scroll! The hero is you...\n" \
"  After several weeks of feasts and balls, you are taken to the king and made a General of the Grey Stalkers, a new regiment of fierce warriors assigned to guard the mountains of Myre from further trouble. A suit of highly embellished mithril-plate armour is presented to you, along with a huge grey warhorse in full barding. If you accept the commission, you must roll a L2-SR vs. Luck every time you want to use this character; if you fail the roll, your character is called to arms and you must put the character away for a week. Multiply the number you missed the roll by times 10 to determine how many ap the character earns; multiply this number by 50 to determine how much gold he or she earns as a result of the actions. When you are on adventure, your rank will bring you benefits described by the solo adventure or Game Master. You have won!"
},
{ // 395
"Working quietly, you wake everyone at the inn and warn them of the danger. They sneak to their wagons and horses and prepare to leave. As they get underway, you hear an alarm going off! The guards have been alerted! If you stay behind and cover the exit of the caravan, take 300 ap and turn to {330}. If you leave, roll a die. On an odd roll, the caravan gets away. Take 200 ap. On an even roll, the caravan is captured and everyone killed! In either case, you realize that the mine is no place to be. You head for the temple (this is a two-day trip) by going to {50}."
},
{ // 396
"You watch in terror as the machine on the roof draws lightning from the storm clouds and pumps it into the sheet covered figure on the table. When the process is over, the form on the table begins to move! It tosses the sheet aside, revealing a hulking, ogre-like creature. It bellows incoherently and takes a vicious swipe at the sparkling contraption that gave it birth. Crashing through the glass and wire, it advances on you menacingly. You may run now, continuing with the adventure (turn to {334} to leave now), or face the creature now to protect the downtrodden peasants of Ulkara's realm. It has an MR of 58[, but doesn't lose adds and dice as it takes damage]. If you defeat the monster, see {349}."
},
{ // 397
"You soon find a staircase that leads into the headquarters tower. At its top is an ornately decorated room occupied by three suspicious guards and an old man dressed in a black robe. An archway leads into another room. If you run for the archway, roll a L1-SR vs. Speed (20 - SPD). If you make it, turn to {403}. If you fail the roll, or want to fight, limber your dice fingers. The guards have MRs of 18, and wear 6 points of armour. The old man is a wizard. [Roll a die for him each turn. On an odd roll, he triples the roll of one of the warriors. On an even roll, he hits you with a Take That You Fiend spell for 16 points (first level). ]He has an MR of 10[, which is reduced by one for each spell he casts]. If you win the battle, turn to {403}."
},
{ // 398
"The black-robed figure turns to you. The hairs on the back of your neck stand up when you notice that there is nothing inside the hood. You are fighting no ordinary creature; you must kill the wight in a single blow if you are to have any hope of survival. Roll 2 dice, adding your Speed, for yourself. Then roll 2 dice and add 12, for the creature. If you roll higher, turn to {391}. If you roll equal or lower, make a L1-SR vs. Luck (20 - LK). If you fail, turn to {409}. If you make it, see {367}."
},
{ // 399
"You are in the sulphur mine. It is a horrid, hellish place, stinking of brimstone and uncomfortably clammy. Using crude tools, baskets and ropes, the slaves scoop up sulphur-bearing rock and liquid sulphur sludge and haul it to the surface. The toxic fumes make many go blind; those affected are kept working since the mines are almost totally dark anyway.\n" \
"  You have several choices of action. If you sneak around in the dark, whispering to slaves in hopes of getting help, turn to {346}. If you go deeper into the dungeon, turn to {369}."
},
{ // 400
"Hah! HAH! Perhaps if you'd been a bit faster in getting here there'd have been a chance to save this poor kingdom. Realizing this, the gods arrange for you to have plenty of chances to exercise your legs as you run from the magically fortified troops of Krestok. Increase your Speed to 10 if it was below 10; add 2 to the attribute if it was already over that figure. In addition to leg-building, your flight from the country loses you half your gold[ and gems, and any two magical items]. Take 250 ap for getting this far. Don't try this adventure with this character again!"
},
{ // 401
"Baron Ulkara, a tall muscular man with a beard and moustache, enters the room followed by a sneering, cruel-eyed man dressed in an odd white robe. The baron greets you warmly while Mortol, the man in white, glares contemptuously at you both from behind the baron's back. If you accept the Ulkaran offer of hospitality, see {347}. If you accuse the baron of treating his subjects cruelly and demand he recompense his vassals and peasants for their troubles, go to {365}. If you attack the man in white for his continued bad manners (he goes so far as to stick his tongue out at you), turn to {376}."
},
{ // 402
"Not a good move. The slaves with you think you are abandoning their fellows! Make a L1-SR vs. Charisma (20 - CHR); one slave stays with you for each point you beat the roll by. [Each man has an MR of 10; with a sword and food (you'll have to give up your ration bag) this will go up to 14. ]Now, decide what you are going to do: To attack the headquarters, turn to {379}. You may travel to the temple (a two-day trip) but your companions will leave you; turn to {50} to go to the temple. If you wish, you may now leave the mountains and try to find an outpost of the king's army, in hopes of preventing an easy defeat by the Krestok hordes. Turn to {350} for this option."
},
{ // 403
"You rush into the room and find it empty. Make a L1-SR vs. Luck (20 - LK). If you make it, you find and take a strange map and amulet which were lying on a desk in the room. You spot a ladder leading to the roof and climb it to {207}. If you fail the roll, you find nothing in the room, and upon hearing a mass of angry guards outside the door head for the roof to hide...turn to {133}."
},
{ // 404
"You prove yourself useful in battle as well as being lauded for warning the land of the Krestok threat. You are made a captain of the Grey Stalkers, a new regiment of fierce warriors assigned to guard the mountains of Myre from further trouble. A suit highly embellished of nickel-plated plate armour is presented to you, along with a huge grey warhorse. [If you accept the commission, you must roll a L1-SR vs. Luck (20 - LK) every time you want to use this character; if you fail the roll, your character is called to arms and you must put the character away for a week. Multiply the number you missed the roll by times 10 to determine how many ap the character earns; multiply this number by 10 to determine how much gold he or she earns as a result of the actions. ]No matter what you choose now, take 600 ap and turn to {411}."
},
{ // 405
"What rotten luck! You unfortunately hit your head on a rock and were knocked unconscious. The slimy pit is full of disgusting liquids and you drown. You can flush this character!"
},
{ // 406
"Yastri Kroll, leader of the cult of Krestok, turns to you with his mace drawn. You realize you face a most powerful foe! To flee now, you must roll a L1-SR vs. Speed (20 - SPD) to get away from Yastri, then another L2-SR vs. Luck (25 - LK) to get out of the area. If you make both, take 100 ap and turn to {400}. If you miss either, you must face Yastri. He has these attributes:\n" \
"    ST: 17  IQ: 14  LK: 23  DEX: 16  CON: 24  CHR: 25  Adds: 20/24\n" \
"Yastri is carrying a huge mace which gets 5 dice and 2 adds[; a silver coat allows it to hit enchanted creatures]. Yastri's chainmail armour is made of an alien metal; it takes 20 hits[ and nullifies most spells on level 1-3 (to get through, Yastri must fail a saving roll vs. Luck on the level of your spell)]. Do your best versus Yastri. If you beat him, take 100 ap, his armour, and the scroll which is curled up in his sleeve. If his staff are still alive, turn immediately to {383}. If you beat Yastri, turn to {394}."
},
{ // 407 (anti-cheat)
"Actually, there is no way to get to this paragraph. The paragraph that sent you here is a fake. Quit cheating and play the game right!"
},
{ // 408
"MENTAL COMBAT & BATTLES OF WILL\n" \
"  You may, in the course of this adventure, be forced into a battle of wills and intellect. This sort of combat is played much as ordinary combat is, but different statistics are involved. Your mental combat adds are computed using IQ, Luck and Charisma. Your mental \"Constitution\", called Mental Integrity, is equal to the average of Luck and IQ. The number of dice rolled in a battle of wills varies. Rogues always roll 2 dice, but get to add and roll over again on doubles because they have devious mentalities. Warriors always roll 3 dice, warrior-wizards always roll 4. Wizards roll a number equal to their level (they start out weaker because they are sensitized to the spirit realm, and therefore vulnerable).\n" \
"  Wizards' staves act as intellectual armour, taking as many mental-combat hits as the wizard's level. Anyone, even a warrior, can use a deluxe staff as armour; they take 10 hits, or the owner's level, whichever is higher. If your mental integrity is reduced below 5, your spirit, aura, or what-have-you is scourged, and subject to the victor's whim; sometimes this results in possession or a geas. If your mental integrity is depleted entirely, your character dies and the remains become a zombie. If you beat an opponent in a mental combat, you may receive a bonus or favour, but may not automatically gain possession of the vanquished creature's body or spirit. The paragraphs will give details on the consequences of victory or defeat."
},
{ // 409
"Phoooomf! The wizard-thing tosses an eleventh level Icefall spell. Unless you are immune to magic, take 11 dice plus 35 adds in damage directly off your Constitution. If you still live, turn to {391}. If you die or are disabled, your frozen corpse is given to the troops to play with. They break off pieces, throw them off a cliff, and watch them shatter. So it goes."
},
{ // 410
"Ever cautious, you make your way to a portable temple/headquarters. You have long since obtained the green robe and gold sash of a warrior-acolyte, and sneak in easily. Inside, a group of generals and a figure cloaked in black (wearing green sash) mill about. One of the generals wears a green silk tunic over silvery chainmail. If you announce yourself, turn to {385}. If you attack the robed figure, turn to {409}. If you attack the warrior in the green tunic, turn to {406}. If you sneak out now, take 200 ap and turn to {400}."
},
{ // 411
"This adventure is at an end. In addition to any rewards mentioned before, add 250 to your total adventure points. Don't use this character in this book again. If your feet are still itchy with wanderlust and your sword arm in need of exercise, try travelling north to the city of Ptarm and the White Dread Mountains."
},
{ // 412
"The king's army pounces on the troop of raiders you were travelling with. You must fight three soldiers to escape. Each has an MR of 16 and 4 points of armour. Two have bows which they shoot twice before closing to melee. (They have 15 Dexterity. The first found is at medium range, the second at pointblank range.) If you win, [you may take any four weapons or pieces of armour from the book; ]roll 5 dice and multiply times 10 to determine the amount of gold you loot from the bodies.[ You also earn a reputation: if you ever meet king's soldiers, you are recognized and attacked immediately.]\n" \
"  Your raiding days land you far from your original path. Turn to {208} to continue the adventure."
},
{ // 413 (anti-cheat)
"[Reading the scroll does wondrous things for you. All wounds are healed, all curses are eliminated, and all your characteristics are doubled! You also get 2000 ap. ]Now go to {407}."
},
}, dt_wandertext[44] = {
{ // 0 (Table A)
" 2. Bandits. Five bandits with bows surprise you and command you to give them your gold and weapons. Each of the five has an MR of 12, DEX 14, and wear armour worth 4 points. See rules below for missile fire. If you let them have their way, they take your coins, gems and weapons.[..you may, if you wish, try to hide some items by making a L1-SR vs. Luck (20 - LK). You may hide one item for each point you make the roll by. ]If you fight and kill them, you may take their swag (two rolls on the treasure generator)."
},
{ // 1 (Table A)
" 3. Slavers. Like the bandits above, but they carry bolas instead of bows and will take you captive if you surrender. [If a bola hits, you are tripped up and must either spend two combat rounds untangling yourself or fight at half strength for the remainder of the combat. ]Good luck! If you are taken captive, turn to {330}."
},
{ // 2 (Table A)
" 4. Horsemen. A band of four horsemen gallop by. Roll a die to see how they react to you: on a 1-3 they ignore you, on a 4-5 they act like the bandits mentioned above, on a 6 they talk with you[, giving you valuable information which will allow you to cut the travel time through any one paragraph by half]. The horsemen have MRs of 16 apiece; the horses take 16 hits[ but don't fight. You may not run from them unless the horses are killed]. The horsemen have two randomly rolled treasures among them."
},
{ // 3 (Table A)
" 5. Soldiers. Five soldiers from the King of Myre's army stop you. Roll a die to see how they react to you:\n" \
"    1-2: They question you, delaying you for a day and exacting a toll of 5 gp.\n" \
"    3-5: They bring you to their encampment for questioning, delaying you for five days.[ If you have attacked any merchants, soldiers or pilgrims and been recognized, you are jailed. (Turn to {306}).]\n" \
"    6:   You are mistaken for an enemy spy and attacked. The soldiers have MRs of 14 each[; two of them have bows that they will shoot (from near range) if you try to run]."
},
{ // 4 (Table A)
" 6. Highwayman. A colourful rogue, this bandit operates alone. Roll a L1-SR vs. Charisma (20 - CHR); if you make it, he likes you and leaves you alone. If you fail the roll, he asks for your gold, shooting you with his crossbow (DEX 16, from near range[. The bow does 2 dice + 7 adds damage]) if you refuse. In melee, the highwayman has an MR of 16 and has a buckler that takes 3 hits. The rogue has two random treasures and three gems."
},
{ // 5 (Table A)
" 7. Wandering mercenary. A tough soldier of fortune. [For 20 gold pieces, he will accompany you until the next combat, fight alongside you, then leave. ]He has an MR of 24, and wear armour that takes 8 points per round. [If you run out of a combat in which he is involved, he will appear the next time you roll up a wandering mercenary and attack you. ]He has no money."
},
{ // 6 (Table A)
" 8. An old man dressed in blue. See paragraph {232}."
},
{ // 7 (Table A)
" 9. Grizzled fighter with bagpipes. A bearded man wearing a weirdly patterned kilt approaches you. He seems to be under attack by a horrid, screaming monster that is clinging to his neck. Roll two L2-SRs, one on Intelligence (25 - IQ) and one on Luck (25 - LK). If you make both, you know about bagpipes and may treat the man like a mercenary (see entry #7 above). If you fail one, you laugh and make the man your sworn enemy; [every time you encounter him ]he will attack until you run away or kill him. If you fail both rolls, you run away in horror[, dropping any one piece of equipment or weapon in your haste]."
},
{ // 8 (Table A)
"10. Cloaked horseman. Only occurs once. If you roll this encounter again, treat it as though you've met another wandering mercenary (see above). If this is the first time you've rolled this encounter, see {251}."
},
{ // 9 (Table A)
"11. Amazon. Roll a die to see how she reacts to you. Add 2 to the roll if your character is female:\n" \
"    1-3: The warrior woman is in a bad mood and attacks you.\n" \
"    4-5: She verbally abuses you and tells you she will attack you if she sees you \"following her\" again (if you run into an amazon again, subtract 3 from this roll).\n" \
"    6-8: The amazon is looking for a party of bandits[; she will ride with you and help you in combat until you run into bandits or enter the temple valley].\n" \
"The amazon has an MR of 20, DEX of 15, and has a long bow (4 dice + 3 adds)."
},
{ // 10 (Table A)
"12. A campsite. In a patch of light woods, you see the smoke of campfires and the hubbub of a busy caravan setting up camp for the night. If you investigate, see {242}."
},
{ // 11 (Table B)
"2. Large caravan. A long chain of wagons, horses and other travellers pass by. Luckily, they are going in your direction. If you make a L1-SR vs. Charisma (20 - CHR), you are hired on as a scout for three days. This earns you 30 gp, plus food if you need it. On each day, roll three times for an encounter on Table A. Two MR 12 warriors assist you in clearing up trouble for the caravan. If you don't make the SR, or don't want to be a scout, you may buy food to restock your ration sack for 8 gp."
},
{ // 12 (Table B)
"3. Refugees. Fifteen half-starved people straggle past. If you give them aid, see {244}. If you attack them, see {289}."
},
{ // 13 (Table B)
"4. Pilgrims. You pass a band of pilgrims, dressed in simple robes and sandals. Their few possessions are wrapped in bundles tied to their walking sticks. fearing bandits, they stare at you apprehensively as you approach. Roll a die: if a 1 or 2 comes up, the pilgrims are wearing green robes and you turn now to {318}. If they are not wearing green robes, you may attack them ({293}), or offer your protection for the day's travels (see {254})."
},
{ // 14 (Table B)
"5. Isolated farm. You pass by an isolated farm. If your rations were stolen or ruined, you may buy food here for 4 gp. If this is the first time you've rolled this encounter, you may press the farmer for information. (See {265})."
},
{ // 15 (Table B)
"6. Peddler. You pass by a wandering peddler. He offers to sell you equipment and weapons (if you want a weapon, roll a die: on a roll of 1, he has the requested item in stock. Prices are half again normal), and has a vial of potion for sale. If you buy it (it costs 100 gp), go to {272}. If you attack the peddler for the portion or his outrageous prices, {257}."
},
{ // 16 (Table B)
"7. Slavers. A coffle of slaves led by a gang on nasty-looking slave-traders pass by. You may attack them (see Table A for a description of the slavers), or buy slaves. Weak and unskilled, these slaves cost 100 gp each and are only good for carrying things (100# apiece). If you get into a combat while with slaves, roll a die: on a 1-3, they run away; on a 4-5, they fight for you with an MR of 8; on a 6, they join the opposition with an MR of 8."
},
{ // 17 (Table B)
"8. Trading post. See {311}."
},
{ // 18 (Table B)
"9. Mugging in progress. You come across four men menacing a fellow traveller. If you want to help, see {286}. If you want to join the muggers, see {249}."
},
{ // 19 (Table B)
"10. Merchant on wagon. A well-fed merchant on a horse-drawn wagon draws near. You may ask him for directions and gossip by going to {260}, or attack him, {280}."
},
{ // 20 (Table B)
"11. Noble with retinue. A duke and seven followers ride towards you on horseback. If you approach and talk with them, see {273}. If you attack, see {263}. If you run away, you become \"suspicious\" and will be attacked by any soldiers or nobles when you encounter them."
},
{ // 21 (Table B)
"12. An army is on the move in this area. Men on horses, foot soldiers, and dozens of carts stir up dust and the sounds of marching songs fill the air. If you approach, roll a die. On a 1-3, see {239}. On a 4-5, see {252}."
},
{ // 22 (Table C)
"2. Dragon on manoeuvres. Flying far overhead is a large dragon. If you wave your arms to attract attention to yourself, see {282}. If you continue walking, see {296}. If you dig yourself into the ground to avoid attention, see {308}."
},
{ // 23 (Table C)
"3. Man riding a pegasus. A man riding a winged steed flies by, just above tree level. If you wave and shout, see {296}. If you shoot an arrow or spell at him (range 60 yards, far range), see {270}."
},
{ // 24 (Table C)
"4. Troll. Large, mean, hungry. The troll spots you and charges; you have time to get off one missile or spell shot at him before facing his wrath. The troll has an MR of 50, with skin that absorbs 4 hits of damage. Each turn, make a L1-SR vs. Dexterity or Speed (20 - DEX or SPD) to avoid taking 2 hits directly off your Strength due to the troll's tireless blows."
},
{ // 25 (Table C)
"5. A man on a large toad. Passing through a copse of trees, you happen upon a slightly built man dressed in a bright red smock and green stockings sitting in the saddle of a gigantic, sad-eyed toad. The fellow sneers at you contemptuously from atop his odd, warty mount. You wave politely at the man, who sticks out his tongue at you in response. If you walk on, see {234}. If you talk to the fellow, see {278}. If you attack him, see {291}."
},
{ // 26 (Table C)
"6. Orcish bandits. Four orcs armed with spears attack you, hungry for treasure and slaves. On the first round of combat, the orcs will throw their javelins at you and any others in your party. The orcs have Dexterity 14, and are throwing from near range. The spears do 2 dice + 4 adds damage. The orcs themselves have MRs of 16, with shields that take 4 hits. If you are disabled or surrender to the orcs, they take you to a mine deep in the mountains (see {330})."
},
{ // 27 (Table C)
"7. Wolves. Maddened by a combination of moonlight and evil magic, a pack of wolves hungry for human flesh leaves the woods and swarms about you, howling and slavering. Roll a die and add 3 to find the number of wolves in the pack; each has an MR of 10. [If you have a torch, or a spell that creates fire, you may double your combat roll and automatically do 1 die of hits to any one wolf each turn. ]If you bring the wolves' ears[ to a village], you will get an 8 gp bounty for each."
},
{ // 28 (Table C)
"8. Goblins. Late at night, a group of goblins steal into your camp and make mischief. All of your food is stolen (see food rules) and some items are stolen; roll a die for each piece of equipment or weapon you have. On a roll of 5 or 6, the item is stolen."
},
{ // 29 (Table C)
"9. Starving man. You find a man lying on the ground, unconscious. You get him to shelter and give him food and water. After he awakes, he has some more food...two days' worth! Oddly, you don't mind. Even more oddly, you still don't mind as he continues eating. See {246}."
},
{ // 30 (Table C)
"10. Misty figure. As you get ready for sleep on this night, a misty figure approaches you. If you attack it with weapons, go to {314}. If you use a spell in your defence, see {266}. If you wait to see what happens, see {284}."
},
{ // 31 (Table C)
"11. Giant snake. A HUGE snake, which you took from a distance to be a line of hills, bars your path. You may detour around it, adding a day to your travel time, or try attacking it. If you fight it, see {298}."
},
{ // 32 (Table C)
"12. Werewolf. Looking for victims on which to wreak havoc and sate its blood lust, a long-snouted werewolf slinks towards you on all fours. With hot saliva dripping from fangs protruding beneath horribly human-looking lips, the lycanthrope pounces. It has an MR of 48. Because of its magical nature, only spells and magical or silver-coated weapons harm it permanently. [If you have no magic weapon, you may only defend yourself (if you win a combat round, the werewolf takes no hits). ]If you live more than 6 rounds, the werewolf gives up and leaves, frustrated. [If you take more than 7 hits from the creature, ]you must make a L2-SR vs. Luck (25 - LK) to avoid becoming a werewolf yourself."
},
{ // 33 (Table D)
"1. Pilgrims. You come across devotees to Krestok travelling to the temple in the mountains. Though fanatical, these pilgrims are not openly hostile. If you want to attack them anyway, see {292}. If you approach them to talk, see {318}."
},
{ // 34 (Table D)
"2. Conversion squad. As it is not the most popular faith among the general public, the followers of Krestok are forced to impress many folk to keep their ranks full. You have run into a group of people looking to make converts. There are four guards with an MR of 14, and three green-robed acolytes with nets and MRs of 12. They will demand your surrender (go to {330} if you choose to give up), attacking if you fail to obey.[ On each turn one of the nets is tossed; it hits on a 1-2. Being trapped in a net halves your combat roll and prevents you from running.]"
},
{ // 35 (Table D)
"3. Warriors of Krestok. Eight warrior-priests of the cult of Krestok shuffle past single-file, murmuring a solemn chant. If you wish to attack them, see {299}. If you question them, see {276}."
},
{ // 36 (Table D)
"4. Green dust. The followers of Krestok deal with creatures from other planes on a regular basis. One of these has detected that you hold some hostility to its allies and attacks. A cloud of whirling green dust surrounds you; harsh, loud voices speaking a guttural language howl in your mind. See {294} if you are a fighter or rogue, {313} if a wizard or warrior-wizard."
},
{ // 37 (Table D)
"5. Dancers. A troupe of muscular men and women strut and whirl past you. They are dressed in flowing green robes and wear headpieces made of horse skulls. From their chanting, you guess that they belong to an offshoot of the Krestok cult. If you dance along with them, see {331}. If you attack them while they prance and leap, see {302}."
},
{ // 38 (Table D)
"6. A figure dressed in black, with a bright green sash tied about its waist, approaches. It stops before you and raises a hand before you. \"Where may I find the plain of obelisks?\" it asks in a gravelly whisper. If you [know and ]tell it, see {303}. If you don't know, or attack the apparition, see {321}."
},
};

MODULE SWORD dt_exits[DT_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {   9,  20,  28,  -1,  -1,  -1,  -1,  -1 }, //   1
  {   4,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  30,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  10,  38,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {   3,  23,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  10,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {   4,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  32,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  18,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  32,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {   4,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  {   4,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  48,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  44,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  78,  45,  60,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  18,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  64,  62,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {   5,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  61,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  25,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  50, 382,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {  59,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  26,   7,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  29,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  55,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {  68, 116,  72,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  19,  62,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  61, 189,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  22,  47,  37,  90,  -1,  -1,  -1,  -1 }, //  57
  {  61, 189,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  32,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  84,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  61,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  { 400, 350, 381,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  70,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {  61, 189,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  { 116, 140, 114, 106,  -1,  -1,  -1,  -1 }, //  72
  { 216,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {  58,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  54,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  { 109,  85,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  41,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  89,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  { 166,  94,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  89,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {  66,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  { 216,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  66,  60, 280,  45,  22,  -1,  -1,  -1 }, //  90
  { 121,  86,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {  43,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  { 104,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  {  54,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  { 127, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {  98,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  {  95,  72, 138,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  72, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  { 113, 105,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  {  72, 107,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  { 140,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {  72,  95,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  {  95,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  { 128, 135, 146,  -1,  -1,  -1,  -1,  -1 }, // 119
  { 137, 143, 152, 157, 164, 172, 179, 186 }, // 120
  { 145, 141, 184,  -1,  -1,  -1,  -1,  -1 }, // 121
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  { 203, 149, 187,  -1,  -1,  -1,  -1,  -1 }, // 123
  { 145,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  { 207,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  { 119,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  { 203,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  { 114, 120,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  { 213,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  { 120, 107,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  { 130, 148, 155,  -1,  -1,  -1,  -1,  -1 }, // 134
  { 231,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  { 191, 184,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  { 106, 145,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  { 136, 169, 121,  -1,  -1,  -1,  -1,  -1 }, // 141
  { 194,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  { 121, 150, 138,  -1,  -1,  -1,  -1,  -1 }, // 145
  { 112, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147*
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  {  31,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  { 145, 160, 122,  -1,  -1,  -1,  -1,  -1 }, // 150
  { 223,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  { 198, 174,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  { 215, 151,  24,  -1,  -1,  -1,  -1,  -1 }, // 156
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157
  { 182, 212,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  { 149, 203,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  { 202, 158,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161
  { 181, 174, 153,  -1,  -1,  -1,  -1,  -1 }, // 162
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  { 107, 177,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  {  94,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  { 198, 174, 153,  -1,  -1,  -1,  -1,  -1 }, // 167
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168
  { 177,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  { 190, 175,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  { 213, 197, 210,  -1,  -1,  -1,  -1,  -1 }, // 171
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  { 192,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  { 198, 153, 159,  -1,  -1,  -1,  -1,  -1 }, // 175
  { 163, 210,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  { 183, 123, 187,  -1,  -1,  -1,  -1,  -1 }, // 177
  { 200, 173,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  { 194,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  { 218,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  { 156, 133, 177,  -1,  -1,  -1,  -1,  -1 }, // 183
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  { 210,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  { 129,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187
  { 170, 196, 120,  -1,  -1,  -1,  -1,  -1 }, // 188
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191
  { 200,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192
  { 120,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193
  { 223,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194
  { 200, 173,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195
  { 120, 162,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196
  { 213,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197
  { 126,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198
  { 241,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199
  { 228,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200
  { 171, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201
  { 205, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202
  { 180,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203
  { 221, 217,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204
  { 144, 218,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205
  { 214, 248,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206
  {  24, 194,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207
  { 345, 224,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208
  { 228,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209
  { 213,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211*
  { 218, 139,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213
  { 248,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214
  { 125,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215
  { 233,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217
  { 168,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218
  { 163, 210,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220*
  { 217,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221
  { 225,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222
  { 230, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223
  { 235,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224
  { 248,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 225
  { 217, 204,  -1,  -1,  -1,  -1,  -1,  -1 }, // 226
  { 248,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 227
  { 154,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 228
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 229*
  { 219, 201,  -1,  -1,  -1,  -1,  -1,  -1 }, // 230
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 231
  { 243, 234, 258, 268,  -1,  -1,  -1,  -1 }, // 232#
  { 245, 248,  -1,  -1,  -1,  -1,  -1,  -1 }, // 233
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 234#
  { 345,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 235
  { 255,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 236
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 237#
  { 228,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 238
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 239!
  { 248,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 240
  { 344,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 241
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 242#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 243#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 244!
  { 206, 248,  -1,  -1,  -1,  -1,  -1,  -1 }, // 245
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 246#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 247#
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 248
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 249!
  { 255, 248,  -1,  -1,  -1,  -1,  -1,  -1 }, // 250
  { 261, 269, 290,  -1,  -1,  -1,  -1,  -1 }, // 251#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 252!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 253#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 254!
  { 248, 225,  -1,  -1,  -1,  -1,  -1,  -1 }, // 255
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 256#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 257
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 258#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 259#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 260!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 261#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 262#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 263!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 264#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 265!
  { 301, 312,  -1,  -1,  -1,  -1,  -1,  -1 }, // 266#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 267#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 268#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 269#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 270#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 271#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 272!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 273!
  { 256,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 274#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 275#
  { 305, 299,  -1,  -1,  -1,  -1,  -1,  -1 }, // 276#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 277#
  { 291, 316,  -1,  -1,  -1,  -1,  -1,  -1 }, // 278#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 279#
  { 234, 247, 269,  -1,  -1,  -1,  -1,  -1 }, // 280
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 281#
  { 344,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 282#
  { 285, 259, 267,  -1,  -1,  -1,  -1,  -1 }, // 283#
  { 301, 312,  -1,  -1,  -1,  -1,  -1,  -1 }, // 284#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 285#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 286!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 287!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 288#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 289!
  { 295, 234,  -1,  -1,  -1,  -1,  -1,  -1 }, // 290#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 291#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 292#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 293!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 294#
  { 269, 304,  -1,  -1,  -1,  -1,  -1,  -1 }, // 295#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 296#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 297#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 298#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 299#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 300#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 301#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 302#
  { 338, 321,  -1,  -1,  -1,  -1,  -1,  -1 }, // 303#
  { 279, 247, 354,  -1,  -1,  -1,  -1,  -1 }, // 304#
  { 334, 368,  -1,  -1,  -1,  -1,  -1,  -1 }, // 305#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 306#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 307!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 308#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 309!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 310!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 311!
  { 322,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 312#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 313#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 314#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 315#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 316#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 317!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 318#
  { 329,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 319#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 320!
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 321#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 322#
  { 396, 386,  -1,  -1,  -1,  -1,  -1,  -1 }, // 323
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 324#
  {  62,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 325#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 326
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 327#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 328
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 329#
  { 387, 350,  -1,  -1,  -1,  -1,  -1,  -1 }, // 330
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 331#
  { 384,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 332
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 333!
  { 344,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 334
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 335#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 336#
  { 399, 402, 379,  -1,  -1,  -1,  -1,  -1 }, // 337
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 338#
  { 362,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 339
  { 370,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 340
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 341#
  { 352, 363, 374,  -1,  -1,  -1,  -1,  -1 }, // 342
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 343#
  { 358,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 344
  { 354, 334,  -1,  -1,  -1,  -1,  -1,  -1 }, // 345
  { 374, 369, 363,  -1,  -1,  -1,  -1,  -1 }, // 346
  { 378, 357,  -1,  -1,  -1,  -1,  -1,  -1 }, // 347
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 348#
  { 334,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 349
  { 400, 381,  -1,  -1,  -1,  -1,  -1,  -1 }, // 350
  { 401,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 351
  { 330,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 352
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 353
  { 384, 364,  -1,  -1,  -1,  -1,  -1,  -1 }, // 354
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 355#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 356
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 357
  { 371,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 358
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 359#
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 360
  { 392,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 361
  { 334,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 362
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 363
  { 373, 328,  -1,  -1,  -1,  -1,  -1,  -1 }, // 364
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 365
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 366
  { 394,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 367
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 368#
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 369
  { 350, 381, 400,  -1,  -1,  -1,  -1,  -1 }, // 370
  { 382,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 371
  { 411,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 372
  { 334, 384,  -1,  -1,  -1,  -1,  -1,  -1 }, // 373
  { 395, 387,  -1,  -1,  -1,  -1,  -1,  -1 }, // 374
  { 380,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 375
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 376
  { 381, 350, 340,  -1,  -1,  -1,  -1,  -1 }, // 377
  { 390, 396,  -1,  -1,  -1,  -1,  -1,  -1 }, // 378
  { 366,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 379
  { 389,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 380
  { 361,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 381
  { 342, 363, 399,  -1,  -1,  -1,  -1,  -1 }, // 382
  { 356, 394,  -1,  -1,  -1,  -1,  -1,  -1 }, // 383
  { 393, 351, 401,  -1,  -1,  -1,  -1,  -1 }, // 384
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 385
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 386
  { 399,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 387
  { 411,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 388
  { 397,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 389
  { 396,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 390
  { 406,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 391
  { 400,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 392
  { 401, 323, 339, 378,  -1,  -1,  -1,  -1 }, // 393
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 394
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 395
  { 349,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 396
  { 403,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 397
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 398
  { 346, 369,  -1,  -1,  -1,  -1,  -1,  -1 }, // 399
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 400
  { 347, 365, 376,  -1,  -1,  -1,  -1,  -1 }, // 401
  { 379, 350,  -1,  -1,  -1,  -1,  -1,  -1 }, // 402
  { 133,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 403
  { 411,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 404
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 405
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 406
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 407
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 408
  { 391,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 409
  { 385, 409, 406,  -1,  -1,  -1,  -1,  -1 }, // 410
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 411
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 412
  { 407,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 413
};
/* # = WMT A/C/D (implemented)
   ! = WMT B only (unimplemented)
   * = tentacle beast only (unimplemented) */

MODULE STRPTR dt_pix[DT_ROOMS] =
{ ""     , ""     , ""     , ""     , ""     , "dt5"  , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , "dt42" , ""     , ""     , ""     , ""     , ""     , "dt48" ,  "",
  ""     , ""     , ""     , ""     , "dt54" , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , "dt71" , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , "dt85" , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , "dt95" , ""     , ""     , ""     ,  "",
  "dt100", ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , "dt123", ""     , ""     , ""     , "dt127", ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , "dt135", ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , "dt147", ""     ,  "",
  ""     , ""     , ""     , ""     , "dt154", ""     , ""     , ""     , "dt158",  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  "dt180", ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  "dt200", ""     , ""     , ""     , "dt204", ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , "dt225", ""     , ""     , ""     ,  "",
  ""     , "dt231", ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , "dt251", ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , "dt272", ""     , "dt274", ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , "dt315", ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , "dt326", ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , "dt135", ""     , ""     , ""     , ""     , ""     ,  "",      // this is no mistake
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "dt100", // this is no mistake
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , "dt378",  "",
  ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , ""     , ""     , ""     , "dt158", ""     , "dt398",  "",      // this is no mistake
  ""     , ""     , ""     , ""     , ""     , "dt405", ""     , ""     , ""     ,  "",
  ""     , ""     , ""     , "dt413"
};

MODULE TEXT ansi_dicefaces[5][DICEY][40 + 1] = {
{
"   þ__________________ ",
" þ.·                 .:",
"¶: ¯¯¯¯¯¯¯¯¯¯¯¢¯¯¯¯¯¬: þ|",
"¶|    \\þ'/¶\\ /þ\\`¶/     ¢| þ|",
"¶|þ`¶¯¢·-¶-'þ~~¢Yþ~~`¶-¢-·¯¶'þ·¢| þ|",
"¶|þ\"¶\"¢. þ`o. ¶· þ.o' ¢.\"¶\"þ\"¶| þ|",
"¶|   ¢Y   ¶' `   ¢Y    ¶| þ|",
"¶|   ¢` .     . '    ¶| þ|",
"¶|   ¢',l þ¯Y¯ ¢;,'    ¶| þ|",
"¶|    ¢'¶,lþ-^-¶;,¢'     ¶| þ!",
"¶!     'þ.¯¯¯,¶'      ¶!þ· ",
" ¶¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"      ¢GOAT (1)        ",
},
{
"   þ__________________ ",
" þ.·                 .:",
"¶: ¯¯¯¯¯¯¯¯¯¯¯¢¯¯¯¯¯¬: þ|",
"¶|      §.·~\"\"\"\"ð~.   ¢| þ|",
"¶|    §.·         ð)  ¢| þ|",
"¶|    §l_.`\"\"\",  ð/   ¶| þ|",
"¶|   þ.'¯ . ·§oþ.§·ð(æ__  ¶| þ|",
"¶| þ,; `.\"     ¹---.æ\\ ¶| þ|",
"¶|þ;;;``l  §Y   Y¹¯¯¯~ ¶| þ|",
"¶|þ;;;;` ·-§|   ð|     ¶| þ!",
"¶!þ;;;;;;;,§`._.ð'     ¶!þ· ",
" ¶¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"     ¢ROOSTER (2)      ",
},
{
"   þ__________________ ",
" þ.·                 .:",
"¶: ¯¯¯¯¯¯¯¯¯¯¯¢¯¯¯¯¯¬: þ|",
"¶|/_¢___ ¹.·¯æ¬·¹. ____¶\\¢| þ|",
"¶|.___ ¹~__¬_æ__~ __¢_¶.¢| þ|",
"¶| ¹.--·`. '` æ.'¹·-æ-. ¶| þ|",
"¶|  ¹~~`.þ`¹)`'æ(þ'æ.¹'~~  ¶| þ|",
"¶|  ¹:   Yþ____æY   :  ¶| þ|",
"¶|  ¹|   `þT¯¯Tæ'   |  ¶| þ|",
"¶|  ¹|     þ`'     æ|  ¶| þ!",
"¶!  ¹`            æ'  ¶!þ· ",
" ¶¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"       ¢BULL (3)       ",
},
{
"   þ__________________ ",
" þ.·                 .:",
"¶: ¯¯¯¯¯¯¯¯¯¯¯¢¯¯¯¯¯¬: þ|",
"¶|   ¹.~.      .~.   ¢| þ|",
"¶|   ¹|þ: ¹`\"\"\"\"'  þ:æ|  ¢| þ|",
"¶|   ¹|þ`· ¹`  ' þ·'æ|   ¢| þ|",
"¶|   ¹;.\". \"\" .\".æ|   ¶| þ|",
"¶|  ¹Í  ¢`·    ·'  æÌ  ¶| þ|",
"¶|  ¹:   þ'¹'  æ`þ`   æ:  ¶| þ|",
"¶|  ¹''\"¯Y þ() æY¹¯\"æ``  ¶| þ!",
"¶!     þ//¹·--·þ\\¶\\     !þ· ",
" ¶¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"       ¢FOX (4)        ",
},
{
"   þ__________________ ",
" þ.·                 .:",
"¶: ¯¯¯¯¯¯¯¯¯¯¯¢¯¯¯¯¯¬: þ|",
"¶|      ¢.    .      | þ|",
"¶|      ¢;\\__/l      | þ|",
"¶|þ\\     ¢)ð.¢\"\"ð.¢(     þ/¶| þ|",
"¶| ¯¯¢¯¯¯ .þ`'¢. ¯¯¯¯¯þ·¶| þ|",
"¶|þ.`¯¯\".      .\"¯¯'.¶| þ|",
"¶|      þÌ    Í      ¶| þ|",
"¶|þ.¶·¯¢¯·þ.'.~~.`.¢·¯¶¯·þ.¶| þ!",
"¶!     ¹\"·þ.  .¹·\"     ¶!þ· ",
"¶ ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"       ¢BAT (5)        ",
},
} /* , dicefaces[5][DICEY] = {
// Ì = backwards f, Í = forwards f
{
"   __________________ ",
" .·                 .:",
": ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¬: |",
"|    \\'/\\ /\\`/     | |",
"|`¯·--'~~Y~~`--·¯'·| |",
"|\"\". `o. · .o' .\"\"\"| |",
"|   Y   ' `   Y    | |",
"|   ` .     . '    | |",
"|   ',l ¯Y¯ ;,'    | |",
"|    ',l-^-;,'     | !",
"!     '.¯¯¯,'      !· ",
" ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"      Goat (1)        ",
},
{
"   __________________ ",
" .·                 .:",
": ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¬: |",
"|      .·~\"\"\"\"~.   | |",
"|    .·         )  | |",
"|    l_.`\"\"\",  /   | |",
"|   .'¯ . ·o.·(__  | |",
"| ,; `.\"     ---.\\ | |",
"|;;;``l  Y   Y¯¯¯~ | |",
"|;;;;` ·-|   |     | !",
"!;;;;;;;,`._.      !· ",
" ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"     Rooster (2)      ",
},
{
"   __________________ ",
" .·                 .:",
": ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¬: |",
"|/____ .·¯¬·. ____\\| |",
"|.___ ~__¬___~ ___.| |",
"| .--·`. '` .'·--. | |",
"|  ~~`.`)`'('.'~~  | |",
"|  :   Y____Y   :  | |",
"|  |   `T¯¯T'   |  | |",
"|  |     `'     |  | !",
"!  `            '  !· ",
" ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"       Bull (3)       ",
},
{
"   __________________ ",
" .·                 .:",
": ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¬: |",
"|   .~.      .~.   | |",
"|   |: `""""' :|   | |",
"|   |`· `  ' ·'|   | |",
"|   ;.". "" .".|   | |",
"|  Í  `·    ·'  Ì  | |",
"|  :   ''  ``   :  | |",
"|  ''"¯Y () Y¯"``  | !",
"!     //·--·\\     !· ",
" ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"       Fox (4)        ",
},
{
"   __________________ ",
" .·                 .:",
": ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¬: |",
"|      .    .      | |",
"|      ;\\__/l      | |",
"|\\     ).\"\".(     /| |",
"| ¯¯¯¯¯ .`'. ¯¯¯¯¯·| |",
"|.`¯¯\".      .\"¯¯'.| |",
"|      Ì    Í      | |",
"|.·¯¯·.'.~~.`.·¯¯·.| !",
"!     \"·.  .·\"     !· ",
" ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯   ",
"       Bat (5)        ",
},
} */ ;

MODULE FLAG                   angryamazon,
                              dt_met[39],
                              killedwhirlwind;
MODULE       int              daysdone,
                              evil_mi, evil_dice, evil_adds, evil_armour,
                              good_mi,
                              wanderroom;

IMPORT       FLAG             rawmode,
                              logconsole;
IMPORT       TEXT             userstring[40 + 1];
IMPORT       int              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              evil_attacktotal,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              minutes,
                              spellchosen,
                              spelllevel,
                              room, prevroom, module,
                              target,
                              theround,
                              thethrow,
                              wordwrap;
IMPORT       SWORD*           exits;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct LanguageStruct  language[LANGUAGES];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];
IMPORT struct SpellInfoStruct spellinfo[20 + 1];

IMPORT void (* enterroom) (void);

MODULE void dt_enterroom(void);
MODULE void dt_wandering(int whichtable);
MODULE void dt_givefood(void);
MODULE void dt_treasure(void);
MODULE void battleofwills(FLAG new);
MODULE FLAG dt_fight(FLAG missilable);

EXPORT void dt_preinit(void)
{
#ifdef WIN32
    int i, j, k;
#endif

    descs[MODULE_DT]   = dt_desc;
    wanders[MODULE_DT] = dt_wandertext;

#ifdef WIN32
    for (i = 0; i < 5; i++)
    {   for (j = 0; j < DICEY; j++)
        {   k = 0;
            while (ansi_dicefaces[i][j][k] != EOS)
            {   if (istrouble(ansi_dicefaces[i][j][k]))
                {   // aprintf("%d,%d,%d: $%X!\n", i, j, k, (TEXT) ansi_dicefaces[i][j][k]);
                    ansi_dicefaces[i][j][k] = '!';
                }
                k++;
    }   }   }
#endif
}

EXPORT void dt_init(void)
{   int i;

    exits     = &dt_exits[0][0];
    enterroom = dt_enterroom;
    for (i = 0; i < DT_ROOMS; i++)
    {   pix[i] = dt_pix[i];
    }

    daysdone = 0;
}

MODULE void dt_enterroom(void)
{   TRANSIENT FLAG ok,
                   runnable;
    TRANSIENT int  blind,
                   bonus,
                   created,
                   i,
                   iqbonus, chrbonus,
                   oldcon,
                   oldcountfoes,
                   needed,
                   progress,
                   reserves,
                   result, result2, result3,
                   wounds;
    PERSIST FLAG   fought,
                   guide,
                   swapped;
    PERSIST int    armysize,
                   startminutes,
                   villages;

    switch (room)
    {
    case 0:
        dt_givefood();
        villages = 0;
        angryamazon = guide = killedwhirlwind = swapped = FALSE;
        startminutes = minutes;
        for (i = 0; i < 39; i++)
        {   dt_met[i] = FALSE;
        }
    acase 1:
        pay_gp_only(1); // %%: maybe just do pay_cp(130); instead of these lines
        pay_sp_only(3);
    acase 2:
        guide = TRUE;
    acase 3:
        give(119);
        give_multi(120, 3);
    acase 4:
        result = getnumber("Buy how many feet of hemp rope", 0, money / 20); // 2 sp per foot
        pay_cp(result * 20);
        give_multi(155, result);
        if (money >= 1200 && getyn("Buy piton & hammer set")) // 12 gp
        {   pay_gp(12);
            give_multi(PIT, 10); // %%: we assume there are 10 in a set, same as in the rulebook
            give(PTH);
        }
    acase 5:
        getsavingthrow(TRUE);
        if (class == ROGUE) thethrow += 6;
        if (!madeit(2, chr))
        {   room = 23;
        }
    acase 6:
        create_monster(534);
        create_monsters(535, 2);
        create_monsters(536, 2);
        create_monster(537);
        if (!castspell(-1, TRUE))
        {   if (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE)) // %%: it doesn't say what range
                {   evil_takemissilehits(target);
        }   }   }
        runnable = TRUE;
        oldcountfoes = countfoes();
        do
        {   if (runnable && getyn("Run") && saved(1, spd))
            {   dispose_npcs();
                room = 10;
            }
            oneround();
            if (countfoes() < oldcountfoes)
            {   runnable = TRUE;
            } else
            {   runnable = FALSE;
            }
            oldcountfoes = countfoes();
        } while (countfoes() && con >= 1);
    acase 7:
        for (i = 0; i < 3; i++)
        {   if (room == 7 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case 1: case 2: dt_wandering(TABLE_A);
                acase 6:        dropitem(ITEM_DT_RATIONS);
                }
                if (room == 7)
                {   daysdone++;
        }   }   }
        if (room == 7 && daysdone == 3)
        {   daysdone = 0;
            result = dice(1);
            if (guide) result++;
            switch (result)
            {
            case  1: case 2:         room = 36;
            acase 3: case 4: case 5: room = 49;
            acase 6: case 7:         room = 55;
        }   }
    acase 8:
        pay_gp(30);
        guide = TRUE;
    acase 9:
        if (gp < 6)
        {   room = 1;
        } else
        {   dt_gamble();
        }
    acase 10:
        progress = 0;
        do
        {   getsavingthrow(TRUE);
            if
            (   (items[PIT].owned && items[PTH].owned) // %%: the need for PTH (piton hammer) isn't explicitly stated
             || gotrope(1)
             || canfly(TRUE)
            )
            {   thethrow += 4;
            }
            if (madeit(2, (lk + dex) / 2))
            {   elapse(ONE_DAY, TRUE);
                progress++;
            } elif (misseditby(2, (lk + dex) / 2) < iq)
            {   elapse(ONE_DAY, TRUE);
            } else
            {   templose_con(dice(2)); // %%: does a day elapse? We assume not.
        }   }
        while (progress < 5 && con >= 5);
        if (con < 5)
        {   room = 14;
        }
    acase 11:
        savedrooms(1, lk, 58, 71);
    acase 12:
        give(ITEM_DT_KEY);
        give(ITEM_DT_MAP);
        // %%: perhaps let them take the dart too?
    acase 13:
        die();
    acase 14: // %%: this paragraph is phrased ambiguously
        if (con < 10)
        {   heal_con(10 - con);
        } else
        {   healall_con();
        }
        pay_cp(money);
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && items[i].type == JEWEL)
            {   dropitems(i, items[i].owned);
        }   }
        dropitem(ITEM_DT_RATIONS);
    acase 15:
        if (getyn("Let them throw you (otherwise fight)"))
        {   if (saved(1, lk))
            {   gain_flag_ability(153);
            } else
            {   room = 405;
        }   }
        else
        {   room = 353;
        }
    acase 16:
        pay_gp(100);
        guide = TRUE;
    acase 17:
        if (daysdone == 0)
        {   guide = FALSE;
            dropitem(ITEM_DT_RATIONS);
        }
        for (i = 0; i < 5; i++)
        {   if (room == 17 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1)) // %%: it doesn't say whether we check for an encounter every day or just once. We assume every day.
                {
                case  1:         dt_wandering(TABLE_A);
                acase 2: case 3: dt_wandering(TABLE_D);
                }
                if (room == 17)
                {   daysdone++;
        }   }   }
        if (room == 17 && daysdone == 5)
        {   daysdone = 0;
        }
    acase 18:
        if (getyn("Hire a guide"))
        {   dicerooms(2, 2, 8, 8, 8, 16);
        }
    acase 19:
        dicerooms(27, 27, 34, 34, 34, 51);
    acase 20:
        pay_sp_only(1);
    acase 24:
        award(200);
        failmodule();
    acase 25:
        give_gp(2);
        give(ITEM_DT_MAP);
        // %%: give dart?
        // %%: give adventurer's sword?
    acase 26:
        elapse(ONE_DAY * 2, TRUE);
    acase 29:
        if
        (   items[ITEM_DT_KEY].owned
         || items[880].owned
         ||  cast(SPELL_BM, TRUE)
         || (cast(SPELL_KK, TRUE) && spelllevel >= 4)
        )
        {   room = 42;
        }
    acase 30:
        give_gp(150);
        give(596);
        if (saved(2, dex))
        {   room = 40;
        } else
        {   create_monster(541);
            do
            {   oneround();
            } while (st >= 7 && con >= 7 && npc[0].mr >= 7);
            if (st < 7 || con < 7)
            {   room = 48;
            } else
            {   room = 40;
        }   }
    acase 31:
        award(500);
        failmodule();
    acase 32:
        dt_givefood();
    acase 33:
        // %%: advance some time?
    acase 34:
        give_multi(878, 2);
        dt_givefood();
    acase 35:
        pay_gp(gp / 2);
        failmodule();
    acase 36:
        for (i = 0; i < 4; i++)
        {   if (room == 36 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case  1: dt_wandering(TABLE_C);
                acase 6: dropitem(ITEM_DT_RATIONS);
                }
                if (room == 36)
                {   daysdone++;
        }   }   }
        if (room == 36 && daysdone == 4)
        {   daysdone = 0;
        }
    acase 37:
        elapse(ONE_DAY, TRUE);
    acase 38:
        // %%: advance some time?
        if (getyn("Leave now"))
        {   room = 10;
        } else
        {   getsavingthrow(TRUE);
            if (race == DWARF || race == GNOME) thethrow += 3;
            if (madeit(2, chr))
            {   room = 23;
            } else
            {   room = 21;
        }   }
    acase 39:
        // %%: it doesn't say whether we are allowed to shoot/cast at them, we assume so.
        if (getyn("Run"))
        {   if (lk > spd)
            {   if (saved(2, lk))
                {   room = 69;
            }   }
            else
            {   if (saved(2, spd))
                {   room = 69;
        }   }   }
        // %%: it doesn't say when and how often we can run, and what happens if we fail
        // We assume you can just run once at the start, and there is no penalty for failure
        if (room == 39)
        {   create_monsters(542, 4);
            // sayround();
            for (i = 0; i < 4; i++)
            {   getsavingthrow(FALSE);
                if (thethrow >= 19)
                {   good_takehits(dice(2) + 4, TRUE);
            }   }
            if (!castspell(-1, TRUE) && shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_FAR, SIZE_LARGE, FALSE))
                {   evil_takemissilehits(target);
            }   }
            if (countfoes())
            {   // sayround();
                for (i = 0; i < 4; i++)
                {   if (npc[i].mr)
                    {   getsavingthrow(FALSE);
                        if (thethrow >= 9)
                        {   good_takehits(dice(2) + 4, TRUE);
                }   }   }
                if (!castspell(-1, TRUE) && shooting())
                {   target = gettarget();
                    if (target != -1 && shot(RANGE_NEAR, SIZE_LARGE, FALSE))
                    {   evil_takemissilehits(target);
                }   }
                if (countfoes())
                {   // sayround();
                    for (i = 0; i < 4; i++)
                    {   if (npc[i].mr)
                        {   getsavingthrow(FALSE);
                            if (thethrow >= 5)
                            {   good_takehits(dice(2) + 4, TRUE);
                    }   }   }
                    if (!castspell(-1, TRUE) && shooting())
                    {   target = gettarget();
                        if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE))
                        {   evil_takemissilehits(target);
                    }   }
                    while (countfoes())
                    {   oneround();
            }   }   }
            give_gp(dice(4));
        }
    acase 40:
        dispose_npcs();
        give(ITEM_DT_KEY);
        give(ITEM_DT_MAP);
        gain_flag_ability(154);
    acase 41:
        for (i = 0; i < 4; i++)
        {   if (room == 41 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case  1: dt_wandering(TABLE_A);
                }
                if (room == 41)
                {   daysdone++;
        }   }   }
        if (room == 41 && daysdone == 4)
        {   daysdone = 0;
        }
    acase 42:
        if (makelight() == LIGHT_NONE)
        {   if (saved(1, dex))
            {   savedrooms(1, dex, 107, 100);
            } else
            {   DISCARD saved(1, dex);
                room = 117;
        }   }
    acase 43:
        elapse(ONE_DAY * 3, TRUE);
        result = dice(1);
        if (guide) result++;
        if (result <= 2) room = 56; elif (result <= 5) room = 73; else room = 81;
    acase 44:
        if (prevroom != 53)
        {   create_monster(543);
        }
        while (countfoes())
        {   if (cast(-1, TRUE))
            {   room = 53;
            } else
            {   oneround();
        }   }
        give(879);
        give(880);
    acase 45: // %%: ambiguous paragraph
        getsavingthrow(TRUE);
        if (prevroom == 90)
        {   thethrow += 4;
        }
        room = 66;
        if (iq > chr)
        {   if (madeit(2, iq))
            {   room = 115;
            } elif (misseditby(2, iq) < 10)
            {   room = 22;
        }   }
        else
        {   if (madeit(2, chr))
            {   room = 115;
            } elif (misseditby(2, chr) < 10)
            {   room = 22;
        }   }
    acase 47:
        elapse(ONE_DAY, TRUE);
        create_monsters(544, 2);
        // sayround();
        if (!castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_NEAR, SIZE_LARGE, FALSE))
            {   evil_takemissilehits(target);
        }   }
        while (countfoes())
        {   if (getyn("Slip away"))
            {   dispose_npcs();
                room = 22;
            } else
            {   oneround();
        }   }

    acase 48:
        dispose_npcs();
        // %%: does "binding any wounds" mean we get healed?
        give(ITEM_DT_MAP);
        give(ITEM_DT_KEY);
        if (getyn("Accept quest"))
        {   gain_flag_ability(155);
        } else
        {   lose_chr(5);
            room = 35;
        }
    acase 49:
        villages++;
        if (!items[ITEM_DT_RATIONS].owned && money >= 800 && getyn("Buy food"))
        {   pay_gp(8);
            dt_givefood();
        }
        if (money >= 300)
        {   result = getnumber("Rest how many days", 0, money / 300);
            pay_gp(result * 3);
            elapse(ONE_DAY * result, TRUE);
            heal_con(result);
        }
        if (money >= 500 && getyn("Hire fisherman"))
        {   pay_gp(5);
            room = 62;
        }
    acase 50:
        if (minutes < startminutes + (ONE_DAY * 30))
        {   room = 57;
        } else
        {   room = 63;
        }
    acase 51:
        give(878); // %%: apparently we only get one dose, unlike at DT34
        give(881);
    acase 52:
        for (i = 0; i < 5; i++)
        {   if (room == 52 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case  1: dt_wandering(TABLE_C);
                }
                if (room == 52)
                {   daysdone++;
        }   }   }
        if (room == 52 && daysdone == 5)
        {   daysdone = 0;
            if (getyn("Take shortcut"))
            {   guide = FALSE;
                room = 47;
        }   }
    acase 53:
        if
        (   spellchosen == SPELL_RE
         || spellchosen == SPELL_WO
         || spellchosen == SPELL_BP
        ) // %%: what about TF, AS, MJ, ZX, SC, S6, GL, W2, etc. spells?
        {   dispose_npcs();
        } elif (!spell[spellchosen].combat)
        {   good_takehits(dice(5) + 20 - lk, TRUE);
        }
    acase 55:
        elapse(ONE_DAY * 2, TRUE);
    acase 57:
        ; // %%: elapse some time?
    acase 58:
        aprintf("#360:\n%s\n\n", descs[MODULE_DT][360]);
        // %%: how many chances do they get to run? We assume just once, at the beginning.
        wounds = 0;
        if (getyn("Run") && saved(1, spd))
        {   if (dice(1) <= 2)
            {   dropitem(ITEM_DT_RATIONS);
            }
            room = 91;
        } else
        {   create_monsters(545, 6);
            if (!castspell(-1, TRUE) && shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_NEAR, SIZE_LARGE, FALSE)) // %%: it doesn't say what range
                {   evil_takemissilehits(target);
            }   }
            if (countfoes())
            {   if (!castspell(-1, TRUE) && shooting())
                {   target = gettarget();
                    if (target != -1 && shot(RANGE_NEAR, SIZE_LARGE, FALSE)) // %%: it doesn't say what range
                    {   evil_takemissilehits(target);
                }   }
                while (countfoes())
                {   if (dice(1) == 6)
                    {   if (getyn("Take wound"))
                        {   templose_con(1);
                        } else
                        {   wounds++;
                            aprintf("Old man now has %d wounds.\n", wounds);
                        }
                        if (wounds >= 6)
                        {   dispose_npcs();
                    }   }
                    oneround();
            }   }
            if (wounds < 6)
            {   room = 67;
        }   }
    acase 59:
        elapse(ONE_DAY * 2, TRUE);
    acase 60:
        result = dice(1);
        if (prevroom == 22) result += 2;
        switch (result)
        {
        case  1:                 room =  74;
        acase 2: case 3: case 4: room =  82;
        acase 5: case 6:         room =  93;
        acase 7:                 room = 101;
        acase 8:                 room = 108;
        }
    acase 61:
        if (daysdone == 0)
        {   if (prevroom == 56) needed = 2; else needed = 7;
        }
        for (i = 0; i < needed; i++)
        {   if (room == 61 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                result = (st + iq + lk) / 3;
                if (race == ELF) result += 3;
                getsavingthrow(TRUE);
                if (been[67])
                {   thethrow += 10;
                }
                ok = FALSE;
                if (madeit(2, result))
                {   ok = TRUE;
                } elif (misseditby(2, result) >= 6)
                {   room = 71;
                    break;
                }
                switch (dice(2))
                {
                case 7:   dt_wandering(TABLE_C);
                acase 11: dt_wandering(TABLE_D);
                acase 12: dropitem(ITEM_DT_RATIONS);
                }
                if (room == 61 && ok)
                {   daysdone++;
        }   }   }
        if (room == 61 && daysdone == needed)
        {   daysdone = 0;
        }
    acase 62:
        elapse(ONE_DAY, TRUE);
    acase 63:
        if (getyn("Storm temple alone"))
        {   award(1000);
            advance(FALSE);
            room = 340;
        }
    acase 65:
        dt_givefood();
        result = getnumber("Take how many short swords", 0, 99); // %%: how many are here?
        give_multi(SHO, result);
        result = getnumber("Take how many light self bows", 0, 99); // %%: how many are here? And what exactly is meant by a "small" self-bow?
        give_multi(LSB, result);
        give_gp(345);
        give_sp(432);
        rb_givejewels(-1, -1, 1, 4);
        give(373);
    acase 66:
        if (saved(1, spd))
        {   if (saved(1, lk))
            {   room = 78;
            } else
            {   room = 80;
        }   }
        else
        {   DISCARD saved(1, lk);
            room = 80;
        }
    acase 67:
        if (class != WARRIOR)
        {   learnspell(SPELL_D2);
        }
    acase 68:
        if (items[ITEM_DT_ROBE].owned)
        {   room = 91;
        } elif (saved(1, chr))
        {   room = 72;
        } else
        {   room = 95;
        }
    acase 69:
        result = dice(1);
        if (guide) result++;
        if (result <= 2) room = 52; elif (result <= 5) room = 83; else room = 56;
    acase 70:
        result = dice(3) - lk - iq;
        if (sex == MALE) result += chr;
        if (result <= 0) room = 79; elif (result <= 6) room = 87; elif (result <= 12) room = 92; else room = 99;
    acase 71:
        die();
    acase 73:
        for (i = 0; i < 4; i++)
        {   if (room == 73 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case  1: dt_wandering(TABLE_A);
                acase 2: dt_wandering(TABLE_C);
                }
                if (room == 73)
                {   daysdone++;
        }   }   }
        if (room == 73 && daysdone == 4)
        {   daysdone = 0;
        }
    acase 74:
        give(ITEM_DT_ROBE);
        dt_givefood();
        give(903);
    acase 75:
        elapse(ONE_DAY, TRUE);
    acase 77:
        if (getyn("Run away"))
        {   award(50);
            room = 89;
        }
    acase 78:
        result = dice(1);
        if   (items[ITEM_DT_ROBE].owned) result += 4;
        elif (prevroom == 280          ) result += 2;
        if (result <= 3) room = 88; elif (result <= 5) room = 98; elif (result <= 7) room = 103; else room = 111;
    acase 79:
        award(25);
    acase 80:
        create_monsters(546, 4);
        create_monster(547);
        do
        {   if (getyn("Run"))
            {   getsavingthrow(TRUE);
                thethrow += (5 - countfoes()) * 2;
                if (madeit(1, spd))
                {   dispose_npcs();
                    room = 22;
            }   }
            if (room == 80)
            {   oneround();
            }
            if (countfoes() && getyn("Surrender"))
            {   dispose_npcs();
                room = 112;
        }   }
        while (countfoes());
    acase 81:
        elapse(ONE_DAY, TRUE);
        if (getyn("Climb"))
        {   getsavingthrow(TRUE);
            if
            (   (items[PIT].owned && items[PTH].owned) // %%: the need for PTH (piton hammer) isn't explicitly stated
             || gotrope(1)
            )
            {   thethrow += 3;
            }
            if (madeit(2, dex))
            {   room = 77;
        }   }
    acase 82:
        create_monster(582);
        do
        {   if (!saved(1, lk))
            {   templose_con(2);
            }
            oneround();
        } while (countfoes());
        give(ITEM_DT_ROBE);
        give(PON);
        // %%: what kind of poison? Should we give the player some?
    acase 83:
        // %%: we assume the "day of wandering" is part of the "total of three days".
        for (i = 0; i < 3; i++)
        {   if (room == 83 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case  1: dt_wandering(TABLE_C);
                acase 2: dt_wandering(TABLE_D);
                }
                if (room == 83)
                {   daysdone++;
        }   }   }
        if (room == 83 && daysdone == 3)
        {   daysdone = 0;
        }
    acase 85:
        gain_iq(iq / 2);
        gain_lk(6);
        gain_flag_ability(160); // %%: it doesn't say how this can be healed/cured
    acase 86:
        elapse(ONE_HOUR * 5, TRUE);
        award(500);
        failmodule();
    acase 87:
        elapse(ONE_DAY * 30 * dice(2), TRUE);
        set_language(LANG_RAT   , 2); // rodents
        set_language(LANG_DOG   , 2); // foxes
        set_language(LANG_WEASEL, 2); // weasel
        failmodule();
    acase 89:
        for (i = 0; i < 3; i++)
        {   if (room == 89 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case  1: dt_wandering(TABLE_A);
                acase 2: dt_wandering(TABLE_C);
                }
                if (room == 89)
                {   daysdone++;
        }   }   }
        if (room == 89 && daysdone == 3)
        {   daysdone = 0;
        }
    acase 91:
        elapse(ONE_HOUR * 9, TRUE);
    acase 92:
        elapse(ONE_DAY * 14, TRUE);
        pay_cp(money);
        for (i = 0; i < ITEMS; i++)
        {   if (i != CLO && i != ITEM_DT_MAP)
            {   dropitems(i, items[i].owned);
        }   }
    acase 93:
        create_monster(582);
        do
        {   if (theround && theround % 2 == 0) // remember theround hasn't been advanced yet
            {   create_monster(548);
            }
            if (getyn("Surrender"))
            {   dispose_npcs();
                room = 112;
            }
            if (npc[0].mr && !saved(1, lk))
            {   templose_con(2);
            }
            oneround();
        } while (countfoes() && con >= 6 && st >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 112;
        }
    acase 94:
        elapse(ONE_DAY, TRUE);
        villages++;
        dt_givefood();
    acase 95:
        result = dice(1);
        if (items[ITEM_DT_ROBE].owned) result += 2;
        if (prevroom == 95) result += 3;
        if (result <= 3) room = 102; elif (result <= 5) room = 110; elif (result <= 7) room = 118; else room = 124;
    acase 96:
        for (i = 0; i < SPELLS; i++)
        {   spell[i].known = FALSE;
        }
        permchange_st(20);
        change_dex(20);
        permchange_con(16);
        change_chr(15);
        change_spd(25);
        set_language(LANG_WIZARD, 2);
        gain_flag_ability(1);
        race = PHOENIX;
        changerace();
        failmodule(); // %%: should we award the standard 100 ap?
    acase 97:
        elapse(ONE_DAY * 2, TRUE);
    acase 98:
        create_monster(549);
        do
        {   if (dice(1) >= 5)
            {   dispose_npcs();
                room = 66;
        }   }
        while (countfoes());
    acase 99:
        die();
    acase 101:
        if (iq > lk)
        {   savedrooms(1, iq, 115, 108);
        } else
        {   savedrooms(1, lk, 115, 108);
        }
    acase 103:
        if (getyn("Pay bribe"))
        {   pay_gp_only(gp);
            pay_sp_only(sp);
            room = 54;
        }
    acase 104:
        // %%: it talks about becoming disabled, but not what to do in that case!
        create_monster(550);
        created = 1;
        do
        {   if (getyn("Run") && saved(1, spd))
            {   dispose_npcs();
                room = 69;
            } else
            {   oneround();
        }   }
        while (countfoes() && theround < 4);
        if (room == 104)
        {   if (!countfoes())
            {   room = 65;
            } else
            {   do
                {   if (countfoes() < 4)
                    {   create_monster(551);
                        created++;
                    }
                    if (getyn("Run") && saved(1, spd))
                    {   dispose_npcs();
                        room = 69;
                    } else
                    {   oneround();
                }   }
                while (room == 104 && created - countfoes() < 7);
        }   }
    acase 105:
        goodattack();
        if (good_attacktotal >= 20)
        {   room = 72;
        } else
        {   room = 95;
        }
    acase 107:
        if (!been[231] && getyn("Enter chamber"))
        {   room = 119;
        }
    acase 109:
        if (ability[43].known || saved(4, lk))
        {   room = 96;
        } else
        {   die();
        }
    acase 110:
        if (makelight() == LIGHT_NONE)
        {   room = 100;
        } else
        {   room = 114;
        }
    acase 112:
        drop_all(); // %%: this is merely implied rather than stated
        iqbonus = chrbonus = 0;
        do
        {   elapse(ONE_DAY, TRUE);
            getsavingthrow(TRUE);
            thethrow += iqbonus;
            if (madeit(2, iq))
            {   getsavingthrow(TRUE);
                thethrow += chrbonus;
                if (madeit(2, chr))
                {   give(TOR);
                    room = 130;
                } else
                {   iqbonus++;
            }   }
            else
            {   result = misseditby(2, iq);
                getsavingthrow(TRUE);
                thethrow += chrbonus;
                if (madeit(2, chr))
                {   chrbonus++;
                } elif (result > 5 || misseditby(2, chr) > 5)
                {   room = 119;
        }   }   }
        while (room == 112);
    acase 113:
        savedrooms(3, dex, 76, 112);
    acase 114:
        if (makelight() == LIGHT_NONE)
        {   room = 100;
        } elif
        (   (items[ITEM_DT_KEY].owned && getyn("Unlock door"))
         || (cast(SPELL_KK, TRUE) && spelllevel >= 2)
        )
        {   room = 134;
        }
    acase 115:
        pay_gp(10);
        // %%: advance some time? And cure hunger, presumably.
    acase 116:
        if (items[ITEM_DT_ROBE].owned && getyn("Proceed"))
        {   room = 145;
        }
    acase 117:
        dicerooms(134, 112, 134, 112, 134, 112);
    acase 118:
        if (getyn("Surrender")) // %%: it doesn't say how many chances we get to surrender; we assume just once at the start.
        {   room = 112;
        } else
        {   create_monsters(549, 2);
            create_monster(548);
            do
            {   oneround();
            } while (countfoes() && con >= 6 && st >= 6);
            if (countfoes())
            {   dispose_npcs();
                room = 112;
        }   }
    acase 120:
        // %%: we should probably check whether they actually have the jail keys
        if (getyn("Named prisoner"))
        {   room = 193;
        } elif (getyn("Taunt men"))
        {   room = 132;
        }
    acase 121:
        if (!items[ITEM_DT_ROBE].owned)
        {   room = 95;
        }
    acase 122:
        create_monsters(552, 3);
        create_monster(553);
        do
        {   oneround();
        } while (countfoes() && st >= 6 && con >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 112;
        }
    acase 125:
        award(500);
        failmodule(); // %%: arguably die() might be more appropriate
    acase 126:
        dispose_npcs();
        give(883);
        give(884);
    acase 128:
        if (getyn("Use Luck (otherwise Speed)"))
        {   if (!saved(2, lk))
            {   die();
            } else
            {   do
                {   ok = FALSE;
                    if (!saved(2, lk))
                    {   ok = TRUE;
                        room = 146;
                    } else
                    {   if (saved(2, lk))
                        {   if (saved(2, lk))
                            {   ok = TRUE;
                        }   }
                        else
                        {   if (!immune_fire()) templose_con(dice(3));
                }   }   }
                while (!ok);
        }   }
        else
        {   if (!saved(2, spd))
            {   die();
            } else
            {   do
                {   ok = FALSE;
                    if (!saved(2, spd))
                    {   ok = TRUE;
                        room = 146;
                    } else
                    {   if (saved(2, spd))
                        {   if (saved(2, spd))
                            {   ok = TRUE;
                        }   }
                        else
                        {   if (!immune_fire()) templose_con(dice(3));
                }   }   }
                while (!ok);
        }   }
    acase 130:
        if (getyn("Obey"))
        {   room = 112;
        } else
        {   create_monster(554);
            do
            {   if (dice(1) == 1)
                {   room = 95;
                }
                oneround();
            } while (countfoes());
            give(SCI); // %%: DT112 says he has a scimitar
            give(RIN); // %%: or perhaps it was leather and he was doubling it to get 4
            give(885);
        }
    acase 135:
        create_monster(555);
        fight();
    acase 137:
        pay_gp_only(gp / 3);
    acase 138:
        if (getyn("Walk across roof"))
        {   getsavingthrow(TRUE);
            if (gotrope(1) || canfly(TRUE))
            {   thethrow += 5;
            }
            if (madeit(2, dex))
            {   room = 162;
            } else
            {   good_takehits(dice(2), FALSE);
                room = 141;
        }   }
    acase 139:
        victory(100); // %%: it doesn't specify any bonus, so we grant the standard bonus
    acase 140:
        if (items[ITEM_DT_ROBE].owned)
        {   bonus = 2;
        } else
        {   bonus = 0;
        }
        do
        {   aprintf
            (   "0: Done\n" \
                "1: Green robe\n" \
                "2: Lamp\n" \
                "3: Bucket\n" \
                "4: Flint\n" \
                "5: Food\n" \
                "6: Rope\n"
            ); // %%: it doesn't say whether they have other things not listed; we assume not.
            result = getnumber("Take which (0 when done)", 0, 6);
            result2 = 1;
            switch (result)
            {
            case  0: result = -1;
            acase 1: result = ITEM_DT_ROBE;
            acase 2: result = LAN;
            acase 3: result = 886;
            acase 4: result = DEP;
            acase 5: result = ITEM_DT_RATIONS;
            acase 6: result = ROP; // %%: we assume they only have hemp rope
                     result2 = getnumber("How many feet", 0, 999);
            }
            if (result == -1)
            {   room = 72;
            } else
            {   if (result == ITEM_DT_RATIONS)
                {   dt_givefood(); // otherwise they could end up with multiple rations
                } else
                {   give_multi(result, result2);
                }
                result3 = dice(1) + bonus;
                if (result3 <= 2)
                {   room = 95;
                } elif (result3 <= 4)
                {   dropitems(result, result2);
                    room = 72;
        }   }   }
        while (room == 140);
    acase 142:
        // %%: we assume "a sharp whistle" refers to a verb rather than a noun.
        give(883);
    acase 143:
        if (been[115])
        {   room = 188;
        }
    acase 144:
        elapse(ONE_DAY * 2, TRUE);
    acase 145:
        give(887);
    acase 146:
        result = 0;
        if (saved(1, chr)) result++;
        if (saved(1, chr)) result++;
        if (saved(1, chr)) result++;
        switch (result)
        {
        case 0:
        case 3:
            die();
        acase 2:
            room = 117;
        }
       // 147 is tentacle-only
    acase 148:
        result = dice(1);
        if (items[ITEM_DT_ROBE].owned)
        {   result += 2;
        }
        if   (result <= 3) room = 130;
        elif (result <= 5) room = 120; // %%: it's ambiguous about how to "free your prisoner"
        else
        {   if (been[115])
            {   room = 143;
            } else
            {   room = 193;
        }   }
    acase 149:
        create_monster(556);
        do
        {   oneround();
        } while (countfoes() && st >= 6 && con >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 13;
        }
    acase 151:
        create_monster(557);
        do
        {   fight();
        } while (countfoes() && st >= 6 && con >= 6 && npc[0].st >= 6 && npc[0].con >= 6);
        if (countfoes() && npc[0].st >= 6 && npc[0].con >= 6)
        {   dispose_npcs();
            room = 125;
        } else
        {   kill_npcs(); // so they get his sword and armour
            give(SAX);
        }
    acase 152:
        result = dice(1);
        if (been[132])
        {   result += 2;
        }
        if (result >= 6)
        {   if (saved(1, con))
            {   create_monster(558);
                oneround();
                if (countfoes())
                {   oneround();
                    if (countfoes())
                    {   oneround();
                        if (countfoes())
                        {   oneround();
                            dispose_npcs();
            }   }   }   }
            else
            {   room = 112; // weapons will get taken at paragraph 112 anyway
        }   }
    acase 153:
        getsavingthrow(FALSE);
        if
        (   (height >  60 && thethrow >=  9)
         || (height <= 60 && thethrow >= 14)
        )
        {   oldcon = con;
            good_takehits(dice(2) + 13, TRUE);
            if (st < 6 || con < 6)
            {   dispose_npcs();
                room = 159;
            } elif (oldcon - con <= 8)
            {   room = 183;
        }   }
        else
        {   room = 183;
        }
    acase 154:
        if (!been[200])
        {   give_gp(126);
            give_sp(487);
            rb_givejewels(-1, -1, 1, 11);
            give(889);
            give(890);
        }
        dt_givefood();
        dropitem(891);
        elapse(ONE_DAY * 5, TRUE);
        victory(1500);
    acase 155:
        savedrooms(1, chr, 120, 130);
    acase 159:
        dispose_npcs();
        if (ability[48].known) // %%: not sure what "charms or spells" they had in mind
        {   if (!saved(3, chr))
            {   room = 13;
        }   }
        else
        {   if (!saved(1, chr))
            {   room = 13;
        }   }
    acase 160:
        result = dice(1);
        if (items[ITEM_DT_ROBE].owned)
        {   result += 2;
        }
        if (result <= 2)
        {   good_takehits(22, TRUE); // %%: are we supposed to decrement the cost of this from his ST?
            room = 122;
        } elif (result <= 4)
        {   room = 122;
        } elif (result <= 6)
        {   room = 141;
        } else
        {   room = 167;
        }
    acase 163:
        create_monster(559);
        oneround();
        if (getyn("Stop fighting"))
        {   dispose_npcs();
            room = 210;
        } else
        {   fight();
            room = 131;
        }
    acase 165:
        give_sp(34);
        give_multi(PON, 2);
        give_multi(SPI, 2);
        give(892);
    acase 166:
        elapse(ONE_DAY, TRUE);
        give(893);
        give(894);
    acase 169:
        switch (dice(1))
        {
        case  1: case 2: case 3: templose_con(dice(1));
        acase 6:                 room = 167;
        }
    acase 170:
        if (prevroom != 179)
        {   room = 179;
        }
    acase 175:
        dicerooms(142, 142, 133, 133, 133, 133);
    acase 176:
        if (castspell(-1, FALSE))
        {   room = 185;
        }
    acase 178:
        if (items[887].owned && getyn("Try something special"))
        {   room = 195;
        }
    acase 181:
        goodattack(); // %%: does it mean to ignore weapon adds? We assume not.
        if (good_attacktotal >= 26)
        {   room = 126;
        } elif (good_attacktotal >= 21)
        {   create_monster(557);
            evil_takehits(0, good_attacktotal);
            room = 198;
        } else
        {   if (getyn("Fight"))
            {   create_monster(557);
                room = 198;
            } else
            {   room = 159;
        }   }
    acase 182:
        templose_con(4);
        if (!saved(2, dex))
        {   if (misseditby(2, dex) > lk)
            {   die();
            } else
            {   good_takehits(misseditby(2, dex), TRUE);
        }   }
        if (!saved(2, dex))
        {   if (misseditby(2, dex) > lk)
            {   die();
            } else
            {   good_takehits(misseditby(2, dex), TRUE);
        }   }
        if (!saved(2, dex))
        {   if (misseditby(2, dex) > lk)
            {   die();
            } else
            {   good_takehits(misseditby(2, dex), TRUE);
        }   }
    acase 183:
        dispose_npcs();
    acase 184:
        if (!items[ITEM_DT_ROBE].owned)
        {   room = 95;
        } else
        {   dicerooms(121, 121, 121, 177, 191, 191); // %%: it doesn't really say where to go on a roll of 1-3
        }
    acase 185:
        give(895);
    acase 187:
        create_monsters(560, 6);
        do
        {   oneround();
        } while (countfoes() && st >= 6 && con >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 159;
        }
    acase 189:
        elapse(ONE_DAY * 2, TRUE);
        aprintf("#408:\n%s\n\n", descs[MODULE_DT][408]);
        // %%: it doesn't say whether they fight simultaneously or in sequence
        evil_mi     = 12;
        evil_dice   =  2;
        evil_adds   =  6;
        evil_armour =  0;
        battleofwills(TRUE);
        if (good_mi < 5)
        {   elapse(ONE_DAY * 7, TRUE);
            room = 354;
        } else
        {   evil_mi     = 12;
         /* evil_dice   =  2;
            evil_adds   =  6;
            evil_armour =  0; */
            battleofwills(FALSE);
            if (good_mi < 5)
            {   elapse(ONE_DAY * 7, TRUE);
                room = 354;
            } else
            {   evil_mi     = 12;
             /* evil_dice   =  2;
                evil_adds   =  6;
                evil_armour =  0; */
                battleofwills(FALSE);
                if (good_mi < 5)
                {   elapse(ONE_DAY * 7, TRUE);
                    room = 354;
                } else
                {   award(30);
                    elapse(ONE_DAY, TRUE);
                    room = 208;
        }   }   }
    acase 190:
        aprintf("#198:\n%s\n\n", descs[MODULE_DT][198]);
        create_monster(557);
        do
        {   oneround();
        } while (countfoes() && st >= 6 && con >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 159;
        } else
        {   room = 142;
        }
    acase 191:
        create_monsters(561, 4);
        reserves = 16;
        do
        {   if (getyn("Surrender")) // %%: at what point(s) are we allowed to surrender?
            {   dispose_npcs();
                room = 112;
                break;
            } else
            {   if (!saved(2, lk))
                {   good_takehits(misseditby(2, lk) / 2, TRUE);
                }
                if (st >= 6 && con >= 6)
                {   oneround();
                    if (countfoes() < 4 && reserves)
                    {   needed = 4 - countfoes();
                        if (reserves >= needed)
                        {   create_monsters(561, needed);
                            reserves -= needed;
                        } else
                        {   create_monsters(561, reserves);
                             reserves = 0;
        }   }   }   }   }
        while (countfoes() && st >= 6 && con >= 6);
        if (room == 191)
        {   if (countfoes())
            {   room = 112;
            } else
            {   room = 165;
        }   }
    acase 192:
        if (getyn("Were you correct"))
        {   room = 209;
        } elif (items[887].owned && getyn("Think of something"))
        {   room = 195;
        }
    acase 193:
        if (been[115])
        {   room = 143;
        }
    acase 195:
        if (items[887].owned && getyn("Swap clubs"))
        {   dropitem(887);
            give(CLU);
            swapped = TRUE;
        }
    acase 197:
        if (money >= 10000 && getyn("Buy map"))
        {   pay_gp(100);
            give(895);
        } elif (getyn("Fight for map"))
        {   room = 257;
        }
    acase 198:
        if (!countfoes()) // in case he and/or some warriors are already alive
        {   create_monster(557);
        }
        if (getyn("Surrender")) // %%: we assume we only get one chance to do this
        {   dispose_npcs();
            room = 159;
        } elif (getyn("Get to ladder")) // %%: we assume we only get one chance to do this
        {   room = 153;
        } else
        {   oneround();
            oneround();
            while (npc[0].con)
            {   if (dice(1) >= 5)
                {   create_monster(566);
                }
                oneround();
        }   }
    acase 199:
        elapse(ONE_DAY, TRUE); // DT241 clarifies the timing situation
        create_monster(567);
        fight();
    acase 200:
        give_gp(126);
        give_sp(487);
        give(889);
        rb_givejewels(-1, -1, 1, 11);
        give(890);
        create_monster(562);
        if (swapped)
        {   room = 238;
        } else
        {   fight();
        }
    acase 202:
        if (!saved(2, dex))
        {   good_takehits(misseditby(2, dex), TRUE);
        }
    acase 206:
        if (canfly(TRUE) && getyn("Fly"))
        {   room = 236;
        } elif (cast(SPELL_RE, FALSE)) // %%: not sure what "similar spells or abilities" they had in mind (there is no extant see-through-rock ability/spell)
        {   room = 227;
        } elif
        (   (items[880].owned && getyn("Tunnel"))
         || cast(SPELL_BM, FALSE)
         || cast(SPELL_BP, FALSE)
         || cast(SPELL_HB, FALSE)
        )
        {   room = 250;
        } else
        {   room = 214;
        }
    acase 209:
        create_monster(562);
        if (swapped)
        {   room = 238;
        } else
        {   fight();
        }
       // 211 is tentacle-only
    acase 213:
        result = dice(1);
        if (items[884].owned || items[895].owned)
        {   result += 2;
        }
        if (result <= 3) room = 226; elif (result <= 5) room = 217; elif (result <= 7) room = 144; else room = 168;
    acase 214:
        if (items[894].owned && getyn("Insert stone")) // %%: presumably this is the "correct stone"
        {   room = 255;
        }
    acase 215:
        if (getyn("Leap"))
        {   if (saved(1, st))
            {   if (saved(1, dex))
                {   room = 151;
                } else
                {   room = 125;
            }   }
            else
            {   DISCARD saved(1, dex);
                room = 125;
        }   }
    acase 216:
        elapse(ONE_DAY, TRUE); // %%: vague about whether a whole day passes or just a night or what
        if (saved(1, chr))
        {   dt_givefood();
            spell_cf(7);
        } else
        {   if (!pay_gp(misseditby(1, chr)))
            {   give_gp(misseditby(1, chr));
        }   }
    acase 217:
        elapse(ONE_DAY * 3, TRUE);
        create_monsters(5, 20);
        do
        {   result = dice(1);
            for (i = 0; i < 20; i++)
            {   if (npc[i].mr && result)
                {   kill_npc(i);
                    result--;
            }   }
            oneround();
        } while (countfoes());
    acase 218:
        give_multi(896, 10);
        award(125);
    acase 219:
        if (castspell(-1, FALSE))
        {   room = 176;
        }
       // 220 is tentacle-only
    acase 221:
        if (saved(1, dex))
        {   if (saved(1, st))
            {   room = 161;
            } else
            {   templose_con(dice(2));
        }   }
    acase 222:
        if (items[881].owned)
        {   room = 248;
        }
    acase 224:
        elapse(ONE_DAY, TRUE);
    acase 225:
        award(100);
        while (room == 225 && getyn("Make a sortie"))
        {   switch (dice(2))
            {
            case 2:
                create_monster(585);
                fight();
            acase 3: case 4:
                create_monster(586);
                fight();
            acase 5: case 6: case 7: case 8: case 9:
                create_monster(587);
                fight();
            acase 10:
                create_monster(588);
                fight();
            acase 11: case 12:
                templose_con(dice(1));
            }
            dt_treasure();
        }
    acase 226:
        elapse(ONE_DAY * 4, TRUE);
    acase 227:
        if
        (   (items[880].owned && getyn("Cut rock")) // %%: what about an ordinary pick axe? I guess not, since they say "magic".
         || cast(SPELL_BM, FALSE)
         || cast(SPELL_BP, FALSE)
         || cast(SPELL_EM, FALSE)// %%: not sure what other "cutting magic" they had in mind. SPELL_DU doesn't work on rock, only earth.
        )
        {   room = 250;
        } elif (saved(4, st))
        {   award(50);
            room = 255;
        }
    acase 228:
        give(891);
       // 229 is tentacle-only
    acase 230:
        elapse(ONE_DAY * 2, TRUE);
    acase 231:
        award(200); // %%: maybe this is instead of, rather than additionally to, the usual ap of killing it
        give_gp(398);
        give_sp(2417);
        rb_givejewels(-1, -1, 1, 7);
        give_multi(ORD, 2);
        give(897);
        if (class == WARRIOR)
        {   give_multi(DRA, 2);
        }
    acase 233:
        elapse(ONE_DAY * 3, TRUE);
    acase 234:
        change_chr(4); // %%: maybe we should implement bags on heads?
        if (prevroom == 271)
        {   room = 256;
        } else
        {   room = wanderroom; daysdone++;
        }
    acase 235:
        elapse(ONE_DAY, TRUE); // %%: ambiguous about elapsed time again
        heal_con((max_con - con) / 2);
        if (money >= 10000 && getyn("Hire boat"))
        {   pay_gp(100);
            room = 199;
        }
    acase 236:
        create_monster(564);
        fight();
    acase 237:
        for (i = 0; i < ITEMS; i++)
        {   if (isarmour(i) || isweapon(i))
            {   dropitems(i, items[i].owned);
        }   }
        dropitem(ITEM_DT_RATIONS);
        gain_flag_ability(156);
        if (getyn("Leave adventure"))
        {   award(200);
            failmodule();
        } else
        {   if (prevroom == 271)
            {   room = 256;
            } else
            {   room = wanderroom; daysdone++;
        }   }
    acase 238:
        fight(); // monster was already created at DT200
    acase 240:
        aprintf("#408:\n%s\n\n", descs[MODULE_DT][408]);
        evil_mi     = 40;
        evil_dice   =  5;
        evil_adds   = 20;
        evil_armour =  4;
        battleofwills(TRUE);
        if (good_mi < 5)
        {   die();
        } else
        {   for (i = 1; i <= 10; i++)
            {   dt_treasure();
            }
            if (evil_mi <= 0) // killed
            {   award(250);
                if (shop_give(10) != -1)
                {   elapse(ONE_DAY * 3, TRUE);
            }   }
            elif (evil_mi < 5) // disabled
            {   award(200);
        }   }
    acase 241:
        award(100); // %%: additional to what we already got from killing it, we assume
        elapse(ONE_DAY, TRUE); // we elapsed the other one at DT199'
    acase 242:
        result = 0;
        for (i = 1; i <= 5; i++)
        {   result2 = dice(1);
            if (result2 == 2 || result2 == 4)
            {   result += result2;
        }   }
        if (!immune_fire())
        {   good_takehits(result, FALSE);
        }
        if (getyn("Attack"))
        {   room = 343;
        } else
        {   room = wanderroom; daysdone++;
        }
    acase 243:
        if (been[243])
        {   heal_con(2);
        } else
        {   healall_con();
            spell_hf();
            spell_cf(6);
        }
        room = wanderroom; daysdone++;
    acase 246:
        savedrooms(2, chr, 253, 262);
    acase 247:
        // %%: perhaps we should require that they actually have a dagger
        if (getyn("Follow"))
        {   room = 354;
        } else
        {   dicerooms(300, 300, 300, 300, 281, 281);
        }
    acase 248:
        for (i = 0; i < 2; i++)
        {   if (room == 248 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                dt_wandering(TABLE_C);
                if (room == 248)
                {   daysdone++;
        }   }   }
        if (room == 248 && daysdone == 2)
        {   daysdone = 0;
        }
    acase 250:
        getsavingthrow(TRUE);
        if (madeit(2, spd))
        {   if (madeitby(2, spd) < 5)
            {   room = 248;
        }   }
        else
        {   templose_con(dice(4));
        }
    acase 253:
        award(120);
        room = wanderroom; daysdone++;
    acase 255:
        if (items[881].owned)
        {   room = 222;
        }
    acase 256:
        if (prevroom == 274)
        {   award(150);
            room = wanderroom; daysdone++;
        } else
        {   // we already got "the arms and armour mentioned above" when we looted the corpse
            dt_givefood();
            give_gp(135);
            give(PON);
            give(DRA);
            give(909);
            if (cast(SPELL_OE, FALSE))
            {   room = 274;
            } else
            {   award(150);
                room = wanderroom; daysdone++;
        }   }
    acase 257:
        create_monster(565);
        fight();
        give_gp(25);
        give(LAN);
        give(OIL);
        give(COM);
        give(CUR);
        if (prevroom == 197)
        {   room = 213;
        } else
        {   room = prevroom;
        }
    acase 258:
        result  = dice(2) + level;
        result2 = dice(2) + 5;
        if (result <= result2)
        {   room = 277;
        } else
        {   create_monster(602);
            if (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE)) // %%: it doesn't say what range
                {   evil_takemissilehits(target);
            }   }
            else
            {   oneround(); // we shouldn't allow spellcasting here (they should've gone to paragraph #268 for that)
            }
            if (countfoes() && npc[0].con >= 6)
            {   dispose_npcs();
                room = 277;
            } else
            {   give(ORD);
                give(CUR);
                give(910);
                room = wanderroom; daysdone++;
        }   }
    acase 259:
        if (getyn("Talk (otherwise run)"))
        {   room = 275;
        } else
        {   if (!saved(1, spd))
            {   create_monsters(603, 2);
                fight();
                if (!saved(1, spd))
                {   create_monsters(603, 2);
                    fight();
            }   }
            room = wanderroom; daysdone++;
        }
    acase 261:
        if (cast(SPELL_BT, FALSE) || cast(SPELL_SF, FALSE))
        {   room = wanderroom; daysdone++;
        } else
        {   if (saved(2, spd))
            {   award(25);
                room = wanderroom; daysdone++;
            } else
            {   if (getyn("Attack (otherwise talk)"))
                {   room = 269;
                } else
                {   room = 290;
        }   }   }
    acase 262:
        dropitem(ITEM_DT_RATIONS);
    acase 264:
        elapse(ONE_DAY * 4, TRUE);
        shop_give(10);
        give_gp(dice(4) * 10);
        if (getyn("Turn on bandits") && dice(1) <= 2)
        {   room = 281;
        } else
        {   room = 412;
        }
    acase 267:
        if (getyn("Talk (otherwise leave"))
        {   room = 275;
        } else
        {   room = wanderroom; daysdone++;
        }
    acase 268:
        result  = dice(2) + level;
        result2 = dice(2) + 5;
        if (result <= result2)
        {   change_iq(3);
            if (getyn("Leave (otherwise fight)"))
            {   room = 234;
            } else
            {   room = 258;
        }   }
        else
        {   create_monster(602);
            castspell(-1, TRUE);
            if (countfoes() && npc[0].con >= 6)
            {   dispose_npcs();
                room = 277;
            } else
            {   give(ORD);
                give(CUR);
                give(910);
                award(50);
                room = wanderroom; daysdone++;
        }   }
    acase 269:
        if (prevroom != 283)
        {   create_monster(604);
            if (castspell(-1, FALSE))
            {   room = 283;
            } elif (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE)) // %%: it doesn't say what range
                {   evil_takemissilehits(target);
        }   }   }
        do
        {   oneround();
        } while (countfoes() && npc[0].st >= 6 && npc[0].con >= 6 && npc[0].iq >= 3); // %%: for SPELL_WL
        if (countfoes())
        {   room = 300;
        } else
        {   room = 256;
        }
    acase 270:
        create_monster(611);
        if (!castspell(-1, TRUE))
        {   if (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE)) // 60' is at near range
                {   evil_takemissilehits(target);
        }   }   }
        if (!countfoes() || npc[0].con <= 7 || npc[0].st < 6)
        {   dispose_npcs();
            award(200);
            room = wanderroom; daysdone++;
        } else
        {   room = 297;
        }
    acase 271:
        dicerooms(256, 256, 256, 234, 234, 237);
        kill_npcs();
    acase 275:
        result = dice(1);
        if (class == ROGUE) result += 2; elif (class == WIZARD) result++;
        if (result <= 3)
        {   room = 285;
        } elif (result <= 6)
        {   elapse(ONE_DAY * 4, TRUE);
            for (i = 1; i <= 5; i++)
            {   shop_give(6); // %%: how is "equipment" defined?
            }
            give_gp(200);
            create_monster(605);
            fight(); // %%: or dt_fight()?
            award(200);
            room = wanderroom; daysdone++; // %%: it doesn't actually say this, maybe we are allowed to stay on
        } else
        {   elapse(ONE_DAY * 12, TRUE);
            give_gp(dice(5) * 10);
            rb_givejewels(-1, -1, 1, 4);
            for (i = 0; i < SPELLS; i++)
            {   if (spell[i].level == 2 && !spell[i].known)
                {   listspell(i, TRUE);
            }   }
            do
            {   i = getspell("Learn which spell (ªENTERª key for none)");
            } while (i != -1 && (spell[i].level != 2 || spell[i].known));
            if (i != -1)
            {   learnspell(i);
            }
            dt_givefood();
            if (getyn("Stay on"))
            {   room = 264;
            } else
            {   room = wanderroom; daysdone++;
        }   }
    acase 277:
        result = dice(1);
        if (result <= 3)
        {   gain_flag_ability(161);
            room = wanderroom; daysdone++;
        } elif (result <= 5)
        {   gain_flag_ability(162);
            room = wanderroom; daysdone++;
        } else
        {   room = 237;
        }
        dispose_npcs();
    acase 278:
        if (getyn("Leave"))
        {   room = wanderroom; daysdone++;
        }
    acase 280:
        if (class != WARRIOR || !getyn("Ambush wagon") || !saved(1, iq + level))
        {   if (!saved(1, spd))
            {   room = prevroom;
        }   }
        if (room == 280)
        {   create_monster(568); // %%: maybe we should do his padded jerkin as an item rather than as skin
            do
            {   oneround();
                if (!saved(1, dex))
                {   templose_con(8);
                    dispose_npcs();
            }   }
            while (countfoes());
            dt_givefood();
            give_multi(ROP, 200); // %%: it doesn't say what kind of rope
            give_multi(ARR, 24);
            give(898);
            if (prevroom == 90)
            {   room = 78;
        }   }
    acase 281:
        elapse(ONE_DAY * 2, TRUE);
        create_monster(606);
        create_monsters(607, 2);
        do
        {   result = dice(1);
            if (result <= 3)
            {   for (i = 1; i <= result; i++)
                {   good_takehits(dice(3), TRUE); // %%: we assume armour counts separately against each bolt
            }   }
            oneround();
        } while (npc[0].mr > 0);
        dispose_npcs();
        for (i = 1; i <= 5; i++)
        {   shop_give(11);
        }
        give_gp(250);
        rb_givejewels(-1, -1, 1, 5);
        award(200);
    acase 283:
        if (daro() < 8)
        {   payload(TRUE);
            if
            (   spellchosen == SPELL_MP
             || spellchosen == SPELL_WL
             || spellchosen == SPELL_DW
             || (countfoes() && npc[0].st < 6 || npc[0].con < 6)
            )
            {   dispose_npcs();
                room = 300;
            } else
            {   if (countfoes())
                {   room = 269;
                } else
                {   room = 256; // %%: it doesn't say this explicitly
        }   }   }
    acase 285:
        // %%: elapse some time?
        getsavingthrow(TRUE);
        if (class == ROGUE || ability[32].known  || cast(SPELL_CC, TRUE))
        {   thethrow += 5;
        }
        if (!madeit(1, lk))
        {   create_monster(608);
            oneround();
            oneround();
            while (countfoes())
            {   if (dice(1) <= 2)
                {   create_monster(607);
                }
                oneround();
        }   }
        give_gp(dice(5) * 10);
        dt_givefood();
        shop_give(10);
        if (getyn("Return woman"))
        {   room = 368;
        } else
        {   room = wanderroom; daysdone++;
        }
    acase 288:
        give(LEA);
        give_gp(118);
        rb_givejewels(-1, -1, 1, 5);
        give(911);
        if (getyn("Take wand"))
        {   room = 324;
        } else
        {   room = wanderroom; daysdone++;
        }
    acase 291:
        create_monster(609);
        do
        {   oneround();
        } while (countfoes() && st >= 6 && con >= 6 && npc[0].st >= 6 && npc[0].con >= 6);
        if (countfoes())
        {   dispose_npcs();
            if (st >= 6 && con >= 6)
            {   room = 348;
            } else
            {   room = 336;
        }   }
        else
        {   room = 355;
        }
    acase 292:
        create_monsters(610, 8);
        do
        {   if (npc[0].mr) { result = dice(1); if (result <= 2) templose_con(result); }
            if (npc[1].mr) { result = dice(1); if (result <= 2) templose_con(result); }
            if (npc[2].mr) { result = dice(1); if (result <= 2) templose_con(result); }
            if (npc[3].mr) { result = dice(1); if (result <= 2) templose_con(result); }
            oneround();
        } while (countfoes() && st >= 6 && con >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 305;
        } else
        {   give_multi(PON, 4);
            give_multi(CUR, 4);
            dt_givefood();
            give(ITEM_DT_KEY); // %%: presumably this is the key that is meant?
            room = wanderroom; daysdone++;
        }
    acase 294:
        aprintf("#408:\n%s\n\n", descs[MODULE_DT][408]);
        evil_mi     = 10;
        evil_dice   =  4;
        evil_adds   =  4;
        evil_armour =  0;
        battleofwills(TRUE);
        if (good_mi < 5)
        {   room = 112;
        } else
        {   award(50);
            if (evil_mi <= 0)
            {   killedwhirlwind = TRUE;
            }
            room = wanderroom; daysdone++;
        }
    acase 296:
        room = wanderroom; daysdone++;
    acase 297:
        if (prevroom != 270)
        {   create_monster(611);
        }
        create_monster(612);
        if (shooting())
        {   target = gettarget(); // %%: we assume we are allowed to shoot the pegasus
            if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE))
            {   evil_takemissilehits(target);
        }   }
        do
        {   if (!npc[0].con)
            {   room = 329;
            } elif (!npc[1].con)
            {   room = 319;
            } else
            {   oneround();
        }   }
        while (room == 297 && st >= 6 && con >= 6);
        if (room == 297)
        {   dispose_npcs();
            room = 306;
        }
    acase 298:
        elapse(15, TRUE);
        room = wanderroom; daysdone++;
    acase 299:
        create_monsters(613, 3);
        if (!castspell(-1, TRUE))
        {   if (shooting())
            {   target = gettarget();
                if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE)) // %%: it doesn't say what range
                {   evil_takemissilehits(target);
        }   }   }
        reserves = 5;
        if (countfoes() < 3)
        {   reserves -= (3 - countfoes());
            create_monsters(613, 3 - countfoes());
        }
        do
        {   oneround();
            if (countfoes() < 3 && reserves)
            {   reserves--;
                create_monster(613);
            }
            if (countfoes() < 3 && reserves)
            {   reserves--;
                create_monster(613);
            }
            if (countfoes() < 3 && reserves)
            {   reserves--;
                create_monster(613);
        }   }
        while (countfoes() && st >= 6 && con >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 305;
        } else
        {   give(ITEM_DT_ROBE);
            give(ITEM_DT_KEY);
            give(915);
            room = wanderroom; daysdone++;
        }
    acase 300:
        award(100);
        if (getyn("Kill him"))
        {   room = 271;
        } else
        {   dispose_npcs();
            room = wanderroom; daysdone++;
        }
    acase 301:
        elapse(ONE_DAY, TRUE);
        award(25);
        room = wanderroom; daysdone++;
    acase 302:
        // %%: it doesn't say how many there are! We assume 4.
        create_monsters(614, 2);
        create_monsters(615, 2);
        do
        {   oneround();
            if (countfoes() && evil_attacktotal >= good_attacktotal + 20)
            {   dispose_npcs();
                room = 305;
        }   }
        while (countfoes());
        if (room == 302)
        {   dt_givefood();
            give_sp(dice(40));
            room = wanderroom; daysdone++;
        }
    acase 304:
        elapse(ONE_DAY * 2, TRUE);
    acase 305:
        daysdone = 0;
        if (dice(1) <= 2)
        {   room = 330;
        }
    acase 306:
        result = dice(1);
        if (chr >= 13) // %%: what about if exactly equal?
        {   result += 2;
        }
        if (class == WIZARD || class == WARRIORWIZARD)
        {   result++;
        }
        if (result <= 3)
        {   room = 315;
        } elif (result <= 6)
        {   room = 325;
        } else
        {   room = 335;
        }
    acase 308:
        if (getyn("Ride dragon"))
        {   room = 112;
        } else
        {   create_monster(555);
            if (!castspell(-1, TRUE))
            {   if (shooting())
                {   target = gettarget();
                    if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE)) // %%: it doesn't say what range
                    {   evil_takemissilehits(target);
            }   }   }
            do
            {   oneround();
            } while (countfoes() && st >= 6 && con >= 6);
            if (countfoes())
            {   dispose_npcs();
                room = 112;
            } else
            {   award(200);
                gain_chr(2); // %%: could implement dragon's ears as a proper item
                room = wanderroom; daysdone++;
        }   }
    acase 312:
        aprintf("#408:\n%s\n\n", descs[MODULE_DT][408]);
        evil_mi     = 20;
        evil_dice   =  3;
        evil_adds   = 10;
        evil_armour =  0;
        battleofwills(TRUE);
        if (good_mi < 5)
        {   die();
        }
    acase 313:
        if (getyn("Mental combat"))
        {   room = 294;
        } else
        {   create_monster(618);
            do
            {   if (cast(SPELL_TF, FALSE))
                {   if (saved(1, lk))
                    {   payload(TRUE);
                }   }
                elif (cast(SPELL_PA, FALSE))
                {   if (saved(1, lk))
                    {   payload(TRUE);
                }   }
                templose_con(dice(1));
            } while (countfoes());
            award(100);
            room = wanderroom; daysdone++;
        }
    acase 314:
        lose_lk(2);
        if (getyn("Run"))
        {   room = wanderroom; daysdone++;
        } elif (castspell(-1, FALSE))
        {   room = 266;
        } else
        {   room = 284;
        }
    acase 315:
        if (ability[43].known)
        {   failmodule();
        } else
        {   die();
        }
    acase 316:
        if (getyn("Steal the man's hat"))
        {   if (dex > lk)
            {   savedrooms(2, dex, 327, 234);
            } else
            {   savedrooms(2, lk,  327, 234);
        }   }
        elif (getyn("Riddle contest"))
        {   getsavingthrow(TRUE);
            result = iq + level;
            if (race == WHITEHOBBIT || race == FAIRY || race == LEPRECHAUN || class == ROGUE) // %%: what about BLACKHOBBITs?
            {   result += 2;
            }
            if (madeit(2, result))
            {   room = 359;
            } else
            {   room = 348;
        }   }
        elif (getyn("Other plan"))
        {   award(25);
        } else
        {   room = 234;
        }
    acase 318:
        // wandering monster encounters don't happen (as we are always inside the WMT), so that we avoid recursive wandering monsters.
        if (getyn("Ask to go to temple"))
        {   getsavingthrow(TRUE);
            if (madeit(2, chr))
            {   elapse(ONE_DAY * 20, TRUE);
                daysdone = 0;
                room = 17;
            } elif (misseditby(2, chr) <= 5)
            {   room = 292;
            } else
            {   room = 305;
        }   }
        else
        {   room = wanderroom; daysdone++;
        }
    acase 319:
        fight();
    acase 321:
        result  = dice(2) + level;
        result2 = dice(2) + 4;
        if (result >= result2)
        {   create_monster(616);
            good_freeattack(); // %%: but not with missiles! only melee or spells
            if (!countfoes() || npc[0].con <= 5)
            {   room = 288;
        }   }
        dispose_npcs();
        if (room == 321)
        {   good_takehits(dice(5), TRUE);
            room = wanderroom; daysdone++;
        }
    acase 322:
        spell_cf(99);
        if (evil_mi <= 0)
        {   award(50);
        }
        room = wanderroom; daysdone++;
    acase 323:
        create_monster(569);
        if (!castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE))
            {   evil_takemissilehits(target);
        }   }
        if (countfoes())
        {   if (npc[0].mr <= 30) // ie. we did 18 or more points of damage
            {   kill_npcs();
            } else
            {   room = 376;
        }   }
    acase 324:
        aprintf("#408:\n%s\n\n", descs[MODULE_DT][408]);
        evil_mi     = 10;
        evil_dice   =  7;
        evil_adds   =  7;
        evil_armour =  0;
        battleofwills(TRUE);
        if (good_mi < 5)
        {   die();
        } elif (evil_mi <= 0)
        {   good_takehits(4, TRUE);
            award(200);
        } else
        {   give(923);
            if (class != WARRIOR)
            {   for (i = 0; i < SPELLS; i++)
                {   if (spell[i].level == 1 || spell[i].level == 2 || (spell[i].level >= 3 && spell[i].level <= 7 && dice(1) == 6))
                    {   if
                        (   iq  >= spellinfo[spell[i].level].iq
                         && dex >= spellinfo[spell[i].level].dex
                        )
                        {   learnspell(i);
        }   }   }   }   }
        room = wanderroom; daysdone++;
    acase 325:
        result = dice(2);
        elapse(ONE_DAY * result, TRUE);
        templose_con(result / 2);
        give(904); // %%: what kind of clothing? perhaps item #150 instead?
        give(CLU);
        dt_givefood();
    acase 326:
        die();
    acase 327:
        give(916);
        room = wanderroom; daysdone++;
    acase 328:
        create_monster(570);
        result  = dice(1) + level;
        result2 = dice(1) + 1;
        // %%: it doesn't say what happens if results are equal (we are favouring the player)
        if (result < result2 && dice(2) >= 8) // %%: seems they don't want doubles to add and roll over in this case
        {   good_takehits(dice(4) + 5, TRUE);
        }
        if (!castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE)) // %%: it doesn't say what range
            {   evil_takemissilehits(target);
        }   }
        if (result >= result2 && countfoes() && dice(2) >= 8) // %%: seems they don't want doubles to add and roll over in this case
        {   good_takehits(dice(4) + 5, TRUE);
        }
        fight();
        // %%: what loot do we get? We give his crossbow, but no bolts nor armour.
        give(CRO);
    acase 329:
        dispose_npcs();
        dt_givefood();
        give(913);
        give_multi(914, 7);
        give(ITEM_DT_KEY);
        lose_chr(1);
        room = wanderroom; daysdone++;
    acase 330:
        blind = daysdone = 0;
        ok = FALSE;
        do
        {   elapse(ONE_DAY, TRUE);
            if (blind) blind--;
            switch (dice(2))
            {
            case 2:
                blind = 7;
            acase 6:
                room = 112;
            acase 10:
                if (!blind)
                {   ok = TRUE;
                    room = 369;
                }
            acase 11:
            case 12:
                if (!blind)
                {   ok = TRUE;
                    if (getyn("Head for the temple"))
                    {   elapse(ONE_DAY * 2, TRUE);
                        room = 50;
        }   }   }   }
        while (!ok);
    acase 331:
        if (getyn("Keep dancing"))
        {   if (saved(2, con))
            {   if (saved(2, dex))
                {   room = 341;
                } else
                {   room = 305;
            }   }
            else
            {   DISCARD saved(2, dex);
                room = wanderroom; daysdone++;
        }   }
        else
        {   room = wanderroom; daysdone++;
        }
    acase 334:
        for (i = 0; i < 2; i++)
        {   if (room == 334 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                if (dice(1) <= 2)
                {   dt_wandering(TABLE_C);
                }
                if (room == 334)
                {   daysdone++;
        }   }   }
        if (room == 334 && daysdone == 2)
        {   daysdone = 0;
        }
    acase 335:
        if (pay_gp(120))
        {   room = 62;
        } else
        {   room = 325;
        }
    acase 336:
        if (lk > chr)
        {   if (!saved(2, lk))
            {   gain_flag_ability(163);
        }   }
        else
        {   if (!saved(2, chr))
            {   gain_flag_ability(163);
        }   }
        award(125);
        room = wanderroom; daysdone++;
    acase 338:
        spell_cf(99);
        gain_flag_ability(164);
        room = wanderroom; daysdone++;
    acase 339:
        create_monster(571);
        if (!castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE))
            {   evil_takemissilehits(target);
        }   }
        if (countfoes())
        {   room = 376;
        }
    acase 340:
        getsavingthrow(TRUE);
        if (ability[32].known || cast(SPELL_CC, TRUE))             thethrow += 10;
        if (class == ROGUE)                                        thethrow += level;
        if (race == WHITEHOBBIT || race == FAIRY || race == LEPRECHAUN) thethrow += 2; // %%: what about black hobbits?
        if (madeit(4, lk))
        {   room = 375;
        } else
        {   create_monsters(572, misseditby(4, lk));
            fight();
            elapse(dice(1) * 10, TRUE);
        }
    acase 341:
        // %%: elapse some time?
        give(ITEM_DT_ROBE);
        give(917);
        room = wanderroom; daysdone++;
    acase 343:
        create_monster(555);
        if (!castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_FAR, SIZE_HUGE, FALSE))
            {   evil_takemissilehits(target);
        }   }
        if (countfoes() && !castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_NEAR, SIZE_HUGE, FALSE))
            {   evil_takemissilehits(target);
        }   }
        if (countfoes() && !castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_POINTBLANK, SIZE_HUGE, FALSE))
            {   evil_takemissilehits(target);
        }   }
        if (countfoes())
        {   good_takehits(dice(4), TRUE);
            fight();
        }
        award(200);
        if (class == WARRIOR)
        {   give(DRA);
        }
        give(918);
        room = wanderroom; daysdone++;
    acase 344:
        guide = FALSE;
        // %%: villages++; ?
        shop_buy(100, 'X'); // %%: we assume all provisions and equipment are available at normal prices
        pay_gp(10);
        result = getnumber("Stay how many nights", 0, 9999);
        if (result)
        {   for (i = 1; i <= result; i++)
            {   elapse(ONE_DAY, TRUE);
                heal_con(1);
                if (!pay_gp(15))
                {   elapse(ONE_DAY, TRUE);
        }   }   }
        if (money >= 1000 && getyn("Pay for food"))
        {   pay_gp(10);
        } else
        {   elapse(ONE_DAY, TRUE);
        }
        dt_givefood();
        if (money >= 1500 && getyn("Buy adventurer's gear"))
        {   pay_gp(15);
            give(904);
        }
    acase 345:
        daysdone = 0;
    acase 348:
        give_gp(348);
        give_multi(919, 4);
        give(920);
        give_multi(921, 7);
        award(150);
        room = wanderroom; daysdone++;
    acase 349:
        award(500);
        give_gp(1000);
        give(MAI);
        dt_givefood();
    acase 350:
        getsavingthrow(TRUE);
        if (class == WARRIOR) thethrow += level;
        elif (class == ROGUE) thethrow -= level;
        if (items[ITEM_DT_ROBE].owned) thethrow++;
        if (madeit(3, chr))
        {   armysize = madeitby(3, chr) * 10;
            award(armysize * 10);
            room = 361;
        }
    acase 353:
        create_monster(538); // %%: maybe should actually implement the chair as a proper shield rather than as skin
        create_monsters(539, 2);
        create_monster(540);
        do
        {   oneround();
        } while (con > 5 && npc[0].mr > 5 && npc[1].mr > 5 && npc[2].mr > 5 && npc[3].mr > 5);
        if (con <= 5)
        {   gain_flag_ability(153);
            if (money >= items[150].cp && getyn("Buy clothes"))
            {   pay_cp(items[150].cp);
                give(150);
                lose_flag_ability(153);
        }   }
        else
        {   award(25);
        }
        dispose_npcs();
    acase 354:
        daysdone = 0;
    acase 355:
        give(922);
        award(150);
    acase 356:
        die();
    acase 357:
        savedrooms(1, lk, 378, 326);
    acase 358:
        for (i = 0; i < 3; i++)
        {   if (room == 358 && daysdone == i)
            {   elapse(ONE_DAY, TRUE);
                switch (dice(1))
                {
                case 4:
                case 5:
                    dt_wandering(TABLE_D);
                acase 6:
                    if (getyn("Use Luck (otherwise Speed)"))
                    {   if (!saved(1, lk))
                        {   good_takehits(dice(2), TRUE);
                            elapse(ONE_DAY * 2, TRUE);
                    }   }
                    else
                    {   if (!saved(1, spd))
                        {   good_takehits(dice(2), TRUE);
                            elapse(ONE_DAY * 2, TRUE);
                }   }   }
                if (room == 358)
                {   daysdone++;
        }   }   }
        if (room == 358 && daysdone == 3)
        {   daysdone = 0;
        }
    acase 359:
        if (!been[359] && getyn("Were you correct"))
        {   room = 348;
        } else
        {   if (iq > lk)
            {   if (saved(3, iq))
                {   room = 348;
            }   }
            else
            {   if (saved(3, lk))
                {   room = 348;
        }   }   }
        if (room == 359)
        {   room = 336;
        }
    acase 361:
        result = dice(2) * 10;
        if (getyn("Fight in battle"))
        {   fought = TRUE;
            result -= 20;
        } else
        {   fought = FALSE;
        }
        if (result <= armysize)
        {   result = dice(1);
            if (class == WARRIOR) result += level;
            if (fought) result += 5;
            if (result <= 6) room = 372; elif (result <= 8) room = 388; else room = 404;
        }
    acase 362:
        elapse(ONE_DAY * 7, TRUE);
        heal_con((max_con - con) / 2);
        give_gp(1000);
        // we got his katar when he died
        award(250);
    acase 363:
        // %%: elapse some time?
        savedrooms(1, lk, 374, 387);
    acase 365:
        savedrooms(2, chr, 362, 376);
    acase 366:
        if (minutes < startminutes + (ONE_DAY * 30)) // %%: what it is exactly 30 days?
        {   if (getyn("Help slaves"))
            {   award(1000);
                spell_cf(12); // %%: this is arbitrary, they only say "powerful"
                failmodule();
        }   }
        else
        {   room = 377;
        }
    acase 367:
        kill_npcs();
        if (saved(1, lk))
        {   ok = TRUE;
        } else
        {   ok = FALSE;
        }
        // there is no "immune to 10th level magic" power that we know of, or at least that we support
        if (!immune_hb())
        {   if (!immune_fire())
            {   good_takehits(100, TRUE);
            }
            good_takehits(dice(10), TRUE);
        }
        for (i = 0; i < ITEMS; i++)
        {   if (!items[i].magical)
            {   dropitems(i, items[i].owned);
        }   }
        award(200); // delayed because it is only awarded "if you live"
        if (!ok)
        {   room = 406;
        }
    acase 368:
        // wandering monster encounters don't happen (as we are always inside the WMT), so that we avoid recursive wandering monsters.
        elapse(ONE_DAY * 4, TRUE);
        give_gp(250);
        rb_givejewels(-1, -1, 1, 4);
        dt_givefood();
        if (prevroom == 305)
        {   room = 334;
        } else
        {   room = wanderroom; daysdone++;
        }
    acase 369:
        if (makelight() == LIGHT_NONE)
        {   if (saved(2, dex))
            {   savedrooms(2, dex, 107, 100);
            } else
            {   DISCARD saved(2, dex);
                room = 117;
        }   }
    acase 370:
        getsavingthrow(TRUE);
        if (class == WARRIOR) thethrow += level;
        if (height < 60) thethrow += 10;
        if (!madeit(2, spd))
        {   good_takehits(dice(misseditby(2, spd)), TRUE);
        }
        create_monsters(573, 10);
        do
        {   oneround();
            if (theround % 3 == 0)
            {  create_monster(573);
        }   }
        while (countfoes());
        if (getyn("Continue")) // %%: we assume we can only rest if going to DT375
        {   elapse(dice(1) * 10, TRUE);
            room = 375;
        }
    acase 371:
        if (getyn("Avoid mine"))
        {   elapse(ONE_DAY * 3, TRUE);
            room = 50;
        }
    acase 372:
        award(500);
    acase 374:
        if (!saved(1, spd))
        {   room = 330;
        }
    acase 375:
        if (items[ITEM_DT_ROBE].owned)
        {   room = 389;
        } elif (getyn("Talk your way in"))
        {   savedrooms(3, chr, 389, 380);
        }
    acase 376:
        // %%: it doesn't say whether to apply damage done at DT323/DT339. We do so.
        if (prevroom == 323)
        {   create_monster(571); // baron is #0, advisor is #1
        } elif (prevroom == 339)
        {   create_monster(569); // advisor is #0, baron is #1
        }
        do
        {   oneround();
        } while (countfoes() == 2);
        if
        (   !countfoes() // %%: it doesn't say what to do if we kill both at the same time
         || (prevroom == 323 && npc[0].mr) // baron alive, advisor dead
         || (prevroom == 339 && npc[1].mr) // baron alive, advisor dead
        )
        {   dispose_npcs();
            room = 362;
        } else
        {   room = 390; // we finish combat with advisor in next room
        }
    acase 379:
        create_monsters(574, 10);
        // %%: what swords do the guards have? We should let them loot swords, as text suggests. And perhaps also loot the leather armour.
        do
        {   oneround();
        } while (countfoes() && con >= 6 && st >= 6);
        if (countfoes())
        {   dispose_npcs();
            room = 330;
        }
    acase 380:
        if (race == GIANT)
        {   create_monsters(575, 2);
            do
            {   if (getyn("Try maneouvres") && saved(1, spd))
                {   if (madeitby(1, spd) >= 6)
                    {   dispose_npcs();
                        room = 389;
                    } else
                    {   target = gettarget();
                        if (target != -1)
                        {   evil_takehits(target, 10);
                }   }   }
                else
                {   oneround();
            }   }
            while (countfoes());
        } else
        {   create_monster(575);
            do
            {   if (getyn("Try maneouvres") && saved(1, spd))
                {   if (madeitby(1, spd) >= 6)
                    {   dispose_npcs();
                        room = 389;
                    } else
                    {   evil_takehits(0, 10);
                }   }
                else
                {   oneround();
            }   }
            while (countfoes());
            if (room == 380)
            {   create_monster(575);
                do
                {   if (getyn("Try maneouvres") && saved(1, spd))
                    {   if (madeitby(1, spd) >= 6)
                        {   dispose_npcs();
                            room = 389;
                        } else
                        {   evil_takehits(0, 10);
                    }   }
                    else
                    {   oneround();
                }   }
                while (countfoes());
        }   }
        if (room == 380)
        {   elapse(dice(1) * 10, TRUE);
        }
    acase 381:
        armysize = 0;
        if (saved(1, iq))
        {   armysize = madeitby(1, lk) * villages;
            if (class == ROGUE) armysize *= 2;
        } else
        {   armysize = 0;
        }

        getsavingthrow(TRUE);
        if (class == WARRIOR) thethrow += level;
        if (madeit(1, chr))
        {   result = madeitby(1, chr) * villages;
            if (ability[122].known || ability[157].known || ability[158].known)
            {   result *= 2;
        }   }
        else
        {   result = 0;
        }

        armysize += result;
        if (been[355]) armysize += 5;
        if (been[368]) armysize += 5;
        award(armysize * 10);
    acase 385:
        savedrooms(2, lk, 406, 398);
    acase 386:
        goodattack();
        if (good_attacktotal >= 40)
        {   room = 349;
        } else
        {   room = 396;
        }
    acase 387:
        if (getyn("Head for the temple"))
        {   elapse(ONE_DAY * 3, TRUE);
            room = 50;
        } elif (getyn("Raise rebellion"))
        {   if (saved(2, chr))
            {   room = 337;
            } elif (getyn("Be captured"))
            {   room = 330;
        }   }
    acase 388:
        award(600);
        gain_flag_ability(157);
    acase 389:
        if (class == WIZARD && getyn("Dress as acolyte"))
        {   give(CLO);
            give(SAX);
        } else
        {   give(LEA);
            give(HEM);
            give(PIL); // %%: we assume we can loot both weapons if we want
        }
        if (saved(2, chr))
        {   create_monster(576);
            do
            {   oneround();
            } while (countfoes() && st >= 6 && con >= 6);
            if (countfoes())
            {   die();
            } else
            {   give(TAR);
                give(LEA);
                elapse(dice(1) * 10, TRUE); // %%: we assume this only happens if we actually fought the officer
        }   }
    acase 390:
        if (prevroom == 378)
        {   create_monster(571);
        }
        // %%: it doesn't say whether to apply damage done at DT339/DT376. We do so.
        fight();
    acase 391:
        if (prevroom != 409)
        {   create_monster(583);
        }
        if (castspell(-1, FALSE))
        {   if (saved(1, lk))
            {   payload(TRUE);
        }   }
        elif (shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE)) // %%: we assume it is man-sized (large)
            {   evil_takemissilehits(target);
        }   }
        if (npc[0].mr <= 20)
        {   kill_npcs();
        }
        if (countfoes())
        {   savedrooms(1, lk, 367, 409);
        } else
        {   award(100);
        }
    acase 392:
        if (fought && getyn("Assassinate leaders"))
        {   room = 410;
        }
    acase 394:
        gain_flag_ability(158);
        give(900);
        give(901);
        victory(100); // %%: we just give them the default bonus
    acase 395:
        if (getyn("Stay behind"))
        {   award(300);
            room = 330;
        } else
        {   if (dice(1) % 2)
            {   award(200);
            }
            elapse(ONE_DAY * 2, TRUE);
        }
    acase 396:
        if (getyn("Run"))
        {   room = 334;
        } else
        {   create_monster(577);
            fight();
        }
    acase 397:
        if (!getyn("Run for archway") || !saved(1, spd))
        {   create_monster(578);
            create_monsters(579, 3);
            fight();
        }
    acase 398:
        result  = dice(2) + spd;
        result2 = dice(2) + 12;
        if (result > result2)
        {   room = 391;
        } else
        {   savedrooms(1, lk, 367, 409);
        }
    acase 400:
        if (spd < 10)
        {   change_spd(10);
        } else
        {   gain_spd(2);
        }
        pay_gp_only(gp / 2);
        award(250);
        failmodule();
    acase 402:
        DISCARD saved(1, chr); // lose some slaves (we don't keep track of them anyway)
        if (getyn("Head for the temple"))
        {   // lose all slaves (we don't keep track of them anyway)
            elapse(ONE_DAY * 2, TRUE);
            room = 50;
        }
    acase 403:
        if (saved(1, lk))
        {   give(884);
            give(883);
            room = 207;
        }
    acase 404:
        gain_flag_ability(159);
        give(902);
        give(901);
        award(600);
    acase 405:
        die();
    acase 406:
        create_monster(557);
        if (prevroom == 367)
        {   evil_takehits(0, 10 + 20); // +20 is to compensate for his armour
        }
        if (getyn("Flee") && saved(1, spd) && saved(2, lk))
        {   dispose_npcs();
            award(100);
            room = 400;
        } else
        {   fight();
            award(100); // %%: is this additional to the normal ap award? We assume so.
            give(891);
            if (prevroom == 367)
            {   room = 394;
            } else
            {   room = 383;
        }   }
    acase 409:
        // we don't know of any "you are immune to magic" ability.
        templose_con(dice(11) + 35);
        if (st < 6 || con < 6)
        {   die();
        }
    acase 410:
        if (!items[ITEM_DT_ROBE].owned)
        {   give(ITEM_DT_ROBE); // %%: we treat the sashed robe the same as an unsashed one
        }
        if (getyn("Sneak out now"))
        {   award(200);
            room = 400;
        }
    acase 411:
        victory(250); // %%: we assume this is a considered to be a victory
    acase 412:
        create_monsters(580, 2); // %%: we assume they have medium longbows
        create_monster(581);
        evil_missileattack(RANGE_NEAR, 0); // %%: we assume they mean near range by "medium"
        evil_missileattack(RANGE_NEAR, 1); // %%: we assume they mean near range by "medium"
        // %%: we assume the bow attacks should be applied separately (with armour counting against each)
        // %%: we assume the player gets to shoot back or cast here
        if (!castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_NEAR, SIZE_LARGE, FALSE)) // %%: we assume they mean near range by "medium"
            {   evil_takemissilehits(target);
        }   }
        if (npc[0].mr) evil_missileattack(RANGE_POINTBLANK, 0);
        if (npc[1].mr) evil_missileattack(RANGE_POINTBLANK, 1);
        // %%: we assume the bow attacks should be applied separately (with armour counting against each)
        // %%: we assume the player gets to shoot back or cast here
        if (countfoes() && !castspell(-1, TRUE) && shooting())
        {   target = gettarget();
            if (target != -1 && shot(RANGE_POINTBLANK, SIZE_LARGE, FALSE))
            {   evil_takemissilehits(target);
        }   }
        if (countfoes())
        {   npc[0].rt =
            npc[1].rt = -1;
            fight();
        }
        give_multi(MLB, 2); // %%: we assume medium longbows. Are there any arrows?
        give_gp(dice(5) * 10);
}   }

#define DT_PRIVY  0
#define DT_LOSE   1
#define DT_DASH   2
#define DT_EVEN   3
#define DT_DOUBLE 4
#define DT_TRIPLE 5
#define DT_QUINT  6
EXPORT void dt_gamble(void)
{   PERSIST const int results[5][5][5] =
{ { { DT_PRIVY , DT_DASH  , DT_DASH  , DT_DOUBLE, DT_TRIPLE }, // 1,1,1..5
    { DT_DASH  , DT_DASH  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 1,2,1..5
    { DT_DASH  , DT_LOSE  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 1,3,1..5
    { DT_DOUBLE, DT_LOSE  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 1,4,1..5
    { DT_TRIPLE, DT_LOSE  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 1,5,1..5
  },
  { { DT_DASH  , DT_LOSE  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 2,1,1..5
    { DT_LOSE  , DT_DOUBLE, DT_EVEN  , DT_EVEN  , DT_EVEN   }, // 2,2,1..5
    { DT_LOSE  , DT_EVEN  , DT_DOUBLE, DT_DOUBLE, DT_TRIPLE }, // 2,3,1..5
    { DT_LOSE  , DT_EVEN  , DT_DOUBLE, DT_DOUBLE, DT_DOUBLE }, // 2,4,1..5
    { DT_LOSE  , DT_EVEN  , DT_TRIPLE, DT_DOUBLE, DT_TRIPLE }, // 2,5,1..5
  },
  { { DT_DASH  , DT_LOSE  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 3,1,1..5
    { DT_LOSE  , DT_EVEN  , DT_DOUBLE, DT_DOUBLE, DT_TRIPLE }, // 3,2,1..5
    { DT_LOSE  , DT_DOUBLE, DT_TRIPLE, DT_DOUBLE, DT_DOUBLE }, // 3,3,1..5
    { DT_LOSE  , DT_DOUBLE, DT_DOUBLE, DT_DOUBLE, DT_DOUBLE }, // 3,4,1..5
    { DT_LOSE  , DT_TRIPLE, DT_DOUBLE, DT_DOUBLE, DT_TRIPLE }, // 3,5,1..5
  },
  { { DT_DOUBLE, DT_LOSE  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 4,1,1..5
    { DT_LOSE  , DT_EVEN  , DT_DOUBLE, DT_DOUBLE, DT_DOUBLE }, // 4,2,1..5
    { DT_LOSE  , DT_DOUBLE, DT_DOUBLE, DT_DOUBLE, DT_DOUBLE }, // 4,3,1..5
    { DT_LOSE  , DT_DOUBLE, DT_DOUBLE, DT_TRIPLE, DT_DOUBLE }, // 4,4,1..5
    { DT_LOSE  , DT_DOUBLE, DT_DOUBLE, DT_DOUBLE, DT_DOUBLE }, // 4,5,1..5
  },
  { { DT_TRIPLE, DT_LOSE  , DT_LOSE  , DT_LOSE  , DT_LOSE   }, // 5,1,1..5
    { DT_LOSE  , DT_EVEN  , DT_TRIPLE, DT_DOUBLE, DT_TRIPLE }, // 5,2,1..5
    { DT_LOSE  , DT_TRIPLE, DT_DOUBLE, DT_DOUBLE, DT_TRIPLE }, // 5,3,1..5
    { DT_LOSE  , DT_DOUBLE, DT_DOUBLE, DT_DOUBLE, DT_DOUBLE }, // 5,4,1..5
    { DT_LOSE  , DT_TRIPLE, DT_TRIPLE, DT_DOUBLE, DT_QUINT  }, // 5,5,1..5
} };
    TRANSIENT int  bet,
                   i,
                   limit,
                   playable,
                   played,
                   result1, result2, result3;

    playable = (class == ROGUE) ? 13 : 7;
    played = 0;
    do
    {   limit = chr / 2;
        if (limit > gp) limit = gp;
        if (limit == 0 || !(bet = getnumber("Bet how many gp", 0, limit)))
        {   return;
        }
        pay_gp(bet);
        result1 = anydice(1, 5);
        result2 = anydice(1, 5);
        result3 = anydice(1, 5);
        rawmode = TRUE;
        for (i = 0; i < DICEY; i++)
        {   aprintf
            (   "%s    %s    %s\n",
                ansi_dicefaces[result1 - 1][i],
                ansi_dicefaces[result2 - 1][i],
                ansi_dicefaces[result3 - 1][i]
            );
        }
        rawmode = FALSE;
        aprintf("¢");

        switch (results[result1 - 1][result2 - 1][result3 - 1])
        {
        case  DT_PRIVY:
            aprintf("Privy!\n");
            if (gp >= bet * 4 && getyn("Pay men"))
            {   pay_gp(bet * 4);
            } else
            {   room = 15;
            }
        acase DT_LOSE:                 aprintf("Lose\n"      );
        acase DT_EVEN:   case DT_DASH: aprintf("Even\n"      ); give_gp(bet);
        acase DT_DOUBLE:               aprintf("Double\n"    ); give_gp(bet * 2);
        acase DT_TRIPLE:               aprintf("Triple\n"    ); give_gp(bet * 3);
        acase DT_QUINT:                aprintf("Quintuple!\n"); give_gp(bet * 5);
        }
        played++;
    } while
    (   gp
     && (   module == MODULE_RB
         || (room == 9 && played < playable)
        )
     && getyn("Play again")
    );
}

MODULE void dt_givefood(void)
{   if (!items[ITEM_DT_RATIONS].owned)
    {   give(ITEM_DT_RATIONS);
}   }

MODULE void dt_wandering(int whichtable)
{   int i, j,
        result,
        whichwp;

    aprintf(
"ENCOUNTER TABLES\n" \
"  During your travels in Dark Temple, you will occasionally be asked to roll for an encounter. There are four tables in this section. The creatures and people you may run into vary on each. The table used is identified by a letter in the text. It is very important to write down or mark the place in the adventure that sends you to an encounter; most encounters will not send you back to the main body of the adventure.\n" \
"NOTES ON ENCOUNTERS\n" \
"  There are some rules common to all encounters given above. If you are given a choice of talking or attacking, you may usually leave by simply continuing the adventure. If you are in combat and wish to escape, you must wait until after the first combat round: roll a L1-SR vs. Speed (20 - SPD). If you make the roll, you may go about your business. If you missed the roll, take hits equal to the amount you missed by; armour only counts for its base value. You may continue trying to escape until you die or are disabled. You may not cast spells or use a weapon on a turn in which you try to run.\n" \
"  Some foes described above have missile weapons. Creatures with bows will have two chances to shoot if you want to close with them, three if you also pause to loose a missile or spell. [Unless otherwise noted, bows do 1 die of damage plus 10 adds (1 die + 10). ]You may subtract [basic ]armour protection from each arrow-shot. Note that for purposes of spell or missile casting, the first round as noted above is at far range (51 yards/150'), the second round at near range (25 yards/75'), the final round at pointblank range (3 yards/15').\n"
    );

    switch (whichtable)
    {
    case TABLE_A:
        aprintf("Roll two dice and consult the appropriate paragraph below:\n");
        whichwp = dice(2) -  2; // 2..12 ->  0..10
    acase TABLE_B:
        aprintf("Roll two dice and follow the instructions below:\n");
        whichwp = dice(2) +  9; // 2..12 -> 11..21
    acase TABLE_C:
        aprintf("Roll two dice and consult the appropriate section below.\n");
        whichwp = dice(2) + 20; // 2..12 -> 22..32
    acase TABLE_D:
        aprintf("Roll one die and consult the section below:\n");
        whichwp = dice(1) + 32; // 1.. 6 -> 33..38
    }

    aprintf("%s\n", dt_wandertext[whichwp]);
    wanderroom = room;

    if (whichwp == 8 && dt_met[8])
    {   whichwp = 5;
    }

    switch (whichwp)
    {
    case 0: // A.2 (bandits)
        if (getyn("Surrender"))
        {   pay_gp_only(gp);
            pay_sp_only(sp);
            pay_cp_only(cp);
            for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && (items[i].type == JEWEL || isweapon(i)))
                {   dropitems(i, items[i].owned);
        }   }   }
        else
        {   create_monsters(589, 5);
            if (dt_fight(TRUE))
            {   rb_treasure(2);
                rb_treasure(2);
        }   }
    acase 1: // A.3 (slavers)
        aprintf("%s\n", dt_wandertext[0]);
        if (getyn("Surrender"))
        {   room = 330;
        } else
        {   create_monsters(590, 5);
            if (dt_fight(TRUE))
            {   rb_treasure(2);
                rb_treasure(2);
        }   }
    acase 2: // A.4 (horsemen)
        result = dice(1);
        if (result == 4 || result == 5)
        {   aprintf("%s\n", dt_wandertext[0]);
            if (getyn("Surrender"))
            {   pay_gp_only(gp);
                pay_sp_only(sp);
                pay_cp_only(cp);
                for (i = 0; i < ITEMS; i++)
                {   if (items[i].owned && (items[i].type == JEWEL || isweapon(i)))
                    {   dropitems(i, items[i].owned);
            }   }   }
            else
            {   create_monsters(591, 4);
                create_monsters(592, 4);
                if (dt_fight(TRUE))
                {   rb_treasure(2);
                    rb_treasure(2);
        }   }   }
    acase 3: // A.5 (soldiers)
        switch (dice(1))
        {
        case 1: case 2:
            elapse(ONE_DAY, TRUE);
            pay_gp(5);
        acase 3: case 4: case 5:
            elapse(ONE_DAY * 5, TRUE);
        acase 6:
            create_monsters(617, 5);
            dt_fight(TRUE);
        }
    acase 4: // A.6 (highwayman)
        if (!saved(1, chr))
        {   if (getyn("Give gold"))
            {   pay_gp_only(gp);
            } else
            {   create_monster(593);
                evil_missileattack(RANGE_NEAR, 0);
                if (dt_fight(FALSE))
                {   rb_givejewels(-1, -1, 1, 3);
                    rb_treasure(2);
                    rb_treasure(2);
        }   }   }
    acase 5: // A.7 (mercenary)
        if (getyn("Attack")) // %%: presumably we can attack him if we want
        {   create_monster(594);
            dt_fight(TRUE);
        }
    acase 6: // A.8 (old man)
        room = 232;
    acase 7: // A.9 (fighter)
        if (saved(2, iq))
        {   if (saved(2, lk))
            {   aprintf("%s\n", dt_wandertext[5]);
                if (getyn("Attack")) // %%: presumably we can attack him if we want
                {   create_monster(595);
                    dt_fight(TRUE);
            }   }
            else
            {   create_monster(595);
                dt_fight(TRUE);
        }   }
        else
        {   if (saved(2, lk))
            {   create_monster(595);
                dt_fight(TRUE);
        }   }
    acase 8: // A.10 (cloaked horseman)
        room = 251;
    acase 9: // A.11 (amazon)
        result = dice(1);
        if (sex == FEMALE)
        {   result += 2;
        }
        if (angryamazon)
        {   result -= 3;
        }
        if (result <= 3)
        {   create_monster(596);
            dt_fight(TRUE);
        } elif (result <= 5)
        {   angryamazon = TRUE;
        }
    acase 10: // A.12 (campsite)
        if (getyn("Investigate"))
        {   room = 242;
        }
   // 11..21 (Table B) are unused (and therefore unimplemented)
    acase 22: // C.2 (dragon)
        do
        {   result = getnumber("Which paragraph", 282, 308);
        } while (result != 282 && result != 296 && result != 308);
        room = result;
    acase 23: // C.3 (elf on pegasus)
        if (getyn("Wave and shout"))
        {   room = 296;
        } elif (!getyn("Continue journey"))
        {   room = 270;
        }
    acase 24: // C.4 (troll)
        create_monster(597);
        dt_fight(TRUE);
    acase 25: // C.5 (man on toad)
#ifdef WIN32
        manualshowpic("%s\\Images\\DT\\dt-p59.gif", "A man on a large toad");
#endif
#ifdef AMIGA
        manualshowpic("PROGDIR:Images/DT/dt-p59.gif", "A man on a large toad");
#endif
        if (!been[327])
        {   do
            {   result = getnumber("Which paragraph", 234, 291);
            } while (result != 234 && result != 278 && result != 291);
            room = result;
        }
    acase 26: // C.6 (orcish bandits)
        create_monsters(598, 4);
        evil_missileattack(RANGE_NEAR, 0);
        evil_missileattack(RANGE_NEAR, 1);
        evil_missileattack(RANGE_NEAR, 2);
        evil_missileattack(RANGE_NEAR, 3);
        npc[0].rt =
        npc[1].rt =
        npc[2].rt =
        npc[3].rt = -1; // %%: maybe let the player pick up the javelins
        fight();
    acase 27: // C.7 (wolves)
        result = dice(1) + 3;
        create_monsters(599, result);
        dt_fight(TRUE);
        give_multi(908, result);
        // %%: is it 8 gp per ear or per wolf? We assume per wolf.
        // %%: are wolves' ears saleable in the city? We assume so.
    acase 28: // C.8 (goblins)
        dropitem(ITEM_DT_RATIONS);
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && !isarmour(i)) // %%: what exactly is meant by "equipment"?
            {   result = items[i].owned;
                for (j = 1; j <= result; j++)
                {   if (dice(1) >= 5)
                    {   dropitem(i);
        }   }   }   }
        room = wanderroom; daysdone++;
    acase 29: // C.9 (eater)
        elapse(ONE_DAY * 2, TRUE);
        room = 246;
    acase 30: // C.10 (misty figure)
        if (castspell(-1, FALSE))
        {   room = 266;
        } elif (getyn("Attack"))
        {   room = 314;
        } else
        {   room = 284;
        }
    acase 31: // C.11 (giant snake)
        if (getyn("Fight (otherwise detour)"))
        {   room = 298;
        } else
        {   elapse(ONE_DAY, TRUE);
        }
    acase 32: // C.12 (werewolf)
        create_monster(600);
        do
        {   if (enchantedorsilver_melee())
            {   oneround();
        }   }
        while (theround < 6);
        dispose_npcs();
        if (!saved(2, lk))
        {   race = WEREWOLF;
            changerace();
        }
    acase 33: // D.1 (pilgrims)
        if (getyn("Attack"))
        {   room = 292;
        } elif (getyn("Talk"))
        {   room = 318;
        }
    acase 34: // D.2 (conversion squad)
        if (getyn("Surrender"))
        {   room = 330;
        } else
        {   create_monsters(601, 3);
            create_monsters(548, 3);
            dt_fight(FALSE);
        }
    acase 35: // D.3 (warrior-priests)
        if (getyn("Attack"))
        {   room = 299;
        } elif (getyn("Question"))
        {   room = 276;
        }
    acase 36: // D.4 (dust)
        if (!killedwhirlwind)
        {   if (class == WARRIOR || class == ROGUE)
            {   room = 294;
            } else
            {   room = 313;
        }   }
    acase 37: // D.5 (dancers)
        if (getyn("Dance"))
        {   room = 331;
        } elif (getyn("Attack"))
        {   room = 302;
        }
    acase 38: // D.6 (figure in black)
#ifdef WIN32
        manualshowpic("%s\\Images\\DT\\dt-p60.gif", "A figure dressed in black");
#endif
#ifdef AMIGA
        manualshowpic("PROGDIR:Images/DT/dt-p60.gif", "A figure dressed in black");
#endif
        // %%: what are the criteria for "knowing" where the plain of obelisks is?
        if (getyn("Tell it"))
        {   room = 303;
        } else
        {   room = 321;
    }   }

    dt_met[whichwp] = TRUE;
}

// Return code is whether you won (killed all enemies) or not (fled).
MODULE FLAG dt_fight(FLAG missilable)
{   int  i;
    FLAG fought = FALSE,
         ran;

    // %%: the whole thing is very ambiguous; this is just one possible interpretation

    if (missilable)
    {   // sayround();
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if (npc[i].con || npc[i].mr) evil_missileattack(RANGE_FAR, i);
        }
        if (castspell(-1, TRUE))
        {   fought = TRUE;
        } elif (shooting())
        {   fought = TRUE;
            target = gettarget();
            if (target != -1 && shot(RANGE_FAR, races[npc[target].race].size, FALSE))
            {   evil_takemissilehits(target);
        }   }
        if (!countfoes())
        {   return TRUE;
        }

        // sayround();
        ran = FALSE;
        if (room != 248 && getyn("Run"))
        {   ran = TRUE;
            if (saved(1, spd))
            {   dispose_npcs();
                return FALSE;
            } else
            {   good_takehits(misseditby(1, spd), FALSE);
        }   }
        for (i = 0; i < MAX_MONSTERS; i++)
        {   if (npc[i].con || npc[i].mr) evil_missileattack(RANGE_NEAR, i);
        }
        if (!ran)
        {   if (castspell(-1, TRUE))
            {   fought = TRUE;
            } elif (shooting())
            {   fought = TRUE;
                target = gettarget();
                if (target != -1 && shot(RANGE_NEAR, races[npc[target].race].size, FALSE))
                {   evil_takemissilehits(target);
        }   }   }
        if (!countfoes())
        {   return TRUE;
        }

        if (fought)
        {   // sayround();
            ran = FALSE;
            if (room != 248 && getyn("Run"))
            {   ran = TRUE;
                if (saved(1, spd))
                {   dispose_npcs();
                    return FALSE;
                } else
                {   good_takehits(misseditby(1, spd), FALSE);
            }   }
            for (i = 0; i < MAX_MONSTERS; i++)
            {   if (npc[i].con || npc[i].mr) evil_missileattack(RANGE_POINTBLANK, i);
            }
            if (!ran)
            {   if (!castspell(-1, TRUE))
                {   if (shooting())
                    {   target = gettarget();
                        if (target != -1 && shot(RANGE_POINTBLANK, races[npc[target].race].size, FALSE))
                        {   evil_takemissilehits(target);
            }   }   }   }
            if (!countfoes())
            {   return TRUE;
        }   }

        for (i = 0; i < MAX_MONSTERS; i++)
        {   if ((npc[i].mr || npc[i].con) && npc[i].rt != -1 && items[npc[i].rt].range)
            {   npc[i].rt = -1; // maybe we should let the player loot it after the battle
        }   }
        while (countfoes())
        {   // ran = FALSE;
            if (wanderroom != 248 && getyn("Run"))
            {   // ran = TRUE;
                if (saved(1, spd))
                {   dispose_npcs();
                    return FALSE;
                } else
                {   good_takehits(misseditby(1, spd), FALSE);
            }   }
            else
            {   oneround();
    }   }   }
    else
    {   for (i = 0; i < MAX_MONSTERS; i++)
        {   if ((npc[i].mr || npc[i].con) && npc[i].rt != -1 && items[npc[i].rt].range)
            {   npc[i].rt = -1; // maybe we should let the player loot it after the battle
        }   }
        do
        {   if (wanderroom != 248 && theround >= 1 && getyn("Run"))
            {   if (saved(1, spd))
                {   dispose_npcs();
                    return FALSE;
                } else
                {   good_takehits(misseditby(1, spd), FALSE);
                    evil_freeattack();
            }   }
            else
            {   oneround();
        }   }
        while (countfoes());
    }
    return TRUE;
}

MODULE void dt_treasure(void)
{   PERSIST   FLAG learnedspell[SPELLS]; // PERSISTent so as not to blow the stack
    PERSIST   FLAG cupped = FALSE;
    TRANSIENT int  i,
                   result, result2,
                   whichspell;

    switch (dice(1))
    {
    case 1:
        DISCARD shop_give(10);
    acase 2:
        give_gp(dice(5) * 20);
    acase 3:
        give_gp(dice(4) * 10);
        rb_givejewels(-1, -1, 1, dice(2));
    acase 4:
        give(ORD);
    acase 5:
        if (room == 240)
        {   ; // %%: it says to "ignore" the roll, so we assume they don't intend it to be rerolled
        } else
        {   // assert(room == 225);
            room = 240;
        }
    acase 6:
        switch (dice(1))
        {
        case 1:
        case 2:
            give(905);
        acase 3:
        case 4:
            // %%: maybe we should implement it as an item instead
            result = dice(2) / 2; // 1st..6th level
            // This algorithm relies on the fact that >= 3 spells exist at each level from 1st..6th.
            for (whichspell = 0; whichspell < SPELLS; whichspell++)
            {   learnedspell[whichspell] = FALSE;
            }
            for (i = 0; i < 3; i++)
            {   do
                {   whichspell = anydice(1, SPELLS) - 1;
                } while (spell[whichspell].level != result || learnedspell[whichspell]);
                learnspell(whichspell);
                learnedspell[whichspell] = TRUE; // %%: we assume the spellbook is not allowed to contain duplicate spells
            }
        acase 5:
            if (cupped)
            {   give(907);
            } else
            {   give(906);
                cupped = TRUE;
            }
        acase 6:
            if (give(DEL))
            {   result = dice(3) / 2; // 1st..9th level
                result2 = result * 2; // number of spells in staff
                for (whichspell = 0; whichspell < SPELLS; whichspell++)
                {   learnedspell[whichspell] = FALSE;
                }
                for (i = 0; i < result2; i++)
                {   do
                    {   whichspell = anydice(1, SPELLS) - 1;
                    } while (spell[whichspell].level > result || learnedspell[whichspell]);
                    learnspell(whichspell);
                    learnedspell[whichspell] = TRUE; // %%: we assume the staff is not allowed to contain duplicate spells
}   }   }   }   }

MODULE void battleofwills(FLAG new)
{   int damage,
        evil_mentaltotal,
        good_adds,
        good_armour,
        good_mentalattack,
        good_mentaltotal;

    if (new)
    {   good_mi = (lk + iq) / 2; // %%: it doesn't say when Mental Integrity is reset
    }

    if
    (   items[DEL].owned
     || items[ITEM_BW_DELUXEI].owned
     || items[ITEM_OK_DELUXER].owned
     || items[ITEM_NS_HOMUNCULUS].owned
     || items[ITEM_AS_SDELUXE].owned
     || items[ITEM_GK_CDELUXE].owned
     || items[923].owned
    )
    {   if (level > 10)
        {   good_armour = level;
        } else
        {   good_armour = 10;
    }   }
    elif
    (   class != WARRIOR
     && (   items[MAK].owned
         || items[ORD].owned
         || items[ORQ].owned
    )   )
    {   good_armour = level;
    } else
    {   good_armour = 0;
    }

    for (;;)
    {   elapse(2, FALSE); // %%: we assume time elapses in the same way as in normal combat

        switch (class)
        {
        case  ROGUE:         good_mentalattack = daro();
        acase WARRIOR:       good_mentalattack = dice(3);
        acase WARRIORWIZARD: good_mentalattack = dice(3);
        acase WIZARD:        good_mentalattack = dice(level);
        }

        good_adds = 0;
        if (iq  < 9) good_adds -= 9 - iq ; elif (iq  > 12) good_adds += iq  - 12;
        if (lk  < 9) good_adds -= 9 - lk ; elif (lk  > 12) good_adds += lk  - 12;
        if (chr < 9) good_adds -= 9 - chr; elif (chr > 12) good_adds += chr - 12;

        good_mentaltotal = good_mentalattack + good_adds;
        if (been[67]) good_mentaltotal += 10;

        aprintf("You generated %d mental hits.\n", good_mentaltotal);
        evil_mentaltotal = dice(evil_dice) + evil_adds;
        aprintf("Opponent generated %d mental hits.\n", evil_mentaltotal);
        if (good_mentaltotal > evil_mentaltotal)
        {   damage = good_mentaltotal - evil_mentaltotal;
            aprintf("You won by %d points.\n", damage);
            damage -= evil_armour;
            if (damage < 0) damage = 0;
            if (evil_armour)
            {   aprintf("Opponent's mental armour absorbs %d hits.\n", evil_armour);
            }
            if (damage)
            {   aprintf("You inflicted %d actual mental damage on your opponent.\n", damage);
                evil_mi -= damage;
                aprintf("Your opponent's Mental Integrity is now %d.\n", evil_mi);
                if (evil_mi < 5) // disabled or killed
                {   return;
        }   }   }
        elif (good_mentaltotal < evil_mentaltotal)
        {   damage = evil_mentaltotal - good_mentaltotal;
            aprintf("You lost by %d points.\n", damage);
            damage -= good_armour;
            if (damage < 0) damage = 0;
            if (good_armour)
            {   aprintf("Your mental armour absorbs %d hits.\n", good_armour);
            }
            if (damage)
            {   aprintf("You suffered %d actual mental damage.\n", damage);
                good_mi -= damage;
                aprintf("Your Mental Integrity is now %d.\n", good_mi);
                if (good_mi < 5) // disabled or killed
                {   return;
        }   }   }
        else
        {   aprintf("A draw!\n");
}   }   }
