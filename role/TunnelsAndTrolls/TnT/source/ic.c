#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

MODULE const STRPTR ic_desc[IC_ROOMS] = {
{ // 0
"`INSTRUCTIONS\n" \
"  Just about every solo adventure has \"choices\" available that are obviously pretty stupid, and of course no one picks those choices unless they are real idiots. It recently occurred to me, however, that some people are pretty dimwitted, and anyone who makes a stupid choice in a solo adventure probably \"dies\" pretty quickly. Certainly we don't want to miss a market niche, so I thought I would write a solo adventure that a stupid person could enjoy. So here it is. Now normally, we jumble all the paragraphs, so that from {1} you choose between {8}, {27} or {56} and from paragraph {8} you choose between {39}, {60} or {92} and so on. But since this adventure is for people who are probably pretty slow readers anyway, I'm just going to put the paragraphs in order. It's easier that way, and besides, I don't want to confuse anyone. Don't read ahead, now. Just read the paragraphs you are directed to.~"
},
{ // 1
"You are a peasant, tending a flock of sheep in a meadow high up in the Blue Mountains. While looking for a comfortable place to sit down and have lunch one bright morning, you discover a cave in the side of the mountain. Over the cave is a large sign: \"Danger! There is a dragon inside this cave! Do not enter or you will die!\" You are carrying nothing but your lunch, a water sack, and a stout wooden club. You have often wondered what it would be like to be a great hero such as a slayer of dragons. If you ignore the cave and go back and tend your flock, go to {2}. If you enter the cave to see what is inside, go to {3}."
},
{ // 2
"No, no, no. This is an adventure for *stupid* people. People who make intelligent choices are not allowed to play this adventure. You get 100 adventure points for having seen the cave, collect 100 silver pieces for telling the tale over and over in the local tavern, and live a long and reasonably happy life. The End."
},
{ // 3
"When you get inside the cave, you see that the way into the deeper reaches of the cave is sealed off with rocks and some kind of mortar. There is a large, rusty, iron door in the centre of this rock pile. There is a lock on the door that is glowing faintly. As you reach for the lock, your hand starts to tingle, and the hairs on the back of your hand stand straight up. The closer your hand gets to the lock, the nastier the tingle. If you wish to grab hold of the lock to take a closer look, go to {4}. If you wish to take your wooden club and pound on the door shouting for someone to come open up, go to {5}."
},
{ // 4
"The lock pops open, and comes off in your hand. You put it in your pocket for safekeeping, while the iron door slowly swings open with a creaking and groaning noise. (If you survive this adventure, you may later sell the lock for 100 gold pieces back in the village.) It is very dark inside the cave and you can't see a thing. If you just walk right in, go to {6}. If you shout into the darkness \"Hey, are there any dragons in there?\" go to {7}."
},
{ // 5
"The door slams open, and standing there in the opening is a huge, smelly, slobbering man-like creature. He is over 8' tall, with green skin, 4\" fangs, dirty hair, and looks like he weighs about 300# of all muscle and bone. In his hand he has an ugly club about as big as you are, with a long, curved spike sticking out of it. He is swinging this club rather casually, as he growls, \"Whadda you want?\" If you tell him are you are here to kill the dragon, go to {8}. If you just push right by him and go inside, go to {9}. If you immediately challenge him to a duel to the death, go to {10}."
},
{ // 6
"In the dark, you trip over something long, white and skinny (perhaps a bone?) and fall flat on your face. You hear a whishing sound over your head, and feel a slight breeze and then hear a loud \"Thump!\" As you climb to your hands and knees, you slip on something slimy and fall forward into a pit. You tumble, roll and slide for quite a ways, and end up at the bottom in a brightly lit cavern. All around you are piles of gold, jewels, bolts of expensive looking fabrics, and little bottles of potions. In one corner of the room is a rope leading up to the ceiling. There is a small sign next to the rope that says \"alarm\". In the centre of the room is a large, forbidding altar encrusted with bloodstains and slimy gore, and covered all over with hideous carved gargoyles and arcane symbols. The top of the altar has a little depression, somewhat bowl-shaped with more bloodstains and some scorch marks. Hanging over the altar is a huge, glowing sword with the letters E.V.I.L. imprinted on the handle. You grab a few likely jewels as you look around (3 gems worth 200 gold pieces each). You pick up one of the little bottles, and notice that it has no writing on it, but there is a skull and crossbones engraved on the lid. If you wish to open this bottle and drink what is inside, go to {11}. (If you don't drink it, you can sell it later for 100 gold pieces). If you wish to walk over and pull the rope marked \"alarm\" go to {12}. If you wish to climb on top of the altar and take down the sword, go to {13}."
},
{ // 7
"A loud, rough, masculine voice shouts back \"No, there are no dragons here, but there is a beautiful princess. Come on in and rescue her.\" If you walk into the dark cave, go to {6}. If you shout back \"No, no, I want to kill a dragon,\" go to {14}."
},
{ // 8
"\"Ha!\" he shouts. \"No one comes inside unless they fight me first. What do you say to that?\" If you pull out your club and try to impress him by twirling in a flashy manner, go to {10}. If you just say \"Oh, bother!\" and just walk past him into the dark entrance, go to {9}."
},
{ // 9
"The ogre howls in rage, and swings his club at you. Fortunately his club is longer than the door is wide, and it hits the side of the door with a loud \"Clang!\" As you walk on inside, the ogre drops his club and reaches for you with huge, warty hands. In his blind rage, he trips over his club and falls on the spike, which happens to get him right in the throat. You get 500 adventure points for killing this nasty beast. Now go to {6}."
},
{ // 10
"The ogre looks at you in surprise, and then starts to laugh. You angrily pull out your cudgel, and try to twirl it to impress him with your dexterity, but you slip and smack yourself in the knee. The ogre laughs even harder, drops his club, and grabs his stomach. As you bend over to rub your aching joint, you poke yourself in the eye with your wooden staff. The ogre howls even louder, sits down, and rolls around on his back. You drop your staff, and cover your watering eye, but now you step on the staff and slip and fall down on your rump. The ogre starts kicking his heels on the ground, and gasping with a sort of \"Erck, argh, ack!\" noise. Suddenly he is quiet, jerks a couple of times, and then lies still. He has had a fatal heart attack. You get 500 adventure points for killing this nasty beast. Now if you want to walk into the dark cave, go to {6}. If you want to shout \"Hey, are there any dragons in there?\", go to {7}."
},
{ // 11
"After you drink the potion, you have a sudden urge to bury all the treasure you see all around. You wander around the cave saying \"Arrr! Shiver me timbers! Yo, ho ho!\" and covering up the gold pieces with the bolts of cloth. After a while you grow dizzy and faint. When you wake up you are outside near where you left your sheep. You discover that on your left shoulder you have a tattoo of a parrot, and on the back of your right hand is a tattoo of a heart with the word \"Mum\" underneath it, and you can't remember where they came from. You get 1000 adventure points and this adventure is over. The End."
},
{ // 12
"There is a puff of smoke and a loud \"pop\" and suddenly appearing before you is a small creature about 1' high with yellow skin and blue hair that sticks out in all directions. \"You rang?\" he asks. \"Who are you?\" you ask. \"My name is Larm,\" he replies. \"I can grant you a wish,\" he says with a smile.\n" \
"  If you want to kick this funny-looking creature, go to {15}. If you want to laugh at the way his hair sticks out, go to {16}. If you want to wish for a roast beef sandwich, go to {17}. If you want to wish that the big bully back in your village would be covered with warts, then go to {18}."
},
{ // 13
"As you grasp the sword, there is a sudden spark of static electricity. It makes you flinch, and you drop the sword. You make a grab for the falling sword, and slip off the altar. As you fall forward, you hear a very loud \"Crack!\" and there is an extremely bright flash of light behind you. You land on a pile of fancy rugs and the sword lands next to you. When you turn around to look at the altar, you see smoke coming off the top of it and you hear a slight hissing of steam. Then you hear a voice behind you saying \"Who has taken my sword?\" You turn around and see a 6' tall, very muscular man with black hair and a black beard. There is a jagged scar over his right eye, and he is wearing chain mail. \"My name is Edgar Victor Ichabod Lodz and that's my sword. Hand it over.\" He holds out his right hand. If you want to turn it around and hand it to him handle first, go to {19}. If you want to throw it to him, go to {20}. If you want to laugh and say \"Nyah nyah nyah nyah nyah nyah! Finders keepers, losers weepers!\", go to {21}."
},
{ // 14
"The voice replies \"Well, I understand that a dragon is supposed to come by this afternoon. Do you want to come inside and wait?\" If you want to go inside the dark cave, go to {6}. If you want to sit down here and wait until the dragon comes, go to {22}."
},
{ // 15
"You kick him and he bounces off the far wall like a rubber ball. He screeches, and runs into a small hole in the wall that you hadn't noticed before. You walk over to examine this little opening. You see that it is barely big enough for your head and it is very dark inside. If you want to stick your head inside the hole, go to {23}. If you want to stick your arm into the dark and feel around for something valuable, go to {24}."
},
{ // 16
"\"Oh, so I'm funny am I? Well, how about this?\" He snaps his fingers and you feel very funny. You look down and discover that your skin is now yellow. You reach for your head, and discover that your hair is now blue. Suddenly a door crashes open on the far side of the cave, and five heavily armed and armoured guards come clanking in. \"Nobody here but us Larms!\" laughs the little fellow. He snaps his fingers again, and there is another puff of smoke. You feel dizzy, and find yourself seated in a tiny room, where you have to keep your neck bent to keep from banging your head on the ceiling. It's the little guy's living room, and he cheerfully serves you tea in a little teeny cup. You discover that he is lonely for someone to listen to his jokes, and since you seem to like to laugh he tells you all 500 of his favourite \"short people\" jokes. You laugh uproariously at every one of them and in gratitude, he teaches you how to teleport yourself. It is a magic spell you can use even if you are not a magic user, but unfortunately you can only teleport yourself 5' at a time, and each time you do it, you have to rest for an hour before you can do it again. Afterwards he shows you a back way out of the cave and you wander back to your flock, trying to think up ways to use your new skill to impress the young people of your village of the opposite sex. You discover that with your new skin and hair colour, females think you are \"cute\" and you can add 3 to your Charisma[ when dealing with females. However, subtract 3 from your Charisma when you are dealing with males]. The End."
},
{ // 17
"\"OK,\" he says. He snaps his fingers, and there is a roast beef sandwich in your hand. \"In return, I'll take the cheese and biscuits that are in your lunch sack.\" He snaps his fingers once again, and your lunch sack suddenly feels lighter. There is another puff of smoke and he is gone. If you want to sit down now and eat your roast beef sandwich, go to {25}. If you want to get the sword from above the sinister altar, go to {13}."
},
{ // 18
"\"Very well,\" he says and snaps his fingers again. \"The bully is now covered with warts. But I forgot to tell you, that whatever you wish for, your worst enemy gets twice as much. So now the village bully is covered in *three* layers of warts!\" He lets out a loud laugh, and disappears in yet another puff of smoke. If you want to sit down in this dangerous cave, and eat your lunch now, go to {25}. If you want to climb up on the sinister altar and get the sword marked E.V.I.L., go to {13}."
},
{ // 19
"As he reaches out for the sword, the blade slips a bit and cuts your finger. You squeal in pain and see blood dropping from your finger onto the ground. Edgar immediately says \"Oh, you've cut yourself. I think there is healing potion in that bottle behind you.\" If you turn around to look for the healing potion, go to {26}. If you ignore his comment and demand that he pay you for getting his sword for him, go to {27}."
},
{ // 20
"You throw the sword to him, and as you let go of it, it suddenly speeds up on its own, and flies like an arrow straight for his heart. As it pierces his breast, both Edgar and the sword disappear in a blinding flash of light. You get 200 adventure points for killing this bully. Now go to {25}."
},
{ // 21
"Edgar gets a cunning look in his eye, and says \"I'll trade you for it. Here, how about this pretty green rock?\" If you give him the sword for the pretty green rock, go to {28}. If you demand more, go to {29}. If you tell him you won't sell it for any price, and turn around and walk away, go to {26}."
},
{ // 22
"After you wait for an hour or so, an old man dressed in robes with arcane symbols all over them, wearing a pointed cap and carrying a staff walks up. The staff is glowing and sparking. \"Who opened the Forbidden Cave?\" demands the man in an angry voice. If you reply \"*I* did, Gramps. What's it to ya?\", go to {30}. If you whip out your little club and attack this guy pretending to be a powerful magician, go to {31}."
},
{ // 23
"You feel a sharp kick to your posterior, and smack your head against the top of the little opening. You turn around, rubbing your head, and the little yellow fellow is standing behind you laughing. As you take a step towards him, he disappears in another puff of smoke. Now if you want to sit down and eat your lunch, go to {25}. If you want to climb up on the sinister altar and get the E.V.I.L. sword, go to {13}."
},
{ // 24
"You hear a loud \"Snap!\" and feel a sharp pain across your fingers. You jerk your hand out of the hole just as three sharp spears slam across the opening of the opening, just missing your hand. You remove the mousetrap from your bruised fingers (you can sell the mousetrap later for one silver piece), and look around for something wet to lessen the pain. You see a nearby potion bottle and open it and pour it over your fingers. They tingle, and you can add 1 to your Dexterity. Now if you want to sit down and eat your lunch, go to {25}. If you want to climb up on the sinister altar and get the E.V.I.L. sword, go to {13}."
},
{ // 25
"Suddenly a door crashes open, and five heavily armed and armoured guards come clashing in. One of them shouts \"Ho, an intruder.\" They quickly surround you, pointing their spears and crossbows at you. If you offer to share your lunch with them, go to {32}. If you pull out your little club and attack them, go to {33}."
},
{ // 26
"You feel a sharp crack on the back of your head, and feel yourself falling down another chute or slide. You slip into unconsciousness, and when you wake up, you are outside near where you left your sheep. (If you had the sword in your hand, it is not here with you.) You are disappointed that you didn't get to kill a dragon, but it's getting late, and you need to take the sheep home. You get 500 adventure points and wander home. Tomorrow is another day."
},
{ // 27
"\"Sure,\" he says, \"I'll reward you. Suppose I give you a gift of good health for the rest of your life? Just close your eyes and turn around. I can't let you see how I perform this magic spell.\" If you agree, and close your eyes and turn around, go to {26}. If you refuse, he laughs and walks out of the cavern. Go to {25}."
},
{ // 28
"The \"pretty green rock\" is an emerald worth 450 gold pieces. Edgar takes a few practice swings with his sword, then looks behind you and shouts \"Look out!\" You turn around to see what it is. Go to {26}."
},
{ // 29
"\"Then die!\" shouts Edgar as he pulls a dagger from his sleeve and throws it at you. You throw your hand up in front of your face to protect yourself and the sword slips out of your hand towards Edgar. The sword magically speeds up, and flies straight and true right at Edgar's heart. As the sword pierces his heart, both he and the sword disappear in a blinding flash of light. You get 200 adventure points for killing this bully. Now go to {25}."
},
{ // 30
"\"Then,\" he smiles, \"you must want to fight the dragon!\" He gestures at you with his staff, and there is a loud noise and a puff of smoke. You find yourself on a mountaintop, in front of the largest creature you have ever imagined in your life. It is enormous, covered in green scales, and appears to be asleep. If you want to shout \"Wake up, dragon!\" go to {34}. If you want to take your wooden club and smack the dragon on his nearest toe, go to {35}."
},
{ // 31
"Your club goes right through him, as if he weren't there. Since you were expecting some resistance, this throws you off balance, and you fall forward, on top of the little 1' tall being who was actually standing before you. He lets out a loud \"Oof!\" and scrambles out from under you, dropping a strange glowing rock in his hurry. He scurries and quickly disappears behind some bushes, while you examine the glowing rock. [Eventually you discover that this magic rock allows you to look like anything you desire for one hour every day. ]You hurry back to your village with this treasure[, thinking up all the various ways you can appear to the villagers of the opposite sex]. The End."
},
{ // 32
"They think this is so hilariously funny that they forget to search your pockets as they smack you around and throw you out of the cave. You limp back to your sheep, slightly bruised and dishevelled, and without your lunch, but with everything you had managed to put in your pocket while you were in the cave. You get 200 adventure points for this. The End."
},
{ // 33
"Just as you charge towards guard #1, guard #3 fires his crossbow at the spot where you were a moment ago. Since you are no longer there to stop the bolt, it goes through the throat of guard #5, who drops his crossbow. It fires when it hits the floor, and hits guard #2 in the leg. This makes guard #2 jerk his spear sideways, just in time to impale guard #4 who was leaping at you. Guard #4 drops his spear, which rolls under the feet of guard #1 as he is trying to fend you off. Both you and guard #1 fall in a heap, while guard #3 picks up the fallen spear and tries to run you through from behind, just as #1 throws you off, and #3 ends up spitting #1 instead. You smack #3 in the back of the head, and discover that you are the only one left standing. You get 500 adventure points for killing the guards. You gather up one crossbow (just an ordinary crossbow) and all the gold you can carry, and leave the cave through a back door in the room where the guards came from. (Figuring correctly that there are more guards on the way.) You are now the richest peasant in your village, but after you pay for the sheep you forgot to bring home (in all the excitement) and paying the \"income tax\" and \"treasure trove tax\" demanded by your village elders, you find that you only have 3000 gold pieces left. The End."
},
{ // 34
"An elf walks up behind you and, yawning, asks for your ticket. You notice that he has a shirt with the letters \"S.P.C.D.\" printed on the front. You ask \"What ticket?\" and he replies that this is the Dragon Preserve, run by the Society to Prevent Cruelty to Dragons, and you were supposed to buy a ticket before coming in to see the dragon. If you tell him that you are here to kill the dragon, go to {36}. If you attack him, go to {37}."
},
{ // 35
"The dragon's toe flicks out by reflex and hits you in the chest. You go flying off the mountaintop, and slide down a couple of hundred feet, and land in a large nest. You get 500 ap for surviving a \"fight\" with a dragon. Now you are in a nest with a 12' tall bird. The bird squawks, stands up, and starts to flap its wings. If you grab one of its legs and hold on, go to {38}. If you leap over the side of the nest without looking, go to {39}."
},
{ // 36
"He gasps in horror, and blows a small whistle. Suddenly there are 500 armed elves surrounding you. They drag you into court with a charge of attempted destruction of an endangered species. You are found guilty, and sentenced to 10 years working in a magic cookie factory hidden inside a giant tree. After 10 years of very boring labour, you are released, and you discover that magic elf time is not the same as human time. You get home the same day that you left, but you get 2000 adventure points for all the time you spent in the elf factory. The End."
},
{ // 37
"You catch him by surprise and knock him on the side of his head. He falls to the ground unconscious. You search his pockets, and find 30 gold pieces. Now if you want to attack the dragon by hitting his toe with your club, go to {35}. If you want to hang around and collect ticket money, go to {40}."
},
{ // 38
"The giant bird flies away, with you hanging onto its leg. After about half an hour, your arms get so tired you can't hang on anymore. You slip and fall off the bird. Fortunately you land in a lake not far from your village. You get 1000 adventure points for this flight, gather up your sheep, and go home."
},
{ // 39
"There is a \"Poof\" and a puff of smoke and you find yourself in front of the cave again, facing the wizard. \"Ha!\" he laughs. \"Not much of a dragon killer.\" He disappears, laughing, in another puff of smoke. You get 500 adventure points for this. The cave still beckons, but it's getting dark and someone has to take the sheep home. Maybe tomorrow. The End."
},
{ // 40
"You collect 150 gold pieces and a magic lantern that is guaranteed to give off light [for 50 hours of continuous use (you can turn it on and off and use it a little at a time) ]from various tourists before you get bored and go home. You get 200 adventure points, but after you go home, you discover when you try to bring your friends back here that you can't find the right mountaintop. The End."
},
};

