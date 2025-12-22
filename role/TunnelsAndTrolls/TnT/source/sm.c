#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

#define STATUS_NONE      0
#define STATUS_SLAVE     1
#define STATUS_CRIMINAL  2
#define STATUS_PIRATE    3
#define STATUS_PASSENGER 4

/* Ambiguities/errata (%%):
 87/15G: "Take hits on your CON equal to the number you missed the saving roll by...if you miss the roll, you die..."
 The picture on page 14 is perhaps intended for 80/14F (rather than 78/14D).
Notes:
 Although there is a Magic Matrix, paragraphs where it applies are not marked (eg. by '*').
*/

MODULE const STRPTR sm_desc[SM_ROOMS] = {
{ // 0/1
"`INSTRUCTIONS\n" \
"  Before you begin to adventure in this solo, you should be aware of several points that will aid your gameplay. Any character entering this adventure is limited to 45 combat adds and must enter alone. Magic is allowed and is regulated by a magic matrix; any time you wish to cast a spell, write the spell name down and go to the Magic Matrix on page 27 of this booklet. Only characters of the six major kindreds (human, dwarf, elf, hobbit, fairy, leprechaun) may enter.\n" \
"  The Sea of Mystery is magical by its very nature and is home to some Bermuda Triangle-esque effects. [You will find that the weapons you have given your character disappear to be replaced by more appropriate weapons for your situation. (If you encounter a shark and are armed with a broadsword, you will find it replaced by a dagger.) ]You will also find that being captured by slavers or pirates will strip you of your goods. You might want to avoid arming characters sent into this adventure; weapons will be provided and anything brought in can and probably will be parted from your character.\n" \
"  The code \"ap: XX\" appears after a number of paragraphs. The number indicates the number of adventure points granted to characters who survive that paragraph. Of course, other standard T&T abbreviations are also used within this adventure: 1d6 (one six-sided die), L1-SR (first level saving roll), gp (gold pieces), ST (Strength), IQ (Intelligence), LK (Luck), CON (Constitution), DEX (Dexterity) and CHR (Charisma).\n" \
"  Lastly you will notice something very different about Sea of Mystery. It was designed to provide maximum variability and continuing playability for those who play T&T primarily through the solo adventures. This is accomplished through a series of short interlocking adventures and pathways often determined by random throws of the dice. It is a new type of solo system and we would appreciate any feedback upon it that you care to offer.\n" \
"  You will find all the appropriate rules you need to play this adventure in the back of this book. We suggest you turn to them now and return here when you have read and understood them.\n" \
"  Of course you will need as many six-sided dice as you can lay your hands upon, paper and pencils to play. Good luck and have fun.\n" \
"  To begin, go to {73}.\n" \
"~INTRODUCTION\n" \
"  Sea of Mystery...The name echoes through your memory. You recall your elders warning you that if you were bad the Sea witches would come and take you away. When you grew older you heard the pirates and slavers of the Sea cursed by a thousand different voices. In late nights under full moons your fellows told tales of carnivorous plants, the dreaded Mesgegra vampire-demon and islands of beautiful amazons waiting for lost males.\n" \
"  On the coast below you sprawls one of the port cities on the Sea of Mystery. Travelling here you heard of the desert Yajna tribes and their raiding on the Iderian coast; of the Sardur raiders and their attacks upon merchant ships; but this has not daunted you. You've always felt the lure of the ocean; now you can realize a dream. Shouldering your bag you march towards the port...to take ship on the Sea of Mystery."
},
{ // 1/1A
"A customer of the Iron Bell accuses you of emptying his purse while he slept. Mog, the house mistress, believes the customer is always right and flogs you. Roll two dice and take it as damage from your CON. If you survive, go to {57}."
},
{ // 2/1B
"Escape is hopeless; you fall prone to the ground. Rough hands turn you over. You see the aquiline faces of the desert men. If you beg them to take you as a slave in order to spare your life, make a L2-SR on Charisma (25 - CHR). If you succeed, they take you to {75}. If you fail, they quench the thirst of the ground with your blood."
},
{ // 3/1C
"After a few moments of gentle coaxing, the door opens. Upon the threshold stands a scruffily attractive girl with red hair. So this is what you have been following! Cautiously, she takes your hand and urges you to follow her. To do so, go to {26}. To leave her, go to {48}."
},
{ // 4/1D
"A merchant ship hangs off the windward side; it flies the flag of a friendly nation, but also a flag of distress. Roll one die. If you roll a 1 or 2, your captain ignores it and sails to port at {141}. If you roll a 3, go to {147}. If you rolled 4-6, your captain orders his ship to close to investigate at {84}."
},
{ // 5/1E
"A sailor sees a sodden piece of cloth on the deck and picks it up; on it is a symbol he doesn't understand. You instantly recognize it and gasp, \"The plague flag!\" It's too late; a group of searchers call up from the forecastle. \"It's bloody hell down there! Bodies are everywhere!\"\n" \
"  The men form a frightened council. \"If the captain finds out about the plague he'll leave us out here to die! We'll have to keep silent until we get back on board; then it'll be too late for him to do anything!\" Agreeing, you all row back to the ship. If you want to betray the plotters and warn the ship, shout the word \"Plague!\" and go to {109}. If you say nothing, go to {33}. (ap: 30)"
},
{ // 6/1F
"This is the auction block where all of the women will be sold to harems, the scullery, or taverns. Roll one die to see where you end up. If you roll 1-3, go to {131}. If you roll a 4 or 5, go to {19}. If you roll a 6, go to {57}."
},
{ // 7/1G
"Breathless from your race through the jungle, you arrive at the village. All of the women gather round you and jabber questions at you. A warchief takes charge of the situation and you tell your story.\n" \
"  Weapons are handed out and the amazons quickly deploy themselves along a hilltop above the beach trail. The invaders spot the amazons and charge up the hill. The amazons rise and meet them with a withering hail of arrows.\n" \
"  To determine the outcome of the battle, roll one die. If it comes up even, go to {92}. If it comes up odd, go to {130}. (ap: 20)"
},
{ // 8/1H
"You adjust to a life of piracy aboard the Black Dragon; the company of freebooters is run like a rough democracy and the discipline is less severe than on the merchant ships you have known. Even the captain is a decent sort, forced into crime by cruel circumstances.\n" \
"  Occasionally the crew pulls into an island to careen the vessel or gather provisions. If you no longer wish to be a pirate, make a L2-SR on Luck (25 - LK). If you make the roll, jump ship to {74}. If you fail it, you are discovered at {32}.\n" \
"  If you want to earn pirate gold before you leave the ship, roll 1d6 for your adventures.\n" \
"    - If you roll a 1, you pull into port at {141}.\n" \
"    - If you roll a 2, you run into unforeseen events; go to {27}.\n" \
"    - If you roll 3-6, you have captured a ship. Roll one die and multiply by 100 for the number of gold pieces you get; roll one die and multiply by 50 for the number of adventure points you earn. (Note: there is no limit to the number of times you may roll the die for gold and adventure points as long as you get a 3-6 (ship captured) result.)"
},
{ // 9/2A
"A few days later the death toll has reached catastrophic proportions. You worry that some sort of contagious madness has seized the ship, causing men to destroy themselves. Only Larisa, the young lady from the ghost ship, keeps her courage. You are thinking of her beauty and her bravery when you are suddenly aware that she stands beside you.\n" \
"  You look into her deep and compelling eyes. \"I have never properly thanked everyone on this ship who helped to save my life.\" You stand speechless as her lips touch your cheek; you feel strange, unable to move of your own volition. \"Now you belong to me,\" she smiles.\n" \
"  Suddenly a shadow moves and she cries out. The girl falls away from you and you see her attacker: Pnouk, the old peglegged cook. He's clutching an iron sax covered with black blood that begins to smoke.\n" \
"  You look at the girl. She has been wounded - but instead of bleeding, her arm has blackened and shrivelled like an old corpse's. The cook cannot move; her power has stunned him as it has stunned you. \"Kill her!\" he shouts. \"She's a demon!\"\n" \
"  To shake off your immobility you must make a L3-SR on IQ (30 - IQ). If you make it, you tear the sax from his grasp and stab her for 300 adventure points and safe passage home to {141}. If you fail the saving roll, you stand immobile as she kills him and then turns towards you; your last memory of this life a deep a fatal kiss from her lips."
},
{ // 10/2B
"The crewmen look at you strangely. \"See, she's a witch!\" the captain cries. \"Helmsman, take my ship away from here.\"\n" \
"  \"You are a cruel man, captain,\" she shouts loudly as the ship pulls away. \"Your voyage is cursed, and I'll not succour you when you desire it!\" As you watch, her form changes to that of a dolphin and she vanishes beneath the surface of the sea.\n" \
"  Roll one die to determine the continuation of your voyage. If you roll a 1, go to {42}; a 2, go to {147}; a 3 or 4, go to {85}; a 5 or 6, go to {4} (unless you are a pirate, in which case you would go to {54})."
},
{ // 11/2C
"The sound of hammers rings in your ears as you labour in a rock quarry, cutting building blocks. The sun burns down on your back; you would swoon from the heat and labour, but the overseer's whip cuts the flesh of any tarrier.\n" \
"  To survive these inhuman conditions, you must make a L2-SR on Strength (25 - ST). If you succeed, go to {81}. If you fail, you die. (ap: 80)"
},
{ // 12/2D
"You enter the seaside Iron Bell tavern. It rings with broad laughter, song and the shouts of sailors demanding drinks. Slave girls in short silken costumes and rouge run swiftly between the tables, carrying pitchers of ale. Picking up the festive mood of the crowd, you wave over a honey-blonde serving girl and order a drink.\n" \
"  After pouring you several (at 1 gp each) she suggests, \"Perhaps you would rather be served in a private room?\" The meaning of her question is not quite clear to you.\n" \
"  If you would like to make love to her, pay the tavern mistress 20 gp and go to {41}.\n" \
"  If you get the idea that she wants to speak in private, and you want to listen, go to {101}.\n" \
"  If you wish to ignore her, and would rather gamble in the back room, go to {69}.\n" \
"  If you want to leave the tavern, go to {73}."
},
{ // 13/3A
"You swim with long, strength-saving strokes. You must be carrying no more than 1/20th of your weight-carrying capacity; if you're carrying too much, you must drop it. The beach looms nearer - the gods willing, you may make shore safely. Suddenly you spot a wisp of white water and a gliding fin. A shark! You hold perfectly still, praying it doesn't notice you. It won't, unless you fail a L2-SR on Luck (25 - LK). If you miss it, you draw your dirk because the shark is heading for you. The shark has a Monster Rating equal to 1d × 12 (12-72). If you made the saving roll or kill the shark, go to {74}."
},
{ // 14/3B
"You are no master seaman yourself, but you and your novice crew managed to push the ship off into the water. The wind nudges you out to sea while you pray that somehow you may reach a civilized coast. Make a L2-SR on Luck (25 - LK). If you make it, you managed to arrive in port at {141}. If you miss the roll, go to {85}. (ap: 30)"
},
{ // 15/3C
"A sail appears on the horizon. The lookout yells, \"It's the Sardur commerce raider, the Red Shark!\" The captain orders the crew to outrun the enemy vessel. \"The Shark is a privateer that preys on ships like this,\" he tells you. Pointing towards a distant fog bank he continues, \"If we can make it into the fog we'll be safe. You'd best wish us luck!\"\n" \
"  Wish them luck. If you can make a L2-SR on Luck (25 - LK), your ship will outdistance the enemy and arrive at {141}. If you fail the roll, bad luck dooms your escape and you must go to {47}."
},
{ // 16/3D
"As you make your weary way out of the surf, you see lights ahead. This land is inhabited. Down the beach some men are fishing. If you want to speak with them, go to {98}. If you wish to sneak into the village and steal some food and clothing, go to {119}. If you have gold to spend, go to the port at {141}. (ap: 10)"
},
{ // 17/4A
"You can scarcely believe it, but a ship is approaching. You frantically wave at it until they see you and send out a boat. You do not realize what sort of a ship it is until you have boarded it. If you roll a 1 or 2, it is a merchant ship and you go to {96}. If you roll a 3 or 4, it is an unsavoury ship that impresses you into the crew; go to {39}. If you roll a 5 or 6, you have been rescued by a slave ship. They treat you to a set of chains at {121}. (ap: 20)"
},
{ // 18/4B
"Once you are out to sea, your captain reveals that he has a map to a sunken treasure. He asks for volunteers to dive to the submerged wreck and bring up the plate and coin. If you do not want to volunteer, go to {96}. When the recovery is finished, you won't get a share of the treasure - after all, you did nothing to earn it.\n" \
"  If you want to dive, roll one die. If you roll a 1, you must fight a shark with a 45 MR. If you roll a 2 or 3, your dive is unsuccessful. If you roll a 4, you recover 10 gold pieces. If you roll a 5, you recover 100 gold pieces. If you roll a 6, you recover a jewelled item (roll for it on the jewel generation chart in the rules).\n" \
"  Each of your compatriots do as well as you do so the wealth you have recovered represents your share. You may only attempt 5 dives on this voyage. Once you are finished, go to {96}. (ap: 20/dive)"
},
{ // 19/4C
"You find that the life of a harem girl consists mainly of bored confinement. Even so, you are aware that your master will send you back to the auction block when he tires of you. You consider your options: You might steal a dirk and fight through the eunuch guard (MR of 1 die × 8) and make it to {62}; or you might seek to make your master fall in love with you, marry you and grant you your freedom. To pursue this latter course make a L3-SR on Charisma (30 - CHR). If you make it, go to {158}. If you miss, he tires of your charms and sells you at {6}. (ap: 10)"
},
{ // 20/4D
"The captain nods to his men. \"This landlubber wants to go to port; I guess we can oblige!\" They seize you from behind, bind you and take you to {121}. (ap: 40)"
},
{ // 21/4E
"You finally see a living thing as you stroll down the beach - a flying bird. Before you can run after it, you hear a moan in the mushroom forest. To follow the bird, go to {53}. To investigate the moan, go to {89}."
},
{ // 22/4F
"You climb the temple steps warily; reaching the fallen doors, you pause. The old oaken panels bear the imprint of small sandalled feet. You scramble excitedly through the dark archway and advance along the aisle. Benches sprawl at odd angles, their surfaces bored by termites.\n" \
"  As your thoughts run on, you pick up the stealthy sound of light feet. Dashing for the wrought-iron staircase you climb toward the source of the sound upstairs. A door stands ajar; the odds are that the fugitive is inside.\n" \
"  If you charge in, go to {97}. If you try to coax the unseen stranger out with soft words, go to {155}. If you would rather turn around and leave the temple, go to {124}. (ap: 10)"
},
{ // 23/4G
"\"This man is the greatest fighter on this ship and he just saved my life. He's going to be my first mate - and I do mean mate!\" the captain declares. \"Are there any objections?\"\n" \
"  \"I object!\" says the first mate. \"If he's a fighter, let him face me with boarding pikes!\"\n" \
"  If you urge your companion to throw this man in irons, go to {125}. If you defend your right to be first mate, take a boarding pike (4 dice in combat), and square off with your similarly armed foe. He has 30 adds and a CON of 18. If you survive, go to {82}. (ap: 12)"
},
{ // 24/5A
"You beat on the stockade gate, begging the women to let you in. They open the gates and you see that less than half of the warriors escaped the fight and pursuit. \"We have no hope,\" says Peleki, \"unless we send a messenger to the goddess, asking her to intervene! Prepare the sacrifice!\"\n" \
"  Suddenly ten women grab you and drag you to the altar. \"But I was the person who warned you about the attack!\" you protest.\n" \
"  \"We love you for that,\" Peleki says, \"but you were the last to join us. Therefore, we give you the first chance to seek aid from the goddess. Accept this honour, for it is very great.\"\n" \
"  To decline this great honour and fight for your life, make a L2-SR on Charisma (25 - CHR). If you make it, the amazons do not try to restrain you as you escape. If you miss it, multiply the number you missed by 10 to yield the MR of the crowd attempting to stop your flight. If you defeat them, or are not restrained, you burst into the jungle at {148}. (ap: 50)"
},
{ // 25/5B
"While the others search elsewhere, you probe the small passenger cabins below. You raise your sabre, but recognition arrests its movement. A young woman in a white decolletage stands trembling against her bunk. \"Thank the gods!\" she cries. \"A human being!\"\n" \
"  You ask the logical questions and she explains that her name is Larisa and that her father, the captain, had shaken her awake some days before and told her to bar her cabin - strange sea creatures were swarming aboard the Grey Moon and the crew was trying to drive them off. He left her and never returned; when she dared to emerge from her cabin and explore the ship, she discovered she was all alone.\n" \
"  You summon the rest of the search party and they agree to take the girl back to the other ship. Roll a die. If it comes up an even number, go to {141}. If it is odd, go to {133}. (ap: 20)"
},
{ // 26/5C
"The girl leads you through the ruins of the ancient city and pauses at a mighty brick house. She gives a series of rapid knocks on a cellar door and it opens.\n" \
"  An old man looks up from the cavity, surprised at the sight of a stranger. He quickly recovers from his amazement and summons you both down.\n" \
"  If you fear a trap, speed to {124}. If not, descend to {70}."
},
{ // 27/5D
"Unexpected events. Roll one die. If you roll a 1, go to {85}. If you roll a 2, go to {147}. If you roll a 3 or 4, go to {122}. If you roll a 5 or 6, go to {54}."
},
{ // 28/5E
"They are very friendly and take you home. They give you some clothes that belonged to a fisherman who drowned last week, and share their meal of baked fish and bread with you. Afterwards, you trade stories and tall tales. When you feel fit, you thank them and begins the short trek to the port city a few miles down the coast at {141}."
},
{ // 29/6A
"You think you have made a friend. A handsome young sailor has visited the tavern frequently and has repeatedly sought your company. You hope he is falling in love with you, so you can have his help to escape.\n" \
"  Make a L3-SR on Charisma (30 - CHR). If you make it, go to {91}. If you fail, you find that this is his last visit; the cad just wanted to tell you that he was getting married and will think of you often. Go to {57}."
},
{ // 30/6B
"Rowing the galley has broken you. One day your strength fails and you collapse across your oar with a raging fever. Rather than let you start a plague, Klon the guard throws you to the sharks."
},
{ // 31/6C
"You and Delia launch your raft into the ocean. The breeze is swift and you begin to have hopes of reaching land. The woman, you find, is as wealthy as she is beautiful. This does not prejudice at all your offer of marriage. Roll one die. If it comes up even, you reach a port at {158}. If it comes up odd, go to {85}."
},
{ // 32/6D
"\"No you don't!\" growls Cosmas, one of your shipmates, as he grips you by your shirt. He is not alone and your shipmates quickly pummel you into unconsciousness.\n" \
"  \"You have wronged us,\" says the captain, \"and we've agreed on your fate. You wanted to get to land so badly - well, we've gone and found a piece for you. Take this dishonest dog over to it!\"\n" \
"  The crewmen bundle you into a boat and row you out to a bleak sand bar, leaving you only a loaf of bread, a bottle of water and a stiletto. \"If you make it from here, you deserve to get away! Haw!\" laughs one of your former crewmates. In an hour the ship has passed out of sight. Marooning is to be your bitter fate. By the next day your provisions are gone and you are suffering horribly from the sun.\n" \
"  Average your IQ and Charisma. (Add them and divide by two.) Make a second level saving roll on that number (25 - (IQ + CHR) ÷ 2) to see if you can stave off despair. If you succeed, go to {17}. If you miss it, you slit your wrists with your stiletto; your life drains away as the sun sets. (ap: 80)"
},
{ // 33/6E
"\"Well?\" demands the captain as the search party returns from the ghost ship. The men look glumly at one another. \"Speak up when I talk to you!\"\n" \
"  \"All right, Captain,\" says the group leader, \"we'll tell you now that it won't do you any good to throw us back into the sea. That ship was filthy with plague!\"\n" \
"  \"You devils!\" shouts the captain, but he knows his violence is useless. \"We may all die on this voyage - but if we live, I'll see that no shipmaster will ever take you on again!\"\n" \
"  Roll one die. If it comes up even, plague strikes the ship. If this happens you will need to make a L3-SR on Constitution (30 - CON) to survive. If you miss the roll, take damage equal to the number you missed the saving roll by. If you live, you find yourself all alone at {153}.\n" \
"  If the die came up odd, plague did not strike the ship. Roll another die. If it comes up even, go to {141}. If it comes up odd, go to {96} (if you are a pirate, go to {8}). (ap: 40)"
},
{ // 34/6F
"The ship goes on and on; fog has blanketed the sea for days. Only now has a cold drizzle thinned it somewhat. You cast your dull gaze ahead, and gasp - something dark hides behind a thin veil of mist. Slowly the shapes become the definite outline of buildings; you have found a port!\n" \
"  You managed to loot the ship for 1 die × 1,000 gp in wealth. To determine which port you are in, roll one die. If you roll a 1 or 2, go to {66}. If you roll a 3 or 4, go to {141}. If you roll a 5 or 6, go to {115}."
},
{ // 35/6G
"It's a slovenly ship you see tied to the pier. The crewmen look rougher than most merchant mariners. As you climb the gangplank, the sailor playing the hornpipe stops to stare at you. Eyes follow you to the quarterdeck where the captain is musing over his charts. You ask if he is taking on hands.\n" \
"  \"Aye, matey. I'm sailing at dawn and you've a job if you want it!\" You suspect this man *might* be a pirate. If you don't mind, you take the job. Roll one die. If you a roll a 1 or 2, go to {8}. If you roll 3-6, go to {149}. If you don't want to sail with him, go to {73}."
},
{ // 36/7A
"As you lie helplessly bound, a strange sea creature rises from the surf. It looks like a thick eel with short webbed feet and a suckerlike mouth full of needlelike fangs. The hideous wet body creeps towards you, glides over your legs and presses its mouth to your heart. You feel a sharp pain, then oblivion as the creature drains the lifeblood from your arteries."
},
{ // 37/7B
"You greet the men as they draw their boats onto the beach. With a snarl their leader commands two of his men to grab you. They do and quickly strip you of any weapons you may be carrying. \"If all the inhabitants of this island are as meek as you,\" one sneers, \"we'll have an easy time filling our ship with goods.\"\n" \
"  Horrified, you realize that these men are slavers. Rough hands shove you toward one of the longboats. If you give in meekly, you are bound and sent to {121}. To buy your freedom by betraying the amazons, go to {111}. To pretend to aid the slavers in an attempt to destroy them or warn the amazons, go to {106}. (ap: 50)"
},
{ // 38/7C
"Your guards escort you to the small native village of Zoume. They throw you into a guarded hut. As you crumple to the straw mat floor, a husky female voice demands, \"Who are you?\"\n" \
"  You look up to see a green-eyed brunette wearing short cut-offs and a tattered sailor's blouse. You mumble out your recent history; in return she informs you that her name is Delia and she came to the island on a ship that was kept in the local cove by perverse winds. When she went ashore to explore, the natives captured her.\n" \
"  \"My ship might still be in the cove. We must escape because I am sure the tribesmen will soon put us to death!\" If you want to escape, go to {107}. If you want to wait and see what the natives are planning for you, go to {126}."
},
{ // 39/7D
"Roll one die. If you roll 1-4, go to {149}. If your result is 5 or 6, go to the pirate ship at {8}."
},
{ // 40/7E
"You have decided you joined a bad ship. The captain is a greedy scoundrel who pays the worst wages on the sea and feeds the crew on the cheapest swill money can buy. The smallest infraction of the rules leads to brutal floggings; you resolve to jump ship as soon as possible. While you are making plans you learn that the captain keeps most of his gold in an iron chest in his cabin.\n" \
"  The captain and most of his crew have gone ashore in this foreign port; you see this as your chance to escape. If you would like to sneak ashore in a small boat, go to {93}. If you would like to rob the captain's chest, first go to {67}. If you wish to remain with the ship, go to {142}."
},
{ // 41/7F
"She is passionate as well as lovely; take two dice worth of adventure points. Afterwards, she looks as though she wants to say something. To hear her out, go to {101}. If you would like to leave her to gamble in the back room, go to {69}. If you wish to ignore her and leave the tavern, go to {73}."
},
{ // 42/7G
"Fog closes around the ship and the winds die. The sails hang slack while blind currents carry the ship along. The ship wanders aimlessly for days and the crew begins to worry about the dwindling supply of fresh water. When the fog finally dissipates, you find the ship lies off a vast muddy plain at the mouth of a sluggish estuary.\n" \
"  From the masthead the lookout can see only a few small, scrubby trees. The first scouts report that the river water tastes foul, and the captain decides to send a party farther inland to try to locate a fresh spring before the water supply is totally exhausted.\n" \
"  If you are a passenger, go to {144}. If you are a crew member, roll one die: even go to {144}, odd go to {72}."
},
{ // 43/7H
"You eat a lump of fungus and immediately feel strange. You collapse in agony. As you pass into violent madness, you notice that the fungus is causing your whole body to become yet another of the mushrooms that flourish on this doomed atoll."
},
{ // 44/8A
"Several dead man lie at your feet, but the raiders have overwhelmed your compatriots. Several of them close with you, murder in their eyes. They are about to attack when their leader cries out, \"Wait! Anyone as strong as that is worth much to foreign slavers!\"\n" \
"  If you allow yourself to be taken slave, go to {100}. If you wish to commit suicide, do so and go to {134}."
},
{ // 45/8B
"Training in the Eagle's Hill gladiatorial camp is not easy, but you soon adapt and gain a certain amount of skill with your chosen weapon. (Choose one weapon, not a bow, that you want to train with. For each creature you kill, add 3 to your combat adds whenever you fight with this weapon. This only holds to creatures slain while you are a gladiator.)\n" \
"  If you have Arena of Khazan, your character is sent to fight[ five fights for your master. If he wins 10,000 gp on bets in those fights, he sets you free and gives you 100 gold pieces and all magical weapons you might pick up. If your 5 fights fail to net him 10,000 total, he keeps you fighting until you earn him that money. Once you do, all of the above conditions apply. (Ignore the rules in Arena of Khazan about three or ten fights: this is a special case.)\n" \
"  If you do not have Arena of Khazan, you must fight five foes, one at a time, ranging in MR from 20-70. (Roll one die and add one to the result. Multiply this by 10 for the Monster Rating of your human foe.) At no time will you ever fight a foe with a Monster Rating lower than the last one you fought. If the MR rolls up lower, fight a foe of the same strength at the one you just defeated. (Example: Phredd has killed a 30 MR man. His next foe rolls up to be a 20 MR man. The arena officials pull this guy and replace him with a fighter with a 30 MR. If Phredd kills him and then rolls up a 40 MR man they will allow the fight to proceed.) If you win all five fights, your master frees you and gives you 100 gold pieces.\n" \
"  Once you have been freed, your master sends you to the friendly port at {141}. If a fight looks very dangerous and you wish to attack one of the 30 MR guards in an escape attempt, kill him and go to {62}]."
},
{ // 46/8C
"You have no intention of remaining rooted in one spot for long. You build a raft and paddle out into the open sea. For your final destination, roll one die. If you get a 1, go to {123}; if a 2, go to {85}; if a 3, go to {141}; if a 4, go to {17}; if a 5 or 6, go to {74}."
},
{ // 47/8D
"The wind fails and the Red Shark draws close. Your captain knows there is no hope and strikes his colours. The Sardur soldiers grapple your ship and board. The Sardur captain, confident and handsome in his uniform, strides up to your captain and accepts his sword.\n" \
"  \"Your ship and cargo is hereby impounded in the name of his Highness the King of Sardur.\"\n" \
"  \"My sailors know nothing of politics,\" your captain says bravely. \"Leave them, and the passengers, alone.\"\n" \
"  \"Nonsense,\" says the officer, a wolfish grin on his face. \"We need galley slaves like all other nations. And the women, they will bring much gold on the auction blocks.\"\n" \
"  Even as the captain of the Sardur ship says this you feel rough hands upon you. If you are male, go to {150}. If you are female, go to {121}. (ap: 10)"
},
{ // 48/9A
"As you press ahead, something moves in the ruins. You advance cautiously, picking your way over a heap of shattered bricks. An unexpected grunt draws you up short; out of the alley lumbers a monster as bulky as a buffalo, with webbed hands and huge, curled horns. It lowers its head and charges like a battering ram. If you make a L2-SR on Dexterity (25 - DEX), you avoid the beast; go to {94}. If you miss it, or choose to fight the animal, you discover it has a MR of 50. If you win, go to {113}."
},
{ // 49/9B
"A seedpod lands square on your back; the thorny surface strikes painfully, then you feel numb. As you slip into unconsciousness, your comrades race away in panic. For what seems an eternity you hang in limbo. When you try to move, you realize you are imprisoned in the trunk of a hideous tree. Your anguished cry is answered by every tree in the grove."
},
{ // 50/9C
"The pirates have been repulsed. All the crew, passengers and slaves who fought them zealously receive 100 gp as a reward and are put ashore in port at {141}. Those who did not fight well go to {121} as cowardly criminals."
},
{ // 51/9D
"\"Captain!\" shouts the lookout aloft. \"That bloody ghost ship has disappeared!\" You stare out over the bulwarks and see that it is true! All the boarding party is carried away into oblivion. You thank the gods that you were not one of them!\n" \
"  Roll one die. If it comes up even, go to port at {141}. If it comes up odd, go to {96}."
},
{ // 52/9E
"Your captain is bound for the Iderian coast. There, some desert tribes are besieging the coastal cities and many rich citizens are paying any price for passage to safety. When you reach the port of Magodha, the ship fills with rich men and women; your share of the profits will come to about 50 gp.\n" \
"  Upon the gangplank appears a priest. Behind him stands a crowd of poor people. \"I have no money,\" Botan tells you, \"nor does my flock. They are poor people who fear massacre by the desert nomads. Will you not take them out of charity?\"\n" \
"  To speak in favour of the poor refugees, go to {138}. If you keep your mouth shut, roll one die. If it comes up 1 or 2, go to {96}; 3 or 4, go to {85}; 5 or 6, go to {122}."
},
{ // 53/9F
"The birds are flying thickly over a small rocky islet. You do not see any mushrooms growing over there. You do see a small shark in the channel between the islands. You wonder if the risky swim is worth the meals of birds' eggs certain to be found there.\n" \
"  Make a L2-SR on Dexterity (25 - DEX) to avoid the shark. If you make the roll, go to {159}. If you miss it, you must face a shark with a MR on 10-60. (Roll one die and multiply the result by 10 for the MR.) If you survive the fight, go to {159}.\n" \
"  If you would rather pass up the swim and dine on mushrooms, go to {43}."
},
{ // 54/10A
"\"Warship to port bow!\" shouts the lookout. The pirates rush to the rail and observe a large swift ship, the Flame Tiger, bearing down on the freebooters. Your ship heads for the shallows attempting to lose the deeper-draft pursuer.\n" \
"  Roll one die. If it comes up even, you neatly elude the Flame Tiger and go to {8}. If it comes up odd, the ship overtakes you. You are caught and bound as a criminal; go to {121}."
},
{ // 55/10B
"The law in this cruel land allows the natives to enslave strangers. You are one of the latter, and the fishermen are the former; they capture and escort you to {77}. (ap: 30)"
},
{ // 56/10C
"You rush to the beach and see Delia staked out naked on the sand. She screams and you see why! An eel-like creature with a fanged mouth is waddling towards her on small webbed feet.\n" \
"  To rescue her you must kill the monster. Roll one die and multiply it by 12 to determine the creature's Monster Rating. Your native spear is worth 3 dice plus 1 add. If you attack and slay the monster, go to {143}. If you run in terror, go to {46}."
},
{ // 57/10D
"The Iron Bell tavern rings with broad laughter, song and the shouts of sailors demanding drinks. Serving girls wearing baubles, rouge and a short slip of silk run swiftly to their call, carrying pitchers of ale through the milling carousers. You are one of them, performing the hectic duties of a tavern slave. You reel with exhaustion, but do not dare to rest for fear of being seen idle by Mog, the tavern mistress.\n" \
"  Sometimes the sight of adventurers reminds you painfully of your old life. Under such pressure your require a first level IQ saving roll (20 - IQ) to avoid the temptation to commit suicide. If you make it, go to {136}. If not, you steal a sword from a drunk patron and fall upon it; obtaining the release from slavery that you thought would never come. (ap: 40)"
},
{ // 58/10E
"\"This is my ship and I'll not have the likes of you telling me how to run it,\" the captain snaps at you. \"I'll not risk my ship for an old fishwife, let the sea take her!\"\n" \
"  He turns from the rail and you see the woman's eyes burn with hatred. She looks at you and kindness replaces the hatred for a moment. \"Charity such as yours deserves reward,\" she mumbles as she splashes a handful of seawater into your face. \"As the sea is the source of the cycle of life,\" she chants mystically, \"I bless you with it.[ Should this mortal body you wear perish, your soul will reincarnate into another body.]\"[ (Read {156} and record the information therein upon your character card. When and if this character dies, follow the instructions there.)]\n" \
"  For now, go to {10}."
},
{ // 59/10F
"You sink your fingers into wet sand and claw your way beyond the surf line on the beach. Exhausted, you collapse and sleep for a short time. The sounds of the island intrude into your dream; when you finally open your well-rested eyes you find that the island agrees with your dream of a lush jungle alive with monkeys and brilliantly coloured flowers and birds.\n" \
"  You stagger to your feet and lean heavily against a tree. Without warning an arrow bites deeply into the tree, inches from your face. You wheel, stumble, and sink to your knees shouting, \"Don't shoot, I'm unarmed.\"\n" \
"  With arrows nocked in their bows, several young and beautiful women emerge from the jungle and draw near. They are clad in scant garments of animal skin and bronzed by the tropical sun. Make a L1-SR on Charisma (20 - CHR). If you miss it, they mistake you for some ill-spawned sea monster and shoot you full of their arrows. If you make it and you are female, go to {114}. If you make it and are male, go to {78}. (ap: 10)"
},
{ // 60/10G
"Sordor, your overseer, has decided you are a coward and takes sport in provoking you with abuse and extra work. Under such treatment you must make another L2-SR on Strength (25 - ST) to survive. If you do survive, go to {102}. (ap: 50)"
},
{ // 61/12A
"The men on the ship are surprised to see the woman return - and with a stranger. They assist you to the deck. No sooner are you on board than you realize your companion hadn't told you much about herself. This is a pirate ship! \"Who's the landlubber, M'lady?\" the first mate asks Delia.\n" \
"  If you are male, go to {23}. If not, make a L1-SR on Charisma (20 - CHR). If you succeed, you join them and go to {8}. If you fail, they bind you and you end up at {121}. (ap: 10)"
},
{ // 62/12B
"In your distinctive slave clothing it is not so easy to escape the hue and cry that pursues you. To get some civilian clothes and reach safety, make a L3-SR on Luck (30 - LK). If you make it, go to {141}. If you fail, you are hung as an escaped slave."
},
{ // 63/12C
"The sun shines brightly as you trek back and forth from the ship and pool, hefting heavy barrels of water. Well before sundown all of the ship's barrels have been filled. Anxious to be free of this accursed shoreline the crew weighs anchor and rides the tide away.\n" \
"  Roll one die to determine the outcome of the rest of your voyage. If you roll even go to {141}; odd go to {96} (unless you are a pirate, in which case you should go to {8}.) (ap: 10)"
},
{ // 64/12D
"The low roar of the sea takes on a threatening sound as the longboat bobs up against the side of the ghost ship, the Grey Moon. Your group leader shouts, \"Anyone aboard?!\" but there is no answer. A loose rope dangling down into the water provides an easy means to climb up to the deck. Roll 1d6. If it comes up 1 or 2, go to {117}; 3 or 4, go to {5}; 5, go to {25}; 6, go to {112}."
},
{ // 65/12E
"The pirates of the Black Dragon quickly conquer your ship. All who fought the pirates with zeal are put to the sword. If you didn't fight them too zealously, the pirates offer you a chance to join their crew. If you accept, go to {8}. If you decline, they take you prisoner; go to {121}."
},
{ // 66/12F
"The ship beaches itself without undo damage. You leap ashore and caper about in joy. But after only a few steps, you stagger to a halt; this is not what you expected. The buildings totter crazily with rot and age; the weatherbeaten structures seem empty and ruined.\n" \
"  If you approach the town carefully along its periphery, go to {88}. If you walk boldly down its centre looking for people, go to {113}."
},
{ // 67/12G
"The old miserly captain had a lock on his door as old as history. You work quickly and break open the treasure chest. You seize 1 die × 1,000 gp worth of gems, and you must now attempt your escape. Make a L3-SR on Luck (30 - LK).\n" \
"  If your roll is successful, go to {93}. If you miss the roll, go to {32}."
},
{ // 68/12H
"Roll one die. If you roll a 1 or 2, a passerby recognizes you. If you have ever earned adventure points at {8} as a pirate in this incarnation, go to {119}. If you have never been a pirate, you chat and then you go either to the tavern ({12}), or on your way to {73}.\n" \
"  If you roll a 3 or 4, you hear a scream from an alley to your right. You dash in and rudely interrupt a gang of thieves as they rob a rich-looking man. As they flee, he gives you [a ring set with ]two gems. (Use the jewel generator in the rules for determining their value.) From here you may go to the tavern ({12}), or wander to {73}.\n" \
"  If you roll a 5 or 6, you stroll down the streets until something strikes you on the head. You wake up at {149} - shanghaied; without gold, weapons or armour."
},
{ // 69/12J
"Several men are playing cards around a table. They seem affable and invite you to join. To gamble, make a bet (maximum bet is 100 gp) and roll two dice. Each time you roll doubles, you win four times your bet. Each time you roll anything else, your bet is lost.\n" \
"  Play as long as you like, then go to {141}."
},
{ // 70/13A
"The people you have discovered lead a weary frightened life, constantly fleeing and hiding from the horned monsters. As the days pass you learn enough of their language to reconstruct their story.\n" \
"  This was Anthelios, a prosperous port in ancient days, but the sin and impiety of the inhabitants angered the gods. They cursed them to be forgotten by the outer world and be attacked by the creatures of the swamp. A generation before, the city's walls had been breached and only a few people managed to survive to the present.\n" \
"  If you settle here, go to {124}. If you construct a small boat from available wood and head for open sea, go to {46}. If you train the survivors as sailors and take the derelict ship out to sea, go to {14}. (ap: 20)"
},
{ // 71/13B
"Musing over the mounting deaths, you recall a sea tale about a demon called the mesgegra that vampirizes human beings of their life force; it always appears as a young maiden. You take your suspicions to the captain, but when you talk to him he becomes angry. \"Your ideas are insane!\" he screams. \"If you insult the lady Larisa in front of anyone else, I'll have you hauled beneath the keel!\"\n" \
"  As you walk away you bear a grim thought: he would not have reacted so irrationally had he been himself. You are sure he has fallen under the spell of the mesgegra. She has probably gathered other slaves from the crew. Now that you have voiced your suspicions your life is in danger.\n" \
"  You may steal a lifeboat and flee that ship by going to {123}. If you desire to confront and destroy the mesgegra yourself, read on.\n" \
"  You have one chance; you know demons cannot bear the touch of cold iron. You draw your poniard and go looking for her. Spotting the maiden across the deck, you move towards her in a friendly manner. When you are close enough, you spring. If you make a L2-SR on Dexterity (25 - DEX), you manage to plunge the dagger into her breast for 300 adventure points and a voyage home to {141}. If you fail she dodges and you land sprawling upon the deck. As you look up your will goes out of you. She kneels, her slender arms outspread; her kiss your last memory in this life."
},
{ // 72/13C
"As dusk nears, the captain decides to wait until morning to send out the exploring party. The island makes you feel uneasy and you cannot sleep. You leave your bunk and pace the deck; the ominous sounds from the muddy beach send shivers up and down your spine.\n" \
"  To your left, something moves - a hulking mass, little more than a tangled mass of writhing tentacles, draws itself onto the deck. You spin to flee into the interior of the ship, but your mates, unaware that you are outside, have braced the door against an attack by the monster. If you beat upon the door while shouting to them to admit you (and make a L3-SR on Luck (30 - LK)) they will let you in.\n" \
"  If they don't let you in, or if you choose to get some exercise in the night air, you may battle the monster. In addition to the sabre at your side, you also wear the standard issue leather armour that is supplied to the crew. The creature has a Monster Rating of 20-70 (roll 1d6, add 1 to the result and multiply by 10 to determine the MR).\n" \
"  If you defeat the monster in combat or are let back into the ship by your compatriots, go to {144}. If the creature kills you, feel confident that you will have the prayers of your crewmates to help speed you to whatever rewards you deserve."
},
{ // 73/13D
"You contemplate what this Candavan port has to offer as you stroll along the busy streets. If you want to explore the town and/or buy some provisions, go to {141}. If you think a job with the unsavoury captain everyone is speaking about is just what you have been looking for, go to {35}. If you wish to book passage on a ship bound for new and exciting lands, go to {116}. You can also join a caravan that is bound for adventures elsewhere (hence leaving this adventure); do this automatically."
},
{ // 74/13E
"An island lies just ahead. Roll one die. If it comes up a 1, go to {59}. If you roll a 2, go to {16}. If you roll a 3, go to {129}. If you roll a 4, go to {110}. If you roll a 5, go to {148}. If you roll a 6, go to {115}."
},
{ // 75/14A
"For months you are the helpless slave of a demanding barbarian chief. But by diligent application you eventually gain his trust enough to find the privacy to build a secret raft.\n" \
"  If you fear to use the raft, go about your appointed chores and never leave this adventure. If you are brave enough to risk the unknown, go to {46}."
},
{ // 76/14B
"The serving girl leads you hurriedly to a handsome private yacht in the harbour. She runs up the gangplank and a guard above scowls at the approach of a common adventurer and a tavern wench.\n" \
"  The girl casts a frantic glance toward the nobly-dressed men and women who lounge against the rails on the upper deck and look down upon the action. \"You must remember me, you must!\" she implores, her voice tinged with desperation.\n" \
"  A dapper gallant clothed in rich silk robes stares at her. Recognition dawns in his eyes. \"Baroness? It is you! They said you were dead! Come aboard, o do come aboard!\"\n" \
"  Her friends hurry to meet her and embrace her joyfully. If you are a male who is interested in enlarging your friendship with the Baroness, make a L2-SR on Charisma (25 - CHR). If you succeed, go to {158}. If such romance is out of the question, take 1 die × 500 gp in reward for your gallant actions and go to {141}. (ap: 40)"
},
{ // 77/14C
"You are herded in chains to the slave market. Business is brisk. As the auctioneer shouts, \"Sold!\" you wonder if you will ever regain your freedom. For now, male characters should go to {128}. All female characters are remanded to {6}."
},
{ // 78/14D
"The women prod you indecorously along a jungle path; you stumble into their village - an all-female community. You are fed, and housed in a hut, but the women stay away from you for several days. Then one afternoon Peleki, the old chieftainess and leader of the amazon village, comes to visit you.\n" \
"  \"We only allow one man in our village at any one time. One man is enough to maintain our numbers while not limiting our freedom. Since you have arrived there are now two men in our village; you must fight the other until only one of you survives.\"\n" \
"  At spearpoint you leave the hut you had called home. They lead you into the centre of the village. Your foe is introduced as Aristerion. He's devilishly handsome and looks strong. He has 9 personal adds and a CON of 16. Peleki tosses a dirk onto the sand before each of you. \"Fight!\" she commands.\n" \
"  If you kill Aristerion, go to {137}. (ap: 80)"
},
{ // 79/14E
"You are too superstitious to volunteer to go out to the ghost ship. Instead you watch the boarding party organize and row out to the strange derelict. For the consequences, roll one die. If you roll a 1 or 2, go to {117}. If you roll a 3 or 4, go to {33}. If you roll a 5, go to {133}. If you roll a 6, go to {51}."
},
{ // 80/14F
"You spring at the monster. If you can make a L3-SR on Dexterity (30 - DEX), you get one free combat round and can take your total damage from its Monster Rating of 50. After that, or if you miss the saving roll, you must fight it normally. If you vanquish this creature, go to {139}. If you lose, the monster shreds your unresisting corpse. (ap: 20)"
},
{ // 81/15A
"You endured the labour of the quarries until Lord Exazenus, your owner, notices you. He has you brought to him.\n" \
"  \"I have been watching you; I'm impressed with your strength. Do you have the courage it takes to fight as a gladiator?\" If you reply that you do, go to {45}. If you decide you do not, go to {60}."
},
{ // 82/15B
"During successful months as a pirate, the captain has accumulated a mountain of wealth. She suggests that you marry her and settle down on shore somewhere. If you like that idea, go to {158}. If not, tactfully demure and go to {8}."
},
{ // 83/15C
"To buy her freedom, give the house mistress 500 gp and go to {127}. If you do not have the money, your only hope is to trick your way out.\n" \
"  You cross the room and strike up a conversation with the guard. You chat and offer to buy him a drink. As your lady comes forward he reaches out to take a mug of ale from her stay - and you stab him with your misericorde. His Monster Rating is determined by rolling one die and multiplying the result by 10. For your unexpected strike you may take your first round of hits directly from his MR.\n" \
"  If you kill him, roll one die. If it comes up even, go to {127}. If it comes up odd, you are separated from your lady and you end up at {119}."
},
{ // 84/15D
"As soon as your ship is close, the other vessel strikes its false flag and raises the banner of piracy! \"Damn my stupidity!\" swears the captain. \"There weren't supposed to be any pirates sailing these waters!\" He knows his small vessel is outclassed and gives orders to arm the passengers and any slaves on board who are willing to fight. These last are promised their freedom if they fight with zeal.\n" \
"  If you would like to fight the pirates with zeal go to {132}. If you will take a weapon, but fight with a conspicuous lack of zeal, go to {103}."
},
{ // 85/15E
"The ill-fated voyage ends in disaster! A tempest arises, dashing the craft against the reefs of an unknown coast. Its hull is destroyed and you are pitched into the brine. You cling to a piece of wreckage, praying that your strength holds out until the sea calms enough to let you reach land.\n" \
"  Make a L2-SR on Strength (25 - ST). If you succeed, go to {74}. If you fail, so does your strength and you are torn to pieces against the reef by the force of the savage sea. (ap: 50)"
},
{ // 86/15F
"Make a L3-SR on Constitution (30 - CON). If you make it, you live despite dehydration; go to {153}. If you miss it you die, wrinkled and dried like a raisin."
},
{ // 87/15G
"\"Leave him alone, Turus,\" says your group leader. \"He's right and we're wrong.\" The sailor lets you go and gloomily sinks upon the bench. \"Well,\" says the group leader, \"let's see if we can't row this thing to some shore.\"\n" \
"  Make a L2-SR on Constitution (25 - CON) to see if you survive your bout with the plague. Take hits on your CON equal to the number you missed the saving roll by. If you live, go to {123}. (ap: 10)"
},
{ // 88/15H
"You plunge into the muddy street; the narrow lane is a quagmire bordered by tall weeds. Creepers run up the crumbling building facades on either side. Suddenly there comes a sound and you twist your head to see. You glimpse a shadow in the rain; in its flight it splashes through the puddles. To pursue the figure, go to {118}. If you choose to ignore it, go to {48}."
},
{ // 89/15J
"You cautiously advance toward the sound. Working your way through the thick growth of mushrooms, you see a man sprawled on the ground. From a bitten mushroom in his hand, you guess he has tasted the fungus and has been poisoned. If you try to help him, go to {140}. If you would rather continue after the bird, go to {53}. (ap: 20)"
},
{ // 90/16A
"You are resigned to give your life for a good cause, if need be. After a few days of dreaded anticipation the enemy attacks the city and soon scales the temple walls. You take your place on the ramparts of the wall and marvel at Botan as he consoles the wounded amid the slaughter. Soon you lose sight of him and are forced back into the temple proper. A maddened raider rushes at you, posing the newest threat to your survival. Roll one die and multiply by 9. This is his Monster Rating. If you kill him with your sabre, go to {44}. [If he slays you, go to {134}. ](ap: 20)"
},
{ // 91/16B
"\"You're marvellous!\" he tells you. \"I've never loved anyone so much in my life!\" You decide to take this opportunity to broach the subject of helping you to escape. He joins in the scheme enthusiastically and suggests a bold plan. He'll pretend to be roaring drunk and you'll help him to the door. When you get close you [both ]attack the guard.\n" \
"  The guard has a MR of one die × 10. Y[our friend has a CON of 17 and 12 adds. Both of y]ou will be using jambiya[s]. If you survive the fight, roll one die. If it comes up even, you leave the tavern together - go to {158}. If it comes up odd, he stays back as rear guard and you go to {62}. (ap: 40)"
},
{ // 92/16C
"The amazons' attention is directed towards the invaders charging up the hill. You notice that there seem to be fewer invaders than you noticed in the three longboats. As you turn, the remaining pirates burst from the jungle where they have executed a perfect flanking move.\n" \
"  In the resulting melee you are driven away from the rest of the amazons. You face a pair of slavers (20 MR each), and you are armed with a common spear. If you kill them, you may head for the deep jungle at {148} or you may rejoin the remaining amazons at {24}. (ap: 80)"
},
{ // 93/16D
"Make a L2-SR on Luck (25 - LK). If you miss the saving roll, go to {32}. If you make it, roll one die. If you roll 1 or 2, go to {141}; 3 or 4, go to {115}; 5 or 6, go to {16}."
},
{ // 94/16E
"As you run without a sense of direction, someone shouts to you in an unknown language. You turn; a red-headed girl stands in an open doorway beckoning you toward her. Run on alone to {124}; or follow her to {26}. (ap: 20)"
},
{ // 95/16F
"You are captured and separated from the woman. Your captors shove you towards a large pit which contains a creature you can't see because of the shadows. \"I hope you aren't thinking of -\" you begin as they push you into the pit.\n" \
"  You roll to your feet and discover that you share the pit with a large ape. Even though you offer to split the rent he comes at you, canine teeth sharp and gleaming. You grab up a sharp rock (two dice in combat) and close with the 40 MR ape. If you win, go to {151}."
},
{ // 96/17A
"Seagulls whirl through the dim morning sky as your ship runs with the wind. As your voyage drags on, you find shipboard life dreary. The only relief from boredom comes from games of chance with the sailors or choruses of rousing sea songs. The monotony unexpectedly ends when...\n" \
"  Roll one die and apply the result below. If you rolled a 1, go to {122}; a 2, go to {15}; a 3, go to {141}; a 4, go to {52}; a 5, go to {85}; or a 6, go to {4}."
},
{ // 97/17B
"You hurl the door open and burst inside the room. Unfortunately, you charge into a set of table and chairs just inside the door. The rotten furniture collapses under you and you fall entangled to the floor. You see a flash of red hair and a dagger hurled by a small hand.\n" \
"  The range is pointblank; your attacker has a DEX of 17. Find your size on the missile weapons chart and roll the attacker's saving roll to see if you are hit. If you are, roll the damage for the dirk and add the attacker's 10 combat adds with a missile weapon.\n" \
"  If it misses, you have time to pursue the attacker to {145}. If it hits you, you may painfully attempt to pick up the trail at {48}. If you wish, you may forget the whole thing at {124}. Of course if the dagger killed you then you are dead and don't really care anyway. (ap: 20)"
},
{ // 98/17C
"The fishermen look up at you as you stagger down the beach. They gather around you and ply you with questions, which you answer as fully as you think is wise. Roll a die. If it comes up even, go to {28}. If it comes up odd, go to {55}. (ap: 20)"
},
{ // 99/17D
"Your master's favourite wife takes a dim view of your attempts to charm her husband. She convinces him that you would be better off in a tavern. Go to {57}."
},
{ // 100/17E
"Few people are being spared, but if you can make a L3-SR on Charisma (30 - CHR), you will be allowed to live. If you live, go to {146}."
},
{ // 101/17F
"Roll one die. If you roll a 1 or 2, go to {152}. If you roll 3-6, she has little to say. You may leave her to gamble at {69} or leave the tavern by going to {73}."
},
{ // 102/17G
"It begins like an ordinary day, the slaves working with hammer and chisel. Suddenly a guard begins to bludgeon a slave unfairly. Unexpectedly, he begins to fight back. Other prisoners leap into the fight and in an instant the whole quarry is in riot.\n" \
"  To try to fight your way to freedom, take your hammer (4 dice in combat) and fight your way past your nemesis, Sordor. (Roll one die and multiply it by 10 to determine his Monster Rating.) If you kill him, go to {62}. If you decide not to join in on the riot, it is quelled and you should go to {11}."
},
{ // 103/17H
"Make a L2-SR on Luck (25 - LK). If you make it, go to {65}. If you fail your attempt, go to {50}."
},
{ // 104/17J
"A few months later you are roused from deep sleep. A woman, Koula, forces a dirk into your grasp. \"Another man has been washed ashore,\" Peleki tells you as you exit the hut. \"The law says you must fight him to the death. Come!\" You groan and follow them to a torchlit circle.\n" \
"  You size up your opponent; he's a strong-looking sailor type. You curse - he had no right to survive drowning to ruin your life here. When the signal is given, you find yourself eager to rush in and cut his heart out.\n" \
"  He's got 14 combat adds and a CON of 18. If you kill him, you realize you might not win the next fight and you depart to {46}. If you fail to kill him, you realize that you are dead. (ap: 80)"
},
{ // 105/18A
"Out of respect for your obvious interest, the captain includes you in the search party. You and several others leave the ship and begin a slow advance across the muddy plain, heading for the nearest grove of scrub trees. As you draw near them, you notice the sparkle of clear water in their shade. You blurt a loud \"Wa-hoo!\" and wave to the ship - and a chilling howl issues from the grove in a grotesque parody of your joyful shout.\n" \
"  Fearing some manner of monster, you all draw your weapons and advance more cautiously. You reach the pool and quickly scan the brush nearby. You see no animals, though your eyes linger on the trees sheltering the pool. Their shapes are strangely manlike; each bears a burden of heavy, thorn-covered seedpods.\n" \
"  \"The water is sweet!\" trumpets one of the sailors. The others quickly stoop and, upon tasting the water, agree. If you insist upon searching for other pools, go to {154}. If you begin to fill the water barrels you have helped haul this distance, roll one die. If you roll a 1, go to {154}; a 2-6, go to {63}. (ap: 10)"
},
{ // 106/18B
"You offer to betray the rest of the natives in return for your freedom. Their leader ponders your offer and agrees. \"I'll warrant that an island full of women is fair for the likes of you. Be warned, however, that at the first sign of treachery you'll die.\n" \
"  Heart in your throat you load them into the jungle. You march on an old path overgrown with briars and vines. When all of them are engaged in cutting through the brush you make a break for freedom. If you can make a L1-SR on Dexterity (20 - DEX), you leave them behind and escape to {7}. If you miss it, the leader of the slavers cuts his way through the brush and fulfills his promise. (ap: 50)"
},
{ // 107/18C
"As part of the escape plan, the woman begins to scream as though she is terrified. When the Zoumite guards hurry in, you both assail them with makeshift clubs and dash out the door. You plunge into the jungle, but the natives are yelling their warcry close behind.\n" \
"  \"The cove is just ahead!\" pants Delia. But the natives are gaining. make a L2-SR on Speed (25 - SPD). If you make it, roll one die. If it comes up even, go to {17}; if it comes up odd, go to {61}.\n" \
"  If you fail the saving roll and are male, go to {95}. If you fail and are female, go to {120}. (ap: 50)"
},
{ // 108/18D
"You reach the city gates and see the familiar face of the priest, Botan. \"It is very bad,\" he says. \"The townsmen have spies who predict a major attack on the city in a few days. Can I count upon you to join me in the defence of Goloe's temple?\n" \
"  If you agree to defend the temple, go to {90}. If you would rather build a raft to escape Ideria, go to {46}."
},
{ // 109/18E
"Hearing you, the captain screams at the boarding party. \"You mad scoundrels! You'd risk my ship to gamble on saving your own hides!\"\n" \
"  Turus, an enraged sailor standing beside you, grabs your throat and whips out his dirk. If you can make a L2-SR on Dexterity (25 - DEX), you are able to dodge his death blow; go to {87}. If you miss the saving roll, he drains your lifeblood with one deft slice. (ap: 50)"
},
{ // 110/19A
"You wade ashore and study the aspect of the island. There are ruins of an old native village, but instead of green plants, odd knobby mushrooms flourish everywhere. You are famished, but realize that many mushrooms are deadly poison. If you eat a mushroom, go to {43}. If you choose to look for safer food, go to {21}."
},
{ // 111/19B
"You lead the slavers to the hilltop stockade. While the slavers keep out of sight you shout, \"Everyone come out! There's a man on the beach!\"\n" \
"  The amazon warriors hear you and open the gates. The villagers hurry down the path, shouting excited questions. When they are drawn into the trap, the slavers cast their nets over the amazons and rush the gates before the confused sentries can close it. After a brief fight, the resistance is at an end.\n" \
"  The slaver captain grins and slaps you on the back. \"Well done! We can use a rogue like you in this crew! Will you sign aboard?\"\n" \
"  If you would like to be a slaver, go to {8}; if you say you'd just like to be taken to a port and be left off, go to {20}. (ap: 30)"
},
{ // 112/19C
"For your part of the search, you check the passengers' cabins below deck, but find no one. When you climb up to the deck, you hail your companions with a loud \"Hulloo!\" but no one answers. Alarmed, you look out over the water, but cannot find your own ship. A frantic search proves you are all alone. You drift with the tide for two days; you notice some land in the distance. But you know the Grey Moon is not drifting that way. If you try to swim for land, go to {13}. If you are content with drifting in the ship, roll one die. If it is even, go to {85}. If it is odd, go to {34}."
},
{ // 113/19D
"You press on into the heart of the decaying city, shouting \"Is anybody here?\" Suddenly rusted hinges creak; you turn to spy an old man in a doorway. Behind him press other haggard and nervous people. They beckon you to enter.\n" \
"  To ignore them, go to {124}. To enter the building, go to {70}. (ap: 20)"
},
{ // 114/20A
"They realize that you have been through some terrific ordeal and help you back to their village. They feed you and tend whatever minor wounds you have. You are allowed to rest for several days and you come to think of their amazon lifestyle as one you might like to try. The only negative point seems to be the total lack of men, and you wonder if this may be a blessing in disguise.\n" \
"  Peleki, the old chieftainess, arrives to speak with you a week after rescue. \"Only the strong may share our life here. If you can defeat Koula in a [barefisted ]fight, you may remain with us. If she defeats you, your heart will be sacrificed to our goddess, Pydna.\"\n" \
"  That afternoon you are led into a circle formed by the whole community. Across the circle from you is the tall, lithe Koula. Since she is fighting bare-handed she rolls one die, has 9 adds and a CON of 16. [Unless you have special training or a magical hand you will also roll only one die. ]If you defeat her, go to {137}. If you lose, don't feel disheartened (pardon the pun): Pydna was pleased by your sacrifice. (ap: 80)"
},
{ // 115/20B
"You climb out of the water and fall exhausted on the beach. You are awakened by the touch of hands on your body. You open your eyes to the sight of several haggard-looking people and a priest. One of them hands you a cup of warm soup and you are relieved to come into a friendly country. \"Where am I?\" you ask.\n" \
"  \"You've been led by the gods to a sad land,\" says the priest, Botan. He goes on to explain that this is Ideria, a land under invasion from fierce desert tribes of the Yajna. \"We are going to the city of Magodha where the goddess Goloe will protect us.\" Suddenly, a scream rings out. You turn and see a band of desert raiders plunge into the mass of refugees.\n" \
"  You may fight, flee, or surrender. If you choose to fight, you must kill a nomad. Roll one die and multiply by 7 to determine his Monster Rating. If you kill him, go to {108} and haven in Magodha. If you wish to flee, you must successfully make a L2-SR on Luck (25 - LK). If you flee, you make it to Magodha and {108}. If you miss, you end up at {2}. If you surrender to the Yajna raiders, go to {2}. (ap: 30)"
},
{ // 116/20C
"You stand on the docks openly admiring a stout merchant ship. You decide that it looks worthy enough to carry you on your travels. Shouldering your sea bag, you elbow your way through the crowd and up the gangplank. You locate the captain, Raiktor, amid a bustle of activity and he pauses long enough for you to ask him about buying passage. He strikes you as an upright man and the 50 gp fare he asks seems appropriate. If you pay him, go to {96}. If you cannot afford the fare, return to {73}."
},
{ // 117/20D
"The Grey Moon is deserted; there is no clue as to why everyone disappeared. Finally the group leader, Bolkan, orders the sailors back to the ship.\n" \
"  Roll one die. If it comes up even, your ship heads back to port at {141}. If it comes up odd, go to {96} (pirates go to {8})."
},
{ // 118/20E
"The sound of running feet guides you down the turning lanes. You dash into an old plaza. The figure is nowhere to be seen; the flagstones, heaved askew by tree roots, do not take the fugitive's footprints. In the centre of the clearing sags an ancient temple. To give up the chase, go to {48}. To enter the temple on the chance that your quarry might be there, go to {22}."
},
{ // 119/20F
"Your excursion into a life of crime has plunged you into trouble already. The city guards pursue you through the strange streets. Make a L3-SR on Luck (30 - LK). If you make it, you escape your pursuers and go to {73}. If you miss it, you are apprehended and remanded to {157}. (ap: 20)"
},
{ // 120/20G
"Your escape attempt fails and the natives recapture you. They drag you to the beach and tie you spread-eagle to four stakes. Delia, tied next to you, says she has resolved to die with dignity. If you'd prefer to save your own life by seducing the warchief overlooking the sacrifice, make a L3-SR on Charisma (30 - CHR). If you make it, go to {75}. If you fail, go to {36}. (ap: 60)"
},
{ // 121/21A
"You are locked up in chains and imprisoned in the hot hold of the ship with many other captives. The conditions are so vile you are actually relieved when the long voyage ends and you are herded ashore. If you are accused of a crime, go to {157}. If you are a slave, go to {77}."
},
{ // 122/21B
"The lookout hails the captain from the crow's nest. \"Castaway adrift off the starboard bow!\" he cries. Immediately the captain orders the ship to come about to rescue the person. You press to the rail and spot the figure of an old woman clinging tenuously to a piece of wreckage. \"Help me!\" she cries weakly as the vessel draws near.\n" \
"  The captain takes a close look at her and the crew begins to whisper. A crew member turns to you and says, \"She's a sea witch. I've heard what they can do to ships; drive men mad and all!\"\n" \
"  To your eyes she looks like an ordinary old woman. If you urge the captain to let her come aboard, go to {58}. If you remain quiet and watch, go to {10}."
},
{ // 123/21C
"There has been no rain at all to replenish your supply of fresh water; consequently thirst has taken its toll. Your fevered mind can almost see the phantoms of your former companions as you drift on alone.\n" \
"  Make a L2-SR on Constitution (25 - CON) to see if you can survive these harsh conditions. Take damage equal to the number you have missed the saving roll by. If you survive, roll one die. If it comes up even, go to {17}. If it comes up odd, go to {74}."
},
{ // 124/21D
"Your luck has run out! As you move swiftly down an alley you run into a mass of lurking horned monsters. They have you cornered so you must fight. There are between 2 and 7 of the beasts (1 die + 1); each has a MR of 50. If you can make a DEX-SR on the level equal to the number of monsters you face, only one can attack you at a time. If you miss the saving roll, they all close and try to destroy you. If you survive, go to {46}. (ap: 80)"
},
{ // 125/21E
"The captain is pleased with your suggestion and gleefully shouts, \"Put the mate in irons!\"\n" \
"  To her surprise, her pirate crew moves forward ominously. \"You've changed,\" says the mate in a harsh voice. \"We followed you when you acted like a captain. Now that you're taking orders from a landlubber, I'm taking control of the ship. Men, lock the wench below!\n" \
"  The new captain glares at you and spits on the deck. \"And as for the newest member of your crew...\" You make a frantic dash for the rail, but only get as far as {32}."
},
{ // 126/21F
"Several days later, the natives come to your hut. They clean you up a bit and hustle you along to the centre of the village where the natives sit around the clearing with baskets full of crafts and trade goods. Other natives, obviously of different tribes, mill around the displays or haggle with their vendors.\n" \
"  You surmise that this is Market Day as you are prodded into a small group of captives. You also guess - quite correctly - that this is the local slave market, and that you are the latest merchandise. A warchief purchases you and takes you to another island. Go to {75}."
},
{ // 127/21G
"Roll one die. If you rolled an even number, go to {61}; an odd number, go to {76}."
},
{ // 128/21H
"Men are generally sold to galleys, quarries or gladiatorial schools. Roll one die to determine your final destination. If you roll 1-3, go to {150}. If you roll a 4 or 5, go to {11}. If you roll a 6, go to {45}."
},
{ // 129/22A
"Exhausted by your ordeal, you crawl up the beach and fall asleep. You finally waken with the aid of a brutal kick. Startled, you open your eyes to see a band of dark-skinned natives standing around you with spears at the ready.\n" \
"  They study you. If you can make a L1-SR on Charisma (20 - CHR), they spare you and conduct you to {38}. If you miss, they run you through and leave you for the seagulls. (ap: 40)"
},
{ // 130/22B
"The slavers' advance wavers; the arrows take a heavy toll. Finally their leader shouts, \"It's no use! Let's get out of here!\" They break for the beach. The amazons cheer and embrace you. Males go to {104}. Females go to {46}, unless they wish to retire here for the rest of their lives. (ap: 50)"
},
{ // 131/22C
"You work as a scullery maid in a large house. The kitchen matrons drive you ruthlessly from early morn to late at night. Your life is a never-ending ordeal of cooking, cleaning, washing, scrubbing, sewing and serving. You come to realize that you have two chances to leave this life of drudgery. One is to seduce your master; the other is to escape.\n" \
"  To attempt to seduce your master into placing you in his harem you must make a L2-SR on Charisma (25 - CHR). If you make it, go to {19}. If you fail, go to {99}. If you want to escape you must use a kitchen knife (dirk) to cut your way through a guard. Roll one die and multiply the result by 5 to determine his MR. If you survive the fight, go to {62}. (ap: 20)"
},
{ // 132/22D
"Make a L2-SR on Luck (25 - LK). If you succeed, go to {50}. If you fail in your attempt, go to {65}."
},
{ // 133/22E
"The search party brings back the girl who was the sole survivor of the derelict. The crew is fascinated by her story of sea creatures that carried off the rest of the Grey Moon's personnel. Her charm soon has the whole crew in love with her, but their bliss is short-lived. The ship has trouble aplenty; a crewman has been found dead in the poop deck and two others have vanished completely. Make a L3-SR on Intelligence (30 - IQ). If you make it, go to {71}. If you miss it, go to {9}."
},
{ // 134/22F
"Your spirit seems to hang in limbo; you hear a voice in your mind saying, \"I am Goloe, the goddess of this temple.[ For your bravery I grant you a return to life just this once.]\" Go to {156}."
},
{ // 135/22G
"A few days later the galley passes near a cluster of islands. Your comrade tells you that the attempt had best be made now - the reefs guarding the island would prevent the ship's pursuit. He picks the locks with practiced ease while the guards beat another prisoner. Swiftly you go over the side and into the water. You tread water waiting for him to surface.\n" \
"  He comes to the surface and sputters loudly. A guard hears him and sounds an alarm. Archers shoot arrows at you and he screams as one buries itself in his back. As he slips beneath the waves the archers concentrate upon you.\n" \
"  Make a L2-SR on Dexterity (25 - DEX). If you miss it, you barely feel the pain of the arrow coursing through your neck. If you make it, you have escaped to {74}. (ap: 50)"
},
{ // 136/23A
"Months have passed. Somehow you have endured service in the tavern. You are popular with the sailors; your ambition is to keep them happy and escape from the tavern.\n" \
"  The tavern staff comes to trust you. When the guard at the door is not looking at you, you shatter a bottle of rum and attack him with the broken end of it (1 die + 3 in combat). He has a Monster Rating of one die × 5. If you kill him, go to {62}.\n" \
"  If he looks too tough to kill, you laugh and tell him he should pay more attention. You say that if you had wanted to escape you might have hurt him. You decide to bide your time. Roll one die: if it comes up even, go to {1}; if it comes up odd, go to {29}."
},
{ // 137/23B
"For a time the sultry pleasures of this tropical island suit you, but as the months pass a longing for places left behind grows within you. One day you are wandering on the beach when a ship appears on the horizon.\n" \
"  Quickly you conceal yourself in the jungle brush and watch as the ship launches three longboats. If the men in the boats are friendly you might be able to convince them to take you away from this island. As they draw closer to the island you can see that they are not that amiable.\n" \
"  If you approach them in a friendly manner, go to {37}. If you spy upon them and warn the amazons of this seeming invasion, go to {7}."
},
{ // 138/23C
"\"I'll not have charity workers on my ship! I'll sell your berth too!\" the captain snarls in reaction to your interference. You leave the boat.\n" \
"  The priest comes to your side to cheer you up. \"Fear not, friend. I think Goloe, the Goddess of Life, will reward your kindness as surely as she will punish that wicked ship. Will you not come to the temple of the goddess? We will give you food and drink - if you will lend your sword in defence of the temple,\" he adds as he nods at your sabre.\n" \
"  If you will defend the temple, go to {90}. If you would rather steal a raft and leave the port, go to {46}. (ap: 20)"
},
{ // 139/23D
"The monster lies at your feet, caramel-coloured blood running from its jaws. You give a tired grin; the girl has not bolted off for another merry chase. \"You're a hard lady to get to know,\" you laugh breathlessly. She smiles gratefully and emerges from her hiding place to see to your wounds. \"Are there any other people here?\" you ask.\n" \
"  You cannot understand her language, but she motions you to come with her. If you go with her, go to {26}. If you part company, go to {48}."
},
{ // 140/23E
"Despite all you do, the man does not regain consciousness. Deciding it is futile, you lie down to get some sleep. When you wake you are being choked to death. A monstrous face looms before you. You recognize your attacker as the poisoned man, but his features are distorted by a grim metamorphosis! He is changing into a fungus creature, one violently insane.\n" \
"  He has a Monster Rating of 40. You have a dirk that you recovered from his belt. If you survive the fight, you stagger away from your foe towards the beach and {53}."
},
{ // 141/23F
"You make it safely into port. Keeping an eye out for trouble you enjoy striding down the streets of a friendly port. You may reprovision yourself here automatically by spending your gold in the local shops. If you wish to return to the port at {73} or visit the tavern at {12} you must first roll a die. If it comes up even, go directly to your destination. If it comes up odd, go to {68}.[ A word of caution: you cannot bring more than a two-die weapon into the tavern. All larger weapons are checked at the door, automatically, before you go in.]"
},
{ // 142/23G
"Make a first level saving roll on Intelligence (20 - IQ). If you succeed, you learn to acclimate to your life on board the Sea Sprite and you stay on the good side of the captain. Go to {96}.\n" \
"  If you have missed the saving roll, the captain flogs you for some imagined slight. Take two dice damage from your CON. If you survive, go to {40}."
},
{ // 143/24A
"You untie the woman and help her to her feet. She smiles at you and says, \"Nothing like the nick of time for a rescue, thanks.\" You turn to face your fellow tribesmen and they bow in homage.\n" \
"  If you would like to retire from this adventure with the woman you have rescued, you may do so. If you would like to leave this island on her ship (the one in the cove), roll one die. On the roll of a 1 or 2, go to {61}. If you roll a 3 or 4, she catches a tropical fever and dies; go to {17}. On the roll of 5 or 6, her ship has left. You construct a raft and go to {31} to leave the island."
},
{ // 144/24B
"The captain outlines the situation to his assembled crew. \"'Tis a bad situation we're in, and I'll not dictate when it's your necks as well as mine.\" He calls for a vote and the crew is split right down the middle. If you cast the deciding vote in favour of searching for water, go to {105}. If you vote for attempting to sail on such low provisions, hoping to find a place where there is fresh water, go to {86}."
},
{ // 145/24C
"You leap to your feet and race downstairs. There, dashing across the temple floor, is a girl with wild, coppery hair and a wrapping of rags like a brief sarong. She looks lithe and strong; you pursue her along the maze of houses, but lose sight of her. You are looking for tracks when a scream rings out from an old stone house. You run to it and throw open the door - inside, horror!\n" \
"  A clay-brown horned creature with webbed hands and feet has cornered the girl in a large fireplace, groping at her. If you wish to attack the creature, go to {80}. If you flee, go to {124}."
},
{ // 146/24D
"That night you hear a voice in your sleep. \"I am Goloe, the Goddess of Life; you defended my temple bravely and shall be rewarded.[ When this mortal life is finished you may be reborn!]\" [(Note: remember to go to {156} if your character perishes in this dungeon.) ]Now go to {77}."
},
{ // 147/25A
"You are the first to spy the strange ship coming out of the mist. Your attention is drawn to it because of its slack lines and the sails that are flapping in tatters. You call to the captain and point it out. \"I don't like the looks of this,\" he says. \"Seems to be a ghost ship, but it's the custom of the sea to check for survivors. Would you like to go with the boarding party?\"\n" \
"  If you are part of the crew, you realize this was not a question. You grab your gear and go to {64}. If you are a passenger, you have a choice: you may join them at {64}, or you may decline and go to {79}."
},
{ // 148/25B
"You explore the island and find a few signs of former habitation. You also discover that you are alone on the island and that it seems to be far off of the normal shipping lanes.\n" \
"  There are two methods you may employ in attempting to leave the island. If you choose to build a raft you must make a third level Constitution saving roll (30 - CON) to see if you survive the long sail to {123}. If you miss it, take damage on your CON equal to the number you missed by. If you live, go to {123}.\n" \
"  The other method is by lighting a huge bonfire every time you think a ship is near. The first bonfire you light will require your making a first level saving roll on Luck (20 - LK) for a ship to see it. If a ship sees you, go to {17}.\n" \
"  If you miss the saving roll, add ten years to your age (after all, this island is far from the shipping lanes) and deduct 10% of your CON as the effects of aging on this island. The next bonfire will require a saving roll one level higher than the previous one. For each miss deduct 10% from your CON and add ten years to your age. *Age loss on CON is permanent and can only be replaced by magic addition to your CON or level adds to your CON.* You cannot repair aging with Restoration spells. At any time you may build a raft or commit suicide. (ap: 20)"
},
{ // 149/25C
"The merchant ship, the Sea Sprite, on which you are sailing, is bound to a course to high adventure. Roll one die to choose your fate. If you roll a 1, go to {18}. If you roll a 2, go to {52}. If you roll a 3, go to {40}. If you roll a 4, go to {15}. If you roll a 5 or 6, go to {96}."
},
{ // 150/25D
"You are placed in chains and set to rowing the ship. The slave master is a sadistic animal who plies the whip to the whole crew. After the first day you are uncertain how long you can keep up with the merciless pace he sets.\n" \
"  Make a L2-SR on Strength (25 - ST). If you make it, read on. If you fail it, your strength has failed and you faint. The slave master heaves you over the side as sharkmeat - an example to the others to be diligent.\n" \
"  Misery loves company, so you and your benchmate converse in hushed tones and soon come to trust each other. He says he can pick the locks on your chains and remove them. He'll only do it if you'll help him escape; he cannot swim. You realize that the odds against success are overwhelming, but the odds of survival on this ship are also staggering.\n" \
"  If you agree to help him escape, go to {135}. If you decline his offer, roll 1d6. If it comes up odd, go to {30}. If it comes up even, you continue to row until the captain spots another ship on the high seas and sails toward it at {84}. (ap: 30)"
},
{ // 151/25E
"Battered, but alive, you stand in triumph over the ape. The natives cheer and hoist you out of the pit. They smile and hand you a spear like their own. You realize they have adopted you into the tribe for your fearlessness. If you are still interested in the woman, go to {56}. If you don't care what happens to her, go to {46}. (ap: 10)"
},
{ // 152/25F
"\"Please, listen to me,\" she pleads. \"You look kinder than the scoundrels who usually come here. I was kidnapped by brigands and sold into slavery - but tonight I saw a ship belonging to my friends enter the harbour. If you could help me reach them, you'd be well-rewarded with gold!\"\n" \
"  To help the woman, go to {83}. If you wish to ignore her pleas and go to gamble in the back, go to {69}. Or, you may leave the tavern entirely - go to {73}."
},
{ // 153/26A
"The disaster has left you the sole survivor of the ship's personnel. The ship still has food and other provisions so you need not fear starvation. Unable to do anything you anxiously await what the sea has in store for you. Go to {34}."
},
{ // 154/26B
"The grove holds the only source of water on the plain; you are certain of that. The tide will soon go out, so the sailors are urged to work with as much speed as possible. As you dip your pail into the water a sailor shouts a warning at you. You catch a glimpse of movement from above you and dodge. If you make a L2-SR on Dexterity (25 - DEX), read on. If you miss it, go to {49}.\n" \
"  You roll out of the way as one of the thorny seedpods thuds into the sand where you were standing. Even as you rise you see a pod strike down a sailor you knew as Tzibis. Your horrified party watches him writhe in agony from outside the range of the trees. The seedpod absorbs his blood and sprouts on the spot; you hear a scream as his soul is absorbed and bound into the plant.\n" \
"  In terror you join the others fleeing across the beach. Once the captain hears of Tzibis' fate he wastes no time in casting off for {86}. (ap: 30)"
},
{ // 155/26C
"Roll a die. If the result is even, go to {3}. If the result is odd, the door flies open, and the fugitive bolts out. You are knocked off balance and sent to {145}."
},
{ // 156/26D
"[As was promised, ]you are [reincarnate]d[ in anoth]e[r body. To determine your new sh]a[pe, roll one ]d[ie. If you roll a 1 or 2, you are a woman. If you roll a 3 or 4, you are a man. If you roll a 5 or 6, you become a low animal (no one said this stuff was perfect!)\n" \
"  If you are a human after reincarnation you retain your level and adventure points, as well as your IQ (and all memories of your past life). Gold and all other attributes must be rolled for again. Go to {73}.\n" \
"  If you were reincarnated as a low animal, pray for a nice master]."
},
{ // 157/26E
"You and the other criminals are herded out of your place of confinement and brought before a magistrate. You must argue your own case.\n" \
"  If you can make a L4-SR on Intelligence (35 - IQ), you convince the judge of your innocence. In that event you are released and wander to {141}. If you made at least a first level IQ saving roll, you are sent to {77}. If you miss even the first level roll, you are sent to the gallows to be hung by the neck until dead."
},
{ // 158/26F
"The months that follow prove that your mate loves you very much. You could live a happy life here, but there is your wanderlust to deal with. If you wish to steal away from home to renew your adventures, take 1 die × 1,000 gold pieces from your own house and go to {73}. If you decide to begin a family and retire, leave this adventure. (Why not the joy you know, instead of the terror that lurks without?)"
},
{ // 159/26G
"Swimming to the bird island was worth it. You feast on eggs and nestlings. An occasional drizzle provides you with just enough water.\n" \
"  Soon you note that your invasion has driven the birds away. If you don't manage to escape the island you will starve to death.\n" \
"  Make a L3-SR on Luck (30 - LK). If you make it, your salvation is at hand. In that case go to {17}. If you miss it, take one point from your Strength. Continue to attempt the saving rolls, taking one from your Strength (the horrors of starvation) each time you miss. If you make the saving roll, go to {17}. If your Strength goes to zero, you die. (ap: 20)"
}
};

