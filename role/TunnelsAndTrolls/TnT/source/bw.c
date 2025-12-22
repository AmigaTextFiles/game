#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/*
Official errata (all implemented):
 Paragraphs 1B, 5A, 8E, 21G, 25L, and 30C all have a reference to 13F, and it should be 37F.
 Paragraphs 36B and 45C both have an option 15C that should be 15B.
 Paragraph 2C has an option 13G that really should be 17F.
 Paragraph 6D turns out to be somewhat confusing. It makes more sense if you rewrite it to read: 6D The figure begins to turn toward you. If you have some sort of invisibility (check the magic matrix) or can make a 1st level saving roll on luck, you pass on your way unseen to paragraph 1D. If you miss the roll, go to 8H, you have been seen. (The GOTO paragraphs are correct, but paragraph 1D seems not to connect unless you use the above wording.)
 Another clarification: the Combat Chart on page iii. What it means is that you are supposed to add another point to the dice roll multiplier for each 50 points your adds exceed 100.
Unofficial errata:
 Paragraph #37 (aka 5L) is unreachable.
*/

MODULE const STRPTR bw_desc[BW_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  Beyond the Wall of Tears is an outdoor adventure through a strange and often terrifying nightmare land. It is for any character type and level. Also, only one (1) adventurer is allowed at a time (no groups!). Magic is available here, but it can be very unreliable. Most spells will work (though not always correctly), with the absolute exception of Wall and Travel spells (ie. Wall of Iron, Wings, etc.) To find out the outcome of a particular spell, cast it and then check the Magic Matrix on pages 46 and 47. Below, you will find two systems which gear this adventure to the individual. One is a combat system, the other a saving roll system. You will also need some paper and pencil, a few six-sided dice, and a copy of the 5th edition Tunnels & Trolls rulebook.\n" \
"  To use the Combat Chart below, find the category that your character fits into. Use the number beside it as the multiplier for the dice roll of the monster(s) that you face. Be sure to multiply *before* you add in the combat adds. This multiplier reflects the fluid nature of the dream world you are about to enter: the tougher you character, the harder you will have to fight.\n" \
"  In the game, certain saving rolls will be called for. To determine what level saving roll is needed in a given situation, take the attribute that the saving roll calls for and divide by the number listed below, fractions always rounding up.\n" \
"  Example: A character with a Luck of 30 must make a saving roll based on Luck. He would take his Luck of 30 and divide by 8. This leaves a 4. Thus, a 4th level saving roll on Luck would be needed. Any attribute that is below 10 would result in a 0th level saving roll, or the basic roll of 5 (remember that doubles add and re-roll).\n" \
"  When the paragraph calls for a Wandering Monster to appear, check the Wandering Monster Table on the last page of this book.\n" \
"  ~To begin play, go to {1}.`\n" \
"COMBAT CHART\n" \
"    Your Combat Adds    Dice Roll Multiplier\n" \
"       19 or less                 1\n" \
"         20-35                    2\n" \
"         36-57                    3\n" \
"         58-100                   4\n" \
"      101 or more         +1 per 50 points\n" \
"  Add another point to the dice roll multiplier for each 50 points your adds exceed 100.\n" \
"SAVING ROLLS\n" \
"    Attribute Value     Saving Roll Divisor\n" \
"       19 or less                10\n" \
"         20-35                    8\n" \
"         36-57                    6\n" \
"       58 or more                 5~"
},
{ // 1/1A
"You knew that living on the border between night and day would hold dangers, and now the worst has finally happened. Your younger sister has been kidnapped, stolen under the cover of night by the evil creatures which roam and thrive in the region of terror where mortals visit only in nightmares. Or, as you know, in the rarely used ritual called Dreamwalking...\n" \
"  Your village wizard stares hard and long at you. \"You realize the dreamwalking is difficult. You will constantly be faced by foes your own mind conjures up, and they will press you hard in your quest for your kin. To protect yourself, I will give you the ceremonial weapons.\" The wizard offers you the four-dice straight sword \"Dreamreaver\" and a dirk, worth two dice and one add, called \"Nightmare\". If you are a wizard he substitutes a staff called \"Nightstick\". It works like a staff ordinaire.\n" \
"  In your armour you lay back on your bed. The wizard lights four sticks of incense and stations one at each corner of your bed. He hands you a chalice containing a bitter liquid that glows a pale blue. You drink it and begin to fall asleep.\n" \
"  \"If you recover treasure, upon waking you will know where it is hidden in this world. If you die in your dreams, you will die here. Good luck.\" The wizard's voice fails.\n" \
"  As you slip into the deathlike trance, you find yourself standing behind a large, ornately carved stone wall. This is the mythical Wall of Tears, so named for those who mourn the adventurers who pass beyond her and never return. As you stand watching, a section of the wall wavers and vanishes, allowing you passage through her. You are standing upon a long winding road which glistens in the double moonlight. Many red and yellow eyes peer at you from the dense forest that borders each side of the road. If you wish to make a light, go to {250}. If you would prefer to travel in the darkness, go to {118}."
},
{ // 2/1B
"After days of searing heat and freezing nights, you reach the base of the mountains. They appear to be totally sheer and unscalable. If you wish to search for an easy route through, go to {273}. If you want to try and climb, go to {56}."
},
{ // 3/1C
"At your approach, the \"boulders\" shift and move. Immediately, you find that you are surrounded by fierce giant crabs. Fight for your life! Each crab has a MR of 5 (plus modifier), and there are 1d6 + 3 of them. [You must make a saving roll on DEX each round to avoid getting struck from behind. If you miss your roll, you must take full effect for any blows from one crab that round (even if you win that round). ]If you win, go to {77}. If you are undone, go to {103}."
},
{ // 4/1D
"The light casts an eerie shadow as you move through the cavern. You can see many narrow crevices in the walls as you move along. The path moves downwards at a gentle slope. Your footsteps echo back at you, no matter how soft your tread. Make a saving roll on LK. If you are in the graces of the fickle lady, go to {208}. If she has turned her head, go to {138}."
},
{ // 5/1E
"The door gives way slowly as you enter the huge, dusty building. Once inside, the door swings closed behind you. For a moment, all is darkness. Then, at the far end of the room, a soft golden light begins to glow. As you approach, you see a small golden idol sitting atop a stone altar. There is an old tome next to the idol. If you would like to cast a spell, do so now. If you wish to take the idol, go to {38}. If you'd rather take the book, go to {212}."
},
{ // 6/1F
"You peek cautiously over the small hill and spy several creatures sitting around a campfire. They are talking in low, guttural sounds that just border on recognizable words. Not far from where they sit is a smaller bound form. The light plays over the quiet figure, only revealing the slight body. Could it be? After all you trials, could it be your little sister? A stray flicker of light dances across the captive's face. Yes! It is she.\n" \
"  Now you must choose. If you wish to rush in and attack the foul creatures that hold her, go to {209}. If you would like to sneak about in hopes of catching them unaware, go to {183}."
},
{ // 7/2A
"Take 3 dice worth of damage as the ceiling falls on you. If you still survive, all of your treasure is lost beneath the settling rubble. Fate is not altogether against you though, for you still retain your weapons. You see that all of the buildings have crumbled into dust, and the mist is gone. If you perished in the collapse, go to {103}. If you are still among the living, choose which direction you prefer: back to the main road ({128}) or along the side path that took you here ({67})."
},
{ // 8/2B
"Dazed and tired, you find that you must rest. Yet in this heat, rest is nearly impossible. Almost beaten, you rise to continue your quest. Take 5 from your CON and go to {292}."
},
{ // 9/2C
"The pink-fleshed denizen of the underworld has a Speed rating of 20. If yours is greater, you may escape to the outside unhindered; go to {128}. If yours is equal or less, you must turn and fight; go to {255}."
},
{ // 10/2D
"Rushing in, you shatter the walls with a single, well-placed kick. This sends the survivors fleeing in terror. Below you, in the heart of the now ruined castle, you see a metal glove. It seems to have been used as a throne. If you wish to take this prize, go to {152}. If you just want to leave, go to {253}."
},
{ // 11/2E
"The swarm follows you at a discreet distance. You cannot seem to lose it. You might as well go back to {223} and choose again."
},
{ // 12/2F
"The road leads steeply up into the mountains. There seem to be places where the mountain was actually melted away to make a path. Above you on either side are steep, smooth cliffs. Higher and higher the road takes you until you come to a pass near some very tall peaks. Make a saving roll on LK. If you make the roll, go to {240}. If not, go to {296}."
},
{ // 13/2G
"Dawn has come and gone, and you have travelled many leagues. You have come upon a place where the road splits into three branches. To the left, the road changes colour, from black to a deep greenish hue. To your right, the road changes to light brown. If you would like to take the right fork, go to {244}. If you wish to go left, go to {185}. If you'd rather just stay on the main road, go to {259}."
},
{ // 14/2H
"As you sleep, you dream (yes, a dream within a dream). In your dream, you see your sister. She looks battered and weary. Her wrists drip a slow crimson fluid where the rough ropes have bitten into her tender flesh. There seems to be a fierce battle raging all around her. A light rain is falling and you see a small wood bridge in the background. A figure, large and dark, moves in front of her. She seems to shrink in horror from this ebon form. With a clap of thunder, you awake. You are soaked to the bone and night seems to be rapidly approaching. The moons will be hidden this night. If you wish to set up camp, go to {182}. If you decide to make a light, go to {199}. If you want to continue on in darkness, go to {46}."
},
{ // 15/2J (there is no 2I)
"Halfway across, you slip on the slick stones and tumble into the river. Make a saving roll on CON. If you are lucky and make your roll, go to {302}. If your luck has run out, go to {291}."
},
{ // 16/2K
"Though it is impossible to ever truly kill a ghost, your attacks have reduced the shade to utter impotence! You know that you must take your leave of this accursed city before it can regain its strength. Go to {128}."
},
{ // 17/2L
"Ahead of you on the path you see a few glistening slender threads. Spider webs! If you would like to cut or burn your way through them, go to {117}. If you fear for your life and wish to turn back, go to {53}. If you feel a bit more ambitious and wish to try and reason with the spider, go to {178}."
},
{ // 18/3A
"You have earned your freedom. The elven lord bows before you and begs that he be allowed to aid in your quest, at least to the forest's edge. If you feel safer in the company of these \"Dark Elves\", go to {320}. If you feel it best to go on alone, go to {151}."
},
{ // 19/3B
"The Wraiths continue on. As they (and you) move down from the shelter of the mountains, you enter the Valley of Shadows. Here the air seems to be somehow darker and thicker. You are barely able to make out the citadel Cantahf in the distance. The Wraiths increase their speed. If you wish to attack now, go to {311}. If you still want to follow, go to {112}."
},
{ // 20/3C
"Groggy and shaken, you wobble to your feet. Looking about, you determine that the walls of the pit are far too slick to climb. A few feet from you is a roughly hewn statue of a seated man. In one hand, he holds a torch, in the other a staff. Carved into the base of the statue are the words: \"One is DOOM, the other is FREEDOM.\" There is nothing else of value in the cavern. If you choose to take the staff, go to {286}. If you choose the torch, go to {121}."
},
{ // 21/3D
"You must make a saving roll on LK to find out if you pass the night unscathed. If you make your saving roll, go to {193}. If fate is against you, go to {312} and face what you must."
},
{ // 22/4A
"They walk past you and disappear from view. You breathe a sigh of relief as you step out from behind the boulder and continue on. Ahead of you, the trail seems to level off and then start down. You are on top of a mountain. Looking down, you can see a dark valley and an iron citadel glowing red as it sits in a lake of boiling blood. You are a bit exposed up there, so roll on the Wandering Monster Table. There is no place to run so you must fight. If you win, go to {163}. If not, go to {103}."
},
{ // 23/4B
"Azoth, the great dragon, growls a challenge. If you are hero enough to do battle with this magnificent creature, go to {55}. If, instead, you turn to flee, go to {261}."
},
{ // 24/4C
"The door opens easily. You find yourself looking down at a sleeping giant. After a few moments you begin to feel very dizzy. It is then that you realize that you are looking at your own sleeping form! The effects of the special potion that let you journey here cannot stand the shock of you seeing yourself and begins to wear off. Go to {227}."
},
{ // 25/4D
"The sand-strewn road is hard to make out in the shifting light. You manage to push yourself over the dunes at a slow, plodding pace. Ahead of you, the light that you were following flickers out. \"They\" have spotted your approach. Make a saving roll on LK. If you make it, go to {52}. If your roll fails, go to {246}."
},
{ // 26/4E
"The brutes are stupid, but they are willing to talk. One of them (obviously the brightest of the bunch) says that he remembers seeing a group of beings with a young female among them. He can't remember where or when, though. You can tell by the agitation this one is showing that he is unused to talking. You'd best be on your way. If you would like to continue on this path, go to {145}. If you'd rather return to the main road, go to {53}."
},
{ // 27/5A
"You awake hours later, half buried in the sand. Dragging yourself out you see that the sun is high in the sky. You check the area and find that the band is long gone. Their fire is cold. With a weary and battered body, you once more take to the road. Go to {273}."
},
{ // 28/5B
"Make a saving roll on LK. If you make it, go to {116}. If you miss your roll, go to {43}."
},
{ // 29/5C
"Choose your direction. If you would like to return to the main road, go to {128}. If you'd rather continue on the path, go to {67}."
},
{ // 30/5D
"The forest giant doesn't immediately step on you. Instead, he pick you up in his mighty hand and asks your name. He smiles with teeth that look like tree stumps. After considering your tale, he offers to aid you. If you accept, go to {194}. If you refuse, go to {267}."
},
{ // 31/5E
"One of the tiny beings pushes forward and in a small but gruff voice, orders you off. If you would like to comply, go to {253}. If you insist on being a pest, go to {262}."
},
{ // 32/5F
"With an agonizing effort, you are finally able to scramble up the steep facade. Once on top, you begin sliding down the opposite side. Unable to stop yourself, you bump to a halt on a narrow mountain path. Take 5 from your CON for the hard fall. Breathing hard, you struggle to rise. Go to {141}."
},
{ // 33/5G
"Your attack catches her by surprise. The evil witch dies instantly under your power. This leaves you free to search the cavern. In one corner, you find a healing potion that will restore any CON you have lost. The only other thing of note in the room is the crystal skull around the dead witch's neck. If you wish to take it, go to {187}. If you would just like to continue on your way, go to {148}."
},
{ // 34/5H
"All around you, you can hear whispered voices. The mist seems to cling and pull at you. A fell chill creeps up your spine. The path seems to be fairly level as you walk, but when you look behind you, it seems that you have just travelled through steep hills. Eventually, you come out into a small ruined city. The mist is very heavy around the base of all of the buildings, save one. It is a small building with all of its stone walls and roof intact. If you wish to investigate the first building you come to, go to {69}. If you would like to try the mistless building, go to {5}. If you just want to get out of there, go to {99}."
},
{ // 35/5J (there is no 5I)
"You have made a light. With it, you can see that the road is still a slimy black. All of the prying eyes have vanished into the surrounding darkness. It is well to remember though, that if you can see by the light, you can also be seen. If you wish to continue walking, go to {21}. If you'd rather make camp, go to {204}."
},
{ // 36/5K
"The last of the skeletons rattles to the ground. As you once again turn to cross the bridge, you notice that the flame tower has moved off a little. It speaks to you in its loud, crackling voice, \"Well fought, little one! Still, I cannot let you pass. Only if you best me either in combat or rolling the bones may you continue on.\n" \
"  If you choose to battle this thing, go to {68}. If you would gamble with it, go to {304}. If you think that you would fare better with the river, go to {283}."
},
{ // 37/5L (unreachable!)
"You advance cautiously on the citadel. Strangely there are no guards to bar your way. At least, none that you can see.\n" \
"  As you approach the citadel, your foot accidentally kicks one of the many loose clods of dirt that are strewn here. Suddenly there is a loud clamour of alarm bells. The reason for the lack of guards is now apparent as the world goes spinning around you. You awaken in your hut, realizing that you will never save your little sister from Ballaha. You lie there, cursing Ballaha and his alarm clods."
},
{ // 38/6A
"The idol is of a slug-like creature, eyeless but with several small tentacles coming from the area where eyes would be. The mouth is perfectly circular, with a triple row of jewelled teeth all around. The moment your hand falls upon the idol, a deep rumbling noise begins beneath your feet. Instants later, a creature exactly like the one you hold in your hands bursts through the floor. Unlike the idol, this one is 30' long and 6' around. It has an MR of 35. If you wish to fight this fecund beast, go to {255}. If you'd rather flee, go to {9}."
},
{ // 39/6B
"Make a saving roll on CHR. Any creature *could* be amiable, even a Hobgoblin. If you make your roll, go to {91}. If not, go to {298}."
},
{ // 40/6C
"At your approach, she waves her hands, as if to ward you off. You stiffen as though physically struck. Your body begins to change. Your sandals burst apart as your feet sprout thick roots. Your arms are thrust skyward as they change into stout limbs. Your last thoughts are occupied with the image of the cute little Dryad that just changed you into a tree. Go to {103}."
},
{ // 41/6D
"The figure begins to turn toward you. If you have some sort of invisibility (check the magic matrix) or can make a first level saving roll on Luck (20 - LK), you pass on your way unseen to paragraph {4}. If you miss the roll, go to {57}, you have been seen."
// Uncorrected version was: "The figure begins to turn toward you. If you have some form of invisibility, go to {4} (magic-users should check the Matrix first). If not, make a saving roll on LK. If you make your roll, go to {4}. If you miss the roll, go to {57}; you've been seen!"
},
{ // 42/6E
"You have come upon a short dirt wall. It looks as though some child has been playing with a bucket and shovel. As you peer past the wall, you can see a tiny moat surrounding a miniature castle. The \"toy\" castle is constructed of rock in a neat geometrical precision. If you want to jump the wall for a closer inspection, go to {124}. If you'd rather continue on your way, go to {253}."
},
{ // 43/6F
"As you touch the first stone, it changes into a writhing viper. The whole field is alive with them. In seconds, they surround you, hissing and striking. You drop in agony as the first set of fangs buries itself in your leg. You start to change form, and moments later you find that you are also a viper. Feeling a bit tired, you curl yourself into the dormant state of a bright blue gem and sleep. Go to {103}."
},
{ // 44/6G
"As your hand falls upon the pendant, the room seems to darken. You hear a whispered voice in your ear, \"You are mine!\" Your body becomes that of a beautiful witch. Around your neck you place the crystal pendant. You will now spend the rest of your days directing your goblins to set traps for unwary fools. Go to {103}."
},
{ // 45/7A
"Your hands are tied behind your back as you are marched off along a small path through the forest. The leader cautions you to be silent or he will lop off your head. After a time, you come to a small cleared area with a few wooden buildings in it. The entire place is surrounded by huge oak trees. You can see several more elves and a number of enormous timber wolves. The wolves seem to have the run of the place. If you are an elf, go to {165}. If you are a dwarf, go to {143}. If you are anything else, go to {85}."
},
{ // 46/7B
"In the darkness, you wander on. A cold breeze begins to blow, making your already wet clothes that much more unbearable. Your teeth begin to chatter and your limbs shake. [Roll one die. This is the number of turns that you must go with a -5 to CON and ST. ]As you move along, you see a path on your left. There are several patches of glowing fog on it. If you would like to investigate, go to {172}. If you would rather keep on the way you are going, go to {128}."
},
{ // 47/7C
"The mists shrivel and flow away from you as you leave. You slowly make your way back to the main road unhindered. At your back, the mist seems to gather itself together. It wavers to and fro as if to say goodbye. Go to {128}."
},
{ // 48/7D
"The putrid decaying creatures lie at your feet. The forest all around is still and hushed after the cries of combat. The pathetic little village seems somehow oppressive now. If you wish to enter and ransack the huts, go to {219}. If you would like to continue along this path, go to {145}. If you would prefer to move back to the main road, go to {53}."
},
{ // 49/7E (reachable only via Magic Matrix)
"You were warned that magic can be unreliable here. You have just turned yourself into an alley cat. This is a permanent change, though you still retain your IQ and CHR ratings. Why don't you become a familiar for someone? Go to {103}."
},
{ // 50/8A
"The wolves march you before an old elf. After hearing your tale, he nods for a moment and then remarks, \"You have killed my elven warriors and trespassed in my woods. Still, I am a fair elf. You may earn your freedom in the arena, or you may be my slave.\" Go to {123} if you choose the arena or {109} if you prefer slavery."
},
{ // 51/8B
"Make a saving roll on IQ. If you make your roll, go to {84}. If you miss the roll, go to {122}."
},
{ // 52/8C
"You know that it would be foolish to continue now. With a hearty sigh, you douse your light and set up camp. The cold wind seems to bring a mocking laughter to your tired ears. In the cold, grey light of dawn, you begin anew your quest. Go to {231}."
},
{ // 53/8D
"As you make your way to the main road, make a saving roll on DEX. If you are nimble (and lucky), go to {213}. If you are a klutz, go to {233}."
},
{ // 54/8E
"By breathing slowly and shallowly, you are able to outlast the storm. You stand and shake yourself off. Your quarry is long gone. Once again, you must begin the process of tracking them. Go to {273}."
},
{ // 55/8F
"You face the great dragon Azoth! His flowing silver scales reflect the light with a fierce intensity. He has an MR of 48! Be careful, for he also breathes fire, and you must make a saving roll on DEX every round. If you should miss your saving roll, you take one die worth of damage (in addition to any other damage you take). If you defeat the great beast, go to {135}. If you are crisped instead, go to {103}."
},
{ // 56/8G
"Make a saving roll on both DEX and ST. If you make both, go to {32}. If you fail either, go to {317}."
},
{ // 57/8H
"You've been heard! Something screams an unintelligible command and a strange breeze begins to blow. In moments, it's a howling fury. The stinging sand comes like hot needles burning into your flesh. You find yourself held at bay by the power of this gale. It rips and rends all exposed flesh. Throw five dice; this is the number of hits that you take from the lashing sand. If this is your death, go to {103}. If by some miracle you survive, you are battered into unconsciousness; go to {27}."
},
{ // 58/8J (there is no 8I)
"Ahnit warns you that casting any kind of spell here could close up the passage. He says that he can act as an 8 dice weapon[, but he can only be used that way once]. If you decide to listen to Ahnit, go to {285}. If you wish to ignore the torch's advice and cast a spell, go to {174}. If you just want to wait, go to {243}."
},
{ // 59/8K
"Your heart didn't give out on you. The misty image seems to speak inside your head, \"Not bad, but I'm not through with you yet, fool!\" With that, the image fades and a slight trembling begins under your feet. Go to {175}."
},
{ // 60/8L
"The carnage lies all about you. All lie dead at your feet. Girdling each insect is a tiny gold chain worth ½ gold piece each. If you wish, you may pluck them from their slain hosts. You are now free to continue on your way; go to {42}."
},
{ // 61/8M (reachable only via Magic Matrix)
"You find yourself falling into a deep hole, forever! Remember, magic doesn't always follow the rules here! Go to {103}."
},
{ // 62/8N
"Hidden in the rushes, you find a small boat made of woven reeds. If you would like to board this fragile craft and cross the river using a pole, go to {156}. If you'd rather not risk it, go to {84} and choose again."
},
{ // 63/9A
"The old man ushers you in. He closes and bolts the door. With a broad smile, he tells you that his name is Aza-zel and that he is a 12th level mage who has elected to live in the land of dreams. Make a saving roll on CHR. If your sparkling personality wins out, go to {188}. If you are in need of charm school, go to {159}."
},
{ // 64/9B
"Congratulations! These wonderful folk have invited you to dinner. You're the main course! These orcs have no use for a prisoner. Go to {103}."
},
{ // 65/9C
"As she dies, she changes back into a woman. The crystal pendant shatters as she falls. The only other thing of value here is a healing potion that will restore your CON to normal. Go to {148} to continue on."
},
{ // 66/9D
"At your first touch, the column bursts apart. Before you stands a large scaly beast, half snake and half gorilla. It is attacking! It has an MR of 40. If you defeat the terror, go to {8}. If you are undone, go to {103}."
},
{ // 67/9E
"The path winds about, twisting to avoid certain large rocks and trees. As you continue, you notice that the path itself seems to be changing colour. What was an ordinary dirt path is giving way to a dark red loam. You are suddenly brought up short by a huge stone mountain. It seems to have appeared from nowhere. Cut into the mountain are the words: \"Believe if you dare!\" Below the inscription is a balancing rock, obviously being used for a door. If you would like to push on through, go to {216}. If you want to turn back, go to {128}. If you would like to cast a spell, do so now."
},
{ // 68/10A
"The demonic cross of flame giant and fire elemental seems to quiver with anticipation. It bellows, \"Come, fool, test my power!\" The skeletons behind you can't cross the bridge (moving water bars them), but they wait should you choose to turn and run. The immense pyre has an MR of 47! Should you reave it into embers, go to {105}. If your bones feed the flame, go to {103}."
},
{ // 69/10B
"As you enter the building, you are momentarily blinded as several small bats rush into you in their scurry to escape. The fog is thick and glowing in here. Silently, five figures move from the shadows towards you. They are living skeletons. Each is armed with a long curved sword. Each has an MR of 8. One moves to block the entrance as the others form a horseshoe in front of you. You must fight to survive! If you defeat them, go to {210}. If they pull the life from your body, go to {103}."
},
{ // 70/10C
"You come upon a trail a bit further up. It is here that you find a stone with runes carved into its surface. In Common, it says, \"The door beneath the stone holds only the past.\" If you wish to turn the stone over, go to {181}. If you would prefer to ignore it, go to {51}."
},
{ // 71/10D
"In the inky darkness, your light illuminates you to all manner of beast! Roll on the Wandering Monster Table and either fight or flee. If you win or successfully elude the creature, go to {276}. If you are defeated, go to {103}."
},
{ // 72/10E
"You reach the boulder just as three huge Hobgoblins step from around the bend. Oddly enough, they are armoured with the livery of the naked skull. In their hands, each carries a broadsword lengthened to their size. No simple brutes these, but rather trained fighting machines. You may attack and perhaps surprise them (go to {125}), or you may wait and hope that they miss you (go to {195}). If you feel real lucky, you may try to reason with them by going to {39}."
},
{ // 73/10F
"Throw one die, for this is the number of winged Shacaths you must face. They each have an MR of 10. These horrors are some combination of giant bat, scorpion, and serpent. [Both the bite and the stinger are poisoned, so if you lose even one combat round, you will be overcome and killed, unless you are immune to poison. ]If you destroy the monsters, go to {170}. If they end your adventuring days, go to {103}."
},
{ // 74/10G
"The spider may be a deadly enemy, but it is still rather stupid. It is nothing for you to convince it to let you pass through unharmed. With a nod and a smile, go to {256}."
},
{ // 75/10H
"As you continue down the passage, you notice a viscous red fluid apparently seeping through the walls. You also notice that it is becoming increasingly warm. Make a saving roll on IQ. If you make the roll, go to {242}. If you miss the roll, go to {191}."
},
{ // 76/10J (there is no 10I)
"The swarm begins to make strange formations. Make a saving roll on IQ. If you are lucky and make the roll, go to {234}. If not, go to {249}."
},
{ // 77/10K
"Your path is now clear; the horny crustaceans are dead. If you wish to go across the stones in the river now, go to {156}. If you'd rather search along the shore for another route, go to {115}."
},
{ // 78/10L
"They tell you that the elves were their friends and that they are bound to defend what little honour they still retain. They do offer to take you to the elven chief so that your case may be tried. Your only other choice is to do battle with these shaggy horrors. If you will fight, go to {295} and choose your course. If you allow yourself to be marched deeper into the woods, go to {50}."
},
{ // 79/11A
"In utter exhaustion, you stumble and fall. Your hands strike a hard surface. Beneath a thin layer of sand, you find the shiny black material of the road. You have again found a proper trail. Weariness claims you as you curl tight against the cold and fall fast asleep. The sound of rock cracking under the heat of a new day wakes you. With a yawn, you set out in search of the light from last night. Go to {231}."
},
{ // 80/11B
"The old wizard insists that you stay and refuses to unbolt the door. If you relent and decide to accept the old man's hospitality, go to {232}. If you wish instead to attack Aza-zel, heave to and go to {299}."
},
{ // 81/11C
"The old elf cuts you off in mid-story. \"I care not for your lies! You have compounded your crime by trying to pass off such outrages! For such insolence, you must face death!\" With that, he orders you dragged to the \"pit\". Go to {123}."
},
{ // 82/11D
"You fall, scraping painfully against the sides of the huge hole. Shortly, you hit the sandy bottom. You take 3 dice worth of damage for the fall (regardless of armour). If you still survive, go to {20}. If you are undone, go to {103}."
},
{ // 83/11E
"The mist clings to you. With an unusual strength, it seems to pull you back. Make a saving roll on ST. If you make your roll, go to {106}. If your Strength isn't equal to the task, go to {245}."
},
{ // 84/11F
"Your trail finally ends at a fast-flowing river. You can see no immediate means of safely crossing. However, directly in front of you and floating 6' above the river is a stone. Could it be some kind of invisible bridge? If you would like to try crossing an unseen structure, go to {207}. If you'd rather search for a more conventional way across, go to {192}."
},
{ // 85/12A
"You are brought before the head of the clan, an old elf with grey hair. He is dressed in black with grey/green trim. On his chest is a crystal bauble fashioned in the shape of a skull. He looks you up and down. Finally, he speaks, \"You have been caught trespassing in our woods. This is a most grievous crime. As sentence, you may choose to serve us as a thrall for ten years time, or fight to earn your freedom!\"\n" \
"  If you choose ten years slavery, go to {109}. If you would rather fight to win free, go to {123}."
},
{ // 86/12B
"Pushing through the dense trees, you hear a strange grunting noise coming from above you. Looking up, you see a pale green giant with leaf-like hair. Make a saving roll on LK. If you are successful, go to {30}. If you fail the roll, go to {149}."
},
{ // 87/12C
"Make a saving roll on IQ. If you make your roll, go to {26}. If you miss the saving roll, go to {64}."
},
{ // 88/12D
"The gory remains are strewn about. In the battle, several of the mushrooms were toppled. Under some are a small number of shiny gold nuggets. Roll one die times 10. This is the number that you find. Now go to {224}."
},
{ // 89/12E
"The spines waver in your hand. Dropping them, you see that they are changing form. In the blink of an eye, they are full grown replicas of the original beast. This time, there is no room to run. Each beast has an MR of 50. If you can defeat them all, go to {51}. If they undo you, go to {103}."
},
{ // 90/12F
"At the far edge of the field, you come upon an obelisk. It stands 13' tall and has runes carved on its surface in all known languages. It reads, \"The river is death, the way across by stones.\" With this cryptic message in mind, go to {239}."
},
{ // 91/12G
"While talking to them, you discover that they are in the service of Ballaha, Dark Lord of Iron Cantahf. They tell you that they are not permitted to let anyone through the pass who is not in Ballaha's service. If you choose to battle them, go to {125}. If you'd rather find another way around, go to {203}."
},
{ // 92/12H
"As you start to enter the first hut, a noise behind you attracts your attention. The noise of your battle has drawn some new denizen of this hellish wood. Roll on the Wandering Monster Table to see what it is you must now face. If you negate your foe, go to {307}. If it destroys you, go to {103}. If you run, go to {147}. If you can elude the beast, go to {213} and ignore the first sentence."
},
{ // 93/13A
"Moving along, you suddenly blunder into something cool and sticky. As you twist to pull away, you find yourself becoming more and more enmeshed. With a slow, sickening realization, you know that you are caught in an enormous spiderweb! Above you sits a spider with large glowing red eyes. Its body is nearly 5' in diameter, and its mandibles drip a thick green poison. Make a saving roll on ST. If you are lucky and make the roll, go to {139}. If not, go to {316}."
},
{ // 94/13B (reachable only via Magic Matrix)
"Great! You've just given yourself a permanent case of \"double vision\". Take 5 off your DEX! Now, go back to the paragraph that sent you here and choose again."
},
{ // 95/13C
"With a truly monumental effort, you leap clear. It is nothing to cut down the Wraith in its weakened state. You face the one remaining Dark Wraith. It has a ST of 100 and a CON of 30. It will fight to the death using an MR of 44. If you manage to defeat it, go to {170}. If you are destroyed, go to {103}."
},
{ // 96/13D
"Make a saving roll on LK. If you make it, go to {58}. If not, go to {174}."
},
{ // 97/13E
"Your rudeness has offended the old man. He is a 12th level wizard. With a cry of anger, he hits you with a spell. You now have an ugly case of yellow boils. Take 5 off your CHR. Go to {146}."
},
{ // 98/13F
"You and the host of warriors advance along the path until you come to a tiny castle. Miniature archers line the walls all along the castle ramparts. If you would like to chicken out now, go to {253}. If you are more determined, go to {262}."
},
{ // 99/13G
"As you turn to flee, the mist seems to gather itself together before you. It swirls and twists, gathering itself into a giant tower of mist. The tower wavers momentarily before taking on the semblance of a 40' ghost! This thing can only be destroyed by magic or a magical weapon. If you decide to fight, it has an MR of 30. If you fight, go to {300}. If you have no enchantments to use, you can run by going to {29} (this thing can always be outrun, as it is bound to this place)."
},
{ // 100/13H
"You willingly give yourself up to the beauty of the visions that the mischievous nymph is showing you. The world of tree and plant seems to close in all around you as you blissfully pass out of the realm of the animal. Go to {103}."
},
{ // 101/13J (there is no 13I)
"They move into a large, dimly lit cavern where a woman is lying languidly upon a silken couch. She barks a harsh command in a grating language unknown to you, and the goblins begin to approach you once more. You may bravely jump out and attack if you like by going to {260}. Or you may try to run by going to {275}. There is nowhere for you to hide here."
},
{ // 102/15A
"You are able to pick the lock! The pages seem to swim before your eyes. This is an eleventh level spellbook written in the \"High Arcane\" language. You will need a Wizard Speech spell in order to understand it. If you can understand the book, you will now have available to you all of the spells from levels one to eleven (all restrictions still apply to this adventure). If you are not a magic user, the book is worth 50,000 gold pieces. While still holding the book, the air shimmers in front of your eyes. A tall, well-built man with a fleshless skull for a head appears before you. He is dressed in solid black with gold trim. His eye sockets seem to hold glowing red coals that stare right through you. At once, you know that this is Ballaha, Dark Lord of Iron Cantahf. Make a saving roll on CON. If you make it, go to {301}. If not, go to {132}."
},
{ // 103/15B
"This character is done for. The things of nightmare which lay Beyond the Wall of Tears are often best left alone. Fear not, you can always try again with a new character (if you dare)."
},
{ // 104/15C
"What fantastic luck! The shock of the spell doesn't immediately kill you. A strange new power seems to infuse your limbs. Add 5 to your Strength. Through the trees, you spy a small log cabin and a slight wisp of smoke curling from a crude stone chimney. If you wish to seek out its owner for news of your lost sister, go to {319}. If you'd rather just continue on in possible ignorance, go to {146}."
},
{ // 105/15D
"As the flame flickers out, you find an enormous fire opal in the glazed sand where it stood. Its value is 1000 gold pieces. You look ahead of you and see a vast expanse of shimmering sand. This is the Sparkling Desert which runs right into the base of the mountain range, Shaitans Teeth. Night is rapidly approaching, and the day's battle weighs heavily upon you. You *must* rest or further exertion will kill you. Set your camp and go to {292}."
},
{ // 106/15E
"As you tear yourself from the grasp of the mist, you hear a strange wailing noise. Looking back, you see the mist form itself into hundreds of separate ghosts. They seem to be pleading with you. If you must investigate, go to {34}. If you would rather ignore them and continue on, go to {128}."
},
{ // 107/15F
"Intuitively, you know that you must dig yourself into the sand. You make a shallow depression and, throwing a cover over your back, lie face down. The storm increases to hurricane force, covering you with a thick layer of sand. Make a saving roll on CON. If you make the roll, go to {54}. If you fail the throw, go to {308}."
},
{ // 108/15G
"You cross without incident. As you reach the other side, you find yourself in a vast expanse of sparkling desert. It seems to stretch forever in all directions (except behind you). At the extreme edge of your vision, you think you see some mountains. They lie directly ahead of you. If you want to head for this somewhat dubious landmark, go to {161}. If you'd rather move along the shore, go to {142}."
},
{ // 109/15H
"You are a slave now for the next ten years. Start keeping track. Put this character in a nice safe place until his ten years are up, and then you can start it all over again. At least you are alive! Close the book, and start cleaning up the wolf droppings."
},
{ // 110/15J (there is no 15I)
"In agony and blinded, you fall. In an instant, the enemy is all over you. They cut and stab at all unprotected flesh. Mercifully, you pass into a deep unconsciousness long before they end your life. Go to {103}."
},
{ // 111/15K
"As you begin the complicated process of \"tailing\" on an open and rocky path, make a saving roll on LK *and* DEX. If you make both rolls, go to {19}. If you fail either, go to {310}."
},
{ // 112/16A
"They outdistance you rapidly. In a short time, they are at the drawbridge which spans of the lake of boiling blood and crosses over into Iron Cantahf. You are still trying to keep up with them as the bridge is raised. You have lost! Your sister is now and forever at the mercy of hated Ballaha! You wake out of your dream state to find Alhim Dandin slowly shaking his head, a definite air of despair hangs about him. You may recover any treasures you found, but how can you enjoy them, knowing the fate of your little sister? Close this book now, for this character could never stand the shock of another draught to take him Beyond the Wall of Tears!"
},
{ // 113/16B
"Make a saving roll on IQ. If your luck is still holding, go to {280}. If you've run out of luck, go to {23}."
},
{ // 114/16C
"As you sip from the deceptively calm lake, you feel a searing agony in your lips and mouth. There is liquid fire in your throat as you fall to the ground. Acid! The lake was pure acid, and the gold deer was unaffected. Pity you were not. Go to {103}."
},
{ // 115/16D
"Shortly, you spy a bridge a little ahead of you. Snaking from each side of the bridge is the \"Black Road\". If you would like to cross the bridge, go to {259}. If you'd rather risk the stones, go to {156}."
},
{ // 116/16E
"Just as you reach for one of the gems, you notice it move. If you still want to pick them up, go to {43}. If you have changed your mind and would like to move on, go to {90}."
},
{ // 117/16F
"As you hack or crisp your way out, you see the awful host of this shimmering world. An enormous spider spits and curses you, but fains not to come closer. With a sneer, you turn to the now open road. Go to {256}."
},
{ // 118/16G
"The road is rough and uneven. As you walk in the darkness, you stumble and scrape often. The noise can easily be heard for some distance. If you wish not to chance the darkness, you may camp by going to {204}. If you prefer the anonymity of the night, go to {274}."
},
{ // 119/16H
"With all of your might, you pull yourself free of the slimy black evil. It seems to flow slowly toward you. You may either stay to fight or take your chances going into the forest to go around it. If you decide to fight, it has an MR of 30. [If you take hits for 3 consecutive rounds, you are engulfed and must make a saving roll on DEX and ST to break free. If you miss either roll, you are killed; go to {103}. ]If you defeat the fiend, go to {136}. If it defeats you, go to {103}. If you decide to go around, go to {289}."
},
{ // 120/16J (there is no 16I)
"As you creep along, you hear strange voices ahead of you. You stop for a moment to assess the situation and in the gloom can see several pairs of softly glowing green/yellow eyes. Goblins! Twenty eyes means ten of the monsters. If you would like to leap out and attack them, go to {260}. If you would rather wait and see if they pass by, go to {164}."
},
{ // 121/16K
"As you grasp the torch, the statue disappears. A tiny voice seems to whisper in your head, \"My name is Ahnit and I can lead you to freedom!\" With a rumble, the hole above you draws closed. A section of wall seems to swirl into a thin mist through which a tunnel opens. With a strange new ally in hand, go to {217}."
},
{ // 122/16L
"You travel for days. The weather seems to be growing colder the further. Eventually, the trees give way to a low, barren hill country. Soon, snow begins to fall and you find that you are on frozen tundra. You have blundered onto a false trail! You are hopelessly lost! Snowblinded, you stumble into an open fissure. Here you will stay frozen in a dreamless sleep forever. Go to {103}."
},
{ // 123/17A
"You are led to small, natural amphitheatre located a short distance from the main encampment. You are placed with weapon in hand at one end of the sandy arena. The crowd gathered in the roughly hewn seats around you goes silent as your opponent is led onto the small battleground. A new nightmare stands before you. 20' tall with six arms and the head of a wolf, it holds three thick-bladed swords in its claw-like hands. It has a CON of 50 yet fights with an MR of 45 (the MR will not go down as you wound the creature). There is no place to run as archers have been stationed around all of the entrances. If victory chimes for you this day, go to {18}. If you are crushed, go to {103}."
},
{ // 124/17B
"As you leap the wall, a high-pitched whistle issues from the tiny castle. In seconds, the miniature ramparts are crowded with palm-high people. Each is armed with a small bow. If you are feeling a bit rangy and wish to attack the diminutive citadel, go to {262}. If you would like to hail them from where you are, go to {31}. If you'd rather just leave, go to {253}."
},
{ // 125/17C
"[You get a +10 to all of your attacks (caught them off guard, didn't you?). ]They each have an MR of 10 and armour that can take 5 hits. If you are victorious, go to {130}. If not, go to {103}."
},
{ // 126/17D
"She stares at you with those cool, green eyes. Her mouth forms a perfect little \"O\" as her gaze clouds with surprise and fear. Make a first level saving roll on Charisma (20 - CHR). If you are lucky this day, go to {154}. If your luck falls below par, go to {40}."
},
{ // 127/17E
"The elves have an MR of 4 each and they attack as a group of 10. They have no armour as they are dressed in black to blend in with these dreary woods. If you are victorious over the elves, go to {295}. If you become a pincushion, go to {103}."
},
{ // 128/17F
"As you continue, a light rain begins to fall. After a short time, you come to a large dip in the road. At the bottom of the dip, a large black pool extends across the entire width of your path. The surface dimples slightly as the cool droplets of water strike it. If you want to wade through the pool, go to {309}. If you wish to enter the forest to avoid the foul-looking liquid, go to {289}. If you want to cast a spell, do so and check the Magic Matrix."
},
{ // 129/17G
"As you leap to the attack, you notice that your intended victim is a \"Dark Wraith\". It seems to ripple for an instant and you fall right through it. The Wraith raises both hands and lets out an inhuman shriek! You hurriedly try to silence this black spectre to no avail. Go to {57}."
},
{ // 130/18A
"As the last one drops, they begin to turn into a thin mist. The mist slowly forms itself into the shape of a grinning skull. Ballaha, Lord of Iron Cantahf! Make a saving roll on CON. If you make the roll, go to {59}. If not, go to {221}."
},
{ // 131/18B
"The path becomes an open meadow filled with mushrooms. The mushrooms are oddly shaped and are nearly as tall as you. As you continue to move through the field, you hear a voice. While turning to look for the source, you hear another voice, and then another. Shortly, the whole meadow is filled with low voices. It is now that you realize that the mushrooms are talking! If you would try to try conversing with the fungi, go to {271}. If you'd rather keep right on walking, go to {224}."
},
{ // 132/18C
"The shock of the vision is too much for you! As you clutch at your chest, you hear echoing laughter. You are amusement for Ballaha. You fall to the ground while the fleshless skull seems to leer at you. In your last seconds, you breathe the name of your beloved sister. Ballaha laughs again and whispers, \"Mine, little bug, mine!\" Go to {103}."
},
{ // 133/18D
"As the bloodthirsty animals die raging, they change form. They become sharp-faced humans. You have dealt death blows to werewolves! I[f you have been unfortunate enough to take *any* hits from these hellish beasts, go to {315}. If not, i]t is about time that you took your leave of this forsaken spot; go to {13} and choose again."
},
{ // 134/18E
"You try to push through the blinding storm. Sand rips your body as the storm grows in strength. Stabbing knives of agony drive you to your knees. The sand races over you like a hot knife through butter. Your senses reel as you slip into oblivion. You never quite know when the end comes as your heart pumps your warm blood into the parched sand. After the storm, your bones gleam whitely in the bright sunlight. Go to {103}."
},
{ // 135/18F
"Your path is now clear. Roll eleven times on the Treasure Generator (no magic weapons or other items!) for your haul. If you like, you may also pry free a scale from the dead dragon to use as a shield (good for 9 hits). You move from the tunnel onto a steep mountain trail. Below you is a dark and forbidding valley. Go to {163}."
},
{ // 136/18G
"Night is near full upon you. You have travelled far enough from the \"Black Mire\" to feel a small measure of security. If you wish to camp for the night, go to {314}. If you would like to make a light and continue on, go to {71}. If you'd rather travel in darkness, go to {167}."
},
{ // 137/19A
"Throw one die. This is the number that you pluck. Taking these most unusual spines, go to {89}."
},
{ // 138/19B
"You run headlong into a group of goblins! Behind you, even more of them appear. You now find yourself surrounded by a mob of ten goblins! They demand that you surrender to them. If you comply, go to {180}. If instead you decide to fight them, go to {260}."
},
{ // 139/19C
"In a frantic burst of energy, you rip free of the clinging strands. If you wish to fight through this spun corridor of death, go to {117}. If you would turn back, go to {53}."
},
{ // 140/19D
"As you sip the water, you feel yourself growing sleepy. You fall into a very deep slumber. Roll one die. If you roll odd, you are attacked while you sleep; go to {186}. If you roll even, you sleep undisturbed; go to {14}."
},
{ // 141/19E
"Make a saving roll on LK. If you make your roll, go to {163}. If you miss your roll, go to {240}."
},
{ // 142/19F
"After a few steps, you are suddenly blinded by a flash of light. As your vision clears, you find yourself facing a creature that is all fire! In a crackling voice, it bellows, \"Fool, now you face your end!\" This thing has an MR of 35. You have no place to run, so fight! If you win, go to {269}. If you fall, go to {103}."
},
{ // 143/19G
"You are cast at the feet of an old elf dressed in black. Around his neck is a pendant in the shape of a grinning skull. This is the master of the woodland clan. With a sneer in his voice, he speaks, \"Foolish dwarf! You dare to trespass our land? For such arrogance you must pay!\"\n" \
"  He orders you taken to the \"pit\". Go to {123}."
},
{ // 144/19H
"You can tell that he is preparing to attack you in some manner. If you wish to try and escape his clutches, go to {97}. If you'd rather get him before he gets you, go to {299}."
},
{ // 145/19J (there is no 19I)
"As you continue along the path, it seems to broaden out. The soft dirt slowly gives way to a carefully laid flagstone trail. All around you, you can hear a soft crunching noise. If you would like to stand and try to identify the sound, go to {277}. If you would prefer to keep on walking, go to {42}."
},
{ // 146/19K
"After travelling a few hundred yards, you notice a path on your left. There are occasional patches of dense fog on it. While you are observing, a light rain begins to fall. The patches of fog remain, undisturbed by the rain. If you want to investigate, go to {172}. If you want to cast a spell, do so now. If you just want to continue on the main road, go to {128}."
},
{ // 147/19L
"Compare your Speed rating with that of your antagonist. If yours is greater by more than half, you elude your pursuer with ease (go to the next paragraph). If your Speed rating is not more than half of your foe's, you must making a saving roll on both Dexterity and Luck. If you make both, then you have eluded your pursuer (go to the next paragraph). If not, you must stand and fight[ with a -5 to your Strength for the first three combat rounds (your back was exposed)].\n" \
"  If you have escaped, you must roll a saving roll on your IQ. If you make your roll, then you have found your way back to the path that you were on and can continue (see the \"if you elude\" portion of the paragraph that sent you here). If you do not make your IQ saving roll, then you are lost. Subtract what you rolled from what you needed. This is the number of \"hits\" that must come off your CON to allow for exposure. Continue rolling until you make your IQ saving roll or perish. For every turn that you are lost, roll on the Wandering Monster Table (and fight!). If you die, go to {103}."
},
{ // 148/20A
"You move on through the tunnel. Gradually, it beings to slope upward. You come to a place where the tunnel forks. The tunnel to the right has a warm, damp feel to it. The one on the left has a distinct odour of sulphur. If you choose to go to the right, go to {75}. If you'd rather chance the one on the left, go to {294}."
},
{ // 149/20B
"Oblivious to your existence, the giant steps on you. Take 4 dice worth of damage (regardless of armour). If this kills you, go to {103}. If you manage to survive this, go to {268}."
},
{ // 150/20C
"They converse with you and, after some deliberation, ask if you will help them defeat their enemies. If you say yes, go to {98}. If you are not willing to help, they warn you to stay away from the castle ahead and wish you on your way; go to {42}."
},
{ // 151/20D
"Decide: will you continue on the small path before you or will you return to the main road? If you choose the path, go to {67}. If you choose the main road, go to {13} and choose again."
},
{ // 152/20E
"Slipping your hand into the glove, you feel an incredible rush of power. Add 5 to your ST. Go to {253}."
},
{ // 153/20F
"After a few minutes chase, the deer simply vanishes. Unfortunately you are now lost. Make a saving roll on IQ. If you make your roll, you manage to find your way back to the path; go to {84}. If you missed your roll, you must roll on the Wandering Monster Table for every turn that you are lost. Also, for every turn that you are lost, subtract the dice total of your saving roll from what you needed. This is the number of hits that must come directly off of your CON due to exposure. If you finally win free, go to {84}. If you are slain, go to {103}."
},
{ // 154/20G
"You call out to her gently. She tilts her head and smiles. As you move closer, you can see that this is indeed no mortal being, but a Dryad. Every curve of her body is revealed to you through the filmy gauze of illusion which drapes her. Her softly glowing eyes and pert smile seem to beckon you as she gently sways in the light wind. There seems to be open invitation written in her every manner. Make saving rolls on both IQ and LK. If you make both, go to {236}. If you miss either, go to {100}."
},
{ // 155/20H
"A crash and a roar awaken you. A midnight black leopard with ruby eyes lunges at you with unbridled ferocity. You have only instants to parry its charge. With the beast so close, you *must* fight. Be brave; its MR is 30. If you win, go to {128}. If the feline kills you, go to {103}."
},
{ // 156/21A
"Make a saving roll on DEX. If you make the roll, go to {108}. If you miss it, go to {15}."
},
{ // 157/21B
"Each Hobgoblin has an MR of 10. They are wearing a very high quality plate armour that can take 5 hits. Be careful; they are obviously trained in combat and their species is born to be bloodthirsty. If you *do* manage to defeat them, go to {130}. If they slay you, go to {103}."
},
{ // 158/21C
"You are unable to find another means to cross, so you return to that strange bridge. Go to {207} and make your attempt to cross."
},
{ // 159/21D
"There is an evil gleam in the old mage's eyes. You shudder as you notice several skins from various animals nailed to the walls of the cabin. Aza-zel moves from shelf to shelf gathering mystical items and herbs. Make a saving roll on IQ. If you make your roll, go to {144}. If you fail, go to {228}."
},
{ // 160/21E
"The spider will not even listen to your stupid prattle. She threatens to suck the marrow from your bones if you dare to invade her kingdom. If you fear the spider, go to {53}. If you are more courageous and wish to fight your way through, go to {117}."
},
{ // 161/21F
"Make a saving roll on LK. If you have made your roll, go to {248}. If you fail, go to {246}."
},
{ // 162/21G
"The last of the grey, bloated bodies dies. The multiple rows of teeth gnash, and the four webbed claws paw helplessly in the air. You cut great greasy steaks from their flanks and chew the raw flesh to help regain some of your expended ST. Add 5 to ST. In time, you return to the road and resume your search. Go to {273}."
},
{ // 163/21H
"You look ahead of you on the trail and see, a few hundred yards away, two dark figures with a third lighter figure between them. *Your sister!* You may rush to do battle with them - go to {311} - or you may try to ambush them by going to {111}."
},
{ // 164/21J (there is no 21I)
"If you are fortunate enough to have some form of invisibility, go to {254} (magic-users should check the Magic Matrix). If not, make a saving roll on LK. If you made the roll, go to {254}. If you missed it, go to {275}."
},
{ // 165/21K
"You are presented to the chieftain of the Dark Elves. An old elf with greying hair, he is dressed in black with grey/green trim. Around his neck is a small crystal pendant in the shape of a skull. His eyes seem to pierce you as he speaks, \"What are you doing in our forest, fair one?\"\n" \
"  Make a saving roll on IQ. If you make your roll, go to {173}. If not, go to {81}."
},
{ // 166/21L
"The road winds and twists. Ahead, you can just barely make out a group of thatched roofs. The odour of cooking meat wafts by and you can hear muted voices coming from ahead of you. If you would like to approach, go to {282}. If you want to go back the way you came, go to {53}. If you would like to cast a spell, do so now and check the Magic Matrix in the back of the book."
},
{ // 167/21M
"In the near impenetrable dark, you stumble and fall. Deduct one die worth of points from your CON. You suddenly become aware that all sound has ceased. Your flesh breaks out in goosebumps as you feel a definite evil presence somewhere near. Looking skyward, you see a large dark form moving high above you, its outline standing black against the grey clouds. If you choose to stand and watch, make a saving roll on LK. If you make the roll, go to {284}. If not, go to {258}. If you choose to run into the forest or continue down the road, go to {258}."
},
{ // 168/22A
"At your first stroke or spell, it divides to allow the blow to pass through. Now it is mad! You are completely engulfed as millions of microscopic stingers pierce all exposed flesh. Burning poison rushes through your bloodstream. Take 5 dice worth of damage. If you still live, go to {292}. If not, go to {103}."
},
{ // 169/22B (reachable only via Magic Matrix)
"The mountain shimmers and vanishes. In its place is a large pit. If you would like to turn back, go to {128}. If you want to try and leap the gap, make a saving roll on DEX and ST. If you make both rolls, go to {190}. If you miss either, go to {82}."
},
{ // 170/22C
"You've done it! After all you've been through, you've rescued your little sister. Fear not, for the counter-spell to take you from this nightmare world has already begun. Nothing can stop you from returning now. Your stunning attributes have saved you both. Go to {220}."
},
{ // 171/22D
"A wave of nausea washes over you, and then before your eyes is a vision of your lost sister. You are unable to hear what is being said, but you are able to see for some distance around her. All of her captors are hidden in shadows, but they seem to be camped in some kind of shimmering desert near the foot of a great mountain range! You know that you must hurry now, for those are the mountains of \"Deeper Fear\" and once over them, they are very near the iron city of Cantahf where all hope is lost! You shiver awake and thank the old mage. He warns you that the road is well watched and to be very careful, for its dangers are not always easy to tell. With these thoughts in mind, go to the road and {146}."
},
{ // 172/22E
"The moment you step onto the path, you feel a highly magical presence. If you would cast a spell, do so now. If you wish to explore further, go to {34}. If you'd rather go back the way you came, go to {83}."
},
{ // 173/22F
"He listens to your tale and nods his head slowly. \"You are one of the blood,\" he starts, \"but your crime still stands. I offer you a choice. You may stay with us here and choose a mate from among my people, or you may do battle and earn your freedom.\"" \
"  If you are weary of your adventure and choose to retire here with the elves, close the book[ and remember that the next character will have to face 11 elven warriors]. If you choose to fight, go to {123}."
},
{ // 174/22G
"The creature vanishes at the first utterance of the spell, but so does the passage. Ahnit disappears. You are now encased in solid rock. There is no escape. You are entombed forever. Go to {103}."
},
{ // 175/22H
"Above you an avalanche has begun. It is upon you before you could move. Throw three dice; this is the number of hits that you have taken (less any armour). If you survive, go to {163}. If the avalanche finished you, go to {103}."
},
{ // 176/22J (there is no 22I)
"They do not believe you have any good intentions and with a cry, they set their little \"pets\" on you. Go to {200}."
},
{ // 177/22K
"You stiffen as the full shock of the spell grips you in its embrace. Slowly, painfully, you feel your body growing heavier. You are totally unable to move. The magic of the stream has turned you to stone. Go to {103}."
},
{ // 178/22L
"Make a saving roll on IQ. If you make the roll, go to {74}. If not, go to {160}."
},
{ // 179/22M
"As the living pincushion expires, you notice that some of the \"quills\" on the head are made of some kind of gem. If you wish to take them, go to {137}. If you are leery and wish to keep on walking, go to {51}."
},
{ // 180/23A
"They catch you and bind your arms and legs. Laughing, they drag you along the cavern floor, kicking and biting you as they go. Deeper into the earth they run. Finally, they bring you into a chamber that is dimly lit by smouldering torches. In the centre of this cave is a beautiful woman reclining on a silken couch. Around her ivory white neck is a smooth silk chain on which hangs a crystal pendant of a skull. She beckons you to come closer. The goblins toss you at her and she catches you in a grip of iron. She throws back her head and laughs, revealing tiny, needle-sharp teeth. She bites deeply into your throat and, instead of sucking out your blood, seems to inject you with a hot venom. Instantly, you begin to change. You acquire strange tastes and thoughts as you become a goblin! Go to {103}." \
},
{ // 181/23B
"As you move the stone and lift the thin metal door beneath it, you seem to be looking down at a huge figure of a person sleeping. You feel very dizzy. Suddenly it dawns on you that you are looking at your own sleeping form. Moments later, you wake up. Go to {227}."
},
{ // 182/23C
"Make a saving roll on LK. If you make it, the night passes without an incident, and you may continue on your way (go to {146}). If you miss your saving roll, roll on the Wandering Monster Table. If you defeat the beast, go to {146}. If you run, go to {147}. If you manage to elude your foe, go to {146}. If you are undone, go to {103}."
},
{ // 183/23D
"As you begin to circle around the small dune, you hear someone approach. You press yourself flat in the sand. The sound stops, and you can see a dark silhouette against the grey/black sky. If you wish to attack this lone creature, go to {129}. If you prefer to wait for a time of your own choosing, go to {41}."
},
{ // 184/23E
"He falls to his knees and offers you his greatest treasure if you will but spare his life. So saying, he pulls a large blue jewel from a pocket of his robe. It is faceted and seems to glow with an inner radiance of its own. If you accept his offer, go to {222}. If you decide to butcher him instead, go to {278}."
},
{ // 185/24A
"As you continue on, you notice the forest becoming less dense and tangled. You seem to hear a small, lilting voice raised in laughter and song. Your path widens out into a small clearing with a huge, old oak tree at its centre. There, dancing about the tree, is a beautiful young woman. Her hair is the colour of autumn leaves, her eyes a deep, cool green, and her skin a soft gold/brown. If you wish to approach this vision, go to {126}. If you'd rather leave her to her merriment, go to {13} and choose again."
},
{ // 186/24B
"Make a saving roll on Luck. If you make your roll, go to {155}. If you are unlucky and miss the roll, go to {241}."
},
{ // 187/24C
"Make a saving roll on IQ. If you make it, you get bad vibes about the crystal skull; go to {148}. If you miss it, go to {44}."
},
{ // 188/24D
"Aza-zel seems to like you. He is starved for conversation, and you impress him as the likable type. He invites you to share a meal with him. The inside of the cabin is warm and dimly lit. It is furnished sparsely, and there are several \"hides\" from different creatures hanging on every wall. If you accept the humble hospitality of the old wizard, go to {232}. If you wish to politely decline and be on your way, go to {80}."
},
{ // 189/24E
"Halfway to the boulder, three large hobgoblins come around the corner. With a cry, they attack (after all, you were running toward them). Each is armed with a large broadsword and has an MR of 10. They are armoured in plate that will absorb 5 hits. If you can overcome them, go to {130}. If it is your blood that wets the field this day, go to {103}."
},
{ // 190/24F
"Moving on, you soon come to a place where the path broadens out into a grass-filled meadow. The field appears to be littered with gems of various colours and sizes. If you would like to pick some of them up, go to {28}. If you wish to continue on and leave them where they lie, go to {90}. If you would like to cast a spell, go to the Magic Matrix."
},
{ // 191/24G
"The passage finally opens into a wide chasm. Below you, you can hear the sounds of a swiftly flowing river. The heat in the tunnel is nearly unbearable. If you wish to dive into the dark river, go to {297}. If you'd rather turn back, go to {294}."
},
{ // 192/24H
"Make a saving roll on LK. If you make the roll, go to {62}. If not, go to {158}."
},
{ // 193/25A
"It is daylight now, and the road still has that shiny black sheen to it. After several hours of walking, you see a side road on your right. There is a bit of cloth on a bush near it. Could it be from your sister's cloak? If you wish to investigate, go to {166}. If you would feel more confident on the main road, go to {53}."
},
{ // 194/25B
"The giant walks for a short time, taking huge steps over trees and hills. Finally, he halts and slowly kneels. Looking to your right and left, you see a vast ribbon of blue. A river! The giant stretches and sets you down on the far bank. With a wave, the giant strides into the forest and is soon lost to sight. Before you is an expanse of shiny sand, a large desert. In the distance, you can see a mountain range. If you would like to set out for those far mounds, go to {223}. If you would like to move along the bank of the river, go to {142}."
},
{ // 195/25C
"While trying to make yourself look like a rock, make a saving roll on LK. If you make your roll, go to {22}. If you're not the stony type, go to {218}."
},
{ // 196/25D
"After taking you deep into the woods, the elves suddenly desert you (the scum!). Make a saving roll on IQ. If you make your roll, go to {67}. If you miss your roll, go to {122}."
},
{ // 197/25E
"With the tunnel clear, Ahnit whispers for you to continue. After a time, you come to a section of tunnel with a door in one of its walls. The door is just man-height and seems to be made of brass. There is no keyhole, and Ahnit is curiously silent. If you would like to open the door, go to {24}. If you would rather keep on walking, go to {263}."
},
{ // 198/25F
"Make a saving roll on LK and DEX. If you make both, you have achieved the shelter of the mountains and eluded your pursuers. Go to {170}. If you miss either roll, go to {73}."
},
{ // 199/25G
"Due to the wet nature of everything you are wearing (and own), you must make a saving roll on both DEX and LK to light a torch or lantern. Of course magic should be unaffected. If you wish to cast a spell, go ahead and then check the Magic Matrix. If you are able to make a light, go to {281}. If you fail at the attempt, go to {46}."
},
{ // 200/25H
"Roll four dice. This is the number of the little buggers that you face. Each has an MR of 2 (plus your multiplier). If you overcome them, go to {60}. If they feast on you, go to {103}."
},
{ // 201/25J (there is no 25I)
"You must take two points off your CON to allow for the effects of the heat. A little ways ahead on your left, you see a small road branching off the main road. Along this branch, you can see occasional patches of dense fog. Most unusual for this time of day! If you would explore this snaking path, go to {172}. If you prefer to stay on the Black Road, go to {128}."
},
{ // 202/25K
"The gruesome horror lies dead at your feet. In a puff of greasy black smoke, the rider vanishes. Almost immediately, the Shacath begins to decay into a mass of putrid ashes. Among the ashes, you spy several black gems. If you wish to gather them up, go to {287}. If you prefer to leave the remains of this vile thing untouched, go to {13}."
},
{ // 203/25L
"You travel for hours along the \"Dark Path\". It takes you through the foothills and leads you to a large cave. The little way that you can see into the cave appears to be smooth rock. There are no sounds that you can detect coming from the hole. If you choose to enter and wish to have a light, make a saving roll on DEX. If you make it, go to {4}. If you fail or do not wish to advertise your presence, go to {215}. If you would prefer to leave the area entirely, go to {273} and take the other road."
},
{ // 204/26A
"You have camped within easy sight of the road. The forest is alive with the night sounds around you. There seems to be a noticeable tension in the very air. Roll one die. If you are fortunate and roll even, the night passes without an incident; go to {193}. If, on the other hand, you roll odd, you are attacked out of the darkness. Go to {318}."
},
{ // 205/26B
"You rush from the temple an instant before it collapses. In your hands, you still hold your treasures. As the dust settles, you can see that all of the buildings have also turned to dust. Neither stick nor stone remains standing. The mist has vanished as though it was created by the city itself. If you wish to make your way back to the main trail, go to {128}. If you'd rather continue on the way you were going, go to {67}."
},
{ // 206/26C
"You sink to your knees in molten slag. As you scream in agony, the rock hardens around your legs. The remaining Wraith (the first died from total exhaustion) almost casually throws a Medusa spell, leaving you there as a warning to any other foolhardy wanderers. Go to {103}."
},
{ // 207/26D
"You feel something solid under your feet. After a few cautious steps, you move along with some reassurance. Just before you reach the other side, the bridge seems to give way. You tumble headlong into the swiftly flowing river. Make a saving roll on CON. If you are successful, go to {302}. If not, go to {291}."
},
{ // 208/26E
"You stop. You can hear scuffling ahead and behind you. Using a good dose of common sense, you [douse your light and ]back against the wall. Moments later, two groups of goblins link up. Their green/yellow eyes glow dully in the dark cave. Counting, you find that there are ten of them! You can jump out and attack (go to {260}) or wait and hope that they don't see you (go to {164})."
},
{ // 209/26F
"As you come barrelling over the dune, you see that you face two \"Dark Wraiths\" and two \"Pit Demons\".\n" \
"  The Wraiths have a ST of 59 and a CON of 30 each. Their Speed is 21.[ The Wraiths will use magical attacks, Death Spell #9 (you will have to make two L9-SRs on Luck (60 - LK) per combat round - don't forget to deduct the cost of the spell (40) from their ST). The Wraiths can only be hit with magic or magical weapons, but if their ST drops below 20 each, they will attempt to flee.]\n" \
"  The Demons each have a CON of 10 and their Speed is 18. They will attack with \"tine-swords\" and have an MR of 15 each. Their scales are equivalent to armour and can take 8 hits each. The Demons are only semi-intelligent and will fight to the death.\n" \
"  If you are still fighting after the fourth combat round, the Wraiths will try to take your sister and make a run for it. If you kill all of your adversaries, go to {170}. If the Wraiths flee with your sister and you manage to kill the Demons, go to {279}. If you are killed, go to {103}."
},
{ // 210/26G
"The shattered bones lay scattered at your feet. The mist recedes a little as you approach. In the corner of the dusty room is a small strongbox. Intricate designs are carved into its rusty lid. You notice that the mist has formed a tight circle around you and the box, but will not come near you. If you wish to cast a spell, do so. If you wish to open the box, go to {235}. If you decide to drop the box and leave, go to {99}."
},
{ // 211/26H
"As you pluck the staff from the hand of the statue, the staff winks out of existence. The statue seems to flicker for a moment, displaying a distinct frown on its stony face, then vanishes. Above you, the pit begins to draw closed like a purse string. As total darkness covers you, a fire springs to life in the centre of the pit. It grows in strength, until it is a raging furnace. The air is being quickly consumed by the raging fire. In seconds, you gasp your last breath as death overtakes you. Go to {103}."
},
{ // 212/28A
"The tome has a complicated lock on it. As you pick it up to examine it more closely, the cover seems to squirm in your hands. Upon inspection, you see that there are pictures moving in an endless stream across the book. One figure in the background does not. A powerful looking man with a fleshless skull for a head stares at you with glowing red spots for eyes. Make a saving roll on DEX. If you are successful, go to {102}. If not, go to {266}."
},
{ // 213/28B
"Your noise doesn't attract anything as you make your way back to the road. The sun is beating down on you, and the road seems to reflect all of the day's head right up through the soles of your feet. Along the left side of the road, you can make out a small stream as it weaves in and out of the trees. If you wish to soak your tired feet in this stream, go to {247}. If you feel parched and would like to drink from it, go to {140}. If you'd rather ignore this inviting liquid, go to {201}. If you would cast a spell, do so and check the Magic Matrix."
},
{ // 214/28C
"Their Speed rating is 40! But it really doesn't matter for they track by sound and are as relentless as a pack of hungry wolves. At some point, you will tire of the chase and then they will have you. They will drag you down and feast on your flesh. There is no hope for you now. Soon, your bones will be bleached and polished by sun and sand. Go to {103}."
},
{ // 215/28D
"You move slowly along. Running your hands along the wall, you can feel many cracks and indentations. The sound of your footfalls and shallow breathing seem to come back at you magnified. Make a saving roll on LK. If you make it, go to {120}. If your roll misses, go to {138}."
},
{ // 216/28E
"As you begin to push on through, you feel your foot slipping. The mountain has vanished, and in its place is a huge pit. Make a saving roll on DEX. If you make your roll, go to {270}. If you fail, go to {82}."
},
{ // 217/28F
"Afer several hundred yards, the voice whispers again, \"There is great danger just ahead!\" In the next instant, you find yourself facing a creature that looks as though it has been put together with odds and ends. If you want to attack with a weapon, go to {285}. If you would like to use magic, go to {96}. If you wish to wait, go to {243}."
},
{ // 218/28G
"One of the Hobgoblins stops and sniffs the air. Turning this way and that, he spots you and bellows to the others. They move in to attack. Each has an MR of 10. They are wearing superb armour that can take 5 hits for each of them. If you overcome them, go to {130}. If not, go to {103}."
},
{ // 219/28H
"Roll a six-sided die. If you roll a 1-3, go to {307}. If you roll 4-6, go to {92}."
},
{ // 220/28J (there is no 28I)
"You awaken with your sister beside you and the certain knowledge of where to pick up any treasure you collected along the way. You are awarded a total of 10,000 experience points for successfully completing your quest. Well done! You should never use this same character in this adventure again; give someone else a chance."
},
{ // 221/28K
"The shock of the vision is too much for you. Your heart stops in frozen fear. As your sight fades, you see the image laughing at you. Only terror waits for those who pass Beyond the Wall of Tears! Go to {103}."
},
{ // 222/28L
"Your hand touches the faceted surface and you experience a moment of vertigo. You feel weaker and weaker as your life force is drained from your body. The evil sorcerer has tricked you! Your spirit is now forever trapped within the structure of the blue prism. Near you, you can feel the presence of others, so take solace in the fact that you are not alone in your foolishness. Go to {103}."
},
{ // 223/29A
"The sun flashing off the sand crystals seems to be melting you with the heat. Half blind and baking in the awful furnace of the desert, you find that you must stop and rest often. It is during one of these brief rest stops that you hear a strange humming noise. A few moments later, you are standing in front of a globular swarm of tiny flying creatures. If you wish to attack this \"pest\", go to {168}. If you would like to wait, go to {76}. If you want to run, go to {11}."
},
{ // 224/29B
"After a time, you come to a small lake. On the far shore, you see a deer wading into the lake and drinking. It is unlike any deer you have ever seen in that it gleams like polished gold. If you would like to drink from the lake, go to {114}. If you would like to chase or attack the deer, go to {153}. If you'd rather just keep right on going, go to {84}."
},
{ // 225/29C
"You are dragged along until reach the mouth of the river (about 500 miles!). There you are swept out into a freezing sea of ice where your frozen remains sink to the bottom of the sea. In time, you will be a source of good protein for the many plants and animals that can endure this frigid domain (now, isn't that nice). Go to {103}."
},
{ // 226/29D
"Torn goblin flesh and black ichor covers the ground as you pause to catch your breath. You resume your journey, and the path leads deeper down. Eventually, you come to a dimly lit cavern. In middle of the room is a silken couch with a beautiful woman apparently asleep on it. Around her neck is a small crystal pendant of a skull. Beyond her, the trail seems to slant upward. If you would like to cast a spell, do so now. If you want to attack the woman (you heartless fiend), go to {33}. If you would like to try and quietly approach her, go to {237}. If you want to go back the way you came, go to {203}."
},
{ // 227/29E
"You awaken to find that you are back where you began your journey. Alhim Dandin is standing next to the pallet where you lay. He tells you that you could never survive another excursion into the land of nightmare. You will be able to recover any treasure that you found there, but your sister is lost forever. You receive 1500 experience points for surviving as far as you did. Close the book and try again someday with a new character."
},
{ // 228/29F
"Oh evil fate! While you stood unprepared and unknowing, Aza-zel has cast a powerful spell on you. You feel all of your Strength draining from your body. You go totally limp and fall to the floor as you feel yourself becoming thinner and thinner. Aza-zel chuckles as he picks you up and nails you to the wall. Now you have become one of his prized hides. You will remain alert and aware forever, but will always be incapable of movement or speech. Go to {103}."
},
{ // 229/30A
"Throw one die and add two. This is the number of skeletons that you must face. Each has an MR of 5. [The weapons that they carry are coated with a slimy black ichor. It is a poison (actually a rotting disease). If you are not immune to poison, for every hit taken you must make a saving roll on LK. If you make your roll, you were not poisoned that round. If you miss your roll, you were poisoned. If you are poisoned, you will begin to decay into a skeleton in two turns unless you have a cure. ]If you can shatter the calcified remains, go to {36}. If you are undone[ or have become a skeleton yourself], go to {103}."
},
{ // 230/30B
"Ballaha nods. You feel a strange change coming over you. Your arms seem to grow lighter and lighter as they turn darker and darker. You have now become a Dark Wraith. You will hear nothing except the commands of Ballaha. Your sister is forever forgotten, as your whole world is now the Dark Lord. Your sister is forever forgotten, as your whole world is now the Dark Lord. This character is now set to watch for other fools along the \"Black Road\". Go to {103}."
},
{ // 231/30C
"You wander for a time, and finally crest a small dune. At the base of the dune, you find a long dead campfire. All traces of footprints have been obliterated, either intentionally or by the shifting sands. Laying in the sand is a piece of cloth. You recognize it as being from your sister's cloak. They were here, so close! Once again, you take to the road in hopes that they may not be too far ahead of you. Go to {273}."
},
{ // 232/30D
"In the course of your meal, you learn that a group of evil-looking creatures have recently passed by. In their midst was a struggling prisoner. It had to be your sibling. They could be no more than a few days ahead of you, perhaps only a few hours! Aza-zel is touched by your single-minded devotion. He offers you a gift. He will magically cure any and all of your wounds (your CON goes back to the original number), or he will give you a mystic vision showing you where your sister is. If you choose to be healed, go to {288}. If you prefer the vision, go to {171}."
},
{ // 233/31A
"Make a roll on the Wandering Monster Table. Your noise has attracted this (these) creature(s)! If you survive the encounter, go to {213} and ignore the first sentence. If you are defeated, go to {103}. If you run, go to {147}. If manage to elude the monster(s), go to {213} and ignore the first sentence."
},
{ // 234/31B
"In a sudden rush of inspiration, you realize that the tiny beings are intelligent and trying to communicate with you. After a time, you are able to understand their simple message. They are telling you to avoid some kind of large object ahead of you. With a signal of thanks, leave the swarm and go to {248}."
},
{ // 235/31C
"The mist sends out cautious tendrils and then pulls back as you struggle with the box. Finally, it opens with a loud creak. Inside is a small amulet glowing with a cold blue light. Written in runes upon its surface is the inscription \"Ghost Breaker\". It is magic[ and proof against all forms of ghost, except black wraiths]. If you wish to wear this pretty bauble, go to {47}. If you are of a mind to carry it in the box, go to {99}. The amulet has a material value of 500 gold pieces."
},
{ // 236/31D
"Some inner voice seems to drag at your memory. With a sudden clarity, you realize the danger that you are in. Keeping your distance, you speak with the non-human beauty. She tells you that her name is Amorate'l, and that the trees have spoken to her of dark creatures moving along the road with another hapless victim. She isn't able to tell how long it has been since they were last seen (time has very little meaning to trees), but she does add that they are beyond the ken of the trees now. Are they dead, have they left the forest, are they across the river? She leaves you with no answers, only more questions. With a shrug, you thank her and leave. If you would like to continue along this path, go to {253}. If you wish to go back to the road, go to {13} and choose again."
},
{ // 237/31E
"Her eyes flash open at your approach. She screams, \"What have you done with my goblins?\" Before you can react to this alarming question, she begins to alter form. She becomes a giant snake! Her scales are fully 3\" thick. Her fangs drip a deadly poison as her scales glow dully in the scant light. Her MR is 40, but you must make a saving roll on DEX each combat round to avoid being poisoned. If you are poisoned, you will lose 5 ST points per round that you miss (deduct your adds accordingly). If you kill her, your ST will return at a rate of 1 point per paragraph as you continue on your way. If you can defeat this scaly terror, go to {65}. If she kills you, go to {103}."
},
{ // 238/31F
"You move through the desert heat. The landscape swims before your eyes as the sun becomes a bitter enemy. The tinted crystals of sand seem to sparkle and dance in front of you. You try to remember exactly where you saw that light of the night before. Make a saving roll on LK. If you make your roll, go to {231}. If you should fail your roll, go to {246}."
},
{ // 239/31G
"The path runs out onto a sandy beach by a fast flowing river. To your left are a group of large, flat stones that are half-buried in the sand. In front of you are a few rocks poking up above the water. The stones in the water seem to be fairly evenly spaced and extend all the way across the river. If you would like to examine the large flat rocks in the sand, go to {3}. If you'd like to try crossing the river on the stones in the water, go to {156}."
},
{ // 240/31H
"Ahead of you, you hear footsteps. There is a strange odour in the air. You notice that the walls on each side of you are far too sheer to climb. Ahead of you, the trail makes a bend and just before that bend is a large boulder. Seeing that this is your only chance for cover, you rush for it. Make a saving roll on DEX. If you make the roll, go to {72}. If you miss it, go to {189}."
},
{ // 241/32A
"You are sound asleep when a midnight black leopard jumps you. Its MR is 30, but take the beast's first hits directly off your CON, less any armour. If by some miracle you survive the first assault, fight on! If you manage to overcome this huge feline, go to {128}. If it rips you to pieces, go to {103}."
},
{ // 242/32B
"You realize that the walls are dripping with hot blood! You can also tell that the further you travel, the hotter the blood becomes! Finally, the tunnel opens out into a wide chasm. Below you are the sounds of a fast moving river. If you wish to chance it and swim across, go to {297}. If you'd rather go back and try the other path, go to {294}."
},
{ // 243/32C
"Nothing happens. Go back and choose again."
},
{ // 244/32D
"As you wander along this track, you can feel many eyes upon you. On your right, you can see a small, dark stream bubbling along in your direction. While you travel, you hear the rustle of leaves and the tinkle of metal. The trail ends in a wide clearing with a deep, wide pool into which the stream empties. As you step into the clearing, ten black-clad elves spring from the trees. Half have light bows aimed at you, the other half have thin, flashing rapiers that reflect the light into your eyes. One, taller and more regal of bearing, steps forward. He commands that you throw down your arms. If you comply, go to {45}. If you'd rather fight, go to {127}."
},
{ // 245/32E
"You feel as though you're being smothered in cotton. The mist has totally engulfed you. Every time you open your mouth to take a breath, a tendril of fog reaches down your throat, gagging you. You can feel your body being pushed and pulled from every direction, inside and out. Finally, a huge arm of mist forces its way into your mouth and down your gullet. With a single titanic effort, you are ripped open from the inside! Your ghost now flies to join these other horrors comprising the mist. Go to {103}."
},
{ // 246/32F
"As you put your foot down into the shimmering sand, a soft humming arises. You can feel your foot gently vibrating. There seems to be a regular pattern to the vibration. It beats, almost like a pulse. With a sinking realization, you know that the sand is setting up a resonance to the beat of your heart! The sound moves out through the sand in concentric waves, like ripples from a stone dropped into a pond. In the distance, you can see the sand shifting in straight lines in your direction. Something is rapidly burrowing under the sand toward you! Odd, grey triangles burst through the sand, sharks! Sand sharks! Throw two dice; this is the number of grey monsters that you have attracted. Each has an MR of 6. If you manage to defeat the \"sharks\", go to {162}. If you decide to run, go to {214}. If you lose the battle, go to {257}."
},
{ // 247/33A
"As you lower your tired feet into this cool fluid, a cold shock runs up your legs. With its first tendrils going through your body, you realize that there is an enchantment upon the stream. Make a saving roll on CON. If you make your roll, go to {104}. If luck deserts you and you miss it, go to {177}."
},
{ // 248/33B
"After an interminable amount of slow shuffling through the hot desert sands, you come upon a large crystalline obelisk. The surface is smooth and unmarked. If you want to examine the structure more closely, go to {66}. If you'd like to continue on toward the mountains, go to {292}."
},
{ // 249/34A
"You watch in total confusion. After a while, their antics begin to bore you. Somehow, the swarm realizes you are impatient and moves off to allow you to pass them. Go to {248}."
},
{ // 250/34B
"If you wish to cast a spell, do so and check the Magic Matrix. If you are using torches or a lantern, make a saving roll on DEX *and* LK to allow for wind and dampness. If you succeed in making a light, go to {35}. If you fail, go to {118}."
},
{ // 251/34C
"You are at last able to break free of the current. You swim to the shore and drag yourself out of the water. Looking around, you see a vast expanse of desert stretching interminably to the right, left, and in front of you. Behind you is the river and the great forest. You can barely make out the tops of the great mountains of Shaitans Teeth, your only real landmark in this barren land. Night is nearly upon you, so you must either make camp or continue on in darkness (you are just too wet to make a light of any kind). If you do decide to camp, go to {292}. If you decide to wander in the dark, go to {293}."
},
{ // 252/34D
"Several small humanoid creatures, about as large as your hand, push their way through to the front. Make a saving roll on CHR (you devil). If you make it, go to {150}. If not, go to {176}."
},
{ // 253/34E
"Make a saving roll on IQ and LK. If you make both rolls, go to {17}. If you should miss either, go to {93}."
},
{ // 254/34F
"The goblins wander off without spotting you! You may now choose to follow them further down the cave - go to {101} - or go back out the way you came and take the other fork by going to {12}."
},
{ // 255/34G
"A most formidable opponent! [For every hit that you make upon the monster, you must make a saving roll on DEX in that round as the blood of the beast is a virulent acid and will eat away flesh in minutes. If you miss your roll, you must take one die worth of hits that round. ]If you are hero enough to defeat the beast, go to {290}. If the worm shreds you, go to {103}."
},
{ // 256/35A
"You come to a fork in the path. One branch leads to the right, the other continues on straight ahead. The trees seem to be thicker and more crowded together ahead of you. The path leading to the right seems to be a bit more open (though not by much). If you'd like to continue straight on, go to {86}. If you'd rather take the branch to the right, go to {131}."
},
{ // 257/35B
"The slate grey horrors spring upon you. Their 9', slender bodies crush you as their razor-sharp teeth and talons rend your flesh. You die a bloody screaming pulp. Another victim of what lies beyond the Wall of Tears! Go to {103}."
},
{ // 258/35C
"From out of the sky it plummets! Before you can escape, it has landed before you. It is some hellish combination of giant bat, scorpion and serpent. Perched upon its armoured back is an absolutely black form. No mortal rider this, but a dark wraith, perhaps an inhabitant of the evil iron city Cantahf. The rider and mount attack as one, for in fact they are bonded in a way no mortal can ever understand. Their combined MR is 40. [But, if you lose even one combat round, the fangs of the serpent head or the stinger of the scorpion tail will have struck and poisoned you! Unless you are immune to poison, you will be paralyzed for the next round, and all of the monster's hits will count. ]If you win your battle, go to {202}. If the vile thing finishes you, go to {103}."
},
{ // 259/36A
"You move along another few leagues or so, and come upon the bones of many dead creatures. Some are man-like in form, many are nightmare concoctions. There must have been a fierce battle here. A little further on, you come to a small wooden bridge. Beneath the bridge, a wide, dark river flows swiftly. Looking into the water, you can see many bones sticking in its sandy bottom. As you step onto the wooden planking, a huge column of flame springs into existence on the far side. Abruptly, you hear behind you the clatter of feet. Whirling about, you see several living skeletons rushing toward you. A voice issues from the tower of fire, \"Come to me, little one. I thirst for warm blood!\"\n" \
"  If you stand to fight the skeletons, go to {229}. If you decide to face the giant shaft of flame, go to {68}. If you'd rather chance the water by leaping from the bridge, go to {283}."
},
{ // 260/36B
"With a hearty war whoop, you leap upon your foes. [You get +15 to your first attack for surprise. ]Each goblin has an MR of 5, making a grand total of 50 (plus any modifier)! Not bad odds, all things considered. If you can destroy this crowd, go to {226}. If they drag you down, go to {103}."
},
{ // 261/36C
"The great dragon Azoth hates cowards! He hits you with a powerful blast of his flame breath. Take three dice worth of damage[ (all of it on your posterior)]. If you still live, go to {148} and make another choice. If you are turned into a cinder, go to {103}."
},
{ // 262/36D
"At your advance, the tiny archer let loose their fusillade of arrows. There are 5 dice times 5 arrows coming at you. Each will cause one point of damage (less any armour), and you must make a saving roll on LK against the number of arrows to avoid getting any arrows in your eyes. If you miss your roll, go to {110}. If you survive this first attack, go to {10}. If you perish in the first skirmish, go to {103}."
},
{ // 263/36E
"After a time, you come to a section of tunnel with a great pool of standing water in it. Looking up, you can see a steady drip of water from the ceiling. It is not long after that you notice the tunnel is moving gradually upward. Finally, you come to a place where the tunnel apparently dead ends.\n" \
"  Ahnit speaks in your head again, \"You are now free, and I must go back to my true owner.\" So saying, you find yourself standing outside in a vast sparkling desert and Ahnit is gone. Go to {238}."
},
{ // 264/36F
"You must make a saving roll on DEX each combat round to allow for the chance of being surrounded. If you miss your saving roll, then take the hits from that round directly off your CON. If you overcome these brutes, go to {48}. If you should fall, go to {103}."
},
{ // 265/36G
"The Wraiths are almost transparent in their weakened state. As they cringe upon the ground, they speak in a halting tandem sing-song, \"You have...not won...free yet...for you...are under...the eye...of...BALLAHA!\" At the utterance of the last word, they point toward the great iron citadel sitting in the lake of blood. There, in the distance, you can see several winged shapes rise from the ruddy walls. If you wish to make a stand and fight off your new foes, go to {73}. If you want to take your sister and run, go to {198}."
},
{ // 266/36H
"The tome will not open for you. As you struggle in vain to break the metal seal, a vision takes form before your eyes. A tall, strongly built man dressed in black appears. He stares at you with glowing red eyes set in a fleshless skull. Make a saving roll on CON. If you make your roll, go to {301}. If your luck has turned sour, go to {132}."
},
{ // 267/36J (there is no 36I)
"With a shrug, the giant ambles off, leaving the path open. The forest seems to press in on you as you go to {268}."
},
{ // 268/37A
"In utter stillness, you move further up the trail. A buzzing noise soon impinges upon your awareness. You are brought up short by a creature in your path. It appears to be all spines and armour. It begins to shuffle toward you. It's attacking! It has an MR of 30. If you fight and win, go to {179}. If you lose, go to {103}. If you run, go to {147} (it has a Speed of 5). If you elude the beast, go to {70}."
},
{ // 269/37B
"As the horror evaporates and flickers from existence, you find an enormous fire opal in the sand. It is worth 1000 gold pieces. After recovering this precious bauble, you find that your path is now clear. You may now head for the mountains by going to {2}."
},
{ // 270/37C
"With a truly titanic effort, you twist and catch the edge of the hole. Slowly, painfully, you drag yourself up and out. After resting, you can see the true size of the hole. If you wish to try to leap across, make a saving roll on both DEX and ST. If you make both, go to {190}. If you miss either, go to {82}. If you'd rather go back the way you came, go to {128}."
},
{ // 271/37D
"Unfortunately, the thoughts of mushrooms are quite beyond those of the more animate life forms. However, their ceaseless chatter has attracted some attention from the denizens of this wooded nightmare. Roll on the Wandering Monster Table *three* times. If you choose to fight (and you manage to win), go to {88}. If you lose, go to {103}. If you run, go to {147} and if you elude the beasts, go to {224}."
},
{ // 272/37E
"You stand over his lifeless body. Searching him, you find only a light blue powder that slowly sifts through your fingers. Before your startled gaze, his robe begins to rot, as does the flesh beneath it. The room seems to rock and sway. In an instant, you find yourself standing in an empty clearing a little way from the road. Go to {146}."
},
{ // 273/37F
"You wander for days. The leagues pile up behind you. The sun beats at you like a merciless whip. The freezing nights bite at you like angry hounds. Subtract 5 from your CON. Finally, near the foot of the great mountain range, the road splits. At the centre of the fork is a stone marker. Carved into its rough surface are two crude arrows, each pointed at a different path. The one on the left says \"Dark Path\", the one of the left \"Shadow Road\". Choose! If you will take the right-hand road, go to {203}. If you'd rather chance the left, go to {12}."
},
{ // 274/37G
"Feeling lucky? Go ahead and make a saving roll on your LK. If you make it, go to {193}. If not, go to {312}."
},
{ // 275/38A
"With a cry they spot you! They attack all together. There are ten of them and each has an MR of 5. Defend yourself! If you survive their onslaught, go to {226}. If they rend you, go to {103}."
},
{ // 276/38B
"Exhausted, you sit on the ground. Your light still burns. The forest goes suddenly still. A chill inches up your back as you feel a malign presence near. You look up to see a huge black form gliding beneath the heavy cloud layer. Fool! It has spotted your light. Go to {258}."
},
{ // 277/38C
"As you wait, the sound grows louder and louder. Finally, it has become nearly deafening, and then stops. Looking around, you find that you are completely surrounded by thousands of blood red insects. Each is about as long as your hand. Their antennae and mandibles twitch in seeming anticipation. If you would like to fight the insect horde, go to {200}. If you want to hold back for the moment, go to {252}."
},
{ // 278/38D
"The old mage falls, shattering the crystal into a million sharp fragments. You feel a strange fluttering rush, as if some unseen force were suddenly freed and winging its way past you. Many voices seem to whisper, \"Thank you!\" into your ear and are then gone. You are alone with the dead sorcerer. Go to {272}."
},
{ // 279/38E
"As the mystical life force that animated the Demons flees, you turn to find that the Wraiths have made off with your sister. A strong wind springs up, blowing sand and dirt into your face. With each passing second, the wind grows stronger. A sandstorm! Make a saving roll on IQ. If you make it, go to {107}. If you fail, go to {134}."
},
{ // 280/38F
"The dragon speaks to you. He tells you that his name is Azoth and he offers you clear passage. Upon listening to your tale of woe, he gives you a magic shield from his hoard of treasure. [The shield will absorb 2 (and only 2) Hellbomb Bursts. ]Thanking him, you scuttle from the caves onto a steep mountain path. Go to {163}."
},
{ // 281/38G
"A chill wind springs up, making your wet clothes feel as though you are wrapped in ice. [Roll one die. This is the number of turns that you must go with a -5 to your CON and ST. ]Your light is like a beacon to the foul denizens of this dark wood. Roll on the Wandering Monster Table. If you can defeat the monster, go to {146}. If you want to run, go to {147}. If you manage to elude the beast, go to {146}. If you die in battle, go to {103}."
},
{ // 282/39A
"At your approach, several creatures come out of the huts. Roll 2 dice; this is the number of creatures that you see. With a cry, they dash toward you. They are orcs! They all seem to be armed with heavy bludgeons. They each have an MR of 7. If you wish to fight, go to {264}. If you would like to throw down your weapon and surrender, go to {64}. If you'd like to try to talk with them, go to {87}. If you want to run, their Speed rating is 12; go to {147}. If you elude them, go to {53}."
},
{ // 283/39B
"You leap from the bridge, casting away all treasure and forsaking any armour. In your hand, you still clutch your favoured weapon. As your body neatly slices the water, you feel a numbing chill spread through your limbs. Make a saving roll on CON. If your luck holds, go to {302}. If fate turns her fickle head, go to {291}."
},
{ // 284/39C
"The thing passes silently over you. As it goes, you can see its great bat wings pushing slowly through the air. The Shacath, horror of the sky! Atop its great back, a dark wraith seems all intent on searching the road below. Lady Luck has perches on your shoulder this eve, and whoever the rider was, whatever his mission, he has passed you by. Rest easy now as dawn all too quickly approaches and you must soon be on your way. Go to {13}."
},
{ // 285/39D
"At the first stroke, the creature seems to fall apart. The head and arms separate from the body. Each section now attacks you separately. The head will bite, the arms claw and strangle, and the feet will kick and scratch. This sectional monster has an MR of 45. You must also make third level saving roll on Dexterity (30 - DEX) to avoid being surrounded each combat round (every 9 hits done will destroy a body part; as each part dies, subtract 1 from the level of the saving roll on DEX). If you are surrounded, you will be overcome and unable to fight for that round (all of the monster's hits will take effect). If you win through, go to {197}. If you are finished, go to {103}."
},
{ // 286/39E
"Make a saving roll on LK. If you make it, you get bad vibes from the staff. You take the torch and go to {121}. If you miss the roll, go to {211}."
},
{ // 287/40A
"The moment you touch the gems, your body stiffens with pain. You feel the jewel move beneath your fingers. As you move your hand away, you begin to feel an icy fire race up your arm and through your body. You fall, and before your fading eyes, a small scorpion with bat wings and a serpent's head scuttles away and takes to the air. You have been poisoned. As you die in the throes of agony, the clouds part for a moment, revealing a mocking skull leering down at you. Go to {103}.\n" \
"  If you are immune to poison, smash the \"eggs\" and go to {13}."
},
{ // 288/40B
"With a wave of his hand all of your wounds tingle and are then healed. You know in your heart that it is time to leave. Aza-zel warns you that there are evil watchers set along the road, ever ready to waylay the lone traveller. \"Stay to the shadows or take a less obvious route\" are his parting words as you head back out to the road once more. Go to {146}."
},
{ // 289/40C
"Skirting the pool takes you into the fallen branches and leaves of the muddy forest. You cannot help but make noise as you push your way through the tangle. It is bound to attract more of the inhabitants of these damnable woods. Roll on the Wandering Monster Table. If you are lucky and strong enough to defeat your adversary, go to {136}. If you wish to run further into the forest, go to {147}. If you manage to elude the horror, go to {136}. If you are undone, go to {103}."
},
{ // 290/40D
"As the foul creature perishes, the body disintegrates. Once again you are alone. The idol has lost its power to summon the beast now, but its value has made the fight worth your while. It is dwarven gold inlaid with pure mithril. The teeth are perfectly cut emeralds. It has a material value of 5000 gold pieces. However, if you are magic user, you now find that you own a deluxe magic staff, even though the shape is a bit unusual. If you would like to examine the book now, go to {212}. If you just wish to leave, go to {128}."
},
{ // 291/40E
"The spell upon the river overcomes you. You can feel the waters draining the heat and life from your body. As you slowly sink beneath the dark surface, you see a large, mocking skull appear amidst the bubbles. With the last bit of rational thought, you are forced to realize that Ballaha, Dark Lord of Iron Cantahf, has beaten you. Your sister is lost forever! Go to {103}."
},
{ // 292/40F
"As the sky darkens, the temperature drops dramatically. You shiver as you doze fitfully this night. In the small hours before dawn, you peer into the darkness ahead of you. There, near the foot of the great mountain chain, you see a small light. Perhaps a campfire or the luminescence of another horrible monster from this side of the \"wall\". If you decide to move toward the light now, go to {305}. If you'd rather wait until dawn, go to {238}. If you wish to make a light yourself and chase down the other beacon's source, go to {25}."
},
{ // 293/40G
"As you move off toward the light, you find that you must constantly adjust your course to stay in sight of the beacon. You no longer have the road to act as a guide. The sand shifts constantly beneath your feet, making every move drain that much more energy from your tired body. Make a saving roll on LK. If you're lucky this day, go to {79}. If your luck has run out, go to {246}."
},
{ // 294/40H
"The air seems to be filled with an irritating smoke as you stumble along the narrow corridor. In the murky air ahead of you, you see two large glowing orbs, each approximately 2' in diameter. The glowing, golden light from the orbs seems to reflect off mirror-like plates. As you take a few steps more, you find that you are face to face with a huge dragon. It fills the whole width and height of the tunnel.\n" \
"  If you wish to try and talk with this magnificent lizard, go to {113}. If you would rather attack, go to {55}. If you want to run like a frightened rabbit, go to {261}."
},
{ // 295/42A
"As the last of the evil elves falls before your might, you hear a mournful baying in the woods. All at once, several huge timber wolves burst into the clearing. Their eyes hold the red gleam of hunger as they advance on you. Throw one die and add three; this is the number of wolves that you face. They each have an MR of 10. You may choose to run: their Speed rating is 35 each, so go to {147} to run and {13} if you evade them. If you know Lupine and wish to speak with them, go to {78}. If you choose to fight and you defeat them, go to {133}. If you cannot elude them or they defeat you in battle, go to {103}."
},
{ // 296/42B
"From around a bend in the path ahead of you, three armed and armoured Hobgoblins appear. If you would like to brazen it out and speak with them, go to {39}. If you would leap to the attack, go to {157}. If you'd prefer to run, their Speed is 13; go to {147}. If you elude them, go to {203}. If you can't get away, go to {157}."
},
{ // 297/42C
"You dive. Just before you hit, you realize that the intense heat is coming from this river of blood. As you plunge headlong down, you die screaming as you are parboiled. Days later, your decomposing corpse bobs to the surface of a lake of boiling blood surrounding a dark and foreboding citadel. Go to {103}."
},
{ // 298/42D
"Without warning, they attack you. Their broadswords gleam brightly as they cry for your blood. They each have an MR of 10. Their armour can withstand 5 hits. If you win, go to {130}. If you fall, go to {103}."
},
{ // 299/42E
"With a cry, you attack the wizard. He has an MR of 35 and fights with a magic sword. He will expend 5 ST points per round to maintain the magic of his weapon. His ST is 30, but if it falls below 10, he will surrender. If you kill him, go to {272}. If he is forced to surrender, go to {184}. If you are defeated, go to {103}."
},
{ // 300/42F
"[If you have lost your magical weapon or are unable to perform magic, then none of your hits will take effect. There you stand defenceless against the horror as blow after blow finally reduces you to dust; go to {103}. If you do have some magic about you, all of your hits take effect, but you still take damage if the spectre scores higher than you. ]Be careful, for if your CON should fall below 5, you will become a zombie! If you win against this mighty foe, go to {16}. If you lose, you will become a ghost and join with the evil creature before you; go to {103}."
},
{ // 301/42G
"The shock and power of the vision do not immediately kill you. The vision speaks in hollow echoing tones, \"I see you! You hold in your grasp the spellbook of one of my *lesser* servants. Through it, I am able to speak to you. Speak not yourself, for it will avail you nothing. I may use this spell but once, but be warned for I know you now. If you would bend you arm against me, I shall assuredly destroy you. If you drop to your knees and swear fealty to me, I shall spare you!\" If you would like to accept Ballaha's offer, go to {230}. If you choose to defy him, go to {313}."
},
{ // 302/42H
"By a stroke of good fortune, you have survived the enchantment that rests upon this river. You are, however, caught in the rapid current of the stream. On both sides of the bed, you can see your would-be adversaries dwindle in the distance. The current is mighty; make a saving roll on ST. If your good luck holds, go to {251}. If your luck has run dry, go to {225}."
},
{ // 303/42J (there is no 42I)
"The elves will follow you willingly for a time. They lead you past numerous traps and dangerous beasts until you reach a sandy bank of a river. Here they tell you that they must stop. They are prevented by means a spell from ever crossing over rushing water. To the south is a bridge, they tell you. If you would like to follow their directions, go to {259}. If you think that you would like to explore on your own, go to {239}."
},
{ // 304/43A
"Roll two dice, first for yourself and then for the towering inferno. If you rolled a 2 or 12, you lost automatically. The same goes for your fiery friend. If not, then the winner is whoever rolled highest. You must do this three times, and the one who wins the most rounds is the true winner (ties must be rolled over). If you win, you may pass freely and your gambling companion will disappear; go to {105}. If, however, the flame wins, you are consumed in its fiery embrace; go to {103}."
},
{ // 305/43B
"You walk for hours. Dawn is just approaching when you hear low voices very close by. You slither over a small sand dune, trying to be as quiet as possible. Tension fills you as you snake slowly up. Make a saving roll on DEX. If you make the roll, go to {6}. If you fail it, go to {57}."
},
{ // 306/43C (reachable only via Magic Matrix)
"The mist slowly reveals itself to you. Through the haze of illusion, you can see that the mist is a series of composite ghosts! They are grotesque, with multi-limbed and -headed bodies. If you feel strong enough to venture on with these spectres, go to {34}. If you refuse the impulse to give into curiosity, go to {83}."
},
{ // 307/43D
"Roll two times on the Treasure Generator. Ignore any rolls that indicate jewels or magic items. These were poor orcs and would only have a small amount of money which they strip from their occasional victim. You may also pick up any of their clubs; they are 3 dice weapons due to their extraordinary seasoning. Go to {53} if you would return to the main road, or {145} to continue along the path."
},
{ // 308/44A
"Your air has run out! In an act of desperation, you raise your head and inhale. Sand clogs your nose and mouth. A glob of sand, wetted by the moisture of your mouth, sticks in your throat. Your body jerks and spasms as you slowly choke to death. Go to {103}."
},
{ // 309/44B
"As one of your feet enters the pool, small finger-like projections grab both foot and leg. Slowly you are being sucked down into its mass. The pool quivers like jelly, almost as if in anticipation. A long tentacle with a dark black eye on the end rises out from the body of the thing, as though appraising the situation. Make saving rolls on DEX and ST. If you make both, go to {119}. If you fail at either, you will be sucked completely into the monster; go to {103}."
},
{ // 310/44C
"The Dark Wraith has heard you! It releases two Hellbomb Bursts in rapid succession. Take 12 dice worth of damage (unless you have protection). Even if you survive this massive assault, the ground at your feet has been melted. Make a saving roll on DEX. If you have made your roll, go to {95}. If you miss the boat, go to {206}. If the \"bursts\" have undone you, go to {103}."
},
{ // 311/44D
"You find that you are facing two \"Dark Wraiths\". They each have a ST of 59 and a CON of 30. [They will use a combined Death Spell #9 (you must make two saving rolls on LK per combat round). They will keep this up until their ST falls to 5 or below. ]If you kill them, go to {170}. If they kill you, go to {103}.[ If you disable them (ST 5 or less), go to {265}.]"
},
{ // 312/44E
"From out of the night, you are attacked and caught by surprise! Roll on the Wandering Monster Table to find out what is molesting you. Take the creatures' first hits directly off your CON (less armour) to allow for the surprise. If you win, go to {193}. If you perish, go to {103}. If you should decide to run, go to {147}. If you elude the creature(s), go to {193}."
},
{ // 313/44F
"Ballaha screams a shriek of anger and hate. The walls of the temple begin to shake and crack. Huge stone blocks start to fall from the ceiling and the floor beneath your feet begins to buckle. A dusty haze fills the air of the room. Make a saving roll on LK and DEX. If you make both, go to {205}. If you should fail either, go to {7}."
},
{ // 314/45A
"There is absolutely no sound in the night around you. It is as though the whole world were holding its collective breath. Just as you lay yourself down to sleep, you sense a powerful \"presence\" somewhere near. Looking up into the cloud-ridden sky, you can see a black form moving slowly, high above the road. Make a saving roll on LK. If you make the roll, go to {284}. If you fail, go to {258}."
},
{ // 315/45B
"Your wound begins to tingle. Your body shudders and convulses. You can feel hairs pushing themselves rapidly through your skin in patches all over your body. Your spine begins to bow forward, and you can hear and feel your bones crack and reshape. In a sudden and final agony, you drop to all fours. You have become a werewolf. You bound off into the forest, never to be seen by mortal eyes again (note: if you have a spell against lycanthropy or disease, use it and go to {13} to choose again). Go to {103}."
},
{ // 316/45C
"As you struggle feebly in the tightening cocoon of evil, the spider silently drifts down. One well-placed bite sends the venom coursing through your veins. Your limbs jerk reflexively as you pass into death. Go to {103}."
},
{ // 317/45D
"You climb about halfway up and then lose your footing. Screaming, you fall to the jagged boulders below. Take 10 dice worth of damage. If you survive, go back to {2}. If you have succumbed, go to {103}."
},
{ // 318/45E
"You must roll on the Wandering Monster Table. If you win, go to {193}. If you are killed, go to {103}. If you decide to run, go to {147}. If you run and should manage to elude the creature(s), go to {193}."
},
{ // 319/45F
"As you approach, an old man dressed in a coarse brown smock appears at the door. In his withered hands, he holds a gnarled staff which he leans upon. He smiles as he squints to see you better. With a nodding head, he waves you closer, beckoning you to come inside. If you want to get closer, go to {63}. If you want to hightail it out of there back to the main road, go to {97}. If you wish to cast a spell, do it and check the Magic Matrix."
},
{ // 320/45G
"The elven chief thanks you graciously. He orders five of his best warriors to accompany the two of you. They load fresh arrows and water and prepare to depart. After a tearful goodbye from their mates, you are led to a well-hidden forest path. Make a saving roll on your CHR. If you make it, go to {303}. If you miss it, go to {196}."
},
}, bw_wandertext[11] = {
{ // 0
" 2. Ogre             MR = 10, 1d3+2 appearing, speed 10."
},
{ // 1
" 3. Giant Rat        MR =  3, 4d6 appearing, speed 16."
},
{ // 2
" 4. Tiger            MR = 45, 1 appearing, speed 28."
},
{ // 3
" 5. Giant Spider     MR = 20, 1-2 appearing, speed 15."
},
{ // 4
" 6. Zombie           MR =  4, 2d6 appearing, speed 7."
},
{ // 5
" 7. Leopard          MR = 40, 1 appearing, speed 28."
},
{ // 6
" 8. Flame Demon      MR = 10, 1d3+2 appearing, speed 12."
},
{ // 7
" 9. Dire Wolf        MR =  5, 1d6+4 appearing, speed 18."
},
{ // 8
"10. Manticore        MR = 50, 1 appearing, speed 20."
},
{ // 9
"11. Kobold           MR = 10, 1d3+1 appearing, speed 10."
},
{ // 10
"12. Hobgoblin        MR =  5, 1d6+3 appearing, speed 12."
}
};

MODULE SWORD bw_exits[BW_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  { 273,  56,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  38, 212,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  { 209, 183,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  { 128,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/2A
  { 292,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/2B
  { 255,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2C
  { 152, 253,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2D
  { 223,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/2E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2F
  { 244, 185, 259,  -1,  -1,  -1,  -1,  -1 }, //  13/2G
  { 182,  46,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/2H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/2J
  { 128,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/2K
  { 117,  53, 178,  -1,  -1,  -1,  -1,  -1 }, //  17/2L
  { 320, 151,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/3A
  { 311, 112,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/3B
  { 286, 121,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/3C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21/3D
  { 163,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/4A
  {  55, 261,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/4B
  { 227,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/4C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/4D
  { 145,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/4E
  { 273,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/5A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/5B
  { 128,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/5C
  { 194, 267,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/5D
  { 253, 262,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/5E
  { 141,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/5F
  { 187, 148,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/5G
  {  69,   5,  99,  -1,  -1,  -1,  -1,  -1 }, //  34/5H
  {  21, 204,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/5J
  {  68, 304, 283,  -1,  -1,  -1,  -1,  -1 }, //  36/5K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/5L
  { 255,   9,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/6A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/6B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/6C
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/6D
  { 124, 253,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/6E
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/6F
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/6G
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/7A
  { 172, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/7B
  { 128,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/7C
  { 219, 145,  53,  -1,  -1,  -1,  -1,  -1 }, //  48/7D
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/7E
  { 123, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/8A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/8B
  { 231,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/8C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/8D
  { 273,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/8E
  { 135,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/8F
  { 317,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/8G
  {  27,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57/8H
  { 285, 174, 243,  -1,  -1,  -1,  -1,  -1 }, //  58/8J
  { 175,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59/8K
  {  42,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60/8L
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61/8M
  { 156,  84,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62/8N
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63/9A
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64/9B
  { 148,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65/9C
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66/9D
  { 216, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67/9E
  { 105,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68/10A
  { 210,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69/10B
  { 181,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70/10C
  { 276,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71/10D
  { 125, 195,  39,  -1,  -1,  -1,  -1,  -1 }, //  72/10E
  { 170,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73/10F
  { 256,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74/10G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75/10H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76/10J
  { 156, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77/10K
  { 295,  50,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78/10L
  { 231,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79/11A
  { 232, 299,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80/11B
  { 123,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81/11C
  {  20,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82/11D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83/11E
  { 207, 192,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84/11F
  { 109, 123,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85/12A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86/12B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87/12C
  { 224,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88/12D
  {  51,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89/12E
  { 239,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90/12F
  { 125, 203,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91/12G
  { 307,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92/12H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93/13A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94/13B
  { 170,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95/13C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96/13D
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97/13E
  { 253, 262,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98/13F
  { 300,  29,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99/13G
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100/13H
  { 260, 275,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101/13J
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102/15A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103/15B
  { 319, 146,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104/15C
  { 292,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105/15D
  {  34, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106/15E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107/15F
  { 161, 142,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108/15G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109/15H
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110/15J
  { 310,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111/15K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112/16A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113/16B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114/16C
  { 259, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115/16D
  {  43,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116/16E
  { 256,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117/16F
  { 204, 274,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118/16G
  { 289,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119/16H
  { 260, 164,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120/16J
  { 217,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121/16K
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122/16L
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123/17A
  { 262,  31, 253,  -1,  -1,  -1,  -1,  -1 }, // 124/17B
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125/17C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126/17D
  { 295,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127/17E
  { 309, 289,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128/17F
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129/17G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130/18A
  { 271, 224,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131/18B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132/18C
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133/18D
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134/18E
  { 163,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135/18F
  { 314, 167,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136/18G
  {  89,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137/19A
  { 180, 260,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138/19B
  { 117,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139/19C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140/19D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141/19E
  { 269,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142/19F
  { 123,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143/19G
  {  97, 299,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144/19H
  { 277,  42,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145/19J
  { 172, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146/19K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147/19L
  {  75, 294,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148/20A
  { 268,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149/20B
  {  98,  42,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150/20C
  {  67,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151/20D
  { 253,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152/20E
  {  84,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153/20F
  { 100,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154/20G
  { 128,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155/20H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156/21A
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157/21B
  { 207,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158/21C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159/21D
  {  53, 117,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160/21E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 161/21F
  { 273,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162/21G
  { 311, 111,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163/21H
  { 275,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164/21J
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165/21K
  { 282,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166/21L
  { 258,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167/21M
  { 292,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168/22A
  { 128,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169/22B
  { 220,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170/22C
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171/22D
  {  34,  83,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172/22E
  { 123,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173/22F
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174/22G
  { 163,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175/22H
  { 200,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176/22J
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177/22K
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178/22L
  { 137,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179/22M
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180/23A
  { 227,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181/23B
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182/23C
  { 129,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 183/23D
  { 222, 278,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184/23E
  { 126,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185/24A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186/24B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187/24C
  { 232,  80,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188/24D
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189/24E
  {  28,  90,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190/24F
  { 297, 294,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191/24G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192/24H
  { 166,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193/25A
  { 223, 142,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194/25B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195/25C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196/25D
  {  24, 263,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197/25E
  {  73,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198/25F
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199/25G
  {  60,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200/25H
  { 173, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201/25J
  { 287,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202/25K
  { 273,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203/25L
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204/26A
  { 128,  67,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205/26B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206/26C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207/26D
  { 260, 164,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208/26E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209/26F
  { 235,  99,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210/26G
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211/26H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212/28A
  { 247, 140, 201,  -1,  -1,  -1,  -1,  -1 }, // 213/28B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214/28C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215/28D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216/28E
  { 285,  96, 243,  -1,  -1,  -1,  -1,  -1 }, // 217/28F
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218/28G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219/28H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220/28J
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221/28K
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222/28L
  { 168,  76,  11,  -1,  -1,  -1,  -1,  -1 }, // 223/29A
  { 114, 153,  84,  -1,  -1,  -1,  -1,  -1 }, // 224/29B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 225/29C
  {  33, 237, 203,  -1,  -1,  -1,  -1,  -1 }, // 226/29D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 227/29E
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 228/29F
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 229/30A
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 230/30B
  { 273,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 231/30C
  { 288, 171,  -1,  -1,  -1,  -1,  -1,  -1 }, // 232/30D
  { 213,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 233/31A
  { 248,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 234/31B
  {  47,  99,  -1,  -1,  -1,  -1,  -1,  -1 }, // 235/31C
  { 253,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, // 236/31D
  {  65,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 237/31E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 238/31F
  {   3, 156,  -1,  -1,  -1,  -1,  -1,  -1 }, // 239/31G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 240/31H
  { 128,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 241/32A
  { 297, 294,  -1,  -1,  -1,  -1,  -1,  -1 }, // 242/32B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 243/32C
  {  45, 127,  -1,  -1,  -1,  -1,  -1,  -1 }, // 244/32D
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 245/32E
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 246/32F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 247/33A
  {  66, 292,  -1,  -1,  -1,  -1,  -1,  -1 }, // 248/33B
  { 248,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 249/34A
  { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 250/34B
  { 292, 293,  -1,  -1,  -1,  -1,  -1,  -1 }, // 251/34C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 252/34D
  {  93,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 253/34E
  { 101,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 254/34F
  { 290,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 255/34G
  {  86, 131,  -1,  -1,  -1,  -1,  -1,  -1 }, // 256/35A
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 257/35B
  { 202,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 258/35C
  { 229,  68, 283,  -1,  -1,  -1,  -1,  -1 }, // 259/36A
  { 226,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 260/36B
  { 148,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 261/36C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 262/36D
  { 238,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 263/36E
  {  48,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 264/36F
  {  73, 198,  -1,  -1,  -1,  -1,  -1,  -1 }, // 265/36G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 266/36H
  { 268,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 267/36J
  { 179,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 268/37A
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 269/37B
  { 128,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 270/37C
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 271/37D
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 272/37E
  { 203,  12,  -1,  -1,  -1,  -1,  -1,  -1 }, // 273/37F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 274/37G
  { 226,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 275/38A
  { 258,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 276/38B
  { 200, 252,  -1,  -1,  -1,  -1,  -1,  -1 }, // 277/38C
  { 272,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 278/38D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 279/38E
  { 163,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 280/38F
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 281/38G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 282/39A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 283/39B
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 284/39C
  { 197,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 285/39D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 286/39E
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 287/40A
  { 146,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 288/40B
  { 136,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 289/40C
  { 212, 128,  -1,  -1,  -1,  -1,  -1,  -1 }, // 290/40D
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 291/40E
  { 305, 238,  -1,  -1,  -1,  -1,  -1,  -1 }, // 292/40F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 293/40G
  { 113,  55, 261,  -1,  -1,  -1,  -1,  -1 }, // 294/40H
  { 133,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 295/42A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 296/42B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 297/42C
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 298/42D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 299/42E
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 300/42F
  { 230, 313,  -1,  -1,  -1,  -1,  -1,  -1 }, // 301/42G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 302/42H
  { 259, 239,  -1,  -1,  -1,  -1,  -1,  -1 }, // 303/42J
  { 105,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 304/43A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 305/43B
  {  34,  83,  -1,  -1,  -1,  -1,  -1,  -1 }, // 306/43C
  {  53, 145,  -1,  -1,  -1,  -1,  -1,  -1 }, // 307/43D
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 308/44A
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 309/44B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 310/44C
  { 170,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 311/44D
  { 193,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 312/44E
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 313/44F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 314/45A
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 315/45B
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 316/45C
  {   2,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 317/45D
  { 193,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 318/45E
  {  63,  97,  -1,  -1,  -1,  -1,  -1,  -1 }, // 319/45F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 320/45G
};

MODULE STRPTR bw_pix[BW_ROOMS] =
{ "",      //   0
  "bw1",   //   1/1A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw20",  //  20/3C
  "",
  "bw22",  //  22/4A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw38",  //  38/6A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw49",  //  49/7E
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw66",  //  66/9D
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw84",  //  84/11F
  "",
  "bw86",  //  86/12B
  "",
  "",
  "",
  "",
  "",
  "",
  "bw93",  //  93/13A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw102", // 102/15A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw123", // 123/17A
  "",
  "",
  "",
  "",
  "",
  "",
  "bw130", // 130/18A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw155", // 155/20H
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw180", // 180/23A
  "",
  "",
  "",
  "",
  "bw185", // 185/24A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw209", // 209/26F
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw224", // 224/29B
  "",
  "",
  "",
  "",
  "bw229", // 229/30A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw244", // 244/32D
  "",
  "bw246", // 246/32F
  "",
  "",
  "",
  "",
  "bw251", // 251/34C
  "",
  "",
  "",
  "",
  "",
  "",
  "bw258", // 258/35C
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw273", // 273/37F
  "",
  "",
  "",
  "bw277", // 277/38C
  "",
  "",
  "",
  "",
  "bw282", // 282/39A
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw294", // 294/40H
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw306", // 306/43C
  "",
  "",
  "",
  "bw310", // 310/44C
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "bw319", // 319/45F
  "",      // 320
};

IMPORT int                    been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              evil_attacktotal,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, prevroom, module,
                              scaling,
                              spellchosen,
                              theround;
IMPORT       SWORD*           exits;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct LanguageStruct  language[LANGUAGES];

IMPORT void (* enterroom) (void);

MODULE void bw_enterroom(void);
MODULE int bw_getsavelevel(int stat);
MODULE FLAG bw_saved(int attribute);
MODULE void bw_savedrooms(int stat, int yesroom, int noroom);
MODULE void bw_wandering(int eluderoom, FLAG surprised);
MODULE FLAG bw_twosaves(int stat1, int stat2);
MODULE FLAG bw_gamble(void);
MODULE FLAG fled(void);

EXPORT void bw_preinit(void)
{   descs[MODULE_BW]   = bw_desc;
    wanders[MODULE_BW] = bw_wandertext;
}

EXPORT void bw_init(void)
{   int adds,
        i;

    exits     = &bw_exits[0][0];
    enterroom = bw_enterroom;
    for (i = 0; i < BW_ROOMS; i++)
    {   pix[i] = bw_pix[i];
    }

    adds = calc_personaladds(st, lk, dex);
    if   (adds <=  19) scaling = 1;
    elif (adds <=  35) scaling = 2;
    elif (adds <=  57) scaling = 3;
    elif (adds <= 100) scaling = 4;
    else               scaling = 4 + ((adds - 100) / 50); // %% ambiguous wording
}

MODULE void bw_enterroom(void)
{   TRANSIENT int i,
                  parts,
                  result;
    PERSIST   int insects,
                  orcs,
                  spines,
                  wolves;

    switch (room)
    {
    case 1:
        if (class == WIZARD)
        {   give(ORD); // %%: we assume it substitutes for both weapons
        } else
        {   give(873);
            give(DRK); // %%: could do this as a separate item from an ordinary dirk
        }
        if (makelight())
        {   room = 250;
        }
    acase 3:
        create_monsters(505, dice(1) + 3);
        fight();
    acase 4:
        bw_savedrooms(lk, 208, 138);
    acase 7:
        templose_con(dice(3));
        pay_gp_only(gp);
        pay_sp_only(sp);
        pay_cp_only(cp);
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && !isweapon(i) && !isarmour(i)) // %%: it doesn't say what to do about armour. We assume they can keep it.
            {   dropitems(i, items[i].owned);
        }   }
    acase 8:
        templose_con(5);
    acase 9:
        if (spd > 20)
        {   room = 128;
        }
    acase 12:
        bw_savedrooms(lk, 240, 296);
    acase 14:
        if (makelight())
        {   room = 199;
        }
    acase 15:
        bw_savedrooms(con, 302, 291);
    acase 21:
        bw_savedrooms(lk, 193, 312);
    acase 22:
        bw_wandering(-1, FALSE);
    acase 25:
        bw_savedrooms(lk, 52, 246);
    acase 28:
        bw_savedrooms(lk, 116, 43);
    acase 32:
        templose_con(5);
    acase 33:
        give(246);
    acase 37:
        victory(0); // %%: maybe give them the standard 100 ap for completing a module?
    acase 39:
        bw_savedrooms(chr, 91, 298);
    acase 41:
        if (ability[32].known)
        {   room = 4;
        } elif (castspell(-1, TRUE))
        {   ;
        } else
        {   savedrooms(1, lk, 4, 57);
        }
    acase 45:
        if (race == ELF)
        {   room = 165;
        } elif (race == DWARF)
        {   room = 143;
        }
    acase 49:
        race = ANIMAL;
        changerace(); // you're about to "die" anyway, so it is unimportant
    acase 51:
        bw_savedrooms(iq, 84, 122);
    acase 53:
        bw_savedrooms(dex, 213, 233);
    acase 55:
        create_monster(506);
        theround = 0;
        do
        {   if (!bw_saved(dex))
            {   good_takehits(dice(1), TRUE); // %%: does armour help? We assume so.
            }
            oneround();
        } while (countfoes());
    acase 56:
        if (bw_twosaves(dex, st))
        {   room = 32;
        }
    acase 57:
        good_takehits(dice(5), TRUE); // %%: we assume armour helps
    acase 60:
        give_multi(866, insects);
    acase 63:
        bw_savedrooms(chr, 188, 159);
    acase 65:
        give(246);
    acase 66:
        create_monster(507);
        fight();
    acase 68:
        create_monster(508);
        fight();
    acase 69:
        create_monsters(509, 5);
        fight();
    acase 71:
        bw_wandering(276, FALSE);
    acase 73:
        create_monsters(510, dice(1));
        fight();
    acase 75:
        bw_savedrooms(iq, 242, 191);
    acase 76:
        bw_savedrooms(iq, 234, 249);
    acase 82:
        templose_con(dice(3));
    acase 83:
        bw_savedrooms(st, 106, 245);
    acase 86:
        bw_savedrooms(lk, 30, 149);
    acase 87:
        bw_savedrooms(iq, 26, 64);
    acase 88:
        give_multi(867, dice(1) * 10); // %%: they could maybe just be implemented as gp
    acase 89:
        create_monsters(511, spines);
    acase 92:
        bw_wandering(213, FALSE);
    acase 93:
        bw_savedrooms(st, 139, 316);
    acase 94:
        lose_dex(5); // %%: perhaps it should be implemented as a magically reversible impairment
        room = prevroom;
    acase 95:
        create_monster(513);
        fight();
    acase 96:
        bw_savedrooms(lk, 58, 174);
    acase 97:
        lose_chr(5); // %%: perhaps it should be implemented as a magically reversible 12th-level curse
    acase 102:
        give(868); // %%: arguably knowing the Wizard Speech language might substitute for casting SPELL_WZ?
        bw_savedrooms(con, 301, 132);
    acase 103:
        die();
    acase 104:
        gain_st(5);
    acase 105:
        give(726);
    acase 107:
        bw_savedrooms(con, 54, 308);
    acase 109:
        elapse(ONE_YEAR * 10, TRUE);
        victory(0); // %%: maybe give them the standard 100 ap for completing a module?
    acase 111:
        if (bw_twosaves(lk, dex))
        {   room = 19;
        }
    acase 112:
        victory(0); // %%: maybe give them the standard 100 ap for completing a module?
    acase 113:
        bw_savedrooms(iq, 280, 23);
    acase 119:
        if (getyn("Fight (otherwise go around)"))
        {   create_monster(514);
            fight();
            room = 136;
        }
    acase 121:
        give(874);
    acase 123:
        create_monster(515);
        fight();
    acase 125:
        // they were already created earlier
        fight();
    acase 126:
        savedrooms(1, chr, 154, 40);
    acase 127:
        create_monsters(517, 10);
    acase 130:
        bw_savedrooms(con, 59, 221);
    acase 135:
        for (i = 1; i <= 11; i++)
        {   rb_treasure(1);
        }
        give(869);
    acase 136:
        if (makelight())
        {   room = 71;
        }
    acase 137:
        spines = dice(1);
    acase 140:
        dicerooms(186, 14, 186, 14, 186, 14);
    acase 141:
        bw_savedrooms(lk, 163, 240);
    acase 142:
        create_monster(518);
        fight();
    acase 149:
        templose_con(dice(4));
    acase 152:
        gain_st(5); // %%: this should probably be done as a proper item
    acase 153:
        while (!bw_saved(iq))
        {   templose_con(misseditby(bw_getsavelevel(iq), iq));
            bw_wandering(-1, FALSE); // %%: it doesn't say whether this is a fleeable encounter. We assume it isn't.
        }
    acase 154:
        if (bw_twosaves(iq, lk))
        {   room = 236;
        }
    acase 155:
        create_monster(519);
        fight();
    acase 156:
        bw_savedrooms(dex, 108, 15);
    acase 157:
        fight();
    acase 159:
        bw_savedrooms(iq, 144, 228);
    acase 161:
        bw_savedrooms(lk, 248, 246);
    acase 162:
        heal_st(5);
    acase 164:
        if (ability[32].known)
        {   room = 254;
        } elif (castspell(-1, TRUE))
        {   ;
        } else
        {   bw_savedrooms(lk, 254, 275);
        }
    acase 165:
        bw_savedrooms(iq, 173, 81);
    acase 167:
        templose_con(dice(1)); // %%: does armour help? We assume not.
        if (getyn("Stand and watch") && bw_saved(lk))
        {   room = 284;
        }
    acase 168:
        good_takehits(dice(5), TRUE); // %%: does armour help? We assume so.
    acase 169:
        if (getyn("Leap the gap (otherwise turn back)"))
        {   if (bw_twosaves(dex, st))
            {   room = 190;
            } else
            {   room = 82;
        }   }
    acase 173:
        if (!getyn("Fight (otherwise retire)"))
        {   die(); // %%: maybe we should just do victory(0) or similar?
        }
    acase 174:
        destroy(874);
    acase 175:
        good_takehits(dice(3), TRUE);
    acase 178:
        bw_savedrooms(iq, 74, 160);
    acase 180:
        race = GOBLIN;
        changerace(); // you're about to "die" anyway, so it is unimportant
    acase 182:
        if (!bw_saved(lk))
        {   bw_wandering(146, FALSE);
        }
    acase 186:
        bw_savedrooms(lk, 155, 241);
    acase 187:
        bw_savedrooms(iq, 148, 44);
    acase 189:
        create_monsters(516, 3);
        fight();
    acase 192:
        bw_savedrooms(lk, 62, 158);
    acase 193:
        elapse(ONE_HOUR * 4, TRUE); // %%: "several hours"
    acase 195:
        bw_savedrooms(lk, 22, 218);
    acase 196:
        bw_savedrooms(iq, 67, 122);
    acase 198:
        if (bw_twosaves(lk, dex))
        {   room = 170;
        }
    acase 199:
        if (makelight() && bw_twosaves(dex, lk))
        {   room = 281;
        }
    acase 200:
        insects = dice(4);
        create_monsters(520, insects);
        fight();
    acase 201:
        templose_con(2);
    acase 203:
        if (prevroom == 91)
        {   dispose_npcs();
        }
        elapse(ONE_HOUR * 2, TRUE); // "hours"
        if (makelight())
        {   bw_savedrooms(dex, 4, 215);
        } else
        {   if (getyn("Enter in darkness (otherwise leave area)"))
            {   room = 215;
        }   }
    acase 204:
        dicerooms(318, 193, 318, 193, 318, 193);
    acase 207:
        bw_savedrooms(con, 302, 291);
    acase 209:
        create_monsters(521, 2);
        create_monsters(522, 2);
        theround = 0;
        do
        {   oneround();
        } while (countfoes() && theround < 4);
        if (countfoes())
        {   npc[0].con =
            npc[0].mr  =
            npc[1].con =
            npc[1].mr  = 0; // dispose wraiths
            if (countfoes())
            {   fight();
                room = 279;
        }   }
        else
        {   room = 170;
        }
    acase 212:
        bw_savedrooms(dex, 102, 266);
    acase 215:
        bw_savedrooms(lk, 120, 138);
    acase 216:
        bw_savedrooms(dex, 270, 82);
    acase 218:
        create_monsters(516, 3);
        fight();
    acase 219:
        dicerooms(307, 307, 307, 92, 92, 92);
    acase 220:
        victory(10000);
    acase 222:
        dispose_npcs();
    acase 227:
        victory(1500);
    acase 229:
        create_monsters(523, dice(1) + 2);
        fight();
    acase 233:
        bw_wandering(213, FALSE);
    acase 235:
        give(870);
    acase 237:
        create_monster(524);
        theround = 0;
        do
        {   if (!immune_poison() && !bw_saved(dex))
            {   templose_st(5);
            }
            oneround();
        } while (countfoes());
    acase 238:
        bw_savedrooms(lk, 231, 246);
    acase 240:
        bw_savedrooms(dex, 72, 189);
    acase 241:
        create_monster(519);
        evil_freeattack();
        fight();
    acase 243:
        room = prevroom;
    acase 246:
        // %%: maybe we should show them the enemy stats before asking whether to fight/run.
        // %%: maybe we are supposed to let them run during any round of the fight.
        if (getyn("Fight (otherwise run)"))
        {   create_monsters(525, dice(2));
            fight();
        } else
        {   room = 214;
        }
    acase 247:
        bw_savedrooms(con, 104, 177);
    acase 250:
        result = makelight();
        if (result == LIGHT_LANTERN || result == LIGHT_TORCH || result == LIGHT_UWTORCH)
        {   if (bw_twosaves(dex, lk))
            {   room = 35;
        }   }
        elif (result != LIGHT_NONE)
        {   room = 35;
        }
    acase 252:
        bw_savedrooms(chr, 150, 176);
    acase 253:
        if (bw_twosaves(iq, lk))
        {   room = 17;
        }
    acase 255:
        create_monster(526);
        fight();
    acase 258:
        create_monster(527);
        fight();
    acase 260:
        create_monsters(528, 10);
        fight();
    acase 261:
        good_takehits(dice(3), TRUE); // %%: does armour help? We assume so.
    acase 262:
        result = dice(5);
        good_takehits(result, TRUE);
        getsavingthrow(TRUE);
        if (madeit(result, lk))
        {   room = 10;
        } else
        {   room = 110;
        }
    acase 263:
        destroy(874);
    acase 264:
        fight();
    acase 266:
        bw_savedrooms(con, 301, 132);
    acase 268:
        create_monster(512);
        if (!getyn("Fight (otherwise flee)") && fled())
        {   room = 70;
        } else
        {   fight();
        }
    acase 269:
        give(726);
    acase 270:
        if (getyn("Leap across (otherwise go back)"))
        {   if (bw_twosaves(dex, st))
            {   room = 190;
            } else
            {   room = 82;
        }   }
    acase 271:
        bw_wandering(224, FALSE);
        bw_wandering(224, FALSE);
        bw_wandering(224, FALSE);
    acase 273:
        elapse(ONE_DAY * 2, TRUE); // "days"
        templose_con(5);
    acase 274:
        bw_savedrooms(lk, 193, 312);
    acase 275:
        create_monsters(528, 10);
        fight();
    acase 278:
        kill_npcs();
    acase 279:
        bw_savedrooms(iq, 107, 134);
    acase 280:
        give(871);
    acase 281:
        bw_wandering(146, FALSE);
    acase 282:
        orcs = dice(2);
        create_monsters(529, orcs);
        if (getyn("Talk"))
        {   dispose_npcs();
            room = 87;
        } elif (getyn("Surrender"))
        {   dispose_npcs();
            room = 64;
        } elif (!getyn("Fight (otherwise flee)") && fled())
        {   room = 70;
        } else
        {   room = 264;
        }
    acase 283:
        pay_gp_only(gp);
        pay_sp_only(sp);
        pay_cp_only(cp);
        for (i = 0; i < ITEMS; i++)
        {   if (items[i].owned && !isweapon(i))
            {   dropitems(i, items[i].owned);
        }   }
        bw_savedrooms(con, 302, 291);
    acase 285:
        create_monster(530);
        theround = 0;
        do
        {   if (npc[0].mr > 36)
            {   parts = 3;
            } elif (npc[0].mr > 27)
            {   parts = 2;
            } else parts = 1;
            if (saved(parts, dex))
            {   oneround();
            } else
            {   evil_freeattack();
        }   }
        while (countfoes());
    acase 286:
        bw_savedrooms(lk, 121, 211);
    acase 287:
        if (immune_poison())
        {   room = 13;
        }
    acase 288:
        healall_con();
    acase 289:
        bw_wandering(136, FALSE);
    acase 290:
        give(ITEM_BW_DELUXEI);
    acase 292:
        if (makelight())
        {   room = 25;
        }
    acase 293:
        bw_savedrooms(lk, 79, 246);
    acase 295:
        if (!been[295])
        {   wolves = dice(1) + 3;
        }
        if (language[13].fluency && getyn("Speak to wolves")) // %%: there is no Lupine, so we substitute Canine instead. And we assume pidgin is good enough.
        {   room = 78;
        } else
        {   create_monsters(531, wolves);
            if (!getyn("Fight (otherwise flee)") && fled())
            {   room = 13;
            } else
            {   fight();
        }   }
    acase 296:
        create_monsters(516, 3);
        if (getyn("Talk"))
        {   room = 39; // we don't dispose them yet, there may be combat ahead
        } elif (!getyn("Fight (otherwise flee)") && fled())
        {   room = 203;
        } else
        {   room = 157;
        }
    acase 298:
        // they were already created earlier
        fight();
    acase 299:
        create_monster(532);
        theround = 0;
        do
        {   npc_templose_st(0, 5);
            if (npc[0].st >= 10)
            {   oneround();
        }   }
        while (countfoes() && npc[0].st >= 10);
        if (countfoes())
        {   room = 184;
        } else
        {   room = 272;
        }
    acase 300:
        create_monster(533);
        theround = 0;
        do
        {   oneround();
        } while (countfoes() && con >= 5);
        if (con < 5)
        {   dispose_npcs();
            race = ZOMBIE; // %%: well, which is it? Zombie or ghost? We assume zombie.
            changerace(); // you're about to "die" anyway, so it is unimportant
            room = 103;
        }
    acase 302:
        bw_savedrooms(st, 251, 225);
    acase 304:
        if (!bw_gamble())
        {   room = 103;
        }
    acase 305:
        bw_savedrooms(dex, 6, 57);
    acase 307:
        rb_givecoins();
        rb_givecoins();
        give_multi(CLU, orcs); // %%: these could be implemented as special "orc clubs", no real reason to though
    acase 309:
        if (bw_twosaves(dex, st))
        {   room = 119;
        }
    acase 310:
        good_takehits(dice(12), TRUE); // %%: should we do it as two separate dice(6)s?
        bw_savedrooms(dex, 95, 206);
    acase 311:
        create_monsters(521, 2);
        fight(); // %%: SPELL_D9 costs 40 ST. So their ST would go from 59 to 19 and then to -21. So their ST will never be in the 1..5 range.
    acase 312:
        bw_wandering(193, TRUE);
    acase 313:
        if (bw_twosaves(lk, dex))
        {   room = 205;
        }
    acase 314:
        bw_savedrooms(lk, 284, 258);
    acase 315:
        if (cast(SPELL_HF, TRUE))
        {   room = 13;
        } else
        {   race = WEREWOLF;
            changerace();
        }
    acase 317:
        good_takehits(dice(10), TRUE); // %%: does armour help? We assume so.
    acase 318:
        bw_wandering(193, FALSE);
    acase 320:
        bw_savedrooms(chr, 303, 196);
}   }

#define is ==
#define or ||
EXPORT void bw_magicmatrix(void)
{   aprintf(
"`MAGIC MATRIX\n" \
"  When using the Magic Matrix, cross-index over from the spell name (on the left side of the table) to the paragraph number that sent you here (across the top) and read your result. Even if a spell does not work, the spellcaster still loses Strength for *trying* to cast it.\n~"
    );

