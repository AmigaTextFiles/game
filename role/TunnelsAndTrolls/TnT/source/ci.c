#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* %%: Ambiguities/contradictions:
 50/8G: Can the crystal's light be toggled on/off by its user? Does it need to be held in a hand to cast light?
 When it says "return to {foo} and choose another option", does that mean we can never go to this paragraph again, or just not immediately? We assume never.
Illustration notes:
 the one at 36/6B could perhaps instead be for 38/6D.
 the one on page 67 (aka page 8) seems to be an incidental.
 the one at 65/11D is a mirrorred subset of 17/3D.
 the one at 67/12A doesn't seem to match up with its paragraph very well (could be an incidental instead)?
*/

MODULE const STRPTR ci_desc[CI_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  This adventure is for 1st through 4th level characters with no more than 70 combat adds. Magic is allowed, and you have been supplied with provisions suitable for arctic conditions.\n" \
"~INTRODUCTION\n" \
"  There is a world world where two realms vie for total power. One is the Realm of Light, with tall blonde warriors in white and silver. The other is the Realm of Dark, with dark-skinned and powerful warriors in armour of ebon and blackened steel. Each realm steals minor victories from the other, but neither wins totally.\n" \
"  To the west, bordering both, is the Circle of Ice. Neither Light nor Dark hold sway - the frigid circle is a power unto itself. Both Realms fear the Circle of Ice for its power and the potential threat that lies dormant therein.\n" \
"  The Lords of Darkness have summoned you. Before you stands a tall dark man. His eyes burn with a red light. \"We have summoned you,\" he says in a voice that sounds like many voices in one, \"because of your reputation as one who seeks adventure. We desire your aid. Travel into the Circle of Ice and map a route for us. Whatever treasure or peril you find within is yours to deal with - we want only your map.\n" \
"  \"When you have it, come to the High Citadel of Cinity. There, we will reward you and return you to your world.\"\n" \
"  As the image of the black warrior-wizard fades, you find an icy blue doorway hanging before you. Step forward to {1}."
},
{ // 1/1A
"You find yourself in a tunnel with walls of drift ice over a darker base of carved ice blocks. A cruelly biting arctic gale whips around your body. The intense cold is made almost unbearable by the stinging ice particles carried in the frigid wind. For the duration of this adventure, you must calculate the effects of the cold on your character. *Each time you turn to a new paragraph*, you must make a first level Constitution saving roll (20 - CON) before reading that paragraph. If you fail this roll, you must subtract 1 from your CON. The arctic tempest carries ice spicules to the north. If you also go north, go to {9}. If you turn into the wind and go south, go to {15}. If you attempt to dig into the side of the tunnel (you'll need an axe or edged weapon), go to {22}. If you try to dig into the floor of the tunnel, go to {30}."
},
{ // 2/1B
"You are in the dark. By touching the walls you determine you are in a narrow corridor. If you stumble north, go to {16}. If you cautiously walk south, go to {23}."
},
{ // 3/1C
"Spend as much time as you wish trying to retrieve these gems. Each turn, roll one six-sided die. If you get a six, you have retrieved a gem. If you roll a one, take one point off your CON due to the freezing cold. When you give up, return to {52} and choose another option. If you collect ten or more gems, go to {38}. If you retrieve less than 10 gems, go to {58}."
},
{ // 4/1D
"Roll a six-sided die. If you get 1 to 3, go to {54}. If you roll 4 to 6, go to {68}."
},
{ // 5/1E
"You escape a deadfall trap. A falling snowblade missed you by inches, slashing a small hole in your footwear.\n" \
"  You can pick up this weapon if you wish - the Krieviski snowblade requires a ST of 15, a DEX of 16, and must be wielded with two hands. It causes 4 dice damage. Now return to {41} and choose another option."
},
{ // 6/1F
"The spell succeeds in baffling two of the three kukainis, which retreat down a stairway in the northeast corner of the room. The third worm seems to be counter-charmed - it continues to attack. Fight it by returning to {36}."
},
{ // 7/1G
"While you looked for treasure, twice the previous number of kukainis emerged from their hiding places in the belly of the dead adult. Return to {36} and conduct combat as before. Magic works on the same number of worms as before."
},
{ // 8/2A
"With the bone-chilling wind behind you, you quickly progress north to an open area. Visibility is poor, but through the snow and ice drifts you discern the vague outlines of a wide, sunken well. It goes down at least 20', and gradually darkens into an impenetrable blackness at the bottom. Although the drift ice makes the footing treacherous, there are footholds in the well, which seem to be cut deep enough for you to descend. If you do this, go to {39}. If you examine the room you are in, go to {4}. If you would rather return along the southbound corridor, go to {15}."
},
{ // 9/2B
"Two dozen feet south, the corridor is blocked by a tall sculpture in red ice. This is an extremely realistic depiction of an ancient Cinity warrior, armed with a barbed ice sword and wearing a heavy cloak over loose layers of Cinity clothing. If you attack the sculpture and attempt to destroy it, go to {24}. If you squeeze past the sculpture, go to {17}. If you try to talk to the sculpture, go to {32}. If you retreat up the northbound corridor, then go to {37}. If you examine the sculpture carefully, go to {40}."
},
{ // 10/2C
"Make a first level saving roll on Luck (20 - LK). If you make it, go to {18}. If you fail, go to {25}."
},
{ // 11/2D anti-cheat
"You are a person with an intensely curious nature, since you are reading a paragraph which cannot be reached from any other paragraph in this book. Nonetheless in a vision, you suddenly learn that the secret name of the Lady of Clarelichte is Dama meness gaisma Ta. This information may be a suitable reward for your enterprise or it may have no value at all. Go to {1}."
},
{ // 12/2E
"The sarkans kukainis (red worm) is close behind you as you fight your way against icy gale-force winds. You come to a dead end - a wall of loosely-laid ice blocks carved into grotesque designs. If you throw the blocks aside and try to escape through here, go to {34}. If you turn to fight the worm, go to {55}. If you want to try to dodge the worm and run off to the west go to {21}."
},
{ // 13/2F
"If you want to search for treasure in this area, go to {7}. Otherwise, you can explore the chamber and go to {41}."
},
{ // 14/2G
"The ice blocks which make up the floor rapidly melt away. You step on a block which cannot take your weight. The floor drops away, down into a formless black void. You lose consciousness. Proceed to {67}."
},
{ // 15/3A
"The raw, creeping cold is much worse now. The gale-driven ice spicules numb your face and eyelids; you can barely see the wooden door set into the east wall of the corridor. The door and frame are both fashioned of a coarse-grained wood, almost black in colour, which contrasts vividly with the smooth ice. If you go through this door, go to {51}. If you listen at the door, go to {44}. If you continue south against the wind, go to {56}."
},
{ // 16/3B
"You must make a first level saving roll on Luck (20 - LK). If you make it, go to {52}. If you fail, go to {46}."
},
{ // 17/3C
"The corridor continues south to a flight of stairs leading upwards. At the foot of the ice stairs sprawls the frozen corpse of an armour-laden ebon warrior. Scuff marks beside the body lead upstairs. If you go up the stairs, go to {36}. If you examine and plunder the body, go to {31}."
},
{ // 18/3D
"You find a single ruby set in the ice. It is worth 200 gp. Return to {41} and choose another option."
},
{ // 19/3E
"You find a small cache in a corner of the pedestal. Make a first level saving roll on Luck (20 - LK). If you make it, go to {33}. If you fail, then you have accidentally opened a gate to the Inferno. Go to {64}."
},
{ // 20/3F
"The cache contains a clear blue gemstone which radiates cold. It can only be handled with gloves. Anyone can use it; for 3 ST points, it can freeze 1 gallon of fresh water, or put a chill on a keg of beer. It will also extinguish a campfire-sized blaze. Return to {8} and make another choice (you have already examined the room, so that is no longer an option)."
},
{ // 21/3G
"Unfortunately, you quickly lose your way in the blinding snow and collapse. You soon freeze to death. This is the end for you."
},
{ // 22/4A
"The drift ice comes loose, but the darker ice beneath, warped by compression and hardened with intense cold, is impenetrable. Roll two dice. If you get snake-eyes, then your digging tool breaks. Return to {1}."
},
{ // 23/4B
"After stumbling south, you run into a sculptured column of ice. You have wounded yourself on one of its projecting points. The blood which seeps from your wound freezes instantly in the super-chilled air. Take one point from your CON. To continue south, go to {53}. To retreat north, go to {37}. To explore to the west, go to {21}."
},
{ // 24/4C
"This statue is protected by very powerful magic which immediately breaks the weapon you attacked it with. If you attempted magic, it was dispelled. The statue itself is unharmed, although you can now detect a faint red glow from the area where the heart of the statue would be. Return to {9} and choose another option."
},
{ // 25/4D
"Make another first level saving roll on Luck (20 - LK). If you make it, go to {5}. If you fail, go to {63}."
},
{ // 26/4E
"You manage to outdistance the liels kukainis. It loses interest in you and returns southward. Go to {8}."
},
{ // 27/4F
"The cache contains a dark crystal with a complex pattern engraved upon it. The crystal is highly magical, and will enable you to turn back the pages of time three times in any solo adventure.\n" \
"  Using this crystal, you can return from any paragraph to the one that you have just come from. Obviously, you must keep a list of paragraphs read in order for this to be of any practical use. Once the crystal has been used three times, it is [no longer magical, but is ]still worth 1000 gp. Return to {8} and make another choice (you have already examined this room)."
},
{ // 28/4G
"You are in a north-south corridor. There is a gale-force wind blowing from the south. If you go north, go to {8}. If you turn south into the face of the tempest, go to {56}."
},
{ // 29/4H
"The cache contains an ice spider, an amusing and harmless little creature with the amazing ability to subsist indefinitely on a diet of ice particles and snowflakes. Now, return to {8} and make another choice (you have already examined the room)."
},
{ // 30/5A
"You lever the ice blocks up out of the floor, revealing a substrata layer of hard-packed snow. The snow can be rapidly excavated to provide a slight break from the stinging ice spicules. If you dig further, go to {35}. Otherwise, return to {1} and choose another option."
},
{ // 31/5B
"On the body, you find two dirks in matching sheaths. The first dirk has a black handle; the blade is made of a ruby-red crystal worked with many Dark runes. [This dirk is a soul-eater. *Once drawn*, it must kill and eat a soul within two hours (12 full turns) before it is returned to its sheath, or it will take your soul, killing you. ]It gets 2 dice + 13 in combat. This dirk and sheath cannot be given or thrown away - it will return immediately. If a *non-acquaintance* steals it, it will not return to you. If you die, the dirk can be taken from your body.\n" \
"  The second dirk has a silver handle and black ivory-like blade fashioned from a dragon's tooth. This dirk gets normal 2 dice + 1[, but any wound caused by it will be poisoned with dragon's venom].\n" \
"  The armour is fused and cannot be removed from the body. If you climb the stairs, go to {36}. If you head along the northbound corridor, go to {64}. To stand here to observe and listen, go to {45}."
},
{ // 32/5C
"The sculpture does not say a word. Furthermore, you feel pretty foolish standing there talking to a block of ice. Return to {9}."
},
{ // 33/5D
"You find the cas (sic) of Lady Clairelichte. It is an unadorned locket made of fire opal. Within the locket is a silver mirror engraved with the likeness of a full moon. This mirror will produce the illusion of a similar mirror, up to 20' square, to be placed wherever the user wishes. Although the mirror-wall cannot have any effect on real objects, it will act on beams of light and magical emanations the same way a real mirror would.\n" \
"  Ordinarily, the cas can only be used under the light of a full moon. However, if the user manages to discover the secret name of the Lady Clarelichte, then it can be used anywhere. Return to {52}."
},
{ // 34/5E
"The dangerous winds of the plateau sweep down the corridor, reaching gusts of several hundred miles per hour. You are swept backwards by the sheer force of the wind. If your CON is reduced to zero by the 3 dice of damage this causes, go to {69}. Otherwise, go to {64}."
},
{ // 35/6A
"You dig down almost 6' when your footing gives way. You slide through a few feet of loose snow, and drop in terrifying darkness. You land on a hard surface, knocking yourself semi-conscious (take two points of damage off your CON, allowing for armour). There is not even a hint of breeze about you, but the air is much colder (you are still in danger of frostbite). It is impossible to light torches in this cold, so unless you have an alternate method of producing light, you are in the dark - go to {2}. If you have a lantern, Will-o-Wisp spell, or can see in the dark, use it and go to {62}."
},
{ // 36/6B
"* You enter a 30' × 30' room which contains the corpse of a huge kukainis liels (great worm). Venom drips from its massive red mandibles.\n" \
"  As you watch in horror, the skin of the creature bulges out in huge welts, and three miniature worms emerge to attack you. These are the mazs kukainis (children of the worm). They are so rapid in their movements you barely have time to ready yourself for combat before they attack.\n" \
"  Each worm has a MR of 10. To use magic at any time, choose your spell and go to the Magic Matrix. If your CON is reduced to zero, go to {69}. If you kill all three worms, go to {13}. For adventure points take the MR of the worms slain."
},
{ // 37/6C
"* Too bad...movement away from the statue in a northerly direction is the only thing which will trigger the guardian Cinity gem imbedded in its heart. The statue (MR 83) animates and attacks you. Fight until you kill it - go to {50}, or your CON falls to zero - go to {69}. If you want to use magic, choose your spell and go to the Magic Matrix.[ If you are fighting in the dark, you only score half damage on your opponent.]"
},
{ // 38/6D
"* The gems you have collected reach the cusp of their magical 'butterfly catastrophe'. They all hatch into monster red worms with a MR of 5 each. Fight them with magic or weapons. If you use magic, choose your spell and go to the Magic Matrix. If you die, go to {69}. If you live, go to {52}."
},
{ // 39/7A
"As you descend into the well, the violent gusts of wind and ice decrease, and the light gradually lessens. With the dark, a chill enters the air (you are still in grave danger of frostbite).\n" \
"  After you have climbed 20' down, the footholds come to an abrupt end; you slip and fall into the void. Make a first level saving roll on DEX (20 - DEX). If you fail, you sprain your ankle (take two points damage from your CON).\n" \
"  Because of the intense cold, it is impossible to light a torch or keep one lit. If you have a lantern, light spell of some type, or you can see in the dark, then go to {62}. Otherwise, you can't see anything and must go to {2}."
},
{ // 40/7B
"In the statue's left hand you see seven black pellets. Each has a rune inscribed on it that means Shadowfire. These are Cinity sling stones, for use in normal slings. [Each will travel through walls or non-magical armour to damage the first living organic creature they encounter. No combat adds go into the attack, but when the pellets strike living flesh, ]they do triple damage[ (unless the target is immune to fire). These stones are not recoverable, and cannot be further enchanted].\n" \
"  Return to {9} and choose another option."
},
{ // 41/7C
"You are in a room 30' square. There is a door of dark, coarse-grained wood on the western wall; in the northeast corner a flight of ice stairs leads down. A draft blows through the cracks in the wooden door. Downstairs the air is still but very cold.\n" \
"  If you search the room for treasure, go to {10}. If you go through the door, go to {28}. If you go down the stairs, go to {17}."
},
{ // 42/7D
"Your magic is countered by high level sorcery in the heart of the statue. The ethereal backlash injures you - one six-sided die for each level you have attained. If this kills you, go to {69}. Otherwise, return to {37}."
},
{ // 43/7E
"You find a hidden cache containing a cane of dark brown wood with a golden dragon's head on it. This cane is imprinted with a goldfire spell, which will reduce any amount of gold to grey ash. The spell is triggered automatically by any amount of gold greater than 100 gp within 10' of the cane. If you had more than 100 gold pieces on your person, you have received three dice in damage from the burns caused by the gold fire. If this kills you, go to {69}. Otherwise, return to {56} and choose another option."
},
{ // 44/8A
"You hear nothing but the clicking of ice spicules against the wooden door. Return to {15} and choose another option."
},
{ // 45/8B
"You become considerably colder, and lose two points from your CON due to frostbite. Return to {31} and choose another option."
},
{ // 46/8C
"You have stumbled north in the dark for several dozen feet. As you put your hands in front of you to warn yourself of obstacles, you accidentally bump a pivoted artifact on a pedestal. This pivot is a magical nexus point of great importance - by turning it, you have opened a gate to the Inferno. Proceed to {64}."
},
{ // 47/8D
"This spell works on only one of the mazs kukainis attacking you. Conduct combat with the two remaining. [If you don't kill these two within 4 combat turns, the third kukainis will wake and resume combat. ]Return to {36}."
},
{ // 48/8E
"The pivoted arrow is a magical nexus point of great importance in this place. By turning it, you have instigated an interesting sequence of events. Go to {64}."
},
{ // 49/8F
"The cache contains a woven metallic headband made years ago in the Realm of Dark. It produces a rainbow halo and sparkles of sorcerous light about the wearer's head. Although intrinsically worthless, it is great for impressing peasants and shepherds. Return to {8} and make another choice (you have already examined this room)."
},
{ // 50/8G
"At the heart of the statue is a ruby-red crystal which will cast a strong light, start fires, and burst into a violent flame when the command \"Tagad Ral\" is given. This magical combustion will do 1 to 6 dice damage to anyone in close contact with the gem. If the gem can be retrieved, it can be used over and over again. If you ever wish to sell the gem, it is worth 500 gp or whatever the market will bear.\n" \
"  At the moment, you have more pressing matters than this gem to concern you. The death of the guardian statue has triggered the opening of a gate to the Inferno! Proceed to {64}."
},
{ // 51/9A
"* The door is caught by a particularly strong gust of wind, and is flung open with a crash. Inside the room is a massive Kukainis sarkans (great red worm) with two massive mandibles and countless poisonous suckers along its underbelly. It has a MR of 50. If you fight it, go to {59}. If you use magic, choose your spell and go to the Magic Matrix. To run into the corridor and turn south, go to {12}. To run north in the corridor, go to {26}."
},
{ // 52/9B
"The corridor opens into an oval room about 30' long. At the far end of this room is a grotesque statue of dark ice placed high on a pedestal.\n" \
"  The head of the statue is flat-topped, with a misshapen wolverine's snout projecting from the primitive skull. Its stocky body is seated in lotus position, and the four arms of the figure hold a jet bowl in which many bright red gems sparkle. Surrounding the pedestal is a dark pool of an oily liquid, a dozen feet wide.\n" \
"  Before you is another pedestal of dark ice; set on top of it is an arrow of black iron, fixed to move on a pivot. Carved into the side of this pedestal is the legend:\n" \
"    Slikts Uguns Sleptau Bet,\n" \
"    Slikts Ziema Es Turpinau.\n" \
"If you turn the arrow on the pedestal, go to {48}. If you examine the pedestal and walls of the room, go to {19}. If you swim across the pool to the statue, go to {66}. If you have rope or some 10' poles, you can try to retrieve some of the gems in the bowl without crossing the pool; go to {3}. If you turn south in the corridor, go to {9}."
},
{ // 53/9C
"As you continue south, you come to a set of stairs which lead up. If you ascend the ice stairs, go to {36}. Otherwise, go to {64}."
},
{ // 54/9D
"You find a cache behind one of the ice blocks. Roll one six-sided dice to determine its contents, and go to that paragraph:\n" \
"    1  Go to {49}    4  Go to {20}\n" \
"    2  Go to {60}    5  Go to {29}\n" \
"    3  Go to {27}    6  Go to {65}"
},
{ // 55/9E
"* Clutching your body in its huge mandibles, the worm drags you back to the room. If you want to use magic against the worm, choose your spell and then go to the Magic Matrix. Otherwise, go to {59}."
},
{ // 56/10A
"The gusting wind carries ice and dust-fine snow, numbing your mind and frosting your lungs. The corridor ends in a wall of loosely-stacked ice blocks, engraved with a grotesque design. The disarray of the ice blocks makes it impossible to distinguish much detail.\n" \
"  If you toss a few of the blocks aside to see what is on the other side, go to {34}. If you turn back up the corridor (north), go to {64}. If you would like to examine the wall of ice blocks more closely, then go to {43}."
},
{ // 57/10B
"You find a small crystal which gives off a fiery red glow. It is worth 1000 gp. Proceed to {36}."
},
{ // 58/10C
"The gems which you have collected are the eggs of the Liels Kukainis sarkans (the greater red worm), a monstrous insectoid with cruel mandibles and an immense appetite for fresh food.\n" \
"  The[se eggs will hatch in two weeks. Until then, the] eggs are worth 100 gp each as gemstones. [The young worms which will emerge from the eggs are worth 1000 gp each, if a buyer can be found. However, these docile and easily-trained hatchlings will undergo metamorphosis during the seventh week of growth. This metamorphosis is extremely rapid, often occurring within an hour, and is marked by a sudden colour change from immature pale pink to the adult crimson, and the beginning of venom secretion from the mandibles.\n" \
"  The adult red Kukainis is hazardous to all living creatures. It has a Monster Rating of at least 25, and will immediately attempt to kill its master. ]Now that you know what you have, return to {52} and choose another option."
},
{ // 59/10D
"The Kukainis has a Monster Rating of 50. Conduct combat until you have killed it (go to {41}) or your CON has been reduced to zero (go to {69}.)"
},
{ // 60/10E
"The cache contains a locket of milk-white crystal set in silver, with a matching silver chain. The locket is not magical, but is worth 2000 gp. Return to {8} and do something else (you have already examined this room)."
},
{ // 61/10F
"You are crushed by a falling block of ice, and your neck snaps instantly. Go to {69}."
},
{ // 62/11A
"You are in a narrow north-south passage. If you go north, go to {52}. If you go south, go to {9}."
},
{ // 63/11B
"You are caught in a deadfall trap. A heavy bladed instrument falls on you, causing 4 dice damage. If this kills you, go to {69}.\n" \
"  If you are still alive, you see you were hit by a heavy snow-blade. It requires a ST of 15, a DEX of 16, and must be wielded with both hands. You may take it if you wish. If you continue to search, go to {57}. Otherwise, return to {41}."
},
{ // 64/11C
"The spring thaw has begun. The Liels Ugun (great fire elemental) has returned to his ancestral home. A sudden blast of superheated air comes toward you. You stagger in the suffocating wave of heat. The layer of drift ice covering the wall explodes into flying shrapnel as the violent temperature change strains the crystal structure of the ice. Ominous creakings above and below signal a more dangerous change - the heavy ice blocks which form the floor and ceiling are sagging.\n" \
"  If you curl up into a ball and cower under your pack, go to {61}. If you run away at top speed along the corridor, go to {14}."
},
{ // 65/11D
"The cache contains an opening to the Crypt of Ice, a shaft leading many fathoms below to the roots of Ice Mountain, where nameless things lie in wait. As a paralyzing chill sweeps your body, you are drawn deep below to those who wait for you. Close the book, it's all over for this character."
},
{ // 66/11E
"The oily liquid in the pool is at a temperature of -120°F. You are simultaneously frost-burned and dehydrated, and your cells are disrupted by the formation of ice crystals. Proceed to {69}."
},
{ // 67/12A
"The loss of consciousness was only momentary. You wake in a dark room of coal black marble, which reflects little of the flickering lamplight. Seated at tables are the Dark Lords of Cinity, the rulers of the Realm of Dark. One Lord rises and speaks.\n" \
"  \"You have served us far better than we asked. Summoning the Leils Ugun has destroyed the Circle of Ice. Our forces, poised to strike when you returned with your map, burst through and even now are driving on the Citadel of Clarelichte, the center of the Realm of Light.\n" \
"  \"None of this concerns you, however, as you are not of this realm, and our politics must bore you.\" He holds out a seamless ring of black ivory. \"For your services, take this ring.[ It will allow you to hear anything spoken in a tongue you understand, if you stand in connecting patches of shadow while wearing it. Walls and closed doors will stop the power. Nightfall does not cast one large shadow, though an eclipse does.]\"\n" \
"  He moves his hands, and darkness again engulfs you. You appear in your home with your treasure and the ring. You have earned 750 adventure points, in addition to any you garnered during the trip. You are done. This character may never again enter this adventure. (NOTE: The differences in the nature of shadows from universe to universe may affect the powers of the ring. Each GM should be informed of the powers of the ring and adjust it as he or she sees fit. A smart GM might even have a character suffer input overload if caught in a populated place during an eclipse or in an open market at night under torchlight and shadows...)"
},
{ // 68/12B
"You find a vial of lunar pollen, blessed with the secret name of the Lady of Clairelichte. [This vial can be used once only. It acts as a sleep spell over an area 20' in diameter. (If you are within the area affected, you will fall asleep also.) ]Go to {64}."
},
{ // 69/12C
"Your character is dead. The nine-faced judge of eternity has measured its soul and found it wanting. You can't use your character in here again, but if you wish to make a desperate attempt at revival, you can try Abyss. Better luck next time."
}
};

