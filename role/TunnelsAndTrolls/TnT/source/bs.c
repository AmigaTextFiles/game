#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

MODULE const int situations[16] =
{  6, //  3A
  11, //  4A
  16, //  5A
  21, //  6A
  27, //  7A
  33, //  8A
  38, //  9A
  44, // 10A
  49, // 11A
  55, // 12A
  61, // 13A
  67, // 14A
  72, // 15A
  78, // 16A
  83, // 17A
  88  // 18A
};

MODULE const STRPTR bs_desc[BS_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  Let's start with the ground rules. Please read only the indicated paragraphs. Tunnels & Trolls rules apply in all situations unless noted otherwise. Use of any optional rules is up to you.\n" \
"  You will find all the appropriate rules you will need to play this adventure at the front of this book. All trips are made alone; no parties of tourists, please. Spellcasters are limited to Revelation, Will-o-Wisp and combat spells. What to use as combat spells is left to your discretion, but any spell you can use may be used against you. Minimum saving rolls are always 5. You can take any of your magic weapons, charms, rings, etc. down with you. However, if these powers don't fit into a situation's options, then that power won't work in that room.\n" \
"  If you are taking a short trip, roll three dice. If you roll a 3, turn to paragraph {6}; 4 - paragraph {11}; 5 - paragraph {16}; 6 - paragraph {21}; 7 - paragraph {27}; 8 - paragraph {33}; 9 - paragraph {38}; 10 - paragraph {44}; 11 - paragraph {49}; 12 - paragraph {55}; 13 - paragraph {61}; 14 - paragraph {67}; 15 - paragraph {72}; 16 - paragraph {78}; 17 - paragraph {83}; 18 - paragraph {88}. Read the paragraph, and follow the directions. Make your decisions quickly.\n" \
"  If you are trying the Mirror Marathon, then go to {6} and continue through to {88}, going to the next paragraph listed above. [Unless given, each situation is one game turn. ]Spent Constitutions or other attributes are not regained until after completion of the situation which begins at paragraph {88}. Strength is regained as described in the Tunnels & Trolls Rule Book (also published by Corgi Books).\n" \
"~INTRODUCTION\n" \
"Your host for this dungeon is that cheerful mercantile dwarf, Marcelanius the Fair. And fair he is, if you are fair with him. Those who try to cheat him find he swings a mean war hammer. After purchasing an old mirror (which proved to be the entrance to many separate planes of existence), he saw a chance to make some money off the current dungeon-delving craze and developed his Looking Glass Dungeon (no cracks about Alice in Wonderland).\n" \
"  Marcelanius looks up as you enter his Dungeon Supplies shop at Groko Square in downtown Tallymark.\n" \
"  \"Well, well, unless I sleep with orcs, you are here to challenge my Looking Glass Dungeon, correct? Good, fine, let me explain how it works. If you have braved my friend Umslop's dungeon, you will find mine works much the same way. You can take short trips through the mirror, after which you come back here for healing[, being awarded experience,] and replacing equipment which I'll be only too happy to sell you). You may leave a situation by saying 'Enough,' which lets me know you've had enough. I'll bring you back as soon as I hear that word.\n" \
"  \"If you feel like a worldbeater, you can try to survive the Mirror Marathon. A character of little experience shouldn't try it. In this trip, you simply start with one situation and continue through all the situations without coming out to heal wounds or replace equipment. The choice is yours; just let me know which trip you want before I send you through the mirror.\n" \
"  \"I'll end my speech with some helpful suggestions. Sometimes brains are better than brawn. You may need the means of making a fire. Remember, things aren't always what they seem. Be prepared to confront the worst of yourself. Follow me.\"\n" \
"  He takes you to back room. The walls are hung with dark curtains, and a single torch burns to provide light. On a south wall is a mirror, a 10' × 20' slab of ominous power. Marcelanius mutters a few words and the mirror begins to glow redly.\n" \
"  \"Step right up, don't be afraid,\" chuckles the dwarf. \"Take a last look at yourself and step right into the mirror. Good luck!\"\n" \
"  You see your image bathed in blood-red. Stepping forwards, your leg disappears into the mirror. You're on your way..."
},
{ // 1/2A
"You get all the experience earned during the trip, as described in the Tunnels & Trolls rules. You are awarded 100 bonus experience points for surviving a short trip. You get 2000 bonus points if you have survived the Mirror Marathon. If you have made five trips with the same character, the time has come for you to think about trying the Marathon since the short trips are not providing much of a challenge.\n" \
"  You may otherwise try another short trip with this character. Roll three dice and go to that \"A\" paragraph, adding one to the roll, if you have already been to this room. If this character has had enough, Marcelanius thanks you for your patronage, and asks you to spread the news about his dungeon."
},
{ // 2/2B
"This character, while not dead, is not much fun anymore. You can always roll up a new character and try again..."
},
{ // 3/2C
"This dungeon has proved to be too much for you. The creators are pleased! Maybe your next character will have a better time of it..."
},
{ // 4/2D
"\"Great, you survived!\" cries Marcelanius, as you appear in the mirror room. \"Many were not so lucky.[ Now, there's the simple matter of 10% of any treasure you have brought back. This amount was deemed fair at the Brotherhood of Dungeon Hosts Convention last year.]\"\n" \
"  [Pay the dwarf, and ]go to {1}."
},
{ // 5/2E
"Nothing happens. Marcelanius must be busy with a customer in the shop. You'll have to stay in this room a little while longer. Go back to the paragraph you just came from."
},
{ // 6/3A
"You step from a mirror in the southern wall into a brightly lit room. In the centre of the room is a table covered with human bones and shiny objects. The walls are hung with colourful tapestries of elaborate design. You can examine the table ({108}) or search the rest of the room ({180})."
},
{ // 7/3B
"You feel intense pain. You have been tricked by a soul-sucker. Make an L3-SR based on your Strength (30 - ST) to see if you can break free. If you make it, go to {179}. If not, your soul is being sucked from your body. Take 3 off both Strength and Constitution for each combat turn you can't break free. If you do break free, go to {178}. If you die, go to {3}."
},
{ // 8/3C
"Nothing happens as long as you just wait. Go back to the paragraph you just came from ({89})."
},
{ // 9/3D
"Nevet remains stationary and will not advance upon you. Go back to {101}."
},
{ // 10/3E
"As you dive in, you can see that this deep pool is *really* dark. Below you is a faint glow. You may investigate this glow (go to {208}), or you can return to the surface (go to {73})."
},
{ // 11/4A
"You step out of the mirror into a large, brightly lit room. The walls are covered with gaudy tapestries. Couches and sleeping rugs are in ohne corner, a chest is in another corner, and a table with chairs completes the furnishings. The table is covered with half-eaten food. The smell of cheap wine reaches your nose. The room is occupied by two scruffy-looking men. One is tall (6' 4\") and is picking up a light flail (3 dice + 4) from the table. The shorter one (5' 10\") moves to block the only door in the room, unsheathing his claymore (6 dice) as he moves.\n" \
"  The tall one says, \"Well, well, another visitor. We welcome visitors, don't we, Rodansk?\"\n" \
"  Rodansk snickers. \"That's right, Valkum, visitors is how we makes our living. Now give us all you owns, and go free, or we kills you and takes it anyhow. What'll it be?\"\n" \
"  Back to the wall and defend yourself (go to {134}), or surrender and go to {24}."
},
{ // 12/4B
"You find a door. If you open it, go to {75}; if you choose to wait there, go to {17}. If you want to say \"enough,\" go to {96}."
},
{ // 13/4C
"The dragon offers you a jewel-encrusted goblet (worth 1500 gp) to forget your quest. If you take it, say \"enough\" and go to {116}. If you decline the offer, go to {97}."
},
{ // 14/4D
"You find a set of plate armour on the table. You can search for the hobbit hole (go to {193}) or say \"enough\" and go to {116}."
},
{ // 15/4E
"You are falling through limbo. Since limbo is infinite, your character is gone. Go to {2}."
},
{ // 16/5A
"You are in a room half lit with torches which are out of your reach. The lighted half of the room is 30' square. You can see a faint green glow in the dark side of the room. The light side of the room has a door in the middle of one wall. If you want to explore the light side of the room, go to {127}. If you want to explore the dark side of the room, go to {197}. If you want to try to open the door, go to {89}."
},
{ // 17/5B
"The door opens. You are so dazzled by the bright light coming in from the other room that your Strength and Constitution drop by one-quarter for one combat turn. You are blocking the doorway, so only one centaur (MR 54) can attack you. If you kill this one, a second will attack. Fight to the death. If you die, go to {3}. If you kill them both, go to {114}."
},
{ // 18/5C
"The golden glint was from a ring shaped like a fish with its tail in its mouth. If you put the ring on your finger, go to {50}. Otherwise, go to {48}."
},
{ // 19/5D
"The vampire (MR 35) makes a try for your neck. Fight it to the death. [It is immune to poison. ]If you die, go to {3}. If you kill it, go to {141}."
},
{ // 20/5E
"Make a L2-SR based on your on Charisma (25 - CHR). If you make it, go to {100}. If you missed, she wants nothing whatsoever to do with you, so go to {43}."
},
{ // 21/6A
#ifdef CENSORED
"You step from a mirror in the west wall. You are in a room with fur-covered walls. There is a chest in the corner. In the middle of the floor stands a burning brazier. In the room is a beautiful woman. She is wearing a golden chain necklace, an armband, and a swordbelt. On the belt is a flamberge (6 dice + 1). She holds an ornate shield (3 hits) and a spear (3 dice). She looks at you warily. You may try to talk to her ({59}), or you can attack her ({43}), or you may try to charm her ({20})."
#else
"You step from a mirror in the west wall. You are in a room with fur-covered walls. There is a chest in the corner. In the middle of the floor stands a burning brazier. In the room is a beautiful woman. Her sole clothing consists of golden chain necklaces, an armband, and a swordbelt. On the belt is a flamberge (6 dice + 1). She holds an ornate shield (3 hits) and a spear (3 dice). She looks at you warily. You may try to talk to her ({59}), or you can attack her ({43}), or you may try to seduce her ({20})."
#endif
},
{ // 22/6B
"By the light of your torch you see the floor slopes steeply downwards. Descending the slope, you reach the bottom and see...go to {101}."
},
{ // 23/6C
"You spend a pleasant few hours talking to Lorac. Due to the great and varied knowledge of this man, you gain 1000 experience points and add three to your IQ. [He also returns your weapons and treasure dropped in the room below. ]Say \"enough\" and go to {116}."
},
{ // 24/6D
"\"That's what we like, cooperative visitors,\" sneers Valkum. \"Strip off all your weapons, armour and possessions - right down to your tunic. Now move!\"\n" \
"  If you comply, go to {74}. If you fight, go to {134}."
},
{ // 25/6E
"Take the amount by which you missed off your CON. If you die, go to {185}. If you still live, go to {157}."
},
{ // 26/6F
"The octopus overcame his fear of your light and caught you before you reached shore. Fight to the death; it has a MR of 45. If you die, go to {3}. If you slay it, you may continue to shore ({162}) or dive again and investigate the chest (go to {195})."
},
{ // 27/7A
"You have stepped out into the junction of the fifteen planes of the mirror. In this meeting of the existences, all things are possible. You feel as though you're falling through space. Dizzying lights swirl around you. You are overwhelmed and feel the very fibre of your body being pulled apart. You awake to find all your attributes have been raised by 7. Say \"enough\" and go to {116}."
},
{ // 28/7B
"You find a gold sword with a gold hilt set with three gems, in the niche which Nevet was guarding. If you take the sword, go to {51}. If you want to leave it alone, say \"enough\" and go to {116}."
},
{ // 29/7C
"You are in a hypnotic trace, and have an irresistible urge to kiss this woman. Do so and go to {7}."
},
{ // 30/7D
"You have managed to shake off these disgusting beasties. Make a L1-SR based on your Dexterity (20 - DEX). If you make it, go to {166}. If you miss, go to {92}."
},
{ // 31/7E
"These dwarves have a MR of 21 each. Fight to the death. If you die, go to {3}. If they all die, you can search their bodies for treasure (go to {106}) or you can advance (go to {138})."
},
{ // 32/7F
"Your splashing in and out has attracted a young giant octopus. You are surprised to find a slimy tentacle looping around your waist. You have no hope of beating this monster in his own element and in the dark, and you are pulled into the depths. Go to {3}."
},
{ // 33/8A
"You are in a dark room. Powdery dust crunches underfoot. If you want to make a light, go to {111}. If you wish to grope around in the dark, go to {12}."
},
{ // 34/8B
"After you have splashed around for a few minutes, a slimy tentacle loops around your waist. Your blind groping has attracted a giant octopus. Taken by surprise, you have no hope of beating this monster, and it quickly pulls you far below the water. Go to {3}."
},
{ // 35/8C
"Make a L1-SR based on Luck (20 - LK). If you make it, or if you cast a Revelation spell, go to {52}. Otherwise, all you get from this room is nausea. Say \"enough\" and go to {116}."
},
{ // 36/8D
"You are trapped against the ceiling by the rising water, and drown. What did you expect? Go to {3}."
},
{ // 37/8E
"Lifting the trap door, you see a flight of stairs leading down. If you trust she means you no harm, descend and go to {217}. Otherwise, attack her and go to {43}."
},
{ // 38/9A
"You step out of the mirror into a large, well-lit 30' cubic room. There is one problem: you are standing on the ceiling! On the floor above you are rugs, couches, and a table with chairs. Light is provided by a fireplace, and the smoke floats down the chimney. The pictures are upside down on the walls, as is the door. The whole effect is rather nauseating. If you search the walls and ceiling, go to {35}. If you do nothing, go to {144}."
},
{ // 39/9B
"You can now search either the table (go to {14}) or you can see where the hobbits came from (go to {193})."
},
{ // 40/9C
"Your first impression was correct: the cavern is indeed almost empty. However, behind a rock you find a strange torch which gives off a faint green glow. Make a L1-SR on your IQ (20 - IQ). If you make it, go to {187}. If you fail, go to {198}."
},
{ // 41/9D
"The bandit whips a sack of gold out from behind a tapestry, gives it to you and hustles you out of the room, locking the door behind you. You find the sack contains 450 gp. Say \"enough\" and go to {116}."
},
{ // 42/9E
"No luck, go to {5}."
},
{ // 43/9F
"As you approach, she throws the spear at you (3 dice off your Constitution, allowing for your shield and armour, if any). Then she draws her sword. She gets 6 dice + 22 personal adds, and has a Constitution of 40. If you die, go to {3}. If you kill her, go to {158}."
},
{ // 44/10A
"You are in an Egyptian tomb. The sarcophagus lies in the middle of the room. Artifacts are placed around the room. The walls are covered with hieroglyphs. The sarcophagus is empty. Its contents are walking towards you. If you have the means of making an open fire, go to {124}; otherwise, you are going to have to fight this mummy the hard way...go to {133}."
},
{ // 45/10B
"This man enjoys a good conversation. He tells you that his name is Lorac, and that he is an eighteenth-level sorcerer. Make a L1-SR based on your IQ (20 - IQ) to see if your conversation bores him. If you miss, you're boring: go to {174}. If not, he likes you, so go to {23}."
},
{ // 46/10C
"Go to {116}."
},
{ // 47/10D
"Make a L1-SR based on Luck (20 - LK). If you fail, go to {98}. If you make it, you find 1000 gp in the chest. Make a L2-SR based on your Luck (25 - LK). If made, go to {150}. If you fail, say \"enough\" and go to {116}."
},
{ // 48/10E
"By not putting on the ring, you have lost it. Regardless of where you put it, it isn't there now. Go to {65}."
},
{ // 49/11A
#ifdef CENSORED
"You are inside a torture chamber. Around the room are the various instruments of torture - the rack, the iron maiden, and others. There is a door in the north wall. The mirror you came through is on the south wall. Shackled to the east wall is a beautiful girl. The filthy rag she wears barely covers her body. She sees your entrance and begs you to release her before the torturer returns. If you want to help her, go to {164}. If you want to wait, go to {77}."
#else
"You are inside a torture chamber. Around the room are the various instruments of torture - the rack, the iron maiden, and others. There is a door in the north wall. The mirror you came through is on the south wall. Shackled to the east wall is a beautiful girl. The filthy rag she wears barely covers her body, which shows signs of torture. She sees your entrance and begs you to release her before the torturer returns. If you want to help her, go to {164}. If you want to wait, go to {77}."
#endif
},
{ // 50/11B
"This ring gives you the ability to breathe water for one hour a day, so now you are breathing easily. You can surface ({60}), or you can search the chest ({223})."
},
{ // 51/11C
"This sword is purely ornamental. It is worth 1950 gp. Say \"enough\" and go to {116}."
},
{ // 52/11D
"You find a secret panel inside of which is a lever. If you pull the lever, go to {137}. If you don't pull it, go to {153}."
},
{ // 53/11E
"You're done with this room. Say \"enough\" and go to {116}."
},
{ // 54/11F
"Kassamax is gone. The room is empty. You've been had. Say \"enough\" and go to {116}."
},
{ // 55/12A
"You are in a green room; in the centre of this room is a green statue which appears to be a demon of some sort. It is 10' tall, has a scaled body, wings and long taloned arms and legs. One of its eyes is a huge ruby; the other socket is empty. Its one eye trains upon you and the statue speaks.\n" \
"  \"Bring Kassamax his eye and you'll be rewarded beyond your wildest dreams.\"\n" \
"  If you agree to do it, go to {169}. If you refuse, go to {212}. Or, you can say \"enough\" and go to {42}."
},
{ // 56/12B
"As you turn, you see there are no squares behind you. You can go back to the paragraph you just came from, or step into the nothingness ({15}), or you can wait and go to {219}."
},
{ // 57/12C
"Bad move by you. This is an eighteenth-level sorcerer. He detests your violence and turns you into a toad. Go to {2}."
},
{ // 58/12D
"You may now either look around ({28}) or say \"enough\" and go to {116}."
},
{ // 59/12E
"Make a L1-SR based on IQ (20 - IQ). If you make it, go to {109}. If you miss, you say something that insults the amazon (go to {135})."
},
{ // 60/12F
"As you swim upwards, make a L1-SR saving roll on your Luck (20 - LK). If you miss, go to {26}. If you make it, you reach the surface safely. Gather your belongings, say \"enough\" and go to {93}."
},
{ // 61/13A
"You are underwater - you will have to shuck your armour, and drop any weapon heavier than a dagger. Make a L1-SR based on Dexterity (20 - DEX) to see if you get rid of your excess weight in time. If you do, go to {99}. If not, then go to {3}."
},
{ // 62/13B
"You aren't quick enough. Kassamax screams, \"You blind me and so choose your fate!\" You are blinded for life; go to {2}."
},
{ // 63/13C
"You can now search the room. Make a L1-SR based on Luck (20 - LK). If you make it, or if you use a Revelation spell, go to {79}. Otherwise, you find nothing. Say \"enough\" and go to {116}."
},
{ // 64/13D
"When you open the door, you are thrown against the far wall by a cascade of water. Make a L1-SR on Luck (20 - LK). If you make it, go to {221}. If you miss, you are knocked out and drown. Go to {3}."
},
{ // 65/13E
"You may either search the chest and go to {104}, or return to the surface and go to {123}."
},
{ // 66/13F
#ifdef CORGI
"You avoided the trap by removing the hinge pins and opening the chest from the back. You find three gems; roll for them on the Jewel Generator in the rules section at the beginning of the book, and a potion which will double your Strength[ for one hour]. Say \"enough\" and go to {116}."
#else
"You avoided the trap by removing the hinge pins and opening the chest from the back. You find three gems (roll for them on the Jewel Generator in the T&T rulebook), and a potion which will double your Strength[ for one hour]. Say \"enough\" and go to {116}."
#endif
},
{ // 67/14A
"You are in a dimly lit cavern. Before you extends a dark pool. The cavern appears empty save for the usual stalactites and stalagmites. The sound of dripping water echoes eerily around this dank place. If you wish to search the cavern, go to {40}. If you want to search the pool, go to {159}."
},
{ // 68/14B
#ifdef CENSORED
"Their intentions don't seem to be exactly honourable. You must fight them. Turn to {134}."
#else
"These two haven't had even an average-looking woman in a long time. \"Let's see what's under that tunic,\" leers Rodansk. Comply and go to {225}, or you can fight and go to {134}."
#endif
},
{ // 69/14C
"The powder was phosphorous. A spark from your flame touched it off; you were burned to a cinder. Go to {3}."
},
{ // 70/14D
"There is a party of four goblins (MR 15 each) on the square ahead of you. They are not friendly. You can make one of three choices: attack and go to {165}; retreat and go to {56}; wait, and go to {219}."
},
{ // 71/14E
"Twenty minutes have passed, and you are 5' from the ceiling. You can either make for the light from the ceiling and go to {105}, or stay put and tread water, and go to {36}."
},
{ // 72/15A
"You step out into a room which is *completely* free of light (Cat Eyes won't work). You have three options. Stay where you are, and go to {85}; grope in the dark, and go to {220}; or create a light and go to {112}."
},
{ // 73/15B
"You can search the cavern (unless you have already done so) and go to {40}; dive again (go to {32}), or you can collect your belongings and say \"enough\" (go to {93})."
},
{ // 74/15C
"If your Charisma is 8 or less, they merely beat you senseless (your CON drops to 2) and throw you out the door. Moan \"enough\" when you come to, and go to {116}. If your Charisma is 9 or higher, then males go to {196}, and females go to {68}."
},
{ // 75/15D
"Make a L1-SR on Strength (20 - ST). If you miss it, the door does not open for you - go to {17}. If you made it, the door opens and you enter a room containing two centaurs. The room is brightly lit, and your eyes are dazzled for one combat turn (ST and DEX are reduced by ¼ for one combat turn). The centaurs attack you as you come through the door. They have a MR of 54 each and fight you to the death. If you die, go to {3}. If you kill them, go to {114}."
},
{ // 76/15E
"Kassamax looks annoyed. \"Your reward? Ah yes!\" With a blaze of energy, the demon disappears. *You* are now a statue with ruby eyes. You shouldn't mess with a demon...Go to {2}."
},
{ // 77/15F
"She tells you not to waste time, that her tormenter is a sixth-level ogre who could easily kill you. If you release her now, go to {164}. If you still want to wait, go to {103}."
},
{ // 78/16A
"You are in a cold, dark, damp room. The smell of rotting flesh invades your nose. You can see absolutely nothing except a light-framed rectangle on the ceiling. You have three options: just stand there ({172}), make a light ({140}), or grope around in the dark ({215})."
},
{ // 79/16B
"You find the catch hidden in one of the picture frames. Pulling this allows the picture to swing out from the wall. Behind the picture is a compartment containing sacks of gold (200 gp total). Take it and say \"enough\" before whatever lives in the upside-down room returns! Go to {116}."
},
{ // 80/16C
"This whole room has been a strain on your sanity. This last shock is too much. Your mind snaps and you jump off the walkway. Go to {15}."
},
{ // 81/16D
"Kassamax continues his ranting, but nothing happens. You assume he is powerless in his present condition. The only treasure in the room is his other eye. You can take out the eye (go to {186}) or say \"enough\" and go to {93}."
},
{ // 82/16E
"The tomb is devoid of treasure. In the ashes that were the mummy, you find a medallion worth 500 gp, and a ring with a cat's head carved on it. This mummy was a minor priest of Bubastis and this ring gives the wearer the power to control any animal in the cat family. Say \"enough\" and go to {116}."
},
{ // 83/17A
"You are in a 20' square room. The room's source of light is a 20' high monolith which stands before you. Purple light comes from an inscription on the monolith. In the Common Tongue, as well as several ancient languages, is written:\n\n" \
"\"HEREIN LIES GREAT POWER OR GREAT DOOM.\"\n\n" \
"Before the monolith stand several statues of men in various poses, each with a hand stretched out to the monolith. You can either touch the monolith and go to {218}, or examine the statues and go to {113}."
},
{ // 84/17B
"Make a L2-SR based on your Constitution (25 - CON) to see if you had enough air to reach the surface. If you missed the saving roll, you drown: go to {3}. If you made it, you can go back to the octopus's lair after breathing...go to {211}."
},
{ // 85/17C
"He who hesitates is lost. You have remained on this spot too long and triggered a trap door. Make a L2-SR based on Luck (25 - LK). If you make it, go to {191}; otherwise, go to {148}."
},
{ // 86/17D
"You see you are in a small, empty room with a door in the east wall. You came through the mirror in the west wall. A white-green powder covers the floor. You have three options: try to open the door (go to {151}); wait outside the door (go to {117}); or say \"enough\" and go to {96}."
},
{ // 87/17E
"The room has but one exit. The slab must be dealt with in order to leave. Either attack and go to {179}, or touch it with your hand and go to {218}."
},
{ // 88/18A
"You are standing on a 5' square. More squares are in front of you, forming an unending line. All around you swirl changing colours. Make a L1-SR on your Constitution (20 - CON). If you miss, an attack of vertigo causes you to slip off the square; go to {202}. If you made it, you have four options: step forwards ({154}), backwards ({56}), to one side ({15}), or just wait ({219})."
},
{ // 89/18B
"Opening the door, you find a dimly lit corridor. You follow the winding passage until you come to a door. Either open the door and go to {101}, or wait outside the door and go to {8}."
},
{ // 90/18C
"Behind the tapestries you find sacks of gold (450 gp). Now either say \"enough\" and go to {116}, or search the chest and go to {160}."
},
{ // 91/18D
"If you want to search the skeletons, go to {156}. If you wish to search the chest, go to {104}."
},
{ // 92/18E
"The hobbits each have a MR of 17. If you wish to surrender, go to {122}. If you wish to fight, then do so - if you kill them, go to {193}. If you die, go to {3}."
},
{ // 93/18F
"Breathe a sigh of relief and go to {116}."
},
{ // 94/19A
"You have beaten a most formidable opponent: yourself. Now you may either search the body (go to {204}) or say \"enough\" (go to {116})."
},
{ // 95/19B
"The current is too strong for you, and now the water level is at your neck. Make a L1-SR based on Dexterity to see if you can shuck any armour and/or weapons which weigh more than a dagger. If you do, go to {115}. If you don't, you will drown - go to {3}."
},
{ // 96/19C
"Sorry; go to {5}."
},
{ // 97/19D
"The dragon says that he holds the eye to keep the demon imprisoned, and can't let you have it. He adds a large sack of gold (1500 gp) as further inducement. You can either take it, say \"enough\" and go to {93}, or attack the dragon and go to {146}."
},
{ // 98/19E
"You failed to notice the trip wire attached to the chest. A ceiling block smashes you flat. Go to {3}."
},
{ // 99/19F
"There is a dim light above. You can now head for it (go to {102}) or follow the current and go to {125}."
},
{ // 100/20A
#ifdef CENSORED
"She is warmed by you. Go to {206}."
#else
"She is attracted by your animal magnetism. You enjoy hours of mad, passionate love, ending only because of mutual exhaustion. Give yourself 2000 experience points for doing something few free men have done, witness the passion of an amazon. After a good night's sleep to restore your strength, you have a light breakfast and enjoy another tumble in the furs. Say \"enough\" and go to {116}."
#endif
},
{ // 101/20B
"50' before you is a 10' long monster of the glowing green variety. It has a snakelike body, six stumpy legs, and two 4' long heads. You have three options: attack it ({152}), talk to it ({130}), or wait ({9})."
},
{ // 102/20C
"Make an L1-SR based on Constitution (20 - CON) to see if your air lasts. If you miss, go to {3}. It you make it, you surface in a pool that is fed by a waterfall. At the pool's edge stands a beautiful girl. Either swim to her and go to {136}, or dive and go to {61}."
},
{ // 103/20D
"She looks deeply into your eyes; you can't look away. Make an L1-SR on IQ (20 - IQ). If you made it, go to {178}. If you miss, go to {29}."
},
{ // 104/20E
"The octopus overcomes his fear of your light when you threaten his treasure, and attacks. It has a MR of 45, and you will have to make first-level saving rolls on CON (20 - CON) every combat turn to see if you still have air. If you miss a roll or are killed in combat, go to {3}. If you kill it, octopus ink fills the area, and you see nothing even if you have a light. Go to {211}."
},
{ // 105/21A
"You reach the door in the ceiling, open it, and climb up into a lighted room. The water stopped rising when you opened the door, and is now draining out of the room below. In the room with you is an old man dressed in a robe of royal blue. He appears to have no weapons. On his fingers are many strange rings. You sense great magical power. Either attack him and go to {57}, or talk to him and go to {45}."
},
{ // 106/21B
"Searching the dwarves will take time. If you take the time, go to {219}. If you would rather advance instead of searching, go to {138}. If you want to go back, go to {56}."
},
{ // 107/21C
"She breaks through your guard and attaches a sucker to your face. Take 3 off both ST and CON. Now, make a L2-SR on Strength (25 - ST) to see if you can break free. If you make it, go to {118}. Each combat turn you don't break free, take 3 from your ST and CON. If either of these attributes hits zero, go to {3}."
},
{ // 108/21D
"As you start to search the table, 7 black hobbits (MR 17 each) come out from behind one of the tapestries. If you surrender, go to {122}. If you fight and kill them, go to {39}. If they kill you, go to {3}."
},
{ // 109/21E
"If you are female, make a L1-SR on Charisma (20 - CHR). If you make it, go to {206}. If you don't make the roll, or if your character is male, go to {216}."
},
{ // 110/21F
"You clumsy oaf! You've fallen down the slope. Make a L1-SR on Luck (20 - LK). If you made it, go to {101}. If you missed it, then you dropped whatever you were holding in your hands (weapon, treasure) and can't find it again. Go to {101}."
},
{ // 111/21G
"If your light source is an open fire, go to {69}. Otherwise, go to {86}."
},
{ // 112/22A
"You now see the room is octagonal. There are full-length mirrors on the west, northwest, and northeast walls. There is a door in the north wall. You stepped from a mirror on the south wall. The other walls are covered with murals depicting great and bloody battles. You hear a sound from the mirror on the northwest wall. Your reflection begins to speak to you.\n" \
"  \"I am your mirror image[, activated by your light]. I have all your attributes and powers. I carry whatever weapons and belongings you now carry. This room was built as a tribute to the War God, and you may only leave by killing me.\" He then steps through the glass and attacks. Fight to the death. If you die, go to {3}. If you kill yourself, go to {94}."
},
{ // 113/22B
"Great anguish is frozen on their faces. They share another characteristic: only their bodies are sculpted but the rest of each statue is real clothing and equipment. Some are dressed as magic-users, others appear to be warriors. You may either touch the monolith and go to {218}, search for a way out by going to {87}, or say \"enough\" and go to {96}."
},
{ // 114/22C
"Either search the lighted room by going to {119}, or say \"enough\" and go to {116}."
},
{ // 115/22D
"Congratulations, you are quick enough! Go to {71}."
},
{ // 116/22E
"Marcelanius heard you. You begin to glow redly. Go to {4}."
},
{ // 117/22F
"The door opens. The other room is brightly lit, and you see two centaurs. You are blocking the doorway, so only one centaur (MR 54) can attack you. If you kill this one, the second will attack. Fight to the death. If you die, go to {3}. If you kill them both, go to {114}."
},
{ // 118/23A
"Continue fighting until either you die ({3}), she dies ({170}), or you sustain five or more hits during any one combat turn ({107})."
},
{ // 119/23B
"You find a chest. You can either open it and go to {47}, or say \"enough\" and go to {116}."
},
{ // 120/23C
"Roll one die. Subtract this number from your Constitution. If that kills you, go to {3}. Otherwise, go to {63}."
},
{ // 121/23D
"What! You think that you don't need air by now? You sleep with the fishes. Go to {3}."
},
{ // 122/23E
"They quickly strip off your armour and weapons, and take away your treasure. Not satisfied, six hobbits grab you and force you onto the table. Make a L1-SR on Strength (20 - ST). If you make it, go to {30}. Otherwise, you are held helpless on the table and the remaining hobbit cuts you into little pieces. Go to {3}."
},
{ // 123/23F
"Make a L2-SR on Constitution (25 - CON) to get back to the surface. If you miss it, go to {3}. If you make the roll, [gather your things, ]say \"enough\" and go to {116}, or return to search the chest ({104})."
},
{ // 124/24A
"Make a L1-SR based on Dexterity (20 - DEX) to see if you can make a fire in time. If you miss, go to {133}. Mummies are known for their inflammability. Once set afire, the mummy will burn up in 3 combat turns. You have to stave off his attacks for those three turns. In addition to any hits you take from his attack, you get burn damage of 4, 3, and 2 points on the three respective turns. The mummy's MR is 53. If you die, go to {3}. If you kill it, go to {82}."
},
{ // 125/24B
"Make a L1-SR based on Constitution (20 - CON) to see if your air lasted. If missed, go to {3}. If you made it, the current gets stronger as you dive, becoming a whirlpool. You wash out over a falls which empties into a pool. At the water's edge stands a beautiful girl. You can either swim to her by going to {136}, or dive and go to {61}."
},
{ // 126/24C
"Roll two dice and subtract that number from your CON. If that kills you, go to {3}. Otherwise, go to {63}."
},
{ // 127/24D
"You find no treasure in this part of the room. Go to {16}."
},
{ // 128/24E
"You can now either find the ruby and return to the green room (go to {201}), or take three pieces of jewellery, or as much gold as you can carry and say \"enough\" (go to {93}). (If you choose jewellery, roll on the Treasure Generation chart in the T&T Rulebook; none of the items are magical.)"
},
{ // 129/24F
"Make a L2-SR on CON (25 - CON) to see if your air lasts. If you miss, you drown - go to {3}. If you make it, you can go back to the octopus's lair (go to {156}) or you can go to shore[, gather your things,] and say \"enough\" (go to {116})."
},
{ // 130/25A
"Nevet says his name once, then gives you a blank stare. He is not known for being especially bright. Go back to {101}."
},
{ // 131/25B
"You are in shock when the ogre attacks. Take the amount by which you missed your saving roll off your CON and fight using the Tunnels & Trolls combat rules. If you die, go to {3}. If you kill it, go to {145}."
},
{ // 132/25C
"Roll three dice and subtract that number from your Constitution. If that kills you, go to {3}. Otherwise, go to {63}."
},
{ // 133/25D
"The mummy has a MR of 53. [Personal adds and non-magical weapons count at only half value (round up) when fighting a mummy that is not burning. He is immune to magic that doesn't reduce his Monster Rating to zero with one spell. ]Good luck fighting this centuries-old warrior-priest! If you die, go to {3}. If you kill him, go to {142}."
},
{ // 134/25E
"These are tough bandits. Each gets three dice plus 12 adds each, and has a CON of 20. Concentrate your attack against one bandit. They will combine and attack you together. You can surrender at any time by going to {24}. If you kill one of the bandits, go to {177}. If they kill you, go to {168}."
},
{ // 135/25F
"With an amazon warcry, she hurls her spear - you take 3 dice worth off your CON, less shield and armour. Then she attacks. She gets 6 dice + 22 adds, and has a CON of 40. If you kill her, go to {158}. If you die, go to {3}."
},
{ // 136/26A
"As you leave the pool, your knees buckle. The girl helps you to her camp. There is a pot boiling over a fire, and sleep rugs spread out. As you lay down on a rug, she offers you a steaming goblet to drink. Make a L1-SR on IQ (20 - IQ). If you miss the roll, you drink the goblet down...go to {181}. If you make it, go to {167}."
},
{ // 137/26B
"With a groan, the room rights itself. Unfortunately, you were on the ceiling, and now you take a 30' fall. make a L2-SR on the average of your Luck and Dexterity (25 - (LK + DEX ÷ 2)) to see if you got hurt badly. If you made the roll, go to {120}. If you missed the roll by less than 10, go to {126}. If you missed the roll by more than ten, go to {132}."
},
// 224/26C is banned
{ // 138/26D
"You come face to face with an ogre (MR 66). This ogre looks familiar; as you look closer you see that it has your face. Make a L2-SR on your IQ (25 - IQ). If you make the roll, go to {209}. If you miss by more than 10, go to {80}. If you miss by 10 or less, go to {131}."
},
{ // 139/26E
"The rest of the pool is barren. You are running out of air. You can either return to the surface ({129}) or go back to the octopus's lair ({121})."
},
{ // 140/27A
"After making a light, you see that you are in a 20' square room that was constructed of finely-carved granite, but now the walls and floor are covered with lichen. The floor is cluttered with several suits of armour and weapons in various stages of rust. Two of the suits of armour contain bodies. One is just a skeleton, the other is a decomposing corpse. On one wall, you see a door. You can either explore the armour by going to {213}, or try to open the door on the wall and go to {64}."
},
{ // 141/27B
"Drive a stake through her heart, just to make sure. There are 30 doses of [sleep ]potion in the pot for the taking. This potion has to be ingested to work. A search of her body turns up 500 gp in jewellery. Make a L2-SR based on Luck (25 - LK). If you made it, go to {222}. If you missed, say \"enough\" and go to {116}."
},
{ // 142/27C
"When you finally kill him, his body begins to decompose rapidly. Soon all that remains is dust and ashes. Either search the tomb by going to {82}, or say \"enough\" and go to {116}."
},
{ // 143/27D
"You may immediately search the octopus's lair by going to {121}, or return to the surface and go to {84}."
},
{ // 144/27E
"Nothing happens aside from an increase in your nausea. Go back to {38}."
},
{ // 145/27F
"As you strike the death-stroke, you find yourself back in the mirror room. Around your neck is a jewel-encrusted gold necklace worth 3000 gp. [Any experience gotten from combats is multiplied by ten. ]Go to {4}."
},
{ // 146/28A
"The dragon has a MR of 75. Fight to the death. If you die, go to {3}. If you kill it, go to {128}."
},
{ // 147/28B
"Nothing happens so long as you do nothing. Go back to {215}."
},
{ // 148/28C
"*OUCH!* You have skewered yourself by falling 30' and landing on a 10' steel spike. You die - go to {3}."
},
{ // 149/28D
"You reach the bottom of the slope. To find out what you see, go to {101}."
},
{ // 150/28E
"Under the false bottom of the chest, you find a flamberge with a black hilt and blade. This is no ordinary weapon. It has the following attributes: ST needed 20, dice 6 + 3 adds, weight 100, DEX needed 20. [Any time you score a hit with this sword, ¼ of your opponent's CON or MR is added to your Strength for one combat turn. If ]you try to get rid of this sword[, your Strength and Constitution are dropped to ten *permanently*. If this weapon is carried but not used, it subtracts 20 from your Dexterity. Once this sword is drawn from its sheath, it must be blooded within an hour (6 turns) or it causes the wielder to attack the nearest being; if you are alone, the blade will turn on you and slay you]. Say \"enough\" and go to {116}."
},
{ // 151/28F
"Make a L1-SR on Strength (20 - ST). If you miss it, the door does not open for you. Go to {117}. If you made it, the door opens and you enter a room containing two centaurs. The room is brightly lit, but your eyes are already adjusted. The centaurs attack together as you come through the door. They each have a MR of 54, and they will fight to the death. If you die, go to {3}. If you kill them, go to {114}."
},
{ // 152/29A
"Nevet (MR 25), the guardian of the niche[, has two special powers. Whenever he is struck by a metal weapon, he transmits an electrical charge to his attacker (drops ST by 3 each combat turn you are in combat). Remember that as your Strength decreases, you will be unable to handle the heavier weapons. Secondly, non-metal weapons have no effect on Nevet. They just bounce off his slimy hide]. Use the T&T combat rules. If you kill him, go to {58}. If you die, go to {3}."
},
{ // 153/29B
"What have you got to lose? Pull the lever and go to {137}, or leave empty-handed and say \"enough\" - go to {116}."
},
{ // 154/29C
"As you step onto the square before you, the square behind you disappears. Either advance by going to {70}, or wait on this square and go to {219}."
},
{ // 155/29D
"You find passages leading off in every direction, with hundreds of doors and staircases scattered around. You are soon hopelessly lost. Marcelanius can't hear your cries of \"enough\" since this maze is not in any of the mirror planes. You will eventually starve to death. Go to {3}."
},
{ // 156/29E
"You see a golden glint from the skeletons. Either investigate the glint by going to {18}, or search the chest by going to {104}."
},
{ // 157/30A
"Your skin has been transmuted into an alien metal. [It can take up to 12 hits. ]Your body weight is quadrupled[, so bodies of water can be death traps for you (your Strength would have to be around 80 to be able to tread water)]. [Your fists are four-die weapons (2 each). Count yyour added body weight to your total weight being carried. Your new skin needs an occasional oil bath to avoid corrosion. ]You may still perform all bodily functions. Say \"enough\" and go to {116}."
},
{ // 158/30B
"The chest is full of weapons of all kinds - take any you want. Her necklaces and armband are worth 1000 gp. Say \"enough\" and go to {116}."
},
{ // 159/30C
"The pool is too dark to see more than a few feet below the surface. You can either dive into the pool ({171}), or grope around underwater with your hands ({34})."
},
{ // 160/30D
"Make a L1-SR on Luck (20 - LK). If you make it, go to {66}. If you miss, you have sprung a trap when you opened the chest. You pricked your finger on a poisoned needle concealed in the lock mechanism. Go to {3}, unless you are immune to all poison. In that case, the needle stings you but does not kill. Go to {66} and ignore the first sentence."
},
{ // 161/30E
"You materialize in a treasure room. There are heaps of gold, silver, gems, and jewellery. Resting on the treasure is a large dragon. You can either try to talk to it ({175}) or you can attack it ({146})."
},
{ // 162/30F
"Nothing more molests you. You gather your belongings, say \"enough\" and go to {93}."
},
{ // 163/31A
"Nothing happens. Go to {191}."
},
{ // 164/31B
"The chains break easily. The girl falls against you, and tries to kiss you. You can either kiss her ({7}) or refuse to do so ({103})."
},
{ // 165/31C
"Fight to the death. As each goblin dies, it falls over the side of the square and disappears. If you die, go to {3}. Otherwise, you may advance and go to {173}, or wait where you are and go to {219}."
},
{ // 166/31D
"[You were quick enough to grab one of your weapons before they attack. ]Go to {92}."
},
{ // 167/31E
"You are suspicious of this girl. Something tells you to be very careful. You can either drink what she offers ({181}), or you can refuse ({19})."
},
{ // 168/31F
"Your corpse is stripped, mutilated, and thrown out the door. Go to {3}."
},
{ // 169/32A
"A light comes into his eye. \"Excellent, now step onto the black square.\" As you do so, it continues, \"The eye is part of a dragon's hoard. You must now go and kill this thief. When you get back my eye, you will be returned here.\" Make a L2-SR on Dexterity (25 - DEX) for a chance to jump off the square. If you make it, go to {212}. If not, go to {161}."
},
{ // 170/32B
"Surviving your bout with the soulsucker adds 5 to your normal CON and is worth 100 experience points. Say \"enough\" and go to {4}."
},
{ // 171/32C
"You will have to strip down to your tunic. You can take anything with you that weighs less than your Strength multiplied by 5. Your DEX underwater is decreased by two times the dice of the weapon you use. (For example, a weapon that gets 3 dice decreases your Dexterity by 6.) If your DEX goes below the minimum needed for that weapon, you can't use it. If you have the means of making an underwater light, go to {192}. If not, go to {10}."
},
{ // 172/32D
"Nothing happens. Go back to {78} and try something else."
},
{ // 173/32E
"You come across three dwarves, all of whom look like Marcelanius. They wave their weapons at you menacingly. Either attack them by going to {31}, wait by going to {219}, or retreat and go to {56}."
},
{ // 174/33A
"Lorac is a courteous host. He shows you to a table on which are some shields and rings. He tells you that each is special in some way, and you are to take any *one* thing.\n\n" \
"    1) A tower shield.............{183}\n" \
"    2) A viking spike shield......{188}\n" \
"    3) A figure-eight shield......{194}\n" \
"    4) A translucent green ring...{200}\n" \
"    5) A gold ring................{205}\n" \
"    6) A jet black ring...........{210}"
},
{ // 175/33B
"If your adds are 30 or more, go to {13}. If not, make a L1-SR on IQ (20 - IQ) to see if the dragon will talk to you. If you make it, go to {97}. If not, then you bore the dragon and it attacks you - go to {146}."
},
{ // 176/33C
"Nothing happens so long as you do nothing. Go back to the paragraph you just came from."
},
{ // 177/33D
"If your Constitution is more than ½ of its original amount (when you started this fight), then go to {203}. If not, then {190}."
},
{ // 178/33E
"The illusion of a torture chamber disappears. You are now facing an angry soulsucker (MR 53). [If you take five hits in any one turn, go to {107}, or else ]fight to the death. If you die, go to {3}. If she dies, go to {170}."
},
{ // 179/34A
"You are either very brave or very scared, to attack an ancient monolith. Your violent act brings your doom. As your weapon strikes, there is a blaze of purple light. Go to {185}."
},
{ // 180/34B
"Behind one of the tapestries you find a small door. You may either try to open the door by going to {207}, or go to the table by going to {108}."
},
{ // 181/34C
"The drink is a strong sleep potion. Make a L2-SR on your Constitution (25 - CON) to see if you fall asleep. If you make the roll, your Strength is halved - go to {19}. If you miss it, you will fall asleep and this beautiful vampire sucks you dry. You become a vampire. Go to {2}."
},
{ // 182/34D
"You see next to you a 10' steel spike that you just missed impaling yourself upon. You also see a ladder leading up to the trapdoor which you can now climb while holding your light. Go back to {112}."
},
{ // 183/34E
"This is a normal tower shield. It is special because of its historical value. This shield was used in the famous battle at Fire Giant Pass. You have quite a conversation piece there! Say \"enough\" and go to {116}."
},
{ // 184/35A
"Because you have not created a light, you fail to see the ground begin to slope steeply downward. Make a L2-SR on Dexterity (25 - DEX) to see if you fall. If you do fall, go to {110}. If you don't, go to {149}."
},
{ // 185/35B
"The power of the monolith overwhelmed you. You have become another of the statues of the monolith. Go to {2}."
},
{ // 186/35C
"As Kassamax swears oaths that make your skin crawl, you climb the statue and remove his eye (worth 1500 gp). Make a L2-SR on Dexterity (25 - DEX). If you miss it, go to {62}. If you make it, say \"enough\" and go to {116}."
},
{ // 187/35D
"You remember hearing of a substance that glows greenly in the dark and burns even when underwater. This torch is made of that substance. Go to {198}."
},
{ // 188/35E
"This shield is made of a stronger-than-steel metal. It takes five hits and weighs 427 weight units. Say \"enough\" and go to {116}."
},
{ // 189/35F
"If you missed by more than ten, go to {185}. Otherwise, go to {25}."
},
{ // 190/36A
"Enraged by the death of his partner, the other bandit offers you no quarter. If you kill him, go to {214}. If you die, go to {168}."
},
{ // 191/36B
"You have landed on something soft, suffering only minor bruises. Either make a light and go to {182}, or stay where you are and go to {163}."
},
{ // 192/36C
"The light reveals an underwater ledge, below which is a young giant octopus. Your light startles it, and it retreats as you advance, staying on the edge of your light. You see it was protecting a chest and some human skeletons. Either investigate what the octopus was guarding (go to {91}) or search the rest of the pool (go to {139})."
},
{ // 193/36D
"You find a dirty hobbit hole. Hidden in a food cupboard are 247 gp. Say \"enough\" and go to {116}."
},
{ // 194/36E
"This shield is made of a light alien metal, so it weighs only 20 pounds, but still takes 4 hits. Say \"enough\" and go to {116}."
},
{ // 195/36F
"You can see the chest contains a mixed variety of coins and gems. It will take you several trips to get the treasure to shore, as the chest is too rotten to take out. Use the treasure generation table in the T&T Rulebook, once for gems and twice for coins, to value the treasure. (Nothing here is magic.) Take what you can carry away, say \"enough\" and go to {116}."
},
{ // 196/37A
"These bandits are ugly - Charisma of eight. Your good looks bother them, so they decide to change them. Make a L2-SR on Luck (25 - LK). If you make it, you managed to dodge both Rodansk and Valkum, and escape. Say \"enough\" and go to {116}.\n" \
"  If you missed the saving roll, they catch you and carve your face and body, reducing your Charisma to eight. Take twice the amount of your lost Charisma off your Constitution. If this kills you, go to {168}. If you still live, you are thrown out of this room with their laughter ringing in your eyes. Moan \"enough\" and go to {116}."
},
{ // 197/37B
"As you walk towards the dark side of the room, the glow gets brighter. If you want to make a light, go to {22}. If not, go to {184}."
},
{ // 198/37C
"You can now search the pool by going to {159}, or say \"enough\" and go to {116}."
},
{ // 199/37D
"From your contact with the monolith, you absorb both strength and knowledge. Raise both your Strength and IQ by 5 points. Go to {157}."
},
{ // 200/37E
"[This ring doubles the effectiveness of any dagger used with the hand wearing the ring. ]Say \"enough\" and go to {116}."
},
{ // 201/38A
"Kassamax is filled with unholy joy, and tells you to put in the eye. When you do, the statue becomes animated. Laughing, the demon spreads his wings and begins to fade away. You can remind him of your reward by going to {76}, or do nothing and go to {54}."
},
{ // 202/38B
"Goodbye. Go to {15}."
},
{ // 203/38C
"Seeing how easily you dropped his ally, the other bandit drops his weapon, falls to his knees and begs you not to kill him. If you kill him, go to {214}. If you decide to spare him, go to {41}."
},
{ // 204/38D
"Very good. You have been smart enough to take the gold pouch from your dead body. Inside is the same amount of treasure you already have. Say \"enough\" and go to {116}."
},
{ // 205/38E
"This is a plain gold ring, worth 50 gp. It was the only gold item on the table. Say \"enough\" and go to {116}."
},
{ // 206/38F
"She finds something in you to admire. She pulls off one of her necklaces and hands it to you (worth 100 gp). Then, from a concealed place beneath the fur hangings she brings out a dirk (2 dice + 1) in a worn sheath. She explains that it is magically balanced. [When used as a thrown weapon, \"pointblank\" and \"near\" may both be treated as \"pointblank\" (ie. the base saving roll to hit is first level, up to the maximum range of 10 yards). ]Thank her politely and say \"enough\". Go to {116}."
},
{ // 207/39A
"The door opens, revealing a dirty hobbit hole. Seven black hobbits are inside in the midst of their second breakfast. They scoop up their weapons and attack you. Since you surprised them, you can take your first attack right off their Monster Rating (MR 17 each). If you kill them, go to {193}. If you die, go to {3}."
},
// 225/39B is banned
{ // 208/39C
"You swim right into the arms of a young giant octopus (MR 45). Its luminous eyes caused the glow you saw. Fight it to the death, checking every combat turn to see if you still have enough air (roll L1-SR Constitution saving rolls). If you die, go to {3}. If you kill it, go to {143}."
},
{ // 209/39D
"You came out of shock quick enough to counter its initial attack. Fight! If you die, go to {3}. If you kill it, go to {145}."
},
{ // 210/39E
"[This ring allows the wearer to alter his shape to that of any other living animal. The ring doesn't work in any of the rooms in this dungeon. ]Say \"enough\" and go to {116}."
},
{ // 211/40A
"You feel human bones and a chest. In the chest you feet metal discs and sharp stones. It takes several trips to get all the treasure to shore. Use the treasure generation table in the T&T Rulebook, *once* for gems and twice for coins (nothing is magical) to get a value on the treasure. Take what you can carry, say \"enough\" and go to {116}."
},
{ // 212/40B
"\"You are risking my anger, mortal!\" roars Kassamax. \"Do as I ask, or die!\" Agree by going to {169}, or refuse his request by going to {81}."
},
{ // 213/40C
"You find nothing of use among the pieces of armour. Go back to {140}."
},
{ // 214/40D
"Either search the room (go to {90}), or say \"enough\" (go to {93})."
},
{ // 215/40E
"You find a door. Either open it by going to {64}, or just stand there and go to {147}."
},
{ // 216/40F
"You learn that she lives here because she wishes to be left alone. She shows you a trap door in the floor and tells you to leave. Either check out the trap door (go to {37}), tell her you won't do it (go to {135}), or say \"enough\" and go to {42}."
},
{ // 217/40G
"As you descend, the trap door slammed shut and locked. Stepping off the last stair, you get a queasy feeling in your stomach. The stairs behind you vanish. Go to {155}."
},
{ // 218/41A
"As you approach the monolith, you feel great power emanating from it. Your body is bathed in purple light and your hand trembles as you reach towards the forbidding object. When you touch it, great pain races through your hand, up your arms, and into your body. Your skin feels as if it is crawling and tightening at the same time. Make a L2-SR on Constitution (25 - CON) to see if your body can stand this torture. If you make it, go to {199}. If you miss, go to {189}."
},
{ // 219/41B
"After 20 minutes, the square you are standing on disappears. Go to {15}."
},
{ // 220/41C
"You feel along until you reach a wall. It feels smooth and cold. Continuing along, you find a door. Either open it by going to {53}, or make a light and go to {112}."
},
{ // 221/41D
"The room is filling with water. You have two options. Strip down to your tunic, drop any weapon heavier than a dagger, and tread water - go to {71}. Or, you can make for the door you opened by going to {95}."
},
{ // 222/41E
"A more thorough search turns up 2000 gp of gems buried under the fire site. Say \"enough\" and go to {116}."
},
{ // 223/41F
"The octopus overcame its fear of your light and attacked you. It has a MR of 45. If you are killed in combat, go to {3}. If you kill it, octopus ink fills the area and you can see nothing at all, even though you have a light. Go to {211}."
},
{ // 224/26C (banned)
"The paragraph scheduled to be put here disappeared while editing the dungeon. Since you were never directed to this paragraph, subtract 5 from all your attributes for being nosy..."
},
{ // 225/39B (banned)
"You are forced onto the couch. When they are finished with you, they throw you out the door. Say \"enough\" and go to {116}."
} };

