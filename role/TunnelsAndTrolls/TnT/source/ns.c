#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Official errata:
Paragraph 148 (page 59): "Go to {156}" should be "Go to {188}".

More errata:
101: it says "L8-SR on Luck (50 - LK)". We assume they meant "L7-SR on Luck (50 - LK)."
120: it says "10 - Luck" for the saving roll. We assume they meant "20 - Luck".
214: it says "go back to {156}." We assume they meant "go back to {196}".
*/

MODULE const STRPTR ns_desc[NS_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  Sorcerer Solitaire is an adventure for mages exclusively. Non-mages will have a lot of trouble with most of the adventures and will almost certainly die horribly. Your character should be no higher than level 3 and should have no more than 30 combat adds.\n" \
"  Any time that you are told that you can rest for a number of turns you may cast healing spells on yourself if you need to, however remembering that the Strength you use must be restored by rest during this time.\n" \
"  Any time at all you may cast Will-o-wisp for light unless the paragraph you are at negates this spell.\n" \
"  In any combat you may cast Take That You Fiend or Blasting Power as your attack. This will negate the necessity of referring to the Magic Matrix every time.\n" \
"  Several times you will be told that you restore one or more Constitution points spontaneously during the adventure. This is because of the intervention of good spirits on your behalf. It should not be depended on for healing, but it might help out in some situations.\n" \
"  Always remember to write down the paragraph you came from when referring to the Magic Matrix. You will not always be told which paragraph to return to even though you may have to do so.\n" \
"  I hope that you enjoy your adventures in Sorcerer Solitaire. Good delving.\n" \
"~INTRODUCTION\n" \
"  The rain on the slates covering the east wing of the Aged One's Sanctum beats a strange rhythmic counterpoint to your thoughts as you travel the full length of the Hall of Contemplation. The Master's summons had been no surprise. He recently interviewed several young magi. You assumed that the Aged One was searching for an apprentice to replace you. After three long years of study and work it is time for your ascension to journeyman mage status.\n" \
"  The great doors at the terminus of the hall open at a word of command from within before you can touch the opening lever. You hear the Master's voice from inside.\n" \
"  \"Come in, my friend. I welcome you to my study.\" The Aged One looks much the same as he did three years ago when you interviewed for your apprenticeship. According to legend among the servants and students who live and work and study in the sanctum the Master has looked this way for all time. With magic as a factor it is impossible to discount this rumour.\n" \
"  \"As you know I have recently undertaken a second apprentice magician. I did this in order that you might advance to the journeyman level of study. I trust that this is something that you wish to do?\" This question was purely rhetorical. Your life has had this goal as its focus for the last half a decade.\n" \
"  \"Taranwn Wildchild will serve me from this point on. You must undertake a quest to commence your journey into the more esoteric realms of knowledge which a journeyman must master.\" A quest! Of all the methods open to the advancing apprentice, the quest was the most arduous! If the Aged One has chosen the quest, then he must indeed think highly of his former apprentice!\n" \
"  \"After much reflection I have found a suitable quest. You must go to the village of River's Edge where you will contact Kessel Joris, a local hunter. Kessel will guide you to a large manor located in the forest north of town.\n" \
"  \"Vaning Manor, as the locals call it, has been vacant for the last fifty years. I know some of the history of the place. The last Lord Vaning died soon after it was constructed. He, his new bride, and all his servants fell prey to a strange, creeping malaise. No one could understand what was happening. Now I fear that the evil is returning to Vaning Manor. I want you to find out what is going on and do whatever you can do to stop it.\n" \
"  \"Further, the Princess Nanus of Robert's Hold recently disappeared near the manor. I can't help but think that the two are interrelated. I hear that there is a large reward for the safe return of the princess.\"\n" \
"  After taking your leave of the Aged One you set out on your journey. Kessel Joris proves easy to find, and you set out for Vaning Manor with your somewhat surly guide. Go to {1}."
},
{ // 1
"The night winds howl an evil refrain to your thoughts as deep velvet clouds hide the green and gibbous moon from your sight. Weird night creatures prowl the fog-cloaked clearing your guide has chosen to stop in. He pauses to take a pull out of a small silver flask produced with notable dexterity from his back pocket. \"Nasty night out, eh? You ain't gonna find Kessel Joris goin' no closer to yon evil digs! I ain't paid ta get myself grabbed by no ghosties nor ghoulies!\"\n" \
"  With a last gulp from his flask, the grizzled old man drops your pack at your feet and takes shelter under a gnarled and mossy oak tree. \"I'll await your return, mage. If you ain't out by daybreak I leave. Good luck, you'll need it!\"\n" \
"  Taking up your pack, you walk on down the path until you come to an old, half-rusted and fallen gate. The words \"Vaning House\" can still be read, worked in wrought iron over the gateway. Flashes of lightning illuminate the ancient and sprawling ruin that was once the home of one of the most influential families in the kingdom. Now, it is nothing but a ruin rumoured to be the home of ghosts and worse. Pondering thoughts of mortality and the fallen mighty, you approach the manse.\n" \
"  The building storm sends blinding bolts of lightning to the ground. In this uncertain light you can make out the wooden shutters nailed over the windows of the house. The crumbling steps lead up to the front door which is sealed by a heavy padlock and chain.\n" \
"  An Unlock spell makes short work of the padlock (subtract the Strength). Lightning strikes a tree nearby, a formidable reminder of the coming storm. If you wish to make a foray into the unknown dangers of Vaning House, go to {8}. If you choose to remain on the front steps, go to {15}."
},
{ // 2
"As you approach the skull it brightens: its radiance fills the room. You can feel yourself changing, your skin grows hot, your bones creak and your muscles burn. Falling to the floor in agony, you wonder if you can survive this metamorphosis. What seems like hours later you begin to rise, a new being. Roll 1d6 and consult the following table.\n" \
"    1: Go to {29}\n" \
"    2: Go to {36}\n" \
"    3: Go to {43}\n" \
"    4: Go to {49}\n" \
"    5: Go to {10}\n" \
"    6: Go to {17}\n" \
"The shards of the now-destroyed skull litter the table upon which it sat. Go to {45}."
},
{ // 3
"Make a L1-SR on Luck (20 - LK). If you miss this roll, go to {23}. If you make the roll, you will travel down the corridor in the dark without noticing anything. If you make the roll, go to {16}."
},
{ // 4
"You wait for a short time, then you hear the troll's boots as he returns. You may cast magic by going to the Magic Matrix (note this paragraph so you can return here when you're done), or you may ready a weapon and go to {18}."
},
{ // 5
"The magic of your spell reveals a concealed door on the wall across the landing from you. You may flee through the hidden door by going to {161}, or you may return to {24} and take some other option excepting that you will not have time to cast another spell."
},
{ // 6
"\"Moooooooaan!\" the ghost cries out, agony distorting his already ghastly features. His fingers clutch at you, cold waves coming from the dead digits. \"Ooooohhh! You shall pay for this!\" The ghost will disappear before you can attack again unless you can make a Dexterity saving roll against his Speed (28 - DEX). If you miss, he gets away, and may return to plague you at another time. If you make the roll, you will get off your second Take That You Fiend. Return to {48} and continue from there."
},
{ // 7
"With very little warning a squid-like demon materializes out of the ceiling of the room. Your mind flashes to a lecture your master delivered when you were an apprentice magician: \"Gopher, you must beware the danger of searching another magician's sanctum. Given enough time and motivation any wizard can summon all manner of horrible spirit, demon, devil and monster to act as a guardian. These guardians are sometimes very powerful, and you would be hard put to defeat them if you are taken by surprise. Always check to see if these things are present before you do any other thing!\"\n" \
"  Your homey flashback is interrupted by the squid-demon ripping you limb from limb. Close the book. You have died."
},
{ // 8
"The door opens with a protesting shriek of tortured metal. You enter a dark foyer. In the afterglow of the lightning you can see a dimly glowing skull resting on an ornate pedestal in the centre of the room. Behind the skull you can make out a stairway leading up. To your right and left are doorways. The floor is littered with the rotten remains of wall hangings and fabric furniture. Mice and insects scurry about underfoot. A musty odour permeates the atmosphere.\n" \
"  Suddenly, with a sound like the crack of doom, the door behind you slams shut. Turning back, you find it jammed firmly into its casing. If you would like to cast magic, consult the Magic Matrix. If you want to go upstairs, go to {21}. If you go through the door on the left, go to {28}. If you go through the door on the right, go to {34}. If you approach the skull, go to {2}."
},
{ // 9
"You slip when the step breaks, but manage to catch yourself before you suffer serious injury. In the dark beneath the stairs you see a bit of glittering something. Reaching into the cobweb festooned space you pluck a golden ring from its hiding place. Casting a Detect Magic you determine that the ring is magical. It will cast the Restoration spell, restoring 10 points of lost Constitution. (10 uses of 1 CON restored per use or 1 use of 10 CON restored, your choice.) Afterwards, the ring can be sold for 30 gp. Go to {24}."
},
{ // 10
"You have become noticeably more beautiful and graceful. Subtract 3 each from your Constitution and Strength, and add 5 each to your Charisma and Dexterity. Go to {45}."
},
{ // 11
"You begin to carefully sneak out of the closet. Make a L2-SR on Luck (25 - LK). If you make the roll, go to {25}. If you fail, go to {31}."
},
{ // 12
"You can see nothing on the stairs, however a chilling wind suddenly envelops your body. Make a L1-SR on Constitution (20 - CON). If you make it, go to {19}. If you miss, go to {26}."
},
{ // 13
"Out of the corner of your eye you spot a squid-like demon materializing. You realize that you are about to be attacked by a powerful guardian demon of unknown power and ability.\n" \
"  Instantly your mystic training takes effect, justifying all those hours of gruelling practice with tongue twisting dead languages! \"Buttafingga!\" you shout. \"Nottafingga! Gorrudicadma!\" These mystic words have an instant effect! The demon hesitates, leaving you a few seconds to escape the room. Make a L1-SR on Luck (20 - LK). If you make it, go to {52}. If you miss, go to {60}."
},
{ // 14
"The second step you take sags, then with a groan, breaks under your weight. Take damage equal to the number you missed the saving roll by. If you die, close the book. Otherwise, you crawl out of the ruins of the stairs and continue on up without further incident. Go to {24}."
},
{ // 15
"The lightning flashes come fast and furious, the sky continually lit as the storm rages across the night sky. Thunder drowns out all other noises. The small creatures of the night run for the dubious safety of their burrows and nests. Too late, you realize your danger. A bolt of lightning streaks down out of the clouds like the finger of fate. Make a L1-SR on your Dexterity (20 - DEX) to see if you are struck. If you miss the saving roll, you will have to take 10 points of damage on your Constitution. If you survive, go to {1} and try another option. If you did not survive, you provide a much needed meal for the little forest critters."
},
{ // 16
"Darkness cloaks you in its anonymity. Small creatures cry out as you pass by and sometimes on them. After a time you come to a bend in the corridor. The sounds you have been hearing all along resolve themselves into incoherent muttering and clicking. Go to {35} and ignore the first few sentences."
},
{ // 17
"You have become somewhat taller and grown fur similar to that of a mountain lion. You further notice that you can see quite well - even in the dimness of this room. Subtract 2 from your Charisma now that you are a cat person. Add 3 to your Dexterity and go to {45}."
},
{ // 18
"This ominous beast of a troll charges you, showing every bit of his ferocity and tenacity. You may consult the Magic Matrix to cast magic by writing down your spell and going to its arcane listing.\n" \
"  The troll has a Monster Rating of 30, which gives him 3 dice and 15 adds in combat. He uses his hands in combat, and is able to absorb 2 hits of damage in the skins and hair that cover his body. He will continue to fight until he has taken at least 15 points of damage, at which point his true nature will show through. This troll is a bully! He will cut and run at this point, giving you a last, free shot at him. If you survive the troll's savage attack, go to {221}. If you are killed, close the book."
},
{ // 19
"You shiver, but nothing bad happens. Return to {24} and take a choice you have not yet taken."
},
{ // 20
"These books contain information on sorcery, enchanting, necromancy, numerology, demonology, conjuration and a hundred other arcane subjects. You reach to take one down from the shelf in order to flip through its bounty of lore. Make a L3-SR on Intelligence (30 - IQ). If you make it, go to {61}. If you miss it, go to {7}."
},
{ // 21
"The first step creaks threateningly under your weight. The second step sags precipitously. You begin to realize that this stairway is a death trap. Make a L1-SR on Luck (20 - LK). If you make the roll, go to {9}. If you missed your saving roll, go to {14}."
},
{ // 22
"The closer you come to the end of the passage the louder the rumbling becomes. You can now smell a noxious, rank odour. Suddenly it comes to you: what you smell is unwashed troll. What you hear is hungry troll. You are now only a few feet from the source of the odorous and ominous rumbling! If you wish to cast any defensive magic, you may do so by consulting the Magic Matrix. When you are finished, go to {31}."
},
{ // 23
"You walk slowly down the corridor, trusting in your luck to guide you safely toward the light at the ends. Your heartbeat seems to reverberate with pent-up tension. Your breathing comes fast. You seem to imagine a hundred noisome critters sneaking up on you from every direction. When your doom finally comes, it is almost anti-climatic!\n" \
"  A single sharp click sounds. A grinding sends your nerves into a fever pitch. You turn to run! But you never get your step completed. A sharp spike strikes you just above the fourth vertebra, rips through your vitals, and protrudes sickeningly from your chest.\n" \
"  As the trap slowly begins to recycle, you wonder what it was doing in a hallway in a house anyway! The only way you will know is to haunt this home of death! Close the book."
},
{ // 24
"At the top of the stairs is a small landing. As you come onto the landing a chill envelops you and the faint illumination that is a natural feature of the house dims. (You may make a light if you wish. Cateyes will work.)\n" \
"  Laughter slinks up the stairway from below and chains clink in the distance. An eerie feeling of dread begins to creep up your spine like a spider on a web of bone.\n" \
"  You see an iron-bound door across from you. If you wish to cast an Unlock spell at the door, go to {51}. If you wish to cast a Revelation, go to {5}. If you look back down the stairs to see what is coming up them, go to {12}."
},
{ // 25
"You are able to elude the noxious troll. Take 85 adventure points and go to {38}."
},
{ // 26
"You shiver, your teeth snapping against each other, your breath coming in harsh gulps. You lose 1d6 from your Constitution from the intense cold. Return to {24} and take a choice you have not yet taken."
},
{ // 27
"The beakers, bottles and vials contain all manner of interesting stuff; mummified lizard tails, crushed ant mandibles, dried mandrake root! You have discovered a veritable storehouse of alchemical ingredients! You begin to root through the stuff on the table with greedy abandon!\n" \
"  Suddenly, out of the corner of your eye, you spot a squid-like demon materializing. Your realize that you are are about to be attacked by a powerful guardian demon of unknown power and ability.\n" \
"  Instantly your mystic training takes effect, justifying all those hours of gruelling practice with tongue twisting dead languages! \"Buttafingga!\" you shout. \"Nottafingga! Gorrudicadma!\" These mystic words have an instant effect! The demon hesitates, leaving you a few seconds to escape the room. Make a L1-SR on Luck (20 - LK). If you make it, go to {67}. If you miss, go to {60}."
},
{ // 28 %%: it says "do a Revelation spell", but we just say "do a spell", because there are other allowed spells here
"You stumble, falling through the rotten floor of Vaning House. Dust and debris cushion your fall, preventing you from taking any damage. You find yourself in one of the basements of the old house. The way back up is blocked by wreckage. You can proceed down a short tunnel-like hallway. There is sufficient light coming from the far end for you to see vague shapes. Several small furry creatures with long tails scurry away at your approach. Large bones litter the floor. You think that they might be human bones. The hallway grows suddenly cold and dark. You can hear something growling, coming toward you from the opposite end of the passage. You have only two choices: you can search the tunnel, or wait to see what is at the other end. If you do a spell, go to the Magic Matrix. If you search the corridor without using magic, go to {152}. If you prefer to make your way through the bone littered passage without searching, go to {22}."
},
{ // 29
"You change your outward racial aspect - thus, you would look like the racial type indicated, but not have any of the attribute adjustments listed under the racial attribute modification table. Roll 1d6 on this table:\n" \
"    1-3 = Human\n" \
"    4-5 = Elf\n" \
"     6  = Orc\n" \
"(If you roll your own race, then you lucked out and do not change.) Go to {45}."
},
{ // 30
"You hear a rushing sound from behind you as you turn to go. A huge, hairy, warty green arm reaches over your shoulder and grabs your throat. As you gasp for breath, you feel a sudden sharp pain on the back of your head, and then all is black. Too bad, so sad. Never turn your back on an unusual growling sound. You can never tell what it might be. Go to {37}."
},
{ // 31
"Terror grips you heart as you see an immense green troll dead ahead. It very nearly blocks the passageway. It moves toward you, its malformed skull scraping the ceiling, its hairy arms like moss covered tree limbs, its legs like the gnarley old trunks of old growth oaks. The only way you can pass is between the troll's massive legs. Consult the Magic Matrix if you intend to cast magic, then go to {18} to adjudicate the effects of your spell. Don't forget to write down which spell you wish to cast before going to the Magic Matrix. (Make a note of this paragraph so that you may return here if directed to do so.) If you think your tongue is more powerful than the troll's pea-sized brain and attempt communication, go to {126}. If you draw your puny weapons and try to fight the malodorous green beast, go to {18}."
},
{ // 32
"You find that the boiler chamber is full of some sort of liquid. The tubing runs through several condensation devices, and terminates in an empty wooden barrel. You are familiar with the concept of the boiler system and are sure that you could start up the distillation machine. You waste no time starting the fire.\n" \
"  Make a L3-SR on Intelligence (30 - IQ). If you make your roll, go to {13}. If you miss your roll, go to {7}."
},
{ // 33
"You find yourself in a large trash-cluttered room. Along one wall a narrow table has been set up. On the table you see several boxes, beakers, wooden casks and small bottles. In the centre of the room is a larger table set up with what looks like several metres of copper tubing running from a boiler chamber and terminating over an overflow vat. Bookshelves line the wall to your left, covered with many tomes of unknown lore.\n" \
"  This room is considerably warmer than the corridor outside. You may elect to investigate the books by going to {20}, you may check out the centre table by going to {32}, you may investigate the work table on the far wall by going to {40}, you may cast Detect Magic by going to {47}, or you may cast Revelation by going to {53}."
},
{ // 34
"The door leads into a small room once used to hang cloaks and store muddy boots. A servant's door opens into a long corridor. You can hear some noises coming from the end of the hallway, as well as seeing some dim source of light. You may cast a Will-o-Wisp spell and continue to {35}, or you can take advantage of the darkness and sneak forward by going to {3}."
},
{ // 35
"The dim light of the flickering Will-o-Wisp reveals a corridor strewn with trash, dust-balls and small animal bones. You can see tracks in the dust ahead of you, alerting you to the fact that you are not alone in this vile house. As you walk the noises you heard resolve themselves into clinking and muttering. Rounding a bend you come face to face with a sorry figure of a man!\n" \
"  Scars cover what little of his face you can see under the darkly brooding slouch hat that he wears jauntily cocked over on one side. His rags - you hesitate to call them clothes - seem to have seen better decades. You give an involuntary start as his croaking voice hails you, \"Hoy, guv'ner! What brings a fine young mage such as yourself to these sorry digs?\"\n" \
"  Your hand nervously begins the finger motions for a potent spell of repulsion, but you stay your spell as he continues, \"Sir, I been lost in this terror hole for well nigh unto a week! I tell you, I'm so hungry I could eat a rat - and I can assure you, I have already dined on the scrawny vermin that pass for rats in this pestilential place, and they don't fill me up none too well!\n" \
"  If you wish to continue your conversation with the ragamuffin man, go to {123}. If you strike out at him with your weapons for his impudent behaviour, go to {130}. If you elect to brush by him, ignoring him in grand big city style, go to {138}. If you want to cast magic, write down your spell and consult the Magic Matrix."
},
{ // 36
"You grow fangs and a tail. [Your bite will now do 1d6 of damage plus your combat adds. ]Your tail is prehensile and may be used to grip small, light objects. [It may manipulate objects with one half of your normal Dexterity. ]Subtract 5 points from your Charisma, however, due to your demonic appearance. Go to {45}."
},
{ // 37
"With a groan fit to wake the dead you slug your way out of the black limbo of pain induced coma. The rustling of small clawed paws gives testament to the presence of life nearby. You seem to be in a very dark room. Musty odours of decay and neglect assail your nose. If you have a way of seeing in the dark or making a light, go to {44}. If you want to feel your way around, go to {50}."
},
{ // 38
"The area succumbs to a serene silence. Moss clings to the damp cold clay walls. You have the option of waiting here or you may continue. If you decide to wait here for 5 turns, go to {120}. If you prefer to leave, go to {127}."
},
{ // 39
"Make a L2-SR on Luck (25 - LK). If you make it, go to {67}. If you miss, go to {75}."
},
{ // 40
"You begin to poke around the work table, opening bottles and sniffing at beakers. Make a L3-SR on Intelligence (30 - IQ). If you make it, go to {27}. If you miss, go to {7}."
},
{ // 41
"You pull up the ring, which reveals a trapdoor set in the floor. Hastily you descend to the room below the magic laboratory.\n" \
"  This room is a bedroom. From the richness of the furnishings and the tapestries on the wall you conclude that it must have belonged to Lord Vaning himself! As you stand looking about yourself a strange light emanates from the bed. Before your eyes a young woman appears. She lifts her ethereally beautiful, brown-tressed head from the pillow and addresses you, \"I am Charlotte, Lady Vaning. Will you help me?\"\n" \
"  If you wish to help Lady Charlotte, go to {63}. If you wish to leave the room via the secret entrance, go to {76}."
},
{ // 42
"A diminished, shrivelled husk of a ghost comes face to face with you. The ghost's reddish beard seems to brush either side of the landing, as well as the ceiling and floor! Chains hang from the ghost's wrists and ankles, clinking as he moves.\n" \
"  \"Beware!\" it shrieks! \"Beware the curse of Krwonsku the Blood Drinker! He shall surely destroy you as he destroyed all of us!\"\n" \
"  If you wish to heed the ghost's warning and run from the house, you may do so by charging back down the stairs at {66}. If you choose to cast a Take That You Fiend at the ghost, go to {48}. If you wish to ignore the ghost and go into the room, go to {33}."
},
{ // 43
"Your skin is now lightly scaled, much like a snake's. You are considered to have 1 point of armour protection over your entire body. Subtract 3 points of Charisma because, though these scales are rather pretty, they are also rather frightening to those with a fear of reptiles. Go to {45}."
},
{ // 44
"You see that you are in a small room, about the size of a large closet or utility room. On the walls are hooks, festooned with decaying clothing. The floors are covered with trash and littered with the bones of small animals. You avoid the nest of a brooding rat and go directly to the door, which opens into a hallway: the same one, in fact, that you were in when the troll grabbed you. You can only guess that he dumped you into the closet for a later snack. You may stay in the closet, hoping to ambush the burly being on his return by going to {4}, or you can cast magic by going to the Magic Matrix (note this paragraph so you can return here when you are done), or you can try to sneak out by going to {11}."
},
{ // 45
"The room is now dark. Shards of the crystal skull litter the floor, crunching under your feet as you walk. If you go up the staircase, go to {21}. If you go through the door on the left, go to {28}. If you go through the door on the right, go to {34}."
},
{ // 46
"As the ghoul's life's blood slowly stains the worn floorboards you notice that it was carrying a small amulet around its neck. Bending down you take the amulet, which explodes in a burst of magical energy.\n" \
"  The magical power released from the amulet will grant you +1d6 Cold Touch anytime you wish to use bare hands in combat. [This Cold Touch will always score damage on any normal armour: unfortunately magic armour will block it. ]You may take 68 ap for killing the ghoul.\n" \
"  Turning away, you get no more than a few paces before you come face to face with a frightening creature from beyond the grave (so what else is new). As it floats down out of the ceiling go to {83} ignoring the first sentence of {83}."
},
{ // 47
"You cast Detect Magic and sense that this place is a place of greatly evil magic. Much that was horrible went on here! You sense a malefic presence nearby. If you wish to cast Revelation, go to {53}. If you wish to leave the room, do so by going to {39}."
},
{ // 48
"The ghost will get one attack off against you while you are casting your spell. Reduce your Strength by one half, then resolve the combat as listed below. If you killed the ghost, go to {55}. If you failed to kill the ghost with your first Take That You Fiend, go to {6}.\n" \
"  The ghost has the following statistics:\n" \
"    Strength:     0\n" \
"    Intelligence: 11\n" \
"    Luck:         18\n" \
"    Constitution: 22\n" \
"    Dexterity:    0\n" \
"    Charisma:     22\n" \
"    Speed:        28\n" \
"[The ghost is very vulnerable to Take That You Fiend spells. You will get an additional one half of your IQ in hits against the ghost.\n" \
"]  Each round the ghost attacks he must make a saving roll on IQ against your Dexterity or your Speed rating, whichever is higher (SPD or DEX - IQ of 11). If the ghost makes this roll he will touch you and you will lose half of your Strength. When you reach a Strength below 1 you will die. If you die, close the book. If you live, go to {55}."
},
{ // 49
"You have grown noticeably more muscular. Add 5 to your Strength. However, you have also grown somewhat clumsy because of the extra musculature. Subtract 3 from your Dexterity. Go to {45}."
},
{ // 50
"You feel trash, small bones, and the furless tail of an irate mother rat. Your scream of pain as her teeth gnash your flesh alters the troll, who returns to finish the job he started earlier. Close the book."
},
{ // 51
"With a click, clearly audible in the sudden silence of the now quite chilly landing, the door swings open. Sepulchral groans and moans envelop you.\n" \
"  You may rush into the room blindly and slam the door shut behind you by going to {33} or you can turn and see what is causing all the commotion by going to {42}."
},
{ // 52
"As you search frantically for a way out you notice a gold ring set in the floor of the room. If you wish to pull it up, go to {41}. If you wish to search further, go to {54}."
},
{ // 53
"You cast your Revelation and instantly a horrific demon becomes visible. It is connected by tendrils of energy to each and every thing in this room. You realize that it is a guardian demon. If anything is disturbed, the demon will attack. Otherwise, it will leave you alone.\n" \
"  If you decide to take something anyway, go to {7}. If you decide to just leave, go to {39}."
},
{ // 54
"While you are searching, the spell holding the demon in stasis wears off. Go to {7}."
},
{ // 55
"As the ghost's ectoplasmic remains dissipate into the nether planes you are left with its meagre material possessions: a small golden earring worth 15 gp, and a short length of silver chain worth 1 gp. You may take 65 ap for dissipating this noisy revenant.\n" \
"  You may rest for 10 turns after this battle, during which time all the Strength sucked away by the ghost will return, along with any Strength you used to cast spells.\n" \
"  While you rest you notice a trapdoor in the ceiling. You may investigate this trapdoor by going to {16} or you may go through the door behind you by going to {33}."
},
{ // 56
"You follow the ghost down the stairs revealed behind the secret door. Soon you come to another door. Lord Vaning takes his leave of you, saying that he cannot pass beyond this point. You slip the door open and peep through the folds of a tapestry to see a room which has been made up as a Chapel of Krwonsku, an evil god of dark repute.\n "\
"  At one end of the room a beautiful young woman is bound by silver chains to an altar carved all over with serpentine coils of draconian demons. Over her stands another woman, clad in the vestments of an Initiate of Krwonsku! Even as you watch the Initiate casts an arcane spell at the captive, turning her into a black cat (!) and the chains into a silver cage!\n" \
"  If you wish to attack the Initiate, go to {92}. If you wish to watch for a while longer, go to {100}. If you wish to talk to the woman, go to {59}."
},
{ // 57
"You awaken outside the door of Vaning House. All of your belongings are intact, and you seem to be healthy. As morning breaks, you notice smoke pouring out of the windows and chimneys of the old house. It burns to the ground in a very short time.\n" \
"  \"Whatever you did in there, it must have been mighty final!\" your guide says as he walks up. \"Want me to get the mules ready to go back to town?\"\n" \
"  Resignedly, you nod yes. You'll never know how you survived the ghost or what put you outside the house. This mystery burned with the mansion. Ah, well. Tomorrow is another day. Close the book. Take 225 ap for this mystifying sojourn in Vaning House."
},
{ // 58
"\"Thank you, Living One! I cannot enter the Temple of Krwonsku! I have tried many times, but the force of his darkness repels my incorporeal form! Come. I will show you the way!\" He points out a secret door. Go to {56}."
},
{ // 59
"The Initiate starts in surprise when you make yourself known, then settles down to a suspicious expectancy.\n" \
"  \"What are you doing here?\" she demands. \"You should be guarding the Tooth of Krwonsku!\n" \
"  Realization that she has mistaken you for someone else is not long in coming. You may disabuse her of this assumption by attacking her at {78}, or you can continue the deception at {93}."
},
{ // 60
"You rush towards the door to the stairs. Throwing it open, you see a ghost standing on the landing! Go to {83} if you prefer the ghost. Go to {7} if you prefer the demon!"
},
{ // 61
"You take down the book and begin to peruse its subject index. Before you can get much past the Introductory Thaumaturgy listing you see a greenish yellow tentacle out of the corner of your eye. Make a L3-SR on Intelligence (30 - IQ). If you miss the roll, go to {7}. If you make the roll, go to {13}."
},
{ // 62
"Though she has her suspicions, she buys your line of blarney. She gives you the cage with the cat in it and tells you to take it to the Chamber of the Master. If you wish to follow her orders make a L1-SR on Luck (20 - LK) and go to {80}. If you feel you are doomed to failure in this web of deception you may attack her now by going to {92}."
},
{ // 63
"Once you have decided to help Lady Charlotte she rises to a sitting position. You see that she is very frail looking, as if she has undergone a long illness. \"My husband and I are the victims of a terrible curse,\" she starts out. \"Fifty years ago an evil magician named Semaj cursed our house with a terrible creeping curse of horror. Ever since that time we have been unable even to die with dignity. If you will destroy the evil force that holds our house under the curse I will reward you with a great treasure.\"\n" \
"  If you wish to take up her offer, go to {84}. If you wish to leave now, go to {76}."
},
{ // 64
"Long ago I was the owner of Vaning House. I built it as a home for myself and my young bride, Charlotte. I did not know it at the time, but I had built my house directly over the long buried Great Temple of Krwonsku! The priesthood of the Blood Drink had long been driven from these parts! How was I to know?\" The ghost pauses, remembering some other time, lost in his emotions.\n" \
"  \"I had only lived here a few months when Semaj, the evil high priest of Krwonsku, launched a plot against me! He wished to drive me from my house, take it as his own, and dig down to the buried temple! I resisted, of course. But his plan was almost foolproof!\"\n" \
"  As the ghost, Lord Vaning, told his story you began to get a sense of what the Aged One meant when he said that the evil of Vaning House was creeping! Semaj's plan was simplicity! He began by casting a series of subtle curses on the land around Vaning House. Each curse taken by itself was minor, unimportant. But with each additional curse, the creeping evil grew!\n" \
"  At first it was just a little bad luck, an unusual sickness, or a general malaise. Then monsters began to roam the area, smaller ones at first, then more powerful undead and demons. Finally, all the persons living in Vaning House began changing, becoming evil, decadent. Lord Vaning ever had a chance. By the time he realized he had been cursed, it was too late.\n" \
"  \"So you see, Living One, all that I cared for died at the hands of Semaj the Black!\n" \
"  \"I have but one reason to welcome my current existence! Revenge!\" He holds our the chest. \"Take this chest into the heart of the Temple of Krwonsku! Within it is the Heart of Edualc the Red! The power of the Sainted One's goodness will surely destroy all the vestiges of Krwonsku's malevolent power!\"\n" \
"  To take the Heart of Edualc, go to {58}. If you refuse the quest of Vaning, go to {68}. If you wish to attack the ghost, go to {73}."
},
{ // 65
"The cage hits the Initiate full in the face! Roll 1d6 and add your Dexterity combat add, then subtract this as damage from her Constitution when you get to {94}. Other than the above, follow the instructions at {94}."
},
{ // 66
"You push past the ghost, running for your life. The stairs seem to best option, so you run headlong down the rickety flight. Make a L4-SR on Luck (35 - LK). If you make the roll, go to {90}. If you miss, go to 98}."
},
{ // 67
"You see a secret door on the back wall of the room. You hand reaches out for the door's ornate pull ring. You could take this door (by going to {41}) you muse, or you could just forget secret doors entirely (by going to {75}). Which appeals to you more? The known or the unknown?"
},
{ // 68
"\"You refuse! You dare to refuse me! You shall die for this!\" The ghost moves to attack you with unnatural speed. Vaning strikes out at you, cuffing you across the face. You will lose one half of your Strength points now as a result of this attack. Now go to {77}."
},
{ // 69
"The Initiate has a Constitution of 22, however since you have complete surprise, she will take [1½ times the damage of ]your normal attack. If you kill her, go to {86}. If you don't kill her she will recover and throw a nasty transformation spell at you, turning you into a wooden statue. Terminates will tunnel in your toes for a very long time. Close the book."
},
{ // 70
"Make a L1-SR on Dexterity (20 - DEX). If you make it, go to {96}. If you miss, go to {104}."
},
{ // 71
"As you stand over the Initiate's body you hear a creaking, groaning sound from behind you. You turn, and to your horror, you see Semaj standing up! He begins to cast a spell! If you wish to cast your own spell, go to the Magic Matrix. If you wish to take out the Amulet of Edualc, go to {102} and ignore any references to the Initiate. If you wish to run, go to {88}."
},
{ // 72
"The Initiate buys your tale completely. She indicates a secret door and instructs you to follow her with the caged cat.\n" \
"  The passage revealed beyond the door is long and treacherous, leading down a steep incline. It takes you several seconds to reach the bottom. Once there the woman casts a Will-o-Wisp spell and lights the way into a large room.\n" \
"  This room must be the inner sanctum of the Temple of Krwonsku that you were told of by the ghost of Lord Vaning. Its high vaulted roof is decorated with scenes of bloodshed which only a demon of Krwonsku's tastes could admire. Against the far wall is a huge crystal throne upon which sits a wizened husk of a man.\n" \
"  \"Behold the mortal remains of Semaj, High Initiate of Krwonsku!\" exclaims the woman! \"It is he who shall lead the Brotherhood out of obscurity and into the power that is rightly ours!\"\n" \
"  She instructs you to place th silver cage on Semaj's lap. If go do so, go to {87}. If you choose to attack her, go to {94}."
},
{ // 73
"To cast spells at the ghost, refer to the Magic Matrix. If you wish to use normal weapons, go to {77}."
},
{ // 74
"The magic of your spell reveals of concealed door on the wall across the landing from you. You may flee through the hidden door by going to {56}, or you may return to {83} and take some other option except that you will not have time to cast another spell."
},
{ // 75
"You see only one exit from the room; the door you came in through. Remembering back, you know that something horrible may be waiting out there for you. If you can't go on, you will be trapped in this room with a horrible demon. Truly, you are between a rock and a hard place. If you want to chuck it all, summon the demon by picking up one of the beakers on the work table and go to {7}. If you want to throw caution to wind and brave the stair's first landing, go to {83}."
},
{ // 76
"As you step into the corridor a ghoul's terrible, scarred visage fills your heart with horror! You try the door, but it will not open! You must fight the ghoul!\n" \
"  The ghoul has the following statistics:\n" \
"    Strength:     23\n" \
"    Intelligence: 4\n" \
"    Luck:         12\n" \
"    Constitution: 22\n" \
"    Dexterity:    12\n" \
"    Charisma:     1\n" \
"    Speed:        12\n" \
"In order to cast magic at the ghoul, go to the Magic Matrix. If you wish to use normal weapons you may conduct the fight right here. The ghoul will get 2d6 (claws) + 11 combat adds. If you kill the ghoul, go to {46}. If the ghoul kills you, close the book."
},
{ // 77
"The ghost has the following statistics:\n" \
"    Strength:     0\n" \
"    Intelligence: 11\n" \
"    Luck:         18\n" \
"    Constitution: 17\n" \
"    Dexterity:    0\n" \
"    Charisma:     22\n" \
"    Speed:        28\n" \
"The ghost may not be hit by normal weapons. It can only be hit by magic. If you have a magic weapon you may hit the ghost[ only if your total attack exceeds the Speed rating of the ghost]. Each turn the ghost attacks he must make a saving roll on IQ against your Dexterity or your Speed rating, whichever is higher (SPD or DEX - IQ of 11). If the ghost makes this roll he will touch you and you will lose half of your Strength. When you reach a Strength below 1 you will die. If you die, close the book. If you survive this battle, go to {85}."
},
{ // 78
"The Initiate has a Constitution of 22, and you have total surprise, so you may double your attack. If you kill her, go to {86}. If you do not, she will cast a nasty transformation spell at you, turning you into a wooden statue. Termites will appreciate your new body for a very long time. Close the book."
},
{ // 79
"You break Semaj's hold easily. His muscles are old and withered and don't have much strength. However, the time you spend doing this allows the Initiate to get off a spell! Take 28 hits off your Constitution. If you live, go to {94} and ignore the part about getting surprise, since you do not have this benefit. If you die, close the book."
},
{ // 80
"If you made your saving roll, go to {72} and ignore the first line of the first paragraph. If you missed your roll, go to {94}."
},
{ // 81
"So you have taken all the options at {8}. Therefore, take 110 ap and close the book. You have finished the adventure."
},
{ // 82
"The power of the third, Omnipotent Eye washes the scene before you in its all-revealing rays! You detect the presence of a powerful curse at work on the ghost! Before you can take any action, he speaks, \"So, you are a wizard, Living One! Release me from this accursed unlife and I will give you all the secrets of Vaning House! In order to listen to the ghost's story and learn the secrets of Vaning House, go to {64}. To run away in terror, go to {66}. To attack the ghost, go to {73}."
},
{ // 83
"The door opens and you stand face to face with the terrifying visage of a horribly murdered man! His tall, gaunt forms shows many wounds, any one of which could have been fatal. All the more terrible is the realization that he must have died a young man, about your own age. Chains hang from his arms and legs, though they make no noise when they touch against the floor or his body. In one hand he clutches a small, intricately carved chest.\n" \
"  If you wish to cast magic other than the spells, go to the Magic Matrix. If you wish to cast Revelation, go to {74}. If you wish to cast Omnipotent Eye, go to {82}. If facing this ghost is too terrible to contemplate, you may faint dead away by going to (57}. If the option of total flight appeals to you, go to {66}."
},
{ // 84
"\"I can take you to a place where you will meet my husband's ghost. He will give you a talisman of great power which can use to destroy the evil of Semaj.\"\n" \
"  She rises from the bed and floats across the room to an intricately carved dressing cabinet. Opening it, she takes out a jewellery box. \"This was a gift from my Lord Vaning. Take these five diamond studs as your reward. They were once the property of a queen.\"\n" \
"  You agree to go, taking the studs, each worth 250 gp, and find yourself speaking with Lord Vaning at {64}."
},
{ // 85
"You may take 100 ap for slaying the ghost. In the small chest you will find a crystal orb on a chain, a silver and gold signet ring worth 175 gp and a silver locket worth 80 gp. Inside the locket you will find a lock of hair and two tiny portraits, one Vaning, and the other a young woman. As you turn back up the stairs you feel a cold wind play over your body. A woman's voice cries out, \"I curse you for destroying the spirit of my beloved! You shall never know true love! Or any kind of love!\"\n" \
"  [As a result of this curse, you must add three levels to any saving roll on Charisma you must make if it involves love or romance until you can find a mage of level twelve or higher who is willing to cast a Curses Foiled on your behalf.\n" \
"  ]You may continue by going up the stairs to {16}."
},
{ // 86
"You may search this room by going to {99} and ignoring the first paragraph. Take 165 ap for your efforts."
},
{ // 87
"You approach the throne with trepidation. Near to it, on the left side you see some bones that look somewhat fresh. The odour of rot and decay seems to emanate from the still figure of Semaj. If you wish to drop the cage and take out the Amulet of Edualc, go to {102}. If you continue up the throne, go to {110}. If you throw the cage at the Initiate and attack, go to {65}."
},
{ // 88
"You get only a few feet before Semaj's spell catches you. You are engulfed in a blast of flames that sear the flesh from your bones. Close the book, you have died."
},
{ // 89
"The zombie cannot be harmed by non-magical weapons. If you have normal weapon, return to {109} and cast magic. (Except now you don't get one free round of combat since you wasted valuable time trying to destroy him with a non-magical weapon). If you have a magical weapon you kill the zombie in one blow by disrupting his unlife energy.\n" \
"  You may take the way out presented by the zombie by going to {111}."
},
{ // 90
"You run down the stairs, which collapse behind you. Go to {8} and choose any option that you have not already chosen. If you have taken all of the options available at {8}, go to {81}."
},
{ // 91
"You have landed on an altar just as a magic spell is being cast! Before you on the altar is a young woman you recognize as Princess Nanus of Robert's Hold.\n" \
"  Before you can do anything both you and the Princess are transformed into black cats and locked in a silver cage!\n" \
"  The woman gloats, \"Ha! Semaj will dine on two souls this night!\" She picks up the cage and carries it down a ramp into a large room. You and the Princess are both sacrificed to Semaj, the mortal avatar of Krwonsku the Blood Drinker. Close the book."
},
{ // 92
"You have total surprise. If you cast a Take That You Fiend, go to {69}. Attack with weapons, go to {78}."
},
{ // 93
"You apologize for deserting your post, but make some excuse that sounds plausible. Make a L1-SR on Intelligence (20 - IQ) and a L1-SR on Charisma (20 - CHR). If you miss both, go to {101}. If you miss either one but not both, go to {62}. If you make both, go to {72}."
},
{ // 94
"To cast magic at her, consult the Magic Matrix and return here. If you wish to attack using weapons, her statistics are as follows:\n" \
"    Strength:     10\n" \
"    Intelligence: 28\n" \
"    Luck:         12\n" \
"    Constitution: 22\n" \
"    Dexterity:    18\n" \
"    Charisma:     12\n" \
"    Speed:        18\n" \
"The Initiate has no armour. [Her weapon is magic. Each turn she will cast a Take That You Fiend spell at you. ]If you die, close the book. If you live, you may continue the battle.\n" \
"  On the first round of combat you have surprise and may move up to her without taking the attack. Each round thereafter combat will proceed as normal in the T&T rules. If you defeat her, go to {71}."
},
{ // 95
"As soon as you touch the cat's cage the spell is broken and the cat transforms into a woman whom you instantly recognize as the Princess Nanus of Robert's Hold.\n" \
"  \"Who are you? Where am I? What happened?\" she asks. Quickly you fill her in.\n" \
"  \"Thank you for rescuing me,\" she says. \"We must get out of this place!\"\n" \
"  If you wish to search for an exit, go to {118}. If you wish to search the body of the Initiate, go to {109}."
},
{ // 96
"You are able to lasso a post and hoist the Princess and yourself up to the main level. With the help of the Princess you make your way out of Vaning House and return to town. In gratitude King Bilmore of Robert's Hold will give you 1000 gp for rescuing his daughter.\n" \
"  When you return to the sanctum of the Aged One he asks you into his Sanctum Sanctorum.\n" \
"  \"My friend, you have done very well! I am proud of you!\" He offers you a seat on a soft cushion.\n" \
"  \"But now it is time for you to adventure into the world as a mage among men. In honour of this occasion take this token of our friendship.\"\n" \
"  The Aged One gives you a ring that will act as armour against [magical ]damage such as that from Take That You Fiend spells and Blasting Power spells. The ring will absorb 6 points of damage, the rest being applied to your Constitution as normal.\n" \
"  You leave the Aged One's sanctum to embark on life's journey with a good feeling in your heart. Take 500 ap for surviving Vaning House."
},
{ // 97
"With a scream of pain you look on in horror as the wrinkled thing burrows into your flesh. For several minutes you feel the thing growing inside you. Then, just as suddenly, you feel an unusual calm come over you. You sit down and watch without comment as your skin opens up and a short, weird looking critter crawls forth. \"Hoy, mate! Then handle's Mort the Wart! I'm a homunculus - OK, a familiar to you new guys!\"\n" \
"  Mort is a fairly good familiar as such things go. He will help you cast spells as if he were an ordinaire staff, so you won't have to carry one around anymore. Further, he can see rather well in the dark, and can give you this ability as well. [In combat, he will be able to heal 4 points of damage 1 time per hour, and if you take damage from a magic spell he will act as 6 points of armour, thus reducing the amount of damage you must take. ]In the case of your death, Mort will die as well, and even if you are brought back to life, he will still be dead. If you ever get a deluxe staff, Mort will turn back into the homunculus egg you found him as, his usefulness to you at an end. At that time, you will be able to sell him for 300 gp. To continue, go to {38}.\n" \
"  Too late, you remember the crystal you found. Looking around, you find its broken shards on the floor of the passage. You must have broken it when Mort burrowed into you to hatch."
},
{ // 98
"You run down the stairs which collapse under your weight! You find yourself falling - down, down, down you go, and where you stop, only the gods above know!\n" \
"  You crash through a thin plank decking. Make a L1-SR on Luck (20 LK). If you make the roll, go to {91}. If you missed the saving roll, take the number you missed by directly off your Constitution and go to {99}."
},
{ // 99
"You have landed directly atop a woman clad in the robes of an Initiate of Krwonsku the Blood Drinker! You may take 100 ap for disposing of this evil woman.\n" \
"  You find yourself in a small room accoutred as a Temple of Krwonsku. In a cage on the altar is a black cat. The walls are all hung with tapestries depicting the ghastly practices associated with the worship of Krwonsku. No exit is instantly visible.\n" \
"  In order to investigate the cat's cage, go to {95}. If you wish to cast a Revelation spell, go to {103}. If you wish to search the body of the Initiate, go to {109}."
},
{ // 100
"You wait for several moments. You may regain 5 Strength and 1 Constitution. The woman picks up the caged cat and moves across the room to another tapestry and disappears behind its folds. Before you can enter the room to follow, a sharp cracking sound alerts you to a presence behind you. Turning, you face a man carrying a crossbow, which was aimed at your back.\n" \
"  To attack him, go to {153}. To do nothing, go to {169}."
},
{ // 101
"Your story is very unconvincing. While you are still making excuses she casts a Mutatum Mutandorum spell on you, turning you into a small brown mouse.\n" \
"  As a mouse you are not much of a match for the terrors of Vaning House, however, if you make a L7-SR on Luck (50 - LK) you will be able to survive Vaning House and continue life's grand adventure elsewhere.\n" \
"  If you survived, take 200 ap and close the book. (With that much, you should be able to find a kindly wizard who will change you back into yourself.)"
},
{ // 102
"As soon as you take out the Amulet an intense white light bathes the room! A voice shouts out a spell in an arcane language dead for a thousand years! The Initiate, Semaj, the throne, all are consumed in the blinding light of Edualc's fury!\n" \
"  You look about you in astonishment, taking a few seconds to comprehend the destruction you have witnessed. The voice of Lord Vaning captures your attention: \"You have destroyed Semaj and banished the evil power of Krwonsku! I thank you with all my heart! Take the Princess and go from this cursed house. You will find a great treasure in the ancient oak beside the main gate!\"\n" \
"  As Lord Vaning says it, you realize the cat in the cage must have been the Princess Nanus! Hastily you lead the princess from the house as smoke begins to tinge the atmosphere. Once outside you see that a fire has broken out. The old mansion burns quickly.\n" \
"  Once outside you find the oak tree easily. You, your guide, and the princess are able to make it back to town with ease.\n" \
"  The treasure in the tree consists of 3000 gp worth of gems, jewels, and silver plated dishes. Lord Vaning must have hidden these things before his death fifty years ago. King Bilmore of Robert's Hold rewards you with an additional 1000 for rescuing his daughter.\n" \
"  When you return to the Sanctum of the Aged One he calls you into his study and holds out a wand. Taking it, you discover it to be a deluxe staff! \"You have earned this, my friend. Go, be the best mage you can be!\"\n" \
"  Apprentice no longer, you enter the world a power to be reckoned with. Take 1000 ap for successfully completing the adventure."
},
{ // 103
"Your spell will illuminate a secret door set in the floor of the room. If you wish to take it, go to {133}. If you wish to search further, go to {125}."
},
{ // 104
"Try as you may, you cannot get the lasso to stay on any of the likely boards. As you resign yourself to some other course of action a zombie shuffles in. Go to {109} and ignore the first paragraph."
},
{ // 105
"You touch the crystal, which instantly dissolves. Add 1 to your IQ and go to {112} to continue your explorations.\n" \
"  Suddenly, you remember the wrinkled something. Looking at it, you realize with your newfound IQ that it could be a trap of some sort, and in disgust, toss it over your shoulder, back down the passageway."
},
{ // 106
"You find yourself in the midst of a panicked flight of rats, mice and large insects. You see the glow of flames coming towards you, followed shortly by a reptilian head. If you wish to run, go to {113}. If you wish to stand your ground, make a L1-SR on Intelligence (20 - IQ) and go to {121} if you make it. If you fail, go to {128}."
},
{ // 107
"You sense that you are not alone in the darkness (big surprise)! A sick dread begins to fill your soul as you remember something the Aged One said about a darkness demon. It could only be dispelled by the proper usage of one of the lesser power spells. Now what was it? Which spell will dissolve this demon back to the nether planes from which it came? Now, write down your choice and hope you can find it on the Magic Matrix! If you still refuse to use magic, go to {115}."
},
{ // 108
"You wander in this tunnel for several minutes, until you come to a nondescript door. Opening the door you find yourself on the back porch of Vaning House.\n" \
"  For several moments you explore the drooping, moss-covered porch. Then you notice that the house has been set afire. Moving around to the front of the house you and your guide watch as the house burns to the ground.\n" \
"  Take 125 ap for surviving the adventure, then close the book."
},
{ // 109
"You will find a pouch containing 300 gp in diamonds on the Initiate. As you are searching her body a secret door on one of the walls opens and a zombie shuffles in. You must fight the zombie!\n" \
"  The zombie's statistics are as follows.\n" \
"    Strength:     10\n" \
"    Intelligence: 28\n" \
"    Luck:         12\n" \
"    Constitution: 22\n" \
"    Dexterity:    18\n" \
"    Charisma:     12\n" \
"    Speed:        18\n" \
"He gets 1d6 + 8 adds in combat. [Due to his unliving nature he will halve the effects of all magic spells cast at him. ]In order to cast magic at him, consult the Magic Matrix. You will get 1 free round before he shuffles up to you. In order to attack with normal weapons, go to {89}. If you defeat the zombie, go to {119}. If the zombie defeats you, close the book."
},
{ // 110
"You place the caged cat on Semaj's lap. A bony hand grasps your wrist before you can withdraw it and a leathery voice croaks, \"Traitor! You are not an Acolyte of Krwonsku! Asilrats! Kill him!\"\n" \
"  With that, the Initiate begins casting a Take That You Fiend at you. You may attempt to break Semaj's hold on your wrist by going to {79}. You may cast a spell at Asilrats by going to the Magic Matrix. Or you may pull out the Amulet of Edualc by going to {102}."
},
{ // 111
"The zombie must have come in from outside, for the passage he came out of leads right to freedom. As you come out into the trees near where you left your guide you smell smoke. Turning, you see that Vaning House has been set aflame by some unknown agency.\n" \
"  With the help of your guide, you and the princess make your way out of Vaning House and return to town. In gratitude King Bilmore of Robert's Hold will give you 1000 gp for rescuing his daughter.\n" \
"  When you return to the sanctum of the Aged One he asks you into his study.\n" \
"  \"My friend, you have done very well! I am proud of you!\" He offers you a seat on a soft cushion. \"But now it is time you adventure into the world as a mage among men. In honour of this occasion take this token of my friendship.\"\n" \
"  The Aged One gives you a ring that will act as armour against magical damage such as that from Take That You Fiend spells and Blasting Power spells. The ring will absorb 6 points of damage, the rest being applied to your Constitution as normal.\n" \
"  You leave the Aged One's sanctum to embark on life's journey with a good feeling in your heart. Take 500 ap for surviving Vaning House."
},
{ // 112
"If you have any red stones, go to {129}, then return here. If you have any clear crystals, go to {154} and return here.\n" \
"  Leaving the damp tunnel, you enter a room hewn from solid rock. Something tiny hits you on the shoulder with a splat! Water is dripping from the ceiling, running down the walls and out through cracks along the floor. Except for the sounds of the water there is absolute silence; you could hear a worm belch. Phosphorescent fungus coats the walls and emits a dim yellow glow so that you can see about you. Make a L1-SR on Luck (20 - LK). If you make it, go to {137}. If you miss, go to {147}."
},
{ // 113
"Something hits you hard in the back. You go down, falling through a rotten place in the floor. When you wake up, you find yourself at {229}."
},
{ // 114
"You can pick up half your IQ of clear crystals as well. These also have a weight of 0.1#. Go to {112}."
},
{ // 115
"Dread grips your heart in a hand cold as ice! A sickness seeps into your soul from the darkest nether reaches of the forbidden realms of the outer demons. You feel a cold, slimy tentacle wrap itself inexorably around your body, leaching the will to live from your failing flesh. Too late you remember what your Master said about demons of darkness and the one simple spell which send them screaming into the pits of Daleglaith in the farthest reaches of the Dark Dimensions! Close the book, you cannot survive this onslaught of horror!"
},
{ // 116
"You open the door only to discover that it opens on the side of the house. You stumble out, rejoicing that you have escaped. Take 150 ap and stay out of trouble. If you wish to return to Vaning House, go to {1}. Try to avoid making the same decisions."
},
{ // 117
"You pick up the rabbit's foot and instantly gain 2 points of Luck. The foot crumbles to dust. Return to {156}. You may not choose to examine the rabbit's foot again."
},
{ // 118
"You find a rope by the altar. If you wish to lasso a board on the collapsed stairs and hoist yourself and the princess up to the first level, go to {70}. If you wish to search further, go to {125}. If you wish to consult the Magic Matrix, write down your spell choice and do so."
},
{ // 119
"Take 55 ap for defeating the zombie. Tiring of Vaning House you leave via the same door the zombie entered by.\n" \
"  Once outside you meet up with your guide and make your way back to town. Take 250 ap for completing this adventure."
},
{ // 120
"Make a L1-SR on Luck (20 - LK). If you make it, you survive 5 turns without anything popping up. You can leave by going to {127}. If you missed your saving roll, go to {135}."
},
{ // 121
"You notice that the dragon's head is so large that its body could never fit in the corridor before you. This is a not so clever illusion.\n" \
"  Taking up your courage, do you stand your ground? Go to {136}. Or do you try an Omnipotent Eye spell? If so, go to {146}."
},
{ // 122
"You know that these stones are rubies, worth 8 gp each. Your will also notice several crystals which you scoop up. These are diamonds, each worth 10 gp each. You can get your IQ worth of them. Go to {112}."
},
{ // 123
"Surprisingly, the ragamuffin man turns out to be a pretty fair conversationalist. His raspy voice begins to tell his sad tale: \"For the last week I have been searching this house for the Princess Nanus, who was lost near here about 10 days ago. I have just about lost hope of ever finding her, however, since this old manse if filled with all manner of deadly trap and critter.\"\n" \
"  You notice him looking longingly at your canteen and decide to let him have a few sips of water. Thus fortified, he continues, \"I wish to thank you for your water, sir! Perhaps a bit of advice would be the better form of repayment! Beware the darkness! If you find yourself in a darkness that fills you with true dread, then use the power of the Third Eye to combat it, for it can never face the all revealing power of the Eye! Only with this spell was I able to escape the Darkness!\"\n" \
"  Realizing that the man is a rogue - he hasn't the look of a full mage about him - you might offer him the vast benefit of your magical knowledge by teaching him a spell. Go to {148} or you may continue your journeys in Vaning House by going to {156}."
},
{ // 124
"You swing open the door to see a shadowy figure standing just beyond it. You make a move to begin a spell, only to realize that you are looking at your own reflection! Entering the room, you begin to investigate the highly ornate, full length, oak mounted mirror that someone has thoughtlessly left standing facing the door.\n" \
"  Without warning the room grows cold. A dark blotch begins to take form in the glass of the mirror. You have only a few seconds to decide what you are going to do! Run into the corridor and slam the door? Go to {131}. Cast a spell at the mirror? Consult the Magic Matrix. Shatter the mirror with your weapon? Go to {139}."
},
{ // 125
"As you search, a zombie shuffles in. Go to {109} and ignore the first paragraph."
},
{ // 126
"The monster's reaction will depend on how likable you are. If you a Charisma less than 12, the troll finds you to be a deficient conversationalist, and insists that you remind him of his last meal. Go to {18} and see what happens to you. If your Charisma is 12 or more, make a L1-SR on Charisma (20 - CHR). If you miss, you may queue up behind the poor conversationalists at {18}. If you make your saving roll, proving your likable nature, go to {134}."
},
{ // 127
"You walk briskly for 5 turns and reach the end of the tunnel. You may recover two of your lost Strength points (if necessary). Now go to {112}."
},
{ // 128
"The dragon comes ever closer. Losing your control, you turn to run, only to stumble over some debris. You hit the floor solidly, continuing on through the rotten wood. You hit hard, but not hard enough to be unconscious. You are in a short corridor. To go west, go to {112}. To go east, go to {108}. Take 75 ap for facing this fierce critter."
},
{ // 129
"These red stones are rubies, worth 8 gp each; now return to {112}."
},
{ // 130
"With a hoarse shout of rage you draw steel and charge! The rogue is not taken unaware by your manoeuvre. Deftly he draws his dagger and meets your slashes as you both begin combat.\n" \
"  His statistics are as follows:\n" \
"    Strength:     14\n" \
"    Intelligence: 12\n" \
"    Luck:         15\n" \
"    Constitution: 11\n" \
"    Dexterity:    13\n" \
"    Charisma:     10\n" \
"    Speed:        13\n" \
"If you win, go to {156} to find out what happens next. If you lose, close the book; you are dead.[ If you run away because of the effects of a Panic spell, go to {163}.]"
},
{ // 131
"You run for the door. Make a L1-SR on Speed (20 - SPD). If you make it, go to {145}. If you miss, go to {157}."
},
{ // 132
"You leave the room and enter a corridor which is as bare as the proverbial cupboard, until you come to a T-intersection. (During this time you may regain 3 turns worth of Strength and Constitution if you are down.)\n" \
"  To take the left passage, go to {188}. To take the right passage, go to {140}."
},
{ // 133
"The trapdoor leads out of Vaning House. Once outside you meet up with your guide and make your way back to town. Take 250 ap for completing this adventure."
},
{ // 134
"For some reason you have entranced this poor, dumb troll with your powerful personality. With a sound much like the screeching of an old, very rusty iron hinge, he begins to cry and beg your forgiveness. Realizing the power you have over him, you demand all his treasure! \"Sir!\" he croaks! \"It's yours! I'll just go eat some worms or something...\" He drops his gold and other sundries at your feet and goes off down the passage muttering to himself.\n" \
"  Picking up his pouch, you are surprised by its weight. Opening it, you will find 210 gp worth of rubies, a magic marble which will increase your IQ one point one time (it will not work on trolls), and a magic ring which will allow you to cast a Will-o-wisp spell at no Strength cost once per melee round for light only. It will not cast the spell at another being.\n" \
"  As you move down the passage, you notice a part of the wall that is different from the rest. Searching around, you find a loose brick. Behind this brick is a small pouch. Inside this pouch is a small, grey, wrinkled bit of something, and a glowing crystal. If you touch the wrinkled something, go to {97}. If you touch the crystal, go to {105}."
},
{ // 135
"You wait for a time. You begin to grow somewhat nervous, however you are getting some much needed rest so you stick it out. For the first 3 turns, nothing happens. Then, with a sound like a runaway peddler's cart, and a small much akin to the swamps in south Rhalph, a big nasty looking THING approaches! Go to {106} if you stand your ground. Go to {113} if you cut and run."
},
{ // 136
"The dragon hits you, doing no damage. Its body snarls past you, eventually disappearing in the distance. You continue down the corridor until you get to a small grotto. Inside the grotto you find several rocks that you believe might be large rubies. Take 110 ap for the illusionary dragon. You can also grab up to your IQ worth of the red stones, each of which weigh 0.1#, or you may search further. To search further, go to {114}. If you are dwarf go to {122}. If you wish to cast Detect Magic or Revelation, go to {222}, and if you wish to leave, go to {112}."
},
{ // 137
"You see a small gold ring in a puddle of stagnant, brackish water. The skilfully crafted ring is magical. [When you pick up the ring, you note that it will cast a Too-Bad Toxin spell 1 time per day. ]Without any magical quality the ring is probably worth about 20 gp. Now go to {147}, you lucky stiff."
},
{ // 138
"You brush by the ragamuffin man, sniffing your displeasure as you do. You don't get far, however. Angered at your cavalier treatment of his person, Captain Guy l'Webbe of the royal guard of Robert's Hold draws his dirk (the only weapon he has that has survived the ravages of this place!) and charges your back. Go to {130}, however, you must let Guy have 1 free round of combat on you before you can begin to fight."
},
{ // 139
"You try to shatter the glass, but it is unbreakable. As you stand pounding at the mirror's surface a hideous amorphous being of unnatural origin takes unform. Tentacles reach forth and clamp onto your body. You feel your soul being slowly drained from you. Close the book, you are dead."
},
{ // 140
"This path is getting colder and darker fast. If you go back, go to {156} and take a different option. If you cast a Detect Magic, go to {196}."
},
{ // 141
"You cleverly manage to twist in mid fall, thus avoiding the majority of the spikes. This is not so true for others that you see as you painfully pull your gored body up off its bed of death. Looking around yourself, you find you are in a roughly constructed pit about 15' deep. You are so injured that you could never hope to climb up the crumbly walls. Lucky you you, recent rains have eroded one wall of the pit, revealing an old access tunnel. With a lot of squirming, dirt shifting, and hard work, you manage to worm your way to the surface, exiting near an old cistern. Your cries for help bring your guide, who performs some rudimentary first aid on your cuts and gashes.\n" \
"  You have a Constitution of 1, which will take a few days to recover from since the ghouls were kind enough to poison their punji stakes. By the time you are able to move, Vaning House is not open to your explorations. Take 150 ap for surviving your experience."
},
{ // 142
"A pale green light sprouts from your fingers, light which has a devastating effect on the frail forms of the shadow-favouring ghosts! Long ago these were the high priests of a terrible darkness-loving demon called Krwonsku the Blood Drinker! Now you have destroyed them, ending their unlives unlived in the service of the evil Krwonsku! Take 160 ap and go to {147}."
},
{ // 143
"If you missed the saving roll, you lose half your Strength to the ghost's evil draining. You must fight at this reduced level, knowing that only rest and recuperation will restore your lost Strength!\n" \
"  If you cast a Blasting Power spell, go to {151}. If you cast any other spell, go to the Magic Matrix and consult it to see what happens!"
},
{ // 144
"You take the finger bone. Instantly the corpse crumbles into its component parts. A sepulchral voice rises from the skull a moment before it crumbles to shards: \"My blessing is in that finger bone! If you are ever the victim of harmful magics it will absorb much of the harm!\"\n" \
"  The bone will take 10 points of damage[ from the total generated by any damage causing spell such as Take That You Fiend or Blasting Power]. This bone is mystic armour. Take 150 ap for talking to the mummified servant. Now go to the landing at {42}. There are no other exits from this room."
},
{ // 145
"You slam the door and run down the corridor. Throwing open the first door you see, you discover that it opens on the side of Vaning House. You stumble out, rejoicing that you have escaped. Take 150 ap and stay out of trouble. If you wish to return to Vaning House, go to {1}. Try to avoid making the same decisions."
},
{ // 146
"The all-seeing power of the third, Omnipotent Eye, reveals the illusionary nature of the dragon, which promptly dissolves away. Unhappily, so does the floor under your feet. You fall, striking your head on the way down. Take 55 ap for this illusionary dragon. Go groggily to {229}."
},
{ // 147
"The little bit of light coming from the phosphorescent fungus on the walls suddenly fails. You sense a palpable evil in the atmosphere. Torches, lanterns, candles, Will-o-Wisps, even Cateyes are useless. The evil grows closer, more evident. Your back seems to crawl in expectation of a dagger thrust. If you wish to grope around blindly in the darkness, looking for a way out, go to {155}. If you wish to try other magic spells, go to the Magic Matrix."
},
{ // 148
"He is grateful for your assistance! With a great deal of enthusiasm he learns Take That You Fiend, the only level 1 spell he has yet to learn. As you go, he takes out a small bag and tosses it to you.\n" \
"  The bag contains a diamond worth 100 gp and a copper eating dagger worth 8 gp. \"This is the sum of my worldly goods. No, I won't take it back! You deserve much more than this, but alas, I am a poor man.\" Go to {188} after taking 100 ap for teaching him the spell."
},
{ // 149
"You continue down the corridor, nonchalantly keeping up your jogging pace. About halfway to the end of the corridor you notice a glinting in the darkness. If you stop to search, go to {192}. If you continue on, go to {147}. If you choose to cast magic, write down you spell and consult the Magic Matrix."
},
{ // 150
"You dash off after the diminutive ghouls, confident in your power to overcome the entire pack. Abruptly the world seems to rise up and slap you! You have fallen into a pit! Pain explodes over your entire body! Spikes! Several of them! Your body, held, torn, gouged, helpless! Dying!\n" \
"  Your last coherent thoughts revolve around the concept of fate, the afterlife, and God, but it is too late. You make a fine meal for a bunch of hungry scavenger ghouls!"
},
{ // 151
"A mystical vision of magical energy erupts from your hands as bolt of energy leap to do your bidding! Your fiery spell force meets to mingle with the cold anti-life of the malevolent spirits. Phosphorescent vapours dance in a rainbow aura like that of the far north. The ghosts are obliterated, one by one, until only the largest and oldest is left! With a cry of outrage terrible to behold, the spectre cries out, \"Krwonsku! Avenge your servants! Destroy this unbeliever!\"\n" \
"  And then he dies, leaving you alone with the only reminder of this epic battle the drifting mists of the ghostly beings' ectoplasmic bodies. You can stop to rest, go to {176}; or you may run for your life just in case Krwonsku shows up, go to {185}."
},
{ // 152
"What a pile of garbage you sift through! Fifty years of ghosts, goblins and similar ghastlies can leave a lot of trash! Eventually you tire of your labour and determine to continue your searches elsewhere. To continue down the hallway, go to {22}. If you decide to return the way you came, go to {30}."
},
{ // 153
"You move to grab your weapon or to cast your spell, but the guard is ready for you. The crossbow quarrel takes you in the chest. Close the book, you are dead."
},
{ // 154
"The crystals are diamond. Each one is worth 10 gp."
},
{ // 155
"You search and search fruitlessly. The darkness extends infinitely in all directions. You feel the evil drawing closer and soon it will be upon you. If you want to use your magic, return to {147} and consult the Magic Matrix. If you wish to ready your weapons for a fight in the pitch blackness of this unnatural darkness, go to {162}."
},
{ // 156
"Having killed the ragamuffin man, you kneel to loot the body. As is frequently the case, all was not as it seemed with this man. You find his money pouch attached to a loop under his ragged cloak. The man was once a member of the royal guard of Robert's Hold, a small kingdom far from the hustle and bustle of Khosht or Khazan. He has several personal ornaments, including a locket containing the likeness of a very beautiful young lady, whom you take to be his wife or lady, a diamond worth 100 gp, a lucky rabbit's foot, which seemed not to give this man much luck, and a dagger (other than the one that he used in combat. You may take the dirk as well, but it is nothing special, just an ordinary dirk.) The dagger and the rabbit's foot both detect as magical.\n" \
"  If you wish to examine the dagger, go to {164}. If you wish to examine the rabbit's foot, go to {117}. If you wish to leave these items where they lay and just gather up the mundane items and the dirk, go to {132}.\n" \
"  In any case, take 88 ap for killing the ragamuffin man."
},
{ // 157
"From over your shoulder you can just glimpse the surface of the evil mirror. As if viewed in the depths of honey or some other viscous liquid, a hideous amorphous being of unnatural origins takes unform. Tentacles reach forth and clamp onto your body. You feel your soul being slowly drained from you. Close the book...You are now dead."
},
{ // 158
"As the witch-glow of the Will-o-Wisp spell slowly dispels the shadows you hear a scurrying from your rear. Turning, you catch a glimpse of several feral creatures as they rapidly retreat into the darkness from whence you came. Realizing that even cornered rats will fight with the ferocity of lions, you elect to avoid a confrontation by going on to {183}. If you are a gung-ho Conan-style brawler, you could run after them by going to {191}. In either case, you get 150 ap for causing such a router among the monsters."
},
{ // 159
"Ransacking the entire room will take a bit of time. You can regain any lost Strength, and 1 lost Constitution, while doing so. In teh end, you don't find much in the way of mystic tomes except one volume dealing with the summoning of fire elementals which is far beyond your current level of achievement, but is worth 800 gp!\n" \
"  You take it and leave by the stairway, which puts you in a faintly phosphorescent corridor which you do not recognize from your previous explorations. Go to {147}."
},
{ // 160
"The lead spirit absorbs the mystic energies that were unleashed by your spell and grows visibly larger before your eyes! These undead priests of a terrible evil demon thrive on fear! The ghosts surround you and begin to suck the very life essence from you!\n" \
"  You may try to fight back with weapons, go to {211}, or you can try to cast a spell, go to {143}. Before doing either, make a L3-SR on Strength (30 - STR)."
},
{ // 161
"The hidden door leads into a narrow passage about twenty paces long and six paces wide. At the opposite end of the room is an incongruous brick wall.\n" \
"  If you wish to break down the brick wall, go to {168}. If you wish to search the room for a way out, go to {177}. If you wish to just wait here for a while, then return to the landing, go to {186}."
},
{ // 162
"You stand in the darkness, clutching your weapons in sweaty hands, awaiting doom in who know what form. A panic begins to grip your soul. What are you thinking; trying to play knight in shining armour? How can you hope to win against whatever is in the darkness? Surely, your courage must be foolhardy, and your sense of self preservation nil! Make a L1-SR on Luck (20 - LK). If you make the roll, go to {107}. If you miss, go to {115}."
},
{ // 163
"You run until your breath is exhausted. Slowly it dawns on you that you are totally lost. The only ray of hope you have seems to be a glinting of light up ahead.\n" \
"  Tiredly, you begin to trudge down the corridor. Once before the door, you waste no time opening it. Make a L2-SR on Luck (25 - LK). If you make it, go to {116}. If you lose, go to {124}."
},
{ // 164
"You have never seen such a magnificent piece of workmanship before! This dagger, actually a jambiya, is a masterpiece of form and function. Only a master weaponsmith could have fashioned it! Admiringly, your finger reaches to trace the gold filigree demons that decorate the hilt.\n" \
"  At first touch, the dagger seems cold, lifeless. Then, horribly, you sense a change come over the weapon, and indeed, over you!\n" \
"  The dagger has been cursed by its creator! The whole darkling story pours into your mind from the spirit of the dagger!\n" \
"  \"Man, know that I am the Tooth of Krwonsku the Blood Drinker! For far too long have I been thirsty! Now, in the hands of a true mage, I can once more slake my thirst on the gore of the living! Take me forth from this place into the cities and the towns. Never again will I allow my will to be thwarted! We will start such a bloodletting that it will be remembered in the time of your grandson's grandson's grandson!\n" \
"  This is the last coherent thought you have as you rush from Vaning House, embarking on your savage killing spree! If some kindly master magician takes pity on you and cast a level 14 Curses Foiled you may regain control from the Tooth of Krwonsku the Blood Drinker. More likely you will be spitted on the end of a city guardsman's spear and the dagger will possess some other poor fool.\n" \
"  Make a L9-SR on Luck (60 - LK). If you make it, you receive a Curses Foiled after about 10 days. If you miss, you receive a spear in about 12 days. In either case, you may not return to Vaning House. Close the book."
},
{ // 165
"Make a L1-SR on your Dexterity (20 - DEX). If you miss, you tripped in the dark, and fell over. You must absorb 8 hits if you fell. All of this may be taken on armour, if applicable. If you make your saving roll, nothing happened. You reach the other end safely. Go to {147}."
},
{ // 166
"You soon tire of prying open potion beakers that have not been opened in several decades. In frustration, you take the nearest beaker and throw it against the far wall. Unfortunately for you, this beaker contained a huge and very violent djinn. Laughing all the while, this thing from the Eastern Lands uses its incredible power to destroy the room you are in. You barely escape to the outside. Looking back you see Vaning House in flames, the djinn revelling in its fiery chaos. Take 85 ap and close the book. This character can't enter Sorcerer Solitaire again."
},
{ // 167
"Desperately striking out with your weapons you drive the ghosts back down the corridor! Shrieking, the lead ghost gives way before you, then the next and the next. A seeming endless horde of the foul undead priests of Krwonsku the Blood Drinker strive against you!\n" \
"  You begin to believe that you may prevail! The terrible wounds that your weapons cause to their insubstantial bodies gives you hope!\n" \
"  Then a growing, ululating, squirming laughter insinuates itself into your mind. The evil spirits that only a moment ago you had been ripping to ectoplasmic shreds now rise up anew, untouched by your efforts! A sick, hopeless moaning sound wells up from deep in your throat as you crumple to the floor!\n" \
"  The ghost's laughter echoes in your ears as they begin to suck your life's essence from your body. So it ends. Close the book."
},
{ // 168
"It takes a while, but you manage to break down the wall, revealing a small room. Chained to the far wall is the skeleton of a human being. You can see at a glance that the person died after the room was sealed up: the distortion of his feature implies absolute agony.\n" \
"  If you wish to search the corpse, go to {194}. If you wish to return to the landing, go to {186}."
},
{ // 169
"The guard motions you to go on into the room. Once inside you see that the woman has returned, sans the caged cat.\n" \
"  \"Well, Calla. I see you have found another sacrifice for Semaj. Bind him to the altar!\"\n" \
"  Realizing that you will not get any other chances you make your move to escape now. To cast magic, consult the Magic Matrix. To fight with weapons, go to {178}."
},
{ // 170
"Your hand brushes across a small bag of some sort as you crawl forward. Soon you get to the opening which proves large enough for you to squeeze through.\n" \
"  Once outside the crawl space you pause to examine the bag, which contains 30 pieces of gold and 8 pieces of silver. You turn back toward the front of the house only to notice that most of the upper floors are engulfed in flames.\n" \
"  You and your guide watch as the old house burns to the ground. You get 125 ap for completing the adventure. Close the book."
},
{ // 171
"Your spell will reveal a small golden coin caught in the floorboards. Taking it up in your hand you suddenly feel a bit luckier. Add 1 to your Luck. (Return to the paragraph that sent you to the Magic Matrix.)"
},
{ // 172
"Your Dis-Spell will neutralize Semaj's spell momentarily. To run, go to 88}. To use the Heart of Edualc, go to {102}."
},
{ // 173
"You detect high level evil magic. To learn more by casting Omnipotent Eye, go to {224}. To try to go back, go to {107}."
},
{ // 174
"Your spell warns you of magical danger! Looking in the direction you are detecting magic in you will see the eerie forms of several ghosts! Since you have noticed them, they abandon stealth and come streaming out of the walls towards you, moaning and shrieking in glee! Their cold-as-death forms cluster around you like pilot fish on a shark. If you cast a Will-o-Wisp, go to {142}. If you cast a Blasting Power, go to {151}. If you cast a Panic, go to {160}. If you cast any other spell, write it down and consult the Magic Matrix. If you elect to fight with weapons, go to {167}."
},
{ // 175
"You crack the door on the furnace, disturbing the fire elemental who has been busily baking a clay beaker since the last living resident of Vaning House ordered him to do so. The cold air let in by your opening of the door strikes the beaker with catastrophic results! The resultant explosion hurls you across the room and down the stairs! Flames engulf the upper room as the elemental, freed from the furnace when the beaker exploded, wreaks his revenge for too long an imprisonment in too small a space.\n" \
"  Counting yourself lucky to have survived you take the first turn that takes you far from the flames that will surely destroy this house of evil. Go to {147}.\n" \
"  Before going, however, you should know that you were not altogether unchanged by your encounter with alchemical philosophic science. Roll 1d6 and consult the following table:\n" \
"    Roll    Effect\n" \
"    1       The potion being baked was a Troll Strength Potion. Add 3 Strength permanently.\n" \
"    2       The potion being baked was a Brain Booster Potion. Add 2 IQ permanently.\n" \
"    3       The potion being baked was a Dragon Control Potion. It went bad. -10 Charisma[ versus any dragons you may encounter].\n" \
"    4       The potion being baked was a Regeneration Potion. It went bad.[ Any time you must be healed by a Restoration spell it will take 2 times the cost for each heal. In other words, 4 for 1 instead of 2 for 1!]\n" \
"    5       The potion being baked was a Shape Change Potion. It went bad. No effect on you save that you now have green hair, eyebrows, beard, teeth, fingernails and toenails!\n" \
"    6       The potion being baked was actually a toxin, Dragon Venom! It went bad, so it didn't kill you outright. Instead, lower your Constitution by 3 permanently."
},
{ // 176
"You can rest for 5 turns, thus restoring the proper amount of Strength and Constitution for that time. Take 160 ap for destroying the ghosts. They had no treasure. When you are done go to {147}."
},
{ // 177
"You search for a long time, but find no other exit. If you wish to break down the brick wall in order to see if it hides an exit, go to {168}. If you wish to check out the landing now, go to {186}."
},
{ // 178
"You draw your weapon and slash at the guard closest to you. You will have to kill the guard before you can attack the woman.\n" \
"  Calla, the guard:\n" \
"    Strength:     16    Crossbow: 5d6\n" \
"    Intelligence: 10    Short sword: 3d6\n" \
"    Luck:         13\n" \
"    Constitution: 16    Leather armour: 6 hits taken\n" \
"    Dexterity:    12\n" \
"    Charisma:     11\n" \
"    Speed:        12\n" \
"  The Initiate:\n" \
"    Strength:     10[    Will always cast Take That You Fiend in combat for 28 points of damage.]\n" \
"    Intelligence: 28\n" \
"    Luck:         12\n" \
"    Constitution: 22\n" \
"    Dexterity:    18\n" \
"    Charisma:     12\n" \
"    Speed:        18\n" \
"Calla will not be able to draw his short sword until he drops his crossbow, so you will get one free attack on him. If you kill him, you can try to attack the woman.\n" \
"  If any case when you are fighting Calla, the woman will have an opportunity to cast a spell at you. Take 28 points off your Constitution from your Take That You Fiend. If you survive, you may continue to fight. Otherwise, you die. If you survive, take 340 ap. You may go through the door behind the tapestry after taking the guard's crossbow (if you want it) by going to {195}."
},
{ // 179
"You reach the opening which proves to open onto the outside of the house. You turn back towards the front of the mansion only to notice that most of the upper floors are engulfed in flames.\n" \
"  You and your guide watch as the old house burns to the ground. You get 125 ap for completing the adventure. Close the book."
},
{ // 180
"In the all seeing rays of the third, Omnipotent Eye, you can see the lines of ancient magic that permeate the atmosphere of Vaning Manor. You realize that this place has been cursed for a long time, and that the curse is even now at work against you. You will also perceive an undercurrent of opposition to the power of the curse, as yet embryonic, but it could flare into full power at any time. (Return to the paragraph that sent you to the Magic Matrix.)"
},
{ // 181
"Your Curses Foiled will un-animate the zombie. Take 250 ap for quick thinking and go to {119}. You will get the full reward at {119} for your actions."
},
{ // 182
"This type of demon thrives on anonymity! By casting a spell which reveals that which is hidden, you have banished it!\n" \
"  As the demon dissolves into the nether planes from whence it came it drops a small golden orb. You carefully Omni-eye the orb, but it proves to have no harmful magic on it. In fact, you realize that the spells on the orb are such that it will allow you cast a Protective Pentagram that will last for 6 turns for a Strength cost of only 6. Go to {11}. Take 250 ap for not sleeping during your Master's lecture on basic demon banishing."
},
{ // 183
"Marching on, you come to a spiral stairway that leads up into the upper floors of the old mansion. Taking this path, you will come up in a large room, some three stories above the ground level.\n" \
"  You stand agog! This one room is the greatest treasure you could possibly find in a place such as this! You realize that you have stumbled on the study of a magician of great power and learning. Slowly your eyes roam the stacks of books, the dwarven manufactured furnace, the neatly arranged vials of magical paraphernalia. Surely this is the best this place has to offer.\n" \
"  You may search the combination study, workshop and library by going to {159} to look for books, or you may begin to open vials and bottles, looking for magical potions, go to {166}, or you may open the alchemical furnace to see what may have been cooking by going to {175}, or you may cast a Detect Magic, go to {184}."
},
{ // 184
"As soon as you finish your spell you realize that it was the very best thing you could have done. The years have not been kind to this magician's sanctum. Over the passage of time many enchantments that should have been maintained for safety's sake were left to vanish. You know to avoid some danger spots, and you know what is magical and safe to take. You move to gather up your treasure!\n" \
"  You find a book on summoning fire elementals worth 1800 gp to your master, the Aged One, a small ring which would have gone unnoticed in the debris[ which will cast a Second Sight spell at level 5 power for 12 Strength points], a bit of unicorn horn[ which will neutralize any type of poison or toxin it is dipped into], and a Bag of Plenty which will hold 50# worth of weight[ in things that could fit through the opening in the bag (4\" x 4\" roughly)] but which will only weigh 5#[ and take up the volume of the bag].\n"
"  Further, for thinking like a magic user take 1000 ap, and use the secret magic door thus revealed by your spell to exit Vaning House. Since you have all the best that this place has to offer, you never return."
},
{ // 185
"You do not pause to rest, nor do you pause to search for treasure. Make a L2-SR on Luck (25 - LK). If you make it, go to {193}. If you miss, go to {242}. Take 260 ap for obliterating the ghosts."
},
{ // 186
"This interlude has been restful enough that you have restored 7 points of Strength lost from casting spells, and 2 points of Constitution lost in combat. You may cast Restoration spells to top off your Constitution if you wish. Go now to {42}."
},
{ // 187
"There is no paragraph {187}. You must have cheated to get here! Poof! You have been turned into a toad! So there! And stop peeking."
},
{ // 188
"Your eyes flit from shadow to shadow as you briskly jog along the latest in a seemingly endless string of winding, twisting, turning corridors. Abruptly you feel a change come over the atmosphere of the hallway. Your hair rises n your neck and along your spine, the feeling of invisible daggers plunging into your body palpable in the sudden darkness.\n" \
"  The section ahead of you is totally dark; no light escapes its stygian depths. An eldritch blast of cool, damp air stirs the edges of you cloak, coming as if from the nostrils of some evil winter troll.\n" \
"  You may continue into the darkness, go to {149}. You can cast a Will-o-Wisp spell, go to {158}. You can pick your pack up, and try to run into the darkness, as if through an arcane gauntlet, go to {165}. Or, on the chance that it may reveal some hidden spell or enchantment, you could cast a Detect Magic. Go to {174}."
},
{ // 189
"You detect magic emanating from the skull on the pedestal. (Return to the paragraph that sent you to the Magic Matrix.)"
},
{ // 190
"You discover a secret door with your spell. To take it, go to {201}. To go back the way you came, go to {107}."
},
{ // 191
"How soon you have forgotten the mage rules of survival! Never, never charge a bunch of ghouls! They are cunning, these vultures in human form. Though not a match for a healthy man, they can be more than a match for a man who has fallen into a pit of spikes! Too late you realize that these creatures live here. They know all the ins and outs of Vaning House. Where the pits with spikes are, for instance.\n" \
"  Make a L3-SR on Dexterity (30 - DEX). If you make the roll, go to {141}. If you miss the roll, go to {150}."
},
{ // 192
"You search around in the debris that litters the floor until you find a large sapphire which is worth 100 gp. Now continue on to {147}."
},
{ // 193
"You notice a secret door. Opening it, you follow the corridor thus revealed to a tunnel which ends just outside the house in a copse of trees. Noticing your guide nearby, you rejoin him and take your leave of Vaning House and its evil story! Close the book."
},
{ // 194
"As soon as you touch the corpse its eyes open! To fight it, go to {203}; to talk to it, go to {212}."
},
{ // 195
"The passage revealed beyond the door is long as treacherous, leading down a steep incline. It takes you several seconds to reach the bottom. Once there you must cast a Will-o-Wisp spell to light the way into this large room.\n" \
"  The room must be the inner sanctum of the Temple of Krwonsku that you were told of by the ghost of Lord Vaning. Its high vaulted roof is decorated with scenes of bloodshed the likes of which only a demon of Krwonsku's tastes could admire. Against the far wall is a huge crystal throne upon which sits a wizened husk of a man.\n" \
"  You realize that these must be the mortal remains of Semaj the Black! If you wish to go closer, go to {204}. If you wish to take out the Heart of Edualc right now, go to {213}."
},
{ // 196
"You reach the end of the hallway where you find a short stocky man. He looks you in the eye and says, \"You're on the wrong track, friend. You needed to go up to the second floor. Take this ladder.\"\n" \
"  If you wish to take the ladder, go to {33}. If you wish to attack the man, go to {214}."
},
{ // 197
"Sometimes it pays to just look around for the pleasure of looking! Roll 2d6:\n" \
"    2       You find a dirk of dwarven manufacture. It does 3d6+1 and is worth 54 gp.\n" \
"    3-5     You find a treasure of 30 gold pieces and 15 silver pieces.\n" \
"    6-8     You find nothing of note.\n" \
"    9-11    You find a small bronze salt shaker. Inside is a powder which will neutralize any toxin or poison once. (1 dose is in the shaker. When it is empty, the shaker will be worth 12 gold pieces.)\n" \
"    12      You find a small brown spider, which you promptly squish. Now you'd just better hope you don't run into Mama Shelob, the baby's mum!\n" \
"You may only get each item on this list once."
},
{ // 198
"The troll is actually just a big bully. Double the effects of your spell. If you came from {31} go to {18} to find out how well you did. If you came from {18} this is not a mistake. Double the effects of your spell and return to {18}."
},
{ // 199
"This thing thrives on fear! Go to {115}."
},
{ // 200
"The mirror shatters! Behind it you will find a vanity with a box of jewels on it worth 300 gp. Take 145 ap and go to {145}."
},
{ // 201
"You stumble around in the secret passage for quite some time. At one point you smell smoke. Panic spurs you on to greater efforts. Soon you come out in a tiny, damp, evil smelling room. A ladder on one wall leads up to a wooden trapdoor. To climb out, go to {210}. To go back and search for some other exit, go to {219}."
},
{ // 202
"You stumble into a trapdoor set in the floor of the corridor. It will lead you to {147}."
},
{ // 203
"\"Evil!\" it shrieks. \"Evil is at work here! Beware!\" In order to attack it with spells choose your spell, write it down, and refer to the Magic Matrix. In order to fight with weapons, go to {220}."
},
{ // 204
"Before you can go more than a few feet into the room Semaj opens his dehydrated eyes: \"Who are you? You are not one of my Initiates!\"\n" \
"  He casts a very powerful Take That You Fiend at you that does more damage than you can handle. Close the book, you have died."
},
{ // 205
"You also get 10,000 ap. Go to {187}."
},
{ // 206
"You fly up near the ceiling where you find a trapdoor. This opens into a short corridor, which terminates in a secret door. Open it and go to {161}."
},
{ // 207
"You realize that all you really need to do is grab hold of Princess Nanus and fly her out of here! Take 100 ap for thinking like a magic user and go to {96} and ignore the part about the lasso."
},
{ // 208
"This thing is indeed a function of a curse! One on you! Lucky for you it's an old and somewhat weak curse. You disperse its effects and the darkness goes away. Go to {35}. Take 150 ap for creative thinking."
},
{ // 209
"Sometimes it pays to just look around for the pleasure of looking! Roll 2d6:\n" \
"    2       You find a dirk of dwarven manufacture. It does 3d6+1 and is worth 54 gp.\n" \
"    3-5     You find a treasure of 30 gold pieces and 15 silver pieces.\n" \
"    6-8     You find nothing of note.\n" \
"    9-11    You find a small bronze salt shaker. Inside is a powder which will neutralize any toxin or poison once. (1 dose is in the shaker. When it is empty, the shaker will be worth 12 gold pieces.)\n" \
"    12      You find a small brown spider, which you promptly squish. Now you'd just better hope you don't run into Mama Shelob, the baby's mum!\n" \
"You may only get each item on this list once. (Return to the paragraph that sent you to the Magic Matrix.)"
},
{ // 210
"You climb out of an old cistern near the gate. You see that Vaning Manor is almost completely burned to the ground. Kessel is started by your sudden appearance. \"Oi! I thought you'd died, what with the fire and all! You must tell me how you managed to survive!\" As you make your way back to the village you relate your adventures to Joris, only adding a bit here and there to spice things up. Take 150 ap for surviving and close the book."
},
{ // 211
"If you missed your saving roll, you lose half your Strength to the ghost's evil dragining. You must fight at this reduce level, knowing that only rest and recuperation time will restore the lost Strength. Go to {167}. If you made your saving roll, you need not subtract half of your Strength! You resisted the ghost's efforts! Go to {230}."
},
{ // 212
"\"Evil!\" it shrieks. \"Evil is at work here! Beware!\" You stand stock still listening to the thing's words.\n" \
"  \"My Lord Vaning tried to stop him! Semaj is evil incarnate! His spirit still dwells within the walls of this cursed house. Beware his minions, they are everywhere!\"\n" \
"  Your spine tingles. It is as the Aged One implied! There are forces at work here that have ramifications even in this day and age! You hang on every word the mummy creaks out, fearing to miss some clue that could lead you to the answer to the Aged One's questions.\n" \
"  \"Lord Vaning holds the key to destroying Semaj. He holds the Heart of Edualc the Red! Take it from his hands and you will be invincible! But do not seek to betray Lord Vaning! Cursed are all betrayers! Take my smallest finger bone as a token of protection.\"\n" \
"  If you take the finger bone, go to {144}. If you wish to leave, go back to the landing at {42}. There are no other ways out of this place."
},
{ // 213
"As soon as you take out the Amulet an intense white light bathes the room! A voice shouts out a spell in an arcane language dead for a thousand years! Semaj is consumed in the blinding light of Edualc's fury!\n" \
"  You look about you in astonishment, taking a few seconds to comprehend the destruction you have witnessed. The voice of Lord Vaning captures your attention: \"You have destroyed Semaj and banished the evil power of Krwonsku! I thank you with all my heart! Go now, while you can! You will find a great treasure in the great oak beside the main gate!\"\n" \
"  Hastily you run from the house as smoke begins to tinge the atmosphere. Once outside you see that a fire has broken out. The old mansion burns quickly.\n" \
"  Once outside you find the oak tree easily. You and your guide are able to make it back to town with ease.\n" \
"  The treasure in the tree consists of 3000 gp worth of gems, jewels, and silver plated dishes. Lord Vaning must have hidden these things before his death fifty years ago.\n" \
"  When you return to the Sanctum of the Aged One he calls you into his study and holds out a wand. Taking it, you discover it to be a deluxe staff! \"You have earned this, my friend. Go, be the best mage you can be!\"\n" \
"  Apprentice no longer, you enter the world a power to be reckoned with. Take 750 ap for successfully completing the adventure."
},
{ // 214
"You prepare to cast your spell, but before you can complete the most basic gestures the ghost dematerializes. You must go back to {196}. Do not return here."
},
{ // 215
"This troll is particularly susceptible to Dreamweaver spells. He collapses like a puppet with its strings cut. (Return to the paragraph that sent you to the Magic Matrix.)"
},
{ // 216
"You notice that the lasso is magical. If you wish to cast an Omnipotent Eye on the lasso, go to {223}."
},
{ // 217
"Wrong choice! This thing can't be dispelled! Go back to {115}, while there is still a chance!"
},
{ // 218
"You detect magic emanating from a small vial wedged between the floor and the baseboard along the side of the corridor. You take it up and find that it contains a metal sewing needle.\n" \
"  Further investigation proves that this needle will always point north when the vial is floating in water. When the vial is floating in wine it will indicate the nearest secret door. When floating in milk it will indicate the nearest pure water. (Directions laboriously printed on the cap of the vial help somewhat.) Take 75 for thinking to cast the spell. (Return to the paragraph that sent you to the Magic Matrix)."
},
{ // 219
"As you wander the maze of secret corridors under the old house you can feel the air getting warmer and warmer and more and more smoke fills the air. Soon it is hard to breathe. Make a L4-SR on Luck (35 - LK). If you make it, go to {227}. If you miss it, close the book. You have died of smoke inhalation."
},
{ // 220
"Your weapons rip into the mummified flesh of the corpse. All the while it keeps screaming \"Evil! Beware the evil!\" Finally it falls into a pile of dust. Take 10 ap for destroying this animated corpse. There are no other exits from this room. Go to the landing via {42}."
},
{ // 221
"You may take 65 ap for killing the troll. You will find that he has a very small bag in his filthy loincloth that contains 35 copper pennies and a small bit of quartz worth 12 more coppers. Continue down the corridor by going to {38}."
},
{ // 222
"If you cast either of these two spells, you will see a small, purple glowing crystal way in the back. You realize that this is magical, and that it is worth much more than any of the rubies or diamonds littering the room. You can take your IQ in rubies, as noted, and a like amount of diamonds. The rubies will retail for 8 gp each, and the diamonds for 10. The purple crystal is a rare one called Dragon Egg. It is worth 300 gp. Go to {112}."
},
{ // 223
"You learn that the lasso has a modified Lock Tight on it. Whenever you tie anyone or anything up with this lasso it will take a Dis-Spell or an Unlock to untie it. Return to {118}."
},
{ // 224
"The power of the Omnipotent Eye shows you a lattice of horrible magics indicating the presence of a powerful curse in action. In order to avoid becoming enmeshed in this curse you must search for some other route. You already are deeply enough into the effects of the curse that you cannot go back the way you came. To cast a Revelation, go to {190}. In order to search without using magic, go to {107}."
},
{ // 225
"Very creative! It isn't a disease, but the healing spell has a very strong element of good in it. This gives the demons pause and they withdraw to consider for a short time. Make some other choice by writing it on a piece of paper and consulting the Magic Matrix line for paragraph {107}. Take 150 ap for creative thinking."
},
{ // 226
"This spell works fine on the lead ghost, but the rest just fall in behind him. Before you can ready another spell the other ghosts fall on you and drain your life away. Close the book, you are dead."
},
{ // 227
"You stumble out of the maze of corridors into the burned out ruins of Vaning Manor. Take 125 ap and close the book. You lack even Kessel's surly company on your journey back to the village. He left long ago, having given you up for dead."
},
{ // 228
"The corpse shudders, then slumps. A young man appears before you in ghostly form. \"Oh, God! Thank you for freeing my astral self from my body! I have been cursed to feel all that it feels for fifty years! Can you imagine what it is like to feel yourself slowly rot away?\n" \
"  \"Know you that my body is magical. I was a practitioner of an arcane form of magic that concentrates magic power in the bones, organs and joints of the living caster. Take each of my toe bones as reward for releasing me from my cursed state. They will heal your wounds when cracked by your dagger or against a stone.\"\n" \
"  Each toe may be used one time. You may collect 10 toes. Since you no longer wish to fight the corpse, go to {212} and listen to what the ghost has to say."
},
{ // 229
"You wake up in a crawl space under the floors of Vaning House. As you look around yourself you notice light coming from a small opening.\n" \
"  As you crawl towards this opening make a L1-SR on Luck (20 - LK). If you make your roll, go to {170}. If you miss your roll, go to {179}."
},
{ // 230
"Your first desperate blow blasts clear through the lead ghost's insubstantial body and strikes a metal object that is floating in the hand of the second spirit!\n" \
"  With a loud keening shriek all the ghosts are sucked into a vortex of energy! Your blow has destroyed the Sceptre of Krwonsku the Blood Drinker! Its power was what held the ghosts in the world of the living.\n" \
"  Take 300 ap for destroying the Sceptre! Searching around, you notice that the ghosts all dropped some bit of jewellery when they were sucked into the vortex. Each piece is worth 100 gp and each of the 8 ghosts had one piece of jewellery. Go to {147}."
},
{ // 231
"Among all the magical paraphernalia, you find a wondrous deluxe staff that contains all the 4th and 5th level magic spells. Now go to {205}."
},
{ // 232
"If you chose to cast fire Blasting Power, go to {151}. If you chose any other type of Blasting Power, you are overwhelmed by the ghosts. Close the book, you are now dead. Sorry, better luck next time..."
},
};

