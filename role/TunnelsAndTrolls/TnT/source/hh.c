#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <ctype.h>

#include "tnt.h"

/* %%: Errata:
 27E should say "go to 26B" instead of "go to 12".
 28B should say "go to 29H" instead of "go to 29A".
%%: Ambiguities:
 33/28H/AD326: it is unclear whether cursed items are covered by this;
  probably they should be, but we currently assume not.
*/

MODULE const STRPTR hh_desc[HH_ROOMS] = {
{ // 0/0/AD300
"INTRODUCTION\n" \
"  From time to time I like to expand upon the mythos of Khazan, city of monsters. This adventure is for all character classes and kindreds regardless of level, and it deals with what may well be the most amazing place in the whole city: Hela's House of Dark Delights.\n" \
"  Hela's House fairly shrieks its magical origin. It is a pyramid on the north side of Great Khazan on the edge of the Noble Quarter built entirely of polished obsidian. Furthermore, it is huge, being ¼ of a mile along each base edge. There are doors along the front edge large enough to admit anything under 100' tall. There is also a great sign made of carved and polished ivory. It reads:\n" \
"  House of Dark Delights. Beware of your wish, it may come true.\n" \
"  A great horde of people enter the House every day and night. Somewhat fewer of them come back out, and they don't always come out in the same condition as they were when they went in. It is well known that the Laws of Khazan do not extend within the pyramid, and that anybody who enters deserves whatever he gets. Legend has it that Hela was a goddess in her own world before coming to Khazan and that she could challenge the power of Lerotra'hh if she wished to make a fight of it. At any rate, her magic is both extremely powerful and extremely subtle - those who experience it sometimes don't know they have been changed for weeks.`\n" \
"INSTRUCTIONS\n" \
"  This is not your ordinary adventure with a plot. It is more like going into an expensive store and buying something. If you wish, it can be repeated again and again. However, remember that you are dealing with a power that can read your true thoughts and desires below the level of surface consciousness. You may not get what you want - you may get what you need, or deserve. To play you will need the 5th edition T&T rules, some scratch paper, and quite a few ordinary dice. It might be helpful to have the Arena of Khazan or the Naked Doom adventure solitaires, but will not be absolutely necessary. Good luck, and be careful! Go to {1}.~"
},
{ // 1/23A/AD293
"Ah! Khazan! Capital of the northern world! And what would a visit to Khazan be without a stop at Hela's House of Dark Delights? There are throngs waiting to get in, but as you enter you find yourself alone in a small room. It is dark inside, but as your eyes quickly adjust to the dim illumination from the few candles present. Underfoot is a thick soft carpet of some black fur that muffles all sound. Coming toward you is a pubescent Elf maiden of great beauty. She wears a scanty skirt and halter of shiny black patent leather along with long white gloves and boots. In her flowing hair is a tiara set with glittering diamonds and rubies. She leads you to a small table of polished ebony and seats you, asking if you would like some coffee or any other drink while looking at the menu.\n" \
"  You place your order and sit down. Looking around, you notice that the room is vaster than you thought, with a table like your own every 10' or so. A minute ago you would have sworn you were alone, but now you can see that you are only one of many. Beatiful Elf maidens flit among the tables like luminous white moths in the darkness bearing decanters of liquid and solid ivory menus. Your girl returns with your drink and menu. She curtsies and hands it to you, promising to return for your selection in a short time.\n" \
"  You examine the ivory tablet. It is carven with strange runes that rearrange themselves in your native language as you watch. (If your character was illiterate, it has just gained the ability to read its native language.) There are six selections; click on one. If you cannot decide, roll one die and try the number indicated. The tablet reads: You have entered the House of Dark Delights, to:\n" \
"    * Reward yourself            Go to {2}\n" \
"    * Punish yourself            Go to {3}\n" \
"    * Challenge yourself         Go to {4}\n" \
"    * Change yourself            Go to {5}\n" \
"    * Obtain something           Go to {6}\n" \
"    * Dispose of an item         Go to {7}"
},
{ // 2/23B/AD294
"The Elfin enchantress smiles. \"It is always a pleasure to grant a reward.\" She turns the menu over and the runes on it rearrange themselves to spell out the following message:\n" \
"  Hela is always happy to grant a reward; however the Laws of Karma require that the patron describe the action that merits the reward. If the action is deemed worthy, you shall have one of the rewards listed below.\n" \
"  Your hostess smiles dazzlingly. \"Now tell me,\" she simpers, \"what praiseworthy action have you performed lately?\" You tell her while she listens in awe. Make your own level saving roll on Intelligence or Luck, whichever is your better attribute. If you miss the saving roll, go to {8} now. If you make it, read on.\n" \
"  \"Truly that merits a great reward,\" she cries happily. \"Choose now from the rewards that Hela offers!\" The menu displays six possibilities. Choose one or roll one die and take a random reward.\n" \
"    * Wealth                     Go to {9}\n" \
"    * Fame                       Go to {10}\n" \
"    * Personal power             Go to {11}\n" \
"    * Good fortune               Go to {12}\n" \
"    * Health                     Go to {13}\n" \
"    * Pleasure                   Go to {14}"
},
{ // 3/24A/AD295
"When you announce this choice, your hostess becomes very serious and sad. \"Alas,\" she cries, \"all patrons have the right to seek punishment.\" She turns over the ivory tablet and you see the Punishment options listed. Choose one of the six and then make your own level saving roll on Luck. If you make the saving roll, go to the paragraph indicated. If you miss it, go to {15}.\n" \
"    * Loss of money              Go to {16}\n" \
"    * Infamy                     Go to {17}\n" \
"    * Loss of personal power     Go to {18}\n" \
"    * Imprisonment               Go to {19}\n" \
"    * Disease                    Go to {20}\n" \
"    * Pain                       Go to {21}"
},
{ // 4/24B/AD296
"Her eyes sparkle with excitement. \"Hela is happy to offer a challenge to all who dare!\" she cries. \"Come with me.\" She takes you by the hand and leads you out of the room of the tables. While you are walking she asks you what kind of challenge you would like. Choose one of the following and go to the paragraph indicated:\n" \
"    * Your fighting skill        Go to {22}\n" \
"    * Your Intelligence          Go to {23}\n" \
"    * Your Luck                  Go to {24}\n" \
"    * Your own limits            Go to {25}"
},
{ // 5/24C/AD297
"The Elf girl bends down and takes your face in her delicate hands and stares deeply into your eyes. (If your character is unnaturally large, she will levitate to face you and look through the windows of your soul.) \"Truly,\" she whispers, \"I do not believe your spirit matches your bodily form. Come with me, please.\" She leads you out of the room of the tables. You soon find yourself in a corridor of coruscating lights. They get ever brighter and more dazzling until you must close your eyes to protect yourself. Even then it seems that the light pours through and floods your brain.\n" \
"  Turn to section 2.41.2 in the T&T rules. For each letter in your character's name, count down one on the Monster Table. If you reach the bottom, return to the top and keep counting. (For example, if your name were Fred, you would count down Dragon, Goblin, Ogre, Orc. Your character would then become an Orc.) Then multiply by the multipliers listed. If you are a type that changes into the same type (a Troll who changes into a Troll, for instance), you will become a super example of that monster type. Go ahead and multiply your attributes by the multipliers anyway. When you are finished, go to {57}."
},
{ // 6/25A/AD298
"\"You can purchase anything for a price,\" says your hostess. \"Turn over the menu and tell me what you wish to obtain.\" Choose one of the categories from the list below and go to the appropriate paragraph.\n" \
"    * Any ordinary commodity     Go to {26}\n" \
"    * A magical weapon           Go to {27}\n" \
"    * Magical armour             Go to {28}\n" \
"    * A magical power            Go to {29}\n" \
"    * A deluxe staff             Go to {30}\n" \
"    * The perfect friend         Go to {31}"
},
{ // 7/25B/AD299
"\"You wish to get rid of something?\" asks your hostess. \"Tell me, is it of a magical nature?\" If the answer is yes, go to {32}. If your reply is negative, go to {33}."
},
{ // 8/25C/AD301
"The Elfin girl leans forward impulsively and kisses you. \"What was that for?\" you ask. She smiles. \"I'm sorry,\" she tells you, \"your deed was not worthy of a greater reward, but thank you for telling me about it. I have given you the gift of self-esteem. You will be very pleased with yourself for the next 24 hours. And now it is time for you to leave Hela's. Please come with me.\" She takes your hand and leads you out. Go to {57}."
},
{ // 9/25D/AD302
"The girl snaps her fingers and dice spill out of the air onto your table. (Roll one die for each level your character has obtained. Example: a second level character rolls two dice.) She looks at the total, multiplies by 100, and tells you that amount of gold pieces have just been deposited to your account at the Temple of the Money Gods. You need only go over and claim them. Then she tells you it is time to leave. Go to {57}."
},
{ // 10/25E/AD303
"As you finish your tale, the Elf girl beckons to the darkness and a strolling minstrel approaches your table. He carries a silver-stringed guitar, and you recognize him as John Taliesin, the greatest balladeer in the world. \"Quiet, everyone!\" he shouts. \"I have a song to sing.\" Many faces turn in your direction. Then John Taliesin composes his latest and greatest ballad, immortalizing your story in perfect iambic pentameter. When he finishes, there is a deafening applause. \"This song shall be sung by minstrels throughout Rhalph for the next hundred years,\" promises the Elf. \"Now it is time for you to leave.\" Go to {57}."
},
{ // 11/26A/AD304
"The Elf girl takes your hand and leads you out of the room. For some time you wind through a maze of obsidian passages with barely enough light to see the pale form of your guide. Finally she brings you to a golden statue of a skeleton. \"Reach out and touch it,\" she tells you. You obey, and a magical charge courses through your body. If you are a first level character, go to {34}. If you are higher than first level, go to {35}."
},
{ // 12/26B/AD305
"The Elf maiden tells you that you must visit Dyse the Goddess of Fortune, and leads you out of the room of the tables. After traversing many dark obsidian tunnels you come out before a statue made of many different metals all joined together. It portrays a radiant woman with two faces, one bright and smiling, the other dull, pitted, and weeping tears of blood. If you came here from paragraph #2, kiss the bright face and go to {36}. If you came here from anywhere else, you are handed a cup of tears to drink. After drinking, go to {37}."
},
{ // 13/26C/AD306
"To your amazement, the Elfchild spits on the table. But instead of saliva, you see a plain copper ring. \"Wear this,\" she tells you, \"and you will be immune to infectious diseases. Furthermore, while wearing it, you will regenerate damage done in combat. (You will recover 1 point of damage every two minutes while wearing the ring, back to your normal CON rating.) But, if you ever lose the ring, or speak of its powers, they will vanish.\" You put on the ring. You now have your health. She takes you out of the House of Dark Delights. Go to {57}."
},
{ // 14/26D/AD307
"\"And what is your pleasure, O my master?\" asks the Elfgirl. The ivory tablet lists three possibilities. Pick one of them.\n" \
"    * Love/sex                   Go to {38}\n" \
"    * Food/drink                 Go to {39}\n" \
"    * Entertainment              Go to {40}"
},
{ // 15/26E/AD308
"The punishment appropriate to a sinner like you has been decided by a higher power. Your hostess gestures and you find yourself helplessly paralyzed. Two very large and ugly trolls then appear and lift you up. For many minutes the Elf maid leads you all through lightless corridors. Go to {12} and start reading from the second sentence."
},
{ // 16/26F/AD309
"\"It has been our pleasure serving you. It is now time to leave the House of Dark Delights. Please come again when you are wealthier,\" says your hostess. (You do not know it yet, but all the wealth you have stored in any institution or in any hiding place is now lost to you. It has been magically transported to Hela's treasury with a 20% tax given to Lerotra'hh. Furthermore, any gold pieces you may be carrying have been changed into an equal number of silver pieces. All jewels have been replaced with glass.[ You will not discover this until you have exited.]) Go to {57}."
},
{ // 17/27A/AD310
"A strolling minstrel with a silver-stringed guitar approaches your table, takes one look at you and composes a limerick of ridicule. \"Who was that?\" you ask. \"That was John Taliesin, the greatest singer in the world,\" the Elf tells you, \"and his limerick will be repeated for 100 years. Now it is time for you to go.\" (You don't know it yet, but your Charisma has just been reduced to 3. [This is a permanent and unalterable change (ie. your Charisma rating can't be changed by magic, not even by dungeon level magic) except for level bonuses to raise your Charisma again.) ]Go to {57}."
},
{ // 18/27B/AD311
"\"As you wish, so be it,\" she says sadly. She walks off and returns quickly with six small cakes. \"Eat at least one of these!\" she orders, and you are compelled to do so. If you're really feeling destructive, eat more than one. For each cake you eat, roll once on the table below. The table determines which attribute is reduced. To reduce an attribute, take your level number, add one to it, then divide that number into the attribute rating being reduced.\n" \
"    1. ST\n" \
"    2. IQ\n" \
"    3. LK\n" \
"    4. DEX\n" \
"    5. CHR\n" \
"    6. SPD\n" \
"After you have reduced one or more attributes, she leads you out of Hela's. Go to {57}."
},
{ // 19/27C/AD312
"She tells you to follow her. As you walk through the obsidian pyramid, it grows even darker until the Elf maiden is only a dimly seen ghost in front of you. Finally you come to a door marked EXIT in runes of fire. She motions you to walk through. (As you pass through the portal, your Constitution rating instantly is halved[ - something you won't notice for quite some time].) If you are a warrior or a rogue who knows no magic, go to paragraph #28 in Naked Doom. If you know any magical spells, go instead to the fifth paragraph of the introduction of Sewers of Oblivion. If you do not have the solitaire adventure called for, you will find this character imprisoned beneath the pyramid until such time as you obtain the necessary dungeon and complete this adventure."
},
{ // 20/27D/AD313
"You must be sick to want to be sick. Your hostess leads you out of the Great Chamber and through many tunnels. At one time you find yourself walking through a pool of stagnant water that comes up to your chin. The roof is so low that there is no room to fly over it. (If you have Sewers of Oblivion, turn to the Disease Chart and roll one die to learn what disease you have contracted. [Your version of the disease is immune to all magical cures. You will recover from it when you have gone up 2 levels in adventure points. ]If you do not have Sewers of Oblivion, you will contract rickets and terminal halitosis. Your legs become very weak, and you have the worst mouth and body odour in the city of Khazan. Reduce your Dexterity and Charisma by half. This disease is incurable. Not even dungeon level magic will affect it.) Go to {57}."
},
{ // 21/27E/AD314
"The Elf girl tells you to follow her and leads you out of the Great Chamber. Your path leads steadily down until at last you enter a fully equipped torture room. \"What will it be?\" she asks. \"The whip, the rack, hot irons, the thumbscrew, amputations, crushing, or something worse?\" If you choose something worse, go to {12}. If you accept one of the ordinary tortures, go to {41}. If you tell her you've changed your mind, go to {42}."
},
{ // 22/27F/AD315
"\"Do you want a physical contest or a magical contest?\" she asks. If you choose physical, go to {43}; if you choose magical, go to {44}."
},
{ // 23/27G/AD316
"Your hostess leads you out of the Great Chamber and into a room filled with books and scrolls. Then she hands you a list of questions to answer, not ordinary questions, but extremely difficult ones such as \"How old is Lerotra'hh?\" She tells you that all of the answers can be found in the books of this room, and that you have one hour to answer all the questions. Then she leaves you alone. Time fairly flies until her return. (Make your own level saving roll on Intelligence. If you make the saving roll, add whatever you made it by to your IQ to get a new IQ rating. This represents excess knowledge you picked up while looking through the books. If you missed the saving roll, subtract the difference you missed by to get a new IQ rating. If your IQ rating falls to 0 or less, you burst your brain and died here.) She says to you, \"I hope you have enjoyed the challenge. Now it is time to leave.\" Go to {57}."
},
{ // 24/27H/AD317
"\"Come, you will enjoy yourself more in the casino,\" the Elf girl tells you. She leads you from the room of the tables to the casino. The two places are totally different. The casino sparkles with light, and people crowd elbow to elbow. There is only one game in Hela's casino. The wheel of fortune! But this wheel is unusual. The bets are all or nothing, and the wheels have no numbers. Instead, when you place your bet, you lay your hand upon a golden bar and an image of your face magically appears on one of the spokes of the wheel. When the wheel is spun, the faces flash off and on. If your face remains on the wheel when it stops, you are a winner. The odds against you are equal to your own character level number, and the chance of winning depends on your Luck. (Make your own level saving roll on Luck. If you make the saving roll, go to {45}; if you miss, go to {46}.)"
},
{ // 25/27I/AD318
"Your hostess leads you out of the Great Chamber, through many black tunnels, and into a small room with a golden throne in it. She tells you to sit down, and as you do, clamps rise out of the chair to secure you at wrists, ankles and throat. She walks over to a nearby wall and throws a lever. Strange energies flood your body. Make your own level saving roll on all attributes but Speed. If you exceed the saving roll required, add the difference to the attribute to raise it to a new level. If you fail the saving roll, subtract the difference from the attribute to a new lower attribute. If any attributes fall to zero or less, except Charisma, you will die. When you have finished making all six saving rolls, and if you still live, you will have a feeling of exhilaration, knowing that you were tested to the utmost. Your hostess will now lead you to the exit. Go to {57}."
},
{ // 26/28A/AD319
"The Elf girl leads you to the way out. \"When you walk out this door,\" she explains, \"you will find yourself in the Great Bazaar of Khazan in front of the very merchant who can sell you what you need or want. Tell him Hela sent you and you will get a special deal. Goodbye now!\" Go to {57}. (Assume you acquired whatever you wanted for a fair price.)"
},
{ // 27/28B/AD320
"\"Magical weapons are not cheap,\" your hostess informs you. \"We have three types: those that cost 10 times the normal price, those that cost 100 times the normal price, and those that cost 1000 times the normal price. Unfortunately, I am forbidden to tell you what their powers are until you indicate how much you are willing to pay. If you cannot or will not pay any of these prices, I am authorized to give you a dirk that glows in the dark.\" Make your choice. If you will pay 10 times their cost, go to {47}; if you will pay 100 times their cost, go to {48}; if you will pay 1000 times their cost, go to {49}. If you take the glowing dirk, you have it, and will be taken to {57}."
},
{ // 28/28C/AD321
"\"We have two kinds of magical armour,\" your hostess states, \"but they are very expensive. One type costs 100 times its normal value, and the other type costs 1000 times its normal value. If you cannot afford either of these types, I can give you a steel cap that takes three hits instead of one. I cannot tell you what the armour does, until you tell me which you intend to buy.\" If you want the armour that costs 100 times normal value, go to {50}; if you want the super expensive kind, go to {51}. If you take the steel cap, you have it, and are led out. Go to {57}."
},
{ // 29/28D/AD322
"\"In order to gain a magical power,\" the Elf girl tells you, \"you must pay us either 5000 gold pieces or all of the wealth which you have, whichever is lower. If you will not pay, you must leave.\" If you agree to pay, go to {52}. If you refuse, go to {57}."
},
{ // 30/28E/AD323
"Your hostess leads you off to see an ancient wizard-smith. On payment of 5000 gold pieces, he gives you a deluxe staff whose name is the same as your own, but which is pronounced backwards: if your name is Tom, you would get a staff named Tom but pronounced Mot. If you cannot afford the staff, the wizard gives it to you anyway, but takes your left eye to keep[ until you return and pay the 5000 gold pieces you owe him]. Go now to {57}."
},
{ // 31/28F/AD324
"\"Oh thank you, master, you have freed me!\" the Elf girl exclaims. \"No longer must I slave for Hela.\" Her image begins to shimmer and when the glow is gone, there is no longer a pubescent Elf beside you, but a fair maiden of your own kindred type. [Her attributes will be exactly double yours, and she will be a wizardess of double your own level. ]She will stay with this character [and help it ]until one of two things happens: your character is slain, or your character deliberately insults the perfect friend. Should either one happen, the girl will gain total freedom and disappear. (She explains all this to you later.) Right now she takes you to the exit. Go to {57}."
},
{ // 32/28G/AD325
"The Elf girl leads you off through the pyramid and brings you to a small chapel. In this chapel are two holy things, an altar of polished onyx and a statue of Hela of whitest marble with changing opal eyes. If the thing you wish to dispose of is a material object, lay it on the altar and go to {53}. If it is a curse or magical power bound to yourself, embrace the statue and go to {54}."
},
{ // 33/28H/AD326
"She listens to your description of the thing you want to dispose of, and then says, \"Come, I know a buyer for such an object.\" She leads you to the exit. (When you go through it you will find yourself in the Great Bazaar of Khazan at the stall of a merchant who will give you 10 times the fair market price of whatever you want to sell - no questions asked.) Go to {57}."
},
{ // 34/28I/AD327
"A surge of power goes through your body and you gain 1000 adventure points. You are now a second level character, so take your level bonus. Then go to {57}."
},
{ // 35/28J/AD328
"You feel a tingle and a new sense of wellbeing. (It will be some time before you know exactly what happened, but right now roll one die:\n" \
"    1. ST\n" \
"    2. IQ\n" \
"    3. LK\n" \
"    4. SPD\n" \
"    5. DEX\n" \
"    6. CHR\n" \
"After determining an attribute, multiply it by your own level number.) \"You have your wish,\" she tells you. Go to {57}."
},
{ // 36/28K/AD329
"The Goddess of Fortune smiles on you. Roll one die and note that number[ by your Luck rating]. That is the number of [Luck ]saving rolls that you will make automatically, regardless of level or die roll. (For example, let us say that you have a Luck of 10 and are told to make a 4th level Luck saving roll. You would need to roll a 25, but when you try you only roll a 5. Nevertheless, you would count it as having made the saving roll exactly, although you would get only 20 adventure points for it.) You must use these automatic saving rolls at the first opportunity, and not just when you would've failed. \"Time to go, Lucky,\" says your hostess. Go to {57}."
},
{ // 37/28L/AD330
"Your body instantly is wracked with a horrible burning pain. This pain will fade gradually to an excruciating ache which always will remain with you. Because of your continual agony, it will be harder for you to make saving rolls in the future. Your new minimum roll is a seven - you must roll at least a seven to make any saving roll. Go to {57}."
},
{ // 38/28M/AD331
"They lead you off to the exit and you are given a free pass for one gala evening at Flaming Cherry's Palace of Pleasure. That place has something for everyone. What your character experiences there is left to your own erotic imagination. Go to {57}."
},
{ // 39/28N/AD332
"Your hostess whips out a golden chip and gives it to you. Runes on it say, \"Admit one to the Banquet of Champions, Summer Solstice.\" This is a famous six-day saturnalia held twice a year in the Palace of the Death Goddess, and it is the greatest feast and orgy in the known world. Some folks would kill to get a ticket to it, but you have one now. She then leads you off to the exit. Go to {57}."
},
{ // 40/29A/AD333
"Your hostess asks you if you like arts, music or sports. If you answer art, she gives you a season ticket to the Queen's Folly playhouse. If you say music, she calls over the house bard, John Taliesin with his silver-stringed guitar, to serenade you for an hour. Taliesin is renowned as the greatest bard and poet on all of Rhalph. If you say sports, she hands you a silver chip that is a lifetime pass to the Arena of Khazan. Once your entertainment is over, she leads you to the exit. Go to {57}."
},
{ // 41/29B/AD334
"Several hours of torture ensue. When she is finished, the Elf maid babies your CON back up to normal. Make your own level saving roll on Intelligence to see if the torture affected you mentally. If you miss the roll, cut your IQ rating in half - you are now semi-insane. As a side benefit, take 500 adventure points, and you will always experience pain of any sort as intense pleasure. Go to {57}."
},
{ // 42/29C/AD335
"\"As you wish,\" says your hostess leading you away and to the exit. \"But think of all the fun we will miss.\" Unbeknown to you, you have been penalized 1000 adventure points for cowardice. Your IQ rating also went up 1 point. Go to {57}."
},
{ // 43/29D/AD336
"Time shifts strangely around you and you find yourself on the sands of the Arena of Khazan. If you are a first, second, or third level character, go to paragraph {55} in Arena of Khazan[ but double the Monster Rating for the beast]. If you are a fourth, fifth or sixth level character, go to paragraph {61} in Arena. If you are seventh level or higher, go to paragraph {67} in Arena[ and multiply the Monster Rating by your own level number].[\n" \
"  If you win the fight in the arena, you may collect your prize and then time will shift around you again, and you will be back in the tunnels of Hela's House. Your Elfin hostess will praise your combat skill and lead you to the exit. Go to {57}.]"
},
{ // 44/29E/AD337
"You are led deep into the pyramid. Waiting for you is a demon-wizard of horrific visage. He looks incredibly powerful, but in fact his powers are exactly the same as yours. Choose a spell and throw it. When you have written down your spell, go to {55}."
},
{ // 45/29F/AD338
"The wheel of fortune is spinning. Your face blinks in and out of existence on it. Finally the wheel stops and you see that you have won. You had bet all the money that was on your person, and now you collect your level number times that sum. Your winnings will be waiting for you in the Temple of the Money Gods. Now it is time to leave. Go to {57}."
},
{ // 46/29G/AD339
"For you it is a wheel of misfortune. As it spins, your face blinks out of existence and stays out. You have lost all the money you brought with you. Your hostess advises you to leave now, but tells you that you can have one more chance to bet your Luck itself against 1000 gold pieces. If you wish to leave, go to {57}. If you take the second gamble, go to {56}."
},
{ // 47/29H/AD340
"Through the pyramid she leads you to an armoury. Every weapon listed in the rulebook is there. For 10 times the normal price you can buy a weapon[ that always will do triple its normal damage in dice and adds. (For example, a sax that gets two dice and 5 adds would get six dice plus 15 adds.) Buy one that you have Strength and Dexterity enough to use]. Then go to {57}."
},
{ // 48/29I/AD341
"She leads you off to an armoury the walls of which are made of silver. [The weapons within it glitter and gleam with their own fire. Those weapons that have edges are forged of mithril and are fantastically keen. ]The armoury contains all the [edged ]weapons in the T&T rules. [They get five times their normal dice and adds, and require neither Strength nor Dexterity to use them, seeming almost to fight for themselves. (A sax would get 10 dice plus 25 adds, for example.) Since they have no DEX requirement, they may be used as a second weapon in combat. Buy one. ]Then go to {57}."
},
{ // 49/30A/AD342
"[She leads you deep into the pyramid, to the forge of a wizard-smith. He has only one weapon available and the cost is 1000 times the price in the rules. To see what it is, first roll one die: (1) swords; (2) a class I hafted weapon; (3) a class II hafted weapon; (4) a class III hafted weapon; (5) a spear; (6) a dagger. This magic weapon has the power to bounce any magic spell cast at you back at the sender, and it gets the same number of dice as you have personal adds when you are fighting with it. To decide which weapon within a class is available, roll two dice and count down from the top. Doubles add and roll over - if you reach the bottom of the list, return to the top and keep counting. If you have the Strength and Dexterity necessary to use the one weapon available, buy it and go to {57}. If you don't have the necessary attributes, ]your guide will take you to buy something more suited to you. Go to {48} where the weapons only cost 100 times their normal value."
},
{ // 50/30B/AD343
"She leads you off to an armoury the walls of which are made of gold pieces melted together. Armour here is kept in complete suits of enchanted steel. Each suit of armour will take 100 hits of damage and weighs only half the normal weight. Buy a suit for 30,000 gold pieces and then go to {57}."
},
{ // 51/30C/AD344
"She takes you deep into the pyramid to meet an ancient wizard-smith. This man has crafted a suit of fantasy armour consisting of a demonfaced helm and a shimmering curtain of light. The wearer of this armour is immune to any spell of a level lower than or equal to his own. The wearer can also dodge physical hits by making a first level DEX saving roll. (However, if the wearer misses the saving roll he must take all the generated hits aimed at him - the armour is no protection in that case.) The cost of this remarkable armour is a mere 500,000 gold pieces. If you cannot afford that, your guide will lead you to a place where armour is slightly cheaper. Go to {50}. Otherwise, buy the demon-helm and go to {57}."
},
{ // 52/30D/AD345
"She takes you deep into the pyramid to meet Hela herself. The lady in question is tall and thin and incredibly beautiful. She dresses all in green and black and most of her body is masked in a great ebony dragon-helm. She examines you and says, \"I know what you need.\" Roll two dice and check the table below to see what power you get.\n" \
"   2.[ Once in any 24-hour period you may teleport up to 100 miles at no cost in Strength.]\n" \
"   3.[ Magic thrown at you by anyone but yourself dissipates harmlessly if you roll a five or better on two dice.]\n" \
"   4.[ You may change into the beast or monster of your choice at no cost with a Monster Rating equal to the sum of double your attributes and change back at will.]\n" \
"   5.[ You change any living thing you touch with the bare skin of your left hand into a frog with a Monster Rating of 2. You cannot change yourself this way.]\n" \
"   6.[ Your touch negates any magical curse or spell on a being if the curse is of a lower level than you are.]\n" \
"   7.[ You have the power to walk on any solid surface, including sheer walls and ceilings.]\n" \
"   8. You have the power to fly at will.\n" \
"   9. You have the power of Wizard Speech.\n" \
"  10.[ You regenerate combat and poison and disease hits equal to your total CON rating each combat turn. To be slain you must take double your CON in damage on a single combat turn.]\n" \
"  11.[ You have the power of incorporeality at will. By magically shifting your body out of phase with the rest of the universe, you cannot be hurt by any physical means. You still can cast magic and still are vulnerable to it.]\n" \
"  12. Dragonspeech[ and the Word of Command]. You have the power to speak to dragons[ and command them to help you, which they will do]. You do not have the power to summon dragons[ when there are none about].\n" \
"After your new magical power is determined, go to {57}."
},
{ // 53/30E/AD346
"The object shimmers and disappears. Hela has negated the curse on you and has added the magical item to her own stockpile of such things. The Elf maid will now lead you to the exit. Go to {57}."
},
{ // 54/30F/AD347
"The statue shudders and shrieks once. The curse is gone from you. The Elf maid now takes you away. Go to {57}."
},
{ // 55/30G/AD348
"Look up your spell in the rulebook. [Your foe throws the spell right below yours in the rulebook. (Example: if you threw a Take That You Fiend spell, your foe would throw a Vorpal Blade on its knife and attack you with it in the same combat turn. It would get its hits and you would not be able to defend against the physical attack.) ]Your foe has exactly the same attributes as you do, except for its CON rating which will equal double your IQ rating. If you slay it with one spell, you get 1000 adventure points. If it kills you, oh well...If you both live at the end of the spell-casting, take adventure points times 10 for the Strength used in spell-casting. Your hostess will now lead you out of the House. Go to {57}."
},
{ // 56/30H/AD350
"Once again your face appears on the Wheel of Fortune. This is a straight tenth level saving roll on Luck (65 - LK). If you make the saving roll, you are given 1000 gold pieces and led to the exit ({57}). If you miss the saving roll, you lose the bet and pass out. Servants carry you off to the Room of Doom. Go to {12} and start reading from the second sentence."
},
{ // 57/Exit/AD349
"Your time in Hela's House of Dark Delights is now finished. Before you is an obsidian door with the rune for Exit etched on its surface in living flame. You are told that you cannot re-enter the House until you have participated in an adventure somewhere [beyond the city of Khazan ]- the Entrance door simply will not open for you. The Elf maid holds the door open and you pass through, back into the mean streets of the city of monsters.\n" \
"  When the door closes there is no sign of the obsidian pyramid. Your experience seems like a dream to you unless you have some physical token to prove its reality. You are totally unaware that half of your life-force has been drained from you at the end. (Reduce CON by half. In case of fractions, round down. A character with a CON of 1 would die at this point.) You have paid Hela's price - hopefully you got your wish for it."
}
};