MODULE SWORD bs_exits[BS_ROOMS][EXITS] =
{ {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/ 2A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/ 2B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/ 2C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/ 2D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/ 2E
  { 108, 180,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/ 3A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/ 3B
  {  89,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/ 3C
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/ 3D
  { 208,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/ 3E
  { 134,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/ 4A
  {  75,  17,  96,  -1,  -1,  -1,  -1,  -1 }, //  12/ 4B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/ 4C
  { 193, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/ 4D
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/ 4E
  { 127, 197,  89,  -1,  -1,  -1,  -1,  -1 }, //  16/ 5A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/ 5B
  {  50,  48,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/ 5C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/ 5D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/ 5E
  {  59,  43,  20,  -1,  -1,  -1,  -1,  -1 }, //  21/ 6A
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/ 6B
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/ 6C
  {  74, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/ 6D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/ 6E
  { 162, 195,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/ 6F
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/ 7A
  {  51, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/ 7B
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/ 7C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/ 7D
  { 106, 138,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/ 7E
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/ 7F
  { 111,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/ 8A
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/ 8B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/ 8C
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/ 8D
  { 217,  43,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/ 8E
  {  35, 144,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/ 9A
  {  14, 193,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/ 9B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/ 9C
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/ 9D
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/ 9E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/ 9F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/10A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/10B
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/10C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/10D
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/10E
  { 164,  77,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/11A
  {  60, 223,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/11B
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/11C
  { 137, 153,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/11D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/11E
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/11F
  { 169, 212,  42,  -1,  -1,  -1,  -1,  -1 }, //  55/12A
  {  15, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/12B
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/12C
  {  28, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58/12D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/12E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/12F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/13A
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/13B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/13C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/13D
  { 104, 123,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/13E
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/13F
  {  40, 159,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/14A
#ifdef CENSORED
  { 134,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/14B
#else
  { 225, 134,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/14B
#endif
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/14C
  { 165,  56, 219,  -1,  -1,  -1,  -1,  -1 }, //  70/14D
  { 105,  36,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/14E
  {  85, 220, 112,  -1,  -1,  -1,  -1,  -1 }, //  72/15A
  {  40,  32,  93,  -1,  -1,  -1,  -1,  -1 }, //  73/15B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/15C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/15D
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/15E
  { 164, 103,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/15F
  { 172, 140, 215,  -1,  -1,  -1,  -1,  -1 }, //  78/16A
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/16B
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/16C
  { 186,  93,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/16D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/16E
  { 218, 113,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/17A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/17B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/17C
  { 151, 117,  96,  -1,  -1,  -1,  -1,  -1 }, //  86/17D
  { 179, 218,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/17E
  { 154,  56,  15, 219,  -1,  -1,  -1,  -1 }, //  88/18A
  { 101,   8,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/18B
  { 116, 160,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/18C
  { 154, 104,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/18D
  {  -1, 218,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/18E
  { 116, 218,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/18F
  { 204, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/19A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/19B
  {   5,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/19C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/19D
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/19E
  { 102, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/19F
#ifdef CENSORED
  { 206,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/20A
#else
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/20A
#endif
  { 152, 130,   9,  -1,  -1,  -1,  -1,  -1 }, // 101/20B
  { 136,  61,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/20C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/20D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/20E
  {  57,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/21A
  { 219, 138,  56,  -1,  -1,  -1,  -1,  -1 }, // 106/21B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/21C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/21D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/21E
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/21F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/21G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/22A
  { 218,  87,  96,  -1,  -1,  -1,  -1,  -1 }, // 113/22B
  { 119, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/22C
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/22D
  {   4,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/22E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/22F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/23A
  {  47, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/23B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/23C
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/23D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/23E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/23F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124/24A
  { 136,  61,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/24B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/24C
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/24D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/24E
  { 156, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/24F
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/25A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/25B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/25C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/25D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/25E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/25F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/26A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/26B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/26D
  { 129, 121,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/26E
  { 213,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/27A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/27B
  {  82, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/27C
  { 121,  84,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/27D
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/27E
  {   4,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/27F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/28A
  { 215,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/28B
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/28C
  { 101,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/28D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/28E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/28F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/29A
  { 137, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/29B
  {  70, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/29C
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/29D
  {  18, 104,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/29E
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/30A
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/30B
  { 171,  34,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/30C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/30D
  { 175, 146,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/30E
  {  93,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/30F
  { 191,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/31A
  {   7, 103,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/31B
  { 173, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165/31C
  {  92,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/31D
  { 181,  19,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/31E
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/31F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169/32A
  {   4,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170/32B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171/32C
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172/32D
  {  31, 219,  56,  -1,  -1,  -1,  -1,  -1 }, // 173/32E
  { 183, 188, 194, 200, 205, 210,  -1,  -1 }, // 174/33A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175/33B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176/33C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177/33D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178/33E
  { 185,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179/34A
  { 207, 108,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180/34B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181/34C
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182/34D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183/34E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184/35A
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185/35B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186/35C
  { 198,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187/35D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188/35E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189/35F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190/36A
  { 182, 163,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191/36B
  {  91, 139,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192/36C
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193/36D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194/36E
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195/36F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196/37A
  {  22, 184,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197/37B
  { 159, 116,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198/37C
  { 157,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199/37D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200/37E
  {  76,  54,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201/38A
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202/38B
  { 214,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203/38C
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204/38D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205/38E
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206/38F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207/39A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208/39C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209/39D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210/39E
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211/40A
  { 169,  81,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212/40B
  { 140,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213/40C
  {  90,  93,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214/40D
  {  64, 147,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215/40E
  {  37, 135,  42,  -1,  -1,  -1,  -1,  -1 }, // 216/40F
  { 155,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217/40G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218/41A
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219/41B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220/41C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221/41D
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222/41E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223/41F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224/26C (banned)
  { 116,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 225/39B (banned)
};

MODULE STRPTR bs_pix[BS_ROOMS] =
{ "", //   0
  "",
  "",
  "",
  "bs4",
  "", //   5
  "bs6",
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
  "bs28",
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
  "bs83",
  "",
  "", //  85
  "",
  "",
  "",
  "",
  "bs90", //  90
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
  "bs101",
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
  "",
  "",
  "",
  "", // 140
  "",
  "",
  "",
  "",
  "bs145", // 145
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
  "bs157",
  "",
  "",
  "", // 160
  "",
  "",
  "",
  "",
  "bs165", // 165
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
  "bs223",
  "",
  ""  // 225
};

IMPORT int                    been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp, rt, lt, both,
                              height, weight, sex, race, class, size,
                              room, prevroom, module,
                              theround;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];

MODULE int                    oldcon,
                              situation;
MODULE FLAG                   donethis[16],
                              marathon;

IMPORT void (* enterroom) (void);

MODULE void bs_enterroom(void);

EXPORT void bs_preinit(void)
{   descs[MODULE_BS] = bs_desc;
}

EXPORT void bs_init(void)
{   int i;

    exits     = &bs_exits[0][0];
    enterroom = bs_enterroom;
    for (i = 0; i < BS_ROOMS; i++)
    {   pix[i] = bs_pix[i];
    }

    marathon  = FALSE;

    for (i = 0; i <= 15; i++)
    {   donethis[situation] = FALSE;
    }
    if (room == -1)
    {   room = situations[dice(3) - 3]; // 0..15
}   }

MODULE void bs_enterroom(void)
{   int  choice,
         i,
         temp_st,
         temp_con,
         temp_chr;
    FLAG done;

    switch (room)
    {
    case 0: // %%: what does it mean by "come back for healing", do you have to heal yourself or will he heal you? How long can you wait each time (between each trip), eg. to heal naturally?
        if (been[0])
        {   healall_con();
        }
    case 1: // 2A
        if (room == 1)
        {   if (marathon)
            {   award(2000);
            } else
            {   award(100);
                donethis[situation] = TRUE;
        }   }
        marathon = FALSE;
        do
        {   choice = getnumber("0) None\n1) Short trip\n2) Mirror Marathon\n3) Shop\nWhich trip", 0, 3);
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
                shop();
        }   }
        while (choice == 3);
    acase 2: // 2B
    case 3: // 2C
        die();
    acase 4: // 2D
        if (marathon)
        {   situation++;
            if (situation <= 16)
            {   room = situations[situation];
        }   }
    acase 5: // 2E
        room = prevroom;
    acase 7: // 3B
        getsavingthrow(TRUE);
        done = FALSE;
        do
        {   if (madeit(3, st))
            {   done = TRUE;
            } else
            {   templose_st(3);
                templose_con(3);
                if (st <= 0 || con <= 0)
                {   room = 3;
                    done = TRUE;
        }   }   }
        while (!done);
        if (room == 7)
        {   room = 179;
        }
    acase 13:
        if (getyn("Accept goblet"))
        {   give(206);
            room = 116;
        } else
        {   room = 97;
        }
    acase 14:
        give(PLA);
    acase 17:
        temp_st  = st  / 4;
        temp_con = con / 4;
        templose_st(temp_st);
        templose_con(temp_con);
        create_monster(61);
        oneround();
        heal_st(temp_st);
        heal_con(temp_con);
        fight();

        create_monster(61);
        fight();

        if (con <= 0)
        {   room = 3;
        } else
        {   room = 114;
        }
    acase 19:
        create_monster(62);
        fight();

        if (con <= 0)
        {   room = 3;
        } else
        {   room = 141;
        }
    acase 20:
        savedrooms(2, chr, 100, 43);
    acase 23:
        award(1000);
        gain_iq(3);
    acase 25:
        templose_con(misseditby(2, con));
        if (con <= 0)
        {   room = 185;
        } else
        {   room = 157;
        }
    acase 26:
        create_monster(63);
        fight();
        if (con <= 0)
        {   room = 3;
        }
    acase 27:
        gain_st(7);
        gain_iq(7);
        gain_lk(7);
        gain_con(7);
        gain_dex(7);
        gain_chr(7);
        gain_spd(7);
    acase 30:
        savedrooms(1, dex, 166, 92);
    acase 31:
        create_monsters(64, 3);
        fight();
    acase 33:
        makelight();
        if (lightsource() != LIGHT_NONE)
        {   room = 111;
        } else
        {   room = 12;
        }
    acase 35:
        if (saved(1, lk))
        {   room = 52;
        } else
        {   if (cast(SPELL_RE, FALSE))
            {   room = 52;
            } else
            {   room = 116;
        }   }
    acase 40:
        savedrooms(1, iq, 187, 198);
    acase 41:
        give_gp(450);
    acase 43:
        good_takehits(dice(3), TRUE);
        // %%: should we allow player to loot spear after battle?
        create_monster(65);
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 158;
        }
    acase 44:
        if (can_makefire())
        {   room = 124;
        } else
        {   room = 133;
        }
    acase 45:
        savedrooms(1, iq, 23, 174);
    acase 47:
        getsavingthrow(TRUE);
        if (madeit(1, lk))
        {   give_gp(1000);
            if (madeit(2, lk))
            {   room = 150;
            } else
            {   room = 116;
        }   }
    acase 50:
        give(208);
    acase 51:
        give(209);
    acase 56:
        if (getyn("Return to previous paragraph"))
        {   room = prevroom;
        }
    acase 59:
        savedrooms(1, iq, 109, 135);
    acase 60:
        savedrooms(1, lk, 93, 26);
    acase 61:
        savedrooms(1, dex, 99, 3);
    acase 63:
        if (saved(1, lk))
        {   room = 79;
        } else
        {   if (cast(SPELL_RE, FALSE))
            {   room = 79;
            } else
            {   room = 116;
        }   }
    acase 64:
        savedrooms(1, lk, 221, 3);
    acase 66:
        rb_givejewels(-1, -1, 1, 3);
        give(210);
    acase 71:
        elapse(10, TRUE);
    acase 74:
        if (chr <= 8)
        {   templose_con(con - 2);
            room = 116;
        } elif (sex == MALE)
        {   room = 196;
        } else
        {   room = 68;
        }
    acase 75:
        if (saved(1, st))
        {   temp_st  = st  / 4;
            temp_con = con / 4;
            templose_st(temp_st);
            templose_con(temp_con);
            create_monsters(61, 2);
            oneround();
            heal_st(temp_st);
            heal_con(temp_con);
            fight();

            if (con <= 0)
            {   room = 3;
            } else
            {   room = 114;
        }   }
        else
        {   room = 17;
        }
    acase 79:
        give_gp(200);
    acase 82:
        give(211);
        give(212);
    acase 84:
        savedrooms(2, con, 211, 3);
    acase 85:
        savedrooms(2, lk, 191, 148);
    acase 88:
        getsavingthrow(TRUE);
        if (!madeit(1, con))
        {   room = 202;
        }
    acase 90: // 18C
        give_gp(450);
    acase 92: // 18E
        if (getyn("Surrender (otherwise attack)"))
        {   room = 122;
        } else
        {   create_monsters(67, 7);
            fight();
            if (con <= 0)
            {   room = 3;
            } else
            {   room = 193;
        }   }
    acase 95: // 19B
        // %%: what if you don't have anything needing shucking, do you still have to make the roll?
        getsavingthrow(TRUE);
        if (saved(1, dex))
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned)
                {   if
                    (   (items[i].type != WEAPON_DAGGER && (items[i].dice || items[i].adds)) // %%: maybe we should do this by actual weight, not weapon type
                     || (items[i].type != ARMOUR) // %%: what about shields and partial armour?
                    )
                    {   dropitems(i, items[i].owned);
            }   }   }
            // %%: should we drop all carried armour too? We assume so.
            room = 115;
        } else
        {   room = 3;
        }
    acase 97: // 19D
        if (getyn("Agree (otherwise attack)"))
        {   give_gp(1500);
            room = 93;
        } else
        {   room = 146;
        }
#ifndef CENSORED
    acase 100: // 20A
        lose_flag_ability(88);
        award(2000);
#endif
    acase 102: // 20C
        if (!saved(1, con))
        {   room = 3;
        }
    acase 103: // 20D
        if (saved(1, lk))
        {   room = 178;
        } else
        {   room = 29;
        }
    acase 104: // 20E
        create_monster(63);
        oneround();
        // when do we do the air checks?
        while (countfoes() && room == 104 && con >= 0)
        {   getsavingthrow(TRUE);
            if (!madeit(1, con))
            {   room = 3;
            }
            oneround();
        }
        if (room == 104)
        {   room = 211;
        }
    acase 107: // 21C
        templose_st(3);
        templose_con(3);
        do
        {   if (saved(2, st))
            {   room = 118;
            } else
            {   templose_st(3);
                templose_con(3);
                oneround();
                if (st <= 0 || con <= 0)
                {   room = 3;
        }   }   }
        while (room == 107);
    acase 108: // 21D
        if (getyn("Surrender (otherwise attack)"))
        {   room = 122;
        } else
        {   create_monsters(67, 7);
            fight();
            if (con <= 0)
            {   room = 3;
            } else
            {   room = 39;
        }   }
    acase 109: // 21E
        if (sex == FEMALE)
        {   savedrooms(1, chr, 206, 216);
        } else
        {   room = 216;
        }
    acase 110: // 21F
        if (!madeit(1, lk))
        {   if (both != EMPTY)
            {   dropitem(both);
                both = EMPTY;
            }
            if (lt != EMPTY)
            {   dropitem(lt);
                lt = EMPTY;
            }
            if (rt != EMPTY)
            {   dropitem(rt);
                rt = EMPTY;
        }   }
    acase 111: // 21G
        if
        (   lightsource() == LIGHT_TORCH
         || lightsource() == LIGHT_UWTORCH // %%: is LIGHT_WO considered an open flame? (We assume not.)
        )
        {   room = 69;
        } else
        {   room = 86;
        }
    acase 112: // 22A
        makeclone(0);
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 94;
        }
    acase 117: // 22F
        create_monster(61);
        fight();

        create_monster(61);
        fight();

        if (con <= 0)
        {   room = 3;
        } else
        {   room = 114;
        }
    acase 118:
        do
        {   oneround();
            if (!countfoes())
            {   room = 170;
            } elif (con <= 0)
            {   room = 3;
            } elif (good_damagetaken >= 5)
            {   room = 107;
        }   }
        while (room == 178);
    acase 120:
        templose_con(dice(1));
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 63;
        }
    acase 122:
        drop_all();
        savedrooms(1, st, 30, 3);
    acase 123:
        savedrooms(2, con, 116, 3);
    acase 124:
        if (saved(1, dex))
        {   create_monster(68);
            good_takehits(4, TRUE);
            oneround();
            if (countfoes())
            {   good_takehits(3, TRUE);
                oneround();
                if (countfoes())
                {   good_takehits(2, TRUE);
                    oneround();
                    if (countfoes())
                    {   kill_npc(0);
            }   }   }
            if (con <= 0)
            {   room = 3;
            } else
            {   room = 82;
        }   }
        else
        {   room = 133;
        }
    acase 125:
        if (!saved(1, con))
        {   room = 3;
        }
    acase 126:
        templose_con(dice(2));
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 63;
        }
    acase 128:
        choice = getnumber("1) Find the ruby\n2) Take jewellery\n3) Take gold\nWhich", 1, 3);
        if (choice == 1)
        {   room = 201;
        } elif (choice == 2)
        {   rb_givejewels(-1, -1, 1, 3);
            room = 93;
        } else
        {   encumbrance();
            give_gp((st * 100) - carrying());
            room = 93;
        }
    acase 129:
        if (!saved(2, con))
        {   room = 3;
        }
    acase 131:
        templose_con(misseditby(2, iq)); // %%: does armour help? We assume not.
        create_monster(69);
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 145;
        }
    acase 132:
        templose_con(dice(3));
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 63;
        }
    acase 133:
        create_monster(68);
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 142;
        }
    acase 134:
        if (prevroom != 24)
        {   create_monster(70);
            create_monster(71);
        }
        do
        {   if (getyn("Surrender"))
            {   room = 24;
                dispose_npcs();
            } else
            {   theround = 0;
                oldcon = con;
                oneround();
                if (con <= 0)
                {   room = 168;
                } elif (countfoes() == 0) // %%: it doesn't actually say what to do in this situation
                {   room = 214;
                } elif (countfoes() == 1)
                {   room = 177;
        }   }   }
        while (room == 134);
    acase 135:
        good_takehits(dice(3), TRUE);
        // %%: is player allowed to loot spear after battle? We assume not.
        create_monster(65);
        if (con >= 1)
        {   room = 158;
        } else
        {   room = 3;
        }
    acase 136:
        savedrooms(1, iq, 167, 181);
    acase 137:
        getsavingthrow(TRUE);
        if (madeit(2, (lk + dex) / 2))
        {   room = 120;
        } elif (madeitby(2, (lk + dex) / 2) >= -10) // %%: it doesn't say what to do if you miss it by exactly 10
        {   room = 126;
        } else
        {   room = 132;
        }
    acase 138:
        getsavingthrow(TRUE);
        if (madeit(2, iq))
        {   room = 209;
        } elif (madeitby(2, iq) >= -10)
        {   room = 131;
        } else
        {   room = 80;
        }
    acase 141:
        give_multi(219, 30);
        give(332);
        savedrooms(2, lk, 222, 116);
    acase 145:
        give(220);
    acase 146:
        create_monster(72);
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 128;
        }
    acase 150:
        give(221); // %%: it doesn't explain how this curse can be lifted
    acase 151:
        if (saved(1, st))
        {   create_monsters(61, 2);
            fight();
            if (con <= 0)
            {   room = 3;
            } else
            {   room = 114;
        }   }
        else
        {   room = 117;
        }
    acase 152:
        create_monster(73);
        fight();
        if (con >= 1)
        {   room = 58;
        } else
        {   room = 3;
        }
    acase 157: // 30A
        gain_flag_ability(24);
        weight *= 4;
    acase 158:
        while (shop_give(2) != -1);
        give(333); // %%: is the 1000 gp the total? Or does it mean 1000 gp each? We assume it is the total.
    acase 160: // 30D
        if (saved(1, lk))
        {   room = 66;
        } else
        {   if (immune_poison())
            {   room = 66;
            } else
            {   room = 3;
        }   }
    acase 164:
        create_monsters(66, 4);
        fight();
        if (con <= 0)
        {   room = 3;
        }
    acase 169: // 32A
        if (saved(2, dex))
        {   room = 212;
        } else
        {   room = 161;
        }
    acase 170: // 32B
        gain_con(5);
        award(100);
    acase 171: // 32C
        makelight();
        if
        (   lightsource() == LIGHT_UWTORCH
         || lightsource() == LIGHT_CE
         || lightsource() == LIGHT_WO // %%: we assume WO spell works underwater
         || lightsource() == LIGHT_CRYSTAL
        )
        {   room = 192;
        } else
        {   room = 10;
        }
    acase 175: // 33B
        if (calc_personaladds(st, lk, dex) >= 30)
        {   room = 13;
        } elif (saved(1, iq))
        {   room = 97;
        } else
        {   room = 146;
        }
    acase 176: // 33C
        room = prevroom;
    acase 177: // 33D
        if (con > oldcon / 2)
        {   dispose_npcs();
            room = 203;
        } else
        {   room = 190;
        }
    acase 178: // 33E
        create_monster(74);
        theround = 0;
        do
        {   oneround();
            if (!countfoes())
            {   room = 170;
            } elif (con <= 0)
            {   room = 3;
            } elif (good_damagetaken >= 5)
            {   room = 107;
        }   }
        while (room == 178);
    acase 181: // 34C
        if (saved(2, con))
        {   templose_st(st / 2);
            room = 19;
        } else
        {   room = 2;
        }
    acase 183: // 34E
        give(TOW);
    acase 184: // 35A
        if (saved(2, dex))
        {   room = 149;
        } else
        {   room = 110;
        }
    acase 186: // 35C
        give(222);
        if (saved(2, dex))
        {   room = 116;
        } else
        {   room = 62;
        }
    acase 187: // 35D
        give(ITEM_BS_UWTORCH);
        makelight();
    acase 188:
        give(223);
    acase 189:
        if (madeitby(2, con) < -10)
        {   room = 185;
        } else
        {   room = 25;
        }
    acase 190: // 36A
        fight();
        if (con >= 1)
        {   room = 214;
        } else
        {   room = 168;
        }
    acase 191: // 36B
        if (makelight())
        {   room = 182;
        } else
        {   room = 163;
        }
    acase 193: // 36D
        give_gp(247);
    acase 194: // 36E
        give(224);
    acase 195: // 36F
        rb_givejewel(-1, -1, 1);
        rb_givecoins();
        rb_givecoins();
    acase 196: // 37A
        if (saved(2, lk))
        {   room = 116;
        } else
        {   if (chr > 8)
            {   temp_chr = chr - 8;
                change_chr(8);
                templose_con(temp_chr * 2);
                if (con <= 0)
                {   room = 168;
                } else
                {   room = 116;
        }   }   }
    acase 197: // 37B
        if (makelight())
        {   room = 22;
        } else
        {   room = 184;
        }
    acase 199: // 37D
        gain_st(5);
        gain_iq(5);
    acase 200:
        give(213);
    acase 204:
        give_cp(cp);
        give_sp(sp);
        give_gp(gp);
        // %%: what about jewels, etc.?
    acase 205:
        give(214);
    acase 206:
        give(215);
        give(216);
    acase 207:
        create_monsters(67, 7);
        good_freeattack();
        fight();
        if (con >= 1)
        {   room = 193;
        } else
        {   room = 3;
        }
    acase 208:
        create_monster(63);
        oneround();
        // when do we do the air checks?
        while (countfoes() && room == 208 && con >= 0)
        {   if (!saved(1, con))
            {   room = 3;
            }
            oneround();
        }
        if (room == 208)
        {   room = 143;
        }
    acase 209:
        create_monster(69);
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 145;
        }
    acase 210:
        give(217);
    acase 211:
        rb_givejewel(-1, -1, 1);
        rb_givecoins();
        rb_givecoins();
    acase 218:
        savedrooms(2, con, 199, 189);
    acase 220:
        if (makelight())
        {   room = 112;
        } else
        {   room = 53;
        }
    acase 221:
        if (getyn("Tread water (otherwise leave)"))
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned)
                {   if
                    (   (items[i].type != WEAPON_DAGGER && (items[i].dice || items[i].adds)) // %%: maybe we should do this by actual weight, not weapon type
                     || (items[i].type != ARMOUR) // %%: what about shields and partial armour?
                    )
                    {   dropitems(i, items[i].owned);
            }   }   }
            // %%: should we drop all carried armour too? We assume so.
            room = 71;
        } else
        {   room = 95;
        }
    acase 222:
        give(638);
    acase 223:
        create_monster(63);
        fight();
        if (con <= 0)
        {   room = 3;
        } else
        {   room = 211;
        }
    acase 225:
        lose_flag_ability(88);
}   }