MODULE SWORD ic_exits[IC_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {   2,   3,  -1,  -1,  -1,  -1,  -1,  -1 }, //   1
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   2
  {   4,   5,  -1,  -1,  -1,  -1,  -1,  -1 }, //   3
  {   6,   7,  -1,  -1,  -1,  -1,  -1,  -1 }, //   4
  {   8,   9,  10,  -1,  -1,  -1,  -1,  -1 }, //   5
  {  11,  12,  13,  -1,  -1,  -1,  -1,  -1 }, //   6
  {   6,  14,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7
  {  10,   9,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8
  {   6,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9
  {   6,   7,  15,  -1,  -1,  -1,  -1,  -1 }, //  10
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11
  {  15,  16,  17,  18,  -1,  -1,  -1,  -1 }, //  12
  {  19,  20,  21,  -1,  -1,  -1,  -1,  -1 }, //  13
  {   6,  22,  -1,  -1,  -1,  -1,  -1,  -1 }, //  14
  {  23,  24,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16
  {  25,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17
  {  25,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18
  {  26,  27,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19
  {  25,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20
  {  28,  29,  26,  -1,  -1,  -1,  -1,  -1 }, //  21
  {  30,  31,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22
  {  25,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23
  {  25,  13,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24
  {  32,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26
  {  26,  25,  -1,  -1,  -1,  -1,  -1,  -1 }, //  27
  {  26,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28
  {  25,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29
  {  34,  35,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33
  {  36,  37,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34
  {  38,  39,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36
  {  35,  40,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40
};

MODULE STRPTR ic_pix[IC_ROOMS] =
{ "", //   0
  "",
  "",
  "ic3", // %%: arguably it could be intended for paragraph #4
  "",
  "", //   5
  "",
  "",
  "",
  "",
  "", //  10
  "",
  "ic12",
  "",
  "",
  "", //  15
  "",
  "",
  "",
  "",
  "", //  20
  "",
  "ic22",
  "",
  "",
  "", //  25
  "",
  "",
  "",
  "ic29",
  "", //  30
  "",
  "",
  "",
  "",
  "", //  35
  "ic36",
  "",
  "",
  "",
  "", //  40
};

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
                              round,
                              spellchosen,
                              spellcost,
                              spelllevel,
                              spellpower;
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

MODULE void ic_enterroom(void);
// MODULE void ic_wandering(FLAG mandatory);

EXPORT void ic_preinit(void)
{   descs[MODULE_IC]   = ic_desc;
 // wanders[MODULE_IC] = ic_wandertext;
}

EXPORT void ic_init(void)
{   int i;

    exits     = &ic_exits[0][0];
    enterroom = ic_enterroom;
    for (i = 0; i < IC_ROOMS; i++)
    {   pix[i] = ic_pix[i];
}   }

MODULE void ic_enterroom(void)
{   switch (room)
    {
    case 1:
        drop_all();
        give(805);
        give(806);
        give(CLU);
    acase 2:
        give_sp(100);
        victory(100);
    acase 4:
        give(807);
    acase 6:
        give_multi(724, 3); // we could use a custom item for these
        give(808);
    acase 9:
    case 10:
        killcount[OGRE]++;
        award(500);
    acase 11:
        dropitem(808);
        // could do the tattoos as an ability[]
        victory(1000);
    acase 16:
        gain_flag_ability(142);
        gain_flag_ability(143);
        victory(100); // %%: it doesn't say how many ap to award
    acase 20:
        killcount[HUMAN]++;
        award(200);
    acase 24:
        give(809);
        gain_dex(1);
    acase 26:
        victory(500);
    acase 28:
        give(810);
    acase 29:
        killcount[HUMAN]++;
        award(200);
    acase 31:
        give(811);
    acase 32:
        dropitem(805);
        victory(200);
    acase 33:
        killcount[HUMAN] += 5;
        award(500);
        give(CRO);
        give_gp(3000);
        victory(0);
    acase 35:
        award(500);
    acase 36:
        victory(2000);
    acase 37:
        give_gp(30);
    acase 38:
        victory(1000);
    acase 39:
        victory(500);
    acase 40:
        give_gp(150);
        give(ITEM_IC_LANTERN);
        victory(200);
}   }