MODULE SWORD ci_exits[CI_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  0
  {   9,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, //  1/1A
  {  16,  23,  -1,  -1,  -1,  -1,  -1,  -1 }, //  2/1B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  3/1C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  4/1D
  {  41,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  5/1E
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  6/1F
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  7/1G
  {  39,  15,  -1,  -1,  -1,  -1,  -1,  -1 }, //  8/2A
  {  24,  17,  32,  37,  -1,  -1,  -1,  -1 }, //  9/2B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 10/2C
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 11/2D
  {  34,  55,  21,  -1,  -1,  -1,  -1,  -1 }, // 12/2E
  {   7,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 13/2F
  {  67,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 14/2G
  {  51,  56,  -1,  -1,  -1,  -1,  -1,  -1 }, // 15/3A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 16/3B
  {  36,  31,  -1,  -1,  -1,  -1,  -1,  -1 }, // 17/3C
  {  41,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 18/3D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 19/3E
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 20/3F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 21/3G
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 22/4A
  {  53,  37,  21,  -1,  -1,  -1,  -1,  -1 }, // 23/4B
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 24/4C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 25/4D
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 26/4E
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 27/4F
  {   8,  56,  -1,  -1,  -1,  -1,  -1,  -1 }, // 28/4G
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 29/4H
  {  35,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 30/5A
  {  36,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, // 31/5B
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 32/5C
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 33/5D
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 34/5E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 35/6A
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 36/6B
  {  50,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 37/6C
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 38/6D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 39/7A
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 40/7B
  {  10,  28,  17,  -1,  -1,  -1,  -1,  -1 }, // 41/7C
  {  37,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 42/7D
  {  56,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 43/7E
  {  15,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 44/8A
  {  31,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 45/8B
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 46/8C
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 47/8D
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 48/8E
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 49/8F
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 50/8G
  {  59,  12,  26,  -1,  -1,  -1,  -1,  -1 }, // 51/9A
  {  48,  19,  66,   9,  -1,  -1,  -1,  -1 }, // 52/9B
  {  36,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, // 53/9C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 54/9D
  {  59,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 55/9E
  {  34,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, // 56/10A
  {  36,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 57/10B
  {  52,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 58/10C
  {  41,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 59/10D
  {   8,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 60/10E
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 61/10F
  {  52,   9,  -1,  -1,  -1,  -1,  -1,  -1 }, // 62/11A
  {  57,  41,  -1,  -1,  -1,  -1,  -1,  -1 }, // 63/11B
  {  61,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, // 64/11C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 65/11D
  {  69,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 66/11E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 67/12A
  {  64,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 68/12B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  // 69/12C
};

MODULE STRPTR ci_pix[CI_ROOMS] =
{ "", //   0
  "",
  "",
  "ci3",
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
  "", //  15
  "",
  "ci17",
  "",
  "",
  "", //  20
  "",
  "ci22",
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
  "ci34",
  "", //  35
  "ci36",
  "",
  "",
  "",
  "", //  40
  "",
  "",
  "ci43",
  "",
  "", //  45
  "",
  "",
  "",
  "",
  "", //  50
  "",
  "ci52",
  "",
  "",
  "", //  55
  "",
  "",
  "",
  "ci59",
  "", //  60
  "",
  "",
  "",
  "ci64",
  "ci65", //  65
  "",
  "ci67",
  "",
  ""  //  69
};

IMPORT       FLAG             inmatrix;
IMPORT       int              age,
                              armour,
                              been[MOST_ROOMS + 1],
                              evil_damagetaken,
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_damagetaken,
                              good_hitstaken,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              prevroom, room, module,
                              round,
                              spellchosen,
                              spelllevel,
                              spellpower,
                              rt, lt, both,
                              thethrow;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct LanguageStruct  language[LANGUAGES];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct SpellStruct     spell[SPELLS];

IMPORT void (* enterroom) (void);

MODULE void ci_enterroom(void);

EXPORT void ci_preinit(void)
{   descs[MODULE_CI]   = ci_desc;
 // wanders[MODULE_CI] = ci_wandertext;
}

EXPORT void ci_init(void)
{   int i;

    exits     = &ci_exits[0][0];
    enterroom = ci_enterroom;
    for (i = 0; i < CI_ROOMS; i++)
    {   pix[i] = ci_pix[i];
}   }

MODULE void ci_enterroom(void)
{   PERSIST   int  digger,
                   gems,
                   kukainis;
    TRANSIENT int  i, j,
                   result,
                   target;
    TRANSIENT FLAG ok;

    switch (room)
    {
    case 1:
        if (getyn("Dig into side"))
        {   listitems(TRUE, FALSE, 100, 100);
            ok = FALSE;
            do
            {   digger = getnumber("With which implement (0 for none)", 0, ITEMS) - 1;
                if (digger == -1)
                {   ok = TRUE;
                } elif (items[digger].owned && isedged(digger))
                {   room = 22;
                    ok = TRUE;
                } else
                {   aprintf("Not suitable!\n");
            }   }
            while (!ok);
        }

        if (room == 1 && !been[30] && getyn("Dig into floor")) // %%: do you need a digging implement for the floor? We assume so.
        {   listitems(TRUE, FALSE, 100, 100);
            ok = FALSE;
            do
            {   digger = getnumber("With which implement (0 for none)", 0, ITEMS) - 1;
                if (digger == -1)
                {   ok = TRUE;
                } elif (items[digger].owned && isedged(digger))
                {   room = 30;
                    ok = TRUE;
                } else
                {   aprintf("Not suitable!\n");
            }   }
            while (!ok);
        }
    acase 3:
        gems = 0;
        do
        {   result = dice(1);
            if (result == 6)
            {   gems++;
            } elif (result == 1)
            {   templose_con(1);
            }
            elapse(10, TRUE);
        } while (getyn("Try again"));
        if (gems >= 10)
        {   room = 38;
        } elif (gems >= 1)
        {   room = 58;
        } else
        {   // assert(gems == 0);
            room = 52;
        }
    acase 4:
        dicerooms(54, 54, 54, 68, 68, 68);
    acase 5:
        give(786);
    acase 6:
        // %%: what if one or more kukainis have already been killed?
        for (i = 0; i < 2; i++)
        {   for (j = 0; j < MAX_MONSTERS; j++)
            {   if (npc[j].con != 0 || npc[j].mr != 0)
                {   kill_npc(j);
                    break;
        }   }   }
    acase 7:
        kukainis *= 2;
        create_monsters(478, kukainis);
    acase 8:
        if (!been[20] && !been[27] && !been[29] && !been[49] && !been[60] && getyn("Examine room"))
        {   room = 4;
        }
    acase 9:
        if     (!been[24] && getyn("Attack sculpture"))
        {   room = 24;
        } elif (!been[40] && getyn("Examine sculpture"))
        {   room = 40;
        }
    acase 10:
        savedrooms(1, lk, 18, 25);
    acase 15:
        if (!been[44] && getyn("Listen at door"))
        {   room = 44;
        }
    acase 16:
        savedrooms(1, lk, 52, 46);
    acase 18:
        give(538);
    acase 19:
        savedrooms(1, lk, 33, 64);
    acase 20:
        give(787);
    acase 21:
        die();
    acase 22:
        if (dice(1) == 1 && dice(1) == 1)
        {   destroy(digger);
        }
    acase 23:
        templose_con(1);
    acase 24:
        if (both != EMPTY && isweapon(both))
        {   destroy(both);
        }
        if (rt   != EMPTY && isweapon(rt))
        {   destroy(rt);
        }
        if (lt   != EMPTY && isweapon(lt))
        {   destroy(lt);
        }
    acase 25:
        savedrooms(1, lk, 5, 63);
    acase 26:
        dispose_npcs();
    acase 27:
        give_multi(788, 3);
    acase 29:
        give(789);
    acase 31:
        if (!been[31])
        {   give(790);
            give(791);
        }
        if (!been[45] && getyn("Listen"))
        {   room = 45;
        }
    acase 33:
        give(792);
    acase 34:
        templose_con(dice(3));
        if (con <= 0)
        {   room = 69;
        }
    acase 35:
        good_takehits(2, TRUE);
        makelight();
        if (lightsource() == LIGHT_NONE)
        {   room = 2;
        } else
        {   room = 62;
        }
    acase 36:
        if (prevroom != 6 && prevroom != 7 && prevroom != 47)
        {   // assert(prevroom == 17 || prevroom == 31 || prevroom == 53 || prevroom == 57);
            kukainis = 3;
            create_monsters(478, kukainis);
        }
        fight();
        if (con <= 0)
        {   room = 69;
        }
    acase 37:
        if (prevroom != 42)
        {   // assert(prevroom == 9 || prevroom == 23);
            create_monster(479);
        }
        fight();
        if (con <= 0)
        {   room = 69;
        }
    acase 38:
        create_monsters(480, gems);
        fight();
        if (con <= 0)
        {   room = 69;
        }
    acase 39:
        if (!saved(1, dex))
        {   templose_con(2);
        }
        makelight();
        if (lightsource() == LIGHT_NONE)
        {   room = 2;
        } else
        {   room = 62;
        }
    acase 40:
        give_multi(793, 7);
    acase 41:
        if (!been[5] && getyn("Search room"))
        {   room = 10;
        }
    acase 42:
        templose_con(dice(level)); // %%: does armour help?
        if (con <= 0)
        {   room = 69;
        }
    acase 43:
        give(794);
        if (gp > 100)
        {   pay_gp_only(gp);
            templose_con(dice(3)); // %%: does armour help?
            if (con <= 0)
            {   room = 69;
        }   }
        else
        {   pay_gp_only(gp);
        }
    acase 45:
        templose_con(2);
    acase 47:
        target = gettarget();
        if (target != -1)
        {   kill_npc(target);
        }
    acase 50:
        give(ITEM_CI_CRYSTAL);
    acase 51:
        create_monster(481);
    acase 52:
        // %%: how much rope is needed? We assume 10'.
        // %%: 10' poles aren't implemented...where would we find one?
        // %%: it's ambiguous about whether a >= 10' pole arm would qualify. We assume so.
        if
        (   (   gotrope(10)
             || items[44].owned
             || items[45].owned
             || items[46].owned
             || items[47].owned
             || items[48].owned
             || items[49].owned
             || items[50].owned
             || items[51].owned
             || items[55].owned
            )
         && getyn("Retrieve gems")
        )
        {   room = 3;
        }
    acase 54:
        dicerooms(49, 60, 27, 20, 29, 65);
    acase 55:
        create_monster(481);
    acase 56:
        if (!been[43] && getyn("Examine wall"))
        {   room = 43;
        }
    acase 57:
        give(797); // %%: we assume this can't be used for illumination
    acase 58:
        give_multi(798, gems);
    acase 59:
        // the monster has already been created at 51 or 55
        fight();
        if (con <= 0)
        {   room = 69;
        }
    acase 60:
        give(799);
    acase 63:
        good_takehits(dice(4), TRUE);
        if (con <= 0)
        {   room = 69;
        }
        give(786);
    acase 65:
        die();
    acase 67:
        give(800);
        victory(750);
    acase 68:
        give(801);
    acase 69:
        die();
}   }

#define is ==
#define or ||

EXPORT void ci_magicmatrix(void)
{   aprintf(
"`MAGIC MATRIX\n" \
"  Cross-reference the paragraph you came from with your spell for the result. If the spell you want to cast is not listed, it will not work.\n" \
"  If a paragraph number is given as your spell's result, go to that paragraph.\n" \
"  If no paragraph number is given, return to the paragraph which sent you here.\n~"
    );

    inmatrix = TRUE;

    switch (spellchosen)
    {
    case SPELL_CC:
    case SPELL_TF:
        if
        (   room is 36 // 6B
         or room is 38 // 6D
         or room is 51 // 9A
         or room is 55 // 9E
        )
        {   fulleffect();
        } elif (room is 37) // 6C
        {   room = 42; // 7D
        }
    acase SPELL_PP:
        if (room is 36) // 6B
        {   room = 6; // 1F
        } elif (room is 37) // 6C
        {   room = 42; // 7D
        } elif
        (   room is 38 // 6D
         or room is 51 // 9A
         or room is 55 // 9E
        )
        {   noeffect();
        }
    acase SPELL_DW:
        if (room is 36) // 6B
        {   room = 47; // 8D
        } elif (room is 37) // 6C
        {   room = 42; // 7D
        } elif (room is 38) // 6D
        {   noeffect();
        } elif (room is 51 or room is 55) // 9A or 9E
        {   // "Spell is partially effective, treat as Delay with normal effects."
            spellchosen = SPELL_DE;
            fulleffect();
        }
    acase SPELL_BP:
        if (room is 36 or room is 38) // 6B or 6D
        {   doubleeffect();
        } elif (room is 37) // 6C
        {   room = 42; // 7D
        } elif (room is 51 or room is 55) // 9A or 9E
        {   fulleffect();
        }
    acase SPELL_IF:
        if
        (   room is 36 // 6B
         or room is 38 // 6D
         or room is 51 // 9A
         or room is 55 // 9E
        )
        {   noeffect();
        } elif (room is 37) // 6C
        {   room = 42; // 7D
        }
    acase SPELL_DE:
        if (room is 36) // 6B
        {   room = 47; // 8D
        } elif (room is 37) // 6C
        {   room = 42; // 7D
        } elif
        (   room is 38 // 6D
         or room is 51 // 9A
         or room is 55 // 9E
        )
        {   fulleffect();
        }
    adefault:
        noeffect();
    }

    inmatrix = FALSE;
}