MODULE SWORD sm_exits[SM_ROOMS][EXITS] =
{ {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  26,  48,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  { 109,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/1G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/1H
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2B
  {  81,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/2C
  { 101,  69,  73,  -1,  -1,  -1,  -1,  -1 }, //  12/2D
  {  74,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/3A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/3B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/3C
  {  98, 119, 141,  -1,  -1,  -1,  -1,  -1 }, //  16/3D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/4A
  {  96,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/4C
  { 121,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/4D
  {  53,  89,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/4E
  {  97, 155, 124,  -1,  -1,  -1,  -1,  -1 }, //  22/4F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/4G
  { 148,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/5A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/5B
  { 124,  70,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/5C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/5D
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/5E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/6A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/6B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/6C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/6D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/6E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/6F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/6G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/7A
  { 111, 106,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/7B
  { 107, 126,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/7D
  {  93,  67, 142,  -1,  -1,  -1,  -1,  -1 }, //  40/7E
  { 101,  69,  73,  -1,  -1,  -1,  -1,  -1 }, //  41/7F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/7G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/7H
  { 100, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/8A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/8B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/8C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/8D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/9A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/9B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/9C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/9D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/9E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/9F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/10A
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/10B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/10C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/10D
  {  10,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/10E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/10F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/10G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/12B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/12C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/12D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/12E
  {  88, 113,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/12F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/12G
  {  12,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/12H
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/12J
  { 124,  46,  14,  -1,  -1,  -1,  -1,  -1 }, //  70/13A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/13B
  { 144,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72/13C
  { 141,  35, 116,  -1,  -1,  -1,  -1,  -1 }, //  73/13D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/13E
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/14A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/14B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/14C
  { 137,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/14D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/14E
  { 139,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/14F
  {  45,  60,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/15A
  { 158,   8,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/15B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/15C
  { 132, 103,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/15D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/15F
  { 123,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/15G
  { 118,  48,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/15H
  { 140,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/15J
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/16B
  { 148,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/16C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/16D
  { 124,  26,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/16E
  { 151,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/16F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/17A
  {  48, 124,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/17B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/17C
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/17D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/17E
  {  69,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/17F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/17G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/17H
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/17J
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/18A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/18B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/18C
  {  90,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/18D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/18E
  {  43,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/19A
  {   8,  20,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/19B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/19C
  { 124,  70,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/19D
  { 137,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/20A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/20B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/20C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/20D
  {  48,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/20E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/20F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/20G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/21A
  {  58,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/21B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/21C
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/21D
  {  32,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/21E
  {  75,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/21F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/21G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/21H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/22A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/22B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/22C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/22D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/22E
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/22F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/22G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/23A
  {  37,   7,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/23B
  {  90,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/23C
  {  26,  48,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/23D
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/23E
  {  73,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/23F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/23G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/24A
  { 105,  86,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/24B
  {  80, 124,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/24C
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/24D
  {  64,  79,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/25A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/25B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/25C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/25D
  {  56,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/25E
  {  83,  69,  73,  -1,  -1,  -1,  -1,  -1 }, // 152/25F
  {  34,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/26A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/26B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/26C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/26D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/26E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/26F
  {  17,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 159/26G
};

MODULE STRPTR sm_pix[SM_ROOMS] =
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
  "sm12",
  "sm13",
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
  "sm24",
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
  "sm46",
  "",
  "sm48",
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
  "sm61",
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
  "sm78",
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
  "sm95", //  95
  "",
  "",
  "",
  "",
  "", // 100
  "",
  "",
  "",
  "",
  "sm105", // 105
  "",
  "",
  "",
  "",
  "sm110", // 110
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
  "sm135", // 135
  "",
  "",
  "",
  "",
  "", // 140
  "",
  "",
  "sm143",
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
  "sm157",
  "",
  ""  // 159
};

MODULE FLAG                   beenpirate;
MODULE int                    status;

IMPORT FLAG                   usedweapons;
IMPORT int                    armour,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              missileammo,
                              room, prevroom, module,
                              round,
                              spellchosen,
                              spelllevel,
                              spellpower;
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

MODULE void sm_enterroom(void);

EXPORT void sm_preinit(void)
{   descs[MODULE_SM] = sm_desc;
}

EXPORT void sm_init(void)
{   int i;

    exits      = &sm_exits[0][0];
    enterroom  = sm_enterroom;
    for (i = 0; i < SM_ROOMS; i++)
    {   pix[i] = sm_pix[i];
    }

    status     = STATUS_NONE;
    beenpirate = FALSE;
}

MODULE void sm_enterroom(void)
{   TRANSIENT int i,
                  result;
    PERSIST   int oldstat;

    switch (room)
    {
    case 1:
        templose_con(dice(2));
    acase 2:
        savedrooms(2, chr, 75, -1);
    acase 4:
        dicerooms(141, 141, 147, 84, 84, 84);
    acase 5:
        award(30);
    acase 6:
        dicerooms(131, 131, 131, 19, 19, 57);
    acase 7:
        oddeven(130, 92);
    acase 8:
        status = STATUS_PIRATE;
        while (room == 8 && getyn("Earn pirate gold"))
        {   beenpirate = TRUE;
            result = dice(1);
            if   (result == 1) room = 141;
            elif (result == 2) room = 27;
            else
            {   give_gp(dice(1) * 100);
                award(dice(1) * 50);
        }   }
        if (room == 8)
        {   status = STATUS_NONE;
            savedrooms(2, lk, 74, 32);
        }
    acase 9:
        if (saved(3, iq))
        {   award(300);
        } else
        {   die();
        }
    acase 10:
        if (status == STATUS_PIRATE)
        {   dicerooms(42, 147, 85, 85, 54, 54);
        } else
        {   dicerooms(42, 147, 85, 85,  4,  4);
        }
    acase 11:
        if (saved(2, st))
        {   award(80);
        } else
        {   die();
        }
    acase 12:
        pay_gp(3); // %%: how many is "several"? What if you can't afford it?
        if (maybespend(20, "Fuck her"))
        {   room = 41;
        }
    acase 13:
        while (carrying() > st * 5)
        {   aprintf("You are encumbered.\n");
            drop_or_get(FALSE, FALSE);
        }
        if (!saved(2, lk))
        {   create_monster(419);
            npc[0].mr = 12 * dice(1);
            recalc_ap(0);
            fight();
        }
    acase 14:
        savedrooms(2, lk, 141, 85);
        award(30);
    acase 15:
        savedrooms(2, lk, 141, 47);
    acase 16:
        award(10);
    acase 17:
        dicerooms(96, 96, 39, 39, 121, 121);
        if (room == 121)
        {   status = STATUS_SLAVE;
        }
        award(20);
    acase 18:
        for (i = 1; i <= 5; i++)
        {   if (!getyn("Dive"))
            {   break;
            } // implied else
            result = dice(1);
            switch (result)
            {
            case 1:
                create_monster(419);
                fight();
            acase 4:
                give_gp(10);
            acase 5:
                give_gp(100);
            acase 6:
                rb_givejewelleditem(-1);
            }
            award(20);
        }
    acase 19:
        if (getyn("Fight eunuch guard (else seduce master)"))
        {   give(DRK);
            create_monster(421);
            fight();
            room = 62;
        } else
        {   savedrooms(3, chr, 158, 6);
        }
        award(10);
    acase 20:
        // %%: are we treated as a criminal or a slave? We assume slave.
        status = STATUS_SLAVE;
        award(40);
    acase 22:
        award(10);
    acase 23:
        if (getyn("Fight"))
        {   give(632);
            create_monster(422);
            fight();
            room = 82;
        } else
        {   room = 125;
        }
        award(12);
    acase 24:
        if (!saved(2, chr))
        {   create_monster(423);
            npc[0].mr = 10 * misseditby(2, chr);
            recalc_ap(0);
            fight();
        }
        award(50);
    acase 25:
        oddeven(133, 141);
        award(20);
    acase 27:
        dicerooms(85, 147, 122, 122, 54, 54);
    acase 29:
        savedrooms(3, chr, 91, 57);
    acase 30:
        die();
    acase 31:
        oddeven(85, 158);
    acase 32:
        give(STI);
        savedrooms(2, (iq + chr) / 2, 17, -1);
        award(80);
    acase 33:
        if (dice(1) % 2 == 0)
        {   if (!saved(3, con))
            {   templose_con(misseditby(3, con));
            }
            room = 153;
        } else
        {   if (status == STATUS_PIRATE)
            {   oddeven( 8, 141);
            } else
            {   oddeven(96, 141);
        }   }
        award(40);
    acase 34:
        give_gp(dice(1) * 1000);
        dicerooms(66, 66, 141, 141, 115, 115);
    acase 35:
        if (getyn("Take the job"))
        {   dicerooms(8, 8, 149, 149, 149, 149);
        } else
        {   room = 73;
        }
    acase 36:
        die();
    acase 37:
        drop_weapons();
        if (getyn("Give in"))
        {   status = STATUS_SLAVE;
            room = 121;
        }
        award(50);
    acase 39:
        dicerooms(149, 149, 149, 149, 8, 8);
    acase 41:
        lose_flag_ability(88); // virginity
        award(dice(2));
    acase 42:
        if (status == STATUS_PASSENGER)
        {   room = 144;
        } else
        {   oddeven(72, 144);
        }
    acase 43:
        die();
    acase 45:
        module = MODULE_AK;
        room = 0;
    acase 46:
        dispose_npcs();
        dicerooms(123, 85, 141, 17, 74, 74);
    acase 47:
        status = STATUS_SLAVE;
        if (sex == MALE)
        {   room = 150;
        } else
        {   room = 121;
        }
        award(10);
    acase 48:
        if (getyn("Fight beast (otherwise avoid)") || !saved(2, lk))
        {   create_monster(424);
            fight();
            room = 113;
        } else
        {   room = 94;
        }
    acase 49:
        die();
    acase 50:
        if (oldstat)
        {   give_gp(100);
            room = 141;
        } else
        {   status = STATUS_CRIMINAL;
            room = 121;
        }
    acase 51:
        oddeven(96, 141);
    acase 52:
        give_gp(50);
        if (getyn("Speak"))
        {   room = 138;
        } else
        {   dicerooms(96, 96, 85, 85, 122, 122);
        };
    acase 53:
        if (getyn("Swim"))
        {   if (!saved(2, dex))
            {   create_monster(419);
                npc[0].mr = dice(1) * 10;
                recalc_ap(0);
                fight();
            }
            room = 159;
        } else
        {   room = 43;
        }
    acase 54:
        oddeven(121, 8);
        if (room == 121)
        {   status = STATUS_CRIMINAL;
        }
    acase 55:
        award(30);
    acase 56:
        give(633);
        create_monster(420);
        npc[0].mr = dice(1) * 12;
        recalc_ap(0);
        if (getyn("Attack"))
        {   fight();
            room = 143;
        } else
        {   room = 46;
        }
    acase 57:
        savedrooms(1, iq, 136, -1);
        award(40);
    acase 58:
        gain_flag_ability(113);
    acase 59:
        if (!saved(1, chr))
        {   die();
        } elif (sex == MALE)
        {   room = 78;
        } else
        {   room = 114;
        }
        award(10);
    acase 60:
        savedrooms(2, st, 102, -1);
        award(50);
    acase 61:
        if (sex == MALE)
        {   room = 23;
        } else
        {   savedrooms(1, chr, 8, 121);
            if (room == 121)
            {   status = STATUS_SLAVE; // %%: or STATUS_CRIMINAL?
        }   }
        award(10);
    acase 62:
        savedrooms(3, lk, 141, -1);
    acase 63:
        if (status == STATUS_PIRATE)
        {   oddeven( 8, 141);
        } else
        {   oddeven(96, 141);
        }
        award(10);
    acase 64:
        dicerooms(117, 117, 5, 5, 25, 112);
    acase 65:
        if (oldstat)
        {   die();
        } elif (getyn("Join"))
        {   room = 8;
        } else
        {   status = STATUS_SLAVE;
            room = 121;
        }
    acase 67:
        give(637 - 1 + dice(1));
        savedrooms(3, lk, 93, 32);
    acase 68:
        result = dice(1);
        if (result <= 2)
        {   if (beenpirate)
            {   room = 119;
        }   }
        elif (result <= 4)
        {   rb_givejewels(-1, -1, 1, 2);
        } else
        {   drop_all(); // %%: gold, weapons, armour
            room = 149;
        }
    acase 69:
        do
        {   result = getnumber("Bet how many gp", 0, (gp > 100 ? 100 : gp));
            if (dice(1) == dice(1))
            {   give_gp(result * 4);
            } else
            {   pay_gp(result);
        }   }
        while (result);
    acase 70:
        set_language(LANG_ANTHELIAN, 1);
        award(20);
    acase 71:
        if (getyn("Fight mesgegra"))
        {   if (saved(2, dex))
            {   award(300);
                room = 141;
            } else
            {   die();
        }   }
        else
        {   room = 123;
        }
    acase 72:
        give(SAB);
        give(LEA);
        if (!getyn("Knock (otherwise fight)") || !saved(3, lk))
        {   create_monster(425);
            npc[0].mr = (dice(1) + 1) * 10;
            recalc_ap(0);
            fight();
        }
    acase 73:
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 74:
        dicerooms(59, 16, 129, 110, 148, 115);
    acase 75:
        elapse(2 * ONE_MONTH, TRUE);
    acase 76:
        if (sex == MALE && getyn("Seduce") && saved(2, chr))
        {   room = 158;
        } else
        {   give_gp(dice(1) * 500);
            room = 141;
        }
        award(40);
    acase 77:
        drop_all();
        if (sex == MALE) room = 128; else room = 6;
    acase 78:
        give(DRK);
        create_monster(426);
        fight();
        award(80);
    acase 79:
        dicerooms(117, 117, 33, 33, 133, 51);
    acase 80:
        create_monster(424);
        if (saved(3, dex))
        {   good_freeattack();
        }
        fight();
        award(20);
    acase 83:
        give(MIS);
        if (maybespend(500, "Buy her freedom"))
        {   room = 127;
        } else
        {   create_monster(427);
            npc[0].mr = dice(1) * 10;
            recalc_ap(0);
            good_freeattack();
            fight();
            oddeven(119, 127);
        }
    acase 85:
        savedrooms(2, st, 74, -1);
    acase 86:
        savedrooms(3, con, 153, -1); // %%: current or maximum CON?
    acase 87:
        if (!saved(2, con)) // %%: current or maximum CON?
        {   templose_con(misseditby(2, con));
        }
        award(10);
    acase 89:
        award(20);
    acase 90:
        give(SAB);
        create_monster(428);
        npc[0].mr = dice(1) * 9;
        recalc_ap(0);
        fight();
        award(20);
    acase 91:
        give(JAM);
        create_monster(427);
        npc[0].mr = dice(1) * 10;
        recalc_ap(0);
        fight();
        oddeven(62, 158);
        award(40);
    acase 92:
        give(SPE);
        create_monsters(429, 2);
        award(80);
    acase 93:
        if (saved(2, lk))
        {   dicerooms(141, 141, 115, 115, 16, 16);
        } else
        {   room = 32;
        }
    acase 94:
        award(20);
    acase 95:
        give(634);
        create_monster(430);
        fight();
    acase 96:
        dicerooms(122, 15, 141, 52, 85, 4);
    acase 97:
        getsavingthrow(FALSE);
        if (madeit(evil_getneeded(RANGE_POINTBLANK), 17))
        {   good_takehits(dice(2) + 1 + 10, TRUE);
        } elif (getyn("Pursue"))
        {   room = 145;
        }
        // %%: can you now pick up the dirk?
        award(20);
    acase 98:
        oddeven(55, 28);
        award(20);
    acase 100:
        savedrooms(3, chr, 146, -1);
    acase 101:
        if (dice(1) <= 2)
        {   room = 152;
        }
    acase 102:
        give(635); // hammer
        if (getyn("Riot"))
        {   create_monster(431);
            npc[0].mr = dice(1) * 10;
            recalc_ap(0);
            fight();
            room = 62;
        } else
        {   room = 11;
        }
    acase 103:
        oldstat = 0;
        savedrooms(2, lk, 65, 50);
    acase 104:
        elapse(ONE_MONTH * 3, TRUE);
        give(DRK);
        create_monster(432);
        fight();
        award(80);
    acase 105:
        if (getyn("Fill barrels"))
        {   dicerooms(154, 63, 63, 63, 63, 63);
        } else
        {   room = 154;
        }
        award(10);
    acase 106:
        savedrooms(1, dex, 7, -1);
    acase 107:
        // %%: should we give them a makeshift club?
        if (saved(2, spd))
        {   oddeven(61, 17);
        } elif (sex == MALE)
        {   room = 95;
        } else
        {   room = 120;
        }
        award(50);
    acase 109:
        savedrooms(2, dex, 87, -1);
        award(50);
    acase 111:
        award(30);
    acase 112:
        elapse(ONE_DAY * 2, TRUE);
        if (getyn("Swim (otherwise drift)"))
        {   room = 13;
        } else
        {   oddeven(34, 85);
        }
    acase 113:
        award(20);
    acase 114:
        healall_con(); // %%: "tend whatever minor wounds you have"
        elapse(ONE_DAY * 7, TRUE);
        create_monster(433);
        fight();
        award(80);
    acase 115:
        if (getyn("Fight nomad"))
        {   create_monster(434);
            npc[0].mr = dice(1) * 7;
            recalc_ap(0);
            fight();
            room = 108;
        } elif (getyn("Flee (otherwise surrender)"))
        {   savedrooms(2, lk, 108, 2);
        } else
        {   room = 2;
        }
        award(30);
    acase 116:
        if (maybespend(50, "Pay fare"))
        {   room = 96;
        } else
        {   room = 73;
        }
    acase 117:
        if (status == STATUS_PIRATE)
        {   oddeven( 8, 141);
        } else
        {   oddeven(96, 141);
        }
    acase 119:
        savedrooms(3, lk, 73, 157);
        award(20);
    acase 120:
        savedrooms(3, chr, 75, 36);
        award(60);
    acase 121:
        drop_all();
        if (status == STATUS_CRIMINAL)
        {   room = 157;
        } else
        {   // assert(status == STATUS_SLAVE);
            room = 77;
        }
    acase 123:
        if (!saved(2, con))
        {   templose_con(misseditby(2, con));
        }
        oddeven(74, 17);
    acase 124:
        result = dice(1) + 1;
        if (saved(result, dex))
        {   for (i = 1; i <= result; i++)
            {   create_monster(424);
                fight();
        }   }
        else
        {   create_monsters(424, result);
            fight();
        }
        award(80);
    acase 126:
        elapse(3 * ONE_DAY, TRUE); // %%: "several"
    acase 127:
        oddeven(76, 61);
    acase 128:
        dicerooms(150, 150, 150, 11, 11, 45);
    acase 129:
        savedrooms(1, chr, 38, -1);
        award(40);
    acase 130:
        if (sex == MALE) room = 104; else room = 46;
        award(50);
    acase 131:
        if (getyn("Seduce master"))
        {   savedrooms(2, chr, 19, 99);
        } else
        {   give(DRK);
            create_monster(427);
            npc[0].mr = dice(1) * 5;
            recalc_ap(0);
            fight();
            room = 62;
        }
        award(20);
    acase 132:
        oldstat = 1;
        savedrooms(2, lk, 50, 65);
    acase 133:
        savedrooms(3, iq, 71, 9);
    acase 135:
        elapse(ONE_DAY * 3, TRUE);
        savedrooms(2, dex, 74, -1);
        award(50);
    acase 136:
        elapse(2 * ONE_MONTH, TRUE);
        give(636); // broken bottle
        create_monster(427);
        npc[0].mr = dice(1) * 5;
        recalc_ap(0);
        if (getyn("Fight (otherwise laugh)"))
        {   fight();
            room = 62;
        } else
        {   dispose_npcs();
            oddeven(29, 1);
        }
    acase 137:
        elapse(2 * ONE_MONTH, TRUE);
    acase 138:
        status = STATUS_NONE;
        award(20);
    acase 139:
        healall_con(); // %%: "see to your wounds"
    acase 140:
        give(DRK);
        create_monster(435);
        fight();
    acase 141:
        status = STATUS_NONE;
        while (shop_buy(100, 'X') != -1);
        if (dice(1) % 2 == 1)
        {   room = 68;
        }
    acase 142:
        if (saved(1, iq))
        {   room = 96;
        } else
        {   templose_con(dice(2));
            room = 40;
        }
    acase 143:
        if (getyn("Retire from adventure")) // %%: ambiguous paragraph
        {   victory(0);
        } else
        {   dicerooms(61, 61, 17, 17, 31, 31);
        }
    acase 146:
        gain_flag_ability(113);
    acase 147:
        if (status == STATUS_PIRATE)
        {   room = 64;
        }
    acase 148:
        result = 1;
        do
        {   if (getyn("Build raft"))
            {   if (!saved(3, con))
                {   templose_con(misseditby(3, con));
                }
                room = 123;
            } elif (getyn("Commit suicide"))
            {   die();
            } else
            {   if (saved(result++, lk))
                {   room = 17;
                } else
                {   elapse(ONE_YEAR * 10, TRUE);
                    permlose_con(con / 10);
        }   }   }
        while (room == 148);
        award(20);
    acase 149:
        status = STATUS_PASSENGER;
        dicerooms(18, 52, 40, 15, 96, 96);
    acase 150:
        status = STATUS_SLAVE;
        if (!saved(2, st))
        {   die();
        } elif (getyn("Accept offer"))
        {   room = 135;
        } else
        {   oddeven(30, 84);
        }
        award(30);
    acase 151:
        give(633); // native spear
        award(10);
    acase 154:
        savedrooms(2, dex, 86, 49);
        award(30);
    acase 155:
        oddeven(145, 3);
    acase 156:
        die();
    acase 157:
        getsavingthrow(TRUE);
        if (madeit(4, iq))
        {   room = 141;
        } elif (madeit(1, iq))
        {   room = 77;
        } else
        {   die();
        }
    acase 158:
        elapse(2 * ONE_MONTH, TRUE);
        if (getyn("Retire from adventure"))
        {   victory(0);
        } else
        {   give_gp(dice(1) * 1000);
            room = 73;
        }
    acase 159:
        while (!saved(3, lk))
        {   templose_st(1); // %%: temporary or permanent?
        }
        award(20);
}   }

#define is ==
#define or ||

EXPORT void sm_magicmatrix(void)
{   aprintf(
"MAGIC MATRIX\n" \
"  When using the Magic matrix, cross-index down from the spell name (at the top of the table) to the paragraph number that sent you here (along the left side) and read your result. Even if a spell does not work, the spellcaster still loses Strength for *trying* to cast it.\n"
    );

    switch (spellchosen)
    {
    case SPELL_TF:
        if
        (   room is 13
         or room is 24
         or room is 45
         or room is 48
         or room is 72
         or room is 90
         or room is 95
         or room is 104
         or room is 114
         or room is 115
         or room is 131
         or room is 136
        )
        {   fulleffect();
        } elif (room is 19)
        {   maybeeffect(3);
        } elif (room is 53 or room is 124)
        {   halfeffect();
        } elif
        (   room is 78
         or room is 91
         or room is 92
         or room is 140
        )
        {   doubleeffect();
        } elif (room is 80)
        {   maybeeffect(4);
        } else
        {   noeffect();
        }
    acase SPELL_VB:
        if
        (   room is 13
         or room is 23
         or room is 53
         or room is 72
         or room is 91
         or room is 115
         or room is 124
         or room is 136
         or room is 140
        )
        {   fulleffect();
        } elif (room is 19 or room is 90)
        {   maybeeffect(4);
        } elif (room is 24)
        {   maybeeffect(3);
        } elif
        (   room is 48
         or room is 80
         or room is 83
        )
        {   doubleeffect();
        } elif (room is 131)
        {   halfeffect();
        } else
        {   noeffect();
        }
    acase SPELL_PA:
        if
        (   room is 13
         or room is 45
         or room is 95
         or room is 124
         or room is 140
        )
        {   maybepowereffect(4, npc[0].mr);
        } elif (room is 19)
        {   halfpowereffect(npc[0].mr);
        } elif (room is 23)
        {   doublepowereffect(42);
        } elif
        (   room is 24
         or room is 53
         or room is 102
         or room is 115
        )
        {   doublepowereffect(npc[0].mr);
        } elif (room is 80 or room is 92)
        {   powereffect(npc[0].mr);
        } elif (room is 90)
        {   maybepowereffect(1, npc[0].mr);
        } elif (room is 104)
        {   powereffect(34);
        } elif (room is 114)
        {   halfpowereffect(42);
        } else
        {   noeffect();
        }
    acase SPELL_DE:
        if
        (   room is 13
         or room is 19
         or room is 78
         or room is 92
         or room is 102
         or room is 104
         or room is 114
        )
        {   doubleeffect();
        } elif (room is 23)
        {   maybeeffect(3);
        } elif
        (   room is 24
         or room is 45
         or room is 48
         or room is 53
         or room is 72
         or room is 95
         or room is 115
         or room is 124
         or room is 131
         or room is 140
        )
        {   fulleffect();
        } elif
        (   room is 90
         or room is 91
         or room is 136
        )
        {   halfeffect();
        } else
        {   noeffect();
        }
    acase SPELL_SF:
        if
        (   room is 19
         or room is 24
         or room is 45
         or room is 48
         or room is 72
         or room is 91
         or room is 95
         or room is 104
         or room is 114
         or room is 124
        )
        {   fulleffect();
        } elif (room is 23 or room is 90)
        {   halfeffect();
        } elif (room is 53 or room is 80)
        {   maybeeffect(3);
        } elif
        (   room is 78
         or room is 92
         or room is 102
         or room is 140
        )
        {   doubleeffect();
        } elif (room is 83)
        {   maybeeffect(4);
        } else
        {   noeffect();
        }
    acase SPELL_EH:
        if
        (   room is 13
         or room is 19
         or room is 45
         or room is 91
         or room is 104
         or room is 115
        )
        {   doubleeffect();
        } elif
        (   room is 23
         or room is 53
         or room is 72
         or room is 92
         or room is 95
         or room is 124
         or room is 140
        )
        {   fulleffect();
        } elif
        (   room is 24
         or room is 83
         or room is 131
        )
        {   maybeeffect(3);
        } elif (room is 136)
        {   halfeffect();
        } else
        {   noeffect();
        }
    acase SPELL_DW:
        if
        (   room is 13
         or room is 19
         or room is 24
         or room is 45
         or room is 53
         or room is 72
         or room is 83
         or room is 90
         or room is 102
         or room is 124
        )
        {   powereffect(npc[0].mr);
        } elif (room is 23)
        {   doublepowereffect(42);
        } elif (room is 48 or room is 92)
        {   maybepowereffect(3, npc[0].mr);
        } elif
        (   room is 91
         or room is 115
         or room is 136
         or room is 140
        )
        {   rebound(FALSE);
        } elif (room is 104)
        {   powereffect(40);
        } elif (room is 131)
        {   halfpowereffect(npc[0].mr);
        } else
        {   noeffect();
        }
    acase SPELL_BP:
        if (room is 19 or room is 83)
        {   rebound(FALSE);
        } elif
        (   room is 23
         or room is 24
         or room is 78
         or room is 90
         or room is 92
        )
        {   fulleffect();
        } elif
        (   room is 48
         or room is 72
         or room is 80
         or room is 95
        )
        {   doubleeffect();
        } elif (room is 91 or room is 140)
        {   maybeeffect(3);
        } elif
        (   room is 102
         or room is 104
         or room is 115
         or room is 124
        )
        {   halfeffect();
        } else
        {   noeffect();
        }
    acase SPELL_IF:
        if
        (   room is 23
         or room is 45
         or room is 78
         or room is 83
         or room is 95
         or room is 102
         or room is 104
         or room is 114
         or room is 131
         or room is 136
         or room is 140
        )
        {   fulleffect();
        } elif (room is 24)
        {   halfeffect();
        } elif (room is 48)
        {   maybeeffect(4);
        } elif
        (   room is 72
         or room is 80
         or room is 90
         or room is 91
         or room is 92
         or room is 124
        )
        {   doubleeffect();
        } else
        {   noeffect();
        }
    acase SPELL_SG:
        if (room is 13)
        {   maybeeffect(2);
        } elif (room is 19)
        {   maybeeffect(3);
        } elif
        (   room is 23
         or room is 24
         or room is 115
        )
        {   rebound(FALSE);
        } elif
        (   room is 48
         or room is 72
         or room is 83
         or room is 91
         or room is 102
         or room is 104
         or room is 136
         or room is 140
        )
        {   doubleeffect();
        } elif
        (   room is 53
         or room is 90
         or room is 124
        )
        {   fulleffect();
        } elif (room is 78 or room is 114)
        {   halfeffect();
        } elif (room is 92 or room is 131)
        {   maybeeffect(4);
        } else
        {   noeffect();
        }
    acase SPELL_WL:
        if
        (   room is 19
         or room is 24
         or room is 53
         or room is 95
         or room is 102
         or room is 115
         or room is 124
         or room is 136
        )
        {   fulleffect();
        } elif
        (   room is 23
         or room is 45
         or room is 80
         or room is 83
        )
        {   doubleeffect();
        } elif (room is 72)
        {   maybeeffect(3);
        } elif (room is 104)
        {   rebound(FALSE);
        } elif (room is 114)
        {   halfeffect();
        } else
        {   noeffect();
        }
    adefault:
        noeffect();
}   }

EXPORT void sm_viewman(void)
{   aprintf("³Status: ²");
    switch (status)
    {
    case STATUS_SLAVE:
        aprintf("Slave\n");
    acase STATUS_CRIMINAL:
        aprintf("Criminal\n");
    acase STATUS_PIRATE:
        aprintf("Pirate\n");
    acase STATUS_PASSENGER:
        aprintf("Passenger\n");
    acase STATUS_NONE:
        aprintf("Normal\n");
}   }