MODULE SWORD hh_exits[HH_ROOMS][EXITS] =
{ {   1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   0
  {   2,   3,   4,   5,   6,   7,  -1,  -1 }, //   1/23A
  {   9,  10,  11,  12,  13,  14,  -1,  -1 }, //   2/23B
  {  16,  17,  18,  19,  20,  21,  -1,  -1 }, //   3/24A
  {  22,  23,  24,  25,  -1,  -1,  -1,  -1 }, //   4/24B
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   5/24C
  {  26,  27,  28,  29,  30,  31,  -1,  -1 }, //   6/25A
  {  32,  33,  -1,  -1,  -1,  -1,  -1,  -1 }, //   7/25B
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   8/25C
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //   9/25D
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  10/25E
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  11/26A
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  12/26B
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  13/26C
  {  38,  39,  40,  -1,  -1,  -1,  -1,  -1 }, //  14/26D
  {  12,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  15/26E
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  16/26F
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  17/27A
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  18/27B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  19/27C
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  20/27D
  {  12,  41,  42,  -1,  -1,  -1,  -1,  -1 }, //  21/27E
  {  43,  44,  -1,  -1,  -1,  -1,  -1,  -1 }, //  22/27F
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  23/27G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  24/27H
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  25/27I
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  26/28A
  {  47,  48,  49,  -1,  -1,  -1,  -1,  -1 }, //  27/28B
  {  50,  51,  -1,  -1,  -1,  -1,  -1,  -1 }, //  28/28C
  {  52,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, //  29/28D
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  30/28E
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  31/28F
  {  53,  54,  -1,  -1,  -1,  -1,  -1,  -1 }, //  32/28G
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  33/28H
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  34/28I
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  35/28J
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  36/28K
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  37/28L
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  38/28M
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  39/28N
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  40/29A
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  41/29B
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  42/29C
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  43/29D
  {  55,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  44/29E
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  45/29F
  {  56,  57,  -1,  -1,  -1,  -1,  -1,  -1 }, //  46/29G
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  47/29H
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  48/29I
  {  48,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  49/30A
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  50/30B
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  51/30C
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  52/30D
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  53/30E
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  54/30F
  {  57,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  55/30G
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }, //  56/30H
  {  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1 }  //  57/Exit
};

MODULE STRPTR hh_pix[HH_ROOMS] =
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
  "hh-p26", //  10
  "hh-p29",
  "",
  "",
  "",
  "", //  15
  "",
  "hh-p26",
  "",
  "",
  "", //  20
  "",
  "",
  "hh-p24",
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
  ""  //  57
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

MODULE void hh_enterroom(void);
// MODULE void hh_wandering(FLAG mandatory);

EXPORT void hh_preinit(void)
{   descs[MODULE_HH]   = hh_desc;
 // wanders[MODULE_HH] = hh_wandertext;
}

EXPORT void hh_init(void)
{   int i;

    exits     = &hh_exits[0][0];
    enterroom = hh_enterroom;
    for (i = 0; i < HH_ROOMS; i++)
    {   pix[i] = hh_pix[i];
}   }

MODULE void hh_enterroom(void)
{   int  cakes,
         i,
         result;
    FLAG ok;
    TEXT letter;

    switch (room)
    {
    case 2:
        if (!saved(level, ((iq > lk) ? iq : lk)))
        {   room = 8;
        }
    acase 5:
        if (strlen(name) == 0)
        {   race = 0;
        } else
        {   race = (strlen(name) - 1) % 37;
        }
        race = races_table[race];
        st  = max_st;
        con = max_con;
        changerace();
        max_st  = st;
        max_con = con;
        aprintf("You are now a %s.\n", races[race].singular);
    acase 9:
        bankcp += dice(level) * 10000;
    acase 11:
        room = (level == 1) ? 34 : 35;
    acase 12:
        room = (prevroom == 2) ? 36 : 37;
    acase 13:
        give(818);
    acase 16:
        bankcp = 0;
        result = gp;
        pay_gp(gp);
        give_sp(result);
        result = 0;
        for (i = 0; i < ITEMS; i++)
        {   if (i != 828 && items[i].owned && items[i].type == JEWEL)
            {    result += items[i].owned;
                 items[i].owned = 0;
        }   }
        give_multi(828, result);
    acase 17:
        change_chr(3);
    acase 18:
        cakes = 6;
        do
        {   cakes--;
            result = dice(1);
            switch (result)
            {
            case 1:
                permchange_st(max_st / (level + 1));
            acase 2:
                change_iq(    iq  / (level + 1));
            acase 3:
                change_lk(    lk  / (level + 1));
            acase 4:
                change_dex(   dex / (level + 1));
            acase 5:
                change_chr(   chr / (level + 1));
            acase 6:
                change_spd(   spd / (level + 1));
        }   }
        while (cakes >= 1 && getyn("Eat another"));
    acase 19:
        permchange_con(max_con / 2);
        ok = FALSE;
        for (i = 0; i < SPELLS; i++)
        {   if (spell[i].known)
            {   ok = TRUE;
                break; // for speed
        }   }
        if (ok)
        {   module = MODULE_SO;
            room = 0;
        } else
        {   module = MODULE_ND;
            room = 28;
        }
    acase 20:
        DISCARD so_diseasechart(TRUE);
    acase 23:
        if (saved(level, iq))
        {   gain_iq(madeitby(level, iq));
        } else
        {   lose_iq(misseditby(level, iq));
        }
    acase 24:
        savedrooms(level, lk, 45, 46);
    acase 25:
        if (saved(level, st))
        {   gain_st(madeitby(level, st));
        } else
        {   permlose_st(misseditby(level, st));
        }
        if (saved(level, iq))
        {   gain_iq(madeitby(level, iq));
        } else
        {   lose_iq(misseditby(level, iq));
        }
        if (saved(level, lk))
        {   gain_lk(madeitby(level, lk));
        } else
        {   lose_lk(misseditby(level, lk));
        }
        if (saved(level, con))
        {   gain_con(madeitby(level, con));
        } else
        {   permlose_con(misseditby(level, con));
        }
        if (saved(level, dex))
        {   gain_dex(madeitby(level, dex));
        } else
        {   lose_dex(misseditby(level, dex));
        }
        if (saved(level, chr))
        {   gain_chr(madeitby(level, chr));
        } else
        {   lose_chr(misseditby(level, chr));
        }
    acase 27:
        if (getyn("Accept glowing dirk"))
        {   give(ITEM_HH_DIRK);
            room = 57;
        }
    acase 28:
        if (getyn("Accept steel cap"))
        {   give(820);
            room = 57;
        }
    acase 30:
        give(DEL);
        if (!pay_gp(5000))
        {   gain_flag_ability(39);
        }
    acase 31:
        give(821);
    acase 33:
        shop_sell(1000, 1000);
    acase 34:
        award(1000);
        advance(FALSE);
    acase 35:
        switch (dice(1))
        {
        case 1:
            permchange_st(max_st * level);
        acase 2:
            change_iq(    iq     * level);
        acase 3:
            change_lk(    lk     * level);
        acase 4:
            change_spd(   spd    * level);
        acase 5:
            change_dex(   dex    * level);
        acase 6:
            change_chr(   chr    * level);
        }
    acase 36:
        gain_numeric_abilities(126, dice(1));
    acase 37:
        gain_flag_ability(127);
    acase 38:
        give(822);
    acase 39:
        give(823);
    acase 40:
        letter = getletter("ªAªrts/ªMªusic/ªSªports", "AMS", "Arts", "Music", "Sports", "", "", "", "", "", FALSE);
        if   (letter == 'A') give(824);
        elif (letter == 'S') give(825);
    acase 41:
        healall_con();
        if (!saved(level, iq))
        {   lose_iq(iq / 2);
            award(500);
            gain_flag_ability(128);
        }
    acase 42:
        award(-1000);
        gain_iq(1);
    acase 43:
        module = MODULE_AK;
        if (level <= 3)
        {   room = 55;
        } elif (level <= 6)
        {   room = 61;
        } else
        {   room = 67;
        }
    acase 44:
        DISCARD castspell(-1, FALSE);
    acase 45:
        bankcp +=  (level * cp)
               +  ((level * sp) *  10)
               +  ((level * gp) * 100);
    acase 46:
        pay_gp_only(gp);
        pay_sp_only(sp);
        pay_cp_only(cp);
    acase 47:
        shop_buy(1000, 'W');
    acase 48:
        shop_buy(10000, 'W');
    acase 50:
        if (getyn("Buy armour") && pay_gp(30000))
        {   give(826);
        }
    acase 51:
        if (getyn("Buy armour") && pay_gp(500000))
        {   give(827);
            room = 57;
        } else
        {   room = 50;
        }
    acase 52:
        if (cp + (sp * 10) + (gp * 100) < 5000)
        {   pay_cp(cp + (sp * 10) + (gp * 100));
        } else
        {   pay_gp(5000);
        }
        switch (dice(2))
        {
        case 2:
            gain_flag_ability(129);
        acase 3:
            gain_flag_ability(130);
        acase 4:
            gain_flag_ability(131);
        acase 5:
            gain_flag_ability(132);
        acase 6:
            gain_flag_ability(133);
        acase 7:
            gain_flag_ability(134);
        acase 8:
            gain_flag_ability(135);
        acase 9:
            set_language(LANG_WIZARD, 2);
        acase 10:
            gain_flag_ability(136);
        acase 11:
            gain_flag_ability(137);
        acase 12:
            set_language(LANG_DRAGON, 2);
            gain_flag_ability(138);
        }
    acase 53:
        drop_or_get(FALSE, TRUE);
    acase 54:
        for (i = 0; i < ABILITIES; i++)
        {   aprintf("%d: %s\n", i + 1, ability[i].text);
        }
        result = getnumber("Lose which ability (0 for none)", 0, ABILITIES) - 1;
        if (result != -1)
        {   if (ability[result].known)
            {   lose_flag_ability(result);
        }   }
        // %%: strictly speaking probably only curses should be fixable by this means
        // (eg. regenerating lost limbs, etc. should not be possible)
    acase 55:
        create_monster(485);
        npc[0].max_st  = max_st;
        npc[0].st      = st;
        npc[0].iq      = iq;
        npc[0].lk      = lk;
        npc[0].dex     = dex;
        npc[0].max_con =
        npc[0].con     = iq * 2;
        npc[0].chr     = chr;
        npc[0].spd     = spd;
        npc[0].height  = height;
        npc[0].level   = level;
        recalc_ap(0);

        result = spellcost;
        payload(TRUE);
        if (countfoes())
        {   award(10 * result);
        } else
        {   award(1000);
        }
    acase 56:
        if (saved(10, lk))
        {   give_gp(1000);
            room = 57;
        } else
        {   room = 12;
        }
    acase 57:
        if (con % 2)
        {   permlose_con((con / 2) + 1);
        } else
        {   permlose_con( con / 2     );
        }
        victory(100); // %%: we just give them the standard ap bonus
}   }
