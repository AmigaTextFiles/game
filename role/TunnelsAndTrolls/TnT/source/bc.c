#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* Perhaps we should edit the text to explicitly incorporate the extra 10 MR bonus for 5th edition.

Ambiguities/contradictions (%%):
 Where the option to run away exists, do we get only one chance to do this
  before the battle starts, or get a chance once per combat turn? (We are
  assuming the former.)
*/

MODULE const STRPTR bc_desc[BC_ROOMS] = { // room numbers are in the format: ordinal/BCv2/BCv1.
{ // 0
"`INSTRUCTIONS\n" \
"  Buffalo Castle was the first solo adventure written for Tunnels & Trolls, and as far as we know, it was the first solo adventure written for any roleplaying game, and even came out before the \"choose your own adventure\" books.\n" \
"  If you are familiar with T&T, you may go right into the adventure, but only take a first level warrior. (No magic users or higher level characters in this adventure.) Whenever you are told to \"roll for a WM (or wandering monster)\", roll one six-sided die. If you roll a 1-5, nothing happens. If you roll a 6, a wandering monster appears and you must go to the Wandering Monster table. If you kill the wandering monster, you come back to where you left off.[ Any time you wish to stop and rest (to regain Strength) for each turn that you rest, you must roll again for a wandering monster.]\n" \
"  Each of the rooms in Buffalo Castle is numbered.[ If you come back to a room where you have already defeated the monster or completed the task or whatever, just roll for a wandering monster instead of following the room instructions.]\n" \
"  Because of the increased dice and adds given to weapons and armour in the 5th edition of T&T, you may find this dungeon will be too weak to properly challenge your characters - the wandering monsters, and the room monsters, will be relatively weak, as this dungeon was designed under earlier editions of the rulebook.\n" \
"  To return the balance of play and a personal sense of 'fair' to this solitaire, it is suggested that you increase all Monster Ratings given by 10 points. This should make the dungeon a challenge once again without making it an unforgiving deathtrap.\n" \
"~INTRODUCTION\n" \
"  Now, before you enter Buffalo Castle, I have a special exploring kit to sell you. It contains clothing, provisions, a knapsack to carry gold in, and a compass. It only costs you 10 gp (a bargain!) and weighs 5. The only other things you will need are weapons, armour, and poison (if you can afford it). You won't need torches, as the entire dungeon is dimly lit.\n" \
"  Here we go: you are facing a huge, gloomy castle with bats flying around the battlements. There are three large wooden doors in front of you. You may go in the left door ({54}), or the centre door ({99}), or even the right door ({74})."
},
{ // 1/1A/2A
"This is the exit room. You must fight one wandering monster before you can leave. Roll on the Wandering Monster table to see what monster it is. You must kill him to leave the dungeon. The exit monster never carries any treasure, and you cannot run away from him.\n" \
"  Once you have killed the exit monster, you have successfully completed Buffalo Castle. Add 100 experience points to whatever you have already earned, and travel to the nearby village to cure whatever hits you took during the adventure."
},
{ // 2/1B/2B
"You found one gold piece. Now go to the exit ({1})."
},
{ // 3/1C/2D
"Roll one die. If you roll a 6, you find a secret door. Go to {56}. If you do not roll a 6, roll again to see if a Wandering Monster appears while you are wasting time looking for a door. (A roll of 6 means a WM appears.) Then go back to {20}."
},
{ // 4/1D/2E
"You are at a 4-way intersection. You may go to the north ({113}) or to the west ({51}) or to the east ({83}) or to the south ({21})."
},
{ // 5/1E/4C
"You have entered a wandering monster room. This is Room Twenty-One. Roll on the Wandering Monster table to see what monster you have to fight. After you have killed it, you may exit the dungeon ({1}), or you may leave through the north door ({105}) or you may leave through the south door ({47})."
},
{ // 6/1F/3A
"You walk down a short corridor, and enter a small room. This is Room Seven. There is nothing in the room except a small slot in one wall, with a sign over the slot. The sign says \"Insert Sword Here\". You may insert your weapon in the slot ({78}), or you may leave by the north door ({77}), or the west door ({101}), or the south door ({54}), or you may exit the dungeon ({1})."
},
{ // 7/1G/21C
"Roll two dice (doubles add and roll again). Add your Dexterity. If the total is over 20, you have stolen a bracelet worth 500 gold pieces. You may exit the dungeon ({1}), or you may go back the way you came ({109}). If your total is 20 or less, go to {100}."
},
{ // 8/1H/28C
"You have entered Room Twenty. This is a wandering monster room. Roll on the Wandering Monster table to see what kind of monster you must fight. After you kill it, you may leave by the west door ({77}) or by the east door ({105})."
},
{ // 9/1J/4B
"You have found 22 gold pieces. Go to the exit ({1})."
},
{ // 10/1K/5A
"After you leave the room, you find he has picked your pocket. Lose 100 gold pieces (or all you have, if you don't have as many as 100). If you go back to the room, he is gone and the room is empty. Meanwhile, you may leave through the south door ({101}), or the north door ({110})."
},
{ // 11/1L/13B
"You find a gambling stone. It is worth 20 gold pieces. It has a red button on it. [Each time you push the button, roll a die. If you roll 1-4, the stone is doubled in value. If you roll a 5 or 6, the stone disappears. ]If the stone stays with you, you may sell it for its present value when you leave the dungeon. Now go to the exit ({1})."
},
{ // 12/2A/3B
"You find one silver piece. Now go to the exit ({1})."
},
{ // 13/2B/19C
"Roll one die to see what happens. You may only open it once.\n" \
"    1 - There is a jewel inside worth 100 gold pieces.\n" \
"    2 - There are 10 silver pieces inside.\n" \
"    3 - An arrow has popped out of the chest. Make a L1-SR on your Dexterity (20 - DEX). If you miss your saving roll, take 2 hits. At any rate, you find 50 gold pieces inside.\n" \
"    4 - The chest is full of tear gas. Take 1 hit. There is nothing else inside.\n" \
"    5 - Add 3 permanently to your Luck!\n" \
"    6 - Poof! You are teleported to Room Three ({64}).\n" \
"If you did not roll a 6, then return to {79}."
},
{ // 14/2C/5B
"You find a scorpion. Make a first level saving roll on your Luck (20 - LK). If you are successful, you may capture it and sell it for 10 gold pieces. If not, take 3 hits on your Constitution (armour won't help you here) and it gets away. Now go to the exit ({1})."
},
{ // 15/2D/16B
"If you successfully kill him, roll one die and multiply by 100 to see how many gold pieces you find. You may leave through the south door ({101}), or the north door ({110})."
},
{ // 16/2E/17C
"Roll one die. If you roll 1, 2, or 3, double the attribute you picked. If you roll 4, 5, or 6, reduce that attribute to 1. You may only try once. Now leave by the south door ({44})."
},
{ // 17/2F/22D
"The wizard instantly throws a spell which paralyzes everything except your left eyelid. He tells you to blink your eye once if you want to flip ({16}), or twice if you don't want to flip ({63}). He unfreezes you after it is clear than you can't hurt him."
},
{ // 18/2G/3C
"You have entered Room Fifteen. There is a large tree growing in the middle of the room. There appear to be emeralds growing on its branches, and rubies lying on the ground. If you wish you can pick up the rubies ({38}) or you can pick the emeralds growing on the branches ({85}), or you can leave by the north door ({43}), or by the south door ({46})."
},
{ // 19/3A/10A
"You set off the burglar alarm. 4000 policemen swarm into the room and arrest you. You are put into prison for 20 years. [Every year at Christmas you may roll on die to see if your character was paroled. If you roll a 6, you get to use the character again. If you roll anything else, put him away for another year! ](In other words, you are finished. Try again?)"
},
{ // 20/3B/28D
"To climb out, add your Dexterity and Luck, and roll two dice (doubles add and roll again). If the total is over 30, you climbed out (go to {47}). If the total is not over 30, roll one die to see if a Wandering Monster appears, then try again. Keep trying until you have been killed by a wandering monster, or you have successfully climbed out."
},
{ // 21/3C/28E
"You are in a corridor which goes north and south. You may go north ({4}) or you may go south ({49}) or you may go through the door on the east wall ({48})."
},
{ // 22/3D/18B
"You find two gold pieces. Go to the exit ({1})."
},
{ // 23/3E/28B
"You've found a diploma. It is worth nothing at all, but it is very pretty. Go to the exit ({1})."
},
{ // 24/3F/8C
"Roll one die. 1 to 4 means you add, 5 or 6 means you subtract.\n" \
"Roll one die again. This tells you the number (1 to 6) that you add or subtract.\n" \
"Roll one die a third time. This tells you which of your attributes the number is permanently added to or subtracted from.\n" \
"    1 - Strength\n" \
"    2 - Intelligence\n" \
"    3 - Luck\n" \
"    4 - Constitution\n" \
"    5 - Dexterity\n" \
"    6 - Charisma\n" \
"Example: you roll 1, 2, 4. That means you add 2 to your Constitution. Now go back to {47}."
},
{ // 25/3G/10D
"You are in Room One. There is a giant octopus in the room, and it immediately attacks you. It has a Monster Rating of 10 for each of its eight arms. [It starts fighting you with two arms (MR of 20) and each combat round/turn it adds an additional arm with a rating of 10, until all 8 arms are fighting. On any one combat turn you can't get more hits than its total rating at the moment. Each combat turn, combine its arms which are fighting into one total rating. ]If you kill the octopus, take 80 experience points; and roll one die and multiply by ten to see how many gold pieces you find in the room.\n" \
"  If you think he looks too tough to fight, you may try to run away.\n" \
"  You may now exit Buffalo Castle ({1}), or you may leave this room through the west door ({49}), or through the east door ({91})."
},
{ // 26/4A/6A
"You have entered Room Thirteen. There is nothing in the room but a chest. You may open the chest ({98}) or you may leave by the south door ({110}) or by the north door ({107})."
},
{ // 27/4B/6B
"You find a jewel worth 100 gold pieces. Go to the exit ({1})."
},
{ // 28/4C/6C
"Cut your Charisma in half (temporarily - for the rest of this adventure[, and for your next one adventure with this character]) for being a coward and refusing to fight. Now go to {18}."
},
{ // 29/4D/12B
"You find a magic wand[ which will double someone else's strength. (It only works once and then disappears.) It cannot be used on any character belonging to you - only someone else's]. Go to the exit ({1})."
},
{ // 30/4E/12C
"Today is your lucky day - you find three silver pieces. Go to the exit ({1})."
},
{ // 31/4F/11C
"You have come to a bend in the corridor. From here you can go north ({69}) or you can go east ({64})."
},
{ // 32/4G/12D
"You are in a short corridor. Make a first-level saving roll on your Luck (20 - LK). If you are successful, you may continue west ({48}) or east ({57}). If you missed the saving roll, go to {53}."
},
{ // 33/4H/12E
"The corridor curves to the south. You are now standing beside a door. If you wish, you may go through the door on the east wall ({68}), or follow the curve around southeast ({4}), or go back ({59})."
},
{ // 34/4J/8B
"Roll a die to see how many gold pieces you find (1-6). Now go to the exit ({1})."
},
{ // 35/4K/28A
"You found nothing at all. Now go to the exit ({1})."
},
{ // 36/4L/2C
"You found an ordinary dagger. It's worth 30 gold pieces, weighs 10, and gets 2 dice in combat. Now go to the exit ({1})."
},
{ // 37/4M/10C
"You tripped a trip-wire and the walls start closing on you very fast. Try to make a L1-SR on your Intelligence (20 - IQ). If you are successful, you managed to save yourself by sticking your weapon between the walls sideways. [Subtract one from your weapon's adds (if your sword was 1 die plus 3, it is now 1 die plus 2; if it was 2 dice with no adds, it is now 2 dice minus one.) ]If you failed this second saving roll, the walls smash you flat. Sorry about that!\n" \
"  If you saved yourself, you may go east ({69}) or go west ({47})."
},
{ // 38/4N/10B
"There are three rubies, and they are worth 100 gold pieces each. Now return to {18}."
},
{ // 39/4P/18A
"Make a first level saving roll on your Charisma (20 - CHR). If you are successful, you manage to look convincingly mean and nasty; the troll leaves you alone. If you wish you may leave by the north door ({6}) or you may leave by the west door ({73}). Meanwhile, you get 100 experience points for getting past the troll. If you miss the saving roll, however, the troll attacks you immediately (go to {111})."
},
{ // 40/5A/27B
"The corridor ends, but there is a door in the west wall. You may go through the door ({94}) or you may go south ({112})."
},
{ // 41/5B/9A
"You have entered Room Eighteen. This is a wandering monster room. Roll on the Wandering Monster table to see what monster it is. If you successfully kill him, you may leave through the east door ({110}), or you may exit the dungeon ({1}), or you may look for secret doors ({66})."
},
{ // 42/5C/9B
"You find a crystal ball which tells you that if you should ever come into this room again, you should look in box #20. The crystal ball is worth 20 gold pieces. Now go to the exit ({1})."
},
{ // 43/5D/11B
"You walk down a short corridor and enter a small room. Inside you find a large, very strong looking man. He laughs at you and dares you to fight him. He tells you that the chest behind him (you suddenly notice a very expensive looking chest) contains a fabulous treasure, but you must fight him to get it. You may fight him for the treasure ({82}), or you may turn around and go back ({28})."
},
{ // 44/5E/13C
"You are in a wandering monster room. This is Room Nineteen. Roll two dice to see what wandering monster you must fight. After you kill it, you may exit the dungeon ({1}), or you may leave through the west door ({91}), or the north door ({112}), or the east door ({106})."
},
{ // 45/5F/7C
"You are in a corridor that runs north and south. There is a door on the west wall. If you wish, you may go through the door ({79}) or you may go north ({109}) or you may go south ({105})."
},
{ // 46/5G/14B
"You have walked down a short corridor, and are at a \"T\" intersection. You may go west ({110}), or north ({18}), or south ({116})."
},
{ // 47/5H/22C
"You have entered Room Six. There is a large fountain in the middle of the room. You may drink from it ({24}) if you wish. Or you may leave by the north door ({5}) or you may leave by the east door ({87})."
},
{ // 48/6A/19D
"You are in Room Two. You are apparently in a very large, grassy plain. You see a large herd of buffalo thundering right at you. You may fight them ({97}) or you may try to run away ({58})."
},
{ // 49/6C/5E
"You are in a north/south corridor. You may go north ({21}), or you may go south ({69}), or you may go through the door on the east wall ({25})."
},
{ // 50/6D/21Ba
"A green fog comes out of the box and eats all of the gold you are carrying. Now go to the exit ({1})."
},
{ // 51/6E/9D
"The corridor curves to the north. You are now standing beside a door. If you wish you may go through the door on the east wall ({68}), or you may follow the curve around northeast ({59}), or you can go back around the southeast curve ({4})."
},
{ // 52/6F/13G
"You are at a right-angle intersection. You may go south ({114}) or you may go west ({115})."
},
{ // 53/6G/24E
"You fell into a pit of very hot oil. Take 5 hits off your Constitution. If you are wearing any armour, you have to take it off and leave it behind to climb out of the oil. You may now go east ({57}) or west ({48})."
},
{ // 54/6H/4A
"You walk down a short corridor, and enter a small room. Inside is a troll, sitting on a treasure chest. He is looking at you in a bored fashion. You may attack him ({111}), or you may try to talk to him ({62}), or you may try to walk by him ({39}). This is Room Four."
},
{ // 55/6K/17A
"You find a jewel worth 300 gold pieces in the treasure chest. Now you may leave the room by the north door ({6}), or by the west door ({73})."
},
{ // 56/7A/7D
"You are in Room Five (the treasure room!). There are gold pieces strewn all over the floor. You may pick up as many as you want. For each 10 gold pieces you pick up, roll once for a Wandering Monster. If a monster appears, then all the rest of the gold disappears. When you are tired of picking up gold, (remember, you can only carry 100 times your current Strength attribute) or when you have killed the wandering monster, you may leave through the east door ({115}), or you may exit the dungeon ({1})."
},
{ // 57/7B/13E
"You are at a bend in the corridor. You may go north ({83}) or you may go west ({32})."
},
{ // 58/7C/14D
"Make three first-level saving rolls based on your Dexterity (20 - DEX). If you make all three, you are safe but exhausted. Reduce your Strength by 4 temporarily. [(You may rest to get it back, but don't forget to roll for Wandering Monsters while resting.) ]If you only miss once, you got grazed by one buffalo. Take 1 die roll of hits. If you missed twice, you got trampled. Take 3 dice of hits (roll three dice and take that many hits). If you missed all three, you were smashed to dust. If you survived, you may leave through the west door ({21}), or you may leave through the east door ({32})."
},
{ // 59/7D/14E. BCv1 and BCv2 both say "northwest" but are incorrect.
"You are at a 3-way intersection. You may go east ({114}), or south ({113}), or follow the curve of the corridor to the southwest ({33})."
},
{ // 60/7E/20C
"The emeralds are fake - worthless. Return to {18}."
},
{ // 61/7F/20D
"You may go back the way you came ({44}), or you may search for secret doors ({76})."
},
{ // 62/7G/14A
"Add your Charisma and your Luck. Roll two dice (doubles add and roll again) and add that to the total. If the combined total is over 36, he gives you a jewel worth 300 gold pieces and you may leave through the north door ({6}) or the west door ({73}). If the total is not over 36, then he attacks you immediately ({111})."
},
{ // 63/7H/13D
"He sneers at you for being a chicken, and throws a spell which cuts your Charisma in half for the rest of this adventure[, and for your next one]. You may leave by the south door ({44})."
},
{ // 64/8A/15C
"You have entered the smoke filled room. This is Room Three. Roll one die. That is the number of turns it takes you to find the way out.\n" \
"  For each turn that you are in the room, roll one die for Wandering Monsters.[ If a wandering monster appears while you are in the smoke filled room, you must fight at half strength (divide your combat rolls by two) because you cannot see.]\n" \
"  After you have searched for the required number of turns, you may leave by the west door ({31}) or the north door ({91})."
},
{ // 65/8B/14C
"You have stumbled into the falling rock trap. Dozens of rocks fall on you from the ceiling. Roll one die to see how many hits you take (your armour may take hits for you in this case).\n" \
"  After you climb out from under the rocks, you may go back the way you came ({44}), or you may search for secret doors ({76})."
},
{ // 66/8C/21A
"There are no secret doors here. Roll one die to see if a Wandering Monster appears while you are wasting time looking for secret doors. Then return to {41}."
},
{ // 67/8D/18C
"Don't forget, his rating is twice what it was. If you kill him, go to {103}."
},
{ // 68/8E/26D
"You are in a short corridor that runs east and west with a door in the west side. You may go west ({92}) or you may go east ({113})."
},
{ // 69/8F/24D
"You are at a \"T\" intersection. You may go west ({92}), or north ({49}), or south ({31})."
},
{ // 70/8G/26A
"You have entered Room Eleven. You see an evil looking character in leather armour. He says you must either fight him ({108}), or pay him one gold piece ({10})."
},
{ // 71/8H/26B
"You find 100 gold pieces. Now go to the exit ({1})."
},
{ // 72/8J/26C
"Make a first level saving roll on your Luck (20 - LK). If you are successful, you have killed her. Get 500 experience points, pick up the bracelet (worth 500 gold pieces), and either exit the dungeon ({1}), or go back the way you came in ({109}). However, if you miss your saving roll, go to {100}."
},
{ // 73/8K/13A
"You have entered Room Seventeen. There is a Wandering Monster in this room. Roll on the Wandering Monster table to see what kind of monster he is. If you kill him, you may leave by the north door ({101}), or by the east door ({54}), or you may exit the dungeon ({1})."
},
{ // 74/9A/12A
"Make a first level saving roll on your Luck (20 - LK). If you are successful, go to {47}, but if you are unsuccessful, go to {96}."
},
{ // 75/9B/25B
"You find 20 gold pieces. Now go to the exit ({1})."
},
{ // 76/9C/23D
"There are no secret doors. Roll a die to see whether a Wandering Monster appears. Then return to {44}."
},
{ // 77/9D/16A
"You are standing in a corridor which runs north/south. There is a door on the east wall. You may go through the door ({8}), or you may go north ({116}), or you may go south ({6})."
},
{ // 78/9E/25A
"If your weapon was not a dagger or sword of some kind, nothing happens. Go back to {6}. If your weapon was a dagger or sword, roll two dice to see what happens to it.[ Each sword or dagger may be inserted once only.]\n" \
"    2[ - Your sword is now a magic flying sword. It will fight any monster for you just as if you were carrying it, only it will fight by itself. You may fight with a different weapon at the same time. On the first combat turn, it fights the monster far away so he cannot get any hits on you the initial round.]\n" \
"    3[ - Your sword is now a magic sword. Double the number of dice you get to roll.]\n" \
"    4 - Your sword melts. It is gone.\n" \
"    5 - Your sword is the same as before[, but if it touches a vampire or bat, the vampire or bat is instantly destroyed]. [(If you meet any wandering blood bats in this dungeon, you have automatically defeated them if you are carrying this.)]\n" \
"    6[ - Your sword is cursed. Subtract 4 from every future combat roll.]\n" \
"    7[ - You get an additional 5 adds for your sword when fighting.]\n" \
"    8[ - Temporary magic: for the very next combat turn only, add 20 adds to your first combat roll.]\n" \
"    9[ - Your sword is now a magic defensive sword. It will take three hits for you every combat turn.]\n" \
"    10[ - Your sword is now a glowing sword. Your sword shines so brightly, any monster is partly blinded and loses one of his combat dice. Also it lights your path as well as an ordinary torch (not needed in this dungeon, but handy in other people's dungeons). Disadvantage: it makes it very hard to hide or not be noticed, when you have a brightly glowing sword!]\n" \
"    11[ - Your sword is now a singing sword. Every combat turn (after combat) roll one die. If you roll a 6, the sound scares away one monster.]\n" \
"    12[ - Magically poisoned sword. After you get any hits on a monster, it will lose 5 from its Monster Rating on each subsequent combat turn until it is dead.]\n" \
"This is Room Seven. After you have rolled [once ]for each sword or dagger you have (if you wish to) [you must ]return to {6}."
},
{ // 79/10A/23C
"You have entered Room Eight. There is nothing in the room but a chest in the middle of the floor. You may open the chest ({13}) or leave by the west door ({116}), or leave by the east door ({45})."
},
{ // 80/10B/18F
"Make a first level saving roll on your Dexterity (20 - DEX). If you miss, the pendulum hits you and you take 10 hits! If you succeed, you go on through. If you were going east, go to {52}. If you were going west, go to {56}."
},
{ // 81/10C/24B
"You find a bottle of magic aspirin; when you eat one, your Constitution is put back up to the maximum without going out of the dungeon. There are three aspirins in the bottle. They are worth 50 gold pieces each if you sell them. Now go to the exit ({1})."
},
{ // 82/10D/24C
"He has a Monster Rating of 20. If you kill him, go to {95}. Or you may try to run away."
},
{ // 83/10E/8E
"You are at a 3-way intersection. You may go west ({4}), or you may go north ({94}), or you may go south ({57})."
},
{ // 84/10F/15A
"You find a magic vitamin pill[ which doubles your Constitution (temporarily) if you eat it]. [(Effect lasts for approximately a week.) ]Now go to the exit ({1})."
},
{ // 85/10G/15B
"The tree comes to life and attacks you. It has a Monster Rating of 25 (3 dice)[ and is not affected by poison]. You may try to run away or fight it. If you succeed in killing it, go to {60}."
},
{ // 86/10H/16C
"You have entered Room Nine. You see a lady sleeping on a couch with her back to you. There is a dresser near her with a jewelled bracelet on it. There are several life-sized (and very realistic) statues of various heroic characters in several poses in the room. The room is decorated with paintings and fancy drapes. You may wake her up and talk to her ({100}), or you may try to kill her while she sleeps ({72}) (shame on you!), or you can try to steal the bracelet while she sleeps ({7}). You may also go back the way you came ({109}), or you may exit the dungeon ({1})."
},
{ // 87/10J/16D
"You are in a short corridor that runs east and west. Make a first level saving roll on Luck (20 - LK). If you are successful, you may go east ({69}) or go west ({47}). If you miss your saving roll, go to {37}."
},
{ // 88/10K/19B
"You find stocks and bonds. Roll one die to see how many hundred gold pieces they are worth. However, if your Intelligence is less than 9, you don't realize they are worth anything. Make a first level Luck saving roll. If you make the saving roll, you accidentally showed them to someone who could tell you they were worth money. Now go to the exit ({1})."
},
{ // 89/11A/23Ca
"You are caught in the rope trap. A loop of rope has grabbed your foot, and you are now dangling from the ceiling. Take one hit (cannot be stopped by armour). Roll one die to see if a Wandering Monster comes along while you are cutting yourself down. [If one does appear (roll of 6), then your first combat roll is cut in half due to your awkward position. ]After you have cut yourself down, and dispatched any wandering monster, you may go north ({86}) or you may go south ({45})."
},
{ // 90/11B/23B: this is considerably different in BCv2
"You find nothing[, but you may write in this space __________ to indicate what the next person who opens this box will find]! Now go to {1}."
},
{ // 91/11C/21E
"You are at a bend in the corridor. You may go south ({64}), or you may go east ({44}), or you may go through the door on the west side of the corridor ({25})."
},
{ // 92/11D/21F
"The door does not open. You must return to where you came from ({68})."
},
{ // 93/11E/20A
"You find a lot of dust. Roll a die to see if your sneezes attract a Wandering Monster. If not, then go to the exit ({1})."
},
{ // 94/11F/20E
"You are at a four-way intersection. You may go north ({114}), or west ({113}), or south ({83}), or east ({40})."
},
{ // 95/11G/9C
"There is a flash of light, a clap of thunder, and the fighter has returned to life. He is now twice as strong as before. (Double his Monster Rating.) You may fight him again ({67}), or you may give up and leave ({28})."
},
{ // 96/11H/18E
"You have fallen into the pit trap. Take two hits. You may look for secret doors ({3}), or you may try to climb out ({20})."
},
{ // 97/11J/17D
"You fight one buffalo at a time, one combat round each. Each combat turn you fight a fresh buffalo. They each get 2 dice and 7 adds. If you get hits on a buffalo, it goes around you. If it gets hits on you, it grazed you as it went by. If you get 5 hits on one buffalo, you killed it. Take 15 experience points for each buffalo killed. There are five thousand buffalo, but after you have killed three, the others go around you. (In other words, you keep fighting until you have killed at least three). You may keep fighting if you wish (buffalo hides are worth 5 gold pieces each and weigh 10) but you may kill no more than 10 buffalo. After the buffalo are gone, you may leave through the east door ({32}), or the west door ({21})."
},
{ // 98/12A/23A
"Roll one die. (You may open this chest only once).\n" \
"    1 - You find a magic wand[ which will kill anything but it will only work once (it disappears after it kills)].\n" \
"    2 - You find a potion and an antidote (2 drinks of each). If you drink the potion, your Strength is tripled until you drink the antidote, but you get one hit on your Constitution each combat turn until you drink the antidote. Each drink is worth 50 gold pieces if you decide to sell it instead.\n" \
"    3 - There is nothing in the chest, and it slams shut on your fingers! Take one hit.\n" \
"    4 - There is a ruby in the chest worth 1000 gold pieces. But it is cursed: every monster you meet whle carrying it will go berserk and fight at double strength.\n" \
"    5 - There is an emerald necklace worth 200 gold pieces if you sell it, but each time you meet a new monster while you wear it, roll 2 dice. If you roll 12, he is charmed by the necklace and give you all his treasure and lets you pass freely. (However, he will not fight for you.)\n" \
"    6 - There is a rattlesnake inside. Make a first level saving roll on Luck (20 - LK). If you are successful, nothing happens and you get no treasure. If you miss, you must take 4 hits on your Constitution, and your Strength is halved until you leave Buffalo Castle.\n" \
"Now go back to {26}."
},
{ // 99/12B/8A
"You have gone through the teleport door. Roll two dice to see where you are teleported.\n" \
"    2  - {86}\n" \
"    3  - {48}\n" \
"    4  - {25}\n" \
"    5  - {47}\n" \
"    6  - {79}\n" \
"    7  - {56}\n" \
"    8  - {64}\n" \
"    9  - {6}\n" \
"    10 - {70}\n" \
"    11 - {112}\n" \
"    12 - {54}"
},
{ // 100/12C/18D
"You have been turned to stone! Sorry about that."
},
{ // 101/12D/19A
"You have travelled a short corridor, and come to a \"T\" intersection. You may go north ({70}), or south ({73}), or east ({6})."
},
{ // 102/12E/20B
"You find a crystal ball which tells you that if you should ever be in this room again, you should look in box #17. The crystal ball is worth 25 gold pieces. Now you may exit ({1})."
},
{ // 103/12F/21B
"There is a flash of light, a clap of thunder, and he has returned to life. His rating is now twice what it was last time. You may fight him again, or you may leave. If you leave, go to {28}. If you fight him, and kill him again, go to {95}."
},
{ // 104/12G/11A
"You find three gold pieces. Now go to the exit ({1})."
},
{ // 105/12H/22B
"You are in a corridor that runs north and south. There is a door in the west wall. You may go through the door ({8}), or you may go north ({45}), or you may go south ({5})."
},
{ // 106/12J/5D
"You walk down a short coridor, which comes to a sudden end. Make a L1-SR on Luck (20 - LK). If you are successful, go to {61}. If you are unsuccessful, go to {65}."
},
{ // 107/13A/27A
"You have entered Room Fourteen, which looks like a bank vault. You may pick one box and open it; then you must leave Buffalo Castle. (No fair picking the same box in future trips with other characters!)\n" \
"1 - {2}      6 - {22}     11 - {81}    16 - {23}     21 - {71}\n" \
"2 - {12}     7 - {35}     12 - {34}    17 - {42}     22 - {30}\n" \
"3 - {19}     8 - {104}    13 - {75}    18 - {36}     23 - {11}\n" \
"4 - {84}     9 - {27}     14 - {29}    19 - {9}      24 - {50}\n" \
"5 - {93}    10 - {88}     15 - {14}    20 - {102}    25 - {90}"
},
{ // 108/13B/7B
"He has a Monster Rating of 20. If you get any hits on him, he tries to give up and let you pass for free. You may accept his offer ({10}), or you may continue to fight ({15}). (Or you could just run away.)."
},
{ // 109/13C/5C
"Make a first-level saving roll on your Luck (20 - LK). If you fail, go to {89}. If you make it, you may go north ({86}) or you may go south ({45})."
},
{ // 110/13D/22A
"You walk down a short corridor and come to a four way intersection. Roll a die to see if a Wandering Monster appears. (6 means yes.)\n" \
"  After you have dispatched the WM, you may go south ({70}) or west ({41}) or north ({26}) or east ({46})."
},
{ // 111/13E/7A
"He has a Monster Rating of 40 (5 dice + 20 adds). If you kill him, go to {55}. Or you may try to run away."
},
{ // 112/13F/8D
"You have entered Room Twelve. Inside is an old man sitting behind a desk. Leaning against the wall is a very elaborate magic staff. On the wall hangs a diploma from the 17th Level Wizards' School.\n" \
"  The old man smiles at you. He is nonchalantly flipping a coin over and over. He offers to flip you double or nothing for any of your attributes (permanent change), Strength, Intelligence, Luck, Constitution, Charisma, Dexterity, or all your gold.\n" \
"  You may attack the old man ({17}), or just decline to flip ({63}), or agree to flip ({16}). If you agree to flip, decide first what you are going to risk."
},
{ // 113/13G/20F
"You are at a four way intersection. Roll a die to see if a Wandering Monster appears.\n" \
"  After dispatching any monster, you may go north ({59}), or west ({68}), or south ({4}), or east ({94})."
},
{ // 114/13H/4D
"You are at a three way intersection. Roll a die to see if a Wandering Monster appears.\n" \
"  After dispatching any monster, you may go north ({52}), or west ({59}), or south ({94}). "
},
{ // 115/13J/27D
"There is a pendulum swinging across the corridor. You may try to go through the pendulum between swings ({80}) or go back the way you came. If you came from the east, go to {52}, or if you came from the west, go to {56}."
},
{ // 116/13K/17B
"You are standing in a corridor that runs north and south. There is a door on the east wall. You may go through the door ({79}), or north ({46}), or south ({77})."
}
}, bc_wandertext[11] = {
{ // 0
"2 - GIANT. Monster Rating of 80 (9 dice plus 40 adds).[ Special combat rules: you may try to dodge him. Make a L1-SR on your Dexterity (20 - DEX). Each time you successfully make your saving roll, he misses you and you get to roll your combat dice and get that many hits on him. If you miss your saving roll once, he smashes you flat. Any time you feel that you have reduced his Monster Rating to a number low enough to fight, you may switch to regular combat.]"
},
{ // 1
"3 - BLOOD BATS: Roll one die to see how many bats. If you roll a 1, roll the die again and add one. Each bat has a Monster Rating of 10. (Add them all together for the combat and to calculate how many dice they roll)."
},
{ // 2
"4 - KILLER BEES: Roll one die to see how many swarms of bees. Subtract one from the roll (if you rolled a one, the bees went away without bothering you). Each swarm has a Monster Rating of 10.[ Killer bees are not affected by poison.]"
},
{ // 3
"5 - OGRE: Monster Rating of 20."
},
{ // 4
"6 - GIANT SNAKE: Monster Rating of 16.[ If it gets any hits on you, roll a die to see if it is poisonous. On a roll of 4, 5, or 6 it is poisonous. If you take any hits from a poisonous snake, but still survive, your strength is cut in half for the rest of the time you are in this dungeon. Snakes are not affected by poison.]\n" \
"  After you kill the snake, roll one die to see if its mate comes looking for you. If you roll a 1, you must fight another snake."
},
{ // 5
"7 - MUMMY: Monster Rating of 16."
},
{ // 6
"8 - GIANT JELLYFISH: Monster Rating of 10.[ After you kill it, your weapon is covered with slime. Take one turn to clean it off. (This removes any remaining poison you may have on your blade also.)]\n" \
"  Roll once to see if another wandering monster appears while you are cleaning your weapon. If one does appear, roll a die again to see if the slimy weapon slips out of your grasp. A roll of 1 or 2 means you drop your weapon, and you must fight the monster with your bare hands (one die plus your personal adds) on the second combat turn. Each subsequent combat round, make a L1-SR on your Dexterity (20 - DEX) to see whether you are able to pick up your weapon."
},
{ // 7
"9 - GIANT SPIDER: Monster Rating of 16.[ On the first combat turn, make a L1-SR on Luck. If you fail, you get caught in his web and must fight at half strength (after you total up your combat roll, divide it by two.) You cannot get out of the web until you kill the spider.]"
},
{ // 8
"10 - GIANT RATS: Roll one die to see how many rats. Each has a Monster Rating of 12."
},
{ // 9
"11 - TROLL: Monster Rating of 24."
},
{ // 10
"12 - RABID DOG: Monster Rating of 18.[ If he gets any hits on you, you will die of rabies!]"
}
};

