#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Note: various fates which we consider equivalent to death are not, strictly speaking,
deaths, and therefore we ideally shouldn't go to the Abyss in such cases (eg. SO26). We
should probably distinguish between a "normal" death and a "quasi-death".
  There is an anti-cheat (in the dT&T version, at least) at 3D.

These illustrations might belong to the wrong paragraph:
 22/5B
 44/8E
 54/10D
 55/11A
*/

MODULE const STRPTR ab_desc[AB_ROOMS] = {
{ // 0/The First Step
"`INSTRUCTIONS\n" \
"  The Abyss can only be entered by a character used and killed in play. The dead character regains consciousness [holding the largest sword or dagger he can wield, and with all prime attributes he had immediately before encountering the cause of his death]. A character may enter the Abyss only once.\n" \
"  Ground rules for this solitaire are standard: T&T rules apply, minimum saving roll is 5, magical/holy artifacts are usable only if they fit the options offered.\n" \
"  Use of sorcery here is a rather touchy affair. Ethereal fluctuations in the Abyss make all spells undependable, so when you decide what spell you want to cast, refer to the Magic Matrix to find the result. If a spell is not listed, it does not work.\n" \
"  There are many ways to reach the Abyss, and several methods for the strong or pure of heart to leave. Strangely enough, there is no sure method of travelling to any given portion of the Abyss from any other - thus, both maps and memory can be untrustworthy advisors. You will not emerge unscathed. But success will award you a sweet trophy: your life. Good luck.\n" \
"  Entry to the Abyss is made alone to the Edge of the Last Ocean.\n" \
"COMBAT CHART\n" \
"  Find the category your character fits into. Use the number beside it as the multiplier for the dice roll of the monster(s) you face. Multiply before you add in the combat adds. (This multiplier is used to signify the degree of interest the Dark Powers have in your character. The tougher the character, the harder they will try to keep you...)\n" \
"    Dice roll multiplier    Your combat adds\n" \
"             1              Less than 25\n" \
"             2                        26 to    50\n" \
"             3                        51 to    75\n" \
"             4                        76 to   100\n" \
"           Add 1                 Each 50 over 100\n" \
"~INTRODUCTION\n" \
"  You stand on the edge of a dirt plain littered with the signs of battle. Mounds of decaying corpses lie about, holding the rusted remains of evil weapons. The tip of the sun starts to slip beneath the horizon; the sky is orange and scarlet. Suddenly, a blinding light strikes your face.\n" \
"  The leonine Guardian is before you, revealed in his power, robeless. His magnificent mane is flying about as though tossed by a storm, yet there is no breeze. His eyes, once dark gold, now shine like unto two suns. His voice is distorted but powerful in the sunset, it seems to shimmer visibly in the air as he speaks.\n" \
"  \"According to the First Agreement with the nameless, thou may regain thy life and soul by braving the Abyss. Thy way is dark: may thy fate be better.\n" \
"  \"Start thy journey with the words of the scholar:\n" \
"    \"The gates of hell are open night and day\n" \
"    Smooth the descent, and easy is the way;\n" \
"    But to return, and view the cheerful skies,\n" \
"    In this the task and mighty labour lies. - Dryden.\"\n" \
"With these words, a dank fog closes on you. As the first wisps of mist curl about your feet, the last colours of sunset darken. The chill of the fog weakens you. The Guardian has departed.\n" \
"  Far above you can see the nebulous shape of a full moon; for the first time, you notice that the pebbles underfoot are cobblestones. If you step forward, go to {7}. If you retreat backwards, go to {47}. If you move to one side, go to {16}. If you stay and observe, go to {56}. If you attempt to remove one of the cobblestones underfoot, go to {2}."
},
{ // 1/1A
"Your eternal soul is cast into the River Pyriphlegethon, there to drift to Cocytos. As the eons pass, the fire in the River of Wailing is gradually extinguished in the great falling waters to the bottom of Tartaros. In other words you lose. Don't feel too bad, though. You can't use this character again, but you can try another one. Maybe your next one will succeed!"
},
{ // 2/1B
"Roll one six-sided die. If you roll a 1 or 2, go to {39}. If you roll a 3 or 4, go to {27}.\n" \
"  If you roll a 5 or 6, the cobblestone lifts up easily to reveal a small cache. In this hollow, there is a single black pebble, engraved with fine runes which read \"Wizard of Blackstone, 1013, similas Judasi\". [This small charm has several interesting properties. It is a deadly poison, and will poison any weapon it is rubbed against. Any liquid which the stone is dipped in becomes a fatal poison, and the touch of the stone against an open wound is invariably fatal.] Return to {0}."
},
{ // 3/1C
"Just recovering from the effects of the sting, you are carried down the smoking well and pushed through a one-way door into a large cavern. Go to {13}."
},
{ // 4/1D
"Battered and bleeding, the beast is weak enough for you to bind it with ease. Upon each of the horns, you will recall, there is a crown. While the runes on the heads of the Beast are of the vilest evil, the gold and jewels are mere money. You may take as many crowns as you wish. Each is worth 500 gold pieces. Write down the number you want to take, and go to {9}."
},
{ // 5/1E
"With a mighty blow you shatter the cuff on his ankle. \"Quickly, we must flee,\" he says running towards the right passageway. \"I am Iscariot.\"\n" \
"  Iscariot has a Monster Rating of 30, and is the betrayer. [Whenever you fight anything in the trip,] he will [join the creature to help it] destroy you. Iscariot can also multiply his combat roll by the multiplier that you use when facing monsters. Go to {13}."
},
{ // 6/1F
"You detect a strange reserve in the motions of the man as you make love. He realizes you have divined his true nature and attacks. [You must fight bare-handed -] go to {53}."
},
{ // 7/2A
"If you are male, go to {21}. If you are female, go to {26}."
},
{ // 8/2B
"The interior of the cave is a passageway which slopes downward. As you emerge from a fully enclosed tunnel, you find that your path has narrowed - one side drops off into a pool of bubbling lava 50' below. As you stand there, the earth begins to shake and your ledge begin to crumble.\n" \
"  Make a third level saving roll on Dexterity (30 - DEX). If you make it, go to {30}. If you fail, you fall into the Pits of Eternal Torment, where you will spend the rest of time in perpetual anguish."
},
{ // 9/2C
"The only thing between you and living again is the Sea. You are 240' beneath the surface of the water. To reach the surface, you will have to make 3 first level saving rolls on your current CON (20 - CON). (Magic users have no time to heal themselves at this point.) For each crown you picked up from the Beast of the Sea, add one level to the level of the saving roll (i.e., 6 crowns, L7-SR on CON).\n" \
"  If you miss one saving roll, be it 1st, 2nd or 3rd, go immediately to {44}. If you make all three, or if you can breathe water naturally, go to {51}."
},
{ // 10/2D
"If you have an IQ over 18 and are male, go to {19}. If you have an IQ of 18 and are female, go to {6}. Otherwise, you are charmed into submission in the act of love. The Mark is placed on your forehead, and you are now a servant of the false prophet, with no mind of your own. Close the book."
},
{ // 11/2E
"You find a dark oak door under a clump of lacy seaweed. The water is an ultramarine blue, and so are you from holding your breath. If you enter the doorway (which is set in an underwater cliff of granite) then go to {31}. If you do anything else, go to {50}."
},
{ // 12/2F
"You are awarded the viper's tail of your opponent. If used as a weapon, the viper fangs will cause three dice damage. When you escape the Abyss, the viper tail can be sold to a sorcerer or holy man for up to 500 gp.\n" \
"  The mystic horse beasts lead you to the cave entrance, where you see an inlaid marble floor, and a torchlit pathway leading inward with a slight decline. If you enter, go to {22}.\n" \
"  If you want to fight a duel with another horse beast, return to {55} and try it again."
},
{ // 13/3A
"You are at one end of a huge cavern which is many rods across; two rods from floor of polished crystal to dome of carven bronze and pearl glass. It is lit by flickering torchlight, seventy-seven torches set in golden holders. There is a tall, wrought metal gate set into the opposite wall. It is magical and holds the sea back. It is the exit to your world.\n" \
"  Before you is the Beast of the Sea. It has the form of a huge leopard with ten heads, a horn upon each head. On each of the horns is a crown of gold and jewels. Written upon the heads are cruel black runes in an unknown tongue, and the runes are evil to look upon.\n" \
"  The Beast blocks your path to the door and your freedom. If you wish to try to dodge the ten heads in a mad dash for freedom, go to {54}. If you want to stand and fight the beast, go to {25}."
},
{ // 14/3B
"If you strike out over the plain, go to {45}. If you head for the cave, go to {57}."
},
{ // 15/3C
"Make a first level saving roll on Strength (20 - ST). If you succeed, go to {36}. If you fail, go to {43}."
},
{ // 16/4A
"You move into an area free of the smog, and notice that you are in an open courtyard with carved granite walls. Far above in the west, a red planet is rising into the constellation of Draco, next to Thuban. You can see the source of the dark fog behind you; there is an open well. in the centre of the courtyard, from which pours a dirty cloud of fog and smoke.\n" \
"  Suddenly, a great and terrible flying creature rises from the well. It has two scaled wings, a form like unto a horse girded for battle, a breastplate of black iron, and a human countenance, upon which rests a golden crown. It has a tail like unto that of a scorpion, and its name is Abaddon, Angel of the bottomless pit.\n" \
"  You must fight Abaddon or be dragged down into the well, and hence to even darker places. Although Abaddon is immortal and cannot be killed, if you lower his Monster Rating to 5 or less, you will be able to bind him and throw him back into the pit.\n" \
"  If you surrender to Abaddon, go to {46}. If you fight, go to {28}."
},
{ // 17/4B
"* As you fall, a giant black bird plucks you out of the air. His red eyes cast a baleful glance at you while his powerful wings pump and carry both of you out of the mist.\n" \
"  This beast has a Monster Rating of 40. [It will inflict no damage on you - this MR merely reflects the difficulty you will have killing the creature while you are in its talons. Roll for its CON...reflect a lack of target as the wings, with the rest of the bird's body, rise and fall in flight.]\n" \
"  If you kill it in 1 to 3 combat turns, go to {45}. If you kill it in 4 to 6 combat turns, go to {48}. If you haven't slain it by the end of the 6th combat turn, go to {32}."
},
{ // 18/4C
"You escape the undertow. If you don't have plate armour on, then you can try to swim back up to the surface by going to {49}. Otherwise, you can continue sideways (go to {11}) or swim downwards (go to {23})."
},
{ // 19/4D
"You detect a strange reserve in the girl's motions as you make love. She realizes you have divined her true nature and attacks. [You must fight bare-handed -] go to {53}."
},
{ // 20/4E
"You are swept deep into the Last Ocean by a powerful current. You drown. Proceed to {1}."
},
{ // 21/5A
"You move a few feet through the fog, and discover a stunning blonde woman wearing a torchy slit dress. She has a Charisma of 18, and asks you if you want to see a good time. If you do, go to {10}. If you don't, go to {33}. If you attack, go to {53}. If you retreat backwards, go to {47}."
},
{ // 22/5B
"The path leads smoothly downwards, and after travelling for some time, you come to the entrance of a huge underground cavern. At this point the tunnel behind you disappears; when you look around behind you, the spot where the tunnel was is now a cul-de-sac in the cavern. As soon as your character recovers from the shock of this, proceed to {13}."
},
{ // 23/5C
"You estimate that you have swum downwards over twenty fathoms in the blue water, when you finally reach the seafloor of bare granite. Set in the granite is a trap door. If you go through the trap door, go to {13}. If you search the sea floor, go to {20}."
},
{ // 24/5D
"You have bound the false prophet. Award yourself 1000 experience points for this. The only treasure you find is a silver arrow with a cursed tip; it causes 33 hit points of damage when it breaks the skin of an enemy. It is usable once only.\n" \
"  By now the fog has entirely lifted, and you can see that you are in an open courtyard with two exits. One is a sheer drop of 20' to a frothing body of sea water. If you dive in here, go to {40}. The other exit is a pathway leading out over a rocky plain to a cave in the nearby Iron Hills. If you leave this way, go to {14}. If you investigate the large covered well, which is the only item of interest in the courtyard, go to {37}."
},
{ // 25/5E
"* Roll a six-sided die. This is the number of 15 MR Beast-heads that attacks you. Until you have destroyed all of the heads fighting you, roll another six-sided die each combat turn: this additional number of heads joins the fight. (There will never be more than ten heads fighting you at one time.) (If you have an ally, both of you share hits (but you cannot use him as a shield).)\n" \
"  After you have defeated all the heads engaging you (even if there are still unscathed heads), you may elect to dodge to freedom. In this case, you only have to dodge the remaining heads - go to {54}. If you stand and destroy all the heads, go to {4}."
},
{ // 26/6A
"You move a few feet through the fog, and discover a handsome man in black pants and an open white shirt. He has a well-groomed moustache, machismo, and a Charisma of 18. He inquires into your health, and after several minutes of charming conversation asks if you want to see a good time. If you do, go to {10}. If you don't, go to {41}. If you attack, go to {53}. If you retreat backwards, go to {47}."
},
{ // 27/6B
"You find a gold piece. Return to {0}."
},
{ // 28/6C
"* Abaddon has a MR of 55. Once you reduce this to 5 or less, you have won. Conduct combat. If your CON falls to zero first, then go to {1}. If you win, go to {35}."
},
{ // 29/6D
"The number of saving rolls you missed is the number of heads that have managed to attack you. Each has a Monster Rating of 15. Only these heads will fight you (they are the only ones that can reach you). After you have defeated these heads, go to {9}."
},
{ // 30/6E
"As you leap from the ledge to a more solid point, you feel the ledge fall completely away. You pause and catch your breath - you are not injured - and press on. The path continues downward and you find that it is getting warmer. As the tunnel you are in ends, you find a group of men with shovels, digging more passageways. Each is chained to a large spike.\n" \
"  They see you and cry, \"Free us!\" Their cries attract a demon, who comes running down the passageway to the left.\n" \
"  If you wish to free one of the men, make a L2-SR on Luck (25 - LK). If you make it, go to {42}. If you miss, go to {5}. If you choose to ignore them and run into the righthand passage, away from the demon, go to {13}."
},
{ // 31/6F
"You enter a small room, the foyer to a huge underground cavern. The sea door you have entered is one-way - there is no alternative path for you. Go to {13}."
},
{ // 32/6G
"* Despite the damage you have inflicted, the bird carries you to its nest. There you find three young birds. They each have a Monster Rating of 12. The large bird drops you into the nest and flies away. If you kill the young birds, go to {52}."
},
{ // 33/7A
"She persists. In a silken and seductive voice she insinuates you're the best man she has seen in a long time. If you have an IQ of 10 or greater, then you may refuse and retreat (go to {47}) or attack her (go to {53}). Otherwise, she is so attractive that you can't help yourself, and accept. Go to {10}."
},
{ // 34/7B
"You take ten dice in damage from fire, brimstone fumes, and missile weapons. If this kills you, then go to {1}. Otherwise, go to {55}."
},
{ // 35/7C
"You have succeeded in binding Abaddon. Under his wings he carried a leather pouch containing seven brilliant jewels. The first and largest of the gems will call a plague of black locusts with the stings of scorpions. This will cause 33 points damage against whatever the locusts are directed against. The plague may only be called once, after which the gem is worth 1000 gp. The other six gems are each worth 33 gp.\n" \
"  You have also halted the issue of smoke and fog, and can see clearly that you are in an open courtyard with only two exits. One is a sheer drop to a frothing body of seawater, and the other is a path leading to a cave in the nearby Iron Hills. If you dive into the water, go to {40}. If you walk along the path, go to {14}."
},
{ // 36/7D
"You make it back to the surface, and up the wall. This supreme effort costs you half your ST and 4 CON points.\n" \
"  The fog has cleared away, and you see that you are at one end of an open courtyard. At the other end is the only exit, a path leading over a rocky plain towards a cave in the nearby Iron Hills. If you go out that way, go to {14}. If you dive back in the water, go to {40}."
},
{ // 37/7E
"There is a small gem (worth 33 gp) set in the well cover. The well cover can't be opened by mortal hands. Return to {24}, and choose another option."
},
{ // 38/7F
"The horse beasts don't like cowards. You are dragged off to the bottomless pit, and spend eternity falling through pitch blackness. Close the book."
},
{ // 39/7G
"You make an interesting discovery. You have just been bitten by a small green spider. Its venom causes the little finger on your right hand to promptly fall off. Reduce your DEX permanently by 3 points, and return to {0}."
},
{ // 40/8A
"You fall 20' and plunge into a frothy body of salt water. There is a terrific current here, the intersection of three dangerous undertows, and it swiftly drags you straight under and down towards the bottom. It is so strong that you will lose most of your belongings, if you attempt to fight it.\n" \
"  If you drop all your equipment but small gems and items weighing less than a total of 20 weight units, you can try to swim upwards by going to {15}. If you swim sideways, go to {18}. If you keep your possessions and swim downwards, go to {23}."
},
{ // 41/8B
"He insists that you are the best-looking woman that he has seen for a long time. If you have an IQ over 10, then you may choose to retreat backwards (go to {47}) or attack him (go to {53}). Otherwise, the stranger is so exciting that you can't resist. Go to {10}."
},
{ // 42/8C
"Striking a mighty blow, you shatter the cuff on his ankle. \"I am Firebringer,\" he says as he leads you to the right passageway. [\"We'd better move fast if we want to escape!\"]\n" \
"  [Firebringer has a MR of 30, and can multiply his combat roll by the multiplier that you use when facing monsters. He will fight with you, and aid you to escape, though the Mark burned into his forehead tells you that he cannot leave this place.] Go to {13}."
},
{ // 43/8D
"You cannot make it back to the surface. You have barely enough air left to swim downwards (go to {23}) or to move sideways (go to {18})."
},
{ // 44/8E
"As you rose to the surface, the air in your lungs expanded, and ruptured your lungs. Pain flashes through your chest. Crimson bubbles play about your face and cloud your vision. You have failed - you are dead. You can never be reborn again. This is the end."
},
{ // 45/8F
"As soon as you step out onto the plain, you hear a hunting horn. Sweeping down on you from both sides is a wave of four-legged beasts (vaguely equine), charging towards you. They have already cut off your way back to the courtyard, and are closing rapidly. If you run for the cave entrance, go to {57}. If you stay and fight, go to {34}."
},
{ // 46/9A
"Abaddon takes every one of your possessions, and then poisons you with his scorpion's sting. You will lie paralyzed, with a CON of 1, for five months [real time]. Write the date and particulars on your character's card.\n" \
"  After a painful five months, proceed to paragraph {3}."
},
{ // 47/9B
"As you step backwards you feel yourself falling. Mist surrounds you, and you hear nothing but the sea and the sound of wings. Make a first level saving roll on Luck (20 - LK). If you make it, go to {17}. If you miss, go to {40}."
},
{ // 48/9C
"The beast carries you over the plains below and begins to lose altitude as it nears its mountain home. Above you, on the top of the mountain, you see a nest with young birds in it. Your bird, wounded as it is, never makes it to the nest and you crashland on the side of the mountain.\n" \
"  As you pull yourself free of the dead bird's claws, you notice a path on the mountain. If you would like to go up to a small cave, go to {8}. If you want to go down the hill to the plains, go to {45}."
},
{ // 49/9D
"You almost reach the surface when the undertow catches you again. Make a first level saving roll on Constitution (20 - CON). If you fail, you ran out of air. Go to {1}. If you succeed, you reach the surface. Go to {36}."
},
{ // 50/9E
"You are swept down by a powerful undertow, far into the depths of the Last Ocean, into the black reaches of the Lower Waters where the entrance to the Lake Acherusian swallows you. Go to {1}."
},
{ // 51/10A
"    Life is real, life is earnest,\n" \
"    And the grave is not its goal,\n" \
"    Dust thou art, to dust returnest.\n" \
"    Was not spoken of the soul. - Longfellow\n" \
"You break the surface and swim to shore. You now have whatever treasure you garnered, plus your weapons. Due to your experience, you will be able to sense any undead creatures and demons of an evil nature which come within 50' of you. Walls will hinder this ability. You won't know how many there are, or how tough they are - you'll just know that there is something out there. (However, you do have a directional sense and can tell the difference between zombies, vampires and demons.)\n" \
"  If you die again, you cannot use the Abyss to escape your fate. As the Dark One says, \"Fool me once, shame on you. Fool me twice, *never*!\""
},
{ // 52/10B
"Leaving the nest, you notice a dirk in the bottom of the nest (see the rules for dice and adds). You also discover a trail that leads down the mountainside. As you descend, you see a cave off to the right. If you wish to enter the cave, go to {8}. If you would rather follow the path to the plains below, go to {45}."
},
{ // 53/10C
"* Whether you thought the creature was male or female before, it now changes shape into its true form - a hirsute and ugly form of a dark man, with two horns as a ram, and the long forked tongue of a dragon, speaking of falsehoods and lies.\n" \
"  This is the false prophet of the Beast, with a MR of 69. It cannot be killed by mortal hands, but if you reduce its MR to 10, you will have weakened it enough to bind it for one thousand years. Fight until you have a CON of zero (go to {1}) or you have bound the false prophet (go to {24})."
},
{ // 54/10D
"There are ten heads and you must dodge each one. Dodging calls for a saving roll on DEX at the level you get by adding 1 to your Monster Rating multiplier. (If you have 0-25 combat adds, you must make a 2nd level saving roll on DEX).\n" \
"  Record the number of saving rolls you miss - and remember to take the adventure points for them. If you make all ten saving rolls on DEX, go to {9}. If you missed any at all, go to {29}."
},
{ // 55/11A
"You find yourself surrounded by these mystic horses - to the number of 200, which is one-thousandth of their number to be. They have breastplates of fire, and jasmine, and black wormwood. Their heads are those of lions, and out of their mouths proceedeth fire and brimstone. Their tails are living vipers, with fangs of black venom. One of their number speaks to you.\n" \
"  \"By leaving the marked path, you have shown yourself to be a freeman. We would do combat with you to prove the worth of your warriors. If you win a single duel with one of our number, we will let you pass to the cave entrance, but nowhere else. Let the duel begin.\"\n" \
"  A horse beast with a MR of 33 comes forward to fight you. If you attempt to run away and break through the circle of mystic horse beasts, go to {38}. Otherwise, you can conduct combat with your opponent until you are dead (go to {1}) or you are victorious (go to {12}). [Magic-users get the feeling that no magic can be used here.]"
},
{ // 56/11B
"A stray zephyr parts the fog above to form a window to the heavens. The full moon is rising ominously over Vifa Minor, and a red planet is rising into the constellation of Draco, overhanging Thuban. According to the portents, the time of action is upon you. Return to {0}."
},
{ // 57/11C
"The cave entrance leads inward. The path is inlaid with pearly marble tiles, exquisitely carved and set in the floor. Every dozen feet there is a flickering torch set in the wall. The path seems to incline slightly downwards. If you go this way, go to {22}. If you go out along the plain, go to {45}."
}
};