/* %%: SPELL_TT and SPELL_RS have abbreviations given for them in the key, but no rows on the Matrix itself.
We are assuming that they always take full effect in any paragraph. */

    switch (spellchosen)
    {
    case SPELL_DM:
        if
        (   room is   5 //  1E
         or room is  67 //  9E
         or room is 146 // 19K
         or room is 172 // 22E
         or room is 190 // 24F
         or room is 203 // 25L
         or room is 210 // 26G
         or room is 213 // 28B
         or room is 319 // 45F
        )
        {   aprintf("The answer is yes.\n");
        } elif
        (   room is 128 // 17F
         or room is 166 // 21L
        )
        {   aprintf("The answer is no.\n");
        } else noeffect();
    acase SPELL_WO: // "WOW"
        if
        (   room is 199 // 25G
         or room is 203 // 25L
         or room is 250 // 34B
         or room is 292
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_TF: // "TTYF"
        if
        (   room is   3 //  1C
         or room is  22
         or room is  55
         or room is  66
         or room is  68 // 10A
         or room is  69 // 10B
         or room is  71 // 10D
         or room is  73 // 10F
         or room is  89 // 12E
         or room is  95 // 13C
         or room is 119 // 16H
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 142 // 19F
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 209 // 26F
         or room is 218 // 28G
         or room is 229 // 30A
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 311
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_VB:
        if
        (   room is   3 //  1C
         or room is  22
         or room is  55
         or room is  66
         or room is  71 // 10D
         or room is  73 // 10F
         or room is  89 // 12E
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 142 // 19F
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 218 // 28G
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_CC: // "HH"
        if
        (   room is  41
         or room is  68 // 10A
         or room is  71 // 10D
         or room is 125 // 17C
         or room is 142 // 19F
         or room is 155 // 20H
         or room is 164 // 21J
         or room is 209 // 26F
         or room is 229 // 30A
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 264
         or room is 275
         or room is 281
         or room is 289
         or room is 300
         or room is 311
         or room is 312
         or room is 318
        )
        {   room = 61;
        } else noeffect();
    acase SPELL_CE:
        if
        (   room is 199 // 25G
         or room is 203 // 25L
         or room is 250 // 34B
         or room is 292
        )
        {   room = 49;
        } else noeffect();
    acase SPELL_EH: // "W"
        if
        (   room is   3 //  1C
         or room is  22
         or room is  55
         or room is  66
         or room is  69 // 10B
         or room is  71 // 10D
         or room is  73 // 10F
         or room is  89 // 12E
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 142 // 19F
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 218 // 28G
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_BP:
        if
        (   room is   3 //  1C
         or room is  22
         or room is  55
         or room is  66
         or room is  69 // 10B
         or room is  71 // 10D
         or room is  73 // 10F
         or room is  89 // 12E
         or room is  95 // 13C
         or room is 119 // 16H
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 209 // 26F
         or room is 218 // 28G
         or room is 229 // 30A
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 311
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_IF: // "FP"
        if
        (   room is   3 //  1C
         or room is  55
         or room is  66
         or room is  68 // 10A
         or room is  69 // 10B
         or room is  71 // 10D
         or room is  73 // 10F
         or room is  89 // 12E
         or room is  95 // 13C
         or room is 119 // 16H
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 142 // 19F
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 209 // 26F
         or room is 218 // 28G
         or room is 229 // 30A
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 311
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_SE: // "SS"
        if
        (   room is   5 //  1E
         or room is 128 // 17F
         or room is 166 // 21L
         or room is 190 // 24F
         or room is 210 // 26G
         or room is 213 // 28B
        )
        {   room  = 94; // 13B
        } elif (room is 67) // 9E
        {   room = 169; // 22B
        } elif (room is 146) // 19K
        {   room = 306; // 43C
        } else noeffect();
    acase SPELL_ZA: // "ZT"
        if
        (   room is   3 //  1C
         or room is  22
         or room is  66
         or room is  73 // 10F
         or room is  89 // 12E
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 218 // 28G
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_ZP: // "ZA"
        if
        (   room is   3 //  1C
         or room is  22
         or room is  66
         or room is  68 // 10A
         or room is  73 // 10F
         or room is  89 // 12E
         or room is  95 // 13C
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 142 // 19F
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 209 // 26F
         or room is 218 // 28G
         or room is 229 // 30A
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 311
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_D9: // "DS"
        if
        (   room is   3 //  1C
         or room is  22
         or room is  66
         or room is  89 // 12E
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 218 // 28G
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_HB:
        if
        (   room is   3 //  1C
         or room is  22
         or room is  66
         or room is  68 // 10A
         or room is  69 // 10B
         or room is  73 // 10F
         or room is  89 // 12E
         or room is  95 // 13C
         or room is 119 // 16H
         or room is 123 // 17A
         or room is 125 // 17C
         or room is 127 // 17E
         or room is 142 // 19F
         or room is 155 // 20H
         or room is 157 // 21B
         or room is 189 // 24E
         or room is 200 // 25H
         or room is 209 // 26F
         or room is 218 // 28G
         or room is 229 // 30A
         or room is 237 // 31E
         or room is 241 // 32A
         or room is 246 // 32F
         or room is 255 // 34G
         or room is 258 // 35C
         or room is 260 // 36B
         or room is 264
         or room is 268
         or room is 271
         or room is 275
         or room is 281
         or room is 289
         or room is 295
         or room is 298
         or room is 299
         or room is 300
         or room is 311
         or room is 312
         or room is 318
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_RS: // "PB"
    case SPELL_TT: // "TBT"
    case SPELL_HF: // %%: mentioned in paragraph #315 so we allow it
    case SPELL_WZ: // %%: mentioned in paragraph #102 so we allow it
        fulleffect();
    adefault:
        noeffect();
}   }

MODULE int bw_getsavelevel(int stat)
{   int divisor,
        savelevel;

    if   (stat <  10) return 0;

    if   (stat <= 19) divisor = 10;
    elif (stat <= 35) divisor =  8;
    elif (stat <= 57) divisor =  6;
    else              divisor =  5;
    savelevel = stat / divisor;
    if (stat % divisor)
    {   savelevel++;
    }
    return savelevel;
}

MODULE FLAG bw_saved(int attribute)
{   return saved(bw_getsavelevel(attribute), attribute);
}

MODULE FLAG bw_twosaves(int stat1, int stat2)
{   if (bw_saved(stat1))
    {   if (bw_saved(stat2))
        {   return TRUE;
    }   }
    else
    {   DISCARD bw_saved(stat2);
    }
    return FALSE;
}

MODULE void bw_savedrooms(int stat, int yesroom, int noroom)
{   if (bw_saved(stat))
    {   if (yesroom == -1)
        {   die();
        } else
        {   room = yesroom;
    }   }
    else
    {   if (noroom == -1)
        {   die();
        } else
        {   room = noroom;
}   }   }

MODULE void bw_wandering(int eluderoom, FLAG surprised)
{   int whichwp;

    aprintf(
"WANDERING MONSTER TABLE\n" \
"  Roll 2 dice and fight or flee from the monster(s) rolled. If you fight and win, go to the paragraph that sent you here and follow the instructions supplied. If you fight and lose, go to {103}. If you wish to run from the monster(s) and the paragraph that sent you here allows it, go to {147}, then return to the paragraph that sent you here and follow the instructions.\n"
    );

    whichwp = dice(2) - 2;
    aprintf("%s\n", bw_wandertext[whichwp]);

    switch (whichwp)
    {
    case   0: create_monsters(494, anydice(1, 3) + 2);
    acase  1: create_monsters(495, dice(4));
    acase  2: create_monsters(496, 1);
    acase  3: create_monsters(497, anydice(1, 2));
    acase  4: create_monsters(498, dice(2));
    acase  5: create_monsters(499, 1);
    acase  6: create_monsters(500, anydice(1, 3) + 2);
    acase  7: create_monsters(501, dice(1) + 4);
    acase  8: create_monsters(502, 1);
    acase  9: create_monsters(503, anydice(1, 3) + 1);
    acase 10: create_monsters(504, dice(1) + 3);
    }

    if (surprised)
    {   evil_freeattack();
    }

    if (eluderoom != -1 && !getyn("Fight (otherwise flee)") && fled())
    {   room = eluderoom;
    } else
    {   fight();
}   }

MODULE FLAG bw_gamble(void)
{   int dice1,
        dice2,
        lost   = 0,
        rounds = 1,
        won    = 0;

    do
    {   aprintf("Round %d:\n", rounds);
        dice1 = dice(2);
        dice2 = dice(2);
        if (dice1 == 2 || dice1 == 12)
        {   if (dice2 != 2 && dice2 != 12)
            {   aprintf("You lost.\n");
                lost++;
                rounds++;
            } else
            {   aprintf("A draw!\n");
        }   }
        else
        {   if (dice2 == 2 || dice2 == 12 || dice1 > dice2)
            {   aprintf("You won.\n");
                won++;
                rounds++;
            } elif (dice1 < dice2)
            {   aprintf("You lost.\n");
                lost++;
                rounds++;
            } else
            {   aprintf("A draw!\n");
    }   }   }
    while (rounds <= 3);

    if (won > lost) return TRUE; else return FALSE; // won == lost can never happen with an odd number of rounds
}

/* %%:
 Paragraph #1 seems to imply that the character can't take their own possessions into the
  adventure.
 When it says it is dawn or whatever, we should perhaps move the clock forwards correspondingly.
 Some of the unfortunate polymorphing arguably shouldn't be fatal, eg. paragraphs #49 and #180.
 Various monsters are described as having certain weapons and/or armour, but stats for those
  items are generally not given, nor is the player given an explicit chance to loot them.
 It doesn't say how often to recalculate the Combat Chart (we just do it once, at the start of
  the adventure).

These paragraphs are explicitly castable ones:
  5
 67
128
146
166
172
190
199
210
213
226
250
319
*/

MODULE FLAG fled(void)
{   aprintf("#147:\n%s\n\n", descs[MODULE_BW][147]);
    // %%: should we increase time by 10 mins (and then another 10 when returning to previous paragraph)?

    if
    (   spd > npc[0].spd + (npc[0].spd / 2)
     || bw_twosaves(dex, lk)
    )
    {   dispose_npcs();
        while (!bw_saved(iq))
        {   templose_con(misseditby(bw_getsavelevel(iq), iq));
            bw_wandering(-1, FALSE); // %%: it doesn't say whether this is a fleeable encounter. We assume it isn't.
        }
        return TRUE;
    } else
    {   return FALSE;
}   }