MODULE SWORD bc_exits[BC_ROOMS][EXITS] =
{ {  54,  99,  74,  -1,  -1,  -1,  -1,  -1 }, //   0
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  { 113,  51,  83,  21,  -1,  -1,  -1,  -1 }, //   4
  {   1, 105,  47,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  77, 101,  54,   1,  -1,  -1,  -1,  -1 }, //   6
  {   1, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  77, 105,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  { 101, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  { 101, 110,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  16,  63,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  {  38,  85,  43,  46,  -1,  -1,  -1,  -1 }, //  18
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  47,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {   4,  49,  48,  -1,  -1,  -1,  -1,  -1 }, //  21
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  47,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {   1,  49,  91,  -1,  -1,  -1,  -1,  -1 }, //  25
  { 110, 107,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  69,  64,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  48,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  68,   4,  59,  -1,  -1,  -1,  -1,  -1 }, //  33
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  69,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {   6,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  94, 112,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
  { 110,   1,  66,  -1,  -1,  -1,  -1,  -1 }, //  41
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42
  {  82,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43
  {   1,  91, 112, 106,  -1,  -1,  -1,  -1 }, //  44
  {  79, 109, 105,  -1,  -1,  -1,  -1,  -1 }, //  45
  { 110,  18, 116,  -1,  -1,  -1,  -1,  -1 }, //  46
  {   5,  87,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47
  {  97,  58,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48
  {  21,  69,  25,  -1,  -1,  -1,  -1,  -1 }, //  49
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50
  {  68,  59,   4,  -1,  -1,  -1,  -1,  -1 }, //  51
  { 114, 115,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52
  {  57,  48,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53
  { 111,  62,  39,  -1,  -1,  -1,  -1,  -1 }, //  54
  {   6,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55
  { 115,   1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56
  {  83,  32,  -1,  -1,  -1,  -1,  -1,  -1 }, //  57
  {  21,  32,  -1,  -1,  -1,  -1,  -1,  -1 }, //  58
  { 114, 113,  33,  -1,  -1,  -1,  -1,  -1 }, //  59
  {  18,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  60
  {  44,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, //  61
  {   6,  73,  -1,  -1,  -1,  -1,  -1,  -1 }, //  62
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  63
  {  31,  91,  -1,  -1,  -1,  -1,  -1,  -1 }, //  64
  {  44,  76,  -1,  -1,  -1,  -1,  -1,  -1 }, //  65
  {  41,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  66
  { 103,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  67
  {  92, 113,  -1,  -1,  -1,  -1,  -1,  -1 }, //  68
  {  92,  49,  31,  -1,  -1,  -1,  -1,  -1 }, //  69
  { 108,  10,  -1,  -1,  -1,  -1,  -1,  -1 }, //  70
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  71
  {   1, 109,  -1,  -1,  -1,  -1,  -1,  -1 }, //  72
  { 101,  54,   1,  -1,  -1,  -1,  -1,  -1 }, //  73
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  74
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  75
  {  44,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  76
  {   8, 116,   6,  -1,  -1,  -1,  -1,  -1 }, //  77
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  78
  {  13, 116,  45,  -1,  -1,  -1,  -1,  -1 }, //  79
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  80
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  81
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  82
  {   4,  94,  57,  -1,  -1,  -1,  -1,  -1 }, //  83
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  84
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  85
  { 100,  72,   7, 109,   1,  -1,  -1,  -1 }, //  86
  {  69,  47,  -1,  -1,  -1,  -1,  -1,  -1 }, //  87
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  88
  {  86,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, //  89
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  90
  {  64,  44,  25,  -1,  -1,  -1,  -1,  -1 }, //  91
  {  68,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  92
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  93
  { 114, 113,  83,  40,  -1,  -1,  -1,  -1 }, //  94
  {  67,  28,  -1,  -1,  -1,  -1,  -1,  -1 }, //  95
  {   3,  20,  -1,  -1,  -1,  -1,  -1,  -1 }, //  96
  {  32,  21,  -1,  -1,  -1,  -1,  -1,  -1 }, //  97
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  98
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  99
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 100
  {  70,  73,   6,  -1,  -1,  -1,  -1,  -1 }, // 101
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 102
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 103
  {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 104
  {   8,  45,   5,  -1,  -1,  -1,  -1,  -1 }, // 105
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 106
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 107
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 108
  {  86,  45,  -1,  -1,  -1,  -1,  -1,  -1 }, // 109
  {  70,  41,  26,  46,  -1,  -1,  -1,  -1 }, // 110
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 111
  {  17,  63,  -1,  -1,  -1,  -1,  -1,  -1 }, // 112
  {  59,  68,   4,  94,  -1,  -1,  -1,  -1 }, // 113
  {  52,  59,  94,  -1,  -1,  -1,  -1,  -1 }, // 114
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, // 115
  {  79,  46,  77,  -1,  -1,  -1,  -1,  -1 }  // 116
};

MODULE STRPTR bc_pix[BC_ROOMS] =
{ "bc0", // 0
  "",
  "bc2",
  "",
  "",
  "", //   5
  "bc6",
  "",
  "",
  "",
  "", //  10
  "",
  "",
  "",
  "bc14",
  "", //  15
  "",
  "",
  "bc18",
  "",
  "", //  20
  "",
  "",
  "bc23",
  "",
  "bc25", // 25
  "",
  "",
  "bc28",
  "",
  "", //  30
  "",
  "",
  "",
  "",
  "", //  35
  "bc36",
  "",
  "",
  "",
  "", //  40
  "",
  "bc42",
  "",
  "",
  "", //  45
  "",
  "bc47",
  "",
  "",
  "", //  50
  "",
  "",
  "",
  "bc54",
  "", //  55
  "bc56",
  "",
  "",
  "",
  "", //  60
  "",
  "",
  "bc63",
  "bc64",
  "bc65", // 65
  "",
  "",
  "",
  "",
  "bc70", // 70
  "",
  "bc72",
  "",
  "",
  "", //  75
  "",
  "",
  "bc78",
  "",
  "", //  80
  "",
  "",
  "",
  "bc84",
  "", //  85
  "bc86",
  "",
  "",
  "",
  "", //  90
  "",
  "",
  "bc93",
  "",
  "", //  95
  "bc96",
  "bc97",
  "bc98",
  "",
  "", // 100
  "",
  "bc102",
  "",
  "",
  "", // 105
  "",
  "bc107",
  "",
  "",
  "", // 110
  "",
  "bc112",
  "",
  "",
  "", // 115
  ""  // 116
};

IMPORT int                    armour,
                              been[MOST_ROOMS + 1],
                              level, xp,
                              st, iq, lk, con, dex, chr, spd,
                              max_st, max_con,
                              good_attacktotal,
                              good_shocktotal,
                              gp, sp, cp,
                              height, weight, sex, race, class, size,
                              room, module, prevroom,
                              spellchosen,
                              theround;
IMPORT       STRPTR           pix[MOST_ROOMS];
IMPORT const STRPTR          *descs[MODULES],
                             *wanders[MODULES];
IMPORT       SWORD*           exits;
IMPORT struct ItemStruct      items[ITEMS];
IMPORT struct MonsterStruct   monsters[];
IMPORT struct NPCStruct       npc[MAX_MONSTERS];

MODULE int                    doubled,
                              flipping,
                              whichweapon;

IMPORT void (* enterroom) (void);

MODULE void bc_enterroom(void);
MODULE FLAG bc_wandering(FLAG definite, FLAG exiting);
MODULE void bc_treasure(void);

EXPORT void bc_preinit(void)
{   descs[MODULE_BC]   = bc_desc;
    wanders[MODULE_BC] = bc_wandertext;
}

EXPORT void bc_init(void)
{   int i;

    exits     = &bc_exits[0][0];
    enterroom = bc_enterroom;
    for (i = 0; i < BC_ROOMS; i++)
    {   pix[i] = bc_pix[i];
    }

    flipping  = 0;
    doubled   = 1;
}

MODULE void bc_enterroom(void)
{   int  i,
         killed,
         newfoes, oldfoes,
         result, result1, result2;
    FLAG done;

    switch (room)
    {
    case 0:
        if (gp >= 10 && getyn("Buy exploring kit"))
        {   pay_gp(10);
            give(329);
        }
        // %%: There's an implication that if you didn't have a knapsack, compass, etc. you would be penalized in some way.
    acase 1:
        DISCARD bc_wandering(TRUE, TRUE);
        victory(100);
    acase 2:
        give_gp(1);
    acase 3:
        if (dice(1) == 6)
        {   room = 56;
        } else
        {   DISCARD bc_wandering(FALSE, FALSE);
            room = 20;
        }
    acase 5:
        DISCARD bc_wandering(TRUE, FALSE);
    acase 6:
        if (getyn("Insert weapon"))
        {   listitems(TRUE, TRUE, 100, 100); // ideally, don't show non-weapons
            do
            {   whichweapon = getnumber("Insert which weapon (0 for none)", 0, ITEMS - 1) - 1;
                if (whichweapon != -1)
                {   if (!items[whichweapon].owned)
                    {   aprintf("You don't own that!\n");
                    } elif (!isweapon(whichweapon))
                    {   aprintf("That is not a weapon!\n");
                    } else
                    {   room = 78;
            }   }   }
            while (room == 6 && whichweapon != -1);
        }
    acase 7:
        if (daro() + dex > 20)
        {   give(309);
        } else
        {   room = 100;
        }
    acase 8:
        DISCARD bc_wandering(TRUE, FALSE);
    acase 9:
        give_gp(22);
    acase 10:
        if (gp >= 100)
        {   pay_gp_only(100);
        } else
        {   pay_gp_only(gp);
        }
    acase 11:
        give(307);
    acase 12:
        give_sp(1);
    acase 13:
        result = dice(1);
        switch (result)
        {
        case 1:
            give(308);
        acase 2:
            give_sp(10);
        acase 3:
            if (!saved(1, dex))
            {   good_takehits(2, TRUE); // %%: it doesn't say whether armour helps
            }
            give_gp(50);
        acase 4:
            good_takehits(1, TRUE); // %%: it doesn't say whether armour helps
        acase 5:
            gain_lk(3);
        acase 6:
            room = 64;
        }
        if (room == 13)
        {   room = 79;
        }
    acase 14:
        if (saved(1, lk))
        {   give(310);
        } else
        {   templose_con(3);
        }
    acase 15:
        if (countfoes())
        {   fight(); // we are continuing the fight from BC108
        }
        give_gp(dice(1) * 100);
    acase 16:
        if (flipping == 0)
        {   flipping = getnumber("1) Strength\n2) Intelligence\n3) Luck\n4) Constitution\n5) Dexterity\n6) Charisma\n7) Gold\nWhich", 1, 7);
        }
        if (dice(1) <= 3)
        {   switch (flipping)
            {
            case 1:
                gain_st(max_st);
            acase 2:
                gain_iq(iq);
            acase 3:
                gain_lk(lk);
            acase 4:
                gain_con(max_con);
            acase 5:
                gain_dex(dex);
            acase 6:
                gain_chr(chr);
            acase 7:
                give_gp(gp);
        }   }
        else
        {   switch (flipping)
            {
            case 1:
                permchange_st(1);
            acase 2:
                change_iq(1);
            acase 3:
                change_lk(1);
            acase 4:
                permchange_con(1);
            acase 5:
                change_dex(1);
            acase 6:
                change_chr(1);
            acase 7:
                pay_gp(gp - 1);
        }   }
        flipping = 0;
    acase 19:
        die();
    acase 20:
        for (;;)
        {   result = daro() + dex + lk;
            if (result >= 30)
            {   break;
            }
            DISCARD bc_wandering(FALSE, FALSE);
        }
    acase 22:
        give_gp(2);
    acase 23:
        give(311);
    acase 24:
        // %%: it's ambiguous whether we can drink multiple times. We assume not.
        if (dice(1) <= 4)
        {   result1 = dice(1);
        } else
        {   result1 = -dice(1);
        }
        result2 = dice(1);
        switch (result2)
        {
        case 1:
            if (result1 >= 1)
            {   gain_st(result1);
            } else
            {   permlose_st(-result1);
            }
        acase 2:
            if (result1 >= 1)
            {   gain_iq(result1);
            } else
            {   lose_iq(-result1);
            }
        acase 3:
            if (result1 >= 1)
            {   gain_lk(result1);
            } else
            {   lose_lk(-result1);
            }
        acase 4:
            if (result1 >= 1)
            {   gain_con(result1);
            } else
            {   permlose_con(-result1);
            }
        acase 5:
            if (result1 >= 1)
            {   gain_dex(result1);
            } else
            {   lose_dex(-result1);
            }
        acase 6:
            if (result1 >= 1)
            {   gain_chr(result1);
            } else
            {   lose_chr(-result1);
        }   }
    acase 25:
        if (getyn("Run away (otherwise fight)"))
        {   if (saved(1, lk))
            {   room = 1;
            } else
            {   good_takehits(2, TRUE); // %%: it doesn't say whether armour helps
        }   }
        if (room == 25)
        {   create_monster(132);
            fight();
            give_gp(dice(1) * 10);
        }
    acase 26:
        if (!been[98] && getyn("Open chest"))
        {   room = 98;
        }
    acase 27:
        give(308);
    acase 28:
        owe_chr(chr / 2);
    acase 29:
        give(312);
    acase 30:
        give_sp(3);
    acase 32:
        if (!saved(1, lk))
        {   room = 53;
        }
    acase 34:
        give_gp(dice(1));
    acase 36:
        give(313);
    acase 37:
        if (!saved(1, iq))
        {   die();
        }
    acase 38:
        give_multi(537, 3);
    acase 39:
        if (saved(1, chr))
        {   award(100);
        } else
        {   room = 111;
        }
    acase 41:
        DISCARD bc_wandering(TRUE, FALSE);
    acase 42:
        give(315);
    acase 44:
        DISCARD bc_wandering(TRUE, FALSE);
    acase 47:
        if (!been[24] && getyn("Drink"))
        {   room = 24;
        }
    acase 50:
        pay_gp(gp);
        // %%: what about gold items, eg. gold rings, nuggets, etc.?
    acase 51:
        templose_con(5); // %%: does armour help? We assume not.
        if (armour != -1)
        {   items[armour].owned--;
            armour = -1;
        }
        // %%: what about carried armour?
    acase 55:
        give(316);
    acase 56:
        done = FALSE;
        while (!done && getyn("Get 10 gp (otherwise leave)"))
        {   give_gp(10);
            if (bc_wandering(FALSE, FALSE))
            {   done = TRUE;
        }   }
    acase 58:
        result = 0;
        if (saved(1, dex)) result++;
        if (saved(1, dex)) result++;
        if (saved(1, dex)) result++;
        switch (result)
        {
        case 0:
            die();
        acase 1:
            good_takehits(dice(3), TRUE);
        acase 2:
            good_takehits(dice(1), TRUE);
        acase 3:
            templose_st(4);
        }
    acase 60:
        give(317);
    acase 62:
        if (daro() + chr + lk > 36)
        {   give(316);
        } else
        {   room = 111;
        }
    acase 63:
        owe_chr(chr / 2);
    acase 64:
        result = dice(1);
        for (i = 1; i <= result; i++)
        {   elapse(10, TRUE);
            DISCARD bc_wandering(FALSE, FALSE);
        }
    acase 65:
        good_takehits(dice(1), TRUE);
    acase 66:
        DISCARD bc_wandering(FALSE, FALSE);
    acase 67:
        doubled *= 2;
        create_monster(136);
        npc[0].mr *= doubled;
        fight();
        room = 103;
    acase 71:
        give_gp(100);
    acase 72:
        if (saved(1, lk))
        {   award(500);
            give(309);
        } else
        {   room = 100;
        }
    acase 73:
        DISCARD bc_wandering(TRUE, FALSE);
    acase 74:
        if (saved(1, lk))
        {   room = 47;
        } else
        {   room = 96;
        }
    acase 75:
        give_gp(20);
    acase 76:
        DISCARD bc_wandering(FALSE, FALSE);
    acase 78:
        if (items[whichweapon].type == WEAPON_SWORD || items[whichweapon].type == WEAPON_DAGGER)
        {   if (dice(2) == 4)
            {   dropitem(whichweapon);
            }
            while (getyn("Insert another sword/dagger"))
            {   listitems(TRUE, TRUE, 100, 100); // ideally, don't show non-weapons
                whichweapon = getnumber("Insert which weapon (0 for none)", 0, ITEMS - 1) - 1;
                if (whichweapon != -1)
                {   if (!items[whichweapon].owned)
                    {   aprintf("You don't own that!\n");
                    } elif (items[whichweapon].type != WEAPON_SWORD && items[whichweapon].type != WEAPON_DAGGER)
                    {   aprintf("That is not a sword/dagger!\n");
                    } else
                    {   if (dice(2) == 4)
                        {   dropitem(whichweapon);
        }   }   }   }   }
    acase 80:
        if (!saved(1, dex))
        {   good_takehits(10, TRUE); // %%: it doesn't say whether armour helps
        }
        if (prevroom == 56)
        {   room = 52;
        } else
        {   // assert(prevroom == 52);
            room = 56;
        }
    acase 81:
        give_multi(318, 3);
    acase 82:
        if (getyn("Run away (otherwise fight)"))
        {   if (saved(1, lk))
            {   room = 1;
            } else
            {   good_takehits(2, TRUE); // %%: it doesn't say whether armour helps
        }   }
        if (room == 82)
        {   create_monster(136);
            fight();
            room = 95;
        }
    acase 84:
        give(319);
    acase 85:
        if (getyn("Run away (otherwise fight)"))
        {   if (saved(1, lk))
            {   room = 1;
            } else
            {   good_takehits(2, TRUE); // %%: it doesn't say whether armour helps
        }   }
        if (room == 85)
        {   create_monster(133);
            fight();
            room = 60;
        }
    acase 87:
        if (!madeit(1, lk))
        {   room = 37;
        }
    acase 88:
        result = dice(1);
        if (iq >= 9 || saved(1, lk))
        {   give_multi(320, result); // %%: strictly speaking, it should probably be done as one item with variable value, not variable items with fixed value.
        }
    acase 89:
        templose_con(1);
        bc_wandering(FALSE, FALSE);
    acase 93:
        bc_wandering(FALSE, FALSE);
    acase 96:
        templose_con(2); // %%: armour might help, but in that case damage would be usually reduced to 0
    acase 97:
        killed = 0;
        theround = 0;
        while (killed < 3 || (killed < 10 && getyn("Keep fighting (otherwise leave)")))
        {   create_monster(134);
            oldfoes = countfoes();
            oneround();
            newfoes = countfoes();
            killed += oldfoes - newfoes;
            give_multi(321, oldfoes - newfoes);
        }
    acase 98:
        result = dice(1);
        switch (result)
        {
        case 1:
            give(322);
        acase 2:
            give_multi(323, 2);
            give_multi(324, 2);
        acase 3:
            good_takehits(1, TRUE); // %%: what about armour?
        acase 4:
            give(325);
        acase 5:
            give(326);
        acase 6:
            if (!saved(1, lk))
            {   templose_con(4);
                owe_st(st / 2);
        }   }
    acase 99:
        result = dice(2);
        switch (result)
        {
        case 2:
            room = 86;
        acase 3:
            room = 48;
        acase 4:
            room = 25;
        acase 5:
            room = 47;
        acase 6:
            room = 79;
        acase 7:
            room = 56;
        acase 8:
            room = 64;
        acase 9:
            room = 6;
        acase 10:
            room = 70;
        acase 11:
            room = 112;
        acase 12:
            room = 54;
        }
    acase 100:
        die();
    acase 102:
        give(327);
    acase 103:
        if (getyn("Leave (otherwise fight)"))
        {   room = 28;
        } else
        {   doubled *= 2;
            create_monster(136);
            npc[0].mr *= doubled;
            fight();
            room = 95;
        }
    acase 104:
        give_gp(3);
    acase 106:
        if (saved(1, lk))
        {   room = 61;
        } else
        {   room = 65;
        }
    acase 107:
        result = getnumber("Which box", 1, 25);
        switch (result)
        {
        case 1:
            room = 2;
        acase 2:
            room = 12;
        acase 3:
            room = 19;
        acase 4:
            room = 84;
        acase 5:
            room = 93;
        acase 6:
            room = 22;
        acase 7:
            room = 35;
        acase 8:
            room = 104;
        acase 9:
            room = 27;
        acase 10:
            room = 88;
        acase 11:
            room = 81;
        acase 12:
            room = 34;
        acase 13:
            room = 75;
        acase 14:
            room = 29;
        acase 15:
            room = 14;
        acase 16:
            room = 23;
        acase 17:
            room = 42;
        acase 18:
            room = 36;
        acase 19:
            room = 9;
        acase 20:
            room = 102;
        acase 21:
            room = 71;
        acase 22:
            room = 30;
        acase 23:
            room = 11;
        acase 24:
            room = 50;
        acase 25:
            room = 90;
        }
    acase 108:
        if (getyn("Run away (otherwise fight)"))
        {   if (saved(1, lk))
            {   room = 1;
            } else
            {   good_takehits(2, TRUE); // %%: it doesn't say whether armour helps
        }   }
        if (room == 108)
        {   // %%: it's ambiguous about whether his armour takes hits for him
            create_monster(135);
            do
            {   oneround();
                if (!countfoes())
                {   room = 15;
                } elif (npc[0].mr < 20)
                {   if (getyn("Accept his surrender (otherwise keep fighting)"))
                    {   dispose_npcs();
                        room = 10;
                    } else
                    {   room = 15;
            }   }   }
            while (room == 108);
        }
    acase 109:
        if (!saved(1, lk))
        {   room = 89;
        }
    acase 110:
        if (dice(1) == 6)
        {   DISCARD bc_wandering(FALSE, FALSE);
        }
    acase 111:
        if (getyn("Run away (otherwise fight)"))
        {   if (saved(1, lk))
            {   room = 1;
            } else
            {   good_takehits(2, TRUE); // %%: it doesn't say whether armour helps
        }   }
        if (room == 111)
        {   create_monster(137);
            fight();
            room = 55;
        }
    acase 112:
        if (getyn("Agree to flip"))
        {   flipping = getnumber("1) Strength\n2) Intelligence\n3) Luck\n4) Constitution\n5) Dexterity\n6) Charisma\n7) Gold\nWhich", 1, 7);
            room = 16;
        }
    acase 113:
        DISCARD bc_wandering(FALSE, FALSE);
    acase 114:
        DISCARD bc_wandering(FALSE, FALSE);
    acase 115:
        if (getyn("Jump through pendulum (otherwise go back)"))
        {   room = 80;
        } elif (prevroom == 56)
        {   room = 52;
        } else
        {   // assert(prevroom == 52);
            room = 56;
}   }   }

MODULE FLAG bc_wandering(FLAG definite, FLAG exiting)
{   int result,
        treasure = 0, // initialized to avoid spurious SAS/C optimizer warnings
        whichmonster;

    // BCv2 has its own treasure table, which isn't quite like the RB one! (eg. it has magic items in it!).

    if (!definite && dice(1) != 6)
    {   return FALSE; // return code is whether a monster was actually generated
    }

    aprintf(
"WANDERING MONSTER TABLE\n" \
"  Whenever you are told to roll to see whether a wandering monster appears, roll one die. A six means you must fight a wandering monster.\n" \
"  If you successfully kill it, get experience points equal to its Monster Rating. After each monster is the treasure number. After you kill a wondering monster, roll one die to see if it has any treasure. Treasure = 1-4 means that if you roll a 1, 2, 3, or 4, that monster was carrying treasure. Now roll on the treasure generation table in the rules (ignoring rolls that call for magical treasures) to see what the treasure is."
"  If this is not an \"exit monster\", instead of fighting, you may try to run away.\n"
    );

// BCv1 has snake treasure on a 1-2 (instead of 1-3).
// BCv1 has an orc instead of a mummy.

    whichmonster = dice(2);
    aprintf("%s\n", bc_wandertext[whichmonster - 2]);

    if (!exiting && getyn("Run away (otherwise fight)"))
    {   if (saved(1, lk))
        {   room = 1;
            return TRUE;
        } else
        {   good_takehits(2, TRUE); // %%: it doesn't say whether armour helps
    }   }

    switch (whichmonster)
    {
    case 2:
        create_monster(121);
        treasure = 5;
    acase 3:
        result = dice(1);
        if (result == 1)
        {   result = dice(1) + 1; // %%: ambiguous about whether to do this in a loop. We are assuming so.
        }
        create_monsters(122, result);
        treasure = 3;
    acase 4:
        result = dice(1) - 1;
        if (result >= 1)
        {   create_monsters(123, result);
        }
        treasure = 0;
    acase 5:
        create_monster(124);
        treasure = 3;
    acase 6:
        create_monster(125);
        treasure = 3;
    acase 7:
        create_monster(126);
        treasure = 3;
    acase 8:
        create_monster(127);
        treasure = 2;
    acase 9:
        create_monster(128);
        treasure = 4;
    acase 10:
        create_monsters(129, dice(1));
        treasure = 3;
    acase 11:
        create_monster(130);
        treasure = 4;
    acase 12:
        create_monster(131);
        treasure = 3;
    }
    fight();

    if (whichmonster == 6 && dice(1) == 1)
    {   create_monster(125); // %%: is this done before or after giving treasure?
        fight();
    }

    if (!exiting && treasure && dice(1) <= treasure)
    {   bc_treasure();
    }

    return TRUE;
}

MODULE void bc_treasure(void)
{   int result;

PERSIST const STRPTR bc_treasuretext[6] = {
{ // 0
"1. You have found a steel cap. It takes one hit of damage per combat round. (If you already have full armour, this doesn't help you any more. It's worth 10 gold pieces if you sell it.)"
},
{ // 1
"2. You have found a small dagger. It gets two dice in combat. (It is a poniard). It is worth 10 gold pieces."
},
{ // 2
"3. You have found an expensive jewelled dagger. It isn't much good in combat (1 die, plus 1 add), but it is worth 500 gold pieces."
},
{ // 3
"4. You have found a jar of smelly ointment. It turns out to be insect repellant. [If you smear it on your body, for the rest of the adventure killer bees, spiders, and any other insects or arachnids will ignore or avoid you. (You can still attack THEM if you want.) One application will last for one adventure, as long as you don't go swimming. There is enough ointment for 3 applications.]"
},
{ // 4
"5. You have found a strength potion. [If you swig it down during (or just before) a combat, you can add 10 to your strength (and thus add to your \"adds\") for up to 5 combat rounds. If you try to drink this potion *during* a combat make a first level saving roll based on your Luck (20 - LK). If you make it, you safely drink the potion. If you miss it, take as many additional hits as you missed your saving roll by. (But at least you now have +10 Strength).]"
},
{ // 5
"6. You have found a healing potion. If you drink it, you can add up to 10 points of Constitution back. (But you can't make your Constitution more than it was when you started.) [You cannot drink this potion during combat.]"
}
};

    result = dice(2);
    if (result == 2)
    {   rb_givejewel(-1, -1, 1);
    } elif (result == 12)
    {   result = dice(1);
        aprintf("%s\n", bc_treasuretext[result - 1]);
        switch (result)
        {
        case  1: give(CAP);
        acase 2: give(PON);
        acase 3: give(593);
        acase 4: give(594);
        acase 5: give(595);
        acase 6: give(596);
    }   }
    else
    {   rb_givecoins();
}   }

/* Here is the conversion table between BCv1 and BCv2.
BCv1 BCv2
 2A= 1A
 2B= 1B
 2C= 4L
 2D= 1C
 2E= 1D
 3A= 1F
 3B= 2A
 3C= 2G
 4A= 6H
 4B= 1J
 4C= 1E
 4D=13H
 5A= 1K
 5B= 2C
 5C=13C
 5D=12J
 5E= 6C
 5F=---
 6A= 4A
 6B= 4B
 6C= 4C
 7A=13E
 7B=13B
 7C= 5F
 7D= 7A
 7E=---
 8A=12B
 8B= 4J
 8C= 3F
 8D=13F
 8E=10E
 9A= 5B
 9B= 5C
 9C=11G
 9D= 6E
 9E=---
10A= 3A
10B= 4N
10C= 4M
10D= 3G
11A=12G
11B= 5D
11C= 4F
11D=---
12A= 9A
12B= 4D
12C= 4E
12D= 4G
12E= 4H
12F=---
12G=---
13A= 8K
13B= 1L
13C= 5E
13D= 7H
13E= 7B
13F=---
13G= 6F
14A= 7G
14B= 5G
14C= 8B
14D= 7C
14E= 7D
15A=10F
15B=10G
15C= 8A
15D=---
16A= 9D
16B= 2D
16C=10H
16D=10J
16E=---
17A= 6K
17B=13K
17C= 2E
17D=11J
17E=---
17F=---
18A= 4P
18B= 3D
18C= 8D
18D=12C
18E=11H
18F=10B
19A=12D
19B=10K
19C= 2B
19D= 6A
19E=---
19F=---
20A=11E
20B=12E
20C= 7E
20D= 7F
20E=11F
20F=13G
21A= 8C
21Ba=6D
21B=12F
21C= 1G
21D=---
21E=11C
21F=11D
22A=13D
22B=12H
22C= 5H
22D= 2F
22E=---
23A=12A
23B=11B
23C=10A
23Ca=11A
23D= 9C
23E=---
24A=---
24B=10C
24C=10D
24D= 8F
24E= 6G
24F=---
24G=---
25A= 9E
25B= 9B
25C=---
26A= 8G
26B= 8H
26C= 8J
26D= 8E
26E=---
27A=13A
27B= 5A
27C=---
27D=13J
28A= 4K
28B= 3E
28C= 1H
28D= 3B
28E= 3C
28F=---

BCv2 doesn't use (skips) these room numbers: 1I, 4I, 4O, 6B, 6I, 6J, 8I.
*/