MODULE SWORD ns_exits[NS_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {   8,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  { 161,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  48,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  { 221,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  31,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  { 152,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  20,  32,  40,  -1,  -1,  -1,  -1,  -1 }, //  33
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  { 123, 130, 138,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  { 120, 127,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  {  63,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41
  {  66,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {   4,  11,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44
  {  21,  28,  34,  -1,  -1,  -1,  -1,  -1 }, //  45
  {  83,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46
  {  39,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  55,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  45,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  33,  42,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51
  {  41,  54,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {   7,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  {   7,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54
  {  16,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  {  92, 100,  59,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  {  78,  93,  -1,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  83,   7,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {  80,  92,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  {  84,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  58,  68,  73,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  94,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  {  41,  75,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  86,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  69
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  {  87,  94,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  {  77,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {  56,  83,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {   7,  83,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  46,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  {  85,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  77
  {  86,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  94,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  64,  66,  73,  -1,  -1,  -1,  -1,  -1 }, //  82
  {  57,  66,  -1,  -1,  -1,  -1,  -1,  -1 }, //  83
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  16,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  {  99,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  86
  { 110,  65,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  78,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  {  71,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  94
  { 118, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  95, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  { 153, 169,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 101
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  { 133, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  { 109,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 105
  { 113,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  { 119,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  79,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 110
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  { 229,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 113
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 116
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 117
  {  70, 125,  -1,  -1,  -1,  -1,  -1,  -1 }, // 118
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 119
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 120
  { 136,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 121
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 122
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 123
  { 131, 139,  -1,  -1,  -1,  -1,  -1,  -1 }, // 124
  { 109,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 125
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 126
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 127
  { 112, 108,  -1,  -1,  -1,  -1,  -1,  -1 }, // 128
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 129
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 130
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 131
  { 188, 140,  -1,  -1,  -1,  -1,  -1,  -1 }, // 132
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 133
  {  97, 105,  -1,  -1,  -1,  -1,  -1,  -1 }, // 134
  { 106, 113,  -1,  -1,  -1,  -1,  -1,  -1 }, // 135
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 136
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 137
  { 130,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 138
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 139
  { 156,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 140
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 141
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 142
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 143
  {  42,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 144
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 145
  { 229,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 146
  { 155,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 147
  { 188,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 148
  { 192, 147,  -1,  -1,  -1,  -1,  -1,  -1 }, // 149
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 150
  { 176, 185,  -1,  -1,  -1,  -1,  -1,  -1 }, // 151
  {  22,  30,  -1,  -1,  -1,  -1,  -1,  -1 }, // 152
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 153
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 154
  { 162,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 155
  { 164, 132,  -1,  -1,  -1,  -1,  -1,  -1 }, // 156
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 157
  { 183, 191,  -1,  -1,  -1,  -1,  -1,  -1 }, // 158
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 159
  { 211, 143,  -1,  -1,  -1,  -1,  -1,  -1 }, // 160
  { 168, 177, 186,  -1,  -1,  -1,  -1,  -1 }, // 161
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 162
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 163
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 164
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 165
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 166
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 167
  { 194, 186,  -1,  -1,  -1,  -1,  -1,  -1 }, // 168
  { 178,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 169
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 170
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 171
  {  88,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 172
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 173
  { 167,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 174
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 175
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 176
  { 168, 186,  -1,  -1,  -1,  -1,  -1,  -1 }, // 177
  { 195,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 178
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 179
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 180
  { 119,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 181
  {  11,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 182
  { 159, 166, 175,  -1,  -1,  -1,  -1,  -1 }, // 183
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 184
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 185
  {  42,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 186
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 187
  { 149, 165,  -1,  -1,  -1,  -1,  -1,  -1 }, // 188
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 189
  { 201, 107,  -1,  -1,  -1,  -1,  -1,  -1 }, // 190
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 191
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 192
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 193
  { 203, 212,  -1,  -1,  -1,  -1,  -1,  -1 }, // 194
  { 204,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 195
  {  33,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 196
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 197
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 198
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 199
  { 145,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 200
  { 210, 219,  -1,  -1,  -1,  -1,  -1,  -1 }, // 201
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 202
  { 220,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 203
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 204
  { 187,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 205
  { 161,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 206
  {  96,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 207
  {  35,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 208
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 209
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 210
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 211
  { 144,  42,  -1,  -1,  -1,  -1,  -1,  -1 }, // 212
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 213
  { 196,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 214
  { 221,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 215
  { 223,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 216
  { 115,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 217
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 218
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 219
  {  42,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 220
  {  38,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 221
  { 112,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 222
  { 118,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 223
  { 107,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 224
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 225
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 226
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 227
  { 212,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 228
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 229
  { 147,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 230
  { 205,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 231
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 232
};

MODULE STRPTR ns_pix[NS_ROOMS] =
{ "", //   0
  "ns1",
  "",
  "",
  "",
  "",
  "",
  "",
  "ns8",
  "",
  "", //  10
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", //  20
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", //  30
  "",
  "",
  "",
  "",
  "ns35",
  "",
  "",
  "",
  "",
  "", //  40
  "",
  "ns42",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", //  50
  "",
  "",
  "",
  "",
  "",
  "",
  "ns-p55", // 57
  "",
  "",
  "", //  60
  "",
  "",
  "ns63",
  "",
  "",
  "",
  "",
  "",
  "",
  "", //  70
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", //  80
  "",
  "",
  "ns83",
  "",
  "",
  "",
  "",
  "",
  "",
  "", //  90
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 100
  "",
  "ns-p55", // 102
  "",
  "",
  "",
  "",
  "",
  "ns-p55", // 108
  "",
  "", // 110
  "ns-p55", // 111
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 120
  "",
  "",
  "",
  "ns124",
  "",
  "",
  "",
  "",
  "",
  "", // 130
  "",
  "",
  "",
  "ns134",
  "",
  "",
  "",
  "",
  "",
  "", // 140
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 150
  "ns151",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 160
  "",
  "",
  "",
  "ns164",
  "",
  "ns-p55", // 166
  "",
  "",
  "",
  "ns-p55", // 170
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "ns178",
  "ns-p55", // 179
  "", // 180
  "",
  "ns182",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 190
  "",
  "",
  "",
  "",
  "ns195",
  "",
  "",
  "",
  "",
  "", // 200
  "",
  "",
  "",
  "ns204",
  "",
  "",
  "",
  "",
  "",
  "ns-p55", // 210
  "",
  "ns212",
  "ns-p55", // 213
  "",
  "",
  "",
  "",
  "",
  "",
  "", // 220
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "",
  "ns230", // 230
  "",
  "", // 232
};

MODULE FLAG                   got[3];

IMPORT TEXT                   name[80 + 1];
IMPORT int                    age,
                              armour,
                              bankcp,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              killcount[RACES],
                              prevroom, room, module,
                              spellchosen,
                              spellcost,
                              spelllevel,
                              spellpower,
                              theround,
                              thethrow;
IMPORT const int              races_table[37];
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct RacesStruct     races[RACES];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void ns_enterroom(void);
// MODULE void ns_wandering(FLAG mandatory);

EXPORT void ns_preinit(void)
{   descs[MODULE_NS]   = ns_desc;
 // wanders[MODULE_NS] = ns_wandertext;
}

EXPORT void ns_init(void)
{   int i;

    exits     = &ns_exits[0][0];
    enterroom = ns_enterroom;
    for (i = 0; i < NS_ROOMS; i++)
    {   pix[i] = ns_pix[i];
    }
    for (i = 0; i < 3; i++)
    {   got[i] = FALSE;
}   }

MODULE void ns_enterroom(void)
{   int i;

    switch (room)
    {
    case 1:
        elapse(ONE_YEAR * 3, TRUE);
        DISCARD cast(SPELL_KK, TRUE); // %%: we should force them to do this
    acase 2:
        dicerooms(29, 36, 43, 49, 10, 17);
    acase 3:
        savedrooms(1, lk, 16, 23);
    acase 4:
        create_monster(486);
        DISCARD castspell(-1, FALSE);
    acase 6:
        getsavingthrow(TRUE);
        if (thethrow < 5 || thethrow < 28 - dex)
        {   dispose_npcs();
        }
    acase 7:
        die();
    acase 8:
        do
        {   if (!castspell(-1, FALSE))
            {   if (!been[21] && getyn("Go upstairs"))
                {   room = 21;
                } elif (!been[28] && getyn("Go left"))
                {   room = 28;
                } elif (!been[34] && getyn("Go right"))
                {   room = 34;
                } elif (!been[2] && getyn("Approach skull"))
                {   room = 2;
        }   }   }
        while (room == 8);
    acase 9:
        give(257);
    acase 10:
        permlose_con(3);
        permlose_st(3);
        gain_chr(5);
        gain_dex(5);
    acase 11:
        savedrooms(2, lk, 25, 31);
    acase 12:
        savedrooms(1, con, 19, 26);
    acase 13:
        savedrooms(1, lk, 52, 60);
    acase 14:
        good_takehits(misseditby(1, lk), TRUE);
    acase 15:
        if (!saved(1, dex))
        {   good_takehits(10, TRUE); // %%: we assume armour helps
        }
    acase 17:
        gain_flag_ability(147); // %%: maybe this should be handled as a change of race?
    acase 18:
        if (prevroom != 4 && prevroom != 18 && prevroom != 31 && prevroom != 198)
        {   create_monster(486);
        }
        do
        {   oneround();
        } while (con >= 1 && countfoes() && npc[0].mr > 15);
        if (con >= 1 && countfoes())
        {   // assert(npc[0].mr <= 15);
            aprintf("Troll cuts and runs!\n");
            good_freeattack();
        }
        dispose_npcs();
    acase 20:
        savedrooms(3, iq, 61, 7);
    acase 21:
        savedrooms(1, lk, 9, 14);
    acase 22:
        DISCARD castspell(-1, FALSE);
    acase 23:
        die();
    acase 24:
        makelight();
        if (prevroom != 5)
        {   if     (((prevroom != 19 && prevroom != 26) || !been[51]) && cast(SPELL_KK, TRUE))
            {   room = 51;
            } elif (((prevroom != 19 && prevroom != 26) || !been[ 5]) && cast(SPELL_RE, TRUE))
            {   room = 5;
        }   }
    acase 25:
        award(85);
    acase 26:
        templose_con(dice(1));
    acase 27:
        savedrooms(1, lk, 67, 60); // %%: doesn't actually say which level
    acase 28:
        DISCARD castspell(-1, FALSE);
    acase 29:
        switch (dice(1))
        {
        case 1:
        case 2:
        case 3:
            race = HUMAN;
        acase 4:
        case 5:
            race = ELF;
        acase 6:
            race = ORC;
        } // don't use changerace() for this!
    acase 31:
        create_monster(486);
        if (getyn("Talk"))
        {   dispose_npcs();
            room = 126;
        } else
        {   DISCARD castspell(-1, FALSE);
        }
    acase 32:
        savedrooms(3, iq, 13, 7);
    acase 33:
        if (cast(SPELL_DM, TRUE))
        {   room = 47;
        } elif (cast(SPELL_RE, TRUE))
        {   room = 53;
        }
    acase 34:
        if (cast(SPELL_WO, TRUE))
        {   room = 35;
        }
    acase 35:
        create_monster(492);
        DISCARD castspell(-1, FALSE);
    acase 36:
        gain_flag_ability(4);
        gain_flag_ability(148);
    acase 37:
        makelight();
        if (lightsource() != LIGHT_NONE)
        {   room = 44;
        }
    acase 39:
        savedrooms(2, lk, 67, 75);
    acase 40:
        savedrooms(3, iq, 27, 7);
    acase 42:
        create_monster(487);
        if (cast(SPELL_TF, FALSE))
        {   room = 48;
        } else
        {   dispose_npcs();
        }
    acase 43:
        gain_flag_ability(149);
    acase 44:
        DISCARD castspell(-1, FALSE);
    acase 46:
        gain_flag_ability(150);
        // already awarded ap at the time they killed it
    acase 47:
        if (cast(SPELL_RE, TRUE))
        {   room = 53;
        }
    acase 48:
        if (prevroom == 6)
        {   while (con >= 1 && countfoes())
            {   DISCARD cast(SPELL_TF, TRUE);
                getsavingthrow(FALSE);
                if (spd > dex)
                {   if (thethrow >= 5 && thethrow >= spd - npc[0].iq)
                    {   templose_st(st / 2);
                }   }
                else
                {   if (thethrow >= 5 && thethrow >= dex - npc[0].iq)
                    {   templose_st(st / 2);
        }   }   }   }
        else
        {   templose_st(st / 2);
            payload(TRUE);
            if (countfoes())
            {   room = 6;
        }   }
    acase 49:
        gain_st(5);
        lose_dex(3);
    acase 50:
        die();
    acase 55:
        give(814);
        give(815);
        award(65);
        if (getyn("Rest"))
        {   elapse(100, TRUE);
            healall_st();
        }
    acase 57:
        victory(225);
    acase 58:
        give(816);
    acase 61:
        savedrooms(3, iq, 13, 7);
    acase 66:
        savedrooms(4, lk, 90, 98);
    acase 68:
        templose_st(st / 2);
    acase 69:
        payload(TRUE);
        if (countfoes())
        {   die();
        }
    acase 70:
        savedrooms(1, dex, 96, 104);
    acase 71:
        if (items[816].owned && getyn("Take out Amulet of Edualc"))
        {   room = 102;
        } else
        {   castspell(-1, FALSE);
        }
    acase 73:
        create_monster(489);
        DISCARD castspell(-1, FALSE); // this is not quite right?
    acase 76:
        create_monster(488);
        fight();
    acase 77:
        if (prevroom != 73)
        {   create_monster(489);
        }
        do
        {   getsavingthrow(FALSE);
            if (spd > dex)
            {   if (thethrow >= 5 && thethrow >= spd - npc[0].iq)
                {   templose_st(st / 2);
            }   }
            else
            {   if (thethrow >= 5 && thethrow >= dex - npc[0].iq)
                {   templose_st(st / 2);
            }   }
            if (enchanted_melee() || (theround == 1 && enchanted_missile()))
            {   good_freeattack();
        }   }
        while (con >= 1 && countfoes());
    acase 78:
        if (prevroom != 92)
        {   create_monster(490);
        }
        good_freeattack();
        if (countfoes())
        {   die();
        }
    acase 79:
        good_takehits(28, TRUE); // %%: we assume armour helps
    acase 80:
        savedrooms(1, lk, 72, 94); // we are supposed to do the roll in room 62 instead, doesn't matter though.
    acase 81:
        victory(110);
    acase 83:
        if (prevroom != 74 && cast(SPELL_RE, TRUE))
        {   room = 74;
        } elif (prevroom != 74 && cast(SPELL_OE, TRUE))
        {   room = 82;
        } elif (prevroom != 74)
        {   DISCARD castspell(-1, FALSE);
        }
    acase 84:
        give_multi(817, 5);
    acase 85:
        // already awarded the ap when they killed it
        give(835);
        give(836);
        give(837);
        gain_flag_ability(151);
    acase 86:
        award(165);
    acase 87:
        if (items[816].owned && getyn("Take out Amulet of Edualc"))
        {   room = 102;
        }
    acase 88:
        die();
    acase 89:
        if (enchanted_melee() || enchanted_missile())
        {   kill_npcs();
            room = 111;
        } else
        {   room = 109;
        }
    acase 90:
        if (been[21] && been[28] && been[34] && been[2])
        {   room = 81;
        } else
        {   room = 8;
        }
    acase 91:
        die();
    acase 92:
        create_monster(490);
        if (cast(SPELL_TF, FALSE))
        {   room = 69;
        }
    acase 93:
        if (saved(1, iq))
        {   if (saved(1, chr))
            {   room = 72;
            } else
            {   room = 62;
        }   }
        else
        {   if (saved(1, chr))
            {   room = 62;
            } else
            {   room = 101;
        }   }
    acase 94:
        create_monster(490);
        if (prevroom == 65)
        {   int result = dice(1); // We are supposed to do the roll at NS65 instead of here, but it doesn't matter.

            if (dex > 12)
            {   result += dex - 12;
            } // %%: we it doesn't how negative adds would affect it
            evil_takehits(0, result); // she doesn't wear armour anyway
        }
        if (prevroom != 79)
        {   good_freeattack();
        }
        while (con >= 1 && countfoes())
        {   oneround();
        }
    acase 96:
        give_gp(1000);
        give(838);
        victory(500);
    acase 97:
        give(ITEM_NS_HOMUNCULUS); // could be implemented as an ability[] instead
    acase 98:
        if (saved(1, lk))
        {   room = 91;
        } else
        {   templose_con(misseditby(1, lk));
            room = 99;
        }
    acase 99:
        if (prevroom != 86)
        {   award(100);
        }
        if (cast(SPELL_RE, TRUE))
        {   room = 103;
        }
    acase 100:
        heal_st(5);
        heal_con(1);
    acase 101:
        if (saved(7, lk))
        {   victory(200);
        } else
        {   die();
        }
    acase 102:
        give_gp(4000); // %%: some of it is supposed to be in the form of "gems, jewels and silver plated dishes"
        give(DEL);
        victory(1000);
    acase 105:
        gain_iq(1);
    acase 106:
        if (getyn("Stand your ground"))
        {   savedrooms(1, iq, 121, 128);
        }
    acase 107:
        if (!castspell(-1, FALSE))
        {   room = 115;
        }
    acase 108:
        victory(125);
    acase 109:
        if (prevroom == 89)
        {   castspell(-1, FALSE);
        } else
        {   if (prevroom != 104 && prevroom != 125)
            {   give(841);
            }
            create_monster(491);
            if (!castspell(-1, FALSE))
            {   room = 89;
        }   }
    acase 110:
        if (items[816].owned && getyn("Take out Amulet of Edualc"))
        {   room = 102;
        } elif (!castspell(-1, FALSE))
        {   room = 79;
        }
    acase 111:
        give_gp(1000);
        give(838);
        award(500);
    acase 112:
        if (items[846].owned && prevroom != 129 && prevroom != 154)
        {   room = 129;
        }
        if (items[842].owned && prevroom != 154)
        {   room = 154;
        }
        savedrooms(1, lk, 137, 147);
    acase 114:
        give_multi(842, iq / 2);
    acase 115:
        die();
    acase 116:
        award(150);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 117:
        gain_lk(2);
    acase 118:
        give(863);
        castspell(-1, FALSE);
    acase 119:
        // already awarded the ap when they killed him
        victory(250);
    acase 120:
        if (saved(1, lk))
        {   elapse(50, TRUE);
            room = 127;
        } else
        {   room = 135;
        }
    acase 121:
        if (cast(SPELL_OE, TRUE))
        {   room = 136;
        }
    acase 122:
        give_multi(842, iq);
    acase 123:
        dispose_npcs();
        if (spell[SPELL_TF].known && cast(SPELL_TE, TRUE))
        {   room = 148;
        }
    acase 124:
        castspell(-1, FALSE);
    acase 126:
        if (chr < 12 || !saved(1, chr))
        {   room = 18;
        } else
        {   room = 134;
        }
    acase 127:
        elapse(50, FALSE);
        heal_st(2);
    acase 128:
        award(75);
    acase 130:
        if (prevroom == 138)
        {   evil_freeattack();
        }
        while (con >= 1 && countfoes())
        {   oneround();
        }
    acase 131:
        savedrooms(1, spd, 145, 157);
    acase 132:
        elapse(30, TRUE);
    acase 133:
        victory(250);
    acase 134:
        give(843);
        give(844);
        give(845);
    acase 135:
        elapse(30, TRUE);
    acase 136:
        award(110);
        give_multi(846, iq);
        if (race == DWARF)
        {   room = 122;
        } elif (cast(SPELL_DM, TRUE) || cast(SPELL_RE, TRUE))
        {   room = 222;
        }
    acase 137:
        give(847);
    acase 139:
        die();
    acase 140:
        if (cast(SPELL_DM, TRUE))
        {   room = 196;
        }
    acase 141:
        templose_con(con - 1);
        elapse(ONE_DAY * 3, TRUE);
        victory(150);
    acase 142:
        award(160);
    acase 143:
        // we are supposed to do the saving roll at NS160 instead of here
        if (!saved(3, st))
        {   templose_st(st / 2);
        }
        if (cast(SPELL_BP, TRUE)) // it doesn't matter that we haven't created any enemies
        {   room = 151;
        } else
        {   DISCARD castspell(-1, FALSE);
        }
    acase 144:
        give(848);
        award(150);
    acase 145:
        award(150);
        if (getyn("Leave adventure"))
        {   victory(0);
        }
    acase 146:
        award(55);
    acase 147:
        DISCARD castspell(-1, FALSE);
    acase 148:
        give(253);
        give(849);
        award(100);
    acase 149:
        castspell(-1, FALSE);
    acase 150:
        die();
    acase 153:
        die();
    acase 155:
        DISCARD castspell(-1, FALSE);
    acase 156:
        // already awarded the ap when they killed him
        give(253); // diamond
        if (!been[156])
        {   give(850);
        }
        if (!been[117] && getyn("Examine rabbit's foot"))
        {   room = 117;
        }
    acase 157:
        die();
    acase 158:
        award(150);
    acase 159:
        healall_st();
        heal_con(1);
        give(851);
    acase 162:
        savedrooms(1, lk, 107, 115);
    acase 163:
        savedrooms(2, lk, 116, 124);
    acase 164:
        if (saved(9, lk))
        {   elapse(ONE_DAY * 10, TRUE);
            victory(0);
        } else
        {   elapse(ONE_DAY * 12, TRUE);
            die();
        }
    acase 165:
        if (!saved(1, dex))
        {   good_takehits(8, TRUE);
        }
    acase 166:
        victory(85);
    acase 167:
        die();
    acase 169:
        create_monster(493);
        castspell(-1, FALSE);
    acase 170:
        give_gp(30);
        give_sp(8);
        victory(125);
    acase 171:
        give_gp(1);
        gain_lk(1);
        // assert(prevroom == 8);
        room = prevroom;
    acase 172:
        if (items[816].owned && getyn("Use Heart of Edualc"))
        {   room = 102;
        }
    acase 173:
        if (cast(SPELL_OE, TRUE))
        {   room = 224;
        }
    acase 174:
        if (cast(SPELL_WO, TRUE))
        {   room = 142;
        } elif (cast(SPELL_BP, TRUE))
        {   room = 151;
        } elif (cast(SPELL_PA, TRUE))
        {   room = 160;
        } else
        {   castspell(-1, FALSE);
        }
    acase 175:
        switch (dice(1))
        {
        case  1: gain_st(3);
        acase 2: gain_iq(2);
        acase 3: lose_chr(10);
        acase 5: gain_flag_ability(152);
        acase 6: permlose_con(3);
        }
    acase 176:
        elapse(50, TRUE);
        award(160);
    acase 178:
        if (prevroom != 169)
        {   create_monster(493);
        }
        good_freeattack();
        good_takehits(28, TRUE);
        while (countfoes() && con >= 1)
        {   oneround();
        }
        create_monster(490);
        npc[0].st -= 6; // for casting spell
        // %%: we should really let her recharge Strength if the previous fight went on long enough
        fight();
        award(340);
    acase 179:
        victory(125);
    acase 180:
        // assert(prevroom == 8);
        room = prevroom;
    acase 181:
        kill_npcs();
        award(250);
    acase 182:
        killcount[DEMON]++;
        DISCARD cast(SPELL_OE, TRUE); // %%: we should force them to do this
        give(852);
        award(250);
    acase 183:
        if (cast(SPELL_DM, TRUE))
        {   room = 184;
        }
    acase 184:
        give(853);
        give(854);
        give(855);
        give(856);
        victory(1000);
    acase 185:
        award(260);
        savedrooms(2, lk, 193, 202);
    acase 186:
        heal_st(7);
        heal_con(2);
        while (cast(SPELL_RS, TRUE));
    acase 187: // anti-cheat
        die();
    acase 188:
        if (cast(SPELL_WO, TRUE))
        {   room = 158;
        } elif (cast(SPELL_DM, TRUE))
        {   room = 174;
        }
    acase 189:
        // assert(prevroom == 8);
        room = prevroom;
    acase 193:
        victory(0);
    acase 195:
        DISCARD cast(SPELL_WO, TRUE); // %%: we should force them to do this
        if (items[816].owned && getyn("Take out Heart of Edualc"))
        {   room = 213;
        }
    acase 196:
        if (!been[214] && getyn("Attack"))
        {   room = 214;
        }
    acase 197: // SPELL_RE from NS28
    case  209: // SPELL_RE from NS149
        switch (dice(2))
        {
        case 2:
            if (!got[0])
            {   got[0] = TRUE;
                give(857);
            }
        acase 3:
        case 4:
        case 5:
            if (!got[1])
            {   got[1] = TRUE;
                give_gp(30);
                give_sp(15);
            }
        acase 9:
        case 10:
        case 11:
            if (!got[2])
            {   got[2] = TRUE;
                give(858);
        }   }
        room = prevroom;
    acase 200:
        give(859);
        award(145);
    acase 203:
        castspell(-1, FALSE);
    acase 204:
        die();
    acase 205: // anti-cheat
        award(10000);
    acase 207:
        award(100);
    acase 208:
        award(150);
    acase 210:
        victory(150);
    acase 211:
        // we are supposed to do the saving roll at NS160 instead of here
        if (saved(3, st))
        {   room = 230;
        } else
        {   templose_st(st / 2);
            room = 167;
        }
    acase 213:
        give_gp(3000); // %%: it is supposed to be in the form of "gems, jewels and silver plated dishes"
        give(DEL);
        victory(750);
    acase 215:
        kill_npcs();
    acase 216:
        DISCARD cast(SPELL_OE, TRUE); // %%: we should force them to do this, since it doesn't offer any alternative
    acase 218:
        give(860);
        award(75);
        // assert(prevroom == 149);
        room = prevroom;
    acase 219:
        savedrooms(4, lk, 227, -1);
    acase 220:
        award(10);
    acase 221:
        // already awarded the ap when they killed him
        give_cp(35);
        give(861);
    acase 222:
        give_multi(846, iq);
        give_multi(842, iq);
        give(862);
    acase 224:
        if (cast(SPELL_RE, TRUE))
        {   room = 190;
        }
    acase 225:
        award(150);
        castspell(-1, FALSE);
    acase 226:
        die();
    acase 227:
        victory(125);
    acase 228:
        give_multi(864, 10);
    acase 229:
        savedrooms(1, lk, 170, 179);
    acase 230:
        award(230);
        killcount[GHOST] += 8;
        give_multi(865, 8);
    acase 231: // anti-cheat
        give(DEL);
        for (i = 0; i < SPELLS; i++)
        {   if (!spell[i].known && (spell[i].level == 4 || spell[i].level == 5))
            {   learnspell(i);
        }   }
    acase 232:
        if (getyn("Was it fire Blasting Power"))
        {   room = 151;
        } else
        {   die();
}   }   }

#define is ==
#define or ||
EXPORT void ns_magicmatrix(void)
{   int spellroom;

    if
    (   (room ==   1 &&  spellchosen == SPELL_KK)
     || (room ==  24 && (spellchosen == SPELL_KK || spellchosen == SPELL_RE || spellchosen == SPELL_WO || spellchosen == SPELL_CE))
     || (room ==  33 && (spellchosen == SPELL_DM || spellchosen == SPELL_RE))
     || (room ==  34 &&  spellchosen == SPELL_WO)
     || (room ==  37 && (spellchosen == SPELL_WO || spellchosen == SPELL_CE))
     || (room ==  47 &&  spellchosen == SPELL_RE)
     || (room ==  48 &&  spellchosen == SPELL_TF)
     || (room ==  83 && (spellchosen == SPELL_RE || spellchosen == SPELL_OE))
     || (room ==  99 &&  spellchosen == SPELL_RE)
     || (room == 121 &&  spellchosen == SPELL_OE)
     || (room == 123 &&  spellchosen == SPELL_TE)
     || (room == 136 && (spellchosen == SPELL_DM || spellchosen == SPELL_RE))
     || (room == 140 &&  spellchosen == SPELL_DM)
     || (room == 143 &&  spellchosen == SPELL_BP)
     || (room == 173 &&  spellchosen == SPELL_OE)
     || (room == 174 && (spellchosen == SPELL_WO || spellchosen == SPELL_BP || spellchosen == SPELL_PA))
     || (room == 182 &&  spellchosen == SPELL_OE)
     || (room == 183 &&  spellchosen == SPELL_DM)
     || (room == 186 &&  spellchosen == SPELL_RS)
     || (room == 188 && (spellchosen == SPELL_WO || spellchosen == SPELL_DM))
     || (room == 195 &&  spellchosen == SPELL_WO)
     || (room == 216 &&  spellchosen == SPELL_OE)
     || (room == 224 &&  spellchosen == SPELL_RE)
    )
    {   fulleffect();
        return;
    } // implied else
    if
    (   spellchosen == SPELL_TF
     && (room == 42 || room == 92)
    )
    {   aprintf("Your spell will take effect.\n");
        return;
    }

    aprintf(
"MAGIC MATRIX\n" \
"  Always write down the paragraph you came from and the spell you wish to cast before going to the Magic Matrix. The first column is the paragraph you came from. All the other columns under the spell names tell you what to do.\n"
    );

    if (room is 225)
    {   spellroom = 107;
    } else
    {   spellroom = room;
    }

    switch (spellchosen)
    {
    case SPELL_TF:
        if
        (   spellroom is 4
         or spellroom is 31
         or spellroom is 203
         or spellroom is 76
         or spellroom is 169
         or spellroom is 94
         or spellroom is 110
         or spellroom is 71
         or spellroom is 109
         or spellroom is 18
         or spellroom is 35
        )
        {   fulleffect();
        } elif
        (   spellroom is 83
         or spellroom is 73
        )
        {   room = 77;
        } elif
        (   spellroom is 174
         or spellroom is 143
        )
        {   room = 226;
        } elif (spellroom is 96)
        {   room = 46;
        } elif (spellroom is 124)
        {   rebound(FALSE);
        } else noeffect();
    acase SPELL_VB:
        if
        (   spellroom is 8
         or spellroom is 28
         or spellroom is 44
         or spellroom is 4
         or spellroom is 22
         or spellroom is 31
         or spellroom is 203
         or spellroom is 83
         or spellroom is 73
         or spellroom is 169
         or spellroom is 94
         or spellroom is 109
         or spellroom is 118
         or spellroom is 147
         or spellroom is 149
         or spellroom is 174
         or spellroom is 143
        )
        {   fulleffect();
        }
    acase SPELL_PA: // "OGA"
        if
        (   spellroom is 4
         or spellroom is 76
         or spellroom is 169
         or spellroom is 94
         or spellroom is 110
         or spellroom is 71
         or spellroom is 35
        )
        {   fulleffect();
        } elif
        (   spellroom is 31
         or spellroom is 18
        )
        {   doubleeffect();
            room = 198;
        } elif (spellroom is 107)
        {   room = 199;
        } else noeffect();
    acase SPELL_CE:
        if
        (   spellroom is 8
         or spellroom is 28
         or spellroom is 44
         or spellroom is 4
         or spellroom is 22
         or spellroom is 31
         or spellroom is 203
         or spellroom is 83
         or spellroom is 73
         or spellroom is 169
         or spellroom is 94
         or spellroom is 109
         or spellroom is 118
         or spellroom is 149
         or spellroom is 174
         or spellroom is 143
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_RS: // "PB"
        if
        (   spellroom is 83
         or spellroom is 73
         or spellroom is 94
         or spellroom is 109
         or spellroom is 118
         or spellroom is 147
         or spellroom is 149
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_EH: // "Wh"
        if
        (   spellroom is 8
         or spellroom is 28
         or spellroom is 44
         or spellroom is 4
         or spellroom is 22
         or spellroom is 31
         or spellroom is 203
         or spellroom is 83
         or spellroom is 73
         or spellroom is 169
         or spellroom is 94
         or spellroom is 109
         or spellroom is 118
         or spellroom is 147
         or spellroom is 149
         or spellroom is 174
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_CF:
        if (spellroom is 203)
        {   room = 228;
        } elif (spellroom is 109)
        {   room = 181;
        } elif (spellroom is 107)
        {   room = 208;
        } else noeffect();
    acase SPELL_DW: // "RAB"
        if
        (   spellroom is 4
         or spellroom is 31
        )
        {   room = 215;
        } elif
        (   spellroom is 76
         or spellroom is 169
         or spellroom is 94
         or spellroom is 110
         or spellroom is 71
         or spellroom is 18
         or spellroom is 35
        )
        {   fulleffect();
        } else noeffect();
    acase SPELL_DS: // "Dis"
        if (spellroom is 203)
        {   room = 228;
        } elif (spellroom is 71)
        {   room = 172;
        } elif (spellroom is 107)
        {   room = 217;
        } elif (spellroom is 124)
        {   room = 200;
        } else noeffect();
    acase SPELL_BP:
        if
        (   spellroom is 4
         or spellroom is 31
         or spellroom is 203
         or spellroom is 76
         or spellroom is 169
         or spellroom is 94
         or spellroom is 110
         or spellroom is 71
         or spellroom is 109
         or spellroom is 18
         or spellroom is 35
        )
        {   fulleffect();
        } elif
        (   spellroom is 83
         or spellroom is 73
        )
        {   room = 77;
        } elif (spellroom is 174)
        {   room = 232;
        } else noeffect();
    acase SPELL_WI: // "FM"
        if (spellroom is 44)
        {   room = 206;
        } elif (spellroom is 118)
        {   room = 207;
        } else noeffect();
    acase SPELL_HF:
        if
        (   spellroom is 83
         or spellroom is 73
         or spellroom is 94
         or spellroom is 109
         or spellroom is 118
         or spellroom is 147
         or spellroom is 149
         or spellroom is 174
        )
        {   fulleffect();
        } elif (spellroom is 107)
        {   room = 225;
        } else noeffect();
    acase SPELL_RE: // "OTIS"
        if (spellroom is 8)
        {   room = 171;
        } elif (spellroom is 28)
        {   room = 197;
        } elif (spellroom is 147)
        {   room = 190;
        } elif (spellroom is 107)
        {   room = 182;
        } elif (spellroom is 149)
        {   room = 209;
        } else noeffect();
    acase SPELL_OE:
        if (spellroom is 8)
        {   room = 180;
        } elif (spellroom is 147)
        {   room = 224;
        } else noeffect();
    acase SPELL_DM:
        if (spellroom is 8)
        {   room = 189;
        } elif (spellroom is 118)
        {   room = 216;
        } elif (spellroom is 147)
        {   room = 173;
        } elif (spellroom is 149)
        {   room = 218;
        } else noeffect();
    adefault:
        noeffect();
    }

    if (spellroom == 169)
    {   room = 178;
    } elif (spellroom == 35)
    {   room = 130;
}   }