MODULE SWORD ab_exits[AB_ROOMS][EXITS] =
{ {   7,  47,  16,  56,   2,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1/1A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2/1B
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3/1C
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4/1D
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/1E
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   6/1F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/2A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/2B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/2C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/2D
  {  31,  50,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/2E
  {  22,  55,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/2F
  {  54,  25,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/3A
  {  45,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14/3B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/3C
  {  46,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/4A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/4B
  {  11,  23,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/4C
  {  53,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/4D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/4E
  {  10,  33,  53,  47,  -1,  -1,  -1,  -1 }, //  21/5A
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/5B
  {  13,  20,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/5C
  {  40,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/5D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/5E
  {  10,  41,  53,  47,  -1,  -1,  -1,  -1 }, //  26/6A
  {   0,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27/6B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/6C
  {   9,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/6D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/6E
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/6F
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/6G
  {  47,  53,  10,  -1,  -1,  -1,  -1,  -1 }, //  33/7A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/7B
  {  40,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/7C
  {  40,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/7D
  {  24,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/7E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/7F
  {   0,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/7G
  {  18,  23,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/8A
  {  47,  53,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/8B
  {  13,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/8C
  {  23,  18,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/8D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/8E
  {  57,  34,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/8F
  {   3,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/9A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/9B
  {   8,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/9C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/9D
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/9E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/10A
  {   8,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/10B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/10C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/10D
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/11A
  {   0,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/11B
  {  22,  45,  -1,  -1,  -1,  -1,  -1,  -1 }  //  57/11C
};

MODULE STRPTR ab_pix[AB_ROOMS] =
{ "ab0", //   0
  "",
  "",
  "",
  "",
  "ab5", //   5
  "",
  "",
  "",
  "",
  "", //  10
  "",
  "ab12",
  "ab13",
  "",
  "", //  15
  "ab16",
  "",
  "",
  "",
  "", //  20
  "",
  "ab22",
  "",
  "",
  "", //  25
  "ab26",
  "",
  "",
  "",
  "", //  30
  "",
  "ab32",
  "",
  "",
  "ab35", //  35
  "",
  "",
  "",
  "",
  "", //  40
  "",
  "",
  "",
  "ab44",
  "", //  45
  "",
  "",
  "ab48",
  "",
  "", //  50
  "",
  "",
  "",
  "ab54",
  "ab55", //  55
  "",
  "", //  57
};

IMPORT int                    armour,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              evil_attacktotal,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, prevroom, module,
                              round,
                              scaling,
                              spellchosen,
                              spellpower;
IMPORT       SWORD*           exits;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR*          descs[MODULES];

IMPORT struct AbilityStruct   ability[ABILITIES];
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];
IMPORT struct LanguageStruct  language[LANGUAGES];

IMPORT void (* enterroom) (void);

MODULE void ab_enterroom(void);

EXPORT void ab_preinit(void)
{   descs[MODULE_AB] = ab_desc;
}

EXPORT void ab_init(void)
{   int adds,
        i;

    exits     = &ab_exits[0][0];
    enterroom = ab_enterroom;
    for (i = 0; i < AB_ROOMS; i++)
    {   pix[i] = ab_pix[i];
    }

    adds = calc_personaladds(st, lk, dex);
    if   (adds <=  25) scaling = 1;
    elif (adds <=  50) scaling = 2;
    elif (adds <=  75) scaling = 3;
    elif (adds <= 100) scaling = 4;
    else               scaling = 4 + ((adds - 100) / 50); // %%: ambiguous wording
}

MODULE void ab_enterroom(void)
{   TRANSIENT int i,
                  result;
    PERSIST   int crowns,
                  heads,
                  missed;

    switch (room)
    {
    case 1:
        die();
    acase 2:
        result = dice(1);
        if   (result <= 2) {            room = 39; }
        elif (result <= 4) {            room = 27; }
        else               { give(535); room =  0; }
    acase 4:
        crowns = getnumber("Take how many crowns", 0, 10);
        give_multi(536, crowns);
    acase 5:
        create_monster(295);
        fight();
        room = 13;
    acase 7:
        if (sex == MALE)
        {   room = 21;
        } else
        {   room = 26;
        }
    acase 8:
        savedrooms(3, dex, 30, -1);
    acase 9:
        if (can_breathewater(TRUE) || (saved(1 + crowns, con) && saved(1 + crowns, con) && saved(1 + crowns, con)))
        {   room = 51;
        } else
        {   room = 44;
        }
    acase 10:
        lose_flag_ability(88);
        if (iq >= 18)
        {   if (sex == MALE)
            {   room = 19;
            } else
            {   room = 6;
        }   }
        else
        {   die();
        }
    acase 12:
        give(531);
    acase 15:
        savedrooms(1, st, 36, 43);
    acase 17:
        create_monster(296);
        oneround();
        oneround();
        oneround();
        if (!countfoes())
        {   room = 45;
        } else
        {   oneround();
            oneround();
            oneround();
            if (!countfoes())
            {   room = 48;
            } else
            {   room = 32;
        }   }
    acase 18:
        if (armour != PLA && getyn("Swim upwards"))
        {   room = 49;
        }
    acase 24:
        if (!been[24])
        {   award(1000);
            give(532);
        }
        if (!been[37] && getyn("Investigate well"))
        {   room = 37;
        }
    acase 25: // %%: ambiguous paragraph
        heads = 10;
        do
        {   result = dice(1);
            if (result > heads)
            {   result = heads;
            }
            create_monsters(290, result);
            heads -= result;
            oneround();
        } while (countfoes() || (heads && getyn("Keep fighting (otherwise dodge)")));
        if (heads)
        {   room = 54;
        } else
        {   room = 4;
        }
    acase 27:
        give_gp(1);
    acase 28:
        create_monster(291);
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (!countfoes())
            {   room = 35;
            } elif (npc[0].mr <= 5)
            {   dispose_npcs();
                room = 35;
        }   }
        while (room == 28);
    acase 29:
        create_monsters(290, missed);
        fight();
    acase 30:
        if (getyn("Free man (otherwise run)"))
        {   savedrooms(2, lk, 42, 5);
        } else
        {   room = 13;
        }
    acase 32:
        dispose_npcs();
        create_monsters(292, 3);
        fight();
        room = 52;
    acase 33:
        if (iq < 10)
        {   room = 10;
        }
    acase 34:
        good_takehits(dice(10), TRUE);
        if (con <= 0)
        {   room = 1;
        } else
        {   room = 55;
        }
    acase 35:
        give(533);
        give_multi(534, 6);
    acase 36:
        templose_st(st / 2);
        templose_con(4);
    acase 37:
        give(534);
    acase 38:
        die();
    acase 39:
        gain_flag_ability(71);
    acase 40:
        // %%: if swimming sideways, do you have to drop equipment? We assume not.
        if (getyn("Swim upwards"))
        {   for (i = 0; i < ITEMS; i++)
            {   if (items[i].owned && items[i].weight >= 20) // %%: what do they mean by "...other items weighing less than a total of..."?
                {   dropitems(i, items[i].owned);
            }   }
            room = 15;
        }
    acase 41:
        if (iq < 10)
        {   room = 10;
        }
    acase 44:
        die();
    acase 46:
        drop_all();
        templose_con(con - 1);
        elapse(ONE_MONTH * 5, FALSE);
    acase 47:
        savedrooms(1, lk, 17, 40);
    acase 49:
        savedrooms(1, con, 36, 1);
    acase 51:
        gain_flag_ability(72);
        victory(1000); // %%: how much ap to award?
    acase 52:
        give(DRK);
    acase 53:
        create_monster(293);
        do
        {   oneround();
            if (con <= 0)
            {   room = 1;
            } elif (!countfoes())
            {   room = 24;
            } elif (npc[0].mr <= 10)
            {   dispose_npcs();
                room = 24;
        }   }
        while (room == 53);
    acase 54:
        if (prevroom == 13)
        {   heads = 10;
        }
        missed = 0;
        for (i = 1; i <= heads; i++)
        {   if (!saved(scaling + 1, dex))
            {   missed++;
        }   }
        if (missed == 0)
        {   room = 9;
        } else
        {   room = 29;
        }
    acase 55:
        if (getyn("Run away (otherwise fight"))
        {   room = 38;
        } else
        {   create_monster(294);
            fight();
            if (con <= 0)
            {   room = 1;
            } else
            {   room = 12;
}   }   }   }

EXPORT void ab_magicmatrix(void)
{   if
    (   room != 17 //  4B
     && room != 25 //  5E
     && room != 28 //  6C
     && room != 32 //  6G
     && room != 53 // 10C
    )
    {   aprintf("No spells are allowed in this room!\n");
        // noeffect();
        return;
    }

    switch (spellchosen)
    {
    case SPELL_TF:
        if (room == 25)
        {   halfeffect();
        } else
        {   fulleffect();
        }
    acase SPELL_DE:
        if (room == 28)
        {   fulleffect();
        } elif (room == 53)
        {   dispose_npcs();
            room = 24;
        } else
        {   noeffect();
        }
    acase SPELL_IF:
        if (room == 25 || room == 28)
        {   fulleffect();
        } else
        {   halfeffect();
        }
    acase SPELL_BP:
        if (room == 53)
        {   noeffect();
        } else
        {   fulleffect();
        }
    acase SPELL_ME:
        if (room == 53)
        {   maybeeffect(2);
        } elif (room == 25 || room == 28)
        {   maybeeffect(3);
        } else
        {   noeffect();
        }
    acase SPELL_PA:
        if (room == 25)
        {   fulleffect();
        } else
        {   noeffect();
}   }   }
